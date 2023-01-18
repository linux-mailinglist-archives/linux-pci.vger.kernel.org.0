Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030FD671889
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 11:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjARKIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 05:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjARKHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 05:07:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F26E807
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 01:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674033161; x=1705569161;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NTxjNrAP88GnC2doiDvby2CsEH8RgdVbzqE/L5YOIpk=;
  b=NWL/08D5PMHcDqsq2S9fEVgXY3W4oXDvrA/+4Zo/cbmLBFQj3FsLPLmO
   mFGhCtzgyQR+D4zEwU1NDarXiR7+SE5G4s+ENgwAszf+jlsg89WOOZpAu
   B146gpDOH9QxyunZENLWqQ/LdssBBGbdlwD1aHjr5naVbvnI8KRIuhDOV
   sWF1zBA+HPSFT9JexGAdXvByJ5nUCBk7KqomR2XPD8VEcZvIcau6bTHXY
   07iEwkfiwB134Q5ICNIJb6b+XfUQv33r3tUu4Se1CuhJbjFreK6ANAnPs
   jP0tSGQb88sEjPDkcXF/MuJEd27O7cq9JnbqtKJXgIy+q/yxa4m/TW3aV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411177601"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411177601"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 01:12:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="728115689"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="728115689"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jan 2023 01:12:39 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI4Uo-0000Aq-2V;
        Wed, 18 Jan 2023 09:12:38 +0000
Date:   Wed, 18 Jan 2023 17:11:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 1aa3f2b02fcd3817a0b1caa0a4654e40433a33be
Message-ID: <63c7b7da.icj2X3JFjtkgqE7c%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 1aa3f2b02fcd3817a0b1caa0a4654e40433a33be  misc: pci_endpoint_test: Drop initial kernel-doc marker

elapsed time: 725m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
x86_64                            allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-c001-20230116
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a016-20230116
i386                 randconfig-a014-20230116
i386                 randconfig-a011-20230116
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                          hp300_defconfig
arm                            lart_defconfig
riscv                randconfig-r042-20230116
arm                  randconfig-r046-20230117
arm                  randconfig-r046-20230115
s390                 randconfig-r044-20230116
arc                  randconfig-r043-20230117
arc                  randconfig-r043-20230116
arc                  randconfig-r043-20230115
powerpc                      bamboo_defconfig
arm                           imxrt_defconfig
powerpc                      makalu_defconfig
arm                        cerfcube_defconfig
i386                 randconfig-a015-20230116
ia64                        generic_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
powerpc                     tqm8548_defconfig
mips                        vocore2_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20230117

clang tested configs:
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
arm                          sp7021_defconfig
powerpc                     ppa8548_defconfig
powerpc                     tqm8560_defconfig
arm                  colibri_pxa270_defconfig
x86_64                        randconfig-k001
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
powerpc                      acadia_defconfig
arm                        magician_defconfig
riscv                             allnoconfig
arm                           sama7_defconfig
riscv                          rv32_defconfig
powerpc                    mvme5100_defconfig
arm                         hackkit_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
x86_64                          rhel-8.3-rust
powerpc                        fsp2_defconfig
mips                           rs90_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       cns3420vb_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    ge_imp3a_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
riscv                randconfig-r042-20230117
s390                 randconfig-r044-20230117
hexagon              randconfig-r041-20230117
hexagon              randconfig-r045-20230117

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
