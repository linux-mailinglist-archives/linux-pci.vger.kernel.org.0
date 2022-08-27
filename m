Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543085A3486
	for <lists+linux-pci@lfdr.de>; Sat, 27 Aug 2022 06:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiH0Edm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Aug 2022 00:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiH0Edl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Aug 2022 00:33:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB6BB275F
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 21:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661574820; x=1693110820;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7TB6yl2I65Bwx656bzjH/dKSH7Qqo9qRem+ih7iD980=;
  b=XUSbymKC3D/p9y+7WN+e5FZectStvG8yQTPCgKhwSB44LavDDgUWbT9D
   ZpY9Y12j/59bSQ8NqLjZzpNeEY7YHwK5eVx/ah1eMeqNcPyhEq5lf56lI
   hgtQ82BofiglChLH0Kgg1QxtV51xasaQ7wYJaVVveqzGaRpJmPfJkEYez
   hLwUWOKctJSUq9YM6By9y7m0RYVJqo04MjxPESpu8+KrXYX83EFePTWJ2
   RXtmkh/mwfPqghBNUoaNll7dPbJjytN7Ui7W4C0EPex+oXf8InWWjr9H0
   pWnFp3rZCKC975L0sOUK5XJ8QGgef8CMm0tnDecvnxIArj1WgyD8/IG+I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281602931"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="281602931"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 21:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="643883547"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Aug 2022 21:33:37 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRnVp-0000zc-0k;
        Sat, 27 Aug 2022 04:33:37 +0000
Date:   Sat, 27 Aug 2022 12:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/msi] BUILD SUCCESS
 2b96f92ca4257c05e352f61742839b451e293949
Message-ID: <63099e65.ikouk8MWmbIw5KWW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
branch HEAD: 2b96f92ca4257c05e352f61742839b451e293949  PCI/MSI: Correct 'can_mask' test in msi_add_msi_desc()

elapsed time: 724m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
arm                                 defconfig
um                             i386_defconfig
arc                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm64                            allyesconfig
i386                                defconfig
i386                          randconfig-a005
alpha                               defconfig
arm                              allyesconfig
x86_64                              defconfig
loongarch                         allnoconfig
x86_64                        randconfig-a004
loongarch                           defconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a006
arc                  randconfig-r043-20220824
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
x86_64                           allyesconfig
powerpc                           allnoconfig
riscv                randconfig-r042-20220824
s390                                defconfig
powerpc                          allmodconfig
i386                          randconfig-a012
s390                             allmodconfig
i386                          randconfig-a016
i386                             allyesconfig
x86_64                          rhel-8.3-func
mips                             allyesconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20220826
arc                              allyesconfig
s390                             allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
s390                 randconfig-r044-20220824
riscv                randconfig-r042-20220826
arc                  randconfig-r043-20220826
arc                  randconfig-r043-20220825
sh                        apsh4ad0a_defconfig
openrisc                    or1ksim_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          randconfig-c001
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
ia64                             allmodconfig
sh                          landisk_defconfig
sh                          rsk7203_defconfig
parisc                generic-32bit_defconfig
arm                            xcep_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
s390                       zfcpdump_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           sama5_defconfig
sh                           se7343_defconfig
m68k                          multi_defconfig
sh                           se7780_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220827
sh                           se7206_defconfig
sh                               j2_defconfig
powerpc                     mpc83xx_defconfig
alpha                            alldefconfig
mips                          rb532_defconfig
powerpc                         wii_defconfig
powerpc                      ep88xc_defconfig
sh                         ap325rxa_defconfig
arc                      axs103_smp_defconfig
um                               alldefconfig
m68k                          sun3x_defconfig
arc                           tb10x_defconfig
m68k                       bvme6000_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
arm                       imx_v6_v7_defconfig
powerpc                     redwood_defconfig
ia64                        generic_defconfig
sh                          rsk7269_defconfig
powerpc              randconfig-c003-20220827

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220825
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220825
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
hexagon              randconfig-r045-20220826
hexagon              randconfig-r041-20220826
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
hexagon              randconfig-r045-20220827
riscv                randconfig-r042-20220827
hexagon              randconfig-r041-20220827
s390                 randconfig-r044-20220827
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
hexagon              randconfig-r041-20220823
s390                 randconfig-r044-20220823
x86_64                        randconfig-k001
powerpc                  mpc885_ads_defconfig
arm                                 defconfig
arm                         bcm2835_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
