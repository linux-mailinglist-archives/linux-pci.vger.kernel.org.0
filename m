Return-Path: <linux-pci+bounces-12607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590019680EA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CA3282933
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C251714B7;
	Mon,  2 Sep 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kksvHH3c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251D15382C
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263451; cv=none; b=jKgGWdMj7AOpIP92z0aj6Z3nVTs5xaQW2m4ezficYSz/BXkGumOCRh+5sH1m7PfzyVdu68YCG1ZTLRnCKspicL0dNEC9FCgrHuC4k2dr5Dgc4bue/Gwfa6bR0Id8Wf90QDsoebciaj1ma0GrrLOwMXiONtdUScRSq1mi4BSIYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263451; c=relaxed/simple;
	bh=GMG2S57aUeaG7CeeM+WAjAJq0tk6jkSAsQuMom/gfCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q2GXVP2vOYmJz9F+qjx2Lo0DImB7p40tLVhNS3H6QIeJ516FF0xVic2BPAHnMY1iyar3Ot/3RmrwKkBVfGQp9giw6vA85SXv2ueyEy91zB2/7gjuWBAUzWCzuTeWZ2MScc2SuTDxgOiWt/vMupCETa68AVb6HVNHCeyy7R1wFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kksvHH3c; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725263449; x=1756799449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GMG2S57aUeaG7CeeM+WAjAJq0tk6jkSAsQuMom/gfCM=;
  b=kksvHH3cY93WGDK+WYNEub6zdPa95KqRrX7ppd2K9z53gpShgi1qQH+6
   bYXFbZGdifSBrdbh0WRsP0iPFQKW2BsaM652Ah6RuS+TQ3iTaemkaO6Q4
   qDy2VRMkliotlb4wDW5PylqDvDCEBIVvr8cXqOlFYH4KP0/FKctg/Eoqp
   XH/l3jDEP71f91FJDUos912mQzs0PiLZfBAlL9pDphRkukP6Aq06p480f
   lteK8j0lrGVdFE/Cl4/JnwOIRqDqgLLYlcUayVBcAmEt9sf9WvvO9iDIM
   zW+vvRDE15lqPZaxDkDFiSRDTiVTKf1TiZ3CNosGkKVmHlfPv2h2H36ml
   g==;
X-CSE-ConnectionGUID: MPIdxTgvT2CsQpTASobfBQ==
X-CSE-MsgGUID: N+TYkYI9QI+BINGBWalb4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34443945"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34443945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 00:50:48 -0700
X-CSE-ConnectionGUID: koC3KZg9TvWaMH+5mf8rcQ==
X-CSE-MsgGUID: C3ojXiMsRQ+8wC9y8ZXSNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="87772740"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Sep 2024 00:50:47 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sl1pl-0005GG-0i;
	Mon, 02 Sep 2024 07:50:45 +0000
Date: Mon, 02 Sep 2024 15:50:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 4654cf52cbd07cb2d6ab6f55bcc5eb2dae8b736a
Message-ID: <202409021535.iqaKW5yd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 4654cf52cbd07cb2d6ab6f55bcc5eb2dae8b736a  PCI: vmd: Fix indentation issue in vmd_shutdown()

elapsed time: 842m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                          axs103_defconfig   gcc-14.1.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-14.1.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g4_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240902   clang-18
i386         buildonly-randconfig-002-20240902   clang-18
i386         buildonly-randconfig-003-20240902   clang-18
i386         buildonly-randconfig-004-20240902   clang-18
i386         buildonly-randconfig-005-20240902   clang-18
i386         buildonly-randconfig-006-20240902   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240902   clang-18
i386                  randconfig-002-20240902   clang-18
i386                  randconfig-003-20240902   clang-18
i386                  randconfig-004-20240902   clang-18
i386                  randconfig-005-20240902   clang-18
i386                  randconfig-006-20240902   clang-18
i386                  randconfig-011-20240902   clang-18
i386                  randconfig-012-20240902   clang-18
i386                  randconfig-013-20240902   clang-18
i386                  randconfig-014-20240902   clang-18
i386                  randconfig-015-20240902   clang-18
i386                  randconfig-016-20240902   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5208evb_defconfig   gcc-14.1.0
m68k                       m5249evb_defconfig   gcc-14.1.0
m68k                            q40_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   gcc-14.1.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-13.2.0
mips                           mtx1_defconfig   gcc-14.1.0
mips                        omega2p_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-14.1.0
nios2                         3c120_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc                     powernv_defconfig   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-14.1.0
powerpc                     stx_gp3_defconfig   gcc-14.1.0
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-14.1.0
powerpc                      tqm8xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                            migor_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
sh                  sh7785lcr_32bit_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               alldefconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240902   clang-18
x86_64       buildonly-randconfig-002-20240902   clang-18
x86_64       buildonly-randconfig-003-20240902   clang-18
x86_64       buildonly-randconfig-004-20240902   clang-18
x86_64       buildonly-randconfig-005-20240902   clang-18
x86_64       buildonly-randconfig-006-20240902   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240902   clang-18
x86_64                randconfig-002-20240902   clang-18
x86_64                randconfig-003-20240902   clang-18
x86_64                randconfig-004-20240902   clang-18
x86_64                randconfig-005-20240902   clang-18
x86_64                randconfig-006-20240902   clang-18
x86_64                randconfig-011-20240902   clang-18
x86_64                randconfig-012-20240902   clang-18
x86_64                randconfig-013-20240902   clang-18
x86_64                randconfig-014-20240902   clang-18
x86_64                randconfig-015-20240902   clang-18
x86_64                randconfig-016-20240902   clang-18
x86_64                randconfig-071-20240902   clang-18
x86_64                randconfig-072-20240902   clang-18
x86_64                randconfig-073-20240902   clang-18
x86_64                randconfig-074-20240902   clang-18
x86_64                randconfig-075-20240902   clang-18
x86_64                randconfig-076-20240902   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0
xtensa                    xip_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

