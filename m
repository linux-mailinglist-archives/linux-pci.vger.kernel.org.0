Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BEE1BAC78
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgD0SYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:25 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53104 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgD0SYY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id EBD854C85D;
        Mon, 27 Apr 2020 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011858; x=1589826259; bh=C3bATN/zUcDbhnnLp3XVUlDepF5uCqSARUZ
        QtzVsZYs=; b=q9aZ1WWljerU+yuMO9Aq9vACu3FiVqcSkC+XBO/Nnb+iN8yoNcr
        KZ6S+fP6mVd5gqmNMCi4TiTvJlycfeMeJKwh7MwsIHdKgoj4cTcAVrt2RPIULRqo
        hwZH58sm/9gbBYNusP27xVswh9At2I1X/6pztMe3UgRLmfYHm8bxPwP8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kGb-JXFV2kgF; Mon, 27 Apr 2020 21:24:18 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id CF9104C843;
        Mon, 27 Apr 2020 21:24:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:12 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 11/24] PCI: Include fixed BARs into the bus size calculating
Date:   Mon, 27 Apr 2020 21:23:45 +0300
Message-ID: <20200427182358.2067702-12-s.miroshnichenko@yadro.com>
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
 drivers/pci/setup-bus.c | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4d1f392b05f9..481cb8257a8e 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -860,6 +860,8 @@ resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
  */
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
+	if (pci_dev_bar_fixed(dev, dev->resource + resno))
+		return 1;
 	return pcibios_iov_resource_alignment(dev, resno);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 869398a62e5f..124b88398075 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -558,6 +558,8 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
 		return pci_sriov_resource_alignment(dev, resno);
 #endif
+	if (pci_dev_bar_fixed(dev, res))
+		return 1;
 	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
 	return resource_alignment(res);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 92517275fc06..1e52dd71f02a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -882,6 +882,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
+	struct resource *fixed_range = &bus->fixed_range[0];
+	resource_size_t fixed_size = pci_fixed_range_valid(fixed_range) ?
+		resource_size(fixed_range) : 0;
+
 	if (!b_res)
 		return;
 
@@ -917,6 +921,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
+	if (size1 < fixed_size)
+		size1 = fixed_size;
+
 	size0 = calculate_iosize(size, min_size, size1, 0, 0,
 			resource_size(b_res), min_align);
 	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
@@ -998,6 +1005,14 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	int idx = pci_get_bridge_resource_idx(b_res);
+
+	struct resource *fixed_range = &bus->fixed_range[idx];
+	resource_size_t fixed_size = pci_fixed_range_valid(fixed_range) ?
+		resource_size(fixed_range) : 0;
+
+	if (min_size < fixed_size)
+		min_size = fixed_size;
 
 	if (!b_res)
 		return -ENOSPC;
@@ -1017,7 +1032,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
 
-			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+			if (r->parent ||
 			    !pci_dev_bar_enabled(dev, i) ||
 			    ((r->flags & mask) != type &&
 			     (r->flags & mask) != type2 &&
-- 
2.24.1

