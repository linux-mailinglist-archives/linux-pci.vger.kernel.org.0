Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F376637A00
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 14:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiKXNdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 08:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiKXNdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 08:33:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC70B442EA
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669296802; x=1700832802;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Fz0IaYOlcSZmKnoY5wEUBQfGrsfGJyOCUdoQd2bMOdE=;
  b=fssY50o0/9/iWXKprPEpnvwQ5/BFUMf2N0/AduG8R+RerUrjRO8IYxgs
   iqvo125bZkYIasHcmMiDlV7Cu5KXNl4X9EAVdQ+peJ/QftVzmolZw3VBG
   rCaqYEBAD8MTJEtvhIpp51PjBx/jNTrmj1g6g3T9y7DocOYDomMyDNtgv
   wQ67ARMJJn4b7JQ+7zKmkG/+BhktcgvEwmO8zP54gtuWnk0ZNnQv9er4L
   AbiJPYmTIE0oK6eL/LR4Z1UGEoQdUGvFIpJElY13ki/I0+ubwCsJDiOyg
   /nRKkaMhzOwD1tvQPETmC4GXO1yx/D/gprkkiAwHVZ746CC30LL2zXrDC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="311938526"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311938526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="675095613"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="675095613"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2022 05:33:16 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyCLr-0003wP-2I;
        Thu, 24 Nov 2022 13:33:15 +0000
Date:   Thu, 24 Nov 2022 21:33:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 ba6ed462dcf41a83b36eb9a74a8c4720040f9762
Message-ID: <637f729a.2NAwtu3JZYjmbn4J%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: ba6ed462dcf41a83b36eb9a74a8c4720040f9762  PCI: dwc: Add Baikal-T1 PCIe controller support

elapsed time: 1347m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a015
i386                                defconfig
arc                  randconfig-r043-20221124
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                          pxa3xx_defconfig
mips                         db1xxx_defconfig
arm                        shmobile_defconfig
arm                           viper_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a016
riscv                randconfig-r042-20221124
s390                 randconfig-r044-20221124
hexagon              randconfig-r045-20221124
hexagon              randconfig-r041-20221124
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
