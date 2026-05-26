# Single-Slit Diffraction Pattern Analysis using MATLAB

This repository contains a MATLAB script used to analyze a photograph of a single-slit diffraction pattern, extract the light intensity profile (specifically for a red laser), and visually compare it with the theoretical intensity graph.

## 📌 Project Description

This program performs image processing on the photographic results of a single-slit diffraction experiment to experimentally measure the light intensity distribution. The main workflow of the program includes:

1. **Reading the Image:** Loading the diffraction pattern photo file (`.jpg`).
2. **Color Channel Extraction:** Extracting the red channel since the experiment typically uses a red laser (e.g., He-Ne or red diode laser).
3. **Region of Interest (ROI):** Cropping a specific area of the image where the diffraction pattern is most clearly visible.
4. **Data Normalization:** Scaling the pixel intensity data to a range of 0 to 1 so it can be compared with the theoretical curve.
5. **Theoretical Modeling:** Calculating the single-slit diffraction intensity curve based on the theoretical formula:

$$I(\beta) = \left(\frac{\sin\beta}{\beta}\right)^2$$


6. **Fitting & Visualization:** Aligning the experimental coordinate axis scale to match the theoretical $\beta$ axis, then plotting both on a single graph for conformity analysis.

---

## 🛠️ Prerequisites & Required Files

To run this script, ensure you have:

* **MATLAB** (R2016b or a newer version is recommended).
* **Image Processing Toolbox** (Optional, for the basic `imread` function).
* **Input Image File:** A file named `OPTK_PJ2_SET_006_MXA237.jpg` must be placed in the same folder as this MATLAB script.

---

## 🚀 How to Use

1. Download or copy the MATLAB script (`.m`) into your working directory.
2. Ensure the image file `OPTK_PJ2_SET_006_MXA237.jpg` is in the same directory.
3. Open MATLAB and point your *Current Folder* to that directory.
4. Run the script (press `F5` or the **Run** button).
5. A comparison graph between the Experimental data (Image) and Theory will appear in the Figure window.

---

## 📋 Code Structure Explanation

Here is a breakdown of the functionality for each code block:

* **Initialization & Image Reading:**
```matlab
clc; clear; close all;
I = imread("OPTK_PJ2_SET_006_MXA237.jpg");
R = I(:,:,1); % Extracting the red color component

```


* **Image Cropping (ROI):**
Extracting a 200 by 1000 pixel matrix starting from the 171st row and 684th column to focus the analysis on the center of the diffraction pattern.
```matlab
for i=1:1:200
    for j=1:1:1000
        r(i,j) = R(i+170, j+683); 
    end
end

```


* **Vertical Averaging & Initial Normalization:**
Averaging the intensity vertically to reduce noise, then dividing it by its maximum value so the central peak equals 1.
```matlab
Sr=sum(r)/200;
Sn=Sr/max(Sr);

```


* **Theoretical Curve Generation:**
Creating a $\beta$ vector from $-2\pi$ to $2\pi$ with 736 data points using the single-slit intensity formula.
```matlab
beta=linspace(-2*pi,2*pi,736);
I_teori=(sin(beta)./beta).^2;

```


* **Data Alignment:**
Extracting a 736-pixel window from the experimental data (`Sn`) with an offset of 132 pixels so the center of the experimental pattern aligns with the center of the theoretical pattern. Then, applying a coordinate transformation for the X-axis (`y`) from pixels to radians ($\beta$ scale).
```matlab
for n=1:1:736
    Sn2(n)=Sn(n+132);
end
Sn2=(Sn2-min(Sn2))/(max(Sn2)-min(Sn2)); % Min-Max Normalization

for m=1:1:736
    y(m)=(m-361)/(371/(2*pi));
end

```


* **Final Visualization:**
Displaying an overlay graph between the Theory (first default color line) and the Experiment (`Sn2` against the `y` coordinates).
```matlab
plot(beta, I_teori, y, Sn2)

```



---

## ⚠️ Important Notes & Future Development

1. **Truncated Code:** At the very end of your code, there is a hanging/truncated loop:
```matlab
% Range
% k=1:0.1:736;
% for z=1:1:length(k)
%     

```


If this part was intended for interpolation or calculating a more precise slit width, you can complete it or delete it if it remains unused.
2. **Mean Squared Error (MSE):** There is an MSE calculation block that is commented out (`%`). You can uncomment it to measure the mean squared error between the experimental and theoretical curves as an indicator of fitting accuracy:
```matlab
Se=0;
for n=1:1:736
    Se=Se+(I_teori(n)-Sn2(n))^2;
end
MSE=Se/736;
disp(['MSE Value: ', num2str(MSE)]);

```


3. **Extracting the Slit Width ($a$):** To obtain the physical value of the slit width ($a$), you need to link the $\beta$ variable with the physical parameters of the experiment using the formula:

$$\beta = \frac{\pi a \sin\theta}{\lambda} \approx \frac{\pi a x}{\lambda L}$$



Where:
* $\lambda$ = Laser wavelength (meters)
* $L$ = Distance from the slit to the screen (meters)
* $x$ = Distance from the central maximum on the screen (meters), which can be calibrated from the pixel scale of the `y` axis.



---

*Created for Optic Physics / Photonics project documentation purposes.*

---

**A quick reminder on your final goal:** Your current code successfully overlaps the theoretical and experimental intensity graphs. However, it doesn't calculate the actual "slit width" just yet. You will need to implement the calibration math mentioned in Point 3 of the README to convert your pixel distances into physical measurements and isolate the variable $a$.
