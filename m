Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2E48FEDD
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jan 2022 21:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiAPUoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jan 2022 15:44:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:62635 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbiAPUoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Jan 2022 15:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642365858; x=1673901858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J063RBw/2q/HCwiW/791Ep3SLzAFRk7P9SqEGSo8Oao=;
  b=TZzqf+3DFKUCwLkn7eAKw5A2m4e+hUVJBozkCmuExYP44ZwCLkEruIgM
   A94R2g6ws5UM91eXQTtvf7R2S+1OdLm3r6l7wvBtfrRa41P6Vh+miPwuu
   FfOJsv2piQ8eQd7Oqjd+fCbxqtOZvgFJiqjPE5XPFWfPaykMlwDDybPVU
   odWMNj3HOXT3ULr/0QY2NylGqahp7rWhe8fkHAzBSqM0nmQ8QbaZO49G7
   A++qyEMKoUNI0sNpO/cMku5aUGTp7/uLmjnhXgGNHAebcEx+7wy29Uj5f
   V4XVJ7TDsV2eeMW6rSTh98TtZEWT999g+J7hJ2086CcpD1gHyMBuF63p0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224494869"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="224494869"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 12:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="692854934"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 12:44:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9CNq-000AyT-7h; Sun, 16 Jan 2022 20:44:14 +0000
Date:   Mon, 17 Jan 2022 04:43:20 +0800
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
Message-ID: <202201170402.sPT8Gtpa-lkp@intel.com>
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

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on next-20220116]
[cannot apply to v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220116-102631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-randconfig-c002-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170402.sPT8Gtpa-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-rcar-host.c:109:6: warning: no previous prototype for 'rcar_pci_write_reg_workaround' [-Wmissing-prototypes]
     109 | void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rcar-host.c:121:5: warning: no previous prototype for 'rcar_pci_read_reg_workaround' [-Wmissing-prototypes]
     121 | u32 rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, unsigned int reg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/ccquRjDl.s: Assembler messages:
   /tmp/ccquRjDl.s:1425: Error: selected processor does not support `isb' in ARM mode
   /tmp/ccquRjDl.s:1486: Error: selected processor does not support `isb' in ARM mode
   /tmp/ccquRjDl.s:2594: Error: selected processor does not support `isb' in ARM mode
>> /tmp/ccquRjDl.s:2622: Error: symbol `rcar_pci_read_reg_workaround_start' is already defined
   /tmp/ccquRjDl.s:2624: Error: selected processor does not support `isb' in ARM mode

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
