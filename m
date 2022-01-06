Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93EA486713
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 16:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbiAFPw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 10:52:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:14911 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbiAFPwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 10:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641484345; x=1673020345;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KyUJuL/37AKZT213euKBPot/i+FxnNcZg6gJVwKYoZc=;
  b=dAeXtmNewmIE/6Lx9YrFqaLsdGgkyMzl6uSo+BecUizkWP9XpVIWqdRo
   zMJEvUUWSZh+TBbKB0VdCLM6gFg5JsPyhFRwQS9NrIAtsIS4O0WHN4IW/
   eO1mU/8BYgwM8zL2atX9fCgX++aLpABaL1hG9nWJEovrMY0bieXEbh1rg
   MCQGjxISYndYjdNJ1Iu9RvciXg1lWPmSZJEVZ2A16aDaMy32wKDJjIF1f
   oijR59Sk3PzRpJ8Rfrgzhr60DhelODYOvORW9Vl6ryc/EZyDcwwU3A2iM
   JPx/W2Dg8drphkqbn0oC3UYrFmQitKEmaPQK1+dn//EVfs4pq9nPXl9tW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240228302"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="240228302"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 07:52:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="689445704"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Jan 2022 07:52:23 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5V3v-000HlT-8q; Thu, 06 Jan 2022 15:52:23 +0000
Date:   Thu, 06 Jan 2022 23:52:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/vga2] BUILD SUCCESS
 b061dfeaaf6f4059ab1eab9950ca761e6c6abdf4
Message-ID: <61d71025.UmJALiKds8opbeQ7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vga2
branch HEAD: b061dfeaaf6f4059ab1eab9950ca761e6c6abdf4  vgaarb: Replace full MIT license text with SPDX identifier

elapsed time: 728m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220106
s390                       zfcpdump_defconfig
um                           x86_64_defconfig
arm                            lart_defconfig
sparc                            alldefconfig
sh                        apsh4ad0a_defconfig
arc                          axs103_defconfig
ia64                        generic_defconfig
sh                              ul2_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     tqm8541_defconfig
nios2                            alldefconfig
arm                            qcom_defconfig
sh                             espt_defconfig
xtensa                          iss_defconfig
powerpc                      ppc40x_defconfig
powerpc                    amigaone_defconfig
arm                             ezx_defconfig
sh                               alldefconfig
sparc                               defconfig
mips                       capcella_defconfig
m68k                       bvme6000_defconfig
openrisc                    or1ksim_defconfig
sh                          polaris_defconfig
parisc                              defconfig
mips                        vocore2_defconfig
powerpc                     redwood_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7785rp_defconfig
parisc                generic-64bit_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          pxa3xx_defconfig
powerpc                     mpc83xx_defconfig
sh                     sh7710voipgw_defconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
arm                  randconfig-c002-20220106
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20220106
x86_64               randconfig-a015-20220106
x86_64               randconfig-a014-20220106
x86_64               randconfig-a013-20220106
x86_64               randconfig-a011-20220106
x86_64               randconfig-a016-20220106
i386                 randconfig-a012-20220106
i386                 randconfig-a016-20220106
i386                 randconfig-a014-20220106
i386                 randconfig-a015-20220106
i386                 randconfig-a011-20220106
i386                 randconfig-a013-20220106
s390                 randconfig-r044-20220106
arc                  randconfig-r043-20220106
riscv                randconfig-r042-20220106
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220106
arm                  randconfig-c002-20220106
i386                 randconfig-c001-20220106
riscv                randconfig-c006-20220106
powerpc              randconfig-c003-20220106
x86_64               randconfig-c007-20220106
arm                          collie_defconfig
powerpc                      ppc44x_defconfig
arm                         socfpga_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          rm200_defconfig
arm                           spitz_defconfig
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a004-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106
x86_64               randconfig-a005-20220106
x86_64               randconfig-a001-20220106
x86_64               randconfig-a004-20220106
x86_64               randconfig-a006-20220106
x86_64               randconfig-a002-20220106
x86_64               randconfig-a003-20220106

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
