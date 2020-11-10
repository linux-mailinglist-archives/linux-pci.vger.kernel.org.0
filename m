Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6842ADC59
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 17:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJQoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 11:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJQoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 11:44:24 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3B9C0613CF
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2020 08:44:23 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id v143so7517482qkb.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2020 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xf26olugM7i4GwxdO8nDUCglJTZeWhEQOwUVRID66YQ=;
        b=YWD4UYI4e57IzMyimJifOZxcn/u1xrETVn+aHKOJ3QStnZWzrRyklXLGQ4Csg9uz/4
         JNNh3KLfveYOOOUeTiB5sygLaPZyAchRa8v9pu+UG6CfcwmpuMrQXw3PX3IWgsl9jHP8
         1gUzuhFB/zohLrx148RZ78EK8fLlH4IvgfN0ypQ1znV//xUXjGaSeVfC4wqZU2n4bNXU
         cHD81JKDXqY5pwpdpxAcwmNSkymGKxhRu/4pXewKTLQqCqfSH8EN0ZfX245QG9TXt5sn
         yYjVb070kXfBjoZ+9i+BIKzf1ftLw6SFOIBEubP18+XAVINaKHC+zxe8spY0k4mGcBml
         iThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xf26olugM7i4GwxdO8nDUCglJTZeWhEQOwUVRID66YQ=;
        b=V5um/1jXgm/BQl1eTwN5qbZ0kySskI0uKvinoMd+COlDxFxmHpi7fyzk2vxhb28M1J
         nr9+ahvqNRaQggUHiCqWTrkfgdXXBx9xKGNZMgyoqqdKx/HVZexfhgEYEEbwxR5HTduE
         qkgfilP6b1j58kbZAvrvF0VrhoodD+kSbU6joSla2oHoYKKuCpnlawGoDmgmf1n9H9bh
         Q2dkWvqzG7UOV0Rbsfi6DIxYtHZ4/F7JvZZpMRwCSm4Wk8jTAWMaKIfr/BWN3XTrBEM9
         SWdaJGiXiThG4k1fB8bqsz+vL8zCVMHWmcFkRRnLsqgsxsD7E4OrabRROjETjHakqFyM
         BMdA==
X-Gm-Message-State: AOAM532fh95WwsNv7qvR5y5TrQRxr0N4RNejA2qUO6YEUnG1KGxs7q86
        D0LeYgD96i7jQc43rPyF9Do=
X-Google-Smtp-Source: ABdhPJwtofOmA0v2SrxAodePpdE+CUbuNm8awT3pHZRlzjqqF7U4+a833JlK+SzMZPI9GoJut3v0kg==
X-Received: by 2002:a37:2716:: with SMTP id n22mr2132250qkn.500.1605026662643;
        Tue, 10 Nov 2020 08:44:22 -0800 (PST)
Received: from localhost.est.adc.delllabs.net ([143.166.81.254])
        by smtp.googlemail.com with ESMTPSA id p72sm5242572qke.110.2020.11.10.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:44:21 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2] Expose PCIe SSD Status LED Management DSM in sysfs
Date:   Tue, 10 Nov 2020 09:37:35 -0600
Message-Id: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch will expose the PCIe SSD Status LED Management interface in
sysfs for devices that have the relevant _DSM method, per the "_DSM
additions for PCIe SSD Status LED Management" ECN to the PCI Firmware
Specification revision 3.2.

The interface is exposed in two sysfs files, ssdleds_supported_states (RO)
and ssdleds_current_state (RW).

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---

v2: made PCI_SSDLEDS dependent on PCI and ACPI
    remove unused variable
    warn if call to sysfs_create_group fails
    include header file with function prototypes
    change logical OR to bitwise

