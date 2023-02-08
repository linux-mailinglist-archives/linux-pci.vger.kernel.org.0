Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0E68E90D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 08:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjBHHfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 02:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjBHHe7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 02:34:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53E34300
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 23:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675841698; x=1707377698;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1JDorif86tEjcuGFYUs3AXlM5Vk3fA7ZklzscTzQsQI=;
  b=YGA4P/QZqxP/MxCemjDYW/9R8g5FwX9eJp8va2ct5CZCSkyZxuQ4lrd8
   DrsFLHrkqeK/zm/+WeeUuDC5J2UXsfQhijXz4Yd1DVKF4KhbMcK3bNGO0
   uTlUidD+ky1TCoemSbze14qQdqqntXHKkXwDA3uc1VaTp+dB8H+eawyVX
   26Ulw+lzc8jSNr2imXf7SZJiS7lctBxo1UKU5+SljaOv3UM0jc5eef7Z4
   afwTCoB9oQuwidfb0Lh9jGEgb8id/4OsXFSCD6hZrZABgNmJk9TL7F+rJ
   g0E7VvOE+a9KxNcCJkUgdgG4eVAt5d/R3sPUrdCGwPVMdK7B7m5QK4jl0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415954668"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415954668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="667150950"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="667150950"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Feb 2023 23:34:55 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPeyl-0004HA-0S;
        Wed, 08 Feb 2023 07:34:55 +0000
Date:   Wed, 08 Feb 2023 15:34:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/reset] BUILD SUCCESS
 270d19bb0b65360440f78f75ca55d2ed318cf40c
Message-ID: <63e35068.ua5vdjGxW16QmY0U%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/reset
branch HEAD: 270d19bb0b65360440f78f75ca55d2ed318cf40c  PCI/DPC: Await readiness of secondary bus after reset

elapsed time: 737m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
ia64                             allmodconfig
i386                                defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a014-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a011-20230206
x86_64                          rhel-8.3-func
i386                 randconfig-a014-20230206
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20230206
i386                 randconfig-a016-20230206
i386                 randconfig-a015-20230206
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
riscv                randconfig-r042-20230206
s390                 randconfig-r044-20230206

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a001-20230206
x86_64                        randconfig-a005
i386                 randconfig-a002-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a006-20230206
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230205
s390                 randconfig-r044-20230205
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
