Return-Path: <linux-pci+bounces-19142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F69FF3E8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A95161E00
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 11:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCC1E0E0B;
	Wed,  1 Jan 2025 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhWs6OeI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFC13D531;
	Wed,  1 Jan 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735732259; cv=none; b=tVkQLqGGXo+nBFvazjNrhVO/SOUMel9IMmSc7mGBFjusJkwqcZDt1MIz0v/CZRgfE+hLzlpEe6DTOKuGoHTcpg0dnA+wgh51OUXs3gyyRPDzfMwkzmN5BUW082ADIusj7Ei8uvyCEi+dVsdmMNicoGUHO8r+bx1GmLcqZKPAnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735732259; c=relaxed/simple;
	bh=5aNhBXtzWbT1FnnCz4GGlFGR5F/n8mmquAdZ0YZV2cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhym0ZsmrO00PkaUDpVw0IFAWhLu9tTNF6wvCTbNJiKLpeBzxrtOo69vheA1kzJSxdOu0fcvMhjVT9fmZWtWvONc4F6FVt92tx0cs3ifT8AGA1agSjY4NY4D0HR+Oefj72bGBeS2oQLAdIu2sBoNOo71oUiDyrWx7bJrQojPsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhWs6OeI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735732258; x=1767268258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5aNhBXtzWbT1FnnCz4GGlFGR5F/n8mmquAdZ0YZV2cg=;
  b=EhWs6OeIxp2aj+nSXyZ7E7wdP940iD8jUMkDOKruX7LhmBUQB+hZEUYd
   br3GyC7u5/xNWiq3VEVhOe3uFSWFvMjtrE8/sdjaG7f8mrlpRydV2pgxL
   VqCVIKIpb5jbR6AR3Xzg+aSbpfPEUIC+S/dMIdtxP2Tk23IunpD0+IazE
   hjH6o4IKHGc8OrVR783MJeOfJeef+1yJd7KAXhyxAiCaHim9EYkZpmsxM
   09JJqTl+EpCtmCqNu5Tswy98CyiIia4LbzA/LKEng6uZVbqwv+HNm4dFO
   hCs3nWRxjSY9kHGrIj8fG/Xx124PMor+AQp8v/R7TbCEwr89HMqb9cr+a
   g==;
X-CSE-ConnectionGUID: WpJJo9hBRiOyd0cFhcgO/g==
X-CSE-MsgGUID: 1tspRJaGRku0OTDAjdQUyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36101855"
X-IronPort-AV: E=Sophos;i="6.12,282,1728975600"; 
   d="scan'208";a="36101855"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 03:50:58 -0800
X-CSE-ConnectionGUID: I2fowjemTauj7jX+mYxNZQ==
X-CSE-MsgGUID: 3j5Ho8OoR4ug9Jpeih6/3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101088075"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 01 Jan 2025 03:50:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tSxFU-0007mh-1A;
	Wed, 01 Jan 2025 11:50:52 +0000
Date: Wed, 1 Jan 2025 19:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, manivannan.sadhasivam@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v4] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <202501011917.ugP1ywJV-lkp@intel.com>
References: <20241231065500.168799-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231065500.168799-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next soc/for-next linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/misc-pci_endpoint_test-Fix-overflow-of-bar_size/20241231-145733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241231065500.168799-1-18255117159%40163.com
patch subject: [v4] misc: pci_endpoint_test: Fix overflow of bar_size
config: i386-randconfig-003-20250101 (https://download.01.org/0day-ci/archive/20250101/202501011917.ugP1ywJV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250101/202501011917.ugP1ywJV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501011917.ugP1ywJV-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/misc/pci_endpoint_test.o: in function `pci_endpoint_test_bar':
>> drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'


vim +315 drivers/misc/pci_endpoint_test.c

2a35703a6a00e8 Niklas Cassel          2024-03-22  282  
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  283  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  284  				  enum pci_barno barno)
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  285  {
2a35703a6a00e8 Niklas Cassel          2024-03-22  286  	void *write_buf __free(kfree) = NULL;
2a35703a6a00e8 Niklas Cassel          2024-03-22  287  	void *read_buf __free(kfree) = NULL;
cda370ec6d1f7b Kishon Vijay Abraham I 2017-08-18  288  	struct pci_dev *pdev = test->pdev;
bb17ee74a3494e Hans Zhang             2024-12-31  289  	int j, buf_size, iters, remain;
bb17ee74a3494e Hans Zhang             2024-12-31  290  	resource_size_t bar_size;
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  291  
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  292  	if (!test->bar[barno])
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  293  		return false;
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  294  
2a35703a6a00e8 Niklas Cassel          2024-03-22  295  	bar_size = pci_resource_len(pdev, barno);
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  296  
834b9051992580 Kishon Vijay Abraham I 2017-08-18  297  	if (barno == test->test_reg_bar)
2a35703a6a00e8 Niklas Cassel          2024-03-22  298  		bar_size = 0x4;
834b9051992580 Kishon Vijay Abraham I 2017-08-18  299  
2a35703a6a00e8 Niklas Cassel          2024-03-22  300  	/*
2a35703a6a00e8 Niklas Cassel          2024-03-22  301  	 * Allocate a buffer of max size 1MB, and reuse that buffer while
2a35703a6a00e8 Niklas Cassel          2024-03-22  302  	 * iterating over the whole BAR size (which might be much larger).
2a35703a6a00e8 Niklas Cassel          2024-03-22  303  	 */
2a35703a6a00e8 Niklas Cassel          2024-03-22  304  	buf_size = min(SZ_1M, bar_size);
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  305  
2a35703a6a00e8 Niklas Cassel          2024-03-22  306  	write_buf = kmalloc(buf_size, GFP_KERNEL);
2a35703a6a00e8 Niklas Cassel          2024-03-22  307  	if (!write_buf)
2a35703a6a00e8 Niklas Cassel          2024-03-22  308  		return false;
2a35703a6a00e8 Niklas Cassel          2024-03-22  309  
2a35703a6a00e8 Niklas Cassel          2024-03-22  310  	read_buf = kmalloc(buf_size, GFP_KERNEL);
2a35703a6a00e8 Niklas Cassel          2024-03-22  311  	if (!read_buf)
2a35703a6a00e8 Niklas Cassel          2024-03-22  312  		return false;
2a35703a6a00e8 Niklas Cassel          2024-03-22  313  
2a35703a6a00e8 Niklas Cassel          2024-03-22  314  	iters = bar_size / buf_size;
2a35703a6a00e8 Niklas Cassel          2024-03-22 @315  	for (j = 0; j < iters; j++)
2a35703a6a00e8 Niklas Cassel          2024-03-22  316  		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
2a35703a6a00e8 Niklas Cassel          2024-03-22  317  						 write_buf, read_buf, buf_size))
2a35703a6a00e8 Niklas Cassel          2024-03-22  318  			return false;
2a35703a6a00e8 Niklas Cassel          2024-03-22  319  
2a35703a6a00e8 Niklas Cassel          2024-03-22  320  	remain = bar_size % buf_size;
2a35703a6a00e8 Niklas Cassel          2024-03-22  321  	if (remain)
2a35703a6a00e8 Niklas Cassel          2024-03-22  322  		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
2a35703a6a00e8 Niklas Cassel          2024-03-22  323  						 write_buf, read_buf, remain))
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  324  			return false;
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  325  
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  326  	return true;
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  327  }
2c156ac71c6b25 Kishon Vijay Abraham I 2017-03-27  328  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

