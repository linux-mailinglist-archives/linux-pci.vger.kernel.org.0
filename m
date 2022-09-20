Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E245BDCB7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 07:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiITFza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 01:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiITFzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 01:55:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753611004
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663653306; x=1695189306;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RbTpk4YCr75hGwvrdKaqkrALZ/RLs0EYWr6R1JM2Lp4=;
  b=g17avoeppCXD++0iNEJMjiGWwMqcTknb+hmnEmlgiESwv15CPdT43h8I
   S2T3nsWWPmaMTnpqf/RNESI1wB3fTxJcJJIxvj1GOl6xjdbVDC3mCIK5I
   OR/uRgEv+Pn6s00dEBHf2n8J975w8rw4RjcONTlUKYMBqGOw2/x5p/VrH
   GQ7OLmQ6tfSHiMdQq4z/1fz1cGdkLPgc08sMi9YX0YaQOleRNsItqoTiC
   haJLdnp9AhGhQOJ+sJCAHOhwo2G7NMZZlpbfL1a2Suf2hPKrkUFPSATU3
   nJYqO3+0VowXL5A6eKu+w5tqxL++HP994kSIYCkuIafdReJhtFIV+H9vO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282634137"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="282634137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 22:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="761168985"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2022 22:55:04 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaWDo-0002WP-0q;
        Tue, 20 Sep 2022 05:55:04 +0000
Date:   Tue, 20 Sep 2022 13:54:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 fcf773ae8016c6bffe5d408d3eda50d981b946e6
Message-ID: <63295585.coZVFVPNH9ygw9lk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: fcf773ae8016c6bffe5d408d3eda50d981b946e6  Merge branch 'remotes/lorenzo/pci/qcom'

elapsed time: 724m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
alpha                            allyesconfig
i386                 randconfig-a013-20220919
arm                                 defconfig
riscv                randconfig-r042-20220919
i386                 randconfig-a012-20220919
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220919
x86_64               randconfig-a012-20220919
x86_64                          rhel-8.3-func
i386                 randconfig-a014-20220919
x86_64               randconfig-a011-20220919
x86_64               randconfig-a014-20220919
i386                 randconfig-a011-20220919
s390                 randconfig-r044-20220919
x86_64               randconfig-a015-20220919
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a013-20220919
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a016-20220919
arm64                            allyesconfig
i386                 randconfig-a016-20220919
i386                 randconfig-a015-20220919
arm                              allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                             shx3_defconfig
powerpc                       holly_defconfig
x86_64               randconfig-k001-20220919
i386                 randconfig-c001-20220919
i386                             alldefconfig
arm                         lpc18xx_defconfig
sh                          r7785rp_defconfig
powerpc                      chrp32_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                 randconfig-a001-20220919
i386                 randconfig-a002-20220919
hexagon              randconfig-r041-20220919
i386                 randconfig-a003-20220919
i386                 randconfig-a004-20220919
i386                 randconfig-a005-20220919
hexagon              randconfig-r045-20220919
i386                 randconfig-a006-20220919
x86_64               randconfig-a003-20220919
x86_64               randconfig-a001-20220919
x86_64               randconfig-a002-20220919
x86_64               randconfig-a004-20220919
x86_64               randconfig-a006-20220919
x86_64               randconfig-a005-20220919
powerpc                     tqm5200_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
