Return-Path: <linux-pci+bounces-30635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F7AE8B1A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA893AB1DA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D42F0055;
	Wed, 25 Jun 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CB1wk4k9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC72C3274
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870807; cv=none; b=MhXycWM52A1RgnrkrSA5CxG47iMHR473yjBD5eSCKKlrlIXnDQUgO35G+S91fLJfIuIIi+LKMXgwj4y94VaECTjeF0dNVi4zB7rOjp1gVGxElQ0wGUPrfrQGtVATJ2Ca9zZjH2um/RICJLKlmaMGKpikcgTSxNnxXvaya0j+iYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870807; c=relaxed/simple;
	bh=kSUcLTPfS0rI+lSzwwj71dOQ289s1EqrcttziBFwOEw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZtMezdxLo+vOZNQQHtffd6v8nIYBzDV5R5YEoe7Er+YfMLoKmoWGMWJz6ZZ8VuFVsHfqf0hcFmook2mx56GXmtLwKj5CWTWWC3n6BSPqRfKTTIc/zgKQJKIMfOrQqRN3u1N/9qr69209vrBPQO3NSCQGT8KVEoyT/mihF8ZhAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CB1wk4k9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750870806; x=1782406806;
  h=date:from:to:cc:subject:message-id;
  bh=kSUcLTPfS0rI+lSzwwj71dOQ289s1EqrcttziBFwOEw=;
  b=CB1wk4k9flXogbmtKjBY2Y+WRLKJnAs6/jFALTgVgaUpSVfiYe4mUpz3
   ubXCOtieEkvTSmSDkbsG3A+4eLsFF/Tp21wu5xRq+TKCrbJFvnQkQRYIQ
   U1CJRE+rIEWhtjTGyVnelLnx9iRBVhFCv2U6fsD4V8HgnvFtwFOPIH5dI
   casg/I9ImOCKo8vDMnFms+9x5jrRPrn8I2g+rJiSJ8oqQ+fcfT0YIff27
   VC1GljKP8ErdZYSDRSazHmQOOAn0IOsTAmguV/ilB1UC0dO7J6c+DwNIU
   VyWSabodTAPseRvq+Bplc73RbK5UWVC6zIVIIHuPpdRmrQ140Lw7lgJ18
   A==;
X-CSE-ConnectionGUID: /lxhtJRPRxWF2kKg8gxOOQ==
X-CSE-MsgGUID: er/s+ttoRSG9NYPGRQMThw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64209382"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64209382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:00:05 -0700
X-CSE-ConnectionGUID: 7aX9o+eASdSP3tmZhpjP1g==
X-CSE-MsgGUID: XE63DyVKRsyArvBVrs2TMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152044643"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2025 10:00:05 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUTTd-000TLg-33;
	Wed, 25 Jun 2025 17:00:01 +0000
Date: Thu, 26 Jun 2025 00:59:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 078ffdc22b98b49d19f573f7badbadb6b3b3a542
Message-ID: <202506260055.yiVXDPYK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 078ffdc22b98b49d19f573f7badbadb6b3b3a542  Merge branch 'pci/misc'

elapsed time: 1097m

configs tested: 93
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250625    gcc-11.5.0
arc                   randconfig-002-20250625    gcc-11.5.0
arc                   randconfig-002-20250625    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250625    clang-21
arm                   randconfig-001-20250625    gcc-11.5.0
arm                   randconfig-002-20250625    gcc-11.5.0
arm                   randconfig-003-20250625    gcc-11.5.0
arm                   randconfig-003-20250625    gcc-13.3.0
arm                   randconfig-004-20250625    gcc-11.5.0
arm                   randconfig-004-20250625    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250625    gcc-11.5.0
arm64                 randconfig-002-20250625    clang-20
arm64                 randconfig-002-20250625    gcc-11.5.0
arm64                 randconfig-003-20250625    gcc-11.5.0
arm64                 randconfig-003-20250625    gcc-12.3.0
arm64                 randconfig-004-20250625    clang-20
arm64                 randconfig-004-20250625    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250625    clang-20
i386        buildonly-randconfig-001-20250625    gcc-12
i386        buildonly-randconfig-002-20250625    gcc-12
i386        buildonly-randconfig-003-20250625    gcc-12
i386        buildonly-randconfig-004-20250625    gcc-12
i386        buildonly-randconfig-005-20250625    clang-20
i386        buildonly-randconfig-005-20250625    gcc-12
i386        buildonly-randconfig-006-20250625    clang-20
i386        buildonly-randconfig-006-20250625    gcc-12
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
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
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
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250625    gcc-12
x86_64      buildonly-randconfig-002-20250625    clang-20
x86_64      buildonly-randconfig-003-20250625    clang-20
x86_64      buildonly-randconfig-004-20250625    clang-20
x86_64      buildonly-randconfig-005-20250625    clang-20
x86_64      buildonly-randconfig-006-20250625    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

