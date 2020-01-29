Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03F614CD53
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgA2P34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:29:56 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55788 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgA2P34 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6AE634761A;
        Wed, 29 Jan 2020 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311794; x=1582126195; bh=qCJ684UfztdQ8GmZ4DdMqFhe7FDmUKT2og3
        ldW7el80=; b=F7USgEFbzOvRsiFy/9se1UbLySbQBL1F7WcucRFPqeBx1eqY6Vi
        9XndO0f0ED3soefu1ErZT1qE1wYL0Mbo0qNxiWEAsz9tk94HA5DVd7DusV1/Bsno
        qdFNlCW6CBJL03VUpmZMzvhQ7kSymYEe30CC8ZbbGgZPPobBDEF9qfMY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kZVzFQ9YJURe; Wed, 29 Jan 2020 18:29:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0FD1747607;
        Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:51 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 05/26] PCI: hotplug: Fix reassigning the released BARs
Date:   Wed, 29 Jan 2020 18:29:16 +0300
Message-ID: <20200129152937.311162-6-s.miroshnichenko@yadro.com>
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

Bridge windows are temporarily released during a PCI rescan, and their old
size is not relevant anymore - it will be recreated in pbus_size_*() from
scratch. To make these functions work correctly, set zero size of released
windows.

If BAR assignment fails after a PCI hotplug event, the kernel will retry
with a fall-back reduced configuration, so don't apply reset_resource() for
non-window BARs to keep them valid for the next attempt.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4c464430478f..2cf07003d5fc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -295,7 +295,9 @@ static void assign_requested_resources_sorted(struct list_head *head,
 						    0 /* don't care */,
 						    0 /* don't care */);
 			}
-			reset_resource(res);
+			if (!pci_can_move_bars ||
+			    idx >= PCI_BRIDGE_RESOURCES)
+				reset_resource(res);
 		}
 	}
 }
@@ -1597,8 +1599,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_info(dev, "resource %d %pR released\n",
 			 PCI_BRIDGE_RESOURCES + idx, r);
-		/* Keep the old size */
-		r->end = resource_size(r) - 1;
+		/* Don't keep the old size if the bridge will be recalculated */
+		r->end = pci_can_move_bars ? 0 : (resource_size(r) - 1);
 		r->start = 0;
 		r->flags = 0;
 
-- 
2.24.1

