Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04D46D973
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbhLHRSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 12:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbhLHRSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 12:18:39 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60015C061A72
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 09:15:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z7so6862443lfi.11
        for <linux-pci@vger.kernel.org>; Wed, 08 Dec 2021 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkjJueskC61HJ/9+LZZr5rRLuA13RiM7nsIGLfBSnLA=;
        b=InXqlkb8bYIUHb0nJPDLrzLzo+1jrkcmFWO4SNdew8tYqlxT0PUSRd7ud3TFEIXGkG
         htH+v8JbkW5jmOK5zn989xk9zKjoRULkuw+ghHgD3vWyNtsmN1tIRcFGLHCqk0P5TUpw
         sjFC/goO/2Wu50E8aHMM/ftC02Jh/OhK1NqSdPUES3zBaTCo86qrldTxI+j0ssuLqsQc
         kCtA8j3xKjPLTQ9IHQ8MnNcn3Tf0seYV1PRv5Py3m9Jpvqxgje1Kx1RBk9pVEUkgM0qa
         s0VEHnPD8WZrzxy4ZMT1gLxRykx9kdYYTfAyyw05Sq6C3dKYxxmNXrdlF5Tgj8ZsKmTe
         BlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkjJueskC61HJ/9+LZZr5rRLuA13RiM7nsIGLfBSnLA=;
        b=WXVpKzgIAvJOBXW43iT3E/XHwbVscL/X3HRMhdGLCDdQtOJmTC1Gk5LztUU6hKfhlG
         5x7mESNPxBh37JdPeMTWVBfCLqA657IcZnKGJfht9rh/Z/IDBABBPx2pP90R4AklbQ5W
         B52ECBh9qBJl3trsOPNJPWu/pZxdyeMexqVSdKNrll/VBJF4wYnkvXTo070V9jxuTrWh
         Tbl5CgD8I2X4T1cJDAtNPcLmYMDlu+cP3Y46FToafXERvzNiK/tyo5ocUsxi98AQL49O
         Buldk3NdthKS3Hx5yx69c7GAhxKg6ZTLT3qdvj+fvDfq6noR9zHcbdW+2MN1RJrO/kbt
         sUvA==
X-Gm-Message-State: AOAM532l6zeoX4XhYaAx5YfZkeFrw1HuUgGb7sOz1Vu8XZj7Oyiu9zNk
        Ek+VWwYHz3ZVeZsXTOQrZkydHQ==
X-Google-Smtp-Source: ABdhPJy7w2PoI4pjdcMwTMAP8qXMGY5JW498WPPj2dVvRdOn3JxwFH7bVFzXWEGU2mhNJmADz/8mLQ==
X-Received: by 2002:a05:6512:6c7:: with SMTP id u7mr702294lff.636.1638983705646;
        Wed, 08 Dec 2021 09:15:05 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t9sm307213lfe.88.2021.12.08.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:15:05 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v2 08/10] arm64: dts: qcom: sm8450: add PCIe0 RC device
Date:   Wed,  8 Dec 2021 20:14:40 +0300
Message-Id: <20211208171442.1327689-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree node for the first PCIe host found on the Qualcomm
SM8450 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 101 +++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index a047d8a22897..09087a34a007 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -627,6 +627,84 @@ i2c14: i2c@a98000 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+		];
+
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-sm8450";
+			reg = <0 0x01c00000 0 0x3000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60001000 0 0x1000>,
+			      <0 0x60100000 0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
+				 <&pcie0_lane>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
+			clock-names = "pipe",
+				      "pipe_mux",
+				      "phy_pipe",
+				      "ref",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "aggre0",
+				      "aggre1";
+
+			iommus = <&apps_smmu 0x1c00 0x7f>;
+			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
+				    <0x100 &apps_smmu 0x1c01 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+			power-domain-names = "gdsc";
+
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+
+			perst-gpio = <&tlmm 94 GPIO_ACTIVE_LOW>;
+			enable-gpio = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie0_default_state>;
+
+			interconnects = <&pcie_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
+			interconnect-names = "pci";
+
+			status = "disabled";
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -763,6 +841,29 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 211>;
 			wakeup-parent = <&pdc>;
 
+			pcie0_default_state: pcie0-default {
+				perst {
+					pins = "gpio94";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq {
+					pins = "gpio95";
+					function = "pcie0_clkreqn";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake {
+					pins = "gpio96";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
 			qup_i2c13_default_state: qup-i2c13-default-state {
 				mux {
 					pins = "gpio48", "gpio49";
-- 
2.33.0

