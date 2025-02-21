Return-Path: <linux-pci+bounces-21992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DCA3F9B8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FFD189AC87
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788EE206F24;
	Fri, 21 Feb 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZGDEv6P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594361DED6F
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153133; cv=none; b=UGjEdPRBwS/cl9dTj+sQFQD5/ItBoGUg6K9xDI5jacDrDidxTwgrfd5YOZ/Phd6oGv4Z9ydCt0V72AsCNfhNybxL16UAfU3IOzCL7SmyVxj1ut0w80mXG77urpRBUWivR8irjzI1q6hMJnz5SYo10CLlYzoCpWCDjsHLoqxsKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153133; c=relaxed/simple;
	bh=2EB6HQ3Xg729UaJzi6eQwoGHABfEKMGzkAxaHZxQ0PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADvRhiPbthW54Hw+8YwaLtGh2xWbbgzkpJQKcVijpEwwgIxmEEzQ0Fp1BsiKngdPFPdmthW0NX8dMPJBJvw5tTp58C9nPxZ639NefvLKCnzl4tWIUjRXyzdmJQhDrmae56SV2Vzaxr7+Eq2NlPU3COBUDUh7w3JiMCa6jAMUa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZGDEv6P; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-546267ed92fso2617331e87.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153129; x=1740757929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywz5+X0tFc1uge/ko+PjpyJKNH56apxqeqThZAdXh4A=;
        b=fZGDEv6PET70MlRf1Dlo7UNOB0iYIGoKuIi/1cE4egLE7SSvAQBz9NDwypBOVkhzcx
         pM9eqW69Pa3ZanfaHvJZOCtQFraC65du/9C6xwELxhjoCwVPKswxD+fOG0fDmydHIIXi
         7wjaSGb+lIFKH1Tq939UFZDMzlseXrQZckYCl87kpflPcvyr1zl+3T6ATnlimVk4KLZe
         SU3Ua+EjAkBYrspA1vnAYe761ISsErZepKBpAZl0RIqJjmd00NPLtE/kkehBnnkr5ypt
         7pO/JsoTvkwlNUGkDj442cta51oQJeYTLwYTbQ7SBbWpRUavuuL8qjo3z0TwhooNrEUC
         IsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153129; x=1740757929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywz5+X0tFc1uge/ko+PjpyJKNH56apxqeqThZAdXh4A=;
        b=b2h9NRmvMHYGvO6ELRYAkG9Z9dDKYPrG2+BRzv03fmG0ZoenDsG6dMGHUmWMEYn7dm
         XE60OF5zS9HzXegunov2IV0leGQq8DWioAm8Z8jIfXNbHepKtjmsEsvQc4VeLzWYPl+X
         EuTjFG7o5EAcaldLQ809XRueEPSDe27uWN/dEzBSD76vqTovZD8vOPGHgSoKHPFlrXHZ
         LlzJ1bv0PXFpR25EaDQ8602XYI8llSrsxRIxlA4iWv2aknSlYTBO2fZSpGEdrv5eeehF
         tHyhBeRBsEbAR7F/XQ1oyLBWyEW2/Yu4sRUr4UGF3p3zrIGIkBm/cRQjG4upK1fLv4Qt
         h4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/LS1hdT6R5lll6d2XsZ3OLydUXNEMlU63xcM5zul1yKv4h1LUNkgFmMMXls2OFPTYviQLZKq7Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9YfBPEszrLPKmIthANAwETN2SN55LvsHtXxBztYFH7QfmS+6i
	daPmffHbwJFDevssGXBng+CCoja13i9z1cQJ0tR/dwLwAaV3NBBfqvxMugaSm10=
X-Gm-Gg: ASbGncsgmsT2/6q6GNisbgomijeYe1pbo2alJmwBCWPwbyKsKFubWgKsnQlwKIS2GJH
	otrtrgIc6Hh54VtBjBahylDSck+40gYN99n0o2QwoncuqNRMd/cvvbcQkw4mEJe4f2BJ6Z5Vod1
	u+ptR5UrRCueBg5l7UTXF0f1XdblxJoK8JjiQWTkDMbqRKTUNgdpd88FpU1hMbIhKShohykKxJJ
	gTb20g8gQAwUFdLhTq4PXflqGndmQK/RCUFlQSO1gdYn/AoLWsF9lO9/qHIKu5mCo35cTrqug/x
	esVJ7euGuKTRWSci9R24qhttXu5duA3/leVESu+LIWYulbH4lUhsYqNx6IfXZQooRMZK/Q==
