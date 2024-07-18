Return-Path: <linux-pci+bounces-10518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE093500F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78861C2195E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F861448C9;
	Thu, 18 Jul 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRyMApne"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA17143C55;
	Thu, 18 Jul 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317069; cv=none; b=OMkTE9imc73aLzXBBkgE0jiIjI14aDW1UnfXrZMVex1mng4xE1pYXE4ukA18AzF+vQQRLDQcEZ7utjDPgyC6Ao3wVXGwJCVAArFVyhalJ0gE8NGhDExmBs92DhQry7LIKk1Wf0vE/PU7/wlJsII4JAyXnfLjF5xvOQphHhknoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317069; c=relaxed/simple;
	bh=q8xB8YjwvvcSwbrw7Le2TORA5F7YWJ0dr743OTWSyAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkboTeUGfXSczI299yVkDewokfYiHOazgbmgcqDHQ0cFmb/QUhVaMuf5wCqE8W/Lwn+o7v0fa/uCUOTvyoKUlkzAl3BDjos334k0ZPSRSc2ovaftNOmVaWaOR8PIvoJ4AIFmoJJ/xqodKEbCT7pRliJIwSMKrFY9YQcuOJYYSWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRyMApne; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721317068; x=1752853068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8xB8YjwvvcSwbrw7Le2TORA5F7YWJ0dr743OTWSyAY=;
  b=eRyMApneDNe5Eoh/MQX99cM3t6os90DVMVA2MOkWMPAgAs9Im583BAE9
   9znEeWZY+31klHoTMFgiKLBPk1DwSi+cMlepRiQ2RlX2Em3QjTg4gAIJa
   zS6iAeQGs63jUVOL31lEG9hLXXlAI7Xm+L0rmWHIJ5XuIZjcQz7pP2hwO
   Cp3n0v3p0/pnwl+JjnY0QvEhEDD4AYT5K1qp1zLgEZnemcKT/Fdg8/c9c
   9W2/Wz/jo82LrX4ip9PRcYkVZrryt5vSmuE9+F7nbbGIX7LS97Whhcv4c
   cC0IJUhKrI26PXd/kEf9+e374McHXqPdv0ISHhX4yyg3xmOCX7xunXlq9
   Q==;
X-CSE-ConnectionGUID: rUW+N79FQrSlMU1vxGbwCQ==
X-CSE-MsgGUID: ug2HryX7TgyBs6hmc9uZmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="22658656"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="22658656"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 08:37:47 -0700
X-CSE-ConnectionGUID: ILKoIV9EQrWsn+PV/pQFMA==
X-CSE-MsgGUID: 7jet6lFGTLyc+m9NRYYIsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="50552786"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jul 2024 08:37:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUTCP-000hNu-1A;
	Thu, 18 Jul 2024 15:37:41 +0000
Date: Thu, 18 Jul 2024 23:37:22 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <202407182326.ZHNfCp4Z-lkp@intel.com>
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
config: i386-randconfig-002-20240718 (https://download.01.org/0day-ci/archive/20240718/202407182326.ZHNfCp4Z-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407182326.ZHNfCp4Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407182326.ZHNfCp4Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-epc-core.c: In function 'pci_epc_destroy':
>> drivers/pci/endpoint/pci-epc-core.c:843:17: error: implicit declaration of function 'pci_bus_release_domain_nr'; did you mean 'pci_bus_release_busn_res'? [-Werror=implicit-function-declaration]
     843 |                 pci_bus_release_domain_nr(NULL, &epc->dev);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                 pci_bus_release_busn_res
   drivers/pci/endpoint/pci-epc-core.c: In function '__pci_epc_create':
   drivers/pci/endpoint/pci-epc-core.c:911:34: error: implicit declaration of function 'pci_bus_find_domain_nr' [-Werror=implicit-function-declaration]
     911 |                 epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +843 drivers/pci/endpoint/pci-epc-core.c

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

