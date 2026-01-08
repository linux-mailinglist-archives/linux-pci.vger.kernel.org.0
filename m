Return-Path: <linux-pci+bounces-44304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F36D067AE
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2D85302C858
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA732B990;
	Thu,  8 Jan 2026 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdYaBWuA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725642C21EC
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912811; cv=none; b=CF37CD9Tu109QLtZ0+aHqecoI88MDA+qBQ0N/EK4WJ3FZgsGQPrYBP9n4ECXioEBEyqyadXYwsUeyv7Axkvf0+Zd/Gb9DMUUIT0NHrMIukJCFSNwYaHb830UIlE8s27htydhevVuh7/AfkBj+QEDnnD+y3f6b2mMtNaqwUmZ0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912811; c=relaxed/simple;
	bh=AvAwRTj2PyJ5rvHDossr+kEqu1GKcaynG0ROXE44vVY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=McRLQIHFoBOQ0KMW3iGzxTW0yDj04ROVeU/j4+ZSVBIL9yFFiNgtoAwEPQ6EEM4A9rCnBhE1JqDPejSvMKztDlA2nJ4AxNR39YaRdAooeu3S4oYkVXA3pyAFCRZ3x8APfiKD+I7qrlbTIPFdXIvY/UdJ531Dg4sa/hLHIqhHbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdYaBWuA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767912809; x=1799448809;
  h=date:from:to:cc:subject:message-id;
  bh=AvAwRTj2PyJ5rvHDossr+kEqu1GKcaynG0ROXE44vVY=;
  b=SdYaBWuANDXmbaq05jVL1oPAu2zcGn2vvVqpzD+KJTzJIaNKz/LSd6FT
   bW/Nra6TfVFqBp5Rc/quP/VVxkJjJ5tHNdnUKNxFSCNRsdThBHwe1JSn2
   b328P5royyRaeQKdpW439PCLegdyYuDJKwRAmw17F+lGcDpo8DkxiePqf
   Bp+9q5GDWUgEJMHditm+HM0jAHmk9Hdv1ER3f/RoK3Al3WaPk8NVH0dwt
   r/tCN1VsxN6lPjxs3t++EY3nuXA3bpXKNSF6OVgZr0AxuA41sDMGnhgUh
   AtpCd7DLZKgEgHD3GVTuDwE/nEaF/6I4pJ7ZyQkEv0pD+7SiimGQBBE/t
   w==;
X-CSE-ConnectionGUID: gHpC1aa+S0aJ+P6Z75EEdQ==
X-CSE-MsgGUID: ECfWxKiJS0CVs42Nl0nycQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79936742"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="79936742"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:53:28 -0800
X-CSE-ConnectionGUID: F/iPKAAeTZmCaV31S1QNZA==
X-CSE-MsgGUID: pCgO8L/yRpmSwuLJU7p1dw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jan 2026 14:53:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdyse-000000005E8-2nrl;
	Thu, 08 Jan 2026 22:53:24 +0000
Date: Fri, 09 Jan 2026 06:52:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 bdb32359eab94013e80cf7e3d40a3fd4972da93a
Message-ID: <202601090622.yxLcPC5R-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: bdb32359eab94013e80cf7e3d40a3fd4972da93a  sparc/PCI: Correct 64-bit non-pref -> pref BAR resources

