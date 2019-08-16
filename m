Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1590619
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHPQvP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:15 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51338 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfHPQvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 972BB42EED;
        Fri, 16 Aug 2019 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974272; x=1567788673; bh=UUdHgJhxaQgfi4cl/ddzHCHCSLhs0rYnkXJ
        xePQqKTs=; b=o5TMjxJQxe2kEbdyHgVWbT+anifvu1C6KqBVPFnITzDf5sq1gWn
        ZTmnaiKdO8XH8yIOlGFbbvcekOlaXtWoJ+TCvd0SDo4yCboWobCWhc6nkKSeZIYA
        7cidBZFdwINyGE5cHeTxfUyQquJn4R7W8QzPyvbR+hq+5JWUWYWf6nB4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HKy2jYnnkb5n; Fri, 16 Aug 2019 19:51:12 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8DFED42ECB;
        Fri, 16 Aug 2019 19:51:10 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:09 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 05/23] PCI: hotplug: movable BARs: Fix reassigning the released bridge windows
Date:   Fri, 16 Aug 2019 19:50:43 +0300
Message-ID: <20190816165101.911-6-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a bridge window is temporarily released during the rescan, its old
size is not relevant anymore - it will be recreated from pbus_size_*(), so
it's start value should be zero.

If such window can't be reassigned, don't apply reset_resource(), so the
next retry may succeed.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6cb8b293c576..7c2c57f77c6f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -295,7 +295,8 @@ static void assign_requested_resources_sorted(struct list_head *head,
 						    0 /* don't care */,
 						    0 /* don't care */);
 			}
-			reset_resource(res);
+			if (!pci_movable_bars_enabled())
+				reset_resource(res);
 		}
 	}
 }
@@ -1579,8 +1580,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_info(dev, "resource %d %pR released\n",
 			 PCI_BRIDGE_RESOURCES + idx, r);
-		/* Keep the old size */
-		r->end = resource_size(r) - 1;
+		/* Don't keep the old size if the bridge will be recalculated */
+		r->end = pci_movable_bars_enabled() ? 0 : (resource_size(r) - 1);
 		r->start = 0;
 		r->flags = 0;
 
-- 
2.21.0

