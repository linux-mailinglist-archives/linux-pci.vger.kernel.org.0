Return-Path: <linux-pci+bounces-30882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8AAEABBC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 02:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0374F17A9F3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811C2F30;
	Fri, 27 Jun 2025 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJw7U4Cc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF6CA5A
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983919; cv=none; b=QplhoOkBucLUF2tIc41QUHKGPosUelz1fD0PX6JchnZPy8ejNIZnHs5ZSumC8dIfKwNXgUD7dstAb5KN0Abegspec9843f+Qi7LEusclOvYpAjtOBZcM10x6EGiqiqMnWvOYEUD2Exsa1DEcbwh2YYA9i0eIAlbGqvuc+vPGnDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983919; c=relaxed/simple;
	bh=aTp76CsU0Hg1BYEjgnJHqEncIIgouxPZaQ3pW6gc6Oc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kCVhammBHG+8k2GIRmjrXYhYX24CZtb1/Jd8a3IMYX1jIgJqf3hsGUdQTsEdLEGgphOK+cH5PDoY4DUYlKXl5QUIPrP2Uzusf+DIUTDsHq8J8ux7BlhaZ50214Kul7BHZGKvDq/qrWqn0PMV/31R0uH9o+NHjHpdWHVgryJBzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJw7U4Cc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750983917; x=1782519917;
  h=date:from:to:cc:subject:message-id;
  bh=aTp76CsU0Hg1BYEjgnJHqEncIIgouxPZaQ3pW6gc6Oc=;
  b=lJw7U4Ccet3CViTpFQngSNkVCJ1D1o/GTftG4Y1gFLkwK+oCEajD/a4y
   IE+tahjlM34W0Z355UOVxGMMS6w2qqdL5Dscmwo6l3PeTPM8XSyo0uo08
   ENGEWqAnzrbgCCZ5BwNZfphek3rdX+SLvFCQPdOkE9PpV9cH3I5oCf+nS
   v63PXgLfZjdmnuwcc+MPr50SZ3+Q5aclk4m5YzgKaqCMliQJ9c/IFKqt7
   kQ40IL2fn+VCBb0c5bJjwQCRSD7pVJ9I2XQHznAsK7zdpiLrW6FTHTpmW
   ifsoiLf4vCC5kzuTo8b0yNORg3iJ39J/9yJtSzwJH/ypL26nsY7ULhc2+
   Q==;
X-CSE-ConnectionGUID: X2raWuy/SLeJlDHDoYFHEA==
X-CSE-MsgGUID: 6T53NhjwQ7+tnZTPdQIpSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="70725958"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="70725958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 17:25:16 -0700
X-CSE-ConnectionGUID: 9bQMLhS4RceSPYJoTRiWgA==
X-CSE-MsgGUID: Be1OakYqR2igQi4cEwerdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="152953562"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jun 2025 17:25:14 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUwu0-000Vf4-0j;
	Fri, 27 Jun 2025 00:25:12 +0000
Date: Fri, 27 Jun 2025 08:25:10 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 032f05be51ab4a1d67d08a8083ec16dd934d255e
Message-ID: <202506270800.5zjIkMQk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 032f05be51ab4a1d67d08a8083ec16dd934d255e  PCI: dwc: Simplify the return value of PTM debugfs functions returning bool

elapsed time: 1454m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250626    gcc-12.4.0
arc                   randconfig-001-20250627    gcc-10.5.0
arc                   randconfig-002-20250626    gcc-13.3.0
arc                   randconfig-002-20250627    gcc-10.5.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                   randconfig-001-20250626    clang-21
arm                   randconfig-001-20250627    gcc-10.5.0
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-002-20250627    gcc-10.5.0
arm                   randconfig-003-20250626    gcc-10.5.0
arm                   randconfig-003-20250627    gcc-10.5.0
arm                   randconfig-004-20250626    clang-21
arm                   randconfig-004-20250627    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250626    clang-21
arm64                 randconfig-001-20250627    gcc-10.5.0
arm64                 randconfig-002-20250626    clang-17
arm64                 randconfig-002-20250627    gcc-10.5.0
arm64                 randconfig-003-20250626    gcc-8.5.0
arm64                 randconfig-003-20250627    gcc-10.5.0
arm64                 randconfig-004-20250626    clang-21
arm64                 randconfig-004-20250627    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250626    clang-20
i386        buildonly-randconfig-001-20250627    gcc-12
i386        buildonly-randconfig-002-20250626    clang-20
i386        buildonly-randconfig-002-20250627    gcc-12
i386        buildonly-randconfig-003-20250626    clang-20
i386        buildonly-randconfig-003-20250627    gcc-12
i386        buildonly-randconfig-004-20250626    clang-20
i386        buildonly-randconfig-004-20250627    gcc-12
i386        buildonly-randconfig-005-20250626    clang-20
i386        buildonly-randconfig-005-20250627    gcc-12
i386        buildonly-randconfig-006-20250626    clang-20
i386        buildonly-randconfig-006-20250627    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-001-20250627    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-002-20250627    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-003-20250627    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-004-20250627    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-005-20250627    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64      buildonly-randconfig-006-20250627    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

