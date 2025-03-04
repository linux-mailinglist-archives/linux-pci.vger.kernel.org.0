Return-Path: <linux-pci+bounces-22818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B7CA4D4B4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AAED188069D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713391F5608;
	Tue,  4 Mar 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="larLKxNc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC011FC108
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072504; cv=none; b=TGrJwAPqmeyRKcS9nahUxRE+c3FZY0aCsYeE6zwkm5I40VidNrXrmqlBXFT2tezTI3/EOoW2SEH9q4PatCXlhkM5R0V9e71Ha91pUOyKBA2dqx2gJiqokZUMyBawABtvxapnI8m0YBzlyhDjmwdR4pbkBHH8EIVnLUMYqc34tmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072504; c=relaxed/simple;
	bh=wfo5YtxAOoefKL0h0XL0lXmyyRPplks6LoiTo9wyUU4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTG5GzTZ6VZOURFn7OAA8KzBPUUbXbuuJD+MMAuXiwxIqhunyioG0e6qUVMn6TZUvQy2ItobwtH2+GN5p8ej3ZRtUm1+sp7ZwMWXHdXIwwsYzVa9Ofr3vezqTr4vnNotk8bnTlhvjj/Nh1wBjLE+hHWz5rj2EjZ8hb/VSWEfD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=larLKxNc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072502; x=1772608502;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wfo5YtxAOoefKL0h0XL0lXmyyRPplks6LoiTo9wyUU4=;
  b=larLKxNc1ts8wR5HUHU/8KtfHHpI5pzudVFgNmbH3XoPz34GB8WunZkk
   Ic1KSmylCpk8xHzNEkm5zv11pKr20SH/miVHcQU/3TEYUHO8922b5wDqA
   /1RQBE0cGWxKXT9gNVk090c1jmlrNInVWitgfUtszogoMgOwMA3j0vYJq
   96NkSgfz7K9S7PvPpSc6T78ytrUuOH3Ry9s7OWn9K/3xgCV4spNuAw7Nq
   MbaqYIIfJcTU1OZjnvpx/SCPeCqxg9D3ApxME2sxbbopqkE6C8RcJ54Ap
   nvamJtBM3kxBm79IvrK/PTpI2R3RkUWdBhTp2MryU8jur1hio5f+uQp6P
   g==;
X-CSE-ConnectionGUID: 6T0h0jPCT4K9Oxy+yspP0Q==
X-CSE-MsgGUID: ei8e9r5BQoeJ/ROKRfuwmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52181314"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52181314"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:02 -0800
X-CSE-ConnectionGUID: OO1yF9JZRlySBn01uzVZtw==
X-CSE-MsgGUID: TOWKmBIuSuOepeANDpLYSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123497877"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:02 -0800
Subject: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Date: Mon, 03 Mar 2025 23:15:01 -0800
Message-ID: <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
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

pci_ide_stream_alloc()
  Allocate a Selective IDE Stream Register Block in each Partner Port
  (Endpoint + Root Port), and reserve a host bridge / platform stream
  slot. Gather Partner Port specific stream settings like Requester ID.
pci_ide_stream_register()
  Publish the stream in sysfs after allocating a Stream ID. In the TSM
  case the TSM allocates the Stream ID for the Partner Port pair.
pci_ide_stream_setup()
  Program the stream settings to a Partner Port. Caller is responsible
  for optionally calling this for the Root Port as well if the TSM
  implementation requires it.
pci_ide_stream_enable()
  Run the stream after IDE_KM.

In support of system administrators auditing where platform, Root Port,
and Endpoint IDE stream resources are being spent, the allocated stream
is reflected as a symlink from the host bridge to the endpoint with the
name:

    stream%d.%d.%d:%s

Where the tuple of integers reflects the allocated platform, Root Port,
and Endpoint stream index (Selective IDE Stream Register Block) values,
and the %s is the endpoint device name.

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
 .../ABI/testing/sysfs-devices-pci-host-bridge      |   32 ++
 drivers/pci/ide.c                                  |  352 ++++++++++++++++++++
 include/linux/pci-ide.h                            |   60 +++
 include/linux/pci.h                                |    6 
 4 files changed, 450 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 create mode 100644 include/linux/pci-ide.h

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
new file mode 100644
index 000000000000..51dc9eed9353
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -0,0 +1,32 @@
+What:		/sys/devices/pciDDDD:BB
+		/sys/devices/.../pciDDDD:BB
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		A PCI host bridge device parents a PCI bus device topology. PCI
+		controllers may also parent host bridges. The DDDD:BB format
+		conveys the PCI domain number and root bus number of the
+		host bridge.
+
+What:		pciDDDD:BB/firmware_node
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) Symlink to the platform firmware device object "companion"
+		of the host bridge. For example, an ACPI device with an _HID of
+		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00).
+
+What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a platform has established a secure connection, PCIe
+		IDE, between two Partner Ports, this symlink appears. The
+		primary function is to account the stream slot / resources
+		consumed in each of the (H)ost bridge, (R)oot Port and
+		(E)ndpoint that will be freed when invoking the tsm/disconnect
+		flow. The link points to the endpoint PCI device at domain:DDDD
+		bus:BB device:DD function:F. Where R and E represent the
+		assigned Selective IDE Stream Register Block in the Root Port
+		and Endpoint, and H represents a platform specific pool of
+		stream resources shared by the Root Ports in a host bridge.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 193380763812..b2091f6260e6 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -5,6 +5,8 @@
 
 #define dev_fmt(fmt) "PCI/IDE: " fmt
 #include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/pci-ide.h>
 #include <linux/bitfield.h>
 #include "pci.h"
 
