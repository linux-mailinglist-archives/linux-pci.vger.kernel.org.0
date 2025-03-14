Return-Path: <linux-pci+bounces-23708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D9A60946
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E713BD301
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355A13D26B;
	Fri, 14 Mar 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRalku2S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE031459F6;
	Fri, 14 Mar 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934810; cv=none; b=dMD9CQUgC4aAGMjUAfQIALpZe4UdcnjuldqYegRuLhka0CFVeCzhT5RrEbZAESWGfozCgzH17p7WYOsfaNkgmZCF9POPYl4+to96NPbtBAFPhF0YhgU9yzpqn+txZSg++1StIrT4QhAQAJX26fd41W3MzZAyU+vznqLvBKafsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934810; c=relaxed/simple;
	bh=PwZy2LvuHa0TDcVFLLz4m68zpq9Ia/g9vaB9uGWAXJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EBrz0LDLhqzB77FqBehP/UKufGFt2q/+Cd9UteCYxtk68//ZihLCMee7hTT2L41bfj0as4jIhS5KzNyeCKqdc8IAnod0ggqkptYU5ND6c/qfD+3g/ie3Wq9lsATpWDwz0Z7J9dX0/2DDlmdrU5GOB9WsVTXafyA+sx0+KoD8Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRalku2S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741934809; x=1773470809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PwZy2LvuHa0TDcVFLLz4m68zpq9Ia/g9vaB9uGWAXJY=;
  b=hRalku2Sd87D6/tOSDbqpzaqOCPx7Zwu8WJ7WEqAivbmNEssOo4PZmHC
   hJfwhpugBkvVt3Deoc9HEVB+XaxrDM3HxbR5Quwl2bh+uaE4TiRMXcAmd
   EPLNTs/W20DhRBd36Kb2xTlf4UxfsSufkW8fgPyn8oqQ5rdwC9VCQ4qpQ
   vI267e+zgi83q9vF2HxL98aTYdNlNotLi8zuRl8XXVFQjYmhIeZyFXGEi
   C9s0ZYE9JqXShnlDuuqEPdFO6LzVog6ljJfNXwMMOd2NWCUui9+fXtq2h
   YaDXHF0kMu2CVWANaukV3kd93cgvgkBQW1dsuh8MonoQWYe4zT0JiEqs3
   w==;
X-CSE-ConnectionGUID: Ef+TmA66T7+E6UlvR47itA==
X-CSE-MsgGUID: L1yjcl+ySYacOKX/4hOwlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54456640"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54456640"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 23:46:47 -0700
X-CSE-ConnectionGUID: JT6lrTunTyWjap8z4B/fPg==
X-CSE-MsgGUID: Xg3Jb6j3SGu6D2UzOoU3Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125371150"
Received: from unknown (HELO BSINU234.iind.intel.com) ([10.66.226.146])
  by fmviesa003.fm.intel.com with ESMTP; 13 Mar 2025 23:46:44 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Date: Fri, 14 Mar 2025 12:16:13 +0200
Message-Id: <20250314101613.3682010-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Support function level reset (flr) on hardware exception to recover
controller. Driver also implements the back-off time of 5 seconds and
the maximum number of retries are limited to 5 before giving up.

The function btintel_acpi_reset_method() is made public and reused to
invoke flr for pcie products.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      |  11 +-
 drivers/bluetooth/btintel.h      |  12 ++
 drivers/bluetooth/btintel_pcie.c | 246 ++++++++++++++++++++++++++++++-
 3 files changed, 260 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ec5e2c7a56ae..aae6a85d9f64 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -30,11 +30,6 @@
 
 #define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
 
-enum {
-	DSM_SET_WDISABLE2_DELAY = 1,
-	DSM_SET_RESET_METHOD = 3,
-};
-
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
 	__le32 boot_addr;
@@ -49,9 +44,10 @@ static struct {
 	u32        fw_build_num;
 } coredump_info;
 
-static const guid_t btintel_guid_dsm =
+const guid_t btintel_guid_dsm =
 	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
 		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
