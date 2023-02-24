Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A667A6A1AED
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBXLBP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 06:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBXLAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 06:00:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E8263A2C
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso2463906pjn.4
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xofzeZkvhksqMPAnkuhobq6bJN+LwPdywmpacr5C34Y=;
        b=bgyrhfTAmBvakCMxYfNhX+AmSzRAD2XV36FGGhVGNRWpChwP+kXgg1JXyysxFjz0/m
         uWPvQs9ZioXMchkG6Rabku0DGPo8zvZlBVIZnc9N9dhoq9HdmTD8rBUksEDkKlInG5La
         XBlvkRDARR0GkxWdFdKP1VV4C6Sy8UO/DOo75FcSvGrs4gEjUtxf5SW0Il0TCdo2f5Pt
         Ad8mTVVJJA+RG1L1ByUeds5ZwJgh123mANuou8Y/71VogivX+pqngBmd16fdkg8GBsvD
         y1ZNsVTIbzj7qGnJ4FDz0SKZtgmNvyHW95IYEAiMDMs60gIWRlP/Q8XS0iqo5t2gCgZ1
         vj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xofzeZkvhksqMPAnkuhobq6bJN+LwPdywmpacr5C34Y=;
        b=E/wZYenXniGISvvud9NFbckDJTX9D3FquyOe3cYZDgHtWQleLg4KWLeCfZP1N5yv1K
         Rf/gbi5r2ejAy7WOmjjGH/hc0UNvGh4qm2gbWSwhqNjg3N3MzK0RxSW4Ffk5x4cD822f
         ukHUfvE+UAGJt/hpGUnvgSDx4P6LraowoZWVhDdVaVTdzTr4/zP2QgO86otl1bYmDDlL
         3zjOCXwhuLjQl+wAUNk78AXOWYybLrXBqIHDUtBE1fatg5Vlgw3+6NolIehRlTo3z8RP
         Om5GHaqH5EPrJU5uLJI+eguswd/IniiNrkzZJ5hDP4yB8Am2Ttj8DiH9wWOk5xmz2Fvi
         N4rg==
X-Gm-Message-State: AO0yUKWWcEm7NpdY5uiJBe6PVDJUu3mgMV+P0cteE92HuOKLzIYpjr+1
        +Je89Sip+A6MUFUBp+n4iboX
X-Google-Smtp-Source: AK7set8VOGwZq+wLtaLaKo4UzZu8a/DJFEPGQ+qsSUZj5ZZZg1HsncU+ckHZEWO3OZyQHWyh/v/dgg==
X-Received: by 2002:a17:90b:4f8f:b0:234:f4a:8985 with SMTP id qe15-20020a17090b4f8f00b002340f4a8985mr17114120pjb.15.1677236393048;
        Fri, 24 Feb 2023 02:59:53 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/13] ARM: dts: qcom: sdx55: List the property values vertically
Date:   Fri, 24 Feb 2023 16:29:01 +0530
Message-Id: <20230224105906.16540-9-manivannan.sadhasivam@linaro.org>
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

To align with the rest of the devicetree files and the relative properties,
let's list the values of properties such as {reg/clock/interrupt}-names
vertically.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index b411c4ae34c3..61fdd601fc26 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -393,7 +393,11 @@ pcie_ep: pcie-ep@1c00000 {
 			      <0x40001000 0x1000>,
 			      <0x40200000 0x100000>,
 			      <0x01c03000 0x3000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "addr_space",
 				    "mmio";
 
 			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
@@ -405,12 +409,18 @@ pcie_ep: pcie-ep@1c00000 {
 				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
 				 <&gcc GCC_PCIE_SLEEP_CLK>,
 				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
-			clock-names = "aux", "cfg", "bus_master", "bus_slave",
-				      "slave_q2a", "sleep", "ref";
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "sleep",
+				      "ref";
 
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "global", "doorbell";
+			interrupt-names = "global",
+					  "doorbell";
 			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
 			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
 			resets = <&gcc GCC_PCIE_BCR>;
@@ -434,7 +444,10 @@ pcie_phy: phy@1c07000 {
 				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
 				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "refgen";
 
 			resets = <&gcc GCC_PCIE_PHY_BCR>;
 			reset-names = "phy";
-- 
2.25.1

