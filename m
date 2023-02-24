Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF6C6A1AEA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 12:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjBXLBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 06:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjBXLAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 06:00:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE79961EF3
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u10so16085754pjc.5
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6vfCv6t5vjN1sjFyDIdqOCzfNDFUx2i/y3YhWTxhes=;
        b=E3vLvIh2g9bUvobdpe4jNkgRfo+p7aptEfGDgt0/wn/CAJCarKma6PtJsZA88qWAAB
         I8UfGJ0IrDOw/kyOZMtcao3yCS1Y6GB9ty8RpX6fDTqYQsAV2QhlDpzxJGaFM3sqfIpU
         EktNzBNQhO4nWgXwPiH3p7CRIbCIqX/Zx46HNFKpYYG8C01Iute+Mgl0Jm0mSduTOr3z
         mzbGzsEVhJinNyGU/JZW8QBfog8oloLsk8NRCmuTQWfMV23qzBN8UOEU0g2c0SnNLFC2
         1PUYL0VuaI/BsK3t17rp2UWkdBWRUZ2UvS/EEhuQPRfXqeANcuE6FYUqN0udSdZ8dzu3
         KuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6vfCv6t5vjN1sjFyDIdqOCzfNDFUx2i/y3YhWTxhes=;
        b=Z5s0YYZK617KXtoeDpMVXxzDWfG2Vyd8gl/NmIiXe7rXAWIaTkr67pF+uTk2rdx5D8
         lQuY9zO1HBAnW7+CYLMcAYNuW10X26eUX6Oi+cS9BymK9+MDF6QMYYHgXz1i83O+HdtR
         5TY99R/DfpgI2IzgcWkHatfJizbwa5y2X5XBWmSRaVD43KQaY3HGkKf2256E6EJr8JW8
         bugpHJqCnHic0lmkqeYZddQTjWCx1qlJDtgVrC+OQZsXsLfNaHlVChjSGX4YITLM8jsy
         XGmTWppz+cHBdZFx2Z8NrD37FWoASBMRKrdxBPjIY0FjDqJsJVo47qtQp8Kp46SlRj4u
         TbEw==
X-Gm-Message-State: AO0yUKXLgtoD8wz66gonadUV2HmnrlGn0Hy0StOu7HDXABJmSdXU8Jg7
        unf9xgGb4O+UbBBttBRDDjJs
X-Google-Smtp-Source: AK7set8i0WA4JqJMrgHjV0wM4NunGTsxWfFyBZgCTAe9v84lZvvPQ4osQaGtgXPJsdj4Un0C+6sg9Q==
X-Received: by 2002:a17:90b:38ca:b0:230:a82c:d6c4 with SMTP id nn10-20020a17090b38ca00b00230a82cd6c4mr16388555pjb.15.1677236388465;
        Fri, 24 Feb 2023 02:59:48 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 07/13] ARM: dts: qcom: sdx55: Add support for PCIe RC controller
Date:   Fri, 24 Feb 2023 16:29:00 +0530
Message-Id: <20230224105906.16540-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller in SDX55 can act as the RC controller also. Let's
add support for it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index a1f4a7b0904a..b411c4ae34c3 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -303,6 +303,88 @@ qpic_nand: nand-controller@1b30000 {
 			status = "disabled";
 		};
 
+		pcie_rc: pcie@1c00000 {
+			compatible = "qcom,pcie-sdx55";
+			reg = <0x01c00000 0x3000>,
+			      <0x40000000 0xf1d>,
+			      <0x40000f20 0xc8>,
+			      <0x40001000 0x1000>,
+			      <0x40100000 0x100000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x40200000 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x40300000 0x0 0x3fd00000>;
+
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "msi8";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_PIPE_CLK>,
+				 <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLEEP_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "sleep";
+
+			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			iommus = <&apps_smmu 0x0200 0x0f>;
+			iommu-map = <0x0   &apps_smmu 0x0200 0x1>,
+				    <0x100 &apps_smmu 0x0201 0x1>,
+				    <0x200 &apps_smmu 0x0202 0x1>,
+				    <0x300 &apps_smmu 0x0203 0x1>,
+				    <0x400 &apps_smmu 0x0204 0x1>;
+
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_GDSC>;
+
+			phys = <&pcie_lane>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
 		pcie_ep: pcie-ep@1c00000 {
 			compatible = "qcom,sdx55-pcie-ep";
 			reg = <0x01c00000 0x3000>,
-- 
2.25.1

