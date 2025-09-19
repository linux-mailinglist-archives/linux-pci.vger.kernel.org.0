Return-Path: <linux-pci+bounces-36547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE9B8B9D3
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 01:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A858777E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CE256C6F;
	Fri, 19 Sep 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zd0keZa5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAF21ABC9
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323502; cv=none; b=gr5NvWi8cM/pjz9amhQ7nXrHJ5eWIXpwQPGfMDcOJZ93I7mQmA5fw5uCgHQXkE+JdxRdFE6GvRrltkjSiKu1zFDTWAaQaDD4wkCYYofciqtVqhx2hY5luxBPawktbtK2OEN+06BbNV30KtLUAqd/yMsYGha/i6Clb8S0HGPGAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323502; c=relaxed/simple;
	bh=TA2z0adpoYRnOSRWaCp4fk6ymRGrNk4FMxkHQkZGRz0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B4m74FBeyU7gesx6simW5mRMBA2ay+o9hMpqfCph2R9BHH6V/imhLtuYTL9zgdLUPjg+RTCkRyYhExz9sLm6kki56VKCMdZ0Gm6Ajx7Zfclud7zbz+CA8tZuo8cZwYyg31jjYC0MPGxwLJnpnaFFJzZpZ4msxHNjqSVK3FEtx/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zd0keZa5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758323501; x=1789859501;
  h=date:from:to:cc:subject:message-id;
  bh=TA2z0adpoYRnOSRWaCp4fk6ymRGrNk4FMxkHQkZGRz0=;
  b=Zd0keZa5XRXJMR7bmngypJQnSzyM/J1K6UbQ5B8TPd577k0tdI9r3+eD
   pcypOxyCz0oKr/szpaKbHRZjlsIR1SrdVWnWWQW5PbBb5a4bKPAmgQONW
   bwd7Up9AaO/NsZSCMO+bj4oyU15Gy5dGGOQdRjd3ofrvA7Vn7eNxey+AH
   AZvkfvA0H8f7DiRQufg+cXpji/E6MDkQadJk83MofAWhaL4mCgg2vbB3o
   T0qxw52zJD8RXIKLZUQdrS+3wuRMthc8giZZ2EhtT0+NFqmtkSsD/dS+O
   WcKJhHQCm5owr1AThkZyQRJOQT3+axx+/jYAr+Tdmgkb2MFU3SKHnVHZh
   Q==;
X-CSE-ConnectionGUID: QZ7W1x6JSHicMuj0LPj5bw==
X-CSE-MsgGUID: O4Od3CB7Q+Gvg+LdInkUWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="71302004"
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="71302004"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 16:11:40 -0700
X-CSE-ConnectionGUID: YKUjvTsTRzKLVLsayaS0Sw==
X-CSE-MsgGUID: r9HDPfYhTvaUYa7/936YcA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Sep 2025 16:11:39 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzkGP-0004sw-0B;
	Fri, 19 Sep 2025 23:11:37 +0000
Date: Sat, 20 Sep 2025 07:10:46 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 8a760c454da263f4b5f0f557e26141b2a3186b40
Message-ID: <202509200740.EYwaAR5W-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 8a760c454da263f4b5f0f557e26141b2a3186b40  Documentation: PCI: Fix typos

