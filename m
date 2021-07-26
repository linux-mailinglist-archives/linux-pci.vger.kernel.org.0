Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EBF3D55C1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhGZH73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 03:59:29 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:36811 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231805AbhGZH72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jul 2021 03:59:28 -0400
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud9.xs4all.net with ESMTP
        id 7w2DmOzH54Jsb7w2WmW9Om; Mon, 26 Jul 2021 10:32:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1627288364; bh=PKbQ1TmUx1VxAzGEjtXpNW/Qb53gi7gmApBAe4okEsI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=g3+Imej37aAQx9NE+ANp2i/Y1eNwT3P9EcgAYxRnZb8nDPnUe9vMhzUtMoIN6Kr+i
         rPEmlime5AEk1KYXWYzhtRTMbonjSixyosJA7NGglJ/6NTQdel1KDDts4cNYzFmPZb
         LZW1zlpxh4/2u9AugpXFn/XTHteZwwH1Fl4wNii5pJnpp50y1KwdOoiUAOV6hudzRh
         fFG9/3s6Tez/oHcySaLY21ma/tQsTuXEv11+KQ5fhGST0QzdzHM2Tx1mVdNDi617fG
         MwI4a/wmVIsCyaIftnxwbFl2673ofg2pySspq/pWJOBGFNpR2twJEukUlMpI0/sGX6
         UGWXx+JYIz3qQ==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: apple: Add PCIe node
Date:   Mon, 26 Jul 2021 10:32:01 +0200
Message-Id: <20210726083204.93196-3-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
References: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNgmQNzELbD+zU3VM/bNjyFjHaUQPd84PWVoDiNStFaEhlF1Z0Ouoq97lo+jRhfg0zzWNzfCbCozTMRLkRE55hGOxB5YxqwGJU6LwEOaLRzD3SkRLatU
 A8r2W4Yw5lPbLSINkh/DpOTEWjOwBJ1laUXWqsWs/hBOPR9agv2j2IsQEtiTc1Ux1N95Mi0mgV53EGQYKZv3lrHFs8XIieYWT7gVvCZJGnpyysulvfSmPXoi
 iGkMhPMYz9OJvO0nrXXaiqwfOGafGgo8Negn9ggqlrXg5aAYjil58+zvYJ/671NlOpwa/JI8IBtkbuwF7VGjK+i5/X8UwslsT9Ru/HGtoRWkyc6fwzrL1Uyj
 iXDRfdZgjZqWOV0CMCOHjL0fKdSXRyWjEAmhzZcvEW91e1tyHiZb8No/NQhhhFYLXqtqK1ghvTQ7Ml6R3IaunE3kiU4Qlr2mp/vBA09aSdXGsqyA+04YVBfO
 gjUQoB7wJy/Ru2XodQYXxk5VeIAZMUsPmD3AbzbUsIDMH6WSQI4yiM6ZcoSUfaUpJciKg+vXZkrMVlaDcZXWrKQfOHc5QOeelrdp+w==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

Add node corresponding to the apcie,t8103 node in the
Apple device tree for the Mac mini (M1, 2020).

Clock references and DART (IOMMU) references are left out at the
moment and will be added once the appropriate bindings have been
settled upon.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 503a76fc30e6..cd3ebb940e86 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -214,5 +214,68 @@ pinctrl_smc: pinctrl@23e820000 {
 				     <AIC_IRQ 396 IRQ_TYPE_LEVEL_HIGH>,
 				     <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pcie0: pcie@690000000 {
+			compatible = "apple,t8103-pcie", "apple,pcie";
+			device_type = "pci";
+
+			reg = <0x6 0x90000000 0x0 0x1000000>,
+			      <0x6 0x80000000 0x0 0x4000>,
+			      <0x6 0x81000000 0x0 0x8000>,
+			      <0x6 0x82000000 0x0 0x8000>,
+			      <0x6 0x83000000 0x0 0x8000>;
+			reg-names = "config", "rc", "port0", "port1", "port2";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
+
+			msi-controller;
+			msi-parent = <&pcie0>;
+			msi-ranges = <704 32>;
+
+			bus-range = <0 3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
+				 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
+
+			pinctrl-0 = <&pcie_pins>;
+			pinctrl-names = "default";
+
+			pci@0,0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				reset-gpios = <&pinctrl_ap 152 0>;
+				max-link-speed = <2>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+
+			pci@1,0 {
+				device_type = "pci";
+				reg = <0x800 0x0 0x0 0x0 0x0>;
+				reset-gpios = <&pinctrl_ap 153 0>;
+				max-link-speed = <2>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+
+			pci@2,0 {
+				device_type = "pci";
+				reg = <0x1000 0x0 0x0 0x0 0x0>;
+				reset-gpios = <&pinctrl_ap 33 0>;
+				max-link-speed = <1>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
 	};
 };
-- 
2.32.0

