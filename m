Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2695765989
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfGKO6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 10:58:00 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:14953 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfGKO6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 10:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562857079; x=1594393079;
  h=from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:resent-from:resent-cc:date:
   content-transfer-encoding;
  bh=kBlveuRuLMfyuhTLyavKKcr81LjwYg6bfTMtC9Bgl7s=;
  b=U3UKbA9oqtompUxBpLHxyZHTHIXOZJjcAu/JAfY+YTeZptq1JTx2VUXl
   PNbJZ75P524YkMb4GA33BhcQJifZELeNvQ6z8r+Q9LvWLD8w6fmzfRj+1
   36SOrLMWS8TXueagITfrWkjuHhfQbXQ/7MC38p6O0/QhgGq/tGk+Bs1sN
   Y=;
X-IronPort-AV: E=Sophos;i="5.62,478,1554768000"; 
   d="scan'208";a="410282856"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 11 Jul 2019 14:57:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 12344A22F2;
        Thu, 11 Jul 2019 14:57:56 +0000 (UTC)
Received: from EX13D04UEA001.ant.amazon.com (10.43.61.40) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:57:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D04UEA001.ant.amazon.com (10.43.61.40) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:57:56 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.107.0.52) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Jul 2019 14:57:55 +0000
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Mailbox Transport; Wed, 10 Jul 2019 16:45:55 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Wed, 10 Jul 2019 16:45:54 +0000
Received: from email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 10 Jul 2019 16:45:54
 +0000
Received: by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix)
        id E2DCBA243C; Wed, 10 Jul 2019 16:45:52 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70]) by
 email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS
 id 5579BA18F9; Wed, 10 Jul 2019 16:45:52 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com (localhost [127.0.0.1]) by
 u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Debian-10) with ESMTP id
 x6AGjmRh022241; Wed, 10 Jul 2019 19:45:48 +0300
Received: (from jonnyc@localhost)
        by u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Submit) id x6AGjknT022047;
        Wed, 10 Jul 2019 19:45:46 +0300
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Message-ID: <20190710164519.17883-9-jonnyc@amazon.com>
In-Reply-To: <20190710164519.17883-1-jonnyc@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [PATCH 8/8] PCI: dw: Add support for
 PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags
Date:   Thu, 11 Jul 2019 17:57:54 +0300
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This basically aligns the usage of PCI_PROBE_ONLY and
PCI_REASSIGN_ALL_BUS in dw_pcie_host_init() with the logic in
pci_host_common_probe().

Now it will be possible to control via the devicetree whether to just
probe the PCI bus (in cases where FW already configured it) or to fully
configure it.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index d2ca748e4c85..0a294d8aa21a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -342,6 +342,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
=20
+	of_pci_check_probe_only();
+
 	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 					&bridge->windows, &pp->io_base);
 	if (ret)
@@ -474,6 +476,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
=20
 	pp->root_bus_nr =3D pp->busn->start;
=20
+	/* Do not reassign bus nums if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->dev.parent =3D dev;
 	bridge->sysdata =3D pp;
 	bridge->busnr =3D pp->root_bus_nr;
@@ -490,11 +496,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
=20
-	pci_bus_size_bridges(pp->root_bus);
-	pci_bus_assign_resources(pp->root_bus);
+	/*
+	 * We insert PCI resources into the iomem_resource and
+	 * ioport_resource trees in either pci_bus_claim_resources()
+	 * or pci_bus_assign_resources().
+	 */
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(pp->root_bus);
+	} else {
+		pci_bus_size_bridges(pp->root_bus);
+		pci_bus_assign_resources(pp->root_bus);
=20
-	list_for_each_entry(child, &pp->root_bus->children, node)
-		pcie_bus_configure_settings(child);
+		list_for_each_entry(child, &pp->root_bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
=20
 	pci_bus_add_devices(pp->root_bus);
 	return 0;
--=20
2.17.1


