Return-Path: <linux-pci+bounces-27624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B5AB4DA3
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7913F188D606
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2021F583D;
	Tue, 13 May 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fa8ngPoF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E81F4CBF;
	Tue, 13 May 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123593; cv=none; b=mocM+n2f2TmvPFxLIrtczmISbfiSt/wVLBogI3Ll8BEzA7rzYPy0ulyVO/qzbmfdaaM4aMLUVIOOrftyBxL1Si98WgCabYLMS7+XF+81HxmptlfF8yiAsUXBbGUdgyHs2qsMpNMy0o+8oaOexiSValUyJw3XFv/UOxy8dqul3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123593; c=relaxed/simple;
	bh=A1nArDmix8VnHspbPBbLzihDOlnHf6XdIBJkt+Vu7OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z612Deob2N+e3YZyQ6lHR6aT259cG65ETB1LvRymF/DYHq5w2zLLPnKev3bgeEv2hKc6LUWBpUnuS/f8eFgtrWUMKRs2nomFEupSmy40gt+7NL+88RjAB0rTD46V3Oa5/zj+HvahyPTjaXbt05ioO0iB9aYxr3FGOdRIczYAfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fa8ngPoF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747123591; x=1778659591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A1nArDmix8VnHspbPBbLzihDOlnHf6XdIBJkt+Vu7OY=;
  b=fa8ngPoFH6RcjbsXZeaeok5Csmsjpy3uFnlnElGA6J8ZT7rRrqoIMRln
   ocwT02oJEEtrnLMFOQL2rkrBSZmN034Dn050BIIxWbuibaNNXAzPWYuNY
   5brFxzD520ez3xGCmDDE48KgnpKf6q20rT6x0M+SnU20WheYTdiKb0QLt
   f7Pc4yyE4/EWh95W46uwZ2jBCUJDAsbJ9hIG32CusM53YzoIsZ/t7OGXA
   4d1SJQHaFZSbO1fUh+/cBJDo02s9M0GavahdM2jWvs6oSxynJ1oFLE6sU
   OLPzByoob+5Jz77T3znq9umQeZ0qZ3wQaOBiT4RI16PV3X1nieOaRGVxo
   g==;
X-CSE-ConnectionGUID: Sqnmq+LGSduvwREuK6qUyQ==
X-CSE-MsgGUID: IOtb6iY1TfS2bsM579jiqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="51614692"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="51614692"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 01:06:30 -0700
X-CSE-ConnectionGUID: RKzMWmG2RD2p1tY7hHg7uw==
X-CSE-MsgGUID: 5CKr23GwQ3amUquuyxkQ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138039043"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 May 2025 01:06:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEkef-000Fqt-2P;
	Tue, 13 May 2025 08:06:25 +0000
Date: Tue, 13 May 2025 16:06:21 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com, kw@linux.com
Cc: oe-kbuild-all@lists.linux.dev, cassel@kernel.org, robh@kernel.org,
	jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v11 5/6] PCI: cadence: Use common PCI host bridge APIs
 for finding the capabilities
