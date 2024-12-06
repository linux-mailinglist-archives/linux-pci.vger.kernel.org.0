Return-Path: <linux-pci+bounces-17814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E69E6199
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54833168874
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 00:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D4256E;
	Fri,  6 Dec 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QgGr0Gb6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE0EC2
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443471; cv=none; b=CPKYcfg15B32HtI59yfpMtJ3W6ho/D94BFirZTPGivNkcIT3PJy4W87uB/+/56w3Nssln8PDHMEFFm2ap5eVSPtUmyM57vE6KdgnXsk/TXC1eI2js/9/PJT6MXI4+CFRi4xj+nfvsrsohVFfWJ1TwzWtsqfwuajUqrHRwzXlXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443471; c=relaxed/simple;
	bh=8NoOKINOZDPh29Fa9xZiFkjnsmZHb+VL0rBWjct+Z5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8yhDLdEkiH89gkPZZl+EuC3TjOhYfPAXIwn0eCcfqi0jVgKWIoBl5Gng77f/Y74es/+zslRsBVJNXbBhILvIq9TYp/g9UiykUJ7z1f4GcWDdcz4PeoBmcC117tpDt7H77ANnOTKS5dUj5SZUwcpEg9cOL0DIL5cGVQ+RGoej00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QgGr0Gb6; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06F1C40CE6
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733443466;
	bh=nAQd83d99omC/FVhvXxrkKyQeMsNDxZ2HHM6lEg+BkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=QgGr0Gb6M2LJ324Jlpv3cBscy6GMx8s++cFqgbgr5tNsnt7K5lgaKNeWjN9X5yN3G
	 6zKB8+XBc18MU5erDdkmib1VyJhdUIscmwp+hI/TtLWGtgvmg/FHusV45kB/GFnuKB
	 0a2issiia2dtR7TmHHBOIIMKdOlx7wGzReCeBy6VNHiLe3oh5FZXtHliEOufIHB50b
	 oZ+TDpYSx+I4pUnInsgovoNyyGsbWtbsdtnyHczNmfrDQLKaLU+hqTDXF7WSfw4UH0
	 TSlWKj8lAzPih8uoK1BsGG+RUpYZX3qavDWzndGvLva5VOQvYRo4rI26o7xhr043lz
	 4CSKt5wGVt+CA==
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d87d6c09baso26745356d6.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2024 16:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443465; x=1734048265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAQd83d99omC/FVhvXxrkKyQeMsNDxZ2HHM6lEg+BkA=;
        b=YJkZpFmsBu2S+dnsPJfoG9OjVlTLl5wZPJuwamU44xOa0lHDw5d3E6giYjMTOSCCQX
         L/vjOlHFSRyuPO8bD0g2ILoE3kU8igZ31TpqSQQY8biekqH1+izLoeAQ3JjWsLtSBKrn
         MbPAyKwFa4pQAGl+dG3yFWYexHtBGG/TLyILC2UVEb2+hrcsy6E3rCZox/i1BM/9ishz
         KJL1JRY+iR6sPeVihf3GbWZR7vkqtZBb2XSl/2yq0LEv4kdCSgWpPYITz9E8c+lRkI+U
         BPsB2yAprgtVoodlc5rdh7tdbPwu9U7QWB8/wdYwIy/Uj+CjmRuFsKr9JX44nNdtnZTt
         LckA==
X-Forwarded-Encrypted: i=1; AJvYcCVZXekoY09JnAFE0VoUmSfed3sPs3wO4Np6yEYV5Re2snwj7h/LiipKfBm9ESjbuGsTSth2DYOuwFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkF7+NKGwZZZMsmSquFwA9pAFAf5rooKr9dQ5BkpgkkhhNwUi
	639A6EKe9APQIuVI11WmTD+VLg58eslcpIdmHLY5c0iGljfe4BcaSmxfdK+2N5NXxG7zohbt7u8
	IMinB2ErVZRzQq26dQXC7Y6NBrGOCgtvcL1zS1XTON89mB+JED+5zMHR/DN/rr+U9xlYslCCy7w
	==
