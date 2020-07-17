Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145782242CB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 20:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGQSDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 14:03:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbgGQSDR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 14:03:17 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8236EA905E323B03CF6B;
        Fri, 17 Jul 2020 19:03:16 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 17 Jul 2020 19:03:16 +0100
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
Subject: [PATCH v2 5/6] ACPI: Remove side effect of partly creating a node in acpi_get_node
Date:   Sat, 18 Jul 2020 01:59:58 +0800
Message-ID: <20200717175959.899775-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200717175959.899775-1-Jonathan.Cameron@huawei.com>
References: <20200717175959.899775-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

acpi_get_node calls acpi_get_pxm to evaluate the _PXM AML method for
entries found in DSDT/SSDT. ACPI 6.3 sec 6.2.14 states
"_PXM evaluates to an integer that identifies a device as belonging to
 a Proximity Domain defined in the System Resource Affinity Table (SRAT)."

Hence a _PXM method should not result in creation of a new NUMA node.
Before this patch, _PXM could result in partial instantiation of
NUMA node, missing elements such as zone lists.  A call to devm_kzalloc
for example results in a null pointer dereference.

This patch therefore replaces the acpi_map_pxm_to_node with a call
to pxm_to_node.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 8ef44ee0d76b..697a5c9e2eb5 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -444,6 +444,6 @@ int acpi_get_node(acpi_handle handle)
 
 	pxm = acpi_get_pxm(handle);
 
-	return acpi_map_pxm_to_node(pxm);
+	return pxm_to_node(pxm);
 }
 EXPORT_SYMBOL(acpi_get_node);
-- 
2.19.1

