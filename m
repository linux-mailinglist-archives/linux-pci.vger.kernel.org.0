Return-Path: <linux-pci+bounces-12869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2CA96E839
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 05:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E52280C60
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 03:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90E8381B1;
	Fri,  6 Sep 2024 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMIi4Yt4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBD1E521
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593288; cv=none; b=IPS9j4nHZLI+GhRxf2igluoLqkK9K1y1XI67QYVKtIboesei/pF9EGZC/eh8gK8kLk5YRldeTJnnwIclTcR61SfeniF7xZFdspIyeaWZx9khBizJFySNYtWrPL2YMF4r62cozjbtUvRc2hEmi53faS7fXyV3pOeT+53jq4MTa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593288; c=relaxed/simple;
	bh=e5dgdbk9a5yFFmEoTWpKDdPFE+WjTicwutZBDijxYj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gp8uBBkWe8eYZbKb8ylGwVtCdKRzCt3IvWqOYO/VUa4lz0jvJrUlwd/29YK+hup8NoaP3m3woCe+wg2eqTXRkKI3vnNvPv2vZnssVnaAWIn4WbOtP/uqjFdVygwgHfCaPFjGI09JKr28cwMfRKym/t+spPggdwI79z9CXh4NFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMIi4Yt4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725593286; x=1757129286;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e5dgdbk9a5yFFmEoTWpKDdPFE+WjTicwutZBDijxYj4=;
  b=SMIi4Yt4q2BEYoEHxGndWUFFdH2AYEsQ/kdCBOR1oBgwWOUT3sBjztQp
   2axN77C18Sovk7v8KHKVwqBAcbgrUU24zw0/DVYoRoqxwMLaDmAqbX00F
   NkFJU1iY4/ShSAlTd1bdb9uNKJjk8rqVwxzaN+sieQt1C2XbfgGJsMQd5
   s8rX2HgQ4TE2ZKp/wKkHExxQvsTcXsVCPix80R1u+l43fZ27PN4y6wwFO
   X8mduE+t5r2Q+njawBQcOvLRV5L1xN3iL6CW72JNA8mrpZlxKaMz18izu
   aAnR+E2fNWgePiEnrOodwF8X/kpjaA3HV8UQ09zJzpvHkQxSfsbX9/T3B
   g==;
X-CSE-ConnectionGUID: 2myHWtjNR2CS70A2rny71w==
X-CSE-MsgGUID: 2YRuhh1dQpiTpxdmgAOSgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24142856"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="24142856"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:28:06 -0700
X-CSE-ConnectionGUID: JOKY0HHZROeHTLEAyXDN+w==
X-CSE-MsgGUID: JKHAiAijTAK+jNr06jYOZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="69979677"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Sep 2024 20:28:03 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smPde-000AZD-2B;
	Fri, 06 Sep 2024 03:27:58 +0000
Date: Fri, 06 Sep 2024 11:27:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 721357f7f81fd0c750a33fd1df0872f5f50d14b2
Message-ID: <202409061143.KvRCA6iu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 721357f7f81fd0c750a33fd1df0872f5f50d14b2  PCI: brcmstb: Enable 7712 SoCs

elapsed time: 2203m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-14.1.0
arc                   randconfig-001-20240906   gcc-13.2.0
arc                   randconfig-002-20240906   gcc-13.2.0
arm                               allnoconfig   gcc-14.1.0
arm                   randconfig-001-20240906   clang-20
arm                   randconfig-002-20240906   gcc-14.1.0
arm                   randconfig-003-20240906   gcc-14.1.0
arm                   randconfig-004-20240906   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240906   clang-20
arm64                 randconfig-002-20240906   clang-17
arm64                 randconfig-003-20240906   gcc-14.1.0
arm64                 randconfig-004-20240906   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240906   gcc-14.1.0
csky                  randconfig-002-20240906   gcc-14.1.0
hexagon                           allnoconfig   gcc-14.1.0
hexagon               randconfig-001-20240906   clang-20
hexagon               randconfig-002-20240906   clang-14
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240905   clang-18
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-004-20240905   clang-18
i386         buildonly-randconfig-005-20240905   clang-18
i386         buildonly-randconfig-006-20240905   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-002-20240905   clang-18
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-004-20240905   gcc-11
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-011-20240905   clang-18
i386                  randconfig-012-20240905   clang-18
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-014-20240905   clang-18
i386                  randconfig-015-20240905   clang-18
i386                  randconfig-016-20240905   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240906   gcc-14.1.0
loongarch             randconfig-002-20240906   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240906   gcc-14.1.0
nios2                 randconfig-002-20240906   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240906   gcc-14.1.0
parisc                randconfig-002-20240906   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240906   clang-17
powerpc               randconfig-003-20240906   clang-15
powerpc64             randconfig-001-20240906   clang-20
powerpc64             randconfig-002-20240906   clang-15
powerpc64             randconfig-003-20240906   clang-20
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240906   gcc-14.1.0
riscv                 randconfig-002-20240906   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240906   clang-20
s390                  randconfig-002-20240906   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240906   gcc-14.1.0
sh                    randconfig-002-20240906   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240906   gcc-14.1.0
sparc64               randconfig-002-20240906   gcc-14.1.0
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240906   clang-20
um                    randconfig-002-20240906   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240906   gcc-14.1.0
xtensa                randconfig-002-20240906   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

