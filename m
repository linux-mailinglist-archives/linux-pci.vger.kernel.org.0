Return-Path: <linux-pci+bounces-38850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A471FBF4BC3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 08:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F640121B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5920102B;
	Tue, 21 Oct 2025 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KccuQ31q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC31FC8
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029231; cv=none; b=aycAVzxuFUo77vXspPKkCaIPa8KDNm0HyYW52tLffZCOkCZi4BM1FIYtutbEwr8eq/G5zE3mIdbQa+FSFJVSU4JRm6ubQlsGgsTlx8uHHdaZj6+ZYgpFQ3uI9mvgxVb0liRAohIITHLRyeLK15VLGi2yXrmAedufrgTaxzc5Saw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029231; c=relaxed/simple;
	bh=pzusioux3xHlNrMiXD7PIZ+Z7Zp4dFJtMm9Uyz7BsJ4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F5SETZqM04rTGs2vhfr/Awa95YPZxNcYm0D0un8oNzKROenHKRfrvv52Y7bFuTj3/6jMeN5uAy1w39OiWP8ieraZrHDMstWhNQFZojixSY4alezOvI9ENX9Zi4jaK7FnUL+GNhM7qDkuRbY66vboKbx/1NdsUHNVcWlrclASPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KccuQ31q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761029230; x=1792565230;
  h=date:from:to:cc:subject:message-id;
  bh=pzusioux3xHlNrMiXD7PIZ+Z7Zp4dFJtMm9Uyz7BsJ4=;
  b=KccuQ31qInqOSvZhOGk+Yi0n/ylWmbDDKhcHQAs4A3guDY4r1FzJ9Etp
   ul9AnAIVfzXaIUdXn8y0WKjN/PrjZBC7QTUZxGNIU+0DXqu664nDbj4fG
   eIG4ToXmlBlsB+RUGCbQC9DeHa55SZpJtqd9EtFMxUQsj0vfEH/2wsd4H
   ibNKN3Hf8fU/Qq4L/6NYu/pG/CIeA9mk5iGPso11NXlZEOJu9UzajTeM6
   PXBBKoi2O3NLITgmysAkCfqYzIX83rXzZNaSCBG475+mRk5O6dHeoL+nR
   jqYreR5ch5ffGBNrcBsbTVaJ97ex7T+pRF3o+YJAzSiGcFlIDdvUl6zHw
   A==;
X-CSE-ConnectionGUID: laSdKVT+S/e9dYdOtTfqLg==
X-CSE-MsgGUID: 65MalO1BSL69Hj1HcCPm4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63067693"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63067693"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 23:47:10 -0700
X-CSE-ConnectionGUID: CfmmVMBPTXmRXrHpKGmHEQ==
X-CSE-MsgGUID: O74AegN8SBGO5EQhsVSnEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="182664529"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 20 Oct 2025 23:47:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vB69C-000Aa2-0P;
	Tue, 21 Oct 2025 06:47:06 +0000
Date: Tue, 21 Oct 2025 14:47:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 16fbaba2b78f3adb3ae44a765b5c9ed08779be59
Message-ID: <202510211457.xgZQ9uE9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 16fbaba2b78f3adb3ae44a765b5c9ed08779be59  MIPS: Malta: Use pcibios_align_resource() to block io range

elapsed time: 895m

