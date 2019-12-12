Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CA11C2E0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 03:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfLLCC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 21:02:28 -0500
Received: from mx.socionext.com ([202.248.49.38]:58683 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfLLCC2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 21:02:28 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Dec 2019 11:02:26 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 5E11A180B6B;
        Thu, 12 Dec 2019 11:02:26 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 12 Dec 2019 11:02:57 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id F068F1A0006;
        Thu, 12 Dec 2019 11:02:25 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: PCI: Add UniPhier PCIe endpoint controller description
Date:   Thu, 12 Dec 2019 11:02:17 +0900
Message-Id: <1576116138-16501-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576116138-16501-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1576116138-16501-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT bindings for PCIe controller implemented in UniPhier SoCs
when configured in endpoint mode. This controller is based on
the DesignWare PCIe core.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/pci/uniphier-pcie-ep.txt   | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
new file mode 100644
index 00000000..56cb891
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
@@ -0,0 +1,47 @@
+Socionext UniPhier PCIe endpoint controller bindings
+
+This describes the devicetree bindings for PCIe endpoint controller
+implemented on Socionext UniPhier SoCs.
+
+UniPhier PCIe endpoint controller is based on the Synopsys DesignWare
+PCI core. It shares common functions with the PCIe DesignWare core driver
+and inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+Required properties:
+- compatible: Should be
+	"socionext,uniphier-pro5-pcie-ep" for Pro5 SoC
+- reg: Specifies offset and length of the register set for the device.
+	According to the reg-names, appropriate register sets are required.
+- reg-names: Must include the following entries:
+	"dbi"        - controller configuration registers
+	"dbi2"       - controller configuration registers for shadow
+	"link"       - SoC-specific glue layer registers
+	"addr_space" - PCIe configuration space
+- clocks: A phandle to the clock gate for PCIe glue layer including
+	the endpoint controller.
+- resets: A phandle to the reset line for PCIe glue layer including
+	the endpoint controller.
+
+Optional properties:
+- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
+	phys are required.
+- phy-names: Must be "pcie-phy".
+
+Example:
+
+	pcie_ep: pcie-ep@66000000 {
+		compatible = "socionext,uniphier-pro5-pcie-ep",
+			     "snps,dw-pcie-ep";
+		status = "disabled";
+		reg-names = "dbi", "dbi2", "link", "addr_space";
+		reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
+		      <0x66010000 0x10000>, <0x67000000 0x400000>;
+		clocks = <&sys_clk 24>;
+		resets = <&sys_rst 24>;
+		num-ib-windows = <16>;
+		num-ob-windows = <16>;
+		num-lanes = <4>;
+		phy-names = "pcie-phy";
+		phys = <&pcie_phy>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3a5c5..4b6ec28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12694,7 +12694,7 @@ PCIE DRIVER FOR SOCIONEXT UNIPHIER
 M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+F:	Documentation/devicetree/bindings/pci/uniphier-pcie*.txt
 F:	drivers/pci/controller/dwc/pcie-uniphier.c
 
 PCIE DRIVER FOR ST SPEAR13XX
-- 
2.7.4

