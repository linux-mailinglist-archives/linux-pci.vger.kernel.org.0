Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20B666C2CF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 15:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAPOyK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 09:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjAPOx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 09:53:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F121A12
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673880094; x=1705416094;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=P5F0TgfIsSEqDv4H+hMOEo372x4EPtb9LHe+aWEtcJA=;
  b=b3YLSfbh/3GgAWyMByXTFxueTl80r/SxXOnCx2ur4CZIR2gu3+yH1zjS
   GEa0ylIZb8zzFd33QkC6kcXyaQCLs/+GKj6H1ye3f/KwOvNm5WXhLbAJJ
   jCHR/55jpgjLZeeKED6kQ3G/Gui+hwwLAxAhqqTDDwQ7k9A+/htQ3T5Rr
   HF8gvqN9V4A0jpOaJlNaoYPubhn3tpjn4qZ+uKOpRotfClEhW99hmSPJU
   YW6bKVnrH+tU9jJWGYtaVJijyoZBn96gfKzaOhamW/SCq0vbQOAo92FGy
   FGsdyKTqaHP6/BQLkWEdD2+drtzWEMAgmlUkHgaV4XbBcdl8CO8blr+64
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="304173216"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="304173216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 06:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801400016"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="801400016"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jan 2023 06:41:32 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHQfx-0000Vs-1K;
        Mon, 16 Jan 2023 14:41:29 +0000
Date:   Mon, 16 Jan 2023 22:40:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/switchtec] BUILD SUCCESS
 2648bccefa1d51cfae3f924bae9c57381934d774
Message-ID: <63c561f1.T/KFEzZwubWA8lGG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/switchtec
branch HEAD: 2648bccefa1d51cfae3f924bae9c57381934d774  PCI: switchtec: Return -EFAULT for copy_to_user() errors

elapsed time: 720m

configs tested: 106
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                            allnoconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                              defconfig
arm                                 defconfig
powerpc                           allnoconfig
s390                                defconfig
x86_64                               rhel-8.3
i386                 randconfig-a014-20230116
ia64                             allmodconfig
i386                 randconfig-a013-20230116
s390                             allmodconfig
i386                             allyesconfig
i386                 randconfig-a012-20230116
i386                 randconfig-a011-20230116
i386                 randconfig-a016-20230116
x86_64                           allyesconfig
i386                 randconfig-a015-20230116
arm                        mini2440_defconfig
powerpc                   motionpro_defconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a011-20230116
x86_64               randconfig-a013-20230116
arc                  randconfig-r043-20230115
x86_64               randconfig-a012-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-k001-20230116
x86_64               randconfig-a014-20230116
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20230116
x86_64               randconfig-a016-20230116
arc                  randconfig-r043-20230116
arm                  randconfig-r046-20230115
s390                 randconfig-r044-20230116
i386                 randconfig-c001-20230116
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                         axm55xx_defconfig
sh                           se7722_defconfig
powerpc                       maple_defconfig
powerpc                    klondike_defconfig
sh                           se7206_defconfig
sh                        dreamcast_defconfig
openrisc                       virt_defconfig
powerpc                      ppc6xx_defconfig
m68k                       m5275evb_defconfig
arm                            mps2_defconfig
nios2                         10m50_defconfig
arc                               allnoconfig
powerpc                      makalu_defconfig
arm                               allnoconfig
sh                      rts7751r2d1_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
m68k                                defconfig
loongarch                 loongson3_defconfig

clang tested configs:
powerpc                   bluestone_defconfig
mips                     cu1000-neo_defconfig
x86_64                          rhel-8.3-rust
x86_64               randconfig-a001-20230116
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a002-20230116
hexagon              randconfig-r041-20230116
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
hexagon              randconfig-r045-20230115
riscv                randconfig-r042-20230115
i386                 randconfig-a001-20230116
arm                  randconfig-r046-20230116
hexagon              randconfig-r045-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r041-20230115
powerpc                      pmac32_defconfig
powerpc                     kilauea_defconfig
arm                          collie_defconfig
x86_64                        randconfig-k001
arm                       netwinder_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
