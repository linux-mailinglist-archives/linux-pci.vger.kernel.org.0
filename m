Return-Path: <linux-pci+bounces-43889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5DDCEC6F9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 058E33009755
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DC2BE642;
	Wed, 31 Dec 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwBwhaGt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA332BD586
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204373; cv=none; b=fe1vHXhydcCU0BSHX0QSpZCvzhimzK9OzTz4gmOWOUl1xVY7t4reE3wCHcdEmuq3M+rml8o3gbbA4j4fCtxY/SLC4qVQQaBelDhFOmtqU8aiV52iV6vqCfzsGVLzEXjMaZkwERDNr27sZbLnOtSJUhs3I8Wg2ojNCEtXi6Q7l94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204373; c=relaxed/simple;
	bh=0csMl+d890zW1yJcz6CknK6/NPqSV4wt2Al3zit3pn4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MtU3HxAhNekIsfzazTExCoEQ2a6GOgE8OFSIOmi47ExjO3aRXHE9FpX6gAAw0v92i3qNGGueeT6LNK0pbB0hsVf9bAThgOZjZZVR7EouCqlYZN2exy/WCd7H7E3GsquWvBAoP5zWZtU3nOLE3oDpzbV9B/I+pEvHxojFcIIBbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwBwhaGt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767204372; x=1798740372;
  h=date:from:to:cc:subject:message-id;
  bh=0csMl+d890zW1yJcz6CknK6/NPqSV4wt2Al3zit3pn4=;
  b=XwBwhaGtrGNjRB0u+wGZn3NWlvTHFuHQy615Hc54n3F90ab36KsU+JK4
   JdtmduVH3mtUdSgRY+xkuCzCvj15gnUW9PJvBPYhyGe2tUYj6j5lezzBT
   FAyJTlCrXx9QHWqY9b3moirkdvlDtrUeu+JKHLfMIqxcDvClcA8az6zUp
   rCl8UcmJxUxD5oOF26+W3J9CWjtfY8J9QkU4GJx/vNcX9RG1HamR8mmwD
   h4ZkD5a1kzOLWo3/kW6xFGBa3EKw3QGp/pDLhEC8ResVWI0730SvLcqFA
   Fx+tIrWMaXo5oFlUFJqlj+Bn1Va87StBBE11H/TpdxEVoENL/wuw/xZdF
   A==;
X-CSE-ConnectionGUID: 7OP6954fT1WlSoSwXpKqOQ==
X-CSE-MsgGUID: x17GX2HATOGhpV5Zj6zOlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="67968892"
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="67968892"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 10:06:11 -0800
X-CSE-ConnectionGUID: al/axkvgSMe1tenLikZPUg==
X-CSE-MsgGUID: 1CDRX70jQfqjv16o0K5S1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="200699763"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 31 Dec 2025 10:06:11 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vb0aG-000000001OH-0VMK;
	Wed, 31 Dec 2025 18:06:08 +0000
Date: Thu, 01 Jan 2026 02:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 2fd60a2edb83a6308fffd5ea2a76c221b61a4eb3
Message-ID: <202601010229.MSR1IzrE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 2fd60a2edb83a6308fffd5ea2a76c221b61a4eb3  PCI: qcom: Parse PERST# from all PCIe bridge nodes

elapsed time: 1474m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

