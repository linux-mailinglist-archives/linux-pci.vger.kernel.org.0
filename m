Return-Path: <linux-pci+bounces-35968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106FB53F5A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 01:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BE31C23ACA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 23:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686FB27467E;
	Thu, 11 Sep 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6L38mEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE12E0413
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635019; cv=none; b=PNwVllyOhPmMIEyEWeGn9Btq/h6k27zB/pySlLtlS8O7XXyo7BNJr72lsVFimmquV9g22kwHK4FnuXhG/Rsffl8TsMkAyrdCzCXI+yptMiDpH8SICck6WSs66GCAZHq+Z08HIUvzmeqfVwR7qrHJWAe9nbnFiiZsFjyY/6eJlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635019; c=relaxed/simple;
	bh=L6IZd+nnWQTGmrJRgneyII3EyzgaJOb6YseRNwh6a9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efGvaSAuQAb/kxvnR6oVupKJaymchvKtRtTN/9CqxN0RgwgoyZliFFHTOjzD8fXi5DoH02yVQGkEPpOfahnegHvafiROcgKKaQqHl9d2YAQ/XcyRlo3nGqrznCut3cuXYDDk6c8FROnQvia+zeIcPf9f8hyAHhLCmp4lu366G3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6L38mEX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757635016; x=1789171016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L6IZd+nnWQTGmrJRgneyII3EyzgaJOb6YseRNwh6a9Q=;
  b=n6L38mEXKBYAyvuY7fbMptZShgK8NqTms9ToFr5mDyUv7Y9pXTABiJrV
   BD5QMPZ7iQZOz0ykyi7WKi3IMzIXxz6JZbHOQfzxvHEoUvtbrbuxezPXD
   zJSWZ6DDByCTfvra+uV6u73kheLTFMYBqHHYHbbDf2vNaZISH6ySHAijc
   G8dvH0n8Zyno1oapfx5OOGHLIWTSzvi+eX7nCVFGWdEJTgnDt/ZmD28IH
   JXd0V8MZ3/W0W+hYMuDYBIGJlRX9QG+GxXTYdzKabUh6HqlCWzkoofcWE
   3vRbVJnFaNhgsa98L/h5S+3fcXv7VVe3oGgL3l8Qi5zn5WaNyDuA0kSwX
   g==;
X-CSE-ConnectionGUID: oAfT3MQjQ3yvCg6UcXDw6w==
X-CSE-MsgGUID: FRyiMOguSxKoLS2O0IuyTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70598748"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="70598748"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:56:50 -0700
X-CSE-ConnectionGUID: ugS5C24bQwKKQOIHLjR32w==
X-CSE-MsgGUID: XmkFdbHBSAyzvzE/5Of4DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173393535"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa007.fm.intel.com with ESMTP; 11 Sep 2025 16:56:50 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH resend v6 07/10] PCI/IDE: Add IDE establishment helpers
Date: Thu, 11 Sep 2025 16:56:44 -0700
Message-ID: <20250911235647.3248419-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911235647.3248419-1-dan.j.williams@intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two components to establishing an encrypted link, provisioning
the stream in Partner Port config-space, and programming the keys into
the link layer via IDE_KM (IDE Key Management). This new library,
drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
driver, is saved for later.

With the platform TSM implementations of SEV-TIO and TDX Connect in mind
this library abstracts small differences in those implementations. For
example, TDX Connect handles Root Port register setup while SEV-TIO
expects System Software to update the Root Port registers. This is the
rationale for fine-grained 'setup' + 'enable' verbs.

The other design detail for TSM-coordinated IDE establishment is that
the TSM may manage allocation of Stream IDs, this is why the Stream ID
value is passed in to pci_ide_stream_setup().

The flow is:

pci_ide_stream_alloc():
    Allocate a Selective IDE Stream Register Block in each Partner Port
    (Endpoint + Root Port), and reserve a host bridge / platform stream
    slot. Gather Partner Port specific stream settings like Requester ID.

pci_ide_stream_register():
    Publish the stream in sysfs after allocating a Stream ID. In the TSM
    case the TSM allocates the Stream ID for the Partner Port pair.

pci_ide_stream_setup():
    Program the stream settings to a Partner Port. Caller is responsible
    for optionally calling this for the Root Port as well if the TSM
    implementation requires it.

pci_ide_stream_enable():
    Enable the stream after IDE_KM.

In support of system administrators auditing where platform, Root Port,
and Endpoint IDE stream resources are being spent, the allocated stream
is reflected as a symlink from the host bridge to the endpoint with the
name:

    stream%d.%d.%d

