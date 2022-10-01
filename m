Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55975F1C9F
	for <lists+linux-pci@lfdr.de>; Sat,  1 Oct 2022 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJAOQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Oct 2022 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJAOQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Oct 2022 10:16:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940D3D59B
        for <linux-pci@vger.kernel.org>; Sat,  1 Oct 2022 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664633809; x=1696169809;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CKTX3AOrT38fatbYgiX7En4c2LxaJ7Sy+M/cl4pSKKo=;
  b=PZ3CgU0s+ECJe2aiSx24W6OJJlzDyW9yMaLySKaU4xypCHobNMgkwzAW
   Q6OpNHNgFdObPS4hEuxgFDLp1AAgNbx+EOBZ4iLT4emdcGiiWzNR7z/sD
   M0Nvk84KUTJqJZ6LJK6veqHmfG6gVAIUI78hY3iJZyQ8sEudXAs0qZiWZ
   9z8x9NKzdkwnYo9VbCP5bCN8D/1ejfdRUf+IcAwPwVkY2oK/L8B2maGC1
   BNnr2ER9hvDVf5ozR6/9hefNhA7Qc3D5HhcKhWSrmwodKEeRa6ycGGFT9
   C9DFxqEC58Z8bFmH9bS8k7Jajdt0ssJ5l8gvWOcLE55ojuNmd+XDweMaL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="301102454"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="301102454"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 07:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="712116296"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="712116296"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2022 07:16:35 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oedIA-0002LB-2j;
        Sat, 01 Oct 2022 14:16:34 +0000
Date:   Sat, 01 Oct 2022 22:15:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD SUCCESS
 3e347969a5776947a115649dae740a9ed47473f5
Message-ID: <63384b98.ZvImtL32ldWB3TKX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: 3e347969a5776947a115649dae740a9ed47473f5  PCI/PM: Reduce D3hot delay with usleep_range()

elapsed time: 2540m

configs tested: 198
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                          rhel-8.3-func
s390                             allmodconfig
arc                              allyesconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
s390                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
i386                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a005-20220926
x86_64                        randconfig-a004
i386                 randconfig-a006-20220926
x86_64                        randconfig-a002
arc                  randconfig-r043-20220925
x86_64                        randconfig-a006
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
riscv                randconfig-r042-20220925
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                           se7722_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
sh                        edosk7760_defconfig
mips                         rt305x_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                         assabet_defconfig
sh                            hp6xx_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                             allnoconfig
powerpc                    sam440ep_defconfig
arm                         at91_dt_defconfig
m68k                        mvme147_defconfig
x86_64                           alldefconfig
m68k                        m5307c3_defconfig
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a003-20220926
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                        cell_defconfig
m68k                                defconfig
arm                          gemini_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
sh                             shx3_defconfig
sh                     magicpanelr2_defconfig
mips                      fuloong2e_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                      ppc6xx_defconfig
sh                          rsk7269_defconfig
arm                            xcep_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
arm                          pxa3xx_defconfig
sh                          landisk_defconfig
powerpc                      cm5200_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
m68k                       m5249evb_defconfig
riscv                               defconfig
sh                   sh7770_generic_defconfig
mips                           ip32_defconfig
powerpc                     taishan_defconfig
arm                        shmobile_defconfig
ia64                                defconfig
arm                            mps2_defconfig
loongarch                        allmodconfig
powerpc                        warp_defconfig
arc                      axs103_smp_defconfig
riscv                randconfig-r042-20221001
arc                  randconfig-r043-20221001
s390                 randconfig-r044-20221001
arc                          axs101_defconfig
mips                 decstation_r4k_defconfig
sh                           se7712_defconfig
arm                         lpc18xx_defconfig
arm                       aspeed_g5_defconfig
mips                  maltasmvp_eva_defconfig
arm                           h5000_defconfig
m68k                          atari_defconfig
powerpc                      chrp32_defconfig
sh                        edosk7705_defconfig
sh                         ap325rxa_defconfig
arm                        spear6xx_defconfig
sh                         ecovec24_defconfig
riscv                randconfig-r042-20220927
arc                  randconfig-r043-20220927
s390                 randconfig-r044-20220927
powerpc                       ppc64_defconfig
arm                           sunxi_defconfig
powerpc                     rainier_defconfig
arm64                               defconfig
arm                              allmodconfig
mips                             allmodconfig
arm                          simpad_defconfig
m68k                           sun3_defconfig
sh                      rts7751r2d1_defconfig
alpha                            alldefconfig
mips                           gcw0_defconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220925
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
x86_64                        randconfig-a005
riscv                randconfig-r042-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a012-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a016-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
hexagon              randconfig-r041-20220928
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                   microwatt_defconfig
mips                      malta_kvm_defconfig
powerpc                  mpc885_ads_defconfig
arm                         hackkit_defconfig
powerpc                      walnut_defconfig
mips                        maltaup_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                          moxart_defconfig
arm                         mv78xx0_defconfig
riscv                    nommu_virt_defconfig
powerpc                        icon_defconfig
arm                          pxa168_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                          allyesconfig
mips                     loongson1c_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
