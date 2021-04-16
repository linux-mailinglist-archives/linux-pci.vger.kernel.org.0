Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB241362883
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhDPTUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 15:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhDPTUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 15:20:45 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435FC061574
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 12:20:19 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id b3so14147668oie.5
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlbO91rwmb9BUR79UPP3pIDiPt8WOBgxLLZHVYBmyiM=;
        b=U/Qh5a0b5VI/8r2jxqpH+fmasiqkwovJnfRIDyMRk88jWcVJuC0zu9dU9MncBTAT9a
         XIYPE3Mg7a9HIKrgIybPwCM71NS4F/QqSf1IMPYt9KOU1MSDn0xndLb1uPD7dCRlxYvA
         k35n7aNCpw5FCNPjFED0y4RH73XQEy8WKFKk4JUa035s9Wm5dGWo+l1CLXPHS/To5DIb
         Cl6HC0sCImcMVSFRQieTPhI5wcxLkwkF+MrEyJhCDySxkDjEET7iUIjZ74Rr+5Bw8ym2
         SJK/eqXD/tkKDwoxrafdYrBc8oaurDTwuj/ad3jiC048t3VwZeoonIfo+llkbU9zHWDS
         E1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlbO91rwmb9BUR79UPP3pIDiPt8WOBgxLLZHVYBmyiM=;
        b=rPOuzVbfR49174AjIyiuUe2iuklyFMVm72jrrdPXXapbxUPgvzjEHL+d/ZcZwNCU0x
         kg5y1Hr9aBMiWoXBpIL0bgyUIKA+RtzldU/Gs6Y7FGpP792drXa+Mo1CWbWuNnYY2/F+
         YbVSxvnjgZ6Rbfn4B5Ky8jPhNMiJDEGsM3SHRcydXWJI3wtxg2A6JPCI1Yj8Tr6ddsmE
         rqcZ0jiQ9/8UPVmQZzxpiN1RrmAEEQrdrdJIahSd6bXqCGfD1DeHZsosDQV9lEGKI6s2
         t8iYMuun+YuUSBqHTWK4hifI9/0uXp2Prb5ZLFR/yrAZE/dn7Adu+2YSYMiaF8qa6jy5
         L4eQ==
X-Gm-Message-State: AOAM532e1X38bBeurpGKYEgDHGA8anA1sVGSatcmM4cSkWxBqtqFDP+a
        o/nozNQGMSkTwR2Oyzf4K54=
X-Google-Smtp-Source: ABdhPJwbAPQpH4JxKe9HBbHpK95DX1BTtWXJ/uAOOuJrppldMQl95hrvQLjX4yqXUbnX9M+eiN164g==
X-Received: by 2002:aca:4487:: with SMTP id r129mr7817454oia.106.1618600818569;
        Fri, 16 Apr 2021 12:20:18 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id q130sm1538601oif.40.2021.04.16.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:20:17 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] Add support for PCIe SSD status LED management
Date:   Fri, 16 Apr 2021 15:20:10 -0400
Message-Id: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for the PCIe SSD Status LED Management
interface, as described in the "_DSM Additions for PCIe SSD Status LED
Management" ECN to the PCI Firmware Specification revision 3.2.

It will add a single (led_classdev) LED for any PCIe device that has the
relevant _DSM. The ten possible status states are exposed using
attributes current_states and supported_states. Reading current_states
(and supported_states) will show the definition and value of each bit:

>cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
ok                              0x0004 [ ]
locate                          0x0008 [*]
fail                            0x0010 [ ]
rebuild                         0x0020 [ ]
pfa                             0x0040 [ ]
hotspare                        0x0080 [ ]
criticalarray                   0x0100 [ ]
failedarray                     0x0200 [ ]
invaliddevice                   0x0400 [ ]
disabled                        0x0800 [ ]
--
supported_states = 0x0008

>cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/current_states
locate                          0x0008 [ ]
--
current_states = 0x0000

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 .../sysfs-class-led-driver-pcie-ssd-leds      |  30 ++
 drivers/pci/Kconfig                           |  12 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/pcie-ssd-leds.c                   | 421 ++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds
 create mode 100644 drivers/pci/pcie-ssd-leds.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds b/Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds
