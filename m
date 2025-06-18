Return-Path: <linux-pci+bounces-30067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC7ADEF5E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A622340620C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547792EBBAD;
	Wed, 18 Jun 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlx11TRv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C222C08B8
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256704; cv=none; b=uVKYHx1cTj65XRfPkatneOY5ywWtPj+ECy3Nt1NeEBvxCgyDoyVwLw/deBWje/uyDhLk5wg1py7AVqLTR1Ya+gCHfExMrwWcGWZdquh1sQHApFIX/123opRjI6PsFIyT/nS02DmSdUdCqHCGbGgE2x8XpKcK3o3aswXvmYpdWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256704; c=relaxed/simple;
	bh=G3DGzWZjqtXomPrQatuHWOA76uGNSjRuFDvZwaZbo5Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qYRKBKyj5YFK8INjQP21QA8HbXnEUpJVUQuO9hErFwqIZPFAieFvcSxUgk/B2KU+MfdBmSHlFea7rudXLEm0qUwN3JAIo8s6OEW9g89i4mwjIOaEGS4eD6vO9o/17rZyuYtOQ1dcCp0wpiwnqZnjmH9qycHTWIjE9nW0kdelNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlx11TRv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750256702; x=1781792702;
  h=date:from:to:cc:subject:message-id;
  bh=G3DGzWZjqtXomPrQatuHWOA76uGNSjRuFDvZwaZbo5Q=;
  b=mlx11TRvbX6KqkTKMyiRVA6Kh+5kP4dJT9cuJRUhBFE4FcyL1KCD63ip
   2FgCHIABvGEiJ8lkWDtr5TMoyZJKbSikDBL0hWkS4m3ZBuiKuUMGtLDZn
   IqHRYwmu1NeUVXBKcpw3QAGjn4byK3Qc8RuOVt2AiebsMpkCxEC+rd6MW
   QAXmfBRBJiIFB+9CxrieF7meXocZyWtnKsJYT92OEn2AVcLDa9PKsOpx9
   Z4B/3fxq3oBoqNA/7XIdL1Ij55usIsH3ABuERrs87t48FM2Y0wkW6zt6B
   cWY6fFS/QvrUcL4K8T/S/X72jSr5gNPQnLiAa/RtNNP+shgCvMP/xv7kw
   w==;
X-CSE-ConnectionGUID: gtNR24neR4Oo84UZvPA2eQ==
X-CSE-MsgGUID: h/xAFNn3Q5mu9qCrl8zdLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52564930"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52564930"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 07:23:54 -0700
X-CSE-ConnectionGUID: ZYrb1PlLQluAjA8K1YTilw==
X-CSE-MsgGUID: 2QWOxQlRRumhHcErVBrajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150332677"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Jun 2025 07:23:53 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRthe-000JsD-3C;
	Wed, 18 Jun 2025 14:23:50 +0000
Date: Wed, 18 Jun 2025 22:23:07 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 35636068ce18b8506a7c6cb475395707b6ef3989
Message-ID: <202506182258.2Ad7qYMf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 35636068ce18b8506a7c6cb475395707b6ef3989  dt-bindings: PCI: pci-ep: Extend max-link-speed to PCIe Gen5/Gen6

elapsed time: 1290m

