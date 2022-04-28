Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7855132B7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbiD1Lo6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiD1Los (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 07:44:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A4D68F99
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so8114237lfa.6
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDT9kSu3JZdpsuMm2x+UDGGY32H0TbkhH7Wl08ke45c=;
        b=zKDQYn2dyuv1MqpS6HuJEclQWZTP8lHuhBmSDFOmTHIcLid1gMRwQ53KkbRKt1QKDF
         qsx6Px7VLJsneHMNNB/4lxBHvPXNMGe/eS0hYmhM+yAQA+1BgR/0NbZTs9/R7B/crPAB
         t3jmPjnXTBJf8nKeI4+5WtXB88mr70qaMqDx1cGV92rJuPq2sOUubL0J3DEaYvmwkOBB
         9pKPXawtwv+0csU0vlawgLVH8EbDFkTaqqAC2Q/nIwgJ0v9GzbCRaapF2jpLch7nxkOX
         ZdNuXn7etFZKSNEIIj/ucz1uc/lRq4khff+Tp+r5GQatoplDjChB7AJaUT3BX9069fRD
         ky0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDT9kSu3JZdpsuMm2x+UDGGY32H0TbkhH7Wl08ke45c=;
        b=Wkft4RJ2dURFmGsxtXyuSq7oY/U54X5HE9nYodPd0N0nXd20jr7d7AchuuuXPgudmo
         YaSgQPOjY/HWL63CfKOAd7kCPvztzY1/yyG/0215RabdI6w4OsOPOgAIG9sxDxj49T8Q
         EOcHPTWo/nxl9kMDkjgGU1MqrngEjTiBlEM2c8EKiw1opGyhxIHiAxTNUo0FFj7zr2Pl
         ytgEbX8DRx49CIM3TVsOr4O7YuCE97tRKNG/oLAgwONfsXl8MBye+5mPpvpLnJhjkvdh
         yDhUfCxesXj5d50O0FAX3sus/38VZxOmH0PMUPxb7mPF8QPtWm449Fw++f0tQo3718s2
         KsEg==
X-Gm-Message-State: AOAM531owIvbscOY2Y/NNp8vP5KoRC9T7cKa6rgDIZmOn1QxCAnPJI5S
        J/T7oi+DeoTPRkTEHQ3QBsjbdw==
X-Google-Smtp-Source: ABdhPJx51rL9koaRDPK59rXD7IEKjVx4C9XLhwYta1f3O4Vg62yyqC4u70WUq73uTa3Onhru8XimCQ==
X-Received: by 2002:a05:6512:2622:b0:448:27b9:5299 with SMTP id bt34-20020a056512262200b0044827b95299mr23598116lfb.86.1651146080622;
        Thu, 28 Apr 2022 04:41:20 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm2338790lfb.302.2022.04.28.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:41:20 -0700 (PDT)
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
Subject: [PATCH v4 7/8] arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
Date:   Thu, 28 Apr 2022 14:41:12 +0300
Message-Id: <20220428114113.3411536-8-dmitry.baryshkov@linaro.org>
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

Replace deprecated perst-gpio properties with up-to-date perst-gpios
in the arm32 Qualcomm Snapdragon device trees.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts     | 2 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts      | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts | 2 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi             | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index e068a8d0adf0..160291c5ebeb 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -215,7 +215,7 @@ pci@1b500000 {
 			vdda_refclk-supply = <&v3p3_fixed>;
 			pinctrl-0 = <&pcie_pins>;
 			pinctrl-names = "default";
-			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
+			perst-gpios = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
 		};
 
 		amba {
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 2638b380be20..8b1d540a5f65 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -285,7 +285,7 @@ pci@1b500000 {
 			vdda_refclk-supply = <&ext_3p3v>;
 			pinctrl-0 = <&pcie_pins>;
 			pinctrl-names = "default";
-			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
+			perst-gpios = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
 		};
 
 		qcom,ssbi@500000 {
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
index 7a337dc08741..872f64a12047 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
@@ -100,7 +100,7 @@ m25p80@0 {
 
 		pci@40000000 {
 			status = "okay";
-			perst-gpio = <&tlmm 38 0x1>;
+			perst-gpios = <&tlmm 38 0x1>;
 		};
 
 		qpic-nand@79b0000 {
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
index 06f9f2cb2fe9..ab1835b0fe40 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
@@ -10,7 +10,7 @@ / {
 	soc {
 		pci@40000000 {
 			status = "okay";
-			perst-gpio = <&tlmm 38 0x1>;
+			perst-gpios = <&tlmm 38 0x1>;
 		};
 
 		spi@78b6000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..fa67cb6adcb8 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -842,7 +842,7 @@ pcie0: pci@1b500000 {
 			pinctrl-names = "default";
 
 			status = "disabled";
-			perst-gpio = <&qcom_pinmux 3 GPIO_ACTIVE_LOW>;
+			perst-gpios = <&qcom_pinmux 3 GPIO_ACTIVE_LOW>;
 		};
 
 		pcie1: pci@1b700000 {
@@ -893,7 +893,7 @@ pcie1: pci@1b700000 {
 			pinctrl-names = "default";
 
 			status = "disabled";
-			perst-gpio = <&qcom_pinmux 48 GPIO_ACTIVE_LOW>;
+			perst-gpios = <&qcom_pinmux 48 GPIO_ACTIVE_LOW>;
 		};
 
 		pcie2: pci@1b900000 {
@@ -944,7 +944,7 @@ pcie2: pci@1b900000 {
 			pinctrl-names = "default";
 
 			status = "disabled";
-			perst-gpio = <&qcom_pinmux 63 GPIO_ACTIVE_LOW>;
+			perst-gpios = <&qcom_pinmux 63 GPIO_ACTIVE_LOW>;
 		};
 
 		nss_common: syscon@03000000 {
-- 
2.35.1

