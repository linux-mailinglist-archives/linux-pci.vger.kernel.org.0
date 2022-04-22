Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20150C3A3
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiDVWTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiDVWS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:18:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122632B243
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 17so11108891lji.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5gfhqqfjatXbBteVPXIO9+6L0d8Um+h14mjmTgnTNw=;
        b=KBM1H6FRmOvGWz+HASYdwEsVNzwXdWi2Nek5sUoaELmMIHrDjv+nfMJxoR0wb4BMJV
         dKb6Dzc7GJq/UxaHFVlKHavCInoAMoLPSAgMfZHXlfqN4u2yiY6A1NukKOX8QYJHy51c
         RS4nUpLC/D8v7b9PCKHAiYCSR4i+6LRDxveP7AAnf0bXrTEvnlx4byb1+ekTE3/VGPTH
         HtYpW8420Y2MaBsnMN2qRxqZcVzHDTuXJkfchvV2nBWnj/8usfKaLPiIkUusOJ7Bjoa4
         Ms58qPZgYnzZhNjJOZElKIVWsAjnj3YGwj2tPrMQS8/xwf34E9wk3qzVEAYL1BtNwI+j
         oyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5gfhqqfjatXbBteVPXIO9+6L0d8Um+h14mjmTgnTNw=;
        b=qvLEXc854+K0zzscrwJRFkvyxW5v22D317awIaV+c0HQqaEG0Ls6GctWPTLfJiOSMN
         gYIifzV80pag9LxEDDAuUuTx66Mkdv2ZZO7xbYBESLPyTpk5ghJP3NaODm+5PCaB2dgn
         hf2ARztuWGBL9Dh17eWIlG2UNDssmnNlelwJjrMO/4IjAhhifzro8enCM74BQIZWVkKI
         V4UDBeL5A29KimV/zvSDOGhp5w0+HW5fVutazOR3giZE5tZUIoEvjuRED9GvulAU0yWn
         PeIKX4R2t4BAGOqnLDBxWWrgf4ONVLjUA2YM0LCbRbG4nYjS42VrYRvImZey2ERv7XBD
         vAqQ==
X-Gm-Message-State: AOAM5337IFqLH+OO999Obwg4KzkvXaQCfqaWBPUZnLXw98i34HE7GS1H
        cGe/n5cDAHrNEappw7YVDsstUw==
X-Google-Smtp-Source: ABdhPJwz+NOKGJrx6VpHjh5arxlOhJNPk6yDW/G9OueZX9q5+63+JzEdqTwGTQdtd2FxlR69K4JPHg==
X-Received: by 2002:a2e:808b:0:b0:24d:c2a4:3fc7 with SMTP id i11-20020a2e808b000000b0024dc2a43fc7mr3846655ljg.58.1650661807748;
        Fri, 22 Apr 2022 14:10:07 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24d46000000b0046bb728b873sm351240lfp.252.2022.04.22.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:07 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/7] arm64: dts: qcom: stop using snps,dw-pcie falback
Date:   Sat, 23 Apr 2022 00:09:59 +0300
Message-Id: <20220422211002.2012070-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
References: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
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

Qualcomm PCIe devices are not really compatible with the snps,dw-pcie.
Unlike the generic IP core, they have special requirements regarding
enabling clocks, toggling resets, using the PHY, etc.

This is not to mention that platform snps-dw-pcie driver expects to find
two IRQs declared, while Qualcomm platforms use just one.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f0f81c23c16f..b577b9046938 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1574,7 +1574,7 @@ agnoc@0 {
 			ranges;
 
 			pcie0: pcie@600000 {
-				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				compatible = "qcom,pcie-msm8996";
 				status = "disabled";
 				power-domains = <&gcc PCIE0_GDSC>;
 				bus-range = <0x00 0xff>;
@@ -1626,7 +1626,7 @@ pcie0: pcie@600000 {
 			};
 
 			pcie1: pcie@608000 {
-				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				compatible = "qcom,pcie-msm8996";
 				power-domains = <&gcc PCIE1_GDSC>;
 				bus-range = <0x00 0xff>;
 				num-lanes = <1>;
@@ -1679,7 +1679,7 @@ pcie1: pcie@608000 {
 			};
 
 			pcie2: pcie@610000 {
-				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				compatible = "qcom,pcie-msm8996";
 				power-domains = <&gcc PCIE2_GDSC>;
 				bus-range = <0x00 0xff>;
 				num-lanes = <1>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 3f06f7cd3cf2..2386081463e3 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1280,7 +1280,7 @@ glink-edge {
 		};
 
 		pcie: pci@10000000 {
-			compatible = "qcom,pcie-qcs404", "snps,dw-pcie";
+			compatible = "qcom,pcie-qcs404";
 			reg =  <0x10000000 0xf1d>,
 			       <0x10000f20 0xa8>,
 			       <0x07780000 0x2000>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b31bf62e8680..85dfa0842003 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2027,7 +2027,7 @@ llcc: system-cache-controller@1100000 {
 		};
 
 		pcie0: pci@1c00000 {
-			compatible = "qcom,pcie-sdm845", "snps,dw-pcie";
+			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c00000 0 0x2000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
@@ -2132,7 +2132,7 @@ pcie0_lane: phy@1c06200 {
 		};
 
 		pcie1: pci@1c08000 {
-			compatible = "qcom,pcie-sdm845", "snps,dw-pcie";
+			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c08000 0 0x2000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index af8f22636436..410272a1e19b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1789,7 +1789,7 @@ mmss_noc: interconnect@1740000 {
 		};
 
 		pcie0: pci@1c00000 {
-			compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c00000 0 0x3000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
@@ -1888,7 +1888,7 @@ pcie0_lane: phy@1c06200 {
 		};
 
 		pcie1: pci@1c08000 {
-			compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c08000 0 0x3000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
@@ -1994,7 +1994,7 @@ pcie1_lane: phy@1c0e200 {
 		};
 
 		pcie2: pci@1c10000 {
-			compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c10000 0 0x3000>,
 			      <0 0x64000000 0 0xf1d>,
 			      <0 0x64000f20 0 0xa8>,
-- 
2.35.1

