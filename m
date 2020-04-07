Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B109E1A0D3D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Apr 2020 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgDGMCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Apr 2020 08:02:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbgDGMCu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Apr 2020 08:02:50 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E0729E1B38DA7DBF78E;
        Tue,  7 Apr 2020 20:02:44 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.82.134) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 20:02:36 +0800
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
Subject: [v7 PATCH 5/6] ACPI / APEI: Add callback for non-standard HW errors to the GHES notifier
Date:   Tue, 7 Apr 2020 13:00:44 +0100
Message-ID: <20200407120045.958-6-shiju.jose@huawei.com>
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

Add callback function for the non-standard HW errors to the GHES notifier.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 56 ++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3b89c7621a0d..0c27ea8ea943 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -578,6 +578,34 @@ static int ghes_handle_arm_hw_error(struct notifier_block *nb,
 	return NOTIFY_STOP;
 }
 
+static int ghes_handle_non_standard_event(struct notifier_block *nb,
+					  unsigned long event, void *data)
+{
+	struct acpi_hest_generic_data *gdata = data;
+	void *err = acpi_hest_get_payload(gdata);
+	int sec_sev;
+	guid_t *sec_type;
+	const guid_t *fru_id = &guid_null;
+	char *fru_text = "";
+
+	if (guid_equal((guid_t *)gdata->section_type, &CPER_SEC_PLATFORM_MEM) ||
+	    guid_equal((guid_t *)gdata->section_type, &CPER_SEC_PCIE) ||
+	    guid_equal((guid_t *)gdata->section_type, &CPER_SEC_PROC_ARM))
+		return NOTIFY_DONE;
+
+	sec_type = (guid_t *)gdata->section_type;
+	sec_sev = ghes_severity(gdata->error_severity);
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+		fru_id = (guid_t *)gdata->fru_id;
+
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+		fru_text = gdata->fru_text;
+
+	log_non_standard_event(sec_type, fru_id, fru_text, sec_sev,
+			       err, gdata->error_data_length);
+	return NOTIFY_OK;
+}
+
 static struct notifier_block ghes_notifier_mem_error = {
 	.notifier_call = ghes_handle_memory_failure,
 };
@@ -590,6 +618,10 @@ static struct notifier_block ghes_notifier_arm_hw_error = {
 	.notifier_call = ghes_handle_arm_hw_error,
 };
 
+static struct notifier_block ghes_notifier_non_standard_event = {
+	.notifier_call = ghes_handle_non_standard_event,
+};
+
 struct ghes_error_handler_list {
 	const char *name;
 	struct notifier_block *nb;
@@ -608,6 +640,10 @@ static const struct ghes_error_handler_list ghes_error_handler_list[] = {
 		.name = "ghes_notifier_arm_hw_error",
 		.nb = &ghes_notifier_arm_hw_error,
 	},
+	{
+		.name = "ghes_notifier_non_standard_event",
+		.nb = &ghes_notifier_non_standard_event,
+	},
 };
 
 static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
@@ -656,24 +692,13 @@ static DECLARE_WORK(ghes_event_work, ghes_event_work_func);
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
-	int sev, sec_sev;
+	int sev;
 	struct acpi_hest_generic_data *gdata;
-	guid_t *sec_type;
-	const guid_t *fru_id = &guid_null;
-	char *fru_text = "";
 	struct ghes_event_entry event_entry;
 	u32 len;
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
-		sec_type = (guid_t *)gdata->section_type;
-		sec_sev = ghes_severity(gdata->error_severity);
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
-			fru_id = (guid_t *)gdata->fru_id;
-
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
-			fru_text = gdata->fru_text;
-
 		len = acpi_hest_get_record_size(gdata);
 		event_entry.gdata = (void *)gen_pool_alloc(ghes_gdata_pool,
 							   len);
@@ -692,13 +717,6 @@ static void ghes_do_proc(struct ghes *ghes,
 			pr_warn(GHES_PFX "ghes event queue full\n");
 			break;
 		}
-		{
-			void *err = acpi_hest_get_payload(gdata);
-
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       sec_sev, err,
-					       gdata->error_data_length);
-		}
 	}
 }
 
-- 
2.17.1


