Return-Path: <linux-pci+bounces-28932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4FCACD6B4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 05:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E291897755
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101B26136D;
	Wed,  4 Jun 2025 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbnX6DTv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0E261378
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749009011; cv=none; b=bzRwDqi4Q5X+E1j3AidnsQGDmdEKyYFwvJM0sJKVx8m547q/xVrxvwWW5ciKXteuj94AQ+Z2xHdjGQGOFZV267Ev1Y76Ia0WDkPg2EQ1g0fOA2P8UA8Y16pNe4RexqziYF6x3OyQ4OSwzYBGsfHqUBSg2/JuJN5clmk4XGhhB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749009011; c=relaxed/simple;
	bh=2UXn7SA7RlL0YpBhg0lz5Ufs4Dk/YYLXrf8Bv/A7FKY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Aa2SjKfkxGgEMPVjw886iIDIZdlR004JWULVG/o8S8JDo+saLmMZXdiQmLtzTTNOUiXNn1n0zlilkUTm6wvlNU8aRvrTghcE7r5L305AG1dM7HL+VeFck+qWY+qqas9ujQ49plaw/z/EOLoiz4yJWBOo/BYi3vXA85f2WdcmfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbnX6DTv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749009009; x=1780545009;
  h=date:from:to:cc:subject:message-id;
  bh=2UXn7SA7RlL0YpBhg0lz5Ufs4Dk/YYLXrf8Bv/A7FKY=;
  b=QbnX6DTvTKBjDXpT7EqXY7F1TfJYB8TlU/z889vf13IbmCC5OObsijaj
   /8OZBGADQi34o2QV7d/4irEoTSCk6fVJIU70FqFT0+N8drD8UhUmLeO43
   op8f0lSPTAzb6p7mK6IHVAx8FGmT0wj7A5XzYWcXNSWXmLKyWEOFcDVgV
   /A1WUGBXVDY8t9+JSXLafkWcNEV7A2BUjDcwHnmOz8uCYYh7LXXaRPmoj
   bPua3bQvsRK90REBaN4fi52g3ktwW7yxWQyXkjWScCADUJmDAIDV8riOv
   EwEVN55lqre2gyfSkhFIZfv3mY9eTJZlQ3VYM7smjN4gloQ4ipzAnyeEK
   A==;
X-CSE-ConnectionGUID: ojzMlfvpScqM7szDAE4GVA==
X-CSE-MsgGUID: 2KyGj790TLaR4SVTDhBBgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50986506"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="50986506"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:50:09 -0700
X-CSE-ConnectionGUID: auoIH/h6SxGOh/IqlAFNBw==
X-CSE-MsgGUID: ufgcRV13TGqsYcEQbpvxfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="150340983"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 03 Jun 2025 20:50:09 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMf8g-0002rt-15;
	Wed, 04 Jun 2025 03:50:06 +0000
Date: Wed, 04 Jun 2025 11:49:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 3c05e88413f7b7145795dc1ad56983e75bca07a7
Message-ID: <202506041138.LCbyc0DY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 3c05e88413f7b7145795dc1ad56983e75bca07a7  PCI: j721e: Fix host/endpoint dependencies

elapsed time: 1462m

configs tested: 34
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm          allmodconfig    gcc-15.1.0
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
hexagon      allmodconfig    clang-17
hexagon      allyesconfig    clang-21
i386         allmodconfig    gcc-12
i386          allnoconfig    gcc-12
i386         allyesconfig    gcc-12
i386            defconfig    clang-20
loongarch    allmodconfig    gcc-15.1.0
m68k         allmodconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze   allmodconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
openrisc     allyesconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc      allyesconfig    clang-21
riscv        allmodconfig    clang-21
s390         allmodconfig    clang-18
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc        allmodconfig    gcc-15.1.0
um           allmodconfig    clang-19
um           allyesconfig    gcc-12
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64          defconfig    gcc-11
x86_64      rhel-9.4-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

