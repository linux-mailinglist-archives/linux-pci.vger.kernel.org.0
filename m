Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952348841C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 16:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiAHPAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Jan 2022 10:00:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:47073 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbiAHPAA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Jan 2022 10:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641654000; x=1673190000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDl2K8TuBODyo/rP2NekgRyZH6/0pbxe/iSdJtGGP48=;
  b=WEfl5jC9IEIPUD3vRg4sGymeAajTz21LllWub6w81t4Y8MyzjkiJ7ge3
   LSNcWhSS7ZXrKM2QSu48mfXsDnsW+4qZgNtZkc5zGhV8iAB+PKknvNGB0
   aR6VAzOKhQqRrmW601BcbzWelv9wTLchHNVFWRy32fIw46AukyDluQqh4
   0BBYULiQ7JKykPViIEt5eUglhGuXMWKG62nY6F89BbQsznMbMUcO6SiFW
   N9a2sHgO9gpiLpUj58NMpK5yoHDsDEYp/bUZflTKYXiInNierXQIMSwqR
   XqAhqvU7IaZP6rGbj33M61LpL9PM0MgVargWzp9X20aUdQyGbUn3LUTJG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240569086"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240569086"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 06:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="489587440"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2022 06:59:57 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6DCH-0000i0-6i; Sat, 08 Jan 2022 14:59:57 +0000
Date:   Sat, 8 Jan 2022 22:58:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sanrio Alvares <sanrio.alvares@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mika.westerberg@linux.intel.com,
        Sanrio Alvares <sanrio.alvares@intel.com>
Subject: Re: [PATCH] PCI / thunderbolt: Add quirk to handle incorrect
 Supported Link Speeds
Message-ID: <202201082217.CMkPI5k2-lkp@intel.com>
References: <20220106224240.31052-1-sanrio.alvares@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106224240.31052-1-sanrio.alvares@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sanrio,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on v5.16-rc8 next-20220107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sanrio-Alvares/PCI-thunderbolt-Add-quirk-to-handle-incorrect-Supported-Link-Speeds/20220107-064444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: riscv-randconfig-s032-20220106 (https://download.01.org/0day-ci/archive/20220108/202201082217.CMkPI5k2-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/98f8f42acd1b8f46f3e6778fa58dd0d1cd005369
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sanrio-Alvares/PCI-thunderbolt-Add-quirk-to-handle-incorrect-Supported-Link-Speeds/20220107-064444
        git checkout 98f8f42acd1b8f46f3e6778fa58dd0d1cd005369
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/pci/ kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/pci/quirks.c:2323:57: sparse: sparse: restricted pci_power_t degrades to integer
>> drivers/pci/quirks.c:5304:6: sparse: sparse: symbol 'quirk_intel_tbt_supported_link_speeds' was not declared. Should it be static?

vim +/quirk_intel_tbt_supported_link_speeds +5304 drivers/pci/quirks.c

  5298	
  5299	/*
  5300	 * Intel Titan Ridge returns incorrect Supported Link Speeds Vector
  5301	 * when max Link Speed is 2.5GT/s. This results in an extra 1s delay during
  5302	 * resume_noirq with pcie tunneling enabled. Override that value:
  5303	 */
> 5304	void quirk_intel_tbt_supported_link_speeds(struct pci_dev *pdev)
  5305	{
  5306		pci_info(pdev, "applying Supported Link Speeds quirk\n");
  5307		pdev->supported_link_speed = PCIE_SPEED_2_5GT;
  5308	}
  5309	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15e7, quirk_intel_tbt_supported_link_speeds);
  5310	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ea, quirk_intel_tbt_supported_link_speeds);
  5311	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ef, quirk_intel_tbt_supported_link_speeds);
  5312	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
