Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9B316709
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBJMpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 07:45:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:19230 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhBJMnu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 07:43:50 -0500
IronPort-SDR: OpVPfx0eADEBA2eqbTSazLsghP/rC2vnpcn88FIpS1Aef5Hv2xnmq6bgeh+umt40q5CMUtMZZG
 lUTbSaIGhShg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="178554090"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="178554090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 04:42:52 -0800
IronPort-SDR: kMtrE2+WMTtoIIhAaLZrMD782STsaccMlBvDzZ6irJ74q+UFpnlPpMq2zbep8nwjBz6MFe6I/a
 +7zVhnmMFSFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="578401948"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2021 04:42:50 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9opV-0002yw-WF; Wed, 10 Feb 2021 12:42:50 +0000
Date:   Wed, 10 Feb 2021 20:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/error] BUILD REGRESSION
 5692817fc88f347328e35cd7b19bd04f4400652e
Message-ID: <6023d4ab.ppVidE3EODf/T5IF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/error
branch HEAD: 5692817fc88f347328e35cd7b19bd04f4400652e  PCI/portdrv: Report reset for frozen channel

Error/Warning reports:

https://lore.kernel.org/linux-pci/202102101255.HZtDITwe-lkp@intel.com
https://lore.kernel.org/linux-pci/202102101438.UDt0kMOO-lkp@intel.com
https://lore.kernel.org/linux-pci/202102101442.Y0f7z56q-lkp@intel.com

Error/Warning in current branch:

arch/powerpc/platforms/powernv/../../../../drivers/pci/pci.h:348:20: error: statement with no effect [-Werror=unused-value]
arch/powerpc/platforms/pseries/../../../../drivers/pci/pci.h:348:20: error: statement with no effect [-Werror=unused-value]
drivers/pci/controller/../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
drivers/pci/controller/dwc/../../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
drivers/pci/pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
drivers/pci/pcie/../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]

possible Error/Warning in current branch:

arch/powerpc/kernel/../../../drivers/pci/pci.h:348:20: error: statement with no effect [-Werror=unused-value]
drivers/pci/controller/cadence/../../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
drivers/pci/hotplug/../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- powerpc-pseries_defconfig
|   |-- arch-powerpc-platforms-powernv-..-..-..-..-drivers-pci-pci.h:error:statement-with-no-effect
|   `-- arch-powerpc-platforms-pseries-..-..-..-..-drivers-pci-pci.h:error:statement-with-no-effect
`-- powerpc64-randconfig-s032-20210209
    `-- arch-powerpc-kernel-..-..-..-drivers-pci-pci.h:error:statement-with-no-effect

clang_recent_errors
|-- arm64-randconfig-r025-20210209
|   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
|-- powerpc64-randconfig-r026-20210209
|   `-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|-- riscv-randconfig-r023-20210209
|   `-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|-- s390-randconfig-r024-20210209
|   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-controller-cadence-..-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-hotplug-..-pci.h:warning:equality-comparison-result-unused
|   `-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|-- x86_64-randconfig-a011-20210209
|   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
|-- x86_64-randconfig-a012-20210209
|   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
|-- x86_64-randconfig-a013-20210209
|   |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
|-- x86_64-randconfig-a014-20210209
|   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
|   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
|-- x86_64-randconfig-a015-20210209
|   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
|   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
`-- x86_64-randconfig-a016-20210209
    |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
    |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
    `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused

elapsed time: 720m

configs tested: 105
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
m68k                          atari_defconfig
powerpc                 mpc8560_ads_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
mips                        nlm_xlp_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
arc                              alldefconfig
mips                          ath79_defconfig
c6x                        evmc6474_defconfig
sh                               allmodconfig
xtensa                  audio_kc705_defconfig
arc                        vdk_hs38_defconfig
mips                           rs90_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
mips                      maltaaprp_defconfig
arm                       cns3420vb_defconfig
alpha                            allyesconfig
sh                             shx3_defconfig
arm                          ixp4xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                         hackkit_defconfig
nds32                               defconfig
m68k                       m5475evb_defconfig
arm                           stm32_defconfig
sh                          rsk7201_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
