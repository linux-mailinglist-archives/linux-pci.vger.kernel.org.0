Return-Path: <linux-pci+bounces-1961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF782926B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 03:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520391C23C45
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 02:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29717E4;
	Wed, 10 Jan 2024 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibjPgV2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C117C6;
	Wed, 10 Jan 2024 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704853510; x=1736389510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltAGm7e8WuTbTxkqpaXeFz6y+BS7M2LUElb1NNHFRHs=;
  b=ibjPgV2a51Ry1+kT6Je576uYDIUF3xY20s+1RpibWkjj0Mp5MNqVVtlO
   g7FqC8gTdC3bEhWtnnK7mN2sEZOy8KyTH3A4JlW+b7RMTe8wZYTNXmS5f
   HXwymilcJ4fwOwUQ7Z3fGM4mg7cKexPvxWfpNiChgwz2u6ZceqM64gLdy
   /QD9PVJDLlUMDBFjM400ztMX1cSxz3DPx8rAI1Ch5LkeSUrUBuiHLbe4K
   16pkoVQxXwhkcI3HGo8BMpU5tjJcb1ZCw/Ax4bFtjirJLlkRuCHwXaWa4
   9w0xLccdQLl0H0wav4uw7W/g43L74lp1CsNT0rcn+nq6/EeUKJKIzgwl9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="16975123"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="16975123"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 18:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="900971638"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="900971638"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2024 18:25:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNOH9-0006VE-0w;
	Wed, 10 Jan 2024 02:25:03 +0000
Date: Wed, 10 Jan 2024 10:24:45 +0800
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
Message-ID: <202401101015.Dch3YIjG-lkp@intel.com>
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
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240110/202401101015.Dch3YIjG-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401101015.Dch3YIjG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101015.Dch3YIjG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/of.c:271: warning: Function parameter or struct member 'node' not described in 'of_pci_check_preserve_boot_config'


vim +271 drivers/pci/of.c

   260	
   261	/**
   262	 * of_pci_check_preserve_boot_config - Return true if the boot configuration
   263	 *                                     needs to be preserved
   264	 *
   265	 * This function looks for a property called "preserve-boot-config" for a given
   266	 * PCIe controller's node and returns true if found. Having this property
   267	 * for a PCIe controller ensures that the kernel doesn't re-enumerate and
   268	 * reconfigure the BAR resources that are already done by the platform firmware.
   269	 */
   270	bool of_pci_check_preserve_boot_config(struct device_node *node)
 > 271	{
   272		return of_property_read_bool(node, "preserve-boot-config");
   273	}
   274	EXPORT_SYMBOL_GPL(of_pci_check_preserve_boot_config);
   275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

