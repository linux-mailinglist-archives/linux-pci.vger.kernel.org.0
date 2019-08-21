Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C292F97F51
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfHUPsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 11:48:13 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1924 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfHUPsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 11:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566402492; x=1597938492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wQjlWaSSf3woZCwa9y0Q/yXBW7QLUurCmgMfNw66kl4=;
  b=iU0r+yZ8NOhTXnCrV1qE/IzXiqx1OdAS+o3+DLC7KEdnewM12lIUEciF
   oRld54y7cjM9BsRwfoDHyzLzJI8sQipfeH8MsLMnlWEgq3EbtVj7VYlmx
   CGM/eGiMCPNVc7R0LD62LU2lJwNIMG1Ww285SEQkPSCxXXAfTc9Sh9Buf
   I=;
X-IronPort-AV: E=Sophos;i="5.64,412,1559520000"; 
   d="scan'208";a="696100875"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Aug 2019 15:48:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 25768A2890;
        Wed, 21 Aug 2019 15:48:04 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:48:04 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.230) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:47:57 +0000
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
Subject: [PATCH v4 5/7] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
Date:   Wed, 21 Aug 2019 18:47:43 +0300
Message-ID: <20190821154745.31834-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821153545.17635-1-jonnyc@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.230]
X-ClientProxiedBy: EX13D12UWA002.ant.amazon.com (10.43.160.88) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document Amazon's Annapurna Labs PCIe host bridge.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
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

