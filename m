Return-Path: <linux-pci+bounces-28358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7E1AC2B67
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 23:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2238BA43697
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A5620B801;
	Fri, 23 May 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZI9Eq5i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07A1E2602;
	Fri, 23 May 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036020; cv=none; b=RePN52jvwvpihelmOuaYTtuBmGP9X+ltL73dy8uJ8w29Ngi/rT/IpAWkaKg1MuYT54ynpbMcSxiGytL6EPKxNGXHFHllGgPjN/sIwlLJi7XUk9R5pjiasgSu3qRclTRrUtQILtWwo3wyI6z6Rl57NppFcoNnxjPa2V6cwMpEy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036020; c=relaxed/simple;
	bh=sm8mw8DhfqY+1KlR3no0+z64hdItrfdVOkj9hlVT2Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIdftZKf1iWwEVCHXRQmtD3/+06e7nRls42bpf8N42qUFga3j7FiPT2WycFqIsfhIFQiSdRwSR+FbktZ+xLhlHNZh4XDm1je1ItEH8zPzXUkgM4s1bIetBsRxXakgPbGAeqMiVyl3Za3vKd33M6mhAFaRSBWwFrs+z6DkdIoPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZI9Eq5i; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748036019; x=1779572019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sm8mw8DhfqY+1KlR3no0+z64hdItrfdVOkj9hlVT2Mc=;
  b=VZI9Eq5iPAIHj2FuuIR1MBUzlBTMBqtcx+kI3m7TtWCybbUNseocza/C
   cvKg4b2jkS1F/5Un4cPLMabJlkh6z/mvmwhjErucgGpAw6uuwZqEH8MV+
   apxXa+jOAg1NAUhgnzlaXaQOcZ4pqy4R9TNimFo/Fm0jUyJwgOPqFXT+8
   QuYQE7vMuETN9Vk3QYvugXvBdMKcWZSI8haXzQGzFJmMC/2BhFQWbTs6T
   7RoQWdPRvvD9VOilfxr+Laik7cAXOOtD14ljkdAey+dc5C+DzFf28jwDB
   zpkTFV/a/vCSUUoIJw9Ph0DQDax2Mcdw17dwNIQY1RMvr1uVPGVEO+lh2
   Q==;
X-CSE-ConnectionGUID: 589RGN2cTe2wix6jl3Kovw==
X-CSE-MsgGUID: uKf2neMkSo+opa2txzx2tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49354665"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49354665"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 14:33:38 -0700
X-CSE-ConnectionGUID: 17/+h9EMQc+nneemEVveSA==
X-CSE-MsgGUID: 3jNwTZ+nSMOcgwIt04d4jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="178422381"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 May 2025 14:33:34 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIa1E-000QkK-18;
	Fri, 23 May 2025 21:33:32 +0000
Date: Sat, 24 May 2025 05:33:30 +0800
From: kernel test robot <lkp@intel.com>
To: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Subject: Re: [PATCH v3 06/11] drm/xe/vrsr: Initialize VRSR feature
Message-ID: <202505240511.h1zy992X-lkp@intel.com>
References: <20250523190155.2623462-7-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523190155.2623462-7-badal.nilawar@intel.com>

Hi Badal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on next-20250523]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge pci/next pci/for-linus linus/master v6.15-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Badal-Nilawar/PCI-ACPI-Add-D3cold-Aux-Power-Limit_DSM-method/20250524-030125
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20250523190155.2623462-7-badal.nilawar%40intel.com
patch subject: [PATCH v3 06/11] drm/xe/vrsr: Initialize VRSR feature
config: arm-randconfig-002-20250524 (https://download.01.org/0day-ci/archive/20250524/202505240511.h1zy992X-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505240511.h1zy992X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505240511.h1zy992X-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/xe/xe_device_types.h:10:0,
                    from drivers/gpu/drm/xe/xe_bo_types.h:16,
                    from drivers/gpu/drm/xe/xe_bo.h:11,
                    from drivers/gpu/drm/xe/xe_query.c:17:
>> include/linux/pci-acpi.h:149:12: warning: 'pci_acpi_add_perst_assertion_delay' defined but not used [-Wunused-function]
    static int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/pci-acpi.h:143:12: warning: 'pci_acpi_request_d3cold_aux_power' defined but not used [-Wunused-function]
    static int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pci_acpi_add_perst_assertion_delay +149 include/linux/pci-acpi.h

ac1c8e35a3262d Kuppuswamy Sathyanarayanan 2020-03-23  134  
59dc33252ee777 Rafael J. Wysocki          2021-08-24  135  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
59dc33252ee777 Rafael J. Wysocki          2021-08-24  136  void pci_acpi_clear_companion_lookup_hook(void);
004b1d6651d930 Anshuman Gupta             2025-05-24  137  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
004b1d6651d930 Anshuman Gupta             2025-05-24  138  				      u32 *retry_interval);
57059451b12af0 Anshuman Gupta             2025-05-24  139  int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
5090d4a6a1f150 Jiang Liu                  2013-04-12  140  #else	/* CONFIG_ACPI */
5090d4a6a1f150 Jiang Liu                  2013-04-12  141  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
5090d4a6a1f150 Jiang Liu                  2013-04-12  142  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
004b1d6651d930 Anshuman Gupta             2025-05-24 @143  static int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
004b1d6651d930 Anshuman Gupta             2025-05-24  144  					     u32 *retry_interval)
004b1d6651d930 Anshuman Gupta             2025-05-24  145  {
004b1d6651d930 Anshuman Gupta             2025-05-24  146  	return -EOPNOTSUPP;
004b1d6651d930 Anshuman Gupta             2025-05-24  147  }
57059451b12af0 Anshuman Gupta             2025-05-24  148  
57059451b12af0 Anshuman Gupta             2025-05-24 @149  static int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
57059451b12af0 Anshuman Gupta             2025-05-24  150  {
57059451b12af0 Anshuman Gupta             2025-05-24  151  	return -EOPNOTSUPP;
57059451b12af0 Anshuman Gupta             2025-05-24  152  }
5090d4a6a1f150 Jiang Liu                  2013-04-12  153  #endif	/* CONFIG_ACPI */
^1da177e4c3f41 Linus Torvalds             2005-04-16  154  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

