Return-Path: <linux-pci+bounces-17808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0B9E607C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FCA28430E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3881CCEEC;
	Thu,  5 Dec 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9X6R9qI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F91C878E
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437446; cv=none; b=OVCsbc9sqDu90UzTzxW3iVmmdSAhqyCUYNdDANaGaYxIhtmFWRrkp4EWyCTY0qXQqYZjaRkMi3dFsbKBMFlt5c1DX/N+Myg5YSQwD09Et9YnaTpdrFY7uBNNEBtEYlmd8b1VdDAUFV+H0YSHKoUmXncXE7znb+WA4z3WOu94Pv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437446; c=relaxed/simple;
	bh=Ctr3y6WelSUKaqCbghukVrA6vcI0M1eDXAmBvq79rXI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krNOMNdBjpfBwc6BpG2slIyuMv/PuARq8f/ubaaqERg/9oaVP7x+qEVe00WBYRrqJSFM6UkilA5KSwybQzAZ6+U2j3ZOdM0/j8LKyhZzk3Ib53Br0y5Kzwz0VVMlRJ+nEGZDgIJreJyH2QuqUkCFtw47DEsDBIwvr4QIE1O4nfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9X6R9qI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437444; x=1764973444;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ctr3y6WelSUKaqCbghukVrA6vcI0M1eDXAmBvq79rXI=;
  b=a9X6R9qI45yjtfd+RmKWWwnHVBle66FkpEkcNUGhXAWIJ5jbjBh4g1Si
   9jPBEcQwrIaz9AGOXbjAmtnthSp5iT20cFu9imUyb3e+gT6l7kGugPm7j
   MFgBwxjPTPWfrm6i0RDWwsvKp2h7FmTF1v8K/722uaUO2VMDH3eMH7qfx
   EZ7Hauet9lg93WTYuvfSZj/CoAep01X0CwRZpADl8pcskl/HBdvFAz5We
   jZUg/hZ0jOI5+DzkHU8OrlNOErKWtAAbQtCem960luEnRDtvHsUBQnJG7
   atKMdGpUATLlxC1Km1n5mAOLxFVnAUVl01moRxvoRobFFm1XzLqvmqYJ9
   w==;
X-CSE-ConnectionGUID: b7QmWeFASMiiohi+y/dAtg==
X-CSE-MsgGUID: 1OKt9urlRKOrWrTJqfcSZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33910458"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33910458"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:04 -0800
X-CSE-ConnectionGUID: Z3GBsMxVSlWKu9pCivJc0A==
X-CSE-MsgGUID: fB3wgmR7RquEJzGiDHVTDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99050170"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:03 -0800
Subject: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:24:02 -0800
Message-ID: <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

There are two components to establishing an encrypted link, provisioning
the stream in config-space, and programming the keys into the link layer
via the IDE_KM (key management) protocol. These helpers enable the
former, and are in support of TSM coordinated IDE_KM. When / if native
IDE establishment arrives it will share this same config-space
provisioning flow, but for now IDE_KM, in any form, is saved for a
follow-on change.

With the TSM implementations of SEV-TIO and TDX Connect in mind this
abstracts small differences in those implementations. For example, TDX
Connect handles Root Port registers updates while SEV-TIO expects System
Software to update the Root Port registers. This is the rationale for
the PCI_IDE_SETUP_ROOT_PORT flag.

The other design detail for TSM-coordinated IDE establishment is that
the TSM manages allocation of stream-ids, this is why the stream_id is
passed in to pci_ide_stream_setup().

The flow is:

pci_ide_stream_probe()
  Gather stream settings (devid and address filters)
pci_ide_stream_setup()
  Program the stream settings into the endpoint, and optionally Root Port)
pci_ide_enable_stream()
  Run the stream after IDE_KM

In support of system administrators auditing where platform IDE stream
resources are being spent, the allocated stream is reflected as a
symlink from the host-bridge to the endpoint.

Thanks to Wu Hao for a draft implementation of this infrastructure.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
 drivers/pci/ide.c                                  |  192 ++++++++++++++++++++
 drivers/pci/pci.h                                  |    4 
 drivers/pci/probe.c                                |    1 
 include/linux/pci-ide.h                            |   33 +++
 include/linux/pci.h                                |    4 
 6 files changed, 262 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 create mode 100644 include/linux/pci-ide.h

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
new file mode 100644
index 000000000000..15dafb46b176
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -0,0 +1,28 @@
+What:		/sys/devices/pciDDDDD:BB
+		/sys/devices/.../pciDDDDD:BB
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		A PCI host bridge device parents a PCI bus device topology. PCI
+		controllers may also parent host bridges. The DDDDD:BB format
+		convey the PCI domain number and the bus number for root ports
+		of the host bridge.
+
+What:		pciDDDDD:BB/firmware_node
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) Symlink to the platform firmware device object "companion"
+		of the host bridge. For example, an ACPI device with an _HID of
+		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00).
+
+What:		pciDDDDD:BB/streamN:DDDDD:BB:DD:F
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host-bridge has established a secure connection,
+		typically PCIe IDE, between a host-bridge an endpoint, this
+		symlink appears. The primary function is to account how many
+		streams can be returned to the available secure streams pool by
+		invoking the tsm/disconnect flow. The link points to the
+		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index a0c09d9e0b75..c37f35f0d2c0 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -5,6 +5,9 @@
 
 #define dev_fmt(fmt) "PCI/IDE: " fmt
 #include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/pci-ide.h>
+#include <linux/bitfield.h>
 #include "pci.h"
 
 static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
@@ -71,3 +74,192 @@ void pci_ide_init(struct pci_dev *pdev)
 	pdev->sel_ide_cap = sel_ide_cap;
 	pdev->nr_ide_mem = nr_ide_mem;
 }
