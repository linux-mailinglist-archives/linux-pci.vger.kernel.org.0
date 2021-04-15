Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448EA36050A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhDOIzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 04:55:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:40508 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhDOIzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 04:55:40 -0400
IronPort-SDR: q4PeYCFsw39I+NdPGyTQzNx8rbG6ONHVxQH6rFNiTc4EF4JIK8lFCMvWu3mDIKmwXhXaeD/LVq
 kX/fD8fk1Yww==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194846713"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="194846713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 01:55:17 -0700
IronPort-SDR: VuixoVAUilZwgUsS71x03scpW3LHSGqTRNDN/VRuRauOEnhYD49mMFkmUqn1i0/Tmt6O39kL2a
 RskVL1qcXZeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="382665504"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2021 01:55:15 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWxmM-0000mM-RS; Thu, 15 Apr 2021 08:55:14 +0000
Date:   Thu, 15 Apr 2021 16:54:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/vpd] BUILD SUCCESS
 3eacfbe797a7b738387bb8c6adb703322bb6a944
Message-ID: <6077ff50.DuN75u9TtHaLvSt5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vpd
branch HEAD: 3eacfbe797a7b738387bb8c6adb703322bb6a944  PCI: Allow VPD access for QLogic ISP2722

elapsed time: 726m

configs tested: 191
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
arc                        vdk_hs38_defconfig
sparc                            alldefconfig
m68k                          sun3x_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
ia64                         bigsur_defconfig
powerpc                       maple_defconfig
arm                          ep93xx_defconfig
mips                            e55_defconfig
ia64                      gensparse_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
arm                         palmz72_defconfig
m68k                             alldefconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
mips                         tb0287_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
powerpc                     ep8248e_defconfig
s390                          debug_defconfig
powerpc                     tqm8555_defconfig
arm                         bcm2835_defconfig
sh                            migor_defconfig
mips                      maltasmvp_defconfig
xtensa                  cadence_csp_defconfig
arm                         shannon_defconfig
arm                         lpc32xx_defconfig
m68k                           sun3_defconfig
powerpc                      ppc44x_defconfig
sh                          rsk7264_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        spear6xx_defconfig
mips                      bmips_stb_defconfig
mips                          malta_defconfig
arm                            zeus_defconfig
mips                     cu1830-neo_defconfig
arm                          gemini_defconfig
m68k                             allmodconfig
microblaze                          defconfig
riscv                          rv32_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc8272_ads_defconfig
riscv                            alldefconfig
arm                          exynos_defconfig
xtensa                          iss_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
arm                           h3600_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
arm                      jornada720_defconfig
arm                            qcom_defconfig
powerpc                     pq2fads_defconfig
mips                     loongson1c_defconfig
powerpc                      bamboo_defconfig
mips                         cobalt_defconfig
alpha                            alldefconfig
powerpc                   currituck_defconfig
mips                          ath25_defconfig
mips                            gpr_defconfig
mips                           ci20_defconfig
arm                         s3c6400_defconfig
arm                          pcm027_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
powerpc64                           defconfig
powerpc                      arches_defconfig
h8300                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
arm                      tct_hammer_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
openrisc                    or1ksim_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
mips                     decstation_defconfig
arm                         at91_dt_defconfig
arm                        realview_defconfig
arc                        nsim_700_defconfig
m68k                       m5275evb_defconfig
arc                           tb10x_defconfig
powerpc                   bluestone_defconfig
i386                                defconfig
arm                          lpd270_defconfig
mips                        nlm_xlp_defconfig
powerpc                   motionpro_defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
powerpc                      acadia_defconfig
powerpc                      chrp32_defconfig
parisc                           alldefconfig
arc                        nsimosci_defconfig
sh                         ap325rxa_defconfig
sparc                               defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                            q40_defconfig
m68k                       m5249evb_defconfig
powerpc                     tqm8540_defconfig
powerpc                    socrates_defconfig
mips                           jazz_defconfig
sh                        apsh4ad0a_defconfig
um                            kunit_defconfig
powerpc                    sam440ep_defconfig
arm                             pxa_defconfig
arm                         hackkit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210414
i386                 randconfig-a006-20210414
i386                 randconfig-a001-20210414
i386                 randconfig-a005-20210414
i386                 randconfig-a004-20210414
i386                 randconfig-a002-20210414
x86_64               randconfig-a014-20210414
x86_64               randconfig-a015-20210414
x86_64               randconfig-a011-20210414
x86_64               randconfig-a013-20210414
x86_64               randconfig-a012-20210414
x86_64               randconfig-a016-20210414
i386                 randconfig-a015-20210414
i386                 randconfig-a014-20210414
i386                 randconfig-a013-20210414
i386                 randconfig-a012-20210414
i386                 randconfig-a016-20210414
i386                 randconfig-a011-20210414
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210414
x86_64               randconfig-a002-20210414
x86_64               randconfig-a005-20210414
x86_64               randconfig-a001-20210414
x86_64               randconfig-a006-20210414
x86_64               randconfig-a004-20210414

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
