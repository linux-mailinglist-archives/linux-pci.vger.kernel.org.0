Return-Path: <linux-pci+bounces-32678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E775DB0CB35
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A29189A4A9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E31A23B5;
	Mon, 21 Jul 2025 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPXSdkq4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD422F770
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127775; cv=none; b=dZMB+F2eQ/dIwL2CO1ex1S+egnlhUMcnLQLb7VMbzKdW2eYkY81VCXnjuQdJQ+GlCRaEtz8UiksFXWlcAtDUorQK5DJea7rkpr1MfzifAiUsHtpzFH04mel76TGpOGptrF4c0HyWA2J7M/UJhm2XyyAw319ni+qqYMTYxf7h7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127775; c=relaxed/simple;
	bh=ih4O8OR1LHt2JASXqg1nZnD5FkuCgMqpeU6V/2t/LjE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GxP0puiS7DLYtFpGGNTqU9Se+ka36UkTw2cp4Wx7OVSTSvRk5cc5k0oCOwKFakpR9RS2Ez/I9Sb5iZgRTd3ETPYMT9XomHNjpj9Z/CQwzlo1dvQONAmSxTVEFT4AkKiALtDzYuoW8ByIVXxHn75MRGAu4l6tdgmbK+CTHn5uahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPXSdkq4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753127773; x=1784663773;
  h=date:from:to:cc:subject:message-id;
  bh=ih4O8OR1LHt2JASXqg1nZnD5FkuCgMqpeU6V/2t/LjE=;
  b=HPXSdkq47VSiZQITQlD0jwMhcxaaSzW1z1Qd7og9ZlCS6eepiXxZ7qPn
   EDhzEypeTVgef7RZW8n0Gb9hYdNQgIXt90+F5/opgqZYxyxOHqvrqbB0A
   AMvzuWu9LZM3pw0VVECju/mbVvoTbLXmDWgQSkdeHCeFbR2cHOnkozUfO
   GTdzM5eNu70tLbcCrkgAu0ghFS5zdG5Op8M8N/WEdU+9QX4RJvCYIRfWf
   i5NE9oiKJNXV7yRsdnTWC/FFQYZy3bl7pCFDVLIPonsN023TeMr7PuGdm
   ssYnhJ34R+Vx1HSadV3u7Wa/vBxEQ8nTfVTu+jUPi6hvS+AD7BbweXqve
   w==;
X-CSE-ConnectionGUID: orIhXKGDRdqG8+jltRI61Q==
X-CSE-MsgGUID: 53/0WweSSS6Aq5nMxFUAZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="65622086"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="65622086"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 12:56:13 -0700
X-CSE-ConnectionGUID: y9zKb1DSScSP+31OdIYyUA==
X-CSE-MsgGUID: dFFAG2gdT52j0qyLWPC4bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158978674"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jul 2025 12:56:11 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udwcL-000H7R-2G;
	Mon, 21 Jul 2025 19:56:09 +0000
Date: Tue, 22 Jul 2025 03:55:32 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint/epf-vntb] BUILD SUCCESS
 61ae7f8694fb4b57a8c02a1a8d2b601806afc999
Message-ID: <202507220320.nRwzFWTt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint/epf-vntb
branch HEAD: 61ae7f8694fb4b57a8c02a1a8d2b601806afc999  PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute

elapsed time: 790m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250721    gcc-11.5.0
arc                   randconfig-002-20250721    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                   randconfig-001-20250721    clang-22
arm                   randconfig-002-20250721    gcc-13.4.0
arm                   randconfig-003-20250721    gcc-15.1.0
arm                   randconfig-004-20250721    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250721    clang-22
arm64                 randconfig-002-20250721    clang-20
arm64                 randconfig-003-20250721    gcc-13.4.0
arm64                 randconfig-004-20250721    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250721    gcc-15.1.0
csky                  randconfig-002-20250721    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250721    clang-22
hexagon               randconfig-002-20250721    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250721    clang-20
i386        buildonly-randconfig-002-20250721    clang-20
i386        buildonly-randconfig-003-20250721    gcc-12
i386        buildonly-randconfig-004-20250721    gcc-12
i386        buildonly-randconfig-005-20250721    clang-20
i386        buildonly-randconfig-006-20250721    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250721    clang-18
loongarch             randconfig-002-20250721    gcc-12.5.0
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250721    gcc-8.5.0
nios2                 randconfig-002-20250721    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250721    gcc-15.1.0
parisc                randconfig-002-20250721    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250721    gcc-12.5.0
powerpc               randconfig-002-20250721    gcc-10.5.0
powerpc               randconfig-003-20250721    gcc-11.5.0
powerpc64             randconfig-001-20250721    clang-22
powerpc64             randconfig-002-20250721    clang-22
powerpc64             randconfig-003-20250721    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250721    clang-22
riscv                 randconfig-002-20250721    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250721    clang-22
s390                  randconfig-002-20250721    clang-20
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250721    gcc-15.1.0
sh                    randconfig-002-20250721    gcc-14.3.0
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250721    gcc-15.1.0
sparc                 randconfig-002-20250721    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250721    clang-20
sparc64               randconfig-002-20250721    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250721    gcc-12
um                    randconfig-002-20250721    clang-17
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250721    clang-20
x86_64      buildonly-randconfig-002-20250721    gcc-12
x86_64      buildonly-randconfig-003-20250721    gcc-12
x86_64      buildonly-randconfig-004-20250721    gcc-12
x86_64      buildonly-randconfig-005-20250721    clang-20
x86_64      buildonly-randconfig-006-20250721    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250721    gcc-11.5.0
xtensa                randconfig-002-20250721    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

