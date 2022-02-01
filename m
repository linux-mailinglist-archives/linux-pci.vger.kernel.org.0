Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A087A4A5DA3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 14:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiBANrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 08:47:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:28613 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbiBANrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 08:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643723227; x=1675259227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=alu1H9qvEw3HFlKI7urAlQj1NT+EXGA6doXsiFrrJ64=;
  b=W7XqfEtfblm+hOy2EBzjBFBFCP7AUqc2j15u53AlcfFaMXJ/m05EFnvK
   0wWnlNvGlTGVuOpFBsh6CPmdtsM/sdCaiJYRcyPTZ8dJSbmnJ2KlxZloP
   Ldpr7fh25Acy5rqhDUI5E35ueM06Ja/bzioj8hG51Vputmgzn75Lv9MQ7
   pl2XeU9WFmRTZiUpCtcNYiNkePvYCE7Ua/douv8io+0jIEBcylbTIURrZ
   GNSqFVG3DRxCNQEo6sgo2a8cvzrSZ1h4H2QWxGag0Y4ee1b0fLEq2zoQc
   yB3BEbKL1xPYsXZ2HIu3s0whXIqA8qRbUSheFc1fi4iNGAiVdiqyN+r/C
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="231262473"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="231262473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 05:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="619793915"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2022 05:46:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEtUZ-000TKG-SL; Tue, 01 Feb 2022 13:46:43 +0000
Date:   Tue, 1 Feb 2022 21:46:36 +0800
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
Subject: Re: [PATCH v4 2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
 which triggered an exception
Message-ID: <202202012118.qgdNW3Ra-lkp@intel.com>
References: <20220129043837.172126-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129043837.172126-2-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on v5.17-rc2 next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220129-124033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-randconfig-c002-20220201 (https://download.01.org/0day-ci/archive/20220201/202202012118.qgdNW3Ra-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/88177fcc2d6d4acbea59c90839882f70b7b774a1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220129-124033
        git checkout 88177fcc2d6d4acbea59c90839882f70b7b774a1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pci/controller/

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
