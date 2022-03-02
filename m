Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B934CAFDC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiCBUc1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbiCBUcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:32:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64788DB847
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 12:31:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso2856178pjo.5
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 12:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZB0wmcHb/vPxT3OXeuOvQMbxgsgyn+6ztoW0hvGJJA=;
        b=J6aCv62JRv8pXKSN4faWU++P8+CfLEZhXxOFQNT7HfYNhIEB5EhOknuDcp7y90Wsam
         PaVTrXj/fKbQE7u1oWbVQRx0RjvIBQvkTXECdtmEwjw9dzeCuBdIwFnydrP7xDtH/UFb
         ED/xiCG1RhCOxuEu8ja7Zq7f08eL/Iyj4XoSBCaKZ2RJHHMsMHf1HI0quqXEDVyv0HMp
         rtcvFN9IS+eEynrmaJRJZAc4tMD75bkdzDPMI31DWLb4bhPYdAgCCpjCAnymiSYDHmVq
         bCETryp6zYTQRvFyP87TuGqfEv2chYjD+vxjB189GXg7wv3oF+qC3jrY2BW551ZwovjB
         EFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZB0wmcHb/vPxT3OXeuOvQMbxgsgyn+6ztoW0hvGJJA=;
        b=er8Sf6wyZnALJXHdz26zM8+9yfRx0mpukDUAQ3uwFV/kOEJIWRswcas3pyEtzJi3w/
         okdyz9oggvab+VHHk02LvuocC+Cm9SBKSAmG3+ohwwd5uiIG01zJPwDUctHYp7aJePlF
         vUiTr7b45gV7J6tz8u+yNCda1uRFBvPcLnYwG0g78eG0jJUfqH7BRzpGMjoen+62+Kou
         A69T7rs7PKtstLeWGghYnUoLRLDNyc/p6drPjzl7YWTo9nItV6RB+61DJzpxF5W7OYTZ
         1hhBsQufxzax9SyH8en1EBQeLHSYW+hLhb5jIQV8xMNIMsYHJGI9INqeTG4JriHhSFdy
         QNIA==
X-Gm-Message-State: AOAM531aVZ0zlCMQ0yc8RqmIOkuDkRJGzr3iSWqJvQEJO1Li1LgZ8TRp
        n2JrGZtYqUVfjrsfyTYBsCkxP9uVSMFgkA==
X-Google-Smtp-Source: ABdhPJyYuh2Fbf8DNP4cMJhNZHLXeireD7xt0LcQmeEs6jt/bpr0UnDN0KyUO0ZDi7d88WtLnvTfOw==
X-Received: by 2002:a17:90a:8582:b0:1b9:b0da:9ca9 with SMTP id m2-20020a17090a858200b001b9b0da9ca9mr1603031pjn.146.1646253090636;
        Wed, 02 Mar 2022 12:31:30 -0800 (PST)
Received: from localhost.localdomain ([182.64.85.91])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm5963410pjq.17.2022.03.02.12.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:31:30 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 6/7] arm64: dts: qcom: sm8150: Add PCIe nodes
Date:   Thu,  3 Mar 2022 02:00:44 +0530
Message-Id: <20220302203045.184500-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
References: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
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

Add nodes for the two PCIe controllers found on the SM8150 SoC.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 243 +++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 6012322a5984..598bc3d1ce69 100644
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
+			interrupts = <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
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

