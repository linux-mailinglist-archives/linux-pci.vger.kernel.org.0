Return-Path: <linux-pci+bounces-18570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5039F3D69
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 23:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C791E188F6D4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 22:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157EF1D6188;
	Mon, 16 Dec 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ajeGIER4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6331D618E
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387867; cv=none; b=Olhv3z3NBz9rSKB2CTqpSuPBY/Nx41oa9ZFTBEiBsuiCsap1gD0aWT8oFZn7ijFKLqsfI/TASBPWut/OfpoRSztHEo9HAzIFTqqWXGVgwtUhoY+SX0y32uVpCFcmMRBATMVeibAMuygMSDLS8wiE8byvxJMrrzsQinnCzv9Jhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387867; c=relaxed/simple;
	bh=W87F5QwYscz65qs3Mt2wXxtBPuMYvQo09O0iWubd4OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvaP+PLW5bpqYSW5hfF8HLKwFZi8Gf2uehQJvcOi4d1aV3ccJXHcU/wEaQs611oMbngb1XREIwYltexp3lTUzzkmZOim4p6/tEc1M5gSBHH4eLiM6DEz+oSfffhKwlr7QFfK3V1dwQ1T9Kln6ZcRa+qN6mcMkMNNXjd/Mpgbz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ajeGIER4; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6397D3F102
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 22:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734387856;
	bh=7q0OdswM1iP5of+Rva11akZrU/0cwPpw0p6jdQPgOx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ajeGIER44AUsmjGEmNf+e9Q2FxrchTaps5HaL+GxX3RbYiUk0CUC440Rd2d7S2OWE
	 4hMVk7yy7E9MBL8+Vn1cvZXh/I8wS+7YKCmjL3PNhrFeSFYplnLC5JyFfhcXR6njjq
	 RPXhZclBUm0NkaL2T4J7a48wtbimSvaje64h/NNQVfiCzBtrBtL3HtaFWY5PZ9bisO
	 dz+ZyFQrshDInYbkeB5h8FyncKY2fOPuacOcVCVuWkrnqPY/geqq91zp0k1qY+hlKQ
	 vTDCACFn78RYRxy4NegvwUDb2y9adfi+l32fsZjS7hutNXWSysn0sqskppKvRhuNas
	 ZptiEa0yoLqSA==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2a3da95c5b5so576986fac.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 14:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734387855; x=1734992655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7q0OdswM1iP5of+Rva11akZrU/0cwPpw0p6jdQPgOx8=;
        b=NW4RLOLlzhekrbfjZHm8+N9QBTTJ3CmyspGhqOYO2vkL9vRmxS5hIKuwPchYRSIJrO
         Dq4YdpJ/O4bxffBqgg5uwPUvh3J+JJTp3mqLDdDQTVQ3bqm8yIzAL0ttvyhMu7hM3Sfx
         h136wNV/couCciA/0pmUNXBcfpGAjM2xXyZh9qXpbwW7akv4Cs9NvN84WsIsgiZmkd+n
         wHlmJQQR7m5YKi1al7UrbKK1s2tREWP6A77cK2IaAXIyJEZJdMZJFft0b/8zyRgmyL8E
         vzSqIpyTt/1bN3qrhqXzaBNsVIaXjVTWJ4KpzH3HWJKX/hxoIDWlh9uW5GhbVjVYHMuZ
         m/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWQJkC9tmyQhSW0Kq0xnN8p2XXq/MmhHjy7XqbGvQWanUI84S1enqW/N9NQL8Dwb3zOhYOr7xW9l/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUt+QDTmVbgNgQGM2dPle+PhXuR4m5uOTIosKbwqPoZ+d/hTlh
	GSsvKDO48nqzefZrOmx45bAcyTwQECow1jkW7ccq2ZhBH8b6MjjtUfTZVAvmEOV5Cp9Hsso/GOl
	DbZdWATSYRovpdprP3y3xaGDb/ZsO2X4Q7HZ3pQQZbN3pEFWkgCRQcF39FxKYvbJuVwI3g3StI0
	CLloOg3g==
