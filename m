Return-Path: <linux-pci+bounces-19146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F859FF5BE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 04:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC751882BF6
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 03:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91414C13D;
	Thu,  2 Jan 2025 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQHZ3m33"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AA8F66;
	Thu,  2 Jan 2025 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735788408; cv=none; b=kFhgC6+XvLTE086O58mdK4JHP9NQ5ZS2kxpzvCZ5dDejg+NJHNBRiPFd1gpEPK0IOCSmNHLz1qZKVS1nRFlXbakJNJvRBfDwYsYRldre2GiiwpLARNCQbY1gS6tNa0hY1TQBNRwiC7wgbZ/MaeHznJLTGUpjzAmfuxH7i+uUXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735788408; c=relaxed/simple;
	bh=XVyFOZl09Q6eU2zZOwIxLT8jTLzQyjKmCvA8NtLUkrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T149j77taoANoLtq9U3ksOP5kCY5xfrKtoK+HaEDte0UynMJlFzMj5kB0bogt5P9qC/Gl5J37drWoTjmn5QJfFAV2jSBK3QREEh86Nm1yvscZ1O0TCuK52uHggS84kHwCLvLEwdzFuw1chehvkm5H/P4IBqrNAEJ2QHoXry0RcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQHZ3m33; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735788407; x=1767324407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVyFOZl09Q6eU2zZOwIxLT8jTLzQyjKmCvA8NtLUkrc=;
  b=ZQHZ3m33cbZSUZwWrff4/rQJ3xpMOAP1JJX+Wpc9gDTwCLLe0YIa9bd/
   KFc1DoAxgoNoO3ywELW+KR2sQMaeEaxZ3v1pEddt1OSNQjbmsGry40ekq
   feQNezqmUnmY1LGAN10I46KhIWVTZfhu8rvFvW8SSzv3xnrHLEyzQZWSX
   pkwkHhNVVXiyPRmvjEtOJvCo1nSlPlyzkpDgWoC4hPS+Hu0lYOLi0z6jt
   zkkBX6AxlzLoXB9UkZApAOkX30U0cyb90Ww7t7AXpIv9/2SUgfrN+nmTQ
   Gt/lPJfFAu2lT6G1eVK5yHZitKKi7ysYo1mmBW2UyYwmeY+qzaZPY2bOt
   A==;
X-CSE-ConnectionGUID: IIMn6es1TDuHeuw/GAOQzA==
X-CSE-MsgGUID: cs+F3ZlfS1ixCISvtMWdBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="38849894"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="38849894"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:26:46 -0800
X-CSE-ConnectionGUID: AcOt+Pg5QhK528Dg67kUgw==
X-CSE-MsgGUID: +Z/qB8gsSE++vsPNgOB9HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="101158453"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Jan 2025 19:26:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTBr7-0008DL-1z;
	Thu, 02 Jan 2025 03:26:41 +0000
Date: Thu, 2 Jan 2025 11:25:52 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, manivannan.sadhasivam@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, Hans Zhang <18255117159@163.com>,
	kernel test robot <lkp@intel.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v5] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <202501021000.7Cwcopot-lkp@intel.com>
References: <20250101151509.570341-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101151509.570341-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on ccb98ccef0e543c2bd4ef1a72270461957f3d8d0]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/misc-pci_endpoint_test-Fix-overflow-of-bar_size/20250101-232250
base:   ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
patch link:    https://lore.kernel.org/r/20250101151509.570341-1-18255117159%40163.com
patch subject: [v5] misc: pci_endpoint_test: Fix overflow of bar_size
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250102/202501021000.7Cwcopot-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250102/202501021000.7Cwcopot-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501021000.7Cwcopot-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/gpib/fmh_gpib/fmh_gpib.o
>> ERROR: modpost: "__udivmoddi4" [drivers/misc/pci_endpoint_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

