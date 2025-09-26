Return-Path: <linux-pci+bounces-37117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BDBA4D97
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9FC18931F9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B2277807;
	Fri, 26 Sep 2025 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwEHATXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435826ADD;
	Fri, 26 Sep 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910308; cv=none; b=djsbpsfBtuX7Z2Wprp6AAIDA3dBvAZzyySboDi0/a9GQ/hCkhwAnfDr/drgmv5uZt+FpgUbmwtIWYpbrhZ1h/OJzdY0vLVMKx+99to7uRlaLCJDuqAx3/W6P0MX/X+i+RqDD5WpfDuwcwM5XNzxIqmTCkY7a6vNZJ+QUD+WplcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910308; c=relaxed/simple;
	bh=6YcsbRUDVjvq90+XUsFM49RpOjc9gYPwErAKkZrcQYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU9GsVGfGl3dRabMSoaxWjzoMezrExri4QUlfWQfH/RcoHlw928h+rethxPcNh2BrSDZm6TdIbwUj+bQcoO6iFukJWBDNP6Mwd7GF7RWhgGagsYCEWOHzO7LDvj80OGqEJ2VmWzv+uqCpn1R2EyZQrawUA4R+YpSf4gBGEJbfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwEHATXi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758910307; x=1790446307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6YcsbRUDVjvq90+XUsFM49RpOjc9gYPwErAKkZrcQYM=;
  b=SwEHATXi1Ez58+mLU4c/3gOL9lCuV6LUdwpmDe03g8zTKvDit4Id/XVu
   xfVS1gt3jYM44/Ci8RvOjmPM90/r0BiJ7mtHtAzV8N7+jHChflUQM3ZMl
   3egfUC/G3lu8swaP2RorDYy3EwFlaYZvK6TwqRdSe/Oq9iTzHjrnNbEhH
   mgPUCek0MzHgbrxSRKVG6DFMUUgWar06XwvdFlLShV2gdlzXhnqwb/GWK
   L9NBImxxd+akJC/Jia6lE4zzy1dtsk0jI4TNuMOyY5hpP+Xv5dkBFSjUL
   jz1DMt6H0r9nyg1XVKX+S3fbVYTG9JNlv+sgRFDiPJPn1TxFeGDdNi5oj
   g==;
X-CSE-ConnectionGUID: ibDvskkkReWo/MSP07Xwkw==
X-CSE-MsgGUID: /NbPAI27RBe8+vAiZWgWag==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61139391"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61139391"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 11:11:47 -0700
X-CSE-ConnectionGUID: SYiM7HY/RyymKO/bcCngbg==
X-CSE-MsgGUID: JoNP3XxBQKiatP6zgF2zcQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 26 Sep 2025 11:11:42 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2CuS-0006Ud-0o;
	Fri, 26 Sep 2025 18:11:16 +0000
Date: Sat, 27 Sep 2025 02:10:42 +0800
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
	linux-pci@vger.kernel.org, terry.bowman@amd.com
Subject: Re: [PATCH v12 22/25] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <202509270131.UIdODBaV-lkp@intel.com>
References: <20250925223440.3539069-23-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925223440.3539069-23-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 46037455cbb748c5e85071c95f2244e81986eb58]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Remove-unnecessary-CXL-Endpoint-handling-helper-functions/20250926-064816
base:   46037455cbb748c5e85071c95f2244e81986eb58
patch link:    https://lore.kernel.org/r/20250925223440.3539069-23-terry.bowman%40amd.com
patch subject: [PATCH v12 22/25] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20250927/202509270131.UIdODBaV-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509270131.UIdODBaV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509270131.UIdODBaV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/kernel/eeh_driver.c:68:28: warning: conflicting types for 'pci_ers_merge_result' due to enum/integer mismatch; have 'enum pci_ers_result(enum pci_ers_result,  enum pci_ers_result)' [-Wenum-int-mismatch]
      68 | static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
         |                            ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/eeh_driver.c:68:28: error: static declaration of 'pci_ers_merge_result' follows non-static declaration
   In file included from arch/powerpc/kernel/eeh_driver.c:13:
   include/linux/pci.h:1897:18: note: previous declaration of 'pci_ers_merge_result' with type 'pci_ers_result_t(enum pci_ers_result,  enum pci_ers_result)' {aka 'unsigned int(enum pci_ers_result,  enum pci_ers_result)'}
    1897 | pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
         |                  ^~~~~~~~~~~~~~~~~~~~


vim +68 arch/powerpc/kernel/eeh_driver.c

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

