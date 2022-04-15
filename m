Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7D503161
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 01:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354213AbiDOVJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354221AbiDOVJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 17:09:00 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904388B6CB;
        Fri, 15 Apr 2022 14:06:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id ay4so6604132qtb.11;
        Fri, 15 Apr 2022 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=VikkCoAUvLC1ubmrDIIV+nyiCkBGV9Pl/byIqsOybtzYPMcKNDPfx/XL181ahe2GIi
         q46j8YpQ9t/zJURTqdBt2hI8XvgZ1/mMK/hSg2bSq3t7lI5GjUE2Eik8WvxT7gxpbeBq
         UKwAYOl9Qcd6aoru5sB3ra5q3ni3kHiGNX/jcgC34JTsfs/kVHhdgeEITeC6AUrBVZnA
         MhjHfeBPCOtFE5Q24iUeXQMjmXqwG6eUBEJ6B4GT9KJZXE4cCtMDZ6/HblPPVtE4t0sf
         qjLIifQRvMJXAXJ417O6AX/VMfbW0jGpWbeCPP9ofc9IgQdREUVuMOFcdO2irK4loNbh
         zD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=W6GCTJ+N0COi1/ow2EtBtVJOKi1UVX+E+KOWTKtwcH1DEgk5tWGtlyn+vHBe1J6dsg
         u21vepsE+Kd2VOZ9aVnK24mvg88zZ9ITwQsDViwmJdbEO0o/Awwtq5EMY4+OmXAsDi2K
         8NVQry4xXlNimatT15IslfasjfGW9E3opYe02cHZ8VuIc89+1F6cnGINbmN2lu/nuL7G
         uyAh6fpR+xCobQIXbPfX6jZmkFSEtKp+w1s0ZPiZmF4dl37EGKd4pZ7vz3+RUsujtyFK
         MH+H8XEampzj6x3mypRf5/ZsLrj2LDe283+y4QPOStT30UxhbH7hfn1nujxmiEqgqwoT
         1F0Q==
X-Gm-Message-State: AOAM533mGB4T2y3jq34u3W8yskcPpJo4jY8rZDVJVn2MIQN+qlFCrR4a
        D1dlKkcgDZB5RuDUnPauCU8=
X-Google-Smtp-Source: ABdhPJzLedWnFnNqrv1TQhWt9BpMbdSJ/gRbFqSAse32530sbMvkDxImMfNQDN8aMJMLhl6YMWWjnw==
X-Received: by 2002:ac8:7a8a:0:b0:2f1:de6a:c044 with SMTP id x10-20020ac87a8a000000b002f1de6ac044mr686043qtr.243.1650056790708;
        Fri, 15 Apr 2022 14:06:30 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a148800b0069c4884c990sm2838664qkj.108.2022.04.15.14.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:06:30 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: rockchip: enable pcie controller on quartz64-a
Date:   Fri, 15 Apr 2022 17:06:21 -0400
Message-Id: <20220415210621.538109-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415210621.538109-1-pgwipeout@gmail.com>
References: <20220415210621.538109-1-pgwipeout@gmail.com>
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

