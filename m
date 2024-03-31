Return-Path: <linux-pci+bounces-5459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E7892EB0
	for <lists+linux-pci@lfdr.de>; Sun, 31 Mar 2024 07:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B67B20D5A
	for <lists+linux-pci@lfdr.de>; Sun, 31 Mar 2024 05:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E22F3B;
	Sun, 31 Mar 2024 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fauTo1Qe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6679CC
	for <linux-pci@vger.kernel.org>; Sun, 31 Mar 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863682; cv=none; b=NAF3jqzHp6mXQev8DPOAzikD2aMJF+18oTd7xFvx+GvbGFb5w5b/xkNkGzJtElQ5e4zRgVwEsrcT2UIsdFRHARCghcP8PSzCBMku0NrpldDYaT/1v0ajVu9Paj//82vok+4K6RD8HKWiD9FEtT0rb6FdfP9a76E8NtHn+i2So/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863682; c=relaxed/simple;
	bh=rgBxQWb018sUA1O77Ck6hkUHlAofNm8E+53lqjOtZa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk+r0ZEc5hFNO9XMGYQZAW6ww4OcDQo08NnBwBx/IvaRH/YFnWquAx4SFFCGiqrvcfAuPRgcYCT1+vKCyv5X2fqe/LP3Z+iJpicsCALLJiQ9Fmj7c9VHq/o7zoWeT/pfVK+opv1yYhxy5aLisI0vk5yTCVkuDoPQEwmt741RJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fauTo1Qe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711863681; x=1743399681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rgBxQWb018sUA1O77Ck6hkUHlAofNm8E+53lqjOtZa0=;
  b=fauTo1QepqPBObqE7IPDa2rhpFtXdZC8iz0Pcvf/Im+f6aKR3+THlMF2
   cqazEPlim/a2lLdgJCnt+ppA8h17G6Tob7mG0gjpDHoVZBEuiHDQK3HT9
   z3w9vXRJCHtfvzQxwROJLExceR8/ir9aqjEi0G0CRR3Y/fL7IKkMd1P1A
   3NQ6trAn0+kLFu0aftqBjyU0F1EadgmAOZijqqgSCkoCncDkCjA6cViLO
   Gc6HbIyqYdD7TujyUDVYWhXDP1ZhXJjQwjSofESUedDQHA6rq1CrIQ9Zw
   MY73g1SV684TzicumW3YBGol87TWFTKC+2h/EWHYNqb+7AaCA8y6q24DK
   g==;
X-CSE-ConnectionGUID: EuyxFxxuSmOonmGD7BtJDA==
X-CSE-MsgGUID: xkr7KOhfSaqeQxs7aCr7kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="10793230"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="10793230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 22:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="17830104"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Mar 2024 22:41:17 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqnwQ-0000py-1f;
	Sun, 31 Mar 2024 05:41:14 +0000
Date: Sun, 31 Mar 2024 13:40:32 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 19/19] PCI: rockchip-ep: Handle PERST signal in endpoint
 mode
Message-ID: <202403311327.3pGGy6Qm-lkp@intel.com>
References: <20240329090945.1097609-20-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090945.1097609-20-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/PCI-endpoint-Introduce-pci_epc_check_func/20240329-171158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240329090945.1097609-20-dlemoal%40kernel.org
patch subject: [PATCH 19/19] PCI: rockchip-ep: Handle PERST signal in endpoint mode
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20240331/202403311327.3pGGy6Qm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240331/202403311327.3pGGy6Qm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403311327.3pGGy6Qm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_perst_irq_thread':
>> drivers/pci/controller/pcie-rockchip-ep.c:633:9: error: implicit declaration of function 'irq_set_irq_type'; did you mean 'irq_set_irq_wake'? [-Werror=implicit-function-declaration]
     633 |         irq_set_irq_type(ep->perst_irq,
         |         ^~~~~~~~~~~~~~~~
         |         irq_set_irq_wake
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_setup_irq':
>> drivers/pci/controller/pcie-rockchip-ep.c:657:9: error: implicit declaration of function 'irq_set_status_flags' [-Werror=implicit-function-declaration]
     657 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-rockchip-ep.c:657:45: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
     657 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |                                             ^~~~~~~~~~~~
         |                                             IRQF_NO_AUTOEN
   drivers/pci/controller/pcie-rockchip-ep.c:657:45: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +633 drivers/pci/controller/pcie-rockchip-ep.c

   620	
   621	static irqreturn_t rockchip_pcie_ep_perst_irq_thread(int irq, void *data)
   622	{
   623		struct pci_epc *epc = data;
   624		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   625		struct rockchip_pcie *rockchip = &ep->rockchip;
   626		u32 perst = gpiod_get_value(rockchip->ep_gpio);
   627	
   628		if (perst)
   629			rockchip_pcie_ep_perst_assert(ep);
   630		else
   631			rockchip_pcie_ep_perst_deassert(ep);
   632	
 > 633		irq_set_irq_type(ep->perst_irq,
   634				 (perst ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW));
   635	
   636		return IRQ_HANDLED;
   637	}
   638	
   639	static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
   640	{
   641		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   642		struct rockchip_pcie *rockchip = &ep->rockchip;
   643		struct device *dev = rockchip->dev;
   644		int ret;
   645	
   646		if (!rockchip->ep_gpio)
   647			return 0;
   648	
   649		/* PCIe reset interrupt */
   650		ep->perst_irq = gpiod_to_irq(rockchip->ep_gpio);
   651		if (ep->perst_irq < 0) {
   652			dev_err(dev, "No corresponding IRQ for PERST GPIO\n");
   653			return ep->perst_irq;
   654		}
   655	
   656		ep->perst_asserted = true;
 > 657		irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
   658		ret = devm_request_threaded_irq(dev, ep->perst_irq, NULL,
   659						rockchip_pcie_ep_perst_irq_thread,
   660						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
   661						"pcie-ep-perst", epc);
   662		if (ret) {
   663			dev_err(dev, "Request PERST GPIO IRQ failed %d\n", ret);
   664			return ret;
   665		}
   666	
   667		return 0;
   668	}
   669	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

