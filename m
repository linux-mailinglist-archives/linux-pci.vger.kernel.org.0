Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411D32D2F6
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2019 02:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE2A5R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 20:57:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40056 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfE2A5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2019 20:57:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id g69so267423plb.7
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2019 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hlEO6V7+iSB0usIkjd5ruLwMRHdYcss4+6c861fNe8Q=;
        b=QTTM4PotKaA4IWlNuUfDPwLnIF1aRDxixXGN67NyrM/MlBWhi35yl/zppSWddOJUcq
         bTRLWy2heNAW31E0waEi5L2qiWWBieOzF+urk+EolzhiIrFiKFgrQbDCntfNS42vMUAz
         LQ2HycxMig495CGrvMg/4Rfq+IBY1/In+hK/2I/6qanhZXy5DRxXyRYExDN1xM0Ugwwy
         Wk0LrQi3dvi6hr2M02Q0f2pzwmvgM8vefZpjaumkL1BVe4acYIGS5Jn+Jv3IT3aU4dOX
         xGPe1Ussyf7ZCZcN111RZmdbfQxIETr5ArFYhUgtpxUwFNOm9uy6ii+XqGrmJPCXjBs4
         jjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hlEO6V7+iSB0usIkjd5ruLwMRHdYcss4+6c861fNe8Q=;
        b=Q760yq0gRAD5Eo08moV5mMjNGBn3PGNqitWdZZGLAJ6hv97y4bQJBftgqWA0fZ8Pz6
         3JVzOcXo3qcBcNq+vEEZ8q4Ia9HREt77KxFD2zfSR6Sn259GboV6i4K5O5q8uaKttiXJ
         QZBubALUZUitWKJj5WVqAwgTdDCPMb/AuzVUjrkiMtSPdf/nhzO8/3OBSawybAQzI1U2
         DZCAYp4/UhVnVngU1foiILdYGg4oJdCWHjQhGGUr8pafVt+KckfNd5kwZ9885qkgSi2F
         8NXcd+JGc0mZyO8M+9Z3aUTVSscywppX4PMrUkb7/9z43JWoyePwUTXv254Bec70Nqjg
         gVCg==
X-Gm-Message-State: APjAAAWPW7QQTyEGPTs+OJWpNIhExg+zMAi1Vck4tO4pBtRWc2joraRq
        Awl9CGbHdJ1jlWmFxgqBIY2v8Q==
X-Google-Smtp-Source: APXvYqxha4K1BcnGksiFrjYcA5HRF79hcgx8gvplR1gMNk8TQR5zjZNecUh5Q3sIoHbLSPvvs27bfA==
X-Received: by 2002:a17:902:b094:: with SMTP id p20mr111611096plr.164.1559091436245;
        Tue, 28 May 2019 17:57:16 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p16sm15434824pff.35.2019.05.28.17.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 17:57:15 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: PCI: qcom: Add QCS404 to the binding
Date:   Tue, 28 May 2019 17:57:09 -0700
Message-Id: <20190529005710.23950-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190529005710.23950-1-bjorn.andersson@linaro.org>
References: <20190529005710.23950-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Qualcomm QCS404 platform contains a PCIe controller, add this to the
Qualcomm PCI binding document. The controller is the same version as the
one used in IPQ4019, but the PHY part is described separately, hence the
difference in clocks and resets.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Picked up Vinod's r-b

 .../devicetree/bindings/pci/qcom,pcie.txt     | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 1fd703bd73e0..ada80b01bf0c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -10,6 +10,7 @@
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
 			- "qcom,pcie-ipq4019" for ipq4019
 			- "qcom,pcie-ipq8074" for ipq8074
+			- "qcom,pcie-qcs404" for qcs404
 
 - reg:
 	Usage: required
@@ -116,6 +117,15 @@
 			- "ahb"		AHB clock
 			- "aux"		Auxiliary clock
 
+- clock-names:
+	Usage: required for qcs404
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "iface"	AHB clock
+			- "aux"		Auxiliary clock
+			- "master_bus"	AXI Master clock
+			- "slave_bus"	AXI Slave clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -167,6 +177,17 @@
 			- "ahb"			AHB Reset
 			- "axi_m_sticky"	AXI Master Sticky reset
 
+- reset-names:
+	Usage: required for qcs404
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "axi_m"		AXI Master reset
+			- "axi_s"		AXI Slave reset
+			- "axi_m_sticky"	AXI Master Sticky reset
+			- "pipe_sticky"		PIPE sticky reset
+			- "pwr"			PWR reset
+			- "ahb"			AHB reset
+
 - power-domains:
 	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
@@ -195,12 +216,12 @@
 	Definition: A phandle to the PCIe endpoint power supply
 
 - phys:
-	Usage: required for apq8084
+	Usage: required for apq8084 and qcs404
 	Value type: <phandle>
 	Definition: List of phandle(s) as listed in phy-names property
 
 - phy-names:
-	Usage: required for apq8084
+	Usage: required for apq8084 and qcs404
 	Value type: <stringlist>
 	Definition: Should contain "pciephy"
 
-- 
2.18.0

