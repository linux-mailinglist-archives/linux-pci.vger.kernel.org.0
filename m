Return-Path: <linux-pci+bounces-26324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F917A94C78
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 08:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A0A7A4B7A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 06:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3C258CD6;
	Mon, 21 Apr 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5h1dVcm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65125743C
	for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216302; cv=none; b=iPAt1uz0LyrD2mWYbwfIDeFFLIaNQrvL3STTAJ9r7WMnUSuZ3Sj7ucT+Df4nx07EAOXLKAqRGYOlaagKsSnJGrRN41XbwO6PwnBwA8JmYTmZ7ZRSpK9F062FcL77ZRqagww3oPkdhQs22IMbNF4tJfVSiJSoRtank8lfyMZ7bjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216302; c=relaxed/simple;
	bh=nl8jzdN7l8Y1kfIpcnmrAGkq1/wbOYHw6Tw2+qU0u9c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SCbA89z9VZURAuYAHRIRE2j0TGtDSPj8Q7vGOalY9YMpklefrAwC7tYZu+Ar+KLhktqjMzNcgD89Ymylg3V19Np2W91/s88HGXZPpwqwNB+jgHRm8zRReAsoPMiBA5VGcSpOzJOyBDtFq9KXqR2jMh2uuK0CtBDFqgJ5URyXj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5h1dVcm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745216301; x=1776752301;
  h=date:from:to:cc:subject:message-id;
  bh=nl8jzdN7l8Y1kfIpcnmrAGkq1/wbOYHw6Tw2+qU0u9c=;
  b=Q5h1dVcmlyOzFHKsqkIUQJmeXADRkm5CIvNip9kKGhZD2Spn0EtYjBIX
   IKe+GCMB4p7zCnU1jJl0gSVPGXowjnm13PySU2F/I/zA97BnRp6UPDBDd
   OnPb85ZMawA0dOPN5UWuqyRZv1Wq5qmbpay/IKJyQEEJSVfxxR/5d/zx3
   270iSHCJoA1s/37fbntd6HO8b8ttO0Qt/F2xsrDZZUxgQDl9ItY0bP9ae
   sSyWuVxD9L7vYUTpkYEbbqdtZc5HiYUjrFyl+Ux78BczpVjyMVQ34ns8S
   wdJcgIo/2rf6ifz6rfHo5asjwM4CdyDsyb3FsN4GmTFp2jkB/ZIwolinK
   w==;
X-CSE-ConnectionGUID: cQteBc+2RtKpHcCdwnNTig==
X-CSE-MsgGUID: EfSkZcioRxGatSKJCf7kUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46627852"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="46627852"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 23:18:18 -0700
X-CSE-ConnectionGUID: ZFnROhQfRgWxs4wETysS3Q==
X-CSE-MsgGUID: MFbnJXwVRpKDehCd54pvig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="136443445"
Received: from lkp-server01.sh.intel.com (HELO 9c2f37e2d822) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Apr 2025 23:18:16 -0700
Received: from kbuild by 9c2f37e2d822 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6kTu-0000C3-1x;
	Mon, 21 Apr 2025 06:18:14 +0000
Date: Mon, 21 Apr 2025 14:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 7ab8db9042cb37222bebf77beeb1ff4df0789a84
Message-ID: <202504211413.sVMP9GGw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 7ab8db9042cb37222bebf77beeb1ff4df0789a84  dt-bindings: PCI: Remove obsolete .txt docs

elapsed time: 1446m

configs tested: 215
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250420    gcc-12.4.0
arc                   randconfig-002-20250420    gcc-12.4.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-21
arm                                 defconfig    clang-21
arm                          exynos_defconfig    clang-21
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250420    clang-21
arm                   randconfig-002-20250420    gcc-8.5.0
arm                   randconfig-003-20250420    gcc-7.5.0
arm                   randconfig-004-20250420    gcc-8.5.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    clang-21
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250420    gcc-8.5.0
arm64                 randconfig-002-20250420    gcc-8.5.0
arm64                 randconfig-003-20250420    clang-21
arm64                 randconfig-004-20250420    gcc-6.5.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250420    gcc-14.2.0
csky                  randconfig-002-20250420    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250420    clang-21
hexagon               randconfig-002-20250420    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250420    clang-20
i386        buildonly-randconfig-002-20250420    clang-20
i386        buildonly-randconfig-003-20250420    clang-20
i386        buildonly-randconfig-004-20250420    clang-20
i386        buildonly-randconfig-005-20250420    clang-20
i386        buildonly-randconfig-006-20250420    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250421    gcc-12
i386                  randconfig-002-20250421    gcc-12
i386                  randconfig-003-20250421    gcc-12
i386                  randconfig-004-20250421    gcc-12
i386                  randconfig-005-20250421    gcc-12
i386                  randconfig-006-20250421    gcc-12
i386                  randconfig-007-20250421    gcc-12
i386                  randconfig-011-20250421    clang-20
i386                  randconfig-012-20250421    clang-20
i386                  randconfig-013-20250421    clang-20
i386                  randconfig-014-20250421    clang-20
i386                  randconfig-015-20250421    clang-20
i386                  randconfig-016-20250421    clang-20
i386                  randconfig-017-20250421    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250420    gcc-12.4.0
loongarch             randconfig-002-20250420    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-18
mips                        bcm63xx_defconfig    clang-21
mips                           ip30_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250420    gcc-14.2.0
nios2                 randconfig-002-20250420    gcc-8.5.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250420    gcc-13.3.0
parisc                randconfig-002-20250420    gcc-7.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-21
powerpc                    gamecube_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250420    clang-21
powerpc               randconfig-002-20250420    gcc-6.5.0
powerpc               randconfig-003-20250420    clang-21
powerpc                     tqm8541_defconfig    clang-21
powerpc                     tqm8548_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250420    gcc-8.5.0
powerpc64             randconfig-002-20250420    clang-21
powerpc64             randconfig-003-20250420    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250420    clang-21
riscv                 randconfig-002-20250420    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250420    gcc-6.5.0
s390                  randconfig-002-20250420    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250420    gcc-14.2.0
sh                    randconfig-002-20250420    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250420    gcc-11.5.0
sparc                 randconfig-002-20250420    gcc-7.5.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250420    gcc-9.3.0
sparc64               randconfig-002-20250420    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250420    gcc-12
um                    randconfig-002-20250420    clang-21
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250420    clang-20
x86_64      buildonly-randconfig-002-20250420    gcc-12
x86_64      buildonly-randconfig-003-20250420    gcc-12
x86_64      buildonly-randconfig-004-20250420    gcc-12
x86_64      buildonly-randconfig-005-20250420    clang-20
x86_64      buildonly-randconfig-006-20250420    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250421    clang-20
x86_64                randconfig-002-20250421    clang-20
x86_64                randconfig-003-20250421    clang-20
x86_64                randconfig-004-20250421    clang-20
x86_64                randconfig-005-20250421    clang-20
x86_64                randconfig-006-20250421    clang-20
x86_64                randconfig-007-20250421    clang-20
x86_64                randconfig-008-20250421    clang-20
x86_64                randconfig-071-20250421    gcc-12
x86_64                randconfig-072-20250421    gcc-12
x86_64                randconfig-073-20250421    gcc-12
x86_64                randconfig-074-20250421    gcc-12
x86_64                randconfig-075-20250421    gcc-12
x86_64                randconfig-076-20250421    gcc-12
x86_64                randconfig-077-20250421    gcc-12
x86_64                randconfig-078-20250421    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250420    gcc-9.3.0
xtensa                randconfig-002-20250420    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

