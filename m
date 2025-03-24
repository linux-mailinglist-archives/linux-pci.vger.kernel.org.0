Return-Path: <linux-pci+bounces-24484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB6A6D464
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BD77A2EFD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC315199A;
	Mon, 24 Mar 2025 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QU4cOoT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4B2E338E
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742798628; cv=none; b=u4ieOsh1pnXvMhOsbWaafeV8U6m4LIKBJbGZOEzMqKP/50gvH0iZK5Lu74nJgq6Rnj9ESvdbhQ7VLbzfyvMxHwBFCNdR9KfY2R4OGmi6JtljCUkhsCHkvLB51wV8qGr1W+XPXOvHuG3zdKLquKZIxQuWrg4yMCoBezVIq+F7bkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742798628; c=relaxed/simple;
	bh=YNESSpfSdaz4joEVWb5PTiXPf+fKYdEXVqmxZbJcQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=c/8TCWYsPNCBXo4CACJoo+Qj00xzH52v9J7gOU/BHqWzgX01BZ73PkvgBVR4s3i+VSiV98fbVxLoQ+onelap5Blv6IstIdG9rRms+0TwAok73lgn3guC9julfZm7yESyhDgr3ppt8qJIWbArOn4y9qVTQmaaTdnIncP65ooQUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QU4cOoT3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742798627; x=1774334627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YNESSpfSdaz4joEVWb5PTiXPf+fKYdEXVqmxZbJcQaE=;
  b=QU4cOoT3qKl5/v1zElI5wRa3gtKf1Ls+JMbgI72449HlTc8hW2K8NBPC
   VwtbDic/zMHJFIiyJewznIiPt0FLpRd5LL4H/sJJw/mJyXBSeMB1fA7xj
   xpaRUL0SQy6Rm0kqXrsRKk3cfQDMXqM7LPPsjV0B7iD8r9lviiq1nqY7D
   o/98iDFtRId/hH214S1nHLSpsl9HM7t+mAva6GnJmEhqaffQt57Pcra1n
   6ottyhb2q/OvMzEmO/5w2bier3+slkSWSa4dBk7Bc9XA5Z3oBRd27+mOF
   ZOlL14X2ZKzqmcsz9kQejWVUGPFkWYawrJ4cFIjNouJIemPtByidZt9+s
   g==;
X-CSE-ConnectionGUID: X6+9TmayQt+1bEvC3RGFgg==
X-CSE-MsgGUID: 5MwfcRwzSCO4k6hmtuxAjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="69339371"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="69339371"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:43:47 -0700
X-CSE-ConnectionGUID: 1ag3Skf2R+aHMtqjARaivA==
X-CSE-MsgGUID: cdI1YOx2RhW4N8zXSykTSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="129057779"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 23 Mar 2025 23:43:46 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twbXD-0003LA-0X;
	Mon, 24 Mar 2025 06:43:43 +0000
Date: Mon, 24 Mar 2025 14:42:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/amd-mdb] BUILD SUCCESS
 5f3de23d858edf5df89c397678ba492b96646df4
Message-ID: <202503241450.RlyG1USA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/amd-mdb
branch HEAD: 5f3de23d858edf5df89c397678ba492b96646df4  PCI: amd-mdb: Add AMD MDB Root Port driver

elapsed time: 1443m

configs tested: 185
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250323    gcc-11.5.0
arc                   randconfig-002-20250323    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-21
arm                   randconfig-001-20250323    gcc-7.5.0
arm                   randconfig-002-20250323    gcc-9.3.0
arm                   randconfig-003-20250323    clang-15
arm                   randconfig-004-20250323    gcc-5.5.0
arm                        realview_defconfig    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250323    clang-21
arm64                 randconfig-002-20250323    gcc-5.5.0
arm64                 randconfig-003-20250323    gcc-9.5.0
arm64                 randconfig-004-20250323    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250323    gcc-13.3.0
csky                  randconfig-002-20250323    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250323    clang-21
hexagon               randconfig-002-20250323    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250323    clang-20
i386        buildonly-randconfig-002-20250323    gcc-12
i386        buildonly-randconfig-003-20250323    clang-20
i386        buildonly-randconfig-004-20250323    clang-20
i386        buildonly-randconfig-005-20250323    gcc-12
i386        buildonly-randconfig-006-20250323    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250324    gcc-12
i386                  randconfig-002-20250324    gcc-12
i386                  randconfig-003-20250324    gcc-12
i386                  randconfig-004-20250324    gcc-12
i386                  randconfig-005-20250324    gcc-12
i386                  randconfig-006-20250324    gcc-12
i386                  randconfig-007-20250324    gcc-12
i386                  randconfig-011-20250324    clang-20
i386                  randconfig-012-20250324    clang-20
i386                  randconfig-013-20250324    clang-20
i386                  randconfig-014-20250324    clang-20
i386                  randconfig-015-20250324    clang-20
i386                  randconfig-016-20250324    clang-20
i386                  randconfig-017-20250324    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250323    gcc-14.2.0
loongarch             randconfig-002-20250323    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250323    gcc-13.3.0
nios2                 randconfig-002-20250323    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250323    gcc-10.5.0
parisc                randconfig-002-20250323    gcc-6.5.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-21
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250323    gcc-9.3.0
powerpc               randconfig-002-20250323    gcc-7.5.0
powerpc               randconfig-003-20250323    gcc-9.3.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250323    clang-16
powerpc64             randconfig-002-20250323    gcc-9.3.0
powerpc64             randconfig-003-20250323    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250323    gcc-9.3.0
riscv                 randconfig-002-20250323    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250323    gcc-8.5.0
s390                  randconfig-002-20250323    clang-15
s390                       zfcpdump_defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250323    gcc-5.5.0
sh                    randconfig-002-20250323    gcc-5.5.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250323    gcc-14.2.0
sparc                 randconfig-002-20250323    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250323    gcc-14.2.0
sparc64               randconfig-002-20250323    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250323    gcc-12
um                    randconfig-002-20250323    clang-17
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250323    clang-20
x86_64      buildonly-randconfig-002-20250323    clang-20
x86_64      buildonly-randconfig-003-20250323    gcc-12
x86_64      buildonly-randconfig-004-20250323    clang-20
x86_64      buildonly-randconfig-005-20250323    clang-20
x86_64      buildonly-randconfig-006-20250323    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250324    gcc-12
x86_64                randconfig-002-20250324    gcc-12
x86_64                randconfig-003-20250324    gcc-12
x86_64                randconfig-004-20250324    gcc-12
x86_64                randconfig-005-20250324    gcc-12
x86_64                randconfig-006-20250324    gcc-12
x86_64                randconfig-007-20250324    gcc-12
x86_64                randconfig-008-20250324    gcc-12
x86_64                randconfig-071-20250324    clang-20
x86_64                randconfig-072-20250324    clang-20
x86_64                randconfig-073-20250324    clang-20
x86_64                randconfig-074-20250324    clang-20
x86_64                randconfig-075-20250324    clang-20
x86_64                randconfig-076-20250324    clang-20
x86_64                randconfig-077-20250324    clang-20
x86_64                randconfig-078-20250324    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250323    gcc-14.2.0
xtensa                randconfig-002-20250323    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

