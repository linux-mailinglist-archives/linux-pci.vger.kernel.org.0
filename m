Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC085316C53
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 18:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhBJRPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 12:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232063AbhBJRPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 12:15:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCA9E64D9D;
        Wed, 10 Feb 2021 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612977273;
        bh=kAUWTBa08QsagOQdmwTDPc3Av6r71aZJPANuxTJWbD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cWgYiuq/qECu83PxcQT5LtG+1l9t2xFXSxJUCf/YpZfaHtwOezmfccvnY+ajiGUTO
         2iNacKS1G5/P5fRohDhOxWKgCYiwGKTEulEwL+oKBuLUlPHhoN3+LZ3yPUviQB/mgD
         bK6WJUDxG627DPA5g88YSCrPMwLy0+5uI+O+M/7gj6l2a+ZFgSvu7/lQdu1yASzcun
         A58e6w5XyaYQrofRpNpnjTzl2L5LR4WyJg3ex71LvjtwNA5em7w8d0vU2dhaPIxZRl
         /ppK4wtFfGL/HE+sC+ybx7VPfwT2/WHV9dmz0TQI83I9MCVT18OHek8QxuYlo/VX0k
         el+yHvKvcSKPQ==
Date:   Wed, 10 Feb 2021 11:14:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [pci:pci/error] BUILD REGRESSION
 5692817fc88f347328e35cd7b19bd04f4400652e
Message-ID: <20210210171430.GA590032@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210150641.GA580421@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dan (who also reported my bug), Krzysztof]

How embarrassing!  This bug was actually in *my* patch, sorry.  I had
my patch lingering as sort of work-in-progress, and inadvertently
applied your series on top.

Sorry about that!

