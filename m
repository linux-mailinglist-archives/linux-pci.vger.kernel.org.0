Return-Path: <linux-pci+bounces-12920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283CC97017F
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F1C1F23034
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543A158A13;
	Sat,  7 Sep 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icZ0i5RP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104A158541;
	Sat,  7 Sep 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725703347; cv=none; b=TFDQR+uDgHdChofvnT3If+Pj11dCSCAqXrRE7EAvdCz0TjFJqsgyJf9uGDReVTd28W8G+weZom2sId61Z/cAXbQmKPXw2YtZ5cgxO9gE/Rimo2aqg8+LNYFnJGXb4bm3S7FxvXv6OP+PLqg77goTPmunKiljn7IyR2PYFk/srwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725703347; c=relaxed/simple;
	bh=+8ndftcpr710lyIszgV8c95AAh8cy/KDHvOC47Z5jY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU2OViJOrjpv9T2agmo6zSN6hmP4+qAjhsl2x7tOkj7v6VXXU5a47gfvZRwzc7plZUQ+oAyyS74EWC7fCUMNqsM4h+8Gm/RwmBElefkaRPJYfZ4nMVNy76uwzia6wHWuP3vFi1rbSXCJwS7Ka9KLd5OMyEejjLIfObRDvhPC2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icZ0i5RP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725703344; x=1757239344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+8ndftcpr710lyIszgV8c95AAh8cy/KDHvOC47Z5jY8=;
  b=icZ0i5RPJV4LsP52qy3QMQQ9V7YhiuECIuZ4w+i50Dbr9bZVtDbP2RAH
   BSCqsPnT4AuBnM3Ud/+e8Rjg+e2NXQ0ORKZ4kwxbCjJ+JWu13RyEy7AgC
   dZe3/zPeKMqBAa8XmlAmLbWvLfaVmaTw1/MH4Trazx/DZ19aD//IY+ZFd
   7UEoJ6oD+Va3ZaJkBw01zbho9n0J2FskVFP3+E1vlGGtsYo8nGrHyWsuP
   E0jkBvBrAYPtKjQWCXHKg+TPPFHg4lneqQ0wx9LvKW+M0ZF7zRnp1G5wb
   6bBlf/039+FPFiP3ic4aN8e5jZBpX+mwTz96/3tWDVvfahv4RBC00TvLc
   A==;
X-CSE-ConnectionGUID: mOk0M4ySSimtUg4k2QUIxw==
X-CSE-MsgGUID: d+0cU98WRxeBWCWoYxEjQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24323050"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="24323050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 03:02:24 -0700
X-CSE-ConnectionGUID: /y7E0xneQa+1lRbk+cY5dw==
X-CSE-MsgGUID: 5pZQbW8lSiai6JaiI7i3Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="103648425"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Sep 2024 03:02:20 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smsGn-000CPb-2j;
	Sat, 07 Sep 2024 10:02:17 +0000
Date: Sat, 7 Sep 2024 18:01:24 +0800
From: kernel test robot <lkp@intel.com>
To: Thippeswamy Havalige <thippesw@amd.com>,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bharat.kumar.gogada@amd.com,
	michal.simek@amd.com, lpieralisi@kernel.org, kw@linux.com,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller-1
Message-ID: <202409071713.wrAI0UuK-lkp@intel.com>
References: <20240906093148.830452-3-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906093148.830452-3-thippesw@amd.com>

Hi Thippeswamy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus mani-mhi/mhi-next robh/for-next linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thippeswamy-Havalige/dt-bindings-PCI-xilinx-cpm-Add-compatible-string-for-CPM5-controller-1/20240906-173446
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240906093148.830452-3-thippesw%40amd.com
patch subject: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller-1
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240907/202409071713.wrAI0UuK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071713.wrAI0UuK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071713.wrAI0UuK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/pcie-xilinx-cpm.c: In function 'xilinx_cpm_pcie_event_flow':
   drivers/pci/controller/pcie-xilinx-cpm.c:292:44: error: 'CPM5_HOST1' undeclared (first use in this function)
     292 |         else if (port->variant->version == CPM5_HOST1) {
         |                                            ^~~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c:292:44: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/pcie-xilinx-cpm.c: In function 'xilinx_cpm_pcie_init_port':
   drivers/pci/controller/pcie-xilinx-cpm.c:504:44: error: 'CPM5_HOST1' undeclared (first use in this function)
     504 |         else if (port->variant->version == CPM5_HOST1) {
         |                                            ^~~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c: At top level:
   drivers/pci/controller/pcie-xilinx-cpm.c:635:40: error: redefinition of 'cpm5_host'
     635 | static const struct xilinx_cpm_variant cpm5_host = {
         |                                        ^~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c:631:40: note: previous definition of 'cpm5_host' with type 'const struct xilinx_cpm_variant'
     631 | static const struct xilinx_cpm_variant cpm5_host = {
         |                                        ^~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c:636:20: error: 'CPM5_HOST1' undeclared here (not in a function)
     636 |         .version = CPM5_HOST1,
         |                    ^~~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c:650:26: error: 'cpm5_host1' undeclared here (not in a function); did you mean 'cpm5_host'?
     650 |                 .data = &cpm5_host1,
         |                          ^~~~~~~~~~
         |                          cpm5_host
>> drivers/pci/controller/pcie-xilinx-cpm.c:631:40: warning: 'cpm5_host' defined but not used [-Wunused-const-variable=]
     631 | static const struct xilinx_cpm_variant cpm5_host = {
         |                                        ^~~~~~~~~


vim +/cpm5_host +631 drivers/pci/controller/pcie-xilinx-cpm.c

51f1ffc00d95e3 Bharat Kumar Gogada 2022-07-05  630  
51f1ffc00d95e3 Bharat Kumar Gogada 2022-07-05 @631  static const struct xilinx_cpm_variant cpm5_host = {
51f1ffc00d95e3 Bharat Kumar Gogada 2022-07-05  632  	.version = CPM5,
51f1ffc00d95e3 Bharat Kumar Gogada 2022-07-05  633  };
51f1ffc00d95e3 Bharat Kumar Gogada 2022-07-05  634  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

