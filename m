Return-Path: <linux-pci+bounces-41563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02891C6C5D5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B0C0329824
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 02:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB60274B29;
	Wed, 19 Nov 2025 02:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QY0jwdcX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9C2749E0
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519147; cv=none; b=rHxjqVDhYBrDpXK21ReEvenR67rBv485rA1B0QkWj8FOxmoejx8s28oaphCUd+nqYRFYq5hZF2bewksudKDSRKNLxFkUGvirLZNFQj2Umq1eHJfKQ9ZacnpNglxPuxBHATV0GzjuXpbUktAqRsDR4sGGthBt0Umbn4faLJMjuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519147; c=relaxed/simple;
	bh=7At8A/XCuIpzqQaeH+hNML0X+2b+5F4LUSD4OFffGns=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pYkw5My3nvZV7t7XOLwlhS798sUaNHvotB6AUaRjBSKpjS8P61vkEPVJUV1mXa3dTk5KKXxEUBKNKmEpaAoTFWKZID9WPxE1zh1XexTXNlz3jW8IxHuWigM3do0lzQ6OmrpWjJRbwn2Bw3aGpsaE2+AOQCivtVgeXIwpvIBrSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QY0jwdcX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763519146; x=1795055146;
  h=date:from:to:cc:subject:message-id;
  bh=7At8A/XCuIpzqQaeH+hNML0X+2b+5F4LUSD4OFffGns=;
  b=QY0jwdcXIEpqZAvcs51Cz4mBdBarYFnvE/u1nBwODhTzc+zrAvXsTbZb
   GiZ1LfNNbN1ts/v8xxfzVPf79gqviJBDUCaf1mXpc3AxSKy0+OXWYAYuY
   V7EprwOvNATMKKuFQ7lI80dzWjNRN8vXHEWIKC/Biezna4NI7oSgAF7ji
   5sU5nbYI58qGXBV81gX4CPPbINRDDq1xde1H82T9d3capdwTm3vue4mwK
   iM37y+84LvvLhMh9y+DmjMu+GlL5kRZJWAZSkRAW+VWuDjjFC073NK3AP
   qkanLHzo4FSAaWtn1wI73wuP2d9e/dCR6xFPOifWvpFwjoXuhsc9tBJiX
   g==;
X-CSE-ConnectionGUID: GpOaUTCkSOSQZSPJwh8PlQ==
X-CSE-MsgGUID: nRjM3t9kTSiHuyzlvd3nMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76164674"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76164674"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 18:25:46 -0800
X-CSE-ConnectionGUID: cEk+hImkRIqd+xoJkNcvuw==
X-CSE-MsgGUID: vyepyyg9QjSXRLMzMSrhKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190195200"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 Nov 2025 18:25:44 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLXt7-0002MB-2H;
	Wed, 19 Nov 2025 02:25:41 +0000
Date: Wed, 19 Nov 2025 10:25:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/j721e] BUILD SUCCESS
 444a43bf3c029cc0a7c8d97611b3c126cddb5489
Message-ID: <202511191027.a52DKeIO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/j721e
branch HEAD: 444a43bf3c029cc0a7c8d97611b3c126cddb5489  PCI: j721e: Use 'pcie->reset_gpio' directly and drop the local variable

elapsed time: 7632m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-15.1.0
alpha              allyesconfig    gcc-15.1.0
arc                allmodconfig    gcc-15.1.0
arc                 allnoconfig    gcc-15.1.0
arc                allyesconfig    gcc-15.1.0
arm                allmodconfig    gcc-15.1.0
arm                 allnoconfig    clang-22
arm                allyesconfig    gcc-15.1.0
arm64              allmodconfig    clang-19
arm64               allnoconfig    gcc-15.1.0
arm64              allyesconfig    clang-22
csky               allmodconfig    gcc-15.1.0
csky                allnoconfig    gcc-15.1.0
csky               allyesconfig    gcc-15.1.0
hexagon            allmodconfig    clang-17
hexagon             allnoconfig    clang-22
hexagon            allyesconfig    clang-22
i386               allmodconfig    gcc-14
i386                allnoconfig    gcc-14
i386               allyesconfig    gcc-14
loongarch          allmodconfig    clang-19
loongarch           allnoconfig    clang-22
loongarch          allyesconfig    clang-22
m68k               allmodconfig    gcc-15.1.0
m68k                allnoconfig    gcc-15.1.0
m68k               allyesconfig    gcc-15.1.0
microblaze         allmodconfig    gcc-15.1.0
microblaze          allnoconfig    gcc-15.1.0
microblaze         allyesconfig    gcc-15.1.0
mips               allmodconfig    gcc-15.1.0
mips                allnoconfig    gcc-15.1.0
mips               allyesconfig    gcc-15.1.0
nios2               allnoconfig    gcc-11.5.0
openrisc            allnoconfig    gcc-15.1.0
openrisc           allyesconfig    gcc-15.1.0
parisc             allmodconfig    gcc-15.1.0
parisc              allnoconfig    gcc-15.1.0
parisc             allyesconfig    gcc-15.1.0
powerpc             allnoconfig    gcc-15.1.0
riscv               allnoconfig    gcc-15.1.0
s390               allmodconfig    clang-18
s390                allnoconfig    clang-22
s390               allyesconfig    gcc-15.1.0
sh                 allmodconfig    gcc-15.1.0
sh                  allnoconfig    gcc-15.1.0
sh                 allyesconfig    gcc-15.1.0
sparc              allmodconfig    gcc-15.1.0
sparc               allnoconfig    gcc-15.1.0
um                 allmodconfig    clang-19
um                  allnoconfig    clang-22
um                 allyesconfig    gcc-14
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

