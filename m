Return-Path: <linux-pci+bounces-19890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA0A1238E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F3F188ADB0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08FD2475C9;
	Wed, 15 Jan 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVBOXtLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D32475F9
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942998; cv=none; b=DC4em4Kdh7zuCTWGEZdu3dFmvCajHZnmkTg71JavpTcF5BkiLUlnbiCQl+0XtVB66vtKsWqxOJGvXH51rIF762ubRUB72XSnLspeHTipZIUALgh7F73WZ6/hQFzOnxO28mah0MJRqtdJ12fDNrMMY4PQun/owGL0lSw4XewV0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942998; c=relaxed/simple;
	bh=LXXGZ0cQj15hypa+sI8RXnIU4kaFiSj/FTjV/MDGXr4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pP4nQI8/VKHYRFzfmADv3bYYW9eWoItX3tzABHI3FgPK8Bk2cP8MFLFBRQIerKbKn7nYgAkjWlglpevU4vZGH4JZHmqpGMKk1UO1w+b3+8Dm0KlPmpVU4nJ4aL6BmFPOd2y7XUzb6/VqQ0trPTY8aoOgq27alfRXQkQDplthJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVBOXtLE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736942997; x=1768478997;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LXXGZ0cQj15hypa+sI8RXnIU4kaFiSj/FTjV/MDGXr4=;
  b=XVBOXtLEL2c1B+/Gu49KVWvQ74BxJhZHbr1pCKsHYE5MZgwZtm4tPE8q
   tRi+E1NV0OZlU17FRS6nfoKk527+84nHLQdJLo4l4Ly8zt+bs6CiBNKxS
   DJCKQc0HfG3mq4DupC/a7UJYcnwFKHpsmj8gJXN0MAaabKCbSTLo1LjWA
   F8CPBwJxXmp1j0tpYbyFqvamwVIklThkS/MVpJk0CP5kktht53k4+iLx4
   pbusLwT6YqR2Q6qfdoaGgg1tNArXLZYP0N1qofpJCyqBn6GJ0uDzURmxC
   YalJcNZ0vUbAxjYgHYbLQuyB++ZGY9GPz9/PJwSfAUR0hmrjP6g8mfUj5
   g==;
X-CSE-ConnectionGUID: 7LBFTHTZTwuL1yAGW1NFhg==
X-CSE-MsgGUID: uV/X9j67QkSzmKZJ2SWDFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36969294"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="36969294"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 04:09:56 -0800
X-CSE-ConnectionGUID: Gt+mNmOhSfSqtAfedispIQ==
X-CSE-MsgGUID: B5Hc8A6iQGWA6d/y7iVAlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110253286"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Jan 2025 04:09:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tY2DX-000QJj-19;
	Wed, 15 Jan 2025 12:09:51 +0000
Date: Wed, 15 Jan 2025 20:09:32 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [pci:next 15/20] drivers/pci/controller/dwc/pci-imx6.c:1224:35:
 error: use of undeclared identifier 'IMX_PCIE_FLAG_CPU_ADDR_FIXUP'
