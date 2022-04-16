Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C942503571
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 11:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiDPJEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiDPJEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 05:04:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00C1066E2;
        Sat, 16 Apr 2022 02:02:04 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d9so7850437qvm.4;
        Sat, 16 Apr 2022 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=iEN3ZCVaS/t/rWCo/X/zbmS+TjDfAMD6Cpvna9HLhP+x6o6ZYla5+H0GhKvSS5rkNP
         8ikamagqu15rha3O9npox2er4Nlo0Hn7ck8poWqBP/q72eCOKEY/dfZt4n41DYaOXrMp
         EDwEY8QW0e7FKJ8/isjurvCHIKVg+t8SYaanJRsQ2GTh/Xk7Tk9iTdHIqZ2hnCIihenU
         q+gEjJfKEWbPvQw1Pk47xBBn46/Sof/bvznKDvCqWTND5RbtxfUHpVMZ9XA0YrWq9JBj
         OR9G+IgS/PA/CTIH4SeRb1oG9054zyGVN9LGAXNtVnduvG9YGfhtywCIy+He6L9mMd9g
         mbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=Yygr/ux+MpKZ0QyThc9rYdSV7tTiZ4ZqA+WDLq7M1l3GkQcXoOZmhvQ57a9QNrxc+z
         AzLJ2HlK0q40RWTulLT4JldJUv0Y/3FFHSmmaKhotrqa2oO110lwjeDefQ+JJhvuWHcy
         h59GWcmoerUWnI6Cp3pYn3CE+Qn2Ira3xnwxlVdmfqT+5DMGwF87YocDPkeuQ8k9VQeM
         RvZB/GDlKogNL27IuzIlwdBXHPsE20ANEKiQMCJlrgproxxe9T5D2LAXTwrqRI1/RsME
         xDyGhpTiEzbCwupLYroDKyPQgNa5vtbkxlX8OlK8iqJaMIogQPn2WJ9shydp3fCiYaAE
         Wu8A==
X-Gm-Message-State: AOAM530W1KAQ1lwmeJBZGWbHM/c4tL9RxYXf6uPBNpEplZw/QAhRi4Ei
        qHf8hD+RByC0ZWliHejqUzYpd0fYb6xg8Bcx
X-Google-Smtp-Source: ABdhPJwpTvo4039/1P9AMC+MpCNIKVZR96KS8e9MCcSnpiwoRZMepeQPw0q+y1JNs/94Sh5JjUSMwQ==
X-Received: by 2002:a05:6214:e4a:b0:444:28a7:9fb7 with SMTP id o10-20020a0562140e4a00b0044428a79fb7mr1733610qvc.30.1650099724058;
        Sat, 16 Apr 2022 02:02:04 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm4258085qtx.36.2022.04.16.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 02:02:03 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 1/4] arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
Date:   Sat, 16 Apr 2022 05:01:56 -0400
Message-Id: <20220416090159.596930-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416090159.596930-1-pgwipeout@gmail.com>
References: <20220416090159.596930-1-pgwipeout@gmail.com>
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

From: Michael Riesch <michael.riesch@wolfvision.net>

The Rockchip RK3568 EVB1 features one USB 3.0 device-only
(USB 2.0 OTG) port and one USB 3.0 host-only port.
Activate the USB 3.0 controller nodes and phy nodes in the
device tree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index a794a0ea5c70..622be8be9813 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -103,6 +103,18 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_usb_otg: vcc5v0-usb-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
+		regulator-name = "vcc5v0_usb_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc3v3_lcd0_n: vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd0_n";
@@ -136,6 +148,14 @@ regulator-state-mem {
 	};
 };
 
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -507,6 +527,9 @@ usb {
 		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 };
 
@@ -568,6 +591,11 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
@@ -576,6 +604,24 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	vbus-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
-- 
2.25.1

