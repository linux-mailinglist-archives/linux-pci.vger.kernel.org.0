Return-Path: <linux-pci+bounces-30506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F77AE66B2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A73AAF66
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D962C17B4;
	Tue, 24 Jun 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbZ3Pwzx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3BC2C159A
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772305; cv=none; b=nGRNrjyQmZ0jolBthAAVHQOnnK+6PVhnF37geBVidMZz9zDSNvxO7OjQ9czbERUj/0f/eXl+jVjo2v3znykwB9q+EB5hj+ON/ik6DcQPpVcXrg/2VPxhDejS1fSp9lgexvTU8JSs4zfroRrHGo8vIeT5Q5PY4diNUbZi3DOtd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772305; c=relaxed/simple;
	bh=8EdlEgZGr9F9wJjIl7bPu4gZCcSXjD2emX0NZOEp93M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H3Eh32wyYoxwff+1WvKHrWIgNKYQRv6Ew4IxwElJRk46QsgJCHWs44twYDa0ViMP4oL+pQY7yHJwh3nAysMuJ5NnQ7PKu8o9DJANIAq7Iceg8x0uk7Hv58Cdfgn2bS/mju+6MTQTYd4KuATgbuvRVYxcTBKjAUhTy06M2yFzenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbZ3Pwzx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750772304; x=1782308304;
  h=date:from:to:cc:subject:message-id;
  bh=8EdlEgZGr9F9wJjIl7bPu4gZCcSXjD2emX0NZOEp93M=;
  b=AbZ3PwzxMGfb3gyfMaNYZPq+PZm4aY1cE2aVgPpxcraMqMgX6X+DQdr4
   8mmV7KtLafO1RrQkAv1BMA0rU/RfHUtT2f8AIJxvuPlPNEoJFoxSEZ6cH
   gyUV6ZRbe/ElWVOcS9ZGG3Gaarehkt3FGYl2H4NhpzNymCLy2VYMHkoo0
   kGSce0YQDbtj4++HiHLDhrZfX+/4O062cDjR6AoPpSfCWKSyU+vzdOTkR
   h72oJyF5Vv/QSOz80Tocu2N/8qb0ID19Na6ivy9sH1iAm+fKeYFS8b3+e
   Fsz/rRLStTtQ6HHKIu0Hb4l5+0DD/wNRwW3jDDWW9CcQ3VImlD7oltoOx
   Q==;
X-CSE-ConnectionGUID: YNr3iZbVQtWpdMwrXZ81pQ==
X-CSE-MsgGUID: HPn2yHOjQvKZKaucQG33bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70579997"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="70579997"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 06:38:23 -0700
X-CSE-ConnectionGUID: 4otPRJOJQ/i/8NPFziOUNA==
X-CSE-MsgGUID: 5xmSXJGmQRK7m+sVU3bdWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152446669"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jun 2025 06:38:23 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU3qu-000SB0-1V;
	Tue, 24 Jun 2025 13:38:20 +0000
Date: Tue, 24 Jun 2025 21:37:23 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint/epf-vntb] BUILD SUCCESS WITH WARNING
 a0cc6e6fd072616315147ac68a12672d5a2fa223
Message-ID: <202506242105.8r1cvZZA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint/epf-vntb
branch HEAD: a0cc6e6fd072616315147ac68a12672d5a2fa223  PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202506240711.TJdFg8To-lkp@intel.com

    Warning: drivers/pci/endpoint/functions/pci-epf-vntb.c:695 function parameter 'bar' not described in 'epf_ntb_find_bar'

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- i386-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- i386-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- loongarch-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- microblaze-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- microblaze-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- openrisc-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- parisc-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- parisc-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- powerpc-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- powerpc-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- riscv-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- riscv-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- s390-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- sparc-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- um-allmodconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
|-- um-allyesconfig
|   `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar
`-- x86_64-allyesconfig
    `-- Warning:drivers-pci-endpoint-functions-pci-epf-vntb.c-function-parameter-bar-not-described-in-epf_ntb_find_bar

elapsed time: 1452m

configs tested: 30
configs skipped: 1

tested configs:
alpha        allyesconfig    gcc-15.1.0
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

