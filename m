Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E501A4879BE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiAGPcD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 10:32:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:50734 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239528AbiAGPcD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 10:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641569523; x=1673105523;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k65FGogrqOS1ypdUa4obGQyAvM1SQE2v2ASWlma+N0w=;
  b=YD8ZTPpB84+H7+K+DONPhivSQeKbCXuIrq9ppkIPuGDt6TJj3KiCeZOd
   heHZR+ts2n1k/ieUnuRRMmtM2cMF5caRh0Rjp5D/VBe7vtAXEAphrxaOX
   sloqOAqFbsk/I7rYHBUwGJrNfW9h36CthYe/Ef2m8LPpK+gYi6svqY0U4
   8mBwsohzhlVELlpjsOrzQX3YV32brUQHGSJfCASExkcciqW76WNHPUnzN
   F+v9K7I7N2e2K1egsISEVZHrE4zNjrCFBd0lREBIAGFLIko9lEVs9k6mH
   GzZXLJTOBv15GF2xPWG4iChoStq0NGhWLRdQLf4VggxIXJqpLyC1uLGRI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="242681767"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="242681767"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 07:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="513829606"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 07:32:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5rDl-000IoM-4T; Fri, 07 Jan 2022 15:32:01 +0000
Date:   Fri, 07 Jan 2022 23:31:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 c5897649436b563fae8c675c9ce684764f0361da
Message-ID: <61d85cb5.X8GJJI+SdEEIqBad%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: c5897649436b563fae8c675c9ce684764f0361da  Merge branch 'pci/driver-cleanup'

elapsed time: 1013m

configs tested: 89
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
arm                         axm55xx_defconfig
m68k                         amcore_defconfig
powerpc                      ppc6xx_defconfig
arm                        cerfcube_defconfig
powerpc64                        alldefconfig
m68k                        mvme147_defconfig
sh                          lboxre2_defconfig
arc                         haps_hs_defconfig
mips                         mpc30x_defconfig
sh                           se7721_defconfig
sh                          polaris_defconfig
m68k                       m5208evb_defconfig
m68k                          sun3x_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
arm                  randconfig-c002-20220107
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
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
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func

clang tested configs:
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