+
+void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
+{
+	hb->ide_stream_res =
+		DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");
+}
+
+/*
+ * Retrieve stream association parameters for devid (RID) and resources
+ * (device address ranges)
+ */
+void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	int num_vf = pci_num_vf(pdev);
+
+	*ide = (struct pci_ide) { .stream_id = -1 };
+
+	if (pdev->fm_enabled)
+		ide->domain = pci_domain_nr(pdev->bus);
+	ide->devid_start = pci_dev_id(pdev);
+
+	/* for SR-IOV case, cover all VFs */
+	if (num_vf)
+		ide->devid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
+					   pci_iov_virtfn_devfn(pdev, num_vf));
+	else
+		ide->devid_end = ide->devid_start;
+
+	/* TODO: address association probing... */
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_probe);
+
+static void __pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	int pos;
+
+	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
+			     pdev->nr_ide_mem);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	for (int i = ide->nr_mem - 1; i >= 0; i--) {
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
+	}
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
+}
+
+static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	int pos;
+	u32 val;
+
+	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
+			     pdev->nr_ide_mem);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
+
+	for (int i = 0; i < ide->nr_mem; i++) {
+		val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
+		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
+				 lower_32_bits(ide->mem[i].start) >>
+					 PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
+		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
+				 lower_32_bits(ide->mem[i].end) >>
+					 PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
+
+		val = upper_32_bits(ide->mem[i].end);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
+
+		val = upper_32_bits(ide->mem[i].start);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
+	}
+}
+
+/*
+ * Establish IDE stream parameters in @pdev and, optionally, its root port
+ */
+int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
+			 enum pci_ide_flags flags)
+{
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	int mem = 0, rc;
+
+	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
+		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
+		return -ENXIO;
+	}
+
+	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
+		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
+			ide->stream_id);
+		return -EBUSY;
+	}
+
+	ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
+			      dev_name(&pdev->dev));
+	if (!ide->name) {
+		rc = -ENOMEM;
+		goto err_name;
+	}
+
+	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
+	if (rc)
+		goto err_link;
+
+	for (mem = 0; mem < ide->nr_mem; mem++)
+		if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
+				      range_len(&ide->mem[mem]), ide->name,
+				      0)) {
+			pci_err(pdev,
+				"Setup fail: stream%d: address association conflict [%#llx-%#llx]\n",
+				ide->stream_id, ide->mem[mem].start,
+				ide->mem[mem].end);
+
+			rc = -EBUSY;
+			goto err;
+		}
+
+	__pci_ide_stream_setup(pdev, ide);
+	if (flags & PCI_IDE_SETUP_ROOT_PORT)
+		__pci_ide_stream_setup(rp, ide);
+
+	return 0;
+err:
+	for (; mem >= 0; mem--)
+		__release_region(&hb->ide_stream_res, ide->mem[mem].start,
+				 range_len(&ide->mem[mem]));
+	sysfs_remove_link(&hb->dev.kobj, ide->name);
+err_link:
+	kfree(ide->name);
+err_name:
+	clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
+
+void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	int pos;
+	u32 val;
+
+	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
+			     pdev->nr_ide_mem);
+
+	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
+	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+}
+EXPORT_SYMBOL_GPL(pci_ide_enable_stream);
+
+void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	int pos;
+
+	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
+			     pdev->nr_ide_mem);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+}
+EXPORT_SYMBOL_GPL(pci_ide_disable_stream);
+
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
+			     enum pci_ide_flags flags)
+{
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+
+	__pci_ide_stream_teardown(pdev, ide);
+	if (flags & PCI_IDE_SETUP_ROOT_PORT)
+		__pci_ide_stream_teardown(rp, ide);
+
+	for (int i = ide->nr_mem - 1; i >= 0; i--)
+		__release_region(&hb->ide_stream_res, ide->mem[i].start,
+				 range_len(&ide->mem[i]));
+	sysfs_remove_link(&hb->dev.kobj, ide->name);
+	kfree(ide->name);
+	clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6565eb72ded2..b267fabfd542 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -465,8 +465,12 @@ static inline void pci_npem_remove(struct pci_dev *dev) { }
 
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
+void pci_init_host_bridge_ide(struct pci_host_bridge *bridge);
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
+static inline void pci_init_host_bridge_ide(struct pci_host_bridge *bridge)
+{
+}
 #endif
 
 #ifdef CONFIG_PCI_TSM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6c1fe6354d26..667faa18ced2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -608,6 +608,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
+	pci_init_host_bridge_ide(bridge);
 
 	device_initialize(&bridge->dev);
 }
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
new file mode 100644
index 000000000000..24e08a413645
--- /dev/null
+++ b/include/linux/pci-ide.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
+
+#ifndef __PCI_IDE_H__
+#define __PCI_IDE_H__
+
+#include <linux/range.h>
+
+struct pci_ide {
+	int domain;
+	u16 devid_start;
+	u16 devid_end;
+	int stream_id;
+	const char *name;
+	int nr_mem;
+	struct range mem[16];
+};
+
+void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide);
+
+enum pci_ide_flags {
+	PCI_IDE_SETUP_ROOT_PORT = BIT(0),
+};
+
+int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
+			 enum pci_ide_flags flags);
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
+			     enum pci_ide_flags flags);
+void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide);
+#endif /* __PCI_IDE_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 10d035395a43..5d9fc498bc70 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -601,6 +601,10 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+#ifdef CONFIG_PCI_IDE			/* track IDE stream id allocation */
+	DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
+	struct resource ide_stream_res; /* track ide stream address association */
+#endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);


