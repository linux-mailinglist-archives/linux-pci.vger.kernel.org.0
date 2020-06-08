Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774881F1FDC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgFHT2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 15:28:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgFHT1g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 15:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43A70AEBF;
        Mon,  8 Jun 2020 19:27:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        robh@kernel.org, mathias.nyman@linux.intel.com,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com
Subject: [PATCH 4/9] ARM: dts: bcm2711: Add reset controller to xHCI node
Date:   Mon,  8 Jun 2020 21:26:56 +0200
Message-Id: <20200608192701.18355-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608192701.18355-1-nsaenzjulienne@suse.de>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
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
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 47e7c9c14ddf..2646c858449f 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -207,6 +207,13 @@ phy1: ethernet-phy@1 {
 	};
 };
 
+&pcie0 {
+	usb@1,0 {
+		reg = <0 0 0 0 0>;
+		resets = <&usb_reset>;
+	};
+};
+
 /* uart0 communicates with the BT module */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.26.2

