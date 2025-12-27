Return-Path: <linux-pci+bounces-43764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B71ECDFDC9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 15:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD1CD300BB9F
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A14414AD20;
	Sat, 27 Dec 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsOekvFJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1547263B
	for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766846111; cv=none; b=Ml7saFxFRbNZn6W9vN13Z+riyL8W0+wyUOPH7yGZbnrdPHG2wnyc/MDX3nlbZhSyw1DQ40k33Yzez+1Ff+h9pnEx1cYfr1QDG7ZDhUA13kL2f7OZ6rrdDRq4IBgJKzo3NUb1n7ypEkeuQXHBvM2bUcPCNih0BR0Iq+Ilh2cjdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766846111; c=relaxed/simple;
	bh=+ufO13bCcfVXx65knPhwiqwqKlLsCLDmgdY7gqM7EkU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WDpIRm9bO8nXqAPbHqO2R4hTmiZrbikKzNmTYuJ+YFcS0vGH7ST8pGeK4H2frobLHOSsIRICAfd6bqPbH6o0WUe60NJMOwb2+IltpdVH014VCGJbP5URXCeX+f27JYofbB8AWxwnt/lOE4MmZFjyVUVRLomESDUGf/OSESVD9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsOekvFJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766846108; x=1798382108;
  h=date:from:to:cc:subject:message-id;
  bh=+ufO13bCcfVXx65knPhwiqwqKlLsCLDmgdY7gqM7EkU=;
  b=QsOekvFJNZq2/x/zlI/k6mMOgyDB4NPHCysCatEpWHRXhz95IFhhoFmA
   NLRrh8E48c95rS9JqoX58mhkApIVmzRKS/3hZUM1eS+BPLPmKZ9JE3w5I
   eQCdunL5TBulcF4CecnF3AeeeiKhoLIEtOC/npppjegn0zgDZTTPIIw44
   cpZBmcX/t/e/tpUzZZNxYMMGjVt/56XBL/zH3UMPdcQ8esPndYFvWOcsw
   WAtwOKki0i1RrUlHDdEandV5mhG2mJ5Ms2hpV7SZxYFEs04F/lFwJuaDD
   u2lCyipCosCBxgLPCc06WLfPAznSfcb70Qhsc7kH0/VaMVSydGzWJzDD1
   A==;
X-CSE-ConnectionGUID: O9T712kIRYeEF0jdIWwwVQ==
X-CSE-MsgGUID: jX+NwSqJSO6HpAzafqw29w==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="79177725"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="79177725"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 06:35:08 -0800
X-CSE-ConnectionGUID: Dfcv2VtmTYyyS6hG7UW7vQ==
X-CSE-MsgGUID: RocfkeDmR2GhLvMHx2YwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="201035552"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Dec 2025 06:35:07 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZVNp-000000005sj-1CWN;
	Sat, 27 Dec 2025 14:35:05 +0000
Date: Sat, 27 Dec 2025 22:34:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-meson] BUILD SUCCESS
 113d9712f63b410e0567756ea41fc3f7cb878008
Message-ID: <202512272234.ourrRO9e-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-meson
branch HEAD: 113d9712f63b410e0567756ea41fc3f7cb878008  PCI: meson: Report that link is up while in ASPM L0s and L1 states

elapsed time: 923m