---
 Documentation/ABI/testing/sysfs-bus-pci |  14 ++
 drivers/pci/Kconfig                     |   7 +
 drivers/pci/Makefile                    |   1 +
 drivers/pci/pci-ssdleds.c               | 194 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |   1 +
 drivers/pci/pci.h                       |  11 ++
 6 files changed, 228 insertions(+)
 create mode 100644 drivers/pci/pci-ssdleds.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 77ad9ec3c801..18ca73b764ac 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -366,3 +366,17 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
 Description:	If ASPM is supported for an endpoint, these files can be
 		used to disable or enable the individual power management
 		states. Write y/1/on to enable, n/0/off to disable.
+
+What:		/sys/bus/pci/devices/.../ssdleds_supported_states
+Date:		October 2020
+Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
+Description:	If the device supports the ACPI _DSM method to control the
+		PCIe SSD LED states, ssdleds_supported_states (read only)
+		will show the LED states that are supported by the _DSM.
+
+What:		/sys/bus/pci/devices/.../ssdleds_current_state
+Date:		October 2020
+Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
+Description:	If the device supports the ACPI _DSM method to control the
+		PCIe SSD LED states, ssdleds_current_state will show or set
+		the current LED states that are active.
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..48049866145f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -182,6 +182,13 @@ config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
 
+config PCI_SSDLEDS
+	def_bool y if (ACPI && PCI)
+	depends on PCI && ACPI
+	help
+	  Enables userspace access to PCIe SSD LED management interface via
+	  sysfs.
+
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
 	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 522d2b974e91..75d3d5a3b1ed 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
 obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
 obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
+obj-$(CONFIG_PCI_SSDLEDS)	+= pci-ssdleds.o
 obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
 obj-$(CONFIG_PCI_SYSCALL)	+= syscall.o
 obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
