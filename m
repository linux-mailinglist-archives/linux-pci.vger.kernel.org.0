Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4550C2E3
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiDVWTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiDVWS3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:18:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7C24E91A
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so11067631ljb.6
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xFeOtJuaV8reMhpK/AQiVQIOApHzYKJaZY7pKJ38rnU=;
        b=h4qH1Bs65mZuxO1vz/kPsc1KiE5EyIyPiTjIDhXV8Gpb9Y6nS4NUJIRNdNQrSvWyF/
         dY7b6XDNGNIr696Ix6ylgphn5GqPj3X3qZq2cQl1B1OgsCvwBpT7jc2vKoWO0xFrVPP5
         ilTfyGlt1EZnE62PMqgHJD4gDgFN1zB09+0v1cDfl/Y0ez5rJG7stkaJPMtpAWWvFEmP
         EHaEVi0vWOfDRwbG2kDPq6pPxoD6AWSaqUs2FZexEbDT+WaL+QwU3Vbmentk7oJ/yg0N
         SKBRgDiAcSjn65mQRbJ2+nptv39ydnWeFGZBuErzQAMAdHFZkO9Xfsl87/fOHYv4/Yh3
         hFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFeOtJuaV8reMhpK/AQiVQIOApHzYKJaZY7pKJ38rnU=;
        b=JMj9PkEbEgLKuGMecykazmGpKXzq4YOjk5RbOPhpNvNjJDeemCkMHLoGpg0QHut9ce
         FUEMFC1w3NKNjibADnVi7oUE2P4tz/3NhL22u3jgQPta/0zyndBateH9BMV0CrA0RVmg
         fdUYitjOh2MWBeqctjGwoxNhEd2o4yvTUz8mlvfg+CsagKhykZS35pX0OlDIA776gtMe
         jO/CAOv0CU/A+z/gX6F6gsGeZ6XaqNCBxpyEyt4lgUMNRdikjNHxCvtJYz6mprFAQXhy
         mzBDuWwhmWvlECSGonswByw5OMfGAmVrgXYsiwYeXGnbRRn+Y3lpYHlI/XnFavdf6OKz
         WlNA==
X-Gm-Message-State: AOAM5311dHCpToOyj0+KFhx0OBnPXfcc8cHA4jxAKTKc3VzjehMcnjx0
        Sb0KMjLli30rHYjPUHr9hTnfhA==
X-Google-Smtp-Source: ABdhPJyg28RMqPSrMIWUjzaPSwIMi3WXLYU4k0MRVsdya1CRl/JmbfpTSXDOdyK3bloCVljegeh+PQ==
X-Received: by 2002:a2e:8e93:0:b0:24d:ab45:4053 with SMTP id z19-20020a2e8e93000000b0024dab454053mr3782121ljk.231.1650661810160;
        Fri, 22 Apr 2022 14:10:10 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24d46000000b0046bb728b873sm351240lfp.252.2022.04.22.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:09 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
Date:   Sat, 23 Apr 2022 00:10:02 +0300
Message-Id: <20220422211002.2012070-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
References: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
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

Replace deprecated perst-gpio properties with up-to-date perst-gpios
in the Qualcomm device trees.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts            | 6 +++---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts              | 4 ++--
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi             | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi         | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts             | 4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index f623db8451f1..9fb33850e46c 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -497,20 +497,20 @@ config {
 
 &pcie0 {
 	status = "okay";
-	perst-gpio = <&tlmm 35 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
 	vddpe-3v3-supply = <&wlan_en>;
 	vdda-supply = <&vreg_l28a_0p925>;
 };
 
 &pcie1 {
 	status = "okay";
-	perst-gpio = <&tlmm 130 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 130 GPIO_ACTIVE_LOW>;
 	vdda-supply = <&vreg_l28a_0p925>;
 };
 
 &pcie2 {
 	status = "okay";
-	perst-gpio = <&tlmm 114 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 114 GPIO_ACTIVE_LOW>;
 	vdda-supply = <&vreg_l28a_0p925>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index b5e1eaa367bf..2d5ee337054c 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -54,12 +54,12 @@ &blsp1_uart5 {
 
 &pcie0 {
 	status = "okay";
-	perst-gpio = <&tlmm 61 0x1>;
+	perst-gpios = <&tlmm 61 0x1>;
 };
 
 &pcie1 {
 	status = "okay";
-	perst-gpio = <&tlmm 58 0x1>;
+	perst-gpios = <&tlmm 58 0x1>;
 };
 
 &pcie_phy0 {
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
index 07e670829676..3c0ac747de0e 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
@@ -44,12 +44,12 @@ &blsp1_uart5 {
 
 &pcie0 {
 	status = "ok";
-	perst-gpio = <&tlmm 58 0x1>;
+	perst-gpios = <&tlmm 58 0x1>;
 };
 
 &pcie1 {
 	status = "ok";
-	perst-gpio = <&tlmm 61 0x1>;
+	perst-gpios = <&tlmm 61 0x1>;
 };
 
 &pcie_phy0 {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index 3bb50cecd62d..b90000223d69 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -195,8 +195,8 @@ &mmcc {
 
 &pcie0 {
 	status = "okay";
-	perst-gpio = <&tlmm 35 GPIO_ACTIVE_LOW>;
-	wake-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 	vddpe-3v3-supply = <&wlan_en>;
 	vdda-supply = <&pm8994_l28>;
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index a80c578484ba..b067b9f95189 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -99,7 +99,7 @@ pms405_s3: s3 {
 &pcie {
 	status = "okay";
 
-	perst-gpio = <&tlmm 43 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&perst_state>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index dc17f2079695..461ba68fd939 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -362,7 +362,7 @@ &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_clkreq_n>, <&ssd_rst_l>, <&pe_wake_odl>;
 
-	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
 	vddpe-3v3-supply = <&pp3300_ssd>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b89d896..8abf8077be11 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -240,7 +240,7 @@ &ipa {
 
 &pcie1 {
 	status = "okay";
-	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
 
 	vddpe-3v3-supply = <&nvme_3v3_regulator>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 28fe45c5d516..1aadd5504631 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -502,7 +502,7 @@ &mss_pil {
 
 &pcie0 {
 	status = "okay";
-	perst-gpio = <&tlmm 35 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
 	enable-gpio = <&tlmm 134 GPIO_ACTIVE_HIGH>;
 
 	vddpe-3v3-supply = <&pcie0_3p3v_dual>;
@@ -520,7 +520,7 @@ &pcie0_phy {
 
 &pcie1 {
 	status = "okay";
-	perst-gpio = <&tlmm 102 GPIO_ACTIVE_LOW>;
+	perst-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_default_state>;
-- 
2.35.1

