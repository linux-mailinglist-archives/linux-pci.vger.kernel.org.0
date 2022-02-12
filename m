Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1114B3503
	for <lists+linux-pci@lfdr.de>; Sat, 12 Feb 2022 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiBLMtw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Feb 2022 07:49:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBLMtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Feb 2022 07:49:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E3925D
        for <linux-pci@vger.kernel.org>; Sat, 12 Feb 2022 04:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644670188; x=1676206188;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BK0lhdgmXYnW8fEAq3ReliawlGGfdm1qhGK30issC14=;
  b=GcMwgpul3+JlHDVqYDiyH1e7RnkQHggVZobv2auioSXVSB/xq8n3KTLS
   EkWJwlOs0hLaTe6rHE6Fw+8iuxYYy+SG9on7nyKql4OJ8GlhhBErtV1g5
   +69uK7OZAN/AHR5ZNtavPN0ePb6zzJA9Zt9G2JNIUlASpeZxaJWOzzKR2
   /1MqyCg2ej64F4xQ/eapSvTLvb6tNLVY9+sct+WTcZSBEQaHY8fkZJrFU
   5F3PVrgZmHWF5+gZqRiubcAs4dkva4ovv14+hXixnuFfwQoTwX96iMO6o
   xcjZRNiGGAf4cQU7rwdZVqTRW9JBEVWEqgk6b347dP59X6pTFUWpvYxmq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="336300760"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="336300760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 04:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="569318684"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2022 04:49:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIrqU-00069j-7J; Sat, 12 Feb 2022 12:49:46 +0000
Date:   Sat, 12 Feb 2022 20:49:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 075b7d363c675ef7fa03918881caeca3458e2a96
Message-ID: <6207acbd.EX47rICmR51yquf/%lkp@intel.com>
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
branch HEAD: 075b7d363c675ef7fa03918881caeca3458e2a96  Revert "PCI/portdrv: Do not setup up IRQs if there are no users"

elapsed time: 734m

configs tested: 147
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                      chrp32_defconfig
xtensa                    xip_kc705_defconfig
sh                               allmodconfig
openrisc                            defconfig
mips                          rb532_defconfig
m68k                          hp300_defconfig
mips                        bcm47xx_defconfig
xtensa                  cadence_csp_defconfig
sh                          kfr2r09_defconfig
arm                           h3600_defconfig
sh                        edosk7760_defconfig
powerpc                     stx_gp3_defconfig
mips                        vocore2_defconfig
ia64                        generic_defconfig
xtensa                       common_defconfig
ia64                             alldefconfig
powerpc                    sam440ep_defconfig
ia64                             allmodconfig
powerpc                   currituck_defconfig
powerpc                    adder875_defconfig
arm                        shmobile_defconfig
sh                          sdk7780_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                         virt_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc64                           defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
nds32                             allnoconfig
alpha                            allyesconfig
mips                           ip32_defconfig
sh                        dreamcast_defconfig
m68k                        stmark2_defconfig
arm                          pxa3xx_defconfig
xtensa                generic_kc705_defconfig
arm                           sama5_defconfig
powerpc                      bamboo_defconfig
arc                     nsimosci_hs_defconfig
arm                           u8500_defconfig
ia64                      gensparse_defconfig
arm                          simpad_defconfig
sh                          landisk_defconfig
sh                              ul2_defconfig
m68k                        mvme16x_defconfig
mips                       bmips_be_defconfig
xtensa                    smp_lx200_defconfig
x86_64                              defconfig
arm                        realview_defconfig
m68k                        mvme147_defconfig
riscv                               defconfig
nds32                               defconfig
sh                      rts7751r2d1_defconfig
sh                          rsk7203_defconfig
arc                      axs103_smp_defconfig
um                           x86_64_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220211
arm                  randconfig-c002-20220212
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220212
arc                  randconfig-r043-20220211
arc                  randconfig-r043-20220212
s390                 randconfig-r044-20220212
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220211
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
i386                          randconfig-c001
mips                 randconfig-c004-20220211
mips                     cu1830-neo_defconfig
mips                      malta_kvm_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
mips                        maltaup_defconfig
arm                          collie_defconfig
arm                         palmz72_defconfig
riscv                             allnoconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220211
hexagon              randconfig-r041-20220211
riscv                randconfig-r042-20220211

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
