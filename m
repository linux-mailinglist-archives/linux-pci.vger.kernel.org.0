Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D2A5A0945
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 08:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiHYG5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 02:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiHYG5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 02:57:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D6A0613
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661410650; x=1692946650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZtjWtQJ+89E9tVDKNx5H8VC3v3OMY79ymxg8rEBhFuA=;
  b=kO7olw4Cfb6uFTEmHCY0Dw78viY7a0U+jz0SurRw168H11F0MEwp019U
   Jb6rpCJdAUVAjW4neS/e4GTcZH5EDBq4MIx9ThX29aOhltygkdBqwvZzs
   8M5C+df4CuSP7n0qPU+uMP8momBrGNZV0+uY2gqSjA5MF2+fSa2/y60pI
   iuHiyaV8mAOPeyyfh/fIy8epyJjKZOjA3GIQelk/gXX86+nlaP2dRy2he
   J2xOMGcDf0y/pICV5xxV9pGPFLF+RKvNSC/ObwhCOPxWCrbWbwtIPgzb7
   c13ze8tcYQdJg3ZUzdkmucdi+vCxD9YP2+Extbzi7nh25iKHsjxARC659
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="274553803"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="274553803"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="560908693"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2022 23:57:28 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR6nv-0001of-1x;
        Thu, 25 Aug 2022 06:57:27 +0000
Date:   Thu, 25 Aug 2022 14:56:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/mvebu] BUILD SUCCESS
 2e379ac66d4b734ba0e6dbdbc20f774d91be090b
Message-ID: <63071d2f.91c9+a0dkxMIna57%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/mvebu
branch HEAD: 2e379ac66d4b734ba0e6dbdbc20f774d91be090b  PCI: mvebu: Fix endianness when accessing PCI emul bridge members

elapsed time: 2553m

configs tested: 177
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220823
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                              allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                              defconfig
i386                             allyesconfig
i386                                defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
parisc                           alldefconfig
powerpc                     tqm8555_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                               j2_defconfig
sh                           se7721_defconfig
m68k                          amiga_defconfig
sh                             shx3_defconfig
powerpc                      tqm8xx_defconfig
ia64                                defconfig
m68k                        stmark2_defconfig
i386                          randconfig-c001
sh                           se7724_defconfig
arm                         lubbock_defconfig
powerpc                   currituck_defconfig
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
powerpc                    klondike_defconfig
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
m68k                            mac_defconfig
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                      axs103_smp_defconfig
arm                            hisi_defconfig
um                                  defconfig
sh                     sh7710voipgw_defconfig
parisc64                         alldefconfig
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
arm                           h5000_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
mips                             allmodconfig
m68k                            q40_defconfig
ia64                        generic_defconfig
arc                     nsimosci_hs_defconfig
m68k                         apollo_defconfig
arm                        shmobile_defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
arm                             rpc_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-c001
arm                  randconfig-c002-20220824
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
sh                          rsk7269_defconfig
xtensa                         virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      makalu_defconfig
arm                            pleb_defconfig
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
mips                    maltaup_xpa_defconfig
sh                         ecovec24_defconfig
m68k                       m5249evb_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig

clang tested configs:
hexagon              randconfig-r041-20220823
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220823
x86_64                        randconfig-a005
riscv                randconfig-r042-20220823
s390                 randconfig-r044-20220823
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                            mmp2_defconfig
powerpc                     powernv_defconfig
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
powerpc                     ppa8548_defconfig
powerpc                  mpc866_ads_defconfig
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220824
mips                        omega2p_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        neponset_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                          g5_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8560_ads_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
