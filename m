Return-Path: <linux-pci+bounces-37530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04931BB6520
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27543B481D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E928643E;
	Fri,  3 Oct 2025 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="H7yBi7KY"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCE23BF80;
	Fri,  3 Oct 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482387; cv=none; b=ZBUx3AJAoUD1uEeGJeBhODubF5GOd1cOQnK2GlaNDlH+jOzGJK22BMwOi+h7wDLzGj10GBqhkU2AUQ97jJGifyoTalxGGmCymDBciyB30XBTkP2309OPulAHM+RvvqYHdpe0Wv90SgEqvAteALmBgwLJK28UDPGwzpBmup/1FUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482387; c=relaxed/simple;
	bh=qBYenI8/F27BMF7+8lrlzwzqPRSN/NUwrjvd3tUjqRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rr9Aft/DiWeHzWeq1JJn9AmFpFvUEs+Vx/E9x42+1D8OcJ3YQ6iC0oMczx/zGhiMGvZKilw0ltK2DFOKWPkIQVKG3RoP/rMolL8N4IzljlA64Yb/NfkR2hmZ0DiOOY/W6Z3DxfkE16Pqz5EPfrCEaLGgLqn41frqQNyY1NAdjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=H7yBi7KY; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482386; x=1791018386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXeSm5z0xR2Kf4aWS/AqIIdJFx8TbL/siyNLVrwCYnI=;
  b=H7yBi7KYsseoiet1QMNOaWS25DqaDOajYt4nWkq4uKxO7jUy3iNwptVA
   On3QjU1YwWgJIIbYfDwiHqEhRfEnI3UwHc61YVtkyGpK5M0/XyExhqKXb
   O5EAjnDwyZqNXIIGnJf0AhvD5B2803kD4kXEfc8zuzCXrqhMbJ9RLviBs
   xRXooJE6w+bFmFAb+tRIGOZeN99lQvZV1eGZQ3dq+6ESSaKNCGne0d35u
   wTKTuH7og0JkX8ruuaoFl41/TeDyLsuX/mq7wz9bcVJS3/EnaAbclsTAf
   CWu8/wI2YR5KBlTUjsTX/okYApf+yPmxvkbo5x7XEJW34NsZ9DodMH2qd
   w==;
X-CSE-ConnectionGUID: FXykvy0QSYWchLUd1a/k7w==
X-CSE-MsgGUID: SMHSJhWNQhO4jkUUqJjzhg==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4203677"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:06:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:43236]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.156:2525] with esmtp (Farcaster)
 id 3291c77e-5c90-4790-8e8d-2e7361cba638; Fri, 3 Oct 2025 09:06:25 +0000 (UTC)
X-Farcaster-Flow-ID: 3291c77e-5c90-4790-8e8d-2e7361cba638
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:06:25 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:06:22 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 12/13] pci: pcsc: introduce persistence versioning
Date: Fri, 3 Oct 2025 09:00:48 +0000
Message-ID: <630bdfc9fc9591178329983a308642dde68136e5.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The cacheability of the devices can change, either because registers
need to be removed due to a bug / non-compliant device, or adding more
cacheable registers. The current version does not support the
concept of changing the `is_cacheable` bitmask and in order to do so,
the whole persistence mechanism needs to be disabled, change the bitmask
and reenable it again. This adds maintenance difficulty, as well as
negatively impacting the cache hit rate.

