Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E55132B6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbiD1Lo7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbiD1Lot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 07:44:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219B69284
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w1so8114770lfa.4
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg1LPvr7CNmKtgBxGFEj5Vun/S0D0osu3a6EbDsk4vU=;
        b=d1JNUpPFqdyqSgIH+N042aPoeNpvS9ZLEC6QG5U+eqR3h5Zmi/PVfC3gPkCKQ60f7A
         0Yx5bHBRs7fin0tsVwRwFH4CDrleT9xN8BKe/PhPaC2ZTZz/W6crxqRTWksPJSwXL5Xx
         gwbfM4zRtlDy8Cf5zjNHXb/RmmE1iErae/abfiYJg+jcjNdnR4MaMJtq5IG8SEbliMJK
         iUsLrbXwi+iQb4F6ZeRNungPHfcnv//Z5O8Cmg2LPFaEs/tgzwAGZ1isxo3ICOfmiuh7
         D41A2wHxGlspwodH0ZtTRK5mkkRXbOhBousybyBvAIekpOEvZbXIwVhHhhfkckQM/7yr
         ITpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg1LPvr7CNmKtgBxGFEj5Vun/S0D0osu3a6EbDsk4vU=;
        b=6i9rhYljAOAxfdzdQ7bmqhNOLKjxZBMpWo3oMzXRGu8tprh6A4b79zoqT0HvnO4ACC
         ESM8yASREpr81R9x3843/R7tSo1l8ru3szjxEVc/htDcKz+FPK4Ggx/fujqGM/RDsPJ5
         cbR62GHG0fOMVrHQfKgWh6K9wZHQiE23X9MkJroktucgAU3/8ewgs1m2ejGH0GZ2t8kH
         fmsMeqo4+ohHmEbrLeBx+NyMbmvwyDpjr3RCqJuKkh9LxWSNxN6cE9Asl+AMZOSJzN9U
         MAGsJT8djGrS5qZGyfKKEpW3/CkFCQVElYT6+EM7yKx8vBhXTbn8ee3TmeHMMD2JBDrJ
         qphQ==
X-Gm-Message-State: AOAM5331ie+5YdKtWCKE+tYlf2DUzmy2kKwAJ2wX7dvBg1EYKFksTJ+N
        EJWQ6hbafQAv0cfOfLHAw2Er9e5mLHf0Ww==
X-Google-Smtp-Source: ABdhPJzyBCYsLoS4Ofu7FN0YWK8ZuH4Wqpx92SQJlAdxRmLON+EdrAIAq9ehmwOURMT/g59BIoLN8A==
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id h19-20020a0565123c9300b0044b04bac334mr24006588lfv.27.1651146081363;
        Thu, 28 Apr 2022 04:41:21 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm2338790lfb.302.2022.04.28.04.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:41:21 -0700 (PDT)
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
Subject: [PATCH v4 8/8] arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
Date:   Thu, 28 Apr 2022 14:41:13 +0300
Message-Id: <20220428114113.3411536-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428114113.3411536-1-dmitry.baryshkov@linaro.org>
References: <20220428114113.3411536-1-dmitry.baryshkov@linaro.org>
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

Replace deprecated perst-gpio and wake-gpio properties with up-to-date
perst-gpios and wake-gpios in the Qualcomm device trees.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

