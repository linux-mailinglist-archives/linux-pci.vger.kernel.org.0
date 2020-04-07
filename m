Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD11A0D3B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Apr 2020 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgDGMCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Apr 2020 08:02:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbgDGMCp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Apr 2020 08:02:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F155AB66627BF4D13B8F;
        Tue,  7 Apr 2020 20:02:38 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.82.134) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 20:02:31 +0800
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
Subject: [v7 PATCH 4/6] ACPI / APEI: Add callback for ARM HW errors to the GHES notifier
Date:   Tue, 7 Apr 2020 13:00:43 +0100
Message-ID: <20200407120045.958-5-shiju.jose@huawei.com>
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


