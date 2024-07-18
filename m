Return-Path: <linux-pci+bounces-10509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87648934F9E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E17BB21026
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86114372D;
	Thu, 18 Jul 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMoLatHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6357CB1;
	Thu, 18 Jul 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315090; cv=none; b=TyfyGMGe4dWZsNdnSYGIc5z0Wau8XEpVxC7S9Shzgq73cD0vBptzipkNOx88VmOSFfLdE47iNSpzUW3ML+4M6RZGa5Z59ckUmY8UamcJ073+VDtarEexT+jj6UJTkygAI08IvJbMn/gW5TYsswGitjN66w6nderC4tSJ0trRR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315090; c=relaxed/simple;
	bh=dZW7lRE+sZuNldQlR9VQEdsqcwmACooMJqyeIowXW6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kxqc4+ddnj1LCmUAI6vzqAbtoafOH+ygWG/q4XnWupNRPpXnaVbwowGO+7TdvGCj29Q6HU0Lq6YIqJ/1BdoAxs+aj2qUR2b7Bj1+f3h8DC2dC9AtkMhqY5P3xKzc4LlKaVqSBihNp6htKVv/fVS910HPQar60NITeAj6lbEOEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMoLatHZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721315088; x=1752851088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dZW7lRE+sZuNldQlR9VQEdsqcwmACooMJqyeIowXW6A=;
  b=CMoLatHZ4OYbhfib1NCv6yJyIuzXLaO6NNDklXQwJTXdffaXLP0FL1Xy
   pq18v53A0NAXj7e33nyI5SBoOBj24+4WQY/LbZ0/6ftIbjwPMKb4gTIgD
   FIp2K1ujKqU3lMCF8KXCJCxDfHZh/s4WeoQnUHkBStCtCNv4J9AUsAytX
   e4iLBkqaZ7qHaI2iw3zAGuvA4b6WWVlBNlFIIjAfhBsCtnjkVBphwph8y
   g0ozdKpBba60r5w1qX5gwr212NLesBYIOShlimrcPQmF0GjAkoBFvpwUw
   tacG5t4WNJLCa1pBUjwaeiS/5RBfLQEKWwjUdbTAGyqOf3tXSIxPI6ukl
   A==;
X-CSE-ConnectionGUID: PK7cUQyTQ2ua6uq7z+Jr+A==
X-CSE-MsgGUID: 2zZ9YgDITSmBclC5EvOkGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="29495224"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="29495224"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 08:04:47 -0700
X-CSE-ConnectionGUID: SNYB1mlkQduYB3nKxp1i3A==
X-CSE-MsgGUID: IRYcbZhjSx23VxMOPGTUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="81814698"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jul 2024 08:04:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUSgS-000hMK-1a;
	Thu, 18 Jul 2024 15:04:40 +0000
Date: Thu, 18 Jul 2024 23:04:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <202407182239.m0d1pKRB-lkp@intel.com>
References: <20240717-pci-qcom-hotplug-v2-5-71d304b817f8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-pci-qcom-hotplug-v2-5-71d304b817f8@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 91e3b24eb7d297d9d99030800ed96944b8652eaf]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-ep-Drop-the-redundant-masking-of-global-IRQ-events/20240718-010848
base:   91e3b24eb7d297d9d99030800ed96944b8652eaf
patch link:    https://lore.kernel.org/r/20240717-pci-qcom-hotplug-v2-5-71d304b817f8%40linaro.org
patch subject: [PATCH v2 05/13] PCI: endpoint: Assign PCI domain number for endpoint controllers
config: i386-buildonly-randconfig-004-20240718 (https://download.01.org/0day-ci/archive/20240718/202407182239.m0d1pKRB-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407182239.m0d1pKRB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407182239.m0d1pKRB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/endpoint/pci-epc-core.c:843:3: error: call to undeclared function 'pci_bus_release_domain_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     843 |                 pci_bus_release_domain_nr(NULL, &epc->dev);
         |                 ^
   drivers/pci/endpoint/pci-epc-core.c:843:3: note: did you mean 'pci_bus_release_busn_res'?
   include/linux/pci.h:1142:6: note: 'pci_bus_release_busn_res' declared here
    1142 | void pci_bus_release_busn_res(struct pci_bus *b);
         |      ^
   drivers/pci/endpoint/pci-epc-core.c:911:20: error: call to undeclared function 'pci_bus_find_domain_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     911 |                 epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
         |                                  ^
   2 errors generated.


vim +/pci_bus_release_domain_nr +843 drivers/pci/endpoint/pci-epc-core.c

   830	
   831	/**
   832	 * pci_epc_destroy() - destroy the EPC device
   833	 * @epc: the EPC device that has to be destroyed
   834	 *
   835	 * Invoke to destroy the PCI EPC device
   836	 */
   837	void pci_epc_destroy(struct pci_epc *epc)
   838	{
   839		pci_ep_cfs_remove_epc_group(epc->group);
   840		device_unregister(&epc->dev);
   841	
   842		if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
 > 843			pci_bus_release_domain_nr(NULL, &epc->dev);
   844	}
   845	EXPORT_SYMBOL_GPL(pci_epc_destroy);
   846	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

