Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB3488325
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 12:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiAHLOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Jan 2022 06:14:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:14175 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbiAHLOy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Jan 2022 06:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641640494; x=1673176494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v+IekTsQmQ/ksCj4H81MNQxrz7WPGupipOILz7V/o7o=;
  b=dYhZHWwNRJPid1uBOf2y7MnZLhl9m1zRt3qLgYZR9BJw7+MsB9aDPHDi
   mgdi+IYKhutbkmgBl6PLlLojtE1VMAqrV8JMm2Pf1D0Jed0DL+0jaonz/
   KRiEbha+93ibmtIsl+u8OA/ucOWEgVI9ml/qp1hM5GqceVhsVS7lraHZq
   JOgrgthAwYQYTZl5plFJstX33nFSkB3ygHu3Tbb9uNBdqGmJcFC88xTlk
   JM+tRPewfr2gT1dxI/yWDXxNopZOJO3QICq4igIe8WrxvMYsgmfJm0M0j
   he122J4Mmp1HDd5ZpdAgSUqOBhzd0nZ1Lqm8u+IdAvHvwro4pTaS8TuRT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230347942"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="230347942"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 03:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473624106"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 03:14:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n69gR-0000ZA-Rt; Sat, 08 Jan 2022 11:14:51 +0000
Date:   Sat, 8 Jan 2022 19:13:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sanrio Alvares <sanrio.alvares@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        mika.westerberg@linux.intel.com,
        Sanrio Alvares <sanrio.alvares@intel.com>
Subject: Re: [PATCH] PCI / thunderbolt: Add quirk to handle incorrect
 Supported Link Speeds
Message-ID: <202201081937.sL6eGkBc-lkp@intel.com>
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
config: i386-randconfig-r024-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081937.sL6eGkBc-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/98f8f42acd1b8f46f3e6778fa58dd0d1cd005369
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sanrio-Alvares/PCI-thunderbolt-Add-quirk-to-handle-incorrect-Supported-Link-Speeds/20220107-064444
        git checkout 98f8f42acd1b8f46f3e6778fa58dd0d1cd005369
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/quirks.c:5304:6: warning: no previous prototype for function 'quirk_intel_tbt_supported_link_speeds' [-Wmissing-prototypes]
   void quirk_intel_tbt_supported_link_speeds(struct pci_dev *pdev)
        ^
   drivers/pci/quirks.c:5304:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void quirk_intel_tbt_supported_link_speeds(struct pci_dev *pdev)
   ^
   static 
   1 warning generated.


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
