Return-Path: <linux-pci+bounces-224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B587FBA0D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C97B21653
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801351C3A;
	Tue, 28 Nov 2023 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eAs2Q100"
X-Original-To: linux-pci@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 809721BE;
	Tue, 28 Nov 2023 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=d34IiTMyydsAU1Z9eO
	NPBXN/Ty8c7WVY1SNdn4hy2gk=; b=eAs2Q100ZucG/3Ry9AdXB2oYB+n/dCSEbs
	I4msTs53N7WZ3zOZ7p15ib/nlz+D2CCRL7lWBXkHD1AnJW5xsYWiudys5kZ7N9i+
	duExv9o+XkfZfKH+xvv2JbkEMXSBWMP6OOzV3T+M5AF6WIq4TBVrF1125sj86N1n
	VcfdMdjzE=
Received: from localhost.localdomain.localdomain (unknown [111.205.43.234])
	by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wBnLBsu3GVlp+bDEA--.36749S2;
	Tue, 28 Nov 2023 20:25:18 +0800 (CST)
From: wangdong28 <wangdong202303@163.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	rafael@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lenb@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	wangdong202303@163.com,
	ahuang12@lenovo.com,
	Dong Wang <wangdong28@lenovo.com>
Subject: [PATCH v2] PCI/ACPI: Add extra slot register check for non-ACPI device
Date: Tue, 28 Nov 2023 20:25:16 +0800
Message-Id: <1701174316-14149-1-git-send-email-wangdong202303@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:_____wBnLBsu3GVlp+bDEA--.36749S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFy5KFW5Xr43Zr1DZw1UKFg_yoWxGFWxpF
	4a93Wftr95Gr12g39Fv3yUur1rtrWv93yfGrWxG34DZ3Waga4SqFyvyFyjk3W7Jrs8Wa43
	Za1YvrWkuF48AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8OzxUUUUU=
X-CM-SenderInfo: pzdqwvhrqjjiistqjqqrwthudrp/1tbiXAo2YVXl8GgY6AAAsZ
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Dong Wang <wangdong28@lenovo.com>

When enabling VMD function in UEFI setup, the physical slot of the M.2
NVMe device connected to the VMD device cannot be detected. Here is
the result from lspci ("Physical Slot" field is NOT shown):

 10001:01:00.0 Non-Volatile memory controller: Intel Corporation NVMe
 Datacenter SSD [3DNAND, Beta Rock Controller] (prog-if 02 [NVM Express])
   Subsystem: Intel Corporation NVMe Datacenter SSD [3DNAND] SE M.2 (P4511)

Generally, the physical slot (/sys/bus/pci/slots) will be created via
either ACPI walking path during kernel init or hotplug path:

ACPI walking path:
  pcibios_add_bus
    acpi_pci_add_bus
      acpi_pci_slot_enumerate
        acpi_walk_namespace
          register_slot
            pci_create_slot

hotplug path:
  __pci_hp_initialize
    pci_create_slot

[M.2 NVMe Device]
A. VMD disabled
When VMD is disabled, NVMe will be discovered during bus scanning and
recognized as acpi device. In this case, the physical slot is created
via the ACPI walking path.

B. VMD enabled
vmd_enable_domain() invokes pcibios_add_bus(). This means that it goes
through the ACPI walking path. However, acpi_pci_add_bus() returns
directly becase the statment "!ACPI_HANDLE(bus->bridge)" is true.
See the following code snippet:

  void acpi_pci_add_bus(struct pci_bus *bus)
  {
      ...
      if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
		return;
      ...
  }

Since VMD creates its own root bus and devices of VMD are attached to
the bus, those devices are non-ACPI devices. That's why
"!ACPI_HANDLE(bus->bridge)" returns true.

In addition, M.2 NVMe devices does not have the hotplug capability.
Here is the quote from PCI Express M.2 Specification (Revision 5.0,
Version 1.0):

  CAUTION: M.2 Add-in Cards are not designed or intended to support
  Hot-Swap or Hot-Plug connections. Performing Hot-Swap or Hot-Plug
  may pose danger to the M.2 Add-in Card, to the system Platform,
  and to the person performing this act.

