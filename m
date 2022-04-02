Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807334F0025
	for <lists+linux-pci@lfdr.de>; Sat,  2 Apr 2022 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiDBJfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Apr 2022 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiDBJfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Apr 2022 05:35:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FF44B432
        for <linux-pci@vger.kernel.org>; Sat,  2 Apr 2022 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648892040; x=1680428040;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cg6yR5gEeljGUgPNzFhqVtoDLtLucnDV4Z5cOpIpdkw=;
  b=MVULBR4o/z6+799oDx6gjqaoRxRPjvrgEmoTVZbsMGlafGaCae6cCzw1
   K0gLLK9Y4roHr0kYO/l0O2VtJGABDybW5ykCMX6Auq2P6pz72lgn29q71
   cx3QVrCWp6/bnDhkxpO82WWqpKHmpB2pQZ8Py+JCMSORi1n/8JyC/QJ9o
   cFeWR3s5M0EgSx+kcuZbwlvBAcLO4sQ7p0pwnimwcs0p35syQEkoXq1VT
   Te972/NOjw6lJ59EjTNX8P0OZ4f44Jjf9TVIeRdejEugdSnHE50/qFW65
   yWsTT6RMzdzobsLnK/CTcqX70u4OwamrmRiR2XHrbPGNebNIATj+5CYpO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259119150"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259119150"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 02:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="504425928"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2022 02:33:58 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naa8r-00027s-UT;
        Sat, 02 Apr 2022 09:33:57 +0000
Date:   Sat, 02 Apr 2022 17:33:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 c1d27b79a94fea1741e643ec0e3e24fe6e1aadf8
Message-ID: <6248184c.lvk9pQ5CtVBxtw2t%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: c1d27b79a94fea1741e643ec0e3e24fe6e1aadf8  PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3

elapsed time: 934m

configs tested: 135
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220331
arm                        clps711x_defconfig
arm                       aspeed_g5_defconfig
powerpc                     rainier_defconfig
h8300                       h8s-sim_defconfig
arm                          iop32x_defconfig
arc                        vdk_hs38_defconfig
sh                           sh2007_defconfig
arm                             pxa_defconfig
arm                          simpad_defconfig
mips                  decstation_64_defconfig
arm                            qcom_defconfig
arc                           tb10x_defconfig
h8300                     edosk2674_defconfig
sh                          r7785rp_defconfig
m68k                       m5208evb_defconfig
powerpc                      makalu_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                      loongson3_defconfig
riscv                            allmodconfig
powerpc                     stx_gp3_defconfig
microblaze                          defconfig
sh                          urquell_defconfig
sh                          rsk7201_defconfig
arm                          gemini_defconfig
alpha                               defconfig
arm                         vf610m4_defconfig
mips                 decstation_r4k_defconfig
arm                        shmobile_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220402
arm                  randconfig-c002-20220331
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220402
s390                 randconfig-r044-20220402
riscv                randconfig-r042-20220402
arc                  randconfig-r043-20220331
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220402
riscv                randconfig-c006-20220402
mips                 randconfig-c004-20220402
arm                  randconfig-c002-20220402
powerpc                      obs600_defconfig
arm                        neponset_defconfig
powerpc                    socrates_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
powerpc                      acadia_defconfig
powerpc                     ksi8560_defconfig
mips                           ip22_defconfig
arm                         hackkit_defconfig
powerpc                     kmeter1_defconfig
mips                          ath79_defconfig
arm                          ep93xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
s390                 randconfig-r044-20220331
hexagon              randconfig-r041-20220331
hexagon              randconfig-r045-20220331
riscv                randconfig-r042-20220331

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