On Wed, Feb 10, 2021 at 09:06:43AM -0600, Bjorn Helgaas wrote:
> FYI
> 
> On Wed, Feb 10, 2021 at 08:42:19PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/error
> > branch HEAD: 5692817fc88f347328e35cd7b19bd04f4400652e  PCI/portdrv: Report reset for frozen channel
> > 
> > Error/Warning reports:
> > 
> > https://lore.kernel.org/linux-pci/202102101255.HZtDITwe-lkp@intel.com
> > https://lore.kernel.org/linux-pci/202102101438.UDt0kMOO-lkp@intel.com
> > https://lore.kernel.org/linux-pci/202102101442.Y0f7z56q-lkp@intel.com
> > 
> > Error/Warning in current branch:
> > 
> > arch/powerpc/platforms/powernv/../../../../drivers/pci/pci.h:348:20: error: statement with no effect [-Werror=unused-value]
> > arch/powerpc/platforms/pseries/../../../../drivers/pci/pci.h:348:20: error: statement with no effect [-Werror=unused-value]
> > drivers/pci/controller/../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
> > drivers/pci/controller/dwc/../../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
> > drivers/pci/pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
> > drivers/pci/pcie/../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
> > 
> > possible Error/Warning in current branch:
> > 
> > arch/powerpc/kernel/../../../drivers/pci/pci.h:348:20: error: statement with no effect [-Werror=unused-value]
> > drivers/pci/controller/cadence/../../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
> > drivers/pci/hotplug/../pci.h:348:20: warning: equality comparison result unused [-Wunused-comparison]
> > 
> > Error/Warning ids grouped by kconfigs:
> > 
> > gcc_recent_errors
> > |-- powerpc-pseries_defconfig
> > |   |-- arch-powerpc-platforms-powernv-..-..-..-..-drivers-pci-pci.h:error:statement-with-no-effect
> > |   `-- arch-powerpc-platforms-pseries-..-..-..-..-drivers-pci-pci.h:error:statement-with-no-effect
> > `-- powerpc64-randconfig-s032-20210209
> >     `-- arch-powerpc-kernel-..-..-..-drivers-pci-pci.h:error:statement-with-no-effect
> > 
> > clang_recent_errors
> > |-- arm64-randconfig-r025-20210209
> > |   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
> > |-- powerpc64-randconfig-r026-20210209
> > |   `-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |-- riscv-randconfig-r023-20210209
> > |   `-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |-- s390-randconfig-r024-20210209
> > |   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-controller-cadence-..-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-hotplug-..-pci.h:warning:equality-comparison-result-unused
> > |   `-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |-- x86_64-randconfig-a011-20210209
> > |   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
> > |-- x86_64-randconfig-a012-20210209
> > |   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
> > |-- x86_64-randconfig-a013-20210209
> > |   |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
> > |-- x86_64-randconfig-a014-20210209
> > |   |-- drivers-pci-controller-..-pci.h:warning:equality-comparison-result-unused
> > |   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
> > |-- x86_64-randconfig-a015-20210209
> > |   |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> > |   `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
> > `-- x86_64-randconfig-a016-20210209
> >     |-- drivers-pci-controller-dwc-..-..-pci.h:warning:equality-comparison-result-unused
> >     |-- drivers-pci-pci.h:warning:equality-comparison-result-unused
> >     `-- drivers-pci-pcie-..-pci.h:warning:equality-comparison-result-unused
> > 
> > elapsed time: 720m
> > 
> > configs tested: 105
> > configs skipped: 2
> > 
> > gcc tested configs:
> > arm                                 defconfig
> > arm64                            allyesconfig
> > arm64                               defconfig
> > arm                              allyesconfig
> > arm                              allmodconfig
> > powerpc                     pseries_defconfig
> > arm                       spear13xx_defconfig
> > powerpc                     kmeter1_defconfig
> > mips                       lemote2f_defconfig
> > m68k                          atari_defconfig
> > powerpc                 mpc8560_ads_defconfig
> > sh                   rts7751r2dplus_defconfig
> > powerpc                     ppa8548_defconfig
> > mips                        nlm_xlp_defconfig
> > powerpc                      pasemi_defconfig
> > arm                             mxs_defconfig
> > arc                              alldefconfig
> > mips                          ath79_defconfig
> > c6x                        evmc6474_defconfig
> > sh                               allmodconfig
> > xtensa                  audio_kc705_defconfig
> > arc                        vdk_hs38_defconfig
> > mips                           rs90_defconfig
> > powerpc                     sequoia_defconfig
> > powerpc                     taishan_defconfig
> > mips                      maltaaprp_defconfig
> > arm                       cns3420vb_defconfig
> > alpha                            allyesconfig
> > sh                             shx3_defconfig
> > arm                          ixp4xx_defconfig
> > xtensa                  nommu_kc705_defconfig
> > arm                         hackkit_defconfig
> > nds32                               defconfig
> > m68k                       m5475evb_defconfig
> > arm                           stm32_defconfig
> > sh                          rsk7201_defconfig
> > m68k                             allyesconfig
> > ia64                             allmodconfig
> > ia64                                defconfig
> > ia64                             allyesconfig
> > m68k                             allmodconfig
> > m68k                                defconfig
> > nios2                               defconfig
> > arc                              allyesconfig
> > nds32                             allnoconfig
> > c6x                              allyesconfig
> > nios2                            allyesconfig
> > csky                                defconfig
> > alpha                               defconfig
> > xtensa                           allyesconfig
> > h8300                            allyesconfig
> > arc                                 defconfig
> > parisc                              defconfig
> > s390                             allyesconfig
> > s390                             allmodconfig
> > parisc                           allyesconfig
> > s390                                defconfig
> > i386                             allyesconfig
> > sparc                            allyesconfig
> > sparc                               defconfig
> > i386                               tinyconfig
> > i386                                defconfig
> > mips                             allyesconfig
> > mips                             allmodconfig
> > powerpc                          allyesconfig
> > powerpc                          allmodconfig
> > powerpc                           allnoconfig
> > i386                 randconfig-a001-20210209
> > i386                 randconfig-a005-20210209
> > i386                 randconfig-a003-20210209
> > i386                 randconfig-a002-20210209
> > i386                 randconfig-a006-20210209
> > i386                 randconfig-a004-20210209
> > i386                 randconfig-a016-20210209
> > i386                 randconfig-a013-20210209
> > i386                 randconfig-a012-20210209
> > i386                 randconfig-a014-20210209
> > i386                 randconfig-a011-20210209
> > i386                 randconfig-a015-20210209
> > x86_64               randconfig-a006-20210209
> > x86_64               randconfig-a001-20210209
> > x86_64               randconfig-a005-20210209
> > x86_64               randconfig-a004-20210209
> > x86_64               randconfig-a002-20210209
> > x86_64               randconfig-a003-20210209
> > riscv                    nommu_k210_defconfig
> > riscv                            allyesconfig
> > riscv                    nommu_virt_defconfig
> > riscv                             allnoconfig
> > riscv                               defconfig
> > riscv                          rv32_defconfig
> > riscv                            allmodconfig
> > x86_64                                   rhel
> > x86_64                           allyesconfig
> > x86_64                    rhel-7.6-kselftests
> > x86_64                              defconfig
> > x86_64                               rhel-8.3
> > x86_64                      rhel-8.3-kbuiltin
> > x86_64                                  kexec
> > 
> > clang tested configs:
> > x86_64               randconfig-a013-20210209
> > x86_64               randconfig-a014-20210209
> > x86_64               randconfig-a015-20210209
> > x86_64               randconfig-a012-20210209
> > x86_64               randconfig-a016-20210209
> > x86_64               randconfig-a011-20210209
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
