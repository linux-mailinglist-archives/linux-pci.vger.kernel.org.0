Return-Path: <linux-pci+bounces-15565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386F9B5D0C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 08:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112C328388A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C61DF723;
	Wed, 30 Oct 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ri8/2SiS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DC85931
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273884; cv=none; b=oQ2XBqDQdueI8QAKZvLe0qrzvnjYCpXSTF8wNUIYtvrl819DaxRAGe7t1o+R2SIcjhN0t7XYIENsspuNeva1SKtJUerCP9qSsMOhdvHKQXy1S9osHIGVWnxD3urdau1q61ORw+CbPBXXIEpMCm/MtHZdW26yjDMu94IgIBjxKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273884; c=relaxed/simple;
	bh=zNDX0K9nbq6paKPXHgRn0y3rEOqBlGeSFj8F2Wgl7fY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=alA7Y5QKswALyk5doV+LT8bKJv2eib+Fq/z7KhPesZG1ZPqFZBgjDU6WEVzZtAbm5A85SOM8td8Cx2Bp1IGcQptrT3yP4EhVat/M9wfQYfwrSVnke7ckZOJ7oUipkrWfGyIohzd0lmZT2wFVPybjkiom+J+Cg1MtlNBTCcQs1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ri8/2SiS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730273882; x=1761809882;
  h=date:from:to:cc:subject:message-id;
  bh=zNDX0K9nbq6paKPXHgRn0y3rEOqBlGeSFj8F2Wgl7fY=;
  b=Ri8/2SiS6SrbSoDQsIkH+SlndEdcJQZjbCzoHJvUuB1VCgjMLc2VCkPb
   BC7if6gnm2q9b8ojnJG3dMeqv5ekwsCXBKZV+yv8QPTjxcfnbx2PEviDN
   UjxxsieQfpQQTqZYWt4mc0hGcxWvchcO7nj8RXFoXLx5WdEx2DJrBKjne
   ZImW45orgyHi6wJWjVm6oawH5oGyCjGWqBfWmR3R8yuXgAY/Xd5M+i988
   JCCRg77rUVBi9r4aYGp0N52pBDtXTvz3rfuQ8bIJ32WBrI4LJtBe/FTQ/
   LROXSWkU6gj4n6o8a7gbQwKIfuezg85OtnpqMw0QQU8l4XtS5/2qBXWx2
   A==;
X-CSE-ConnectionGUID: Ln/hr/06RSCPqpEAaAS8xA==
X-CSE-MsgGUID: JFSF9Ya7SuOSrbBWBnzhrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="17597767"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="17597767"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 00:38:01 -0700
X-CSE-ConnectionGUID: QojFMR2lSBmXDJrv6GegpA==
X-CSE-MsgGUID: zxLLBPIBSze4I6/rWBrUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82311377"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Oct 2024 00:38:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t63HC-000edQ-0b;
	Wed, 30 Oct 2024 07:37:58 +0000
Date: Wed, 30 Oct 2024 15:37:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 b5439ed9dce2d6dcb25ff929b55157786539ad8b
Message-ID: <202410301502.Y61c0oVT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: b5439ed9dce2d6dcb25ff929b55157786539ad8b  Merge branch 'pci/misc'

elapsed time: 983m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                 allnoconfig    gcc-14.1.0
alpha                allyesconfig    clang-20
alpha                allyesconfig    gcc-13.3.0
alpha                   defconfig    gcc-14.1.0
arc                  allmodconfig    clang-20
arc                   allnoconfig    gcc-14.1.0
arc                  allyesconfig    clang-20
arc              axs101_defconfig    clang-20
arc                     defconfig    gcc-14.1.0
arm                  allmodconfig    clang-20
arm                   allnoconfig    gcc-14.1.0
arm                  allyesconfig    clang-20
arm             axm55xx_defconfig    clang-20
arm                     defconfig    gcc-14.1.0
arm             lpc32xx_defconfig    clang-20
arm            realview_defconfig    clang-20
arm           spear13xx_defconfig    clang-20
arm64                allmodconfig    clang-20
arm64                 allnoconfig    gcc-14.1.0
arm64                   defconfig    gcc-14.1.0
csky                  allnoconfig    gcc-14.1.0
csky                    defconfig    gcc-14.1.0
hexagon              allmodconfig    clang-20
hexagon               allnoconfig    gcc-14.1.0
hexagon              allyesconfig    clang-20
hexagon                 defconfig    gcc-14.1.0
i386                 allmodconfig    clang-19
i386                  allnoconfig    clang-19
i386                 allyesconfig    clang-19
i386                    defconfig    clang-19
loongarch            allmodconfig    gcc-14.1.0
loongarch             allnoconfig    gcc-14.1.0
loongarch               defconfig    gcc-14.1.0
m68k                 allmodconfig    gcc-14.1.0
m68k                  allnoconfig    gcc-14.1.0
m68k                 allyesconfig    gcc-14.1.0
m68k                    defconfig    gcc-14.1.0
microblaze           allmodconfig    gcc-14.1.0
microblaze            allnoconfig    gcc-14.1.0
microblaze           allyesconfig    gcc-14.1.0
microblaze              defconfig    gcc-14.1.0
mips                  allnoconfig    gcc-14.1.0
mips               ip30_defconfig    clang-20
mips              rb532_defconfig    clang-20
nios2             3c120_defconfig    clang-20
nios2                 allnoconfig    gcc-14.1.0
nios2                   defconfig    gcc-14.1.0
openrisc              allnoconfig    clang-20
openrisc             allyesconfig    gcc-14.1.0
parisc               allmodconfig    gcc-14.1.0
parisc                allnoconfig    clang-20
parisc               allyesconfig    gcc-14.1.0
parisc64                defconfig    gcc-14.1.0
powerpc              allmodconfig    gcc-14.1.0
powerpc               allnoconfig    clang-20
powerpc              allyesconfig    clang-20
powerpc              allyesconfig    gcc-14.1.0
powerpc          arches_defconfig    clang-20
powerpc       bluestone_defconfig    clang-20
powerpc     canyonlands_defconfig    clang-20
powerpc           holly_defconfig    clang-20
powerpc         mpc83xx_defconfig    clang-20
powerpc         rainier_defconfig    clang-20
riscv                allmodconfig    clang-20
riscv                allmodconfig    gcc-14.1.0
riscv                 allnoconfig    clang-20
riscv                allyesconfig    clang-20
riscv                allyesconfig    gcc-14.1.0
s390                 allmodconfig    clang-20
s390                 allmodconfig    gcc-14.1.0
s390                  allnoconfig    clang-20
s390                 allyesconfig    gcc-14.1.0
sh                   allmodconfig    gcc-14.1.0
sh                    allnoconfig    gcc-14.1.0
sh                   allyesconfig    gcc-14.1.0
sh                migor_defconfig    clang-20
sh               se7343_defconfig    clang-20
sh               sh2007_defconfig    clang-20
sparc                allmodconfig    gcc-14.1.0
um                   allmodconfig    clang-20
um                    allnoconfig    clang-20
um                   allyesconfig    clang-20
um                   allyesconfig    gcc-12
x86_64                allnoconfig    clang-19
x86_64               allyesconfig    clang-19
x86_64                  defconfig    clang-19
x86_64                      kexec    clang-19
x86_64                      kexec    gcc-12
x86_64                   rhel-8.3    gcc-12
xtensa                allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

