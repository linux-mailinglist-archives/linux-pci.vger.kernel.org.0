Return-Path: <linux-pci+bounces-19891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63ADA12430
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2464416492B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CAC241683;
	Wed, 15 Jan 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKptHkba"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469671E9911
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736945642; cv=none; b=o4Ot0YS4C07PcAATEmmBJChdHRCE0HChyHuQ6gsRrk4StJE8pn2oTmEWsog72EA/jsFmapwphtFzPESm/1785ZKIwgZF8fQc73MdMmJDTf0JcPkvywhhNKcOiivke+13vF7++6ykTlVd3F/s/ZP5Jnu+fzgtGbIYOeldM0SE74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736945642; c=relaxed/simple;
	bh=KYBTSrU4D0P9uPuMhMszKxKquA7FVkeKmsXmnMzabe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IIX37T2rZ1+rv29ip5jiktNvaS5ZVlGNPTaf5ULpwoPHFZjxvmBBU9ke3dN91deui8qzUQj11PaqK+8C8Nqvnxz6W/eX6mfr4v66uuyjh1t9AjNtAkbIgF60nnPTLnUq0BI5lzGRAropMMZOh6zPrMO0RluzQGnktZEHv6xXkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKptHkba; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736945640; x=1768481640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KYBTSrU4D0P9uPuMhMszKxKquA7FVkeKmsXmnMzabe4=;
  b=fKptHkbaqFrzSLmXC2OGrPZ8MgHL6kkfB2TkZ8+D9C8ewhNoSFMiarwS
   nKG747Qzai1AZhsWr7P1qojzB4JfYIteMoiQmJ5eh1Cs3wzqnEqvlfFuN
   saItG024PFq7ehPQ/+tjJCrzFzPYqFNjwSaCusOQE+4wNvpWVy8g4jd6W
   njKqSQvGmb1ZDdDqfIr61wgpBjqFODHNCox5w/mZrfFD8BpvN53d9Ytd1
   KZKlI1gaiZOILHm44cIFfgc6zQ2HwzVw7YKD8r8UgVhmOAYgfX/JIyFe4
   eDLJNPTwCLL+yzE6yCYzFrnsIdefqHGKvfU5jgFpXmttFe3xyq/bBq+h8
   w==;
X-CSE-ConnectionGUID: T70ZCkGUS02DAW5Gas1JFw==
X-CSE-MsgGUID: Q6hJy7goSqatqnq65kzpqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54820886"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="54820886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 04:53:59 -0800
X-CSE-ConnectionGUID: 0A3XcKV9TOyUZDrbRP1XpA==
X-CSE-MsgGUID: yx+PLy25RLWu97qnJqpJfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128385402"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jan 2025 04:53:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tY2uC-000QLN-0W;
	Wed, 15 Jan 2025 12:53:56 +0000
Date: Wed, 15 Jan 2025 20:53:26 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [pci:next 15/20] drivers/pci/controller/dwc/pci-imx6.c:1218:12:
 warning: 'imx_pcie_cpu_addr_fixup' defined but not used
Message-ID: <202501152029.fuNA3kqE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
head:   19501c8805572d695bc694a761b3e61f0aa32ae4
commit: 7a6f84fed4abbee48ea03897340040dfced9ceee [15/20] Merge branch 'controller/imx6'
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250115/202501152029.fuNA3kqE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250115/202501152029.fuNA3kqE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501152029.fuNA3kqE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pci-imx6.c: In function 'imx_pcie_cpu_addr_fixup':
   drivers/pci/controller/dwc/pci-imx6.c:1224:42: error: 'IMX_PCIE_FLAG_CPU_ADDR_FIXUP' undeclared (first use in this function)
    1224 |         if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pci-imx6.c:1224:42: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/dwc/pci-imx6.c: At top level:
   drivers/pci/controller/dwc/pci-imx6.c:1790:26: error: 'IMX_PCIE_FLAG_CPU_ADDR_FIXUP' undeclared here (not in a function)
    1790 |                          IMX_PCIE_FLAG_CPU_ADDR_FIXUP |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pci-imx6.c:1218:12: warning: 'imx_pcie_cpu_addr_fixup' defined but not used [-Wunused-function]
    1218 | static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +/imx_pcie_cpu_addr_fixup +1218 drivers/pci/controller/dwc/pci-imx6.c

835a345b18b013c Richard Zhu 2022-07-14  1217  
c2699778e6be475 Richard Zhu 2024-07-29 @1218  static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
c2699778e6be475 Richard Zhu 2024-07-29  1219  {
c2699778e6be475 Richard Zhu 2024-07-29  1220  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
c2699778e6be475 Richard Zhu 2024-07-29  1221  	struct dw_pcie_rp *pp = &pcie->pp;
c2699778e6be475 Richard Zhu 2024-07-29  1222  	struct resource_entry *entry;
c2699778e6be475 Richard Zhu 2024-07-29  1223  
c2699778e6be475 Richard Zhu 2024-07-29  1224  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
c2699778e6be475 Richard Zhu 2024-07-29  1225  		return cpu_addr;
c2699778e6be475 Richard Zhu 2024-07-29  1226  
c2699778e6be475 Richard Zhu 2024-07-29  1227  	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
c2699778e6be475 Richard Zhu 2024-07-29  1228  	if (!entry)
c2699778e6be475 Richard Zhu 2024-07-29  1229  		return cpu_addr;
c2699778e6be475 Richard Zhu 2024-07-29  1230  
c2699778e6be475 Richard Zhu 2024-07-29  1231  	return cpu_addr - entry->offset;
c2699778e6be475 Richard Zhu 2024-07-29  1232  }
c2699778e6be475 Richard Zhu 2024-07-29  1233  

:::::: The code at line 1218 was first introduced by commit
:::::: c2699778e6be4757ee0b16449ab8777c6b46e6d0 PCI: imx6: Add i.MX8Q PCIe Root Complex (RC) support

:::::: TO: Richard Zhu <hongxing.zhu@nxp.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

