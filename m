Return-Path: <linux-pci+bounces-35316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1536B3FC50
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196C316878D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A8283689;
	Tue,  2 Sep 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kB9mGtfc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A831280CCE;
	Tue,  2 Sep 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808654; cv=none; b=S2igG0DtqgN39RXhj1KKTPLmSr+LamOIEzVFGyPZx5SS+Ws6JLw7SFATuoaFWC1nwqeSXS0FSDvkPRyNLJugyiJVAReQ9v1Hx8LodQu5Sr8mz+h2kSs6KXiNNetZVwR0UBsHf672iIqw98OSsOZ8Kh2kOfktDzL+2CvkN/BOozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808654; c=relaxed/simple;
	bh=v5NDjFO8lUrsXYBoNk20x/0jTMsSJewfLyzSWN2NvCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvv88kFlhyubbDwm4bw5uzwXb5xQpufioAoBaMqU9x4x+c3hO4HyAPcbfvJSD8QNoghj7YDyQgcy2nsSd39AkoC/Ig5h5MhI/m05qiNInHjimOtUxARwWihq+ctVpTMv3cWcOm+rN5jnHHzGIgipKpmFAETyliNPsVuQtF3PE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kB9mGtfc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756808653; x=1788344653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v5NDjFO8lUrsXYBoNk20x/0jTMsSJewfLyzSWN2NvCQ=;
  b=kB9mGtfcuA0QRGswH0l8MKRJysn3eD5noDeyI/wAzG86Y4zWE3tYwKvm
   725NxrVwV7mLuKTNwcDh7kap5+IMVyRet/MAIL429UCLFP30H1d3BV0xI
   r6h1D/XxqOY5EjWawVd0iFhN/dX7qZa8x6i0xic8Gh+dodxWXegOplvBK
   BsYWaNOIJnzEby7NQQvIDEOId21CaGiU8sQ2YjHh2ty9khkf27NvKGrOF
   0p/JcOvgt3E5JVIZmZZYTQILslfHp4zYnjCJ1qhqKd3e7Jshl9A+qj3V0
   1WDkdk1vbOFGO3lBdlTz0Zxoeu+0h2GQJESmD0ixsrJ+umZG2IUcBj4vt
   w==;
X-CSE-ConnectionGUID: mhFdhiLGQx2Tgqo/8RcBqw==
X-CSE-MsgGUID: dLNMD7Y/RnKqDfNwY72UjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="62719596"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="62719596"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:24:12 -0700
X-CSE-ConnectionGUID: I6HlhqjdSHGTNm9QxC555Q==
X-CSE-MsgGUID: qaZkQZ/4QvmaUvY93+nUTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176556266"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2025 03:24:06 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utOBI-0001pP-0p;
	Tue, 02 Sep 2025 10:24:04 +0000
Date: Tue, 2 Sep 2025 18:23:07 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	vkoul@kernel.org, kishon@kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jacky_chou@aspeedtech.com
Subject: Re: [PATCH v3 07/10] PHY: aspeed: Add ASPEED PCIe PHY driver
Message-ID: <202509021806.1NtrcLpF-lkp@intel.com>
References: <20250901055922.1553550-8-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901055922.1553550-8-jacky_chou@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on robh/for-next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.17-rc4 next-20250902]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-soc-aspeed-Add-ASPEED-PCIe-Config/20250901-140231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20250901055922.1553550-8-jacky_chou%40aspeedtech.com
patch subject: [PATCH v3 07/10] PHY: aspeed: Add ASPEED PCIe PHY driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20250902/202509021806.1NtrcLpF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250902/202509021806.1NtrcLpF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509021806.1NtrcLpF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/phy/aspeed/phy-aspeed-pcie.c:14:
>> drivers/phy/aspeed/phy-aspeed-pcie.c:195:25: error: 'aspeed_pcie_of_match_table' undeclared here (not in a function); did you mean 'aspeed_pcie_phy_of_match_table'?
     195 | MODULE_DEVICE_TABLE(of, aspeed_pcie_of_match_table);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:250:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     250 | static typeof(name) __mod_device_table__##type##__##name                \
         |               ^~~~
>> include/linux/module.h:250:21: error: '__mod_device_table__of__aspeed_pcie_of_match_table' aliased to undefined symbol 'aspeed_pcie_of_match_table'
     250 | static typeof(name) __mod_device_table__##type##__##name                \
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/aspeed/phy-aspeed-pcie.c:195:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     195 | MODULE_DEVICE_TABLE(of, aspeed_pcie_of_match_table);
         | ^~~~~~~~~~~~~~~~~~~
--
   In file included from phy-aspeed-pcie.c:14:
   phy-aspeed-pcie.c:195:25: error: 'aspeed_pcie_of_match_table' undeclared here (not in a function); did you mean 'aspeed_pcie_phy_of_match_table'?
     195 | MODULE_DEVICE_TABLE(of, aspeed_pcie_of_match_table);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:250:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     250 | static typeof(name) __mod_device_table__##type##__##name                \
         |               ^~~~
>> include/linux/module.h:250:21: error: '__mod_device_table__of__aspeed_pcie_of_match_table' aliased to undefined symbol 'aspeed_pcie_of_match_table'
     250 | static typeof(name) __mod_device_table__##type##__##name                \
         |                     ^~~~~~~~~~~~~~~~~~~~
   phy-aspeed-pcie.c:195:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     195 | MODULE_DEVICE_TABLE(of, aspeed_pcie_of_match_table);
         | ^~~~~~~~~~~~~~~~~~~


vim +195 drivers/phy/aspeed/phy-aspeed-pcie.c

   183	
   184	static const struct of_device_id aspeed_pcie_phy_of_match_table[] = {
   185		{
   186			.compatible = "aspeed,ast2600-pcie-phy",
   187			.data = &pcie_phy_ast2600,
   188		},
   189		{
   190			.compatible = "aspeed,ast2700-pcie-phy",
   191			.data = &pcie_phy_ast2700,
   192		},
   193		{ },
   194	};
 > 195	MODULE_DEVICE_TABLE(of, aspeed_pcie_of_match_table);
   196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

