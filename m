Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7698B5F60EC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 08:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJFGQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 02:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJFGQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 02:16:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7F4E843
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 23:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665037014; x=1696573014;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9ecb+FfqvZ1fQ0rAjpJ/MlgdWAWZy7AICZyGF6qy/Wc=;
  b=GqikVVtLURKZaGV1ySvu55K8ooW5kvxYCFPXdwObAsmZSBeA3vBj3qvd
   +vLdQCQaeEzTGFiM6mXAwTmcIKh68yTfDGsdGRGWrI+AwO5n89zI/p7eM
   pFLWJ1tcBrNbykLItVEtlgyV6chKOiuItEBTRa0V2iheF6c/aNdWsnTw5
   UY7ux0wXFdkhLeezBuuGyQCRl3cbYKtJLp0HnzzlB00TQGb1eIaY8hJNZ
   7ZSo65cbvhTIpK2uXrbpENoNXLRl4HL+8Ws0rWv/s4ULoW5zy18lVVI7m
   g6+WnPvqH71B10AFPsYXQZfjEUv5n5Xq92BN9WcTCfdXTaHtiTBNpmHI8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="300957557"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="300957557"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 23:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602310225"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="602310225"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 23:16:53 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogKBg-00021V-1r;
        Thu, 06 Oct 2022 06:16:52 +0000
Date:   Thu, 06 Oct 2022 14:16:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/rebar] BUILD SUCCESS
 91fa127794ac1c48069479b9d45eb4c7378c0e30
Message-ID: <633e72d0.WgIwCN+et9Vk36/n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/rebar
branch HEAD: 91fa127794ac1c48069479b9d45eb4c7378c0e30  PCI: Expose PCIe Resizable BAR support via sysfs

elapsed time: 725m

configs tested: 104
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                           allyesconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
i386                                defconfig
m68k                             allyesconfig
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                 randconfig-a014-20221003
arm                                 defconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arm                              allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
x86_64               randconfig-a011-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a015-20221003
arm64                            allyesconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
sh                          r7780mp_defconfig
xtensa                              defconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                           tb10x_defconfig
um                               alldefconfig
mips                         bigsur_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
m68k                          atari_defconfig
sh                      rts7751r2d1_defconfig
mips                           xway_defconfig
powerpc                    klondike_defconfig
powerpc                         wii_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
arm                     eseries_pxa_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
nios2                            alldefconfig

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a006-20221003
s390                 randconfig-r044-20221002
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
arm                          sp7021_defconfig
arm                        magician_defconfig
x86_64                        randconfig-k001
i386                             allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
