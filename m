Return-Path: <linux-pci+bounces-42591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC29CA1A5E
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 22:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E89FE3001DFA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D44238C1B;
	Wed,  3 Dec 2025 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f58UtOSL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD429ACD8
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796476; cv=none; b=qgysmqengslhDEgj66uzY6JKggeUCk6xRaNvpfp8DGfHlZx+bFLiwR5SeWUxnFeVpSWpQX1NgzKQATVl3jNsu2G6eIAROmtmozu20xLsLX2B7vowKcRYmx4JUzfJ5OsTB4w6AlbBqrtnhIe8K0WE34YIFw8eHAi8NZt7c4wQaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796476; c=relaxed/simple;
	bh=05ihqGskPDBrZxxS1ZR9kyNPMk4t+fJN+vf7UFKpgB4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DWuYo7v251BKkIGbNQRUGUvjE7U1eoNfDzXOJtzd0++q79foQzlDMkKE2oKV5uHLY4+uqmUGBwwAMGw4jX06GPAL6R1qmcIlU9xRvqXKaMohxL0SiUvKMH+xLYt03dv0ULhW0Ycf3NjGY2FfhP3wPj61UQuGTROgWYgOmsWBXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f58UtOSL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764796475; x=1796332475;
  h=date:from:to:cc:subject:message-id;
  bh=05ihqGskPDBrZxxS1ZR9kyNPMk4t+fJN+vf7UFKpgB4=;
  b=f58UtOSL7uJQV+39v2SUloXBmjqvbNF72p7rg3QM+54cN2Dj3q6LF8Q/
   BShinj5KU+hRNMEAJHlSoy2Ad/FEc3BT//PQ9xo782pbwzWvzBzGrdrdZ
   4xTz6USJactVpnVheVmxzkSAZupnKWt8S1qxHY50mdd+R7ngtykzUG7OQ
   96LvwRr162ZhtA+102u+MRafn2lyOBBsok9WWT/hKDYXuSN0uKJx/QiJb
   7/7jSZtwQGVmMUL93Ey4HzpUNgu7bEQ5kcbOCcCEXPB7CLPfrjP4s09pz
   hHUzWQcUrFSZG3BnI4IlkIZ+K4ua2iEIk+CDj+oyk74jRaDb5S/s0AHIx
   w==;
X-CSE-ConnectionGUID: wxBcg06lSV6RrFLd8A/Vdg==
X-CSE-MsgGUID: rbZVPJ99Qr69sMUZeq1QGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="78157278"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="78157278"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 13:14:34 -0800
X-CSE-ConnectionGUID: /wq8tKDJTweLldDuXuaeNw==
X-CSE-MsgGUID: UGA4+nNfT/+R5RwQKaGHTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="194835704"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Dec 2025 13:14:33 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQuBC-00000000D98-2yk6;
	Wed, 03 Dec 2025 21:14:30 +0000
Date: Thu, 04 Dec 2025 05:14:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/s32g] BUILD SUCCESS
 de45401e27bcecbc56ff2f02edc00a37beb1501b
Message-ID: <202512040506.Il8w6UtS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/s32g
branch HEAD: de45401e27bcecbc56ff2f02edc00a37beb1501b  MAINTAINERS: Add NXP S32G PCIe controller driver maintainer

elapsed time: 1446m

