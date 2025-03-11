Return-Path: <linux-pci+bounces-23461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA2A5CF20
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 20:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0F8189EAC6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE8F262818;
	Tue, 11 Mar 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLNe0aXY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630325FA28
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720680; cv=none; b=QXT+XudOdENIq+TZIH2rF5C2y/1JUgav4TVJ96VxOIj7hCKrFdn+6Yl2cqf3zrn2+wwZ2lH9mY8Cf3XMrq9uKCKA2M/k4CnwXxMc4sc9g/TOYyMIEzzs62Ceimdlx8QlKEZQzaZiUUdDI+Mf3n5110NfrBDqpwARif+AF7aGdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720680; c=relaxed/simple;
	bh=2+B+9JK8Mgy60N/wQmKYMoXvhOBjkq930sjb9GBjqS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=goy8fjZgdJIh3ADo64Dd2hi01kCZrrUmlJh3iAyUrhgd4NcRPNQvqIA3KfSP5eBcE5XhZiF5Po9eFf/Q/fhdDa7XciJbFYzXC3eBO+FkdNMKwrWn857dzpjqK4Th8+9E7+OFjg8NFBdVCcoCKSqA+1AWGG8YDMXl1fjWdDsftig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLNe0aXY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741720679; x=1773256679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2+B+9JK8Mgy60N/wQmKYMoXvhOBjkq930sjb9GBjqS8=;
  b=LLNe0aXY4LJ5mfBQxswsK31enhg/NBbqhPf6gWZ+4DOwl4ZdvftucaIY
   yKm2KMV8C6ZcgRlQNwdByJJg9RINWZgsC4aoVl9D/3+ZhvxJpDAjDBWde
   eX+m5NtxS6kIixdF1sb5DcuhFrJhwwOs3LtPzzG5D+ONYq0gMnn9dWoqM
   menMzVtG7LhCEPN/D+LoBBp+pja3gBo19cyeqGX60HIs6oHvYoj64ulIP
   X/MmzwOcaNesw80xREmCNXEpJoe62hyz1r/zKqnZ2nbJgpKVFE4CILfdT
   lNLZQ9H1sYUey/B/KVONfAXC2ptBMLX+YzIx1B6nn6FD5xHw53CinLrmJ
   Q==;
X-CSE-ConnectionGUID: 94NIQEGqT+OBuEvJMqObHQ==
X-CSE-MsgGUID: pQMbc+uVT4mDYoFe1kMw5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60324315"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="60324315"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:17:52 -0700
X-CSE-ConnectionGUID: figeHHutQVqjkQPu0/jTZg==
X-CSE-MsgGUID: f0ZZDbrlTQi1lo5tXk2k4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120370800"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 11 Mar 2025 12:17:50 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts56o-0007m0-32;
	Tue, 11 Mar 2025 19:17:46 +0000
Date: Wed, 12 Mar 2025 03:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint-test] BUILD SUCCESS
 9670b305fea750fe11d809d436bc5a88e1b476c6
Message-ID: <202503120346.mgq4Vziv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint-test
branch HEAD: 9670b305fea750fe11d809d436bc5a88e1b476c6  misc: pci_endpoint_test: Add support for PCITEST_IRQ_TYPE_AUTO

elapsed time: 1451m

configs tested: 150
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-001-20250312    clang-21
arc                   randconfig-002-20250311    gcc-13.2.0
arc                   randconfig-002-20250312    clang-21
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-001-20250312    clang-21
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-003-20250312    clang-21
arm                   randconfig-004-20250311    gcc-14.2.0
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250311    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250311    gcc-14.2.0
arm64                 randconfig-002-20250312    clang-21
arm64                 randconfig-003-20250311    gcc-14.2.0
arm64                 randconfig-003-20250312    clang-21
arm64                 randconfig-004-20250311    gcc-14.2.0
arm64                 randconfig-004-20250312    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250311    gcc-14.2.0
csky                  randconfig-002-20250311    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250311    clang-21
hexagon               randconfig-002-20250311    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250311    gcc-12
i386        buildonly-randconfig-001-20250312    gcc-12
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-002-20250312    gcc-12
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250311    gcc-11
i386        buildonly-randconfig-006-20250312    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-011-20250312    gcc-11
i386                  randconfig-012-20250312    gcc-11
i386                  randconfig-013-20250312    gcc-11
i386                  randconfig-014-20250312    gcc-11
i386                  randconfig-015-20250312    gcc-11
i386                  randconfig-016-20250312    gcc-11
i386                  randconfig-017-20250312    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250311    gcc-14.2.0
loongarch             randconfig-002-20250311    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250311    gcc-14.2.0
nios2                 randconfig-002-20250311    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250311    gcc-14.2.0
parisc                randconfig-002-20250311    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250311    clang-21
powerpc               randconfig-002-20250311    clang-16
powerpc               randconfig-003-20250311    gcc-14.2.0
powerpc64             randconfig-001-20250311    gcc-14.2.0
powerpc64             randconfig-002-20250311    clang-18
powerpc64             randconfig-003-20250311    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-001-20250312    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250311    clang-15
s390                  randconfig-001-20250312    gcc-14.2.0
s390                  randconfig-002-20250311    gcc-14.2.0
s390                  randconfig-002-20250312    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250311    gcc-12
um                    randconfig-001-20250312    gcc-14.2.0
um                    randconfig-002-20250311    gcc-12
um                    randconfig-002-20250312    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-001-20250312    gcc-12
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250312    gcc-12
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-004-20250312    gcc-12
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-005-20250312    gcc-12
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250312    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

