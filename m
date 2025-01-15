Return-Path: <linux-pci+bounces-19809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA80A116A4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 02:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E41622CD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFDB79FD;
	Wed, 15 Jan 2025 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJyvpo3a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25B23243D
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904748; cv=none; b=TOged1Z+3unW/BwW+epuuZo2l1wwunBVO17VJALKiVg3g88XGOgHggUrUqnBlkLM6n8xyY8vnqdtpfJykbdUvo21G5KPIONK94SlfhogT9m/844nyEKHM0uas0zRcVHV0IVeXe8cALqlQDERqtfki0kyAnQL1qDHaYhM/2t9YZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904748; c=relaxed/simple;
	bh=lwXgyz3hHdrPd79eADN4PI2mi8JUVofmhGg0JWku/ok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D44KrH1ARdKOtHjo1lZPuM0xzEsQvx6D7Aj5PoVYL5kS8e9azAJghv/1QkNIjV9NyK/UuWA/UBhSxCo43WBKI5aTUwiFA8RmPcH15DuTPTlXPx8gJBtF/b5STkmANR59qUOQjkoxUvyuf2i1v0OM0DDH1Ngnc86g52NeRLCyeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJyvpo3a; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736904747; x=1768440747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lwXgyz3hHdrPd79eADN4PI2mi8JUVofmhGg0JWku/ok=;
  b=JJyvpo3a5N1wfZTJL9QYavSVODNANRumIzIwx2xa2Ri2AmXQNsHRiPJA
   EBso5xatMWonL8ajje6WMB9PHHVWge1qeyzpdD9jsDFbzd8uO2NGXWc/I
   ishh1b0iPwjK1xDelgWM2SUpdvzCxAch6txOkcIMAU6ZSsXYP5dcBPbOz
   a5e5Tmcg326gJ9CmIwpCGmC8kakKFianwT+vansYqq8Pdk22k0GVrcSG5
   nU47zDuGPHcZw/AgbK4wvfvhAd/r+DF/WSImiDPAR7xFiXHA9Q+a3rF90
   GU/GeCOV/Er35Cx3ycyBax0SFib8PZ/trhc3YYEvhrs+wRpbODFUjVzhm
   g==;
X-CSE-ConnectionGUID: CbTGLUwdSwSkfZauLtrscA==
X-CSE-MsgGUID: VWppn5x0TdCnZnfQIpGl/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36435519"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="36435519"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 17:32:26 -0800
X-CSE-ConnectionGUID: 1LLt3mzhQv+hyZvpd0YeYA==
X-CSE-MsgGUID: xrlvM8UyTFeytVgkm/J+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105847576"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Jan 2025 17:32:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXsGc-000PGL-04;
	Wed, 15 Jan 2025 01:32:22 +0000
Date: Wed, 15 Jan 2025 09:31:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:config-acs] BUILD SUCCESS
 741abdf1e7f6888a7665bbcbd62bbdc3ceb3a869
Message-ID: <202501150951.orzseftk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git config-acs
branch HEAD: 741abdf1e7f6888a7665bbcbd62bbdc3ceb3a869  Documentation: Fix the config_acs= example

elapsed time: 1447m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250114    gcc-13.2.0
arc                   randconfig-002-20250114    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-19
arm                   randconfig-001-20250114    clang-15
arm                   randconfig-002-20250114    clang-20
arm                   randconfig-003-20250114    gcc-14.2.0
arm                   randconfig-004-20250114    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250114    clang-17
arm64                 randconfig-002-20250114    clang-19
arm64                 randconfig-003-20250114    gcc-14.2.0
arm64                 randconfig-004-20250114    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250114    gcc-14.2.0
csky                  randconfig-002-20250114    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250114    clang-20
hexagon               randconfig-002-20250114    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250114    gcc-12
i386        buildonly-randconfig-002-20250114    clang-19
i386        buildonly-randconfig-003-20250114    clang-19
i386        buildonly-randconfig-004-20250114    gcc-12
i386        buildonly-randconfig-005-20250114    clang-19
i386        buildonly-randconfig-006-20250114    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250114    gcc-14.2.0
loongarch             randconfig-002-20250114    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250114    gcc-14.2.0
nios2                 randconfig-002-20250114    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250114    gcc-14.2.0
parisc                randconfig-002-20250114    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-17
powerpc               randconfig-001-20250114    gcc-14.2.0
powerpc               randconfig-002-20250114    clang-20
powerpc               randconfig-003-20250114    gcc-14.2.0
powerpc64             randconfig-001-20250114    clang-20
powerpc64             randconfig-002-20250114    clang-15
powerpc64             randconfig-003-20250114    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250114    gcc-14.2.0
riscv                 randconfig-002-20250114    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250114    clang-18
s390                  randconfig-002-20250114    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250114    gcc-14.2.0
sh                    randconfig-002-20250114    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250114    gcc-14.2.0
sparc                 randconfig-002-20250114    gcc-14.2.0
sparc64               randconfig-001-20250114    gcc-14.2.0
sparc64               randconfig-002-20250114    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250114    clang-17
um                    randconfig-002-20250114    gcc-11
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250114    clang-19
x86_64      buildonly-randconfig-002-20250114    clang-19
x86_64      buildonly-randconfig-003-20250114    clang-19
x86_64      buildonly-randconfig-004-20250114    clang-19
x86_64      buildonly-randconfig-005-20250114    clang-19
x86_64      buildonly-randconfig-006-20250114    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250114    gcc-14.2.0
xtensa                randconfig-002-20250114    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

