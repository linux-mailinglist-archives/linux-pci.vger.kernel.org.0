Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922BC49768C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiAXAaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:30:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:5542 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235059AbiAXA37 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984199; x=1674520199;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5pKqdJFseU1d8xiWff/9uYHf4J7Kb8t+RT8M/z5+0Q=;
  b=LT6sii7ONJVyIp/fx2ZKS9UeUEVyXGltRc05FVxHOKM6aKkX54jSXRu1
   NYp2DhfbVsp/aKJ+OlnfadoOpU6O/kpjtd28Ht3BsvJLjJZzPL16sIyWm
   DGA2AuBVi7l333qoBLk/1dT6ho1LRkXjyV+eKk9v7gAyJBxwxENknIgYt
   7jOIqsMbogOPJ8DByuYKGfS4TENP+WrdNVOz44nXOEe5adHVAhP0slpl+
   JcH12eD+mGAx8WRrI00zYz3JQMZB6mh6jzrviA9OOP0xMRIsxIfm4vppP
   RydRIwidn2EkAnqvDqSd6z1G0I3/S1KtOeIpEnHBbyMriNqgSt2R2BZjq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332288836"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332288836"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="531916276"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:59 -0800
Subject: [PATCH v3 15/40] cxl: Prove CXL locking
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:58 -0800
Message-ID: <164298419875.3018233.7880727408723281411.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When CONFIG_PROVE_LOCKING is enabled the 'struct device' definition gets
an additional mutex that is not clobbered by
lockdep_set_novalidate_class() like the typical device_lock(). This
allows for local annotation of subsystem locks with mutex_lock_nested()
per the subsystem's object/lock hierarchy. For CXL, this primarily needs
the ability to lock ports by depth and child objects of ports by their
parent parent-port lock.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c       |   10 +++---
 drivers/cxl/core/pmem.c  |    4 +-
 drivers/cxl/core/port.c  |   43 ++++++++++++++++++++-------
 drivers/cxl/cxl.h        |   74 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pmem.c       |   12 ++++---
 drivers/nvdimm/nd-core.h |    2 +
 lib/Kconfig.debug        |   23 ++++++++++++++
 7 files changed, 143 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 4e8086525edc..93d1dc56892a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -176,14 +176,14 @@ static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device
 {
 	struct cxl_dport *dport;
 
-	device_lock(&port->dev);
+	cxl_device_lock(&port->dev);
 	list_for_each_entry(dport, &port->dports, list)
 		if (dport->dport == dev) {
-			device_unlock(&port->dev);
+			cxl_device_unlock(&port->dev);
 			return dport;
 		}
 
-	device_unlock(&port->dev);
+	cxl_device_unlock(&port->dev);
 	return NULL;
 }
 
@@ -264,9 +264,9 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (IS_ERR(cxld))
 		return PTR_ERR(cxld);
 
-	device_lock(&port->dev);
+	cxl_device_lock(&port->dev);
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
-	device_unlock(&port->dev);
+	cxl_device_unlock(&port->dev);
 
 	single_port_map[0] = dport->port_id;
 
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index b5fca97b0a07..40b3f5030496 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -115,10 +115,10 @@ static void unregister_nvb(void *_cxl_nvb)
 	 * work to flush. Once the state has been changed to 'dead' then no new
 	 * work can be queued by user-triggered bind.
 	 */
-	device_lock(&cxl_nvb->dev);
+	cxl_device_lock(&cxl_nvb->dev);
 	flush = cxl_nvb->state != CXL_NVB_NEW;
 	cxl_nvb->state = CXL_NVB_DEAD;
