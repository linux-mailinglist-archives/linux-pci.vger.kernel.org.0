Return-Path: <linux-pci+bounces-37106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33AFBA4550
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 17:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9267429B6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA41F4192;
	Fri, 26 Sep 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QszQ/dXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692241E9B19;
	Fri, 26 Sep 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898956; cv=none; b=Kg7jYcXDkNrlVi3+QNfLNUq0qUp/jBCrF2Yd1Tnb8Zay5nsKM2hSO1PmW68UvwDBDB2GJYPbnI2bJFZKqCceiYlkfd6Y7jIZyJ3wGJN4yBf8QTw9QpWqfseVxglz40Im9m8BgPynkq4IoG+yuUy+e6nQjhy1AjtqrATnmRzEw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898956; c=relaxed/simple;
	bh=Ga4EFSKFDnAp35hTckCUWbH8Huu5AT0Xny1M6QQUPMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9J8OrG4zBI4N+aYKlLr1DWDE84BxoLIlGHbqA0an2ugaZ8YG4wCb77Otuad7/HAtHQGBvIN8UzmUZahKPcr5FlHpI30AacuTQ+vJ7UUf30uRZZPeHeeVfBCkT4CDgmE3ufVM/DptaypT/rkJWV5pJdsEqLmkn0KHj2AFUOSFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QszQ/dXw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758898955; x=1790434955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ga4EFSKFDnAp35hTckCUWbH8Huu5AT0Xny1M6QQUPMg=;
  b=QszQ/dXwcjNcIjq/s4AZ1QQxG8hJmQxXfgbrmkIzEGiBJkDY6WLi2Es4
   UGhFbf/9oI5L+5wROYlVuUhRBxhWxAQgMXq02ntxQ6A3zAlY7euVwJQQd
   cdEzDLVM41sGt6yD8WxuzHVgWLz49gLpbLwgwwiM1Yy2UIx37Bd75EwER
   DPJH1YwOVjObA1KN17VYtQyR9SMST0pvyT7mbBHD1sp8oStlATtG2d20v
   tBOgQn4vmNP0YwmaVm3pduYk02djRwHVfmOhdpoejBYs1v0y0LhPY5Xqq
   fus9JL7Fcm4TzAON5mUwthwxOZxcMlMXlc81KxsJ5+xS1WvESdbJKxsRP
   Q==;
X-CSE-ConnectionGUID: a5W1KDb3RD6CP7EqCwj7+Q==
X-CSE-MsgGUID: V4uVxzN3R5iSDWE7dq/opg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60933699"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="60933699"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 08:02:33 -0700
X-CSE-ConnectionGUID: jCmqE4f8RoSf2AdUpdshOA==
X-CSE-MsgGUID: x3/ZrHUYT56f+Pu8eFSbqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177563999"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 26 Sep 2025 08:02:27 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v29xh-0006Kx-06;
	Fri, 26 Sep 2025 15:02:20 +0000
Date: Fri, 26 Sep 2025 23:01:28 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	terry.bowman@amd.com
Subject: Re: [PATCH v12 22/25] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <202509262230.gXBVTVxW-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 46037455cbb748c5e85071c95f2244e81986eb58]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Remove-unnecessary-CXL-Endpoint-handling-helper-functions/20250926-064816
base:   46037455cbb748c5e85071c95f2244e81986eb58
patch link:    https://lore.kernel.org/r/20250925223440.3539069-23-terry.bowman%40amd.com
patch subject: [PATCH v12 22/25] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
config: powerpc64-randconfig-002-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262230.gXBVTVxW-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262230.gXBVTVxW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262230.gXBVTVxW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/eeh_driver.c:68:28: error: static declaration of 'pci_ers_merge_result' follows non-static declaration
   static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
                              ^
   include/linux/pci.h:1897:18: note: previous declaration is here
   pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
                    ^
   1 error generated.


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

