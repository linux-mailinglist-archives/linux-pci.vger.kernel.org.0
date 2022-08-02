Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB20587EE7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiHBPUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHBPUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 11:20:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3C2C3
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659453623; x=1690989623;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cJtCd8lT/C1tmqSbgoxKz66Re8c4fz3vbVkn53Q+Wd8=;
  b=g5MvV/L0ix8ZbKW01hZ6H/n+UjRDPw0xBvsTqcwej6GF5f1A5y+fgiSs
   XShTrvfntB2erMMtlx7/chtxs2OWJyKEkTWgn3/ePDiGpRxBC3kPAIkOU
   s2blELF6bq5F7mw3wmdgRTmCZc4UvUZEGC+SX37AlIgJHUrkee1NbdrOO
   f4OkEIcHwgPQ/kpx5ly0HUqvKCL8xzIbtk28E57140p2Zw622HitQKxJJ
   lRV1lVUHnG4rzWv2lA61V/OL05TL+zsupEVm/udWPgOy/cXM/93TJF12z
   Asncv2vBfsclbKGncK5FtUKCU9n5/d+RGEaI/cmRyqZIEeApPJ3WEhB8+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290648452"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="290648452"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 08:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="578253117"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2022 08:20:22 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oItgz-000G9B-2O;
        Tue, 02 Aug 2022 15:20:21 +0000
Date:   Tue, 02 Aug 2022 23:20:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 d4140dae77302505e769693b0c39440d15de9181
Message-ID: <62e940b2.MGqehzNX6TSAo/3m%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: d4140dae77302505e769693b0c39440d15de9181  Merge branch 'pci/header-cleanup-immutable'

elapsed time: 1043m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                  randconfig-r043-20220801
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
x86_64               randconfig-a011-20220801
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a012-20220801
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a013-20220801
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a014-20220801
arm                              allyesconfig
x86_64               randconfig-a015-20220801
i386                 randconfig-a013-20220801
arm64                            allyesconfig
x86_64               randconfig-a016-20220801
i386                 randconfig-a014-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a016-20220801
i386                 randconfig-a015-20220801
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64               randconfig-k001-20220801
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             allyesconfig
i386                 randconfig-a012-20220801
i386                 randconfig-c001-20220801
m68k                             allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a006-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a006-20220801
powerpc                      obs600_defconfig
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
