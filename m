Return-Path: <linux-pci+bounces-35734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA391B4A409
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 09:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14973BE972
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BBC3054F6;
	Tue,  9 Sep 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7Ad852L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCD307AE8
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403690; cv=none; b=CZ5ZZO8eN433xL48ccMlse5CmsIS27NOUugzsp6mjdaqZsqE7GU3dBdZuUo3uxz5lFO65GP6PQ9Kv0v3Yxn5lYtyZVyZqRYqSD4PbacNC0BaYBiPMdtWiUOUK0iELcrcHxKlf+8DHs+4VDbuIoe9U6Rzf1DmwwgYWcuidv0JGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403690; c=relaxed/simple;
	bh=THLHeZaYRsRci1qO6/dgQwIdsw6eZu0VT/Jqsa78rBo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I9f8nZCcy1M7HIgkxxdqVy+KmYwV76fZs+PZkGGyQUHERO/twHze1I2iMQLaAvJOa3YO28ihdRNkhzS9Jk3lACmO+eRNrhRXtuwOCkF6lSrjTUo+Vsr7fcGQAn+L4huEOGgB5K64MptkOmfTCYWQPUpCzZKGZPh/pFw+H7vvN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7Ad852L; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757403689; x=1788939689;
  h=date:from:to:cc:subject:message-id;
  bh=THLHeZaYRsRci1qO6/dgQwIdsw6eZu0VT/Jqsa78rBo=;
  b=i7Ad852LukWCB7edtJiJBc23H0zHMUXPsRWRZscfdRxPynwKxPivMkrP
   Xb+y6vyV2L+QKRZk0ptYPUFkhyjORQ7Quc0dAT+aTbmNBgJW9d6wcxvbP
   +3leQ8xIUuiEjjXhNW61CD68hiNylqyDnEoLkWorHRwOFtqi2nDLUwu7v
   QJ/VwGC2HGf+Ke+2ZtWvOVYth01V3cfWjtBj+ezh6u76Bu9JtYtjZ+DPY
   xfqtc3pW4+SXxNQYsxJzMMFur5bG1urrUrSz8uvUcixkAUWKCfTjrSh8r
   zb5xQysDmZHDwv+YkJDUwllgJenEdQ9OKBL406rq+9zQ2WOJW58uV8Rlu
   Q==;
X-CSE-ConnectionGUID: EUikfrJjQWyIxjr/GyHZVQ==
X-CSE-MsgGUID: hsupncm4R8W4U3/J5WVl+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59613656"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="59613656"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 00:41:28 -0700
X-CSE-ConnectionGUID: x9rlFcwpTj+/jB3BMN0sHQ==
X-CSE-MsgGUID: XkqPoR74TQqG0ScPXnJ46Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="172888166"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Sep 2025 00:41:26 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvsyi-0004b9-0a;
	Tue, 09 Sep 2025 07:41:24 +0000
Date: Tue, 09 Sep 2025 15:41:18 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/plda] BUILD SUCCESS
 882569dca6646eb3294ec048d76f9bfea1f3348f
Message-ID: <202509091508.2HrNbIK0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/plda
branch HEAD: 882569dca6646eb3294ec048d76f9bfea1f3348f  PCI: plda: Remove dev_err_probe() when the errno is -ENOMEM

elapsed time: 1248m