X-Gm-Gg: ASbGncv/62cXjMqJK6ushAr+a9r/tfQnvqRd37EVsZgkF0BwEIRpNSOEaKYihK7NLsv
	vMu8LIj9WE3RcUnZ5DPJR55v4eqDyTXjZ3kR2hLt9LlTSYk0+e7SQDVqxddyu6cnC7WThQdqzxq
	P27brIBd4KttClPlUoOPN+A1Y5GpM8lxsmeklsDY2WOriH4goCjYIB/UlkP9lmD7A+hpnX5W4Nk
	FDSjgt0UDTjDUXNSy7GYyEECN2d50dzH7bMPTmhlZvU6EK0u13/epTq5IIL8WeU9X2M3XTFutoq
	wssc
X-Received: by 2002:a05:6870:450c:b0:296:f0be:ebcf with SMTP id 586e51a60fabf-2a3ac8baeeamr6767427fac.40.1734387854863;
        Mon, 16 Dec 2024 14:24:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjgspvlLQsdcvEO1Ekl+Q60tbtWyGGXsvLtLKVq1q3QB91CtBn0BGDTE1pTzBLXtpD4Mo4Kg==
X-Received: by 2002:a05:6870:450c:b0:296:f0be:ebcf with SMTP id 586e51a60fabf-2a3ac8baeeamr6767415fac.40.1734387854488;
        Mon, 16 Dec 2024 14:24:14 -0800 (PST)
Received: from localhost (sub55115.htc.net. [65.87.55.115])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d25472a3sm2279547fac.17.2024.12.16.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:24:13 -0800 (PST)
From: Mitchell Augustin <mitchell.augustin@canonical.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mitchell.augustin@canonical.com,
	alex.williamson@redhat.com
Subject: [PATCH v2] PCI: Add decode disable/enable to device level and separate BAR info logging into separate function
Date: Mon, 16 Dec 2024 16:24:08 -0600
Message-ID: <20241216222408.1003825-1-mitchell.augustin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a virtualized environment with PCI devices passed-through,
disabling and enabling decoding is not trivial, and in some
configurations can take up to 2 seconds of wall clock time to
complete. Since this operation could be done once around each
device for devices with multiple BARs (reducing redundancy),
add an additional decode disable/enable mask at the device
level to prevent redundant disable/enables from occurring
during each BAR sizing operation, when pci_read_bases() is
the originator.

Since __pci_read_base() can also be called independently,
keep the current disable/enable mask in that function as-is.

Since printk cannot be used while decoding is disabled,
move the debug prints in __pci_read_base() to
a separate function, __pci_print_bar_status().
To enable this, add pointers to the signature for
__pci_read_base() through which the caller can access
necessary data from __pci_read_base() and pass it to
__pci_print_bar_status().

Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com/
Reported-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Closes: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com/
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Signed-off-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
---
This has been tested on an SR670v2 host and guest VM,
a DGX H100 host and guest VM, and a DGX A100 host and guest
VM. I confirmed that BAR info logged to dmesg was consistent
on each between unmodified 6.12.1 and with this patch, that
BAR mappings in /proc/iomem were consistent between
versions, and that lspci -vv results were consistent
between versions. On the A100/H100, I also confirmed that the
Nvidia driver loads as expected with the patch, and that
VM boot time with cold-plugged, passed-through GPUs is about
2x faster. No regressions were observed.

v2 of this patch removes unnecessary whitespace.

---
 drivers/pci/iov.c   |  16 ++++-
 drivers/pci/pci.h   |   7 ++-
 drivers/pci/probe.c | 144 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 153 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4be402fe9ab9..e8cbd67c9001 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -784,6 +784,11 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		return -ENOMEM;
 
 	nres = 0;
+	u64 sz64s[PCI_SRIOV_NUM_BARS] = { 0 };
+	u64 l64s[PCI_SRIOV_NUM_BARS] = { 0 };
+	u32 ls[PCI_SRIOV_NUM_BARS] = { 0 };
+	u64 mask64s[PCI_SRIOV_NUM_BARS] = { 0 };
+	bool region_matches[PCI_SRIOV_NUM_BARS] = { 0 };
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		res_name = pci_resource_name(dev, i + PCI_IOV_RESOURCES);
@@ -792,11 +797,16 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		 * If it is already FIXED, don't change it, something
 		 * (perhaps EA or header fixups) wants it this way.
 		 */
