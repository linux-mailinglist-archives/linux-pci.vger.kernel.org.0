Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68B3C70B7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhGMMxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 08:53:09 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44434
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236135AbhGMMxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 08:53:08 -0400
Received: from localhost (1.general.khfeng.us.vpn [10.172.68.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CCB6840613;
        Tue, 13 Jul 2021 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626180617;
        bh=VKTLYaxwHaurvjQpqIVYOmBUcfv3FuH+zrzCHFmaYmE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=uzd5MPvTl0ewwx6lTqNurVMdn+Y98K63CQoEcTf5B5Hvheg2M/IQ1kFuMRngHGNVT
         ABDgPZi3KmzlSGno2C/xMFqogj/5zqh5y1jyh+yeuvB0D5ryCxSC+9bE+HOHLsPU0l
         /gtLaG4s/0WbeJQJnnKbdYsE4gKNjDp228D1xai2PS9n+X4YOS4AzIEulR0ZXbi+FL
         6nAfwx6H9ueHStP1k3MaKW0H09OrKNsYZfWfs8RJnM4XYRsQtOD5CblaCy/IXscPRq
         xTXxnulJiCD7fPL/plVm4BL2i99FqrZo0CP5TiqzehRMYzobAK2XJGE/6Pq2vxIUCA
         ajg598zGCvMOA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: Reinstate "PCI: Coalesce host bridge contiguous apertures"
Date:   Tue, 13 Jul 2021 20:50:07 +0800
Message-Id: <20210713125007.1260304-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
can't get the BAR it needs:
  pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
  pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]

  pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
  pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
  pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
  pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
  pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
  pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
  pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window

However, the root bus has two contiguous apertures that can contain the
child resource requested.

Coalesce contiguous apertures so we can allocate from the entire contiguous
region.

This is the second take of commit 65db04053efe ("PCI: Coalesce host
bridge contiguous apertures"). The original approach sorts the apertures
by address, but that makes NVMe stop working on QEMU ppc:sam460ex:
  PCI host bridge to bus 0002:00
  pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
  pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
  pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])

After the offending commit:
  PCI host bridge to bus 0002:00
  pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
  pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
  pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])

Since the apertures on HP EliteDesk 805 G6 are already in ascending
order, doing a precautious sorting is not necessary.

Remove the sorting part to avoid the regression on ppc:sam460ex.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
Cc: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Bring back the original commit message.

 drivers/pci/probe.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..5de157600466 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -877,11 +877,11 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
-	struct resource_entry *window, *n;
+	struct resource_entry *window, *next, *n;
 	struct pci_bus *bus, *b;
-	resource_size_t offset;
+	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
-	struct resource *res;
+	struct resource *res, *next_res;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -961,11 +961,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Coalesce contiguous windows */
+	resource_list_for_each_entry_safe(window, n, &resources) {
+		if (list_is_last(&window->node, &resources))
+			break;
+
+		next = list_next_entry(window, node);
+		offset = window->offset;
+		res = window->res;
+		next_offset = next->offset;
+		next_res = next->res;
+
+		if (res->flags != next_res->flags || offset != next_offset)
+			continue;
+
+		if (res->end + 1 == next_res->start) {
+			next_res->start = res->start;
+			res->flags = res->start = res->end = 0;
+		}
+	}
+
 	/* Add initial resources to the bus */
 	resource_list_for_each_entry_safe(window, n, &resources) {
-		list_move_tail(&window->node, &bridge->windows);
 		offset = window->offset;
 		res = window->res;
+		if (!res->end)
+			continue;
+
+		list_move_tail(&window->node, &bridge->windows);
 
 		if (res->flags & IORESOURCE_BUS)
 			pci_bus_insert_busn_res(bus, bus->number, res->end);
-- 
2.31.1

