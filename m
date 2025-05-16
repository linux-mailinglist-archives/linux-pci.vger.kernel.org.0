Return-Path: <linux-pci+bounces-27899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D61ABA575
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8085DA05B53
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C1221CC7D;
	Fri, 16 May 2025 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBe7lwr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3961022E00E;
	Fri, 16 May 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431875; cv=none; b=EFzC68zJaQVahNwkr/V6hj7qDK0uu08Rb8bRQaLI6DPsrsLenej7HIKiyijtGl68DlO7B4NTDFmNlrH3p3hNWGyOYOBjgE2HKuLTZAI/WII1Ref5CGgRwdMMx2Bwm0JGJgh4u4pmOh4GDLOP4+sZch75ENvk+8SbMh1KXpLcI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431875; c=relaxed/simple;
	bh=KiXlWVvWbj3iQU2JRYdsPONKttf2OpY5rD5DTxqLwNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLVWxQLjcUuyhMaK3FzH/IyzKRGsyMr6bTjvgV+nBW2aNPK0QpB2IP8XLRUSCiPVpvXYqRHsMGful/SkrvskohiHif+KSa10Y6chVcgnLKKVNUbwxVMe9MLCgrWzCH4XiOmZmsKePEU7z8yvmyYQX4dsQD114zctmsrb5rkQRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBe7lwr7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747431874; x=1778967874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KiXlWVvWbj3iQU2JRYdsPONKttf2OpY5rD5DTxqLwNg=;
  b=eBe7lwr76GRCDUAmRCaY6qDDrlA5sgET35WOuPPZr4Gh9SpcXnmC8OIn
   JbTRjXr60E20WJGs/QrEp2YcCVGgIm8F2SoXPHl/okl4PmCY839bHFNP7
   MuL150BrT0EzKFSKseJGIIux8yU9K2lB65uXrpKVRTGzKw7x4QEICGE2G
   Vh7CXkkcZGRLpes2wqHaOobWMZqOzsXfmxPn9dttmy1kgA3tG1rePugPe
   Y7qDyUXsfLQwwanQCLLugCDKA8t+zo7k+gr7t2KF+4c04uYv7hOEHf2GK
   oKZvCyLV1GrfZMWsdvZUE3bBic9yfUQk+BEtSg0hl1lLpItVYi7imW3CQ
   g==;
X-CSE-ConnectionGUID: Ogn2YlS6T8yEf9M0iOp+Dw==
X-CSE-MsgGUID: WBrjmUDaRNiu1gFKz3v0lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="59646240"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="59646240"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:44:33 -0700
X-CSE-ConnectionGUID: 9zi4AcyDTQy2BRR5jKZQLQ==
X-CSE-MsgGUID: NnUL7Z25T9usE81AAyYDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="139298683"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 May 2025 14:44:29 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uG2qx-000JjX-0E;
	Fri, 16 May 2025 21:44:27 +0000
Date: Sat, 17 May 2025 05:44:04 +0800
From: kernel test robot <lkp@intel.com>
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.or, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com
Cc: oe-kbuild-all@lists.linux.dev, ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v1 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host
 controller driver
Message-ID: <202505170506.s78iuxFL-lkp@intel.com>
References: <20250516094315.179-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516094315.179-1-zhangsenchuan@eswincomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.15-rc6 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhangsenchuan-eswincomputing-com/dt-bindings-PCI-eic7700-Add-Eswin-eic7700-PCIe-host-controller/20250516-174445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250516094315.179-1-zhangsenchuan%40eswincomputing.com
patch subject: [PATCH v1 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host controller driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20250517/202505170506.s78iuxFL-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250517/202505170506.s78iuxFL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505170506.s78iuxFL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:31,
                    from include/linux/clk.h:13,
                    from drivers/pci/controller/dwc/pcie-eic7700.c:11:
>> drivers/pci/controller/dwc/pcie-eic7700.c:427:28: error: initialization of 'void (*)(struct platform_device *)' from incompatible pointer type 'int (*)(struct platform_device *)' [-Wincompatible-pointer-types]
     427 |         .remove = __exit_p(eswin_pcie_remove),
         |                            ^~~~~~~~~~~~~~~~~
   include/linux/init.h:395:21: note: in definition of macro '__exit_p'
     395 | #define __exit_p(x) x
         |                     ^
   drivers/pci/controller/dwc/pcie-eic7700.c:427:28: note: (near initialization for 'eswin_pcie_driver.remove')
     427 |         .remove = __exit_p(eswin_pcie_remove),
         |                            ^~~~~~~~~~~~~~~~~
   include/linux/init.h:395:21: note: in definition of macro '__exit_p'
     395 | #define __exit_p(x) x
         |                     ^


vim +427 drivers/pci/controller/dwc/pcie-eic7700.c

   418	
   419	static struct platform_driver eswin_pcie_driver = {
   420		.driver = {
   421				.name = "eic7700-pcie",
   422				.of_match_table = eswin_pcie_of_match,
   423				.suppress_bind_attrs = true,
   424				.pm = &eswin_pcie_pm_ops,
   425		},
   426		.probe = eswin_pcie_probe,
 > 427		.remove = __exit_p(eswin_pcie_remove),
   428		.shutdown = eswin_pcie_shutdown,
   429	};
   430	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

