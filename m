Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7818B413A32
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 20:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhIUSng (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 14:43:36 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51397 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233600AbhIUSng (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 14:43:36 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 14:43:14 EDT
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Skb8mlMr9pQdWSkbamYt73; Tue, 21 Sep 2021 20:34:58 +0200
From:   Mark Kettenis <kettenis@openbsd.org>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v5 4/4] arm64: apple: Add PCIe node
Date:   Tue, 21 Sep 2021 20:34:15 +0200
Message-Id: <20210921183420.436-5-kettenis@openbsd.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921183420.436-1-kettenis@openbsd.org>
References: <20210921183420.436-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHhQZ6AJi25iA7HphsHmJwim8Jvgsd9KkIPWji3RvlBIC8jLZYr7rslO9k7z7tmQrrwWHesyulwaXXRZ6DAF/SK3svoW/pvrIQV/YXd1rGrJxcSDm2M0
 ZKHfHBR0+WX8j2SjgAf+twYv+Nb+sPTyX0fJsqa6oUJKE605ALB1YTdeCmbUAIk4XVQBMCva7mcAyf4ZgTSLQDmjmxpgC9b1WXqfIb3mYCIIu8o2eNrLhqyu
 h5hYAaycS/GcuGTqI5YP3dTTkhKdTWNpKcuVKKnMwNfAGhff3cCgYRPUlzvLlj8ys9AG8kjtXFxNmr3cfXRXMur+//WJOLxXwhiE8lLmN4DK3yeMdSudybAT
 oEO4pV9YQDiZWNjpAb7GexxGH+SRZXvZG8SfX86EDfY5yrbI+D+DhPejf5W/jMZGA2wZVo22m9zO5oKbFjNb68r204es1IzaErqdiM9J5sW8BqUUjrTcZqza
 hiNHZZdapii+cnn1hlOcJbWK+VMw0E2BkDdedpoZ2bLBS1nHkxz6sAfDHo16Ys5YgTZjWolIZqsXRW4WxiJ8tc+oZ02fzZcxTEDoWDS2GwOG/CzrCKXF3/r8
 aOHbA+Gt2TjNFJdwDpu4uJJpOMYOL9acSRO9j0mF/xBWPhECREFW6ubbvgi2XGLjNF8NHUdtviQ7Zbk5JfEADiSTdnZfGOp1foON9iOqyYp0TuO1LWvcFq7Z
 eMxjW2QypkBKzEIhYwXTQLv5SntPN2+SwT0STb+w2c0EdqB6PLFAOLPVnkBRG4khCvzIxOX8XWqJtBnwlQDQIltJ9cJfCxTz4W0nxmym6ru+F/eCK9XSRPPP
 P+N0uiSFw4nN4Rl7mqe0iHF2OugQSiNyss66Z9UyQ58SaYdevEz6HiD79pKbpQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add node corresponding to the apcie,t8103 node in the
Apple device tree for the Mac mini (M1, 2020).

Power domain references and DART (IOMMU) references are left out
at the moment and will be added once the appropriate bindings have
been settled upon.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 503a76fc30e6..10956859b4bb 100644
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
+			      <0x6 0x80000000 0x0 0x100000>,
+			      <0x6 0x81000000 0x0 0x4000>,
+			      <0x6 0x82000000 0x0 0x4000>,
+			      <0x6 0x83000000 0x0 0x4000>;
+			reg-names = "config", "rc", "port0", "port1", "port2";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
+
+			msi-controller;
+			msi-parent = <&pcie0>;
+			msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
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
2.33.0

