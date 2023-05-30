Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F86715DC8
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjE3LtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjE3LtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 07:49:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22CE12D
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447337; x=1716983337;
  h=date:from:to:cc:subject:message-id;
  bh=K/UWMoqSlc++o4WYWbeKs8AcfMeMgrEUgpim+7zJM2I=;
  b=MftpYvCfbnZP2F01DMLejsWuHjhGbauGQ3jN/F/rko54G6zLVXuUS3Rg
   Hgn6n2MXjNufPXZ7kmjvd2jDwiFl6XhqiIpni70/0paazQACAbYVEfa7r
   jvPmDtzG2FqB72C1nUKl8ljExau+xsrp5qR9S39qRTGbTkiTee6MZ+AOP
   aSal6kKINjvxU7F5QdWTWyQtXlVxBq7wf7ox0IcFMouxfN7d1hdiB0ikB
   zfy3eF9qh3apRKfvcwaf5MvZNB+VvtW+exsto6Q4WR2pY8MdRm6ZkiL2z
   jWy9FPyP12VOHcIo6jvCPuX3fAAqUfEZ4sn+qunWLwPjDhhVEfEew/zjs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335238843"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="335238843"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="880731224"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="880731224"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 04:48:56 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3xqR-0000E1-1i;
        Tue, 30 May 2023 11:48:55 +0000
Date:   Tue, 30 May 2023 19:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/endpoint] BUILD SUCCESS
 de22e068e9bb7629072809f676e306f2cbba6bed
Message-ID: <20230530114758.wLxwr%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/endpoint
branch HEAD: de22e068e9bb7629072809f676e306f2cbba6bed  PCI: endpoint: Improve pci_epf_type_add_cfs()

elapsed time: 1187m

configs tested: 155
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230529   gcc  
alpha                randconfig-r025-20230529   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230529   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230529   gcc  
arm                  randconfig-r026-20230529   clang
arm                  randconfig-r046-20230529   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r001-20230529   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230529   gcc  
csky                 randconfig-r023-20230529   gcc  
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230529   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i051-20230529   clang
i386                 randconfig-i052-20230529   clang
i386                 randconfig-i053-20230529   clang
i386                 randconfig-i054-20230529   clang
i386                 randconfig-i055-20230529   clang
i386                 randconfig-i056-20230529   clang
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i071-20230529   gcc  
i386                 randconfig-i072-20230529   gcc  
i386                 randconfig-i073-20230529   gcc  
i386                 randconfig-i074-20230529   gcc  
i386                 randconfig-i075-20230529   gcc  
i386                 randconfig-i076-20230529   gcc  
i386                 randconfig-i081-20230529   gcc  
i386                 randconfig-i082-20230529   gcc  
i386                 randconfig-i083-20230529   gcc  
i386                 randconfig-i084-20230529   gcc  
i386                 randconfig-i085-20230529   gcc  
i386                 randconfig-i086-20230529   gcc  
i386                 randconfig-i091-20230529   clang
i386                 randconfig-i092-20230529   clang
i386                 randconfig-i093-20230529   clang
i386                 randconfig-i094-20230529   clang
i386                 randconfig-i095-20230529   clang
i386                 randconfig-i096-20230529   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230529   gcc  
loongarch            randconfig-r032-20230529   gcc  
loongarch            randconfig-r036-20230529   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r003-20230529   gcc  
microblaze           randconfig-r006-20230529   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r011-20230529   gcc  
openrisc             randconfig-r012-20230529   gcc  
parisc       buildonly-randconfig-r002-20230529   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230529   gcc  
parisc               randconfig-r035-20230529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r031-20230529   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230529   clang
riscv                randconfig-r042-20230529   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230529   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230529   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230529   gcc  
sparc64      buildonly-randconfig-r006-20230529   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230529   clang
x86_64               randconfig-a002-20230529   clang
x86_64               randconfig-a003-20230529   clang
x86_64               randconfig-a004-20230529   clang
x86_64               randconfig-a005-20230529   clang
x86_64               randconfig-a006-20230529   clang
x86_64               randconfig-a011-20230529   gcc  
x86_64               randconfig-a012-20230529   gcc  
x86_64               randconfig-a013-20230529   gcc  
x86_64               randconfig-a014-20230529   gcc  
x86_64               randconfig-a015-20230529   gcc  
x86_64               randconfig-a016-20230529   gcc  
x86_64               randconfig-r021-20230529   gcc  
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x081-20230529   clang
x86_64               randconfig-x082-20230529   clang
x86_64               randconfig-x083-20230529   clang
x86_64               randconfig-x084-20230529   clang
x86_64               randconfig-x085-20230529   clang
x86_64               randconfig-x086-20230529   clang
x86_64               randconfig-x091-20230529   gcc  
x86_64               randconfig-x092-20230529   gcc  
x86_64               randconfig-x093-20230529   gcc  
x86_64               randconfig-x094-20230529   gcc  
x86_64               randconfig-x095-20230529   gcc  
x86_64               randconfig-x096-20230529   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
