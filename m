Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5503E5AD98A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiIETZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiIETZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184E23BF3;
        Mon,  5 Sep 2022 12:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8AEAB815D7;
        Mon,  5 Sep 2022 19:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A08CC433C1;
        Mon,  5 Sep 2022 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405918;
        bh=ZacdliM5CoZmtUxRzDil8M4sBbkaHBWCQ94hEdIcfxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIb6ot0n5NwflvIzaQmsNChFTos6Al5fqOAMg9r9liJ1gMwWfKRNivD0UW4I8lA00
         kKDhSSZimKk/okc5M1M1W2uvckXDxf2pWoN+OJSf3AAH5YOHqpNbMHxJOiWH1E4ltJ
         QQ3W9mLrwy+wjgFU+qQItZwZd+Tu2aOX4KPNlw1iimCNPC1oLBd33kOwLdTrkujN57
         6sWAaOymlQBhU7XnyWXtEZYVgOANJRUm9gOj9+1O/+Jyu9j2WetT+evY7mjgyhdiuj
         Ub7AHLholO7oaZ4cDVLL2TClDIwl0/g5s9AzXGfdBdsbuRbmD/QD1aoG3xIq1yDoAk
         7Gzeh6pAkzQKQ==
Received: by pali.im (Postfix)
        id E5CFD7D7; Mon,  5 Sep 2022 21:25:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/7] ARM: dts: orion5x: Add PCIe node
Date:   Mon,  5 Sep 2022 21:23:10 +0200
Message-Id: <20220905192310.22786-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define PCIe aperture for top level soc node handled by mbus driver and
define PCIe controller node with one PCIe Root Port.

Old Orion arch code maps first 16 MB of PCIe config space to physical
address 0xf0000000. But for full PCIe support it is needed to map whole
256 MB long PCIe config space.

There are probably no Orion boards with more than 2 GB of RAM, so 256 MB of
free physical address space must exist. Tests on Orion board proved that
there is free space in physical address range 0xd0000000-0xdfffffff.

So use this physical space for mapping whole 256 MB long PCIe config space.
In case there would be some issue with this range, particular Orion device
tree board file can change it to 16 MB size or move it to old location.

By default orion5x.dtsi include file would contains whole PCIe config space
for full PCIe support.

By default is PCIe node disabled, so this change in orion5x.dtsi has no
effect for any board until board dts file explicitly enable it. Each board
has to migrate its PCIe code from old arch specific to device tree based.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* New patch
---
 arch/arm/boot/dts/orion5x.dtsi | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 2d41f5c166ee..41954d96ebbf 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -18,6 +18,9 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		controller = <&mbusc>;
+		pcie-cfg-aperture = <0xd0000000 0x10000000>; /* 256 MiB config space */
+		pcie-mem-aperture = <0xe0000000 0x08000000>; /* 128 MiB memory space */
+		pcie-io-aperture  = <0xf2000000 0x00100000>; /*   1 MiB I/O space */
 
 		devbus_bootcs: devbus-bootcs {
 			compatible = "marvell,orion-devbus";
@@ -226,6 +229,54 @@
 			};
 		};
 
+		pciec: pcie {
+			compatible = "marvell,orion5x-pcie";
+			status = "disabled";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			msi-parent = <&intc>;
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x82000000 0x0    0x40000  MBUS_ID(0xf0, 0x01) 0x40000  0x0     0x2000>, /* Port 0.0 Internal registers */
+				 <0x82000000 0x0 0xf0000000  MBUS_ID(0x04, 0x79)     0x0  0x0 0x10000000>, /* Port 0.0 Config space registers */
+				 <0x82000000 0x1 0x00000000  MBUS_ID(0x04, 0x59)     0x0  0x1 0x00000000>, /* Port 0.0 Mem */
+				 <0x81000000 0x1 0x00000000  MBUS_ID(0x04, 0x51)     0x0  0x1 0x00000000>; /* Port 0.0 I/O */
+
+			pcie0: pcie@1,0 {
+				status = "disabled";
+				reg = <0x0800 0 0 0 0>;
+				device_type = "pci";
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				assigned-addresses =         <0x82000800 0x0    0x40000  0x0     0x2000>, /* Port 0.0 Internal registers */
+						             <0x82000800 0x0 0xf0000000  0x0 0x10000000>; /* Port 0.0 Config space registers */
+				ranges = <0x82000000 0x0 0x0  0x82000000 0x1 0x00000000  0x1 0x00000000>, /* Port 0.0 Mem */
+				         <0x81000000 0x0 0x0  0x81000000 0x1 0x00000000  0x1 0x00000000>; /* Port 0.0 I/O */
+				bus-range = <0x00 0xff>;
+
+				clocks = <&core_clk 0>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+
+				#interrupt-cells = <1>;
+				interrupt-names = "intx", "error";
+				interrupts = <11>, <10>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie_intc 0>,
+						<0 0 0 2 &pcie_intc 1>,
+						<0 0 0 3 &pcie_intc 2>,
+						<0 0 0 4 &pcie_intc 3>;
+
+				pcie_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
+			};
+		};
+
 		crypto_sram: sa-sram {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x00) 0x0 0x800>;
-- 
2.20.1