Message-ID: <202505131520.uEv4I92o-lkp@intel.com>
References: <20250505163420.198012-6-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505163420.198012-6-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on ca91b9500108d4cf083a635c2e11c884d5dd20ea]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-bus-config-read-helper-function/20250506-004221
base:   ca91b9500108d4cf083a635c2e11c884d5dd20ea
patch link:    https://lore.kernel.org/r/20250505163420.198012-6-18255117159%40163.com
patch subject: [PATCH v11 5/6] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
config: csky-randconfig-001-20250513 (https://download.01.org/0day-ci/archive/20250513/202505131520.uEv4I92o-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505131520.uEv4I92o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505131520.uEv4I92o-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/cadence/pcie-cadence.c:10:
   drivers/pci/controller/cadence/pcie-cadence.c: In function 'cdns_pcie_find_capability':
>> drivers/pci/controller/cadence/../../pci.h:125:24: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     125 |                 __id = FIELD_GET(PCI_CAP_ID_MASK, __ent);               \
         |                        ^~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence.c:28:16: note: in expansion of macro 'PCI_FIND_NEXT_CAP_TTL'
      28 |         return PCI_FIND_NEXT_CAP_TTL(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
         |                ^~~~~~~~~~~~~~~~~~~~~


vim +/FIELD_GET +125 drivers/pci/controller/cadence/../../pci.h

343e51ae6e3f64 Jacob Keller      2013-07-31   88  
7a1562d4f2d017 Yinghai Lu        2014-11-11   89  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
503fa23614dc95 Maciej W. Rozycki 2022-09-17   90  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
af65d1ad416bc6 Patel, Mayurkumar 2019-10-18   91  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
5f06abead7cb8c Hans Zhang        2025-05-06   92  int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
5f06abead7cb8c Hans Zhang        2025-05-06   93  			u32 *val);
7a1562d4f2d017 Yinghai Lu        2014-11-11   94  
db69afa296b68c Hans Zhang        2025-05-06   95  /* Standard Capability finder */
db69afa296b68c Hans Zhang        2025-05-06   96  /**
db69afa296b68c Hans Zhang        2025-05-06   97   * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
db69afa296b68c Hans Zhang        2025-05-06   98   * @read_cfg: Function pointer for reading PCI config space
db69afa296b68c Hans Zhang        2025-05-06   99   * @start: Starting position to begin search
db69afa296b68c Hans Zhang        2025-05-06  100   * @cap: Capability ID to find
db69afa296b68c Hans Zhang        2025-05-06  101   * @args: Arguments to pass to read_cfg function
db69afa296b68c Hans Zhang        2025-05-06  102   *
db69afa296b68c Hans Zhang        2025-05-06  103   * Iterates through the capability list in PCI config space to find
db69afa296b68c Hans Zhang        2025-05-06  104   * the specified capability. Implements TTL (time-to-live) protection
db69afa296b68c Hans Zhang        2025-05-06  105   * against infinite loops.
db69afa296b68c Hans Zhang        2025-05-06  106   *
db69afa296b68c Hans Zhang        2025-05-06  107   * Returns: Position of the capability if found, 0 otherwise.
db69afa296b68c Hans Zhang        2025-05-06  108   */
db69afa296b68c Hans Zhang        2025-05-06  109  #define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
db69afa296b68c Hans Zhang        2025-05-06  110  ({									\
db69afa296b68c Hans Zhang        2025-05-06  111  	int __ttl = PCI_FIND_CAP_TTL;					\
db69afa296b68c Hans Zhang        2025-05-06  112  	u8 __id, __found_pos = 0;					\
db69afa296b68c Hans Zhang        2025-05-06  113  	u8 __pos = (start);						\
db69afa296b68c Hans Zhang        2025-05-06  114  	u16 __ent;							\
db69afa296b68c Hans Zhang        2025-05-06  115  									\
db69afa296b68c Hans Zhang        2025-05-06  116  	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
db69afa296b68c Hans Zhang        2025-05-06  117  									\
db69afa296b68c Hans Zhang        2025-05-06  118  	while (__ttl--) {						\
db69afa296b68c Hans Zhang        2025-05-06  119  		if (__pos < PCI_STD_HEADER_SIZEOF)			\
db69afa296b68c Hans Zhang        2025-05-06  120  			break;						\
db69afa296b68c Hans Zhang        2025-05-06  121  									\
db69afa296b68c Hans Zhang        2025-05-06  122  		__pos = ALIGN_DOWN(__pos, 4);				\
db69afa296b68c Hans Zhang        2025-05-06  123  		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
db69afa296b68c Hans Zhang        2025-05-06  124  									\
db69afa296b68c Hans Zhang        2025-05-06 @125  		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
db69afa296b68c Hans Zhang        2025-05-06  126  		if (__id == 0xff)					\
db69afa296b68c Hans Zhang        2025-05-06  127  			break;						\
db69afa296b68c Hans Zhang        2025-05-06  128  									\
db69afa296b68c Hans Zhang        2025-05-06  129  		if (__id == (cap)) {					\
db69afa296b68c Hans Zhang        2025-05-06  130  			__found_pos = __pos;				\
db69afa296b68c Hans Zhang        2025-05-06  131  			break;						\
db69afa296b68c Hans Zhang        2025-05-06  132  		}							\
db69afa296b68c Hans Zhang        2025-05-06  133  									\
db69afa296b68c Hans Zhang        2025-05-06  134  		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
db69afa296b68c Hans Zhang        2025-05-06  135  	}								\
db69afa296b68c Hans Zhang        2025-05-06  136  	__found_pos;							\
db69afa296b68c Hans Zhang        2025-05-06  137  })
db69afa296b68c Hans Zhang        2025-05-06  138  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

