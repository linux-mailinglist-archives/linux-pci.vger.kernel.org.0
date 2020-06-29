Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65AC20D7BB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgF2TcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 15:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733154AbgF2Tb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECA7AAE6D;
        Mon, 29 Jun 2020 16:18:57 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v5 4/9] ARM: dts: bcm2711: Add reset controller to xHCI node
Date:   Mon, 29 Jun 2020 18:18:40 +0200
Message-Id: <20200629161845.6021-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629161845.6021-1-nsaenzjulienne@suse.de>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The chip is hardwired to the board's PCIe bus and needs to be properly
setup trough a firmware routine after a PCI fundamental reset. Pass the
reset controller phandle that takes care of triggering the
initialization to the relevant PCI device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v3:
 - Correctly define PCIe topology:

	[0000:00]---00.0-[01]----00.0  VIA Technologies, Inc. VL805 USB 3.0 Host Controller

   Earlier versions were not taking into account the bridge between the
   PCIe controller and xHCI controller. It worked, but out of luck...

Changes since v2:
 - Use dt-bindings to access IDs

Changes since v1:
 - Update to match new binding

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 0cef95058fb0..5b54d2185893 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -4,6 +4,8 @@
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 
+#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
+
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
 	model = "Raspberry Pi 4 Model B";
@@ -207,6 +209,21 @@ phy1: ethernet-phy@1 {
 	};
 };
 
+&pcie0 {
+	pci@1,0 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		reg = <0 0 0 0 0>;
+
+		usb@1,0 {
+			reg = <0x10000 0 0 0 0>;
+			resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
+		};
+	};
+};
+
 /* uart0 communicates with the BT module */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.27.0