-		if (res->flags & IORESOURCE_PCI_FIXED)
+		if (res->flags & IORESOURCE_PCI_FIXED) {
 			bar64 = (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
-		else
+		} else {
 			bar64 = __pci_read_base(dev, pci_bar_unknown, res,
-						pos + PCI_SRIOV_BAR + i * 4);
+						pos + PCI_SRIOV_BAR + i * 4,
+						sz64s, l64s, mask64s, ls, region_matches, i);
+			__pci_print_bar_status(dev, pci_bar_unknown, res,
+					pos + PCI_SRIOV_BAR + i * 4,
+					sz64s[i], l64s[i], mask64s[i], ls[i], region_matches[i]);
+		}
 		if (!res->flags)
 			continue;
 		if (resource_size(res) & (PAGE_SIZE - 1)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..d47f297a2401 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -316,7 +316,12 @@ int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
 
 int pci_setup_device(struct pci_dev *dev);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
-		    struct resource *res, unsigned int reg);
+		struct resource *res, unsigned int pos,
+		u64 *sz64s, u64 *l64s, u64 *mask64s, u32 *ls,
+		bool *region_matches, unsigned int bar_idx);
+int __pci_print_bar_status(struct pci_dev *dev, enum pci_bar_type type,
+		struct resource *res, unsigned int pos,
+		u64 sz64, u64 l64, u64 mask64, u32 l, bool region_match);
 void pci_configure_ari(struct pci_dev *dev);
 void __pci_bus_size_bridges(struct pci_bus *bus,
 			struct list_head *realloc_head);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..3b566b2691d2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -170,17 +170,24 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
  * @type: type of the BAR
  * @res: resource buffer to be filled in
  * @pos: BAR position in the config space
+ * @sz64s: u64[] to be filled in with sz64
+ * @l64s: u64[] to be filled in with l64
+ * @mask64s: u64[] to be filled in with mask64
+ * @ls: u32[] to be filled in with l
+ * @region_matches: bool to be filled in
+ * @bar_idx: Index of this BAR according to caller
  *
  * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
  */
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
-		    struct resource *res, unsigned int pos)
+		    struct resource *res, unsigned int pos,
+		    u64 *sz64s, u64 *l64s, u64 *mask64s, u32 *ls,
+		    bool *region_matches, unsigned int bar_idx)
 {
 	u32 l = 0, sz = 0, mask;
 	u64 l64, sz64, mask64;
 	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
-	const char *res_name = pci_resource_name(dev, res - dev->resource);
 
 	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
 
@@ -247,6 +254,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		mask64 |= ((u64)~0 << 32);
 	}
 
+	sz64s[bar_idx] = sz64;
+	l64s[bar_idx] = l64;
+	mask64s[bar_idx] = mask64;
+
 	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
 		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
 
@@ -255,7 +266,6 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	sz64 = pci_size(l64, sz64, mask64);
 	if (!sz64) {
-		pci_info(dev, FW_BUG "%s: invalid; can't size\n", res_name);
 		goto fail;
 	}
 
@@ -265,8 +275,6 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 			res->start = 0;
 			res->end = 0;
-			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
-				res_name, (unsigned long long)sz64);
 			goto out;
 		}
 
@@ -275,8 +283,6 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET;
 			res->start = 0;
 			res->end = sz64 - 1;
-			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
-				 res_name, (unsigned long long)l64);
 			goto out;
 		}
 	}
@@ -298,12 +304,83 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	 * If it doesn't, CPU accesses to "bus_to_resource(A)" will not
 	 * be claimed by the device.
 	 */
