Return-Path: <linux-pci+bounces-38444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123ABE7F55
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436715E7841
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD030F818;
	Fri, 17 Oct 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3n95l9O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104EB31AF2E
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695644; cv=none; b=KaFaVICt9eozhuszHih114OgZgLgUM/83SsN048s6gxora5561mOPZYNg9cEBgSl4PpuFWaQOGsMphHbu5aWr6j6fhHeHF9qV9NZM/Y/8DaCH2eg8KgpymO8mOaD874B6ZQ87oQPyE5626ep7amKG/JqvOso5tByTVFjRIR/gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695644; c=relaxed/simple;
	bh=kojQMXknS4fWVlJmzyerdgKYf2aOP/WaOJN/eiI6YoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4EeMNOMdhZCZ/lV2vxc4AeNWjBwJZa9zpMwECvMaO5kKx2pJd+n3JA5NEwyCNrigkZB2EaTIrvAwdAIjXA2OT+9XZ5J37SO9rzG1s/tKhqSiCj9oCOC95N5bwhvB+3abnmvSo5qbXQwKSUwm1wEvj46umfbWTL2+RADFT5n0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3n95l9O; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760695643; x=1792231643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kojQMXknS4fWVlJmzyerdgKYf2aOP/WaOJN/eiI6YoA=;
  b=Q3n95l9OI422657rmeyxIPLVr+Mt8Jn787TSNqHw0uZs/UJ/21+IL4Y5
   HPawF32X4DR2iiCpEZEJGXQIpwtZfrbR5BNL1wWfvD5Vz9Ufhm7bPCM3V
   0WJzdhOSv8Hyxw2YBY55sXuthOjguEnwJBlbPKSoAn/lX8u2fgmYs2zur
   DR5kszV1TS5K7pTk9xyHn80kXcYLLuk6XJLc2i9G3SuKRC278E2JRt3Fb
   wu8pvk8hqyh9P/fQsVBlfb09oA0GLmZw+8121fAT2cMYD6HrG5ZhunUvd
   z3sTMbYUc02i30w7mQRPWqiyzwV3q5Opv3yk4VU+SiU7dIhGMbJZMhs+R
   A==;
X-CSE-ConnectionGUID: zY/UgWZ3QiibFQCPoUcoUw==
X-CSE-MsgGUID: LZILZBWUQFuMsxB3SsMZKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="61934766"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="61934766"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 03:07:22 -0700
X-CSE-ConnectionGUID: SBGf7iXUTO6Rnb2b/Ug6Jg==
X-CSE-MsgGUID: VqgQEwF9SlS28aAYKiDhBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="186727728"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2025 03:07:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9hMk-0005pb-0o;
	Fri, 17 Oct 2025 10:07:18 +0000
Date: Fri, 17 Oct 2025 18:06:31 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	lukas@wunner.de, helgaas@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RESEND 1/1] PCI: pciehp: fix concurrent sub-tree removal
 deadlock
Message-ID: <202510171720.AKF8sDMd-lkp@intel.com>
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
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251017/202510171720.AKF8sDMd-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171720.AKF8sDMd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171720.AKF8sDMd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/of.c:18:
>> drivers/pci/pci.h:653:2: error: call to undeclared function 'pci_notify_disconnected'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     653 |         pci_notify_disconnected();
         |         ^
   drivers/pci/pci.h:653:2: note: did you mean 'pci_doe_disconnected'?
   drivers/pci/pci.h:597:20: note: 'pci_doe_disconnected' declared here
     597 | static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
         |                    ^
   1 error generated.


vim +/pci_notify_disconnected +653 drivers/pci/pci.h

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

