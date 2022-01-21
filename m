Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE9F4960A2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbiAUOX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:23:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55140 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350730AbiAUOX6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:23:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B94FB81FF8
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC75C340E1;
        Fri, 21 Jan 2022 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642775036;
        bh=7WrJz6dlTRk2aHPY75u60v8JhqO+CiYno/zQsi8r9jc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TY3+IsnSiEehTLocCtVG2joPKuXI1U/OS5fL8ljGzLssY87Jy6h48ccWCKS96dSya
         0/grcFSLEqEVzyvQqTv+xwOLunbXeB8OwwNrOGFqQnrHxdNjmYgufUhsrNPeJSwN7L
         obZNjhFGEggh8SEyCBfL7aLd/xKV3xQaLm1LF5gjojRrMxUyrkSsh0FThWFaIeCNvr
         3T6/8TKoc+uy+T6z2FnyIWODtuvN/aFviQBID1KAbFUjzwAEXg5ETgYRqaocDqaCa5
         lgsiHbJqj33vxUhkNwzRa+pBFkPyo6j81ewcp8rLWB5FODgKEXsYRRtUcB0HkmtFbq
         nwzKuFTOIQByg==
Received: by pali.im (Postfix)
        id 19D52C83; Fri, 21 Jan 2022 15:23:54 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 2/4] libpci: sysfs: Implement support for PCI_FILL_PARENT
Date:   Fri, 21 Jan 2022 15:22:56 +0100
Message-Id: <20220121142258.28170-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121142258.28170-1-pali@kernel.org>
References: <20220121142258.28170-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---
 lib/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 0dbd127ff53b..1db1b1a7752b 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -390,6 +390,37 @@ sysfs_fill_info(struct pci_dev *d, unsigned int flags)
 	{
 	  done |= sysfs_get_resources(d);
 	}
+      if (flags & PCI_FILL_PARENT)
+	{
+	  unsigned int domain, bus, dev, func;
+	  char *path_abs, *path_canon, *name;
+	  char path_rel[OBJNAMELEN];
+	  struct pci_dev *parent;
+
+	  /* Construct sysfs path for parent device */
+	  sysfs_obj_name(d, "..", path_rel);
+	  path_abs = realpath(path_rel, NULL);
+	  name = path_abs ? strrchr(path_abs, '/') : NULL;
+	  name = name ? name+1 : name;
+	  parent = NULL;
+
+	  if (name && sscanf(name, "%x:%x:%x.%d", &domain, &bus, &dev, &func) == 4 && domain <= 0x7fffffff)
+	    for (parent = d->access->devices; parent; parent = parent->next)
+	      if (parent->domain == (int)domain && parent->bus == bus && parent->dev == dev && parent->func == func)
+	        break;
+
+	  if (parent)
+	    {
+	      /* Check if parsed BDF address from parent sysfs device is really expected PCI device */
+	      sysfs_obj_name(parent, ".", path_rel);
+	      path_canon = realpath(path_rel, NULL);
+	      if (path_canon && strcmp(path_canon, path_abs) == 0)
+		{
+		  d->parent = parent;
+		  done |= PCI_FILL_PARENT;
+		}
+	    }
+	}
     }
 
   if (flags & PCI_FILL_PHYS_SLOT)
-- 
2.20.1

