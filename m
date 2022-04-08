Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107EE4F8DC3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiDHEy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiDHEyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 00:54:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD886ABF53
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649393542; x=1680929542;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zEszkAVb21nsmB3ybAWb2zTpCLXHkLqsVRlhqG3dgxE=;
  b=Ex5S+FvPXSJSYTed6kN3xyjLOCiRId3vQJ/cUm5lpK3oDzT8HWwXF1Cn
   YItjOgKer7xBf1iRuKS4HFg1oL3m7mS1NvFgsbpbwjsN6tRNkG1G3uaom
   n4vxIHVaNUu7CLGEUe6H55Wb9UQwQt+MrTmgv63T9VlsdiyfIk8flQtD6
   bluuXgT8hnjzwZrAErVnJ8hwjvimBJ2KTUtwppbY4WZvx9dIFp+rcfMpQ
   i/oVCmx9/C3tjV4I4/OLogWqtpKZI4OXfYdl9TaHPupzC0c17Qd5TUJgr
   RyOn6+T+fjfRNcKxWkHEpreaeFLp3Kfm0Hches0Bl7fsOe2+PwKlIbzLH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243642202"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="243642202"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 21:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="621504728"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2022 21:52:20 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncgbb-00062e-IS;
        Fri, 08 Apr 2022 04:52:19 +0000
Date:   Fri, 08 Apr 2022 12:51:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD REGRESSION
 53b3488879cff3b3a238e3e9651c2e2879f422cf
Message-ID: <624fbf65.aaszBFyNDncqqRDo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: 53b3488879cff3b3a238e3e9651c2e2879f422cf  PCI/PM: Power up all devices during runtime resume

Error/Warning reports:

https://lore.kernel.org/linux-pci/202204080225.iXDZAkO2-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/pci-driver.c:1315:9: error: implicit declaration of function 'pci_pm_default_resume_early'; did you mean 'pci_pm_default_resume'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r043-20220407
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- arm64-randconfig-r031-20220407
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- i386-randconfig-a014
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- i386-randconfig-c001
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-allmodconfig
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-allyesconfig
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-buildonly-randconfig-r001-20220406
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-buildonly-randconfig-r001-20220407
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-randconfig-r006-20220407
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-randconfig-r013-20220407
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-randconfig-r031-20220406
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- ia64-randconfig-r036-20220406
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- powerpc-randconfig-p002-20220406
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- riscv-allmodconfig
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- riscv-allyesconfig
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- riscv-defconfig
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- riscv-rv32_defconfig
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- sparc64-buildonly-randconfig-r006-20220407
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- x86_64-randconfig-a015
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
|-- x86_64-randconfig-c022
|   `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early
`-- xtensa-allyesconfig
    `-- drivers-pci-pci-driver.c:error:implicit-declaration-of-function-pci_pm_default_resume_early

elapsed time: 730m

configs tested: 134
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           h5000_defconfig
sh                         apsh4a3a_defconfig
arm                        shmobile_defconfig
sh                          rsk7201_defconfig
powerpc                     asp8347_defconfig
powerpc                      bamboo_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
arc                            hsdk_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7780_defconfig
sparc64                          alldefconfig
ia64                          tiger_defconfig
sparc64                             defconfig
arm                             ezx_defconfig
powerpc                 mpc834x_itx_defconfig
arm                        clps711x_defconfig
sh                   sh7770_generic_defconfig
ia64                            zx1_defconfig
arm                             pxa_defconfig
sparc                               defconfig
powerpc                      pcm030_defconfig
arc                        vdk_hs38_defconfig
sh                ecovec24-romimage_defconfig
riscv                               defconfig
powerpc                     stx_gp3_defconfig
powerpc                       ppc64_defconfig
xtensa                          iss_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220406
arm                  randconfig-c002-20220407
arm                  randconfig-c002-20220408
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220406
arc                  randconfig-r043-20220407
arc                  randconfig-r043-20220408
s390                 randconfig-r044-20220408
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
riscv                randconfig-r042-20220408
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220406
s390                 randconfig-c005-20220407
powerpc              randconfig-c003-20220407
powerpc              randconfig-c003-20220406
riscv                randconfig-c006-20220407
riscv                randconfig-c006-20220406
mips                 randconfig-c004-20220407
mips                 randconfig-c004-20220406
arm                  randconfig-c002-20220406
arm                  randconfig-c002-20220407
arm                       aspeed_g4_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                  colibri_pxa270_defconfig
arm                             mxs_defconfig
arm                            dove_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220406
hexagon              randconfig-r045-20220408
hexagon              randconfig-r045-20220406
hexagon              randconfig-r041-20220407
hexagon              randconfig-r041-20220408
hexagon              randconfig-r045-20220407
s390                 randconfig-r044-20220407
riscv                randconfig-r042-20220407

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
