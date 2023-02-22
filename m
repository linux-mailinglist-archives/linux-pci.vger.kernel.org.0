Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17C69F80E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjBVPeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 10:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjBVPeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 10:34:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814793B3E0
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 07:33:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h14so9292440plf.10
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 07:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frPAbJX6IbYMGdSO5i2vVIONplrg4szzCvfObYpFa4I=;
        b=sRUZyKJQWOKpCgL+u2PLfeiXYXt6xtXxNx+mTGh5sCovfq8lREW2rnC8ltuf5B17fs
         9l6/lwqKLjHge+jOoPSKN1IM6oPrt4PJ2J9qqv/bDh3suh+ttLL4TnN7q4l/4MsdtwQH
         ytPWyWMG0HA84+N9GN9Rbd4Y6UM/6bjJkzUeHfnnWRUauPa/0WLdevWKceCqBOUeA4OZ
         ScvKoVW11YSjGxbS784ux4MPPaTbGmubJEULo8TzWCgVqJKuKacuHteWF5R02sPm0jRt
         +AiDe8iFAQHAiYZrnIeioPORCKGjWH3yeobUUgLFaeJSLZoPqQucAePclTimYwHQx3bb
         YADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frPAbJX6IbYMGdSO5i2vVIONplrg4szzCvfObYpFa4I=;
        b=wBjNVN9SDV7SnYxmEvDefYdCjmBdemkaJoIAZIz1h+m1q4b+2UUhA8/6T5Pd7NHLG1
         zVfZBD0D6/UVve5chRVwO+Vz17/r+Xy1t6VcFaHZ5EcTVWV95SDba3YhZWbDgy1ELgKJ
         AG2XQjHUgFGcJxTEMc6uKC0RsHZh1s2uGpq3a9BPohJBMSgVC1sCoEZq8FTuQu6n0fV7
         rmLIAP6Vd6wV4rQgRmNiw1svwioZGu3GEKV3ZIjigfKz+IRXhtBEVCKPLUTMbXyDWt1+
         vPPBT+8lAxDyh+kxJzK4Kf8VOO3YkEI2j8L55S1lLFsEW292B3XualuOVPkr4ReC3l1j
         cTDQ==
X-Gm-Message-State: AO0yUKXQ88oMh9Urf7SU1qwPHM86k2JzK1Q0U1aIIO8RGpBkYtVPin5T
        Un0c2vOf8VArjSE0D92VHwfS
X-Google-Smtp-Source: AK7set8CvdobC9xRiviT8mS8REbRqj6/Yk7otDIZZmUKfon5h8lfYw/K2UBEBZNM9OhrE6YWbLUHyg==
X-Received: by 2002:a05:6a20:a02a:b0:bc:d6e0:3ff6 with SMTP id p42-20020a056a20a02a00b000bcd6e03ff6mr10009690pzj.52.1677080020854;
        Wed, 22 Feb 2023 07:33:40 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.15])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm5222482pfd.186.2023.02.22.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:33:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/11] ARM: dts: qcom: sdx55: Add support for PCIe RC controller
Date:   Wed, 22 Feb 2023 21:02:47 +0530
Message-Id: <20230222153251.254492-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
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
 arch/arm/boot/dts/qcom-sdx55.dtsi | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index a1f4a7b0904a..768d7d7f6335 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -303,6 +303,78 @@ qpic_nand: nand-controller@1b30000 {
 			status = "disabled";
 		};
 
+		pcie_rc: pcie@1c00000 {
+			compatible = "qcom,pcie-sdx55";
+			reg = <0x01c00000 0x3000>,
+			      <0x40000000 0xf1d>,
+			      <0x40000f20 0xc8>,
+			      <0x40001000 0x1000>,
+			      <0x40100000 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
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
+			interrupt-names = "msi", "msi2", "msi3", "msi4",
+					  "msi5", "msi6", "msi7", "msi8";
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

