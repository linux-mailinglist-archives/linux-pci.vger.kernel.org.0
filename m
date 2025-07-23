Return-Path: <linux-pci+bounces-32819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD80B0F546
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6828554768C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6EB2EF676;
	Wed, 23 Jul 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjM8tild"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E1433A6;
	Wed, 23 Jul 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280968; cv=none; b=u3d+VwrcEbUxQo9j1HTk3gTrMkN1hRbztCECVl3cCoL9j2etPznHSyHa4OqATMRE7DtR65ZgeD4vnXCC5inCaQnb+IcQg4a0Gczp8UB/vQ7wdf4JhM9X8bRsb9wevvVXVScxEfD2vBRakseY2EZ/9/JroqGEvr1uXFpLqJcUvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280968; c=relaxed/simple;
	bh=JnPfz05COLFbrti4eA0oit4iSLVZ3XvOremqEbmexSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH/3G9aImvnRFstvLjFDVPZQ/XVi1yW0EtlNWalN4iESPwoRIx/JAtMnRuEYHr2DPRqVcSUZEGU57lmtQcvPwIPP1mrMH9W06J8Lb95YF5HVM2zk3bYi9L/WJp1mGs/IkejYIl3FuIBbGfbNf3/0MkV5ZZsQKOh3wsnRypVv50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjM8tild; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753280967; x=1784816967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnPfz05COLFbrti4eA0oit4iSLVZ3XvOremqEbmexSk=;
  b=JjM8tildqKRdGU+ADVYHW+mOMr9p/te3fMCwzPvfyPp1NXLk6NLdjMb8
   z9GLBn367lEZjkO0/5a468HPqLfxNkSWvlzC6+E5b1CEu1kkYaJ83F/2k
   yLQsVbE6Y+6CJwcRC9FiQLfsDeN9jUbY49eiycaSxKNbsIyl2hkI8j+eF
   qrS0dnDtJ+bqU8Vo6RvZCnvCehSRtvv8b5T/T7pRWuDB9866WGjPkSD1I
   jlmADsLUkVwylXgTQ71RCZVp/UisXD2lxigGr2Cszp51KwfRT2aqt/hAg
   dye6sddHElwghIKdaM0pgoBtuMJ9OKePWHCiDelkplG2vfnJr1USdS6u8
   A==;
X-CSE-ConnectionGUID: GYC6BE01ThCrDgc7rwTulw==
X-CSE-MsgGUID: tEM0QZ0HSuKd681BcpvO5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58180465"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="58180465"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:29:26 -0700
X-CSE-ConnectionGUID: bLMBwyrWRkeAJvKC8iopDQ==
X-CSE-MsgGUID: UZkMCzLeRXqiwiq1mUGeIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159562699"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Jul 2025 07:29:21 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueaT8-000JRD-1n;
	Wed, 23 Jul 2025 14:29:18 +0000
Date: Wed, 23 Jul 2025 22:28:29 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, osandov@osandov.com,
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, kernel-team@meta.com,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <202507232209.GrgpSr47-lkp@intel.com>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>

Hi Breno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 97987520025658f30bb787a99ffbd9bbff9ffc9d]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/vmcoreinfo-Track-and-log-recoverable-hardware-errors/20250723-005950
base:   97987520025658f30bb787a99ffbd9bbff9ffc9d
patch link:    https://lore.kernel.org/r/20250722-vmcore_hw_error-v3-1-ff0683fc1f17%40debian.org
patch subject: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
config: x86_64-buildonly-randconfig-001-20250723 (https://download.01.org/0day-ci/archive/20250723/202507232209.GrgpSr47-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507232209.GrgpSr47-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507232209.GrgpSr47-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: do_machine_check+0x5cc: call to hwerr_log_error_type() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

