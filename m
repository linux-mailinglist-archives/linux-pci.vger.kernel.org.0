Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA8612096
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 07:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ2FlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 01:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2FlJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 01:41:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6422787FB4
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 22:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667022068; x=1698558068;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3DOUM+/C7AaveG/SNVvA40VkcLrm/kGlV/nBcMpZDCk=;
  b=m6eVoD5Nf0xShfHPVEv3ROQJuOlH3MgNCTuUQOOda4wWjsLqZiIZKlXN
   GcGz4pQL6UhR0j1kfQ/DSCRA/aF7zTDUsw19K6CIsaXNw8ZgXZVaK4hnK
   FcUS+5fbkmns8HtcE72HMHWtzyY0wFq6l2XHup5VmkEikWcKrG0Pr9/in
   awbwXKWvoh7rsGUobYWjQzqTwiLutFrp7iRyVqSLMpHbnuFxmIwkN6pf9
   JuAzbVIiOvKnKCnIOYuvF1V6UB9WA0Nwgm/6rMLkdANrChPblVmx45XUk
   hG0oxiv6i89PKYvcwa072b91v6h4Kz7q3QVWcQENQz8u2QjDiEm9V99Ys
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="372851478"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="372851478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 22:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="584149866"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="584149866"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Oct 2022 22:41:06 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooeaf-000Af7-2M;
        Sat, 29 Oct 2022 05:41:05 +0000
Date:   Sat, 29 Oct 2022 13:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 652ce11a7604cac4149ac20acaf145f93924e639
Message-ID: <635cbcbc.F6wogpJLhfAF/t9T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 652ce11a7604cac4149ac20acaf145f93924e639  Merge branch 'remotes/lorenzo/pci/tegra'

elapsed time: 722m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
um                             i386_defconfig
s390                             allyesconfig
um                           x86_64_defconfig
ia64                             allmodconfig
i386                                defconfig
arc                  randconfig-r043-20221028
riscv                randconfig-r042-20221028
s390                 randconfig-r044-20221028
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
sh                               allmodconfig
i386                          randconfig-a014
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allyesconfig
x86_64                        randconfig-a015
mips                             allyesconfig
i386                          randconfig-a012
x86_64                        randconfig-a002
i386                          randconfig-a016
m68k                             allmodconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a006
arc                              allyesconfig
i386                          randconfig-a003
alpha                            allyesconfig
x86_64                        randconfig-a004
arm                                 defconfig
i386                          randconfig-a005
x86_64                               rhel-8.3
arm                              allyesconfig
x86_64                           allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                          pxa3xx_defconfig
sh                        dreamcast_defconfig
arm                            hisi_defconfig
xtensa                  cadence_csp_defconfig
m68k                           virt_defconfig
powerpc                       holly_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                      makalu_defconfig
arm                           u8500_defconfig
arm                         lpc18xx_defconfig
arm                      jornada720_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221028
hexagon              randconfig-r045-20221028
i386                          randconfig-a013
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
