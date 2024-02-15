Return-Path: <linux-pci+bounces-3500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602088565E7
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F751C227D5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A9131E31;
	Thu, 15 Feb 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1vDdhWE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECC131E22;
	Thu, 15 Feb 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007108; cv=none; b=BpzVtowEsjsBlOaviGe/kByzXrv5ZCSPNpOLIFd7SHujg5TM371StUCk7ApZus4fFmCbUVBNoM4tX7YyRpC3xvcva1pTMc/vPzoJDpR3PF1tRfbo3Eg9c7xMQQtbxCRuuHJgmjUxJn4r9AXiTTocph9wfw6jVEvjqXBjHoX5IsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007108; c=relaxed/simple;
	bh=QONstnRaUZd6vdwTWaThhVGg2jpQZSukX3godEk1yAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU4uWPrhooSZcKDcDw28fikwmGdpV9xj5rSddy0rEzy/e1l9i1uf3zIAWE6Yu4QFITGc9DvWa5pQH8d5AOoWXgsvrL7DDUA4a7+cwxz/26cVH6Z9WNDaLSVGxJ7LR7SBckx9B62SW9F+MMYIryILRxTE2pISGYtMeyyBLmSk7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1vDdhWE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708007106; x=1739543106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QONstnRaUZd6vdwTWaThhVGg2jpQZSukX3godEk1yAg=;
  b=n1vDdhWEgAGS3k0z2+2gkLXYCb2KJuVWD36TuKayafcEbHkbnNkrxUxA
   vxka3McEMeGdJYVcR1477Sn1pZ29Xg1dNBtJ/mwmLajWj9bcR3J++PDzc
   KSTxEM2MyAVkBkXARJYVYoe275bAOzMZQjwiPs2XXphsSrrQdFyt5mpUL
   c7iC2ExMorje0bTi3WJl98QmJvhax1nyRs9EK/SaDb60LvXNG8rO07Vim
   TCkJ+uQEamw6it1erblgZFw94U1xsbUkLLb8wGwaZYPl9UXd5N6gnymKP
   AjkSlmCt3J8oX49IgSOpwHgamn2i1jFcyYKbQZwhAcAIATOp1XRAesjl4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19514427"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19514427"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3701883"
