Return-Path: <linux-pci+bounces-1955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F593828F68
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B9AB248B5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A523DB9D;
	Tue,  9 Jan 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANqiQGJ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DF3E462;
	Tue,  9 Jan 2024 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704837902; x=1736373902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDvoKVYVmehl2ViKsufWR9aJAI1u8ABei68fFx16HOw=;
  b=ANqiQGJ7nvJBipTbeJhyoWte05w0nCHGuFG5y2Qjes7+xDqUDzUJvr6m
   o6nehFr9VvqHS/1R7ijMZGdtUhcm59m9360UVJUF7ZnqljTh/VmlH+9HN
   iaZwcSq1BY/Ms7CcvNtTxuTcVoCpAzrVankkV3PXPR+nCPD56hc7ebSnT
   OZiXJGjSFTgvYKwpSXDydgHXfvwA7hBG2FyAdXuqAIVuarYpwKSFMADTC
   4iGP8TP1Z+/wq0fPwFP+UIVa3+UjcDf6YTFKuncADSAXBgWcMG83vyHPG
   9sqUvGccN5+6GTeDGggjFr3hJmtMaKX8Mnk0wPuCO+AZhfpw3ACRRSb9N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11822236"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="11822236"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 14:05:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="775002243"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="775002243"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2024 14:04:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNKDN-0006Ik-1v;
	Tue, 09 Jan 2024 22:04:53 +0000
Date: Wed, 10 Jan 2024 06:04:43 +0800
From: kernel test robot <lkp@intel.com>
To: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	will@kernel.org, frowand.list@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	vidyas@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 2/2] PCI: Add support for "preserve-boot-config"
 property
Message-ID: <202401100554.kaCFjM87-lkp@intel.com>
References: <20240109050648.1347255-3-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109050648.1347255-3-vidyas@nvidia.com>

Hi Vidya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.7 next-20240109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vidya-Sagar/dt-bindings-Add-PCIe-preserve-boot-config-property/20240109-130938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240109050648.1347255-3-vidyas%40nvidia.com
patch subject: [PATCH V1 2/2] PCI: Add support for "preserve-boot-config" property
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240110/202401100554.kaCFjM87-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100554.kaCFjM87-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100554.kaCFjM87-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/probe.c:11:
>> include/linux/of_pci.h:31:13: warning: 'of_pci_check_preserve_boot_config' defined but not used [-Wunused-function]
      31 | static bool of_pci_check_preserve_boot_config(struct device_node *node)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/of_pci_check_preserve_boot_config +31 include/linux/of_pci.h

    30	
  > 31	static bool of_pci_check_preserve_boot_config(struct device_node *node)
    32	{
    33		return false;
    34	}
    35	#endif
    36	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

