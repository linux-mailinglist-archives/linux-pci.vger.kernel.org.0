Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6EF248768
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgHRO0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 10:26:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2619 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbgHRO0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 10:26:38 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 09C4E3BA7355E06700CE;
        Tue, 18 Aug 2020 15:26:37 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 15:26:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <martin@geanix.com>,
        Ingo Molnar <mingo@redhat.com>, <linux-ia64@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/6] ACPI: Remove side effect of partly creating a node in acpi_map_pxm_to_online_node
Date:   Tue, 18 Aug 2020 22:24:27 +0800
Message-ID: <20200818142430.1156547-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200818142430.1156547-1-Jonathan.Cameron@huawei.com>
References: <20200818142430.1156547-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Whilst this function will only return an online node, it can have the side
effect of partially creating a new node.  The existing comments suggest this
is intentional, but the usecases of this function are related to NFIT and
HMAT parsing, neither of which should be able to define new nodes.

One route by which the existing behaviour would cause a crash is to have a
_PXM entry in ACPI DSDT attempt to place a device within this partly
created proximity domain. A subsequent call to devm_kzalloc or similar
would result in an attempt to allocate memory on a node for which zone
lists have not been set up and a null pointer dereference.

We prevent such cases by switching to pxm_to_node() within
acpi_map_pxm_to_online_node which cannot cause a new node to be partly
created. If one would previously have been created we now return
NO_NUMA_NODE.  Documentation updated to reflect this change.
We may want to think about renaming acpi_map_pxm_to_online_node to
pxm_to_online_node to reflect this change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---
 include/linux/acpi.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1e4cdc6c7ae2..a9fd122ae878 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -430,13 +430,12 @@ int acpi_get_node(acpi_handle handle);
  * ACPI device drivers, which are called after the NUMA initialization has
  * completed in the kernel, can call this interface to obtain their device
  * NUMA topology from ACPI tables.  Such drivers do not have to deal with
- * offline nodes.  A node may be offline when a device proximity ID is
- * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
- * "numa=off" on x86.
+ * offline nodes.  A node may be offline when SRAT memory entry does not exist,
+ * or NUMA is disabled, ex. "numa=off" on x86.
  */
 static inline int acpi_map_pxm_to_online_node(int pxm)
 {
-	int node = acpi_map_pxm_to_node(pxm);
+	int node = pxm_to_node(pxm);
 
 	return numa_map_to_online_node(node);
 }
-- 
2.19.1

