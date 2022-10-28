Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCA61094F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 06:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ1EdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 00:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ1EdI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 00:33:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088618F255
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666931587; x=1698467587;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0AzYoWeH44tgkwZWnvl5hjn0aJ1NmTWK/f24MI+FZDM=;
  b=EqcMwNr9JSRCD/uEAMpiGixb/I0bavOTMrAnL2vFL2q3nfjZsgsZfJ/C
   +c83vqtk7/zQwdxIpi0zQOR7ZrmRG/TYC2UNCZ2YrKPk/QUKNLNoAWQ/P
   QOZv7RJ/LiQ6WgNgFVaEo6x4w3hcssnUuvlnvfrFwooR+NXq5EC9UJzFw
   GDm9XiCNctyUUZP6JXVyRXPr9DPSqZP6dXHToTN9r7KaNBfT6QLzRKIoo
   W/rr9JvvdiBVZxUetKVh3cvrdUdMvIGK9o1spd71o3LE52b5weOaoEqPw
   h2dBl2zdyB9gAiC+gFAn3IsKfmrd9M63p9fuCrtP44Vwr46n8zTi3NXu6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370474084"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="370474084"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 21:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="610617427"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="610617427"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2022 21:33:05 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooH3J-0009VD-09;
        Fri, 28 Oct 2022 04:33:05 +0000
Date:   Fri, 28 Oct 2022 12:32:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/endpoint] BUILD SUCCESS
 7711cbb4862aa00909a248f011ba3fa578bd1cf3
Message-ID: <635b5b5b.fTeqhtKcZtQ3F3gT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/endpoint
branch HEAD: 7711cbb4862aa00909a248f011ba3fa578bd1cf3  PCI: endpoint: Fix WARN() when an endpoint driver is removed

elapsed time: 902m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
alpha                               defconfig
s390                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20221027
x86_64                           rhel-8.3-syz
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
ia64                             allmodconfig
arm                              allyesconfig
mips                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
i386                             allyesconfig
powerpc                           allnoconfig
arm64                            allyesconfig
x86_64                        randconfig-a011
sh                               allmodconfig
i386                          randconfig-a014
x86_64                        randconfig-a002
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221027
riscv                randconfig-r042-20221027
hexagon              randconfig-r045-20221027
s390                 randconfig-r044-20221027
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005
arm                       mainstone_defconfig
arm                        multi_v5_defconfig
mips                  cavium_octeon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
