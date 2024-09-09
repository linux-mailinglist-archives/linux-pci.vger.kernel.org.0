Return-Path: <linux-pci+bounces-12943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949A9712B4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FC41F23417
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD00176237;
	Mon,  9 Sep 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGeMTeeX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE61B29C2
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872216; cv=none; b=QiMzASeZgwVmXN60M3JQVqV3oguHX1KllqtcLrU7M8TK/gT7zYAWpPLRLGvRvUu5EaQe4c6NKKUEYd0LfvFjK6a53gtIfviRLJneesU2TKNzR6cq24xo1fwKsn+VT1/kxx3S1Yil3Xbe+bIxPHSeFRGP44YjzCAXDco8hCfRd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872216; c=relaxed/simple;
	bh=Qn8DDf492SFTDFVbYCo4rhi3QoNH93Kny3ep8sNADYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bjPvFBlu4G/+ocd/XdMEcrDyqN83XDeiML5MgoDbD2VazqWtzl4h1eonXY+Q3dpAXaBTlbCi59YLMAk5HJf9G7t0pSYRa1NPuNNpRl/P63bBdYjVGh16CsgMQxeWXcEGEV7W6CwLHA4SXIUe7TyOsw00iYSDn36S/sS1gOkcaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGeMTeeX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725872214; x=1757408214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qn8DDf492SFTDFVbYCo4rhi3QoNH93Kny3ep8sNADYc=;
  b=fGeMTeeXNTs9KBtToSqIkKzW+JEPqE3WIRNHR+XC28O+lXNZvw9sIg3v
   1sQmOIlzp4LgytYa/6eJJ5580H+yJ57axR/wVZ2JtbCTWh3GRltqrcmAV
   RgmU5Oiij658h0kNGj2LXuPyLo6cpMaZPBs8yKQcZXqt4ehzzAPAZfkrY
   IFfIl7MB8Ir2sfnoNxGNzcchXzZeI/c+A45zXERl2iKhg3uqXztFdnOMl
   LVJXTOGtmC1PiAIkkKn4XvwPJbYKN72lBzHGp9xyc0VreHkkYUM52Qrij
   athx2pZNhQkmK6132BESg7QjW1BhhqF1XFlzC/wIvz/v/N+TkwoV8r7N7
   A==;
X-CSE-ConnectionGUID: x7jrx2FBTDie08vchJ0A+g==
X-CSE-MsgGUID: ADB3HKqGRDmJ5f7A/JSAIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="47077060"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="47077060"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:56:53 -0700
X-CSE-ConnectionGUID: bxH3agydRbqxxGePqXcL6A==
X-CSE-MsgGUID: ZJr306r4QP6tHM62tF+sig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71177956"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Sep 2024 01:56:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snaCY-000EXG-1S;
	Mon, 09 Sep 2024 08:56:50 +0000
Date: Mon, 09 Sep 2024 16:56:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 91e5d15c7b198ecea27407e04cff2fed2d4c2c75
Message-ID: <202409091620.m2fdTXVK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 91e5d15c7b198ecea27407e04cff2fed2d4c2c75  PCI: brcmstb: Enable 7712 SoCs

elapsed time: 2366m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240909   gcc-13.2.0
arc                   randconfig-002-20240909   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                   randconfig-001-20240909   gcc-14.1.0
arm                   randconfig-002-20240909   gcc-14.1.0
arm                   randconfig-003-20240909   clang-14
arm                   randconfig-004-20240909   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240909   gcc-14.1.0
arm64                 randconfig-002-20240909   clang-20
arm64                 randconfig-003-20240909   gcc-14.1.0
arm64                 randconfig-004-20240909   clang-16
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                           allnoconfig   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240908   clang-18
i386         buildonly-randconfig-002-20240908   clang-18
i386         buildonly-randconfig-003-20240908   clang-18
i386         buildonly-randconfig-004-20240908   clang-18
i386         buildonly-randconfig-005-20240908   clang-18
i386         buildonly-randconfig-006-20240908   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240908   gcc-12
i386                  randconfig-002-20240908   clang-18
i386                  randconfig-003-20240908   clang-18
i386                  randconfig-004-20240908   clang-18
i386                  randconfig-005-20240908   clang-18
i386                  randconfig-006-20240908   clang-18
i386                  randconfig-011-20240908   clang-18
i386                  randconfig-012-20240908   gcc-12
i386                  randconfig-013-20240908   gcc-12
i386                  randconfig-014-20240908   clang-18
i386                  randconfig-015-20240908   gcc-12
i386                  randconfig-016-20240908   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240909   gcc-12
x86_64       buildonly-randconfig-002-20240909   gcc-12
x86_64       buildonly-randconfig-003-20240909   gcc-12
x86_64       buildonly-randconfig-004-20240909   gcc-12
x86_64       buildonly-randconfig-005-20240909   gcc-12
x86_64       buildonly-randconfig-006-20240909   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240909   gcc-12
x86_64                randconfig-002-20240909   clang-18
x86_64                randconfig-003-20240909   clang-18
x86_64                randconfig-004-20240909   clang-18
x86_64                randconfig-005-20240909   clang-18
x86_64                randconfig-006-20240909   gcc-12
x86_64                randconfig-011-20240909   gcc-12
x86_64                randconfig-012-20240909   gcc-12
x86_64                randconfig-013-20240909   gcc-12
x86_64                randconfig-014-20240909   clang-18
x86_64                randconfig-015-20240909   gcc-11
x86_64                randconfig-016-20240909   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

