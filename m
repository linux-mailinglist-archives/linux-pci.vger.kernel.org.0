Return-Path: <linux-pci+bounces-34913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9C9B38227
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9061755B6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D23019B7;
	Wed, 27 Aug 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnK58qJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A62FE58D;
	Wed, 27 Aug 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297206; cv=none; b=ozSyZ7sL0h2K+drZ1My9d/WFgKElInMB2QXqQb1BAHh6ge5Pa94R3OGTpUgFG8CTZxlrzggigcYFi+byHekDLEGINix6J289yDFLHn+4NNCGPb2QPGiX97ImAwQgFElRRJS1OJ1yPB1Klso5stH2a/SGW3ti7z8IHhQ+cBlPMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297206; c=relaxed/simple;
	bh=2LKep4lVmfJNlIH3ZoIa7hAGGT+uLLtmS2NE+LCVfv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kexTa/OUdS6pG8xYLEdpKMqIeXQSQSQDtrhquQ5STwkHWYA1sNIGHrySJjFTo7rOunqjzZCQyMUiPqOkC8rSXiviOKjJDBwSseeVkTcMK1W999oqWup/a/se20aLIbEz2Ho230kmgZzDf4vQyBiCAkIY/TmG1aIQ0QjraFjEO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnK58qJ4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756297205; x=1787833205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2LKep4lVmfJNlIH3ZoIa7hAGGT+uLLtmS2NE+LCVfv8=;
  b=FnK58qJ4Xnkhqo6lt18gFI5ozzJdWGGdJLgZyJPXxpL9LICKAA8zSUwb
   y8Uaq0M2rjzOXTlZ3uaPbmqPCmjn9gCUup9vG624qs1BCh8yHa9Q2EuPI
   p2nPTiGN689uUtwZxgO1wPXrMSvifJN6aRskl7leQWBcfExS15Xj4gvmI
   oQoAhZgl3cUxDx/NJjNrxU00+Sgu24uYHfTY6cdfrzr1WkN3kq3DQ0R86
   wik8vVbTS+XE0DBmlq/TjMNBHZaJ6+Yvy3JsIYRMvDglCHnAgX34kNYiP
   DRdtdhTfK4int55cbPYOFb0cGacZUcJLbvXQMh4EfFOSckddIG0u0YGdl
   A==;
X-CSE-ConnectionGUID: F827tByvTb+nQi115nVZcg==
X-CSE-MsgGUID: K9aGx93sTGWYAp4ouk9yyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="68816696"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68816696"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 05:20:04 -0700
X-CSE-ConnectionGUID: CXFn0dugRYid9tFo+v8hyg==
X-CSE-MsgGUID: 25UMPQ2kRgGu/EjvkUAn8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="175095902"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Aug 2025 05:19:59 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urF89-000SwF-0b;
	Wed, 27 Aug 2025 12:19:57 +0000
Date: Wed, 27 Aug 2025 20:19:45 +0800
From: kernel test robot <lkp@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 20/23] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <202508271903.HTGgt8kV-lkp@intel.com>
References: <20250827013539.903682-21-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-21-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build errors:

[auto build test ERROR on f11a5f89910a7ae970fbce4fdc02d86a8ba8570f]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-Remove-ifdef-blocks-of-CONFIG_PCIEAER_CXL-from-core-pci-c/20250827-094257
base:   f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
patch link:    https://lore.kernel.org/r/20250827013539.903682-21-terry.bowman%40amd.com
patch subject: [PATCH v11 20/23] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
config: powerpc64-randconfig-002-20250827 (https://download.01.org/0day-ci/archive/20250827/202508271903.HTGgt8kV-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250827/202508271903.HTGgt8kV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508271903.HTGgt8kV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/eeh_driver.c:68:28: error: redefinition of 'pci_ers_merge_result'
      68 | static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
         |                            ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/kernel/eeh_driver.c:13:
   include/linux/pci.h:2767:32: note: previous definition of 'pci_ers_merge_result' with type 'pci_ers_result_t(enum pci_ers_result,  enum pci_ers_result)' {aka 'unsigned int(enum pci_ers_result,  enum pci_ers_result)'}
    2767 | static inline pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
         |                                ^~~~~~~~~~~~~~~~~~~~


vim +/pci_ers_merge_result +68 arch/powerpc/kernel/eeh_driver.c

20b344971433da Sam Bobroff 2018-05-25  67  
30424e386a30d1 Sam Bobroff 2018-05-25 @68  static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
30424e386a30d1 Sam Bobroff 2018-05-25  69  						enum pci_ers_result new)
30424e386a30d1 Sam Bobroff 2018-05-25  70  {
30424e386a30d1 Sam Bobroff 2018-05-25  71  	if (eeh_result_priority(new) > eeh_result_priority(old))
30424e386a30d1 Sam Bobroff 2018-05-25  72  		return new;
30424e386a30d1 Sam Bobroff 2018-05-25  73  	return old;
30424e386a30d1 Sam Bobroff 2018-05-25  74  }
30424e386a30d1 Sam Bobroff 2018-05-25  75  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