-	device_unlock(&cxl_nvb->dev);
+	cxl_device_unlock(&cxl_nvb->dev);
 
 	/*
 	 * Even though the device core will trigger device_release_driver()
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4ec5febf73fb..f58b2d502ac8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -111,7 +111,7 @@ static ssize_t target_list_show(struct device *dev,
 	ssize_t offset = 0;
 	int i, rc = 0;
 
-	device_lock(dev);
+	cxl_device_lock(dev);
 	for (i = 0; i < cxld->interleave_ways; i++) {
 		struct cxl_dport *dport = cxld->target[i];
 		struct cxl_dport *next = NULL;
@@ -127,7 +127,7 @@ static ssize_t target_list_show(struct device *dev,
 			break;
 		offset += rc;
 	}
-	device_unlock(dev);
+	cxl_device_unlock(dev);
 
 	if (rc < 0)
 		return rc;
@@ -214,6 +214,12 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
+bool is_cxl_decoder(struct device *dev)
+{
+	return dev->type->release == cxl_decoder_release;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_decoder, CXL);
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
@@ -235,10 +241,10 @@ static void cxl_port_release(struct device *dev)
 	struct cxl_port *port = to_cxl_port(dev);
 	struct cxl_dport *dport, *_d;
 
-	device_lock(dev);
+	cxl_device_lock(dev);
 	list_for_each_entry_safe(dport, _d, &port->dports, list)
 		cxl_dport_release(dport);
-	device_unlock(dev);
+	cxl_device_unlock(dev);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -254,6 +260,12 @@ static const struct device_type cxl_port_type = {
 	.groups = cxl_port_attribute_groups,
 };
 
+bool is_cxl_port(struct device *dev)
+{
+	return dev->type == &cxl_port_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_port, CXL);
+
 struct cxl_port *to_cxl_port(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_port_type,
@@ -261,13 +273,14 @@ struct cxl_port *to_cxl_port(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
 }
+EXPORT_SYMBOL_NS_GPL(to_cxl_port, CXL);
 
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
 	struct cxl_dport *dport;
 
-	device_lock(&port->dev);
+	cxl_device_lock(&port->dev);
 	list_for_each_entry(dport, &port->dports, list) {
 		char link_name[CXL_TARGET_STRLEN];
 
@@ -276,7 +289,7 @@ static void unregister_port(void *_port)
 			continue;
 		sysfs_remove_link(&port->dev.kobj, link_name);
 	}
-	device_unlock(&port->dev);
+	cxl_device_unlock(&port->dev);
 	device_unregister(&port->dev);
 }
 
@@ -407,7 +420,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 {
 	struct cxl_dport *dup;
 
-	device_lock(&port->dev);
+	cxl_device_lock(&port->dev);
 	dup = find_dport(port, new->port_id);
 	if (dup)
 		dev_err(&port->dev,
@@ -416,7 +429,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 			dev_name(dup->dport));
 	else
 		list_add_tail(&new->list, &port->dports);
-	device_unlock(&port->dev);
+	cxl_device_unlock(&port->dev);
 
 	return dup ? -EEXIST : 0;
 }
@@ -475,7 +488,7 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	if (!target_map)
 		return 0;
 
-	device_lock(&port->dev);
+	cxl_device_lock(&port->dev);
 	if (list_empty(&port->dports)) {
 		rc = -EINVAL;
 		goto out_unlock;
@@ -492,7 +505,7 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	}
 
 out_unlock:
-	device_unlock(&port->dev);
+	cxl_device_unlock(&port->dev);
 
 	return rc;
 }
@@ -712,15 +725,23 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
 
 static int cxl_bus_probe(struct device *dev)
 {
-	return to_cxl_drv(dev->driver)->probe(dev);
+	int rc;
+
+	cxl_nested_lock(dev);
+	rc = to_cxl_drv(dev->driver)->probe(dev);
+	cxl_nested_unlock(dev);
+
+	return rc;
 }
 
 static void cxl_bus_remove(struct device *dev)
 {
 	struct cxl_driver *cxl_drv = to_cxl_drv(dev->driver);
 
+	cxl_nested_lock(dev);
 	if (cxl_drv->remove)
 		cxl_drv->remove(dev);
+	cxl_nested_unlock(dev);
 }
 
 struct bus_type cxl_bus_type = {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c1dc53492773..569cbe7f23d6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -285,6 +285,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport == port->dev.parent;
 }
 
+bool is_cxl_port(struct device *dev);
 struct cxl_port *to_cxl_port(struct device *dev);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
@@ -295,6 +296,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
+bool is_cxl_decoder(struct device *dev);
 struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 					   unsigned int nr_targets);
 struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
@@ -347,4 +349,76 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
 #ifndef __mock
 #define __mock static
 #endif
+
+#ifdef CONFIG_PROVE_CXL_LOCKING
+enum cxl_lock_class {
+	CXL_ANON_LOCK,
+	CXL_NVDIMM_LOCK,
+	CXL_NVDIMM_BRIDGE_LOCK,
+	CXL_PORT_LOCK,
+};
+
+static inline void cxl_nested_lock(struct device *dev)
+{
+	if (is_cxl_port(dev)) {
+		struct cxl_port *port = to_cxl_port(dev);
+
+		mutex_lock_nested(&dev->lockdep_mutex,
+				  CXL_PORT_LOCK + port->depth);
+	} else if (is_cxl_decoder(dev)) {
+		struct cxl_port *port = to_cxl_port(dev->parent);
+
+		mutex_lock_nested(&dev->lockdep_mutex,
+				  CXL_PORT_LOCK + port->depth + 1);
+	} else if (is_cxl_nvdimm_bridge(dev))
+		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_BRIDGE_LOCK);
+	else if (is_cxl_nvdimm(dev))
+		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_LOCK);
+	else
+		mutex_lock_nested(&dev->lockdep_mutex, CXL_ANON_LOCK);
+}
+
+static inline void cxl_nested_unlock(struct device *dev)
+{
+	mutex_unlock(&dev->lockdep_mutex);
+}
+
+static inline void cxl_device_lock(struct device *dev)
+{
+	/*
+	 * For double lock errors the lockup will happen before lockdep
+	 * warns at cxl_nested_lock(), so assert explicitly.
+	 */
+	lockdep_assert_not_held(&dev->lockdep_mutex);
+
+	device_lock(dev);
+	cxl_nested_lock(dev);
+}
+
+static inline void cxl_device_unlock(struct device *dev)
+{
+	cxl_nested_unlock(dev);
+	device_unlock(dev);
+}
+#else
+static inline void cxl_nested_lock(struct device *dev)
+{
+}
+
+static inline void cxl_nested_unlock(struct device *dev)
+{
+}
+
+static inline void cxl_device_lock(struct device *dev)
+{
+	device_lock(dev);
+}
+
+static inline void cxl_device_unlock(struct device *dev)
+{
+	device_unlock(dev);
+}
+#endif
+
+
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index b65a272a2d6d..15ad666ab03e 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -43,7 +43,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	if (!cxl_nvb)
 		return -ENXIO;
 
