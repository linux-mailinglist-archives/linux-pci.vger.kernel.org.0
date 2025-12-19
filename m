Return-Path: <linux-pci+bounces-43436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE9CD1382
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71F64300D3FE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88734C80D;
	Fri, 19 Dec 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/3mopGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67134B43D;
	Fri, 19 Dec 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166221; cv=none; b=K9HTKh/L7Sj/9L4TN/0o6BebItq9xj7lytfED/tgh3X18AazBzTxvI1o8GWYO15yRaTzy1X5lSH4lA0gtRfwCFftS+1L4WL0jaBtl/Ya74byhgviAbGbYDvqHUzodomIEVypehKeju0g5dizOILrRyG+KcKBJCp6ujT3LMBRM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166221; c=relaxed/simple;
	bh=Hh2MVJQRLsQAGxUX6ZiAqbTDSFXBiN+yB+eNqilMsjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW+baJWPF11nsunXXApirT64X1srIvrVw4s9TVcAxGPKrSwlCSrWD16Ew8zmyFyUFeuBZ9zun+cyP2faQfEQ2tSEKkGQ8kzrVKPOpx4byNzxU33RHteRJoC46wRxP1EZw/TtuDWeKi9nUoNsy9NHYd0MHcVhHlE/XDPsyOpLIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/3mopGl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166220; x=1797702220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hh2MVJQRLsQAGxUX6ZiAqbTDSFXBiN+yB+eNqilMsjk=;
  b=P/3mopGlxP5LSIRRAVWe2TPacS2sFXda6HtcQvTkB6x87DMDO5i74+wm
   iyJPxBszMXEkk1Nl3T11aSzth0Z41nmylrtCWufCMKl9q48JW6Cl/HbL0
   mlTPqxo3UmK4JLIvAkWOmoKXLZ2q3dOz44mK2FysvAefsQR3OT1xlbZKW
   ArG3xzHZJtOtG1UfbJfokIn2Xf79wmHzYfAeH2KQKrzuzxBKquuvleYUL
   iEG19HNzL9s+NGEZCpNIgTyeXLrIb8z4tdGU/DZM8Z99+aBVvUjdJIhEC
   BtvktHpDKdwnkePH5UNe3r7s3icdB5mqcNsuL14ny0ALp7bHUwEjZLwqR
   A==;
X-CSE-ConnectionGUID: O85SDRhMTLmBKlv7z/X7hg==
X-CSE-MsgGUID: /pUwTPcqQE+F5M5+rjrovA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78764479"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="78764479"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:39 -0800
X-CSE-ConnectionGUID: VC88LqgnQ+qaBleWJhyL+Q==
X-CSE-MsgGUID: ez3t73HbQEWQRlYb2Ptw3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198066258"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 21/23] PCI: Convert to use Bus Number field defines
Date: Fri, 19 Dec 2025 19:40:34 +0200
Message-Id: <20251219174036.16738-22-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert literals for Primary/Secondary/Subordinate Bus Numbers
to use the field defines to improve code readability.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5d8ce6381dff..1781a0a39f4a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -526,8 +526,8 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 
 	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
 	res.flags = IORESOURCE_BUS;
-	res.start = (buses >> 8) & 0xff;
-	res.end = (buses >> 16) & 0xff;
+	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
+	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
 	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
 		 bridge->transparent ? " (subtractive decode)" : "");
 
@@ -1395,9 +1395,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pm_runtime_get_sync(&dev->dev);
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
-	primary = buses & 0xFF;
-	secondary = (buses >> 8) & 0xFF;
-	subordinate = (buses >> 16) & 0xFF;
+	primary = FIELD_GET(PCI_PRIMARY_BUS_MASK, buses);
+	secondary = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
+	subordinate = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
 
 	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
 		secondary, subordinate, pass);
@@ -1478,7 +1478,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				 * ranges.
 				 */
 				pci_write_config_dword(dev, PCI_PRIMARY_BUS,
-						       buses & ~0xffffff);
+						       buses & PCI_SEC_LATENCY_TIMER_MASK);
 			goto out;
 		}
 
@@ -1509,18 +1509,19 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		if (available_buses)
 			available_buses--;
 
-		buses = (buses & 0xff000000)
-		      | ((unsigned int)(child->primary)     <<  0)
-		      | ((unsigned int)(child->busn_res.start)   <<  8)
-		      | ((unsigned int)(child->busn_res.end) << 16);
+		buses = (buses & PCI_SEC_LATENCY_TIMER_MASK) |
+			FIELD_PREP(PCI_PRIMARY_BUS_MASK, child->primary) |
+			FIELD_PREP(PCI_SECONDARY_BUS_MASK, child->busn_res.start) |
+			FIELD_PREP(PCI_SUBORDINATE_BUS_MASK, child->busn_res.end);
 
 		/*
 		 * yenta.c forces a secondary latency timer of 176.
 		 * Copy that behaviour here.
 		 */
 		if (is_cardbus) {
-			buses &= ~0xff000000;
-			buses |= CARDBUS_LATENCY_TIMER << 24;
+			buses &= ~PCI_SEC_LATENCY_TIMER_MASK;
+			buses |= FIELD_PREP(PCI_SEC_LATENCY_TIMER_MASK,
+					    CARDBUS_LATENCY_TIMER);
 		}
 
 		/* We need to blast all three values with a single write */
-- 
2.39.5


