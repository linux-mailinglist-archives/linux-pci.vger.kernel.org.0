Return-Path: <linux-pci+bounces-24275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D75A6B14E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3524466985
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9C227EBE;
	Thu, 20 Mar 2025 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mpa5PyCc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BC22155C
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511444; cv=none; b=KZkD5Q2zrj0lfttkIz1YCJJ3pG32KvQgQ7r+aIEe+k8OLYmBKOU1JQscVM9ISgJHyvbnF38UeyFXyF2XZDPK/FxAcNhD+9BM6rIIfnrbkxhdhFdTMi1K4PrnDBiMo++QRMNnoSUei4KxutOBUgNyqfRJBstWl6zltGjs2WdK+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511444; c=relaxed/simple;
	bh=jZoKxj5+UpyOE+1wQxvyce1SsOE/Sr1DevRce9Tjntg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZO3H6hUe49Gm9PoACYMkFIHlGvKzbz8QwhCQaUmk6y+g4JTY08HShKI8NEFoTtjZ1G6xMp0cRo9X4pnbOe2zBJx7f9KYRzH5gaRj++v1f3qr0j2Hkcj0wGtSETQAIRnRdnXEa1IKv5hCk1/pNSaGFVOpP2t9htp0dOVHV1Cp5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mpa5PyCc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742511443; x=1774047443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jZoKxj5+UpyOE+1wQxvyce1SsOE/Sr1DevRce9Tjntg=;
  b=Mpa5PyCc0u34hDzKM3zFT7eQmw+7Ypnhyc4odOmuma+LsoG2pE/+Khwj
   xSXZqJ7iLhK8REXdiUiNoUDAvFkloe32UEgEnpH5Xvd78yShVgCyV72mO
   7IoJgVZM9Tsbfa0TdHmW7owIRhe5u6bW3Lm8uOGUYT1JNTGl11S5UH4lp
   UMj91F1TnDBG3fnILgLQvtdDj9KA1lV5LSZnfqk3kvm7a1rcHHkbmoFKp
   YBrJjQk9g5R0qrYrh4PUD0b2bnW3oSHycGxDRrjOqQNxlOHlxsBpku5Nf
   GY10px4AGCLwdhUqUFRZ825c9kjZiNRsHB+YROlT/m9J8qfwSLdpPdx4H
   Q==;
X-CSE-ConnectionGUID: kyFFY1kETfe/fe/xlPhZlA==
X-CSE-MsgGUID: iIKYZLtiTlCV9X+g9sG4xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43881985"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43881985"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:57:23 -0700
X-CSE-ConnectionGUID: RctdBIdlR1W87EbP98NIZw==
X-CSE-MsgGUID: 6OncBKvfT0SL2NB3ac2I5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123407730"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 15:57:21 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvOpC-0000qu-22;
	Thu, 20 Mar 2025 22:57:18 +0000
Date: Fri, 21 Mar 2025 06:56:55 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:controller/dwc-cpu-addr-fixup 6/14]
 drivers/pci/controller/dwc/pcie-designware.c:1130:55: sparse: sparse: Using
 plain integer as NULL pointer
Message-ID: <202503210649.lau9JEgG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-cpu-addr-fixup
head:   94d1d26431c0e4c845e9e9ee5f23bcc9a53d95ec
commit: c1154a3218325a03cd07df51a7076a353a723589 [6/14] PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
config: alpha-randconfig-r121-20250321 (https://download.01.org/0day-ci/archive/20250321/202503210649.lau9JEgG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250321/202503210649.lau9JEgG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503210649.lau9JEgG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-designware.c:1130:55: sparse: sparse: Using plain integer as NULL pointer
   drivers/pci/controller/dwc/pcie-designware.c: note: in included file (through arch/alpha/include/asm/core_tsunami.h, arch/alpha/include/asm/io.h, include/linux/scatterlist.h, ...):
   arch/alpha/include/asm/io_trivial.h:70:16: sparse: sparse: undefined identifier '__kernel_ldwu'
   arch/alpha/include/asm/io_trivial.h:64:16: sparse: sparse: undefined identifier '__kernel_ldbu'
   arch/alpha/include/asm/io_trivial.h:82:9: sparse: sparse: undefined identifier '__kernel_stw'
   arch/alpha/include/asm/io_trivial.h:76:9: sparse: sparse: undefined identifier '__kernel_stb'

vim +1130 drivers/pci/controller/dwc/pcie-designware.c

  1109	
  1110	resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
  1111						  const char *reg_name,
  1112						  resource_size_t cpu_phy_addr)
  1113	{
  1114		struct device *dev = pci->dev;
  1115		struct device_node *np = dev->of_node;
  1116		int index;
  1117		u64 reg_addr, fixup_addr;
  1118		u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
  1119	
  1120		/* Look up reg_name address on parent bus */
  1121		index = of_property_match_string(np, "reg-names", reg_name);
  1122	
  1123		if (index < 0) {
  1124			dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
  1125			return 0;
  1126		}
  1127	
  1128		of_property_read_reg(np, index, &reg_addr, NULL);
  1129	
> 1130		fixup = pci->ops ? pci->ops->cpu_addr_fixup : 0;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