-	device_lock(&cxl_nvb->dev);
+	cxl_device_lock(&cxl_nvb->dev);
 	if (!cxl_nvb->nvdimm_bus) {
 		rc = -ENXIO;
 		goto out;
@@ -68,7 +68,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	dev_set_drvdata(dev, nvdimm);
 	rc = devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);
 out:
-	device_unlock(&cxl_nvb->dev);
+	cxl_device_unlock(&cxl_nvb->dev);
 	put_device(&cxl_nvb->dev);
 
 	return rc;
@@ -233,7 +233,7 @@ static void cxl_nvb_update_state(struct work_struct *work)
 	struct nvdimm_bus *victim_bus = NULL;
 	bool release = false, rescan = false;
 
-	device_lock(&cxl_nvb->dev);
+	cxl_device_lock(&cxl_nvb->dev);
 	switch (cxl_nvb->state) {
 	case CXL_NVB_ONLINE:
 		if (!online_nvdimm_bus(cxl_nvb)) {
@@ -251,7 +251,7 @@ static void cxl_nvb_update_state(struct work_struct *work)
 	default:
 		break;
 	}
-	device_unlock(&cxl_nvb->dev);
+	cxl_device_unlock(&cxl_nvb->dev);
 
 	if (release)
 		device_release_driver(&cxl_nvb->dev);
@@ -327,9 +327,9 @@ static int cxl_nvdimm_bridge_reset(struct device *dev, void *data)
 		return 0;
 
 	cxl_nvb = to_cxl_nvdimm_bridge(dev);
-	device_lock(dev);
+	cxl_device_lock(dev);
 	cxl_nvb->state = CXL_NVB_NEW;
-	device_unlock(dev);
+	cxl_device_unlock(dev);
 
 	return 0;
 }
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index a11850dd475d..2650a852eeaf 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -185,7 +185,7 @@ static inline void devm_nsio_disable(struct device *dev,
 }
 #endif
 
-#ifdef CONFIG_PROVE_LOCKING
+#ifdef CONFIG_PROVE_NVDIMM_LOCKING
 extern struct class *nd_class;
 
 enum {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ef7ce18b4f5..ea9291723d06 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1509,6 +1509,29 @@ config CSD_LOCK_WAIT_DEBUG
 	  include the IPI handler function currently executing (if any)
 	  and relevant stack traces.
 
+choice
+	prompt "Lock debugging: prove subsystem device_lock() correctness"
+	depends on PROVE_LOCKING
+	help
+	  For subsystems that have instrumented their usage of the device_lock()
+	  with nested annotations, enable lock dependency checking. The locking
+	  hierarchy 'subclass' identifiers are not compatible across
+	  sub-systems, so only one can be enabled at a time.
+
+config PROVE_NVDIMM_LOCKING
+	bool "NVDIMM"
+	depends on LIBNVDIMM
+	help
+	  Enable lockdep to validate nd_device_lock() usage.
+
+config PROVE_CXL_LOCKING
+	bool "CXL"
+	depends on CXL_BUS
+	help
+	  Enable lockdep to validate cxl_device_lock() usage.
+
+endchoice
+
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS

