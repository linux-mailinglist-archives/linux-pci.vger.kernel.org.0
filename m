Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D102E5B69CF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiIMIrA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIMIq7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 04:46:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F6474DF
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663058818; x=1694594818;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZlSeYN9NGBI+GDg5zKONOXejVX5qcoCaAB030FNbO6Y=;
  b=It3aNkhn/npG3cNK377hqe67d17djpX/kIDv9vKVHb+X5QmrS8xvaNN0
   lV9O/j60mtSVyYidxjOjuAcMAWciJKpUr7Wy1tvqbK7gzLiHl/6V+hCHP
   dGUw2y9fORiTzMsAoBTsZ7wVkJo2vSVFjIYzEbaDdupcvcvbTWMWAD3Lb
   4qrUAJI4BMLUiY9/CjWhOe7pC7zm66mXcS6upmvEIjPrjIxnYtOVGayGH
   Gs6ZhPrQtLW7hd7b08uPrByM6GMVNvpGZtKE1YYhF7eY88BdRu2TFoPrj
   1FfsT6dhmsoI2eqdipOfeg1o96JabnAX1MNPmRLnhueTBdbJ8ZqU3UHVU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="285104627"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="285104627"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="616380384"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Sep 2022 01:46:56 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oY1ZH-0003Pv-1O;
        Tue, 13 Sep 2022 08:46:55 +0000
Date:   Tue, 13 Sep 2022 16:46:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD SUCCESS
 4c00cba122f3f3ae54aa5a3a1aec3afc7a2e6f94
Message-ID: <63204376.rAXgIzvhOpaWOZoM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: 4c00cba122f3f3ae54aa5a3a1aec3afc7a2e6f94  PCI/PM: Simplify pci_pm_suspend_noirq()

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a001-20220912
powerpc                          allmodconfig
i386                 randconfig-a002-20220912
mips                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20220912
sh                               allmodconfig
i386                 randconfig-a006-20220912
i386                 randconfig-a005-20220912
i386                 randconfig-a004-20220912
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64               randconfig-a001-20220912
x86_64                          rhel-8.3-func
x86_64               randconfig-a004-20220912
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a002-20220912
x86_64               randconfig-a005-20220912
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a003-20220912
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a006-20220912
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
riscv                randconfig-r042-20220911
arc                  randconfig-r043-20220912
arm                                 defconfig
arc                  randconfig-r043-20220911
m68k                             allyesconfig
s390                 randconfig-r044-20220911
m68k                             allmodconfig
arm64                            allyesconfig
arc                              allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a013-20220912
i386                 randconfig-a011-20220912
i386                 randconfig-a012-20220912
i386                 randconfig-a014-20220912
i386                 randconfig-a015-20220912
i386                 randconfig-a016-20220912
riscv                randconfig-r042-20220912
hexagon              randconfig-r041-20220912
hexagon              randconfig-r045-20220911
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220912
s390                 randconfig-r044-20220912
x86_64               randconfig-a014-20220912
x86_64               randconfig-a011-20220912
x86_64               randconfig-a012-20220912
x86_64               randconfig-a013-20220912
x86_64               randconfig-a016-20220912
x86_64               randconfig-a015-20220912

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
