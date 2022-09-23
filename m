Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795CD5E70B1
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 02:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiIWAfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 20:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiIWAfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 20:35:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A6100AAE
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2022 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663893350; x=1695429350;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=leDWyjY/YGtA64Jn0008TrrWp948pjAjozk9BMdns2o=;
  b=jdtFSuDZokUy9Tkt9Hnltq0re+seviod7whi0M39hGE0dWxYnIPpb5qB
   NbXvvqtJw0CfGnsdqQbJzwQrni1kz9QILHD3I7m2k28vw4nbrELrODF2b
   4jBH7zDRLvWkIl8tpqc/J02ozBGzbd8gsSskWrJKDyC0ICnMbbtdrlaOj
   YHwxbsGWZIYBops/2yLz7UTKauhlCM2/tBeXImjaJdsgncC6OtaRSXY5o
   DF1CDSN4nG+cM+Iv5SiX3HV+AmhxRTFdhDW3AHmccX2NdnjcYcY+a4oKS
   SZAaDdTqI2Pajsv4PV6zWLNd1I4LSgcSO8Iwd0VFyh/eDXvCTltv/8UPk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300457104"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300457104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688528705"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 17:35:49 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obWfU-00057g-1E;
        Fri, 23 Sep 2022 00:35:48 +0000
Date:   Fri, 23 Sep 2022 08:34:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 0e32818397426a688f598f35d3bc762eca6d7592
Message-ID: <632cff2d.Nzulz8P+xH08XScv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: 0e32818397426a688f598f35d3bc762eca6d7592  PCI: Sanitise firmware BAR assignments behind a PCI-PCI bridge

elapsed time: 720m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                  randconfig-r043-20220922
sh                               allmodconfig
i386                                defconfig
x86_64                              defconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
mips                           ip32_defconfig
arm                         s3c6400_defconfig
s390                       zfcpdump_defconfig
sh                   sh7770_generic_defconfig
xtensa                         virt_defconfig

clang tested configs:
hexagon              randconfig-r041-20220922
riscv                randconfig-r042-20220922
hexagon              randconfig-r045-20220922
s390                 randconfig-r044-20220922
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
powerpc                        fsp2_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
