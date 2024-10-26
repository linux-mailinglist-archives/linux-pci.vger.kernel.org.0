Return-Path: <linux-pci+bounces-15383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D665E9B1406
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 03:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43951C214C6
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 01:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26E828E0F;
	Sat, 26 Oct 2024 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wq7WzRrR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32944B665;
	Sat, 26 Oct 2024 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729906489; cv=none; b=h3NViOV2PfXhRuwlkSNRyd8R/ACDrRDVN5QKgCnqE8XX9ZpflVE6X0HrBUYKWORZIg+0b5Ik7P567nEhWKtybYOrwrO5LK9KXsR0GtLSCOmU8hWpkZJpLaL3pbYunZAtUd3Zj9/BnE2vAn3utgSyfJ5WWtr7pWudz1GLNP5G13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729906489; c=relaxed/simple;
	bh=AvdnhwNRiXKf7G4bRAt5xJWxJrdRaqp5+mhlW0iRbJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNbIf4HP2RchtvP6YmDJn1SVKYYRVZcTCNaP1bcXenvpEgJYZFEi+vzmP4VHurnQ9b9hxOu7iT39DkuC7wde5HmNMTD/SlXs2ixwFh1hTbLSJxKhaemezKJnvjBSA/pMO9XeRpa5qVAX5vyVwL4oBmUQFcOMP0yVfaV/1h1Etjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wq7WzRrR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729906487; x=1761442487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AvdnhwNRiXKf7G4bRAt5xJWxJrdRaqp5+mhlW0iRbJo=;
  b=Wq7WzRrRZOXME271vy48jIpUUW/IrhcI+rjbnGTGmnm4NnBJhZYkZCum
   1RZlAGvZRCFn3MeLh9wjPWFXPQjSp9sQQXLHMmLOaxSGSkoBd/qyAD08a
   fNnuwq0UTbDwimFLlCvk/16xXnbjd9ZLu6/BeARopus98t53DuBd6rO0R
   TKAakvo319Hl6i6Qnvx5Mj8bcDEuk+LHaseyXhsoBcWaQq1do9rTe1AI6
   AZtG0NjtbACdFlA84UVhq36pq7r2Mv67cs8UGsNWalUaNJekNEWmEt6OC
   d0nnNRJZGbdynOAx9+auYYA0ID7sou98NZIhW/cqtj/RF0l80WJcnWVmd
   Q==;
X-CSE-ConnectionGUID: FaefWCtwROqymHOsvIrMDQ==
X-CSE-MsgGUID: OjnkeOHSShGIQxvQ0UYmHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29536586"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29536586"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 18:34:46 -0700
X-CSE-ConnectionGUID: 70ikL1t/Sde4q68jIS/rvg==
X-CSE-MsgGUID: SbfZrTSgSn69iYeE81rvuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="111925452"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Oct 2024 18:34:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4VhO-000Z8C-1i;
	Sat, 26 Oct 2024 01:34:38 +0000
Date: Sat, 26 Oct 2024 09:34:36 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 05/13] net: enetc: extract common ENETC PF
 parts for LS1028A and i.MX95 platforms
Message-ID: <202410260911.fvWnX8cx-lkp@intel.com>
References: <20241024065328.521518-6-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-6-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-net-add-compatible-string-for-i-MX95-EMDIO/20241024-151502
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241024065328.521518-6-wei.fang%40nxp.com
patch subject: [PATCH v5 net-next 05/13] net: enetc: extract common ENETC PF parts for LS1028A and i.MX95 platforms
config: x86_64-buildonly-randconfig-001-20241026 (https://download.01.org/0day-ci/archive/20241026/202410260911.fvWnX8cx-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260911.fvWnX8cx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260911.fvWnX8cx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/freescale/enetc/enetc_pf.c:7:
   In file included from include/linux/of_net.h:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/freescale/enetc/enetc_pf.c:906:14: error: call to undeclared function 'of_find_compatible_node'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     906 |         ierb_node = of_find_compatible_node(NULL, NULL,
         |                     ^
>> drivers/net/ethernet/freescale/enetc/enetc_pf.c:906:12: error: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
     906 |         ierb_node = of_find_compatible_node(NULL, NULL,
         |                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     907 |                                             "fsl,ls1028a-enetc-ierb");
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/enetc/enetc_pf.c:908:21: error: call to undeclared function 'of_device_is_available'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     908 |         if (!ierb_node || !of_device_is_available(ierb_node))
         |                            ^
>> drivers/net/ethernet/freescale/enetc/enetc_pf.c:912:2: error: call to undeclared function 'of_node_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     912 |         of_node_put(ierb_node);
         |         ^
   drivers/net/ethernet/freescale/enetc/enetc_pf.c:1115:14: error: call to undeclared function 'of_device_is_available'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1115 |         if (node && of_device_is_available(node))
         |                     ^
   1 warning and 5 errors generated.


vim +/of_find_compatible_node +906 drivers/net/ethernet/freescale/enetc/enetc_pf.c

07bf34a50e3279 Vladimir Oltean 2021-02-04  900  
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  901  static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  902  {
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  903  	struct platform_device *ierb_pdev;
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  904  	struct device_node *ierb_node;
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  905  
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17 @906  	ierb_node = of_find_compatible_node(NULL, NULL,
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  907  					    "fsl,ls1028a-enetc-ierb");
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17 @908  	if (!ierb_node || !of_device_is_available(ierb_node))
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  909  		return -ENODEV;
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  910  
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  911  	ierb_pdev = of_find_device_by_node(ierb_node);
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17 @912  	of_node_put(ierb_node);
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  913  
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  914  	if (!ierb_pdev)
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  915  		return -EPROBE_DEFER;
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  916  
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  917  	return enetc_ierb_register_pf(ierb_pdev, pdev);
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  918  }
e7d48e5fbf30f8 Vladimir Oltean 2021-04-17  919  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

