Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C054851DBDB
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 17:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442778AbiEFPZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442767AbiEFPZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 11:25:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF76D19E
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 08:21:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b18so13150393lfv.9
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5gfhqqfjatXbBteVPXIO9+6L0d8Um+h14mjmTgnTNw=;
        b=Ya9qO48DGhMXm/gW+ajeFvW2hDujyOS41F0JSWPVXf4HGHCo7jF2z5ZqLAIk1/klkR
         O7mmOUrZw+wlIe3c/fDFEG2cyLKGMXr/YLP5tfqGLnAe1qzKdJHyMemW+oJ4cr20zIUW
         P8hvJdq7jpxrF1PCtEyqqri/l0iWzQS1HZTk6m1Vi4Ioj65YPwlQl4AT4k1a3vmEX9Mt
         rVKEA4jl1yQKY+YmEAvww22XXoFD5HUOt1ymAo1vlJA8f5+Vy2x59RjyUE+Q8CSLtzZs
         /IPlnpQoG+k3fHjrod0d7+1VhPDl5p4hxpCje3Rn0ZLZ2ZVKea4ALcU/tecQe0e2G+CY
         X9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5gfhqqfjatXbBteVPXIO9+6L0d8Um+h14mjmTgnTNw=;
        b=KWxUvAG5Fo8c9ANmeZuNg2p45djBw4LzADd802qJi3FIz7oI4IJ1pSrUffQ1N2qyIS
         YytogWvWY85LqFbOOkGDtIfjE3jIyWinI6UCkmxPh2Zxa+PDpCeu3zbkCs8WKak7tIjt
         FcIBgKMpsnbmOQjvgqLcvToD5s9SlEiAeTV/B1hZa2obvFoihufe/fBqbuFZq6gYVn4o
         lKU5IVH+M+wGIjEn5OsBxbyOd3qkOi1vxLMk+ehWlo7IYWptgmG2BB6hy0fNRgylaxdU
         nUVxzZPyHK0H3l8RuEq7K0LZWI7cOCUzhQmqr79xxcBMbjFTH35AozABp80oBqFU9P70
         dLYQ==
X-Gm-Message-State: AOAM530+Zei3dl0uIy8ENnKwwLMpeETTXgdbf8ntYlAF82hiwjie+L/Z
        xuZWLtfQFnzIQWvKdhpty2uRig==
X-Google-Smtp-Source: ABdhPJx0PGnOLYskJkuaG0wmDdY1hsuY9dPvUCXSeaIYPhfbvK4/HOl0YjtG2ngZioUZcV8j/at/vg==
X-Received: by 2002:a19:2d57:0:b0:472:1867:79f9 with SMTP id t23-20020a192d57000000b00472186779f9mr2802662lft.483.1651850473297;
        Fri, 06 May 2022 08:21:13 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0047255d211e6sm716757lfu.277.2022.05.06.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:21:12 -0700 (PDT)
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
Subject: [PATCH v6 5/8] arm64: dts: qcom: stop using snps,dw-pcie falback
Date:   Fri,  6 May 2022 18:21:04 +0300
Message-Id: <20220506152107.1527552-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

