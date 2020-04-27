Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768481BAC6D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD0SYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:18 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52938 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbgD0SYS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 91C3C4C852;
        Mon, 27 Apr 2020 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011853; x=1589826254; bh=ePTnXOA3THHbXiObLvUkfw0Gzk3MQelRp0i
        Yk8Skito=; b=WNObFeMHHDk32IjgXLs8gnxjradFO9vpPH/KXn4p/g1R2eg4hLg
        Ch0dtt3wTJIUldEH08RKGWkZHlcfmFdizrj1dtBJMbBpdr6juhXdsmRB+Na2Ve7w
        nZdPcnNgjH2oI6PU1APGEjvG8cbBsdAF80nn4tbT95J1JciM3HSAMbwo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KhmPKrL1HYuH; Mon, 27 Apr 2020 21:24:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 969D24C831;
        Mon, 27 Apr 2020 21:24:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:10 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 04/24] PCI: Add version of release_child_resources() aware of fixed BARs
Date:   Mon, 27 Apr 2020 21:23:38 +0300
Message-ID: <20200427182358.2067702-5-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
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

When release_child_resources() is applied to a bridge window, it drops the
.start field of children BARs to zero, but the STARTALIGN flag remains set,
leaving the resource in a state not valid for later re-assignment.

Fixed BARs must preserve their offset and size: those marked with the
PCI_FIXED or which are bound by drivers without support of the movable BARs
feature.

Add the pci_release_child_resources() to replace release_child_resources()
in handling the described PCI-specific cases.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bbcef1a053ab..1370e798db30 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1510,6 +1510,56 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
 	 IORESOURCE_MEM_64)
 
+/*
+ * Similar to generic release_child_resources(), but aware of fixed BARs and the
+ * STARTALIGN flag.
+ */
+static void pci_release_child_resources(struct pci_bus *bus, struct resource *r)
+{
+	struct pci_dev *dev;
+
+	if (!pci_can_move_bars)
+		return release_child_resources(r);
+
+	if (!bus || !r)
+		return;
+
+	r->child = NULL;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *tmp = &dev->resource[i];
+			resource_size_t size = resource_size(tmp);
+
+			if (!tmp->flags || !tmp->parent)
+				continue;
+
+			tmp->parent = NULL;
+			tmp->sibling = NULL;
+
+			pci_release_child_resources(dev->subordinate, tmp);
+
+			tmp->flags &= ~IORESOURCE_STARTALIGN;
+			tmp->flags |= IORESOURCE_SIZEALIGN;
+
+			if (pci_dev_bar_fixed(dev, tmp)) {
+				pci_dbg(dev, "release fixed BAR %d %pR (%s), keep its flags, base and size\n",
+					i, tmp, tmp->name);
+				continue;
+			}
+
+			pci_dbg(dev, "release BAR %d %pR (%s)\n", i, tmp, tmp->name);
+
+			if (i >= PCI_BRIDGE_RESOURCES)
+				tmp->flags = 0;
+			tmp->start = 0;
+			tmp->end = size - 1;
+		}
+	}
+}
+
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					 unsigned long type)
 {
@@ -1550,7 +1600,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		return;
 
 	/* If there are children, release them all */
-	release_child_resources(r);
+	pci_release_child_resources(bus, r);
+
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_info(dev, "resource %d %pR released\n",
-- 
2.24.1

