Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8D31670F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 13:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhBJMqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 07:46:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:52002 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhBJMpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 07:45:41 -0500
IronPort-SDR: ErzkZnWQ+ZMb3AqLedvI/oePltmexQp9Z/amBWT6b+7yT2K2kOWZyAleSEJJUorTavqTA3BDKS
 E1fZyvv90xzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="243555215"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="243555215"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 04:42:52 -0800
IronPort-SDR: w3q270esnInkUsZ7drw1Dgw+agfkKtUyWE1bwVUV9Al5g+hOw4MyPsxtuQV95eubawpuwMUjAP
 gqITGc1PfPuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="510373306"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2021 04:42:50 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9opV-0002yt-VK; Wed, 10 Feb 2021 12:42:49 +0000
Date:   Wed, 10 Feb 2021 20:42:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 e8e9aababe60a12928172b5f018d15de3c2cdf31
Message-ID: <6023d4a5.ft8Re3+W6QwuE4XL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: e8e9aababe60a12928172b5f018d15de3c2cdf31  PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy

elapsed time: 720m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arm                     am200epdkit_defconfig
sh                            shmin_defconfig
powerpc                     tqm8540_defconfig
mips                           ci20_defconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
m68k                          atari_defconfig
powerpc                 mpc8560_ads_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
mips                        nlm_xlp_defconfig
riscv                    nommu_k210_defconfig
xtensa                         virt_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           rs90_defconfig
arm                         s5pv210_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
arc                              alldefconfig
mips                          ath79_defconfig
c6x                        evmc6474_defconfig
sh                               allmodconfig
xtensa                  audio_kc705_defconfig
arc                        vdk_hs38_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
mips                      maltaaprp_defconfig
arc                              allyesconfig
m68k                       m5475evb_defconfig
arm                           stm32_defconfig
mips                          malta_defconfig
m68k                        mvme147_defconfig
arm                       cns3420vb_defconfig
alpha                            allyesconfig
sh                             shx3_defconfig
arm                          ixp4xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                         hackkit_defconfig
nds32                               defconfig
sh                          rsk7201_defconfig
m68k                             allyesconfig
nios2                         3c120_defconfig
powerpc                     powernv_defconfig
sh                   sh7770_generic_defconfig
sh                     sh7710voipgw_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
