Return-Path: <linux-pci+bounces-23518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19AFA5E213
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CDE1670E7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14123C8A1;
	Wed, 12 Mar 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAIZyxMc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC41D5CD4
	for <linux-pci@vger.kernel.org>; Wed, 12 Mar 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798449; cv=none; b=kQCX0VwpXIxUV/GBpem3cya605zFAFf4kiE3f60NaJP1WpQ09SCESVz9manntgXkc+fHWFDIxxEC7N6Pjn7pz4VroG9OAHdLYmVnH+yHXeVAc5qyl0CLaudLlagC9Tpu/77uxn0wZjSWROaoYwNER1qZvuMkU9TR+zeOu9xplh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798449; c=relaxed/simple;
	bh=douH+ApqysdxqD3MsmZU7tDRKiUmEly0kzUNlnfghNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wg5TmN/y/8++M/Z9IwfieAY6oAIZZ9aOhCJzpdtZb7xp1chiV/8D4Zm4F51bkW3ZezE2zJZG1M2JvvY5TZBpQoLjoa9SzMt+4frvs43DNuTE2MsGS93Wr885MXtsaGUHRLyjRSpE4zf7JQ/FwJaRtR2CBL3yYwU/PK0cbtLp55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAIZyxMc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741798448; x=1773334448;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=douH+ApqysdxqD3MsmZU7tDRKiUmEly0kzUNlnfghNc=;
  b=HAIZyxMcRu1mfB8XHDwQlgLYDlcrkVRbBmVdw2NF1t5ePn65Apo/wQPE
   kSzEU2rLjqVUuucllDCzEtv2awYO/zTO0ikStEDUNciGR4tG9BR5JCMXm
   Ne0Owt5AcE7cdhNgw9jLy+XvOmRN7qCmd56yi43TNL/U0vteFM9j5epLu
   VUZlJby487lBBVKof7kVdaNRvqqVtEQfkCKVlgQMvI9ICRW+fldzOx3Gz
   8D7Lm4ZHEEE4Zx0J0WBj0KIDKquPzDrjHHWkeExjnB8r5w5SIawGUmD8T
   d0/c1ITkIjjVrauJGcFboNgCR4ofUTLlb4kJ3EGj0GmyLgt6XMYwG0yrZ
   g==;
X-CSE-ConnectionGUID: W1baJDi5RNysO7rcmORndw==
X-CSE-MsgGUID: qFtzNfEJRvi6Vd9t1mCqPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42764767"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42764767"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:54:07 -0700
X-CSE-ConnectionGUID: frmAM9LLSu2f5HthXl+x8Q==
X-CSE-MsgGUID: sJszgMh6SKqiCGt8qQyi1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="151507847"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Mar 2025 09:54:05 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsPLH-0008kA-0R;
	Wed, 12 Mar 2025 16:54:03 +0000
Date: Thu, 13 Mar 2025 00:53:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/j721e] BUILD SUCCESS
 a84700a56d33ab430d96351674b63892b3ab8274
Message-ID: <202503130019.eGUgRVuo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/j721e
branch HEAD: a84700a56d33ab430d96351674b63892b3ab8274  PCI: j721e: Fix the value of linkdown_irq_regfield for J784S4

elapsed time: 1453m

