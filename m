Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD554C00B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 05:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiFODRC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 23:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiFODRC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 23:17:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46F4EA36
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655263021; x=1686799021;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RosCmwZJ8u+JJNQi1KOl3agKc6dxRzQknqAYmkgzBCw=;
  b=K+R/a4c8abeIbwhxVzrIEvQbZxTe4ca10FHmEpiZQnyMDJ0enD6bmet+
   LRlZs+2tOVf1m4cqTH0DavnXBP/XC/UTuaPQS/XaZqoDy3HIr8O7Xz7LC
   DOP8SOt9IQ3aYdo5gw4IWy6Lb14t/yx3Dnqj0NlxvNP+8+Ap8C+Gw3Tsh
   gFfP21r0TNhxrX5TKvG20/h2bWCpPnDyWNyBgpeOvhRjepUr8RyM1DrPF
   gwhYrp6Gso13ZOmz8YEtZ3Ke7JScQUVXNsVd9+ckUPDadojI87Lxp2Z1b
   ZDm+9ZuEYXw4a5qfk0EfQyuMPoG5wPGTZBRpDGVHfFbFnzhhEilKkK4NP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276389008"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276389008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="612536481"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2022 20:16:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1JWc-000MX1-W2;
        Wed, 15 Jun 2022 03:16:59 +0000
Date:   Wed, 15 Jun 2022 11:16:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/qcom] BUILD SUCCESS
 873e61fe0c142b6f12d039e773553f625a66c7cc
Message-ID: <62a94f01.aCwC3EOmFt4hqLT7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom
branch HEAD: 873e61fe0c142b6f12d039e773553f625a66c7cc  dt-bindings: PCI: qcom: Fix description typo

elapsed time: 1692m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220613
m68k                       m5249evb_defconfig
mips                         bigsur_defconfig
m68k                       m5275evb_defconfig
arm                       imx_v6_v7_defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
s390                          debug_defconfig
arm                            mps2_defconfig
xtensa                         virt_defconfig
arm                        mini2440_defconfig
powerpc                     pq2fads_defconfig
sh                          r7780mp_defconfig
powerpc                   motionpro_defconfig
arm                             pxa_defconfig
arm                            hisi_defconfig
arm                             ezx_defconfig
sh                           se7206_defconfig
arm                           stm32_defconfig
powerpc                      chrp32_defconfig
mips                         cobalt_defconfig
arm                         axm55xx_defconfig
sh                         microdev_defconfig
arm                      jornada720_defconfig
arm                           u8500_defconfig
microblaze                          defconfig
arc                      axs103_smp_defconfig
arm                  randconfig-c002-20220613
x86_64               randconfig-c001-20220613
ia64                                defconfig
riscv                             allnoconfig
x86_64               randconfig-k001-20220613
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                              debian-10.3
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220613
x86_64               randconfig-a014-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a012-20220613
x86_64               randconfig-a013-20220613
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a012-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
riscv                randconfig-r042-20220613
arc                  randconfig-r043-20220613
s390                 randconfig-r044-20220613
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64               randconfig-c007-20220613
arm                  randconfig-c002-20220613
i386                 randconfig-c001-20220613
powerpc              randconfig-c003-20220613
riscv                randconfig-c006-20220613
s390                 randconfig-c005-20220613
mips                      malta_kvm_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      katmai_defconfig
powerpc                    ge_imp3a_defconfig
x86_64                           allyesconfig
x86_64               randconfig-a003-20220613
x86_64               randconfig-a006-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a005-20220613
i386                 randconfig-a006-20220613
hexagon              randconfig-r041-20220613
hexagon              randconfig-r045-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
