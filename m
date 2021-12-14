Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F7474E59
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhLNW7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhLNW7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:59:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B8C06173F
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:59:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k37so39761589lfv.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iK+ZmbcJU9/EzwaB2fD8nVbLkEXFBhTxkz4m8H07tQ=;
        b=YGOxTe5LaHYi6X6eH8/EAouI1IKAuMRGi0wlZDSsZqxyGZBn0XfHREn7T/qA2TP1uW
         1wmmIt/sobNgrptpi/CG4Ilbgv9+twTbcP8l1GoGLu9o/BnszlfytPuEeT5TiF6MCQLB
         ZcGWVMylOyYkJVtdYiZPqqL69WdAaIBRPyQ3GY3RsuChyp/9/eDlOkDllfVioxkPvt1K
         Nzjyh2l9mZTDy5TEcZsT15kQ7TpsMrtOOrbt5bUsCp4d0Tg+xq8M8H7iumRJ9QEA2AhB
         1ST7go0BzzawLub2tlgwu2O5mGATalqbC+YqLM/QVcwDrQoBk6fuH90IcPfz/+KGELji
         rc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iK+ZmbcJU9/EzwaB2fD8nVbLkEXFBhTxkz4m8H07tQ=;
        b=rTNuGwcStexxPGbLb10UIS01nPWVdEGnHjVsgv7OUqxxjLaDJSgQD6czmAMnJMxanx
         PXpuL9ApY0DIdJCf9DdRfIIdsXYVYUMM+/+6kDT9ajR+47ZrizaOh/PUawV407b/pcMF
         BnFdGnqfFpu68fMir1KlvhmzeLzLudFnEFt6HDh/O27TyRvOUFNtEosOxTbEzwGt8QKP
         ZOUOhNqQ4Cu573btyj/1T1u27iwKpXAk3JCQRvdPx1gQYgjFpTsDCiRUICTesoz4dBky
         6R962xo3gXZKUz22CFuyCbFZ1e/A66TlTodkb0opdSXxYDW+mPqQ8CDsMK4UMVjJz1P+
         65VQ==
X-Gm-Message-State: AOAM532CXKpHZcT7gBRuLa8sN1/zLEQnHrIe3EUz93MykiNuHw97gqS2
        mSNhCaIBxTSD4QIaMA3zyCg/Ug==
X-Google-Smtp-Source: ABdhPJz57YADG4cjbkwu55h1YMqLvScywPDLnnI6DuIoEd2VNFmXoFTrNOHUk/BcA9bSnUxJWlZZQg==
X-Received: by 2002:a05:6512:36d1:: with SMTP id e17mr7248273lfs.673.1639522746578;
        Tue, 14 Dec 2021 14:59:06 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t10sm45115lja.105.2021.12.14.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:59:06 -0800 (PST)
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
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 08/10] arm64: dts: qcom: sm8450: add PCIe0 RC device
Date:   Wed, 15 Dec 2021 01:58:44 +0300
Message-Id: <20211214225846.2043361-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree node for the first PCIe host found on the Qualcomm
SM8450 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 101 +++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index a047d8a22897..f4bebaded8f4 100644
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
+			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
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

