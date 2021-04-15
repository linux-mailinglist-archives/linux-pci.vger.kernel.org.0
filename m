Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B836043B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhDOI0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 04:26:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:22201 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhDOI0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 04:26:38 -0400
IronPort-SDR: sGnV2ewzAiKH7Im3q/Vy5l2vsiIjmajm0YEr433yGb2fh8Y6YSG6pG43l8xHE17LiTbEDqBlUT
 jbL2d3JYgZgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194374605"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="194374605"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 01:26:16 -0700
IronPort-SDR: BtWCZpsYbzyszReTfYh1+nDJtfp4wiCWS2NW8mL371QY54hzoSW0owOReH3gkstgKxmn75NqkG
 U4pijRjPdE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="522286446"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2021 01:26:15 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWxKI-0000li-B8; Thu, 15 Apr 2021 08:26:14 +0000
Date:   Thu, 15 Apr 2021 16:25:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS e4e573c9a39080f43693c70e4efd805674ba0216
Message-ID: <6077f87a.JjG+hwixGvqvNMQ/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: e4e573c9a39080f43693c70e4efd805674ba0216  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 720m

configs tested: 174
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                       maple_defconfig
arm                          ep93xx_defconfig
mips                            e55_defconfig
ia64                      gensparse_defconfig
m68k                             alldefconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
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
arm                         palmz72_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
arm                      jornada720_defconfig
powerpc                     redwood_defconfig
powerpc                        fsp2_defconfig
arm                       versatile_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
arm                            qcom_defconfig
powerpc                     pq2fads_defconfig
mips                     loongson1c_defconfig
powerpc                      bamboo_defconfig
mips                         cobalt_defconfig
arc                        vdk_hs38_defconfig
arm                         s3c6400_defconfig
arm                          pcm027_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
powerpc                      arches_defconfig
h8300                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                      integrator_defconfig
powerpc                        icon_defconfig
arm                         axm55xx_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
mips                     decstation_defconfig
powerpc                    sam440ep_defconfig
mips                           ip28_defconfig
m68k                       bvme6000_defconfig
powerpc                       eiger_defconfig
riscv                             allnoconfig
powerpc                   bluestone_defconfig
i386                                defconfig
arm                          lpd270_defconfig
mips                        nlm_xlp_defconfig
powerpc                      chrp32_defconfig
parisc                           alldefconfig
arc                        nsimosci_defconfig
sh                         ap325rxa_defconfig
sparc                               defconfig
powerpc                       ppc64_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         db1xxx_defconfig
arm                             pxa_defconfig
arm                         hackkit_defconfig
sh                           se7751_defconfig
powerpc                     kilauea_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                 randconfig-a003-20210415
i386                 randconfig-a006-20210415
i386                 randconfig-a001-20210415
i386                 randconfig-a005-20210415
i386                 randconfig-a004-20210415
i386                 randconfig-a002-20210415
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
i386                 randconfig-a015-20210415
i386                 randconfig-a014-20210415
i386                 randconfig-a013-20210415
i386                 randconfig-a012-20210415
i386                 randconfig-a016-20210415
i386                 randconfig-a011-20210415
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
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
