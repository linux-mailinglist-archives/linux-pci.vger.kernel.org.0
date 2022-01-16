Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69448FE84
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jan 2022 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiAPSwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jan 2022 13:52:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:11739 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233885AbiAPSwR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Jan 2022 13:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642359137; x=1673895137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBBtJHqBFLF14+RAwm8soSu4xbTji4rK01PJVewZ1u8=;
  b=OxnZD8pNJj2dtwvyW5v8+uM1cot2MD1P4xW8otbHzc0N+vuW1mqjbGKo
   2z0mol+1KhlgEjYPtmWs1+gnGofPX/4mMbG1IitigMDUKm2c4jn9fgCEL
   YwpjuVbcI18OdpP/YdGM07J0xMCd6HycbqWCv4R4NnJLtEhzAaXqnopF0
   RUh3Z6irBx9mu4Escifs4MnoM/3mWPiqBcfyqO6+KtNwwW7CboRzSaKRK
   SMbXj2xCEuHuiadr6vDlpjR99w4tlABhutM0tstnhJ/2nctA9/KnuvET1
   JL2K0OgapF+o6XPQiziW9QFdwAHcc0to4fu+44458qZFf4nwikf9rhjc/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="225190868"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="225190868"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 10:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="614844128"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2022 10:52:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9AdQ-000AvK-ME; Sun, 16 Jan 2022 18:52:12 +0000
Date:   Mon, 17 Jan 2022 02:51:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     marek.vasut@gmail.com, linux-pci@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
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
Message-ID: <202201170230.U9LeY58M-lkp@intel.com>
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
config: arm-randconfig-c002-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170230.U9LeY58M-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/f784bebf4a058d633fc77579892309b12dd33edb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220116-102631
        git checkout f784bebf4a058d633fc77579892309b12dd33edb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rcar-host.c:109:6: warning: no previous prototype for function 'rcar_pci_write_reg_workaround' [-Wmissing-prototypes]
   void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
        ^
   drivers/pci/controller/pcie-rcar-host.c:109:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
   ^
   static 
>> drivers/pci/controller/pcie-rcar-host.c:121:5: warning: no previous prototype for function 'rcar_pci_read_reg_workaround' [-Wmissing-prototypes]
   u32 rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, unsigned int reg)
       ^
   drivers/pci/controller/pcie-rcar-host.c:121:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, unsigned int reg)
   ^
   static 
   drivers/pci/controller/pcie-rcar-host.c:114:4: error: instruction requires: data-barriers
                   "       isb\n"
                    ^
   <inline asm>:2:2: note: instantiated into assembly here
           isb
           ^
   drivers/pci/controller/pcie-rcar-host.c:129:4: error: instruction requires: data-barriers
                   "       isb\n"
                    ^
   <inline asm>:3:2: note: instantiated into assembly here
           isb
           ^
   drivers/pci/controller/pcie-rcar-host.c:114:4: error: instruction requires: data-barriers
                   "       isb\n"
                    ^
   <inline asm>:2:2: note: instantiated into assembly here
           isb
           ^
   drivers/pci/controller/pcie-rcar-host.c:127:3: error: symbol 'rcar_pci_read_reg_workaround_start' is already defined
                   "rcar_pci_read_reg_workaround_start:\n"
                   ^
   <inline asm>:1:2: note: instantiated into assembly here
           rcar_pci_read_reg_workaround_start:
           ^
   drivers/pci/controller/pcie-rcar-host.c:129:4: error: instruction requires: data-barriers
                   "       isb\n"
                    ^
   <inline asm>:3:2: note: instantiated into assembly here
           isb
           ^
   2 warnings and 5 errors generated.


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
