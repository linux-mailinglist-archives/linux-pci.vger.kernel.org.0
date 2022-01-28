Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFEC49F13F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 03:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345463AbiA1Cry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 21:47:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:4212 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345531AbiA1Cry (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 21:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643338074; x=1674874074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Z6rpYTwUGuTjUocHChIXuJIH1Xqfusv1NopfrR3Vow=;
  b=oB84OpLD7koI3ghejlFU9e97GhOuVkbLN8ZQewF0zkbgT5EyCnMhzl6D
   2XpGXrruVFlDUSQjQlEKMqauVmd/Z8jG2gRkDiBUQcvVCDFkO72L1nt53
   y5hUmwUXUgFchO7NimR3kyTPb/jxjcKgmGLlEsPrWbbLBviM68gidCCj4
   /oSkg2Lr4dK5r/RJSggyDOYZim9MP76gXDbWlAUFgeGkyzHlzYsYoycmj
   hIJpJ1rc6HnFG1g7u20h7Wdu5iVvVBXqQRa61R8g5twkbAha4NRNhFB9q
   EPXDa+W3J3KFHYmPaIC3mjnooxrT7v6JCdUK/N2C8JPg7EeCON54fqSfW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="247248583"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="247248583"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="495971012"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2022 18:47:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDHIj-000NLG-NZ; Fri, 28 Jan 2022 02:47:49 +0000
Date:   Fri, 28 Jan 2022 10:47:10 +0800
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
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <202201281037.40i8elct-lkp@intel.com>
References: <20220122221554.196311-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122221554.196311-2-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on v5.17-rc1 next-20220127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220123-061742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-buildonly-randconfig-r002-20220127 (https://download.01.org/0day-ci/archive/20220128/202201281037.40i8elct-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f400a6012c668dfaa73462caf067ceb074e66c47)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/1eeb0cd756244c956c8b0fa809f2d4e5bee530b4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220123-061742
        git checkout 1eeb0cd756244c956c8b0fa809f2d4e5bee530b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-rcar-host.c:133:5: warning: no previous prototype for function 'rcar_pci_write_reg_workaround' [-Wmissing-prototypes]
   int rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
       ^
   drivers/pci/controller/pcie-rcar-host.c:133:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
   ^
   static 
   drivers/pci/controller/pcie-rcar-host.c:146:5: warning: no previous prototype for function 'rcar_pci_read_reg_workaround' [-Wmissing-prototypes]
   int rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, u32 *val, unsigned int reg)
       ^
   drivers/pci/controller/pcie-rcar-host.c:146:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, u32 *val, unsigned int reg)
   ^
   static 
>> drivers/pci/controller/pcie-rcar-host.c:138:3: error: instruction requires: data-barriers
                   __rcar_pci_rw_reg_workaround("str")
                   ^
   drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
                   "2:     isb\n"                                          \
                    ^
   <inline asm>:2:4: note: instantiated into assembly here
   2:      isb
           ^
   drivers/pci/controller/pcie-rcar-host.c:151:3: error: instruction requires: data-barriers
                   __rcar_pci_rw_reg_workaround("ldr")
                   ^
   drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
                   "2:     isb\n"                                          \
                    ^
   <inline asm>:2:4: note: instantiated into assembly here
   2:      isb
           ^
>> drivers/pci/controller/pcie-rcar-host.c:138:3: error: instruction requires: data-barriers
                   __rcar_pci_rw_reg_workaround("str")
                   ^
   drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
                   "2:     isb\n"                                          \
                    ^
   <inline asm>:2:4: note: instantiated into assembly here
   2:      isb
           ^
   drivers/pci/controller/pcie-rcar-host.c:151:3: error: instruction requires: data-barriers
                   __rcar_pci_rw_reg_workaround("ldr")
                   ^
   drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
                   "2:     isb\n"                                          \
                    ^
   <inline asm>:2:4: note: instantiated into assembly here
   2:      isb
           ^
   2 warnings and 4 errors generated.


vim +138 drivers/pci/controller/pcie-rcar-host.c

   132	
   133	int rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
   134	{
   135		int error = PCIBIOS_SUCCESSFUL;
   136	#ifdef CONFIG_ARM
   137		asm volatile(
 > 138			__rcar_pci_rw_reg_workaround("str")
   139		: "+r"(error):"r"(val), "r"(pcie->base + reg) : "memory");
   140	#else
   141		rcar_pci_write_reg(pcie, val, reg);
   142	#endif
   143		return error;
   144	}
   145	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
