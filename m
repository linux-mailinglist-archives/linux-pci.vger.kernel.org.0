Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186568F670
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjBHSB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjBHSBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 13:01:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830D85357A
        for <linux-pci@vger.kernel.org>; Wed,  8 Feb 2023 10:01:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so2763627wmp.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Feb 2023 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S84pLTPJCH/uwIFX1Bqrss8Ya9/sRzww29xePAXKGDg=;
        b=OWbsgK5wAowu7HB3nMQtoFtJcIRiloGKze/s9KZYtplpDskAKGHGIZ2cLBUOlFTldN
         F1q0UQqdLKfrg8g+y6t+karc07rgUjCFjcm1NiowH0px6NBw+lDeyFJWxei/JUQbN2L8
         ZAV298fCUmv9guqNe48PsxxYst11g09THitgj7bD6jDpM8B3HcBkEArsGMBjLUcbUYSA
         oBd+RfOwVAMOtT1rm/GnczfT69J9qVQ0CHIr1aoCrQRzZceH+A9K7H+TxFySZD3m3jVd
         NU3MiK7ePlYGgHDhMFAK0ncEzPbm1uEAq/Wo27nelnIyWV86vxdwGK4YbcbPCG7PJCC0
         QuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S84pLTPJCH/uwIFX1Bqrss8Ya9/sRzww29xePAXKGDg=;
        b=fG4BDwHeEl/FGvHyfcWFml4BvaxdXyV5QiiOb64URqwv/55IlUHZv10fmyb3nVaUmx
         f63ShFOH5mvnYPhxlUK7TDMDvbm3xn0NfhouOW6MVel+2EqnAzgd+Nh5G7gGIAuxi9xm
         kUQsiHc0F7d5q4wEqYpyGmzenA+bJkiJVgZXAPNci/Gnh+bEcHD2eIOj8N8tuXMDVCgl
         3KHrzyl/TZa5SvM9JRqrVbIwdG/BvG5zBesGT28eLnW2vUfkbC/1M5oYQU5lNXh5iQfl
         MrIfypLusEH/mp43gsjYqHWn8F8kaJ9OhDq8cun5plKtKX9k7gx831CxB23gMc6VQ/1y
         OWUw==
X-Gm-Message-State: AO0yUKV8d2z0rPRwK1cw6JDe0uEK2uS+aKx0d+3SxzJaze6zS49y4TCb
        u3RQXqgkZYTZcbFgQCMoTQ/8cA==
X-Google-Smtp-Source: AK7set8LIAnojVY6PUG1aP0PYXhEbr07tUn+/CwvVQC7jyf60qhmICJLIeoZPPkmfA3vmuPOkOX5AA==
X-Received: by 2002:a05:600c:1606:b0:3e0:39:ec9d with SMTP id m6-20020a05600c160600b003e00039ec9dmr7552229wmn.23.1675879265169;
        Wed, 08 Feb 2023 10:01:05 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c169400b003dc54eef495sm2370286wmn.24.2023.02.08.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:01:04 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 11/11] arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers nodes
Date:   Wed,  8 Feb 2023 20:00:20 +0200
Message-Id: <20230208180020.2761766-12-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208180020.2761766-1-abel.vesa@linaro.org>
References: <20230208180020.2761766-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First, move the pinctrl related propeties out from SoC dtsi and into the
board dts and add blank lines before status properties in the PHY nodes
to be consistent with the rest of the nodes. Then drop the pipe clock
from the controller nodes. Rename the aggre0 and aggre1 clocks to more
generic noc_aggr, and then the cnoc_pcie_sf_axi to cnoc_sf_axi. Add the
cpu-pcie interconnects to both controller nodes. Rename the pcie1 second
reset to link_down and drop the unnecessary enable-gpios. Switch the aux
clock to GCC_PCIE_1_PHY_AUX_CLK for the pcie1 PHY and drop the aux_phy
from clock-names. Also rename the nocsr reset to phy_nocsr. With this
changes we are now in line with the SC8280XP bindings.

Fixes: 98a4dc3a78fa ("arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

The v8 of this patch is:
https://lore.kernel.org/all/20230206212619.3218741-12-abel.vesa@linaro.org/

Changes since v8:
 * added Johan's R-b tag

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 10 +++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 52 +++++++++----------------
 2 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 725d3bc3ee72..56aab7cafcbc 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -414,18 +414,27 @@ &pcie_1_phy_aux_clk {
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
 	status = "okay";
 };
 
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1e_0p88>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
+
 	status = "okay";
 };
 
 &pcie1 {
 	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+
 	status = "okay";
 };
 
@@ -433,6 +442,7 @@ &pcie1_phy {
 	vdda-phy-supply = <&vreg_l3c_0p91>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
 	vdda-qref-supply = <&vreg_l1e_0p88>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6ff135191ee0..bba1123ea374 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1672,25 +1672,24 @@ pcie0: pci@1c00000 {
 					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
-			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
-				 <&gcc GCC_PCIE_0_AUX_CLK>,
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
 				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
 				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
-			clock-names = "pipe",
-				      "aux",
+			clock-names = "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
 				      "slave_q2a",
 				      "ddrss_sf_tbu",
-				      "aggre0";
+				      "noc_aggr";
 
-			interconnect-names = "pcie-mem";
-			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
+			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
 
 			iommus = <&apps_smmu 0x1400 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
@@ -1704,12 +1703,6 @@ pcie0: pci@1c00000 {
 			phys = <&pcie0_phy>;
 			phy-names = "pciephy";
 
-			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
-			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&pcie0_default_state>;
-
 			status = "disabled";
 		};
 
@@ -1771,8 +1764,7 @@ pcie1: pci@1c08000 {
 					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
-			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
-				 <&gcc GCC_PCIE_1_AUX_CLK>,
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
@@ -1780,21 +1772,21 @@ pcie1: pci@1c08000 {
 				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
 				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
 				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
-			clock-names = "pipe",
-				      "aux",
+			clock-names = "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
 				      "slave_q2a",
 				      "ddrss_sf_tbu",
-				      "aggre1",
-				      "cnoc_pcie_sf_axi";
+				      "noc_aggr",
+				      "cnoc_sf_axi";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			interconnect-names = "pcie-mem";
-			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>;
+			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_1 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
 
 			iommus = <&apps_smmu 0x1480 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1480 0x1>,
@@ -1802,20 +1794,13 @@ pcie1: pci@1c08000 {
 
 			resets = <&gcc GCC_PCIE_1_BCR>,
 				<&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
-			reset-names = "pci",
-				"pcie_1_link_down_reset";
+			reset-names = "pci", "link_down";
 
 			power-domains = <&gcc PCIE_1_GDSC>;
 
 			phys = <&pcie1_phy>;
 			phy-names = "pciephy";
 
-			perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
-			enable-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&pcie1_default_state>;
-
 			status = "disabled";
 		};
 
@@ -1823,18 +1808,17 @@ pcie1_phy: phy@1c0e000 {
 			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
 			reg = <0x0 0x01c0e000 0x0 0x2000>;
 
-			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
 				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
-				 <&gcc GCC_PCIE_1_PIPE_CLK>,
-				 <&gcc GCC_PCIE_1_PHY_AUX_CLK>;
+				 <&gcc GCC_PCIE_1_PIPE_CLK>;
 			clock-names = "aux", "cfg_ahb", "ref", "rchng",
-				      "pipe", "aux_phy";
+				      "pipe";
 
 			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
 				 <&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
-			reset-names = "phy", "nocsr";
+			reset-names = "phy", "phy_nocsr";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
 			assigned-clock-rates = <100000000>;
-- 
2.34.1

