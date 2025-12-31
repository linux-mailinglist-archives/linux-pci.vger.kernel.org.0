Return-Path: <linux-pci+bounces-43883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FCCEC469
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 17:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29AED3007603
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CF2882C9;
	Wed, 31 Dec 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j45pbjz9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395382494FF
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767199022; cv=none; b=dt1x+WCztQ2b6i4k7VNXM3JlxmGm5oP3lbmjMjbo/AalZZGnUii6AM+P/tXcHLP8l3MPWT4Q78/M2Vm4S+J9gInl0t0yUZP8SQimpD7OFpp7UTA0C0F1TlB2UoHXyzU+w4Ztg0IJEIkAP/zBF7YT1gV7lM2axaKXAWnjF/J9maw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767199022; c=relaxed/simple;
	bh=9vQfBpgX8DqIlocwcnZif4be3KzNYXUfOGJ4fK3+QSE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=twpZbNZ8pZxiGlkPhv9jdK0JWS3qXZo80vhdRaA4kjDFCtVCTdmLHlnKOyKTGOk8ffvkcR+CFsZEow/2FGqb7BLzuTTCDB0w9jzxMGJPXgjciNY749Ch/EE6vK4UIPU4dSTgmtczEYPkqKtX/ZnYh6IygHHOcjUoSO5dQdjQ8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j45pbjz9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767199020; x=1798735020;
  h=date:from:to:cc:subject:message-id;
  bh=9vQfBpgX8DqIlocwcnZif4be3KzNYXUfOGJ4fK3+QSE=;
  b=j45pbjz9MTc4DDzjzp6kS24hoChW4lf4BbwgpluBuxtooZx6XwzjN8Bg
   6jQ8WgjL9p+OQR55EJoNKLXzf0tFyghdeHFYkO7F5wIvdTxoIH7MfweFo
   fzLIFnyYqnuIrY5x7Hsc4gZu9+DYpn+I8AdKs60aov9UT6ovWUBNNzOhZ
   uPlOsoh7wHtv17dvMt49qqC7lyBtnKJTkmwj+EAMZyYyIA+QGRtjlY/k/
   IzNxv2S+GZYYoLwgLwCg/TusXzA5RwEct9ntwae2rw8zqaji4jP5t82Gf
   q5Ni2R23M19G3vfRJn/19m003ZSJ3mQ9dlYDs5SgiqJjA81mB+j4d3FSN
   Q==;
X-CSE-ConnectionGUID: HUr8UaxVSMCHh3eydIzYOA==
X-CSE-MsgGUID: FNO3cR1/T9mdosjZk+spIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="86344886"
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="86344886"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 08:37:00 -0800
X-CSE-ConnectionGUID: 5Zk+ddSeSbWR+Z/1ZxvByA==
X-CSE-MsgGUID: 9I13cXLsTVqTcSIyGL3V+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="238911868"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Dec 2025 08:36:58 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vazBw-000000001Kh-0rdk;
	Wed, 31 Dec 2025 16:36:56 +0000
Date: Thu, 01 Jan 2026 00:35:57 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rzg3s-host] BUILD SUCCESS
 62d4911290f9cbb16f5b6ba6782660148a656fc7
Message-ID: <202601010051.SITf7ALD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rzg3s-host
branch HEAD: 62d4911290f9cbb16f5b6ba6782660148a656fc7  PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS

elapsed time: 1385m

configs tested: 51
configs skipped: 4

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
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
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

