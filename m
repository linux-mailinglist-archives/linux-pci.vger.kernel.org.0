Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0F60DEE4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 12:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiJZKfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 06:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiJZKfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 06:35:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A92844F7
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666780550; x=1698316550;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hYZ82ThIi+oUDd18Vbnhg8eoYFuJvenGBQxTuip2V9Y=;
  b=Di4mze8oxm6ciYdiL3rdekVb1RdN5u3hVgxa1SasQPZHOmCyDmRGus42
   tDdlfYo+x41tgXG6nZ5VmlIm0+uIERLcsSYxQe/bMFk4KDVoYUYkGyHxu
   bHvonXOHAp+mcP3X+jo0M1/NZU2Y2mGXZW4hWXeg+lfLSXqIrZfywBMwr
   JCdQdvgjw+nrIOKoIjopOFpQabuKyVBMvuQO8EerXMwduhXbJrvYZMzdr
   0CEXilteYjwQG4mfMl4NiDh3AZqGt7+hnAjQKqt5zoyCE3TEym/vJrBbg
   dOmhHRgEQ6TCQBeNS29L2WjZIDsNGVEA1oVvBZHdw08zjcwSSyLlQY3Da
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="295320894"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="295320894"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 03:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="721203515"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="721203515"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2022 03:35:48 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ondlD-0007Is-2T;
        Wed, 26 Oct 2022 10:35:47 +0000
Date:   Wed, 26 Oct 2022 18:34:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 7ef674962273621c58e0586e674277843a7f572e
Message-ID: <63590d4a.JcPxPzP5/1Dxj/tb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 7ef674962273621c58e0586e674277843a7f572e  Merge branch 'pci/portdrv'

elapsed time: 725m

configs tested: 91
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allmodconfig
powerpc                           allnoconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                              defconfig
m68k                             allyesconfig
arc                  randconfig-r043-20221025
x86_64                               rhel-8.3
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
x86_64                           allyesconfig
i386                 randconfig-a013-20221024
i386                             allyesconfig
i386                 randconfig-a012-20221024
i386                 randconfig-a016-20221024
i386                 randconfig-a015-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                        mvme147_defconfig
powerpc                   motionpro_defconfig
mips                         cobalt_defconfig
mips                    maltaup_xpa_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             alldefconfig
arm                      integrator_defconfig
openrisc                 simple_smp_defconfig
mips                          rb532_defconfig
sh                        edosk7705_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
arm                              allmodconfig
nios2                         3c120_defconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20221025
riscv                randconfig-r042-20221025
hexagon              randconfig-r045-20221025
s390                 randconfig-r044-20221025
x86_64               randconfig-a001-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a005-20221024
x86_64               randconfig-a006-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a004-20221024
i386                 randconfig-a006-20221024
i386                 randconfig-a005-20221024
mips                malta_qemu_32r6_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
powerpc                      ppc64e_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
