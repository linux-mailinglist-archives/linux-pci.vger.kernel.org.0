Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98DA5035DE
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiDPKHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDPKHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 06:07:41 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB1926110;
        Sat, 16 Apr 2022 03:05:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id bb38so7278604qtb.3;
        Sat, 16 Apr 2022 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=NmjECRbNdaTFdptYyv+cT8YO6KgWYqyiRjn3aibeKUp3EQBDD2NcV7OofgJP2t2wbn
         b/QBiZJE8xdXANqH8Llqmsfk6O9PjONhNiud9k+vIsEjDwI84M8k2Zs+GRJGU5Tgxyhy
         7CiChZMI32Q5LN2AsKPvze7zl2ays10WvBPyDnxAJ28McIjBawpUrYoY98AhWJTR3ACL
         /XZWzzYUuhkNgUig8mEYWTCzp5PxE1ZYJRZYL+mTnzVzYvHUVYq4s0kTT8HtA0qUUTNq
         oTOU1owRZUzDqWotkBnovzJUlJvHs69w3of/oe+pDVF4x1zcJJXWQECiUiHjv17NG+af
         5uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=GlWCV26AwpMfXZwLLHlFP09cnwUdPp6ektj/MtV7XxCewlUYLB0SWqpDOZ94HM25Kc
         oszp1GkKaaKq3Je4OA6MqpXLmdxhcbIupzZCRj/kApRMxUWSqS/zPtge+Slu3NSZKgCy
         iTJFfrgkmIQqMMYqvM4wBUNLGgZpyJEOEi9TJja4EmxFU+ZSX8EX1lieA/p0yPyDitcM
         oWOWynKMn1oU6f2kNMZ82HqRWXCvVyREG8OWbvvRvMXsV7qkRAvBIEWrar2ZzgkPHzlm
         ItXhrGc/3udkI+z/vqzfE81G02Xb7I3UXhFS5osC1fEdWJ3ViPSIYG8mBGSO8mmvj4Kz
         fP/A==
X-Gm-Message-State: AOAM531Zb6wE/ABWxZVVYLRsPEMYbBrxANclOsrz4XyaOnCGeaYpFEj2
        sWBoN9IStkPhHhGYsDOZiqqXJS4p6P1oIVMt
X-Google-Smtp-Source: ABdhPJwAIjr/Op2S340fMuRIJSZECSC6mxe/6hv16S1HahOfF/1ErIjyLEW5iXethYJhxZJ5rm0X2w==
X-Received: by 2002:ac8:5855:0:b0:2eb:87af:ab50 with SMTP id h21-20020ac85855000000b002eb87afab50mr1822539qth.406.1650103508262;
        Sat, 16 Apr 2022 03:05:08 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm4263188qtw.67.2022.04.16.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 03:05:08 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] arm64: dts: rockchip: enable pcie controller on quartz64-a
Date:   Sat, 16 Apr 2022 06:05:02 -0400
Message-Id: <20220416100502.627289-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416100502.627289-1-pgwipeout@gmail.com>
References: <20220416100502.627289-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the nodes to enable the pcie controller on the quartz64 model a
board.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 141a433429b5..85926d46337d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -125,6 +125,18 @@ vbus: vbus {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	vcc3v3_pcie_p: vcc3v3_pcie_p {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_enable_h>;
+		regulator-name = "vcc3v3_pcie_p";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
 	vcc5v0_usb: vcc5v0_usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
@@ -201,6 +213,10 @@ &combphy1 {
 	status = "okay";
 };
 
+&combphy2 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -509,6 +525,14 @@ rgmii_phy1: ethernet-phy@0 {
 	};
 };
 
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+	vpcie3v3-supply = <&vcc3v3_pcie_p>;
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -534,6 +558,16 @@ diy_led_enable_h: diy-led-enable-h {
 		};
 	};
 
+	pcie {
+		pcie_enable_h: pcie-enable-h {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie_reset_h: pcie-reset-h {
+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.25.1

