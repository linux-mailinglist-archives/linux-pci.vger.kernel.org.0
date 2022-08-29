Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857315A5575
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiH2UTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiH2UTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 16:19:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B1DFF
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661804386; x=1693340386;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IYyI1HhkmIG+1a7PlaJDSKlN5+dahVu/eivVazVSb8o=;
  b=VcU4w1+QjtJEHdiEG2RA/J+5uf9N7z8lZ0ChLFTP2kGYUfpEM97m+jGi
   Ptb6R5qcPS/biWHX7Wf4PduADhBE7j6yTPJu0yqsiE423ZeE/aBUvFrft
   1SaojXAXcbtgm781GonKAaHRIN4b395yf/eHS7YTaO/xl7B3X0xneeNnx
   0iFjSGldlOlzTAxyubHBjv2e+R0RUcy03IJGKPXlbqujGKuHzSMB8L3jU
   GZ2DdS/J+RrrID2/hg5Ml2c+y35yCpL+IbMU9DEIqHYZM6UFP+M0COQpW
   4570G3CqXD6MerLv9JASUDKBSRRjsgKJLrlYODLnE1D7Yeix587+AgLIc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="292569108"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="292569108"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="588297357"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2022 13:19:44 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSlEW-0000DM-0c;
        Mon, 29 Aug 2022 20:19:44 +0000
Date:   Tue, 30 Aug 2022 04:19:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 e99d8c5e803b9a9f0b5a84165dad3b8895446147
Message-ID: <630d1f48.DqaSEw3FS+4uO6i5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: e99d8c5e803b9a9f0b5a84165dad3b8895446147  PCI: dwc: Add support for 64-bit MSI target address

elapsed time: 725m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
nios2                               defconfig
csky                                defconfig
um                             i386_defconfig
x86_64                                  kexec
nios2                            allyesconfig
parisc                           allyesconfig
parisc64                            defconfig
um                           x86_64_defconfig
parisc                              defconfig
sparc                               defconfig
i386                        debian-10.3-kunit
arc                                 defconfig
i386                         debian-10.3-func
x86_64                              defconfig
s390                             allmodconfig
i386                          debian-10.3-kvm
x86_64                           allyesconfig
riscv                randconfig-r042-20220828
alpha                               defconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20220829
loongarch                           defconfig
s390                                defconfig
arc                  randconfig-r043-20220828
x86_64               randconfig-a003-20220829
s390                 randconfig-r044-20220828
sparc                            allyesconfig
x86_64               randconfig-a002-20220829
x86_64               randconfig-a001-20220829
x86_64               randconfig-a004-20220829
x86_64               randconfig-a005-20220829
x86_64               randconfig-a006-20220829
s390                             allyesconfig
xtensa                           allyesconfig
i386                                defconfig
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
arm                                 defconfig
i386                 randconfig-a002-20220829
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a004-20220829
ia64                             allmodconfig
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc                     taishan_defconfig
arm                         axm55xx_defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                               defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                                defconfig
i386                 randconfig-c001-20220829
sh                           se7722_defconfig
xtensa                  nommu_kc705_defconfig
arm                             ezx_defconfig
arm                            mps2_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5407c3_defconfig
sh                          r7780mp_defconfig
m68k                          multi_defconfig
sh                                  defconfig
sh                          r7785rp_defconfig
sh                             shx3_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
arm64                            alldefconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20220829
riscv                randconfig-r042-20220829
hexagon              randconfig-r041-20220828
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220828
hexagon              randconfig-r045-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a016-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a015-20220829
arm                        mvebu_v5_defconfig
x86_64               randconfig-k001-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
