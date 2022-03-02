Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CBD4CA967
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 16:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiCBPr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 10:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiCBPr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 10:47:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660D5BE44
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 07:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236033; x=1677772033;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cwPPZRr4T0Z1ZtokAzBEhj8l6dgAtVis8+sHruw7qnQ=;
  b=DKb/29YHQHbQxOFYeVgFyFSqyPjM3lZLlwz4vjQPUWbAxOzg2EuKS6Et
   n44dExOu3W3LGtIjC4hf/flJd0rLiFSliwUvsY1H03gfZYCfYq3rpe2bz
   Uk6P6DILfPDnz7WDGZExK5HnXCnYaDfy4PAEyIsvaDqlrt1DcrN9lY/1l
   qUzXZ8wkf3a4EO+Bj1lC+3wxgepG8+fMqIhJ0h18twY9UcMa4VgP1ywyY
   HsG67X2GZbQYgoIrYN5PDNrtfrXGIVwHEBcLh1ce1TRuyeiiuGybUWG/8
   6DHk3+56saVd1JMieW+zyYaZomAfZyBpSSRbWHWW3M3EwsNHwKvxHaa7o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278103399"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="278103399"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="508240585"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 07:47:11 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPRC3-0001Wx-5Y; Wed, 02 Mar 2022 15:47:11 +0000
Date:   Wed, 02 Mar 2022 23:47:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/vga] BUILD SUCCESS
 943f0c7ba0fd7d6bbedd5875f4d71055a0282997
Message-ID: <621f9179.cNcLGLMkSQUasOVh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vga
branch HEAD: 943f0c7ba0fd7d6bbedd5875f4d71055a0282997  PCI/VGA: Replace full MIT license text with SPDX identifier

elapsed time: 720m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc              randconfig-c003-20220302
i386                          randconfig-c001
mips                 randconfig-c004-20220302
arm                           corgi_defconfig
parisc                generic-64bit_defconfig
powerpc64                        alldefconfig
arm                        multi_v7_defconfig
sh                           se7705_defconfig
sh                          r7780mp_defconfig
sh                           sh2007_defconfig
arm                        mvebu_v7_defconfig
csky                             alldefconfig
openrisc                  or1klitex_defconfig
sh                             shx3_defconfig
m68k                        mvme16x_defconfig
sh                              ul2_defconfig
sh                            migor_defconfig
microblaze                          defconfig
mips                         bigsur_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
arm                          iop32x_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
sparc                            allyesconfig
sh                        sh7785lcr_defconfig
arm                        trizeps4_defconfig
arm                      jornada720_defconfig
powerpc                      mgcoge_defconfig
powerpc                     taishan_defconfig
sparc64                          alldefconfig
powerpc                     tqm8541_defconfig
sh                          sdk7786_defconfig
arm                        shmobile_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     pq2fads_defconfig
parisc64                         alldefconfig
powerpc                   motionpro_defconfig
arm                            qcom_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
m68k                        stmark2_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
mips                     loongson1b_defconfig
arm                  randconfig-c002-20220302
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
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
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
arc                  randconfig-r043-20220302
riscv                randconfig-r042-20220302
s390                 randconfig-r044-20220302
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
i386                          randconfig-c001
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                     davinci_all_defconfig
arm                       netwinder_defconfig
arm                        neponset_defconfig
arm                      pxa255-idp_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
