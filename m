Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BEC71518
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfGWJ1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 05:27:31 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52938 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGWJ1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 05:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563874050; x=1595410050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=b531SE6MRYpUt8mqMq6kBzbDUygX4l0/zWJlNrWTyTY=;
  b=BvJfvYvwcgjfN2d6+V5bI632bWVUO3FhL9XJlC/xiYyJfjz3hKklpTPt
   SWj6akCCMQGut0ommegz8xfJIohQGko6a3wHKF4QPJlOxvMzeDOedJAuJ
   A8Duypw1EZ/RKXAAV1Tzh/fDOz9mDBwz31Vb6unDl2TNPyFBk0DDt9NgQ
   c=;
X-IronPort-AV: E=Sophos;i="5.64,298,1559520000"; 
   d="scan'208";a="775794056"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Jul 2019 09:27:28 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id CF43DA272C;
        Tue, 23 Jul 2019 09:27:27 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:27:27 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.85) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:27:22 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v3 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
Date:   Tue, 23 Jul 2019 12:27:08 +0300
Message-ID: <20190723092711.11786-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723092529.11310-1-jonnyc@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.85]
X-ClientProxiedBy: EX13D27UWB003.ant.amazon.com (10.43.161.195) To
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