Where the tuple of integers reflects the allocated platform, Root Port,
and Endpoint stream index (Selective IDE Stream Register Block) values.

Thanks to Wu Hao for a draft implementation of this infrastructure.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge |  14 +
 drivers/pci/ide.c                             | 429 ++++++++++++++++++
 include/linux/pci-ide.h                       |  73 +++
 include/linux/pci.h                           |   6 +
 4 files changed, 522 insertions(+)
 create mode 100644 include/linux/pci-ide.h

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 8c3a652799f1..2c66e5bb2bf8 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -17,3 +17,17 @@ Description:
 		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
 		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
 		format.
+
+What:		pciDDDD:BB/streamH.R.E
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a platform has established a secure connection, PCIe
+		IDE, between two Partner Ports, this symlink appears. A stream
+		consumes a Stream ID slot in each of the Host bridge (H), Root
+		Port (R) and Endpoint (E).  The link points to the Endpoint PCI
+		device in the Selective IDE Stream pairing. Specifically, "R"
+		and "E" represent the assigned Selective IDE Stream Register
+		Block in the Root Port and Endpoint, and "H" represents a
+		platform specific pool of stream resources shared by the Root
+		Ports in a host bridge. See /sys/devices/pciDDDD:BB entry for
+		details about the DDDD:BB format.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 05ab8c18b768..608ce79d830f 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -5,8 +5,12 @@
 
 #define dev_fmt(fmt) "PCI/IDE: " fmt
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/pci.h>
+#include <linux/pci-ide.h>
 #include <linux/pci_regs.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "pci.h"
 
@@ -23,6 +27,13 @@ static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
 	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
 }
 
+static int sel_ide_offset(struct pci_dev *pdev,
+			  struct pci_ide_partner *settings)
+{
+	return __sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
+				settings->stream_index, pdev->nr_ide_mem);
+}
+
 void pci_ide_init(struct pci_dev *pdev)
 {
 	u8 nr_link_ide, nr_ide_mem, nr_streams;
@@ -88,5 +99,423 @@ void pci_ide_init(struct pci_dev *pdev)
 
 	pdev->ide_cap = ide_cap;
 	pdev->nr_link_ide = nr_link_ide;
+	pdev->nr_sel_ide = nr_streams;
 	pdev->nr_ide_mem = nr_ide_mem;
 }
