Return-Path: <linux-pci+bounces-24817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7203BA7294F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 04:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827567A254C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 03:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0B3C463;
	Thu, 27 Mar 2025 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGAHCUXU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCC1805B;
	Thu, 27 Mar 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743046659; cv=none; b=Is7V3wXNKJRroye/O389pLWF8l5NEVNivZfjL1z+jyk2inLWF7zrqJbiuAmaropfOVatPT3tlfS3LiW81oprG2h3wOb2v9NL8AlR909jXtVcm0cTb7Uzbrd3MgtXULvPJDupPbAUS0lrosOtVFwVbgY1fPjlokeCW+nYjrcvCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743046659; c=relaxed/simple;
	bh=Vw6zOwv3qna6HIP+dTQI8DuR1ynag+boat1TIK89lxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG4soVkjuY9KaS5zjJc5rvUA1dKQ6xr97cvXQeGgzkTFCujmy3E1KDoZH9MD1m2t9IfgbZq82kZ7BSRfEBlfmqWGod1d10ajwDKzenqjViNI1Og5O7OjpCNuwcwgq/UFHbzWJFZ/jq12cxIO5SFPFm6iZH2DTO3+mggcOgOZL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGAHCUXU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743046658; x=1774582658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vw6zOwv3qna6HIP+dTQI8DuR1ynag+boat1TIK89lxs=;
  b=QGAHCUXUTgFYa6jPtI1WH4qK5WxXBaKrCxzQ7bRVK1VzfPQHU1GtIbvw
   n4LnsEHrgkJkQFK3qV+iL7foAiGGovjYpr4sYgSIAkacn7IEvL4BasIbV
   85nIFEmgzBROqlEn6zTbaPjg9AIrjlaKGiTTrpRVK6lfecp2AYMjimhj9
   B467MP/i8n5yOU8Rdj7VMipQRQFfhyz2KdAAqsruht57gvANhcC/X9qF3
   2o++bTPIzTnRjdYrUeFDsYD0YTqdHna4aLofnkcU+TLjb5e+E5tb8pdrh
   1qUXMci5gUZVuoxpl/B9Oq5rdjM1C1vYLXZKfHn/H++RWoOd2U4rqZh7j
   w==;
X-CSE-ConnectionGUID: aPwio6xvRxSgnMajWu1PCQ==
X-CSE-MsgGUID: 9El/IJzZSjSWL2TRXv7+CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66825340"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="66825340"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 20:37:37 -0700
X-CSE-ConnectionGUID: lTfYX2DoQ2er7a1mTLFMNg==
X-CSE-MsgGUID: GBwxuLjHSbSY0kAhcXWaUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="124977854"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Mar 2025 20:37:31 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txe3d-0006KN-0y;
	Thu, 27 Mar 2025 03:37:29 +0000
Date: Thu, 27 Mar 2025 11:37:21 +0800
From: kernel test robot <lkp@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	lukas@wunner.de, ming.li@zohomail.com,
	PradeepVineshReddy.Kodamati@amd.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 06/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error 'recovery'
Message-ID: <202503271130.BAWzwRWM-lkp@intel.com>
References: <20250327014717.2988633-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-7-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aae0594a7053c60b82621136257c8b648c67b512]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/PCI-CXL-Introduce-PCIe-helper-function-pcie_is_cxl/20250327-095738
base:   aae0594a7053c60b82621136257c8b648c67b512
patch link:    https://lore.kernel.org/r/20250327014717.2988633-7-terry.bowman%40amd.com
patch subject: [PATCH v8 06/16] CXL/PCI: Introduce CXL uncorrectable protocol error 'recovery'
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250327/202503271130.BAWzwRWM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250327/202503271130.BAWzwRWM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503271130.BAWzwRWM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/iomap.c:7:
>> include/linux/pci.h:1873:6: warning: no previous prototype for 'pci_aer_clear_fatal_status' [-Wmissing-prototypes]
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/probe.c:9:
>> include/linux/pci.h:1873:6: warning: no previous prototype for 'pci_aer_clear_fatal_status' [-Wmissing-prototypes]
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/probe.c:16:
   include/linux/aer.h:76:20: error: redefinition of 'pci_aer_clear_fatal_status'
      76 | static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/probe.c:9:
   include/linux/pci.h:1873:6: note: previous definition of 'pci_aer_clear_fatal_status' with type 'void(struct pci_dev *)'
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pci_aer_clear_fatal_status +1873 include/linux/pci.h

  1867	
  1868	#ifdef CONFIG_PCIEAER
  1869	bool pci_aer_available(void);
  1870	void pci_aer_clear_fatal_status(struct pci_dev *dev);
  1871	#else
  1872	static inline bool pci_aer_available(void) { return false; }
> 1873	void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
  1874	#endif
  1875	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

