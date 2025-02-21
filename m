Return-Path: <linux-pci+bounces-21980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D6A3F3EB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A802F17A25B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 12:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A114A62B;
	Fri, 21 Feb 2025 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LU1sQ3bB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A82B9AA
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139698; cv=none; b=mRRn4qozY5+4DONzlKhpjnYCo5LIZxNBEKyo3r2bB0ZIiMJY9zjYbKOcMdFMeskGTdERiCI9itFd3TshwtbsxtqSk9hnmv4HXtuHoNczV8vTpQAFvi+j93eigyc1G5Sv+V4du+bEirpWBAGrgno8vbj6WEEM7FBIQyNS9aqE+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139698; c=relaxed/simple;
	bh=InIcS/pWXeFbNoZZu2Fn3ZI18HiUZuiEi1BD7pYEiFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=S0rA0bahxakw2lo9b4OVX+Avf3Nb8Hs3NwqF4Jq8hy95hj/K9bnaTZ+R0lTxkOD/vcRpF2MAcunG8zfwz50CStV53BZzXXTen3K+aCr4jFC6pSFtcMeR0vvVTtB8Cb+pIwihjJ6qCfGXFXwBn5LhPERHugLPK8C0hlfm1eS5N8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LU1sQ3bB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740139697; x=1771675697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=InIcS/pWXeFbNoZZu2Fn3ZI18HiUZuiEi1BD7pYEiFo=;
  b=LU1sQ3bBFQrKWIQ2/lyZ1oSYtihLdhQrE1ZyyfBJWI/3JQHJrFp2/VXi
   btrKYv/sGPgn01GPvzOqWcUDupwF00lXO+fdegZeHbdw0fOALh+n9NvUJ
   e5wEkyQgAObID+SRt+lXdG3KBtZBbUlG/YRffrI0eRwmxKNr3UT6JqOqE
   8WeDublc221vsWF8YHxHI9Y8eXvohG7LZ8VcQYX1edEoW/NStcjZzo5J/
   NtHggI0sDPSgcm7XvkTWEOsOhFBsKi2VcxDFqpkcn+YUnt5nD1LPjGXDC
   6m3IGDtfsG68Rjo6NMCqtPZo4PZksIE2cRYBQVIO9Inyf3IonpGMwQTK1
   A==;
X-CSE-ConnectionGUID: O6J/EFWuSpiSY+v/qdGCmw==
X-CSE-MsgGUID: TcuGhuj2T3qV9zT7UDrdAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="43790360"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="43790360"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:08:17 -0800
X-CSE-ConnectionGUID: 8VbTjeIOSjOztStU4TVeVw==
X-CSE-MsgGUID: UT2OOpt0R7qKGqYBYOH/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="138571084"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Feb 2025 04:08:15 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlRpF-0005U7-2i;
	Fri, 21 Feb 2025 12:08:13 +0000
Date: Fri, 21 Feb 2025 20:07:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:selftests] BUILD SUCCESS
 70c31d9abb98137f86bc8d593863ae6127ea04ec
Message-ID: <202502212031.5fyMQkY9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git selftests
branch HEAD: 70c31d9abb98137f86bc8d593863ae6127ea04ec  tools/Makefile: Remove pci target

elapsed time: 1453m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250220    gcc-13.2.0
arc                   randconfig-002-20250220    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250220    gcc-14.2.0
arm                   randconfig-002-20250220    gcc-14.2.0
arm                   randconfig-003-20250220    gcc-14.2.0
arm                   randconfig-004-20250220    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250220    gcc-14.2.0
arm64                 randconfig-002-20250220    gcc-14.2.0
arm64                 randconfig-003-20250220    clang-21
arm64                 randconfig-004-20250220    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250220    gcc-14.2.0
csky                  randconfig-002-20250220    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250220    clang-21
hexagon               randconfig-002-20250220    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250220    gcc-12
i386        buildonly-randconfig-002-20250220    gcc-12
i386        buildonly-randconfig-003-20250220    gcc-12
i386        buildonly-randconfig-004-20250220    clang-19
i386        buildonly-randconfig-005-20250220    clang-19
i386        buildonly-randconfig-006-20250220    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250220    gcc-14.2.0
loongarch             randconfig-002-20250220    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250220    gcc-14.2.0
nios2                 randconfig-002-20250220    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250220    gcc-14.2.0
parisc                randconfig-002-20250220    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250220    gcc-14.2.0
powerpc               randconfig-002-20250220    clang-16
powerpc               randconfig-003-20250220    clang-21
powerpc64             randconfig-001-20250220    clang-16
powerpc64             randconfig-002-20250220    clang-18
powerpc64             randconfig-003-20250220    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250220    gcc-14.2.0
riscv                 randconfig-002-20250220    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250220    clang-19
s390                  randconfig-002-20250220    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250220    gcc-14.2.0
sh                    randconfig-002-20250220    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250220    gcc-14.2.0
sparc                 randconfig-002-20250220    gcc-14.2.0
sparc64               randconfig-001-20250220    gcc-14.2.0
sparc64               randconfig-002-20250220    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250220    gcc-12
um                    randconfig-002-20250220    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250220    gcc-12
x86_64      buildonly-randconfig-002-20250220    gcc-12
x86_64      buildonly-randconfig-003-20250220    gcc-12
x86_64      buildonly-randconfig-004-20250220    gcc-12
x86_64      buildonly-randconfig-005-20250220    gcc-12
x86_64      buildonly-randconfig-006-20250220    gcc-12
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250220    gcc-14.2.0
xtensa                randconfig-002-20250220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

