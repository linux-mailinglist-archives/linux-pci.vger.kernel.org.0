Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D04C47D3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 15:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiBYOpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 09:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiBYOps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 09:45:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC420D533
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645800316; x=1677336316;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4Ik3HVCX/+L0DUuOlijLdEvlmv8V/jENp8aMxUiT7do=;
  b=glEfyn1duOo4KiGEpeNne4UYSyaeWggvGPSKbWenvNWAX3H9WMB0/t+9
   BYc2vQkWUwIX2Y3EdaA7EAmWVTOATnO1lPOnO4OuCw3jYQ09yg81LXFBY
   Piqqw+KIOYo7OgHsLALU2k5qI3F2aYQPo/m4Qq7I66h9SXf4G9/92i5zI
   mJ+YAOv7oOdTS2DrrvneYUTh78u5j/bZw9hc4JdeAqjQgu7935M/yxFwP
   LaIUaDB0IFsDKNZNy9knYwD+tZ4WWVCBvtnjCwLGzzp5gXx4TwajdQpAq
   BZII6x1F+pwOtOiN/3Vq+MfBS8Ahod9wGJ7BpFr7DwUIbDYqJYf4MRWCF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232478324"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="232478324"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 06:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="544071974"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2022 06:45:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNbqM-0004QW-J3; Fri, 25 Feb 2022 14:45:14 +0000
Date:   Fri, 25 Feb 2022 22:44:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 9622b4f2fa4be4e0ee3576d46c642eaf1ff4f54e
Message-ID: <6218eb69.LbxP015xQraIN2lC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 9622b4f2fa4be4e0ee3576d46c642eaf1ff4f54e  Merge branch 'remotes/lorenzo/pci/uniphier'

elapsed time: 720m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc              randconfig-c003-20220225
i386                          randconfig-c001
mips                 randconfig-c004-20220225
openrisc                            defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
arc                      axs103_smp_defconfig
m68k                          atari_defconfig
x86_64                           alldefconfig
mips                         rt305x_defconfig
arm                           sama5_defconfig
arm64                            alldefconfig
sh                            shmin_defconfig
sh                   sh7724_generic_defconfig
arc                           tb10x_defconfig
sh                           se7780_defconfig
arc                          axs103_defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                        keystone_defconfig
xtensa                    xip_kc705_defconfig
arc                    vdk_hs38_smp_defconfig
microblaze                      mmu_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      pasemi_defconfig
m68k                          multi_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220225
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a016
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
powerpc              randconfig-c003-20220225
x86_64                        randconfig-c007
arm                  randconfig-c002-20220225
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
arm                           sama7_defconfig
riscv                    nommu_virt_defconfig
i386                             allyesconfig
arm                         orion5x_defconfig
arm                        magician_defconfig
powerpc                          allyesconfig
arm                         palmz72_defconfig
mips                     loongson2k_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
