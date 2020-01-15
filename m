Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD75213BE1A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgAOLCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 06:02:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbgAOLCV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 06:02:21 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0666611C78B2A629D1AC;
        Wed, 15 Jan 2020 19:02:19 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 19:02:08 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <bp@alien8.de>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <gregkh@linuxfoundation.org>,
        <zhangliguang@linux.alibaba.com>, <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/2] PCI:hip08:Add driver to handle HiSilicon hip08 PCIe controller's errors
Date:   Wed, 15 Jan 2020 11:01:40 +0000
Message-ID: <20200115110141.12300-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20200115110141.12300-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20200115110141.12300-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The hip08 error handle driver logs and reports PCIe controller's
recoverable errors.
Perform root port reset and restore link status for the recovery.

Following are some of the PCIe controller's recoverable errors
1. completion transmission timeout error.
2. CRS retry counter over the threshold error.
3. ECC 2 bit errors
4. AXI bresponse/rresponse errors etc.

RFC: The appropriate location for this driver may be discussed.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/pci/controller/Kconfig                 |   8 +
 drivers/pci/controller/Makefile                |   1 +
 drivers/pci/controller/pcie-hisi-hip08-error.c | 323 +++++++++++++++++++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-hisi-hip08-error.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c77069c..0ee99b8 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -260,6 +260,14 @@ config PCI_HYPERV_INTERFACE
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
 
+config PCIE_HISI_HIP08_ERR_HANDLER
+	depends on ARM64 || COMPILE_TEST
+	depends on (ACPI && PCI_QUIRKS)
+	bool "HiSilicon hip08 Soc PCIe local error handling driver"
+	help
+	  Say Y here if you want PCIe error handling support
+	  for the PCIe local(controller) errors on HiSilicon hip08 SoC
+
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/cadence/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 3d4f597..ac9852f 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
+obj-$(CONFIG_PCIE_HISI_HIP08_ERR_HANDLER) += pcie-hisi-hip08-error.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
 
