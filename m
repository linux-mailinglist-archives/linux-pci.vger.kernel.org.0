Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BA239C0B
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgHBU5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 16:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgHBU5C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Aug 2020 16:57:02 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB9420738;
        Sun,  2 Aug 2020 20:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596401820;
        bh=DwloRtzGajmmbDoETDZdePO/PQuENCoXVHHUHGJVDtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=z6N8KnSrL7Zye3DibqY6/NWpGOZQHF1VHugRJ55gdEFYq8nfpTFq+3sn8tPTPJwIQ
         S29Fm1tHK9BN/amV17CHaBgjXucKdKy2iGrgMZB/nLQM6345qQSiGcMVKaPV6jkSsp
         Q1VhliuMlrdTeQ7+6fioXTmVjuuY7tdl/XJpYhOg=
Date:   Sun, 2 Aug 2020 15:56:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [pci:next] BUILD REGRESSION
 d189141dc9d45bf2bcc7d990d105eed99237ac33
Message-ID: <20200802205659.GA257905@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2658b4.KNFK0dVpQicPR9Q7%lkp@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

I can try to fix this up, but not until tomorrow.

On Sun, Aug 02, 2020 at 02:09:56PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
> branch HEAD: d189141dc9d45bf2bcc7d990d105eed99237ac33  Merge branch 'pci/doc'
> 
> Error/Warning in current branch:
> 
> drivers/pci/controller/pcie-xilinx-cpm.c:553:8: error: implicit declaration of function 'pci_parse_request_of_pci_ranges' [-Werror=implicit-function-declaration]
> 
> Error/Warning ids grouped by kconfigs:
> 
> recent_errors
> |-- alpha-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- arm-allmodconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- arm-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- arm64-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- i386-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- ia64-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- mips-allmodconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- mips-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- parisc-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- powerpc-allmodconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- powerpc-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- riscv-allmodconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- s390-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- sparc-allyesconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> |-- x86_64-allmodconfig
> |   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> `-- xtensa-allyesconfig
>     `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
> 
> elapsed time: 1861m
> 
> configs tested: 83
> configs skipped: 4
> 
> arm                                 defconfig
> arm64                            allyesconfig
> arm64                               defconfig
> arm                              allyesconfig
> arm                              allmodconfig
> m68k                            q40_defconfig
> riscv                    nommu_virt_defconfig
> powerpc                     mpc512x_defconfig
> mips                 decstation_r4k_defconfig
> xtensa                    xip_kc705_defconfig
> arm                       versatile_defconfig
> arm                             ezx_defconfig
> powerpc                       maple_defconfig
> arm                            pleb_defconfig
> arm                            mmp2_defconfig
> arm                          lpd270_defconfig
> ia64                             allmodconfig
> ia64                                defconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nds32                               defconfig
> nios2                            allyesconfig
> csky                                defconfig
> alpha                               defconfig
> alpha                            allyesconfig
> xtensa                           allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> nios2                               defconfig
> arc                              allyesconfig
> nds32                             allnoconfig
> c6x                              allyesconfig
> parisc                              defconfig
> s390                             allyesconfig
> parisc                           allyesconfig
> s390                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> i386                                defconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                             defconfig
> powerpc                          allyesconfig
> powerpc                          allmodconfig
> powerpc                           allnoconfig
> x86_64               randconfig-a006-20200802
> x86_64               randconfig-a001-20200802
> x86_64               randconfig-a004-20200802
> x86_64               randconfig-a003-20200802
> x86_64               randconfig-a002-20200802
> x86_64               randconfig-a005-20200802
> i386                 randconfig-a005-20200731
> i386                 randconfig-a004-20200731
> i386                 randconfig-a006-20200731
> i386                 randconfig-a002-20200731
> i386                 randconfig-a001-20200731
> i386                 randconfig-a003-20200731
> x86_64               randconfig-a015-20200731
> x86_64               randconfig-a014-20200731
> x86_64               randconfig-a016-20200731
> x86_64               randconfig-a012-20200731
> x86_64               randconfig-a013-20200731
> x86_64               randconfig-a011-20200731
> i386                 randconfig-a016-20200731
> i386                 randconfig-a012-20200731
> i386                 randconfig-a014-20200731
> i386                 randconfig-a015-20200731
> i386                 randconfig-a011-20200731
> i386                 randconfig-a013-20200731
> riscv                            allyesconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                            allmodconfig
> x86_64                                   rhel
> x86_64                    rhel-7.6-kselftests
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                                  kexec
> x86_64                           allyesconfig
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