diff --git a/drivers/pci/pci-ssdleds.c b/drivers/pci/pci-ssdleds.c
new file mode 100644
index 000000000000..d35e4f3caa71
--- /dev/null
+++ b/drivers/pci/pci-ssdleds.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Provide userspace access to PCIe SSD Status LED Management
+ *
+ * The PCIe spec defines an ACPI _DSM method to allow PCIe SSD status LED
+ * management (see "_DSM additions for PCIe SSD Status LED Management" ECN,
+ * February 12, 2020). This code provides a sysfs interface to this _DSM.
+ *
+ * Copyright (C) 2020 Dell Inc.
+ *
+ */
+
+#include <linux/sysfs.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/acpi.h>
+#include "pci.h"
+
+const guid_t pci_ssdleds_dsm_guid =
+	GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,
+		  0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d);
+
+#define SSDLEDS_GET_SUPPORTED_STATES_DSM	0x01
+#define SSDLEDS_GET_STATE_DSM			0x02
+#define SSDLEDS_SET_STATE_DSM			0x03
+
+struct pci_ssdleds_dsm_output {
+	u16 status;
+	u8 function_specific_err;
+	u8 vendor_specific_err;
+	u32 state;
+};
+
+static int ssdleds_dsm_set(struct device *dev, const char *buf, u64 dsm_func)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj, arg3[2];
+	struct pci_ssdleds_dsm_output *dsm_output;
+	u32 val;
+	int err;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
+	err = kstrtou32(buf, 0, &val);
+	if (err || val > U32_MAX)
+		return -EINVAL;
+
+	arg3[0].type = ACPI_TYPE_PACKAGE;
+	arg3[0].package.count = 1;
+	arg3[0].package.elements = &arg3[1];
+
+	arg3[1].type = ACPI_TYPE_BUFFER;
+	arg3[1].buffer.length = 4;
+	arg3[1].buffer.pointer = (u8 *)&val;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pci_ssdleds_dsm_guid, 0x1,
+				      dsm_func, &arg3[0], ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < 8) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	dsm_output = (struct pci_ssdleds_dsm_output *)out_obj->buffer.pointer;
+	/*
+	 * Ignore function specific error bit 1 (some LED state bits weren't
+	 * set), since write was done. User can read current state to see which
+	 * bits were set.
+	 */
+	if (dsm_output->status != 0 &&
+	    !(dsm_output->status == 4 && dsm_output->function_specific_err == 1)) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	ACPI_FREE(out_obj);
+
+	return 0;
+}
+
+static int ssdleds_dsm_get(struct device *dev, char *buf, u64 dsm_func)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj;
+	struct pci_ssdleds_dsm_output *dsm_output;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pci_ssdleds_dsm_guid, 0x1,
+				      dsm_func, NULL, ACPI_TYPE_BUFFER);
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
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	scnprintf(buf, PAGE_SIZE, "%#x\n", dsm_output->state);
+
+	ACPI_FREE(out_obj);
+
+	return strlen(buf) > 0 ? strlen(buf) : -EIO;
+}
+
+static bool device_has_dsm(struct device *dev)
+{
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return false;
+
+	return !!acpi_check_dsm(handle, &pci_ssdleds_dsm_guid, 0x1,
+		       1 << SSDLEDS_GET_SUPPORTED_STATES_DSM |
+		       1 << SSDLEDS_GET_STATE_DSM |
+		       1 << SSDLEDS_SET_STATE_DSM);
+}
+
+static ssize_t ssdleds_current_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+
+	ret = ssdleds_dsm_set(dev, buf, SSDLEDS_SET_STATE_DSM);
+	return (ret < 0) ? ret : count;
+}
+
+static ssize_t ssdleds_current_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return ssdleds_dsm_get(dev, buf, SSDLEDS_GET_STATE_DSM);
+}
+
+static ssize_t ssdleds_supported_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return ssdleds_dsm_get(dev, buf, SSDLEDS_GET_SUPPORTED_STATES_DSM);
+}
+
+static umode_t ssdleds_attr_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	umode_t mode = attr->mode;
+
+	return device_has_dsm(dev) ? mode : 0;
+}
+
+static struct device_attribute ssdleds_attr_current = {
+	.attr = {.name = "ssdleds_current_state", .mode = 0644},
+	.show = ssdleds_current_show,
+	.store = ssdleds_current_store,
+};
+
+static struct device_attribute ssdleds_attr_supported = {
+	.attr = {.name = "ssdleds_supported_states", .mode = 0444},
+	.show = ssdleds_supported_show,
+};
+
+static struct attribute *ssdleds_attributes[] = {
+	&ssdleds_attr_current.attr,
+	&ssdleds_attr_supported.attr,
+	NULL,
+};
+
+static const struct attribute_group ssdleds_attr_group = {
+	.attrs = ssdleds_attributes,
+	.is_visible = ssdleds_attr_visible,
+};
+
+void pci_create_ssdleds_files(struct pci_dev *pdev)
+{
+	if (sysfs_create_group(&pdev->dev.kobj, &ssdleds_attr_group))
+		pci_warn(pdev, "Unable to create ssdleds attributes\n");
+}
+
+void pci_remove_ssdleds_files(struct pci_dev *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &ssdleds_attr_group);
+}
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d15c881e2e7e..820f32956971 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1377,6 +1377,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 		goto err_rom_file;
 
 	pci_create_firmware_label_files(pdev);
+	pci_create_ssdleds_files(pdev);
 
 	return 0;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f86cae9aa1f4..8e6883a1b701 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -30,6 +30,17 @@ static inline void pci_remove_firmware_label_files(struct pci_dev *pdev)
 void pci_create_firmware_label_files(struct pci_dev *pdev);
 void pci_remove_firmware_label_files(struct pci_dev *pdev);
 #endif
+
+#if !defined(CONFIG_PCI_SSDLEDS)
+static inline void pci_create_ssdleds_files(struct pci_dev *pdev)
+{ return; }
+static inline void pci_remove_ssdleds_files(struct pci_dev *pdev)
+{ return; }
+#else
+void pci_create_ssdleds_files(struct pci_dev *pdev);
+void pci_remove_ssdleds_files(struct pci_dev *pdev);
+#endif
+
 void pci_cleanup_rom(struct pci_dev *dev);
 
 enum pci_mmap_api {
-- 
2.18.1

