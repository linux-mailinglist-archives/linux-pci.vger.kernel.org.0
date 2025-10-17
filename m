Return-Path: <linux-pci+bounces-38443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28813BE7F71
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3B2E562F05
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1431B81B;
	Fri, 17 Oct 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBWoDbfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA231A7FE
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695644; cv=none; b=fxWJH4u+NmjW8+xEIHeWgJiVHE9wCN9Iff/W/WEkkN5LkDIyJ9Cu9m7ep75NqdUw+V/AL7kMu4BFeU6WffXXjl+DDfcmLYPi5px0ivpfo0jf+ftfwd5DebDn7tJe858JyPwpIWRy6yvby3v154b9V1MWS+oy1N0Gpi3pHykrUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695644; c=relaxed/simple;
	bh=QMsicfKcDK7ULVGFj41ccErK2dACIxy7uwfqwBS+Gps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onfenreIvNV6TJMUkUhNQfvBQBGQVkOL7mBzV+c7kqghQWwxGRTMyhFQF2IOiMOWq6u+FVzja9w++J0DbooAIOAD+2L4OgDFNRabZnUsZfCm5/3mTDXV8AO8Myme0w28B2xMC0QRetHSEIJNLPmpFYmWDu/Gp/+6xfmV8gjA2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBWoDbfI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760695642; x=1792231642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMsicfKcDK7ULVGFj41ccErK2dACIxy7uwfqwBS+Gps=;
  b=JBWoDbfIrVTVSB4QpdLUJLqex2+4ncdnYnRPevUbR76HSRyHqE9Md1pO
   RzFFeMNrAm4IExadQDzInJajQHCoGi5z+kY10LgwtiDsi4W9SpClUGhri
   POqZzHLi0Y1wox4I/1NA4XJ0uWuWrKa2VQYHLiClcME/cfP57CVgsnqvg
   ZyFVzJTlVhtqYFlYCzkiary5T8DcF4ykK0Ff0GHPaPPOSagJi7dx/e8oT
   shXrzN30JJt0KQNgVTqZ7YmSgHQZ5CR21OlyODs0nb6M+eZwlSRcU2CA2
   wvDZbHwgDRcO1QLyFfD+Z1d3Vk9E/lw2zsPiCqSjeG8X4CsAp7sfVGZ6F
   g==;
X-CSE-ConnectionGUID: /pG41AdtTWKp/r9kQ3/bjQ==
X-CSE-MsgGUID: jzYxSnQiQMGnkI5Kxm2Olg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="85520958"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="85520958"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 03:07:22 -0700
X-CSE-ConnectionGUID: 7BteNnvhT3m4Jyb/IBAMOA==
X-CSE-MsgGUID: Q/wcFAcDRcKYZ0OwE6MjnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="206406453"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Oct 2025 03:07:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9hMk-0005pd-0s;
	Fri, 17 Oct 2025 10:07:18 +0000
Date: Fri, 17 Oct 2025 18:06:32 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	lukas@wunner.de, helgaas@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RESEND 1/1] PCI: pciehp: fix concurrent sub-tree removal
 deadlock
Message-ID: <202510171744.AnmSOlry-lkp@intel.com>
References: <20251016193049.881212-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016193049.881212-2-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/PCI-pciehp-fix-concurrent-sub-tree-removal-deadlock/20251017-033133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251016193049.881212-2-kbusch%40meta.com
patch subject: [PATCH RESEND 1/1] PCI: pciehp: fix concurrent sub-tree removal deadlock
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20251017/202510171744.AnmSOlry-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171744.AnmSOlry-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171744.AnmSOlry-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/of.c:18:
   drivers/pci/pci.h: In function 'pci_dev_set_disconnected':
>> drivers/pci/pci.h:653:9: error: implicit declaration of function 'pci_notify_disconnected'; did you mean 'pci_doe_disconnected'? [-Wimplicit-function-declaration]
     653 |         pci_notify_disconnected();
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         pci_doe_disconnected


vim +653 drivers/pci/pci.h

   648	
   649	static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
   650	{
   651		pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
   652		pci_doe_disconnected(dev);
 > 653		pci_notify_disconnected();
   654	
   655		return 0;
   656	}
   657	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

