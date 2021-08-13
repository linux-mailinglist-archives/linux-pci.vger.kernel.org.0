Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929793EBDEB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhHMVhd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 17:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhHMVhc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 17:37:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE8C061756
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 14:37:05 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o185so17857690oih.13
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9RQ7Ff2KCDnOxkuL8vHi0PxNzl+gkZfoNBZq37ebqc=;
        b=drshFqvo9zmUe1SlkivIzJIX8Ls98aoUKZ4OloNyUCqFMirMeDYmRXPPBMbpo2wyeH
         H3STxaHCbX8tKI4Wht4r2AgNQjnu4f4R0/1XlwPP69JB60JoMhfbcS59VDdYSwn0e7AU
         0caFNZfT7kyxmukjyrpQzBcQeTDGKDLmrWxPTu8ApNkU5ph0AtApg9lQSqb6CKK/eSBy
         0xz8ihiYEF+nK0MPUgu1emXXQyIa7pBjM1st6ZkXOitC3awqzbmYPrVeoOMiF/Gn2EpC
         wuNXwAWfgbo9CPJEeHjc8nkV5+uh6PC0MBFtWB7QWQeECes5b9Yi0Z+Sb1eALIh9aSW7
         z0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9RQ7Ff2KCDnOxkuL8vHi0PxNzl+gkZfoNBZq37ebqc=;
        b=oQE5X9rMqFADuahphgtL+X5A4J2IhQcL8Wz0fpa/mLH9KXXluwSnmZDMkRCHW3u2aU
         rgt1i0V7rQCp380ZzeIqM7oevh9xobSC7SE1LMPHlW5+k4n9xkGZlglYk1voPNC5mdAm
         etQbR9YanGL3cl+jpAojHosGQ/idRJvQVnibERQMrM7mKwsomcPA4N5Ap0l45+gedge+
         9AqH5MZ/VeUvvf5gP+UQYOf5HQ9nolsftmlaCBG+ATjjOEdX6mBG6cK4rW1iXfrmdpWh
         eMz5ayowZXelOxwX3Sa4S+srwxptnPJbse7wiJCrX2Y4pZm7njOnxSE3vR0nuYt+bi52
         ZYTg==
X-Gm-Message-State: AOAM532mLPMnJShgQT9/Mr4xEykpWXemD6jTTMi/lds3TKn/DAF6LmIz
        qqeRAuP6Zd7oMD6Hib2QTO0=
X-Google-Smtp-Source: ABdhPJysCgLacaN9pZpuOqK9yR6G8kLdgQIDfCMUFU/psK0zq26z07M2ucHTYHFN6XMB8V4RPGWqdA==
X-Received: by 2002:a05:6808:24c:: with SMTP id m12mr3634476oie.43.1628890624974;
        Fri, 13 Aug 2021 14:37:04 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id t9sm552659ott.39.2021.08.13.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 14:37:04 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com, pavel@ucw.cz,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v3] Add support for PCIe SSD status LED management
Date:   Fri, 13 Aug 2021 17:36:53 -0400
Message-Id: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for the PCIe SSD Status LED Management
interface, as described in the "_DSM Additions for PCIe SSD Status LED
Management" ECN to the PCI Firmware Specification revision 3.2.

It will add (led_classdev) LEDs to each PCIe device that has a supported
_DSM interface (one off/on LED per supported state). Both PCIe storage
devices, and the ports to which they are connected, can support this
interface.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
V2:
	* Simplified interface to a single "states" attribute under the LED
	  classdev using only state names
	* Reworked driver to separate _DSM specific code, so support for
	  NPEM (or other methods) could be easily be added
	* Use BIT macro
V3:
	* Changed code to use a single LED per supported state
	* Moved to drivers/pci/pcie
	* Changed Kconfig dependency to LEDS_CLASS instead of NEW_LEDS
	* Added PCI device class check before _DSM presence check
	* Other cleanups that don't affect the function

