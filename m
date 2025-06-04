Return-Path: <linux-pci+bounces-28933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA6ACD6B5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 05:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DFE1780F1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4423815F;
	Wed,  4 Jun 2025 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOWZ61N9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1A70838
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749009071; cv=none; b=T+5CeTPu0kq0ByQvfpPrkOoUOx6lIOlRD8kN3nTGR6m/j+7PHRWVE9amtAmkKOuRwJkAHnOGxAMilkRzMey0ICM/jyZ6UhEtXc3UIGy8Zyv+fW1/qEfUmna6FSd5mXvAPnO0akKo9ZHyFkLFOyRoAkOfOs5rTChA+4acB0XdxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749009071; c=relaxed/simple;
	bh=91XLLkIsqxDA8lPn1mYfAnRPByX1xkaxA5onLmtjerw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aecNLaz6JFeJRZ08Aex7nQPQFU/lMjk7PZA0K+LZmEl0yrlDXi/uQ0I+PJ+M+fLICTu0//xfXctkNPff5aP/HVgMVRBi7cm2VRA5pQmRDYbz92v01fgXt4jds3IKTI9/bfd+ZHhv0eMofCRlWzMjRGlhad0BHQepdUhpiBspSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOWZ61N9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749009070; x=1780545070;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=91XLLkIsqxDA8lPn1mYfAnRPByX1xkaxA5onLmtjerw=;
  b=MOWZ61N9EXJkBwb68jlPqRT33YIi9E6PaPKTDC7Q+1krTdrYqN6EW5Zl
   YaHoV+BJ+kKtVFfkpGscvZHUhsxfufouP06/xKcZEjNhjX6LE1ACBIn2+
   933lGhJXws6sYcq+xdcFyYINaUBimSeAXpru2D1wyt+TKfGDpXhFdfFGZ
   3vbJNd4iJNIOpGfzFavq6cfHGKjBAqIAlPnKh2oNEHlff2D08IOsg5+st
   Dcsn+9+xRFCUPY6fPS7q6kviX+2UCKnG6kEzCCYyyxLvtfB8y3q4yb1GV
   2pWk6h7aGvklCQ3nLMAWdIP/baprEc4VcLcABOOXa4g4F9aNcqsTCqbou
   A==;
X-CSE-ConnectionGUID: 3nQLZBzfQQ+D4k5YbxNDQA==
X-CSE-MsgGUID: RSWNL0xDSO2r5SUKNhkpIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="76459694"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="76459694"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:51:09 -0700
X-CSE-ConnectionGUID: nEdda6akTqK9wCa7tVGJDw==
X-CSE-MsgGUID: PIJskPK+S3GocOjxHl9hWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="145378142"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2025 20:51:08 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMf9e-0002s4-1X;
	Wed, 04 Jun 2025 03:51:06 +0000
Date: Wed, 04 Jun 2025 11:50:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 ae06c6197c9e53dcb115f1f7aad9e86aa465adae
Message-ID: <202506041120.KwO9q0ha-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git mi=
sc
branch HEAD: ae06c6197c9e53dcb115f1f7aad9e86aa465adae  MAINTAINERS: Update =
Krzysztof Wilczy=C5=84ski email address

elapsed time: 1463m

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
powerpc      allyesconfig    clang-21
riscv        allmodconfig    clang-21
riscv        allyesconfig    clang-16
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

