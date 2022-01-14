Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA51148F08A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 20:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiANTmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 14:42:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:5857 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234013AbiANTmY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jan 2022 14:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642189344; x=1673725344;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kPpAaDZAjNDrJlDzT9W8k9malr27sV63Vf5Ga5QYIJk=;
  b=S2mAcqBNiXSOKaVfJpbXc8Pis+6sMhI3HrNy7+iXX4DVJfVPlLBx0X3o
   agJwE9D5Py9BTjMoAVwediyA/KSSgJc2kQ6xzPqIK7OVOIA6X5O9W72JG
   cnwNCUV1b5rOviVJ6qArwhS3RQd43bpKIQDFXiZoEFdb7bMMzPyIsJtgA
   hhUSwFNn+UHv59ygE7Ag9+5R9eS4gMA93McrRfPMD2tvxK7IWbHT0jK4u
   sz4yXs4p8yKOeNH1ZCapg73qXMOGiJIcpMGLBmjuyFvUap4Z2u9WICgYh
   sRp2RuhGGr6QLAQLjZiJ+0QTb+ZiJyLprAvJYkKgOnuqj5E5Pl9FBMetY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="225001606"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="225001606"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 11:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="624456455"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2022 11:42:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8SSr-0008va-OW; Fri, 14 Jan 2022 19:42:21 +0000
Date:   Sat, 15 Jan 2022 03:41:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
Message-ID: <61e1d1f4.khlDN4dcDs0WuSj5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55  Merge branch 'pci/driver-cleanup'

elapsed time: 1388m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                          randconfig-c001
mips                           jazz_defconfig
h8300                               defconfig
powerpc                        cell_defconfig
arm                            hisi_defconfig
m68k                        mvme16x_defconfig
powerpc                     tqm8555_defconfig
powerpc                      pcm030_defconfig
sparc                               defconfig
mips                           ip32_defconfig
arm                           viper_defconfig
arm                            qcom_defconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
powerpc                     mpc83xx_defconfig
mips                        vocore2_defconfig
openrisc                    or1ksim_defconfig
s390                       zfcpdump_defconfig
arm                            xcep_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                         bigsur_defconfig
mips                            ar7_defconfig
sh                                  defconfig
i386                             alldefconfig
sh                          sdk7786_defconfig
arm                           tegra_defconfig
sh                              ul2_defconfig
arm                  randconfig-c002-20220113
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                          pxa168_defconfig
mips                           ip28_defconfig
powerpc                     tqm8560_defconfig
mips                          ath79_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                   lite5200b_defconfig
powerpc                  mpc866_ads_defconfig
riscv                    nommu_virt_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
