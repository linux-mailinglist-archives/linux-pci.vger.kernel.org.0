Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4614C503589
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiDPJLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiDPJLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 05:11:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7605241FBF;
        Sat, 16 Apr 2022 02:08:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a186so5340797qkc.10;
        Sat, 16 Apr 2022 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=QIYrB+ufrI3T77S1O/NAar0XMF8MWIL8WyVbqQv2bTO+Oz1DcaXdylO9KKKyG8tc9G
         BZIqFJ2OkO1DLaWKXWmQFdOpj3tLWkhW06GhcWRyUyqHxIonqFxTnCmmduRvI2CFzyk9
         s/QWB/9zjPTy6RRKJUFKq995GZLnr++d1p2ne+dsbQvIjjGi0+odNLiCsE7ErKa5BCXi
         rKzXSlQlXPT84qI18xw0YhnoRkTUfPPcXhwZn2v3Ettu0nuBIIuFCDhL1zFK6xEXFF8i
         YECwsiZ0gnVqQvhxpq1CyjkyzBBevGjCwJdzxcgj8glWSdVoqD63lvLyU7pnrY9kMad/
         ZOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=k2C8IJTw8bM+8MX/3CkANlpvI1W/XzflS534OXSGpNOqnsSAQN29Om3crpBoprOd4C
         2J550R1ir8ZMz6bcdm8ZR9W+voG5ds0bCVEmobCyDjWNwJZPh63MX8gVbLEAuKhIKgzF
         KN818R4C3WUr7nulQEDDIFq54rrLTtD9gB9mPWXGf8m5W8DXYS+MlCMCZnWLwEtMpjbn
         u28JhCQIghnCONICpM6iXJ3MkJPv2Bibr95zHbdGZv+o9Piv5zIssgiYFEGMVPFb/MKf
         Uokv3omwFsFCztT5CFvy7fo5rmxczeFNTMe0KLR7coeYuep8NqAw0ynjwSMHP+zSMv01
         BqWw==
X-Gm-Message-State: AOAM530t/ghIxq4MpXPXKJg4Qs/je+C4aG5U4jbEYR65FnPcwCGqFYjW
        I6jdf4+tSMPmw7Dab9rSWT7UxyeOipUHcBzO
X-Google-Smtp-Source: ABdhPJyPYMTVfW8c/yxfv8fb57FPal3ZuOQEqxZIO+3LQq9LNDTFZHwCRW39ds1hX7LAEZbebsxdFw==
X-Received: by 2002:a05:620a:1654:b0:69c:7035:b31f with SMTP id c20-20020a05620a165400b0069c7035b31fmr1513161qko.546.1650100138616;
        Sat, 16 Apr 2022 02:08:58 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm4630394qta.52.2022.04.16.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 02:08:58 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] arm64: dts: rockchip: enable pcie controller on quartz64-a
Date:   Sat, 16 Apr 2022 05:08:44 -0400
Message-Id: <20220416090844.597470-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416090844.597470-1-pgwipeout@gmail.com>
References: <20220416090844.597470-1-pgwipeout@gmail.com>
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

