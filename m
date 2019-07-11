Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADADB65983
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfGKO5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 10:57:38 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13004 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfGKO5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 10:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562857056; x=1594393056;
  h=from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:resent-from:resent-cc:date:
   content-transfer-encoding;
  bh=SYZgMArpkzpBbvlUdyauitCtfev5fx4+hkch/ia3KZc=;
  b=wFwDX3QbGZs+vfhHXqyJymIMg4Jo5QSbNVYMcf2WTZ5gtINGWSZlp8Qr
   IlE5cGfrHtbT3GD6BWqsx2XcN2EX0P++MKIMWPGhPgN5bBrWijHKLNWoP
   2u08CzBHk42P3xHg+ic2NCozOB4qhEU3jNqsAvrfQHAZxBFxcjI2buIoN
   s=;
X-IronPort-AV: E=Sophos;i="5.62,478,1554768000"; 
   d="scan'208";a="810659079"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Jul 2019 14:57:35 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 2D526A2214;
        Thu, 11 Jul 2019 14:57:33 +0000 (UTC)
Received: from EX13D14UWC002.ant.amazon.com (10.43.162.214) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:57:33 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D14UWC002.ant.amazon.com (10.43.162.214) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:57:33 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.107.0.52) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Jul 2019 14:57:31 +0000
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Mailbox Transport; Wed, 10 Jul 2019 16:45:51 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Wed, 10 Jul 2019 16:45:51 +0000
Received: from email-inbound-relay-1e-a70de69e.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 10 Jul 2019 16:45:50
 +0000
Received: by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix)
        id 96A7EA22C5; Wed, 10 Jul 2019 16:45:50 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com
 (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210]) by
 email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS
 id AAF00A1C3B; Wed, 10 Jul 2019 16:45:49 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com (localhost [127.0.0.1]) by
 u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Debian-10) with ESMTP id
 x6AGjjbZ021998; Wed, 10 Jul 2019 19:45:45 +0300
Received: (from jonnyc@localhost)
        by u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Submit) id x6AGjhfP021960;
        Wed, 10 Jul 2019 19:45:43 +0300
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Message-ID: <20190710164519.17883-8-jonnyc@amazon.com>
In-Reply-To: <20190710164519.17883-1-jonnyc@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [PATCH 7/8] PCI: dw: Add validation that PCIe core is set to
 correct mode
Date:   Thu, 11 Jul 2019 17:57:30 +0300
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCIe controllers can be set to either Host or EP according to some
early boot FW. To make sure there is no discrepancy (e.g. FW configured
the port to EP mode while the DT specifies it as a host bridge or vice
versa), a check has been added for each mode.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/=
controller/dwc/pcie-designware-ep.c
index 2bf5a35c0570..00e59a134b93 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -531,6 +531,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	int ret;
 	u32 reg;
 	void *addr;
+	u8 hdr_type;
 	unsigned int nbars;
 	unsigned int offset;
 	struct pci_epc *epc;
@@ -543,6 +544,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 	}
=20
+	hdr_type =3D dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	if (hdr_type !=3D PCI_HEADER_TYPE_NORMAL) {
+		dev_err(pci->dev, "PCIe controller is not set to EP mode (hdr_type:0x%x)=
!\n",
+			hdr_type);
+		return -EIO;
+	}
+
 	ret =3D of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
 	if (ret < 0) {
 		dev_err(dev, "Unable to read *num-ib-windows* property\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index f93252d0da5b..d2ca748e4c85 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -323,6 +323,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
+	u8 hdr_type;
 	int ret;
=20
 	raw_spin_lock_init(&pci->pp.lock);
@@ -396,6 +397,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
=20
+	hdr_type =3D dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	if (hdr_type !=3D PCI_HEADER_TYPE_BRIDGE) {
+		dev_err(pci->dev, "PCIe controller is not set to bridge type (hdr_type: =
0x%x)!\n",
+			hdr_type);
+		return -EIO;
+	}
+
 	pp->mem_base =3D pp->mem->start;
=20
 	if (!pp->va_cfg0_base) {
--=20
2.17.1


