Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01656A1AE1
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 12:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBXLAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 06:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBXLAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 06:00:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E8A26CD4
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso2290923pjb.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWzirrIvAlApajl/8IV1ns6ZR5N3zHdUYEWFW4EUTxg=;
        b=WgOeZtrMpNQF82N0RyIc81DA7VMhg2aTHO705wMUkzAOKMcpPDq4HnFy+6rJ79goQl
         XNaMXIDP0Dt9f9O4gKyK5whJQajwOWI4heuAtMtu0MHIFvQMjxIB6o2qm3iu0+P3NuoT
         iCr3q7PM0ssSOC1j7dlYZT5IeubFl+m/ew+OKFzWDK+N+5+c/EttEfavRQozx7z+Ur9s
         o06VmypjZOtiMx9hOaHGxCu4Bnk0vutR2HNR/3yC3dIjqNmDvjuYzTqGuRq5tsr6K5Js
         XHvbuWZQoS9UQRGDxo8tpJnceeWCyB59Cp/Qw874Yuxc4HwOeQ3MgLuw+FUmlSudVMNT
         AhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWzirrIvAlApajl/8IV1ns6ZR5N3zHdUYEWFW4EUTxg=;
        b=GuVsU6OtF2+lt1KVT3xGjnVjunaXWffwvD59YYd7oxPLD9eP2m3O6NgTX8GyegxXdm
         QcpXxHw9Trm+V78nDTCFqONW4YXYd2SKxYA0SXAqUEizL+JXZoEK7SnbkmuM9Pws6K0V
         RBf7l/fvvlp5SmlXPlHinmY/4MsZik+OsBOS9a8+ek7eE/s/FhLBhttVfNTmv1lVK0TB
         jnYDgpt8VSKe1LuSYRTIfnN+5CWP42FghbS870B8HLehaXXjfCbVVkojneUphzecR/9n
         QOFRwxdMw55j/U+HXrEjftpU31oxbKrf9dRa1U2IRHNEYOX/5tdhQqMjtVqXQZerUtIK
         UT5w==
X-Gm-Message-State: AO0yUKW6Me6HyBCY7S07rGtdEzj0aNyLOjLawjlNiwpSTrMBxW4Ngp3r
        2Cne1KOS+9KpzwBhFtcUXFOJ
X-Google-Smtp-Source: AK7set+l3dhsbG5Ta+Ua0gyUgpw/rOM23btJEBVdGna8A6wwbUpMKgPonBx504ritBoktuwXOwg9CQ==
X-Received: by 2002:a17:90b:4d09:b0:233:b849:7e79 with SMTP id mw9-20020a17090b4d0900b00233b8497e79mr18207543pjb.4.1677236378979;
        Fri, 24 Feb 2023 02:59:38 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/13] ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node
Date:   Fri, 24 Feb 2023 16:28:58 +0530
Message-Id: <20230224105906.16540-6-manivannan.sadhasivam@linaro.org>
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

Unit address of PCIe EP node should be 0x1c00000 as it has to match the
first address specified in the reg property.

This also requires sorting the node in the ascending order.

Fixes: e6b69813283f ("ARM: dts: qcom: sdx55: Add support for PCIe EP")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 93d71aff3fab..e84ca795cae6 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -303,6 +303,45 @@ qpic_nand: nand-controller@1b30000 {
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@1c00000 {
+			compatible = "qcom,sdx55-pcie-ep";
+			reg = <0x01c00000 0x3000>,
+			      <0x40000000 0xf1d>,
+			      <0x40000f20 0xc8>,
+			      <0x40001000 0x1000>,
+			      <0x40200000 0x100000>,
+			      <0x01c03000 0x3000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+				    "mmio";
+
+			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLEEP_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
+			clock-names = "aux", "cfg", "bus_master", "bus_slave",
+				      "slave_q2a", "sleep", "ref";
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell";
+			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_GDSC>;
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+			max-link-speed = <3>;
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		pcie0_phy: phy@1c07000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
 			reg = <0x01c07000 0x1c4>;
@@ -400,45 +439,6 @@ sdhc_1: mmc@8804000 {
 			status = "disabled";
 		};
 
-		pcie_ep: pcie-ep@40000000 {
-			compatible = "qcom,sdx55-pcie-ep";
-			reg = <0x01c00000 0x3000>,
-			      <0x40000000 0xf1d>,
-			      <0x40000f20 0xc8>,
-			      <0x40001000 0x1000>,
-			      <0x40200000 0x100000>,
-			      <0x01c03000 0x3000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
-				    "mmio";
-
-			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
-
-			clocks = <&gcc GCC_PCIE_AUX_CLK>,
-				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
-				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLEEP_CLK>,
-				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
-			clock-names = "aux", "cfg", "bus_master", "bus_slave",
-				      "slave_q2a", "sleep", "ref";
-
-			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "global", "doorbell";
-			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
-			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
-			resets = <&gcc GCC_PCIE_BCR>;
-			reset-names = "core";
-			power-domains = <&gcc PCIE_GDSC>;
-			phys = <&pcie0_lane>;
-			phy-names = "pciephy";
-			max-link-speed = <3>;
-			num-lanes = <2>;
-
-			status = "disabled";
-		};
-
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sdx55-mpss-pas";
 			reg = <0x04080000 0x4040>;
-- 
2.25.1

