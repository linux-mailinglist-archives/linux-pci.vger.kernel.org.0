Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AE10FCBE
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 12:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLCLry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 06:47:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:49510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfLCLrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 06:47:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B4FCB1E8;
        Tue,  3 Dec 2019 11:47:51 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, jeremy.linton@arm.com,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/8] ARM: dts: bcm2711: Enable PCIe controller
Date:   Tue,  3 Dec 2019 12:47:35 +0100
Message-Id: <20191203114743.1294-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203114743.1294-1-nsaenzjulienne@suse.de>
References: <20191203114743.1294-1-nsaenzjulienne@suse.de>
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

 arch/arm/boot/dts/bcm2711.dtsi | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 667658497898..5b61cd915f2b 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -288,6 +288,43 @@ IRQ_TYPE_LEVEL_LOW)>,
 		arm,cpu-registers-not-fw-configured;
 	};
 
+	scb {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
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
+	};
+
 	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.24.0

