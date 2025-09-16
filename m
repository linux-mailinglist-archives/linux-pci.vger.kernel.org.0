Return-Path: <linux-pci+bounces-36227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FEB58F7A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5600E1BC4A33
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4012EC087;
	Tue, 16 Sep 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm4+6PR+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C12EA477;
	Tue, 16 Sep 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008718; cv=none; b=snPaWjrus7nt/aBP29A6KWZp/VFgQVCRlwTMAS8DlfijWBFBviiw7RPtQ8Zh8X1aTiMGcpQPgqiimP+Woy86k4qB3i6oouWqTTWwFWGyeTgyKkwC03g3plWV/pfELORztq1KMp1ajfcuGhC+4g3DM9Ym7oV2d37hr7MYEq5vOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008718; c=relaxed/simple;
	bh=AoDEFamLdoU16RXgLYuUZAK+JS2ppkS61fpcFpEu8Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQoInm4eb7f2iQSQai8kyhXHwnQOi95UDm10hlHR2NVTZHwZhGgfoy3LjTLZajAk8pJehijXzd1wYWI35P5TdyuDKVVJqbUPYBwy3RuuucmPUJ8ubideiNItMcD0F0QRGiSC6jcZcUGBkqpBroQw+29gi2z3cwV6sb+eIvKZSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm4+6PR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D54C4CEFA;
	Tue, 16 Sep 2025 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008718;
	bh=AoDEFamLdoU16RXgLYuUZAK+JS2ppkS61fpcFpEu8Jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jm4+6PR+bA9KcdnpoH0iTa7QOP/UAC402hf7Os8CZH5UZp9JJqtrOrainrqMdpQCi
	 6w2iURFLBHdsVHrIqj5tW5J4qR6492tFcqQUa7CbCkb7S8TJSTDSZfd8G5laU84y2J
	 VMXxijvfZ2ZXUY5X22Jy7tNDNabJwaduPHemiwL6cP0FEUW6KoNG3L5VxSQojuaDeQ
	 GziR95uZcXv4Ytu0D4aekvnTKuXGjSfeTa4+Q3fhPRYBxsQuhi8arNzOuHdioSsOsw
	 kWd+Bz88Exa/w6hk25NTrMERzEWQCIIgk0vqmYeHIfloXcu1E1h8i1TQA9ehCy1DRn
	 c70+zvslrJimw==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:12 -0700
Subject: [PATCH v2 04/10] PCI/LUO: Restore state at PCI enumeration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-4-c494053c3c08@kernel.org>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
In-Reply-To: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

Add a PCI device saved state member to indicate the device is requested
vs depended.

Restore the PCI subsystem saved state folio during PCI enumeration.

When a new PCI device is created, restore the per device state pointer
into the dev->lu.dev_state if the device is found in the saved
devices array, by matching the device path.

Restore the dev->lu.flags from the saved flags field.
Add such devices to the "probed_devices" list.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c       | 50 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h              |  6 +++++
 drivers/pci/probe.c            |  2 ++
 include/linux/dev_liveupdate.h |  2 ++
 4 files changed, 60 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 2b215c224fb78c908579b0d22be713e1dc7ca21f..305c5e85aba6bac9d02f97c83e7b3250298d2eff 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -16,6 +16,7 @@
 #define PCI_SUBSYSTEM_NAME "pci"
 
 static LIST_HEAD(preserved_devices);
+static LIST_HEAD(probe_devices);
 
 struct pci_dev_ser {
 	u32	path;		/* domain + bus + slot + fn */
@@ -87,6 +88,7 @@ static int build_liveupdate_devices(struct list_head *head)
 static void dev_cleanup_liveupdate(struct device *dev)
 {
 	dev->lu.flags &= ~LU_DEPENDED;
+	dev->lu.dev_state = NULL;
 	list_del_init(&dev->lu.lu_next);
 }
 
@@ -306,6 +308,54 @@ struct liveupdate_subsystem pci_liveupdate_ops = {
 	.name = PCI_SUBSYSTEM_NAME,
 };
 
+static struct pci_ser *pci_state_get(void)
+{
+	static struct pci_ser *pci_state;
+	struct folio *folio;
+	phys_addr_t data = 0;
+	int ret;
+
+	if (pci_state)
+		return pci_state;
+
+	ret = liveupdate_get_subsystem_data(&pci_liveupdate_ops, &data);
+	if (ret || !data)
+		panic("PCI liveupdate: get subsystem data: [%llx] ret: %d", data, ret);
+
+	folio = kho_restore_folio(data);
+	if (!folio)
+		panic("PCI liveupdate: restore folio from %llx failed", data);
+
+	/* Cache the value for future callers. */
+	pci_state = folio_address(folio);
+	return pci_state;
+}
+
+static void pci_dev_do_restore(struct pci_dev *dev, struct pci_dev_ser *s)
+{
+	dev->dev.lu.dev_state = s;
+	dev->dev.lu.flags = s->flags;
+	pci_info(dev, "liveupdate restore flags %x data: [%llx]\n",
+		 s->flags, s->driver_data);
+	list_move_tail(&dev->dev.lu.lu_next, &probe_devices);
+}
+
+void pci_liveupdate_restore(struct pci_dev *dev)
+{
+	int path;
+	struct pci_dev_ser *s, *end;
+
+	if (!liveupdate_state_updated())
+		return;
+
+	path = pci_get_device_path(dev);
+	s = pci_state_get()->devs;
+	end = s + pci_state_get()->count;
+	for (; s < end; s++)
+		if (s->path == path)
+			return pci_dev_do_restore(dev, s);
+}
+
 static int __init pci_liveupdate_init(void)
 {
 	int ret;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb682b669c0e3a582b5379828e70c4..c9a7383753949994e031dc362920286a475fe2ab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1159,4 +1159,10 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
+#ifdef CONFIG_LIVEUPDATE
+void pci_liveupdate_restore(struct pci_dev *dev);
+#else
+static inline void pci_liveupdate_restore(struct pci_dev *dev) {}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dddd7ebc03d1a6e6ee456e0bf02ab9833a819509..a0605af1a699cd07b09897172803dcba1d2da9f9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2017,6 +2017,8 @@ int pci_setup_device(struct pci_dev *dev)
 	if (pci_early_dump)
 		early_dump_pci_device(dev);
 
+	pci_liveupdate_restore(dev);
+
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
diff --git a/include/linux/dev_liveupdate.h b/include/linux/dev_liveupdate.h
index 80a723c7701ac4ddc2ddd03d0ffc9cc5a62a6083..bb7ecf159dfa82e3779d938811541dddcf8f40af 100644
--- a/include/linux/dev_liveupdate.h
+++ b/include/linux/dev_liveupdate.h
@@ -27,6 +27,7 @@ struct device;
  * @lu_next:	List head for linking the device into live update
  *		related lists (e.g., a list of devices participating
  *		in a live update sequence).
+ * @dev_state:	Set to the device state at restore.
  * @flags:	Indicate what liveupdate feature does the device
  *		participtate.
  * @visited:	Only used by the bus devices when travese the PCI buses
@@ -38,6 +39,7 @@ struct device;
  */
 struct dev_liveupdate {
 	struct list_head lu_next;
+	void *dev_state;
 	enum liveupdate_flag flags;
 	bool visited:1;
 };

-- 
2.51.0.384.g4c02a37b29-goog


