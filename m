Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48823B7E3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgHDJjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 05:39:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:7960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgHDJjd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 05:39:33 -0400
IronPort-SDR: oJO0CdJfLCxD0WoSgI9EpismJYFZFfHXdL7DW8Iad7J6JzPacQzoZULycJsYtvojRdSy+pzbnm
 7yr/ymxW5zNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="151505925"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="151505925"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 02:39:32 -0700
IronPort-SDR: 2gbc2+/eynG5ti1PxsQLPkkOIwSNI6poS5Rgr5NT5lhBmeSWtlOcNpxiNHHqBGYdt6KED+KiQh
 HdZ3K3Bq9pJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="324584693"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2020 02:39:31 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2tPv-00003n-6U; Tue, 04 Aug 2020 09:39:31 +0000
Date:   Tue, 04 Aug 2020 17:39:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS ae86bd9f027080c4c1d1b8575cef50ef1a461ba1
Message-ID: <5f292cc4.YYM6EVad+34tjATV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: ae86bd9f027080c4c1d1b8575cef50ef1a461ba1  Merge branch 'pci/doc'

elapsed time: 722m

configs tested: 118
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                          malta_defconfig
powerpc                      ppc64e_defconfig
mips                 pnx8335_stb225_defconfig
sparc64                          alldefconfig
arm                          badge4_defconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            lart_defconfig
mips                        omega2p_defconfig
mips                     loongson1c_defconfig
m68k                       bvme6000_defconfig
xtensa                           alldefconfig
arm                       aspeed_g4_defconfig
arc                          axs101_defconfig
powerpc                    amigaone_defconfig
sh                   sh7770_generic_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
arm                         lpc18xx_defconfig
m68k                        m5307c3_defconfig
arm                       aspeed_g5_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        stmark2_defconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
sparc                               defconfig
arm                        trizeps4_defconfig
h8300                       h8s-sim_defconfig
arm                        spear6xx_defconfig
mips                          rb532_defconfig
powerpc                     mpc83xx_defconfig
arm                      jornada720_defconfig
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
alpha                            allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200804
x86_64               randconfig-a001-20200804
x86_64               randconfig-a004-20200804
x86_64               randconfig-a005-20200804
x86_64               randconfig-a002-20200804
x86_64               randconfig-a003-20200804
i386                 randconfig-a004-20200803
i386                 randconfig-a005-20200803
i386                 randconfig-a001-20200803
i386                 randconfig-a002-20200803
i386                 randconfig-a003-20200803
i386                 randconfig-a006-20200803
i386                 randconfig-a005-20200804
i386                 randconfig-a004-20200804
i386                 randconfig-a001-20200804
i386                 randconfig-a003-20200804
i386                 randconfig-a002-20200804
i386                 randconfig-a006-20200804
x86_64               randconfig-a013-20200803
x86_64               randconfig-a011-20200803
x86_64               randconfig-a012-20200803
x86_64               randconfig-a016-20200803
x86_64               randconfig-a015-20200803
x86_64               randconfig-a014-20200803
i386                 randconfig-a011-20200804
i386                 randconfig-a012-20200804
i386                 randconfig-a013-20200804
i386                 randconfig-a014-20200804
i386                 randconfig-a015-20200804
i386                 randconfig-a016-20200804
i386                 randconfig-a011-20200803
i386                 randconfig-a012-20200803
i386                 randconfig-a015-20200803
i386                 randconfig-a014-20200803
i386                 randconfig-a013-20200803
i386                 randconfig-a016-20200803
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
