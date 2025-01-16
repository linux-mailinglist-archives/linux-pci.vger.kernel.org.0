Return-Path: <linux-pci+bounces-20010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B1A14260
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24AA188BD06
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895BE22F387;
	Thu, 16 Jan 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtPmTPWM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8822E3FF
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056212; cv=none; b=O2iAFZdDWtL5NlRuQ9QBoyxYj9psEn7CuW6SawtNHCOFg0nazNgSGt0a98DJlQ/xn9g+UonUhO4mZ5ah2fAMmzzo7H2NX7c2bq1XDCqCg5szedyHt28KDCIGFvOyQaTp3haACa528KGtkgokIT/qghFzg1CMExnI4+xTqLMpDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056212; c=relaxed/simple;
	bh=eE2fnyuJOxjUPaY54HrrzpDE6rf0XGH0usPfEfP9XBo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WXTsgoP4ewpCaecL4fFYf5ICsUfywhR+mPMWKxvGNaoC1oYer0H4Z5+PfUa3x9C0tDmHZh3Hg8wfTXMY4mGNziacGS9w5AYPvZEW1GZsrGzjwbIsaZsZKI24FPWaQ6wm7R/rCbzM1NftK4iXjXeq5vNSqnsiB1amo+c/NJCpWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtPmTPWM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737056210; x=1768592210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eE2fnyuJOxjUPaY54HrrzpDE6rf0XGH0usPfEfP9XBo=;
  b=VtPmTPWMytmdb7aK7Dx93VfYPF5urEKj9Gz22MmKHWUm3LOUCXYI0H22
   GT50aHJEr+dKmBt7qrLPPnf5MqtK4WolHhIItEo9h4svCC2X9HU/g51gf
   YYrfgbTg365YO9tQlirpRzN+RdbL3tVGtwi+j5OMTqpoyui6DYYwYaG+g
   N9SAYfKIcBIU2ymVIC6cijU8JddKZUTmg2iGDxAHZCArurPrDXh+AfDO3
   48ERfwejonVlP/GHBrxXXeAwdEq228dnNOB5EiW1gFPNvT8+6wKfp6kjI
   2eN5gbRKaecV3F+fTtrhWnj48e1HF42m6Rhfc8zfqlLFmOln3ciimlB3l
   A==;
X-CSE-ConnectionGUID: SkGRD6DYSwO/gE9bRXLjVw==
X-CSE-MsgGUID: I9C1jDczQom6VleQyQin3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54878389"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="54878389"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 11:36:50 -0800
X-CSE-ConnectionGUID: XMLMpK/3Ski576ys4qK+/Q==
X-CSE-MsgGUID: SLCenBhkQE+7QZ6RtRew4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105366380"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Jan 2025 11:36:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYVfa-000SK1-2s;
	Thu, 16 Jan 2025 19:36:46 +0000
Date: Fri, 17 Jan 2025 03:35:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 ff07df3bc2e941b5b0c60bb511237e6a49553e6b
Message-ID: <202501170343.e9uYaBFV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: ff07df3bc2e941b5b0c60bb511237e6a49553e6b  misc: pci_endpoint_test: Fix overflow of bar_size

elapsed time: 1450m

configs tested: 82
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                  randconfig-001-20250116    gcc-13.2.0
arc                  randconfig-002-20250116    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                        mv78xx0_defconfig    clang-20
arm                  randconfig-001-20250116    gcc-14.2.0
arm                  randconfig-002-20250116    clang-15
arm                  randconfig-003-20250116    gcc-14.2.0
arm                  randconfig-004-20250116    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250116    gcc-14.2.0
arm64                randconfig-002-20250116    gcc-14.2.0
arm64                randconfig-003-20250116    clang-15
arm64                randconfig-004-20250116    clang-20
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250116    gcc-14.2.0
csky                 randconfig-002-20250116    gcc-14.2.0
hexagon                         alldefconfig    clang-15
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20250116    clang-20
hexagon              randconfig-002-20250116    clang-20
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250116    clang-19
i386       buildonly-randconfig-002-20250116    clang-19
i386       buildonly-randconfig-003-20250116    clang-19
i386       buildonly-randconfig-004-20250116    clang-19
i386       buildonly-randconfig-005-20250116    clang-19
i386       buildonly-randconfig-006-20250116    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250116    gcc-14.2.0
loongarch            randconfig-002-20250116    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
m68k                       m5307c3_defconfig    gcc-14.2.0
m68k                         multi_defconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                            allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250116    gcc-14.2.0
nios2                randconfig-002-20250116    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250116    gcc-14.2.0
parisc               randconfig-002-20250116    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250116    clang-20
powerpc              randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-003-20250116    clang-20
powerpc64            randconfig-001-20250116    clang-19
powerpc64            randconfig-002-20250116    clang-20
powerpc64            randconfig-003-20250116    clang-15
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250116    gcc-14.2.0
riscv                randconfig-002-20250116    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250116    gcc-14.2.0
s390                 randconfig-002-20250116    clang-18
sh                              allmodconfig    gcc-14.2.0
sh                               allnoconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250116    gcc-14.2.0
sh                   randconfig-002-20250116    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                            allnoconfig    gcc-14.2.0
sparc                randconfig-001-20250116    gcc-14.2.0
sparc                randconfig-002-20250116    gcc-14.2.0
sparc64              randconfig-001-20250116    gcc-14.2.0
sparc64              randconfig-002-20250116    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250116    clang-19
um                   randconfig-002-20250116    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250116    gcc-12
x86_64     buildonly-randconfig-002-20250116    gcc-12
x86_64     buildonly-randconfig-003-20250116    gcc-12
x86_64     buildonly-randconfig-004-20250116    clang-19
x86_64     buildonly-randconfig-005-20250116    clang-19
x86_64     buildonly-randconfig-006-20250116    clang-19
x86_64                             defconfig    gcc-11
xtensa                           allnoconfig    gcc-14.2.0
xtensa               randconfig-001-20250116    gcc-14.2.0
xtensa               randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

