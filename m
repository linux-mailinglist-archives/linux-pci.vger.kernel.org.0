Return-Path: <linux-pci+bounces-18825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F749F88D4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 01:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5050A16F643
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189EA50;
	Fri, 20 Dec 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrezMkyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067EEC4
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734653473; cv=none; b=KvhDB5Qd3cFGSYN/QOZNteVznCddelUAMOFmSbNNxGl52WZyd7pg8CU6ZH/E43V3FhmElldPC8kfhtvzweharUhRp6urkRpVrHMtWnGw1a4XWE5LHdGfvkaMcxCGTWa3j+e7CngH7tLUIz2FwXrEmQzgHmSS1fjKDMpGB8V2yFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734653473; c=relaxed/simple;
	bh=FHsAC/i4q5BHy4bFjXyV1s9hIvq95f0jvqSwtCBVlIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G1tqHc8Z8T9WVwgJHqxP44uWMYz5l0SzaZkvrKKzp4M7HobJSCQjGQmq1M7O5RGZixbInZMZE20UF8KQcfOIKN8kXkOzUPHNq7KP8aeG9KQZ8DTBxeZcM4HPlj9TEZnTsjR3xV+sN8Nj8ovWqZHprE79JgqzgpuGz4BDAWph24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrezMkyT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734653471; x=1766189471;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FHsAC/i4q5BHy4bFjXyV1s9hIvq95f0jvqSwtCBVlIE=;
  b=IrezMkyT/xnpKNY7Mn4PRqtxhRBV34myDQ0gcfzTYWfI95s5gatfiyi+
   yETKRAUq1cqtDW5k0fDDbhmgErSwomYrA3j4seiWbOH3Jg6xaz3h7ThXb
   W1CdTZ3RmnGXsz6s8YbQZGx9dsfAmYizkIt40DLJEpj2Gu52B3NmyxKVs
   w1ti+Q8f0ot8NGvtHi4GewPxm9+3quHc12vNDgmKFGB9ixSokoHSLkv1P
   /+uP8TXwfeYfThsyfKnuOsXnbhLQMuCqhssfUsy+OfjrMss0OQSPof7u5
   XH181zlzSr7ijzI7Fpt4P77PmJX5aoFATlaxeK5Re0AKhD7Feu02+I0JP
   A==;
X-CSE-ConnectionGUID: CdnE6JSmTZuUal37B9hq3g==
X-CSE-MsgGUID: u6d1lAczR/66CTVynfsAsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="38978234"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="38978234"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 16:11:10 -0800
X-CSE-ConnectionGUID: SI3l/K/8QGGsYryOdGo2mA==
X-CSE-MsgGUID: pZiKw1XoRr64px0Oelrm/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="98749182"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Dec 2024 16:11:09 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOQbi-0000ct-2n;
	Fri, 20 Dec 2024 00:11:06 +0000
Date: Fri, 20 Dec 2024 08:10:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx-cpm] BUILD SUCCESS
 4eea7596b8fb5c204f7a454a5166ebdcb6b6c72a
Message-ID: <202412200844.EDsdanhy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx-cpm
branch HEAD: 4eea7596b8fb5c204f7a454a5166ebdcb6b6c72a  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port Controller 1

elapsed time: 1442m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241219    gcc-13.2.0
arc                   randconfig-002-20241219    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241219    clang-18
arm                   randconfig-002-20241219    gcc-14.2.0
arm                   randconfig-003-20241219    clang-18
arm                   randconfig-004-20241219    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241219    clang-16
arm64                 randconfig-002-20241219    clang-18
arm64                 randconfig-003-20241219    gcc-14.2.0
arm64                 randconfig-004-20241219    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241219    gcc-14.2.0
csky                  randconfig-002-20241219    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241219    clang-19
hexagon               randconfig-002-20241219    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241219    gcc-12
i386        buildonly-randconfig-002-20241219    gcc-12
i386        buildonly-randconfig-003-20241219    clang-19
i386        buildonly-randconfig-004-20241219    clang-19
i386        buildonly-randconfig-005-20241219    gcc-12
i386        buildonly-randconfig-006-20241219    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241219    gcc-14.2.0
loongarch             randconfig-002-20241219    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241219    gcc-14.2.0
nios2                 randconfig-002-20241219    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241219    gcc-14.2.0
parisc                randconfig-002-20241219    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20241219    clang-18
powerpc               randconfig-002-20241219    clang-16
powerpc               randconfig-003-20241219    clang-20
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241219    gcc-14.2.0
powerpc64             randconfig-002-20241219    clang-18
powerpc64             randconfig-003-20241219    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241219    clang-16
riscv                 randconfig-002-20241219    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241219    gcc-14.2.0
s390                  randconfig-002-20241219    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241219    gcc-14.2.0
sh                    randconfig-002-20241219    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241219    gcc-14.2.0
sparc                 randconfig-002-20241219    gcc-14.2.0
sparc64               randconfig-001-20241219    gcc-14.2.0
sparc64               randconfig-002-20241219    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20241219    gcc-12
um                    randconfig-002-20241219    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241219    gcc-12
x86_64      buildonly-randconfig-002-20241219    gcc-12
x86_64      buildonly-randconfig-003-20241219    clang-19
x86_64      buildonly-randconfig-004-20241219    gcc-12
x86_64      buildonly-randconfig-005-20241219    gcc-12
x86_64      buildonly-randconfig-006-20241219    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241219    gcc-14.2.0
xtensa                randconfig-002-20241219    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

