Return-Path: <linux-pci+bounces-23870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7505AA632FF
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1182171681
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 00:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29A2E338B;
	Sun, 16 Mar 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtRnqu4b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1991C27
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742085957; cv=none; b=fzy1Sr6SW2o57I+OdooqEK5YgusdAXVaqkNpX18EJh+Xbq6Bpo5JXA2aowRg+ZsAan3XT+JoKiZhlZXHOVZizq2SocpSEH4fqy5sRyjgX2UhpcLy5JRQaj/f6/U0YQM7aWTLQ6LWcicr50PIDgKmO+KggpkwlfP9NfEKJcXagqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742085957; c=relaxed/simple;
	bh=iVr3mXQ5wZkv8oZyXUzpKEHSnbGTcwDEUVA7B7Bucfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m1c6Cn7eygsJqZey7A1Ec6RRNNooE20q0gPnn9HP+IINmB3RnccXCC/rKeZtCg/nMK08GQgI2XHQQCmeJS7gjk18bdeu3IJi4mL/nTXo2XKaBU70+DScqoWREcJPRvMdxahr8wq19Andwb3anv0P/YEBX+BxItb74vUbt9f28kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtRnqu4b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742085955; x=1773621955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iVr3mXQ5wZkv8oZyXUzpKEHSnbGTcwDEUVA7B7Bucfg=;
  b=JtRnqu4bpZkZRJ52ONjDielD6w0okYO7RguIHtASqjqUWUyv26GHcCqz
   PpX9iSQfuk5NZX13jOnPg306by1U6+i8zQtpyvZAIdl0WR+4Bk0VYDP2p
   gX08PC7nBpxtfzqf4KStGYV3TRq0fwxJur0K5to998naFX9iVzU7stJIk
   K2PP12UzAsIzSLt40XEDZEpsKZ/8GesmGGwsUGWhnNJoQBWC9O50Lk9pr
   PwOGtJd+Rvn4mvwySBnBawXMD7kMGS/b4TxAwGj0GVOh4zfDO6hR6V0ey
   I7pn44o9f75RXYjDSr1+p8+sCaOXl5pJfLN2+I/k61B/7w+MDjHH8Bl+l
   Q==;
X-CSE-ConnectionGUID: t2jRvfJpQy+/ODqbNyJP4g==
X-CSE-MsgGUID: uz23mNwkSzqcgvLgZHX2Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="54585254"
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="54585254"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 17:45:55 -0700
X-CSE-ConnectionGUID: eyVT49zMSjeZK/ENlK6A5w==
X-CSE-MsgGUID: MMkgoWeYT5ijb1hm6vKPaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="126803571"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 15 Mar 2025 17:45:54 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttc8U-000Bk1-2N;
	Sun, 16 Mar 2025 00:45:50 +0000
Date: Sun, 16 Mar 2025 08:45:03 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:controller/dwc-cpu-addr-fixup 6/13]
 drivers/pci/controller/dwc/pcie-designware.c:1134:39: warning: format '%llx'
 expects argument of type 'long long unsigned int', but argument 3 has type
 'resource_size_t' {aka 'unsigned int'}
Message-ID: <202503160823.faHNdwwX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-cpu-addr-fixup
head:   40b96cba38232460c691b52bbf9183f9e4d34914
commit: af175b4797cd4e3e8ff22a4e3c6924443986b797 [6/13] PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
config: csky-randconfig-001-20250316 (https://download.01.org/0day-ci/archive/20250316/202503160823.faHNdwwX-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250316/202503160823.faHNdwwX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503160823.faHNdwwX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma/edma.h:12,
                    from drivers/pci/controller/dwc/pcie-designware.c:15:
   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_parent_bus_offset':
>> drivers/pci/controller/dwc/pcie-designware.c:1134:39: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1134 |                         dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1134:25: note: in expansion of macro 'dev_warn'
    1134 |                         dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
         |                         ^~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1134:47: note: format string is defined here
    1134 |                         dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
         |                                        ~~~~~~~^
         |                                               |
         |                                               long long unsigned int
         |                                        %#010x
   drivers/pci/controller/dwc/pcie-designware.c:1138:39: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1138 |                         dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1138:25: note: in expansion of macro 'dev_warn'
    1138 |                         dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
         |                         ^~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1138:47: note: format string is defined here
    1138 |                         dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
         |                                        ~~~~~~~^
         |                                               |
         |                                               long long unsigned int
         |                                        %#010x
   drivers/pci/controller/dwc/pcie-designware.c:1145:39: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1145 |                         dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1145:25: note: in expansion of macro 'dev_warn'
    1145 |                         dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
         |                         ^~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1145:125: note: format string is defined here
    1145 |                         dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
         |                                                                                                                      ~~~~~~~^
         |                                                                                                                             |
         |                                                                                                                             long long unsigned int
         |                                                                                                                       CPU x


vim +1134 drivers/pci/controller/dwc/pcie-designware.c

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
  1130		fixup = pci->ops->cpu_addr_fixup;
  1131		if (fixup) {
  1132			fixup_addr = fixup(pci, cpu_phy_addr);
  1133			if (reg_addr == fixup_addr) {
> 1134				dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

