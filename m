Return-Path: <linux-pci+bounces-20165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6822A172A9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 19:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337EB18888D2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B851EE7B9;
	Mon, 20 Jan 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIdQ9CUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8A1531E9
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397337; cv=none; b=FuaBlIbXCnhN2gQtmsEvCeDEs0a7vQ5H3Qu1ulnzT2f+/5CdYrQIUdt07tBHzNYJNGOTQldqbRkp87hfEZsbm74raz4k841HN5SexeSgF8JSIkbqWFbw0vS/GpuM7v4tIQowdVJC0ZfcwluasoxUgYDVOil473/vNiynd8MCskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397337; c=relaxed/simple;
	bh=xlcS0wjiOrcaInIJur9SC67T+L9vgt4MPbnjHahD4T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gphLlQPWRoHlZfPXwZ/5IvYVzBnFqtQza+4QGC/1uXXtOgDpzZh5xBuvLx86Ym1TNpbev5dMSr3b8xzHlSh0Rv6c1fAl35ln96VBLI5ni1j7IoSPaETjLJYkFl5FuXmkAWQHvhitC7V/HnaZydHP2Jp2uWYol6qpi2tfuf8rLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIdQ9CUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737397334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W0phQPvCEaASCXfpbBE+osIQ2+WSHPrJ/JMCk7E9yQg=;
	b=ZIdQ9CUpAIHvZD1RJnZWUADWL+TL3fjjq3OgkZEMomsXpxtwvf6uGtu6OMP4LipXTTDx85
	bbGyX0m483e9OZd19N+Vwa6mRYk8ZTnKr9Wgn22FvXk2pmBnR+0XXY8DY2uHW1UXfs8xcX
	1SvFda2s4n7raly95Np6VF3Ohzyj+Zk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-U9P7hZiOPGOKMKjmYIJ29g-1; Mon,
 20 Jan 2025 13:22:11 -0500
X-MC-Unique: U9P7hZiOPGOKMKjmYIJ29g-1
X-Mimecast-MFC-AGG-ID: U9P7hZiOPGOKMKjmYIJ29g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8599A1956087;
	Mon, 20 Jan 2025 18:22:09 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.64.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C732C3003FD2;
	Mon, 20 Jan 2025 18:22:07 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2] PCI: Batch BAR sizing operations
Date: Mon, 20 Jan 2025 11:21:59 -0700
Message-ID: <20250120182202.1878581-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Toggling memory enable is free on bare metal, but potentially expensive
in virtualized environments as the device MMIO spaces are added and
removed from the VM address space, including DMA mapping of those spaces
through the IOMMU where peer-to-peer is supported.  Currently memory
decode is disabled around sizing each individual BAR, even for SR-IOV
BARs while VF Enable is cleared.

This can be better optimized for virtual environments by sizing a set
of BARs at once, stashing the resulting mask into an array, while only
toggling memory enable once.  This also naturally improves the SR-IOV
path as the caller becomes responsible for any necessary decode disables
while sizing BARs, therefore SR-IOV BARs are sized relying only on the
VF Enable rather than toggling the PF memory enable in the command
register.

Reported-by: Mitchell Augustin <mitchell.augustin@canonical.com>
Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

v2:
 - Move PCI_POSSIBLE_ERROR() test back to original location such that it
   only tests the lower half of 64-bit BARs as noted by Ilpo Järvinen.
 - Reduce delta from original code by retaining the local @sz variable
   filled from the @sizes array and keep location of parsing upper half
   of 64-bit BARs.

 drivers/pci/iov.c   |  8 +++-
 drivers/pci/pci.h   |  4 +-
 drivers/pci/probe.c | 93 +++++++++++++++++++++++++++++++++------------
 3 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4be402fe9ab9..9e4770cdd4d5 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -747,6 +747,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	struct resource *res;
 	const char *res_name;
 	struct pci_dev *pdev;
+	u32 sriovbars[PCI_SRIOV_NUM_BARS];
 
 	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
 	if (ctrl & PCI_SRIOV_CTRL_VFE) {
@@ -783,6 +784,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	if (!iov)
 		return -ENOMEM;
 
+	/* Sizing SR-IOV BARs with VF Enable cleared - no decode */
+	__pci_size_stdbars(dev, PCI_SRIOV_NUM_BARS,
+			   pos + PCI_SRIOV_BAR, sriovbars);
+
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
@@ -796,7 +801,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 			bar64 = (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 		else
 			bar64 = __pci_read_base(dev, pci_bar_unknown, res,
-						pos + PCI_SRIOV_BAR + i * 4);
+						pos + PCI_SRIOV_BAR + i * 4,
+						&sriovbars[i]);
 		if (!res->flags)
 			continue;
 		if (resource_size(res) & (PAGE_SIZE - 1)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..6f27651c2a70 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -315,8 +315,10 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
 
 int pci_setup_device(struct pci_dev *dev);
+void __pci_size_stdbars(struct pci_dev *dev, int count,
+			unsigned int pos, u32 *sizes);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
-		    struct resource *res, unsigned int reg);
+		    struct resource *res, unsigned int reg, u32 *sizes);
 void pci_configure_ari(struct pci_dev *dev);
 void __pci_bus_size_bridges(struct pci_bus *bus,
 			struct list_head *realloc_head);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..bf6aec555044 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -164,41 +164,67 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
 
 #define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
 