X-Google-Smtp-Source: AGHT+IG5nl9eE/0JUL1JRbbOoYJgi12gehtW3O2h6zIyVUIoOfhbKmGKz3tOwr6bSiIFCoJEUrY0/w==
X-Received: by 2002:a05:6512:3e04:b0:545:16d3:3bd4 with SMTP id 2adb3069b0e04-54838f5e443mr1378311e87.53.1740153129385;
        Fri, 21 Feb 2025 07:52:09 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:03 +0200
Subject: [PATCH v3 5/8] dt-bindings: PCI: qcom-ep: add SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-5-61a0fdfb75b4@linaro.org>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=2EB6HQ3Xg729UaJzi6eQwoGHABfEKMGzkAxaHZxQ0PY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEhIOyO9evi4YM+xJTK2NM4Yj/jKLQrJ9Snz
 KarRzpLmseJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIQAKCRAU23LtvoBl
 uIa5D/95JI992C4uMMAmvNAtQO1N1b1d3cIaBQQVRB+Z6u8P4D13JhJcv4BtFqF0hzhQolon93z
 9l3Xt0lR2aSvVR/1BELh26VmhYUXIMJJlan2zlWPz5VQ+TucKB+9gdO3gsoJvGcDx/e7p5uhjkC
 dM89xqHhbhO3Yj7Yuv5wDiYg7RhcQebXG5nrkTRaRK4XJC1+vJhfd2CG0Jq3T2hRXDDUGZqzuXg
 5B50dWo/fCPli8sPsFf9Zj/aRFqTZzbMRD3LDu2aSU/YRzKCoUJkwY2q5+IZjoKDyFXn0zsHuf3
 7Ei7ogJ+tO4A46l1sGyUNJZrhWnR2jtH1Z1cWOf137KJbT8Y62gbK4hHJtXDlCU0FMN3ApMAIPs
 Xg980d93pVpCE2ttFBhB4ZkZ13DkG1p8QwE24r7ynV7nRUf9Z8Xy583X3xRiDy5wLHUJFrqydz2
 iyob4YM5FqEN317+gQBddC7V5v+XYKfhDMmHk1oRB0rRE2bt1zRmBTVMQknOn762+l1XvfcQYps
 lKXUmK5gvMjE/QW9Ck+fVLaL6zjaUuk+xxcK2fJpzmkWmBXylrojfbv2clYbpQv+IGDU7xS4S1b
 pbqm+OUBd+A7zktC5r1T52ZtIEYLmwQrlPQAMjO9H8g1vJ6D1Z48OB4qFpbV6mtuR95cCGJO41X
 okUVDAdDo5Pgung==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add support for using the PCI controller in the endpoint mode on the
SAR2130P platform. It is impossible to use fallback compatible to any
other platform since SAR2130P uses slightly different set of clocks.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 36 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 2c1918ca30dcfa8decea684ff6bfe11c602bbc7e..ac3414203d383bbd1a520dc11f317a5da9ca33e4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - qcom,sa8775p-pcie-ep
+          - qcom,sar2130p-pcie-ep
           - qcom,sdx55-pcie-ep
           - qcom,sm8450-pcie-ep
       - items:
@@ -44,11 +45,11 @@ properties:
 
   clocks:
     minItems: 5
-    maxItems: 8
+    maxItems: 9
 
   clock-names:
     minItems: 5
-    maxItems: 8
+    maxItems: 9
 
   qcom,perst-regs:
     description: Reference to a syscon representing TCSR followed by the two
@@ -132,6 +133,37 @@ required:
 allOf:
   - $ref: pci-ep.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sar2130p-pcie-ep
+    then:
+      properties:
+        clocks:
+          items:
+            - description: PCIe Auxiliary clock
+            - description: PCIe CFG AHB clock
+            - description: PCIe Master AXI clock
+            - description: PCIe Slave AXI clock
+            - description: PCIe Slave Q2A AXI clock
+            - description: PCIe DDRSS SF TBU clock
+            - description: PCIe AGGRE NOC AXI clock
+            - description: PCIe CFG NOC AXI clock
+            - description: PCIe QMIP AHB clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg
+            - const: bus_master
+            - const: bus_slave
+            - const: slave_q2a
+            - const: ddrss_sf_tbu
+            - const: aggre_noc_axi
+            - const: cnoc_sf_axi
+            - const: qmip_pcie_ahb
+
   - if:
       properties:
         compatible:

-- 
2.39.5


