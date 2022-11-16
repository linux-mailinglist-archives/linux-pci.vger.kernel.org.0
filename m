Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9962B1FA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 04:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiKPDzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 22:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKPDzl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 22:55:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A181822B15
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 19:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668570940; x=1700106940;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EwARkjz9eNzsZjSSocG3WJ5BBxDt0Q46AUETShMFWLA=;
  b=CIpSMisK7qFzQI3hiX8TBqDIUhrhhXkxWhf6Axtx4jSC2TPqWrGCncrj
   Q/NTIN98h4NJs7HBx8ms1ML7IFOjTAB9YnRGbXkQklzPlSfVN4PmE+ubt
   iANxANHBEeE8L1eVM2bLYWon7riG5aDS/COZXxPdK7Q3+/UgviKTMl6mq
   hoPSeXndGw4zzWqPLlfriH9MPJCNxOO9dYHfDYqfVNONE/CIq3u1yJVmV
   M3rH1um1qbX9gcCuxu3R5yoCR7oF8McKbFKhPMAoYIEvkvjDRnmcust3q
   vn5N6CzTwsbfCYoiemaZ9iQ6IvyNAytaHgKub0C0X63UsCTb2S3X8S1rv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314255054"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="314255054"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 19:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="813931349"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="813931349"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2022 19:55:29 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ov9WK-0001xM-1X;
        Wed, 16 Nov 2022 03:55:28 +0000
Date:   Wed, 16 Nov 2022 11:55:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 e67ad9354a9b7621341adec4ac2c63d5269f835d
Message-ID: <63745f27.XPMuDb049Wv2GwFT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: e67ad9354a9b7621341adec4ac2c63d5269f835d  PCI: pciehp: Enable by default if USB4 enabled

elapsed time: 722m

configs tested: 76
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                 randconfig-a001-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a002-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a006-20221114
i386                 randconfig-a003-20221114
m68k                             allmodconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
ia64                             allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20221115
m68k                             allyesconfig
x86_64                            allnoconfig
riscv                randconfig-r042-20221115
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
s390                 randconfig-r044-20221115
x86_64                           allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                      integrator_defconfig
mips                           ci20_defconfig
powerpc                      ppc6xx_defconfig
sh                 kfr2r09-romimage_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
openrisc                 simple_smp_defconfig
arm                            hisi_defconfig
powerpc                   motionpro_defconfig
mips                      maltasmvp_defconfig
mips                      loongson3_defconfig
sh                           se7721_defconfig
arm                         axm55xx_defconfig
parisc                              defconfig
powerpc                       maple_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
