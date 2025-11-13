Return-Path: <linux-pci+bounces-41037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB42C5565C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3B653483FC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA062DCC05;
	Thu, 13 Nov 2025 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6PDt9/p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781B2D9EC9
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000046; cv=none; b=T029cAU2nwHcyDJhl8rOb4I49bWqOBM6+8AXgdBYJs5cUcuW4pFgryhJMI9cBnOEV/C7u1JJ5FCSqE9OewT+Gx4ukh9fztsMvYA7s99a6SzZ1+qYQr348QrWKg9gqzR0SmbERQHCC7EFnN2RoPIxsFhJvEHjItrgtPmPHXkb5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000046; c=relaxed/simple;
	bh=zt3Z0YNpw39O7x47uZAbYYJmBDfqnaH3hQBBsiaZ+Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0ZVZF6MJxy/07ZVgMG99HIGDVduzOgOtuauibklzF3CBpXm0eFJBsaz8hNkv8wPIPRqKnndf8GS0URksYMPpQZ2M8fdehBIfFKs/bjOB4bThXFFrBH3+x8RWLqP8WI9+GZcTVac3j9dYOFxTDnt7ViFIXd47TBjVB/TGDifB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6PDt9/p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000046; x=1794536046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zt3Z0YNpw39O7x47uZAbYYJmBDfqnaH3hQBBsiaZ+Oc=;
  b=H6PDt9/pVBAHlixLZkpPOov70M54olY4scsQ0aashET9ttsto6CqUrsr
   lCrcRRGJOH4tibECAHn1roG0fy/katQTivQe9YFkzzazKhNYWKNbzr01x
   T0FsVuMNhMBPWOcVkpi65PuwWs2Lxrky+OBDAn94Fvek37j0N7dPzqd6z
   1cdAeK60LKkzr1FuZU4vrWMA/vofqlR6DWZ0xixpgYAKo63EAwZbVLOFQ
   SuBDWgA0ITDkL5LjFUoZI+NDmZ4SkKAwjdOa1iNIVH/M4RYp7SW0iQ5DB
   fks+r5uNXVcUyuDvS7pckkn+WW1vitKkDSxSJNi9FGJGszPy/P6ORqR3z
   w==;
X-CSE-ConnectionGUID: JaZSqB4rTXGkAf79x0r5xg==
X-CSE-MsgGUID: /sc4ksuzQV2vNSjDE/lzzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471757"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:05 -0800
X-CSE-ConnectionGUID: h9kz0nI7TMaaClr4m0ODNA==
X-CSE-MsgGUID: HNH+gtVgTTmiLv91ZdDASA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802485"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/8] drivers/virt: Drop VIRT_DRIVERS build dependency
Date: Wed, 12 Nov 2025 18:14:39 -0800
Message-ID: <20251113021446.436830-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-1-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of the objects in drivers/virt/ have their own configuration symbols to
gate compilation. I.e. nothing gets added to the kernel with
CONFIG_VIRT_DRIVERS=y in isolation.

Unconditionally descend into drivers/virt/ so that consumers do not need to
add an additional CONFIG_VIRT_DRIVERS dependency.

Fix warnings of the form:

    Kconfig warnings: (for reference only)
       WARNING: unmet direct dependencies detected for TSM
       Depends on [n]: VIRT_DRIVERS [=n]
       Selected by [y]:
       - PCI_TSM [=y] && PCI [=y]

...where PCI_TSM selects CONFIG_TSM, but fails to select
CONFIG_VIRT_DRIVERS.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511041832.ylcgIiqN-lkp@intel.com/
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 8e1ffa4358d5..f660cb4e55ed 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -160,7 +160,7 @@ obj-$(CONFIG_RPMSG)		+= rpmsg/
 obj-$(CONFIG_SOUNDWIRE)		+= soundwire/
 
 # Virtualization drivers
-obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
+obj-y				+= virt/
 obj-$(CONFIG_HYPERV)		+= hv/
 
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
-- 
2.51.1


