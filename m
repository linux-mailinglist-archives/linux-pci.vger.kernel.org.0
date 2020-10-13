Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AB28CEF6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgJMNLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Oct 2020 09:11:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:21610 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgJMNLv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Oct 2020 09:11:51 -0400
IronPort-SDR: Sc6GquQmtZ7vMOcMhhM3SEoCoTQVwhu/on/gHMSX13K6Mq18oN/Ti7oVeyRrZ6BEYXKo3Eq7vG
 n0QH0HtDJh0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152836537"
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="152836537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 06:11:48 -0700
IronPort-SDR: yQnZ5/QLRvT3t2B0gLQ7WWGnPAz3XWnjg1/hdbLObHTcou04AHxikPAVs0XTpwm/hNpJR7uxbp
 30caWhdSeM4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="356147368"
Received: from lkp-server01.sh.intel.com (HELO ca2eb8e9a2ab) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2020 06:11:46 -0700
Received: from kbuild by ca2eb8e9a2ab with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSK5i-00000T-7W; Tue, 13 Oct 2020 13:11:46 +0000
Date:   Tue, 13 Oct 2020 21:11:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/err] BUILD SUCCESS
 e49e4b167fd301aa569d757d40e104eed16c6cbe
Message-ID: <5f85a771.i3sPcfgL6SMoKvUG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/err
branch HEAD: e49e4b167fd301aa569d757d40e104eed16c6cbe  PCI/AER: Add RCEC AER error injection support

elapsed time: 722m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         db1xxx_defconfig
powerpc                        warp_defconfig
arm                          lpd270_defconfig
powerpc                    sam440ep_defconfig
s390                          debug_defconfig
ia64                                defconfig
powerpc                      cm5200_defconfig
arm                            mmp2_defconfig
sh                          rsk7201_defconfig
arm                       mainstone_defconfig
openrisc                 simple_smp_defconfig
sh                                  defconfig
powerpc                    socrates_defconfig
arm                          prima2_defconfig
arm                         palmz72_defconfig
arm                            qcom_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
xtensa                  cadence_csp_defconfig
x86_64                           allyesconfig
mips                      fuloong2e_defconfig
parisc                              defconfig
mips                           xway_defconfig
arm                            xcep_defconfig
powerpc                     tqm8548_defconfig
arm                       aspeed_g4_defconfig
mips                          rm200_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           spitz_defconfig
arm                        vexpress_defconfig
arm                            u300_defconfig
h8300                     edosk2674_defconfig
powerpc                      pcm030_defconfig
arm64                            alldefconfig
arm                             rpc_defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
powerpc                  mpc885_ads_defconfig
arc                           tb10x_defconfig
mips                          ath25_defconfig
parisc                           allyesconfig
sh                     sh7710voipgw_defconfig
powerpc                  mpc866_ads_defconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
sh                          lboxre2_defconfig
ia64                             allmodconfig
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
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
i386                 randconfig-a005-20201012
i386                 randconfig-a006-20201012
i386                 randconfig-a001-20201012
i386                 randconfig-a003-20201012
i386                 randconfig-a004-20201012
i386                 randconfig-a002-20201012
x86_64               randconfig-a016-20201012
x86_64               randconfig-a015-20201012
x86_64               randconfig-a012-20201012
x86_64               randconfig-a013-20201012
x86_64               randconfig-a014-20201012
x86_64               randconfig-a011-20201012
i386                 randconfig-a016-20201013
i386                 randconfig-a015-20201013
i386                 randconfig-a013-20201013
i386                 randconfig-a012-20201013
i386                 randconfig-a011-20201013
i386                 randconfig-a014-20201013
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201012
x86_64               randconfig-a002-20201012
x86_64               randconfig-a006-20201012
x86_64               randconfig-a001-20201012
x86_64               randconfig-a003-20201012
x86_64               randconfig-a005-20201012
x86_64               randconfig-a016-20201013
x86_64               randconfig-a015-20201013
x86_64               randconfig-a012-20201013
x86_64               randconfig-a013-20201013
x86_64               randconfig-a014-20201013
x86_64               randconfig-a011-20201013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
