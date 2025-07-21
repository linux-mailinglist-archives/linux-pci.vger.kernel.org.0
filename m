Return-Path: <linux-pci+bounces-32669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED195B0C8AD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72DB162E2D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC72E0B45;
	Mon, 21 Jul 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0N8KIng"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3C2E093F;
	Mon, 21 Jul 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115098; cv=none; b=BJM/Itn6dJ7UxRUa58duj83eeZUdEhEakY7ZRiWmHxjBgbfCYEJ29SLq/5yX3iK6+EfG/2t1fBZ28m9vhpbYJBxsRuoV0K4H3UKgo2kE7lrvm7S/yI1hoSREW4H229H64bXWglHEqXuJ2zWpMHgQZE8aJTipXBT8TJp2tRt8kpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115098; c=relaxed/simple;
	bh=Y0c8fyTNCDbBI1ib06Eg9UDIUghtCzMuq8qbf2t/k5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf3j7S1b9ph2BQHlxi+rOtGRkPvyaeEtbcpY38VR1SgdAgiUjJBXb3Zz0i0BTXuaBMZaK3FrhSVcU2yaGiQbnC14yujM6YapjNKfONcgZCP7+KM7gAqgZn6ja4qSncYj4PcJ1rwbjsnC7H7uikhR7GkHTOzhjtyBgJUrlkcWLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0N8KIng; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753115097; x=1784651097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y0c8fyTNCDbBI1ib06Eg9UDIUghtCzMuq8qbf2t/k5w=;
  b=I0N8KIng0drH2AyEy2zklWBPTdbm//+e0uM5oHYx5Cal8Jw3+cDPZvWY
   lwrQ7dgUFrmD4mLHANl2fEAk+XZodaqvHVaAm07NnayIW8jQs2asFojd/
   lYzAnvk++G69LRW8LqHyPyg4NMMV07zBiXFreTtmuX+tpVGnlEECxsvWR
   TofXtuIvHen3AVThmU9V3XQaDRXTPdqIv19z4yDb+ZfIZa9KHjr+aF1yT
   wS5c4Jz1OhWxdssH4mzGOFmwdJiuhAjIcxkspe/Hw92ZiX8QnTgRKQ1tI
   m4HyauRyfDTvE7RDxqWKD4U411pKijmhJwXRTGCykZjUOx9vhFXr5LlKd
   Q==;
X-CSE-ConnectionGUID: RaKZtsdBRkWdEuS5bBUoig==
X-CSE-MsgGUID: MXo5+SD7TjGwhcEfKGBqfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72791487"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="72791487"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 09:24:56 -0700
X-CSE-ConnectionGUID: /80dSFaRRlanM/T6SY8zFw==
X-CSE-MsgGUID: l0qUhxBCQz+Cpzl2V+Cj2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158184620"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2025 09:24:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udtJn-000GyP-0h;
	Mon, 21 Jul 2025 16:24:47 +0000
Date: Tue, 22 Jul 2025 00:24:42 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	osandov@osandov.com, xueshuai@linux.alibaba.com,
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	kernel-team@meta.com, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <202507220057.iVSR8aqd-lkp@intel.com>
References: <20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org>

Hi Breno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 97987520025658f30bb787a99ffbd9bbff9ffc9d]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/vmcoreinfo-Track-and-log-recoverable-hardware-errors/20250721-181439
base:   97987520025658f30bb787a99ffbd9bbff9ffc9d
patch link:    https://lore.kernel.org/r/20250721-vmcore_hw_error-v2-1-ab65a6b43c5a%40debian.org
patch subject: [PATCH v2] vmcoreinfo: Track and log recoverable hardware errors
config: i386-buildonly-randconfig-001-20250721 (https://download.01.org/0day-ci/archive/20250722/202507220057.iVSR8aqd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250722/202507220057.iVSR8aqd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507220057.iVSR8aqd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from init/initramfs.c:603:
   In file included from include/linux/kexec.h:18:
>> include/linux/vmcore_info.h:91:6: warning: no previous prototype for function 'hwerror_tracking_log' [-Wmissing-prototypes]
      91 | void hwerror_tracking_log(enum hwerror_tracking_source src) {};
         |      ^
   include/linux/vmcore_info.h:91:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      91 | void hwerror_tracking_log(enum hwerror_tracking_source src) {};
         | ^
         | static 
   1 warning generated.


vim +/hwerror_tracking_log +91 include/linux/vmcore_info.h

    87	
    88	#ifdef CONFIG_VMCORE_INFO
    89	void hwerror_tracking_log(enum hwerror_tracking_source src);
    90	#else
  > 91	void hwerror_tracking_log(enum hwerror_tracking_source src) {};
    92	#endif
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

