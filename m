Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891A06CC3A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGRJrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jul 2019 05:47:42 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:22672 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRJrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 05:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563443261; x=1594979261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=b531SE6MRYpUt8mqMq6kBzbDUygX4l0/zWJlNrWTyTY=;
  b=QDOW68cvXgwzAFzGuwYqFRqY4m0Jkb6o39LSxkyJW/dseUpDEmbzFrBU
   T9aI4eKU1VyiWm9yZEl/CvORR9L9qFpXaBVJaIV5yBhUeKDuT/NJLxcP7
   V66MoIK+kd00Qft+cp4meqxs6eB9IezwJteSP/q3Im0P0OYF+muPtyGPN
   w=;
X-IronPort-AV: E=Sophos;i="5.64,276,1559520000"; 
   d="scan'208";a="405475062"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Jul 2019 09:47:40 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 36DAEA207A;
        Thu, 18 Jul 2019 09:47:36 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:47:36 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.219) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:47:30 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v2 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
Date:   Thu, 18 Jul 2019 12:47:15 +0300
Message-ID: <20190718094718.25083-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718094531.21423-1-jonnyc@amazon.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.219]
X-ClientProxiedBy: EX13D19UWC001.ant.amazon.com (10.43.162.64) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document Amazon's Annapurna Labs PCIe host bridge.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 .../devicetree/bindings/pci/pcie-al.txt       | 45 +++++++++++++++++++
 MAINTAINERS                                   |  3 +-
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
new file mode 100644
index 000000000000..89876190eb5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
@@ -0,0 +1,45 @@
+* Amazon Annapurna Labs PCIe host bridge
+
+Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
+PCI core.
+It shares common functions with the PCIe DesignWare core driver and inherits
+common properties defined in Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Properties of the host controller node that differ from it are:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Value should contain
+			- "amazon,al-pcie"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Register ranges as listed in the reg-names property
+
+- reg-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must include the following entries
+			- "config"	PCIe ECAM space
+			- "controller"	AL proprietary registers
+			- "dbi"		Designware PCIe registers
+
+Example:
+
+	pcie-external0: pcie@fb600000 {
+		compatible = "amazon,al-pcie";
+		reg = <0x0 0xfb600000 0x0 0x00100000
+		       0x0 0xfd800000 0x0 0x00010000
+		       0x0 0xfd810000 0x0 0x00001000>;
+		reg-names = "config", "controller", "dbi";
+		bus-range = <0 255>;
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0x00 0 0 7>;
+		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
+		ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 5a6137df3f0e..29cca14a05a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12201,10 +12201,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
 S:	Supported
 F:	drivers/pci/controller/
 
-PCIE DRIVER FOR ANNAPURNA LABS
+PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/pcie-al.txt
 F:	drivers/pci/controller/dwc/pcie-al.c
 
 PCIE DRIVER FOR AMLOGIC MESON
-- 
2.17.1

