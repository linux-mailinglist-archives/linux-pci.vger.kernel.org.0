Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E434FE853
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358824AbiDLTAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358809AbiDLTAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 15:00:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5C45045;
        Tue, 12 Apr 2022 11:58:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t207so13106393qke.2;
        Tue, 12 Apr 2022 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=RcOBcyge8gEW8ksmv2HQErR8WAWybEJlUOFbo4QaXLgFpzSWCcz2HpLldyWyZDRf/o
         4B/GiE31GGs4G7a8Tvr6WpiA44ufpBHoxkDmEKFkUXTiW3JmPk5t61JYhhtWm27CeSI3
         UXO+4I9SFy5OdzF1sA7ljZjoxhBKT8HU0XJ08BrG2+dxkUjMpH19yhQlQmPbHhY2Vstd
         u/R74B8Bg80QFdaG2tQCvKVAY9yFZ31j2556dzztumPjttg3AP1GSRWHjxivFGIocohz
         q9sR9FxtFR5PQV8hgAbfHsM1cUtzj0W2c+IyfNckz4qBkRqfDMoH9k8JOjZFOnJSiw/2
         UetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=FgVg/ggW5uGVxgNZhsaBO3TM7Q9OdJDGyPd9Di6Dalw1G3xJkq5k4fMJVspBiNkko7
         fHILAo+KqMZg1MpdfNIjILiP6nVtCoDHohHPkTA6zvaMLHzNAnTzoJwBGTKxqVaMJCxJ
         FzxzKjf8XKzTJTO6+DtBFWhpbLYVgGvInIGXyzIm9uQn7rw0beG4JyxFIpAuFg9fS3Pr
         WBPw1DCGs7YLZmaxuuUcws9QDccp3N8ZGkWCMVQTMZxM7PoSAxSoIE8k3GSV0Maj6tIa
         DvO8+FEYGt+qpF7n0BxVuKOLDYh+1XCA3wz+LYqUQgxgKcXaD1P0D4p2zhHnKqiHFeNy
         CShg==
X-Gm-Message-State: AOAM533EvPaWfSkkFhrToQyXL1rKulKpUqkVrSSnzzCD1RPfBWzdkBRh
        3/pIYLGAB40QIN2M5vWK9tw=
X-Google-Smtp-Source: ABdhPJyYQ0Cq+V1iYlc6ojDyOm4DcmTLilZwXR3xUcUPCgObjvW2mTuJxmGVy++nUaOzCscfbpTHpA==
X-Received: by 2002:a37:6004:0:b0:69b:dd65:3f36 with SMTP id u4-20020a376004000000b0069bdd653f36mr4238319qkb.487.1649789883614;
        Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a05d200b002f07ed88a54sm1820610qtb.46.2022.04.12.11.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] arm64: dts: rockchip: enable pcie controller on quartz64-a
Date:   Tue, 12 Apr 2022 14:57:51 -0400
Message-Id: <20220412185751.124783-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412185751.124783-1-pgwipeout@gmail.com>
References: <20220412185751.124783-1-pgwipeout@gmail.com>
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

