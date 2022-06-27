Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53855D2CC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiF0HIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiF0HI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 03:08:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40A5FB2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656313707; x=1687849707;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QTUYr41dQyg0KJ3C3n8bmVUNfbCWUBSrKgipkyn1O9s=;
  b=i5NB9q1b3MO5vNT8R2rcDsYxWoJAbsMWW0fk4GTTHhFzTGnAt8T2Rt/t
   L3xQNw1gRcibQF6++1QUX8IBXR7IHt7IuUSjhr3hlfZY7NX1k8KGwlRaO
   XSQgdotQYc1TozsMDYrCU+gXOaiQ15VeybjfLFXRygbIE8Vd5ciEqfo+f
   0NEfCIhCmFVnGPn2dq69XAQynTwifWLP0Oe1K5Tyq0dyXOMkVztamlrqE
   2ZH77mXo3YnEC7f0pbipaRJmoVLuOQgb4h+1SBfXdYQX1SxQgNnOj2tDM
   yIa+TAUmF6JE/2Gfs/Wopyd2/wLjIVii87z8g4AV+yIOLzGyfXgKQH1sC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="367694226"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="367694226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 00:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="657565293"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2022 00:08:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5irB-0008KN-9Z;
        Mon, 27 Jun 2022 07:08:25 +0000
Date:   Mon, 27 Jun 2022 15:08:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/qcom-ipq8074] BUILD SUCCESS
 434d9fd0f24c5728019b6d0462bb71b2d650563d
Message-ID: <62b95758.b7z464KwAkKDYYOS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom-ipq8074
branch HEAD: 434d9fd0f24c5728019b6d0462bb71b2d650563d  PCI: qcom: Move all DBI register accesses after phy_power_on()

elapsed time: 4865m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                            lart_defconfig
sparc                       sparc32_defconfig
mips                          rb532_defconfig
m68k                       m5208evb_defconfig
arm                         s3c6400_defconfig
powerpc                 linkstation_defconfig
m68k                        m5307c3_defconfig
m68k                            mac_defconfig
arm                        oxnas_v6_defconfig
powerpc                    amigaone_defconfig
arc                                 defconfig
ia64                      gensparse_defconfig
mips                           gcw0_defconfig
openrisc                  or1klitex_defconfig
mips                      fuloong2e_defconfig
powerpc                      ppc6xx_defconfig
mips                         mpc30x_defconfig
arm                             ezx_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
xtensa                    smp_lx200_defconfig
sh                   sh7724_generic_defconfig
mips                  decstation_64_defconfig
parisc                           alldefconfig
xtensa                          iss_defconfig
sh                   secureedge5410_defconfig
sh                         apsh4a3a_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7712_defconfig
powerpc                         ps3_defconfig
openrisc                            defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220626
ia64                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220624
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      pxa255-idp_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r041-20220624
hexagon              randconfig-r045-20220624
s390                 randconfig-r044-20220624
riscv                randconfig-r042-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
