Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530526F0D57
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbjD0Ujb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjD0Uja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 16:39:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7C3ABC;
        Thu, 27 Apr 2023 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682627969; x=1714163969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0YnxRyvY588QkIhQ/e9X8ygytR0EFyqhjT6BjUsq4hs=;
  b=m2xcqtHgOMrt6m7Kire8KD+JVUUJq9PNlYetN2kbk2CkRhNhmx9U7Acw
   gsCtjFFmNsBIqN891fM6FC2lqe6T+bBjAPBogjUHe1/BNnL4iNJPCRvVw
   CauQ4SnYUDiZ66KL7EUoSuUYlYtRI8gECoDbfFxGVeAlJrLSmWlTLUTkR
   4Og0F7v68ZLwJfr+IaRu1cIEeHENdmZw0KrOKF2nq7mwe9PYDjDELFjMT
   hm9lXWsAL1pJQLzKrSH2DateFKYG0yNbvbA5MXG7xFJbY5ufmkwoMDp+3
   PCx5muJVQwzRxg5hbVX19BChBooTwiC9j4vvbcZo3YbKaILQ7RkWtDjBn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412924070"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="412924070"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 13:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="868875373"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="868875373"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2023 13:39:26 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ps8Oj-00006V-1K;
        Thu, 27 Apr 2023 20:39:25 +0000
Date:   Fri, 28 Apr 2023 04:38:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 2/3] PCI/sysfs: create private functions for
 pci_create_legacy_files/pci_create_sysfs_dev_files
Message-ID: <202304280450.17v5JK13-lkp@intel.com>
References: <20230427142901.3570536-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427142901.3570536-3-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.3 next-20230427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Stein/PCI-sysfs-sort-headers-alphabetically/20230427-223059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230427142901.3570536-3-alexander.stein%40ew.tq-group.com
patch subject: [PATCH 2/3] PCI/sysfs: create private functions for pci_create_legacy_files/pci_create_sysfs_dev_files
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230428/202304280450.17v5JK13-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cbc778730116b49890b5c41ffc9fc664b566e3c4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Stein/PCI-sysfs-sort-headers-alphabetically/20230427-223059
        git checkout cbc778730116b49890b5c41ffc9fc664b566e3c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280450.17v5JK13-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/pci-sysfs.c:1256:12: warning: no previous prototype for 'pci_create_resource_files' [-Wmissing-prototypes]
    1256 | int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/pci-sysfs.c:1257:13: warning: no previous prototype for 'pci_remove_resource_files' [-Wmissing-prototypes]
    1257 | void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/pci-sysfs.c:1502:18: warning: no previous prototype for '__pci_create_sysfs_dev_files' [-Wmissing-prototypes]
    1502 | int __must_check __pci_create_sysfs_dev_files(struct pci_dev *pdev)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/pci-sysfs.c:1015:13: warning: '__pci_create_legacy_files' defined but not used [-Wunused-function]
    1015 | static void __pci_create_legacy_files(struct pci_bus *b) {}
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~


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
