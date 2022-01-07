Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420764874E0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 10:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiAGJkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 04:40:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:29051 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236952AbiAGJkx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 04:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641548452; x=1673084452;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jRYJegt5AAojK6irwBTOV1j9rPLDKGl+Je1EUI5Jyw8=;
  b=Ue+vMbmisjyjKkA7xqqBYstgxX/Ac5QLU8t9n7/0QhircrU51ZsyTYj5
   F6VE3ZTSY3Yz1GIimwaR4+3FTj9oNF/aiSXs4MkrgSH6N8LHu4SamjnHe
   Z08qFARhrGJDcVCty2mWvbKPHgBm1d9G+Ljn73JAsZRFnYMift61Ug8q8
   OpFJD8HNkPPZuOWz0RBmPJDEgnBPHsQm8L9NtP5tHCIoosogb/98MC2yY
   OXdzZDffXQ/jOT6+div7j01kPdcF+USn4chRQYDYPcGynVqFcqgqQtUDw
   ZV5nztvs8NNfLZi/2m/A+ezLUBhiWlJdziZN6IPLI5yVRT65IVlvTC15M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="303588204"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="303588204"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 01:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="689736125"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2022 01:40:50 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5ljt-000IVW-E6; Fri, 07 Jan 2022 09:40:49 +0000
Date:   Fri, 07 Jan 2022 17:40:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/vga] BUILD SUCCESS
 0f4caffa12979152d2378edf5e88ea6b7fb6befd
Message-ID: <61d80a87.dKE2lQsDRVzBm9oB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vga
branch HEAD: 0f4caffa12979152d2378edf5e88ea6b7fb6befd  vgaarb: Replace full MIT license text with SPDX identifier

elapsed time: 953m

configs tested: 176
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220107
i386                 randconfig-c001-20220106
parisc                           alldefconfig
arm                           stm32_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc40x_defconfig
s390                       zfcpdump_defconfig
arm                     eseries_pxa_defconfig
powerpc                    adder875_defconfig
sh                        sh7785lcr_defconfig
arm                       omap2plus_defconfig
arm                            lart_defconfig
sh                        sh7763rdp_defconfig
sh                           se7343_defconfig
sh                           se7721_defconfig
sh                     sh7710voipgw_defconfig
sh                            shmin_defconfig
arc                          axs101_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
sh                          r7780mp_defconfig
mips                      loongson3_defconfig
ia64                      gensparse_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
m68k                        mvme147_defconfig
sh                          lboxre2_defconfig
sh                         ap325rxa_defconfig
m68k                       m5275evb_defconfig
arc                        nsimosci_defconfig
xtensa                    smp_lx200_defconfig
sparc64                          alldefconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
sh                          polaris_defconfig
m68k                       m5208evb_defconfig
m68k                          sun3x_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
m68k                       m5475evb_defconfig
openrisc                            defconfig
arm                        realview_defconfig
powerpc                       ppc64_defconfig
arm                        trizeps4_defconfig
arm                  randconfig-c002-20220106
arm                  randconfig-c002-20220107
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
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
riscv                randconfig-r042-20220106
arc                  randconfig-r043-20220106
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
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
x86_64               randconfig-c007-20220107
mips                 randconfig-c004-20220106
arm                  randconfig-c002-20220106
i386                 randconfig-c001-20220106
riscv                randconfig-c006-20220106
powerpc              randconfig-c003-20220106
s390                 randconfig-c005-20220106
x86_64               randconfig-c007-20220106
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
mips                        qi_lb60_defconfig
arm                          collie_defconfig
powerpc                          allyesconfig
arm                         s5pv210_defconfig
arm                         palmz72_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                         tb0219_defconfig
s390                             alldefconfig
mips                      bmips_stb_defconfig
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a004-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a016-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
x86_64               randconfig-a005-20220106
x86_64               randconfig-a001-20220106
x86_64               randconfig-a004-20220106
x86_64               randconfig-a006-20220106
x86_64               randconfig-a002-20220106
x86_64               randconfig-a003-20220106
s390                 randconfig-r044-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
