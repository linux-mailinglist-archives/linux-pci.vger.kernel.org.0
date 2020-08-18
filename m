Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD0248765
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHRO0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 10:26:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbgHRO0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 10:26:07 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 54371C421462139A9821;
        Tue, 18 Aug 2020 15:26:06 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 15:26:06 +0100
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
Subject: [PATCH v3 2/6] ACPI: Do not create new NUMA domains from ACPI static tables that are not SRAT
Date:   Tue, 18 Aug 2020 22:24:26 +0800
Message-ID: <20200818142430.1156547-3-Jonathan.Cameron@huawei.com>
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

Several ACPI static tables contain references to proximity domains.
ACPI 6.3 has clarified that only entries in SRAT may define a new domain
(sec 5.2.16).

Those tables described in the ACPI spec have additional clarifying text.

NFIT: Table 5-132,

"Integer that represents the proximity domain to which the memory belongs.
 This number must match with corresponding entry in the SRAT table."

HMAT: Table 5-145,

"... This number must match with the corresponding entry in the SRAT
 table's processor affinity structure ... if the initiator is a processor,
 or the Generic Initiator Affinity Structure if the initiator is a generic
 initiator".

IORT and DMAR are defined by external specifications.

Intel Virtualization Technology for Directed I/O Rev 3.1 does not make any
explicit statements, but the general SRAT statement above will still apply.
https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

IO Remapping Table, Platform Design Document rev D, also makes not explicit
statement, but refers to ACPI SRAT table for more information and again the
generic SRAT statement above applies.
https://developer.arm.com/documentation/den0049/d/

In conclusion, any proximity domain specified in these tables, should be a
reference to a proximity domain also found in SRAT, and they should not be able
to instantiate a new domain.  Hence we switch to pxm_to_node() which will only
return existing nodes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/arm64/iort.c  | 2 +-
 drivers/acpi/nfit/core.c   | 3 +--
 drivers/acpi/numa/hmat.c   | 2 +-
 drivers/iommu/intel/dmar.c | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ec782e4a0fe4..26005a15cb8b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1335,7 +1335,7 @@ static int  __init arm_smmu_v3_set_proximity(struct device *dev,
 
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
-		int dev_node = acpi_map_pxm_to_node(smmu->pxm);
+		int dev_node = pxm_to_node(smmu->pxm);
 
 		if (dev_node != NUMA_NO_NODE && !node_online(dev_node))
 			return -EINVAL;
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 26dd208a0d63..ea0557cb54f7 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3008,8 +3008,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 	if (spa->flags & ACPI_NFIT_PROXIMITY_VALID) {
 		ndr_desc->numa_node = acpi_map_pxm_to_online_node(
 						spa->proximity_domain);
-		ndr_desc->target_node = acpi_map_pxm_to_node(
-				spa->proximity_domain);
+		ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
 	} else {
 		ndr_desc->numa_node = NUMA_NO_NODE;
 		ndr_desc->target_node = NUMA_NO_NODE;
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c32cfb72370..cf6df2df26cd 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -666,7 +666,7 @@ static void hmat_register_target_device(struct memory_target *target,
 
 	pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
 	info = (struct memregion_info) {
-		.target_node = acpi_map_pxm_to_node(target->memory_pxm),
+		.target_node = pxm_to_node(target->memory_pxm),
 	};
 	rc = platform_device_add_data(pdev, &info, sizeof(info));
 	if (rc < 0) {
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 93e6345f3414..2f3badd41e1b 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -473,7 +473,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 	rhsa = (struct acpi_dmar_rhsa *)header;
 	for_each_drhd_unit(drhd) {
 		if (drhd->reg_base_addr == rhsa->base_address) {
-			int node = acpi_map_pxm_to_node(rhsa->proximity_domain);
+			int node = pxm_to_node(rhsa->proximity_domain);
 
 			if (!node_online(node))
 				node = NUMA_NO_NODE;
-- 
2.19.1

