Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C203D24877E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHRO2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 10:28:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726660AbgHRO2J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 10:28:09 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0DFD8528DCC75F4E9448;
        Tue, 18 Aug 2020 15:28:08 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 15:28:07 +0100
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
Subject: [PATCH v3 6/6] irq-chip/gic-v3-its: Fix crash if ITS is in a proximity domain without processor or memory
Date:   Tue, 18 Aug 2020 22:24:30 +0800
Message-ID: <20200818142430.1156547-7-Jonathan.Cameron@huawei.com>
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

Note this crash is present before any of the patches in this series, but
as explained below it is highly unlikely anyone is shipping a firmware that
causes it. Tests were done using an overriden SRAT.

On ARM64, the gic-v3 driver directly parses SRAT to locate GIC Interrupt
Translation Service (ITS) Affinity Structures. This is done much later
in the boot than the parses of SRAT which identify proximity domains.

As a result, an ITS placed in a proximity domain that is not defined by
another SRAT structure will result in a NUMA node that is not completely
configured and a crash.

ITS [mem 0x202100000-0x20211ffff]
ITS@0x0000000202100000: Using ITS number 0
Unable to handle kernel paging request at virtual address 0000000000001a08
...

Call trace:
  __alloc_pages_nodemask+0xe8/0x338
  alloc_pages_node.constprop.0+0x34/0x40
  its_probe_one+0x2f8/0xb18
  gic_acpi_parse_madt_its+0x108/0x150
  acpi_table_parse_entries_array+0x17c/0x264
  acpi_table_parse_entries+0x48/0x6c
  acpi_table_parse_madt+0x30/0x3c
  its_init+0x1c4/0x644
  gic_init_bases+0x4b8/0x4ec
  gic_acpi_init+0x134/0x264
  acpi_match_madt+0x4c/0x84
  acpi_table_parse_entries_array+0x17c/0x264
  acpi_table_parse_entries+0x48/0x6c
  acpi_table_parse_madt+0x30/0x3c
  __acpi_probe_device_table+0x8c/0xe8
  irqchip_init+0x3c/0x48
  init_IRQ+0xcc/0x100
  start_kernel+0x33c/0x548

ACPI 6.3 allows any set of Affinity Structures in SRAT to define a proximity
domain.  However, as we do not see this crash, we can conclude that no
firmware is currently placing an ITS in a node that is separate from
those containing memory and / or processors.

We could modify the SRAT parsing behavior to identify the existence
of Proximity Domains unique to the ITS structures, and handle them as
a special case of a generic initiator (once support for those merges).

This patch avoids the complexity that would be needed to handle this corner
case, by not allowing the ITS entry parsing code to instantiate new NUMA
Nodes.  If one is encountered that does not already exist, then NO_NUMA_NODE
is assigned and a warning printed just as if the value had been greater than
allowed NUMA Nodes.

"SRAT: Invalid NUMA node -1 in ITS affinity"

Whilst this does not provide the full flexibility allowed by ACPI,
it does fix the problem.  We can revisit a more sophisticated solution if
needed by future platforms.

Change is simply to replace acpi_map_pxm_to_node with pxm_to_node reflecting
the fact a new mapping is not created.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 95f097448f97..b59b63ee3fa6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5263,7 +5263,12 @@ static int __init gic_acpi_parse_srat_its(union acpi_subtable_headers *header,
 		return -EINVAL;
 	}
 
-	node = acpi_map_pxm_to_node(its_affinity->proximity_domain);
+	/*
+	 * Note that in theory a new proximity node could be created by this
+	 * entry as it is an SRAT resource allocation structure.
+	 * We do not currently support doing so.
+	 */
+	node = pxm_to_node(its_affinity->proximity_domain);
 
 	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
 		pr_err("SRAT: Invalid NUMA node %d in ITS affinity\n", node);
-- 
2.19.1

