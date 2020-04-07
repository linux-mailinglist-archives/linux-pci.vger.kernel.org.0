Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037461A0D39
	for <lists+linux-pci@lfdr.de>; Tue,  7 Apr 2020 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgDGMCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Apr 2020 08:02:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728474AbgDGMCh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Apr 2020 08:02:37 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9FCE8A497734EDA0552;
        Tue,  7 Apr 2020 20:02:28 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.82.134) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 20:02:21 +0800
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
Subject: [v7 PATCH 2/6] ACPI / APEI: Add callback for memory errors to the GHES notifier
Date:   Tue, 7 Apr 2020 13:00:41 +0100
Message-ID: <20200407120045.958-3-shiju.jose@huawei.com>
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

Add callback function for handling the memory errors to the GHES notifier.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 55 ++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5c0ab5422311..053c4a2ed96c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -471,23 +471,33 @@ static void ghes_clear_estatus(struct ghes *ghes,
 		ghes_ack_error(ghes->generic_v2);
 }
 
-static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
+static int ghes_handle_memory_failure(struct notifier_block *nb,
+				      unsigned long event, void *data)
 {
 #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	unsigned long pfn;
 	int flags = -1;
+	int sev = event;
+	struct acpi_hest_generic_data *gdata = data;
 	int sec_sev = ghes_severity(gdata->error_severity);
 	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
+	if (!guid_equal((guid_t *)gdata->section_type, &CPER_SEC_PLATFORM_MEM))
+		return NOTIFY_DONE;
+
+	ghes_edac_report_mem_error(sev, mem_err);
+
+	arch_apei_report_mem_error(sev, mem_err);
+
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return;
+		return NOTIFY_STOP;
 
 	pfn = mem_err->physical_addr >> PAGE_SHIFT;
 	if (!pfn_valid(pfn)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 		"Invalid address in generic error data: %#llx\n",
 		mem_err->physical_addr);
-		return;
+		return NOTIFY_STOP;
 	}
 
 	/* iff following two events can be handled properly by now */
@@ -500,6 +510,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 	if (flags != -1)
 		memory_failure_queue(pfn, flags);
 #endif
+	return NOTIFY_STOP;
 }
 
 /*
@@ -547,6 +558,22 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static struct notifier_block ghes_notifier_mem_error = {
+	.notifier_call = ghes_handle_memory_failure,
+};
+
+struct ghes_error_handler_list {
+	const char *name;
+	struct notifier_block *nb;
+};
+
+static const struct ghes_error_handler_list ghes_error_handler_list[] = {
+	{
+		.name = "ghes_notifier_mem_error",
+		.nb = &ghes_notifier_mem_error,
+	},
+};
+
 static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
 
 /**
@@ -630,15 +657,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			break;
 		}
 
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-			ghes_edac_report_mem_error(sev, mem_err);
-
-			arch_apei_report_mem_error(sev, mem_err);
-			ghes_handle_memory_failure(gdata, sev);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
@@ -1431,7 +1450,7 @@ static struct platform_driver ghes_platform_driver = {
 
 static int __init ghes_init(void)
 {
-	int rc;
+	int rc, i;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -1473,6 +1492,16 @@ static int __init ghes_init(void)
 		goto err;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(ghes_error_handler_list); i++) {
+		const struct ghes_error_handler_list *list =
+						&ghes_error_handler_list[i];
+		rc = ghes_register_event_notifier(list->nb);
+		if (rc) {
+			pr_warn(GHES_PFX "fail to register %s\n", list->name);
+			goto err;
+		}
+	}
+
 	return 0;
 err:
 	return rc;
-- 
2.17.1


