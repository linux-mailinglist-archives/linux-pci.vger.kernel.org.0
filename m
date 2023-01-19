Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45144673186
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 07:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjASGKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 01:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjASGKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 01:10:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C420470A9
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 22:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674108640; x=1705644640;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2GORJR8UxXm60Lh6doausCfDvpXmVmi1KKiStuBunH0=;
  b=G1pWoDA+koDLwXEmrU35BntB6SYwdp13+u4gFOLMWtG3nc4wKP4m6FS3
   e1Em9w9epO7QypNcXUqA9ddqUIkZxlRP6+gpGLTJ5dZAwqCB9etOsNrrj
   x2qbK6TVetyZIgqrp4GDNfIC0nb6v2e9114VSdeUIK0ivmH8sJ/I09iCd
   EGQfSG2P+0pc0eXfumvY9b+SJiWCP7neGt81jyjN5YYJ9py4HsJaGURwb
   9NxogPl8Hj4p1Agcd2VS7XXm9JNwNWaoFX4KOkyF5nCugs3dvyli1XEDb
   FrnNuaueqM904AiqJcibsrNLel99Y5oqBC469zRdWCUcUzaCqXq9ZFMiB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323892682"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="323892682"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 22:10:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="833878897"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="833878897"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2023 22:10:37 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIO8C-0001Bw-1Q;
        Thu, 19 Jan 2023 06:10:36 +0000
Date:   Thu, 19 Jan 2023 14:10:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/switchtec] BUILD SUCCESS
 ddc10938e08cd7aac63d8385f7305f7889df5179
Message-ID: <63c8ded9.G2RtYnQw5iM7aM26%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/switchtec
branch HEAD: ddc10938e08cd7aac63d8385f7305f7889df5179  PCI: switchtec: Return -EFAULT for copy_to_user() errors

elapsed time: 726m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
arc                              allyesconfig
alpha                            allyesconfig
alpha                               defconfig
m68k                             allmodconfig
m68k                             allyesconfig
s390                                defconfig
s390                             allmodconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                      mgcoge_defconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-c001
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                       omap2plus_defconfig
microblaze                          defconfig
nios2                         10m50_defconfig
arm                               allnoconfig
sh                           se7705_defconfig
arc                      axs103_smp_defconfig
arm                       imx_v6_v7_defconfig
sh                              ul2_defconfig
sh                           se7750_defconfig
arc                     nsimosci_hs_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                        spear3xx_defconfig
arm                        neponset_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
