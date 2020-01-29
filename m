Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EB14CD67
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgA2PaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:05 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55796 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbgA2PaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1979147636;
        Wed, 29 Jan 2020 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311802; x=1582126203; bh=LePmfUy5jBiOSlUl6/64rkHu27lOHQ/BxZ3
        oJp3VpYI=; b=Ai42t2NQbFXgWEnyuoUuiU87m9IF19qVcRcT1YdXN379jkNR5YQ
        ecMwg2ZTGVp5RurqHbe7+k2/e6E88XC/74xnn+9RtpnUL/PDXSQDyzTLdp3SNHpS
        VzY8HXYekC+qxSq5TWeZreUc1S6FY10mH4AmaNII7HKfJYKT8Y8Jcbok=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gX9YbeXGe1iu; Wed, 29 Jan 2020 18:30:02 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 123CE47613;
        Wed, 29 Jan 2020 18:29:54 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:53 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 17/26] PCI: hotplug: Ignore the MEM BAR offsets from BIOS/bootloader
Date:   Wed, 29 Jan 2020 18:29:28 +0300
Message-ID: <20200129152937.311162-18-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BAR allocation by BIOS/UEFI/bootloader/firmware may be non-optimal and
it may even clash with the kernel's BAR assignment algorithm.

For example, sometimes BIOS doesn't reserve space for SR-IOV BARs, and
this bridge window can neither extend (blocked by immovable BARs) nor
move (the device itself is immovable).

With this patch the kernel will use its own methods of BAR allocating
when possible, increasing the chances of successful boot and hotplug.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bb584038d5b4..f8f643dac6d1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -306,6 +306,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			 pos, (unsigned long long)region.start);
 	}
 
+	if (pci_can_move_bars && res->start && !(res->flags & IORESOURCE_IO)) {
+		pci_warn(dev, "ignore the current offset of BAR %llx-%llx\n",
+			 l64, l64 + sz64 - 1);
+		res->start = 0;
+		res->end = sz64 - 1;
+		res->flags |= IORESOURCE_SIZEALIGN;
+	}
+
 	goto out;
 
 
@@ -528,8 +536,10 @@ void pci_read_bridge_bases(struct pci_bus *child)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
 	pci_read_bridge_io(child);
-	pci_read_bridge_mmio(child);
-	pci_read_bridge_mmio_pref(child);
+	if (!pci_can_move_bars) {
+		pci_read_bridge_mmio(child);
+		pci_read_bridge_mmio_pref(child);
+	}
 
 	if (dev->transparent) {
 		pci_bus_for_each_resource(child->parent, res, i) {
@@ -2945,6 +2955,8 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 		pci_bus_claim_resources(bus);
 	} else {
 		pci_bus_size_bridges(bus);
+		if (pci_can_move_bars)
+			pci_bus_update_realloc_range(bus);
 		pci_bus_assign_resources(bus);
 
 		list_for_each_entry(child, &bus->children, node)
-- 
2.24.1

