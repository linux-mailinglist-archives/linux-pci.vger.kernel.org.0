Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D26B239B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 13:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCIMBo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 07:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCIMB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 07:01:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D292BDD
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 04:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678363284; x=1709899284;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MJQz1nc/Ib7E/pB1/y3c8FgURZpMVEv7eGICzOKc5Ds=;
  b=lujutl9HMYbrHuk6jgKJ6EeuG/hnAbziBMz7YIcRCZSM9/M+1XhM/G/I
   OcFsUzCBmJIrv2JY59bJA4CqFPsoY6HayhglXgOGoAC4peDBeI8kCXZT+
   SgQMgBKODprax1Myzi8UU2gkl1AinDnfAunT8lWJLckCviHktvnuEyic/
   E8Ikfw8OjqWcH38Zf8bDKpQbzxjQPuyc2dRaC/18ajsOg2Gry2IiS/uSF
   v2d08io9BkL4yFPiNVv4mns1OnRoQ9zeg42ISikkRDnroFELV19VdQfWk
   7gIZWtZ52AP/DUzXPfDAeKDjn9Xpnnd0Y3ux7hWhQ8pOPIXeGV2/UH91Y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364067664"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="364067664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 04:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="741536682"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="741536682"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2023 04:01:23 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paExX-0002vP-0H;
        Thu, 09 Mar 2023 12:01:23 +0000
Date:   Thu, 09 Mar 2023 20:00:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS e35b32eaec16fdc7285e6d3f94665b104e0aba60
Message-ID: <6409ca73.5C4zHsjbXAtx4EAW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: e35b32eaec16fdc7285e6d3f94665b104e0aba60  cper-arm: Remove unnecessary aer.h include

elapsed time: 724m

configs tested: 97
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230308   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230308   gcc  
arc                  randconfig-r043-20230308   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230308   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230308   gcc  
arm64                randconfig-r013-20230308   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230308   clang
hexagon              randconfig-r045-20230308   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230308   gcc  
ia64                 randconfig-r033-20230308   gcc  
ia64                 randconfig-r036-20230308   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230308   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r035-20230308   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r021-20230308   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230308   gcc  
mips                 randconfig-r032-20230308   clang
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230308   gcc  
openrisc             randconfig-r004-20230308   gcc  
openrisc             randconfig-r005-20230308   gcc  
openrisc             randconfig-r011-20230308   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230308   clang
riscv                randconfig-r031-20230308   gcc  
riscv                randconfig-r034-20230308   gcc  
riscv                randconfig-r042-20230308   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230308   clang
s390                 randconfig-r024-20230308   clang
s390                 randconfig-r044-20230308   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230308   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230308   gcc  
sparc64              randconfig-r023-20230308   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
