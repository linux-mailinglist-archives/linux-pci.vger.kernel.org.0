Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59874382130
	for <lists+linux-pci@lfdr.de>; Sun, 16 May 2021 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhEPV1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 May 2021 17:27:43 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:52865 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230158AbhEPV1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 May 2021 17:27:43 -0400
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud8.xs4all.net with ESMTP
        id iOA9lJWwKWkKbiOAPlkPrx; Sun, 16 May 2021 23:19:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1621199957; bh=HOikwmeJWakjyZ7lU+im9UqH19VkGuK5u0ycvEvKpYg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=YQDeZVcVf6d38kGbeZ0705ZtiQkW7XYyau0Y9RpL3drHc9fwEbfB1bDVARECJbvA8
         Z9WHsTSGEUQ+cxLWfOzyE8r4qrMLSiZIy0+g4vbccART7rB11EZ3VNJDm/IM+A61SW
         GP+Mad4JxMH98+PAMKCScfziBg7C/rayfZpPbyW1AULWKg6kYx8JTycpAX7dBkPU2A
         hxfTXeO0J2kychGYdfky4xNvmwIsX3eHP3I4Ej0SoU0MTAi5oNap93vNqDVEKmYJld
         Vz6hj4ULV6p6Riig6uALO+H+RhHTwpnPKLiM/7g38Jpez+LArbX8OgyE1MObJvGoYD
         hpcjoQdYJzZbQ==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, arnd@arndb.de,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: apple: Add PCIe node
Date:   Sun, 16 May 2021 23:18:47 +0200
Message-Id: <20210516211851.74921-3-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516211851.74921-1-mark.kettenis@xs4all.nl>
References: <20210516211851.74921-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFZK+xFYmI4iu+AvuNjdTrW1Fj61/71SG98CoULY7GKFiYRox6X/GCgTJdRU/rHlsuQvOAxBmauzAJjKYWoBowS1cXcCyTDlrNr4ipOS/AhaQO3jI47o
 DKx3dgubfDSJZ39muL/J5dhiUDbbfD15VEcp2VYyIkbOUqg9lhPzw/eSpDeCJHEw/J/NPSn9tZEjcAx9smwN9Jwq/71hoHgJcL9L8vLZWIUzwhEpoYQmJ6Zg
 SD3IFVLRLttF0UvFe8a3VHZwxzaD3azLQaBtIcTrKPbxTB0gz6HXW2FfQWe6xi4RlKiVSn6gvdit9Cd5ysyzAx7pUZBOY6kmqKyPMyTDeid/HngOG41m6iL/
 43092UZGvKmh93K36abWvEVU5P6HOtQXs58d5hx/JhXwJYNeXRJWEN6g0LYrGU4592/LB9V2xiIMJDObeMoRUXkIjeQYL6xk/B2o3oixyEADP0XVvT/HgoAQ
 KQbSUMMYwkx2+l0kY4DA1uK7LHMahVlozumbRgZmJBNucP3VELyz8xnHtTI=
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
 arch/arm64/boot/dts/apple/t8103.dtsi | 64 ++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 503a76fc30e6..102947935d63 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -214,5 +214,69 @@ pinctrl_smc: pinctrl@23e820000 {
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
+			      <0x6 0x8c000000 0x0 0x4000>,
+			      <0x6 0x81000000 0x0 0x8000>,
+			      <0x6 0x82000000 0x0 0x8000>,
+			      <0x6 0x83000000 0x0 0x8000>;
+			reg-names = "ecam", "rc", "phy", "port0", "port1", "port2";
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
+			bus-range = <0 7>;
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
2.31.1

