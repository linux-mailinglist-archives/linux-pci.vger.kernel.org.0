Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEC248776
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHRO1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 10:27:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726879AbgHRO1I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 10:27:08 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7D89130D0973BBB003B5;
        Tue, 18 Aug 2020 15:27:07 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 15:27:07 +0100
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
Subject: [PATCH v3 4/6] ACPI: Rename acpi_map_pxm_to_online_node to pxm_to_online_node
Date:   Tue, 18 Aug 2020 22:24:28 +0800
Message-ID: <20200818142430.1156547-5-Jonathan.Cameron@huawei.com>
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

As this function is no longer allowed to create new mappings
let us rename it to reflect this.

Note all nodes should already exist before any of the users
of this function are called.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/nfit/core.c | 3 +--
 drivers/acpi/numa/hmat.c | 2 +-
 include/linux/acpi.h     | 8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ea0557cb54f7..8df2f16d1fdf 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3006,8 +3006,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 	ndr_desc->provider_data = nfit_spa;
 	ndr_desc->attr_groups = acpi_nfit_region_attribute_groups;
 	if (spa->flags & ACPI_NFIT_PROXIMITY_VALID) {
-		ndr_desc->numa_node = acpi_map_pxm_to_online_node(
-						spa->proximity_domain);
+		ndr_desc->numa_node = pxm_to_online_node(spa->proximity_domain);
 		ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
 	} else {
 		ndr_desc->numa_node = NUMA_NO_NODE;
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index cf6df2df26cd..e7add2609c03 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -664,7 +664,7 @@ static void hmat_register_target_device(struct memory_target *target,
 		goto out_pdev;
 	}
 
-	pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
+	pdev->dev.numa_node = pxm_to_online_node(target->memory_pxm);
 	info = (struct memregion_info) {
 		.target_node = pxm_to_node(target->memory_pxm),
 	};
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a9fd122ae878..e9f6cd67943e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -420,10 +420,10 @@ int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
 
 /**
- * acpi_map_pxm_to_online_node - Map proximity ID to online node
+ * pxm_to_online_node - Map proximity ID to online node
  * @pxm: ACPI proximity ID
  *
- * This is similar to acpi_map_pxm_to_node(), but always returns an online
+ * This is similar to pxm_to_node(), but always returns an online
  * node.  When the mapped node from a given proximity ID is offline, it
  * looks up the node distance table and returns the nearest online node.
  *
@@ -433,14 +433,14 @@ int acpi_get_node(acpi_handle handle);
  * offline nodes.  A node may be offline when SRAT memory entry does not exist,
  * or NUMA is disabled, ex. "numa=off" on x86.
  */
-static inline int acpi_map_pxm_to_online_node(int pxm)
+static inline int pxm_to_online_node(int pxm)
 {
 	int node = pxm_to_node(pxm);
 
 	return numa_map_to_online_node(node);
 }
 #else
-static inline int acpi_map_pxm_to_online_node(int pxm)
+static inline int pxm_to_online_node(int pxm)
 {
 	return 0;
 }
-- 
2.19.1