configs tested: 212
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    clang-21
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250312    clang-21
arc                   randconfig-001-20250312    gcc-13.2.0
arc                   randconfig-002-20250312    clang-21
arc                   randconfig-002-20250312    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-21
arm                           h3600_defconfig    clang-21
arm                         mv78xx0_defconfig    clang-21
arm                   randconfig-001-20250312    clang-19
arm                   randconfig-001-20250312    clang-21
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250312    clang-19
arm                   randconfig-003-20250312    clang-21
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250312    clang-21
arm64                 randconfig-002-20250312    gcc-14.2.0
arm64                 randconfig-003-20250312    clang-21
arm64                 randconfig-003-20250312    gcc-14.2.0
arm64                 randconfig-004-20250312    clang-21
arm64                 randconfig-004-20250312    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250312    clang-21
hexagon               randconfig-001-20250312    gcc-14.2.0
hexagon               randconfig-002-20250312    clang-21
hexagon               randconfig-002-20250312    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250312    clang-19
i386        buildonly-randconfig-001-20250312    gcc-12
i386        buildonly-randconfig-002-20250312    clang-19
i386        buildonly-randconfig-002-20250312    gcc-12
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250312    clang-19
i386        buildonly-randconfig-006-20250312    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250312    clang-19
i386                  randconfig-002-20250312    clang-19
i386                  randconfig-003-20250312    clang-19
i386                  randconfig-004-20250312    clang-19
i386                  randconfig-005-20250312    clang-19
i386                  randconfig-006-20250312    clang-19
i386                  randconfig-007-20250312    clang-19
i386                  randconfig-011-20250312    gcc-11
i386                  randconfig-012-20250312    gcc-11
i386                  randconfig-013-20250312    gcc-11
i386                  randconfig-014-20250312    gcc-11
i386                  randconfig-015-20250312    gcc-11
i386                  randconfig-016-20250312    gcc-11
i386                  randconfig-017-20250312    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    clang-21
mips                           ip28_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-21
powerpc               randconfig-001-20250312    clang-21
powerpc               randconfig-001-20250312    gcc-14.2.0
powerpc               randconfig-002-20250312    clang-21
powerpc               randconfig-002-20250312    gcc-14.2.0
powerpc               randconfig-003-20250312    clang-21
powerpc               randconfig-003-20250312    gcc-14.2.0
powerpc64             randconfig-001-20250312    clang-17
powerpc64             randconfig-001-20250312    gcc-14.2.0
powerpc64             randconfig-002-20250312    clang-15
powerpc64             randconfig-002-20250312    gcc-14.2.0
powerpc64             randconfig-003-20250312    clang-21
powerpc64             randconfig-003-20250312    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250312    clang-21
riscv                 randconfig-001-20250312    gcc-14.2.0
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250312    clang-15
s390                  randconfig-001-20250312    gcc-14.2.0
s390                  randconfig-002-20250312    clang-16
s390                  randconfig-002-20250312    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    clang-21
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250312    gcc-12
um                    randconfig-001-20250312    gcc-14.2.0
um                    randconfig-002-20250312    clang-15
um                    randconfig-002-20250312    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250312    clang-19
x86_64      buildonly-randconfig-001-20250312    gcc-12
x86_64      buildonly-randconfig-002-20250312    clang-19
x86_64      buildonly-randconfig-002-20250312    gcc-12
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250312    clang-19
x86_64      buildonly-randconfig-004-20250312    gcc-12
x86_64      buildonly-randconfig-005-20250312    clang-19
x86_64      buildonly-randconfig-005-20250312    gcc-12
x86_64      buildonly-randconfig-006-20250312    clang-19
x86_64      buildonly-randconfig-006-20250312    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250312    gcc-12
x86_64                randconfig-002-20250312    gcc-12
x86_64                randconfig-003-20250312    gcc-12
x86_64                randconfig-004-20250312    gcc-12
x86_64                randconfig-005-20250312    gcc-12
x86_64                randconfig-006-20250312    gcc-12
x86_64                randconfig-007-20250312    gcc-12
x86_64                randconfig-008-20250312    gcc-12
x86_64                randconfig-071-20250312    clang-19
x86_64                randconfig-072-20250312    clang-19
x86_64                randconfig-073-20250312    clang-19
x86_64                randconfig-074-20250312    clang-19
x86_64                randconfig-075-20250312    clang-19
x86_64                randconfig-076-20250312    clang-19
x86_64                randconfig-077-20250312    clang-19
x86_64                randconfig-078-20250312    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

