Return-Path: <linux-pci+bounces-43484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB1CD3D75
	for <lists+linux-pci@lfdr.de>; Sun, 21 Dec 2025 10:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD62B3009830
	for <lists+linux-pci@lfdr.de>; Sun, 21 Dec 2025 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AEC22836C;
	Sun, 21 Dec 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKWyEetA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBF3A1E7F
	for <linux-pci@vger.kernel.org>; Sun, 21 Dec 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766308680; cv=none; b=TWY5gaZ6Ykpwzk1jXGRJ2nOIYy1BTQsSsEW8FvqQLyXhzsrLVeOL58u0zIUU7FJtnmEVjjow6WiNsdIVOLmFahKaj6mPX/AJspUHrlAabp3aQ6w30jb9iYXC/M0B9uooRO35zsZI40lYTe/kkroxlCzpLmdf6T+TVAcpcfiJB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766308680; c=relaxed/simple;
	bh=UX76z34OGithuqL4xCqtlmhIT+aXbgFZPl894njcF2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e43UxHK0heJYRi2HzVsNXH1QYA/PKYSbFPa1Q/LMU0/LAOcLHIZjh3ADqToRyh/0GrBijlmp8/84LYnREu2shz474AlJ6nkcroI7xZxosQyqIVN0D4R94B57p1b+mg7q0xQ/6rMPIyz2byxkXqmJBqQO68IDJBBfPX8i9dD2aBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKWyEetA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766308679; x=1797844679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UX76z34OGithuqL4xCqtlmhIT+aXbgFZPl894njcF2A=;
  b=YKWyEetAexvQ1J7TPhqEcg9bB+VjBfTYUTmsXyzcSv9QoiZcvZPMFEHG
   iUcvgwckofMwynRvTzlAs7WiuK15KQXtkdslXTmUoDT49XlBl3Ueyxmxm
   NILvR9AY9nnvKes26C5ipA/mFDwFArq1nnwVzz4bAo2hB9YUkaZ9OdMZf
   HY9Y0ENMmujgQToXEzRc16IoQBpBOY39PPqva8EQV6f5feEf8E5L46xVK
   q2g+fMBDjTyO8xl3MPrE/gudc+D36qs/IW5nA8OA1c23mTaS0XjP+dzAL
   psN/CVrRDtqdv1JQeAQdb02K1kgENYU8TXoqBxMOwn2IJYOG3A5hfmLvI
   w==;
X-CSE-ConnectionGUID: LRjits/gSdmEl5zBJV7Z+Q==
X-CSE-MsgGUID: oPG1b39oSJecQ9h/Kz5pGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="71833218"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="71833218"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 01:17:58 -0800
X-CSE-ConnectionGUID: Q3O/X4heRm6b5NhX3nzU4A==
X-CSE-MsgGUID: a9FT+N8wQVS+eo9HTa3/iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199559936"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 21 Dec 2025 01:17:57 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXFZb-00000000500-0wm1;
	Sun, 21 Dec 2025 09:17:55 +0000
Date: Sun, 21 Dec 2025 10:17:31 +0100
From: kernel test robot <lkp@intel.com>
To: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: extend pci-stub to support explicit binding by PCI
 BUSID
Message-ID: <202512211037.B8KjEeeV-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Shlyakhov/pci-extend-pci-stub-to-support-explicit-binding-by-PCI-BUSID/20251219-211130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251219131038.21052-1-roman.shlyakhov.rs%40gmail.com
patch subject: [PATCH] pci: extend pci-stub to support explicit binding by PCI BUSID
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251221/202512211037.B8KjEeeV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211037.B8KjEeeV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211037.B8KjEeeV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/pci-stub.c:55 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Checking if the PCI device matches the BUSID list.
   Warning: drivers/pci/pci-stub.c:122 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Parsing a single BUSID.
   Warning: drivers/pci/pci-stub.c:148 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Parsing the "busid" kernel parameter.
   Warning: drivers/pci/pci-stub.c:207 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * early_param "pci_stub_busid" handler for the built-in module.
   Warning: drivers/pci/pci-stub.c:222 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Binding devices by BUSID via dynamic IDs.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

