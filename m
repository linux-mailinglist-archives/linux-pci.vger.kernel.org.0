Return-Path: <linux-pci+bounces-41477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA4EC6750F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 06:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6848B4E241D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 05:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8028032D;
	Tue, 18 Nov 2025 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4/oGfUL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207BF1B4257
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442523; cv=none; b=VhlZVysMsbozZM9IhQUk5VQSa87Rk9IngJZJolcDRbtZCqCZC51pspjOdhBVxJ9U10UBBsp8So3uv/HxYpQvVRiS8g7LLRmy9yhXNTqEpgN4Lt3uly75wkJuv74AGgiAB5XkqMy+IaRbonYxpDot5RvcVPDQiE56EI80HOaJgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442523; c=relaxed/simple;
	bh=pLz47jPyiToJiws+Auw267KV9qM2WilSOud6tPBiN3U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E2ge5BHZjkEU15lgulAf5VGX1YoE+rXI8bGA2QnGJmsN/DOnesZYCZwMj2yNksf3cXQBT6mrLf/91/JzI4iAclbkoBi35YF//OEBbzyVwFUh237I/NWmhIZwCEAUg1IYNe6MMatlm1iMiOvWbVAQDuMNbJ3k9+ihIwFJFdl9BfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4/oGfUL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763442522; x=1794978522;
  h=date:from:to:cc:subject:message-id;
  bh=pLz47jPyiToJiws+Auw267KV9qM2WilSOud6tPBiN3U=;
  b=C4/oGfUL34HY0wSIau/Q979VHaXew7BddJeV7NLd08MJHdL4CXNh4y4T
   5GWl70HYiG0izIT/9Ibe3DYup8V6JQKpBF/uWD/Gz3YCdlWbjWv/SWCTF
   YzEHi3ozrOEfk93kFdQCvratfvDOfLmdRxNFda177ood/r1n7LHgCpiDs
   9fuIKAtWzzW9nPVcQ+3qL6QHtW4e00tm/Je4tEXyGBB918gkeCX3H3XZk
   +MGHW/7Ry4AvADqnY4bFZinv/n8jVVVmdfVTWPG34BWVCSJvr+AtXlbX0
   c5Z1r6M96YVgaAMbWIjsp7CqcS6Y+e/BF5++3LAiRFW3iUnrsNt07qTbZ
   A==;
X-CSE-ConnectionGUID: 6H+5tUQ3SLy1oAsclmjHbQ==
X-CSE-MsgGUID: nXmQZdmSQfSKukVVNx/jFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76915302"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="76915302"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 21:08:41 -0800
X-CSE-ConnectionGUID: 6u7ZISlSQ6qR9sQYKblyeQ==
X-CSE-MsgGUID: vj6BsUvNSouA0J90Mjd7Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="195117723"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2025 21:08:39 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLDxF-0001LZ-1T;
	Tue, 18 Nov 2025 05:08:37 +0000
Date: Tue, 18 Nov 2025 13:08:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:ptm] BUILD SUCCESS
 044b9f1a7f4f3d41563007d0762c83a7d7505ac0
Message-ID: <202511181321.15iSSerm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ptm
branch HEAD: 044b9f1a7f4f3d41563007d0762c83a7d7505ac0  PCI/PTM: Enable only if device advertises relevant role

elapsed time: 7519m

configs tested: 65
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-15.1.0
alpha              allyesconfig    gcc-15.1.0
arc                 allnoconfig    gcc-15.1.0
arm                 allnoconfig    clang-22
arm64               allnoconfig    gcc-15.1.0
arm64              allyesconfig    clang-22
csky               allmodconfig    gcc-15.1.0
csky                allnoconfig    gcc-15.1.0
csky               allyesconfig    gcc-15.1.0
hexagon            allmodconfig    clang-17
hexagon             allnoconfig    clang-22
hexagon            allyesconfig    clang-22
i386               allmodconfig    gcc-14
i386                allnoconfig    gcc-14
i386               allyesconfig    gcc-14
loongarch          allmodconfig    clang-19
loongarch           allnoconfig    clang-22
loongarch          allyesconfig    clang-22
m68k               allmodconfig    gcc-15.1.0
m68k                allnoconfig    gcc-15.1.0
m68k               allyesconfig    gcc-15.1.0
microblaze         allmodconfig    gcc-15.1.0
microblaze          allnoconfig    gcc-15.1.0
microblaze         allyesconfig    gcc-15.1.0
mips               allmodconfig    gcc-15.1.0
mips                allnoconfig    gcc-15.1.0
mips               allyesconfig    gcc-15.1.0
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    gcc-11.5.0
nios2              allyesconfig    gcc-11.5.0
openrisc           allmodconfig    gcc-15.1.0
openrisc            allnoconfig    gcc-15.1.0
openrisc           allyesconfig    gcc-15.1.0
parisc             allmodconfig    gcc-15.1.0
parisc              allnoconfig    gcc-15.1.0
parisc             allyesconfig    gcc-15.1.0
powerpc            allmodconfig    gcc-15.1.0
powerpc             allnoconfig    gcc-15.1.0
riscv              allmodconfig    clang-22
riscv               allnoconfig    gcc-15.1.0
riscv              allyesconfig    clang-16
s390               allmodconfig    clang-18
s390                allnoconfig    clang-22
s390               allyesconfig    gcc-15.1.0
sh                 allmodconfig    gcc-15.1.0
sh                  allnoconfig    gcc-15.1.0
sh                 allyesconfig    gcc-15.1.0
sparc              allmodconfig    gcc-15.1.0
sparc               allnoconfig    gcc-15.1.0
um                 allmodconfig    clang-19
um                  allnoconfig    clang-22
um                 allyesconfig    gcc-14
x86_64             allmodconfig    clang-20
x86_64              allnoconfig    clang-20
x86_64             allyesconfig    clang-20
x86_64                    kexec    clang-20
x86_64                 rhel-9.4    clang-20
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-20
x86_64      rhel-9.4-kselftests    clang-20
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
x86_64            rhel-9.4-rust    clang-20
xtensa              allnoconfig    gcc-15.1.0
xtensa             allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

