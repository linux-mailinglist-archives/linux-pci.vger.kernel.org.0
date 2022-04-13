Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164A4FF7CA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiDMNk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiDMNkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 09:40:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE605F261;
        Wed, 13 Apr 2022 06:38:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id d9so1605547qvm.4;
        Wed, 13 Apr 2022 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=QVWku54j+UAXoEMpnZ1vv7gQuCMEln37OGTReSXY+KDFySd2yXriskDocWaYYDoi16
         R1DEchhdtrw58TIj16nF4Dake/0VNdzRAcLysRzLCKefxLPM+NTyY1AnatI3Z8J6kf6P
         nzAdeh7SEeO5UvvljFB+hk7xxCTMbx6F15dTzaYRd9NzML2taBWSDbEao2JJ2VQxwufs
         +sq/41Pb95oMjpJ11dOfj9VP7pD4a21gDC7qdQIEYIPfyUQwAzWOWkE1AMOmowxi0lPh
         FSUGLYWqw6tZQDkzeuReqlLMOoqQUaRqXJx1vlfO71j0EoccWOCwE6Cu8pOSnqBKDcaL
         lGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=Xa9LBvrrT47OcL0fCzyN2jh/O/XAV41/n33t/tKvx6DQwrHdQzmroVPHc0F1GoCfjO
         m0OsVvWw1IUT8TvYqLNpsSFlmtriK1QfElBOCb8DKOu5mbB6EpWELi+B5yfvJ9P0pODX
         qVtjgc0sC/BNyWgBs4OkBdeTwCJZwacjAg6JCyyLroBSGsT0j2qHuuluN4naLJSxqLNV
         bSTjiOQL89QOZ38yNOCIeEmLAklYaj28z6pUSloWO+gMog9Q5TJLX/pmO33QRZRB1Hib
         x7F1yrH6XcLNgK2ZOoJPYhOEW/IqVAs8nKe6ZN597ItWPqlFTJd9sW2fA0WeMSnt6J17
         U51g==
X-Gm-Message-State: AOAM533jzABwSlqyq3e+kfCbh/z02525YpTuyfwHJJ5L0S/RBA7Ssktp
        UCZ9BeqrVoSxsSIX8Fb4liIQyY/v76sHH8Cp
X-Google-Smtp-Source: ABdhPJxvhXF0hMoO3IPsR9ctAISTuf1qYFUU0vcqTreM1lIvwx2wqzJSVw45r9E3LRkANSxrLVws9Q==
X-Received: by 2002:a05:6214:e4f:b0:442:88d4:ecc0 with SMTP id o15-20020a0562140e4f00b0044288d4ecc0mr35807143qvc.47.1649857082566;
        Wed, 13 Apr 2022 06:38:02 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 143-20020a370795000000b0069c59e1b8eesm790584qkh.10.2022.04.13.06.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:38:02 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: rockchip: enable pcie controller on quartz64-a
Date:   Wed, 13 Apr 2022 09:37:31 -0400
Message-Id: <20220413133731.242870-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413133731.242870-1-pgwipeout@gmail.com>
References: <20220413133731.242870-1-pgwipeout@gmail.com>
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

