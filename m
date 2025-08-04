Return-Path: <linux-pci+bounces-33338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A18CB196E6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 02:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661E01731E3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 00:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD023CB;
	Mon,  4 Aug 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arI/F6s0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4738D;
	Mon,  4 Aug 2025 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265945; cv=none; b=smWFqDIt8NsyGOhtHZ6sGYD6WVLvR2fmtpTV5dYy+plotTclVZ+DcaUSSkWjA+lbWtjYSKH9vrQmF+iW8482jBHS6XZz9j4QLVrjjotsYmurJUOzWS2hEPHLHgz1I9TDLStl+lhKbdwToPN9pqO5pBPNuiKpq1h0pX4mSoIIwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265945; c=relaxed/simple;
	bh=9KNKvPGAn/W7k7hCCGpLEmkYx8HoMwBR2BuHqnqD4Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWwwk5r6K3Tc251QTuCcQD00k/p9yGV5InRCW3CgRJbcGCO/HM8vqURihJNyNsPylF6lrKiIVVUd+q9qJBqIUc2Fx+R2C0hv+bYIuiIFjOFHalw0ByTc9ORiYGeqG+sIVbOSfho6tWk3mqtyY1BmLutfSbjKJp8oaYZ7QBpWDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arI/F6s0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754265943; x=1785801943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9KNKvPGAn/W7k7hCCGpLEmkYx8HoMwBR2BuHqnqD4Jc=;
  b=arI/F6s0WyZOBsSPWBh74heSfOVGbYG+9Pu6elFYKHd9//wwS87k0EN+
   DeNksDu5xZ76BqShr5U+VQ/thaEs3JzI7bdykIvwYo27xHPR7gwfhKJRZ
   XzfLOD0Wy4XKMNEQaJW0pq7Oc4kd09kogFhwUwljEW8X68sSBLCot/pTI
   jBcfni562gvTVVOKZk0AI26i1k6nld5INbsAWCpT5yG4THJO63ICEBWu2
   4PQVN6HbrfgIywm4fEwqkNCJNfBZ5z6fij954gSjRnFVUDaSO+fqOx8+r
   3iRftrt4zOi+AC7N4DWU/QrKcYQPun50OqLO8V2mztZ4uF5IBg2SA3WAx
   g==;
X-CSE-ConnectionGUID: Xs+11953TSayzf8gakm1FA==
X-CSE-MsgGUID: ZS2jd5ARTJqr0hxkK6OWQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="55573909"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="55573909"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 17:05:42 -0700
X-CSE-ConnectionGUID: SqTPPasQRUm79hJM7o9n4g==
X-CSE-MsgGUID: BfNupMSDSl6xzF4jpyegdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164410220"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Aug 2025 17:05:37 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiihq-0006gm-1T;
	Mon, 04 Aug 2025 00:05:34 +0000
Date: Mon, 4 Aug 2025 08:05:33 +0800
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
	linux-pci@vger.kernel.org, kernel-team@meta.com, osandov@fb.com,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <202508040737.rlDPN1um-lkp@intel.com>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>

Hi Breno,

kernel test robot noticed the following build errors:

[auto build test ERROR on 89748acdf226fd1a8775ff6fa2703f8412b286c8]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/vmcoreinfo-Track-and-log-recoverable-hardware-errors/20250801-211624
base:   89748acdf226fd1a8775ff6fa2703f8412b286c8
patch link:    https://lore.kernel.org/r/20250801-vmcore_hw_error-v4-1-fa1fe65edb83%40debian.org
patch subject: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
config: x86_64-randconfig-076-20250803 (https://download.01.org/0day-ci/archive/20250804/202508040737.rlDPN1um-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250804/202508040737.rlDPN1um-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508040737.rlDPN1um-lkp@intel.com/

All errors (new ones prefixed by >>):

>> vmlinux.o: error: objtool: hwerr_log_error_type+0x3b: call to ktime_get_real_seconds() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

