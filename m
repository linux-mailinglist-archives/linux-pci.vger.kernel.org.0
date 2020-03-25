Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2481A192E98
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 17:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYQr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 12:47:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbgCYQr7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 12:47:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5722178DC10962893DDE;
        Thu, 26 Mar 2020 00:43:24 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.86.66) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 00:43:14 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
        <james.morse@arm.com>, <tony.luck@intel.com>,
        <gregkh@linuxfoundation.org>, <zhangliguang@linux.alibaba.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v6 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe controller errors
Date:   Wed, 25 Mar 2020 16:42:23 +0000
Message-ID: <20200325164223.650-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200325164223.650-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20200325164223.650-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.86.66]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The HiSilicon HIP PCIe controller is capable of handling errors
on root port and perform port reset separately at each root port.

This patch add error handling driver for HIP PCIe controller to log
and report recoverable errors. Perform root port reset and restore
link status after the recovery.

Following are some of the PCIe controller's recoverable errors
1. completion transmission timeout error.
2. CRS retry counter over the threshold error.
3. ECC 2 bit errors
4. AXI bresponse/rresponse errors etc.

Also fix the following Smatch warning:
warn: should '((((1))) << (9 + i))' be a 64 bit type?
if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
     ^^^ This should be BIT_ULL() because it goes up to 9 + 32.
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
--
drivers/pci/controller/Kconfig           |   8 +
drivers/pci/controller/Makefile          |   1 +
drivers/pci/controller/pcie-hisi-error.c | 336 +++++++++++++++++++++++++++++++
3 files changed, 345 insertions(+)
create mode 100644 drivers/pci/controller/pcie-hisi-error.c
---
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-hisi-error.c | 357 +++++++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-hisi-error.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 20bf00f587bd..8bc6111480c8 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -268,6 +268,14 @@ config PCI_HYPERV_INTERFACE
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
 
+config PCIE_HISI_ERR
+	depends on ARM64 || COMPILE_TEST
+	depends on ACPI
+	bool "HiSilicon HIP PCIe controller error handling driver"
+	help
+	  Say Y here if you want error handling support
+	  for the PCIe controller's errors on HiSilicon HIP SoCs
+
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/cadence/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 01b2502a5323..94f37b3d9929 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
+obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
 
diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
new file mode 100644
index 000000000000..73304512af92
--- /dev/null
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for handling the PCIe controller errors on
+ * HiSilicon HIP SoCs.
+ *
+ * Copyright (c) 2018-2019 HiSilicon Limited.
+ */
+
+#include <linux/acpi.h>
+#include <acpi/ghes.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+
+#include "../pci.h"
+
+#define HISI_PCIE_ERR_RECOVER_RING_SIZE           16
+#define	HISI_PCIE_ERR_INFO_SIZE	1024
+
+/* HISI PCIe controller error definitions */
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
+static guid_t hisi_pcie_sec_type = GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D,
+			0xA8, 0x67, 0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);
+
+#define HISI_PCIE_CORE_ID(v)             ((v) >> 3)
+#define HISI_PCIE_PORT_ID(core, v)       (((v) >> 1) + ((core) << 3))
+#define HISI_PCIE_CORE_PORT_ID(v)        (((v) % 8) << 1)
+
+struct hisi_pcie_err_data {
+	u64   val_bits;
+	u8    version;
+	u8    soc_id;
+	u8    socket_id;
+	u8    nimbus_id;
+	u8    sub_module_id;
+	u8    core_id;
+	u8    port_id;
+	u8    err_severity;
+	u16   err_type;
+	u8    reserv[2];
+	u32   err_misc[HISI_PCIE_ERR_MISC_REGS];
+};
+
+struct hisi_pcie_err_info {
+	struct hisi_pcie_err_data err_data;
+	struct platform_device *pdev;
+};
+
+struct hisi_pcie_err_private {
+	struct notifier_block nb;
+	struct platform_device *pdev;
+};
+
+static char *hisi_pcie_sub_module_name(u8 id)
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
+static char *hisi_pcie_err_severity(u8 err_sev)
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
+static int hisi_pcie_port_reset(struct platform_device *pdev,
+					u32 chip_id, u32 port_id)
+{
+	struct device *dev = &pdev->dev;
+	acpi_handle handle = ACPI_HANDLE(dev);
+	union acpi_object arg[3];
+	struct acpi_object_list arg_list;
+	acpi_status s;
+	unsigned long long data = 0;
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
+
+	/* Call the ACPI handle to reset root port */
+	s = acpi_evaluate_integer(handle, "RST", &arg_list, &data);
+	if (ACPI_FAILURE(s)) {
+		dev_err(dev, "No RST method\n");
+		return -EIO;
+	}
+
+	if (data) {
+		dev_err(dev, "Failed to Reset\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int hisi_pcie_port_do_recovery(struct platform_device *dev,
+				      u32 chip_id, u32 port_id)
+{
+	acpi_status s;
+	struct device *device = &dev->dev;
+	acpi_handle root_handle = ACPI_HANDLE(device);
+	struct acpi_pci_root *pci_root;
+	struct pci_bus *root_bus;
+	struct pci_dev *pdev;
+	u32 domain, busnr, devfn;
+
+	s = acpi_get_parent(root_handle, &root_handle);
+	if (ACPI_FAILURE(s))
+		return -ENODEV;
+	pci_root = acpi_pci_find_root(root_handle);
+	if (!pci_root)
+		return -ENODEV;
+	root_bus = pci_root->bus;
+	domain = pci_root->segment;
+
+	busnr = root_bus->number;
+	devfn = PCI_DEVFN(port_id, 0);
+	pdev = pci_get_domain_bus_and_slot(domain, busnr, devfn);
+	if (!pdev) {
+		dev_warn(device, "Fail to get root port %04x:%02x:%02x.%d device\n",
+			 domain, busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		return -ENODEV;
+	}
+
+	pci_stop_and_remove_bus_device_locked(pdev);
+	pci_dev_put(pdev);
+
+	if (hisi_pcie_port_reset(dev, chip_id, port_id))
+		return -EIO;
+
+	/*
+	 * The initialization time of subordinate devices after
+	 * hot reset is no more than 1s, which is required by
+	 * the PCI spec v5.0 sec 6.6.1. The time will shorten
+	 * if Readiness Notifications mechanisms are used. But
+	 * wait 1s here to adapt any conditions.
+	 */
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
+static void hisi_pcie_handle_one_error(const struct hisi_pcie_err_data *err,
+				    struct platform_device *pdev)
+{
+	char buf[HISI_PCIE_ERR_INFO_SIZE];
+	char *p = buf, *end = buf + sizeof(buf);
+	struct device *dev = &pdev->dev;
+	u32 i;
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
+			      hisi_pcie_sub_module_name(err->sub_module_id));
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID)
+		p += snprintf(p, end - p, "core ID=core%d ", err->core_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID)
+		p += snprintf(p, end - p, "port ID=port%d ", err->port_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_SEVERITY)
+		p += snprintf(p, end - p, "error severity=%s ",
+			      hisi_pcie_err_severity(err->err_severity));
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE)
+		p += snprintf(p, end - p, "error type=0x%x ", err->err_type);
+
+	p += snprintf(p, end - p, "]\n");
+	dev_info(dev, "\nHISI : HIP : PCIe controller error\n");
+	dev_info(dev, "%s\n", buf);
+
+	dev_info(dev, "Reg Dump:\n");
+	for (i = 0; i < HISI_PCIE_ERR_MISC_REGS; i++) {
+		if (err->val_bits & BIT_ULL(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
+			dev_info(dev,
+				 "ERR_MISC_%d=0x%x\n", i, err->err_misc[i]);
+	}
+
+	/* Recovery for the PCIe controller errors */
+	if (err->err_severity == HISI_ERR_SEV_RECOVERABLE) {
+		/* try reset PCI port for the error recovery */
+		rc = hisi_pcie_port_do_recovery(pdev, err->socket_id,
+				HISI_PCIE_PORT_ID(err->core_id, err->port_id));
+		if (rc) {
+			dev_warn(dev, "fail to do hisi pcie port reset\n");
+			return;
+		}
+	}
+}
+
+static DEFINE_KFIFO(hisi_pcie_err_recover_ring, struct hisi_pcie_err_info,
+		    HISI_PCIE_ERR_RECOVER_RING_SIZE);
+static DEFINE_SPINLOCK(hisi_pcie_err_recover_ring_lock);
+
+static void hisi_pcie_err_recover_work_func(struct work_struct *work)
+{
+	struct hisi_pcie_err_info pcie_err_entry;
+
+	while (kfifo_get(&hisi_pcie_err_recover_ring, &pcie_err_entry)) {
+		hisi_pcie_handle_one_error(&pcie_err_entry.err_data,
+					pcie_err_entry.pdev);
+	}
+}
+
+static DECLARE_WORK(hisi_pcie_err_recover_work,
+		    hisi_pcie_err_recover_work_func);
+
+
+static int hisi_pcie_error_notify(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	struct acpi_hest_generic_data *gdata = data;
+	const struct hisi_pcie_err_data *err_data =
+				acpi_hest_get_payload(gdata);
+	struct hisi_pcie_err_info err_info;
+	struct hisi_pcie_err_private *priv =
+			container_of(nb, struct hisi_pcie_err_private, nb);
+	struct platform_device *pdev = priv->pdev;
+	struct device *dev = &pdev->dev;
+	u8 socket;
+
+	if (device_property_read_u8(dev, "socket", &socket))
+		return NOTIFY_DONE;
+
+	if (!guid_equal((guid_t *)gdata->section_type, &hisi_pcie_sec_type) ||
+	    err_data->socket_id != socket)
+		return NOTIFY_DONE;
+
+	memcpy(&err_info.err_data, err_data, sizeof(*err_data));
+	err_info.pdev = pdev;
+
+	if (kfifo_in_spinlocked(&hisi_pcie_err_recover_ring, &err_info, 1,
+				&hisi_pcie_err_recover_ring_lock))
+		schedule_work(&hisi_pcie_err_recover_work);
+	else
+		dev_warn(dev, "queue full when recovering PCIe controller error\n");
+
+	return NOTIFY_STOP;
+}
+
+static int hisi_pcie_err_handler_probe(struct platform_device *pdev)
+{
+	struct hisi_pcie_err_private *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->nb.notifier_call = hisi_pcie_error_notify;
+	priv->pdev = pdev;
+	ret = ghes_register_event_notifier(&priv->nb);
+	if (ret) {
+		dev_err(&pdev->dev, "%s : ghes_register_event_notifier fail\n",
+			__func__);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int hisi_pcie_err_handler_remove(struct platform_device *pdev)
+{
+	struct hisi_pcie_err_private *priv = platform_get_drvdata(pdev);
+
+	if (priv)
+		ghes_unregister_event_notifier(&priv->nb);
+
+	kfree(priv);
+
+	return 0;
+}
+
+static const struct acpi_device_id hisi_pcie_acpi_match[] = {
+	{ "HISI0361", 0 },
+	{ }
+};
+
+static struct platform_driver hisi_pcie_err_handler_driver = {
+	.driver = {
+		.name	= "hisi-pcie-err-handler",
+		.acpi_match_table = hisi_pcie_acpi_match,
+	},
+	.probe		= hisi_pcie_err_handler_probe,
+	.remove		= hisi_pcie_err_handler_remove,
+};
+module_platform_driver(hisi_pcie_err_handler_driver);
+
+MODULE_DESCRIPTION("HiSilicon HIP PCIe controller error handling driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


