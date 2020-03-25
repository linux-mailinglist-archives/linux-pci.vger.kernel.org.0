Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40FAC192E83
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 17:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYQnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 12:43:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbgCYQnX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 12:43:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2A1F8FA3A6CD59B77DA;
        Thu, 26 Mar 2020 00:43:18 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.86.66) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 00:43:09 +0800
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
Subject: [PATCH v6 1/2] ACPI / APEI: Add support to notify the vendor specific HW errors
Date:   Wed, 25 Mar 2020 16:42:22 +0000
Message-ID: <20200325164223.650-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200325164223.650-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20200325164223.650-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.86.66]
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
 drivers/acpi/apei/ghes.c | 35 ++++++++++++++++++++++++++++++++++-
 drivers/ras/ras.c        |  5 +++--
 include/acpi/ghes.h      | 28 ++++++++++++++++++++++++++++
 include/linux/ras.h      |  6 ++++--
 include/ras/ras_event.h  |  7 +++++--
 5 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 24c9642e8fc7..d83f0b1aad0d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -490,6 +490,32 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static ATOMIC_NOTIFIER_HEAD(ghes_event_notify_list);
+
+/**
+ * ghes_register_event_notifier - register an event notifier
+ * for the non-fatal HW errors.
+ * @nb: pointer to the notifier_block structure of the event handler.
+ *
+ * return 0 : SUCCESS, non-zero : FAIL
+ */
+int ghes_register_event_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&ghes_event_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_register_event_notifier);
+
+/**
+ * ghes_unregister_event_notifier - unregister the previously
+ * registered event notifier.
+ * @nb: pointer to the notifier_block structure of the event handler.
+ */
+void ghes_unregister_event_notifier(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&ghes_event_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_event_notifier);
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -526,10 +552,17 @@ static void ghes_do_proc(struct ghes *ghes,
 			log_arm_hw_error(err);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
+			u8 error_handled = false;
+			int ret;
+
+			ret = atomic_notifier_call_chain(&ghes_event_notify_list, 0, gdata);
+			if (ret & NOTIFY_OK)
+				error_handled = true;
 
 			log_non_standard_event(sec_type, fru_id, fru_text,
 					       sec_sev, err,
-					       gdata->error_data_length);
+					       gdata->error_data_length,
+					       error_handled);
 		}
 	}
 }
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 95540ea8dd9d..0ed784a8466e 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -16,9 +16,10 @@
 
 void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 			    const char *fru_text, const u8 sev, const u8 *err,
-			    const u32 len)
+			    const u32 len, const u8 error_handled)
 {
-	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
+	trace_non_standard_event(sec_type, fru_id, fru_text, sev,
+				 err, len, error_handled);
 }
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index e3f1cddb4ac8..a3dd82069069 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -50,6 +50,34 @@ enum {
 	GHES_SEV_PANIC = 0x3,
 };
 
+
+#ifdef CONFIG_ACPI_APEI_GHES
+/**
+ * ghes_register_event_notifier - register an event notifier
+ * for the non-fatal HW errors.
+ * @nb: pointer to the notifier_block structure of the event notifier.
+ *
+ * Return : 0 - SUCCESS, non-zero - FAIL.
+ */
+int ghes_register_event_notifier(struct notifier_block *nb);
+
+/**
+ * ghes_unregister_event_notifier - unregister the previously
+ * registered event notifier.
+ * @nb: pointer to the notifier_block structure of the event notifier.
+ */
+void ghes_unregister_event_notifier(struct notifier_block *nb);
+#else
+static inline int ghes_register_event_notifier(struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+
+static inline void ghes_unregister_event_notifier(struct notifier_block *nb)
+{
+}
+#endif
+
 int ghes_estatus_pool_init(int num_ghes);
 
 /* From drivers/edac/ghes_edac.c */
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 7c3debb47c87..6ed3c67ab905 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -28,13 +28,15 @@ static inline int cec_add_elem(u64 pfn)		{ return -ENODEV; }
 #ifdef CONFIG_RAS
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
-			    const u8 sev, const u8 *err, const u32 len);
+			    const u8 sev, const u8 *err, const u32 len,
+			    const u8 error_handled);
 void log_arm_hw_error(struct cper_sec_proc_arm *err);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
 		       const guid_t *fru_id, const char *fru_text,
-		       const u8 sev, const u8 *err, const u32 len)
+		       const u8 sev, const u8 *err, const u32 len,
+		       const u8 error_handled);
 { return; }
 static inline void
 log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 36c5c5e38c1d..38fd05d82d8e 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -223,9 +223,10 @@ TRACE_EVENT(non_standard_event,
 		 const char *fru_text,
 		 const u8 sev,
 		 const u8 *err,
-		 const u32 len),
+		 const u32 len,
+		 const u8 error_handled),
 
-	TP_ARGS(sec_type, fru_id, fru_text, sev, err, len),
+	TP_ARGS(sec_type, fru_id, fru_text, sev, err, len, error_handled),
 
 	TP_STRUCT__entry(
 		__array(char, sec_type, UUID_SIZE)
@@ -234,6 +235,7 @@ TRACE_EVENT(non_standard_event,
 		__field(u8, sev)
 		__field(u32, len)
 		__dynamic_array(u8, buf, len)
+		__field(u8, error_handled)
 	),
 
 	TP_fast_assign(
@@ -243,6 +245,7 @@ TRACE_EVENT(non_standard_event,
 		__entry->sev = sev;
 		__entry->len = len;
 		memcpy(__get_dynamic_array(buf), err, len);
+		__entry->error_handled = error_handled;
 	),
 
 	TP_printk("severity: %d; sec type:%pU; FRU: %pU %s; data len:%d; raw data:%s",
-- 
2.17.1


