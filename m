Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815EA4D6C19
	for <lists+linux-pci@lfdr.de>; Sat, 12 Mar 2022 03:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiCLCtO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 21:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLCtN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 21:49:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0982274DD
        for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2022 18:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647053289; x=1678589289;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SkMPeFXDMOBSBNECnsOUr2BauZIu4cyCY92m8ybYLfM=;
  b=MUcGuYX9lydKU6f7Qu7qIyxejB9EwZqwYJvdEc8bqgghCVi08AG2usXs
   wRr175A8VEm+Ehej4GL4mw52Cm4SGpZiiho0H9zz1Y6ulzn+vSArcq9d1
   /OLlEi/gk+J/IIGDuGc6qhG9w7AsBUgGF6Wa1SCJ0ZftVoY4adH5hFbbA
   j9d5Zf0CnZ/zI/cO4AfsO8tFfY16yEjAVL9hhW48sGY5vz7FE/8vkvei2
   1/Sg2XYmIvnV0FCEcbtindFxaw+dpyLtMIpVuPUo0RK+6MO6KVr1gmZ2W
   ZhzD9IdlGw2O3UfPD0/ajT5UR21rj5zyhM5+vF3fWBFj034hsJ0w7Gfl6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="280471179"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="280471179"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 18:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="713078177"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 18:48:07 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSrna-0007QR-U0; Sat, 12 Mar 2022 02:48:06 +0000
Date:   Sat, 12 Mar 2022 10:48:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 5949965ec9340cfc0e65f7d8a576b660b26e2535
Message-ID: <622c09e1.0oo98CLnV2QKfMyH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 5949965ec9340cfc0e65f7d8a576b660b26e2535  x86/PCI: Preserve host bridge windows completely covered by E820

elapsed time: 720m

configs tested: 85
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                           h3600_defconfig
riscv                            allmodconfig
powerpc                 mpc85xx_cds_defconfig
mips                           gcw0_defconfig
sh                        apsh4ad0a_defconfig
m68k                           sun3_defconfig
powerpc                 mpc834x_mds_defconfig
sh                   sh7724_generic_defconfig
m68k                          amiga_defconfig
sh                            migor_defconfig
m68k                        mvme16x_defconfig
arc                           tb10x_defconfig
arm                           viper_defconfig
powerpc                       ppc64_defconfig
ia64                      gensparse_defconfig
mips                      fuloong2e_defconfig
arm                  randconfig-c002-20220310
arm                  randconfig-c002-20220312
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220310
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220310
riscv                randconfig-c006-20220310
mips                 randconfig-c004-20220310
i386                          randconfig-c001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