+/**
+ * __pci_size_bars - Read the raw BAR mask for a range of PCI BARs
+ * @dev: the PCI device
+ * @count: number of BARs to size
+ * @pos: starting config space position
+ * @sizes: array to store mask values
+ * @rom: indicate whether to use ROM mask, which avoids enabling ROM BARs
+ *
+ * Provided @sizes array must be sufficiently sized to store results for
+ * @count u32 BARs.  Caller is responsible for disabling decode to specified
+ * BAR range around calling this function.  This function is intended to avoid
+ * disabling decode around sizing each BAR individually, which can result in
+ * non-trivial overhead in virtualized environments with very large PCI BARs.
+ */
+static void __pci_size_bars(struct pci_dev *dev, int count,
+			    unsigned int pos, u32 *sizes, bool rom)
+{
+	u32 orig, mask = rom ? PCI_ROM_ADDRESS_MASK : ~0;
+	int i;
+
+	for (i = 0; i < count; i++, pos += 4, sizes++) {
+		pci_read_config_dword(dev, pos, &orig);
+		pci_write_config_dword(dev, pos, mask);
+		pci_read_config_dword(dev, pos, sizes);
+		pci_write_config_dword(dev, pos, orig);
+	}
+}
+
+void __pci_size_stdbars(struct pci_dev *dev, int count,
+			unsigned int pos, u32 *sizes)
+{
+	__pci_size_bars(dev, count, pos, sizes, false);
+}
+
+static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 *sizes)
+{
+	__pci_size_bars(dev, 1, pos, sizes, true);
+}
+
 /**
  * __pci_read_base - Read a PCI BAR
  * @dev: the PCI device
  * @type: type of the BAR
  * @res: resource buffer to be filled in
  * @pos: BAR position in the config space
+ * @sizes: array of one or more pre-read BAR masks
  *
  * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
  */
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
-		    struct resource *res, unsigned int pos)
+		    struct resource *res, unsigned int pos, u32 *sizes)
 {
-	u32 l = 0, sz = 0, mask;
+	u32 l = 0, sz;
 	u64 l64, sz64, mask64;
-	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
 	const char *res_name = pci_resource_name(dev, res - dev->resource);
 
-	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
-
-	/* No printks while decoding is disabled! */
-	if (!dev->mmio_always_on) {
-		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
-		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
-			pci_write_config_word(dev, PCI_COMMAND,
-				orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
-		}
-	}
-
 	res->name = pci_name(dev);
 
 	pci_read_config_dword(dev, pos, &l);
-	pci_write_config_dword(dev, pos, l | mask);
-	pci_read_config_dword(dev, pos, &sz);
-	pci_write_config_dword(dev, pos, l);
+	sz = sizes[0];
 
 	/*
 	 * All bits set in sz means the device isn't working properly.
@@ -238,18 +264,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	if (res->flags & IORESOURCE_MEM_64) {
 		pci_read_config_dword(dev, pos + 4, &l);
-		pci_write_config_dword(dev, pos + 4, ~0);
-		pci_read_config_dword(dev, pos + 4, &sz);
-		pci_write_config_dword(dev, pos + 4, l);
+		sz = sizes[1];
 
 		l64 |= ((u64)l << 32);
 		sz64 |= ((u64)sz << 32);
 		mask64 |= ((u64)~0 << 32);
 	}
 
-	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
-		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
-
 	if (!sz64)
 		goto fail;
 
@@ -320,7 +341,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
+	u32 rombar, stdbars[PCI_STD_NUM_BARS];
 	unsigned int pos, reg;
+	u16 orig_cmd;
+
+	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
 
 	if (dev->non_compliant_bars)
 		return;
@@ -329,10 +354,28 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	if (dev->is_virtfn)
 		return;
 
+	/* No printks while decoding is disabled! */
+	if (!dev->mmio_always_on) {
+		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
+		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
+			pci_write_config_word(dev, PCI_COMMAND,
+				orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
+		}
+	}
+
+	__pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
+	if (rom)
+		__pci_size_rom(dev, rom, &rombar);
+
+	if (!dev->mmio_always_on &&
+	    (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
+		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
+
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
+		pos += __pci_read_base(dev, pci_bar_unknown,
+				       res, reg, &stdbars[pos]);
 	}
 
 	if (rom) {
@@ -340,7 +383,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 		dev->rom_base_reg = rom;
 		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
-		__pci_read_base(dev, pci_bar_mem32, res, rom);
+		__pci_read_base(dev, pci_bar_mem32, res, rom, &rombar);
 	}
 }
 
-- 
2.47.1


