Return-Path: <linux-pci+bounces-30663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA6FAE908A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 23:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580423AACE1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8744253F13;
	Wed, 25 Jun 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPQ3cNGS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292531C861D
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888596; cv=none; b=mrjuyT/W+fmBIpIu+AhmBlNXjxLWSo07fmXmuW9bo+IovyUg2ZV5IMOkMWjTJscp7Fl0+ebZ7XDdMwIEiZ0rAggHTQ/76rygroX/efg41sL0wjRZPoQqYdKHZN9cYQxvzdlpIEiqxjE8IxyLZ0UViEz6tW/soEF5qTUoXk/fasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888596; c=relaxed/simple;
	bh=A5r4ydyqACtqFHlbEq0LkQiT4jSJv8dZJETlZg0TklQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qXIB+1hs/EayuDY9+T7k3SNN66UQGd+89qvOPK+y4W45STAWZ6ApJcDt9DvgD3ZREJbNoeUqvkMsdjtaCfhhGbPaiij+2H/W6wEAcn0gToQbu7MnzncmGMjk5bgCXH3XOY9UX9JoRAsmNY6h8Vb3ywLf3cpuh527GP63/tr9QWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPQ3cNGS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750888595; x=1782424595;
  h=date:from:to:cc:subject:message-id;
  bh=A5r4ydyqACtqFHlbEq0LkQiT4jSJv8dZJETlZg0TklQ=;
  b=BPQ3cNGStqWLLK0vVHn0kjNKuwc2sYuNykqWiPtR4TM61TUYdxle/dV1
   x6/HKNnAQ0Q6Z3Sw0gSC5+4xcrNC1qFB/wceK6GboJfbNJwrz+GgmabIe
   pdWpkYdqiDl3dXhrQud76YdGm+JXfTkyXq1Je8hN1EGk0Rrr6pKeEz0u9
   cYRt8XRDVG61a4Cf5vjTrbfG5+cniiAf79/T8RBOQs0WfaOvQu4i3en7+
   SUG9Dh44Z7Ym/XyNsE3wqll1y2Fr2SW/equBvukw2ZbAt8u90yeNCrOH1
   85A8aJEDXcHqI676HQTnPPSMpBLoB4lfR+f1jz6dNtHsgXR4M31OnI0WF
   w==;
X-CSE-ConnectionGUID: M8Hq4hrMSZyc5DQf4IBtvw==
X-CSE-MsgGUID: TosyUistTDu/q6QZDaMM5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64608118"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64608118"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:56:35 -0700
X-CSE-ConnectionGUID: 3SXEZtbWSiGBn9KZ2KY62Q==
X-CSE-MsgGUID: EwzAYNEQR5aqQ49M9tccJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152636669"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Jun 2025 14:56:33 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUY6Z-000TTu-1d;
	Wed, 25 Jun 2025 21:56:31 +0000
Date: Thu, 26 Jun 2025 05:56:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 b85af48de3ece4e5bbdb2248a5360a409991cf67
Message-ID: <202506260551.IGiheiHA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: b85af48de3ece4e5bbdb2248a5360a409991cf67  PCI: Adjust the position of reading the Link Control 2 register

elapsed time: 1451m

configs tested: 57
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250625    gcc-11.5.0
arc                   randconfig-002-20250625    gcc-12.4.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250625    clang-21
arm                   randconfig-002-20250625    gcc-11.5.0
arm                   randconfig-003-20250625    gcc-13.3.0
arm                   randconfig-004-20250625    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250625    gcc-11.5.0
arm64                 randconfig-002-20250625    clang-20
arm64                 randconfig-003-20250625    gcc-12.3.0
arm64                 randconfig-004-20250625    clang-20
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
i386        buildonly-randconfig-001-20250625    clang-20
i386        buildonly-randconfig-002-20250625    gcc-12
i386        buildonly-randconfig-003-20250625    gcc-12
i386        buildonly-randconfig-004-20250625    gcc-12
i386        buildonly-randconfig-005-20250625    clang-20
i386        buildonly-randconfig-006-20250625    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
x86_64      buildonly-randconfig-001-20250625    gcc-12
x86_64      buildonly-randconfig-002-20250625    clang-20
x86_64      buildonly-randconfig-003-20250625    clang-20
x86_64      buildonly-randconfig-004-20250625    clang-20
x86_64      buildonly-randconfig-005-20250625    clang-20
x86_64      buildonly-randconfig-006-20250625    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

