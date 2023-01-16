Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF966D1A0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 23:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjAPWQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 17:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjAPWP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 17:15:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11925E15
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 14:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673907347; x=1705443347;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kupr94VuU+3ClcBrwSlJOtmJWqP+HImOXEBk0kk0J5Q=;
  b=lsXGG1vKl/A+7tOlI27w01iHeBe3gsQCqjg/F9wKkEDROIwtWOfpB1Vq
   RcwfCkKn9AL3Xbc2i7e3XixmdKHQ7hdAD8eYlNDxQXssnDVNje9q4iWzc
   Hbvc6HCHFwhgyPd/M/iQWfUWKKjxyTLFqEHCdi2duVJUwtsg8LVSFJUVu
   SZjVLrYgw15dXCaOA5K7XbmDPJzg3ZPAuXBegTl+4lflaI4BtpGjrMplD
   RC9TZtww1/fCiB2lAN2fXzabVll6T9A/YeuGyMhsla4P6DRRjurlBn0fM
   NJkP60OafosXlviFP6SgIPhhN/y0PUVCAxuZnCwkxPeYD//XlkEWN04Zn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325837187"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="325837187"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 14:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="609049937"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="609049937"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2023 14:14:11 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHXk2-0000kf-1r;
        Mon, 16 Jan 2023 22:14:10 +0000
Date:   Tue, 17 Jan 2023 06:13:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/imx6] BUILD SUCCESS
 c435669a41dd4ee063572e17b48c14806ad31f72
Message-ID: <63c5cc21.EakPGEUioc6M7ccP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/imx6
branch HEAD: c435669a41dd4ee063572e17b48c14806ad31f72  PCI: imx6: Add i.MX8MP PCIe EP support

elapsed time: 727m

configs tested: 117
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64               randconfig-k001-20230116
x86_64                            allnoconfig
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a016-20230116
i386                 randconfig-a014-20230116
i386                 randconfig-a015-20230116
i386                 randconfig-a011-20230116
nios2                         10m50_defconfig
arc                               allnoconfig
riscv                randconfig-r042-20230116
s390                 randconfig-r044-20230116
arc                  randconfig-r043-20230116
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                                defconfig
loongarch                 loongson3_defconfig
powerpc                      ppc6xx_defconfig
m68k                       m5275evb_defconfig
openrisc                       virt_defconfig
arm                            mps2_defconfig
i386                             allyesconfig
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                      makalu_defconfig
arm                               allnoconfig
sh                      rts7751r2d1_defconfig
arm                             rpc_defconfig
arm                           h3600_defconfig
powerpc                       maple_defconfig
sh                           se7619_defconfig
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
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
arm                       netwinder_defconfig
powerpc                     kilauea_defconfig
x86_64                          rhel-8.3-rust
riscv                randconfig-r042-20230115
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r041-20230115
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230115
hexagon              randconfig-r045-20230116
arm                        vexpress_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa168_defconfig
arm                     am200epdkit_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