@@ -85,5 +87,355 @@ void pci_ide_init(struct pci_dev *pdev)
 
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
+	struct stream_index __stream[PCI_IDE_PARTNER_MAX + 1];
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
+	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
+	if (!ide)
+		return NULL;
+
+	hb = pci_find_host_bridge(pdev->bus);
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
+	const char *name __free(kfree) = kasprintf(
+		GFP_KERNEL, "stream%d.%d.%d:%s", ide->host_bridge_stream,
+		rp_stream, ep_stream, dev_name(&pdev->dev));
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
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
+
+#define SEL_ADDR1_LOWER_MASK GENMASK(31, 20)
+#define SEL_ADDR_UPPER_MASK GENMASK_ULL(63, 32)
+#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
+	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,          \
+		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (base))) | \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,         \
+		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (limit))))
+
+#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
+	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, (base)) | \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, (domain)))
+
+static int ide_domain(struct pci_dev *pdev)
+{
+	if (pdev->fm_enabled)
+		return pci_domain_nr(pdev->bus);
+	return 0;
+}
+
+static struct pci_ide_partner *to_settings(struct pci_dev *pdev, struct pci_ide *ide)
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
+	case PCI_EXP_TYPE_ROOT_PORT:
+		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
+
+		if (pdev != pcie_find_root_port(ide->pdev)) {
+			pci_warn_once(pdev, "setup expected Root Port: %s\n",
+				      pci_name(rp));
+			return NULL;
+		}
+		return &ide->partner[PCI_IDE_RP];
+	default:
+		pci_warn_once(pdev, "invalid device type\n");
+		return NULL;
+	}
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
+	struct pci_ide_partner *settings = to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+			     pdev->nr_ide_mem);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
+
+	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, ide_domain(pdev));
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
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
+	struct pci_ide_partner *settings = to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+			     pdev->nr_ide_mem);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
+
+/**
+ * pci_ide_stream_enable() - after setup, enable the stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Activate the stream by writing to the Selective IDE Stream Control Register.
+ */
+void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+			     pdev->nr_ide_mem);
+
+	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
+	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
+	      FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
+	      FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
+	      FIELD_PREP(PCI_IDE_SEL_CTL_EN, 1);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
+
+/**
+ * pci_ide_stream_disable() - disable the given stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Clear the Selective IDE Stream Control Register, but leave all other
+ * registers untouched.
+ */
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+			     pdev->nr_ide_mem);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
new file mode 100644
index 000000000000..7a3f72915ee2
--- /dev/null
+++ b/include/linux/pci-ide.h
@@ -0,0 +1,60 @@
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
+enum pci_ide_partner_select {
+	PCI_IDE_EP,
+	PCI_IDE_RP,
+	PCI_IDE_PARTNER_MAX,
+	/* pci_ide_stream_alloc() uses this for stream index allocation */
+	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
+};
+
+/**
+ * struct pci_ide_partner - Per port IDE Stream settings
+ * @rid_start: Partner Port Requester ID range start
+ * @rid_start: Partner Port Requester ID range end
+ * @stream_index: Selective IDE Stream Register Block selection
+ */
+struct pci_ide_partner {
+	u16 rid_start;
+	u16 rid_end;
+	u8 stream_index;
+};
+
+/**
+ * struct pci_ide - PCIe Selective IDE Stream descriptor
+ * @pdev: PCIe Endpoint for the stream
+ * @partner: settings for both partner ports in a stream
+ * @host_bridge_stream: track platform Stream index
+ * @stream_id: unique id (within Partner Port pairing) for the stream
+ * @name: name of the stream in sysfs
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
+struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
+void pci_ide_stream_free(struct pci_ide *ide);
+DEFINE_FREE(pci_ide_stream_free, struct pci_ide *, if (_T) pci_ide_stream_free(_T))
+int  pci_ide_stream_register(struct pci_ide *ide);
+void pci_ide_stream_unregister(struct pci_ide *ide);
+void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
+#endif /* __PCI_IDE_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5ea9869c2b1..0f9d6aece346 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -536,6 +536,8 @@ struct pci_dev {
 	u16		ide_cap;	/* Link Integrity & Data Encryption */
 	u8		nr_ide_mem;	/* Address association resources for streams */
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
@@ -603,6 +605,10 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+#ifdef CONFIG_PCI_IDE
+	u8 nr_ide_streams;		/* Track available vs in-use streams */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
+#endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);