elapsed time: 1584m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20260108    gcc-9.5.0
arc                   randconfig-002-20260108    gcc-9.5.0
arm                               allnoconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                   randconfig-001-20260108    gcc-9.5.0
arm                   randconfig-002-20260108    gcc-9.5.0
arm                   randconfig-003-20260108    gcc-9.5.0
arm                   randconfig-004-20260108    gcc-9.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20260108    gcc-10.5.0
arm64                 randconfig-002-20260108    gcc-10.5.0
arm64                 randconfig-003-20260108    gcc-10.5.0
arm64                 randconfig-004-20260108    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20260108    gcc-10.5.0
csky                  randconfig-002-20260108    gcc-10.5.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon               randconfig-001-20260108    gcc-8.5.0
hexagon               randconfig-002-20260108    gcc-8.5.0
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20260108    clang-20
i386        buildonly-randconfig-002-20260108    clang-20
i386        buildonly-randconfig-003-20260108    clang-20
i386        buildonly-randconfig-004-20260108    clang-20
i386        buildonly-randconfig-005-20260108    clang-20
i386        buildonly-randconfig-006-20260108    clang-20
i386                  randconfig-001-20260108    gcc-14
i386                  randconfig-002-20260108    gcc-14
i386                  randconfig-003-20260108    gcc-14
i386                  randconfig-004-20260108    gcc-14
i386                  randconfig-005-20260108    gcc-14
i386                  randconfig-006-20260108    gcc-14
i386                  randconfig-007-20260108    gcc-14
i386                  randconfig-011-20260108    gcc-14
i386                  randconfig-012-20260108    gcc-14
i386                  randconfig-013-20260108    gcc-14
i386                  randconfig-014-20260108    gcc-14
i386                  randconfig-015-20260108    gcc-14
i386                  randconfig-016-20260108    gcc-14
i386                  randconfig-017-20260108    gcc-14
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260108    gcc-8.5.0
loongarch             randconfig-002-20260108    gcc-8.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
mips                  decstation_64_defconfig    gcc-15.1.0
mips                      loongson3_defconfig    gcc-15.1.0
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260108    gcc-8.5.0
nios2                 randconfig-002-20260108    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260108    clang-22
parisc                randconfig-002-20260108    clang-22
parisc64                            defconfig    clang-19
powerpc                           allnoconfig    clang-22
powerpc                  mpc866_ads_defconfig    gcc-15.1.0
powerpc               randconfig-001-20260108    clang-22
powerpc               randconfig-002-20260108    clang-22
powerpc64             randconfig-001-20260108    clang-22
powerpc64             randconfig-002-20260108    clang-22
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20260108    gcc-13.4.0
riscv                 randconfig-002-20260108    gcc-13.4.0
s390                              allnoconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20260108    gcc-13.4.0
sh                                allnoconfig    clang-22
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260108    gcc-13.4.0
sh                    randconfig-002-20260108    gcc-13.4.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260108    gcc-8.5.0
sparc                 randconfig-002-20260108    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260108    gcc-8.5.0
sparc64               randconfig-002-20260108    gcc-8.5.0
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260108    gcc-8.5.0
um                    randconfig-002-20260108    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260108    gcc-14
x86_64      buildonly-randconfig-002-20260108    gcc-14
x86_64      buildonly-randconfig-003-20260108    gcc-14
x86_64      buildonly-randconfig-004-20260108    gcc-14
x86_64      buildonly-randconfig-005-20260108    gcc-14
x86_64      buildonly-randconfig-006-20260108    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260108    gcc-12
x86_64                randconfig-002-20260108    gcc-12
x86_64                randconfig-003-20260108    gcc-12
x86_64                randconfig-004-20260108    gcc-12
x86_64                randconfig-005-20260108    gcc-12
x86_64                randconfig-006-20260108    gcc-12
x86_64                randconfig-011-20260108    clang-20
x86_64                randconfig-012-20260108    clang-20
x86_64                randconfig-013-20260108    clang-20
x86_64                randconfig-014-20260108    clang-20
x86_64                randconfig-015-20260108    clang-20
x86_64                randconfig-016-20260108    clang-20
x86_64                randconfig-071-20260108    gcc-14
x86_64                randconfig-072-20260108    gcc-14
x86_64                randconfig-073-20260108    gcc-14
x86_64                randconfig-074-20260108    gcc-14
x86_64                randconfig-075-20260108    gcc-14
x86_64                randconfig-076-20260108    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                randconfig-001-20260108    gcc-8.5.0
xtensa                randconfig-002-20260108    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

