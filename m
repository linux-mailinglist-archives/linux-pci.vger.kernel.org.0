Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E036C52FAA5
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbiEUKTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 May 2022 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiEUKTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 May 2022 06:19:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A55AE25E
        for <linux-pci@vger.kernel.org>; Sat, 21 May 2022 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653128377; x=1684664377;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8KtdpKYmBDaNzATPET1ITBfpHxiGodJIO0XBx7HH++Q=;
  b=bPAIrDPKzs2uwXAAvSzdhINV4kI9ynpR62aWNvakfIVomTtZS92g7AIR
   a8n7kCCBVBdxuflfXbK538a8wnty6Mf00kTJ1QRysTOV4qFk3hcd1VQP5
   0l3sHlbuvnryIYtF8PY9TQEWOiucc5IKtu1fGOS5Ob+pROl3axNww7f3Z
   lX4hBRrlxD0gi4AukPtN6kZPNLWGAm33ovFfnru0yfl4tfeD9Xx0F4Vkb
   u+6ntwXDPMcW62thhS1aEMa7gpwWUeNodG8NwkTpUp3e89pif6XzPldB2
   bwtBKkpAl597F7dVeFZqMntHOFk6gl8ZRO/48Bny+UwYo07YdR9fpKc4A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270418546"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="270418546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 03:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="662661381"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2022 03:19:36 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsMCt-0006Bb-Hi;
        Sat, 21 May 2022 10:19:35 +0000
Date:   Sat, 21 May 2022 18:19:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/microchip] BUILD SUCCESS
 7013654af694f6e1a2e699a6450ea50d309dd0e5
Message-ID: <6288bca6.FmG/cSVoRSRY5HPK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/microchip
branch HEAD: 7013654af694f6e1a2e699a6450ea50d309dd0e5  PCI: microchip: Fix potential race in interrupt handling

elapsed time: 3892m

configs tested: 55
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