diff --git a/drivers/pci/controller/pcie-hisi-hip08-error.c b/drivers/pci/controller/pcie-hisi-hip08-error.c
new file mode 100644
index 0000000..6f5d002
--- /dev/null
+++ b/drivers/pci/controller/pcie-hisi-hip08-error.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe driver for handling PCIe local errors occurred on
+ * HiSilicon hip08 PCIe controller.
+ *
+ * Copyright (c) 2018-2019 Hisilicon Limited.
+ */
+
+#include <linux/acpi.h>
+#include <acpi/ghes.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+
+#include "../pci.h"
+
+#define HISI_PCIE_ERR_RECOVER_RING_SIZE           16
+#define	HISI_PCIE_ERR_INFO_SIZE	1024
+
+/* HISI PCIe Local error definitions */
+#define HISI_PCIE_ERR_MISC_REGS	33
+
+#define HISI_PCIE_SUB_MODULE_ID_AP	0
+#define HISI_PCIE_SUB_MODULE_ID_TL	1
+#define HISI_PCIE_SUB_MODULE_ID_MAC	2
+#define HISI_PCIE_SUB_MODULE_ID_DL	3
+#define HISI_PCIE_SUB_MODULE_ID_SDI	4
+
+#define HISI_PCIE_LOCAL_VALID_VERSION		BIT(0)
+#define HISI_PCIE_LOCAL_VALID_SOC_ID		BIT(1)
+#define HISI_PCIE_LOCAL_VALID_SOCKET_ID		BIT(2)
+#define HISI_PCIE_LOCAL_VALID_NIMBUS_ID		BIT(3)
+#define HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID	BIT(4)
+#define HISI_PCIE_LOCAL_VALID_CORE_ID		BIT(5)
+#define HISI_PCIE_LOCAL_VALID_PORT_ID		BIT(6)
+#define HISI_PCIE_LOCAL_VALID_ERR_TYPE		BIT(7)
+#define HISI_PCIE_LOCAL_VALID_ERR_SEVERITY	BIT(8)
+#define HISI_PCIE_LOCAL_VALID_ERR_MISC		9
+
+#define HISI_ERR_SEV_RECOVERABLE	0
+#define HISI_ERR_SEV_FATAL		1
+#define HISI_ERR_SEV_CORRECTED		2
+#define HISI_ERR_SEV_NONE		3
+
+guid_t hip08_pcie_sec_type = GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D, 0xA8, 0x67,
+				       0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);
+
+#define HISI_PCIE_CORE_ID(v)             ((v) >> 3)
+#define HISI_PCIE_PORT_ID(core, v)       ((v >> 1) + (core << 3))
+#define HISI_PCIE_CORE_PORT_ID(v)        ((v % 8) << 1)
+#define HISI_PCIE_ROOT_BUSNR(v)          ((v) ? 0x80 : 0)
+
+struct hisi_pcie_local_err_data {
+	uint64_t   val_bits;
+	uint8_t    version;
+	uint8_t    soc_id;
+	uint8_t    socket_id;
+	uint8_t    nimbus_id;
+	uint8_t    sub_module_id;
+	uint8_t    core_id;
+	uint8_t    port_id;
+	uint8_t    err_severity;
+	uint16_t   err_type;
+	uint8_t    reserv[2];
+	uint32_t   err_misc[HISI_PCIE_ERR_MISC_REGS];
+};
+
+struct pcie_err_info {
+	struct hisi_pcie_local_err_data err_data;
+	struct platform_device *pdev;
+};
+
+static char *pcie_local_sub_module_name(uint8_t id)
+{
+	switch (id) {
+	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
+	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
+	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
+	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
+	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
+	}
+
+	return "unknown";
+}
+
+static char *err_severity(uint8_t err_sev)
+{
+	switch (err_sev) {
+	case HISI_ERR_SEV_RECOVERABLE: return "recoverable";
+	case HISI_ERR_SEV_FATAL: return "fatal";
+	case HISI_ERR_SEV_CORRECTED: return "corrected";
+	case HISI_ERR_SEV_NONE: return "none";
+	}
+
+	return "unknown";
+}
+
+static struct pci_dev *hisi_hip08_pcie_get_rp(u32 chip_id, u32 port_id)
+{
+	u32 devfn = PCI_DEVFN(port_id, 0);
+	u32 busnr = HISI_PCIE_ROOT_BUSNR(chip_id);
+
+	return pci_get_domain_bus_and_slot(0, busnr, devfn);
+}
+
+static int hisi_hip08_pcie_port_acpi_reset(struct platform_device *pdev,
+					u32 chip_id, u32 port_id)
+{
+	struct device *dev = &(pdev->dev);
+	struct acpi_object_list arg_list;
+	union acpi_object arg[3];
+
+	arg[0].type = ACPI_TYPE_INTEGER;
+	arg[0].integer.value = chip_id;
+	arg[1].type = ACPI_TYPE_INTEGER;
+	arg[1].integer.value = HISI_PCIE_CORE_ID(port_id);
+	arg[2].type = ACPI_TYPE_INTEGER;
+	arg[2].integer.value = HISI_PCIE_CORE_PORT_ID(port_id);
+
+	arg_list.count = 3;
+	arg_list.pointer = arg;
+	/* Call the ACPI handle to reset root port  */
+	if (ACPI_HANDLE(dev)) {
+		unsigned long long data = 0;
+		acpi_status s;
+
+		s = acpi_evaluate_integer(ACPI_HANDLE(dev),
+				"RST", &arg_list, &data);
+
+		if (ACPI_FAILURE(s)) {
+			dev_err(dev, "No Reset method\n");
+			return -EIO;
+		}
+
+		if (data) {
+			dev_err(dev, "Failed to Reset\n");
+			return -EIO;
+		}
+
+	} else {
+		dev_err(dev, "No Reset method\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hisi_hip08_pcie_port_reset(struct platform_device *dev,
+				      u32 chip_id, u32 port_id)
+{
+	struct pci_dev *pdev;
+	struct pci_bus *root_bus;
+
+	pdev = hisi_hip08_pcie_get_rp(chip_id, port_id);
+	if (!pdev) {
+		dev_info(&(dev->dev), "Fail to get root port device\n");
+		return -ENODEV;
+	}
+	root_bus = pdev->bus;
+
+	pci_stop_and_remove_bus_device_locked(pdev);
+
+	if (hisi_hip08_pcie_port_acpi_reset(dev, chip_id, port_id))
+		return -EIO;
+	ssleep(1UL);
+
+	/* add root port and downstream devices */
+	pci_lock_rescan_remove();
+	pci_rescan_bus(root_bus);
+	pci_unlock_rescan_remove();
+
+	return 0;
+}
+
+static void pcie_local_error_handle(const struct hisi_pcie_local_err_data *err,
+				    struct platform_device *pdev)
+{
+	char buf[HISI_PCIE_ERR_INFO_SIZE];
+	char *p = buf, *end = buf + sizeof(buf);
+	struct device *dev = &(pdev->dev);
+	uint32_t i;
+	int rc;
+
+	if (err->val_bits == 0) {
+		dev_warn(dev, "%s: no valid error information\n", __func__);
+		return;
+	}
+
+	/* Logging */
+	p += snprintf(p, end - p, "[ Table version=%d ", err->version);
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID)
+		p += snprintf(p, end - p, "SOC ID=%d ", err->soc_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID)
+		p += snprintf(p, end - p, "socket ID=%d ", err->socket_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID)
+		p += snprintf(p, end - p, "nimbus ID=%d ", err->nimbus_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID)
+		p += snprintf(p, end - p, "sub module=%s ",
+			      pcie_local_sub_module_name(err->sub_module_id));
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID)
+		p += snprintf(p, end - p, "core ID=core%d ", err->core_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID)
+		p += snprintf(p, end - p, "port ID=port%d ", err->port_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_SEVERITY)
+		p += snprintf(p, end - p, "error severity=%s ",
+			      err_severity(err->err_severity));
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE)
+		p += snprintf(p, end - p, "error type=0x%x ", err->err_type);
+
+	p += snprintf(p, end - p, "]\n");
+	dev_info(dev, "\nHISI HIP08: PCIe local error\n");
+	dev_info(dev, "%s\n", buf);
+
+	dev_info(dev, "Reg Dump:\n");
+	for (i = 0; i < HISI_PCIE_ERR_MISC_REGS; i++) {
+		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
+			dev_info(dev,
+				 "ERR_MISC_%d=0x%x\n", i, err->err_misc[i]);
+	}
+
+	/* Recovery for the PCIe local errors */
+	if (err->err_severity == HISI_ERR_SEV_RECOVERABLE) {
+		/* try reset PCI port for the error recovery */
+		rc = hisi_hip08_pcie_port_reset(pdev, err->socket_id,
+				HISI_PCIE_PORT_ID(err->core_id, err->port_id));
+		if (rc) {
+			dev_info(dev, "fail to do hip08 pcie port reset\n");
+			return;
+		}
+	}
+}
+
+static DEFINE_KFIFO(pcie_err_recover_ring, struct pcie_err_info,
+		    HISI_PCIE_ERR_RECOVER_RING_SIZE);
+static DEFINE_SPINLOCK(pcie_err_recover_ring_lock);
+
+static void pcie_local_err_recover_work_func(struct work_struct *work)
+{
+	struct pcie_err_info pcie_err_entry;
+
+	while (kfifo_get(&pcie_err_recover_ring, &pcie_err_entry)) {
+		pcie_local_error_handle(&pcie_err_entry.err_data,
+					pcie_err_entry.pdev);
+	}
+}
+
+static DECLARE_WORK(pcie_err_recover_work, pcie_local_err_recover_work_func);
+
+
+static void hip08_pcie_local_error_handle(struct acpi_hest_generic_data *gdata,
+					  int sev, void *data)
+{
+	const struct hisi_pcie_local_err_data *err_data =
+					acpi_hest_get_payload(gdata);
+	struct pcie_err_info err_info;
+	struct platform_device *pdev = data;
+	struct device *dev = &(pdev->dev);
+
+	memcpy(&err_info.err_data, err_data, sizeof(*err_data));
+	err_info.pdev = pdev;
+
+	if (kfifo_in_spinlocked(&pcie_err_recover_ring, &err_info, 1,
+				&pcie_err_recover_ring_lock))
+		schedule_work(&pcie_err_recover_work);
+	else
+		dev_warn(dev, "Buffer overflow when recovering PCIe local error\n");
+}
+
+static int hisi_hip08_pcie_err_handler_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+
+	if (ghes_register_event_handler(hip08_pcie_sec_type,
+					hip08_pcie_local_error_handle,
+					pdev)) {
+		dev_err(&(pdev->dev), "%s : ghes_register_event_handler fail\n",
+			__func__);
+		return ret;
+}
+
+	return 0;
+}
+
+static int hisi_hip08_pcie_err_handler_remove(struct platform_device *pdev)
+{
+	ghes_unregister_event_handler(hip08_pcie_sec_type);
+
+	return 0;
+}
+
+static const struct acpi_device_id hip08_pcie_acpi_match[] = {
+	{ "HISI0361", 0 },
+	{ }
+};
+
+static struct platform_driver hisi_hip08_pcie_err_handler_driver = {
+	.driver = {
+		.name	= "hisi-hip08-pcie-err-handler",
+		.acpi_match_table = hip08_pcie_acpi_match,
+	},
+	.probe		= hisi_hip08_pcie_err_handler_probe,
+	.remove		= hisi_hip08_pcie_err_handler_remove,
+};
+module_platform_driver(hisi_hip08_pcie_err_handler_driver);
+
+MODULE_DESCRIPTION("HiSilicon HIP08 PCIe controller error handling driver");
+MODULE_LICENSE("GPL v2");
+
-- 
1.9.1


