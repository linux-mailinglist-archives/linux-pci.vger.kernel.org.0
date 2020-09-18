Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A726E26F954
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRJbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 05:31:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:42934 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgIRJbT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 05:31:19 -0400
IronPort-SDR: 7laTdno2xrtLKe1PE8H6cEpuEHomkAA0ClhKC/3QO3ltecwI4EaT+LLX1ZIdez7dy9HG2EW/zb
 9MwaOz7Whegg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244734661"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="244734661"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 02:31:18 -0700
IronPort-SDR: V2AK8CM6sprp/eNNSbWfAJTaQyiPmdf8odt81k8FhOxXoD1SWmcNpaZeZh7PsnZ62SQ9ByR22A
 w5Q+1Ra0ueRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="336746696"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2020 02:31:16 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJCja-0000Uh-MK; Fri, 18 Sep 2020 09:31:14 +0000
Date:   Fri, 18 Sep 2020 17:30:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 10791141a6cfc96eecf578fb1240f191ac112e02
Message-ID: <5f647e37.pKBG9FiqIJk6/9gj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: 10791141a6cfc96eecf578fb1240f191ac112e02  PCI: Simplify pci_dev_reset_slot_function()

elapsed time: 722m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                      axs103_smp_defconfig
powerpc               mpc834x_itxgp_defconfig
xtensa                              defconfig
powerpc                        cell_defconfig
mips                           ip22_defconfig
powerpc                     akebono_defconfig
powerpc                     rainier_defconfig
mips                       capcella_defconfig
powerpc                     kilauea_defconfig
arc                 nsimosci_hs_smp_defconfig
nds32                            alldefconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
arm                      pxa255-idp_defconfig
ia64                         bigsur_defconfig
powerpc                      makalu_defconfig
powerpc                  mpc866_ads_defconfig
sh                          rsk7269_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        nlm_xlp_defconfig
powerpc                      ppc6xx_defconfig
arc                             nps_defconfig
arm                           h5000_defconfig
mips                        bcm47xx_defconfig
arm                        neponset_defconfig
arc                        vdk_hs38_defconfig
arm                        mvebu_v5_defconfig
m68k                            mac_defconfig
mips                 decstation_r4k_defconfig
s390                          debug_defconfig
arm                      tct_hammer_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       multi_v4t_defconfig
arc                            hsdk_defconfig
arm                           spitz_defconfig
alpha                            allyesconfig
mips                  cavium_octeon_defconfig
nios2                         10m50_defconfig
powerpc                        fsp2_defconfig
mips                       lemote2f_defconfig
x86_64                           allyesconfig
powerpc                       maple_defconfig
sh                          sdk7780_defconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           tegra_defconfig
mips                        nlm_xlr_defconfig
arm                         s3c2410_defconfig
riscv                          rv32_defconfig
sh                        edosk7705_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     pq2fads_defconfig
um                           x86_64_defconfig
sh                              ul2_defconfig
ia64                      gensparse_defconfig
openrisc                         alldefconfig
sh                   sh7724_generic_defconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
arm                          iop32x_defconfig
m68k                        m5272c3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200918
i386                 randconfig-a011-20200918
i386                 randconfig-a014-20200918
i386                 randconfig-a013-20200918
i386                 randconfig-a012-20200918
i386                 randconfig-a016-20200918
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
