Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED601F9402
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgFOJzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 05:55:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728368AbgFOJza (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jun 2020 05:55:30 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1076B2C26C1113BCF115;
        Mon, 15 Jun 2020 10:55:29 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.26.179) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 15 Jun 2020 10:55:28 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <bp@alien8.de>, <james.morse@arm.com>, <lenb@kernel.org>,
        <tony.luck@intel.com>, <dan.carpenter@oracle.com>,
        <zhangliguang@linux.alibaba.com>,
        <andriy.shevchenko@linux.intel.com>, <wangkefeng.wang@huawei.com>,
        <jroedel@suse.de>
CC:     <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>
Subject: [PATCH v9 1/2] ACPI / APEI: Add support to notify the vendor specific HW errors
Date:   Mon, 15 Jun 2020 10:53:11 +0100
Message-ID: <20200615095312.398-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200615095312.398-1-shiju.jose@huawei.com>
References: <20200615095312.398-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.26.179]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the vendor specific non-fatal HW errors
to the drivers for the error recovery.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 130 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/ghes.h      |  28 +++++++++
 2 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 24c9642e8fc7..854d8115cdfc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -33,6 +33,7 @@
 #include <linux/irq_work.h>
 #include <linux/llist.h>
 #include <linux/genalloc.h>
+#include <linux/kfifo.h>
 #include <linux/pci.h>
 #include <linux/pfn.h>
 #include <linux/aer.h>
@@ -63,6 +64,11 @@
 #define GHES_ESTATUS_CACHES_SIZE	4
 
 #define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
+
+#define GHES_EVENT_RING_SIZE	256
+#define GHES_GDATA_POOL_MIN_ALLOC_ORDER	3
+#define GHES_GDATA_POOL_MIN_SIZE	65536
+
 /* Prevent too many caches are allocated because of RCU */
 #define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 / 2)
 
@@ -122,6 +128,19 @@ static DEFINE_MUTEX(ghes_list_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
+struct ghes_event_entry {
+	struct acpi_hest_generic_data *gdata;
+	int error_severity;
+};
+
+static DEFINE_KFIFO(ghes_event_ring, struct ghes_event_entry,
+		    GHES_EVENT_RING_SIZE);
+
+static DEFINE_SPINLOCK(ghes_event_ring_lock);
+
+static struct gen_pool *ghes_gdata_pool;
+static unsigned long ghes_gdata_pool_size_request;
+
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
 
@@ -188,6 +207,40 @@ int ghes_estatus_pool_init(int num_ghes)
 	return -ENOMEM;
 }
 
+static int ghes_gdata_pool_init(void)
+{
+	unsigned long addr, len;
+	int rc;
+
+	ghes_gdata_pool = gen_pool_create(GHES_GDATA_POOL_MIN_ALLOC_ORDER, -1);
+	if (!ghes_gdata_pool)
+		return -ENOMEM;
+
+	if (ghes_gdata_pool_size_request < GHES_GDATA_POOL_MIN_SIZE)
+		ghes_gdata_pool_size_request = GHES_GDATA_POOL_MIN_SIZE;
+
+	len = ghes_gdata_pool_size_request;
+	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
+	if (!addr)
+		goto err_pool_alloc;
+
+	vmalloc_sync_mappings();
+
+	rc = gen_pool_add(ghes_gdata_pool, addr, PAGE_ALIGN(len), -1);
+	if (rc)
+		goto err_pool_add;
+
+	return 0;
+
+err_pool_add:
+	vfree((void *)addr);
+
+err_pool_alloc:
+	gen_pool_destroy(ghes_gdata_pool);
+
+	return -ENOMEM;
+}
+
 static int map_gen_v2(struct ghes *ghes)
 {
 	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
@@ -247,6 +300,10 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		goto err_unmap_status_addr;
 	}
 
+	ghes_gdata_pool_size_request += generic->records_to_preallocate *
+					generic->max_sections_per_record *
+					generic->max_raw_data_length;
+
 	return ghes;
 
 err_unmap_status_addr:
@@ -490,6 +547,68 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
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
+	return blocking_notifier_chain_register(&ghes_event_notify_list, nb);
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
+	blocking_notifier_chain_unregister(&ghes_event_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_event_notifier);
+
+static void ghes_event_work_func(struct work_struct *work)
+{
+	struct ghes_event_entry entry;
+	u32 len;
+
+	while (kfifo_get(&ghes_event_ring, &entry)) {
+		blocking_notifier_call_chain(&ghes_event_notify_list,
+					     entry.error_severity,
+					     entry.gdata);
+		len = acpi_hest_get_record_size(entry.gdata);
+		gen_pool_free(ghes_gdata_pool, (unsigned long)entry.gdata, len);
+	}
+}
+
+static DECLARE_WORK(ghes_event_work, ghes_event_work_func);
+
+static void ghes_handle_non_standard_event(struct acpi_hest_generic_data *gdata,
+					   int sev)
+{
+	u32 len;
+	struct ghes_event_entry event_entry;
+
+	len = acpi_hest_get_record_size(gdata);
+	event_entry.gdata = (void *)gen_pool_alloc(ghes_gdata_pool, len);
+	if (event_entry.gdata) {
+		memcpy(event_entry.gdata, gdata, len);
+		event_entry.error_severity = sev;
+
+		if (kfifo_in_spinlocked(&ghes_event_ring, &event_entry, 1,
+					&ghes_event_ring_lock))
+			schedule_work(&ghes_event_work);
+		else
+			pr_warn(GHES_PFX "ghes event queue full\n");
+	}
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -527,6 +646,7 @@ static void ghes_do_proc(struct ghes *ghes,
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
+			ghes_handle_non_standard_event(gdata, sev);
 			log_non_standard_event(sec_type, fru_id, fru_text,
 					       sec_sev, err,
 					       gdata->error_data_length);
@@ -1334,7 +1454,7 @@ static int __init ghes_init(void)
 
 	rc = platform_driver_register(&ghes_platform_driver);
 	if (rc)
-		goto err;
+		goto exit;
 
 	rc = apei_osc_setup();
 	if (rc == 0 && osc_sb_apei_support_acked)
@@ -1346,8 +1466,16 @@ static int __init ghes_init(void)
 	else
 		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
 
+	rc = ghes_gdata_pool_init();
+	if (rc) {
+		pr_warn(GHES_PFX "ghes_gdata_pool_init failed\n");
+		goto err;
+	}
+
 	return 0;
 err:
+	platform_driver_unregister(&ghes_platform_driver);
+exit:
 	return rc;
 }
 device_initcall(ghes_init);
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
-- 
2.17.1