This commit adds a mechanism to handle those changes more efficiently.
A version number is identified and it is stored in the FDT during the
save process in the outgoing kernel. The incoming kernel, if compiled
with a different persistence version, will re-infer the cacheability of
all the saved devices, without touching the `is_cached` or the actual
configuration space saved data. This is safe as all access to the cache
are guarded by the `is_cacheable` bitmask. As a result changing the
cacheability will only change the differing registers, while the rest
of the cache will remain valid.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 drivers/pci/pcsc.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 0c4ae73744d6..8ff91ed24a37 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -23,6 +23,9 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 
+/* PCSC persistent data version - increment when the cacheability is changed */
+#define PCSC_PERSISTENT_VERSION 1U
+
 static bool pcsc_enabled;
 static int __init pcsc_enabled_setup(char *str)
 {
@@ -818,6 +821,7 @@ static int pcsc_kho_notifier(struct notifier_block *self, unsigned long cmd,
 	u32 eligible_count = 0;
 	u32 saved_count = 0;
 	u32 skipped_count = 0;
+	const u32 version = PCSC_PERSISTENT_VERSION;
 
 	switch (cmd) {
 	case KEXEC_KHO_ABORT:
@@ -853,8 +857,8 @@ static int pcsc_kho_notifier(struct notifier_block *self, unsigned long cmd,
 	/* Allocate FDT with size calculation (conservative estimates):
 	 * - Per device: node_name(~20) + node_overhead(~12) + da_property(~20)
 	 *   = ~52 bytes, round up to 64 for alignment/margin
-	 * - Fixed overhead: header(40) + root_node(~40) + strings_table(~30)
-	 * + misc(~32) = ~144 bytes, round up to 256
+	 * - Fixed overhead: header(40) + root_node(~48) + strings_table(~30)
+	 * + misc(~32) = ~152 bytes, round up to 256
 	 */
 	fdt_size = PAGE_ALIGN((eligible_count * 64 + 256));
 	pcsc_kho_fdt_order = get_order(fdt_size);
@@ -892,6 +896,12 @@ static int pcsc_kho_notifier(struct notifier_block *self, unsigned long cmd,
 		goto error_cleanup;
 	}
 
+	err = fdt_property(fdt, "pv", &version, sizeof(version));
+	if (err) {
+		pr_err("PCSC: Failed to set version property: %d\n", err);
+		goto error_cleanup;
+	}
+
 	for_each_pci_dev(dev) {
 		int save_err = pcsc_kho_save_device(dev, fdt);
 
@@ -960,7 +970,7 @@ static struct notifier_block pcsc_kho_nb = {
 };
 
 static bool pcsc_kho_restore_device(struct pci_dev *dev, const void *fdt,
-				    int node)
+				    int node, bool version_mismatch)
 {
 	const struct pcsc_data *preserved_data;
 	const u64 *data_addr;
@@ -980,6 +990,9 @@ static bool pcsc_kho_restore_device(struct pci_dev *dev, const void *fdt,
 	dev->pcsc->cached_bitmask = dev->pcsc->data->cached_bitmask;
 	dev->pcsc->cfg_space = dev->pcsc->data->cfg_space;
 
+	if (version_mismatch)
+		infer_cacheability(dev);
+
 	return true;
 }
 
@@ -987,9 +1000,12 @@ static bool pcsc_kho_check_restore(struct pci_dev *dev)
 {
 	phys_addr_t fdt_phys;
 	const void *fdt;
-	int node, err;
+	int node, err, len;
 	bool restored = false;
+	bool version_mismatch = false;
 	char node_name[32];
+	const u32 *version_ptr;
+	u32 saved_version;
 #ifdef CONFIG_PCSC_STATS
 	ktime_t start_time, end_time;
 	u64 duration_ns;
@@ -1007,6 +1023,20 @@ static bool pcsc_kho_check_restore(struct pci_dev *dev)
 		return false;
 	}
 
+	version_ptr = fdt_getprop(fdt, 0, "pv", &len);
+	if (version_ptr && len == sizeof(*version_ptr)) {
+		saved_version = *version_ptr;
+		if (saved_version != PCSC_PERSISTENT_VERSION)
+			version_mismatch = true;
+
+	} else {
+		/* No version found, assume version 0 */
+		pci_info(
+			dev,
+			"PCSC: No version found in restored data. Re-infer Cacheability.\n");
+		version_mismatch = true;
+	}
+
 #ifdef CONFIG_PCSC_STATS
 	start_time = ktime_get();
 #endif
@@ -1017,7 +1047,7 @@ static bool pcsc_kho_check_restore(struct pci_dev *dev)
 
 	node = fdt_subnode_offset(fdt, 0, node_name);
 	if (node >= 0)
-		restored = pcsc_kho_restore_device(dev, fdt, node);
+		restored = pcsc_kho_restore_device(dev, fdt, node, version_mismatch);
 
 #ifdef CONFIG_PCSC_STATS
 	if (restored) {
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


