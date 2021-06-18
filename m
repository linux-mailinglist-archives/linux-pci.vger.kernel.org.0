Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BBD3ACBD3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhFRNPV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 09:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231445AbhFRNPU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 09:15:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 538C9608FC;
        Fri, 18 Jun 2021 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624021991;
        bh=Ry7GUTemd3e6/ABTacig174NwNlLJV43TKfGnN2d+w4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qYDM35oVUTUGxXOgMWeWVFV1sYMSl/cTaACDq+/PRxGfB6p8B5QCKaLZwKVBiWpZh
         AZApE/OBxK+cDLqlfgarNI50gZQR/fWpsbjpK9h4GXUkes2zYFGyf4PZz68hXLQ50x
         8lZpOoTLjS9hpheDVLm3wnbwB/Vi/4SIbfHxuyD8+7xhz7Gzd4NgVpENtZaLIg/JAH
         Ni0Kd3R/ieX5tlaDROZ4tp2M18T7ITXpkLeZXPkrxq8jNBTSZln+IElSgKJ1HyY+P5
         nxGAa9vWfguqA1VQC+TxvNvybLbIAfUkzQft5X9PHYLkUatWwAZHuszyoHBsS4R0ut
         XHcLms/KIGh9g==
Date:   Fri, 18 Jun 2021 08:13:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-pci@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [pci:for-linus] BUILD SUCCESS WITH WARNING
 15ac366c3d20ce1e08173f1de393a8ce95a1facf
Message-ID: <20210618131304.GA3182065@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60cc76ac.4/mGW5mezrK/kfBE%lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Jon, +cc Thierry]

On Fri, Jun 18, 2021 at 06:34:20PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
> branch HEAD: 15ac366c3d20ce1e08173f1de393a8ce95a1facf  PCI: aardvark: Fix kernel panic during PIO transfer
> 
> possible Warning in current branch:
> 
> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]

This looks like a legit warning, but I think the only commit that
could be related is this one:

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=99ab5996278379a02d5a84c4a7ac33a2ebfdb29e

which doesn't touch that code.

It does *move* some code, so maybe this was an existing warning that
moved enough that the robot thought it was new?

Or is this a new compiler version or were more warnings turned on?

How can we reproduce this to make sure we fix it?

> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- m68k-randconfig-p001-20210617
>     `-- drivers-pci-controller-dwc-pcie-tegra194.c:warning:Shifting-signed-bit-value-by-bits-is-undefined-behaviour.-See-condition-at-line-.-shiftTooManyBitsSigned
> 
> elapsed time: 723m
> 
> configs tested: 127
> configs skipped: 2
> 
> gcc tested configs:
> arm                                 defconfig
> arm64                            allyesconfig
> arm64                               defconfig
> arm                              allyesconfig
> arm                              allmodconfig
> arm                     davinci_all_defconfig
> sh                           se7750_defconfig
> mips                     loongson1c_defconfig
> arm                         lpc32xx_defconfig
> mips                          ath79_defconfig
> arm                          lpd270_defconfig
> arm64                            alldefconfig
> arm                        keystone_defconfig
> riscv                          rv32_defconfig
> arm                        trizeps4_defconfig
> sh                      rts7751r2d1_defconfig
> arm                       omap2plus_defconfig
> s390                          debug_defconfig
> mips                         mpc30x_defconfig
> powerpc                   bluestone_defconfig
> nios2                            alldefconfig
> powerpc                    adder875_defconfig
> powerpc               mpc834x_itxgp_defconfig
> arm                          ep93xx_defconfig
> mips                     loongson1b_defconfig
> sh                             sh03_defconfig
> powerpc                     pseries_defconfig
> riscv             nommu_k210_sdcard_defconfig
> arm                          pxa910_defconfig
> sh                          lboxre2_defconfig
> arm                         at91_dt_defconfig
> arm                      tct_hammer_defconfig
> arm                      pxa255-idp_defconfig
> arm                        multi_v5_defconfig
> sh                           se7722_defconfig
> powerpc                    klondike_defconfig
> powerpc                       eiger_defconfig
> ia64                            zx1_defconfig
> sh                 kfr2r09-romimage_defconfig
> powerpc                      pcm030_defconfig
> sh                          r7785rp_defconfig
> xtensa                    smp_lx200_defconfig
> m68k                          sun3x_defconfig
> arm                        cerfcube_defconfig
> powerpc                      tqm8xx_defconfig
> m68k                            q40_defconfig
> powerpc                 mpc834x_mds_defconfig
> powerpc                      ppc44x_defconfig
> x86_64                            allnoconfig
> ia64                             allmodconfig
> ia64                                defconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nios2                               defconfig
> arc                              allyesconfig
> nds32                             allnoconfig
> nds32                               defconfig
> nios2                            allyesconfig
> csky                                defconfig
> alpha                               defconfig
> alpha                            allyesconfig
> xtensa                           allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> parisc                              defconfig
> s390                             allyesconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> i386                                defconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                          allmodconfig
> powerpc                           allnoconfig
> i386                 randconfig-a002-20210618
> i386                 randconfig-a006-20210618
> i386                 randconfig-a004-20210618
> i386                 randconfig-a001-20210618
> i386                 randconfig-a005-20210618
> i386                 randconfig-a003-20210618
> x86_64               randconfig-a015-20210618
> x86_64               randconfig-a011-20210618
> x86_64               randconfig-a012-20210618
> x86_64               randconfig-a014-20210618
> x86_64               randconfig-a016-20210618
> x86_64               randconfig-a013-20210618
> i386                 randconfig-a015-20210618
> i386                 randconfig-a016-20210618
> i386                 randconfig-a013-20210618
> i386                 randconfig-a014-20210618
> i386                 randconfig-a012-20210618
> i386                 randconfig-a011-20210618
> i386                 randconfig-a015-20210617
> i386                 randconfig-a013-20210617
> i386                 randconfig-a016-20210617
> i386                 randconfig-a012-20210617
> i386                 randconfig-a014-20210617
> i386                 randconfig-a011-20210617
> riscv                    nommu_k210_defconfig
> riscv                            allyesconfig
> riscv                    nommu_virt_defconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                            allmodconfig
> x86_64                    rhel-8.3-kselftests
> um                           x86_64_defconfig
> um                             i386_defconfig
> um                            kunit_defconfig
> x86_64                           allyesconfig
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                      rhel-8.3-kbuiltin
> x86_64                                  kexec
> 
> clang tested configs:
> x86_64               randconfig-b001-20210618
> x86_64               randconfig-a002-20210618
> x86_64               randconfig-a001-20210618
> x86_64               randconfig-a004-20210618
> x86_64               randconfig-a003-20210618
> x86_64               randconfig-a006-20210618
> x86_64               randconfig-a005-20210618
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
