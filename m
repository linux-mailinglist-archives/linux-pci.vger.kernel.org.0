Return-Path: <linux-pci+bounces-30507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E318AE66DD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC39175CFD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2402128D8FA;
	Tue, 24 Jun 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDonBQ7N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A3E6F06B
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772667; cv=none; b=BVwF/99+AqoKAgvjzr/M3cU/2XyHmQGvWJZM+ymIi6P+Fj1BXKdHgvNc074WwTTsLLJcnDR4QzVCI/BZwgmrNYKcMXNLZeUnejgV+fHWNW6Emkmj+7tvMFh8NQHtLbqUePKguq3NK9xZYPOnpzJoZ0Cirkv6uYYx2X15L2DF4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772667; c=relaxed/simple;
	bh=5DQCJ4yRICYbKX+IwGrzMO3ORD1QomklngewQwdKpQ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FK1KYvK3tMG7B9TbNePhmVjq6o/VwVsMDzNYpDCRgOwr8h3W9ffTu3TX2pFJmVtI8nsxKAEkkkZcKdR9gYAvs1WK6o0pIv0k5qxSRnQkGqOCWwNEn8EcWKS1RxCQbhrVorxVNOKHiaytPbY7fl3OoGWv37JuRA+eA0urgE+rt1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDonBQ7N; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750772666; x=1782308666;
  h=date:from:to:cc:subject:message-id;
  bh=5DQCJ4yRICYbKX+IwGrzMO3ORD1QomklngewQwdKpQ0=;
  b=DDonBQ7NuOraMejCYznbpyyPRFi13J4VodGi2OLCWGcGxhAEgOJ5Dkx6
   FKcknfsYsbHypUdM3LDmYNo3FjNnmrKwFGDrVuVHmmD+jL0hG+I6Byaxl
   9QE6MBZyM7FFqyoQvCBxgXprmgY6eYXdmVOqQ3EsQCdIDsYyq+fbEUBpI
   6GtTZzRuGMsb40xXr2rxSjQbDE4vq8LA345Vh5CGxzXCs+APmZRnrmQ/n
   CYPAa3iWAuNMTWkekJaE1/MW6icYNnckIb6Nd2H3p98Z7X+ylH7ClrNgl
   m2i56HnH9ilkj2eI8P//DWmgXxkr5a3f5g+HoyPrFaBWcD+bFflQLfXVM
   A==;
X-CSE-ConnectionGUID: SFxnW5/vThS0NvxajGiGCA==
X-CSE-MsgGUID: hwdmTyrpS6GPijvzy1Jw0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52882318"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52882318"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 06:44:26 -0700
X-CSE-ConnectionGUID: +zfKGq90SAO4v9MiPsqotw==
X-CSE-MsgGUID: tiIfiu5lQ7eeRRoo6Sp3Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156314928"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Jun 2025 06:44:25 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU3wk-000SBk-0T;
	Tue, 24 Jun 2025 13:44:22 +0000
Date: Tue, 24 Jun 2025 21:43:29 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc/stm32] BUILD SUCCESS
 003902ed7778d62083120253cd282a9112674986
Message-ID: <202506242117.BEt1xjXY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc/stm32
branch HEAD: 003902ed7778d62083120253cd282a9112674986  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers

elapsed time: 1459m

configs tested: 21
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha       allyesconfig    gcc-15.1.0
hexagon     allmodconfig    clang-17
hexagon     allyesconfig    clang-21
loongarch   allmodconfig    gcc-15.1.0
m68k        allmodconfig    gcc-15.1.0
m68k        allyesconfig    gcc-15.1.0
microblaze  allmodconfig    gcc-15.1.0
microblaze  allyesconfig    gcc-15.1.0
openrisc    allyesconfig    gcc-15.1.0
parisc      allmodconfig    gcc-15.1.0
parisc      allyesconfig    gcc-15.1.0
powerpc     allmodconfig    gcc-15.1.0
s390        allmodconfig    clang-18
s390        allyesconfig    gcc-15.1.0
sh          allmodconfig    gcc-15.1.0
sh          allyesconfig    gcc-15.1.0
sparc       allmodconfig    gcc-15.1.0
um          allmodconfig    clang-19
um          allyesconfig    gcc-12
x86_64       allnoconfig    clang-20
x86_64         defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

