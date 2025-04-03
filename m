Return-Path: <linux-pci+bounces-25263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85260A7AFC6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 23:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC6F7A5F18
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE3D25A64B;
	Thu,  3 Apr 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1WItLgw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879B1A254E;
	Thu,  3 Apr 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710280; cv=none; b=daHqKke84dd2RZmGu7ADlMNuOGG2wedgwL0hO4jz410LsrjYNof8inm6N5XVyMsEJIbPC6gBLGLesUslpEHm7LnLwIgCFwk+grOe75UUlDlyTtFS9Jl1On55tzXxUSy3gwwHJTWTEtjAVaRs3Q7DseR7H4FDFXGOl419Tl4zovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710280; c=relaxed/simple;
	bh=IjAcaogJEfwe1QULvS0sPgg/YGtkzTNEh+GLxUY+kf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbKXqQAzWFbGKKDEW2HA7HzmpIZBHXQ8vH0+dNJ68e0SzMDzWLMVCho6z5JGNy9OqF9Xg8bGesQv1f+ghfzc57MfmiJgrMZFCO9QMCBgiMVxmkhneXQGgzjZYqcteHbPoK0uOwIvEkqdz+2ZyEILkKEMjbiNf5BbJOSIUxRSfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1WItLgw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743710278; x=1775246278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjAcaogJEfwe1QULvS0sPgg/YGtkzTNEh+GLxUY+kf4=;
  b=I1WItLgwrCPu8b25xFTGU1GiRZ2VbL4Y6X8iEgz5Msd+43D810rC3BQb
   MHqSWm1W+DKZhS4bKRM63H8+QZX+c09OFIdSCj27vUIxg3ykal7/H/DJU
   jzgOH5T2YHTf++bO1n1KSNmoW6CWgNEvzGcyx9KIqlR9AJ8BLBBxGrxD8
   0XCIuebqF5MpIXVbmgTOKTA0WhgF+czP+s7n3mBXS+DJrLK1RjlZzoCXK
   kf4GEBSG9ncMzilp9wWQlvPkrDY0RmS8CW+89cF0o5tcg7qDyx/CsLAzy
   FMoqV1dv7QK0xe0Y4MlQXYCkTUTq4QL2aQBYmGrvJ5BaNntrHWzhl5pig
   A==;
X-CSE-ConnectionGUID: GcBwqSY5Q6y+VwEKnE2msw==
X-CSE-MsgGUID: jr+gDegATamgdxuVJV0jQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="67611714"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="67611714"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 12:57:58 -0700
X-CSE-ConnectionGUID: mRRrpAwESFaktxFDiOsS0Q==
X-CSE-MsgGUID: 61Ht4NWSTWCHq56j/Ob+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="158085692"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Apr 2025 12:57:54 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0QhD-0000lb-0S;
	Thu, 03 Apr 2025 19:57:51 +0000
Date: Fri, 4 Apr 2025 03:57:06 +0800
From: kernel test robot <lkp@intel.com>
To: shao.mingyin@zte.com.cn, jonnyc@amazon.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
	xu.xin16@zte.com.cn, ye.xingchen@zte.com.cn
Subject: Re: [PATCH] PCI: al: Use devm_platform_ioremap_resource_byname
Message-ID: <202504040353.k5kLpniy-lkp@intel.com>
References: <20250403154833001aNpIIRBQWEw67Oo8nChch@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403154833001aNpIIRBQWEw67Oo8nChch@zte.com.cn>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.14 next-20250403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shao-mingyin-zte-com-cn/PCI-al-Use-devm_platform_ioremap_resource_byname/20250403-155111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250403154833001aNpIIRBQWEw67Oo8nChch%40zte.com.cn
patch subject: [PATCH] PCI: al: Use devm_platform_ioremap_resource_byname
config: s390-randconfig-002-20250404 (https://download.01.org/0day-ci/archive/20250404/202504040353.k5kLpniy-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250404/202504040353.k5kLpniy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504040353.k5kLpniy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-al.c:359:4: warning: variable 'controller_res' is uninitialized when used here [-Wuninitialized]
     359 |                         controller_res);
         |                         ^~~~~~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-al.c:330:33: note: initialize the variable 'controller_res' to silence this warning
     330 |         struct resource *controller_res;
         |                                        ^
         |                                         = NULL
   1 warning generated.


