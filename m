Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9B14CD69
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgA2PaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:05 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55828 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgA2PaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B57D247614;
        Wed, 29 Jan 2020 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311802; x=1582126203; bh=cbU3IietN3svDQF6So1LqazSgtFc4F5LGyV
        nl7Okf+Q=; b=s4OZWPdWCISm6VC6fsLv/XGZ24jwsJBqKgwZ7k7UOVbqfBzZ8Wp
        jx3Aau3QwP7E0dfwgrU6kaaZMQtBNbynxGnO6wSS6+vnDtB+hPQbq1mXrXXwiff/
        iLYqPufDTYr24jlCF984F/PWQsJVp9ckUflHdYlDjIkkOWlExJbQiADo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wA2O9P8Tx_Zu; Wed, 29 Jan 2020 18:30:02 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4025247615;
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
Subject: [PATCH v7 18/26] PCI: Treat VGA BARs as immovable
Date:   Wed, 29 Jan 2020 18:29:29 +0300
Message-ID: <20200129152937.311162-19-s.miroshnichenko@yadro.com>
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

Some framebuffer drivers (efifb) don't act as a PCI driver (like nouveau),
but take information about BARs indirectly - from BIOS for example. This
makes them vulnerable to BAR movement during boot, when setting reported by
BIOS/bootloader differs from new addresses assigned by the kernel.

Until every such driver is aware of movable BARs, mark every VGA BAR as
immovable. Perhaps this is also useful for splash screens, so they don't
flicker.

This makes some BARs and bridge windows immovable during boot, so update
the parent's struct pci_bus->immovable_range when encountered.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f8f643dac6d1..b810d28ebf96 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -164,6 +164,20 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
 
 #define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
 
+static void expand_immovable_range(struct pci_bus *bus, struct resource *res, int idx)
+{
+	struct resource *immovable_range = &bus->immovable_range[idx];
+
+	if (!immovable_range->start || immovable_range->start > res->start)
+		immovable_range->start = res->start;
+
+	if (immovable_range->end < res->end)
+		immovable_range->end = res->end;
+
+	if (bus->parent)
+		expand_immovable_range(bus->parent, immovable_range, idx);
+}
+
 /**
  * pci_read_base - Read a PCI BAR
  * @dev: the PCI device
@@ -307,11 +321,16 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	}
 
 	if (pci_can_move_bars && res->start && !(res->flags & IORESOURCE_IO)) {
-		pci_warn(dev, "ignore the current offset of BAR %llx-%llx\n",
-			 l64, l64 + sz64 - 1);
-		res->start = 0;
-		res->end = sz64 - 1;
-		res->flags |= IORESOURCE_SIZEALIGN;
+		if ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
+			expand_immovable_range(dev->bus, res,
+					       pci_get_bridge_resource_idx(res));
+		} else {
+			pci_warn(dev, "ignore the current offset of BAR %llx-%llx\n",
+				 l64, l64 + sz64 - 1);
+			res->start = 0;
+			res->end = sz64 - 1;
+			res->flags |= IORESOURCE_SIZEALIGN;
+		}
 	}
 
 	goto out;
@@ -3164,6 +3183,11 @@ bool pci_dev_bar_movable(struct pci_dev *dev, struct resource *res)
 	if (region.start == 0xa0000)
 		return false;
 
+	if (res->start &&
+	    !(res->flags & IORESOURCE_IO) &&
+	    (dev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+		return false;
+
 	if (!dev->driver && !res->child)
 		return true;
 
-- 
2.24.1

