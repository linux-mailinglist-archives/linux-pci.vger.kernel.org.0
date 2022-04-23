Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4FD50CBC7
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiDWP1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiDWP1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:27:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630A35DDF;
        Sat, 23 Apr 2022 08:24:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o18so7562261qtk.7;
        Sat, 23 Apr 2022 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DB27knfDqQc7OD0leI6JmLLgT8Ml329OWNhxU2Af7WI=;
        b=V8Ya5SEin/5zgbYymNln3A+hUT/anyCJ1fnyD17zBLO17TQ74WliCoBmaeGiCG4OXO
         8F3JWIHBR5EvaNlpP62NmBJqNTvnC8ke21pI39iJRqZMdNqaoFVGLfsJXBGt0q1galOl
         0FpPTXf4fCwgWjgx0vpmMBSREtgn4o4OFLwHKklq/eq43A1eF9MU8Ssh52jRbp3tPMbs
         KL0nLbjUuM/AzfqyVRtdAjGbeiTyQZKm6z6AUeZeV82wuw40IOGY0YM73AFQHJKamgua
         b45Z3yNhEtB7ObbJ+T1HpaT0UxBszaHaNhx+/iQC8/7EWVi7eFj/V7phkzF1j8ZfUkMA
         0iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DB27knfDqQc7OD0leI6JmLLgT8Ml329OWNhxU2Af7WI=;
        b=LkvWUBVO3Ly9CccC6b4VAVOcarVHx1EjHHdFvwD2qPXeSezTnpEaemiyq8kOAObwsa
         JnUYxWKAWl+JdLG94OadiSUZQNPF7+7DeZQr95LEASGWfLyRweuvWEdBfnNwY4hZXYbl
         vvlyqFVvlk5V9K2FgB6G3IKEgWU0WT/ZXUHdMVilloEdlSFg6skN4LN6G8KjBvvGBUK5
         4BZnKicxV3LfHYG6sJeESWC/baA5CLNGULvD9IB7F9ylSAwi5UhbBmmwAvbcQl1YEwXx
         QU8out5/3Hlk6i8PB5mCi7z03eyftih54cqlIPqB/n4nWg2cGRjJ2bxVRsamqYi7qSkb
         xw/w==
X-Gm-Message-State: AOAM531wiLCGFE8g4uLh9a/JUB75nxT57iUcCoucJC/tflxSeWZ+WKe3
        m+3iMRXITYF+jH6JzduLCJE=
X-Google-Smtp-Source: ABdhPJybRjaMCkQ7fMxW5I3iMYatbJOQ+l0qY41y/qN0g1LtLCGvGnPRdyP5lvab9ohjC4EXH6prwA==
X-Received: by 2002:ac8:4d51:0:b0:2f1:ec64:cf90 with SMTP id x17-20020ac84d51000000b002f1ec64cf90mr6789779qtv.53.1650727451831;
        Sat, 23 Apr 2022 08:24:11 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id y6-20020a05622a004600b002f33ba280cbsm3184165qtw.8.2022.04.23.08.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:24:11 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/5] arm64: dts: rockchip: enable pcie controller on quartz64-a
Date:   Sat, 23 Apr 2022 11:24:03 -0400
Message-Id: <20220423152403.1681222-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423152403.1681222-1-pgwipeout@gmail.com>
References: <20220423152403.1681222-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index dd7f4b9b686b..8b0537744a60 100644
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
@@ -187,6 +199,10 @@ vcc_wl: vcc_wl {
 	};
 };
 
+&combphy2 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -495,6 +511,14 @@ rgmii_phy1: ethernet-phy@0 {
 	};
 };
 
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie_p>;
+	status = "okay";
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -520,6 +544,16 @@ diy_led_enable_h: diy-led-enable-h {
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

