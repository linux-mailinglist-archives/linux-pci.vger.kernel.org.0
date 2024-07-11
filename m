Return-Path: <linux-pci+bounces-10144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102B992E248
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DB21C22E14
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC52150992;
	Thu, 11 Jul 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7T42vzW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745C155332
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686605; cv=none; b=ZbY4CFbCd3oN7n0bwKJzM9bJrUxVstlLVXQXDjQhVo94+6oz8sYv9bDSEaFJVpoQfRpTCprDp8No52i8Ycpe7UZg9odc167N0N4wexg9b9vUpbTymvG2fq8Vils4PYPei4IiGJ2nI9X4T9bBDrZ7oXKC9xqJh2hIm4ud75rf3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686605; c=relaxed/simple;
	bh=LFI78P/1p72iX4XYkm80nRte77NWuZJ60rtIFZybpDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cd0tfmDSsglsyFBnlcdwe1sSkrfpO9RLrEODdRMTRXmw3c3gwswJSA85or/YxsEQvtbv5tpgSoV5wxLUcMy2EjCwaPANcSWvoxnyuQ2DXR8grBssLMZ+C4FY6KNk1gnEzmauVxD60LiWuPbDkBYnZer/a4bzPbLgm5RvfaxB1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7T42vzW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720686604; x=1752222604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFI78P/1p72iX4XYkm80nRte77NWuZJ60rtIFZybpDs=;
  b=f7T42vzWoqB6n5IZsxIO7BMtst0GzOTWmeaOWSkQp9iCIbViVsAMNQdc
   d9Spzc6aK/YXXJWTAJlFkm18uUdi/qVqJNNaKXnQQvbIJTcn+JaVlEIdD
   rv6JaHAKgYsuAhrFF9xpNgliNJ2dKo3jOL6T9EN4iyjqvsOdzPGDi54wa
   HMLXZQ0v+TJk3pG22Y9rsD3ZWus2QuBPJRjhS0lDWXBqCkxYHF+jJkdNP
   TC1ipGc5n3XaA0P6FmbrSvZyTH1wbCKqQkQpuHhn00M9m6Sp0HJ17VA8K
   n4s8AESCiXjITNM0UJbJLKZUS3pS0KOIOdf/awEthVh1MDm/DglWg3Ve0
   A==;
X-CSE-ConnectionGUID: dhiRmapuQzmFIXyysXsQAg==
X-CSE-MsgGUID: kn6hoc3gSiqzLgXKtvSY1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="43471027"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="43471027"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:30:03 -0700
X-CSE-ConnectionGUID: ip7PRR29QhK2zp2Co28zIA==
X-CSE-MsgGUID: J77e1mUdRWa7YPCQY/HZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48455320"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:30:00 -0700
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management support
Date: Thu, 11 Jul 2024 10:30:08 +0200
Message-Id: <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
managing LED in storage enclosures. NPEM is indication oriented
and it does not give direct access to LED. Although each of
the indications *could* represent an individual LED, multiple
indications could also be represented as a single,
multi-color LED or a single LED blinking in a specific interval.
The specification leaves that open.

Each enabled indication (capability register bit on) is represented as a
ledclass_dev which can be controlled through sysfs. For every ledclass
device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
It is corresponding to NPEM control register (Indication bit on/off).

Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
device which has an NPEM Extended Capability and indication is enabled
in NPEM capability register. For example, these are leds created for
pcieport "10000:02:05.0" on my setup:

leds/
├── 10000:02:05.0:enclosure:fail
├── 10000:02:05.0:enclosure:locate
├── 10000:02:05.0:enclosure:ok
└── 10000:02:05.0:enclosure:rebuild

They can be also found in "/sys/class/leds" directory. Parent PCIe device
bdf is used to guarantee uniqueness across leds subsystem.

To enable/disable fail indication "brightness" file can be edited:
echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness

PCIe r6.1, sec 7.9.19.2 defines the possible indications.

Multiple indications for same parent PCIe device can conflict and
hardware may update them when processing new request. To avoid issues,
driver refresh all indications by reading back control register.

Driver is projected to be exclusive NPEM extended capability manager.
It waits up to 1 second after imposing new request, it doesn't verify if
controller is busy before write, assuming that mutex lock gives protection
from concurrent updates. Driver is not registered if _DSM LED management
is available.

