Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72AC395345
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 00:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhE3WqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 May 2021 18:46:17 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:44195 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhE3WqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 May 2021 18:46:16 -0400
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud8.xs4all.net with ESMTP
        id nUANlDkLZIpGynUAelJsIg; Mon, 31 May 2021 00:44:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1622414676; bh=xS8tcoAoXQ7rfnmN3vR74RBJgyU9e6+aspNVHKO9ktk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=TkcQU1dgiVvL2un05BM81xNwIiivCiP49ex4xsuUJ5ydyerksfvuUKrqQ7iyrU/gY
         +8WPNjHukPKXHeArf2BMLE9VPt6lhfrsjmwjhLW8HLIZMHjcwiVL1FPBS/IGnh+1W5
         Pg5BaTmQ3WKjplSinW0xd4Hd31mZKO/6w7JipzW/3P2tKJy44zxq7sJBkmAgu7QwWp
         +pIvqXBadTDmUSKGVooJ1+u9jJSLQDDABuHLc46V03uI4yRlk0z2GPDnXfE5OsHFMg
         xWCg1kDLfpVMl35TwrB0064zX3Jv7GK3PdnGiDAeEnMH6qzyNRD0z6QELy/GuYaCfl
         xT/kCI523gvgA==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: apple: Add PCIe node
Date:   Mon, 31 May 2021 00:44:01 +0200
Message-Id: <20210530224404.95917-3-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210530224404.95917-1-mark.kettenis@xs4all.nl>
References: <20210530224404.95917-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFmRtx2o8H/8LE3fQg/QQ+gZGAzebIaMe26DrRP04W43Y068UWcZ2PrSxggRBr+OEdBE1iV3d/UB4XZeG0jT+hsZGcDh29DMIWYL2dqYLkYDbJk3yxgV
 ouFFmRzUCJOtLCSPU6CTF91KLyrtJhPQhM1YDqspf5hHOOritGH6vZ0w0YQfQj06pveeKxYrvA/pGBvVJldazPMUOskmv56/O0o2cim/Bw48KgYKpX4hQVd/
 YMoqvCnmesvA7epQoaxptg4i4sKalbH80jRWxaf6nxWkrtg4zCbM3SkCKQhTVs6chock156q5/HuzJ+7Ny1sHJpjI4o6LiQVimswAiN5PTgB1c0Pcw3bjhAS
 JYEgfmnkV4PIQDkAcCKIZ/LmLQnSabQA+CMc+ytquKue56WResWUUlzY758to6V9O3Kxm3hU+BtjTMJkQzkfEp+Ydd6Bm/oTgDadDngWcm8hqcpK4vNbXzrx
 TcjtDfz1bd17hBteeYLNWL7xUVQE+6dIJZvwhtKxkOZzNNZav03sVBCwmGo=
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
2.31.1

