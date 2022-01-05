Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6D485817
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 19:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiAESWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 13:22:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:47359 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242844AbiAESV5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 13:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641406917; x=1672942917;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=08NBb+fNeOyFFeTNOn2L1SUThdTbNcvyZrPR1Dwmto4=;
  b=nDqVJlW99xYuVF9R4i/PNytC9AUDVEkX4tsx23nru4TIYHcw4kOAa5+J
   ICYNvFJ1YDUd68LCyIYlGtj5CtMasJVT0NkZIuxOTMapwoxqhoeAV2Afg
   ZycBo/Tqmo1kzLyHLTVIR4nZALcbmPX3mxRLDCNfobjUdXnk4/l+059WB
   3aLkCKb+lUd1qEk0OqYIzJlVslQengS+jdRbM88nxxSDZFR922iqnWCyE
   RaOpDAEtWWqp1GxQTOBmBP3qrjmeycpvBsOhf8mVj3An4JVhd6+JeKuMM
   lT3myrGlP7ID9Qz3CMP9cVU+Jep52VQAlNYLaWMBUsq4909MFk6WsqSSw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242711797"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242711797"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="472593863"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2022 10:21:49 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5Auy-000GvZ-Ag; Wed, 05 Jan 2022 18:21:48 +0000
Date:   Thu, 06 Jan 2022 02:21:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/vga2] BUILD SUCCESS
 91ca1c7c1e057c0bddffe043c0e74ae9f9ec756e
Message-ID: <61d5e199.9mAk8blNBhF+by5K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vga2
branch HEAD: 91ca1c7c1e057c0bddffe043c0e74ae9f9ec756e  vgaarb: Use disabled device as last resort

elapsed time: 724m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220105
mips                         db1xxx_defconfig
sh                         apsh4a3a_defconfig
sh                         microdev_defconfig
arc                            hsdk_defconfig
powerpc                 mpc834x_mds_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
sh                           se7705_defconfig
sh                 kfr2r09-romimage_defconfig
sh                            migor_defconfig
xtensa                  cadence_csp_defconfig
mips                         rt305x_defconfig
sh                                  defconfig
arc                        vdk_hs38_defconfig
mips                             allyesconfig
sh                        edosk7760_defconfig
arm                            pleb_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            zeus_defconfig
ia64                                defconfig
arm                           sunxi_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 linkstation_defconfig
arm                           stm32_defconfig
powerpc                        warp_defconfig
arm                          lpd270_defconfig
m68k                       m5475evb_defconfig
m68k                         apollo_defconfig
m68k                             allmodconfig
arm                             rpc_defconfig
sh                        apsh4ad0a_defconfig
arm                        shmobile_defconfig
mips                      fuloong2e_defconfig
arm                           u8500_defconfig
h8300                               defconfig
powerpc                           allnoconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
powerpc                     sequoia_defconfig
powerpc                      makalu_defconfig
arm                        spear6xx_defconfig
powerpc                       ppc64_defconfig
powerpc                  iss476-smp_defconfig
i386                             alldefconfig
nds32                               defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc85xx_cds_defconfig
h8300                            allyesconfig
sh                   sh7770_generic_defconfig
powerpc                     tqm8555_defconfig
sh                            shmin_defconfig
arm                  randconfig-c002-20220105
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20220105
x86_64               randconfig-a001-20220105
x86_64               randconfig-a004-20220105
x86_64               randconfig-a006-20220105
x86_64               randconfig-a003-20220105
x86_64               randconfig-a002-20220105
i386                 randconfig-a003-20220105
i386                 randconfig-a005-20220105
i386                 randconfig-a004-20220105
i386                 randconfig-a006-20220105
i386                 randconfig-a002-20220105
i386                 randconfig-a001-20220105
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                  mpc885_ads_defconfig
arm                        multi_v5_defconfig
riscv                          rv32_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     akebono_defconfig
arm                         hackkit_defconfig
arm                              alldefconfig
powerpc                   lite5200b_defconfig
arm                            dove_defconfig
mips                        qi_lb60_defconfig
arm                           spitz_defconfig
arm                         s3c2410_defconfig
x86_64               randconfig-a012-20220105
x86_64               randconfig-a015-20220105
x86_64               randconfig-a014-20220105
x86_64               randconfig-a013-20220105
x86_64               randconfig-a011-20220105
x86_64               randconfig-a016-20220105
i386                 randconfig-a012-20220105
i386                 randconfig-a016-20220105
i386                 randconfig-a015-20220105
i386                 randconfig-a014-20220105
i386                 randconfig-a011-20220105
i386                 randconfig-a013-20220105
hexagon              randconfig-r041-20220105
hexagon              randconfig-r045-20220105
riscv                randconfig-r042-20220105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
