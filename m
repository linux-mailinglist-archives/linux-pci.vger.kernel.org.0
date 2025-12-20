Return-Path: <linux-pci+bounces-43478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8800CD3368
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 17:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F263012253
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3630BF72;
	Sat, 20 Dec 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETw9kNCO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4830B52B;
	Sat, 20 Dec 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766247629; cv=none; b=d7W+OWEvepaOsJVCCw0081gZXSxPiy5K23Wgh5BVT2a1tFfwMTF5AOoyN9E2/U1IwOgCTNRl55YepJ1cFARHP+dSHnnUvjvM/Nt44gLnYqVYBeKpQH6P65lFcnNt1CveW0LSDHhV0xj/8vwT0fKd6uG67B2G4zrB5Nk0LPUmRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766247629; c=relaxed/simple;
	bh=AkCNBeKBmJ2h0eHVNB3huTHy6Wbbi9JvPBgHAckrReU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4ZHt+YLxfVSDbNNEdw8sd1VxWFB62j5hJPrMDXYUIzR1SZXDnq9dgZoPSFqtFy3bd8MQUXEzKwoxrmjqd4aLQEnT2Zw+5GhNe7m4eDT0oeM2932qlj49ZFbb+0Vxv3FxG3xbWfAv1B46vLPmidVqgDU5Oaf1cXcmOOMpW9uOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETw9kNCO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766247628; x=1797783628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AkCNBeKBmJ2h0eHVNB3huTHy6Wbbi9JvPBgHAckrReU=;
  b=ETw9kNCO60th2N43Q7N3GX+2yrAsJC/LrNzWyx2qeKguAQvxWpyvv/1u
   Pu+phvCB0DGwRb86GqtZMbilQGj28ywI32HYIt7O9lDUEiJUWZgaNQOeJ
   oPmLXKKlLO+zDSuMTxTZI5oi9k/elky8wYDM/g9PiZS0gz9Tthbsz3t9J
   EyaG5oKKdXCQy3VK8XyJ/sJr1U+IZkGPmjeGLW593KqmDsQFPiMO1mMPk
   RqFG74ZMSobgREP7An95w3DwIHYJJ16oj0kYXF+HYXgmWCci6+si4MEzV
   chUUBMb0pssd5k4RhKRJweWVBucpxEzhkpHSMHiMUpkmVzavhmI4bgiBF
   w==;
X-CSE-ConnectionGUID: ivSCMODCQme41LVjI07Y1A==
X-CSE-MsgGUID: iW7XKIl8TwWwIrkZbPTYvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="78814627"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="78814627"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 08:20:27 -0800
X-CSE-ConnectionGUID: U+BBSQEASKWxR5gQpLG5QA==
X-CSE-MsgGUID: VSFSAc1RR76AnfSdseLziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199167921"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Dec 2025 08:20:25 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWzgs-000000004rN-1RSw;
	Sat, 20 Dec 2025 16:20:22 +0000
Date: Sun, 21 Dec 2025 00:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: Ziming Du <duziming2@huawei.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisw@redhat.com,
	jbarnes@virtuousgeek.org, alex.williamson@redhat.com,
	liuyongqiang13@huawei.com, duziming2@huawei.com
Subject: Re: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on
 non-x86
Message-ID: <202512202328.VgDVWBKe-lkp@intel.com>
References: <20251216083912.758219-3-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216083912.758219-3-duziming2@huawei.com>

Hi Ziming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziming-Du/PCI-sysfs-fix-null-pointer-dereference-during-PCI-hotplug/20251216-163452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251216083912.758219-3-duziming2%40huawei.com
patch subject: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
config: s390-randconfig-002-20251217 (https://download.01.org/0day-ci/archive/20251220/202512202328.VgDVWBKe-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202328.VgDVWBKe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202328.VgDVWBKe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci-sysfs.c:1145:13: warning: 'is_unaligned' defined but not used [-Wunused-function]
    static bool is_unaligned(unsigned long port, size_t size)
                ^~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=y]
   Selected by [y]:
   - CAN [=y] && NET [=y]


vim +/is_unaligned +1145 drivers/pci/pci-sysfs.c

  1143	
  1144	#if !defined(CONFIG_X86)
> 1145	static bool is_unaligned(unsigned long port, size_t size)
  1146	{
  1147		return port & (size - 1);
  1148	}
  1149	#endif
  1150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

