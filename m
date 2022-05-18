Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DC52B2FD
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 09:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiERG6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 02:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiERG6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 02:58:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7D2F3AB
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652857102; x=1684393102;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xG825U/iF4XdkCL9t6TE1aKdvV34uukQliyosFZUnuE=;
  b=YWF5tVYCe0RLkEkLNi5zdLrRU8W7HHQi/Yp0wCWyeN+VmxnCbcZtuAgc
   KqJ1j6IQz7ogB9N+Tc8GLfotqm7dUEzPqsCqRynaSG3JmJ5Nw1vqKacS0
   m8dNDaWmtsMmMVPXW+CAdEsyix+DZHS9X/kOpQUP7Ezp0LkSzBnWcToo4
   BiOjudyDnkSuq2TPv4P7ffAEZ5g8/Bw+JAqHcDeWYDtusObo+q4b+tMu+
   VOCno2k1nWBs/2H1GwaIWhK54umahW/IfQCQlMffgtPL3wbRV4hgysN0o
   Nf5JCzEwS86QrVcpItEB5NZR5BTNbN4Bii3tbU8VP7TsCgnN+B1TJ/8HH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253562310"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="253562310"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 23:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="569295383"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2022 23:58:21 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrDdU-0001td-MS;
        Wed, 18 May 2022 06:58:20 +0000
Date:   Wed, 18 May 2022 14:57:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 4246970a3bcb450e52c043127792d4f0ad39678f
Message-ID: <628498e2.dWr7wAfzRWeyZ5zf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 4246970a3bcb450e52c043127792d4f0ad39678f  Revert "PCI: brcmstb: Split brcm_pcie_setup() into two funcs"

elapsed time: 1914m

configs tested: 155
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220516
arm                           imxrt_defconfig
powerpc                       ppc64_defconfig
sparc                            allyesconfig
m68k                        m5407c3_defconfig
m68k                             allmodconfig
arm                        multi_v7_defconfig
sh                           se7721_defconfig
sh                           se7780_defconfig
arm                      jornada720_defconfig
sparc                       sparc64_defconfig
mips                            ar7_defconfig
s390                             allyesconfig
sh                           se7712_defconfig
arm                          pxa3xx_defconfig
sh                           se7206_defconfig
sh                   sh7724_generic_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
sh                           se7724_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                       m5208evb_defconfig
sh                             sh03_defconfig
sh                ecovec24-romimage_defconfig
sh                          r7780mp_defconfig
powerpc                     stx_gp3_defconfig
mips                    maltaup_xpa_defconfig
arc                        nsimosci_defconfig
powerpc                     pq2fads_defconfig
sh                         ecovec24_defconfig
mips                            gpr_defconfig
m68k                       bvme6000_defconfig
parisc64                            defconfig
sh                               j2_defconfig
mips                           ci20_defconfig
openrisc                            defconfig
arm                            mps2_defconfig
sh                           se7705_defconfig
powerpc                     sequoia_defconfig
arm                  randconfig-c002-20220516
x86_64               randconfig-c001-20220516
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a012-20220516
x86_64               randconfig-a016-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a015-20220516
i386                 randconfig-a016-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a014-20220516
i386                 randconfig-a011-20220516
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220516
riscv                randconfig-r042-20220516
s390                 randconfig-r044-20220516
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220516
riscv                randconfig-c006-20220516
mips                 randconfig-c004-20220516
arm                  randconfig-c002-20220516
x86_64               randconfig-c007-20220516
i386                 randconfig-c001-20220516
powerpc              randconfig-c003-20220518
x86_64                        randconfig-c007
riscv                randconfig-c006-20220518
mips                 randconfig-c004-20220518
i386                          randconfig-c001
arm                  randconfig-c002-20220518
s390                 randconfig-c005-20220516
arm                       mainstone_defconfig
arm64                            allyesconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     pseries_defconfig
arm                      tct_hammer_defconfig
powerpc                      walnut_defconfig
powerpc                     skiroot_defconfig
x86_64                           allyesconfig
mips                         tb0287_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     mpc5200_defconfig
powerpc                      ppc44x_defconfig
powerpc                    mvme5100_defconfig
arm                     davinci_all_defconfig
arm                          pxa168_defconfig
powerpc                   microwatt_defconfig
powerpc                     akebono_defconfig
x86_64               randconfig-a001-20220516
x86_64               randconfig-a006-20220516
x86_64               randconfig-a003-20220516
x86_64               randconfig-a005-20220516
x86_64               randconfig-a002-20220516
x86_64               randconfig-a004-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a003-20220516
i386                 randconfig-a005-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a006-20220516
i386                 randconfig-a002-20220516
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220516
hexagon              randconfig-r041-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