---
 drivers/pci/pcie/Kconfig    |  11 +
 drivers/pci/pcie/Makefile   |   1 +
 drivers/pci/pcie/ssd-leds.c | 419 ++++++++++++++++++++++++++++++++++++
 3 files changed, 431 insertions(+)
 create mode 100644 drivers/pci/pcie/ssd-leds.c

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 45a2ef702b45..b738d473209f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -142,3 +142,14 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_SSD_LEDS
+	tristate "PCIe SSD status LED support"
+	depends on ACPI && LEDS_CLASS
+	help
+	  Driver for PCIe SSD status LED management as described in a PCI
+	  Firmware Specification, Revision 3.2 ECN.
+
+	  When enabled, LED interfaces will be created for supported drive
+	  states for each PCIe device that has the ACPI _DSM method described
+	  in the referenced specification.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b2980db88cc0..fbcb8c2d1dc1 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_SSD_LEDS)	+= ssd-leds.o
diff --git a/drivers/pci/pcie/ssd-leds.c b/drivers/pci/pcie/ssd-leds.c
new file mode 100644
index 000000000000..cacb77e5da2d
--- /dev/null
+++ b/drivers/pci/pcie/ssd-leds.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Module to provide LED interfaces for PCIe SSD status LED states, as
+ * defined in the "_DSM additions for PCIe SSD Status LED Management" ECN
+ * to the PCI Firmware Specification Revision 3.2, dated 12 February 2020.
+ *
+ * The "_DSM..." spec is functionally similar to Native PCIe Enclosure
+ * Management, but uses a _DSM ACPI method rather than a PCIe extended
+ * capability.
+ *
+ * Copyright (c) 2021 Dell Inc.
+ *
+ * TODO: Add NPEM support
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <uapi/linux/uleds.h>
+
+#define DRIVER_NAME	"pcie-ssd-leds"
+#define DRIVER_VERSION	"v1.0"
+
+struct led_state {
+	char *name;
+	int bit;
+};
+
+static struct led_state led_states[] = {
+	{ .name = "ok",		.bit = 2 },
+	{ .name = "locate",	.bit = 3 },
+	{ .name = "failed",	.bit = 4 },
+	{ .name = "rebuild",	.bit = 5 },
+	{ .name = "pfa",	.bit = 6 },
+	{ .name = "hotspare",	.bit = 7 },
+	{ .name = "ica",	.bit = 8 },
+	{ .name = "ifa",	.bit = 9 },
+	{ .name = "invalid",	.bit = 10 },
+	{ .name = "disabled",	.bit = 11 },
+};
+
+struct drive_status_led_ops {
+	int (*get_supported_states)(struct pci_dev *pdev, u32 *states);
+	int (*get_current_states)(struct pci_dev *pdev, u32 *states);
+	int (*set_current_states)(struct pci_dev *pdev, u32 states);
+};
+
+struct drive_status_state_led {
+	struct led_classdev cdev;
+	struct drive_status_dev *dsdev;
+	int bit;
+};
+
+/*
+ * drive_status_dev->dev could be the drive itself or its PCIe port
+ */
+struct drive_status_dev {
+	struct list_head list;
+	/* PCI device that has the LED controls */
+	struct pci_dev *pdev;
+	/* _DSM (or NPEM) LED ops */
+	struct drive_status_led_ops *ops;
+	/* currently active states */
+	u32 states;
+	int num_leds;
+	struct drive_status_state_led leds[];
+};
+
+struct mutex drive_status_dev_list_lock;
+struct list_head drive_status_dev_list;
+
+/*
+ * _DSM LED control
+ */
+const guid_t pcie_ssd_leds_dsm_guid =
+	GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,
+		  0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d);
+
+#define GET_SUPPORTED_STATES_DSM	0x01
+#define GET_STATE_DSM			0x02
+#define SET_STATE_DSM			0x03
+
+struct ssdleds_dsm_output {
+	u16 status;
+	u8 function_specific_err;
+	u8 vendor_specific_err;
+	u32 state;
+};
+
+static void dsm_status_err_print(struct pci_dev *pdev,
+				 struct ssdleds_dsm_output *output)
+{
+	switch (output->status) {
+	case 0:
+		break;
+	case 1:
+		pci_dbg(pdev, "_DSM not supported\n");
+		break;
+	case 2:
+		pci_dbg(pdev, "_DSM invalid input parameters\n");
+		break;
+	case 3:
+		pci_dbg(pdev, "_DSM communication error\n");
+		break;
+	case 4:
+		pci_dbg(pdev, "_DSM function-specific error 0x%x\n",
+			output->function_specific_err);
+		break;
+	case 5:
+		pci_dbg(pdev, "_DSM vendor-specific error 0x%x\n",
+			output->vendor_specific_err);
+		break;
+	default:
+		pci_dbg(pdev, "_DSM returned unknown status 0x%x\n",
+			output->status);
+	}
+}
+
+static int dsm_set(struct pci_dev *pdev, u32 value)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj, arg3[2];
+	struct ssdleds_dsm_output *dsm_output;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
+	arg3[0].type = ACPI_TYPE_PACKAGE;
+	arg3[0].package.count = 1;
+	arg3[0].package.elements = &arg3[1];
+
+	arg3[1].type = ACPI_TYPE_BUFFER;
+	arg3[1].buffer.length = 4;
+	arg3[1].buffer.pointer = (u8 *)&value;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid,
+				1, SET_STATE_DSM, &arg3[0], ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < 8) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
+
+	if (dsm_output->status != 0) {
+		dsm_status_err_print(pdev, dsm_output);
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int dsm_get(struct pci_dev *pdev, u64 dsm_func, u32 *output)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj;
+	struct ssdleds_dsm_output *dsm_output;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid, 0x1,
+					  dsm_func, NULL, ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < 8) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
+	if (dsm_output->status != 0) {
+		dsm_status_err_print(pdev, dsm_output);
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	*output = dsm_output->state;
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int get_supported_states_dsm(struct pci_dev *pdev, u32 *states)
+{
+	return dsm_get(pdev, GET_SUPPORTED_STATES_DSM, states);
+}
+
+static int get_current_states_dsm(struct pci_dev *pdev, u32 *states)
+{
+	return dsm_get(pdev, GET_STATE_DSM, states);
+}
+
+static int set_current_states_dsm(struct pci_dev *pdev, u32 states)
+{
+	return dsm_set(pdev, states);
+}
+
+static bool pdev_has_dsm(struct pci_dev *pdev)
+{
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return false;
+
+	return acpi_check_dsm(handle, &pcie_ssd_leds_dsm_guid, 0x1,
+			      1 << GET_SUPPORTED_STATES_DSM ||
+			      1 << GET_STATE_DSM ||
+			      1 << SET_STATE_DSM);
+}
+
+struct drive_status_led_ops dsm_drive_status_led_ops = {
+	.get_supported_states = get_supported_states_dsm,
+	.get_current_states = get_current_states_dsm,
+	.set_current_states = set_current_states_dsm,
+};
+
+/*
+ * code not specific to method (_DSM/NPEM)
+ */
+
+static int set_brightness(struct led_classdev *led_cdev,
+				       enum led_brightness brightness)
+{
+	struct drive_status_state_led *led;
+	int err;
+
+	led = container_of(led_cdev, struct drive_status_state_led, cdev);
+
+	if (brightness == LED_OFF)
+		clear_bit(led->bit, (unsigned long *)&(led->dsdev->states));
+	else
+		set_bit(led->bit, (unsigned long *)&(led->dsdev->states));
+	err = led->dsdev->ops->set_current_states(led->dsdev->pdev,
+						  led->dsdev->states);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static enum led_brightness get_brightness(struct led_classdev *led_cdev)
+{
+	struct drive_status_state_led *led;
+
+	led = container_of(led_cdev, struct drive_status_state_led, cdev);
+	return test_bit(led->bit, (unsigned long *)&led->dsdev->states)
+		? LED_ON : LED_OFF;
+}
+
+static struct drive_status_dev *to_drive_status_dev(struct pci_dev *pdev)
+{
+	struct drive_status_dev *dsdev;
+
+	mutex_lock(&drive_status_dev_list_lock);
+	list_for_each_entry(dsdev, &drive_status_dev_list, list)
+		if (pdev == dsdev->pdev) {
+			mutex_unlock(&drive_status_dev_list_lock);
+			return dsdev;
+		}
+	mutex_unlock(&drive_status_dev_list_lock);
+	return NULL;
+}
+
+static void remove_drive_status_dev(struct drive_status_dev *dsdev)
+{
+	if (dsdev) {
+		int i;
+
+		mutex_lock(&drive_status_dev_list_lock);
+		list_del(&dsdev->list);
+		mutex_unlock(&drive_status_dev_list_lock);
+		for (i = 0; i < dsdev->num_leds; i++)
+			led_classdev_unregister(&dsdev->leds[i].cdev);
+		kfree(dsdev);
+	}
+}
+
+static void add_drive_status_dev(struct pci_dev *pdev,
+				 struct drive_status_led_ops *ops)
+{
+	u32 supported;
+	int ret, num_leds, i;
+	struct drive_status_dev *dsdev;
+	char name[LED_MAX_NAME_SIZE];
+	struct drive_status_state_led *led;
+
+	if (to_drive_status_dev(pdev))
+		/*
+		 * leds have already been added for this dev
+		 */
+		return;
+
+	if (ops->get_supported_states(pdev, &supported) < 0)
+		return;
+	num_leds = hweight32(supported);
+	if (num_leds == 0)
+		return;
+
+	dsdev = kzalloc(struct_size(dsdev, leds, num_leds), GFP_KERNEL);
+	if (!dsdev)
+		return;
+
+	dsdev->num_leds = 0;
+	dsdev->pdev = pdev;
+	dsdev->ops = ops;
+	dsdev->states = 0;
+	if (ops->set_current_states(pdev, dsdev->states)) {
+		kfree(dsdev);
+		return;
+	}
+	INIT_LIST_HEAD(&dsdev->list);
+	/*
+	 * add LEDs only for supported states
+	 */
+	for (i = 0; i < ARRAY_SIZE(led_states); i++) {
+		if (!test_bit(led_states[i].bit, (unsigned long *)&supported))
+			continue;
+
+		led = &dsdev->leds[dsdev->num_leds];
+		led->dsdev = dsdev;
+		led->bit = led_states[i].bit;
+
+		snprintf(name, sizeof(name), "%s::%s",
+			 pci_name(pdev), led_states[i].name);
+		led->cdev.name = name;
+		led->cdev.max_brightness = LED_ON;
+		led->cdev.brightness_set_blocking = set_brightness;
+		led->cdev.brightness_get = get_brightness;
+		ret = 0;
+		ret = led_classdev_register(&pdev->dev, &led->cdev);
+		if (ret) {
+			pr_warn("Failed to register LEDs for %s\n", pci_name(pdev));
+			remove_drive_status_dev(dsdev);
+			return;
+		}
+		dsdev->num_leds++;
+	}
+
+	mutex_lock(&drive_status_dev_list_lock);
+	list_add_tail(&dsdev->list, &drive_status_dev_list);
+	mutex_unlock(&drive_status_dev_list_lock);
+}
+
+/*
+ * code specific to PCIe devices
+ */
+static void probe_pdev(struct pci_dev *pdev)
+{
+	/*
+	 * This is only supported on PCIe storage devices and PCIe ports
+	 */
+	if (pdev->class != PCI_CLASS_STORAGE_EXPRESS &&
+	    pdev->class != PCI_CLASS_BRIDGE_PCI)
+		return;
+	if (pdev_has_dsm(pdev))
+		add_drive_status_dev(pdev, &dsm_drive_status_led_ops);
+}
+
+static int ssd_leds_pci_bus_notifier_cb(struct notifier_block *nb,
+					   unsigned long action, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(data);
+
+	if (action == BUS_NOTIFY_ADD_DEVICE)
+		probe_pdev(pdev);
+	else if (action == BUS_NOTIFY_DEL_DEVICE)
+		remove_drive_status_dev(to_drive_status_dev(pdev));
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ssd_leds_pci_bus_nb = {
+	.notifier_call = ssd_leds_pci_bus_notifier_cb,
+	.priority = INT_MIN,
+};
+
+static void initial_scan_for_leds(void)
+{
+	struct pci_dev *pdev = NULL;
+
+	for_each_pci_dev(pdev)
+		probe_pdev(pdev);
+}
+
+static int __init ssd_leds_init(void)
+{
+	mutex_init(&drive_status_dev_list_lock);
+	INIT_LIST_HEAD(&drive_status_dev_list);
+
+	bus_register_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
+	initial_scan_for_leds();
+	return 0;
+}
+
+static void __exit ssd_leds_exit(void)
+{
+	struct drive_status_dev *dsdev, *temp;
+
+	bus_unregister_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
+	list_for_each_entry_safe(dsdev, temp, &drive_status_dev_list, list)
+		remove_drive_status_dev(dsdev);
+}
+
+module_init(ssd_leds_init);
+module_exit(ssd_leds_exit);
+
+MODULE_AUTHOR("Stuart Hayes <stuart.w.hayes@gmail.com>");
+MODULE_DESCRIPTION("Support for PCIe SSD Status LEDs");
+MODULE_LICENSE("GPL");
-- 
2.27.0

