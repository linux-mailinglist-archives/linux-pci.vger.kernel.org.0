Return-Path: <linux-pci+bounces-43483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD44CD3954
	for <lists+linux-pci@lfdr.de>; Sun, 21 Dec 2025 01:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DE483008D71
	for <lists+linux-pci@lfdr.de>; Sun, 21 Dec 2025 00:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D491D5147;
	Sun, 21 Dec 2025 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzOOK1wq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48C157487
	for <linux-pci@vger.kernel.org>; Sun, 21 Dec 2025 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766277361; cv=none; b=Dg64/dkLiR4aegcoaquQUUtR7cjXTrghFYAPd2h8bB6oer1mThzxxKt/6w+iL2bhJM6MQU0F8ZDduKGCswtzsOMMU5jf3R0Xg5a+1rlxHTOsskmk6gWFPfa5Uo5wMbtzpiHxqSridREUmYEy9Yz/3nziChEHHjwNl0sfXiVEyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766277361; c=relaxed/simple;
	bh=olObcnixTQC+iT6Uj2T2HTqCsOCWX5vmWjNPGkjgSF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmL8HAlia/zuCrBmS8IpzNl8hsLjgnPtPjSAsTVakND+67Sdp6UW8VQsBAiTWnx2170grqUOgJASCvxYmKwJRbfcXCb7nYnO2r42YdtOzEX8MIsv+L0m9cr5dfPqbV5/9vrQYI54oShFf9PkCmHyL+uTTHR/UZyZMhB3IFk0ozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzOOK1wq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766277360; x=1797813360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=olObcnixTQC+iT6Uj2T2HTqCsOCWX5vmWjNPGkjgSF8=;
  b=lzOOK1wqzGVeSXmAn9NDqW5VD0UNKVGM4eJV03bd834xfGtZk/uMf2ik
   yzVpVKs708MCiN/mg2SOEeUMFqX8XjybrYoVdecF6mN1u/30ZJUbfkOFN
   40wB1OocfJGxxDLi5oIxTlLdTKrdj3/ot8XjNbBklTVCSJ+W/gpzWcf8P
   2wrf8aWnU8y4fIQFy4CkdcyIxiwMK8NBnt7sN8KlwNCeSGMhkOjGjoLl8
   6P1Dd+hxJmEf6YlbrURtJzhsGhsKjnq71EDD3bXzcn1NbkghK+fmElYJt
   VuSb2ds3dgrehWNstSpnmKIf6/zQIZLa+98+V7qvWt4IldtArkP7wm2BQ
   Q==;
X-CSE-ConnectionGUID: gMjpY57aSUK5dFyNK7YwaQ==
X-CSE-MsgGUID: rX7sAuG6TPC1jKlsG5zaMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="78507751"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="78507751"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 16:36:00 -0800
X-CSE-ConnectionGUID: XrbkD7s0Q1GuuPrMe5yT1g==
X-CSE-MsgGUID: PCy7FnIiTFq6rbqjhiKFEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="198941116"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Dec 2025 16:35:56 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX7QK-000000005Dt-0UC8;
	Sun, 21 Dec 2025 00:35:48 +0000
Date: Sun, 21 Dec 2025 08:35:30 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: extend pci-stub to support explicit binding by PCI
 BUSID
Message-ID: <202512210848.d1IKcriu-lkp@intel.com>
References: <20251219131038.21052-1-roman.shlyakhov.rs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219131038.21052-1-roman.shlyakhov.rs@gmail.com>

Hi Roman,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Shlyakhov/pci-extend-pci-stub-to-support-explicit-binding-by-PCI-BUSID/20251219-211130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251219131038.21052-1-roman.shlyakhov.rs%40gmail.com
patch subject: [PATCH] pci: extend pci-stub to support explicit binding by PCI BUSID
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512210848.d1IKcriu-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b324c9f4fa112d61a553bf489b5f4f7ceea05ea8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210848.d1IKcriu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210848.d1IKcriu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/pci-stub.c:220:13: error: expected parameter declarator
     220 | early_param("pci_stub_busid", pci_stub_early_param);
         |             ^
>> drivers/pci/pci-stub.c:220:13: error: expected ')'
   drivers/pci/pci-stub.c:220:12: note: to match this '('
     220 | early_param("pci_stub_busid", pci_stub_early_param);
         |            ^
>> drivers/pci/pci-stub.c:220:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     220 | early_param("pci_stub_busid", pci_stub_early_param);
         | ^
         | int
>> drivers/pci/pci-stub.c:220:12: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
     220 | early_param("pci_stub_busid", pci_stub_early_param);
         |            ^                                      
         |                                                   void
   4 errors generated.


vim +220 drivers/pci/pci-stub.c

   219	
 > 220	early_param("pci_stub_busid", pci_stub_early_param);
   221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

