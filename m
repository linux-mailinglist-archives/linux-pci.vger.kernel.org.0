Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411E52DE870
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgLRRmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:36 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38578 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731531AbgLRRmg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:36 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B5B8F413ED;
        Fri, 18 Dec 2020 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313274; x=1610127675; bh=zjewFlS8iSFSK0HyEJh9bkkMelhEy1KUPYf
        eiAbNkMk=; b=KGD1sxQYogCuy/K1W0aeRv/FPret59Uzc0Qp6pPWcwpBv1YdJkB
        fqXQeb1eQ9c7sHrJeCRXW3owA4c7zztn5tmd4p9xWJr2Y/KsJ/x7ELOkfSKvQY2c
        e8hypSOG97SGr7b3xOqvJXEUqPxRt4fjYqSu4Wdo8tiUbYZ36cF2IdoY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j4e6qikAwRNc; Fri, 18 Dec 2020 20:41:14 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0782B413B5;
        Fri, 18 Dec 2020 20:41:08 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:07 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 11/26] PCI: Include fixed BARs into the bus size calculating
Date:   Fri, 18 Dec 2020 20:39:56 +0300
Message-ID: <20201218174011.340514-12-s.miroshnichenko@yadro.com>
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

The only difference between fixed and movable BARs is a size and offset
preservation after they are released (the corresponding struct resource* is
detached from a bridge window for a while during a bus rescan). So fixed
BARs should not be skipped in pbus_size_{mem,io}().

Bridge window size calculation uses pci_{,sriov_}resource_alignment(), that
are applicable only to not yet assigned BARs and don't make sense for fixed
ones. Original alignment of a fixed BAR is lost after assignment, so return
1 in this case as a neutral value.

A window should be additionally extended if it has distant fixed BARs on
its edges:

    | <--          bridge window          --> |
    | **fixed BAR** |         | **fixed BAR** |

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/iov.c       |  2 ++
 drivers/pci/pci.h       |  2 ++
 drivers/pci/setup-bus.c | 21 ++++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4afd4ee4f7f0..f4f7c2702579 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -872,6 +872,8 @@ resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
  */
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
+	if (pci_dev_bar_fixed(dev, dev->resource + resno))
+		return 1;
 	return pcibios_iov_resource_alignment(dev, resno);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f47f80b6a620..f7460ddd196a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -576,6 +576,8 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
 		return pci_sriov_resource_alignment(dev, resno);
 #endif
+	if (pci_dev_bar_fixed(dev, res))
+		return 1;
 	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
 	return resource_alignment(res);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 640090046ffd..3dadadea10d6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -888,9 +888,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
+	struct resource *fixed_range;
+	resource_size_t fixed_size;
+
 	if (!b_res)
 		return;
 
+	fixed_range = &bus->fixed_range[0];
+	fixed_size = pci_fixed_range_valid(fixed_range) ? resource_size(fixed_range) : 0;
+
 	/* If resource is already assigned, nothing more to do */
 	if (b_res->parent)
 		return;
@@ -923,6 +929,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
+	if (size1 < fixed_size)
+		size1 = fixed_size;
+
 	size0 = calculate_iosize(size, min_size, size1, 0, 0,
 			resource_size(b_res), min_align);
 	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
@@ -1004,6 +1013,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	int idx;
+	struct resource *fixed_range;
+	resource_size_t fixed_size;
 
 	if (!b_res)
 		return -ENOSPC;
@@ -1012,6 +1024,13 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (b_res->parent)
 		return 0;
 
+	idx = pci_get_bridge_resource_idx(b_res);
+	fixed_range = &bus->fixed_range[idx];
+	fixed_size = pci_fixed_range_valid(fixed_range) ? resource_size(fixed_range) : 0;
+
+	if (min_size < fixed_size)
+		min_size = fixed_size;
+
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
@@ -1023,7 +1042,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
 
-			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+			if (r->parent ||
 			    !pci_dev_bar_enabled(dev, i) ||
 			    ((r->flags & mask) != type &&
 			     (r->flags & mask) != type2 &&
-- 
2.24.1

