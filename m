Return-Path: <linux-pci+bounces-44467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15DD10AD4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8E3300D644
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 06:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718730F930;
	Mon, 12 Jan 2026 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMc/GDgO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862701A9F91
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768198083; cv=none; b=k1a3OfkcdL3lMS3LF6LRUs2oqUXkeePyS3VCa95zt67T+j5//zWButFI92C/m5pguntE40tfeQeVPMFbu/Gf2YyzD+yd63O7KSnu138sn2wA/Zc1pca7sjgLIww5rUgoXDNHulrTIrpfq+cHFCqCypXITWc1HcB4RTQfKMItzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768198083; c=relaxed/simple;
	bh=qY6fFivY3C7osNsjRzXbu1zRPfi+UErb2JkYLlvDlR8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mK8RX4+e5vUvyOcFOtDi62zWkfnwlfzikUqgG/TYsqj1OMf/2waytB22BlVSbtN5REq7b5mKY4XBOGMV/bXRFRKlziR1xhLO8E2PzMEajje1WAXZjJfiYlge/2rr+JViKz3iVm1kV6YEoln4dh8H8+gXfTwPfcpYSvpTrOOFQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMc/GDgO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768198082; x=1799734082;
  h=date:from:to:cc:subject:message-id;
  bh=qY6fFivY3C7osNsjRzXbu1zRPfi+UErb2JkYLlvDlR8=;
  b=VMc/GDgOmta/q4fAk4hxuTnGtlNL6uVTNu8FGZ/sv30zGl+Vv8DTVZtI
   h1aPMh9rXHwijAxkrLVqnHcEHF8GWpBal4NPy1Kw3hz7QDqFq4YJF+uzj
   8ULcCr/5djxrgz2/0or72yPoT/Sa2pu/i9x/kdJXCgoSGvbrwyl6ySZ9w
   N4wKcpMioltIJRpewLYH4/ifZeRGPNmeMmE8CFMobcq07i9E4gpeli7q/
   UsjDF4Cw4s4lOWxDIsIO8luWN3HNDOVbisqms9HdA/rUU0o5dHIbYCCMz
   WEXnzslZLZNoMm9mn4iMpI2ROWQbLQCNhrklRggwScvedsYH93/k7jmJ1
   g==;
X-CSE-ConnectionGUID: MKi21ZbgSq60cwnv8ILM9w==
X-CSE-MsgGUID: 4QiGZ8oZTuyc30BMKznpCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80923218"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80923218"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 22:08:02 -0800
X-CSE-ConnectionGUID: L28uuawHRJGx9PPANYPdAQ==
X-CSE-MsgGUID: DXFS4AWXTWmPYc4J9tobUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203159544"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Jan 2026 22:08:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfB5q-00000000D38-08OP;
	Mon, 12 Jan 2026 06:07:58 +0000
Date: Mon, 12 Jan 2026 14:07:09 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 c796513dc54e9609ac9a080e8958f6d5499d553e
Message-ID: <202601121403.mnien9xx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: c796513dc54e9609ac9a080e8958f6d5499d553e  PCI/PM: Prevent runtime suspend until devices are fully initialized

elapsed time: 7754m

configs tested: 55
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

