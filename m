Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8B150E2E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBCQwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Feb 2020 11:52:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728074AbgBCQwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Feb 2020 11:52:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4E312C0FADCF0E9617C;
        Tue,  4 Feb 2020 00:51:55 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 00:51:45 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
        <james.morse@arm.com>, <tony.luck@intel.com>,
        <gregkh@linuxfoundation.org>, <zhangliguang@linux.alibaba.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v3 1/2] ACPI: APEI: Add support to notify the vendor specific HW errors
Date:   Mon, 3 Feb 2020 16:51:21 +0000
Message-ID: <20200203165122.17748-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20200203165122.17748-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20200203165122.17748-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Presently APEI does not support reporting the vendor specific
HW errors, received in the vendor defined table entries, to the
vendor drivers for any recovery.

This patch adds the support to register and unregister the
error handling function for the vendor specific HW errors and
notify the registered kernel driver.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 116 +++++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/ghes.h      |  56 +++++++++++++++++++++++
 2 files changed, 167 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 103acbb..69e18d7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -490,6 +490,109 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+struct ghes_event_notify {
+	struct list_head list;
+	struct rcu_head	rcu_head;
+	guid_t sec_type; /* guid of the error record */
+	ghes_event_handler_t event_handler; /* event handler function */
+	void *data; /* handler driver's private data if any */
+};
+
+/* List to store the registered event handling functions */
+static DEFINE_MUTEX(ghes_event_notify_mutex);
+static LIST_HEAD(ghes_event_handler_list);
+
+/**
+ * ghes_register_event_handler - register an event handling
+ * function for the non-fatal HW errors.
+ * @sec_type: sec_type of the corresponding CPER to be notified.
+ * @event_handler: pointer to the error handling function.
+ * @data: handler driver's private data.
+ *
+ * return 0 : SUCCESS, non-zero : FAIL
+ */
+int ghes_register_event_handler(guid_t sec_type,
+				ghes_event_handler_t event_handler,
+				void *data)
+{
+	struct ghes_event_notify *event_notify;
+
+	event_notify = kzalloc(sizeof(*event_notify), GFP_KERNEL);
+	if (!event_notify)
+		return -ENOMEM;
+
+	event_notify->event_handler = event_handler;
+	guid_copy(&event_notify->sec_type, &sec_type);
+	event_notify->data = data;
+
+	mutex_lock(&ghes_event_notify_mutex);
+	list_add_rcu(&event_notify->list, &ghes_event_handler_list);
+	mutex_unlock(&ghes_event_notify_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ghes_register_event_handler);
+
+/**
+ * ghes_unregister_event_handler - unregister the previously
+ * registered event handling function.
+ * @sec_type: sec_type of the corresponding CPER.
+ * @data: driver specific data to distinguish devices.
+ */
+void ghes_unregister_event_handler(guid_t sec_type, void *data)
+{
+	struct ghes_event_notify *event_notify;
+	bool found = false;
+
+	mutex_lock(&ghes_event_notify_mutex);
+	rcu_read_lock();
+	list_for_each_entry_rcu(event_notify,
+				&ghes_event_handler_list, list) {
+		if (guid_equal(&event_notify->sec_type, &sec_type)) {
+			if (data != event_notify->data)
+				continue;
+			list_del_rcu(&event_notify->list);
+			found = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	mutex_unlock(&ghes_event_notify_mutex);
+
+	if (!found) {
+		pr_err("Tried to unregister a GHES event handler that has not been registered\n");
+		return;
+	}
+
+	synchronize_rcu();
+	kfree(event_notify);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_event_handler);
+
+static int ghes_handle_non_standard_event(guid_t *sec_type,
+	struct acpi_hest_generic_data *gdata, int sev)
+{
+	struct ghes_event_notify *event_notify;
+	bool found = false;
+	int ret;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(event_notify,
+				&ghes_event_handler_list, list) {
+		if (guid_equal(&event_notify->sec_type, sec_type)) {
+			ret = event_notify->event_handler(gdata, sev,
+						    event_notify->data);
+			if (!ret)
+				continue;
+			found = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -525,11 +628,14 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			log_arm_hw_error(err);
 		} else {
-			void *err = acpi_hest_get_payload(gdata);
-
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       sec_sev, err,
-					       gdata->error_data_length);
+			if (!ghes_handle_non_standard_event(sec_type, gdata,
+							    sev)) {
+				void *err = acpi_hest_get_payload(gdata);
+
+				log_non_standard_event(sec_type, fru_id,
+						       fru_text, sec_sev, err,
+						       gdata->error_data_length);
+			}
 		}
 	}
 }
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index e3f1cdd..e3387cf 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -50,6 +50,62 @@ enum {
 	GHES_SEV_PANIC = 0x3,
 };
 
+enum {
+	GHES_EVENT_NONE	= 0x0,
+	GHES_EVENT_HANDLED	= 0x1,
+};
+
+/**
+ * typedef ghes_event_handler_t - event handling function
+ * for the non-fatal HW errors.
+ *
+ * @gdata: acpi_hest_generic_data.
+ * @sev: error severity of the entire error event defined in the
+ *       ACPI spec table generic error status block.
+ * @data: handler driver's private data.
+ *
+ * Return : GHES_EVENT_NONE - event not handled, GHES_EVENT_HANDLED - handled.
+ *
+ * The error handling function is responsible for logging error and
+ * this function would be called in the interrupt context.
+ */
+typedef int (*ghes_event_handler_t)(struct acpi_hest_generic_data *gdata,
+				    int sev, void *data);
+
+#ifdef CONFIG_ACPI_APEI_GHES
+/**
+ * ghes_register_event_handler - register an event handling
+ * function for the non-fatal HW errors.
+ * @sec_type: sec_type of the corresponding CPER to be notified.
+ * @event_handler: pointer to the event handling function.
+ * @data: handler driver's private data.
+ *
+ * Return : 0 - SUCCESS, non-zero - FAIL.
+ */
+int ghes_register_event_handler(guid_t sec_type,
+				ghes_event_handler_t event_handler,
+				void *data);
+
+/**
+ * ghes_unregister_event_handler - unregister the previously
+ * registered event handling function.
+ * @sec_type: sec_type of the corresponding CPER.
+ * @data: driver specific data to distinguish devices.
+ */
+void ghes_unregister_event_handler(guid_t sec_typei, void *data);
+#else
+static inline int ghes_register_event_handler(guid_t sec_type,
+					ghes_event_handler_t event_handler,
+					void *data)
+{
+	return -ENODEV;
+}
+
+static inline void ghes_unregister_event_handler(guid_t sec_type, void *data)
+{
+}
+#endif
+
 int ghes_estatus_pool_init(int num_ghes);
 
 /* From drivers/edac/ghes_edac.c */
-- 
1.9.1


