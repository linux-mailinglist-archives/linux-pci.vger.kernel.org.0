Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14D166D19F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 23:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjAPWQB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 17:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjAPWPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 17:15:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624F12CC72
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673907345; x=1705443345;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uRiAZWW3pZKezfm+ygg7tpbjG4aHR9GgPUhjVHRX4AY=;
  b=cRpushludWcfDSfAAoxbZgQrR8UsCTBuh92bbu1MJ6jUKu7JQbBy5S9X
   qD0+nvVLYeZKwSgkhjxAe2hL/l0DKLwd62YPvvExzmKTvWZHp0UBqDap6
   NjNlP5Q8CC4Jo3iOO8Y9BOqgITN/ooQqM0l4vZe1dw40+fKlapRYxLQRe
   Wsexp8TiABnt1mX53gJT+DjqVcX8iPEjFD7IBfG91jKes/dPh4+JUsz/R
   DWapEZhj1FdJO/jMk7x6olQnWX/CEE/8j4BPy/SGfzc6Tm0xuqmLBKHJQ
   CLBMVQrnimDS3BFkLpoY/tqDYo+ytBp/rRCz0Ncn8LQuLS3+H9+mWNhD9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325837184"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="325837184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 14:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="609049934"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="609049934"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2023 14:14:11 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHXk2-0000kZ-1Z;
        Mon, 16 Jan 2023 22:14:10 +0000
Date:   Tue, 17 Jan 2023 06:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 0591d47a02172fed83b7ea613670a6594d12a5c7
Message-ID: <63c5cc2d.mKC0JL+FKWXDcP/D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: 0591d47a02172fed83b7ea613670a6594d12a5c7  PCI: qcom: Add support for IPQ8074 Gen3 port

elapsed time: 726m

configs tested: 109
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
i386                                defconfig
arc                                 defconfig
m68k                             allyesconfig
s390                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
sh                               allmodconfig
alpha                               defconfig
x86_64                              defconfig
s390                                defconfig
arm                                 defconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                 randconfig-a014-20230116
x86_64                          rhel-8.3-func
i386                 randconfig-a013-20230116
x86_64               randconfig-a011-20230116
i386                 randconfig-a012-20230116
x86_64                           allyesconfig
x86_64               randconfig-a016-20230116
x86_64               randconfig-a013-20230116
i386                 randconfig-a011-20230116
x86_64               randconfig-a012-20230116
x86_64               randconfig-a015-20230116
arc                  randconfig-r043-20230115
i386                 randconfig-a016-20230116
i386                 randconfig-a015-20230116
riscv                randconfig-r042-20230116
arm64                            allyesconfig
x86_64               randconfig-a014-20230116
ia64                             allmodconfig
arm                              allyesconfig
arc                  randconfig-r043-20230116
arm                  randconfig-r046-20230115
s390                 randconfig-r044-20230116
nios2                         10m50_defconfig
arc                               allnoconfig
powerpc                      ppc6xx_defconfig
m68k                       m5275evb_defconfig
openrisc                       virt_defconfig
arm                            mps2_defconfig
powerpc                      makalu_defconfig
arm                               allnoconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
sh                        sh7785lcr_defconfig
mips                        bcm47xx_defconfig
mips                         bigsur_defconfig
powerpc                mpc7448_hpc2_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20230116
x86_64                          rhel-8.3-rust
x86_64               randconfig-a003-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a006-20230116
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230115
i386                 randconfig-a002-20230116
riscv                randconfig-r042-20230115
i386                 randconfig-a004-20230116
arm                  randconfig-r046-20230116
i386                 randconfig-a003-20230116
s390                 randconfig-r044-20230115
i386                 randconfig-a005-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a006-20230116
hexagon              randconfig-r045-20230116
hexagon              randconfig-r041-20230115
arm                       netwinder_defconfig
powerpc                     kilauea_defconfig
arm                        vexpress_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa168_defconfig
arm                     am200epdkit_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
