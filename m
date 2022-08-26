Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D925A1D74
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 02:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiHZAEF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 20:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHZAEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 20:04:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50DC740A
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661472243; x=1693008243;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NcymGIgsrPOCurDV5G93a5z/Hs8BRT75pirQkNXv6fw=;
  b=fG7xUHNDX0PuQH4fh5Wl1BZl5KKCo9pwplx4kBaPgqMhGhf5sPyGZXwh
   Z93P31wNEzdEOYZRsfiei5QKaEKF7PEZJod1OVEaz25KLeAVMVgMvtoHF
   VKcMMHYumrQbdODhDWaPmcWcRscM90cS3r9UE4dLHuy7j5qwgxX4PL7w3
   qY2f/uEG78ukIcZ1605eeKzOFBPpGKm6qmtQ4O2A9zRkOJdEK2eWZf6ag
   Kl3BpvDT8FJmT0dMG/Fj1In/DHu/dRjoJCmaVSV+aBSB6z+YAJkj5Vj+8
   nSGzKsVrg6JGvbMfaiZgeQ74yijzzZra32gi5MPm/ntZVABuNskikfdzt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="281355912"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="281355912"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 17:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="671229687"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2022 17:04:01 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRMpM-00036L-2G;
        Fri, 26 Aug 2022 00:04:00 +0000
Date:   Fri, 26 Aug 2022 08:03:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/bridge-emul] BUILD SUCCESS
 658aea35ab88deca19705413199933c2cef9bac8
Message-ID: <63080dea.Nly0ScaDJ7DAcZ5g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/bridge-emul
branch HEAD: 658aea35ab88deca19705413199933c2cef9bac8  PCI: pci-bridge-emul: Set position of PCI capabilities to real HW value

elapsed time: 724m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
loongarch                         allnoconfig
loongarch                           defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
m68k                        m5272c3_defconfig
arm                          iop32x_defconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
um                                  defconfig
m68k                       m5249evb_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
x86_64                        randconfig-a006
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
m68k                        stmark2_defconfig
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
arc                  randconfig-r043-20220825
i386                          randconfig-c001
xtensa                         virt_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
arm                        spear6xx_defconfig
mips                            gpr_defconfig
ia64                             alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                           gcw0_defconfig
m68k                       bvme6000_defconfig
sh                            hp6xx_defconfig
m68k                           virt_defconfig
arm                            qcom_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
ia64                             allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
hexagon              randconfig-r045-20220824
hexagon              randconfig-r045-20220825
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
riscv                randconfig-r042-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r041-20220824
hexagon              randconfig-r041-20220825
s390                 randconfig-r044-20220825
s390                 randconfig-r044-20220823
mips                       lemote2f_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
