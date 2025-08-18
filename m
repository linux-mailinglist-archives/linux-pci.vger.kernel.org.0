Return-Path: <linux-pci+bounces-34197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00DB2AB19
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA03B5C0470
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BF340D89;
	Mon, 18 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFrskJ7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594E288AD
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526907; cv=none; b=XGg7qbNAb05NCO5V5V1oMTQoneG/KALG25HnvhhebFi3rv5eQC2Dn18vbTyKcBHaqD8K+rekG1IcHjezZSWXJyXAneanQgvsqB+ZRO1AzY9mtkFJ9z8Rpkh5fHOpYWJM5knSl0F49C5TMu4OTiyS2vKJm2VSvtpcLbrDrLmnrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526907; c=relaxed/simple;
	bh=BBC/SN2tgiFfIsTJ+RWHDHrb8tIq6PdDhwdUXUNjggU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TChdHZWKSqkFN+Vbmw8CO7ALTX18LglB4FL1ztQ2qnTXaVmha+2XvljFwppPOwoXGo4QQlU+cjdAdzzVIeEKepMkNqMQxXaelRENnnWvsteQIWdRlCVMmb78QSmxICm8UFoL9gJN9W+ZQ4FaJdvxixlyMCS/CL0ajPWai8CwIjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFrskJ7l; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so77642366b.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755526904; x=1756131704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEM7/yLAdR0gVn4vxmtqYC2j4AXwiDEZgdOKy+Vv8No=;
        b=nFrskJ7lVFvZ/DT5W7FkfN/AIyLCjgxddI+pQgGi/dC6ysVPCiqK3c5Sj0KhBI0Hsp
         5obbmRPCvSjOQJ5Ald+U8DQpRUd2Gi5+1gqzA0eEkCxVOM1RHS7XksDASLHP5ehm51mY
         c5u0tnLPVnhwdggsrndBv8mq+hePUfb0RtF6rcQpj//RRiGfot/9ia5aaTrikfGW5pLE
         uiKMQahop6wK5/Lic/01SfIn4DGrm1PZR8iqC4G4/c/CAMz13HT4y7Rxd0Qln42HYc/D
         ZGuPo/qNLIzfTBJfl78gfXL+bTfhy60EdrRS3sZ3EMBCj6dK3CtRd4hCeRjAhPj2n9UL
         0/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526904; x=1756131704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEM7/yLAdR0gVn4vxmtqYC2j4AXwiDEZgdOKy+Vv8No=;
        b=P+0tv7ReDEH3EkWEDfgFCJksJm++W9Zpzu8DY47d3yCs073xox5eX3w1ll+7LMWlSP
         0AWaiGBaDBGOMjhLWifph9/5eFVB1WI/q/lqt2ZA5oY3JNOFxAg4O4CUF45btVDriFXm
         cLzcyNWk46ipzDvNgkb2/VoYSCx7vRRjlfDpUnKHvYZPXRGMiu2cekjn9fAFOuTZXS4j
         SIgCCBtG/hjCYp9j0drATjvDEgoUTbpNfeFZJ59meWpgO9gPfVy3XmVG8vuMKm2W0WwM
         tWYMTmZ4iAIVlQcOnAv3FP5stJ6Kox3h644mthfYIQjepxbuzzk3sTtxIPL9X4PEq80C
         JODA==
X-Forwarded-Encrypted: i=1; AJvYcCV3YK3oq5W3raD6M5LuyjnQCDK0O/r+i5ZteDxW6/lJaYpj274dntHX/4fxyPYy57hQug0q8RxPkiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7bg5lYBErhfc6uFESjkliLW6EZoMb8lsRJOV8IWnz6J2+XHf
	bSmTStI/GUoxvO6XGL11gLx4Td5Ge6EyBSH4d1HASm05wje3plBy4jMoBHKdQrB7Vqo=
X-Gm-Gg: ASbGncsNMBptDnO6+XofuT4bDGdEPLS05ozTo08muScziBHQp7k8G9VkzRxUW23E/rG
	b5m0rPrG4i8fSTJJWAZgLJtmbdWVRlmCwAuMPD5lBxYqZD5NKxkuIAqyeZ0XSIk7fCZX01M3Itt
	y1+RnCFicl5msGeX/v3gi+q+QgLChh/5bIFmL7tuZf8aFMBU9MjBgSto65vua8rNJgswCZWvt9w
	NDZB6w9N/HDFMMEA8SxK4Fcst7hMpflxdgobLfezeQ/Dhs7YIrobA0EgpOK29GlXu24NUk54jMo
	xTeYL73vDksQIuVi0J0XcQlBXFcMhZsR7CDPL9zfOnxyNKNYn1zAYQchekLuD94WCyG3b/betsb
	Mlc28++AeHmP0DHNQ1HE7FYBcKJtTuIyhV5ggSphTNix2