+	region_matches[bar_idx] = true;
 	if (inverted_region.start != region.start) {
 		res->flags |= IORESOURCE_UNSET;
 		res->start = 0;
 		res->end = region.end - region.start;
+		region_matches[bar_idx] = false;
+	}
+
+	goto out;
+
+fail:
+	res->flags = 0;
+out:
+	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
+}
+
+/**
+ * __pci_print_bar_status - Print BAR info or errors.
+ * Must be called after __pci_read_base() for a specific bar.
+ * @dev: the PCI device
+ * @type: type of the BAR
+ * @res: resource buffer to be filled in
+ * @pos: BAR position in the config space
+ * @sz64: sz64 for this bar from __pci_read_base()
+ * @l64: l64 for this bar from __pci_read_base()
+ * @mask64: mask64 for this bar from __pci_read_base()
+ * @l: l for this bar from __pci_read_base()
+ * @region_match: true if region.start == inverted_region.start
+ * in __pci_read_base()
+ *
+ * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
+ */
+int __pci_print_bar_status(struct pci_dev *dev, enum pci_bar_type type,
+		struct resource *res, unsigned int pos,
+		u64 sz64, u64 l64, u64 mask64, u32 l, bool region_match)
+{
+	const char *res_name = pci_resource_name(dev, res - dev->resource);
+
+	if (!sz64)
+		goto fail;
+
+	sz64 = pci_size(l64, sz64, mask64);
+	if (!sz64) {
+		pci_info(dev, FW_BUG "%s: invalid; can't size\n", res_name);
+		goto fail;
+	}
+
+	if (res->flags & IORESOURCE_MEM_64) {
+		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
+		    && sz64 > 0x100000000ULL) {
+			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
+				res_name, (unsigned long long)sz64);
+			goto out;
+		}
+
+		if ((sizeof(pci_bus_addr_t) < 8) && l) {
+			/* Above 32-bit boundary; try to reallocate */
+			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
+				 res_name, (unsigned long long)l64);
+			goto out;
+		}
+	}
+
+	/*
+	 * If "A" is a BAR value (a bus address), "bus_to_resource(A)" is
+	 * the corresponding resource address (the physical address used by
+	 * the CPU.  Converting that resource address back to a bus address
+	 * should yield the original BAR value:
+	 *
+	 *     resource_to_bus(bus_to_resource(A)) == A
+	 *
+	 * If it doesn't, CPU accesses to "bus_to_resource(A)" will not
+	 * be claimed by the device.
+	 */
+	if (!region_match) {
 		pci_info(dev, "%s: initial BAR value %#010llx invalid\n",
-			 res_name, (unsigned long long)region.start);
+			 res_name, (unsigned long long)l64);
 	}
 
 	goto out;
@@ -321,6 +398,18 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg;
+	u64 sz64s[PCI_STD_NUM_BARS] = { 0 };
+	u64 l64s[PCI_STD_NUM_BARS] = { 0 };
+	u32 ls[PCI_STD_NUM_BARS] = { 0 };
+	u64 mask64s[PCI_STD_NUM_BARS] = { 0 };
+	bool region_matches[PCI_STD_NUM_BARS] = { 0 };
+	u16 orig_cmd;
+
+	u64 romsz64[1] = { 0 };
+	u64 roml64[1] = { 0 };
+	u32 roml[1] = { 0 };
+	u64 rommask64[1] = { 0 };
+	bool rom_region_matches[1] = { 0 };
 
 	if (dev->non_compliant_bars)
 		return;
@@ -329,18 +418,53 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
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
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
+
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
+		pos += __pci_read_base(dev, pci_bar_unknown, res, reg,
+				sz64s, l64s, mask64s, ls, region_matches, pos);
 	}
 
 	if (rom) {
 		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+
+		dev->rom_base_reg = rom;
+		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
+				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
+		__pci_read_base(dev, pci_bar_mem32, res, rom,
+				romsz64, roml64, rommask64, roml, rom_region_matches, 0);
+	}
+
+	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
+		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
+
+	for (pos = 0; pos < howmany; pos++) {
+		struct resource *res = &dev->resource[pos];
+
+		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
+		pos += __pci_print_bar_status(dev, pci_bar_unknown, res, reg,
+				sz64s[pos], l64s[pos], mask64s[pos], ls[pos], region_matches[pos]);
+	}
+
+	if (rom) {
+		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+
 		dev->rom_base_reg = rom;
 		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
-		__pci_read_base(dev, pci_bar_mem32, res, rom);
+		__pci_print_bar_status(dev, pci_bar_mem32, res, rom,
+				romsz64[0], roml64[0], rommask64[0], roml[0],
+				rom_region_matches[0]);
 	}
 }
 
-- 
2.43.0