new file mode 100644
index 000000000000..856f5a078568
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds
@@ -0,0 +1,30 @@
+What:		/sys/class/leds/<led>/supported_states
+Date:		April 2021
+Contact:	linux-pci@vger.kernel.org
+Description:
+		This attribute indicates the status states supported by this
+		display.  Reading will show a verbose output with the value on
+		the final line (example below), writing only takes a single
+		numerical value.
+
+		>cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
+		ok                              0x0004 [ ]
+		locate                          0x0008 [*]
+		fail                            0x0010 [ ]
+		rebuild                         0x0020 [ ]
+		pfa                             0x0040 [ ]
+		hotspare                        0x0080 [ ]
+		criticalarray                   0x0100 [ ]
+		failedarray                     0x0200 [ ]
+		invaliddevice                   0x0400 [ ]
+		disabled                        0x0800 [ ]
+		--
+		supported_states = 0x0008
+
+What:		/sys/class/leds/<led>/current_states
+Date:		April 2021
+Contact:	linux-pci@vger.kernel.org
+Description:
+		This attribute indicates the currently active status states on
+		this display.  Reading will show a verbose output with the value
+		the final line, writing only takes a single numerical value.
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..f4acf1ad0fb5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -190,6 +190,18 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCIE_SSD_LEDS
+	tristate "PCIe SSD status LED support"
+	depends on ACPI && NEW_LEDS
+	help
+	  Driver for PCIe SSD status LED management as described in a PCI
+	  Firmware Specification, Revision 3.2 ECN.
+
+	  When enabled, an LED interface will be created for each PCIe device
+	  that has the ACPI method described in the referenced specification,
+	  to allow the device status LEDs for that PCIe device (presumably a
+	  solid state storage device or its slot) to be seen and controlled.
+
 choice
 	prompt "PCI Express hierarchy optimization setting"
 	default PCIE_BUS_DEFAULT
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index d62c4ac4ae1b..ea0a0f351ad2 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
+obj-$(CONFIG_PCIE_SSD_LEDS)	+= pcie-ssd-leds.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/pcie-ssd-leds.c b/drivers/pci/pcie-ssd-leds.c
new file mode 100644
index 000000000000..cd00b7dd1a8e
--- /dev/null
+++ b/drivers/pci/pcie-ssd-leds.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Module to expose interface to control PCIe SSD LEDs as defined in the
+ * "_DSM additions for PCIe SSD Status LED Management" ECN to the PCI
+ * Firmware Specification Revision 3.2, dated 12 February 2020.
+ *
+ *  Copyright (c) 2021 Dell Inc.
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
+	u32 mask;
+};
+
+static struct led_state led_states[] = {
+	{ .name = "ok",			.mask = 1 << 2 },
+	{ .name = "locate",		.mask = 1 << 3 },
+	{ .name = "fail",		.mask = 1 << 4 },
+	{ .name = "rebuild",		.mask = 1 << 5 },
+	{ .name = "pfa",		.mask = 1 << 6 },
+	{ .name = "hotspare",		.mask = 1 << 7 },
+	{ .name = "criticalarray",	.mask = 1 << 8 },
+	{ .name = "failedarray",	.mask = 1 << 9 },
+	{ .name = "invaliddevice",	.mask = 1 << 10 },
+	{ .name = "disabled",		.mask = 1 << 11 },
+};
+
+/*
+ * ssd_status_dev could be the SSD's PCIe dev or its hotplug slot
+ */
+struct ssd_status_dev {
+	struct list_head ssd_list;
+	struct pci_dev *pdev;
+	u32 supported_states;
+	struct led_classdev led_cdev;
+	enum led_brightness brightness;
+};
+
+struct mutex ssd_list_lock;
+struct list_head ssd_list;
+
+const guid_t pcie_ssdleds_dsm_guid =
+	GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,
+		  0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d);
+
+#define GET_SUPPORTED_STATES_DSM	0x01
+#define GET_STATE_DSM			0x02
+#define SET_STATE_DSM			0x03
+
+struct pci_ssdleds_dsm_output {
+	u16 status;
+	u8 function_specific_err;
+	u8 vendor_specific_err;
+	u32 state;
+};
+
+static void dsm_status_err_print(struct device *dev,
+			     struct pci_ssdleds_dsm_output *output)
+{
+	switch (output->status) {
+	case 0:
+		break;
+	case 1:
+		dev_dbg(dev, "_DSM not supported\n");
+		break;
+	case 2:
+		dev_dbg(dev, "_DSM invalid input parameters\n");
+		break;
+	case 3:
+		dev_dbg(dev, "_DSM communication error\n");
+		break;
+	case 4:
+		dev_dbg(dev, "_DSM function-specific error 0x%x\n",
+			output->function_specific_err);
+		break;
+	case 5:
+		dev_dbg(dev, "_DSM vendor-specific error 0x%x\n",
+			output->vendor_specific_err);
+		break;
+	default:
+		dev_dbg(dev, "_DSM returned unknown status 0x%x\n",
+			output->status);
+	}
+}
+
+static int dsm_set(struct device *dev, u32 value)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj, arg3[2];
+	struct pci_ssdleds_dsm_output *dsm_output;
+
+	handle = ACPI_HANDLE(dev);
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
+	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssdleds_dsm_guid,
+				1, SET_STATE_DSM, &arg3[0], ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < 8) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	dsm_output = (struct pci_ssdleds_dsm_output *)out_obj->buffer.pointer;
+
+	if (dsm_output->status != 0) {
+		dsm_status_err_print(dev, dsm_output);
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int dsm_get(struct device *dev, u64 dsm_func, u32 *output)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj;
+	struct pci_ssdleds_dsm_output *dsm_output;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssdleds_dsm_guid, 0x1,
+					  dsm_func, NULL, ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < 8) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	dsm_output = (struct pci_ssdleds_dsm_output *)out_obj->buffer.pointer;
+	if (dsm_output->status != 0) {
+		dsm_status_err_print(dev, dsm_output);
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	*output = dsm_output->state;
+	ACPI_FREE(out_obj);
+	return 0;
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
+	return !!acpi_check_dsm(handle, &pcie_ssdleds_dsm_guid, 0x1,
+		1 << GET_SUPPORTED_STATES_DSM ||
+		1 << GET_STATE_DSM ||
+		1 << SET_STATE_DSM);
+}
+
+static ssize_t current_states_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct device *dsm_dev = led_cdev->dev->parent;
+	struct ssd_status_dev *ssd;
+	u32 val;
+	int err, i, result = 0;
+
+	ssd = container_of(led_cdev, struct ssd_status_dev, led_cdev);
+
+	err = dsm_get(dsm_dev, GET_STATE_DSM, &val);
+	if (err < 0)
+		return err;
+	for (i = 0; i < ARRAY_SIZE(led_states); i++)
+		if (led_states[i].mask & ssd->supported_states)
+			result += sprintf(buf + result, "%-25s\t0x%04X [%c]\n",
+					  led_states[i].name,
+					  led_states[i].mask,
+					  (val & led_states[i].mask)
+					  ? '*' : ' ');
+
+	result += sprintf(buf + result, "--\ncurrent_states = 0x%04X\n", val);
+	return result;
+}
+
+static ssize_t current_states_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct device *dsm_dev = led_cdev->dev->parent;
+	struct ssd_status_dev *ssd;
+	u32 val;
+	int err;
+
+	ssd = container_of(led_cdev, struct ssd_status_dev, led_cdev);
+
+	err = kstrtou32(buf, 10, &val);
+	if (err)
+		return err;
+
+	val &= ssd->supported_states;
+	if (val)
+		ssd->brightness = LED_ON;
+	err = dsm_set(dsm_dev, val);
+	if (err < 0)
+		return err;
+
+	return size;
+}
+
+static ssize_t supported_states_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct ssd_status_dev *ssd;
+	int i, result = 0;
+
+	ssd = container_of(led_cdev, struct ssd_status_dev, led_cdev);
+
+	for (i = 0; i < ARRAY_SIZE(led_states); i++)
+		result += sprintf(buf + result, "%-25s\t0x%04X [%c]\n",
+				  led_states[i].name,
+				  led_states[i].mask,
+				  (ssd->supported_states & led_states[i].mask)
+				  ? '*' : ' ');
+
+	result += sprintf(buf + result, "--\nsupported_states = 0x%04X\n",
+			  ssd->supported_states);
+	return result;
+}
+
+static DEVICE_ATTR_RW(current_states);
+static DEVICE_ATTR_RO(supported_states);
+
+static struct attribute *pcie_ssd_status_attrs[] = {
+	&dev_attr_current_states.attr,
+	&dev_attr_supported_states.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(pcie_ssd_status);
+
+static int ssdleds_set_brightness(struct led_classdev *led_cdev,
+				  enum led_brightness brightness)
+{
+	struct device *dsm_dev = led_cdev->dev->parent;
+	struct ssd_status_dev *ssd;
+	int err;
+
+	ssd = container_of(led_cdev, struct ssd_status_dev, led_cdev);
+	ssd->brightness = brightness;
+
+	if (brightness == LED_OFF) {
+		err = dsm_set(dsm_dev, 0);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static enum led_brightness ssdleds_get_brightness(struct led_classdev *led_cdev)
+{
+	struct ssd_status_dev *ssd;
+
+	ssd = container_of(led_cdev, struct ssd_status_dev, led_cdev);
+	return ssd->brightness;
+}
+
+static void remove_ssd(struct ssd_status_dev *ssd)
+{
+	mutex_lock(&ssd_list_lock);
+	list_del(&ssd->ssd_list);
+	mutex_unlock(&ssd_list_lock);
+	led_classdev_unregister(&ssd->led_cdev);
+	kfree(ssd);
+}
+
+static struct ssd_status_dev *pci_dev_to_ssd_status_dev(struct pci_dev *pdev)
+{
+	struct ssd_status_dev *ssd;
+
+	mutex_lock(&ssd_list_lock);
+	list_for_each_entry(ssd, &ssd_list, ssd_list)
+		if (pdev == ssd->pdev) {
+			mutex_unlock(&ssd_list_lock);
+			return ssd;
+		}
+	mutex_unlock(&ssd_list_lock);
+	return NULL;
+}
+
+static void remove_ssd_for_pdev(struct pci_dev *pdev)
+{
+	struct ssd_status_dev *ssd = pci_dev_to_ssd_status_dev(pdev);
+
+	if (ssd)
+		remove_ssd(ssd);
+}
+
+static void add_ssd(struct pci_dev *pdev)
+{
+	u32 supported_states;
+	int ret;
+	struct ssd_status_dev *ssd;
+	char name[LED_MAX_NAME_SIZE];
+
+	if (dsm_get(&pdev->dev, GET_SUPPORTED_STATES_DSM, &supported_states) < 0)
+		return;
+
+	ssd = kzalloc(sizeof(*ssd), GFP_KERNEL);
+	if (!ssd)
+		return;
+
+	ssd->pdev = pdev;
+	ssd->supported_states = supported_states;
+	ssd->brightness = LED_ON;
+	snprintf(name, sizeof(name), "%s::%s",
+		 dev_name(&pdev->dev), "pcie_ssd_status");
+	ssd->led_cdev.name = name;
+	ssd->led_cdev.max_brightness = LED_ON;
+	ssd->led_cdev.brightness_set_blocking = ssdleds_set_brightness;
+	ssd->led_cdev.brightness_get = ssdleds_get_brightness;
+	ssd->led_cdev.groups = pcie_ssd_status_groups;
+
+	ret = led_classdev_register(&pdev->dev, &ssd->led_cdev);
+	if (ret) {
+		pr_warn("Failed to register LED %s\n", ssd->led_cdev.name);
+		remove_ssd(ssd);
+		return;
+	}
+	mutex_lock(&ssd_list_lock);
+	list_add_tail(&ssd->ssd_list, &ssd_list);
+	mutex_unlock(&ssd_list_lock);
+}
+
+static void probe_pdev(struct pci_dev *pdev)
+{
+	if (pci_dev_to_ssd_status_dev(pdev))
+		/*
+		 * leds have already been added for this pdev
+		 */
+		return;
+
+	if (pdev_has_dsm(pdev))
+		add_ssd(pdev);
+}
+
+static int pciessdleds_pci_bus_notifier_cb(struct notifier_block *nb,
+					   unsigned long action, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(data);
+
+	if (action == BUS_NOTIFY_ADD_DEVICE)
+		probe_pdev(pdev);
+	else if (action == BUS_NOTIFY_REMOVED_DEVICE)
+		remove_ssd_for_pdev(pdev);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pciessdleds_pci_bus_nb = {
+	.notifier_call = pciessdleds_pci_bus_notifier_cb,
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
+static int __init pciessdleds_init(void)
+{
+	mutex_init(&ssd_list_lock);
+	INIT_LIST_HEAD(&ssd_list);
+
+	bus_register_notifier(&pci_bus_type, &pciessdleds_pci_bus_nb);
+	initial_scan_for_leds();
+	return 0;
+}
+
+static void __exit pciessdleds_exit(void)
+{
+	struct ssd_status_dev *ssd, *temp;
+
+	bus_unregister_notifier(&pci_bus_type, &pciessdleds_pci_bus_nb);
+	list_for_each_entry_safe(ssd, temp, &ssd_list, ssd_list)
+		remove_ssd(ssd);
+}
+
+module_init(pciessdleds_init);
+module_exit(pciessdleds_exit);
+
+MODULE_AUTHOR("Stuart Hayes <stuart.w.hayes@gmail.com>");
+MODULE_DESCRIPTION("Support for PCIe SSD Status LED Management _DSM");
+MODULE_LICENSE("GPL");
-- 
2.27.0

