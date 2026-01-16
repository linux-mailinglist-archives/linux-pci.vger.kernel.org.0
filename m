Return-Path: <linux-pci+bounces-45046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5AD31B40
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5880230DF3C5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB4246797;
	Fri, 16 Jan 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5ZqPVb4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BA23FC54;
	Fri, 16 Jan 2026 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569324; cv=none; b=lAVHq4UiKCisomizYm1AZEpOjL7NH+eEQt//Fo2JAvda3kWoJ32e4mL+E6emD0tn1Hbp3z1W5PEorEDLOjtWxifdCjeODPaeV5lk1u3a0rq8uHVMRCPGbiVSYOpki48HebGfcErv9F87xXBFwbaTXt/FPBH0cdSSgUnN7K/i/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569324; c=relaxed/simple;
	bh=CXBizUR6TQboXLqZDa2jR+YXV5JC2c2UazlIFgJe+Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H766cwa3k0GOfNVC1gjupIKeyDZTwYe1ReLbsg19vpyus33ZnJh5MVSVJUq62oyBvxwrmCKfbWSObQpr5/SjZU4W+9ODh/vGNr8tP8//lJmek+ccxR2W8eKqBr7RqIOMuy8uCwju5ciaJqHFUx83+YvBo3R8/h8hE6hhZAVgR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5ZqPVb4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768569323; x=1800105323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CXBizUR6TQboXLqZDa2jR+YXV5JC2c2UazlIFgJe+Yc=;
  b=b5ZqPVb4aqk7T3SMSeGN5JAe0BaWnzAzqbiUyRzcj1tUR/jWTIjnnAQF
   mudFjclvvQwCiZp5OfBc4PuIbDnaRqGRG1ADTvr3NVEx3erFI/96CtvM9
   oI6DgdjuWIw3NIMqK174e+EMa55/9x08P3tQgD+PKjUQwmu1BBUfmH+9A
   Lhw9gVhVaVgxhfxk4iDWY/x4/dpIDln330FlEZ5/pY7j7KSAL3KgVS3NM
   HcpA75gPxrNZybsH1PqFPnWdp7AVzlaaCvbH3qICprrkjmc7E5v965Bnv
   1W5m8ESqZo5KOOIu3apWLohk4VX4ddnANb7SW3elzIhvXOHyDjxkZpHBW
   w==;
X-CSE-ConnectionGUID: gDYtLfeWSkycJIrfG4/YvQ==
X-CSE-MsgGUID: ih4eFvQuQAqX4XrHKREwSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="81251822"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="81251822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 05:15:22 -0800
X-CSE-ConnectionGUID: HdVix/WARZivhBFY8nMK9w==
X-CSE-MsgGUID: UOR/tMnvSRyVf7ehzQAzeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="204846773"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 05:15:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adam Stylinski <kungfujesus06@gmail.com>
Subject: [PATCH 1/1] PCI/bwctrl: Disable BW controller on Intel P45 using a quirk
Date: Fri, 16 Jan 2026 15:15:12 +0200
Message-Id: <20260116131513.2359-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as
PCIe BW controller") was found to lead to a boot hang on a Intel P45
system. Testing without setting Link Bandwidth Management Interrupt
Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable (LABIE)
(PCIe r7.0, sec. 7.5.3.7) in bwctrl allowed system to come up.

P45 is very old chipset and supports only up to gen2 PCIe, so not
having bwctrl does not seem a huge defiancy.

Add no_bw_notif into the struct pci_dev and quirk Intel P45 Root Port
with it.

Reported-by: Adam Stylinski <kungfujesus06@gmail.com>
Link: https://lore.kernel.org/linux-pci/aUCt1tHhm_-XIVvi@eggsbenedict/
Tested-by: Adam Stylinski <kungfujesus06@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/bwctrl.c |  3 +++
 drivers/pci/quirks.c      | 10 ++++++++++
 include/linux/pci.h       |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34..4ae92c9f912a 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -250,6 +250,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	struct pci_dev *port = srv->port;
 	int ret;
 
+	if (port->no_bw_notif)
+		return -ENODEV;
+
 	/* Can happen if we run out of bus numbers during enumeration. */
 	if (!port->subordinate)
 		return -ENODEV;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..6ef42a2c4831 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1359,6 +1359,16 @@ static void quirk_transparent_bridge(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
 
+/*
+ * Enabling Link Bandwidth Management Interrupts (BW notifications) can cause
+ * boot hangs on P45.
+ */
+static void quirk_p45_bw_notifications(struct pci_dev *dev)
+{
+	dev->no_bw_notif = 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notifications);
+
 /*
  * Common misconfiguration of the MediaGX/Geode PCI master that will reduce
  * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..3a556cd749e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,6 +406,7 @@ struct pci_dev {
 						      user sysfs */
 	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
 						   bit manually */
+	unsigned int	no_bw_notif:1;	/* BW notifications may cause issues */
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.39.5


