Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D153A34859
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfFDNTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:19:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35448 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfFDNTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:19:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DIwIF092220;
        Tue, 4 Jun 2019 08:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654339;
        bh=5pm3KNyMGROABT0JcoQQvXj/6/ZjaGGLyc7JbsFcHVA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pvsfkqLWhaymyXTVWb5IvLN5Q2tA1bmzOcf/Kr2Cq6Y7Lgvgk+d9WuhwzNAya6dNR
         Jpqe0FfYt8vjfJR/8LTJBbdO2YHjEPCcKnpoomUMMpSlcHZ3vI6AGn8CL8F1SLV4SG
         xL2wMQTK6Vuif76EuKez0R+HKMnLXSqpTMT6AQ54=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DIwNg009979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:18:58 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:18:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:18:58 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGe098972;
        Tue, 4 Jun 2019 08:18:53 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 24/30] dt-bindings: PCI: J721E: Add DT bindings for PCIe controller in J721E
Date:   Tue, 4 Jun 2019 18:45:10 +0530
Message-ID: <20190604131516.13596-25-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree binding documentation for PCIe controller in J721E SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci.txt  | 63 +++++++++++++++++++
 include/dt-bindings/pci/pci.h                 | 12 ++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci.txt
 create mode 100644 include/dt-bindings/pci/pci.h

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci.txt b/Documentation/devicetree/bindings/pci/ti,j721e-pci.txt
new file mode 100644
index 000000000000..9132eff7ea0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci.txt
@@ -0,0 +1,63 @@
+PCI Controller in J721E:
+Required Properties:
+ - compatible: Should be "ti,j721e-pcie"
+ - reg : Two register ranges as listed in the reg-names property
+ - reg-names : The first entry must be "intd_cfg" used for handling legacy
+     interrupts. The second entry must be "user_cfg" and it has registers
+     for enabling the LTSSM. The third entry must be "vmap" and it has
+     registers for programming the requestor ID to VIRTID mapping and ATYPE.
+ - #address-cells : should be 1 to indicate the child node should use 1 cell
+     for address
+ - #size-cells : should be 1 to indicate the child node should use 1 cell for
+     size
+ - mode : should be <PCI_MODE_RC> for RC mode and should be <PCI_MODE_EP> for
+     EP mode
+
+Optional Properties:
+ - max-link-speed: As defined in Documentation/devicetree/bindings/pci/pci.txt
+     Default is GEN3
+ - num-lanes: number of lanes to use. Default is '1' lane
+It should have two child nodes, one for RC mode (pcie) and the other for EP
+mode (pcie-ep). The child node for RC should follow the binding in
+cdns,cdns-pcie-host.txt. The child node for the EP should follow the binding
+in cdns,cdns-pcie-ep.txt
+
+Example:
+	pcie0: pcie@2900000 {
+		compatible = "ti,j721e-pcie";
+		reg = <0x02900000 0x1000>,
+		      <0x02907000 0x400>;
+		reg-names = "intd_cfg", "user_cfg";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pcie0_rc: pcie@d000000 {
+			compatible = "cdns,cdns-pcie-host";
+			reg = <0x0d000000 0x00800000>,
+			      <0x10000000 0x00001000>,
+			      <0x10000000 0x08000000>;
+			reg-names = "reg", "cfg", "mem";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x0 0xff>;
+			linux,pci-domain = <0>;
+			cdns,max-outbound-regions = <16>;
+			cdns,no-bar-match-nbits = <32>;
+			vendor-id = /bits/ 16 <0x17cd>;
+			device-id = /bits/ 16 <0x0200>;
+			msi-map = <0x0 &gic_its 0x0 0x1000>;
+			ranges = <0x01000000 0x0 0x10001000  0x10001000  0x0 0x0010000>,
+				 <0x02000000 0x0 0x10011000  0x10011000  0x0 0x7fef000>;
+		};
+
+		pcie0_ep: pcie-ep@d000000 {
+			compatible = "cdns,cdns-pcie-ep";
+			reg = <0x0d000000 0x00800000>,
+			      <0x10000000 0x08000000>;
+			reg-names = "reg", "mem";
+			cdns,max-outbound-regions = <16>;
+			max-functions = /bits/ 8 <2>;
+		};
+	};
diff --git a/include/dt-bindings/pci/pci.h b/include/dt-bindings/pci/pci.h
new file mode 100644
index 000000000000..6fe7ccaf9e99
--- /dev/null
+++ b/include/dt-bindings/pci/pci.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for PCI bindings.
+ */
+
+#ifndef _DT_BINDINGS_PCI_H
+#define _DT_BINDINGS_PCI_H
+
+#define PCI_MODE_RC		1
+#define PCI_MODE_EP		2
+
+#endif
-- 
2.17.1

