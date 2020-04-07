Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9D71A0D35
	for <lists+linux-pci@lfdr.de>; Tue,  7 Apr 2020 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgDGMCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Apr 2020 08:02:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728514AbgDGMCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Apr 2020 08:02:36 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4FCD2F4798B7A04F03A;
        Tue,  7 Apr 2020 20:02:33 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.82.134) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 20:02:26 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <bp@alien8.de>, <james.morse@arm.com>, <helgaas@kernel.org>,
        <lenb@kernel.org>, <tony.luck@intel.com>,
        <dan.carpenter@oracle.com>, <gregkh@linuxfoundation.org>,
        <zhangliguang@linux.alibaba.com>, <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [v7 PATCH 3/6] ACPI / APEI: Add callback for AER to the GHES notifier
Date:   Tue, 7 Apr 2020 13:00:42 +0100
Message-ID: <20200407120045.958-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200407120045.958-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20200407120045.958-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.82.134]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add callback function for handling the AER to the GHES notifier.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 053c4a2ed96c..67ef1742fc93 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -527,11 +527,16 @@ static int ghes_handle_memory_failure(struct notifier_block *nb,
  * GHES_SEV_PANIC does not make it to this handling since the kernel must
  *     panic.
  */
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
+static int ghes_handle_aer(struct notifier_block *nb, unsigned long event,
+			   void *data)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct acpi_hest_generic_data *gdata = data;
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
+	if (!guid_equal((guid_t *)gdata->section_type, &CPER_SEC_PCIE))
+		return NOTIFY_DONE;
+
 	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 		unsigned int devfn;
@@ -556,12 +561,17 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 				  pcie_err->aer_info);
 	}
 #endif
+	return NOTIFY_STOP;
 }
 
 static struct notifier_block ghes_notifier_mem_error = {
 	.notifier_call = ghes_handle_memory_failure,
 };
 
+static struct notifier_block ghes_notifier_aer = {
+	.notifier_call = ghes_handle_aer,
+};
+
 struct ghes_error_handler_list {
 	const char *name;
 	struct notifier_block *nb;
@@ -572,6 +582,10 @@ static const struct ghes_error_handler_list ghes_error_handler_list[] = {
 		.name = "ghes_notifier_mem_error",
 		.nb = &ghes_notifier_mem_error,
 	},
+	{
+		.name = "ghes_notifier_aer",
+		.nb = &ghes_notifier_aer,
+	},
 };
 
 static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
@@ -657,10 +671,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			break;
 		}
 
-		if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 
 			log_arm_hw_error(err);
-- 
2.17.1