configs tested: 229
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251021    clang-22
arc                   randconfig-001-20251021    gcc-8.5.0
arc                   randconfig-002-20251021    clang-22
arc                   randconfig-002-20251021    gcc-9.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           imxrt_defconfig    gcc-15.1.0
arm                   randconfig-001-20251021    clang-22
arm                   randconfig-002-20251021    clang-22
arm                   randconfig-003-20251021    clang-22
arm                   randconfig-004-20251021    clang-22
arm                           u8500_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251021    clang-22
arm64                 randconfig-001-20251021    gcc-15.1.0
arm64                 randconfig-002-20251021    clang-22
arm64                 randconfig-003-20251021    clang-22
arm64                 randconfig-003-20251021    gcc-12.5.0
arm64                 randconfig-004-20251021    clang-18
arm64                 randconfig-004-20251021    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251020    gcc-15.1.0
csky                  randconfig-001-20251021    gcc-8.5.0
csky                  randconfig-002-20251020    gcc-15.1.0
csky                  randconfig-002-20251021    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251020    clang-22
hexagon               randconfig-001-20251021    gcc-8.5.0
hexagon               randconfig-002-20251020    clang-22
hexagon               randconfig-002-20251021    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251020    gcc-14
i386        buildonly-randconfig-001-20251021    clang-20
i386        buildonly-randconfig-002-20251020    clang-20
i386        buildonly-randconfig-002-20251021    clang-20
i386        buildonly-randconfig-003-20251020    gcc-14
i386        buildonly-randconfig-003-20251021    clang-20
i386        buildonly-randconfig-004-20251020    gcc-14
i386        buildonly-randconfig-004-20251021    clang-20
i386        buildonly-randconfig-005-20251020    clang-20
i386        buildonly-randconfig-005-20251021    clang-20
i386        buildonly-randconfig-006-20251020    clang-20
i386        buildonly-randconfig-006-20251021    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251021    gcc-14
i386                  randconfig-002-20251021    gcc-14
i386                  randconfig-003-20251021    gcc-14
i386                  randconfig-004-20251021    gcc-14
i386                  randconfig-005-20251021    gcc-14
i386                  randconfig-006-20251021    gcc-14
i386                  randconfig-007-20251021    gcc-14
i386                  randconfig-011-20251021    clang-20
i386                  randconfig-012-20251021    clang-20
i386                  randconfig-013-20251021    clang-20
i386                  randconfig-014-20251021    clang-20
i386                  randconfig-015-20251021    clang-20
i386                  randconfig-016-20251021    clang-20
i386                  randconfig-017-20251021    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251020    gcc-15.1.0
loongarch             randconfig-001-20251021    gcc-8.5.0
loongarch             randconfig-002-20251020    gcc-15.1.0
loongarch             randconfig-002-20251021    gcc-8.5.0
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
mips                        bcm63xx_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251020    gcc-10.5.0
nios2                 randconfig-001-20251021    gcc-8.5.0
nios2                 randconfig-002-20251020    gcc-8.5.0
nios2                 randconfig-002-20251021    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251020    gcc-13.4.0
parisc                randconfig-001-20251021    gcc-8.5.0
parisc                randconfig-002-20251020    gcc-10.5.0
parisc                randconfig-002-20251021    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251020    clang-22
powerpc               randconfig-001-20251021    gcc-8.5.0
powerpc               randconfig-002-20251020    gcc-8.5.0
powerpc               randconfig-002-20251021    gcc-8.5.0
powerpc               randconfig-003-20251020    clang-22
powerpc               randconfig-003-20251021    gcc-8.5.0
powerpc64             randconfig-001-20251020    clang-19
powerpc64             randconfig-001-20251021    gcc-8.5.0
powerpc64             randconfig-002-20251020    gcc-11.5.0
powerpc64             randconfig-002-20251021    gcc-8.5.0
powerpc64             randconfig-003-20251020    gcc-8.5.0
powerpc64             randconfig-003-20251021    gcc-8.5.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251021    gcc-8.5.0
riscv                 randconfig-002-20251021    clang-22
riscv                 randconfig-002-20251021    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251021    clang-22
s390                  randconfig-001-20251021    gcc-8.5.0
s390                  randconfig-002-20251021    gcc-11.5.0
s390                  randconfig-002-20251021    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251021    gcc-8.5.0
sh                    randconfig-001-20251021    gcc-9.5.0
sh                    randconfig-002-20251021    gcc-10.5.0
sh                    randconfig-002-20251021    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251021    gcc-8.5.0
sparc                 randconfig-002-20251021    gcc-14.3.0
sparc                 randconfig-002-20251021    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251021    gcc-8.5.0
sparc64               randconfig-002-20251021    gcc-10.5.0
sparc64               randconfig-002-20251021    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251021    gcc-14
um                    randconfig-001-20251021    gcc-8.5.0
um                    randconfig-002-20251021    gcc-14
um                    randconfig-002-20251021    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251021    clang-20
x86_64      buildonly-randconfig-001-20251021    gcc-13
x86_64      buildonly-randconfig-002-20251021    clang-20
x86_64      buildonly-randconfig-003-20251021    clang-20
x86_64      buildonly-randconfig-004-20251021    clang-20
x86_64      buildonly-randconfig-005-20251021    clang-20
x86_64      buildonly-randconfig-005-20251021    gcc-14
x86_64      buildonly-randconfig-006-20251021    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251021    gcc-14
x86_64                randconfig-002-20251021    gcc-14
x86_64                randconfig-003-20251021    gcc-14
x86_64                randconfig-004-20251021    gcc-14
x86_64                randconfig-005-20251021    gcc-14
x86_64                randconfig-006-20251021    gcc-14
x86_64                randconfig-007-20251021    gcc-14
x86_64                randconfig-008-20251021    gcc-14
x86_64                randconfig-071-20251021    gcc-14
x86_64                randconfig-072-20251021    gcc-14
x86_64                randconfig-073-20251021    gcc-14
x86_64                randconfig-074-20251021    gcc-14
x86_64                randconfig-075-20251021    gcc-14
x86_64                randconfig-076-20251021    gcc-14
x86_64                randconfig-077-20251021    gcc-14
x86_64                randconfig-078-20251021    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251021    gcc-8.5.0
xtensa                randconfig-002-20251021    gcc-13.4.0
xtensa                randconfig-002-20251021    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

