Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFEC48FE74
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jan 2022 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiAPSbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jan 2022 13:31:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:32402 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbiAPSbR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Jan 2022 13:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642357877; x=1673893877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=968lJqmkHHdFBTKOb0QPzI++Lw7yAUqpVeAEs8YENdc=;
  b=j42kr0JfbuOs/HU53uuf6eqADSGyttXMRto1Paz6PUv2y2qwjre8Sjav
   tdhnDAIfuIeoP3ewEzUZMqEtu7vQVV0lk6zNKimkRZxNtOF1E89l98Bjb
   2Vi5q6p5vFJVqKt/VZXaU0HsxtHkauvBoTCxlFgyeNr9fbJ8wqdN4Gyyj
   QtQrsnI7QMJ9xin2krKHXjidztr8xinoBn8SnptlWl3oaLq14MsgTppRY
   +bJF0H9Z1gd3xj7b7QmsldC04SopaYUlIP8X0bFcSrfU/pGYMYD7S5z6V
   IGlUR594/UcNLB24bSh4H5RwToSO88H7WOWPjcoJ0NSI4fJlE+2ANEKJl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="243331088"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="243331088"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 10:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="624965093"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2022 10:31:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9AJ6-000AuJ-Dx; Sun, 16 Jan 2022 18:31:12 +0000
Date:   Mon, 17 Jan 2022 02:30:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     marek.vasut@gmail.com, linux-pci@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar: Return all Fs from read which triggered
 an exception
Message-ID: <202201170248.g8zqyL3O-lkp@intel.com>
References: <20220116022549.456486-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116022549.456486-2-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on next-20220116]
[cannot apply to v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220116-102631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-randconfig-c002-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170248.g8zqyL3O-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f784bebf4a058d633fc77579892309b12dd33edb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220116-102631
        git checkout f784bebf4a058d633fc77579892309b12dd33edb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rcar-host.c:109:6: warning: no previous prototype for 'rcar_pci_write_reg_workaround' [-Wmissing-prototypes]
     109 | void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-rcar-host.c:121:5: warning: no previous prototype for 'rcar_pci_read_reg_workaround' [-Wmissing-prototypes]
     121 | u32 rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, unsigned int reg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/cc0JJaba.s: Assembler messages:
   /tmp/cc0JJaba.s:1425: Error: selected processor does not support `isb' in ARM mode
   /tmp/cc0JJaba.s:1486: Error: selected processor does not support `isb' in ARM mode
   /tmp/cc0JJaba.s:2594: Error: selected processor does not support `isb' in ARM mode
   /tmp/cc0JJaba.s:2622: Error: symbol `rcar_pci_read_reg_workaround_start' is already defined
   /tmp/cc0JJaba.s:2624: Error: selected processor does not support `isb' in ARM mode


vim +/rcar_pci_write_reg_workaround +109 drivers/pci/controller/pcie-rcar-host.c

   108	
 > 109	void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
   110	{
   111	#ifdef CONFIG_ARM
   112		asm volatile(
   113			"	str %0, [%1]\n"
   114			"	isb\n"
   115		::"r"(val), "r"(pcie->base + reg):"memory");
   116	#else
   117		rcar_pci_write_reg(pcie, val, reg);
   118	#endif
   119	}
   120	
 > 121	u32 rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, unsigned int reg)
   122	{
   123	#ifdef CONFIG_ARM
   124		u32 val;
   125	
   126		asm volatile(
   127			"rcar_pci_read_reg_workaround_start:\n"
   128			"1:	ldr %0, [%1]\n"
   129			"	isb\n"
   130		: "=r"(val):"r"(pcie->base + reg):"memory");
   131	
   132		return val;
   133	#else
   134		return rcar_pci_read_reg(pcie, reg);
   135	#endif
   136	}
   137	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
