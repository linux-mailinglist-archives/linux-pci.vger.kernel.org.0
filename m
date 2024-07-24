Return-Path: <linux-pci+bounces-10734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0130293B598
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88A01F21866
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303531C693;
	Wed, 24 Jul 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHoQ72oG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AE15EFCD
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840982; cv=none; b=hLgoYoyzGs232YwKvin8EBZKlhqzZM5rpH1q1u21qboWLoexRv1Lpr5m0pByuUs0LlsP8QbVQODD0fYWNz1CLauXTR+gh3Bm7UM+BQg8QmHLw9uwqQE+60RYZpbAwvC3tSMXjz+UYzxJhnJ2L5OKaEfSRW5HsH8Ht300aAQBB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840982; c=relaxed/simple;
	bh=Atc4yJ0kmLFLkhgdjO/qzgNe3nq2K1qGx0U92cu2lSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F+M9hEv66HsdEl7DarEJGIULCKF/oM8SV7LRvFzkbGrM9YoupQfx/wsrCCFtu9ezZmMx/WAe669jQV8qzeQlRajpcZ6jBPmvq+ZacEkQ2ooagTEIynW1fboNmCoiYTUx0UmjXUp9ls6Pluf+jxEs1I7wd4KD3w4MSgkpMaqu+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHoQ72oG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721840980; x=1753376980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Atc4yJ0kmLFLkhgdjO/qzgNe3nq2K1qGx0U92cu2lSw=;
  b=PHoQ72oGH8jqDG8LuMp9W5sCxDlHCb6jGQ7O8rpx4iKPzQPpF5tg8/rm
   hNumB3sGV0hYhVF4zP9pWv1znyPhxaxDWkb+CBNBPWflQydEPxicg5QSP
   RvGK7CKeO0NN5y4RTIcvawm/GcsqLKauiZsG59y1B6U4tGAshiTIKoaop
   SLTuB6kK8f7gK8Ca+cHSMSmMLUMjXztqQb5+DCUO4bkuS59MBmFd8jyT2
   QKC6FVl0EinHa0ArROxAGoNfTL0flKCvdEc5pR8K+av1wRznGkBs8J7J6
   j1tdfsQwXZj5xzVKAr5qbNWhn0tLGIt++X/Mkspk6iFuMStWGq6jCeDgm
   A==;
X-CSE-ConnectionGUID: igfVK6ncTuqoNOVXb4vkFQ==
X-CSE-MsgGUID: GKB2TcqSRHeDwbGxfSGqgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="12692845"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="12692845"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 10:09:38 -0700
X-CSE-ConnectionGUID: cOgU0KBLQH2HgsbfXkt6lw==
X-CSE-MsgGUID: 7umgHSIEReOPjaD11sC/aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="75877579"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.45])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 10:09:38 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: <linux-pci@vger.kernel.org>,
	paul.m.stillwell.jr@intel.com
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jim Harris <james.r.harris@intel.com>
Subject: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream devices
Date: Wed, 24 Jul 2024 10:00:40 -0700
Message-Id: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMD does not support legacy interrupts for devices downstream from a
VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for these
devices to ensure we don't try to set up a legacy irq for them.

Note: This patch was proposed by Jim, I am trying to upstream it.

Signed-off-by: Jim Harris <james.r.harris@intel.com>
Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 arch/x86/pci/fixup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b33afb240601..a3b34a256e7f 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -653,6 +653,20 @@ static void quirk_no_aersid(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
 
+#if IS_ENABLED(CONFIG_VMD)
+/* 
+ * VMD does not support legacy interrupts for downstream devices.
+ * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure OS
+ * doesn't try to configure a legacy irq.
+ */
+static void quirk_vmd_interrupt_line(struct pci_dev *dev)
+{
+	if (is_vmd(dev->bus))
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_vmd_interrupt_line);
+#endif
+
 static void quirk_intel_th_dnv(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource[4];
-- 
2.39.1


