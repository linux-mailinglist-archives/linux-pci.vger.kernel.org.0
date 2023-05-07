Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792286F97D4
	for <lists+linux-pci@lfdr.de>; Sun,  7 May 2023 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEGJGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 May 2023 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGJGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 May 2023 05:06:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2D13C12;
        Sun,  7 May 2023 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683450393; x=1714986393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObwBHhpjW+EYmpG1SC4zZ6cBhW2d+cGNNSnYZsS3dvk=;
  b=bJEUCk21poE/X1l2PSpcn44CjjGcB/9stJ0ogLCGeDjeK3PrnTxQyyaU
   Qz7H+SNd/g4EcD2oiX9h0mpef6OSIn6NxAcDxq3q2z851Rkn8YogYuVMZ
   5Aq2uZ3uL/Ah2H5I1kmCycqSF7BgwzkdrqNQ5lLkH0ulJMRD4pW8wIC3U
   PBjUhTaV51F/c6czhWNEz3Fw8nFwRK6SCJeD8rYsxOpRmETRfmf1ZYcSZ
   OI0ECH01qRS8Vlrau+pwDPdAdH/8RMsrUm4EGGGt3CsADw8Rq/pcQeLDa
   YbSW2q5m0tU72nn5rYr9Fe+AIMzhPw/hQ0HV4ShMAtd06A19yC8rAyrkA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="349495139"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="349495139"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 02:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="692262613"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="692262613"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 May 2023 02:06:31 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvaLe-0000hl-0n;
        Sun, 07 May 2023 09:06:30 +0000
Date:   Sun, 7 May 2023 17:05:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 2/3] PCI/sysfs: create private functions for
 pci_create_legacy_files/pci_create_sysfs_dev_files
Message-ID: <202305071649.zjynmg3E-lkp@intel.com>
References: <20230427142901.3570536-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427142901.3570536-3-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.3 next-20230505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Stein/PCI-sysfs-sort-headers-alphabetically/20230427-223059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230427142901.3570536-3-alexander.stein%40ew.tq-group.com
patch subject: [PATCH 2/3] PCI/sysfs: create private functions for pci_create_legacy_files/pci_create_sysfs_dev_files
config: mips-maltaup_defconfig (https://download.01.org/0day-ci/archive/20230507/202305071649.zjynmg3E-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/cbc778730116b49890b5c41ffc9fc664b566e3c4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Stein/PCI-sysfs-sort-headers-alphabetically/20230427-223059
        git checkout cbc778730116b49890b5c41ffc9fc664b566e3c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pci/ mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305071649.zjynmg3E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci-sysfs.c:1502:18: warning: no previous prototype for function '__pci_create_sysfs_dev_files' [-Wmissing-prototypes]
   int __must_check __pci_create_sysfs_dev_files(struct pci_dev *pdev)
                    ^
   drivers/pci/pci-sysfs.c:1502:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __must_check __pci_create_sysfs_dev_files(struct pci_dev *pdev)
   ^
   static 
   drivers/pci/pci-sysfs.c:1015:13: warning: unused function '__pci_create_legacy_files' [-Wunused-function]
   static void __pci_create_legacy_files(struct pci_bus *b) {}
               ^
   2 warnings generated.


vim +/__pci_create_sysfs_dev_files +1502 drivers/pci/pci-sysfs.c

  1501	
> 1502	int __must_check __pci_create_sysfs_dev_files(struct pci_dev *pdev)
  1503	{
  1504		return pci_create_resource_files(pdev);
  1505	}
  1506	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
