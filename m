Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0D2DE86C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgLRRmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:33 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38566 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728091AbgLRRmc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B41DA413E4;
        Fri, 18 Dec 2020 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313270; x=1610127671; bh=p5ojM85KzuWw1dn9l+gXPAqRVLagkNKnmBV
        ORTqlbZE=; b=OY31YfUjLhcfhtdd//+0ypfwU582Op4Er9rZs90hmLIFeUrB7WB
        y+t92Yu42Hf5ekeeoiEOXseaIC+FgsFXsCjnRGnRQsvel2QBZPxgkgD2hSz/MZLt
        iwxadU07nppfZjQ9/+GOoM0xAYRJJ4eM/pKZ1q4NyXShiMpwOQ9AiceQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xHt6f202nBdK; Fri, 18 Dec 2020 20:41:10 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8B67A41395;
        Fri, 18 Dec 2020 20:41:07 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:06 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 05/26] PCI: hotplug: Fix reassigning the released BARs
Date:   Fri, 18 Dec 2020 20:39:50 +0300
Message-ID: <20201218174011.340514-6-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bridge windows are temporarily released during a PCI rescan, and their old
sizes are not relevant anymore as they will be recreated in pbus_size_*()
from scratch. So don't keep it, but instead set to zero after release.

If BAR assignment fails after a PCI hotplug event, the kernel will retry
with a fall-back reduced configuration, so don't apply reset_resource() for
non-window BARs to keep them valid for the next attempt.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bc342eaa98e8..a956f0179064 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -297,7 +297,9 @@ static void assign_requested_resources_sorted(struct list_head *head,
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
@@ -1616,8 +1618,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
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

