Return-Path: <linux-pci+bounces-44091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91475CF79EF
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 10:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36ED8300FA27
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D152DCF7B;
	Tue,  6 Jan 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPLrFaZD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092386250
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693118; cv=none; b=GSX2KJwzM+XS9j/RuGERYh59L7BVPNaqQvsCHpqNYfGEOwJjiJ1F3ZRUaWtqtjy9cjll59zpmAIKWsUsWoh0GiEMhC7daW93j32dhiHeWWV/QtyPyyOvaNBJaIsXZ6a10bgJsViB01dHx2bwNkfkGUTcFIhycew2+1VfrLp0vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693118; c=relaxed/simple;
	bh=2kMQnftrmetouetOr5c28QNnvj5za26g9mc1cOJPxp8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gxc7eil7KGiyN7KWjXSBs2Oqk+nag8OPeD9Xjy5UR1SnqwOWCrgVNxpEIcidU1Uh/EnbkoqSMcZe8Rtcuff3gh2XQDzt6Y/vO4xlyzpdYJGu+kT5BgKC4QTdYW1S78OHfvwHCYjTAKNV84/y2aqdorzgBGse5uChViwSD1IAn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPLrFaZD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767693116; x=1799229116;
  h=date:from:to:cc:subject:message-id;
  bh=2kMQnftrmetouetOr5c28QNnvj5za26g9mc1cOJPxp8=;
  b=EPLrFaZDCLH7Bfpf/DKhxMT7F2frpBhXyXEYyPzOUuFxN4iHnMXJSmLb
   Tf/PNJDkKZaXercsRBKv1d1rp5N7jlIYmcWUSyFZPatSBGoYxRuvqRJkn
   M6edvxunz9/u2Bfd6XVc3UnMwDvalZCbDrqxsLrblrcAk2GO7OJGJ7b72
   ZGN2ut5cQvHLlqAhQ9TuCX4FDz0kFSAf7RejI9cTRZ6rdBuI01S03zazl
   dWSEzuKYZCcBsa0bM7KnRfobL2axoPPZbTxg0QPEokaDnIbFkDcxhGxky
   b3p0/e7COCET4iXXkWA+X+rX9WxrUQiIEs24sCKgnf5FAbCGFTOlz14Jx
   A==;
X-CSE-ConnectionGUID: LxE6N3BZSbyA6XeDbC+tqg==
X-CSE-MsgGUID: APfAYMAOQ4KUdwiu6xn7oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69131077"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69131077"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 01:51:55 -0800
X-CSE-ConnectionGUID: gZ0xwpDbQYiqRFCNnneJkQ==
X-CSE-MsgGUID: BaZPdEjCSJq7hEQ/3JWkZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="201843041"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Jan 2026 01:51:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vd3jD-000000001p1-2zUd;
	Tue, 06 Jan 2026 09:51:51 +0000
Date: Tue, 06 Jan 2026 17:51:15 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 72b39430284fc4a7a960133b70137c24fed63b74
Message-ID: <202601061707.KWFUu4I2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 72b39430284fc4a7a960133b70137c24fed63b74  dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084 to dedicated schema

elapsed time: 1505m

configs tested: 111
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260106    gcc-13.4.0
arc                   randconfig-002-20260106    gcc-8.5.0
arm                                 defconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20260106    gcc-11.5.0
arm                   randconfig-002-20260106    clang-22
arm                   randconfig-003-20260106    gcc-10.5.0
arm                   randconfig-004-20260106    gcc-8.5.0
arm                        shmobile_defconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260106    clang-22
arm64                 randconfig-002-20260106    gcc-8.5.0
arm64                 randconfig-003-20260106    gcc-9.5.0
arm64                 randconfig-004-20260106    gcc-10.5.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260106    gcc-10.5.0
csky                  randconfig-002-20260106    gcc-11.5.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260106    clang-22
hexagon               randconfig-002-20260106    clang-17
i386        buildonly-randconfig-001-20260106    clang-20
i386        buildonly-randconfig-002-20260106    clang-20
i386        buildonly-randconfig-003-20260106    gcc-14
i386        buildonly-randconfig-004-20260106    clang-20
i386        buildonly-randconfig-005-20260106    gcc-14
i386        buildonly-randconfig-006-20260106    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260106    clang-20
i386                  randconfig-002-20260106    gcc-14
i386                  randconfig-003-20260106    clang-20
i386                  randconfig-004-20260106    clang-20
i386                  randconfig-005-20260106    clang-20
i386                  randconfig-006-20260106    clang-20
i386                  randconfig-007-20260106    clang-20
i386                  randconfig-011-20260106    clang-20
i386                  randconfig-012-20260106    gcc-14
i386                  randconfig-013-20260106    gcc-14
i386                  randconfig-014-20260106    clang-20
i386                  randconfig-015-20260106    gcc-14
i386                  randconfig-016-20260106    clang-20
i386                  randconfig-017-20260106    gcc-14
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260106    gcc-15.1.0
loongarch             randconfig-002-20260106    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                  maltasmvp_eva_defconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260106    gcc-8.5.0
nios2                 randconfig-002-20260106    gcc-11.5.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260106    gcc-8.5.0
parisc                randconfig-002-20260106    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc               randconfig-001-20260106    clang-22
powerpc               randconfig-002-20260106    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20260106    gcc-8.5.0
powerpc64             randconfig-002-20260106    gcc-8.5.0
riscv                            alldefconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260106    gcc-8.5.0
riscv                 randconfig-002-20260106    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20260106    gcc-8.5.0
s390                  randconfig-002-20260106    gcc-14.3.0
sh                                  defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20260106    gcc-15.1.0
sh                    randconfig-002-20260106    gcc-10.5.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260106    gcc-11.5.0
sparc                 randconfig-002-20260106    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260106    clang-22
sparc64               randconfig-002-20260106    gcc-15.1.0
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260106    clang-22
um                    randconfig-002-20260106    clang-22
um                           x86_64_defconfig    clang-22
x86_64      buildonly-randconfig-001-20260106    clang-20
x86_64      buildonly-randconfig-002-20260106    gcc-14
x86_64      buildonly-randconfig-003-20260106    clang-20
x86_64      buildonly-randconfig-004-20260106    gcc-14
x86_64      buildonly-randconfig-005-20260106    clang-20
x86_64      buildonly-randconfig-006-20260106    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260106    gcc-14
x86_64                randconfig-002-20260106    gcc-14
x86_64                randconfig-005-20260106    gcc-14
x86_64                randconfig-006-20260106    gcc-14
x86_64                randconfig-011-20260106    gcc-14
x86_64                randconfig-012-20260106    gcc-13
x86_64                randconfig-013-20260106    gcc-14
x86_64                randconfig-014-20260106    gcc-14
x86_64                randconfig-015-20260106    clang-20
x86_64                randconfig-016-20260106    clang-20
x86_64                randconfig-071-20260106    gcc-14
x86_64                randconfig-072-20260106    clang-20
x86_64                randconfig-073-20260106    clang-20
x86_64                randconfig-074-20260106    clang-20
x86_64                randconfig-075-20260106    gcc-14
x86_64                randconfig-076-20260106    clang-20
xtensa                randconfig-001-20260106    gcc-8.5.0
xtensa                randconfig-002-20260106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

