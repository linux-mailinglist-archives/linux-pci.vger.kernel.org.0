Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2028F1B27AC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgDUNXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 09:23:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728864AbgDUNXt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 09:23:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21F483B7C04644112CD7;
        Tue, 21 Apr 2020 21:23:46 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.83.77) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 21:23:39 +0800
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
Subject: [RESEND PATCH v7 3/6] ACPI / APEI: Add callback for AER to the GHES notifier
Date:   Tue, 21 Apr 2020 14:21:33 +0100
Message-ID: <20200421132136.1595-4-shiju.jose@huawei.com>
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


