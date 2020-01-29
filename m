Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8653314CD5F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgA2PaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:01 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55796 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbgA2PaA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 00CC947625;
        Wed, 29 Jan 2020 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311796; x=1582126197; bh=bWnPaZUGtbi755uNVGa6pv8QekKJ1F945uz
        Qa4YKads=; b=BFcO7pGtHhDhpnYj12iWmNGEnNJgLpsLtC8ou+5xfIqQh5BUAM8
        xL4lPmbIEpPJwM1GEfSPu0hUk+snWgaza/l2PshXKlK/0nU9lrDlg9+yBur91GA6
        Sxvrcz3K7EqEQjKQwJpp3r+llVWSHaeimyZmyjVzZZDkrxf0GLCmvu3E=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kjgEAHxNDe3v; Wed, 29 Jan 2020 18:29:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 945E44760F;
        Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:52 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 10/26] PCI: Include fixed and immovable BARs into the bus size calculating
Date:   Wed, 29 Jan 2020 18:29:21 +0300
Message-ID: <20200129152937.311162-11-s.miroshnichenko@yadro.com>
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

The only difference between the fixed/immovable and movable BARs is a size
and offset preservation after they are released (the corresponding struct
resource* detached from a bridge window for a while during a bus rescan).

Include fixed/immovable BARs into result of pbus_size_mem().

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e87fefa12f62..5874c352b41e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -891,6 +891,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
+	resource_size_t fixed_start = bus->immovable_range[0].start;
+	resource_size_t fixed_end = bus->immovable_range[0].end;
+	resource_size_t fixed_size = (fixed_start < fixed_end) ?
+		(fixed_end - fixed_start + 1) : 0;
+
 	if (!b_res)
 		return;
 
@@ -898,6 +903,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (b_res->parent)
 		return;
 
+	if (min_size < fixed_size)
+		min_size = fixed_size;
+
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
@@ -1006,6 +1014,15 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	int idx = pci_get_bridge_resource_idx(b_res);
+
+	resource_size_t fixed_start = bus->immovable_range[idx].start;
+	resource_size_t fixed_end = bus->immovable_range[idx].end;
+	resource_size_t fixed_size = (fixed_start < fixed_end) ?
+		(fixed_end - fixed_start + 1) : 0;
+
+	if (min_size < fixed_size)
+		min_size = fixed_size;
 
 	if (!b_res)
 		return -ENOSPC;
@@ -1028,12 +1045,22 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
 
-			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+			if (r->parent ||
 			    ((r->flags & mask) != type &&
 			     (r->flags & mask) != type2 &&
 			     (r->flags & mask) != type3))
 				continue;
 			r_size = resource_size(r);
+
+			if (pci_can_move_bars && !pci_dev_bar_movable(dev, r)) {
+				size += r_size;
+
+				continue;
+			} else if (!pci_can_move_bars &&
+				   (r->flags & IORESOURCE_PCI_FIXED)) {
+				continue;
+			}
+
 #ifdef CONFIG_PCI_IOV
 			/* Put SRIOV requested res to the optional list */
 			if (realloc_head && i >= PCI_IOV_RESOURCES &&
-- 
2.24.1

