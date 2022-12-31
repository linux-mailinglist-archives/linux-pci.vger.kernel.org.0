Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2365A2B8
	for <lists+linux-pci@lfdr.de>; Sat, 31 Dec 2022 06:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiLaFA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Dec 2022 00:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiLaFA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Dec 2022 00:00:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5BBBA
        for <linux-pci@vger.kernel.org>; Fri, 30 Dec 2022 21:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672462855; x=1703998855;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=djY9zZWr2P4Sdy7v4l2jo2wzTyWKv+YBQ9PBRaWlAK8=;
  b=gLJmAaNs+kEhCIzotk0onD1tGMpgNW+sGpC+GNc8d6Y8HoiohqCDVGy1
   3YplYM6BpmqRNeqrW8ThHbZA14MFre8qAlkEw9F+4EY6jk4l8CIpe/nDX
   CXpW0av233Fbmt65KxXFc+u77YmpDza+pEMJMEG1zXB8H+25KiCurqgFa
   iV/0ziwphErhhxAvnmxteoD2+0DHf0lA7XzsHVl6EPJrKCnRO51eqdrbf
   yLrOvM6rdBBiWP5z2H5uL2ir8B5duP/Ivpz9guSY1UGfWilSCfefEvSOZ
   agU94DCAgjScmPZdedC/Fqmb+dpYeXfmhqgVP/ghVmEqGeXCBisKZVsRk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="322519743"
X-IronPort-AV: E=Sophos;i="5.96,289,1665471600"; 
   d="scan'208";a="322519743"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 21:00:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="684615795"
X-IronPort-AV: E=Sophos;i="5.96,289,1665471600"; 
   d="scan'208";a="684615795"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Dec 2022 21:00:53 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pBTzJ-000N2b-0Z;
        Sat, 31 Dec 2022 05:00:53 +0000
Date:   Sat, 31 Dec 2022 13:00:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dt] BUILD SUCCESS
 68909a813609595ad5007ee6cdb1f115b985c4d2
Message-ID: <63afc1da.Dy7yZlGoRFVS6LII%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dt
branch HEAD: 68909a813609595ad5007ee6cdb1f115b985c4d2  dt-bindings: PCI: qcom,pcie-ep: correct qcom,perst-regs

elapsed time: 910m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                            allyesconfig
s390                             allmodconfig
alpha                               defconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                                defconfig
m68k                             allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                              defconfig
ia64                             allmodconfig
i386                 randconfig-a012-20221226
arm                                 defconfig
i386                 randconfig-a011-20221226
i386                 randconfig-a013-20221226
arm64                            allyesconfig
i386                 randconfig-a014-20221226
x86_64                               rhel-8.3
i386                 randconfig-a016-20221226
x86_64               randconfig-a014-20221226
arm                              allyesconfig
x86_64               randconfig-a013-20221226
i386                 randconfig-a015-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a016-20221226
x86_64               randconfig-a015-20221226
x86_64                           allyesconfig
i386                             allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig
powerpc                          allmodconfig

clang tested configs:
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64                          rhel-8.3-rust
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
x86_64               randconfig-a006-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227
s390                 randconfig-r044-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