NPEM is a PCIe extended capability so it should be registered in
pcie_init_capabilities() but it is not possible due to LED dependency.
Parent pci_device must be added earlier for led_classdev_register()
to be successful. NPEM does not require configuration on kernel side, it
is safe to register LED devices later.

Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/pci/Kconfig           |   9 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/npem.c            | 449 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 +
 drivers/pci/probe.c           |   2 +
 drivers/pci/remove.c          |   2 +
 include/linux/pci.h           |   3 +
 include/uapi/linux/pci_regs.h |  35 +++
 8 files changed, 509 insertions(+)
 create mode 100644 drivers/pci/npem.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..e696e69ad516 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -143,6 +143,15 @@ config PCI_IOV
 
 	  If unsure, say N.
 
+config PCI_NPEM
+	bool "Native PCIe Enclosure Management"
+	depends on LEDS_CLASS=y
+	help
+	  Support for Native PCIe Enclosure Management. It allows managing LED
+	  indications in storage enclosures. Enclosure must support following
+	  indications: OK, Locate, Fail, Rebuild, other indications are
+	  optional.
+
 config PCI_PRI
 	bool "PCI PRI support"
 	select PCI_ATS
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 175302036890..cd5f655d4be9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
+obj-$(CONFIG_PCI_NPEM)		+= npem.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
new file mode 100644
index 000000000000..3aa0b6e94cbd
--- /dev/null
+++ b/drivers/pci/npem.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe Enclosure management driver created for LED interfaces based on
+ * indications. It says *what indications* blink but does not specify *how*
+ * they blink - it is hardware defined.
+ *
+ * The driver name refers to Native PCIe Enclosure Management. It is
+ * first indication oriented standard with specification.
+ *
+ * Native PCIe Enclosure Management (NPEM)
+ *	PCIe Base Specification r6.1 sec 6.28
+ *	PCIe Base Specification r6.1 sec 7.9.19
+ *
+ * Copyright (c) 2023-2024 Intel Corporation
+ *	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/leds.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+#include <linux/types.h>
+#include <linux/uleds.h>
+
+#include "pci.h"
+
+struct indication {
+	u32 bit;
+	const char *name;
+};
+
+static const struct indication npem_indications[] = {
+	{PCI_NPEM_IND_OK,	"enclosure:ok"},
+	{PCI_NPEM_IND_LOCATE,	"enclosure:locate"},
+	{PCI_NPEM_IND_FAIL,	"enclosure:fail"},
+	{PCI_NPEM_IND_REBUILD,	"enclosure:rebuild"},
+	{PCI_NPEM_IND_PFA,	"enclosure:pfa"},
+	{PCI_NPEM_IND_HOTSPARE,	"enclosure:hotspare"},
+	{PCI_NPEM_IND_ICA,	"enclosure:ica"},
+	{PCI_NPEM_IND_IFA,	"enclosure:ifa"},
+	{PCI_NPEM_IND_IDT,	"enclosure:idt"},
+	{PCI_NPEM_IND_DISABLED,	"enclosure:disabled"},
+	{PCI_NPEM_IND_SPEC_0,	"enclosure:specific_0"},
+	{PCI_NPEM_IND_SPEC_1,	"enclosure:specific_1"},
+	{PCI_NPEM_IND_SPEC_2,	"enclosure:specific_2"},
+	{PCI_NPEM_IND_SPEC_3,	"enclosure:specific_3"},
+	{PCI_NPEM_IND_SPEC_4,	"enclosure:specific_4"},
+	{PCI_NPEM_IND_SPEC_5,	"enclosure:specific_5"},
+	{PCI_NPEM_IND_SPEC_6,	"enclosure:specific_6"},
+	{PCI_NPEM_IND_SPEC_7,	"enclosure:specific_7"},
+	{0,			NULL}
+};
+
+#define for_each_indication(ind, inds) \
+	for (ind = inds; ind->bit; ind++)
+
+/*
+ * The driver has internal list of supported indications. Ideally, the driver
+ * should not touch bits that are not defined and for which LED devices are
+ * not exposed but in reality, it needs to turn them off.
+ *
+ * Otherwise, there will be no possibility to turn off indications turned on by
+ * other utilities or turned on by default and it leads to bad user experience.
+ *
+ * Additionally, it excludes NPEM commands like RESET or ENABLE.
+ */
+static u32 reg_to_indications(u32 caps, const struct indication *inds)
+{
+	const struct indication *ind;
+	u32 supported_indications = 0;
+
+	for_each_indication(ind, inds)
+		supported_indications |= ind->bit;
+
+	return caps & supported_indications;
+}
+
+/**
+ * struct npem_led - LED details
+ * @indication: indication details
+ * @npem: npem device
+ * @name: LED name
+ * @led: LED device
+ */
+struct npem_led {
+	const struct indication *indication;
+	struct npem *npem;
+	char name[LED_MAX_NAME_SIZE];
+	struct led_classdev led;
+};
+
+/**
+ * struct npem_ops - backend specific callbacks
+ * @inds: supported indications array, set of indications is backend specific
+ * @get_active_indications: get active indications
+ *	npem: npem device
+ *	inds: response buffer
+ * @set_active_indications: set new indications
+ *	npem: npem device
+ *	inds: bit mask to set
+ */
+struct npem_ops {
+	const struct indication *inds;
+	int (*get_active_indications)(struct npem *npem, u32 *inds);
+	int (*set_active_indications)(struct npem *npem, u32 inds);
+};
+
+/**
+ * struct npem - NPEM device properties
+ * @dev: PCIe device this driver is attached to
+ * @ops: Backend specific callbacks
+ * @lock: serialized accessing npem device from multiple LED devices
+ * @pos: NPEM backed only, NPEM capability offset
+ * @supported_indications: bit mask of supported indications
+ *			   non-indication and reserved bits are cleared
+ * @active_indications: bit mask of active indications
+ *			non-indication and reserved bits are cleared
+ * @active_inds_initialized: if set then active_indications are initialized
+ * @led_cnt: Supported LEDs count
+ * @leds: supported LEDs
+ */
+struct npem {
+	struct pci_dev *dev;
+	const struct npem_ops *ops;
+	struct mutex lock;
+	u16 pos;
+	u32 supported_indications;
+	u32 active_indications;
+
+	/*
+	 * Use lazy loading for active_indications to not play with initcalls.
+	 * It is needed to allow _DSM initialization on DELL platforms, where
+	 * ACPI_IPMI must be loaded first.
+	 */
+	unsigned int active_inds_initialized:1;
+
+	int led_cnt;
+	struct npem_led leds[];
+};
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
+static int npem_get_active_indications(struct npem *npem, u32 *inds)
+{
+	u32 ctrl;
+	int ret;
+
+	lockdep_assert_held(&npem->lock);
+
+	ret = npem_read_reg(npem, PCI_NPEM_CTRL, &ctrl);
+	if (ret)
+		return ret;
+
+	/* If PCI_NPEM_CTRL_ENABLE is not set then no indication should blink */
+	if (!(ctrl & PCI_NPEM_CTRL_ENABLE)) {
+		*inds = 0;
+		return 0;
+	}
+
+	*inds = ctrl & npem->supported_indications;
+
+	return 0;
+}
+
+static int npem_set_active_indications(struct npem *npem, u32 inds)
+{
+	int ctrl, ret, ret_val;
+	u32 cc_status;
+
+	lockdep_assert_held(&npem->lock);
+
+	/* This bit is always required */
+	ctrl = inds | PCI_NPEM_CTRL_ENABLE;
+
+	ret = npem_write_ctrl(npem, ctrl);
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
+	if (ret)
+		return ret;
+	if (ret_val)
+		return ret_val;
+
+	/*
+	 * All writes to control register, including writes that do not change
+	 * the register value, are NPEM commands and should eventually result
+	 * in a command completion indication in the NPEM Status Register.
+	 *
+	 * PCIe Base Specification r6.1 sec 7.9.19.3
+	 *
+	 * Register may not be updated, or other conflicting bits may be
+	 * cleared. Spec is not strict here. Read NPEM Control register after
+	 * write to keep cache in-sync.
+	 */
+	return npem_get_active_indications(npem, &npem->active_indications);
+}
+
+static const struct npem_ops npem_ops = {
+	.inds = npem_indications,
+	.get_active_indications = npem_get_active_indications,
+	.set_active_indications = npem_set_active_indications,
+};
+
+#define DSM_GUID GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,  0x8c, 0xb7, 0x74, 0x7e,\
+			   0xd5, 0x1e, 0x19, 0x4d)
+#define GET_SUPPORTED_STATES_DSM	1
+#define GET_STATE_DSM			2
+#define SET_STATE_DSM			3
+
+static const guid_t dsm_guid = DSM_GUID;
+
+static bool npem_has_dsm(struct pci_dev *pdev)
+{
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return false;
+
+	return acpi_check_dsm(handle, &dsm_guid, 0x1,
+			      BIT(GET_SUPPORTED_STATES_DSM) |
+			      BIT(GET_STATE_DSM) | BIT(SET_STATE_DSM));
+}
+
+static int npem_initialize_active_indications(struct npem *npem)
+{
+	int ret;
+
+	lockdep_assert_held(&npem->lock);
+
+	if (npem->active_inds_initialized)
+		return 0;
+
+	ret = npem->ops->get_active_indications(npem,
+						&npem->active_indications);
+	if (ret)
+		return ret;
+
+	npem->active_inds_initialized = true;
+	return 0;
+}
+
+/*
+ * The status of each indicator is cached on first brightness_ get/set time and
+ * updated at write time.
+ * brightness_get() is only responsible for reflecting the last written/cached
+ * value.
+ */
+static enum led_brightness brightness_get(struct led_classdev *led)
+{
+	struct npem_led *nled = container_of(led, struct npem_led, led);
+	struct npem *npem = nled->npem;
+	int ret, val = LED_OFF;
+
+	ret = mutex_lock_interruptible(&npem->lock);
+	if (ret)
+		return ret;
+
+	ret = npem_initialize_active_indications(npem);
+	if (ret)
+		goto out;
+
+	if (npem->active_indications & nled->indication->bit)
+		val = LED_ON;
+
+out:
+	mutex_unlock(&npem->lock);
+	return val;
+}
+
+static int brightness_set(struct led_classdev *led,
+			  enum led_brightness brightness)
+{
+	struct npem_led *nled = container_of(led, struct npem_led, led);
+	struct npem *npem = nled->npem;
+	u32 indications;
+	int ret;
+
+	ret = mutex_lock_interruptible(&npem->lock);
+	if (ret)
+		return ret;
+
+	ret = npem_initialize_active_indications(npem);
+	if (ret)
+		goto out;
+
+	if (brightness == LED_OFF)
+		indications = npem->active_indications & ~(nled->indication->bit);
+	else
+		indications = npem->active_indications | nled->indication->bit;
+
+	ret = npem->ops->set_active_indications(npem, indications);
+
+out:
+	mutex_unlock(&npem->lock);
+	return ret;
+}
+
+static void npem_free(struct npem *npem)
+{
+	struct npem_led *nled;
+	int cnt;
+
+	if (!npem)
+		return;
+
+	for (cnt = 0; cnt < npem->led_cnt; cnt++) {
+		nled = &npem->leds[cnt];
+
+		if (nled->name[0])
+			led_classdev_unregister(&nled->led);
+	}
+
+	mutex_destroy(&npem->lock);
+	kfree(npem);
+}
+
+static int pci_npem_set_led_classdev(struct npem *npem, struct npem_led *nled)
+{
+	struct led_classdev *led = &nled->led;
+	struct led_init_data init_data = {};
+	char *name = nled->name;
+	int ret;
+
+	init_data.devicename = pci_name(npem->dev);
+	init_data.default_label = nled->indication->name;
+
+	ret = led_compose_name(&npem->dev->dev, &init_data, name);
+	if (ret)
+		return ret;
+
+	led->name = name;
+	led->brightness_set_blocking = brightness_set;
+	led->brightness_get = brightness_get;
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
+static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
+			 int pos, u32 caps)
+{
+	u32 supported = reg_to_indications(caps, ops->inds);
+	int supported_cnt = hweight32(supported);
+	const struct indication *indication;
+	struct npem_led *nled;
+	struct npem *npem;
+	int led_idx = 0;
+	int ret;
+
+	npem = kzalloc(struct_size(npem, leds, supported_cnt), GFP_KERNEL);
+	if (!npem)
+		return -ENOMEM;
+
+	npem->supported_indications = supported;
+	npem->led_cnt = supported_cnt;
+	npem->pos = pos;
+	npem->dev = dev;
+	npem->ops = ops;
+
+	mutex_init(&npem->lock);
+
+	for_each_indication(indication, npem_indications) {
+		if (!(npem->supported_indications & indication->bit))
+			continue;
+
+		nled = &npem->leds[led_idx++];
+		nled->indication = indication;
+		nled->npem = npem;
+
+		ret = pci_npem_set_led_classdev(npem, nled);
+		if (ret) {
+			npem_free(npem);
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
+	npem_free(dev->npem);
+}
+
+void pci_npem_create(struct pci_dev *dev)
+{
+	const struct npem_ops *ops = &npem_ops;
+	int pos = 0, ret;
+	u32 cap;
+
+	if (!npem_has_dsm(dev)) {
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
+		if (pos == 0)
+			return;
+
+		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
+		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
+			return;
+	} else {
+		/*
+		 * OS should use the DSM for LED control if it is available
+		 * PCI Firmware Spec r3.3 sec 4.7.
+		 */
+		return;
+	}
+
+	ret = pci_npem_init(dev, ops, pos, cap);
+	if (ret)
+		pci_err(dev, "Failed to register PCIe Enclosure Management driver, err: %d\n",
+			ret);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..9dea8c7353ab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -333,6 +333,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e696e547565..b8ea6353e27a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2582,6 +2582,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+
+	pci_npem_create(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..1436f9cf1fea 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -33,6 +33,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	if (!dev->dev.kobj.parent)
 		return;
 
+	pci_npem_remove(dev);
+
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb004fd4e889..c327c2dd4527 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -517,6 +517,9 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
+#endif
+#ifdef CONFIG_PCI_NPEM
+	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..c5e1b0573ff8 100644
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
@@ -1121,6 +1122,40 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Native PCIe Enclosure Management */
+#define PCI_NPEM_CAP	0x04 /* NPEM capability register */
+#define	 PCI_NPEM_CAP_CAPABLE		0x00000001 /* NPEM Capable */
+
+#define PCI_NPEM_CTRL	0x08 /* NPEM control register */
+#define	 PCI_NPEM_CTRL_ENABLE		0x00000001 /* NPEM Enable */
+
+/*
+ * Native PCIe Enclosure Management indication bits and Reset command bit
+ * are corresponding for capability and control registers.
+ */
+#define  PCI_NPEM_CMD_RESET		0x00000002 /* NPEM Reset Command */
+#define  PCI_NPEM_IND_OK		0x00000004 /* NPEM indication OK */
+#define  PCI_NPEM_IND_LOCATE		0x00000008 /* NPEM indication Locate */
+#define  PCI_NPEM_IND_FAIL		0x00000010 /* NPEM indication Fail */
+#define  PCI_NPEM_IND_REBUILD		0x00000020 /* NPEM indication Rebuild */
+#define  PCI_NPEM_IND_PFA		0x00000040 /* NPEM indication Predicted Failure Analysis */
+#define  PCI_NPEM_IND_HOTSPARE		0x00000080 /* NPEM indication Hot Spare */
+#define  PCI_NPEM_IND_ICA		0x00000100 /* NPEM indication In Critical Array */
+#define  PCI_NPEM_IND_IFA		0x00000200 /* NPEM indication In Failed Array */
+#define  PCI_NPEM_IND_IDT		0x00000400 /* NPEM indication Invalid Device Type */
+#define  PCI_NPEM_IND_DISABLED		0x00000800 /* NPEM indication Disabled */
+#define  PCI_NPEM_IND_SPEC_0		0x01000000
+#define  PCI_NPEM_IND_SPEC_1		0x02000000
+#define  PCI_NPEM_IND_SPEC_2		0x04000000
+#define  PCI_NPEM_IND_SPEC_3		0x08000000
+#define  PCI_NPEM_IND_SPEC_4		0x10000000
+#define  PCI_NPEM_IND_SPEC_5		0x20000000
+#define  PCI_NPEM_IND_SPEC_6		0x40000000
+#define  PCI_NPEM_IND_SPEC_7		0x80000000
+
+#define PCI_NPEM_STATUS	0x0c /* NPEM status register */
+#define	 PCI_NPEM_STATUS_CC		0x00000001 /* NPEM Command completed */
+
 /* Data Object Exchange */
 #define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
 #define  PCI_DOE_CAP_INT_SUP			0x00000001  /* Interrupt Support */
-- 
2.35.3


