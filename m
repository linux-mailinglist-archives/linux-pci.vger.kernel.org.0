Return-Path: <linux-pci+bounces-21977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7156DA3F294
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC95420074
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13A20102C;
	Fri, 21 Feb 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTglMYCg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62C20103B
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135385; cv=none; b=RkgiAQ9UWjQv1CxL3fjR5hLsYscSU5vnQOpO7rf4cUoh7nPwE9Qs8KN3c+4AZ8HjZgibXql90gxFrmpaB6v1QtvRFf/Xg5+oTIA0HaN0zVT4fiJXddBltNp54nSLypcaEdrxCmxl3OfeEqJSMg1PwV9qBbln0KgzQ44Jj9Z6U8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135385; c=relaxed/simple;
	bh=jkAvzx1It3ScSixFUZb1S+wJ0JsmwCsJGg9o1misxqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uJfHJD6QuHvvvza1hXZZzCIGbdkzaP0mce7qi/0/6s/GuI5tBRCv0zGOdbq5Y3FWBnNBxckpMnOym1fGRyyr0gl516bw+EgKEKEeg8T9TNlaYMw1LBgcJGPZqeGNZM+vfH5+p4DDpoWW5tiPa6i/kZcMwtvUKh65UfnNuwHGW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTglMYCg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740135384; x=1771671384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jkAvzx1It3ScSixFUZb1S+wJ0JsmwCsJGg9o1misxqA=;
  b=NTglMYCgASWfl6fhO2hXfa7281AT+XNdo3I/tp97+VgYPPVpFBtvXb9z
   gVS/4KUEhN4bGeGVk6nzjBQ8RaYeAQoeF6lDRzucmrfLIYkAgGZIb7zMQ
   amyBpR0cDJNKC2vtdXsfwQLhSGzGF8NaT846ZTtFJq3Stj3H35jcOirvQ
   igBoRg2IdML6DYKE6YPru6tvIN5frGC8+JT2+7v3o2God+6rFZQr9uBLg
   4fw0mMXikrOF8lboF4lDK1bOmrkb6Yy5QS7kYAHABhqD4MRXFCMGBar3r
   Viqv/Jdw3hUemxYY8kJAiNpApBiqk/dC+OKJVziFOkVoUaoTJ1wWYRPXl
   g==;
X-CSE-ConnectionGUID: Lj9+DJsZTsGZXYu5iG2C2A==
X-CSE-MsgGUID: 3aO0sDa9RDyz4AfQgne2SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51576367"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51576367"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 02:56:23 -0800
X-CSE-ConnectionGUID: 2TljJVl1TG2duzS3ysja6Q==
X-CSE-MsgGUID: phHkwHOlQymYZiqB1xvIjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152535950"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 21 Feb 2025 02:56:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlQhL-0005PW-0A;
	Fri, 21 Feb 2025 10:56:07 +0000
Date: Fri, 21 Feb 2025 18:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 cbf937dcadfd571a434f8074d057b32cd14fbea5
Message-ID: <202502211842.mg9aDM6Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: cbf937dcadfd571a434f8074d057b32cd14fbea5  PCI/ASPM: Fix link state exit during switch upstream function removal

elapsed time: 1455m

configs tested: 81
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250220    gcc-13.2.0
arc                  randconfig-002-20250220    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250220    gcc-14.2.0
arm                  randconfig-002-20250220    gcc-14.2.0
arm                  randconfig-003-20250220    gcc-14.2.0
arm                  randconfig-004-20250220    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250220    gcc-14.2.0
arm64                randconfig-002-20250220    gcc-14.2.0
arm64                randconfig-003-20250220    clang-21
arm64                randconfig-004-20250220    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250220    gcc-14.2.0
csky                 randconfig-002-20250220    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250220    clang-21
hexagon              randconfig-002-20250220    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250220    gcc-12
i386       buildonly-randconfig-002-20250220    gcc-12
i386       buildonly-randconfig-003-20250220    gcc-12
i386       buildonly-randconfig-004-20250220    clang-19
i386       buildonly-randconfig-005-20250220    clang-19
i386       buildonly-randconfig-006-20250220    clang-19
i386                               defconfig    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250220    gcc-14.2.0
loongarch            randconfig-002-20250220    gcc-14.2.0
nios2                randconfig-001-20250220    gcc-14.2.0
nios2                randconfig-002-20250220    gcc-14.2.0
parisc               randconfig-001-20250220    gcc-14.2.0
parisc               randconfig-002-20250220    gcc-14.2.0
powerpc              randconfig-001-20250220    gcc-14.2.0
powerpc              randconfig-002-20250220    clang-16
powerpc              randconfig-003-20250220    clang-21
powerpc64            randconfig-001-20250220    clang-16
powerpc64            randconfig-002-20250220    clang-18
powerpc64            randconfig-003-20250220    gcc-14.2.0
riscv                randconfig-001-20250220    gcc-14.2.0
riscv                randconfig-002-20250220    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250220    clang-19
s390                 randconfig-002-20250220    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250220    gcc-14.2.0
sh                   randconfig-002-20250220    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250220    gcc-14.2.0
sparc                randconfig-002-20250220    gcc-14.2.0
sparc64              randconfig-001-20250220    gcc-14.2.0
sparc64              randconfig-002-20250220    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250220    gcc-12
um                   randconfig-002-20250220    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250220    gcc-12
x86_64     buildonly-randconfig-002-20250220    gcc-12
x86_64     buildonly-randconfig-003-20250220    gcc-12
x86_64     buildonly-randconfig-004-20250220    gcc-12
x86_64     buildonly-randconfig-005-20250220    gcc-12
x86_64     buildonly-randconfig-006-20250220    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250220    gcc-14.2.0
xtensa               randconfig-002-20250220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

