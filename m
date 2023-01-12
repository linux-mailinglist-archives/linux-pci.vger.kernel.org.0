Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F766717D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 13:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjALMBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 07:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjALMAb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 07:00:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9533C72B
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 03:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673524502; x=1705060502;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+T6KqXfs6+TVKU3k7AEnGKtQN9mHYeweywYOEsPk+cA=;
  b=Iafp10W8ThhgbXxRhwA0Pw/oBqbUCKplmmyB/A5W7bkM8SuEWkIpvfJl
   LqVAirAPj0eWBVuxhdwxk8CDyrhJPliWDQRIrEvM5D0LgUQOAivNdWOlI
   KLftqXd4NMf0fvnQmVZIen+dh2zKDv6Alt//35z951kgGPsAMJt5nD3Cl
   lq+QgQ6Ely5CMVP4ck5B6Hf8XbcfFExPcAeaF5CjWVrhHtZDB6H6q3xu2
   r3lURWlhnzlfOh8kXHxdCeYBB2zUYRJrG0GGvuyijfdDvVGdqVwjUJUsv
   lVp5v4W4tURFoxYNPF1wxSnw2GPsYCbZyM/isll3wQmXlQokKlbHQChER
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324920631"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="324920631"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831667471"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="831667471"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2023 03:55:00 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFwAb-000A5s-0r;
        Thu, 12 Jan 2023 11:54:58 +0000
Date:   Thu, 12 Jan 2023 19:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 674279b8575ec24f0c39498029684480129bb3e9
Message-ID: <63bff4e6.FQr94AoQoD3RSktf%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 674279b8575ec24f0c39498029684480129bb3e9  x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space

elapsed time: 744m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
arm                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
powerpc                           allnoconfig
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                                defconfig
x86_64                        randconfig-a004
mips                             allyesconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
ia64                             allmodconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                              defconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a013
alpha                            allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a005
m68k                             allyesconfig
x86_64                        randconfig-a015
um                           x86_64_defconfig
x86_64                           allyesconfig
i386                             allyesconfig
um                             i386_defconfig
arc                  randconfig-r043-20230110
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                         amcore_defconfig
arm                        multi_v7_defconfig
sh                              ul2_defconfig
m68k                             alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    klondike_defconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
sh                ecovec24-romimage_defconfig
sparc                       sparc64_defconfig
powerpc                      mgcoge_defconfig
openrisc                 simple_smp_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
xtensa                         virt_defconfig
arc                        nsim_700_defconfig
loongarch                 loongson3_defconfig
mips                         rt305x_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
x86_64                          rhel-8.3-rust
arm                      tct_hammer_defconfig
powerpc                        icon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