configs tested: 203
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251227    gcc-11.5.0
arc                   randconfig-001-20251227    gcc-9.5.0
arc                   randconfig-002-20251227    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251227    gcc-8.5.0
arm                   randconfig-001-20251227    gcc-9.5.0
arm                   randconfig-002-20251227    clang-22
arm                   randconfig-002-20251227    gcc-9.5.0
arm                   randconfig-003-20251227    clang-22
arm                   randconfig-003-20251227    gcc-9.5.0
arm                   randconfig-004-20251227    clang-22
arm                   randconfig-004-20251227    gcc-9.5.0
arm                           u8500_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251227    clang-19
arm64                 randconfig-002-20251227    gcc-15.1.0
arm64                 randconfig-003-20251227    clang-20
arm64                 randconfig-004-20251227    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251227    gcc-15.1.0
csky                  randconfig-002-20251227    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251227    clang-22
hexagon               randconfig-002-20251227    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251227    clang-20
i386        buildonly-randconfig-002-20251227    clang-20
i386        buildonly-randconfig-003-20251227    clang-20
i386        buildonly-randconfig-004-20251227    clang-20
i386        buildonly-randconfig-005-20251227    clang-20
i386        buildonly-randconfig-006-20251227    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251227    clang-20
i386                  randconfig-002-20251227    clang-20
i386                  randconfig-003-20251227    clang-20
i386                  randconfig-004-20251227    gcc-13
i386                  randconfig-005-20251227    gcc-14
i386                  randconfig-006-20251227    gcc-14
i386                  randconfig-007-20251227    clang-20
i386                  randconfig-011-20251227    gcc-12
i386                  randconfig-011-20251227    gcc-14
i386                  randconfig-012-20251227    clang-20
i386                  randconfig-012-20251227    gcc-12
i386                  randconfig-013-20251227    gcc-12
i386                  randconfig-013-20251227    gcc-14
i386                  randconfig-014-20251227    gcc-12
i386                  randconfig-014-20251227    gcc-14
i386                  randconfig-015-20251227    gcc-12
i386                  randconfig-016-20251227    clang-20
i386                  randconfig-016-20251227    gcc-12
i386                  randconfig-017-20251227    gcc-12
i386                  randconfig-017-20251227    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251227    clang-18
loongarch             randconfig-002-20251227    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
mips                           jazz_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251227    gcc-11.5.0
nios2                 randconfig-002-20251227    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251227    gcc-8.5.0
parisc                randconfig-002-20251227    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-19
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251227    gcc-8.5.0
powerpc               randconfig-002-20251227    clang-22
powerpc64             randconfig-001-20251227    clang-22
powerpc64             randconfig-002-20251227    gcc-8.5.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251227    clang-22
riscv                 randconfig-002-20251227    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251227    clang-22
s390                  randconfig-002-20251227    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251227    gcc-15.1.0
sh                    randconfig-002-20251227    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                            shmin_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251227    gcc-14.3.0
sparc                 randconfig-002-20251227    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251227    gcc-8.5.0
sparc64               randconfig-002-20251227    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251227    clang-22
um                    randconfig-002-20251227    clang-19
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251227    clang-20
x86_64      buildonly-randconfig-002-20251227    clang-20
x86_64      buildonly-randconfig-003-20251227    gcc-14
x86_64      buildonly-randconfig-004-20251227    clang-20
x86_64      buildonly-randconfig-005-20251227    clang-20
x86_64      buildonly-randconfig-006-20251227    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251227    gcc-14
x86_64                randconfig-002-20251227    gcc-12
x86_64                randconfig-003-20251227    gcc-14
x86_64                randconfig-004-20251227    clang-20
x86_64                randconfig-005-20251227    gcc-14
x86_64                randconfig-006-20251227    clang-20
x86_64                randconfig-011-20251227    gcc-14
x86_64                randconfig-012-20251227    clang-20
x86_64                randconfig-013-20251227    clang-20
x86_64                randconfig-014-20251227    gcc-14
x86_64                randconfig-015-20251227    gcc-13
x86_64                randconfig-016-20251227    gcc-14
x86_64                randconfig-071-20251227    clang-20
x86_64                randconfig-072-20251227    clang-20
x86_64                randconfig-073-20251227    clang-20
x86_64                randconfig-074-20251227    clang-20
x86_64                randconfig-075-20251227    clang-20
x86_64                randconfig-076-20251227    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251227    gcc-9.5.0
xtensa                randconfig-002-20251227    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

