Return-Path: <linux-pci+bounces-17183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936EE9D54D8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 22:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46992B2166D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314C1DBB31;
	Thu, 21 Nov 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dlv7u64g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1921CB9EC
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225196; cv=none; b=pB8j7zACs4ZEw0MT3DFkv/v59bCNtbGB7KdB401di7m+mcZdBV7bfpQcb+4aFFq+RIlTmdCyOZBMQ3F816QUsFY66MFPaGooK3Um749PokYG19kHB6ZmEJXB2t6E9/HXOzgSJrJUdd309DgnEXhgj0nRgocovh/8ceyARf2ySb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225196; c=relaxed/simple;
	bh=PJNBV9VRpuH9jyWqkvT3JNhlQXBL4bf8jwqz/fXGt7w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=azxYDPgn4RLaKwGR7XfNEUICNws4l+u7I3riLzW/a2c46C8CxP5iTE0gojPZQDIv4xoD20Ck2lkKy7gIF5gmGZOatFcrIZe5TaVpdPpJwef9q2w0D8+EH6XIjdfnYuGgaZWNVg/ty7oalorlStDzXCfeCHR3cOfhzVPyl6o6ItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dlv7u64g; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732225195; x=1763761195;
  h=date:from:to:cc:subject:message-id;
  bh=PJNBV9VRpuH9jyWqkvT3JNhlQXBL4bf8jwqz/fXGt7w=;
  b=Dlv7u64gy2GHDkkFalGzGfvobHSZqRVkCm/C0iStGHuEVFbTt9hhPLdt
   aGBzKvoMn8Ke8wh7y0bP2NUK170Wi0N7COco4qTOkO1W11EqC5d3mo7ZF
   LlOIHpp4ByStqrWXCTXllNs7ssEcqDRM7KpUmYfikhckSkAHZoj2EPI0y
   CgItpHoUEscMZoFp5k+ZOqZGzgNvZ9VcAV2AQUqw2yGMfMZ+ATAm66DZt
   4bfT/cPwJkuwomAqFYM+HH2LJOLhKhLSArdn3/f8lVFQqQ3dnGuRxP8A8
   qaK7WkQeKCDd8A39vzz0mUWVqwCFgU7lFrEJq3uqnHiALJXrQAPQGEw1Z
   w==;
X-CSE-ConnectionGUID: 0aPH2er8TaKxff3ppoGrkA==
X-CSE-MsgGUID: 2dCQXzBkQCaJf+wb+XDKpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="36028977"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="36028977"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:39:55 -0800
X-CSE-ConnectionGUID: W3iq7D3fS9OH+CUcIaSorQ==
X-CSE-MsgGUID: 6xE3mvBgRgqaQ6X3DfifzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90308733"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Nov 2024 13:39:54 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEtz-0003Nf-29;
	Thu, 21 Nov 2024 21:39:51 +0000
Date: Fri, 22 Nov 2024 05:39:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 d9db393f2b9ed674f965dd823c1692b41bad7bfb
Message-ID: <202411220515.LzTEZBve-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: d9db393f2b9ed674f965dd823c1692b41bad7bfb  tools: PCI: Fix incorrect printf format specifiers

elapsed time: 1465m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241121    gcc-13.2.0
arc                   randconfig-002-20241121    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                       imx_v6_v7_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                        keystone_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-20
arm                   randconfig-001-20241121    clang-20
arm                   randconfig-002-20241121    gcc-14.2.0
arm                   randconfig-003-20241121    clang-20
arm                   randconfig-004-20241121    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241121    clang-20
arm64                 randconfig-002-20241121    clang-20
arm64                 randconfig-003-20241121    gcc-14.2.0
arm64                 randconfig-004-20241121    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241121    gcc-14.2.0
csky                  randconfig-002-20241121    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241121    clang-20
hexagon               randconfig-002-20241121    clang-15
i386        buildonly-randconfig-001-20241122    clang-19
i386        buildonly-randconfig-002-20241122    clang-19
i386        buildonly-randconfig-003-20241122    clang-19
i386        buildonly-randconfig-004-20241122    clang-19
i386        buildonly-randconfig-005-20241122    gcc-12
i386        buildonly-randconfig-006-20241122    gcc-12
i386                  randconfig-001-20241122    gcc-12
i386                  randconfig-002-20241122    clang-19
i386                  randconfig-003-20241122    gcc-12
i386                  randconfig-004-20241122    clang-19
i386                  randconfig-005-20241122    gcc-12
i386                  randconfig-006-20241122    gcc-12
i386                  randconfig-011-20241122    gcc-12
i386                  randconfig-012-20241122    gcc-12
i386                  randconfig-013-20241122    gcc-12
i386                  randconfig-014-20241122    gcc-12
i386                  randconfig-015-20241122    gcc-12
i386                  randconfig-016-20241122    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241121    gcc-14.2.0
loongarch             randconfig-002-20241121    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241121    gcc-14.2.0
nios2                 randconfig-002-20241121    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241121    gcc-14.2.0
parisc                randconfig-002-20241121    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-002-20241121    gcc-14.2.0
powerpc               randconfig-003-20241121    clang-20
powerpc64             randconfig-001-20241121    gcc-14.2.0
powerpc64             randconfig-002-20241121    clang-20
powerpc64             randconfig-003-20241121    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241121    gcc-14.2.0
riscv                 randconfig-002-20241121    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241121    gcc-14.2.0
s390                  randconfig-002-20241121    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241121    gcc-14.2.0
sh                    randconfig-002-20241121    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241121    gcc-14.2.0
sparc64               randconfig-002-20241121    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                    randconfig-001-20241121    gcc-12
um                    randconfig-002-20241121    gcc-12
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241121    gcc-14.2.0
xtensa                randconfig-002-20241121    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

