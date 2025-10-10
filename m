Return-Path: <linux-pci+bounces-37824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 672E2BCE38A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 20:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 513C84F24DC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44242FC020;
	Fri, 10 Oct 2025 18:26:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8A2FCBFC;
	Fri, 10 Oct 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120767; cv=none; b=ZxIRkuQjZRTM0u9UjXMBU71oZr6pIMNw29RosDCv33WU0MMohq2jdHfXCmZEsBKH70FTEhNYjnXAsQN5WsGDvzMSRGzinbUOAu/8+nvzkQJxvkfGY5NIJc48woFlcjr4V8HZPi9GZ0hVx9xYgzu3b/lOabUGdQURMCwuvMlh94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120767; c=relaxed/simple;
	bh=TGBu5VD9Csx9auQIJRtZcEAMf9PQUb4RlRSBX/JW7Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNHYkTwizn3JIGE8pft6h4QxL+z54B0RqiJfuaOWV++L+zRLfkg7hs6g9jGa/FnmRCyFIMSa+m8dfuJEO1fj1/c2OAvPQC9ztOV/frHg5cyxEcNhcs5k6DkScZ7hV9RUI8NJaMCGL3poWSmDffV1ShAEFDjqCFb0C9IcRLIB5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A715CC113D0;
	Fri, 10 Oct 2025 18:26:06 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 11:25:47 -0700
Subject: [PATCH 1/3] dt-bindings: PCI: Update the email address for
 Manivannan Sadhasivam
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-pci-binding-v1-1-947c004b5699@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11583;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=TGBu5VD9Csx9auQIJRtZcEAMf9PQUb4RlRSBX/JW7Fs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo6U+95cPnia/TtHbTXZqLu/z4crjkktocHrE3u
 HCxv4o/2dWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaOlPvQAKCRBVnxHm/pHO
 9cg4B/0baky/LH238kGsOfDu1EIHw3HtZr5nnWKhyy+LNUApTpGlQLeUHVwdPUAIyj5MOIPB/4U
 mTx4RrzD57u5wVjBnWFcq94skFiYbSxJtw6NpxWpVsqBNxU95L5hbe19HNaM+2yRqf4+nSDfiFc
 TwsGzRbXDRBa6GLIVjnbHJudEHyFCDL4UTt78h9oqRpNRRzLcl3daGe4Sbz96cw/4/TqZb2LMAe
 U6cV3N3G/bEfta2Fik44uIFoG7AF5Q/3dvugBaYF9I0O23GmWtEZHHj+IByr+Q6YQeBYuOhbgBO
 ccOtuNDfaRUC6FfLUvts6geL/34WmGWIDze5if/SPX5NPruY
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

My linaro email id is no longer active. So switch to kernel.org one.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/pci-ep.yaml             | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml       | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml  | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml  | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml          | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index 1868a10d5b10dbffcbf14b5737e51353f55b98d8..baeb583e0bcd708f219071c5b66a7e2e967299ac 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -11,7 +11,7 @@ description: |
 
 maintainers:
   - Kishon Vijay Abraham I <kishon@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index ab2509ec1c4b40ac91a93033d1bab1b12c39362f..77f8faf54737e0fab089a368976290dece4f2e7d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -8,7 +8,7 @@ title: Qualcomm PCI Express Root Complex Common Properties
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 properties:
   reg:
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index ac3414203d383bbd1a520dc11f317a5da9ca33e4..bed9a40b186bcf2cf93bdf354bddaa257d229f16 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm PCIe Endpoint Controller
 
 maintainers:
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
index bdddd4f499d18689db264adf71b41bb43d35cb36..1f2d098b86384014dbd61c6d0e2bd4a596f3c780 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SA8255p based firmware managed and ECAM compliant PCIe Root Comp
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SA8255p SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index 19afe2a03409b8f638e0f4a3deda304e397ab9f7..dca84580f0da00ed36e34d83bbf8aedf0c180f8b 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SA8775p PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SA8775p SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 4d0a915566030f8fbd8bf83a9ccca00fbc7574bd..4238612dd2ce6411f0ec3796682868a556724bd7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SC7280 PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SC7280 SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
index 34a4d7b2c8459aeb615736f54c1971014adb205f..6a7c410c9fc30f0644da19a9002e0d26813731b8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SC8180x PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SC8180x SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
index 15ba2385eb73c4e69d6de7dc09cf639bc800f7f2..a18cba10aceaec42e0b105f76c92a82a926d727a 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SC8280XP PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SC8280XP SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 26b247a41785fa3e001f7ced165747ac256f0c02..b772e7e6a9e3dda04b990e004db446159a766410 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SM8150 PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SM8150 SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
index af4dae68d50873bf0e64d47571760b62263594cf..ecc4b971ea490b89894dfd7d334f718dec57576d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SM8250 PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SM8250 SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index dde3079adbb3312f46d9c0e9cee5abbd67bcab1b..6c109b30ccc61e47568fdabfff9a4e8a67946f33 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SM8350 PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SM8350 SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index 6e0a6d8f0ed070a98560d3e343f14e39b3cf9cd5..2725f849121b56953ccdac26ff8134dbae1a39bc 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SM8450 PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SM8450 SoC PCIe root complex controller is based on the Synopsys
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 38b561e23c1fda677ce2d4257e1084a384648835..f6f7e5330d59c1a20281cc8a86991c8720ceefa2 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SM8550 PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm SM8550 SoC (and compatible) PCIe root complex controller is based on
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 61581ffbfb2481959344490e54daea001aaa4ca3..2ebf48542911fda6fef91ea43e7b658b6cdc01e1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -8,7 +8,7 @@ title: Qualcomm X1E80100 PCI Express Root Complex
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description:
   Qualcomm X1E80100 SoC (and compatible) PCIe root complex controller is based on
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0e1808105a8196b450bacd6fd3d986c67e5e0082..c61930441be09d02c1b83782835061b92331560b 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -8,7 +8,7 @@ title: Qualcomm PCI express root complex
 
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
 
 description: |
   Qualcomm PCIe root complex controller is based on the Synopsys DesignWare

-- 
2.48.1


