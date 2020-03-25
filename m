Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60B192A7F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 14:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCYNze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 09:55:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2597 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727277AbgCYNze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 09:55:34 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C4C0479CCF68DFE9EBD8;
        Wed, 25 Mar 2020 13:55:32 +0000 (GMT)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 25 Mar 2020 13:55:32 +0000
Received: from [127.0.0.1] (10.47.86.66) by lhreml715-chm.china.huawei.com
 (10.201.108.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 13:55:31 +0000
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
        <james.morse@arm.com>, <tony.luck@intel.com>,
        <gregkh@linuxfoundation.org>, <zhangliguang@linux.alibaba.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>
From:   Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v5 1/2] APEI: Add support to notify the vendor specific HW
 errors
Message-ID: <e4449772-4f51-ca94-5b97-f94c15374216@huawei.com>
Date:   Wed, 25 Mar 2020 13:55:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.66]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
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
@@ -490,6 +490,32 @@ static void ghes_handle_aer(struct 
acpi_hest_generic_data *gdata)
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
+static inline void ghes_unregister_event_notifier(struct notifier_block 
*nb)
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
@@ -28,13 +28,15 @@ static inline int cec_add_elem(u64 pfn)		{ return 
-ENODEV; }
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

  	TP_printk("severity: %d; sec type:%pU; FRU: %pU %s; data len:%d; raw 
data:%s",
-- 
2.17.1