elapsed time: 1466m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-11.5.0
arc                   randconfig-001-20250919    gcc-11.5.0
arc                   randconfig-001-20250919    gcc-15.1.0
arc                   randconfig-002-20250919    gcc-11.5.0
arc                   randconfig-002-20250919    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          ep93xx_defconfig    gcc-11.5.0
arm                   randconfig-001-20250919    gcc-11.5.0
arm                   randconfig-001-20250919    gcc-12.5.0
arm                   randconfig-002-20250919    gcc-10.5.0
arm                   randconfig-002-20250919    gcc-11.5.0
arm                   randconfig-003-20250919    gcc-11.5.0
arm                   randconfig-003-20250919    gcc-12.5.0
arm                   randconfig-004-20250919    clang-22
arm                   randconfig-004-20250919    gcc-11.5.0
arm                        vexpress_defconfig    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250919    gcc-11.5.0
arm64                 randconfig-001-20250919    gcc-15.1.0
arm64                 randconfig-002-20250919    gcc-11.5.0
arm64                 randconfig-002-20250919    gcc-8.5.0
arm64                 randconfig-003-20250919    gcc-11.5.0
arm64                 randconfig-003-20250919    gcc-12.5.0
arm64                 randconfig-004-20250919    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250919    clang-22
csky                  randconfig-001-20250919    gcc-14.3.0
csky                  randconfig-002-20250919    clang-22
csky                  randconfig-002-20250919    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250919    clang-20
i386        buildonly-randconfig-001-20250919    gcc-14
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250919    clang-20
i386        buildonly-randconfig-005-20250919    gcc-14
i386        buildonly-randconfig-006-20250919    clang-20
i386        buildonly-randconfig-006-20250919    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250919    gcc-14
i386                  randconfig-002-20250919    gcc-14
i386                  randconfig-003-20250919    gcc-14
i386                  randconfig-004-20250919    gcc-14
i386                  randconfig-005-20250919    gcc-14
i386                  randconfig-006-20250919    gcc-14
i386                  randconfig-007-20250919    gcc-14
i386                  randconfig-011-20250919    clang-20
i386                  randconfig-012-20250919    clang-20
i386                  randconfig-013-20250919    clang-20
i386                  randconfig-014-20250919    clang-20
i386                  randconfig-015-20250919    clang-20
i386                  randconfig-016-20250919    clang-20
i386                  randconfig-017-20250919    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250919    clang-22
loongarch             randconfig-001-20250919    gcc-15.1.0
loongarch             randconfig-002-20250919    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250919    clang-22
nios2                 randconfig-001-20250919    gcc-10.5.0
nios2                 randconfig-002-20250919    clang-22
nios2                 randconfig-002-20250919    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-11.5.0
parisc                randconfig-001-20250919    clang-22
parisc                randconfig-001-20250919    gcc-15.1.0
parisc                randconfig-002-20250919    clang-22
parisc                randconfig-002-20250919    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-11.5.0
powerpc               randconfig-001-20250919    clang-22
powerpc               randconfig-001-20250919    gcc-10.5.0
powerpc               randconfig-002-20250919    clang-22
powerpc               randconfig-002-20250919    gcc-8.5.0
powerpc               randconfig-003-20250919    clang-18
powerpc               randconfig-003-20250919    clang-22
powerpc                     tqm8560_defconfig    gcc-11.5.0
powerpc64             randconfig-001-20250919    clang-22
powerpc64             randconfig-001-20250919    gcc-8.5.0
powerpc64             randconfig-002-20250919    clang-22
powerpc64             randconfig-002-20250919    gcc-13.4.0
powerpc64             randconfig-003-20250919    clang-18
powerpc64             randconfig-003-20250919    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250919    gcc-10.5.0
riscv                 randconfig-002-20250919    gcc-10.5.0
riscv                 randconfig-002-20250919    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250919    gcc-10.5.0
s390                  randconfig-001-20250919    gcc-8.5.0
s390                  randconfig-002-20250919    gcc-10.5.0
s390                  randconfig-002-20250919    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250919    gcc-10.5.0
sh                    randconfig-001-20250919    gcc-12.5.0
sh                    randconfig-002-20250919    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250919    gcc-10.5.0
sparc                 randconfig-001-20250919    gcc-14.3.0
sparc                 randconfig-002-20250919    gcc-10.5.0
sparc                 randconfig-002-20250919    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250919    clang-22
sparc64               randconfig-001-20250919    gcc-10.5.0
sparc64               randconfig-002-20250919    gcc-10.5.0
sparc64               randconfig-002-20250919    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250919    gcc-10.5.0
um                    randconfig-001-20250919    gcc-12
um                    randconfig-002-20250919    clang-22
um                    randconfig-002-20250919    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250919    clang-20
x86_64      buildonly-randconfig-002-20250919    clang-20
x86_64      buildonly-randconfig-002-20250919    gcc-14
x86_64      buildonly-randconfig-003-20250919    clang-20
x86_64      buildonly-randconfig-003-20250919    gcc-14
x86_64      buildonly-randconfig-004-20250919    clang-20
x86_64      buildonly-randconfig-005-20250919    clang-20
x86_64      buildonly-randconfig-006-20250919    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250919    clang-20
x86_64                randconfig-002-20250919    clang-20
x86_64                randconfig-003-20250919    clang-20
x86_64                randconfig-004-20250919    clang-20
x86_64                randconfig-005-20250919    clang-20
x86_64                randconfig-006-20250919    clang-20
x86_64                randconfig-007-20250919    clang-20
x86_64                randconfig-008-20250919    clang-20
x86_64                randconfig-071-20250919    gcc-14
x86_64                randconfig-072-20250919    gcc-14
x86_64                randconfig-073-20250919    gcc-14
x86_64                randconfig-074-20250919    gcc-14
x86_64                randconfig-075-20250919    gcc-14
x86_64                randconfig-076-20250919    gcc-14
x86_64                randconfig-077-20250919    gcc-14
x86_64                randconfig-078-20250919    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250919    gcc-10.5.0
xtensa                randconfig-001-20250919    gcc-11.5.0
xtensa                randconfig-002-20250919    gcc-10.5.0
xtensa                randconfig-002-20250919    gcc-8.5.0
xtensa                    xip_kc705_defconfig    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

