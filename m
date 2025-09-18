Return-Path: <linux-pci+bounces-36443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19BBB86FA0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE6A525AC5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3530EF97;
	Thu, 18 Sep 2025 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJOF4jcR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115D2F39CD;
	Thu, 18 Sep 2025 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229166; cv=none; b=g6xkwJNIX160wUG8V5Uzx+IcAOIZaJ3WFBKbDysGErUm5/EZn69R/rzdh5FgnNAXfYelkVmDzPzTsjmi0fHd34sPLProW9YjYBnNkFcYrBsFsDsPqZj3ZpmkRp+sS/Wv+lJoLUFxOzP+yXvrP10WCrgrtti290t8JJgF2xJI7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229166; c=relaxed/simple;
	bh=a618McCJxNt8+s5TduoVSTIH5FpmlqM0mzZ0wyJHReA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2Eia2gFzT2UMPv2/tRpjQ2wIWAhWsfBBYXQYz1cM0r9xXAV7j8KJTj/OZUaEssLjMCcNS2cZ3jIYgeLgw/qCaZ1KXIbGbWWl+0/L1lQSQZMrI8P8qL0kw6ASuAHrA7uyAxdXzx10+FPdgs1xx/C6M+deJpiY3Mkg2uSk7L59ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJOF4jcR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758229164; x=1789765164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a618McCJxNt8+s5TduoVSTIH5FpmlqM0mzZ0wyJHReA=;
  b=jJOF4jcRsE+3OKErPk1S8kMe1/hzgd7eQJJNVLSVjtBpvKNi69ghK8Za
   M/tf/d8exIw0DjB8Z6ZBy5pEjvfK12GeADZD2CqS2WRYIOEEeL5zf5PDs
   h7dPYhPbci4uJgHcy/a9V34hkJJ0affq29UHi/zjc9dutWmZJx53OOilP
   OguxU7qOnld5mWW7oceNKNLrg9zcpnZw7UzS0nC+DtNjb+R43DQR8TGTI
   k2yZQOXFBzl8zV/rcP6MUdzSwZQqDMzG0SuOncoPZ/wvsY981MnJFxAC0
   UYHgtwqspXXUpGiTdqnnVNkKWgqJSHYhyCghXHpoTA4ZZ6TlKvG50BU2y
   w==;
X-CSE-ConnectionGUID: nDuRlADvTGGyexMwP3LZCQ==
X-CSE-MsgGUID: BgzGqBOZS4OLXwvh3hQ+nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63205053"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="63205053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 13:59:21 -0700
X-CSE-ConnectionGUID: gOHW8YI/RKS+WJ3wK+dBOA==
X-CSE-MsgGUID: 574gvXfnT2C+JcvxIMRIIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174915017"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 13:59:21 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	=?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: Release BAR0 of an integrated bridge to allow GPU BAR resize
Date: Thu, 18 Sep 2025 13:58:56 -0700
Message-ID: <20250918-xe-pci-rebar-2-v1-1-6c094702a074@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918-xe-pci-rebar-2-v1-0-6c094702a074@intel.com>
References: <20250918-xe-pci-rebar-2-v1-0-6c094702a074@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-b03c7
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Resizing BAR to a larger size has to release upstream bridge windows in
order make the bridge windows larger as well (and to potential relocate
them into a larger free block within iomem space). Some GPUs have an
integrated PCI switch that has BAR0. The resource allocation assigns
space for that BAR0 as it does for any resource.

An extra resource on a bridge will pin its upstream bridge window in
place which prevents BAR resize for anything beneath that bridge.

Nothing in the pcieport driver provided by PCI core, which typically is
the driver bound to these bridges, requires that BAR0. Because of that,
releasing the extra BAR does not seem to have notable downsides but
comes with a clear upside.

Therefore, release BAR0 of such switches using a quirk and clear its
flags to prevent any new invocation of the resource assignment
algorithm from assigning the resource again.

Due to other siblings within the PCI hierarchy of all the devices
integrated into the GPU, some other devices may still have to be
manually removed before the resize is free of any bridge window pins.
Such siblings can be released through sysfs to unpin windows while
leaving access to GPU's sysfs entries required for initiating the
resize operation, whereas removing the topmost bridge this quirk
targets would result in removing the GPU device as well so no manual
workaround for this problem exists.

Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/linux-pci/fl6tx5ztvttg7txmz2ps7oyd745wg3lwcp3h7esmvnyg26n44y@owo2ojiu2mov/
Link: https://lore.kernel.org/intel-xe/20250721173057.867829-1-uwu@icenowy.me/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

Remarks from Ilpo: this feels quite hacky to me and I'm working towards a
better solution which is to consider Resizable BAR maximum size the
resource fitting algorithm. But then, I don't expect the better solution
to be something we want to push into stable due to extremely invasive
dependencies. So maybe consider this an interim/legacy solution to the
resizing problem and remove it once the algorithmic approach works (or
more precisely retain it only in the old kernel versions).
---
 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a401930..9b1c08de3aa89 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6338,3 +6338,26 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * PCI switches integrated into Intel Arc GPUs have BAR0 that prevents
+ * resizing the BARs of the GPU device due to that bridge BAR0 pinning the
+ * bridge window it's under in place. Nothing in pcieport requires that
+ * BAR0.
+ *
+ * Release and disable BAR0 permanently by clearing its flags to prevent
+ * anything from assigning it again.
+ */
+static void pci_release_bar0(struct pci_dev *pdev)
+{
+	struct resource *res = pci_resource_n(pdev, 0);
+
+	if (!res->parent)
+		return;
+
+	pci_release_resource(pdev, 0);
+	res->flags = 0;
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, 0x4fa0, pci_release_bar0);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, 0x4fa1, pci_release_bar0);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, 0xe2ff, pci_release_bar0);

-- 
2.50.1


