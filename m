Return-Path: <linux-pci+bounces-5453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079E892A6E
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 11:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A511C2094F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D31C0DE5;
	Sat, 30 Mar 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuNxGilP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473A1C0DD6
	for <linux-pci@vger.kernel.org>; Sat, 30 Mar 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711794753; cv=none; b=eRi5uLsR86zwJVy5g7XtzWSSvPrjFf8mfTjtr581iaRo0K3lpb3dvVECrKHILHLLk6njkmiRCI2q5gq3v1lzRDwmQIqh9Lm6BkJL6FHT03j/5Ehhuapnionp0qbuQZnNIHn9Louqlu5GIJHwta3/6UbdXGfWZXdjHPRQF3JZPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711794753; c=relaxed/simple;
	bh=XtM/Gfmk+g0ebxAIgyQGRPZgpW6mCp/0GRoMXkTZgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKWUF8vCT6Furu8XonvQ7/EJFWYiWORHgTDM2XOplLx26EcKtVgtT3VzANgFfLJiye4blNPgBzUFMqCgfu2o4NOhtvzWHqelxjKqhabnmD9YSwze7PMBKWcQQEUa6Hxf7YlpW+0kq+lp+4I/o88jlGOrHWm0D//YXol5lQwRK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuNxGilP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711794751; x=1743330751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XtM/Gfmk+g0ebxAIgyQGRPZgpW6mCp/0GRoMXkTZgn4=;
  b=TuNxGilPsvhm7QBzRRTgRDMV+vhRs0RHm+sg0fJS2Y4PQV5Fq26+pcyU
   2rR8DruXYiE846A66Bf2GrafdA366d7gXOcbK0fkuK0XVoDMvYjbRLvBJ
   J7JEUmhjynZkkUSKlc1ulrspWcdyKq56Fd7aZ6UPPK1OO5Fx/zkUHKEDs
   HB9AR/oI5pco7kOHGtctIkWPRpiVAvnmex19J6lfUrD5ZFCsbd2ZoYhCH
   zp2bLYPOIBOAOHFF0F+Mxju67SLNEy7sI28vzPNGOsm5SQFnX3DjQ1qf1
   H9sPjMjyiYmOZj++TFNqJ0TZilIXcPmjgMKgHxBo6NqMWK4KPJoPc9hDL
   g==;
X-CSE-ConnectionGUID: u6Kx1W+OT3iGn6N2XQub9g==
X-CSE-MsgGUID: YcXY+RRMRxurn+COVXeWZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18117913"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="18117913"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 03:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="21871653"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Mar 2024 03:32:27 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqW0f-0004AM-1U;
	Sat, 30 Mar 2024 10:32:25 +0000
Date: Sat, 30 Mar 2024 18:31:49 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 19/19] PCI: rockchip-ep: Handle PERST signal in endpoint
 mode
Message-ID: <202403301809.VzsJsDFL-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20240330 (https://download.01.org/0day-ci/archive/20240330/202403301809.VzsJsDFL-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403301809.VzsJsDFL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403301809.VzsJsDFL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rockchip-ep.c:633:2: error: call to undeclared function 'irq_set_irq_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     633 |         irq_set_irq_type(ep->perst_irq,
         |         ^
   drivers/pci/controller/pcie-rockchip-ep.c:633:2: note: did you mean 'irq_set_irq_wake'?
   include/linux/interrupt.h:482:12: note: 'irq_set_irq_wake' declared here
     482 | extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
         |            ^
>> drivers/pci/controller/pcie-rockchip-ep.c:657:2: error: call to undeclared function 'irq_set_status_flags'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     657 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |         ^
>> drivers/pci/controller/pcie-rockchip-ep.c:657:38: error: use of undeclared identifier 'IRQ_NOAUTOEN'
     657 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |                                             ^
   3 errors generated.


vim +/irq_set_irq_type +633 drivers/pci/controller/pcie-rockchip-ep.c

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

