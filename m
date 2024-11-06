Return-Path: <linux-pci+bounces-16166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F39BF7E8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 21:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139FE1F22A74
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926120C003;
	Wed,  6 Nov 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpdJc/FI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E820C30F
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924380; cv=none; b=LoG31utZJlGwu4fP4MEEffTinZEcDJLQVwAYpINgmniaNjYD+UQKYAEPuAP6ZAddcQG76C1cPDGlnHnfvMQgk121RTyCIVjvpD/yPTHwq+Rjnqu+kNtPFlVfglc+8B+ik8iYn38vX3/mv9UJU1+bvkKrxJSgwkKRyAcysE9X7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924380; c=relaxed/simple;
	bh=CSFZ2m/b0MOo6ENGPqjNjXfmcckm6HSnDWpJlQMs5V4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=guwD52cfrxXNmJRFj7VfaGtVdlZJuVec1yk6giSppFAq+PfQFcAPRxCtDJzkAQj8TAmPQeid/kKZ3o+JyIP6TfltnOmcPFeP3gxG7FeIsynEdpbJqH7tNbMjy2LmSlLEV8Ge5TpiwmUuFWw39Dx+Wc+585sPCVxi+enRKyqTASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpdJc/FI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730924378; x=1762460378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CSFZ2m/b0MOo6ENGPqjNjXfmcckm6HSnDWpJlQMs5V4=;
  b=IpdJc/FI3X6OoN1eEQZ8ljlXzVqklmf7Eii9dm1ZCYpk0aiYBTGPIeyn
   rE6NVnqu9hnYNB7BLplvSVqpxxGY7BZLLD9p2+Leg04zqYjymaqGC4LGD
   1PytQvGYGzWaTP2eefynOcPSKfZ+QnN5fuR948aCLZO8MaIuMTJrH7ych
   YRL6D7dqNKgwz44OtXCi9i14K15IUPXanCnMgazB7bkYPiN9cyJkgScTr
   fm1JuZ7zyI8sYp/w5EM8POa6KC+JZG2anBmwTUaRHN4aD8AbbQC2RxR/R
   xhTvO0K2wWpjtBioL3PkE5MutWCN2cWJBmNXDu56bEsOm99s7fSs71bxp
   Q==;
X-CSE-ConnectionGUID: S4vHBGMRSR2IT9J9F/lIaA==
X-CSE-MsgGUID: Wjj0/tQySjWh2wP76vGDsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="48261012"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="48261012"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 12:19:37 -0800
X-CSE-ConnectionGUID: laEV/4gDS5CaWD/MjBnYiQ==
X-CSE-MsgGUID: 1+lQ5Vd/RgGZqZmazKidfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="88715100"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2024 12:19:35 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8mV3-000pOG-0r;
	Wed, 06 Nov 2024 20:19:33 +0000
Date: Thu, 7 Nov 2024 04:19:10 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Fei Shao <fshao@chromium.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [pci:controller/mediatek 2/2]
 drivers/pci/controller/pcie-mediatek-gen3.c:898:14: error: call to
 undeclared function 'of_property_read_u31'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202411070452.OBJPnFbT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
head:   2bee4c1a6fc0408242aedca80a102ef50c0dfbe5
commit: 2bee4c1a6fc0408242aedca80a102ef50c0dfbe5 [2/2] PCI: mediatek-gen3: Add support for restricting link width
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241107/202411070452.OBJPnFbT-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070452.OBJPnFbT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070452.OBJPnFbT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/pcie-mediatek-gen3.c:22:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-mediatek-gen3.c:898:14: error: call to undeclared function 'of_property_read_u31'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     898 |        ret = of_property_read_u31(dev->of_node, "num-lanes", &num_lanes);
         |              ^
   drivers/pci/controller/pcie-mediatek-gen3.c:898:14: note: did you mean 'of_property_read_u32'?
   include/linux/of.h:1412:19: note: 'of_property_read_u32' declared here
    1412 | static inline int of_property_read_u32(const struct device_node *np,
         |                   ^
   4 warnings and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +/of_property_read_u31 +898 drivers/pci/controller/pcie-mediatek-gen3.c

   845	
   846	static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
   847	{
   848		int i, ret, num_resets = pcie->soc->phy_resets.num_resets;
   849		struct device *dev = pcie->dev;
   850		struct platform_device *pdev = to_platform_device(dev);
   851		struct resource *regs;
   852		u32 num_lanes;
   853	
   854		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
   855		if (!regs)
   856			return -EINVAL;
   857		pcie->base = devm_ioremap_resource(dev, regs);
   858		if (IS_ERR(pcie->base)) {
   859			dev_err(dev, "failed to map register base\n");
   860			return PTR_ERR(pcie->base);
   861		}
   862	
   863		pcie->reg_base = regs->start;
   864	
   865		for (i = 0; i < num_resets; i++)
   866			pcie->phy_resets[i].id = pcie->soc->phy_resets.id[i];
   867	
   868		ret = devm_reset_control_bulk_get_optional_shared(dev, num_resets, pcie->phy_resets);
   869		if (ret) {
   870			dev_err(dev, "failed to get PHY bulk reset\n");
   871			return ret;
   872		}
   873	
   874		pcie->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
   875		if (IS_ERR(pcie->mac_reset)) {
   876			ret = PTR_ERR(pcie->mac_reset);
   877			if (ret != -EPROBE_DEFER)
   878				dev_err(dev, "failed to get MAC reset\n");
   879	
   880			return ret;
   881		}
   882	
   883		pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
   884		if (IS_ERR(pcie->phy)) {
   885			ret = PTR_ERR(pcie->phy);
   886			if (ret != -EPROBE_DEFER)
   887				dev_err(dev, "failed to get PHY\n");
   888	
   889			return ret;
   890		}
   891	
   892		pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
   893		if (pcie->num_clks < 0) {
   894			dev_err(dev, "failed to get clocks\n");
   895			return pcie->num_clks;
   896		}
   897	
 > 898	       ret = of_property_read_u31(dev->of_node, "num-lanes", &num_lanes);
   899	       if (ret == 0) {
   900		       if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
   901				dev_warn(dev, "invalid num-lanes, using controller defaults\n");
   902		       else
   903				pcie->num_lanes = num_lanes;
   904	       }
   905	
   906		return 0;
   907	}
   908	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

