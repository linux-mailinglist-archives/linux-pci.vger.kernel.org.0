Return-Path: <linux-pci+bounces-15787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBB99B8C72
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 08:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA092283720
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B6155725;
	Fri,  1 Nov 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgU75yup"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E81156256
	for <linux-pci@vger.kernel.org>; Fri,  1 Nov 2024 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447719; cv=none; b=diXWj3dmSnQbKwLj73yfi7HiQx2rERN8U0PB7vPcHinLSpxsoyblSqJFrnvWFZqGuaCvSGl113xN1MZefhizREMsfJPSJ5Zq4siaq/mwrWE5WKk0B2A7/J8m92DRi4x/i5k86FUrVeAZOqwyrsCTfbKQDSeaDx6CepQzK+ZgleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447719; c=relaxed/simple;
	bh=2wsqwFbuIJd0lEWWUt+wANjtrBijm7meb5pEsM6NmVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OfGq6PYOuKTgPiIFm5n2KguJ8nY8OlvMDovbu1Ew87WHmE4NiTEA6rkUM7wBUn8ZJh3WEIxgiimwk6J2Dbu2HgLdNkzQIeX0KuOkZIY7aZ4Qdv9YQNW4MnisKa8NaxlDObhx9B4Z324QRBcHGv2CMcxe3zQiAw1ONeWj1bwVhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgU75yup; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730447717; x=1761983717;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2wsqwFbuIJd0lEWWUt+wANjtrBijm7meb5pEsM6NmVg=;
  b=EgU75yup+aWuQrjDBqXaEJ1hqIXBiTubVQwV49j4iRdaELP+506U4dgZ
   HseKvaMM7xYwhVMvgC+sStQVWI1FWbGouxk+t6ZG/sMsgRHDuORBiDtUB
   w96HEu7gjqFY4YRBv6HIcA2xTsePwIUXR1ShqsKr8LozQ6TW8R/4SbIYi
   odnpD0gmOVz+sf1KLOuMy3QD1jVdI6JJI9gLxa68Ua3kGvZHDkk99EyTl
   mlrY5ztjQu57TVYUhFihfY3JTtSs0hi9qoGFm88IP8SsGrJ1nDAUfJmB6
   KA4oH7Wcg1H9KbI01uJV5VTHANzCIXdudW+TZ8mcwWgh79pjuyz/s+AF/
   w==;
X-CSE-ConnectionGUID: SObIP91RTWifwD/vTe8dyg==
X-CSE-MsgGUID: +ACpRoltTZSpyIG0ajydsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29981200"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29981200"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:55:17 -0700
X-CSE-ConnectionGUID: 20rMjnrWQ1eiV+Nrvz0T5A==
X-CSE-MsgGUID: 5Y1CndyPQcGukWUJ+BXQLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83001701"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Nov 2024 00:55:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6mUz-000hHn-1N;
	Fri, 01 Nov 2024 07:55:13 +0000
Date: Fri, 01 Nov 2024 15:54:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/microchip] BUILD SUCCESS
 61efe7e328bc4e9a646d78cc6c3b0525fc10bb70
Message-ID: <202411011529.gIhMEfGI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/microchip
branch HEAD: 61efe7e328bc4e9a646d78cc6c3b0525fc10bb70  PCI: microchip: Rework reg region handing to support using either instance 1 or 2

elapsed time: 863m

configs tested: 148
configs skipped: 4

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
arc                   randconfig-001-20241101    gcc-14.1.0
arc                   randconfig-002-20241101    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                           omap1_defconfig    gcc-14.1.0
arm                          pxa3xx_defconfig    gcc-14.1.0
arm                   randconfig-001-20241101    gcc-14.1.0
arm                   randconfig-002-20241101    gcc-14.1.0
arm                   randconfig-003-20241101    gcc-14.1.0
arm                   randconfig-004-20241101    gcc-14.1.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241101    gcc-14.1.0
arm64                 randconfig-002-20241101    gcc-14.1.0
arm64                 randconfig-003-20241101    gcc-14.1.0
arm64                 randconfig-004-20241101    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241101    gcc-14.1.0
csky                  randconfig-002-20241101    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241101    gcc-14.1.0
hexagon               randconfig-002-20241101    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241101    gcc-12
i386        buildonly-randconfig-002-20241101    gcc-12
i386        buildonly-randconfig-003-20241101    gcc-12
i386        buildonly-randconfig-004-20241101    gcc-12
i386        buildonly-randconfig-005-20241101    gcc-12
i386        buildonly-randconfig-006-20241101    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241101    gcc-12
i386                  randconfig-002-20241101    gcc-12
i386                  randconfig-003-20241101    gcc-12
i386                  randconfig-004-20241101    gcc-12
i386                  randconfig-005-20241101    gcc-12
i386                  randconfig-006-20241101    gcc-12
i386                  randconfig-011-20241101    gcc-12
i386                  randconfig-012-20241101    gcc-12
i386                  randconfig-013-20241101    gcc-12
i386                  randconfig-014-20241101    gcc-12
i386                  randconfig-015-20241101    gcc-12
i386                  randconfig-016-20241101    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241101    gcc-14.1.0
loongarch             randconfig-002-20241101    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           gcw0_defconfig    gcc-14.1.0
mips                           ip28_defconfig    gcc-14.1.0
mips                        maltaup_defconfig    gcc-14.1.0
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241101    gcc-14.1.0
nios2                 randconfig-002-20241101    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241101    gcc-14.1.0
parisc                randconfig-002-20241101    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   motionpro_defconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241101    gcc-14.1.0
powerpc               randconfig-002-20241101    gcc-14.1.0
powerpc               randconfig-003-20241101    gcc-14.1.0
powerpc64             randconfig-001-20241101    gcc-14.1.0
powerpc64             randconfig-002-20241101    gcc-14.1.0
powerpc64             randconfig-003-20241101    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241101    gcc-14.1.0
riscv                 randconfig-002-20241101    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241101    gcc-14.1.0
s390                  randconfig-002-20241101    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241101    gcc-14.1.0
sh                    randconfig-002-20241101    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                          alldefconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241101    gcc-14.1.0
sparc64               randconfig-002-20241101    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241101    gcc-14.1.0
um                    randconfig-002-20241101    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241101    gcc-14.1.0
xtensa                randconfig-002-20241101    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

