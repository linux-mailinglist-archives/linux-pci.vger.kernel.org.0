Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B218450D1FD
	for <lists+linux-pci@lfdr.de>; Sun, 24 Apr 2022 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiDXNXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiDXNXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 09:23:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7EAE64
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g19so21944399lfv.2
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg1LPvr7CNmKtgBxGFEj5Vun/S0D0osu3a6EbDsk4vU=;
        b=jFvKfXj/9p7I4xMSNd9bJpzql//lURk4aUm+4lYHcMAq9PeVjBFTdzM4/Uev0XQR3X
         hQXi8CcA1KMfZXcQcF2zCaTw6DhnGzf/fWU//Y3uB071wSahEXMdjht4/WF8gn3nfEiR
         Uw7B5MK1OawxACK19WHIIHXr85hOHJAqw2K1+gN+5qzWwfHZHGosMqqT31ZzUDcG+ZDH
         z1VaSyOPMzGvhPtXySA2el/qmBWpcwe6OIknLqNwUyALhEie3AC6f7MX8z/YPizrq3xE
         ihm8URYld6PC1bUX43+1rLiyrM/pfWD3u5NUT2g8lJFn1YzpplBlADe+NtmM6AH0Fhg/
         Dq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg1LPvr7CNmKtgBxGFEj5Vun/S0D0osu3a6EbDsk4vU=;
        b=HRfnO2svxeZU4/mk2kEjDu+kV8kD3CvS5fAUyy4Fx7A3iDaLunNXAq/xNX8+3TNYNq
         lcfbfzIxXgmSd0+4S49pKATx6c/oJtRjpFfh5NSOxbjNNr0IFhQ5taaS/4xzzZHoVcNs
         BtitPAeJ023G0/Gnv/WjvfACmboKG3KfzGC4vVSzBQtozZ7UOlo+EEtqJ6M9wtk1H8E0
         2V3ECWrclikyJe+mmpqipRMO7HuIXokMtm9F3+U1HGkD3Xz/byISQPpvQwxCIvHr8mO5
         1QAUl54YmudWReukF7jq2HrM7ly7un7EvuKE/LI4YlmDl/WRWAYph1Tnxdfq24eKkaXD
         VUow==
X-Gm-Message-State: AOAM532cwT0rFAdNGvjYFYyaQLJUWWXvtvlXLwDqxRpGkuPXTGveQ+kU
        de93bevEpTEa/ygS0VqIC0OOxA==
X-Google-Smtp-Source: ABdhPJwHabdj+YRrucPH4fDFwz18jeZ8gf+S++wFqmX+XKee6BhOQ4BY6KWNkOOPjFPdQd5wxbZ3/Q==
X-Received: by 2002:a19:505d:0:b0:46d:167e:b9df with SMTP id z29-20020a19505d000000b0046d167eb9dfmr9970542lfj.184.1650806441983;
        Sun, 24 Apr 2022 06:20:41 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512332c00b0046d0e0e5b44sm1015877lfe.20.2022.04.24.06.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:20:41 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 8/8] arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
Date:   Sun, 24 Apr 2022 16:20:34 +0300
Message-Id: <20220424132034.2235768-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
References: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

