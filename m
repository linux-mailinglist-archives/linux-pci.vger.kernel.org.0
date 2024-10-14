Return-Path: <linux-pci+bounces-14442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB399C6DF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 12:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE98D2831CA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985E15B122;
	Mon, 14 Oct 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exwIxRV4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B11A01BD
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900601; cv=none; b=nUEjAIQfeTNeHfur49loyNh7mMaTZuklkVjbGRDyqsN5L0lkYLoQGzPCAhhNyoeGwwhu8+PWgcqhUqxzE9AFBt6t7JFPB1LfPWwjq4ZaE07CMa6I7WXnvB2qQvWBoTNlRiLXpk9Q9QEiRqpbndU/adMIuJs/EG2jKvQlp6INiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900601; c=relaxed/simple;
	bh=FxAgZgLYG3WhCR6K5ZyTVYWI+VxuRlKimcMVV0XW9W4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GgX/uOQ8jw7X2rNuRYXRtjJYMOrddxzCnASiqIZPXawka5cwXzTwX3z94eJyGG+pEehSxZDfmDEk5egXmvsU/Zt9Z50gs9OQJUr/EZttBOxMJU34226t2utif4EpLHt7QVVQhQQ7Yiy7P1PygaRggEC1bfaYOfjwg1zi7dcNbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exwIxRV4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728900600; x=1760436600;
  h=date:from:to:cc:subject:message-id;
  bh=FxAgZgLYG3WhCR6K5ZyTVYWI+VxuRlKimcMVV0XW9W4=;
  b=exwIxRV4/tc/QGKysTiyO69rvFLfKU5G1Hb7lOwCdOjJWJ8lxIZPfnx/
   rfoe7Kk+FDMkKqO21WSkpHmLu8WBWfZnFYnw3iPoqiwARbu4FeKUTwhXG
   /BBq1CEFK7a6py306dyKz9uzfDF8lFo31eji3yb9d4blR67LIhW0Q8Lo2
   FNGrAH7SKT7fVFzH12AghBAzI3M0GSCVXpY6BJPP9eSvZuzUM3bSdTNcT
   fb5rpcI0q4BQ87xLgEnUV6cVVQPILtzVejtd/+9WdCR0jy52RasCaPcOc
   E/MUuhjTgeK5iLzY+OOXxK9rXiNR7UUCbMsuLRU+Jgiq4b6CRZlwy1BP1
   Q==;
X-CSE-ConnectionGUID: knO8P8qwTbCaP5zJS3Vy8g==
X-CSE-MsgGUID: Gz4KffA8Td2BuQ5pYP9LBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="27699847"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="27699847"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:09:59 -0700
X-CSE-ConnectionGUID: f7WfVYuPTOaZZvt7HB9hJw==
X-CSE-MsgGUID: Z20jGoayQ9+T8e97nor4Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77539561"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Oct 2024 03:09:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0I1U-000FAz-0Z;
	Mon, 14 Oct 2024 10:09:56 +0000
Date: Mon, 14 Oct 2024 18:09:45 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 acb6b7158fdf5598d5f8efd4ddd46f0145190ccd
Message-ID: <202410141838.0nGEhEzb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: acb6b7158fdf5598d5f8efd4ddd46f0145190ccd  PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation

elapsed time: 2720m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241014    clang-18
i386        buildonly-randconfig-002-20241014    gcc-12
i386        buildonly-randconfig-003-20241014    clang-18
i386        buildonly-randconfig-004-20241014    clang-18
i386        buildonly-randconfig-005-20241014    clang-18
i386        buildonly-randconfig-006-20241014    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241014    gcc-12
i386                  randconfig-002-20241014    gcc-12
i386                  randconfig-003-20241014    gcc-12
i386                  randconfig-004-20241014    clang-18
i386                  randconfig-005-20241014    clang-18
i386                  randconfig-006-20241014    clang-18
i386                  randconfig-011-20241014    gcc-12
i386                  randconfig-012-20241014    clang-18
i386                  randconfig-013-20241014    clang-18
i386                  randconfig-014-20241014    clang-18
i386                  randconfig-015-20241014    gcc-12
i386                  randconfig-016-20241014    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip32_defconfig    gcc-14.1.0
mips                          malta_defconfig    gcc-14.1.0
mips                           xway_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             alldefconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7206_defconfig    gcc-14.1.0
sh                           se7780_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

