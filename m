Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF41B27B0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgDUNYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 09:24:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728864AbgDUNX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 09:23:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3EF206D6AE95EF88C47E;
        Tue, 21 Apr 2020 21:23:56 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.83.77) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 21:23:45 +0800
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
Subject: [RESEND PATCH v7 4/6] ACPI / APEI: Add callback for ARM HW errors to the GHES notifier
Date:   Tue, 21 Apr 2020 14:21:34 +0100
Message-ID: <20200421132136.1595-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200421132136.1595-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20200421132136.1595-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.83.77]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add callback function for handling the ARM HW errors to the GHES notifier.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 67ef1742fc93..3b89c7621a0d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -564,6 +564,20 @@ static int ghes_handle_aer(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_STOP;
 }
 
+static int ghes_handle_arm_hw_error(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct acpi_hest_generic_data *gdata = data;
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+
+	if (!guid_equal((guid_t *)gdata->section_type, &CPER_SEC_PROC_ARM))
+		return NOTIFY_DONE;
+
+	log_arm_hw_error(err);
+
+	return NOTIFY_STOP;
+}
+
 static struct notifier_block ghes_notifier_mem_error = {
 	.notifier_call = ghes_handle_memory_failure,
 };
@@ -572,6 +586,10 @@ static struct notifier_block ghes_notifier_aer = {
 	.notifier_call = ghes_handle_aer,
 };
 
+static struct notifier_block ghes_notifier_arm_hw_error = {
+	.notifier_call = ghes_handle_arm_hw_error,
+};
+
 struct ghes_error_handler_list {
 	const char *name;
 	struct notifier_block *nb;
@@ -586,6 +604,10 @@ static const struct ghes_error_handler_list ghes_error_handler_list[] = {
 		.name = "ghes_notifier_aer",
 		.nb = &ghes_notifier_aer,
 	},
+	{
+		.name = "ghes_notifier_arm_hw_error",
+		.nb = &ghes_notifier_arm_hw_error,
+	},
 };
 
 static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
@@ -670,12 +692,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			pr_warn(GHES_PFX "ghes event queue full\n");
 			break;
 		}
-
-		if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-
-			log_arm_hw_error(err);
-		} else {
+		{
 			void *err = acpi_hest_get_payload(gdata);
 
 			log_non_standard_event(sec_type, fru_id, fru_text,
-- 
2.17.1


