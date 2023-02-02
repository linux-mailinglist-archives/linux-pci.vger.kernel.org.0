Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12509687D9A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjBBMkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 07:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjBBMjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 07:39:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E58BDFE
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 04:39:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o36so1292643wms.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 04:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhFH3MDoVM8IW/Ed3e+Mv5/+oaq5exzhbtIWnhMIQjc=;
        b=r6xeXLdCcolXS6zn4ApecLvKhYNRU61nSKqfY5Pm2ugyONdv1B1SES/MGoP78w0aVg
         aOGhVZ89oVAUObaoWYD3pm4ACNcApZcDknTjQOOqyOSfC9y5LvUJya/1Y4bYk51XECAO
         mge3uFpkbi25+2kFeudHQrkjnSo/0eDAOtdOJ91sBXrwtK+tmJC9sPRerJfXLG0HJKDD
         HoL9iW+WLwIcUl1pxES5XQAklTOdzSprspc1pNLj4yAuLc610pbUwlqv2Oedzgkp4yVl
         SUszEMNFFEKbMG/zox3tpo65HSbK4Gka9lbUnqMpiWgNR7m/udFFdYyloal0R/TRw/K5
         t26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhFH3MDoVM8IW/Ed3e+Mv5/+oaq5exzhbtIWnhMIQjc=;
        b=VfWr88RYphzNIE/EUNS7gED1uNpLmPW13EBt0gz5NUffYl72WSJoPau1O2db5+Tsb8
         Wu/melD2i8Zs7UMPiVTH+n7nVcpAG+mmvtOrlj+Zjbk9F1SetW0cSZpm7cAWkNjBJ725
         tBTqu0V08uZKuhe2o+ioDA89EBC2/HEkg97eTkTwaZaVXX6/G1z2HU2sxMoFHOi8+Dv0
         yRoogMrs5Vgw5XITgqJPFR1qWsk7dNDcDU3Yej5eftvy4k1Xvd1pqDYaDa6gP5OQBhkF
         KF75fdRMZc5W2BSD5O9NUo6J3XQg858IyVpT5MMdWeef1I/FrCsQRO57sdPS0FrhPged
         Yk+A==
X-Gm-Message-State: AO0yUKXC96eTdmfEA0VvHP4kf2p1/0glw+hSFRG5EhdsqEamTUKYD/Td
        mpm1IZI417C5xcwQuCBUw5Tv+w==
X-Google-Smtp-Source: AK7set9OA/7/3Qbq98spBzscKJwjoQpg8hsnAJfsRx/b4NqpY4XkkIqylJF9l3HQvdNFWvtCO3GQ/Q==
X-Received: by 2002:a05:600c:4ec7:b0:3dc:5e0d:4ce7 with SMTP id g7-20020a05600c4ec700b003dc5e0d4ce7mr5800182wmq.11.1675341567455;
        Thu, 02 Feb 2023 04:39:27 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm19525644wro.8.2023.02.02.04.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:39:26 -0800 (PST)
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
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 11/12] arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
Date:   Thu,  2 Feb 2023 14:39:01 +0200
Message-Id: <20230202123902.3831491-12-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202123902.3831491-1-abel.vesa@linaro.org>
References: <20230202123902.3831491-1-abel.vesa@linaro.org>
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

Add PCIe controllers and PHY nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patch does not have a v3, but since it is now part of the same
patchset with the controller and the phy drivers patches, I had to
bump the version to 4.

The v5 was here:
https://lore.kernel.org/all/20230124124714.3087948-12-abel.vesa@linaro.org/

Changes since v5:
 * renamed nocsr_com to phy_nocsr as discussed off-list with Bjorn and Johan

Changes since v4:
 * renamed noc_aggr_4 back to noc_aggr
 * moved pinctrl properties out to MTP dts
 * renamed nocsr to nocsr_com

Changes since v2:
 * renamed the pcie_1_link_down_reset to simply link_down
 * dropped the pipe from clock-names
 * renamed aggre clock-names to noc_aggr_4
 * dropped the _pcie infix from cnoc_pcie_sf_axi
 * dropped the aux_phy clock from the pcie1
 
Changes since v1:
 * ordered pcie related nodes alphabetically in MTP dts
 * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
 * dropped the child node from the phy nodes, like Johan suggested,
   and updated to use the sc8280xp binding scheme
 * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
   to "nocsr"
 * reordered all pcie nodes properties to look similar to the ones
   from sc8280xp


 arch/arm64/boot/dts/qcom/sm8550.dtsi | 203 ++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index be2d85ee1f20..a85d2ae7d155 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -740,9 +740,9 @@ gcc: clock-controller@100000 {
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			clocks = <&bi_tcxo_div2>, <&sleep_clk>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie0_phy>,
+				 <&pcie1_phy>,
+				 <&pcie_1_phy_aux_clk>,
 				 <&ufs_mem_phy 0>,
 				 <&ufs_mem_phy 1>,
 				 <&ufs_mem_phy 2>,
@@ -1641,6 +1641,203 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		pcie0: pci@1c00000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sm8550";
+			reg = <0 0x01c00000 0 0x3000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60001000 0 0x1000>,
+			      <0 0x60100000 0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <0>;
+			num-lanes = <2>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr";
+
+			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			iommus = <&apps_smmu 0x1400 0x7f>;
+			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
+				    <0x100 &apps_smmu 0x1401 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			phys = <&pcie0_phy>;
+			phy-names = "pciephy";
+
+			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy";
+			reg = <0 0x01c06000 0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "rchng",
+				      "pipe";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_0_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie0_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		pcie1: pci@1c08000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sm8550";
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40100000 0x0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <1>;
+			num-lanes = <2>;
+
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
+
+			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_1 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			iommus = <&apps_smmu 0x1480 0x7f>;
+			iommu-map = <0x0   &apps_smmu 0x1480 0x1>,
+				    <0x100 &apps_smmu 0x1481 0x1>;
+
+			resets = <&gcc GCC_PCIE_1_BCR>,
+				<&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
+			reset-names = "pci", "link_down";
+
+			power-domains = <&gcc PCIE_1_GDSC>;
+
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+
+			perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+			enable-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@1c0e000 {
+			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
+			reg = <0x0 0x01c0e000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
+				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_1_PIPE_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "rchng",
+				      "pipe";
+
+			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
+				 <&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy", "phy_nocsr";
+
+			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_1_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie1_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		cryptobam: dma-controller@1dc4000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0 0x01dc4000 0x0 0x28000>;
-- 
2.34.1

