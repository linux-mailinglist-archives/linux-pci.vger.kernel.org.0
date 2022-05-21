Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DFD52FA1C
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 10:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiEUItj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 May 2022 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEUIth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 May 2022 04:49:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE0166471
        for <linux-pci@vger.kernel.org>; Sat, 21 May 2022 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653122976; x=1684658976;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tvmfzWeXGATrqh5+Si6oGy/Og3ncuskSe+lmEUc5hs4=;
  b=jhYcQx9HVIafPTB3w7U+UQrXsNShWBq4myPWsjSHjj/auh5+vdGj6GJD
   QJlDXc7FGcPpKkBFOfOogWFlEfXlMQFAjeqMf9uEcVIwf54jidyoeCeji
   zkGjLnBfB5nvQxU8MCTctDSlg8v5clqD8/OmpgLnqX3sOpaxcJ6ZTDlYP
   eNN0U4AkcYmyLZKMafFw+peGpEp0vAXhJyhXVIuVlFfjXo7tQ/slZ0Ixy
   NZtpD88Pq5NTRKlbP+nPmz+j3DzAkC7GlH9DriZiYEp8fyEyDC5Q4wp94
   G4pnuono9jjZDW2xptNec1qI/sVSj0ZTSRQOmlarTh2Rkk2SgQq9RhndW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="252712604"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="252712604"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 01:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="743842905"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2022 01:49:34 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsKnm-00068s-70;
        Sat, 21 May 2022 08:49:34 +0000
Date:   Sat, 21 May 2022 16:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/aardvark] BUILD REGRESSION
 bf8dd34079057e2c761eb914b70b49f4a455fc18
Message-ID: <6288a77a.fQ6QjQGk2hOuZQSi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/aardvark
branch HEAD: bf8dd34079057e2c761eb914b70b49f4a455fc18  PCI: aardvark: Fix reporting Slot capabilities on emulated bridge

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/controller/pci-aardvark.c:1070:54: error: 'PCI_EXP_SLTCAP_PSN_SHIFT' undeclared (first use in this function); did you mean 'PCI_EXP_SLTCAP_PSN'?
drivers/pci/controller/pci-aardvark.c:1071:54: error: 'PCI_EXP_SLTCAP_PSN_SHIFT' undeclared (first use in this function); did you mean 'PCI_EXP_SLTCAP_PSN'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- arc-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- arm-allmodconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- arm-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- arm64-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- arm64-defconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- ia64-allmodconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- ia64-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- ia64-buildonly-randconfig-r003-20220518
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- microblaze-buildonly-randconfig-r001-20220518
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- mips-allmodconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- mips-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- parisc-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- powerpc-allmodconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- powerpc-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- powerpc-buildonly-randconfig-r004-20220518
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- riscv-allmodconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- riscv-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- s390-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
|-- sparc-allyesconfig
|   `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)
`-- xtensa-allyesconfig
    `-- drivers-pci-controller-pci-aardvark.c:error:PCI_EXP_SLTCAP_PSN_SHIFT-undeclared-(first-use-in-this-function)

elapsed time: 3878m

configs tested: 63
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
parisc                           alldefconfig
powerpc                 mpc834x_mds_defconfig
mips                            gpr_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
hexagon              randconfig-r045-20220518
hexagon              randconfig-r041-20220518

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
