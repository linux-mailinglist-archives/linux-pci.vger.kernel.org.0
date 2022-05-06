Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10EC51DBD9
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442807AbiEFPZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442806AbiEFPY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 11:24:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6B96D188
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 08:21:15 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t25so9662803ljd.6
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDT9kSu3JZdpsuMm2x+UDGGY32H0TbkhH7Wl08ke45c=;
        b=EyXIqAhiBsCP+j5gUJptVU9jTVYp0N8rYXvrWknAR5kHzCOIP3o/pRWXARyf7Q0pF+
         oKche5hbrZkDsie78ASKF65nzhibvpfVAQ2NKJ7EbyyPWi0v1zWE8/V0Xs2r1b7Az+tl
         8R+CSv7/fwctNaiFw/HVd2tCGyuqv7vTxOR8FWXv4BMCBCtnkMmYYBF47M201rfUUYS4
         IEnzcfxQizmmXShdPqtyqzovjYuxzrmFmEs/7w6K+t0f7zQm/pgX9a9/u5fb1FryTeLu
         /EdmjTALx/WgT9MTq/Jyeui0+DbVdlQqCLyZQLwZ1sluFPDwfoRY/R6BkAMQEXJzEGyM
         Q6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDT9kSu3JZdpsuMm2x+UDGGY32H0TbkhH7Wl08ke45c=;
        b=B3TH9KRFoZlAzJwMzpt+jl50E8Ia5otkCrZIw5/Kn2uimaCUF5GQvEBolE08NMxivC
         40Hdmbs9NGi7+KdawH616865Kdjx2+5fyy57/3q2zoDOHfSP86M5K86zxSteh/Mn+rGS
         QdJJd65/JKP8ZcU+jTKGTeIygjMyjG0eGLqDMTNJt9BHgjSW0PJM3E1RicfsE7wE+Umb
         9yTDMuE5Bg9cHf+UOqAlBglGRow0TmxZ8hLyQYpp8nHpHcyzUaoQKAJ1TlI0sDzvgc/E
         IVBTtO81ZlgKwrImXk060Iin//oyHhGGlifePMj0q9Y5+rmrrSQm6Uc0sbhDOueEeIsO
         9fLg==
X-Gm-Message-State: AOAM533crpQcBLb08P9nyHswh02EBTHdRdzhoLiSe4ZStWB/tQg5KAkM
        lL+Y8qD3GlTzUpldLYOucHJHYQ==
X-Google-Smtp-Source: ABdhPJzCni7dzuiEqaWqvGgB/Fc9qSfWv7Fh2gccaAlWwcsZ2UTYkBsRakJlLeEFG7AenE2nW6fn/Q==
X-Received: by 2002:a05:651c:2112:b0:24f:4daa:6c86 with SMTP id a18-20020a05651c211200b0024f4daa6c86mr2327949ljq.113.1651850474790;
        Fri, 06 May 2022 08:21:14 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0047255d211e6sm716757lfu.277.2022.05.06.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:21:14 -0700 (PDT)
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
Subject: [PATCH v6 7/8] arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
Date:   Fri,  6 May 2022 18:21:06 +0300
Message-Id: <20220506152107.1527552-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

