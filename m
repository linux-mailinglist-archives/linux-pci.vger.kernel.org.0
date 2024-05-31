Return-Path: <linux-pci+bounces-8105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2DC8D5783
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 03:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4A1F229E3
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080574C89;
	Fri, 31 May 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/pSjJn3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE979CD;
	Fri, 31 May 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117471; cv=none; b=Ek0ZABiwYemX9irvEqfALR1+xghB2w+841AqFPrjT1gwnF6JqJRCtVOk57Br0tmxGbyfpHXLhzUUNixb4JukUnCWlNEW6D2kv7jlK3uuMQTDsRZg3tkChXtomvPF3buVl2Xtl5S2fcJmrmzEQujfeKAWcxd0kf6ov74hn2uW/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117471; c=relaxed/simple;
	bh=QUxh+Y5AFjiZYURoqwYt2w5Ltl8jSAgH+F/Cz4IcRPE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfvLiF/lSFKp140w8Myi3llVGiRAddtmTJOrc3r6+hzFBGTRCAq/XFdpmQGNhbu72RVp5W9aoXoyzfPHdtUdMvS4XRC4PQDtvuJj1a/suv5NLPY+HRCuT2rxp2qWjYAGrarfw0ZUtBDhWEoGxN/GoRkuJ7TjTmFKGMEwq+4/DtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/pSjJn3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717117470; x=1748653470;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QUxh+Y5AFjiZYURoqwYt2w5Ltl8jSAgH+F/Cz4IcRPE=;
  b=K/pSjJn3uBpqyL6kfGHMawHLDH315LR7O1Nq6Lbv3Zduod0v8eaa4Xc1
   gvmQivKN5CnQHOKK8b2gO3LGJatAaHNZzW12XI/0ykc5jedaOXwlbqDg4
   oBx0zhMQdbngqLG6iba0z0Pet3UMSemOqua8Jli4Cpz2M1nQnwcY90zHv
   75/6vexIQF+3rAfqHVnDFxJbiKf5+8Jmheugmn484U2IHEtICgEall+cT
   OWGMSV+AfCaSR2nad3nITsLD+hEZX3LFRNzeBMZkbpxqThxNejJil1Dr8
   7k5ySWbPOEP87aq92ne+esIx2Sg4h7zcQAreKXGJ7t0CX8VtMpHb88CKP
   w==;
X-CSE-ConnectionGUID: VaxeBnHcQ3ixKEKtCmV0QQ==
X-CSE-MsgGUID: bPg2inw3SG2rf455mR4gZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24308769"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24308769"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:04:30 -0700
X-CSE-ConnectionGUID: 0z2OUCOARz6sgdU8XcG67w==
X-CSE-MsgGUID: 3dPOpK8dTx6kYd7zXeDecQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36624104"
Received: from spittala-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.84.244])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:04:30 -0700
Subject: [PATCH v2 2/3] PCI: Warn on missing cfg_access_lock during
 secondary bus reset
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org
Date: Thu, 30 May 2024 18:04:29 -0700
Message-ID: <171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The recent adventure with adding lockdep tracking for cfg_access_lock,
while it yielded many false positives [1], it did catch a true positive in
the pci_reset_bus() path [2].

So, while lockdep is difficult to deploy, open coding a check that
cfg_access_lock is held during the reset is feasible.

While this does not offer a full backtrace, it should be sufficient to
implicate the caller of pci_bridge_secondary_bus_reset() as a path that
needs investigation.

Link: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html [1]
Link: http://lore.kernel.org/r/cfb50601-5d2a-4676-a958-1bd3f1b06654@intel.com [2]
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/pci.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35fb1f17a589..8df32a3a0979 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4883,6 +4883,9 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
  */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
+	if (!dev->block_cfg_access)
+		pci_warn_once(dev, "unlocked secondary bus reset via: %pS\n",
+			      __builtin_return_address(0));
 	pcibios_reset_secondary_bus(dev);
 
 	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");


