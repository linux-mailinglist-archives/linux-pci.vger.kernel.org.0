Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163D234B538
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 08:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhC0Htq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 03:49:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14920 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhC0HtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 03:49:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F6rXg4lrCzkjSk;
        Sat, 27 Mar 2021 15:47:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:49:02 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 02/15] ACPI: processor: fix some coding style issues
Date:   Sat, 27 Mar 2021 15:46:20 +0800
Message-ID: <1616831193-17920-3-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl, including
following types:

ERROR: code indent should use tabs where possible
WARNING: Block comments use a trailing */ on a separate line
WARNING: Missing a blank line after declarations
WARNING: labels should not be indented

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_processor.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index fc89f3a..2d5bd2a 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -25,10 +25,7 @@
 DEFINE_PER_CPU(struct acpi_processor *, processors);
 EXPORT_PER_CPU_SYMBOL(processors);
 
-/* --------------------------------------------------------------------------
-                                Errata Handling
-   -------------------------------------------------------------------------- */
-
+/* Errata Handling */
 struct acpi_processor_errata errata __read_mostly;
 EXPORT_SYMBOL_GPL(errata);
 
@@ -151,10 +148,7 @@ static int acpi_processor_errata(void)
 	return result;
 }
 
-/* --------------------------------------------------------------------------
-                                Initialization
-   -------------------------------------------------------------------------- */
-
+/* Initialization */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 int __weak acpi_map_cpu(acpi_handle handle,
 		phys_cpuid_t physid, u32 acpi_id, int *pcpu)
@@ -306,6 +300,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
 		int ret = acpi_processor_hotadd_init(pr);
+
 		if (ret)
 			return ret;
 	}
@@ -431,10 +426,7 @@ static int acpi_processor_add(struct acpi_device *device,
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-/* --------------------------------------------------------------------------
-                                    Removal
-   -------------------------------------------------------------------------- */
-
+/* Removal */
 static void acpi_processor_remove(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
@@ -892,7 +884,7 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 	info->count = last_index;
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	return ret;
-- 
2.8.1

