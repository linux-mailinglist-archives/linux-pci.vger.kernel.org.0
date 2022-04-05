Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220C84F471C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiDEU7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbiDEUUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 16:20:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE22692BA;
        Tue,  5 Apr 2022 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649188806; x=1680724806;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9+5sWIrw/8+D5NpfC6Yf1k8qyONKg8kSkpaSpE5bF8=;
  b=mwjp+Uy7XBAj/JvV932wF7wUZOXvjrLH7tuCmQJ5TJg/R2fYOc1m9656
   LJUXKyBqigXEtwQYmps0KK368DlxNR8ZCL/yqUk9xPygyr6TATXkfQnZB
   +UC8GAHp2GZB7GUFUGX6sQVMg/+zM0TU11vxpdcTHph8t8cTH864Yc1Bt
   oAYQVZPE7NICBo+93+VY7rLIvDq6+JxJUDZpiRVMo7RDiYANcV/cHt9QJ
   ruQ5J7c/zWDxz6plL8fGmFGUX2Igfe3cWkn0VZFJ2n3Sgiamw1iIBUQSK
   nZ7/VIuiFWgjVInC2mlDGVXjG3GNJ6kgL3zQvE4saE6ZsVrr5d4o3NZQA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260548291"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260548291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 13:00:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="588073914"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 13:00:05 -0700
Subject: [PATCH v2] PM: CXL: Disable suspend
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Tue, 05 Apr 2022 13:00:05 -0700
Message-ID: <164918880566.2022733.9710638662231385597.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL specification claims S3 support at a hardware level, but at a
system software level there are some missing pieces. Section 9.4 (CXL
2.0) rightly claims that "CXL mem adapters may need aux power to retain
memory context across S3", but there is no enumeration mechanism for the
OS to determine if a given adapter has that support. Moreover the save
state and resume image for the system may inadvertantly end up in a CXL
device that needs to be restored before the save state is recoverable.
I.e. a circular dependency that is not resolvable without a third party
save-area.

Arrange for the cxl_mem driver to fail S3 attempts. This still nominaly
allows for suspend, but requires unbinding all CXL memory devices before
the suspend to ensure the typical DRAM flow is taken. The cxl_mem unbind
flow is intended to also tear down all CXL memory regions associated
with a given cxl_memdev.

It is reasonable to assume that any device participating in a System RAM
range published in the EFI memory map is covered by aux power and
save-area outside the device itself. So this restriction can be
minimized in the future once pre-existing region enumeration support
arrives, and perhaps a spec update to clarify if the EFI memory map is
sufficent for determining the range of devices managed by
platform-firmware for S3 support.

Per Rafael, if the CXL configuration prevents suspend then it should
fail early before tasks are frozen, and mem_sleep should stop showing
'mem' as an option [1]. Effectively CXL augments the platform suspend
->valid() op since, for example, the ACPI ops are not aware of the CXL /
PCI dependencies. Given the split role of platform firmware vs OS
provisioned CXL memory it is up to the cxl_mem driver to determine if
the CXL configuration has elements that platform firmware may not be
prepared to restore.

Link: https://lore.kernel.org/r/CAJZ5v0hGVN_=3iU8OLpHY3Ak35T5+JcBM-qs8SbojKrpd0VXsA@mail.gmail.com [1]
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/Makefile           |    2 +-
 drivers/cxl/Kconfig        |    4 ++++
 drivers/cxl/Makefile       |    2 +-
 drivers/cxl/core/Makefile  |    1 +
 drivers/cxl/core/memdev.c  |    1 -
 drivers/cxl/core/suspend.c |   23 +++++++++++++++++++++++
 drivers/cxl/cxlmem.h       |   11 +++++++++++
 drivers/cxl/mem.c          |   22 +++++++++++++++++++++-
 include/linux/pm.h         |    9 +++++++++
 kernel/power/hibernate.c   |    2 +-
 kernel/power/main.c        |    5 ++++-
 kernel/power/suspend.c     |    3 ++-
 12 files changed, 78 insertions(+), 7 deletions(-)
 create mode 100644 drivers/cxl/core/suspend.c

diff --git a/drivers/Makefile b/drivers/Makefile
index 020780b6b4d2..f735c4955143 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -72,9 +72,9 @@ obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ mfd/ nfc/
 obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DAX)		+= dax/
-obj-$(CONFIG_CXL_BUS)		+= cxl/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
 obj-$(CONFIG_NUBUS)		+= nubus/
