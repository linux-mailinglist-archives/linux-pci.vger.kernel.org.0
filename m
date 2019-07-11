Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5D65949
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGKOpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 10:45:49 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:18470 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGKOps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 10:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562856347; x=1594392347;
  h=from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:resent-from:resent-cc:date:
   content-transfer-encoding;
  bh=rEwhUcItizhTKKQJkJSUZmJogRweHOEiCZMdT5sfIX4=;
  b=ZLvIvWQSBJmF3lhBHejZTopb3tnZQh7cF+z4KXsQPTy/2sQr/ncEShB0
   tXDDEYkvbWpROktRjkPqXw048uqhR70MMsHuQOJ9I46L7nt+iuOsgl7uI
   Brc3Xk4X/44ZxsMse4/1tX5eojdzL7AGFkTez6gNARV1XSERI5P4smycH
   M=;
X-IronPort-AV: E=Sophos;i="5.62,478,1554768000"; 
   d="scan'208";a="815639539"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Jul 2019 14:45:45 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 7D50DA2205;
        Thu, 11 Jul 2019 14:45:45 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:45:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:45:44 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.107.0.52) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Jul 2019 14:45:42 +0000
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Mailbox Transport; Wed, 10 Jul 2019 16:45:46 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Wed, 10 Jul 2019 16:45:46 +0000
Received: from email-inbound-relay-1d-98acfc19.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 10 Jul 2019 16:45:45
 +0000
Received: by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix)
        id 6CB35A2515; Wed, 10 Jul 2019 16:45:44 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com
 (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214]) by
 email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS
 id 80A84A20A2; Wed, 10 Jul 2019 16:45:43 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com (localhost [127.0.0.1]) by
 u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Debian-10) with ESMTP id
 x6AGjd5W021757; Wed, 10 Jul 2019 19:45:39 +0300
Received: (from jonnyc@localhost)
        by u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Submit) id x6AGjbb8021728;
        Wed, 10 Jul 2019 19:45:37 +0300
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Message-ID: <20190710164519.17883-6-jonnyc@amazon.com>
In-Reply-To: <20190710164519.17883-1-jonnyc@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [PATCH 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host
 bridge binding
Date:   Thu, 11 Jul 2019 17:45:41 +0300
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document Amazon's Annapurna Labs PCIe host bridge.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 .../devicetree/bindings/pci/pcie-al.txt       | 45 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentat=
ion/devicetree/bindings/pci/pcie-al.txt
new file mode 100644
index 000000000000..d92cc529490e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
@@ -0,0 +1,45 @@
+* Amazon Annapurna Labs PCIe host bridge
+
+Annapurna Labs' PCIe Host Controller is based on the Synopsys DesignWare
+PCI core.
+It shares common functions with the PCIe DesignWare core driver and inheri=
ts
+common properties defined in Documentation/devicetree/bindings/pci/designw=
are-pcie.txt.
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
+	pcie-external0 {
+		compatible =3D "amazon,al-pcie";
+		reg =3D <0x0 0xfb600000 0x0 0x00100000
+		       0x0 0xfd800000 0x0 0x00010000
+		       0x0 0xfd810000 0x0 0x00001000>;
+		reg-names =3D "config", "controller", "dbi";
+		bus-range =3D <0 255>;
+		device_type =3D "pci";
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+		interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask =3D <0x00 0 0 7>;
+		interrupt-map =3D <0x0000 0 0 1 &gic_main GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH=
>; /* INTa */
+		ranges =3D <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 5a6137df3f0e..d555beb794bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12205,6 +12205,7 @@ PCIE DRIVER FOR ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/pcie-al.txt
 F:	drivers/pci/controller/dwc/pcie-al.c
=20
 PCIE DRIVER FOR AMLOGIC MESON
--=20
2.17.1


