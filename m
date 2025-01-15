Return-Path: <linux-pci+bounces-19833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7739A11AC8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F541884030
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E701DB120;
	Wed, 15 Jan 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fl2MVeVf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A91DB122
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925571; cv=none; b=rDmZhzSE4n80vWZW88kUPNrJwv+D5qDlD4zjk8LQ90K98YmYF7/FvDvNxvxHVrJ7fcHnb3NWB0O3XEzwCdeQWxsJDQzU0bKWyuxJ2mo8/e5rq5eK59wpKuf7mx4nBB4+uRLKMuFoz7e6g/UFNLFmi18Jb3+XFTn7OmsNdbpCElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925571; c=relaxed/simple;
	bh=UHe/g86zthLtQC9Eh5hjxn8R7mETXyQ3Q4h25AXX6ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tEyGbp0xk7RABA+UzUN6g/2I1zM/PSH1UYvOoDgYdmZLMfu65YOXjz62DXBgY3t75F82uQdk5oTlnLn3lFIQlRQD37wUUY3HERVOwzYmpIryzcpfjyM3kP1cTY2s+2GrQ2bhv27mkjesL+EfirRtVrphG3ZmS4ArOA2DxC3pdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fl2MVeVf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736925569; x=1768461569;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UHe/g86zthLtQC9Eh5hjxn8R7mETXyQ3Q4h25AXX6ZU=;
  b=fl2MVeVfb25/HjIwdiHKxcmc4fo899T4R4+4NK/gYq4SmygBExEh70vT
   m9IvPlGJ0BGH8oQ2d9ERxsiOHQKjauWtwV8bki+yfFtxcF1LPYVRIMoJ/
   tlSx/QTK7oC09I0nE1A2UXzosxhfvopRmunRbTKSPyjwOQJTjGcujdlRr
   vo3zP7u5nai7nK2vrH2vJYR0G++Yrs2CkeobjlalsqXGOeW3/+y7Wq/k9
   wwa9RBdXtF4Pt73C3nbOyGzqjMWJ+teVOXfh9OHLqWW9pxsbQwwdNKnFx
   LBA2AmWK3ZvRoOW7ydgw/fVGb3mQH8wIuR/leYF2JIdKo8ZvnU+84gELP
   A==;
X-CSE-ConnectionGUID: 7c7eOaKpTg+c3EWjH2j1sw==
X-CSE-MsgGUID: JW3+oSdETSi0Y9M9pXFzIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40928228"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="40928228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 23:19:29 -0800
X-CSE-ConnectionGUID: tCEK3wvIRZqoXdOV+0nJaw==
X-CSE-MsgGUID: Cg2NgwzaQ8CicIp04R02KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110036015"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Jan 2025 23:19:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXxgR-000PcR-32;
	Wed, 15 Jan 2025 07:19:23 +0000
Date: Wed, 15 Jan 2025 15:19:09 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:controller/imx6 2/2]
 drivers/pci/controller/dwc/pci-imx6.c:1116:11: warning: variable 'sid' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202501151501.d4MgHDRq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
head:   bc92494deb1c40f7336ca645c3815f19a5d0e2af
commit: d02f7572cb39c962d0e432f57a267a844d164b4f [2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250115/202501151501.d4MgHDRq-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250115/202501151501.d4MgHDRq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501151501.d4MgHDRq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pci-imx6.c:19:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2223:
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
>> drivers/pci/controller/dwc/pci-imx6.c:1116:11: warning: variable 'sid' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1116 |         else if (!err_m)
         |                  ^~~~~~
   drivers/pci/controller/dwc/pci-imx6.c:1119:41: note: uninitialized use occurs here
    1119 |         return imx_pcie_add_lut(imx_pcie, rid, sid);
         |                                                ^~~
   drivers/pci/controller/dwc/pci-imx6.c:1116:7: note: remove the 'if' if its condition is always true
    1116 |         else if (!err_m)
         |              ^~~~~~~~~~~
    1117 |                 sid = sid_m & IMX95_SID_MASK;
   drivers/pci/controller/dwc/pci-imx6.c:1044:9: note: initialize the variable 'sid' to silence this warning
    1044 |         u32 sid;
         |                ^
         |                 = 0
   5 warnings generated.


vim +1116 drivers/pci/controller/dwc/pci-imx6.c

  1035	
  1036	static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
  1037					  struct pci_dev *pdev)
  1038	{
  1039		struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
  1040		u32 sid_i, sid_m, rid = pci_dev_id(pdev);
  1041		struct device_node *target;
  1042		struct device *dev;
  1043		int err_i, err_m;
  1044		u32 sid;
  1045	
  1046		dev = imx_pcie->pci->dev;
  1047	
  1048		target = NULL;
  1049		err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
  1050				  &target, &sid_i);
  1051		if (target) {
  1052			of_node_put(target);
  1053		} else {
  1054			/*
  1055			 * "target == NULL && err_i == 0" means RID out of map range.
  1056			 * Use 1:1 map RID to streamID. Hardware can't support this
  1057			 * because the streamID is only 6 bits
  1058			 */
  1059			err_i = -EINVAL;
  1060		}
  1061	
  1062		target = NULL;
  1063		err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
  1064				  &target, &sid_m);
  1065	
  1066		/*
  1067		 *   err_m      target
  1068		 *	0	NULL		RID out of range. Use 1:1 map RID to
  1069		 *				streamID, Current hardware can't
  1070		 *				support it, so return -EINVAL.
  1071		 *      != 0    NULL		msi-map does not exist, use built-in MSI
  1072		 *	0	!= NULL		Get correct streamID from RID
  1073		 *	!= 0	!= NULL		Invalid combination
  1074		 */
  1075		if (!err_m && !target)
  1076			return -EINVAL;
  1077		else if (target)
  1078			of_node_put(target); /* Find streamID map entry for RID in msi-map */
  1079	
  1080		/*
  1081		 * msi-map        iommu-map
  1082		 *   N                N            DWC MSI Ctrl
  1083		 *   Y                Y            ITS + SMMU, require the same SID
  1084		 *   Y                N            ITS
  1085		 *   N                Y            DWC MSI Ctrl + SMMU
  1086		 */
  1087		if (err_i && err_m)
  1088			return 0;
  1089	
  1090		if (!err_i && !err_m) {
  1091			/*
  1092			 *	    Glue Layer
  1093			 *          <==========>
  1094			 * ┌─────┐                  ┌──────────┐
  1095			 * │ LUT │ 6-bit streamID   │          │
  1096			 * │     │─────────────────►│  MSI     │
  1097			 * └─────┘   2-bit ctrl ID  │          │
  1098			 *             ┌───────────►│          │
  1099			 *  (i.MX95)   │            │          │
  1100			 *  00 PCIe0   │            │          │
  1101			 *  01 ENETC   │            │          │
  1102			 *  10 PCIe1   │            │          │
  1103			 *             │            └──────────┘
  1104			 * The MSI glue layer auto adds 2 bits controller ID ahead of
  1105			 * streamID, so mask these 2 bits to get streamID. The
  1106			 * IOMMU glue layer doesn't do that.
  1107			 */
  1108			if (sid_i != (sid_m & IMX95_SID_MASK)) {
  1109				dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
  1110				return -EINVAL;
  1111			}
  1112		}
  1113	
  1114		if (!err_i)
  1115			sid = sid_i;
> 1116		else if (!err_m)
  1117			sid = sid_m & IMX95_SID_MASK;
  1118	
  1119		return imx_pcie_add_lut(imx_pcie, rid, sid);
  1120	}
  1121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

