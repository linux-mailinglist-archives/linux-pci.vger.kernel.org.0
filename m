Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAA5132A2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiD1Loz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbiD1Lor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 07:44:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364D6689AE
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h29so846043lfj.2
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5gfhqqfjatXbBteVPXIO9+6L0d8Um+h14mjmTgnTNw=;
        b=SY37zWLjYyOjB4jec9q37BkMFqXfmRPHcC+IIrsvrQtTXExse1e0kznT1TboYYHNxk
         KXP0ToVNQp7vgXVlUfHwl4CM6YZl28RwmWUjthgs6ehLsY5GW6V4YIvCf5/9ZsPMMrNo
         ZcEUarN+6UuzrzvU7JD+BX8t+560S/8sUhDhxMv/TMaGSKj/svxXjciJBAZBOr9q+Wa9
         vqYDqJpIs2ykeLm+taXKPHmU0eJixdz+Z5OppCvgPClPn5I9DLzYx9VdUgarTcUDf+QE
         J8Asp9WTGnFFHvESqMknt1Zqumz2auvzjJoO0GzORyTYDUj2Kv2yEaxOzBzcS6wuLrBp
         O9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5gfhqqfjatXbBteVPXIO9+6L0d8Um+h14mjmTgnTNw=;
        b=J+rJ7NoSFonkcvJ56TDUkhBftktS9h57aOGhGd8O+FipX55vLCWHNUVOeIlGlXsleX
         O+h4zGvZBfWNiJVACXJUzbxlzGv4IjRwATUdLd7vPLExcPoAUEhFsxSRyT4ReF4tGERR
         KiBMsCUyLN99mAHC5xStn+LKWLiFZL3fRPYj/c3/nnVZ6tmRLA6V4alN42dX/A0f4yJy
         Vx3JV5CRBTTNwmEKKgBTbOFooWIftQmc7cEC9DX1tpPencFTRxweallgqMi0YujIWFqL
         +Glayo5+8h88gVD6LGGWdFlL4iY0iMey753H7rZ/7TevuequftbV5tZFLm7vbFbvdIzc
         kKKQ==
X-Gm-Message-State: AOAM530quPpd8qNw4cWuVYfv10sOIjReH3oMzzGeHZiROFEcIytyNC9y
        OJkUHf0MM8vxBoFXPHNV52gkWg==
X-Google-Smtp-Source: ABdhPJw9367Al7oVxb/7kGKlapQJ/DuEdpzZHmpDbFF/MlcVsyL2QMTtYW+71aHpKpAOEoLsbY2lEQ==
X-Received: by 2002:a05:6512:1287:b0:472:2646:88c9 with SMTP id u7-20020a056512128700b00472264688c9mr6863110lfs.169.1651146079105;
        Thu, 28 Apr 2022 04:41:19 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm2338790lfb.302.2022.04.28.04.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:41:18 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/8] arm64: dts: qcom: stop using snps,dw-pcie falback
Date:   Thu, 28 Apr 2022 14:41:10 +0300
Message-Id: <20220428114113.3411536-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428114113.3411536-1-dmitry.baryshkov@linaro.org>
References: <20220428114113.3411536-1-dmitry.baryshkov@linaro.org>
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

