Return-Path: <linux-pci+bounces-18569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81AB9F3C70
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 22:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB191641F3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 21:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237681D5150;
	Mon, 16 Dec 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyaRZnnf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA251D4342
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383151; cv=none; b=HBMSHyRRSQFaoNu+XWyRuyM3n04xf0D0CrcOVVj1BVGlFThodVuWZ0mPp5SF5a1S9A+0VLhQqLhR/CD0bTIybQy+m/G9CxFezrP85dGoZgQ31QF+UX8OpNecsB4E4UKXOK15QLcpJH4VGDh1hJMwAi9FNWnNHFRd41hFm4XAKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383151; c=relaxed/simple;
	bh=5ruA/fM3L78iMPD6pDUO2Hh+Hw86GR3xyBSYIE59vrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa90Z49H4EwpM6aqoBuCPocXTzEIV9O3J4jfOgeZY4yWDtsEQvDufV4nbvoBu3dJh61hXVC/bI7BIUSBOJVDEOkeKICr72wp9FcB5HzhVJHW2We6Txhbj3c4v7bYIeOjt1I7g+EQvsp32Jf94s1OPHDe/wUMRrLz5C2z+BVIChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyaRZnnf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734383149; x=1765919149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ruA/fM3L78iMPD6pDUO2Hh+Hw86GR3xyBSYIE59vrc=;
  b=ZyaRZnnfE2RumI0g3FT2LJp6BVO2T9JdMJZS3ghFMo0Y8hAIPqlvMnwx
   kXAfiwIJHM6CVZukxrU+XLU5jKKqBukdylcMLu2dEFP9/bUA8ANmt/eZ5
   KwB111uVmkYTq0BTHmlEqlZfBoHPS6j2eN80itBpRxKETpPbUt9sGO7KH
   fmfl81vS+SF5lLqCh77S1N/d/sqzZAWoX5rwYi9prvjzhto0IqJ6XYS5T
   voal95MQtYw0+14iCW2ndK227KK8URSekgRXGuU6TbXo8MosLhdcHhE6m
   7HUtNtVXO8/AOHXbndEwUdWbEnHtWZvF842M2t05AcESMjdo0RRgcCGTR
   w==;
X-CSE-ConnectionGUID: Rl8Df0c9S66VyvrZ7D3h3w==
X-CSE-MsgGUID: Bd/IpTrTRKyBPlLT5z18Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="46198981"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="46198981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 13:05:48 -0800
X-CSE-ConnectionGUID: n+dVGZE8SHSBjPQs7IPDvA==
X-CSE-MsgGUID: DhWqMBeJROCKcJmBl25rQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="102346360"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Dec 2024 13:05:45 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNIHe-000ETS-2L;
	Mon, 16 Dec 2024 21:05:42 +0000
Date: Tue, 17 Dec 2024 05:05:20 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
Message-ID: <202412170432.ZuybGalF-lkp@intel.com>
References: <20241210093408.105867-17-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-17-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.13-rc3 next-20241216]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvmet-Add-vendor_id-and-subsys_vendor_id-subsystem-attributes/20241210-174321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241210093408.105867-17-dlemoal%40kernel.org
patch subject: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
config: i386-randconfig-003-20241217 (https://download.01.org/0day-ci/archive/20241217/202412170432.ZuybGalF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241217/202412170432.ZuybGalF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412170432.ZuybGalF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_iod_name':
   drivers/nvme/target/pci-ep.c:658:16: error: implicit declaration of function 'nvme_opcode_str'; did you mean 'nvme_opcode_name'? [-Werror=implicit-function-declaration]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~
         |                nvme_opcode_name
>> drivers/nvme/target/pci-ep.c:658:16: warning: returning 'int' from a function with return type 'const char *' makes pointer from integer without a cast [-Wint-conversion]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:7,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from arch/x86/include/asm/div64.h:8,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:12,
                    from drivers/nvme/target/pci-ep.c:10:
   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_enable_ctrl':
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1842:26: note: in expansion of macro 'GENMASK'
    1842 |         pci_addr = acq & GENMASK(63, 12);
         |                          ^~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1852:26: note: in expansion of macro 'GENMASK'
    1852 |         pci_addr = asq & GENMASK(63, 12);
         |                          ^~~~~~~
   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_init_bar':
>> include/uapi/linux/bits.h:8:31: warning: left shift count >= width of type [-Wshift-count-overflow]
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1949:23: note: in expansion of macro 'GENMASK'
    1949 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1949:23: note: in expansion of macro 'GENMASK'
    1949 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~
   cc1: some warnings being treated as errors


vim +658 drivers/nvme/target/pci-ep.c

   655	
   656	static inline const char *nvmet_pciep_iod_name(struct nvmet_pciep_iod *iod)
   657	{
 > 658		return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
   659	}
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