configs tested: 243
configs skipped: 7

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
arc                   randconfig-001-20250908    gcc-8.5.0
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-002-20250908    gcc-13.4.0
arc                   randconfig-002-20250909    clang-16
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                        multi_v7_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250908    clang-22
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-002-20250908    clang-22
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-003-20250908    gcc-12.5.0
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-004-20250908    gcc-14.3.0
arm                   randconfig-004-20250909    clang-16
arm                       versatile_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250908    clang-20
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250908    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-003-20250908    gcc-9.5.0
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-004-20250908    gcc-8.5.0
arm64                 randconfig-004-20250909    clang-16
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250908    gcc-14.3.0
csky                  randconfig-001-20250909    gcc-8.5.0
csky                  randconfig-002-20250908    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250908    clang-17
hexagon               randconfig-001-20250909    gcc-8.5.0
hexagon               randconfig-002-20250908    clang-20
hexagon               randconfig-002-20250909    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250908    gcc-14
i386        buildonly-randconfig-001-20250909    clang-20
i386        buildonly-randconfig-002-20250908    gcc-14
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-003-20250908    gcc-12
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-004-20250908    gcc-14
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-005-20250908    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-006-20250908    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250909    clang-20
i386                  randconfig-002-20250909    clang-20
i386                  randconfig-003-20250909    clang-20
i386                  randconfig-004-20250909    clang-20
i386                  randconfig-005-20250909    clang-20
i386                  randconfig-006-20250909    clang-20
i386                  randconfig-007-20250909    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250908    gcc-15.1.0
loongarch             randconfig-001-20250909    gcc-8.5.0
loongarch             randconfig-002-20250908    clang-18
loongarch             randconfig-002-20250909    gcc-8.5.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250908    gcc-8.5.0
nios2                 randconfig-001-20250909    gcc-8.5.0
nios2                 randconfig-002-20250908    gcc-11.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250908    gcc-13.4.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250908    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20250908    gcc-15.1.0
powerpc               randconfig-001-20250909    gcc-8.5.0
powerpc               randconfig-002-20250908    clang-19
powerpc               randconfig-002-20250909    gcc-8.5.0
powerpc               randconfig-003-20250908    gcc-9.5.0
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc64             randconfig-001-20250908    gcc-8.5.0
powerpc64             randconfig-001-20250909    gcc-8.5.0
powerpc64             randconfig-002-20250908    gcc-10.5.0
powerpc64             randconfig-002-20250909    gcc-8.5.0
powerpc64             randconfig-003-20250908    clang-22
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250908    gcc-11.5.0
riscv                 randconfig-001-20250909    gcc-15.1.0
riscv                 randconfig-002-20250908    gcc-13.4.0
riscv                 randconfig-002-20250909    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250908    clang-22
s390                  randconfig-001-20250909    gcc-15.1.0
s390                  randconfig-002-20250908    gcc-12.5.0
s390                  randconfig-002-20250909    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250908    gcc-14.3.0
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250908    gcc-14.3.0
sh                    randconfig-002-20250909    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250908    gcc-8.5.0
sparc                 randconfig-001-20250909    gcc-15.1.0
sparc                 randconfig-002-20250908    gcc-12.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250908    gcc-13.4.0
sparc64               randconfig-001-20250909    gcc-15.1.0
sparc64               randconfig-002-20250908    gcc-8.5.0
sparc64               randconfig-002-20250909    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250908    gcc-14
um                    randconfig-001-20250909    gcc-15.1.0
um                    randconfig-002-20250908    clang-22
um                    randconfig-002-20250909    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250908    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250908    gcc-13
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250908    gcc-13
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250908    gcc-11
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250908    gcc-14
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250908    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250909    gcc-14
x86_64                randconfig-002-20250909    gcc-14
x86_64                randconfig-003-20250909    gcc-14
x86_64                randconfig-004-20250909    gcc-14
x86_64                randconfig-005-20250909    gcc-14
x86_64                randconfig-006-20250909    gcc-14
x86_64                randconfig-007-20250909    gcc-14
x86_64                randconfig-008-20250909    gcc-14
x86_64                randconfig-071-20250909    gcc-14
x86_64                randconfig-072-20250909    gcc-14
x86_64                randconfig-073-20250909    gcc-14
x86_64                randconfig-074-20250909    gcc-14
x86_64                randconfig-075-20250909    gcc-14
x86_64                randconfig-076-20250909    gcc-14
x86_64                randconfig-077-20250909    gcc-14
x86_64                randconfig-078-20250909    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250908    gcc-9.5.0
xtensa                randconfig-001-20250909    gcc-15.1.0
xtensa                randconfig-002-20250908    gcc-11.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

