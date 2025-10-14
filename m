Return-Path: <linux-pci+bounces-38068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B730BDAA26
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917943B9368
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ABE3009C4;
	Tue, 14 Oct 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbcgY8Vv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4482D876F;
	Tue, 14 Oct 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459775; cv=none; b=DtyvUpqVjIfvuLA8kFLp6buTHZwtIxYjmyQlcFdXmUnzg3MQSS22Vb7TmdHAKgBDY9oNWdvjSV73xlF2WiJ2EQXMuHNmpWc4SAoUHXBku2FxFG61XAPALjVbgCa9IuGVg8ul7oHosP2iO//UPFfyokWL6WzDm0OgQ0LVb3K9o8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459775; c=relaxed/simple;
	bh=F1+v3UIBK7VfoB+Dfwt8ha5KSWXcrcwVafbVgqUG9TU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ApJ+BFcIKLB2D9kwNuQ5xq1uOijCSF8sT7DtKRrEe8R15zTplu4GPunFaAIOqeH8IzDdHQvCH0Vb96QG7I2Xr9cauJxJ8Aa2K7x6NKmZnzFG/BiKf93mLxCBKuEuAxS0hjs9502gEa+5vBymjMyJo0hp8e+bSZ0QkiTvglD9uT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbcgY8Vv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760459773; x=1791995773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F1+v3UIBK7VfoB+Dfwt8ha5KSWXcrcwVafbVgqUG9TU=;
  b=mbcgY8VviOmPbVVRDkVN7AIRIKG2qU+wtppRctux4nfC+n8VxD2QimoL
   5Njete9Fgsg5G4N++y8B39p5cnGFmqmTH4HH24BnvtswnU7ywzWrlXdJy
   Cg8jVtQQ1qPsZ0NGmRmKCa/cSdX2QUdDqxhuleNf6AXcDDd9h5Ol49EKn
   Nuzxjxr1fhCBmi7tCxn+315KHhfM7Udd61XYNCJtoFU5HNDbeaIVr+5Ou
   LmUgBgD1XoZmfp1S7ft6wGVo9LdMn9VqlhWSjlaJX5BBbimvX1iIgk9ef
   2YMoDbcOem1crTKBh8O1FjPuPv3KIZJ9DklCSQ2L/fSllYT1d34E7SCSd
   A==;
X-CSE-ConnectionGUID: LmFpDXNbTbevE11h4hPNag==
X-CSE-MsgGUID: YPSDokbBQS6shCMGhLrCBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62720888"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="62720888"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 09:36:12 -0700
X-CSE-ConnectionGUID: wmRMhwIYSICX0CfQ8n1s2g==
X-CSE-MsgGUID: khZDkwQ0T8+fJwJIgyd6Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="212892177"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 09:36:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Val Packett <val@packett.cool>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH for-linus 1/1] PCI: Revert early bridge resource set up
Date: Tue, 14 Oct 2025 19:36:02 +0300
Message-Id: <20251014163602.17138-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit a43ac325c7cb ("PCI: Set up bridge resources earlier") moved
bridge window resources set up earlier than before. The change was
necessary to support another change that got pulled on the last minute
due to breaking s390 and other systems.

The presence of valid bridge window resources earlier than before
allows pci_assign_unassigned_root_bus_resources() call from
pci_host_probe() assign the bridge windows. Some host bridges, however,
have to wait first for the link up event before they can enumerate
successfully (see e.g. qcom_pcie_global_irq_thread()) and thus the bus
has not been enumerated yet while calling pci_host_probe().

Calling pci_assign_unassigned_root_bus_resources() without results from
enumeration can result in sizing bridge windows with too small sizes
which cannot be later corrected after the enumeration has completed
because bridge windows have become pinned in place by the other
resources.

Interestingly, it seems pci_read_bridge_bases() is not called at all in
the problematic case and the bridge window resource type setup is done
by pci_bridge_check_ranges() and sizing by the usual resource fitting
logic.

The root problem behind all this looks pretty generic. If resource
fitting is called too early, the hotplug reservation and old size lower
bounding cause the bridge windows to be assigned without children but
with non-zero size, which leads to these pinning problems. As such,
this can likely be solved on the general level but the solution does
not look trivial.

As the commit a43ac325c7cb ("PCI: Set up bridge resources earlier") was
prequisite for other change that did not end up into kernel yet, revert
it to resolve the resource assignment failures and give time to code
and test a generic solution.

Reported-by: Val Packett <val@packett.cool>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: a43ac325c7cb ("PCI: Set up bridge resources earlier")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

This revert should go to for-linus.


I'm not sure whether Guenter's case is exactly the same problem as
described in the commit message, I only know for sure his bisection
landed on the same commit.

My plan is to retry these changes with more supporting changes. It
looks PCI core could delay assigning the bridge window resources if
there are no child resource to put into the bridge windows. Or
alternatively the resource fitting algorithm could release empty bridge
windows as the first step. But that is too complicated change to make
now and would benefit from time spent in -next.

---
 drivers/pci/probe.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec12..0ce98e18b5a8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -538,14 +538,10 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 	}
 	if (io) {
 		bridge->io_window = 1;
-		pci_read_bridge_io(bridge,
-				   pci_resource_n(bridge, PCI_BRIDGE_IO_WINDOW),
-				   true);
+		pci_read_bridge_io(bridge, &res, true);
 	}
 
-	pci_read_bridge_mmio(bridge,
-			     pci_resource_n(bridge, PCI_BRIDGE_MEM_WINDOW),
-			     true);
+	pci_read_bridge_mmio(bridge, &res, true);
 
 	/*
 	 * DECchip 21050 pass 2 errata: the bridge may miss an address
@@ -583,10 +579,7 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 			bridge->pref_64_window = 1;
 	}
 
-	pci_read_bridge_mmio_pref(bridge,
-				  pci_resource_n(bridge,
-						 PCI_BRIDGE_PREF_MEM_WINDOW),
-				  true);
+	pci_read_bridge_mmio_pref(bridge, &res, true);
 }
 
 void pci_read_bridge_bases(struct pci_bus *child)

base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
-- 
2.39.5


