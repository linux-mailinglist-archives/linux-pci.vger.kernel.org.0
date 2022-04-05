Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287504F225F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 07:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiDEFFA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 01:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiDEFEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 01:04:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9381B192A4
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649134906; x=1680670906;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=B00d+40bxWZTjfdpaYz17PhTSE9iND3GubWhvDHaBw4=;
  b=VaENXIeOfVBDxagUpkt+OroqwgVct1FLRpeY06CodFentDwlR+0zaGSQ
   UK+RcX3NU7cj/1A0wWt6AD+czibF3CzPCPYZL1o2qIttSIH7dG4dbi7is
   f4YVdeFbk1Gx5FZ6kWxAE4KnuZQjMVPpwhOFP5B0WWikcPjz3ChCuVk8q
   TQ0XFhwe7u+IqGIQcfAH906YQnT8aCcZgwySsyAgbY6tb7wmu+hDClpiP
   cXy/MJrdubO9N4sCTXGfWdGn7O5a7S86gDqzQmPh+UwXTNdPuY5W+ymyA
   RF6AXlkjHfBkWqX7bcSDrGEItVVEIpLvA06ixQOmDWq24eZKPPJMnJpSy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="241251238"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="241251238"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="523318161"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 04 Apr 2022 22:01:45 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbbK4-0002eI-B0;
        Tue, 05 Apr 2022 05:01:44 +0000
Date:   Tue, 05 Apr 2022 13:01:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 5e8cf6bbbf3d3618358633c60b6ead30918b4541
Message-ID: <624bcd0e.xVaQvPCQV6GOQLoW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 5e8cf6bbbf3d3618358633c60b6ead30918b4541  Merge branch 'pci/resource'

elapsed time: 864m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220404
arm                          lpd270_defconfig
m68k                             alldefconfig
sh                          rsk7269_defconfig
arm                           tegra_defconfig
powerpc                       holly_defconfig
powerpc                      mgcoge_defconfig
arm                       imx_v6_v7_defconfig
powerpc                    sam440ep_defconfig
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
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
parisc                           allyesconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
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
i386                 randconfig-a014-20220404
i386                 randconfig-a012-20220404
i386                 randconfig-a016-20220404
i386                 randconfig-a015-20220404
arc                  randconfig-r043-20220404
riscv                randconfig-r042-20220404
s390                 randconfig-r044-20220404
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
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
powerpc                       ebony_defconfig
powerpc                     tqm5200_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc64e_defconfig
arm                       spear13xx_defconfig
arm                        neponset_defconfig
powerpc                   microwatt_defconfig
i386                 randconfig-a001-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a005-20220404
i386                 randconfig-a006-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a003-20220404
x86_64               randconfig-a004-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a006-20220404
hexagon              randconfig-r041-20220404
hexagon              randconfig-r045-20220404

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
