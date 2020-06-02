Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E551EB841
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgFBJUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 05:20:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:34988 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgFBJUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:02 -0400
IronPort-SDR: LU65sjY1zrrAKe4e9GVNwDC47gp7axev/y7DCAmDU1ZkKEp9SNsd0mWso/tL6PQ3+D1ZoPQjEk
 hP9ltlCH86Ew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:01 -0700
IronPort-SDR: e1SbGkgK+kGnsjzv+eGCt8BQta7T17JsxI52CeVfzmD+fk3/K589DR1wzAMhM/IqkbiJoHT5Kx
 5BGbpsXxIMkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="258263713"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2020 02:19:59 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 02/15] PCI/MSI: forward MSIx vector enable error code in pci_alloc_irq_vectors_affinity
Date:   Tue,  2 Jun 2020 11:19:53 +0200
Message-Id: <20200602091953.31739-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When debugging an issue where I was asking the PCI machinery to enable a
set of MSIx vectors, without falling back on MSI, I ran across a
behaviour which seems odd. The pci_alloc_irq_vectors_affinity will
always return -ENOSPC on failure, when allocating MSIx vectors only,
whereas with MSI fallback it will forward any error returned by
__pci_enable_msi_range. This is a confusing behaviour, so have the
pci_alloc_irq_vectors_affinity forward the error code from
__pci_enable_msix_range when appropriate.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/pci/msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6b43a5455c7a..9db9ce5dddb3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1231,8 +1231,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	if (msix_vecs == -ENOSPC)
-		return -ENOSPC;
+	if (msix_vecs == -ENOSPC || (flags & PCI_IRQ_MSI_TYPES) == PCI_IRQ_MSIX)
+		return msix_vecs;
 	return msi_vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
-- 
2.17.2

