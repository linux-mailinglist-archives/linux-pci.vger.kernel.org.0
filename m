Return-Path: <linux-pci+bounces-44696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3CD1C42C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 04:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0FEA3000DE1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 03:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721B15E5DC;
	Wed, 14 Jan 2026 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC4dS8/q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C342E401
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361468; cv=none; b=Hve00FyUnKlQpTzCv6aL4zepnUU+9rvexid8hInUNn1CZXSUQpIvYKLmghiNVbu7t/3Y1fkFcqZl676Nw9RKIfPgq4mWmUXlEQeKrLDA78iUovasv70tuWdQ7ICQD3t6LgfFlHllnQ0bGiYek9s0fcCXw/GfXHE3jOn5svVDyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361468; c=relaxed/simple;
	bh=fWxFEUqfBwhWCgOzFyKa6UM/DftE1ySWLdAb7XtylYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QcKZxPH2ddJg0+iqlE3Mb9Bu8NRHTTiFTbg7TFbM5Qk2iITbwYjBCDx1wkCxDeovkdjIpS/Rjlin1Vw9BVxJFxm1XR6vl9Y+HClt7uTsN83/pylbH3KOXMyX/HsVIg7nNnRZr9ssClScqHxSjwyx2OYvRJAP1Ko+C7kaJewYAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC4dS8/q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768361467; x=1799897467;
  h=date:from:to:cc:subject:message-id;
  bh=fWxFEUqfBwhWCgOzFyKa6UM/DftE1ySWLdAb7XtylYM=;
  b=XC4dS8/qz3JpDg/O88Jg2gbCUjbf335L5sWJBV+RAUE9YEu8ll89xoT+
   nIxUIf3OQjLp3ZiuD9wpg+9a0iRXWbcr6CnA+0tWbfnODsTYzlivqaU2r
   Adkbv1UUBpsWD7pvJDVNc9pXuqGnd2A6XoSttW3U5FbF6U9zFVApm9lmq
   o5Ux74uqdrwBvhqEDWZHHc4ggQzS6txmVc5QQvlOeCwDyuzYcU9sJWcfU
   +p7IaTRFED/2PU1f8nkREc/fq5UtjyKs0vpp+JDmgiJbwPQF3j9K2x87A
   D/fjyHsqylmbfBlbAdaBunS7WtdjfnAPfjtu0djDAV1B9kqv7Oah8mV2L
   Q==;
X-CSE-ConnectionGUID: Yrm8HbccRFyQs8jJEO8G2w==
X-CSE-MsgGUID: m9c3J9udQsaOMfy+t+IMHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="95130904"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="95130904"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:31:07 -0800
X-CSE-ConnectionGUID: vaTIgcDwTDaZLNJZzszcRQ==
X-CSE-MsgGUID: I143tigkRSKlUxrAVLB1JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204973288"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Jan 2026 19:31:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfrb5-00000000FjM-2ySD;
	Wed, 14 Jan 2026 03:31:03 +0000
Date: Wed, 14 Jan 2026 11:30:47 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra194] BUILD SUCCESS
 6b5e2f70a95c1f46ed444a54ad4c6ff6b9673b1d
Message-ID: <202601141142.5Iu2bVqz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra194
branch HEAD: 6b5e2f70a95c1f46ed444a54ad4c6ff6b9673b1d  PCI: dwc: tegra194: Broaden architecture dependency

elapsed time: 8581m

configs tested: 54
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

