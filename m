Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A266866A9B5
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jan 2023 07:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjANGmf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Jan 2023 01:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjANGme (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2023 01:42:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5634696
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 22:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673678553; x=1705214553;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VIEwUJQoAYpW/uW7Zt4ff42oQ/RxvaYZDRrYrZyc0/g=;
  b=AWC6QJV2zkc2DoRSMaPMqwg/4koQNYHFiFW6UrxNWSM5rbpkWSkBZ8Ha
   zd7AT2UhSQm+KDfRPu+yBpLK1n1x9r+a0M6sWN/ANjySWT8JJVMZgFdDG
   TK18ck7+zvaZf+weges9RjK9KBtjxf8s0zU+rgD9LyZpeMTRICDX0ieOD
   Vp6ApY9rn1cimFPmHH1Rkpvj/wLW7kgMhqRp5mGNGoeuTzQ19m84A7d1P
   JvIbohi5UgVR/oXGLoYGYuQPIOrPWGdksVm8L0/o2yveNdTBCbO/fUuyC
   /UqYTR5pnEjc5XYLv8ZRotSlN5U3lJwOchGC7NOQ24IHEH8cNxbVOvyw6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="410410184"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="410410184"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 22:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="651758565"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="651758565"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2023 22:42:31 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGaFK-000Br8-1f;
        Sat, 14 Jan 2023 06:42:30 +0000
Date:   Sat, 14 Jan 2023 14:42:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD SUCCESS
 4c27e6f994d287d7ae02bd8b9cb98c5b57a546cf
Message-ID: <63c24ed4.A7O8p1Ds+JnAWm3k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: 4c27e6f994d287d7ae02bd8b9cb98c5b57a546cf  PCI/ACPI: Account for _S0W of the target bridge in acpi_pci_bridge_d3(()

elapsed time: 726m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
riscv                randconfig-r042-20230112
arm                  randconfig-r046-20230113
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20230112
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230113
arm64                            allyesconfig
s390                 randconfig-r044-20230112
ia64                             allmodconfig
x86_64                           allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
um                           x86_64_defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
sparc                             allnoconfig
powerpc                    amigaone_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
sh                               allmodconfig
mips                             allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                          allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                         axm55xx_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc64                          alldefconfig
sh                         ecovec24_defconfig
m68k                       m5249evb_defconfig
mips                  decstation_64_defconfig
arc                      axs103_smp_defconfig
mips                       bmips_be_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20230113
arm                  randconfig-r046-20230112
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230113
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a014
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
