Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36764514998
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359391AbiD2MmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 08:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359320AbiD2MmE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 08:42:04 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD262C9B60;
        Fri, 29 Apr 2022 05:38:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x9so5548792qts.6;
        Fri, 29 Apr 2022 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQBPMVh4KxNRh9skZ41FjxLu1MoZCNVrj1TK5/sD6n0=;
        b=j/ndKRSFYP7buMqMGMQiCJU5XRdg77IB9UVShw7egWFQmnIk9pK99P+eyjC3WLXp7t
         0ctpKbP4HMNyiZx0+6q0gYVuF3fN604ffVjFbUuWYiCFBiIY5DXFCFGw4BVSYBJyXkj9
         nOljcWMvx1zYFunQ427lF8be/y1vw57oJiv1b5hcnfOjNyCQr8f9mL/2vNIvr2DFdfUM
         +9E+MPGCdtmE3syuOh2bEYtewpHwgxRdIoyAg7AxS452S4FWkZqq35cS8N3WHI97o8hT
         go6jr62E9XFlZaYYkZo80YrXKxFhpWvtVeSOSUMbUpMehZ4/fAbWJgx+t2Trp/DHsmRu
         rRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQBPMVh4KxNRh9skZ41FjxLu1MoZCNVrj1TK5/sD6n0=;
        b=lVTjaxxdjaQY6yaUZqzj8NEMuCO3TjPYKZ0JlXGHUSLxyU++SKpuTdih498g/08k69
         yu8Fbq7PFx0DdzroHB4M18I6DDBHirzh/DnQKoXULaqejK7Uj0y2X9gCN54qd9w71VB0
         DabSwEB+jYVee3v3aDkBxtenXpMlQKYeqElhT0vFr805QasxfUmK2xO9VaaJss5Amkn2
         NJOhBt1cTq/0+e/R0Ryk/7pmUmQrgqVy+hnEe2Ke4SkJoyKbz4+iRgtIs6Ktz0D+bGbL
         K+oLld7J1nv9axxUevm2es9xeY0/B0lK5bUDP5v6O6JWgpGzTercfWi+5WNcHrgJ8P9H
         P0Sw==
X-Gm-Message-State: AOAM530wruXfexQILdt4ki7UQHejdOCd9IcQSYvfioUTK760ukJpKHQG
        OksaUlaD8ZqGrzfv+xRlja8=
X-Google-Smtp-Source: ABdhPJyJaJYrd4MzvWoNOelwgiutgFGzr/zwhlrF3q+PLQOFMKom71HPMDPQ/jtf5nz0GM3H05DMzg==
X-Received: by 2002:ac8:578b:0:b0:2f3:53a3:33d4 with SMTP id v11-20020ac8578b000000b002f353a333d4mr26724642qta.376.1651235923927;
        Fri, 29 Apr 2022 05:38:43 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v126-20020a37dc84000000b0069f9c375519sm1431644qki.46.2022.04.29.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:38:43 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/5] arm64: dts: rockchip: Enable PCIe controller on quartz64-a
Date:   Fri, 29 Apr 2022 08:38:31 -0400
Message-Id: <20220429123832.2376381-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429123832.2376381-1-pgwipeout@gmail.com>
References: <20220429123832.2376381-1-pgwipeout@gmail.com>
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

Add the nodes to enable the PCIe controller on the Quartz64 Model A
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