vim +/controller_res +359 drivers/pci/controller/dwc/pcie-al.c

a8daea94754989 Jonathan Chocron 2019-09-12  326  
a8daea94754989 Jonathan Chocron 2019-09-12  327  static int al_pcie_probe(struct platform_device *pdev)
a8daea94754989 Jonathan Chocron 2019-09-12  328  {
a8daea94754989 Jonathan Chocron 2019-09-12  329  	struct device *dev = &pdev->dev;
a8daea94754989 Jonathan Chocron 2019-09-12  330  	struct resource *controller_res;
a8daea94754989 Jonathan Chocron 2019-09-12  331  	struct resource *ecam_res;
a8daea94754989 Jonathan Chocron 2019-09-12  332  	struct al_pcie *al_pcie;
a8daea94754989 Jonathan Chocron 2019-09-12  333  	struct dw_pcie *pci;
a8daea94754989 Jonathan Chocron 2019-09-12  334  
a8daea94754989 Jonathan Chocron 2019-09-12  335  	al_pcie = devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
a8daea94754989 Jonathan Chocron 2019-09-12  336  	if (!al_pcie)
a8daea94754989 Jonathan Chocron 2019-09-12  337  		return -ENOMEM;
a8daea94754989 Jonathan Chocron 2019-09-12  338  
a8daea94754989 Jonathan Chocron 2019-09-12  339  	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
a8daea94754989 Jonathan Chocron 2019-09-12  340  	if (!pci)
a8daea94754989 Jonathan Chocron 2019-09-12  341  		return -ENOMEM;
a8daea94754989 Jonathan Chocron 2019-09-12  342  
a8daea94754989 Jonathan Chocron 2019-09-12  343  	pci->dev = dev;
60f5b73fa0f298 Rob Herring      2020-11-05  344  	pci->pp.ops = &al_pcie_host_ops;
a8daea94754989 Jonathan Chocron 2019-09-12  345  
a8daea94754989 Jonathan Chocron 2019-09-12  346  	al_pcie->pci = pci;
a8daea94754989 Jonathan Chocron 2019-09-12  347  	al_pcie->dev = dev;
a8daea94754989 Jonathan Chocron 2019-09-12  348  
a8daea94754989 Jonathan Chocron 2019-09-12  349  	ecam_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
a8daea94754989 Jonathan Chocron 2019-09-12  350  	if (!ecam_res) {
a8daea94754989 Jonathan Chocron 2019-09-12  351  		dev_err(dev, "couldn't find 'config' reg in DT\n");
a8daea94754989 Jonathan Chocron 2019-09-12  352  		return -ENOENT;
a8daea94754989 Jonathan Chocron 2019-09-12  353  	}
a8daea94754989 Jonathan Chocron 2019-09-12  354  	al_pcie->ecam_size = resource_size(ecam_res);
a8daea94754989 Jonathan Chocron 2019-09-12  355  
99f4e0afd9fbe4 Xie Ludan        2025-04-03  356  	al_pcie->controller_base = devm_platform_ioremap_resource_byname(pdev, "controller");
a8daea94754989 Jonathan Chocron 2019-09-12  357  	if (IS_ERR(al_pcie->controller_base)) {
a8daea94754989 Jonathan Chocron 2019-09-12  358  		dev_err(dev, "couldn't remap controller base %pR\n",
a8daea94754989 Jonathan Chocron 2019-09-12 @359  			controller_res);
a8daea94754989 Jonathan Chocron 2019-09-12  360  		return PTR_ERR(al_pcie->controller_base);
a8daea94754989 Jonathan Chocron 2019-09-12  361  	}
a8daea94754989 Jonathan Chocron 2019-09-12  362  
a0fd361db8e508 Rob Herring      2020-11-05  363  	dev_dbg(dev, "From DT: controller_base: %pR\n", controller_res);
a8daea94754989 Jonathan Chocron 2019-09-12  364  
a8daea94754989 Jonathan Chocron 2019-09-12  365  	platform_set_drvdata(pdev, al_pcie);
a8daea94754989 Jonathan Chocron 2019-09-12  366  
60f5b73fa0f298 Rob Herring      2020-11-05  367  	return dw_pcie_host_init(&pci->pp);
a8daea94754989 Jonathan Chocron 2019-09-12  368  }
a8daea94754989 Jonathan Chocron 2019-09-12  369  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

