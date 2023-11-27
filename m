Return-Path: <linux-pci+bounces-170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1117F991F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 07:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A16B20AB2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 06:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38A4CA71;
	Mon, 27 Nov 2023 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XDTclzgf"
X-Original-To: linux-pci@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDBA9E4;
	Sun, 26 Nov 2023 22:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=91hTnZrMRhVpClDGZp
	DjSYx6+//mT5XqMbLZ4DnGSYc=; b=XDTclzgfNbWGiOVo7EUXdLwXH1HcbhEDBp
	6yMqi95Q4RxeTr3H2u1zOGFN14P3L4Jmkavo8JLkQFPDfp/WkHHqAFnQQTnhv4fe
	7TrD4vijjwXm/AXDlkmaFIjE/B4ic+MOIXwiC6cNRLXsdOIKyl7Kwcr8O7otPDR1
	dL2m3vuxE=
Received: from localhost.localdomain.localdomain (unknown [111.205.43.234])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wC3V23qMmRl+oBAEA--.26813S2;
	Mon, 27 Nov 2023 14:10:50 +0800 (CST)
From: wangdong28 <wangdong202303@163.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	wangdong202303@163.com,
	ahuang12@lenovo.com,
	Dong Wang <wangdong28@lenovo.com>
Subject: [PATCH] PCI/ACPI: Add extra slot register check for non-ACPI device
Date: Mon, 27 Nov 2023 14:10:47 +0800
Message-Id: <1701065447-13963-1-git-send-email-wangdong202303@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:_____wC3V23qMmRl+oBAEA--.26813S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFy5KFW5Xr43Zr1DZw1UKFg_yoW7Wr4kpF
	4agw4Syr95Gr17K39Iv3yUGr1rt39293y7Wrs7Jr98Za13W3sagFyvyFyUK3W7Jws8Wa47
	ZF4YvFWv9a1kAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziTGQkUUUUU=
X-CM-SenderInfo: pzdqwvhrqjjiistqjqqrwthudrp/xtbBmw41YVetjfi1wQAAs6
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
 drivers/pci/pci-acpi.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0045750..d7b3462 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -884,6 +884,27 @@ acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
 	return acpi_add_pm_notifier(dev, &pci_dev->dev, pci_acpi_wake_dev);
 }
 
+#define SLOT_NAME_SIZE  5
+
+static void pci_check_extra_slot_register(struct pci_bus *bus)
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
+
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
@@ -1202,9 +1223,16 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	union acpi_object *obj;
 	struct pci_host_bridge *bridge;
 
-	if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
+	if (acpi_pci_disabled || !bus->bridge)
 		return;
 
+
+	if (!ACPI_HANDLE(bus->bridge)) {
+		pci_check_extra_slot_register(bus);
+		return;
+	}
+
+
 	acpi_pci_slot_enumerate(bus);
 	acpiphp_enumerate_slots(bus);
 
-- 
1.8.3.1


