Return-Path: <linux-pci+bounces-24818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6155A72971
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 05:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986713BD8FF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 04:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93DC50276;
	Thu, 27 Mar 2025 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8JYseaq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380FD528;
	Thu, 27 Mar 2025 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743049184; cv=none; b=uacQfhXqxsROrsyXQZgyyhoPgZi8NH5CRkLsiVJ1vfFQMa00f8pTPltwVqbFL7yNRsvuQK4mlsC4oWgGl+9/bTcVOZdekVI6tszGY5EzjaWmpUIzRk0NszlJymscI+aiabERKVk2A5tLxE4rlaxPUS0q1dAniFXRBd5JuRy/k4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743049184; c=relaxed/simple;
	bh=Su3bdLMcybouxNZi1ddRJgjkw76FbhVIu5fJEwGvaNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsuyExxoZ6oJ19oDGk4lxyLyIjcm3gWATlWyVGHjHHcvc7TNz0/+T+sKxh7AMcMgobpbPB9OZmeArp3OjByJkIU5iqinl20fTD+4P76Ben++09hXtZTjMFLyvqnRUgIy864b4t8nXrMaeVFtCPn8i/6Bvc/X1gtRivsv30n4PKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8JYseaq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743049183; x=1774585183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Su3bdLMcybouxNZi1ddRJgjkw76FbhVIu5fJEwGvaNk=;
  b=V8JYseaqBH0GEFRJD8mnB2f3tsCIgQHQT0ONoq6CAHvuhQ/F5yT05s09
   29gdfN4G8YLoiEP8Xx3+PVx/aptaAlzcGlSRIT/3grc0dVIuWLf5x7NRg
   ni8uNN+zWhJGskeW+KYJC4UoJoQ+mnh0yHa44wzN2xCPCiN+Flv5Kir+b
   a2cuGXZdNLRUWj+WfjJwZYiLHJlz12ZMROBnpqFEV2XxuEA3MvT+AcLUN
   4u4+W2Fwema9oYrcYiXNxel4Vvj5qaVBBex6yv1OFv2++DHKJVyOJT3Yk
   7ftu5yUnJ/SsR5KhbxCsE84hwbdTI5enef/kFnx7Oi/gxrAWYkhrgOpTV
   w==;
X-CSE-ConnectionGUID: GesOcpt2T6SbynkQbuPVng==
X-CSE-MsgGUID: M+Q5dNsCSYy5y/JEVVhJ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47101414"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="47101414"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 21:19:42 -0700
X-CSE-ConnectionGUID: U/PonzexSUKeDIPx+yv1zA==
X-CSE-MsgGUID: 7iAryXGJTRaJiyK8/aTvMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="124951010"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Mar 2025 21:19:37 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txeiL-0006MZ-2Y;
	Thu, 27 Mar 2025 04:19:33 +0000
Date: Thu, 27 Mar 2025 12:19:33 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 06/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error 'recovery'
Message-ID: <202503271128.zMRuNISx-lkp@intel.com>
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
config: arm-mv78xx0_defconfig (https://download.01.org/0day-ci/archive/20250327/202503271128.zMRuNISx-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250327/202503271128.zMRuNISx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503271128.zMRuNISx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/access.c:2:
>> include/linux/pci.h:1873:6: warning: no previous prototype for function 'pci_aer_clear_fatal_status' [-Wmissing-prototypes]
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         |      ^
   include/linux/pci.h:1873:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         | ^
         | static 
   1 warning generated.
--
   In file included from drivers/pci/probe.c:9:
>> include/linux/pci.h:1873:6: warning: no previous prototype for function 'pci_aer_clear_fatal_status' [-Wmissing-prototypes]
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         |      ^
   include/linux/pci.h:1873:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         | ^
         | static 
   In file included from drivers/pci/probe.c:16:
   include/linux/aer.h:76:20: error: static declaration of 'pci_aer_clear_fatal_status' follows non-static declaration
      76 | static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
         |                    ^
   include/linux/pci.h:1873:6: note: previous definition is here
    1873 | void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
         |      ^
   1 warning and 1 error generated.


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