X-Google-Smtp-Source: AGHT+IEtfwHiR+XAMlo5vr9s8sihVw3NoWwDohiUKZohVSYlNNrg/QYbPb3rZp7CEC9otrmopx0qbQ==
X-Received: by 2002:a17:907:6d06:b0:af9:3758:a85a with SMTP id a640c23a62f3a-afcdbec64d1mr529367366b.5.1755526903928;
        Mon, 18 Aug 2025 07:21:43 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce73e2esm837537366b.39.2025.08.18.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:21:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: PCI: Correct example indentation
Date: Mon, 18 Aug 2025 16:21:39 +0200
Message-ID: <20250818142138.129327-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5299; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=BBC/SN2tgiFfIsTJ+RWHDHrb8tIq6PdDhwdUXUNjggU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoozbyzFA4VT4xhvO6BqBHnVAKh8r0Z9h+iH/0x
 gojCib/ZkSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKM28gAKCRDBN2bmhouD
 14ETEACSPncNUXTEglIktU9uqeatZH8RnHvdlDUwFWcuMAhCUrRz5U6n1/4x6YmKc4l41O4TNLu
 zzbmcXSUWZNOTbIGRDRYRix4ty7ZGv5YV7mLrRF+TRa6MN1VLbifTO0u7TA2oy6adpWTwKcZOzP
 GOJulwGkApHzONM4skSr64yIon8AvUEzmk45fsdT/MC99hzwAEfNOpJS6jShJoT4V4z1Wy5y0Q9
 D+RmLw5CKPYA3iE5V7FPQE0zNTcGyVUh3d7yu1VzWhrnFEW6LplJtY3X9WBuT1yFqBHoAFoYWxO
 0HYMONO3Jbf64r65XYO2rULZYUdyhvuGNwn2Lkn2rZPFy1WKuDKxmXdMkbKubVnNWfdfeygXfKG
 j3v8TsjnQ5uOk1EiqiuQrpsD+G144Uhd/TDU3zqX1SzQ9CQdiBtmdmdYLyA0Y8f+qpFoan7MEFw
 Y16Nm9/9QOdLmQf1iTkt14YGc0HPkTLBk+qpOOYK7virTE2WUe6V15reLFV7e5MShp7R4VaZZ/4
 eInn8TXB9dkdmIIT53wGxtf399h+1yPG65rsD5rr0LZJPyQfNUvrya603hPOBSgQ/VsfIFLlHLR
 aaYjG24LZ939Srmc/5ig7ohYl1OzatU+X9k2OgUXZjr5GoGJPmKyHkqWMwBrs+ercJLStqmIGzg OXt8qctGwamFf0g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces, so
correct a mixture of different styles to keep consistent 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    |  2 +-
 .../bindings/pci/qcom,pcie-sa8255p.yaml       | 74 +++++++++----------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 421e1116ae7e..406c15e1dee1 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -138,6 +138,6 @@ examples:
                 #address-cells = <0>;
                 #interrupt-cells = <1>;
                 interrupt-controller;
-           };
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
index ef705a02fcd9..bdddd4f499d1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
@@ -77,46 +77,46 @@ examples:
         #size-cells = <2>;
 
         pci@1c00000 {
-           compatible = "qcom,pcie-sa8255p";
-           reg = <0x4 0x00000000 0 0x10000000>;
-           device_type = "pci";
-           #address-cells = <3>;
-           #size-cells = <2>;
-           ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
-                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
-           bus-range = <0x00 0xff>;
-           dma-coherent;
-           linux,pci-domain = <0>;
-           power-domains = <&scmi5_pd 0>;
-           iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
-                       <0x100 &pcie_smmu 0x0001 0x1>;
-           interrupt-parent = <&intc>;
-           interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-           interrupt-names = "msi0", "msi1", "msi2", "msi3",
-                                  "msi4", "msi5", "msi6", "msi7";
+            compatible = "qcom,pcie-sa8255p";
+            reg = <0x4 0x00000000 0 0x10000000>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
+                     <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
+            bus-range = <0x00 0xff>;
+            dma-coherent;
+            linux,pci-domain = <0>;
+            power-domains = <&scmi5_pd 0>;
+            iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+                        <0x100 &pcie_smmu 0x0001 0x1>;
+            interrupt-parent = <&intc>;
+            interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3",
+                                   "msi4", "msi5", "msi6", "msi7";
 
-           #interrupt-cells = <1>;
-           interrupt-map-mask = <0 0 0 0x7>;
-           interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-                           <0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-                           <0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-                           <0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 
-           pcie@0 {
-                   device_type = "pci";
-                   reg = <0x0 0x0 0x0 0x0 0x0>;
-                   bus-range = <0x01 0xff>;
+            pcie@0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                bus-range = <0x01 0xff>;
 
-                   #address-cells = <3>;
-                   #size-cells = <2>;
-                   ranges;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
             };
         };
     };
-- 
2.48.1