+EXPORT_SYMBOL_GPL(btintel_guid_dsm);
 
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
@@ -2547,7 +2543,7 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	kfree_skb(skb);
 }
 
-static int btintel_acpi_reset_method(struct hci_dev *hdev)
+int btintel_acpi_reset_method(struct hci_dev *hdev)
 {
 	int ret = 0;
 	acpi_status status;
@@ -2586,6 +2582,7 @@ static int btintel_acpi_reset_method(struct hci_dev *hdev)
 	kfree(buffer.pointer);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(btintel_acpi_reset_method);
 
 static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 					 struct intel_version_tlv *ver_tlv)
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 19530ea14905..bc4edfe08216 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -64,6 +64,12 @@ struct intel_tlv {
 
 #define BTINTEL_FWID_MAXLEN 64
 
+enum {
+	DSM_SET_WDISABLE2_DELAY = 1,
+	DSM_SET_RESET_METHOD = 3,
+	DSM_SET_RESET_METHOD_PCIE = 5 /* Used for PCIe products */
+};
+
 struct intel_version_tlv {
 	u32	cnvi_top;
 	u32	cnvr_top;
@@ -255,6 +261,7 @@ int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 void btintel_print_fseq_info(struct hci_dev *hdev);
 int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb);
+int btintel_acpi_reset_method(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -393,4 +400,9 @@ static inline int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	return -EOPNOTSUPP;
 }
+
+static int btintel_acpi_reset_method(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9114be1fc3ce..9346c8d68636 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -13,6 +13,7 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/acpi.h>
 
 #include <linux/unaligned.h>
 
@@ -22,6 +23,8 @@
 #include "btintel.h"
 #include "btintel_pcie.h"
 
+extern const guid_t btintel_guid_dsm;
+
 #define VERSION "0.1"
 
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
@@ -41,6 +44,13 @@ static const struct pci_device_id btintel_pcie_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 
+struct btintel_pcie_dev_restart_data {
+	struct list_head list;
+	u8 restart_count;
+	time64_t last_error;
+	char name[];
+};
+
 /* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI type */
 #define BTINTEL_PCIE_HCI_TYPE_LEN	4
 #define BTINTEL_PCIE_HCI_CMD_PKT	0x00000001
@@ -62,6 +72,9 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
 #define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
 
+#define BTINTEL_PCIE_RESET_OK_TIME_SECS		5
+#define BTINTEL_PCIE_FLR_RESET_MAX_RETRY	5
+
 /* Alive interrupt context */
 enum {
 	BTINTEL_PCIE_ROM,
@@ -99,6 +112,14 @@ struct btintel_pcie_dbgc_ctxt {
 	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
 };
 
+struct btintel_pcie_removal {
+	struct pci_dev *pdev;
+	struct work_struct work;
+};
+
+static LIST_HEAD(btintel_pcie_restart_data_list);
+static DEFINE_SPINLOCK(btintel_pcie_restart_data_lock);
+
 /* This function initializes the memory for DBGC buffers and formats the
  * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
  * size as the payload
@@ -1804,6 +1825,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	u32 type;
 	u32 old_ctxt;
 
+	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
+		return -ENODEV;
+
 	/* Due to the fw limitation, the type header of the packet should be
 	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
 	 * the first byte to get the packet type and redirect the rest of data
@@ -2041,6 +2065,210 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	return err;
 }
 
+static struct btintel_pcie_dev_restart_data *btintel_pcie_get_restart_data(struct pci_dev *pdev,
+									   struct device *dev)
+{
+	struct btintel_pcie_dev_restart_data *tmp, *data = NULL;
+	const char *name = pci_name(pdev);
+	struct hci_dev *hdev = to_hci_dev(dev);
+
+	spin_lock(&btintel_pcie_restart_data_lock);
+	list_for_each_entry(tmp, &btintel_pcie_restart_data_list, list) {
+		if (strcmp(tmp->name, name))
+			continue;
+		data = tmp;
+		break;
+	}
+	spin_unlock(&btintel_pcie_restart_data_lock);
+
+	if (data) {
+		bt_dev_dbg(hdev, "Found restart data for BDF:%s", data->name);
+		return data;
+	}
+
+	/* First time allocate */
+	data = kzalloc(struct_size(data, name, strlen(name) + 1), GFP_ATOMIC);
+	if (!data)
+		return NULL;
+
+	strscpy(data->name, name, strlen(data->name) + 1);
+	spin_lock(&btintel_pcie_restart_data_lock);
+	list_add_tail(&data->list, &btintel_pcie_restart_data_list);
+	spin_unlock(&btintel_pcie_restart_data_lock);
+
+	return data;
+}
+
+static void btintel_pcie_free_restart_list(void)
+{
+	struct btintel_pcie_dev_restart_data *tmp;
+
+	while ((tmp = list_first_entry_or_null(&btintel_pcie_restart_data_list,
+					       typeof(*tmp), list))) {
+		list_del(&tmp->list);
+		kfree(tmp);
+	}
+}
+
+static void btintel_pcie_inc_restart_count(struct pci_dev *pdev, struct device *dev)
+{
+	struct btintel_pcie_dev_restart_data *data;
+	struct hci_dev *hdev = to_hci_dev(dev);
+	time64_t retry_window;
+
+	data = btintel_pcie_get_restart_data(pdev, dev);
+	if (!data)
+		return;
+
+	retry_window = ktime_get_boottime_seconds() - data->last_error;
+	if (data->restart_count == 0) {
+		/* First iteration initialise the time and counter */
+		data->last_error = ktime_get_boottime_seconds();
+		data->restart_count++;
+		bt_dev_dbg(hdev, "First iteration initialise. last_error:%lld seconds restart_count:%d",
+			   data->last_error, data->restart_count);
+	} else if (retry_window < BTINTEL_PCIE_RESET_OK_TIME_SECS &&
+		   data->restart_count <= BTINTEL_PCIE_FLR_RESET_MAX_RETRY) {
+		/* FLR triggered still within the Max retry time so
+		 * increment the counter
+		 */
+		data->restart_count++;
+		bt_dev_err(hdev, "FLR triggered still within the Max retry time so increment the restart_count:%d",
+			   data->restart_count);
+	} else if (retry_window > BTINTEL_PCIE_RESET_OK_TIME_SECS) {
+		/* FLR triggered out of the retry window so reset */
+		bt_dev_err(hdev, "FLR triggered OUT of the retry window so RESET counters last_error:%lld seconds restart_count:%d",
+			   data->last_error, data->restart_count);
+		data->last_error = 0;
+		data->restart_count = 0;
+	}
+}
+
+static void btintel_pcie_removal_work(struct work_struct *wk)
+{
+	struct btintel_pcie_removal *removal =
+		container_of(wk, struct btintel_pcie_removal, work);
+	struct pci_dev *pdev = removal->pdev;
+	struct pci_bus *bus;
+	struct btintel_pcie_data *data;
+
+	data = pci_get_drvdata(pdev);
+
+	pci_lock_rescan_remove();
+
+	bus = pdev->bus;
+	if (!bus)
+		goto out;
+
+	btintel_acpi_reset_method(data->hdev);
+	pci_stop_and_remove_bus_device(pdev);
+	pci_dev_put(pdev);
+
+	if (bus->parent)
+		bus = bus->parent;
+	pci_rescan_bus(bus);
+
+out:
+	pci_unlock_rescan_remove();
+	kfree(removal);
+}
+
+static void btintel_pcie_reset(struct hci_dev *hdev)
+{
+	struct btintel_pcie_removal *removal;
+	struct btintel_pcie_data *data;
+	union acpi_object *obj, argv4;
+	acpi_handle handle;
+	struct pldr_mode {
+		u16	cmd_type;
+		u16	cmd_payload;
+	} __packed mode;
+
+	data = hci_get_drvdata(hdev);
+	if (!btintel_test_flag(hdev, INTEL_FIRMWARE_LOADED)) {
+		bt_dev_dbg(hdev, "Firmware not loaded, so reset not supported");
+		return;
+	}
+
+	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
+	if (!handle) {
+		bt_dev_dbg(hdev, "No support for bluetooth device in ACPI firmware");
+		return;
+	}
+
+	if (!acpi_has_method(handle, "_PRR")) {
+		bt_dev_err(hdev, "No support for _PRR ACPI method");
+		return;
+	}
+
+	if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
+			    BIT(DSM_SET_RESET_METHOD_PCIE))) {
+		bt_dev_err(hdev, "No dsm support to set reset method for _PRR");
+		return;
+	}
+
+	/* set 1 for_PRR Mode */
+	mode.cmd_type = 1;
+	/* 0 – BT Core Reset (Default)
+	 * 1 – Product Reset (PLDR Abort flow)
+	 */
+	mode.cmd_payload = 0;
+
+	argv4.buffer.type = ACPI_TYPE_BUFFER;
+	argv4.buffer.length = sizeof(mode);
+	argv4.buffer.pointer = (void *)&mode;
+
+	obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
+				DSM_SET_RESET_METHOD_PCIE, &argv4);
+	if (!obj) {
+		bt_dev_err(hdev, "Failed to call dsm to set reset method");
+		return;
+	}
+	ACPI_FREE(obj);
+
+	removal = kzalloc(sizeof(*removal), GFP_ATOMIC);
+	if (!removal)
+		return;
+
+	removal->pdev = data->pdev;
+	INIT_WORK(&removal->work, btintel_pcie_removal_work);
+	pci_dev_get(removal->pdev);
+	schedule_work(&removal->work);
+}
+
+static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
+{
+	struct  btintel_pcie_dev_restart_data *data;
+	struct btintel_pcie_data *dev_data = hci_get_drvdata(hdev);
+	struct pci_dev *pdev = dev_data->pdev;
+	time64_t retry_window;
+
+	if (code == 0x13) {
+		bt_dev_err(hdev, "Encountered top exception");
+		return;
+	}
+
+	data = btintel_pcie_get_restart_data(pdev, &hdev->dev);
+	if (!data)
+		return;
+
+	retry_window = ktime_get_boottime_seconds() - data->last_error;
+
+	/* If within 5 seconds max 5 attempts have already been made
+	 * then stop any more retry and indicate to user for cold boot
+	 */
+	if (retry_window < BTINTEL_PCIE_RESET_OK_TIME_SECS &&
+	    data->restart_count >= BTINTEL_PCIE_FLR_RESET_MAX_RETRY) {
+		bt_dev_err(hdev, "Recovery options exhausted, Please cold boot!");
+		bt_dev_err(hdev, "Boot time:%lld seconds first_flr at:%lld seconds restart_count:%d",
+			   ktime_get_boottime_seconds(), data->last_error,
+			   data->restart_count);
+		return;
+	}
+	btintel_pcie_inc_restart_count(pdev, &hdev->dev);
+	btintel_pcie_reset(hdev);
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
@@ -2062,9 +2290,10 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->send = btintel_pcie_send_frame;
 	hdev->setup = btintel_pcie_setup;
 	hdev->shutdown = btintel_shutdown_combined;
-	hdev->hw_error = btintel_hw_error;
+	hdev->hw_error = btintel_pcie_hw_error;
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
+	hdev->reset = btintel_pcie_reset;
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
@@ -2208,7 +2437,20 @@ static struct pci_driver btintel_pcie_driver = {
 	.driver.coredump = btintel_pcie_coredump
 #endif
 };
-module_pci_driver(btintel_pcie_driver);
+
+static int __init btintel_pcie_init(void)
+{
+	return pci_register_driver(&btintel_pcie_driver);
+}
+
+static void __exit btintel_pcie_exit(void)
+{
+	pci_unregister_driver(&btintel_pcie_driver);
+	btintel_pcie_free_restart_list();
+}
+
+module_init(btintel_pcie_init);
+module_exit(btintel_pcie_exit);
 
 MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
 MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver " VERSION);
-- 
2.34.1