+obj-y				+= cxl/
 obj-y				+= macintosh/
 obj-y				+= scsi/
 obj-y				+= nvme/
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index b88ab956bb7c..f64e3984689f 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -98,4 +98,8 @@ config CXL_PORT
 	default CXL_BUS
 	tristate
 
+config CXL_SUSPEND
+	def_bool y
+	depends on SUSPEND && CXL_MEM
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index ce267ef11d93..a78270794150 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CXL_BUS) += core/
+obj-y += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 6d37cd78b151..9d35085d25af 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
 cxl_core-y := port.o
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1f76b28f9826..efe4d2e9bfef 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -251,7 +251,6 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
-	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
 	cdev = &cxlmd->cdev;
diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
new file mode 100644
index 000000000000..88bdbe30a1df
--- /dev/null
+++ b/drivers/cxl/core/suspend.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/atomic.h>
+#include <linux/export.h>
+
+static atomic_t mem_active;
+
+bool cxl_mem_active(void)
+{
+	return atomic_read(&mem_active) != 0;
+}
+
+void cxl_mem_active_inc(void)
+{
+	atomic_inc(&mem_active);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, CXL);
+
+void cxl_mem_active_dec(void)
+{
+	atomic_dec(&mem_active);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, CXL);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 243dd86a8b46..7235d2f976e5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -353,6 +353,17 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+#ifdef CONFIG_CXL_SUSPEND
+void cxl_mem_active_inc(void);
+void cxl_mem_active_dec(void);
+#else
+static inline void cxl_mem_active_inc(void)
+{
+}
+static inline void cxl_mem_active_dec(void)
+{
+}
+#endif
 
 struct cxl_hdm {
 	struct cxl_component_regs regs;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 49a4b1c47299..0576d2d3df07 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -129,6 +129,11 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
 	return do_hdm_init;
 }
 
+static void enable_suspend(void *data)
+{
+	cxl_mem_active_dec();
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -207,7 +212,22 @@ static int cxl_mem_probe(struct device *dev)
 out:
 	cxl_device_unlock(&parent_port->dev);
 	put_device(&parent_port->dev);
-	return rc;
+
+	/*
+	 * The kernel may be operating out of CXL memory on this device,
+	 * there is no spec defined way to determine whether this device
+	 * preserves contents over suspend, and there is no simple way
+	 * to arrange for the suspend image to avoid CXL memory which
+	 * would setup a circular dependency between PCI resume and save
+	 * state restoration.
+	 *
+	 * TODO: support suspend when all the regions this device is
+	 * hosting are locked and covered by the system address map,
+	 * i.e. platform firmware owns restoring the HDM configuration
+	 * that it locked.
+	 */
+	cxl_mem_active_inc();
+	return devm_add_action_or_reset(dev, enable_suspend, NULL);
 }
 
 static struct cxl_driver cxl_mem_driver = {
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e65b3ab28377..7911c4c9a7be 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -36,6 +36,15 @@ static inline void pm_vt_switch_unregister(struct device *dev)
 }
 #endif /* CONFIG_VT_CONSOLE_SLEEP */
 
+#ifdef CONFIG_CXL_SUSPEND
+bool cxl_mem_active(void);
+#else
+static inline bool cxl_mem_active(void)
+{
+	return false;
+}
+#endif
+
 /*
  * Device power management
  */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 938d5c78b421..20a66bf9f465 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -83,7 +83,7 @@ bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
 		!security_locked_down(LOCKDOWN_HIBERNATION) &&
-		!secretmem_active();
+		!secretmem_active() && !cxl_mem_active();
 }
 
 /**
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 7e646079fbeb..3e6be1c33e0b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -127,7 +127,9 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 	char *s = buf;
 	suspend_state_t i;
 
-	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
+	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
+		if (i >= PM_SUSPEND_MEM && cxl_mem_active())
+			continue;
 		if (mem_sleep_states[i]) {
 			const char *label = mem_sleep_states[i];
 
@@ -136,6 +138,7 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 			else
 				s += sprintf(s, "%s ", label);
 		}
+	}
 
 	/* Convert the last space to a newline if needed. */
 	if (s != buf)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 6fcdee7e87a5..827075944d28 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -236,7 +236,8 @@ EXPORT_SYMBOL_GPL(suspend_valid_only_mem);
 
 static bool sleep_state_supported(suspend_state_t state)
 {
-	return state == PM_SUSPEND_TO_IDLE || valid_state(state);
+	return state == PM_SUSPEND_TO_IDLE ||
+	       (valid_state(state) && !cxl_mem_active());
 }
 
 static int platform_suspend_prepare(suspend_state_t state)

