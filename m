Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E24F225E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 07:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiDEFE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 01:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiDEFEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 01:04:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A17192A9
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649134906; x=1680670906;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hhdZZzcViSpEyC54kQ3k2n7vloR5LmpPh2e7LsYv/1o=;
  b=lEahjw7A4rRLX2pVZu21Pv8juZqrKJjnsG5DsJXFKIecQUkniDoshgsW
   5lg7oxayisjMswruBhZcx0NWJMxZEV+cfYtTgWo9cWW+q+jsglnBRhMao
   4ZTZAV/xNV/YzQyf64ERHWLwlXHh/45vBXHox2RfBNP+G2WBU8wTYS3z7
   WqpDnly7auPa2ialXYnBsyxK0WtWYGixm5zxX1frvZRcuqcYzloXvDUJI
   r/0wkH+TUyVJI0zDV4yKnoDtaKAcIaiLM+8ye5iS0sUN11xBWieiefiyD
   RLla67A9Bd3xdejQ79TFQIuDChC9p1GR3P6/bIiH4v1R5pJn8RuodWQLJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="240601915"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="240601915"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="641468438"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2022 22:01:45 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbbK4-0002eK-BT;
        Tue, 05 Apr 2022 05:01:44 +0000
Date:   Tue, 05 Apr 2022 13:01:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 dff6139015dc68e93be3822a7bd406a1d138628b
Message-ID: <624bcd14.x8oXQxIRuoAb8Rdg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: dff6139015dc68e93be3822a7bd406a1d138628b  PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3

elapsed time: 864m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220404
sh                           se7343_defconfig
openrisc                 simple_smp_defconfig
sh                             sh03_defconfig
arm                           tegra_defconfig
powerpc                       holly_defconfig
powerpc                      mgcoge_defconfig
powerpc                    sam440ep_defconfig
arm                       imx_v6_v7_defconfig
s390                          debug_defconfig
mips                          rb532_defconfig
sparc                               defconfig
h8300                     edosk2674_defconfig
powerpc64                        alldefconfig
h8300                               defconfig
mips                           gcw0_defconfig
powerpc                      pcm030_defconfig
ia64                             alldefconfig
xtensa                    smp_lx200_defconfig
arm                  randconfig-c002-20220404
x86_64               randconfig-c001-20220404
ia64                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a011-20220404
x86_64               randconfig-a013-20220404
x86_64               randconfig-a012-20220404
x86_64               randconfig-a016-20220404
x86_64               randconfig-a015-20220404
x86_64               randconfig-a014-20220404
i386                 randconfig-a013-20220404
i386                 randconfig-a011-20220404
i386                 randconfig-a012-20220404
i386                 randconfig-a015-20220404
i386                 randconfig-a016-20220404
i386                 randconfig-a014-20220404
riscv                randconfig-r042-20220404
arc                  randconfig-r043-20220404
s390                 randconfig-r044-20220404
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc64e_defconfig
arm                       spear13xx_defconfig
arm                        neponset_defconfig
powerpc                   microwatt_defconfig
x86_64               randconfig-a004-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a006-20220404
i386                 randconfig-a001-20220404
i386                 randconfig-a003-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a005-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a006-20220404
hexagon              randconfig-r045-20220404
hexagon              randconfig-r041-20220404

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
