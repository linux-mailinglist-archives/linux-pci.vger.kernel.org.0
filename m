Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D65D4C850E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 08:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiCAH0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 02:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiCAH0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 02:26:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C793F65839
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:26:01 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z15so13405781pfe.7
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmFecBJXu85lugtXBovemAEOgrgg00YzaxmKlZmZCWI=;
        b=SgiynCT5RzFThAtZOzcPrgD8/7EBKO/cdj6EaTmkcid6XJnqK8JT/uQgzshPQkng4F
         dXAfubyVs+2HgKDS4qSzqHxAFIdNIm8OE/RgjbX68L3jaSv6D5tfGOL+pr21ZfFczJ1s
         37jcLnD5MDFgt8TWTeVRoy8dz6SgnB8R82AqrBPPWr5LJd8YivfWInrTpPzPlarXzIzR
         Jz+zxckq6RvPpN6HBEsAxLSH/iGnXps8T2BTeHdOYGDHYDj4Lg/boQL7pccgHDK3WjXd
         0Xz38Vav3aXxqIUWYbRQc3/J9GtIbn4niuhlKfSccIiPBEBb6nBSfwMJbcQrPJtJasGM
         kvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmFecBJXu85lugtXBovemAEOgrgg00YzaxmKlZmZCWI=;
        b=jF+mP/MpzlXmoagz/nLvE53EUKu2kRvcaP19RGdHDdM3nAzSUkll+RujKGw+96zSeb
         TAQ2rU+z9H1MjM/jE4epR8oT3YR57L3o17FvJWmPDEc1ZVeCm31MVaBZxIKrIxHmRzG5
         nKrx7kRGOM7kG2Dd9Ggmkq9HL57t8s6GNQncPLaUT3Zqbe8Z7K5aVySbNY8mXz7pf3Mp
         5S2dLf2j7qL6sRht1vuumU/G5dzwMs3uZ83MAvedgWqtQbz1nqjeoCrNRiYU5FDXF1G6
         bWqlU6qYBYbXecw3CzSTyhlnhB/zgMHKWei9eT3XWq32BebHNHuE7QmnmG9Ayjsq9qiS
         c71g==
X-Gm-Message-State: AOAM530PFBIv4rUcqOaLhq3pBhTj9p5nSsBSJpRwh1nW98NalnqiG1CP
        eIclq5MwIA9fEO0ioCwYPbNTAg==
X-Google-Smtp-Source: ABdhPJz21JPW9b6toh08ZMORWinkTWPA/rxbUHUkcLaRFXO0qpxABbKQKW8EeNNnfYl7gg1QS7G02g==
X-Received: by 2002:a63:5110:0:b0:374:2312:1860 with SMTP id f16-20020a635110000000b0037423121860mr20592042pgb.146.1646119560885;
        Mon, 28 Feb 2022 23:26:00 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm15680445pfh.153.2022.02.28.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:26:00 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: qcom: sm8150: Add pcie nodes for SM8150
Date:   Tue,  1 Mar 2022 12:55:10 +0530
Message-Id: <20220301072511.117818-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add nodes for the two PCIe controllers founds on the
SM8150 SoC.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 243 +++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 6012322a5984..b97f04ec9c6b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1626,6 +1626,203 @@ system-cache-controller@9200000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
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
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu";
+
+			iommus = <&apps_smmu 0x1d80 0x7f>;
+			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
+				    <0x100 &apps_smmu 0x1d81 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+
+			perst-gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie0_default_state>;
+
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sm8150-qmp-gen3x1-pcie-phy";
+			reg = <0 0x01c06000 0 0x1c0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
+			clock-names = "aux", "cfg_ahb", "refgen";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie0_lane: phy@1c06200 {
+				reg = <0 0x1c06200 0 0x170>, /* tx */
+				      <0 0x1c06400 0 0x200>, /* rx */
+				      <0 0x1c06800 0 0x1f0>, /* pcs */
+				      <0 0x1c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#phy-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk";
+			};
+		};
+
+		pcie1: pci@1c08000 {
+			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
+			reg = <0 0x01c08000 0 0x3000>,
+			      <0 0x40000000 0 0xf1d>,
+			      <0 0x40000f20 0 0xa8>,
+			      <0 0x40001000 0 0x1000>,
+			      <0 0x40100000 0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+
+			interrupts = <GIC_SPI 306 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+				 <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu";
+
+			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			iommus = <&apps_smmu 0x1e00 0x7f>;
+			iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
+				    <0x100 &apps_smmu 0x1e01 0x1>;
+
+			resets = <&gcc GCC_PCIE_1_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_1_GDSC>;
+
+			phys = <&pcie1_lane>;
+			phy-names = "pciephy";
+
+			perst-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
+			enable-gpio = <&tlmm 104 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie1_default_state>;
+
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@1c0e000 {
+			compatible = "qcom,sm8150-qmp-gen3x2-pcie-phy";
+			reg = <0 0x01c0e000 0 0x1c0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
+			clock-names = "aux", "cfg_ahb", "refgen";
+
+			resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie1_lane: phy@1c0e200 {
+				reg = <0 0x1c0e200 0 0x170>, /* tx0 */
+				      <0 0x1c0e400 0 0x200>, /* rx0 */
+				      <0 0x1c0ea00 0 0x1f0>, /* pcs */
+				      <0 0x1c0e600 0 0x170>, /* tx1 */
+				      <0 0x1c0e800 0 0x200>, /* rx1 */
+				      <0 0x1c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#phy-cells = <0>;
+				clock-output-names = "pcie_1_pipe_clk";
+			};
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -2327,6 +2524,52 @@ qup_spi19_default: qup-spi19-default {
 				drive-strength = <6>;
 				bias-disable;
 			};
+
+			pcie0_default_state: pcie0-default {
+				perst {
+					pins = "gpio35";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq {
+					pins = "gpio36";
+					function = "pci_e0";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake {
+					pins = "gpio37";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			pcie1_default_state: pcie1-default {
+				perst {
+					pins = "gpio102";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq {
+					pins = "gpio103";
+					function = "pci_e1";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake {
+					pins = "gpio104";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {
-- 
2.35.1

