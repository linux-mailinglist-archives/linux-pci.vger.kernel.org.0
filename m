Return-Path: <linux-pci+bounces-19647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEDDA0A613
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 22:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CD63A2D9E
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B461B87F4;
	Sat, 11 Jan 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDEHTxKb"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965531B87D3
	for <linux-pci@vger.kernel.org>; Sat, 11 Jan 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736629633; cv=none; b=gW5WvwLauh9pCbVZAjGN5x+jZvk1wgq99s9S73KBuoyhWWaKGFhtKS4V3PBCdja1hE00LW/g8Ny4nSYgYfkNVOrqnVA62c7uNL0KT1TUdAD5PbMilVIPGdcwxiwWmK1lLaD9DaQJIdXI3PybuoLRcWKjYXh4XrGY+rfGgsE3p/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736629633; c=relaxed/simple;
	bh=aEjX9HgcPCtB0KPfcqW9rLAC2XmZI+BxeBSLSgOjNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1QKRqgJ8AhoWni73yEo6ALno/PwIrGdtoVge45Q+CPQgae5uAsUCZfA5qhp5htn48daB77yZp6nDjvXdI9vDxHsN8frr7Wv122TodJixjSXr0TGTXT+C1m5RXB91FFYOXW/jMGTfaJ9ya6W0qVKgh0c2wFxE9L/uv+1FGb1Xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDEHTxKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736629630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nZaN6wj8B8XMuFw+Wi7jF/guxuq2PpyVoYbXo6JR9dc=;
	b=YDEHTxKbykuY8wdOzpVC4Vd65qTvOSk7kJ3/ysk77QIbQEHgYy8uXsfp6t74/RlvCLMHgH
	Ms1w2OjesOVDifC10Eei7jfRqR4ku+A9g6bTHhEBrTzBU8TAOs9h5HIG1AAmIipcakI20q
	oyYATjI+mENWA1VrcJwaJ1RYjnxUyMQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-O9-n20EAOJC18SEvPYj88Q-1; Sat,
 11 Jan 2025 16:07:07 -0500
X-MC-Unique: O9-n20EAOJC18SEvPYj88Q-1
X-Mimecast-MFC-AGG-ID: O9-n20EAOJC18SEvPYj88Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFB3919560AA;
	Sat, 11 Jan 2025 21:07:05 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.64.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C0131955BE3;
	Sat, 11 Jan 2025 21:07:03 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mitchell.augustin@canonical.com
Subject: [PATCH] PCI: Batch BAR sizing operations
Date: Sat, 11 Jan 2025 14:06:51 -0700
Message-ID: <20250111210652.402845-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

This is an alternative to the patch proposed by Mitchell[1] and more
in line with my suggestion in the original report thread[2].  It makes
more sense to me to stash all the BAR sizing values into an array on
the front end of parsing them into resources than it does to pass
multiple arrays on the backend for status printing purposes.  We can
discuss in either of these patches which is the better approach or
if someone has a better yet alternative.

I don't have quite the config Mitchell has for testing, but this
should make effectively the same improvement and does show a
significant improvement in guest boot time even with a single 24GB
GPU attached.  There are of course further improvements to investigate
in the VMM, but disabling memory decode per BAR is a good start to
making Linux be a friendlier guest.  Further testing appreciate.
Thanks,

Alex

[1]https://lore.kernel.org/all/20241218224258.2225210-1-mitchell.augustin@canonical.com/
[2]https://lore.kernel.org/all/20241203150620.15431c5c.alex.williamson@redhat.com/

 drivers/pci/iov.c   |   8 ++-
 drivers/pci/pci.h   |   4 +-
 drivers/pci/probe.c | 132 +++++++++++++++++++++++++++++---------------
 3 files changed, 97 insertions(+), 47 deletions(-)

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
index 2e81ab0f5a25..5ca96280d698 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -164,50 +164,75 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
 
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
+
+		/*
+		 * All bits set in size means the device isn't working properly.
+		 * If the BAR isn't implemented, all bits must be 0.  If it's a
+		 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR,
+		 * bit 1 must be clear.
+		 */
+		if (PCI_POSSIBLE_ERROR(*sizes))
+			*sizes = 0;
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
+	u32 l = 0;
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
-
-	/*
-	 * All bits set in sz means the device isn't working properly.
-	 * If the BAR isn't implemented, all bits must be 0.  If it's a
-	 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, bit
-	 * 1 must be clear.
-	 */
-	if (PCI_POSSIBLE_ERROR(sz))
-		sz = 0;
 
 	/*
 	 * I don't know how l can have all bits set.  Copied from old code.
@@ -221,35 +246,30 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		res->flags |= IORESOURCE_SIZEALIGN;
 		if (res->flags & IORESOURCE_IO) {
 			l64 = l & PCI_BASE_ADDRESS_IO_MASK;
-			sz64 = sz & PCI_BASE_ADDRESS_IO_MASK;
+			sz64 = *sizes & PCI_BASE_ADDRESS_IO_MASK;
 			mask64 = PCI_BASE_ADDRESS_IO_MASK & (u32)IO_SPACE_LIMIT;
 		} else {
 			l64 = l & PCI_BASE_ADDRESS_MEM_MASK;
-			sz64 = sz & PCI_BASE_ADDRESS_MEM_MASK;
+			sz64 = *sizes & PCI_BASE_ADDRESS_MEM_MASK;
 			mask64 = (u32)PCI_BASE_ADDRESS_MEM_MASK;
+
+			if (res->flags & IORESOURCE_MEM_64) {
+				pci_read_config_dword(dev, pos + 4, &l);
+				sizes++;
+
+				l64 |= ((u64)l << 32);
+				sz64 |= ((u64)*sizes << 32);
+				mask64 |= ((u64)~0 << 32);
+			}
 		}
 	} else {
 		if (l & PCI_ROM_ADDRESS_ENABLE)
 			res->flags |= IORESOURCE_ROM_ENABLE;
 		l64 = l & PCI_ROM_ADDRESS_MASK;
-		sz64 = sz & PCI_ROM_ADDRESS_MASK;
+		sz64 = *sizes & PCI_ROM_ADDRESS_MASK;
 		mask64 = PCI_ROM_ADDRESS_MASK;
 	}
 
-	if (res->flags & IORESOURCE_MEM_64) {
-		pci_read_config_dword(dev, pos + 4, &l);
-		pci_write_config_dword(dev, pos + 4, ~0);
-		pci_read_config_dword(dev, pos + 4, &sz);
-		pci_write_config_dword(dev, pos + 4, l);
-
-		l64 |= ((u64)l << 32);
-		sz64 |= ((u64)sz << 32);
-		mask64 |= ((u64)~0 << 32);
-	}
-
-	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
-		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
-
 	if (!sz64)
 		goto fail;
 
@@ -320,7 +340,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
+	u32 rombar, stdbars[PCI_STD_NUM_BARS];
 	unsigned int pos, reg;
+	u16 orig_cmd;
+
+	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
 
 	if (dev->non_compliant_bars)
 		return;
@@ -329,10 +353,28 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
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
@@ -340,7 +382,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 		dev->rom_base_reg = rom;
 		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
-		__pci_read_base(dev, pci_bar_mem32, res, rom);
+		__pci_read_base(dev, pci_bar_mem32, res, rom, &rombar);
 	}
 }
 
-- 
2.47.1


