Return-Path: <linux-pci+bounces-7948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BD8D28B1
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0730E287D03
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166553802;
	Tue, 28 May 2024 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwC03AK8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E913E040;
	Tue, 28 May 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938584; cv=none; b=nP7v4f8S6RaTKqW2uSkw18xvLdu/7kSfgBQxf4ZsDddSruerh6GRKAgXVM+Yh7s9q87ynK4ZlI73Hh6Q/phGevUSx9+47OZyCy9N5QeGCWMZgVIm2s4b7NRkwHpzw58ZnnLLywXUNrsOcO4BCquj02BJWUDGyB5yoAag/kNVpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938584; c=relaxed/simple;
	bh=yzhnzGK7P0PvLxZpSofJR+kMIQXeu+Et4fHeuG13ShA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=bKE8FsMZJgryxlb0iXkF92P+4BptSwI/DerbL98poWCG9RzYE1T7XSOvQ5vi7ITVHM3QCXGyMKDXeUCbL8pG3gD+Y2E9JKldRXFIvvN4bzsUr9++bTwckRW9Pyh4nCw6NBDw1inbU0g9mp70eUmsLrAAFz3kssvAvZNDkYdtHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwC03AK8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716938582; x=1748474582;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yzhnzGK7P0PvLxZpSofJR+kMIQXeu+Et4fHeuG13ShA=;
  b=lwC03AK8R6H75PvVWKPb95INmTB+EHlIBjHH0hcLDk7+pZt9trv5dCn9
   xyu+Pi+yk1yMhxsfrSIlD1dLN9Dbm6ZKvjw/WcYbmVePRSanmrm5o4N80
   CwmjLta6e07R5NsE4yogzQOdf2dWYGZmUY6GP2YVt6BSGqHZ7wloTeQ36
   9cqdhCdaP9u5mdEFofRJ5UpFLMerQDwdQrh77OG3eTdr/IwnlJW1HBgZX
   3AT6B2kKxO0rbQ0zL09yOMLA+lfZ6Zuv9c8rKQwRL0MGBjj5/nF/8sntH
   yPVj9AvAEc8HjfB8I29tFeAyoXhCTCc++51gQUdVLwYOJsUVx1GbkjX1x
   g==;
X-CSE-ConnectionGUID: i7yXKY/WS1u8iSZEVbTq5A==
X-CSE-MsgGUID: o+lZnT0VS06ExiByyuOBhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13086378"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13086378"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:22:59 -0700
X-CSE-ConnectionGUID: SZxVHdivTIeHmBdoE/Mmzg==
X-CSE-MsgGUID: lK+og/Y1TMaEiUbpHRJe6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35757936"
Received: from atorrent-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.37.47])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:22:59 -0700
Subject: [PATCH] PCI: Make PCI cfg_access_lock lockdep key a singleton
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: Jani Saarinen <jani.saarinen@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Date: Tue, 28 May 2024 16:22:59 -0700
Message-ID: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The new lockdep annotation for cfg_access_lock naively registered a new
key per device. This is overkill and leads to warnings on hash
collisions at dynamic registration time:

 WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1226 lockdep_register_key+0xb0/0x240
 RIP: 0010:lockdep_register_key+0xb0/0x240
 [..]
 Call Trace:
  <TASK>
  ? __warn+0x8c/0x190
  ? lockdep_register_key+0xb0/0x240
  ? report_bug+0x1f8/0x200
  ? handle_bug+0x3c/0x70
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? lockdep_register_key+0xb0/0x240
  pci_device_add+0x14b/0x560
  ? pci_setup_device+0x42e/0x6a0
  pci_scan_single_device+0xa7/0xd0
  p2sb_scan_and_cache_devfn+0xc/0x90
  p2sb_fs_init+0x15f/0x170

Switch to a shared static key for all instances.

Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
Reported-by: Jani Saarinen <jani.saarinen@intel.com>
Closes: https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_14834/bat-apl-1/boot0.txt
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Bjorn,

One more fallout from the cfg_access_lock lockdep annotation. This one
still wants a Tested-by from Jani before merging, but wanted to make you
aware of it in case similar reports make their way to you in the
meantime.

 drivers/pci/probe.c |    7 ++++---
 include/linux/pci.h |    1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e696e547565..15168881ec94 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2533,6 +2533,8 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 	dev_set_msi_domain(&dev->dev, d);
 }
 
+static struct lock_class_key cfg_access_key;
+
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
 	int ret;
@@ -2546,9 +2548,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
-	lockdep_register_key(&dev->cfg_access_key);
-	lockdep_init_map(&dev->cfg_access_lock, dev_name(&dev->dev),
-			 &dev->cfg_access_key, 0);
+	lockdep_init_map(&dev->cfg_access_lock, "&dev->cfg_access_lock",
+			 &cfg_access_key, 0);
 
 	dma_set_max_seg_size(&dev->dev, 65536);
 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb004fd4e889..5bece7fd11f8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -413,7 +413,6 @@ struct pci_dev {
 	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
 
 	bool		match_driver;		/* Skip attaching driver */
-	struct lock_class_key cfg_access_key;
 	struct lockdep_map cfg_access_lock;
 
 	unsigned int	transparent:1;		/* Subtractive decode bridge */