M.2 NVMe devices (non-ACPI devices and no hotplug capability) connected
to the VMD device cannot meet the above-mentioned paths. The corresponding
slot info of the M.2 NVMe controller cannot be created in
/sys/bus/pci/slots.

Fix this issue by checking the available physical slot number in
slot capabilities register. If the physical slot number is available,
create the slot info accordingly. The following lspci output shows the
available slot info with applying this patch:

 10001:01:00.0 Non-Volatile memory controller: Intel Corporation NVMe
 Datacenter SSD [3DNAND, Beta Rock Controller] (prog-if 02 [NVM Express])
   Subsystem: Intel Corporation NVMe Datacenter SSD [3DNAND] SE M.2 (P4511)
   Physical Slot: 16

[U.2 NVMe device]
A. VMD disabled
Same as M.2 NVMe Device case "A".

B. VMD enabled
Same as M.2 NVMe Device case "B".

The hotplug of the U.2 device is optional (See "PCI Express SFF-8639 Module
Specification" for detail). The U.2 NVMe controller with hotplug capability
connected to the VMD device can meet the hotplug path, so the slot info can
be shown correctly via the lspci utility (without this patch):

 10000:82:00.0 Non-Volatile memory controller: Intel Corporation NVMe
 Datacenter SSD [3DNAND, Beta Rock Controller] (prog-if 02 [NVM Express])
   Subsystem: Lenovo Thinksystem U.2 P4610 NVMe SSD
   Physical Slot: 64

For U.2 NVMe controller without hotplug capability, this patch is needed
to fix the missing slot info.

Suggested-and-reviewed-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Dong Wang <wangdong28@lenovo.com>
---
v2:
  * Fix the build error for non-x86 arch

---
 arch/x86/pci/common.c  | 21 +++++++++++++++++++++
 drivers/pci/pci-acpi.c |  9 ++++++++-
 include/linux/pci.h    |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index ddb7986..b657b07 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -731,4 +731,25 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
 
 	return dev;
 }
+
+#define SLOT_NAME_SIZE  5
+
+void pci_check_extra_slot_register(struct pci_bus *bus)
+{
+	struct pci_dev *pdev = bus->self;
+	char slot_name[SLOT_NAME_SIZE];
+	struct pci_slot *pci_slot;
+	u32 slot_cap, slot_nr;
+
+	if (!is_vmd(bus) || !pdev || pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap))
+		return;
+
+	if (!(slot_cap & PCI_EXP_SLTCAP_HPC)) {
+		slot_nr = (slot_cap & PCI_EXP_SLTCAP_PSN) >> 19;
+		snprintf(slot_name, SLOT_NAME_SIZE, "%u", slot_nr);
+		pci_slot = pci_create_slot(bus, 0, slot_name, NULL);
+		if (IS_ERR(pci_slot))
+			pr_err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot));
+	}
+}
 #endif
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0045750..e2f2ba8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -884,6 +884,8 @@ acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
 	return acpi_add_pm_notifier(dev, &pci_dev->dev, pci_acpi_wake_dev);
 }
 
+void __weak pci_check_extra_slot_register(struct pci_bus *bus) { }
+
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
@@ -1202,9 +1204,14 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	union acpi_object *obj;
 	struct pci_host_bridge *bridge;
 
-	if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
+	if (acpi_pci_disabled || !bus->bridge)
 		return;
 
+	if (!ACPI_HANDLE(bus->bridge)) {
+		pci_check_extra_slot_register(bus);
+		return;
+	}
+
 	acpi_pci_slot_enumerate(bus);
 	acpiphp_enumerate_slots(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768..b9bb447 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1394,6 +1394,7 @@ static inline int pci_rebar_bytes_to_size(u64 bytes)
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
 struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
+void pci_check_extra_slot_register(struct pci_bus *bus);
 int pci_status_get_and_clear_errors(struct pci_dev *pdev);
 
 int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
-- 
1.8.3.1


