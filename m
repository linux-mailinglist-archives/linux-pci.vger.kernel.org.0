Return-Path: <linux-pci+bounces-25141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE7A78AE6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14AA7A4BAF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243723371D;
	Wed,  2 Apr 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWDp5X7z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868261C8603;
	Wed,  2 Apr 2025 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585634; cv=none; b=k/JYPZlGnwoGAp99dWRXcjhvUWOKBMeeUo39Qv+pom6Zhm0rmKGoUNl0cb3gJi6u0Sfqmx2rY8F0TU14th3jcccUz256kz3uivFFWfB4IYSFONAIhIWDW5C5Amo2awn+n6QhlQvw91uYfBxkhB4/U4YfuRqd8OnqRsHZOc9X7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585634; c=relaxed/simple;
	bh=wPE7WwhGeI3LRwBB24cAH+qILm+nUf5fr4GrEUahx+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtDpQqHN04oGBNEJ0zBuVnL9cFNPpqJOmpVXYCYphb8Ix6eBAXiGYXGrFOco/KMixFrrBw+/T1cMCRdiWBNSuPlrQLK0gXIKrLn1YjuwMxRiAg5wQYJO5sQc+cI22Iq7i45kNyIhpM2pZ1n3Or8qCSn1iGQ0xt2JP6AwOZTgl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWDp5X7z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743585632; x=1775121632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPE7WwhGeI3LRwBB24cAH+qILm+nUf5fr4GrEUahx+c=;
  b=BWDp5X7zr2uJcHz3HHnS29va2xzxoUljXq7ZFPgShON6URtt+RejL7Rr
   5Kt2Rj1u/Gy5GZqWrpJP4NwO1LbL8CH/Yi+Pxzc7XYBuv5eQUjY1sQ5ko
   GJ+wyjlKaFyoX11jgjq2LafA/WKvRjWKz4XzlQLfINGxZNCdcH0hLkUeq
   PESgoHA37gYE9bh7PTXuyKWyLcgWT7qHHsjewuqPubdV7r0JHq/fCOi6E
   27tsxVJlU5B/oJXZrYbWEb41Wojc9A1xdHtqvMwKqhb2A/Ogyc6OTs4Wt
   osD1JM6xKlK0HpphBGORPkjOE5NmDCaOyBXuPjvUcuVTlDayyBi5a972u
   w==;
X-CSE-ConnectionGUID: WinA7UiTTbCsdFfDPKEVUA==
X-CSE-MsgGUID: ISUPeldrSQC7u7gw1ZaQLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="45083622"
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="45083622"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 02:20:31 -0700
X-CSE-ConnectionGUID: 7VV9JwBDQoauM69SpulY/g==
X-CSE-MsgGUID: amQFqQTIRhWsfkxk5mOAmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="127542263"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 02 Apr 2025 02:20:25 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tzuGk-000Ab0-0A;
	Wed, 02 Apr 2025 09:20:22 +0000
Date: Wed, 2 Apr 2025 17:19:55 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com,
	robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
Message-ID: <202504021623.LgnqoZPE-lkp@intel.com>
References: <20250402042020.48681-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402042020.48681-3-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on acb4f33713b9f6cadb6143f211714c343465411c]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Refactor-capability-search-into-common-macros/20250402-122544
base:   acb4f33713b9f6cadb6143f211714c343465411c
patch link:    https://lore.kernel.org/r/20250402042020.48681-3-18255117159%40163.com
patch subject: [v7 2/5] PCI: Refactor capability search functions to eliminate code duplication
config: loongarch-randconfig-001-20250402 (https://download.01.org/0day-ci/archive/20250402/202504021623.LgnqoZPE-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250402/202504021623.LgnqoZPE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504021623.LgnqoZPE-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pci.c: In function '__pci_find_next_ht_cap':
>> drivers/pci/pci.c:627:17: error: 'rc' undeclared (first use in this function); did you mean 'rq'?
     627 |                 rc = pci_read_config_byte(dev, pos + 3, &cap);
         |                 ^~
         |                 rq
   drivers/pci/pci.c:627:17: note: each undeclared identifier is reported only once for each function it appears in


vim +627 drivers/pci/pci.c

70c0923b0ef10b Jacob Keller     2020-03-02  614  
f646c2a0a6685a Puranjay Mohan   2020-11-29  615  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
687d5fe3dc3379 Michael Ellerman 2006-11-22  616  {
687d5fe3dc3379 Michael Ellerman 2006-11-22  617  	u8 cap, mask;
687d5fe3dc3379 Michael Ellerman 2006-11-22  618  
687d5fe3dc3379 Michael Ellerman 2006-11-22  619  	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
687d5fe3dc3379 Michael Ellerman 2006-11-22  620  		mask = HT_3BIT_CAP_MASK;
687d5fe3dc3379 Michael Ellerman 2006-11-22  621  	else
687d5fe3dc3379 Michael Ellerman 2006-11-22  622  		mask = HT_5BIT_CAP_MASK;
687d5fe3dc3379 Michael Ellerman 2006-11-22  623  
687d5fe3dc3379 Michael Ellerman 2006-11-22  624  	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
2675dfd086c109 Hans Zhang       2025-04-02  625  				      PCI_CAP_ID_HT);
687d5fe3dc3379 Michael Ellerman 2006-11-22  626  	while (pos) {
687d5fe3dc3379 Michael Ellerman 2006-11-22 @627  		rc = pci_read_config_byte(dev, pos + 3, &cap);
687d5fe3dc3379 Michael Ellerman 2006-11-22  628  		if (rc != PCIBIOS_SUCCESSFUL)
687d5fe3dc3379 Michael Ellerman 2006-11-22  629  			return 0;
687d5fe3dc3379 Michael Ellerman 2006-11-22  630  
687d5fe3dc3379 Michael Ellerman 2006-11-22  631  		if ((cap & mask) == ht_cap)
687d5fe3dc3379 Michael Ellerman 2006-11-22  632  			return pos;
687d5fe3dc3379 Michael Ellerman 2006-11-22  633  
47a4d5be7c50b2 Brice Goglin     2007-01-10  634  		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
47a4d5be7c50b2 Brice Goglin     2007-01-10  635  					      pos + PCI_CAP_LIST_NEXT,
2675dfd086c109 Hans Zhang       2025-04-02  636  					      PCI_CAP_ID_HT);
687d5fe3dc3379 Michael Ellerman 2006-11-22  637  	}
687d5fe3dc3379 Michael Ellerman 2006-11-22  638  
687d5fe3dc3379 Michael Ellerman 2006-11-22  639  	return 0;
687d5fe3dc3379 Michael Ellerman 2006-11-22  640  }
f646c2a0a6685a Puranjay Mohan   2020-11-29  641  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

