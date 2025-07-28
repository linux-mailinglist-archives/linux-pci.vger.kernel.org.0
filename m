Return-Path: <linux-pci+bounces-33005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1728DB1365F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D420D7A9D26
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C23252900;
	Mon, 28 Jul 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSQv/uhL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F3252287;
	Mon, 28 Jul 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691091; cv=none; b=d2/GDMXxMZm6Zpb95Nd5ymhxWzDd+63GE5yM1NXBO+1CZjw/ZPX49tVspnppAeVRRRzDa6RyBTk5fmaDMEkwMHFXs/3UNKO6ewlsYpNGc/Jd3GcSXwj0P6LajK/BFCqD6EpDTPGYwn41qZzW4xslDuk6uO2KEL9cVL7/snlGWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691091; c=relaxed/simple;
	bh=ehX+ClWrm6r3guFg3n2UP/1LZJ/hCv0T3nDP4k8F0p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bfm9mRFCuGNH5Sns5LM4YazK9qq6Dtn20Epa161WrgQqXaHYE/0JCDzWCWmX8g50tqh2kqJntElKxQHfI2oNgrf9zTfqn/D2ktjoPEY8dB1jejROfKnR4lhW+vfy1x91uyirnywt6lZ7T3sThR23Ez9kG8NUrlDvRbPl23XOdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSQv/uhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD9EC4CEF7;
	Mon, 28 Jul 2025 08:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691090;
	bh=ehX+ClWrm6r3guFg3n2UP/1LZJ/hCv0T3nDP4k8F0p4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KSQv/uhLz+jOZM3kwa0blh/ktTYj04XQaja89gis5f6TxT9uIoPIGGODuaKrHkCWV
	 HvnsZYhV3Y8lZfm7bPiFewzmdt4i3C//LyuJjaF5Cl5d/FssUGacfpyk4gP80p9ZVO
	 r+8A3a4VH/V0XGYNEM3KZLwRVdYSIUGoJkSDCe+ncuZeoR7q8mA6FG9yfMPsjNX5Yl
	 vVHBhbogwtAvFk6uE+PuTpzEQ4M7XwtL/rpxpPGEIjwh2ubf96NjrLX5hJxTODWQ3E
	 PXwbxL96zu2azu+Bs767BBTe+3b4dxHnSz3akxPnOqi6+s1g1uY9TyhFn8H93s85Ip
	 q/zNyFfbWljRQ==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:35 -0700
Subject: [PATCH RFC 05/25] PCI/LUO: Restore state at PCI enumeration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-5-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
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

Also restore the dev->lu.requested or dev->lu.depended base on the saved
"requested" field. Add such devices to the "probed_devices" list.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c       | 54 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h              |  6 +++++
 drivers/pci/probe.c            |  2 ++
 include/linux/dev_liveupdate.h |  2 ++
 4 files changed, 64 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index bbff9b314f99185dfe8941b711cdf0db16b1ed8a..4d13071f5edd6520adb64003262f08d1f79e26c4 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -16,6 +16,7 @@
 #define PCI_SUBSYSTEM_NAME "pci"
 
 static LIST_HEAD(preserved_devices);
+static LIST_HEAD(probe_devices);
 
 struct pci_dev_ser {
 	u32	path;		/* domain + bus + slot + fn */
@@ -91,6 +92,7 @@ static int build_liveupdate_devices(struct list_head *head)
 static void dev_cleanup_liveupdate(struct device *dev)
 {
 	dev->lu.depended = 0;
+	dev->lu.dev_state = NULL;
 	list_del_init(&dev->lu.lu_next);
 }
 
@@ -310,6 +312,58 @@ struct liveupdate_subsystem pci_liveupdate_ops = {
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
+	if (s->requested)
+		dev->dev.lu.requested = 1;
+	else
+		dev->dev.lu.depended = 1;
+	pci_info(dev, "liveupdate restore [%s] data: [%llx]\n",
+		 s->requested ? "requested" : "depended",
+		 s->driver_data);
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
index fa664976f9f5e90b8a5a17cfbed8bd2fdc87b7a1..dc65e2b2d92c02bf15440b6745c62cd748721eef 100644
--- a/include/linux/dev_liveupdate.h
+++ b/include/linux/dev_liveupdate.h
@@ -19,6 +19,7 @@ struct device;
  * @lu_next:	List head for linking the device into live update
  *		related lists (e.g., a list of devices participating
  *		in a live update sequence).
+ * @dev_state:	Set to the device state at restore.
  * @requested:	Set if a live update has been requested for this
  *		device (i.e. device will participate in live update).
  * @depended:	Set if the device participtate the live update due to
@@ -32,6 +33,7 @@ struct device;
  */
 struct dev_liveupdate {
 	struct list_head lu_next;
+	void *dev_state;
 	bool requested:1;
 	bool depended:1;
 	bool visited:1;

-- 
2.50.1.487.gc89ff58d15-goog