Received: from unknown (HELO mtkaczyk-devel.igk.intel.com) ([10.102.108.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:25:04 -0800
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management support
Date: Thu, 15 Feb 2024 15:23:45 +0100
Message-Id: <20240215142345.6073-3-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240215142345.6073-1-mariusz.tkaczyk@linux.intel.com>
References: <20240215142345.6073-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
managing LED blinking patterns in storage enclosures. NPEM is pattern
oriented and it does not give direct access to LED. Although each of
the patterns (register bits) *could* represent an individual LED, multiple
patterns could also be represented as a single, multi-color LED or a
single LED blinking in a specific interval. The specification leaves
that open.

Each pattern is represented here as a ledclass_dev which can be controlled
through sysfs. For every LED only 2 brightness states are allowed:
LED_ON or LED_OFF. LED appears in sysfs as child device (subdirectory)
of PCI device which has an NPEM Extended Capability and LED's pattern
is enabled in NPEM capability register.

Definition of patterns are described in PCIE Base Specification r6.1[1].
The interface is ready to support enclosures where patterns are not
mutually exclusive, driver may clear other LEDs if they cannot be enabled
together.

Driver is projected to be exclusive NPEM extended capability manager.
It waits up to 1 second after imposing new request, it doesn't verify if
controller is busy before write, assuming that mutex lock gives protection
from concurrent updates. Driver is not be registered if _DSM led management
is available.

NPEM is PCIe extended capability so it should be registered in
pcie_init_capabilities() but it is not possible due to led dependency.
Parent pci_device must be added earlier for led_classdev_register()
to be successful. NPEM does not require configuration on kernel side, it
is safe to register led devices later.

Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
Link: https://lore.kernel.org/linux-pci/cover.1643822289.git.stuart.w.hayes@gmail.com/
Link: https://lore.kernel.org/all/20210601203820.3647-1-stuart.w.hayes@gmail.com/
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/pci/Kconfig           |   7 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/bus.c             |   1 +
 drivers/pci/npem.c            | 339 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 +
 drivers/pci/remove.c          |   1 +
 include/linux/pci.h           |   4 +
 include/uapi/linux/pci_regs.h |  34 ++++
 8 files changed, 395 insertions(+)
 create mode 100644 drivers/pci/npem.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 74147262625b..127bcbed02c0 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -138,6 +138,13 @@ config PCI_IOV
 
 	  If unsure, say N.
 
+config PCI_NPEM
+	bool "Native PCIe Enclosure Management"
+	depends on LEDS_CLASS
+	help
+	  Support for Native PCIe Enclosure Management. It allows managing LED
+	  blinking patterns in storage enclosures.
+
 config PCI_PRI
 	bool "PCI PRI support"
 	select PCI_ATS
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..990d55826e5e 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
+obj-$(CONFIG_PCI_NPEM)		+= npem.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..11bb8afe4eb8 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -345,6 +345,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	if (pci_is_bridge(dev))
 		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
+	pci_npem_create(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
new file mode 100644
index 000000000000..005405b56cda
--- /dev/null
+++ b/drivers/pci/npem.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Native PCIe Enclosure Management
+ *	PCIe Base Specification r6.1 sec 6.28
+ *	PCIe Base Specification r6.1 sec 7.9.19
+ *
+ * Copyright (c) 2023 Intel Corporation
+ *	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
+ */
+#include <linux/acpi.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/leds.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/uleds.h>
+
+#include "pci.h"
+
+/**
+ * struct npem_led - LED details.
+ * @pattern: pattern details.
+ * @npem: npem device.
+ * @name: LED name.
+ * @led: LED device.
+ */
+struct npem_led {
+	const struct npem_pattern *pattern;
+	struct npem *npem;
+	char name[LED_MAX_NAME_SIZE];
+	struct led_classdev led;
+};
+
+/**
+ * struct npem - NPEM device properties.
+ * @dev: PCIe device with NPEM capability.
+ * @npem_lock: to keep concurrent updates synchronized.
+ * @pos: capability offset.
+ * @capabilities: capabilities register content.
+ * @control: control register content.
+ * @leds: available LEDs.
+ */
+struct npem {
+	struct pci_dev *dev;
+	struct mutex npem_lock;
+	u16 pos;
+	u32 capabilities;
+	u32 control;
+	struct npem_led leds[];
+};
+
+struct npem_pattern {
+	u32 bit;
+	char *name;
+};
+
+static const struct npem_pattern patterns[] = {
+	{PCI_NPEM_OK,		"enclosure:ok"},
+	{PCI_NPEM_LOCATE,	"enclosure:locate"},
+	{PCI_NPEM_FAIL,		"enclosure:fail"},
+	{PCI_NPEM_REBUILD,	"enclosure:rebuild"},
+	{PCI_NPEM_PFA,		"enclosure:pfa"},
+	{PCI_NPEM_HOTSPARE,	"enclosure:hotspare"},
+	{PCI_NPEM_ICA,		"enclosure:ica"},
+	{PCI_NPEM_IFA,		"enclosure:ifa"},
+	{PCI_NPEM_IDT,		"enclosure:idt"},
+	{PCI_NPEM_DISABLED,	"enclosure:disabled"},
+	{PCI_NPEM_SPEC_0,	"enclosure:specific_0"},
+	{PCI_NPEM_SPEC_1,	"enclosure:specific_1"},
+	{PCI_NPEM_SPEC_2,	"enclosure:specific_2"},
+	{PCI_NPEM_SPEC_3,	"enclosure:specific_3"},
+	{PCI_NPEM_SPEC_4,	"enclosure:specific_4"},
+	{PCI_NPEM_SPEC_5,	"enclosure:specific_5"},
+	{PCI_NPEM_SPEC_6,	"enclosure:specific_6"},
+	{PCI_NPEM_SPEC_7,	"enclosure:specific_7"},
+};
+
+#define for_each_npem_pattern(ptrn)\
+	for (ptrn = patterns; ptrn < patterns + ARRAY_SIZE(patterns); ptrn++)
+
+/* Reserved bits are outside specification, count only defined bits. */
+static int npem_get_supported_patterns_count(u32 capabilities)
+{
+	const struct npem_pattern *pattern;
+	int cnt = 0;
+
+	for_each_npem_pattern(pattern)
+		if (capabilities & pattern->bit)
+			cnt++;
+
+	return cnt;
+}
+
+static int npem_read_reg(struct npem *npem, u16 reg, u32 *val)
+{
+	int ret = pci_read_config_dword(npem->dev, npem->pos + reg, val);
+
+	return pcibios_err_to_errno(ret);
+}
+
+static int npem_write_ctrl(struct npem *npem, u32 reg)
+{
+	int pos = npem->pos + PCI_NPEM_CTRL;
+	int ret = pci_write_config_dword(npem->dev, pos, reg);
+
+	return pcibios_err_to_errno(ret);
+}
+
+static int npem_set_active_patterns(struct npem *npem, u32 val)
+{
+	int ret, ret_val;
+	u32 cc_status;
+
+	lockdep_assert_held(&npem->npem_lock);
+
+	/* This bit is always required */
+	val |= PCI_NPEM_CTRL_ENABLED;
+	ret = npem_write_ctrl(npem, val);
+	if (ret)
+		return ret;
+
+	/*
+	 * For the case where a NPEM command has not completed immediately,
+	 * it is recommended that software not continuously “spin” on polling
+	 * the status register, but rather poll under interrupt at a reduced
+	 * rate; for example at 10 ms intervals.
+	 *
+	 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of NPEM
+	 * Command Completed"
+	 */
+	ret = read_poll_timeout(npem_read_reg, ret_val,
+				ret_val || (cc_status & PCI_NPEM_STATUS_CC),
+				10 * USEC_PER_MSEC, USEC_PER_SEC, false, npem,
+				PCI_NPEM_STATUS, &cc_status);
+
+	return ret ?: ret_val;
+}
+
+static enum led_brightness npem_get(struct led_classdev *led)
+{
+	struct npem_led *nled = container_of(led, struct npem_led, led);
+	u32 mask = nled->pattern->bit | PCI_NPEM_CTRL_ENABLED;
+	struct npem *npem = nled->npem;
+	int ret, val = 0;
+
+	ret = mutex_lock_interruptible(&npem->npem_lock);
+	if (ret)
+		return ret;
+
+	/* Pattern is ON if pattern and PCI_NPEM_CTRL_ENABLED bits are set */
+	if ((npem->control & mask) == mask)
+		val = 1;
+
+	mutex_unlock(&npem->npem_lock);
+
+	return val;
+}
+
+int npem_set(struct led_classdev *led, enum led_brightness brightness)
+{
+	struct npem_led *nled = container_of(led, struct npem_led, led);
+	struct npem *npem = nled->npem;
+	u32 patterns;
+	int ret;
+
+	ret = mutex_lock_interruptible(&npem->npem_lock);
+	if (ret)
+		return ret;
+
+	if (brightness == LED_OFF)
+		patterns = npem->control & ~(nled->pattern->bit);
+	else
+		patterns = npem->control | nled->pattern->bit;
+
+	ret = npem_set_active_patterns(npem, patterns);
+	if (ret == 0)
+		/*
+		 * Read register after write to keep cache in-sync. Controller
+		 * may modify active bits, e.g. some patterns could be mutally
+		 * exclusive.
+		 */
+		ret = npem_read_reg(npem, PCI_NPEM_CTRL, &npem->control);
+
+	mutex_unlock(&npem->npem_lock);
+	return ret;
+}
+
+#define DSM_GUID GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,  0x8c, 0xb7, 0x74, 0x7e,\
+			   0xd5, 0x1e, 0x19, 0x4d)
+#define GET_SUPPORTED_STATES_DSM	BIT(1)
+#define GET_STATE_DSM			BIT(2)
+#define SET_STATE_DSM			BIT(3)
+
+static bool npem_has_dsm(struct pci_dev *pdev)
+{
+	static const guid_t dsm_guid = DSM_GUID;
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return false;
+
+	if (acpi_check_dsm(handle, &dsm_guid, 0x1, GET_SUPPORTED_STATES_DSM |
+			   GET_STATE_DSM | SET_STATE_DSM) == true)
+		return true;
+	return false;
+}
+
+static int npem_set_led_classdev(struct npem *npem, struct npem_led *nled)
+{
+	struct led_classdev *led = &nled->led;
+	struct led_init_data init_data = {};
+	char *name = nled->name;
+	int ret;
+
+	init_data.devicename = pci_name(npem->dev);
+	init_data.default_label = nled->pattern->name;
+
+	ret = led_compose_name(&npem->dev->dev, &init_data, name);
+	if (ret)
+		return ret;
+
+	led->name = name;
+	led->brightness_set_blocking = npem_set;
+	led->brightness_get = npem_get;
+	led->max_brightness = LED_ON;
+	led->default_trigger = "none";
+	led->flags = 0;
+
+	ret = led_classdev_register(&npem->dev->dev, led);
+	if (ret)
+		/* Clear the name to indicate that it is not registered. */
+		name[0] = 0;
+	return ret;
+}
+
+void npem_free(struct npem *npem, int led_cnt)
+{
+	struct npem_led *nled;
+	int cnt = 0;
+
+	while (cnt < led_cnt) {
+		nled = &npem->leds[cnt++];
+
+		if (nled->name[0])
+			led_classdev_unregister(&nled->led);
+	}
+
+	mutex_destroy(&npem->npem_lock);
+	kfree(npem);
+}
+
+int npem_init(struct pci_dev *dev, int pos, u32 capabilities)
+{
+	int led_cnt = npem_get_supported_patterns_count(capabilities);
+	const struct npem_pattern *pattern;
+	struct npem_led *nled;
+	struct npem *npem;
+	int led_idx = 0;
+	int ret;
+
+	npem = kzalloc(sizeof(struct npem) + sizeof(struct npem_led) * led_cnt,
+		       GFP_KERNEL);
+	if (!npem)
+		return -ENOMEM;
+
+	npem->pos = pos;
+	npem->dev = dev;
+	npem->capabilities = capabilities;
+
+	ret = npem_read_reg(npem, PCI_NPEM_CTRL, &npem->control);
+	if (ret) {
+		npem_free(npem, led_cnt);
+		return ret;
+	}
+
+	/*
+	 * Do not take npem->npem_lock, get_brightness() is called on
+	 * registration path.
+	 */
+	mutex_init(&npem->npem_lock);
+
+	for_each_npem_pattern(pattern) {
+		if ((npem->capabilities & pattern->bit) == 0)
+			/* Do not register not supported pattern */
+			continue;
+
+		nled = &npem->leds[led_idx++];
+		nled->pattern = pattern;
+		nled->npem = npem;
+
+		ret = npem_set_led_classdev(npem, nled);
+		if (ret) {
+			npem_free(npem, led_cnt);
+			return ret;
+		}
+	}
+
+	dev->npem = npem;
+	return 0;
+}
+
+void pci_npem_remove(struct pci_dev *dev)
+{
+	npem_free(dev->npem,
+		  npem_get_supported_patterns_count(dev->npem->capabilities));
+}
+
+void pci_npem_create(struct pci_dev *dev)
+{
+	int pos, ret;
+	u32 cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
+	if (pos == 0)
+		return;
+
+	if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
+	    (cap & PCI_NPEM_CAPABLE) == 0)
+		return;
+
+	/*
+	 * OS should use the DSM for LED control if it is available
+	 * PCI Firmware Spec r3.3 sec 4.7.
+	 */
+	if (npem_has_dsm(dev))
+		return;
+
+	ret = npem_init(dev, pos, cap);
+	if (ret)
+		pci_err(dev, "Failed to register Native PCIe Enclosure Management, err: %d\n",
+			ret);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e9750b1b19ba..6f79b1e5ee57 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -327,6 +327,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_NPEM
+void pci_npem_create(struct pci_dev *dev);
+void pci_npem_remove(struct pci_dev *dev);
+#else
+static inline void pci_npem_create(struct pci_dev *dev) { }
+static inline void pci_npem_remove(struct pci_dev *dev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..f2a346802f35 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -20,6 +20,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 	if (pci_dev_is_added(dev)) {
 
 		device_release_driver(&dev->dev);
+		pci_npem_remove(dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
 		of_pci_remove_node(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ab0d13672da..13cbbfb80963 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -516,6 +516,10 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_PCI_NPEM
+	struct npem *npem;
+#endif
+
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..5ff3190da159 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -740,6 +740,7 @@
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
@@ -1148,4 +1149,37 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
+/* Native PCIe Enclosure Management */
+#define PCI_NPEM_CAP	0x04 /* NPEM capability register */
+#define	 PCI_NPEM_CAPABLE		0x01	/* NPEM Capable */
+
+#define PCI_NPEM_CTRL	0x08 /* NPEM control register */
+#define	 PCI_NPEM_CTRL_ENABLED		0x01	/* NPEM Enabled */
+
+#define PCI_NPEM_STATUS	0x0c /* NPEM status register */
+#define	 PCI_NPEM_STATUS_CC		0x01 /* NPEM Command completed */
+/*
+ * Native PCIe Enclosure Management patterns and enclosure specific
+ * bits are corresponding for capability and control registers
+ */
+#define  PCI_NPEM_RESET			0x0001 /* NPEM Reset Command */
+#define  PCI_NPEM_OK			0x0004 /* NPEM pattern OK */
+#define  PCI_NPEM_LOCATE		0x0008 /* NPEM pattern Locate */
+#define  PCI_NPEM_FAIL			0x0010 /* NPEM pattern Fail */
+#define  PCI_NPEM_REBUILD		0x0020 /* NPEM pattern Rebuild */
+#define  PCI_NPEM_PFA			0x0040 /* NPEM pattern Predicted Failure Analysis */
+#define  PCI_NPEM_HOTSPARE		0x0080 /* NPEM pattern Hot Spare */
+#define  PCI_NPEM_ICA			0x0100 /* NPEM pattern In Critical Array */
+#define  PCI_NPEM_IFA			0x0200 /* NPEM pattern In Failed Array */
+#define  PCI_NPEM_IDT			0x0400 /* NPEM pattern Invalid Device Type */
+#define  PCI_NPEM_DISABLED		0x0800 /* NPEM pattern Disabled */
+#define  PCI_NPEM_SPEC_0		0x00800000
+#define  PCI_NPEM_SPEC_1		0x01000000
+#define  PCI_NPEM_SPEC_2		0x02000000
+#define  PCI_NPEM_SPEC_3		0x04000000
+#define  PCI_NPEM_SPEC_4		0x08000000
+#define  PCI_NPEM_SPEC_5		0x10000000
+#define  PCI_NPEM_SPEC_6		0x20000000
+#define  PCI_NPEM_SPEC_7		0x40000000
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.35.3


