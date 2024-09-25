Return-Path: <linux-pci+bounces-13516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD29861DD
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB0828B93D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE21422D4;
	Wed, 25 Sep 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1GOw5Ge"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3813DDDF
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275535; cv=none; b=rY8E6TDjV6v1bpFsN/vMUsH6j+8GjjAf9SWg6QM4uQs6p7UIJgjtgpzfkE9K51BoehI9zBlpExuarh5RXGPpCMppbCq9bXNr+Z9wyObhFwJyV0HACoY4oysSHtA+CB3tky/0qYE24yqTrw7q6nDqcOL98ITfMp7WZMWgurnMH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275535; c=relaxed/simple;
	bh=mTq3SIoJsTDjQhuscju6DwMyUWtDPD3Kmo2BFtmIFiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eX2wcNGnd9/zcTvTqibHX3h8URr5Z9YpVoeYtCFVztKDcPV+i7Bu/yPoByQ0EFCJEqLYbkUpG1t04Yfs4bZUql3+LwkLDcDqzvtwq8aAzNlf+BEUyb1cOQqUyGNlXUhLu0XB19UhMllZNK6iyPaS2OZ+pBxwsP/S409nHGDrJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1GOw5Ge; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727275534; x=1758811534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mTq3SIoJsTDjQhuscju6DwMyUWtDPD3Kmo2BFtmIFiA=;
  b=S1GOw5Gecni+jWUWjOJ8nKb3A2osgJw2/S5tTWln8lLOBOYlJHQoD+Ug
   Fb9iX4Cb/CuMdIC5Khf0j9thMXCCeHwTCmbx/923TZf5g4M3v1zqAMZMU
   7DwJ/jPgJMz4TngfzUZpEXYqVHK7wYFpgmjPy9CSCB9JGul6YwNYqNLEs
   KuVZqfriryN3pbf0t9/+PYMcaEVOKC4q6Qzc3qGa7jVudsX/a12eALUKh
   si/vnuIYmV7QDBs2W12H00WC3hYr2zDdDZW42zfbLV2vBsab006jIH1RC
   sY+aZnOHQNPZPn+lmipTWTGqg8dwWpxBbfd5mI/1df54rl8bX0REXoFEL
   A==;
X-CSE-ConnectionGUID: WYgnxvaJQ6a8L0wGLPlrGg==
X-CSE-MsgGUID: XTlGGEhhRKq/WDw8nPw4bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26470588"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26470588"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:45:34 -0700
X-CSE-ConnectionGUID: VunbD8KQQLyMSh+164KdvQ==
X-CSE-MsgGUID: ceKjx4iLR5OHweqH3UJVmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71941503"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 25 Sep 2024 07:45:31 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 25 Sep 2024 17:45:29 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/6] PCI/PM: Respect pci_dev->skip_bus_pm in the .poweroff() path
Date: Wed, 25 Sep 2024 17:45:21 +0300
Message-ID: <20240925144526.2482-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

On some older laptops i915 needs to leave the GPU in
D0 when hibernating the system, or else the BIOS
hangs somewhere. Currently that is achieved by calling
pci_save_state() ahead of time, which then skips the
whole pci_prepare_to_sleep() stuff.

It feels to me that this approach could lead to unintended
side effects as it causes the pci code to deviate from the
standard path in various ways. In order to keep i915
behaviour more standard it seems preferrable to use
pci_dev->skip_bus_pm here. Duplicate the relevant logic
from pci_pm_suspend_noirq() in pci_pm_poweroff_noirq().

It also looks like the current code is may put the parent
bridge into D3 despite leaving the device in D0. Though
perhaps the host bridge (which is where the integrated
GPU lives) always has subordinates, which would make
this a non-issue for i915. But maybe this could be a
problem for other devices. Utilizing skip_bus_pm will
make the behaviour of leaving the bridge in D0 a bit
more explicit if nothing else.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/pci/pci-driver.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4..ef436895939c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1142,6 +1142,8 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1206,9 +1208,21 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
+	if (!pci_dev->state_saved && !pci_dev->skip_bus_pm &&
+	    !pci_has_subordinate(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
+	if (pci_dev->current_state == PCI_D0) {
+		pci_dev->skip_bus_pm = true;
+		/*
+		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
+		 * downstream device is in D0, so avoid changing the power state
+		 * of the parent bridge by setting the skip_bus_pm flag for it.
+		 */
+		if (pci_dev->bus->self)
+			pci_dev->bus->self->skip_bus_pm = true;
+	}
+
 	/*
 	 * The reason for doing this here is the same as for the analogous code
 	 * in pci_pm_suspend_noirq().
-- 
2.44.2


