Return-Path: <linux-pci+bounces-41919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3591C7DA3F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 01:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41B56351D9F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208E33EC;
	Sun, 23 Nov 2025 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lt6ITdBm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74217E4
	for <linux-pci@vger.kernel.org>; Sun, 23 Nov 2025 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763858961; cv=none; b=i0z6sil3aF62BWcKO9vNVp40LsK9R10wFeeKaYvyiAKuchqP7IJtX16nUiJIAPDBYq1PX1whqNpf1A+2stdUQXtksrVKPt+BdTpdB+J2Zy2urGXnLzEm2DKpE6omJ+n51EJDlJX8dQezCWTYHcz6yRGg5FAo1lKxD0n6OMCB4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763858961; c=relaxed/simple;
	bh=yiuNL8TJke6oU9peFb4uwsXJFereaes/S4iUeb4lEto=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YC74iQdgM016BIoJgTfSmPYa7kaDPFBEYFHIqRDaY6TDJi8sHCK5FjL0t74xe9A8WWRY6VoDgIP6AWq0HzmPneBpU5EZT6Z4Ps9/vp3uWrZphXWNg9MhIHjUDlXqHZChKgNE7Z6HmNr+wrrkEsCUZQo7kPZqLUYR8JdWZUcoDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lt6ITdBm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763858960; x=1795394960;
  h=date:from:to:cc:subject:message-id;
  bh=yiuNL8TJke6oU9peFb4uwsXJFereaes/S4iUeb4lEto=;
  b=lt6ITdBm0IZV8Ir7j4Vg8mEglYNVYjTYvF36RmwEyUblikw7fDA3T5iu
   aL22JzbIcFlA5xK0P3yQeVaYJIN1ppoHHW1CmpKcjvlx+vvC3w4HHR26h
   oQFix9+FEoxBaw4Qh8lPInLObJ9q9kBoKZmDfgj7swXOCkWaewVTp2FSZ
   RbzETSucncDeAgzB/J7SYk+v0yoLoj4Mz5CQZgfjT0uoNOGXmzkTL3ywo
   LBEngA/CMCElW9Zxp45rw3nplK/kMYpPkTXSLemywlzB2fJMzHfhAU+uh
   9LWp+akZF4x06wdL0ocn9FoNzN6JTDb40fZKAnz3jKSFi5Rcb3atnZ9gp
   w==;
X-CSE-ConnectionGUID: Mgl4Hrd1QAOZ5ON1Cq70qQ==
X-CSE-MsgGUID: HgWnDJ71T5unSgrfwGYR9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="65988605"
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="65988605"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 16:49:19 -0800
X-CSE-ConnectionGUID: kJa3FTV8Qz6pepE8GLMRmg==
X-CSE-MsgGUID: gGEUxJjBRBqf+Tob05S8hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="192474398"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 22 Nov 2025 16:49:18 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMyHz-0007wp-30;
	Sun, 23 Nov 2025 00:49:15 +0000
Date: Sun, 23 Nov 2025 08:48:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 ea837d44d23ed536d3764a177ee6d82bba2de5ea
Message-ID: <202511230835.eD1iHStm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: ea837d44d23ed536d3764a177ee6d82bba2de5ea  Merge branch 'pci/controller/stm32'

elapsed time: 7373m

configs tested: 62
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-15.1.0
alpha              allyesconfig    gcc-15.1.0
arc                allmodconfig    gcc-15.1.0
arc                 allnoconfig    gcc-15.1.0
arc                allyesconfig    gcc-15.1.0
arm                 allnoconfig    clang-22
arm                allyesconfig    gcc-15.1.0
arm64              allmodconfig    clang-19
arm64               allnoconfig    gcc-15.1.0
csky               allmodconfig    gcc-15.1.0
csky                allnoconfig    gcc-15.1.0
hexagon            allmodconfig    clang-17
hexagon             allnoconfig    clang-22
i386               allmodconfig    gcc-14
i386                allnoconfig    gcc-14
i386               allyesconfig    gcc-14
loongarch          allmodconfig    clang-19
loongarch           allnoconfig    clang-22
m68k               allmodconfig    gcc-15.1.0
m68k                allnoconfig    gcc-15.1.0
m68k               allyesconfig    gcc-15.1.0
microblaze          allnoconfig    gcc-15.1.0
microblaze         allyesconfig    gcc-15.1.0
mips               allmodconfig    gcc-15.1.0
mips                allnoconfig    gcc-15.1.0
mips               allyesconfig    gcc-15.1.0
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    gcc-11.5.0
openrisc           allmodconfig    gcc-15.1.0
openrisc            allnoconfig    gcc-15.1.0
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
sparc               allnoconfig    gcc-15.1.0
sparc64            allmodconfig    clang-22
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