configs tested: 225
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250618    gcc-11.5.0
arc                   randconfig-002-20250618    gcc-11.5.0
arc                   randconfig-002-20250618    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250618    gcc-11.5.0
arm                   randconfig-001-20250618    gcc-15.1.0
arm                   randconfig-002-20250618    gcc-10.5.0
arm                   randconfig-002-20250618    gcc-11.5.0
arm                   randconfig-003-20250618    clang-21
arm                   randconfig-003-20250618    gcc-11.5.0
arm                   randconfig-004-20250618    gcc-11.5.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250618    clang-21
arm64                 randconfig-001-20250618    gcc-11.5.0
arm64                 randconfig-002-20250618    clang-21
arm64                 randconfig-002-20250618    gcc-11.5.0
arm64                 randconfig-003-20250618    gcc-11.5.0
arm64                 randconfig-003-20250618    gcc-14.3.0
arm64                 randconfig-004-20250618    clang-16
arm64                 randconfig-004-20250618    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250618    gcc-13.3.0
csky                  randconfig-001-20250618    gcc-8.5.0
csky                  randconfig-002-20250618    gcc-15.1.0
csky                  randconfig-002-20250618    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250618    clang-19
hexagon               randconfig-001-20250618    gcc-8.5.0
hexagon               randconfig-002-20250618    clang-16
hexagon               randconfig-002-20250618    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250618    clang-20
i386        buildonly-randconfig-002-20250618    clang-20
i386        buildonly-randconfig-002-20250618    gcc-12
i386        buildonly-randconfig-003-20250618    clang-20
i386        buildonly-randconfig-004-20250618    clang-20
i386        buildonly-randconfig-005-20250618    clang-20
i386        buildonly-randconfig-006-20250618    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250618    gcc-12
i386                  randconfig-002-20250618    gcc-12
i386                  randconfig-003-20250618    gcc-12
i386                  randconfig-004-20250618    gcc-12
i386                  randconfig-005-20250618    gcc-12
i386                  randconfig-006-20250618    gcc-12
i386                  randconfig-007-20250618    gcc-12
i386                  randconfig-011-20250618    gcc-12
i386                  randconfig-012-20250618    gcc-12
i386                  randconfig-013-20250618    gcc-12
i386                  randconfig-014-20250618    gcc-12
i386                  randconfig-015-20250618    gcc-12
i386                  randconfig-016-20250618    gcc-12
i386                  randconfig-017-20250618    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-8.5.0
loongarch             randconfig-002-20250618    gcc-15.1.0
loongarch             randconfig-002-20250618    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       alldefconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250618    gcc-11.5.0
nios2                 randconfig-001-20250618    gcc-8.5.0
nios2                 randconfig-002-20250618    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250618    gcc-10.5.0
parisc                randconfig-001-20250618    gcc-8.5.0
parisc                randconfig-002-20250618    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250618    gcc-8.5.0
powerpc               randconfig-002-20250618    clang-19
powerpc               randconfig-002-20250618    gcc-8.5.0
powerpc               randconfig-003-20250618    clang-21
powerpc               randconfig-003-20250618    gcc-8.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250618    gcc-8.5.0
powerpc64             randconfig-002-20250618    clang-21
powerpc64             randconfig-002-20250618    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250618    clang-20
riscv                 randconfig-001-20250618    gcc-15.1.0
riscv                 randconfig-002-20250618    clang-21
riscv                 randconfig-002-20250618    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250618    gcc-15.1.0
s390                  randconfig-001-20250618    gcc-8.5.0
s390                  randconfig-002-20250618    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250618    gcc-15.1.0
sh                    randconfig-002-20250618    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7724_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-8.5.0
sparc                 randconfig-002-20250618    gcc-13.3.0
sparc                 randconfig-002-20250618    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250618    gcc-13.3.0
sparc64               randconfig-001-20250618    gcc-15.1.0
sparc64               randconfig-002-20250618    gcc-15.1.0
sparc64               randconfig-002-20250618    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250618    clang-21
um                    randconfig-001-20250618    gcc-15.1.0
um                    randconfig-002-20250618    clang-21
um                    randconfig-002-20250618    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250618    clang-20
x86_64      buildonly-randconfig-001-20250618    gcc-12
x86_64      buildonly-randconfig-002-20250618    clang-20
x86_64      buildonly-randconfig-002-20250618    gcc-12
x86_64      buildonly-randconfig-003-20250618    gcc-12
x86_64      buildonly-randconfig-004-20250618    clang-20
x86_64      buildonly-randconfig-004-20250618    gcc-12
x86_64      buildonly-randconfig-005-20250618    clang-20
x86_64      buildonly-randconfig-005-20250618    gcc-12
x86_64      buildonly-randconfig-006-20250618    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250618    gcc-12
x86_64                randconfig-002-20250618    gcc-12
x86_64                randconfig-003-20250618    gcc-12
x86_64                randconfig-004-20250618    gcc-12
x86_64                randconfig-005-20250618    gcc-12
x86_64                randconfig-006-20250618    gcc-12
x86_64                randconfig-007-20250618    gcc-12
x86_64                randconfig-008-20250618    gcc-12
x86_64                randconfig-071-20250618    clang-20
x86_64                randconfig-072-20250618    clang-20
x86_64                randconfig-073-20250618    clang-20
x86_64                randconfig-074-20250618    clang-20
x86_64                randconfig-075-20250618    clang-20
x86_64                randconfig-076-20250618    clang-20
x86_64                randconfig-077-20250618    clang-20
x86_64                randconfig-078-20250618    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250618    gcc-13.3.0
xtensa                randconfig-001-20250618    gcc-15.1.0
xtensa                randconfig-002-20250618    gcc-11.5.0
xtensa                randconfig-002-20250618    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

