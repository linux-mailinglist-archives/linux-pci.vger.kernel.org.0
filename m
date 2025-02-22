Return-Path: <linux-pci+bounces-22071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34229A405E3
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 07:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7AE19C5945
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 06:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BB1FAC37;
	Sat, 22 Feb 2025 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdFpgfuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8E14F121
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740205555; cv=none; b=avkSjhVGcQrku6CULGF7a2Ym2JhS9I76YEqxnp2baS1yY99S7Z0D3wC046qeZMaXzFilt8kAKSPJK1eA84tFc0rMpCZroYXDgYPg6Hg/PF2JkGXwvT9twtAmmV+McHhSU3ZOHXT9EtFKox7hyj2CClPBAIuZL0Dkpb96YtRBl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740205555; c=relaxed/simple;
	bh=YG86hZtOVgi76xd1+cseQmOTly+MQG8TR8WWvQTJLl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bYuBNRsq6lR3bYCJxlNQUyvRHt1OAfzwCdYGbWwxTg7ZKdZETmJrq4uSS1FeLCKgklv8hJJbcJq7GKLaTfP2pqyEGSrgbk/CKBZzBcqhPQIw6pz3QTR6+4T6f8gGec11JvuoDI91BIP1ORR41vX68VulWMSbEeQrEeZ+cytyoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdFpgfuE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740205554; x=1771741554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YG86hZtOVgi76xd1+cseQmOTly+MQG8TR8WWvQTJLl0=;
  b=PdFpgfuETqurOoivzNc+Ua8eYIHq8k+EIKp3SeszJ80IKP21V+uZnp9q
   I9nzQzt7Sx1rva/3YE4cGoXTJEO0B/Ytj+lvFZs23es5z5B76Jvs2zfCD
   bhfUWDp4Vzx4QNCUd0zTeb4sdzauObO1pXSzhwshyKJcEmxSjTPLUJwKW
   JCL4wLxEKFem7tWLZgVTkUQqO8iMD3/T/tyz4tcVYhMhcxbWztDdY27S2
   6/MRej/BCFm4qdPzNOql1lyrTcYlxvDNA8kYdAplyer2sPI8upp8A9yha
   54uL0R7C71uEUJyVXktxjrSj9fs+NeWo6/2PdNV+K4WotcINWbO8p7WB4
   w==;
X-CSE-ConnectionGUID: /ZPhpb6kRv2p+kLpdI1jbA==
X-CSE-MsgGUID: uD85G5EjRnWE4IcOEQKaFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="41151683"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="41151683"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 22:25:53 -0800
X-CSE-ConnectionGUID: Rvt3MBINRAqGLAd24vkCJQ==
X-CSE-MsgGUID: 89+Uyz95S025sLfJmHkyDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="120193608"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Feb 2025 22:25:52 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlixS-0006LT-0S;
	Sat, 22 Feb 2025 06:25:50 +0000
Date: Sat, 22 Feb 2025 14:25:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 b6d7bb0d3bd74b491e2e6fd59c4d5110d06fd63b
Message-ID: <202502221432.qqfdI5Fi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: b6d7bb0d3bd74b491e2e6fd59c4d5110d06fd63b  PCI: mediatek-gen3: Remove leftover mac_reset assert for Airoha EN7581 SoC

elapsed time: 1461m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250221    gcc-13.2.0
arc                  randconfig-002-20250221    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250221    gcc-14.2.0
arm                  randconfig-002-20250221    clang-19
arm                  randconfig-003-20250221    gcc-14.2.0
arm                  randconfig-004-20250221    clang-21
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250221    clang-15
arm64                randconfig-002-20250221    clang-21
arm64                randconfig-003-20250221    clang-21
arm64                randconfig-004-20250221    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250221    gcc-14.2.0
csky                 randconfig-002-20250221    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250221    clang-21
hexagon              randconfig-002-20250221    clang-21
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250221    gcc-14.2.0
loongarch            randconfig-002-20250221    gcc-14.2.0
nios2                randconfig-001-20250221    gcc-14.2.0
nios2                randconfig-002-20250221    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                           defconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250221    gcc-14.2.0
parisc               randconfig-002-20250221    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250221    clang-21
powerpc              randconfig-002-20250221    clang-21
powerpc              randconfig-003-20250221    clang-17
powerpc64            randconfig-001-20250221    clang-21
powerpc64            randconfig-002-20250221    clang-21
powerpc64            randconfig-003-20250221    clang-19
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250221    clang-21
riscv                randconfig-002-20250221    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250221    gcc-14.2.0
s390                 randconfig-002-20250221    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250221    gcc-14.2.0
sh                   randconfig-002-20250221    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250221    gcc-14.2.0
sparc                randconfig-002-20250221    gcc-14.2.0
sparc64              randconfig-001-20250221    gcc-14.2.0
sparc64              randconfig-002-20250221    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250221    gcc-12
um                   randconfig-002-20250221    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250221    gcc-12
x86_64     buildonly-randconfig-002-20250221    clang-19
x86_64     buildonly-randconfig-003-20250221    clang-19
x86_64     buildonly-randconfig-004-20250221    clang-19
x86_64     buildonly-randconfig-005-20250221    clang-19
x86_64     buildonly-randconfig-006-20250221    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250221    gcc-14.2.0
xtensa               randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

