Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD4B34B70B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 13:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhC0MLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 08:11:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15015 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhC0MLM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 08:11:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKv1ClqzPt2F;
        Sat, 27 Mar 2021 20:08:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:11:01 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 08/12] ACPI: CPPC: fix some coding style issues
Date:   Sat, 27 Mar 2021 20:08:20 +0800
Message-ID: <1616846904-25719-9-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl, including
following types:

WARNING: Missing a blank line after declarations
WARNING: unnecessary whitespace before a quoted newline
ERROR: spaces required around that '>='
ERROR: switch and case should be at the same indent

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 71 ++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ae53740..3dbaf47 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -326,6 +326,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 		if (unlikely(ret)) {
 			for_each_possible_cpu(i) {
 				struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
+
 				if (!desc)
 					continue;
 
@@ -777,7 +778,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
 			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
 		} else {
-			pr_debug("Err in entry:%d in CPC table of CPU:%d \n", i, pr->id);
+			pr_debug("Err in entry:%d in CPC table of CPU:%d\n", i, pr->id);
 			goto out_free;
 		}
 	}
@@ -867,7 +868,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	void __iomem *addr;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 
-	if (pcc_ss_id >=0 && pcc_data[pcc_ss_id]) {
+	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
 		if (pcc_data[pcc_ss_id]->pcc_channel_acquired) {
 			pcc_data[pcc_ss_id]->refcount--;
 			if (!pcc_data[pcc_ss_id]->refcount) {
@@ -954,22 +955,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 				val, reg->bit_width);
 
 	switch (reg->bit_width) {
-		case 8:
-			*val = readb_relaxed(vaddr);
-			break;
-		case 16:
-			*val = readw_relaxed(vaddr);
-			break;
-		case 32:
-			*val = readl_relaxed(vaddr);
-			break;
-		case 64:
-			*val = readq_relaxed(vaddr);
-			break;
-		default:
-			pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
-				 reg->bit_width, pcc_ss_id);
-			ret_val = -EFAULT;
+	case 8:
+		*val = readb_relaxed(vaddr);
+		break;
+	case 16:
+		*val = readw_relaxed(vaddr);
+		break;
+	case 32:
+		*val = readl_relaxed(vaddr);
+		break;
+	case 64:
+		*val = readq_relaxed(vaddr);
+		break;
+	default:
+		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
+			 reg->bit_width, pcc_ss_id);
+		ret_val = -EFAULT;
 	}
 
 	return ret_val;
@@ -993,23 +994,23 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 				val, reg->bit_width);
 
 	switch (reg->bit_width) {
-		case 8:
-			writeb_relaxed(val, vaddr);
-			break;
-		case 16:
-			writew_relaxed(val, vaddr);
-			break;
-		case 32:
-			writel_relaxed(val, vaddr);
-			break;
-		case 64:
-			writeq_relaxed(val, vaddr);
-			break;
-		default:
-			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
-				 reg->bit_width, pcc_ss_id);
-			ret_val = -EFAULT;
-			break;
+	case 8:
+		writeb_relaxed(val, vaddr);
+		break;
+	case 16:
+		writew_relaxed(val, vaddr);
+		break;
+	case 32:
+		writel_relaxed(val, vaddr);
+		break;
+	case 64:
+		writeq_relaxed(val, vaddr);
+		break;
+	default:
+		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
+			 reg->bit_width, pcc_ss_id);
+		ret_val = -EFAULT;
+		break;
 	}
 
 	return ret_val;
-- 
2.8.1