X-Gm-Gg: ASbGnctPyJSjOt8l2Z73je8iek841Ck2mVJfIqu4X9gzT6G7SXgngTkpZ89hcBCcI1d
	pwogteAZXormEXHUdwUzLsYlyPN95OAXHkDKp6mwNP9FrmGvkfL1dibXVtnXHKACj28DKBct5ls
	MDM++kiv2miPJH9Kd4SmUVI8T/tZ0ATvd5JpNYObOLOkr+6M954WsoCn4cRBTmvlQ9ho8HKAYb2
	jT0/qSlO482mjaSAMzTnRulSaOeL4Oo3gBilXJp17hwdv9zh6hEIls8/VsC60FleIUPJXMlCA==
X-Received: by 2002:a05:6214:2242:b0:6cb:20b6:f398 with SMTP id 6a1803df08f44-6d8e716b293mr17239266d6.21.1733443464948;
        Thu, 05 Dec 2024 16:04:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyfBdIqzIMXRT8EQHyt8JmGY+shaqBCcMu4+eNVmJwRT862HLdeTIbz5zF/aXV2wC0F1THcQ==
X-Received: by 2002:a05:6214:2242:b0:6cb:20b6:f398 with SMTP id 6a1803df08f44-6d8e716b293mr17239026d6.21.1733443464592;
        Thu, 05 Dec 2024 16:04:24 -0800 (PST)
Received: from localhost (sub55115.htc.net. [65.87.55.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da69591fsm12375016d6.31.2024.12.05.16.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:04:23 -0800 (PST)
From: Mitchell Augustin <mitchell.augustin@canonical.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mitchell.augustin@canonical.com,
	alex.williamson@redhat.com
Subject: [PATCH 1/1] PCI: Add decode disable/enable to device level and separate BAR info logging into separate function
Date: Thu,  5 Dec 2024 18:03:51 -0600
Message-ID: <20241206000351.884656-2-mitchell.augustin@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206000351.884656-1-mitchell.augustin@canonical.com>
References: <20241206000351.884656-1-mitchell.augustin@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an additional decode disable/enable mask at the device
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
 drivers/pci/iov.c   |  16 ++++-
 drivers/pci/pci.h   |   7 ++-
 drivers/pci/probe.c | 149 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 158 insertions(+), 14 deletions(-)

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
index 2e81ab0f5a25..8984bb4ca53a 100644
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
 
@@ -247,15 +254,19 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		mask64 |= ((u64)~0 << 32);
 	}
 
+	sz64s[bar_idx] = sz64;
+	l64s[bar_idx] = l64;
+	mask64s[bar_idx] = mask64;
+
 	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
 		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
 
+
 	if (!sz64)
 		goto fail;
 
 	sz64 = pci_size(l64, sz64, mask64);
 	if (!sz64) {
-		pci_info(dev, FW_BUG "%s: invalid; can't size\n", res_name);
 		goto fail;
 	}
 
@@ -265,8 +276,6 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 			res->start = 0;
 			res->end = 0;
-			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
-				res_name, (unsigned long long)sz64);
 			goto out;
 		}
 
@@ -275,8 +284,6 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET;
 			res->start = 0;
 			res->end = sz64 - 1;
-			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
-				 res_name, (unsigned long long)l64);
 			goto out;
 		}
 	}
@@ -298,12 +305,83 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
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
@@ -316,11 +394,24 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		pci_info(dev, "%s %pR\n", res_name, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
+
 }
 
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
@@ -329,19 +420,57 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
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
+	for (pos = 0; pos < howmany; pos++) {
+		struct resource *res = &dev->resource[pos];
+
+		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
+		pos += __pci_read_base(dev, pci_bar_unknown, res, reg,
+				sz64s, l64s, mask64s, ls, region_matches, pos);
+	}
+
+	if (rom) {
+		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
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
+
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
+
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
+		pos += __pci_print_bar_status(dev, pci_bar_unknown, res, reg,
+				sz64s[pos], l64s[pos], mask64s[pos], ls[pos], region_matches[pos]);
 	}
 
 	if (rom) {
 		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+
 		dev->rom_base_reg = rom;
 		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
-		__pci_read_base(dev, pci_bar_mem32, res, rom);
+		__pci_print_bar_status(dev, pci_bar_mem32, res, rom,
+				romsz64[0], roml64[0], rommask64[0], roml[0],
+				rom_region_matches[0]);
 	}
+
+
 }
 
 static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
-- 
2.43.0


