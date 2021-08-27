Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F43F9D7A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbhH0RRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 13:17:09 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:55917 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236929AbhH0RRC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 13:17:02 -0400
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud8.xs4all.net with ESMTPA
        id JfS3mDfw9JWNeJfSVm6c64; Fri, 27 Aug 2021 19:16:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1630084563; bh=3E/gvqQmnwptUkUosq0Zx0aa7ySj/6pZFQ+5JuWSIY8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=L56qYnRbmqbbPEXYGq/+9I3iH3O3K3WVRr0WMl6Hu2Fext0OZvrPClb4Qq0VkCj1L
         Dj2sI6H/eSSdhTB2PEBs0n/46QwwWSUkN6TH2BURbp1SxsVfgbixIlWEAKB4rYSmt3
         Xj8cQeRGgwrnGTSCVPBOELpIp8rlnNEfeOIylJV73C+wFa8qxX2y6wiUHF/R6ZhFtL
         hW1AtyDq4/rqTIMWtfD1Nr0RbXspGPxUmgvxqIi61cqC7PiBmZ7irLDapLJsGPynXn
         BHyklO2MaOpzabXayNc53FsYbqeqCI3/i36NXiWUzYLBnDcmjfkbU7uTr4jwWPgsrN
         248OakVyg8L/w==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] arm64: apple: Add PCIe node
Date:   Fri, 27 Aug 2021 19:15:29 +0200
Message-Id: <20210827171534.62380-5-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHq2O0XF3viQNnbchOr5vWvKYVWvSOO6J+kWWin2NGiihPhSI6+JDn4rXZGRPpYD91LgjUny7riMTGLq9DzAcRjLCIHYFbfkJWmimc79d0jUyEZp/OG4
 d+TKn6olM6BC2Z+oQbzSLvEFky2EaR64QyCTjChZea/2Tbo3je/qT9PYs1wJqrnnJx2hv6qif0jqz32rqpFKNFuPoWBs8tnFwas0nhwqp/zVC95vGLUayBpb
 upOuBsnU+C0O/XKE9x3CxWzr/SjE5wfoXdZ1cajZpEW1FeLz0ssRo9DpDv99ikCxGcVOr38q4a8MBE3tJ2QKX8Wr/ItBrHXC0XEFFlWczKSYY2TnSzViLml6
 BJ0VjuNNRxxcOf4iaFZspHa1TPYWFUEQxbswaK+OVc9YM8U4Pu+i/Qvsip37XNkXc8r4QD+nAHvMEunKW/hEfbYr//nE8as1Z2HFiuIIjbt/iX17ydeaZYXt
 oFq94MhjVcSSZwH8e8jCWYnlMDIbAFzVRMOd0RK2NapuZDud/t9UADm7clgQpQ1bbIYGAkK7N9chgCsJRxAdj+4W9bEBN1eHhUgHnxMrhVt0g4GngXbfbIgf
 8bCKPlGgE8OdK3Emg0p3BIdYDBpmJAZ4upzA8r8KwnxGmizkYaPtWR6ihnIsHD+GMaEo+fCCU8KFeO5JBgDmFEFY3M2VwQJbWtHnauMwyW7/SJbu5JOfj0cJ
 3oJYWeQMUr0+/QolSdvEdsEpsYqXhc8IU1eqRB1wmZLsECYaYSuqBqj/KEogyUWeGN3ep8Tamf2CqlBL2emAfpG9t3sRjPl237sFS1OWIGsic92cSt0D+R1C
 5CWfltWgr0dBa5I/AvE=
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
index 503a76fc30e6..6e4677bdef44 100644
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
2.32.0