Message-ID: <202501151913.zNl1cXD5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
head:   19501c8805572d695bc694a761b3e61f0aa32ae4
commit: 7a6f84fed4abbee48ea03897340040dfced9ceee [15/20] Merge branch 'controller/imx6'
config: arm-randconfig-002-20250115 (https://download.01.org/0day-ci/archive/20250115/202501151913.zNl1cXD5-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f5cd181ffbb7cb61d582fe130d46580d5969d47a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250115/202501151913.zNl1cXD5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501151913.zNl1cXD5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pci-imx6.c:22:
   In file included from include/linux/pci.h:1647:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/pci/controller/dwc/pci-imx6.c:1109:11: warning: variable 'sid' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1109 |         else if (!err_m)
         |                  ^~~~~~
   drivers/pci/controller/dwc/pci-imx6.c:1112:41: note: uninitialized use occurs here
    1112 |         return imx_pcie_add_lut(imx_pcie, rid, sid);
         |                                                ^~~
   drivers/pci/controller/dwc/pci-imx6.c:1109:7: note: remove the 'if' if its condition is always true
    1109 |         else if (!err_m)
         |              ^~~~~~~~~~~
    1110 |                 sid = sid_m & IMX95_SID_MASK;
   drivers/pci/controller/dwc/pci-imx6.c:1037:9: note: initialize the variable 'sid' to silence this warning
    1037 |         u32 sid;
         |                ^
         |                 = 0
>> drivers/pci/controller/dwc/pci-imx6.c:1224:35: error: use of undeclared identifier 'IMX_PCIE_FLAG_CPU_ADDR_FIXUP'
    1224 |         if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
         |                                          ^
   drivers/pci/controller/dwc/pci-imx6.c:1360:34: warning: shift count >= width of type [-Wshift-count-overflow]
    1360 |                 dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
         |                                                ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   drivers/pci/controller/dwc/pci-imx6.c:1790:5: error: use of undeclared identifier 'IMX_PCIE_FLAG_CPU_ADDR_FIXUP'
    1790 |                          IMX_PCIE_FLAG_CPU_ADDR_FIXUP |
         |                          ^
   3 warnings and 2 errors generated.


vim +/IMX_PCIE_FLAG_CPU_ADDR_FIXUP +1224 drivers/pci/controller/dwc/pci-imx6.c

bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1028  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1029  static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1030  				  struct pci_dev *pdev)
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1031  {
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1032  	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1033  	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1034  	struct device_node *target;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1035  	struct device *dev;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1036  	int err_i, err_m;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1037  	u32 sid;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1038  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1039  	dev = imx_pcie->pci->dev;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1040  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1041  	target = NULL;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1042  	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1043  			  &target, &sid_i);
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1044  	if (target) {
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1045  		of_node_put(target);
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1046  	} else {
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1047  		/*
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1048  		 * "target == NULL && err_i == 0" means RID out of map range.
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1049  		 * Use 1:1 map RID to streamID. Hardware can't support this
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1050  		 * because the streamID is only 6 bits
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1051  		 */
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1052  		err_i = -EINVAL;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1053  	}
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1054  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1055  	target = NULL;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1056  	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1057  			  &target, &sid_m);
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1058  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1059  	/*
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1060  	 *   err_m      target
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1061  	 *	0	NULL		RID out of range. Use 1:1 map RID to
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1062  	 *				streamID, Current hardware can't
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1063  	 *				support it, so return -EINVAL.
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1064  	 *      != 0    NULL		msi-map does not exist, use built-in MSI
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1065  	 *	0	!= NULL		Get correct streamID from RID
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1066  	 *	!= 0	!= NULL		Invalid combination
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1067  	 */
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1068  	if (!err_m && !target)
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1069  		return -EINVAL;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1070  	else if (target)
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1071  		of_node_put(target); /* Find streamID map entry for RID in msi-map */
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1072  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1073  	/*
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1074  	 * msi-map        iommu-map
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1075  	 *   N                N            DWC MSI Ctrl
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1076  	 *   Y                Y            ITS + SMMU, require the same SID
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1077  	 *   Y                N            ITS
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1078  	 *   N                Y            DWC MSI Ctrl + SMMU
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1079  	 */
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1080  	if (err_i && err_m)
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1081  		return 0;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1082  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1083  	if (!err_i && !err_m) {
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1084  		/*
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1085  		 *	    Glue Layer
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1086  		 *          <==========>
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1087  		 * ┌─────┐                  ┌──────────┐
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1088  		 * │ LUT │ 6-bit streamID   │          │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1089  		 * │     │─────────────────►│  MSI     │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1090  		 * └─────┘   2-bit ctrl ID  │          │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1091  		 *             ┌───────────►│          │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1092  		 *  (i.MX95)   │            │          │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1093  		 *  00 PCIe0   │            │          │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1094  		 *  01 ENETC   │            │          │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1095  		 *  10 PCIe1   │            │          │
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1096  		 *             │            └──────────┘
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1097  		 * The MSI glue layer auto adds 2 bits controller ID ahead of
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1098  		 * streamID, so mask these 2 bits to get streamID. The
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1099  		 * IOMMU glue layer doesn't do that.
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1100  		 */
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1101  		if (sid_i != (sid_m & IMX95_SID_MASK)) {
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1102  			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1103  			return -EINVAL;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1104  		}
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1105  	}
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1106  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1107  	if (!err_i)
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1108  		sid = sid_i;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14 @1109  	else if (!err_m)
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1110  		sid = sid_m & IMX95_SID_MASK;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1111  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1112  	return imx_pcie_add_lut(imx_pcie, rid, sid);
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1113  }
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1114  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1115  static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1116  				    struct pci_dev *pdev)
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1117  {
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1118  	struct imx_pcie *imx_pcie;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1119  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1120  	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1121  	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1122  }
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1123  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1124  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
fa33a6d87eac1a drivers/pci/host/pci-imx6.c           Marek Vasut            2013-12-12  1125  {
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1126  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
9751f65db025a1 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1127  	struct device *dev = pci->dev;
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1128  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
9751f65db025a1 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1129  	int ret;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1130  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1131  	if (imx_pcie->vpcie) {
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1132  		ret = regulator_enable(imx_pcie->vpcie);
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1133  		if (ret) {
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1134  			dev_err(dev, "failed to enable vpcie regulator: %d\n",
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1135  				ret);
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1136  			return ret;
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1137  		}
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1138  	}
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1139  
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1140  	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1141  		pp->bridge->enable_device = imx_pcie_enable_device;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1142  		pp->bridge->disable_device = imx_pcie_disable_device;
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1143  	}
bc92494deb1c40 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2025-01-14  1144  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1145  	imx_pcie_assert_core_reset(imx_pcie);
21ad80b0e0ce5f drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1146  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1147  	if (imx_pcie->drvdata->init_phy)
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1148  		imx_pcie->drvdata->init_phy(imx_pcie);
21ad80b0e0ce5f drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1149  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1150  	imx_pcie_configure_type(imx_pcie);
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1151  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1152  	ret = imx_pcie_clk_enable(imx_pcie);
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1153  	if (ret) {
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1154  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1155  		goto err_reg_disable;
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1156  	}
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1157  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1158  	if (imx_pcie->phy) {
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1159  		ret = phy_init(imx_pcie->phy);
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1160  		if (ret) {
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1161  			dev_err(dev, "pcie PHY power up failed\n");
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1162  			goto err_clk_disable;
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1163  		}
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1164  
0dafa2a5c9e14e drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-11-19  1165  		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
0dafa2a5c9e14e drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-11-19  1166  				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
0dafa2a5c9e14e drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-11-19  1167  						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
8026f2d8e8a95a drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1168  		if (ret) {
8026f2d8e8a95a drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1169  			dev_err(dev, "unable to set PCIe PHY mode\n");
8026f2d8e8a95a drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1170  			goto err_phy_exit;
8026f2d8e8a95a drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1171  		}
8026f2d8e8a95a drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1172  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1173  		ret = phy_power_on(imx_pcie->phy);
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1174  		if (ret) {
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1175  			dev_err(dev, "waiting for PHY ready timeout!\n");
5b04d44d5c74e4 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1176  			goto err_phy_exit;
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1177  		}
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1178  	}
ae6b9a65af4801 drivers/pci/controller/dwc/pci-imx6.c Sascha Hauer           2022-11-01  1179  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1180  	ret = imx_pcie_deassert_core_reset(imx_pcie);
ae6b9a65af4801 drivers/pci/controller/dwc/pci-imx6.c Sascha Hauer           2022-11-01  1181  	if (ret < 0) {
ae6b9a65af4801 drivers/pci/controller/dwc/pci-imx6.c Sascha Hauer           2022-11-01  1182  		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
ae6b9a65af4801 drivers/pci/controller/dwc/pci-imx6.c Sascha Hauer           2022-11-01  1183  		goto err_phy_off;
ae6b9a65af4801 drivers/pci/controller/dwc/pci-imx6.c Sascha Hauer           2022-11-01  1184  	}
ae6b9a65af4801 drivers/pci/controller/dwc/pci-imx6.c Sascha Hauer           2022-11-01  1185  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1186  	imx_setup_phy_mpll(imx_pcie);
4a301766f5263d drivers/pci/dwc/pci-imx6.c            Bjorn Andersson        2017-07-15  1187  
4a301766f5263d drivers/pci/dwc/pci-imx6.c            Bjorn Andersson        2017-07-15  1188  	return 0;
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1189  
cf236e0c0d59b3 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1190  err_phy_off:
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1191  	phy_power_off(imx_pcie->phy);
5b04d44d5c74e4 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1192  err_phy_exit:
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1193  	phy_exit(imx_pcie->phy);
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1194  err_clk_disable:
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1195  	imx_pcie_clk_disable(imx_pcie);
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1196  err_reg_disable:
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1197  	if (imx_pcie->vpcie)
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1198  		regulator_disable(imx_pcie->vpcie);
f0691e326b270d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1199  	return ret;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1200  }
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1201  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1202  static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1203  {
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1204  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1205  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1206  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1207  	if (imx_pcie->phy) {
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1208  		if (phy_power_off(imx_pcie->phy))
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1209  			dev_err(pci->dev, "unable to power off PHY\n");
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1210  		phy_exit(imx_pcie->phy);
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1211  	}
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1212  	imx_pcie_clk_disable(imx_pcie);
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1213  
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1214  	if (imx_pcie->vpcie)
d657ea28d55037 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-07-29  1215  		regulator_disable(imx_pcie->vpcie);
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1216  }
835a345b18b013 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2022-07-14  1217  
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1218  static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1219  {
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1220  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1221  	struct dw_pcie_rp *pp = &pcie->pp;
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1222  	struct resource_entry *entry;
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1223  
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29 @1224  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1225  		return cpu_addr;
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1226  
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1227  	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1228  	if (!entry)
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1229  		return cpu_addr;
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1230  
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1231  	return cpu_addr - entry->offset;
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1232  }
c2699778e6be47 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2024-07-29  1233  

:::::: The code at line 1224 was first introduced by commit
:::::: c2699778e6be4757ee0b16449ab8777c6b46e6d0 PCI: imx6: Add i.MX8Q PCIe Root Complex (RC) support

:::::: TO: Richard Zhu <hongxing.zhu@nxp.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

