Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB8AA552
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfIEOCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 10:02:08 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:32843 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbfIEOCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 10:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567692127; x=1599228127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mtcExX1DvgKeY32dgd0YJY2ICHMN8S9nv5NWZ+RR3o4=;
  b=durBodr0/8S1iwKNQfRpSYss+rZq2byg+3ltJ4FLMbBpK3jJbAYtpNE7
   SLohyW0mv2MwZtwPpwOg3lTI7OVuj1UfhdXTjCfQKEaZeU9tslFinVXGr
   2IMt5uNrzPCNTpvHZUc79CKkALidOOwRX6KZuq32fo6oIzcMK7i+wqsNY
   I=;
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="419628744"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 05 Sep 2019 14:02:06 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 6ACFEA2B70;
        Thu,  5 Sep 2019 14:02:03 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 14:02:03 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.29) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 14:01:56 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <andrew.murray@arm.com>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <alisaidi@amazon.com>,
        <ronenk@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v5 5/7] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
Date:   Thu, 5 Sep 2019 17:01:42 +0300
Message-ID: <20190905140144.7933-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905140018.5139-1-jonnyc@amazon.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.29]
X-ClientProxiedBy: EX13D10UWB004.ant.amazon.com (10.43.161.121) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document Amazon's Annapurna Labs PCIe host bridge.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/pcie-al.txt       | 46 +++++++++++++++++++
 MAINTAINERS                                   |  3 +-
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
new file mode 100644
index 000000000000..557a5089229d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
@@ -0,0 +1,46 @@
+* Amazon Annapurna Labs PCIe host bridge
+
+Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
+PCI core. It inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+Properties of the host controller node that differ from it are:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Value should contain
+			- "amazon,al-alpine-v2-pcie" for alpine_v2
+			- "amazon,al-alpine-v3-pcie" for alpine_v3
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
+		compatible = "amazon,al-alpine-v3-pcie";
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
index 783569e3c4b4..d200b16fa95c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12448,10 +12448,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
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