+
+struct stream_index {
+	unsigned long *map;
+	u8 max, stream_index;
+};
+
+static void free_stream_index(struct stream_index *stream)
+{
+	clear_bit_unlock(stream->stream_index, stream->map);
+}
+
+DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
+static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
+					       struct stream_index *stream)
+{
+	if (!max)
+		return NULL;
+
+	do {
+		u8 stream_index = find_first_zero_bit(map, max);
+
+		if (stream_index == max)
+			return NULL;
+		if (!test_and_set_bit_lock(stream_index, map)) {
+			*stream = (struct stream_index) {
+				.map = map,
+				.max = max,
+				.stream_index = stream_index,
+			};
+			return stream;
+		}
+		/* collided with another stream acquisition */
+	} while (1);
+}
+
+/**
+ * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
+ * @pdev: IDE capable PCIe Endpoint Physical Function
+ *
+ * Retrieve the Requester ID range of @pdev for programming its Root
+ * Port IDE RID Association registers, and conversely retrieve the
+ * Requester ID of the Root Port for programming @pdev's IDE RID
+ * Association registers.
+ *
+ * Allocate a Selective IDE Stream Register Block instance per port.
+ *
+ * Allocate a platform stream resource from the associated host bridge.
+ * Retrieve stream association parameters for Requester ID range and
+ * address range restrictions for the stream.
+ */
+struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
+{
+	/* EP, RP, + HB Stream allocation */
+	struct stream_index __stream[PCI_IDE_HB + 1];
+	struct pci_host_bridge *hb;
+	struct pci_dev *rp;
+	int num_vf, rid_end;
+
+	if (!pci_is_pcie(pdev))
+		return NULL;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return NULL;
+
+	if (!pdev->ide_cap)
+		return NULL;
+
+	/*
+	 * Catch buggy PCI platform initialization (missing
+	 * pci_ide_init_nr_streams())
+	 */
+	hb = pci_find_host_bridge(pdev->bus);
+	if (WARN_ON_ONCE(!hb->nr_ide_streams))
+		return NULL;
+
+	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
+	if (!ide)
+		return NULL;
+
+	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
+		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
+	if (!hb_stream)
+		return NULL;
+
+	rp = pcie_find_root_port(pdev);
+	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
+		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
+	if (!rp_stream)
+		return NULL;
+
+	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
+		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
+	if (!ep_stream)
+		return NULL;
+
+	/* for SR-IOV case, cover all VFs */
+	num_vf = pci_num_vf(pdev);
+	if (num_vf)
+		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
+				    pci_iov_virtfn_devfn(pdev, num_vf));
+	else
+		rid_end = pci_dev_id(pdev);
+
+	*ide = (struct pci_ide) {
+		.pdev = pdev,
+		.partner = {
+			[PCI_IDE_EP] = {
+				.rid_start = pci_dev_id(rp),
+				.rid_end = pci_dev_id(rp),
+				.stream_index = no_free_ptr(ep_stream)->stream_index,
+			},
+			[PCI_IDE_RP] = {
+				.rid_start = pci_dev_id(pdev),
+				.rid_end = rid_end,
+				.stream_index = no_free_ptr(rp_stream)->stream_index,
+			},
+		},
+		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
+		.stream_id = -1,
+	};
+
+	return_ptr(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
+
+/**
+ * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
+ * @ide: idle IDE settings descriptor
+ *
+ * Free all of the stream index (register block) allocations acquired by
+ * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
+ * be unregistered and not instantiated in any device.
+ */
+void pci_ide_stream_free(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+
+	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
+			 pdev->ide_stream_map);
+	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
+			 rp->ide_stream_map);
+	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
+	kfree(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_free);
+
+/**
+ * pci_ide_stream_release() - unwind and release an @ide context
+ * @ide: partially or fully registered IDE settings descriptor
+ *
+ * In support of automatic cleanup of IDE setup routines perform IDE
+ * teardown in expected reverse order of setup and with respect to which
+ * aspects of IDE setup have successfully completed.
+ *
+ * Be careful that setup order mirrors this shutdown order. Otherwise,
+ * open code releasing the IDE context.
+ */
+void pci_ide_stream_release(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+
+	if (ide->partner[PCI_IDE_RP].enable)
+		pci_ide_stream_disable(rp, ide);
+
+	if (ide->partner[PCI_IDE_EP].enable)
+		pci_ide_stream_disable(pdev, ide);
+
+	if (ide->partner[PCI_IDE_RP].setup)
+		pci_ide_stream_teardown(rp, ide);
+
+	if (ide->partner[PCI_IDE_EP].setup)
+		pci_ide_stream_teardown(pdev, ide);
+
+	if (ide->name)
+		pci_ide_stream_unregister(ide);
+
+	pci_ide_stream_free(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_release);
+
+/**
+ * pci_ide_stream_register() - Prepare to activate an IDE Stream
+ * @ide: IDE settings descriptor
+ *
+ * After a Stream ID has been acquired for @ide, record the presence of
+ * the stream in sysfs. The expectation is that @ide is immutable while
+ * registered.
+ */
+int pci_ide_stream_register(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	u8 ep_stream, rp_stream;
+	int rc;
+
+	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
+		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
+		return -ENXIO;
+	}
+
+	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
+	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
+	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
+						   ide->host_bridge_stream,
+						   rp_stream, ep_stream);
+	if (!name)
+		return -ENOMEM;
+
+	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
+	if (rc)
+		return rc;
+
+	ide->name = no_free_ptr(name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_register);
+
+/**
+ * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
+ * @ide: idle IDE settings descriptor
+ *
+ * In preparation for freeing @ide, remove sysfs enumeration for the
+ * stream.
+ */
+void pci_ide_stream_unregister(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+
+	sysfs_remove_link(&hb->dev.kobj, ide->name);
+	kfree(ide->name);
+	ide->name = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
+
+static int pci_ide_domain(struct pci_dev *pdev)
+{
+	if (pdev->fm_enabled)
+		return pci_domain_nr(pdev->bus);
+	return 0;
+}
+
+struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	if (!pci_is_pcie(pdev)) {
+		pci_warn_once(pdev, "not a PCIe device\n");
+		return NULL;
+	}
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+		if (pdev != ide->pdev) {
+			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
+			return NULL;
+		}
+		return &ide->partner[PCI_IDE_EP];
+	case PCI_EXP_TYPE_ROOT_PORT: {
+		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
+
+		if (pdev != rp) {
+			pci_warn_once(pdev, "setup expected Root Port: %s\n",
+				      pci_name(rp));
+			return NULL;
+		}
+		return &ide->partner[PCI_IDE_RP];
+	}
+	default:
+		pci_warn_once(pdev, "invalid device type\n");
+		return NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(pci_ide_to_settings);
+
+static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
+			    struct pci_ide_partner *settings, int pos,
+			    bool enable)
+{
+	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, settings->default_stream) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+}
+
+/**
+ * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ *
+ * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
+ * settings are written to @pdev's Selective IDE Stream register block,
+ * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
+ * are selected.
+ */
+void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
+
+	/*
+	 * Setup control register early for devices that expect
+	 * stream_id is set during key programming.
+	 */
+	set_ide_sel_ctl(pdev, ide, settings, pos, false);
+	settings->setup = 1;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
+
+/**
+ * pci_ide_stream_teardown() - disable the stream and clear all settings
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ *
+ * For stream destruction, zero all registers that may have been written
+ * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
+ * settings in place while temporarily disabling the stream.
+ */
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
+	settings->setup = 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
+
+/**
+ * pci_ide_stream_enable() - enable a Selective IDE Stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Activate the stream by writing to the Selective IDE Stream Control
+ * Register.
+ *
+ * Return: 0 if the stream successfully entered the "secure" state, and -EINVAL
+ * if @ide is invalid, and -ENXIO if the stream fails to enter the secure state.
+ *
+ * Note that the state may go "insecure" at any point after returning 0, but
+ * those events are equivalent to a "link down" event and handled via
+ * asynchronous error reporting.
+ *
+ * Caller is responsible to clear the enable bit in the -ENXIO case.
+ */
+int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return -EINVAL;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	set_ide_sel_ctl(pdev, ide, settings, pos, true);
+	settings->enable = 1;
+
+	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
+	if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
+	    PCI_IDE_SEL_STS_STATE_SECURE)
+		return -ENXIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
+
+/**
+ * pci_ide_stream_disable() - disable a Selective IDE Stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Clear the Selective IDE Stream Control Register, but leave all other
+ * registers untouched.
+ */
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	settings->enable = 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
new file mode 100644
index 000000000000..5a7ffb1d826f
--- /dev/null
+++ b/include/linux/pci-ide.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
+
+#ifndef __PCI_IDE_H__
+#define __PCI_IDE_H__
+
+enum pci_ide_partner_select {
+	PCI_IDE_EP,
+	PCI_IDE_RP,
+	PCI_IDE_PARTNER_MAX,
+	/*
+	 * In addition to the resources in each partner port the
+	 * platform / host-bridge additionally has a Stream ID pool that
+	 * it shares across root ports. Let pci_ide_stream_alloc() use
+	 * the alloc_stream_index() helper as endpoints and root ports.
+	 */
+	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
+};
+
+/**
+ * struct pci_ide_partner - Per port pair Selective IDE Stream settings
+ * @rid_start: Partner Port Requester ID range start
+ * @rid_start: Partner Port Requester ID range end
+ * @stream_index: Selective IDE Stream Register Block selection
+ * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
+ *		    address and RID association registers
+ * @setup: flag to track whether to run pci_ide_stream_teardown() for this
+ *	   partner slot
+ * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
+ */
+struct pci_ide_partner {
+	u16 rid_start;
+	u16 rid_end;
+	u8 stream_index;
+	unsigned int default_stream:1;
+	unsigned int setup:1;
+	unsigned int enable:1;
+};
+
+/**
+ * struct pci_ide - PCIe Selective IDE Stream descriptor
+ * @pdev: PCIe Endpoint in the pci_ide_partner pair
+ * @partner: per-partner settings
+ * @host_bridge_stream: track platform Stream ID
+ * @stream_id: unique Stream ID (within Partner Port pairing)
+ * @name: name of the established Selective IDE Stream in sysfs
+ *
+ * Negative @stream_id values indicate "uninitialized" on the
+ * expectation that with TSM established IDE the TSM owns the stream_id
+ * allocation.
+ */
+struct pci_ide {
+	struct pci_dev *pdev;
+	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
+	u8 host_bridge_stream;
+	int stream_id;
+	const char *name;
+};
+
+struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
+struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
+void pci_ide_stream_free(struct pci_ide *ide);
+int  pci_ide_stream_register(struct pci_ide *ide);
+void pci_ide_stream_unregister(struct pci_ide *ide);
+void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
+int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_release(struct pci_ide *ide);
+DEFINE_FREE(pci_ide_stream_release, struct pci_ide *, if (_T) pci_ide_stream_release(_T))
+#endif /* __PCI_IDE_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d3880a4f175e..45360ba87538 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -544,6 +544,8 @@ struct pci_dev {
 	u16		ide_cap;	/* Link Integrity & Data Encryption */
 	u8		nr_ide_mem;	/* Address association resources for streams */
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
@@ -613,6 +615,10 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+#ifdef CONFIG_PCI_IDE
+	u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
+#endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.51.0


