Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8624012032D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 12:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLPLBb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 06:01:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:36890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727511AbfLPLB3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 06:01:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9907ACA7;
        Mon, 16 Dec 2019 11:01:27 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/6] ARM: dts: bcm2711: Enable PCIe controller
Date:   Mon, 16 Dec 2019 12:01:08 +0100
Message-Id: <20191216110113.30436-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216110113.30436-1-nsaenzjulienne@suse.de>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This enables bcm2711's PCIe bus, which is hardwired to a VIA
Technologies XHCI USB 3.0 controller.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v4:
  - Rebase commit taking into account genet support series

Changes since v3:
  - Remove unwarranted comment

Changes since v2:
  - Remove unused interrupt-map
  - correct dma-ranges to it's full size, non power of 2 bus DMA
    constraints now supported in linux-next[1]
  - add device_type
  - rename alias from pcie_0 to pcie0

Changes since v1:
  - remove linux,pci-domain

[1] https://lkml.org/lkml/2019/11/21/235

 arch/arm/boot/dts/bcm2711.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index e2f6ffb00aa9..b56388ce1216 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -331,7 +331,36 @@ scb {
 		#address-cells = <2>;
 		#size-cells = <1>;
 
-		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>;
+		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
+			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
+
+		pcie0: pcie@7d500000 {
+			compatible = "brcm,bcm2711-pcie";
+			reg = <0x0 0x7d500000 0x9310>;
+			device_type = "pci";
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pcie", "msi";
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143
+							IRQ_TYPE_LEVEL_HIGH>;
+			msi-controller;
+			msi-parent = <&pcie0>;
+
+			ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000
+				  0x0 0x04000000>;
+			/*
+			 * The wrapper around the PCIe block has a bug
+			 * preventing it from accessing beyond the first 3GB of
+			 * memory.
+			 */
+			dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000
+				      0x0 0xc0000000>;
+			brcm,enable-ssc;
+		};
 
 		genet: ethernet@7d580000 {
 			compatible = "brcm,bcm2711-genet-v5";
-- 
2.24.0