configs tested: 211
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    clang-22
arc                   randconfig-001-20251203    gcc-9.5.0
arc                   randconfig-001-20251204    gcc-10.5.0
arc                   randconfig-002-20251203    gcc-11.5.0
arc                   randconfig-002-20251204    gcc-10.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                           h3600_defconfig    clang-22
arm                   randconfig-001-20251203    gcc-8.5.0
arm                   randconfig-001-20251204    gcc-10.5.0
arm                   randconfig-002-20251203    clang-22
arm                   randconfig-002-20251204    gcc-10.5.0
arm                   randconfig-003-20251203    clang-22
arm                   randconfig-003-20251204    gcc-10.5.0
arm                   randconfig-004-20251203    clang-22
arm                   randconfig-004-20251204    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251203    gcc-8.5.0
arm64                 randconfig-001-20251204    clang-22
arm64                 randconfig-001-20251204    gcc-14.3.0
arm64                 randconfig-002-20251204    gcc-14.3.0
arm64                 randconfig-003-20251204    clang-16
arm64                 randconfig-003-20251204    gcc-14.3.0
arm64                 randconfig-004-20251203    gcc-8.5.0
arm64                 randconfig-004-20251204    clang-22
arm64                 randconfig-004-20251204    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251203    gcc-15.1.0
csky                  randconfig-001-20251204    gcc-11.5.0
csky                  randconfig-001-20251204    gcc-14.3.0
csky                  randconfig-002-20251203    gcc-15.1.0
csky                  randconfig-002-20251204    gcc-14.3.0
csky                  randconfig-002-20251204    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon               randconfig-001-20251203    clang-22
hexagon               randconfig-001-20251204    gcc-15.1.0
hexagon               randconfig-002-20251203    clang-20
hexagon               randconfig-002-20251204    gcc-15.1.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251203    gcc-14
i386        buildonly-randconfig-001-20251204    clang-20
i386        buildonly-randconfig-002-20251203    gcc-14
i386        buildonly-randconfig-002-20251204    clang-20
i386        buildonly-randconfig-003-20251203    gcc-14
i386        buildonly-randconfig-003-20251204    clang-20
i386        buildonly-randconfig-004-20251203    clang-20
i386        buildonly-randconfig-004-20251204    clang-20
i386        buildonly-randconfig-005-20251203    clang-20
i386        buildonly-randconfig-005-20251204    clang-20
i386        buildonly-randconfig-006-20251203    gcc-14
i386        buildonly-randconfig-006-20251204    clang-20
i386                  randconfig-001-20251203    clang-20
i386                  randconfig-002-20251203    gcc-14
i386                  randconfig-003-20251203    clang-20
i386                  randconfig-004-20251203    clang-20
i386                  randconfig-005-20251203    gcc-14
i386                  randconfig-006-20251203    gcc-14
i386                  randconfig-007-20251203    gcc-14
i386                  randconfig-011-20251203    clang-20
i386                  randconfig-012-20251203    gcc-14
i386                  randconfig-013-20251203    clang-20
i386                  randconfig-014-20251203    gcc-14
i386                  randconfig-015-20251203    gcc-13
i386                  randconfig-016-20251203    clang-20
i386                  randconfig-017-20251203    clang-20
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251203    gcc-15.1.0
loongarch             randconfig-001-20251204    gcc-15.1.0
loongarch             randconfig-002-20251203    gcc-14.3.0
loongarch             randconfig-002-20251204    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251203    gcc-9.5.0
nios2                 randconfig-001-20251204    gcc-15.1.0
nios2                 randconfig-002-20251203    gcc-8.5.0
nios2                 randconfig-002-20251204    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    clang-22
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251203    gcc-12.5.0
parisc                randconfig-001-20251204    clang-22
parisc                randconfig-002-20251203    gcc-8.5.0
parisc                randconfig-002-20251204    clang-22
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251203    gcc-8.5.0
powerpc               randconfig-001-20251204    clang-22
powerpc               randconfig-002-20251203    clang-22
powerpc               randconfig-002-20251204    clang-22
powerpc64             randconfig-001-20251204    clang-22
powerpc64             randconfig-002-20251203    clang-22
powerpc64             randconfig-002-20251204    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                    nommu_k210_defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20251203    gcc-14.3.0
riscv                 randconfig-002-20251203    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251203    clang-22
s390                  randconfig-002-20251203    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251203    gcc-15.1.0
sh                    randconfig-002-20251203    gcc-13.4.0
sh                          rsk7269_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251203    gcc-13.4.0
sparc                 randconfig-002-20251203    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251203    clang-20
sparc64               randconfig-002-20251203    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251203    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251203    clang-20
x86_64      buildonly-randconfig-002-20251203    clang-20
x86_64      buildonly-randconfig-003-20251203    clang-20
x86_64      buildonly-randconfig-004-20251203    gcc-14
x86_64      buildonly-randconfig-005-20251203    clang-20
x86_64      buildonly-randconfig-006-20251203    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251203    gcc-14
x86_64                randconfig-001-20251204    clang-20
x86_64                randconfig-002-20251203    gcc-14
x86_64                randconfig-002-20251204    clang-20
x86_64                randconfig-003-20251203    clang-20
x86_64                randconfig-003-20251204    clang-20
x86_64                randconfig-004-20251203    clang-20
x86_64                randconfig-004-20251204    clang-20
x86_64                randconfig-005-20251203    gcc-14
x86_64                randconfig-005-20251204    clang-20
x86_64                randconfig-006-20251203    gcc-14
x86_64                randconfig-006-20251204    clang-20
x86_64                randconfig-011-20251204    clang-20
x86_64                randconfig-012-20251204    clang-20
x86_64                randconfig-014-20251204    gcc-14
x86_64                randconfig-015-20251204    gcc-13
x86_64                randconfig-071-20251203    clang-20
x86_64                randconfig-072-20251203    gcc-14
x86_64                randconfig-073-20251203    clang-20
x86_64                randconfig-074-20251203    gcc-14
x86_64                randconfig-075-20251203    clang-20
x86_64                randconfig-076-20251203    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    clang-22
xtensa                randconfig-001-20251203    gcc-14.3.0
xtensa                randconfig-002-20251203    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

