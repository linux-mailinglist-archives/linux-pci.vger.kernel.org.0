Return-Path: <linux-pci+bounces-16737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF29C84B3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 09:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8612D1F21722
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2739146588;
	Thu, 14 Nov 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rwti0Vd7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C417ADE8
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572229; cv=none; b=JsdtqLLn4mTsXK/I2VLDtolzimEeJBah2rhu/Ae6TGPw4GQBstzn2PBu/O3r+HaojVWCaV/DUKE397L04KP+0KIur6ErmnoFqJfQriAwx8gRAaRvFKrwE9WpLku76ZBXaqPS1099QP1De1nh0YEkN4FoTqUTg23iIAqLmT1ruNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572229; c=relaxed/simple;
	bh=MC2A5TDYVCmLIOpXF0jmOWzDxB4Kwn2or2n4pdU46s8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tyYAt1fWBfUXBtI7qmaR/EglH5oAJd6mrb0lh0V7wIZGpEh2K0kOaG8P3d0UC+xNJ4n9ITfbjRFwgxd30H40dLdxP+gEQ0C/E+wLgV3hE/geH/4uLRJV8lGomJdp85xS8UrReNVhc/XaEP/PcD1/qJ8DZj3+j/ErLgrbWwm0JLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rwti0Vd7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731572228; x=1763108228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MC2A5TDYVCmLIOpXF0jmOWzDxB4Kwn2or2n4pdU46s8=;
  b=Rwti0Vd76u3WZ1QroZt5YmL89R+ycor2B/e8aHncb4ZoFsWBNB+jExZ/
   vwe0NZlJR/6phvTrOPqazyhEu8/baw3NP9KXAb2/wgh/ysmc0giZzYz6y
   zWCudgX0YoDNzRCIp4A0/k8g4Q1EBZBivr37Du0IDKgs8/0KcSEQ705rd
   PwuyhgEwKXxI8CfhrPX0xybMflMW/Xea0W+sEkWRpBOm/NoFP34KxNGAb
   cKhunztef6UwaXLeHkZggMHvkLj2QDtUyV1XEJozOLxy7nhjhwq3O61PT
   iUl4ldbY0BcX5Naei2+HqV6ETamtPo7tH0WlBb4hnhUPBCu7mzDX87mIZ
   g==;
X-CSE-ConnectionGUID: +nT66mIgRuCDkvpJbDjcUA==
X-CSE-MsgGUID: sn//fw0tQp6134bvpq7s4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30905758"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="30905758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:17:05 -0800
X-CSE-ConnectionGUID: 9TlISGPpSfavJs5ytN16rQ==
X-CSE-MsgGUID: GbB73WtbSiiqn+TJzChjew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125628926"
Received: from lkp-server01.sh.intel.com (HELO 8eed2ac03994) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:17:03 -0800
Received: from kbuild by 8eed2ac03994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBV2D-00006V-1a;
	Thu, 14 Nov 2024 08:17:01 +0000
Date: Thu, 14 Nov 2024 16:17:01 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [pci:controller/rockchip 13/13]
 drivers/pci/controller/pcie-rockchip-ep.c:640:9: error: implicit declaration
 of function 'irq_set_irq_type'; did you mean 'irq_set_irq_wake'?
Message-ID: <202411141621.uwFAKZb2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
head:   337657a3c24c92befb3ed11d6f15402faa09f7dd
commit: 337657a3c24c92befb3ed11d6f15402faa09f7dd [13/13] PCI: rockchip-ep: Handle PERST# signal in endpoint mode
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20241114/202411141621.uwFAKZb2-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411141621.uwFAKZb2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411141621.uwFAKZb2-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_perst_irq_thread':
>> drivers/pci/controller/pcie-rockchip-ep.c:640:9: error: implicit declaration of function 'irq_set_irq_type'; did you mean 'irq_set_irq_wake'? [-Wimplicit-function-declaration]
     640 |         irq_set_irq_type(ep->perst_irq,
         |         ^~~~~~~~~~~~~~~~
         |         irq_set_irq_wake
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_setup_irq':
>> drivers/pci/controller/pcie-rockchip-ep.c:672:9: error: implicit declaration of function 'irq_set_status_flags' [-Wimplicit-function-declaration]
     672 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-rockchip-ep.c:672:45: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
     672 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |                                             ^~~~~~~~~~~~
         |                                             IRQF_NO_AUTOEN
   drivers/pci/controller/pcie-rockchip-ep.c:672:45: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/pcie-rockchip-ep.c: At top level:
   drivers/pci/controller/pcie-rockchip-ep.c:705:10: error: 'const struct pci_epc_ops' has no member named 'align_addr'
     705 |         .align_addr     = rockchip_pcie_ep_align_addr,
         |          ^~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:705:27: error: initialization of 'int (*)(struct pci_epc *, u8,  u8,  phys_addr_t,  u64,  size_t)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  long long unsigned int,  long long unsigned int,  long unsigned int)'} from incompatible pointer type 'u64 (*)(struct pci_epc *, u64,  size_t *, size_t *)' {aka 'long long unsigned int (*)(struct pci_epc *, long long unsigned int,  long unsigned int *, long unsigned int *)'} [-Wincompatible-pointer-types]
     705 |         .align_addr     = rockchip_pcie_ep_align_addr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:705:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')
   drivers/pci/controller/pcie-rockchip-ep.c:706:27: warning: initialized field overwritten [-Woverride-init]
     706 |         .map_addr       = rockchip_pcie_ep_map_addr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:706:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')


vim +640 drivers/pci/controller/pcie-rockchip-ep.c

   627	
   628	static irqreturn_t rockchip_pcie_ep_perst_irq_thread(int irq, void *data)
   629	{
   630		struct pci_epc *epc = data;
   631		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   632		struct rockchip_pcie *rockchip = &ep->rockchip;
   633		u32 perst = gpiod_get_value(rockchip->perst_gpio);
   634	
   635		if (perst)
   636			rockchip_pcie_ep_perst_assert(ep);
   637		else
   638			rockchip_pcie_ep_perst_deassert(ep);
   639	
 > 640		irq_set_irq_type(ep->perst_irq,
   641				 (perst ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW));
   642	
   643		return IRQ_HANDLED;
   644	}
   645	
   646	static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
   647	{
   648		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   649		struct rockchip_pcie *rockchip = &ep->rockchip;
   650		struct device *dev = rockchip->dev;
   651		int ret;
   652	
   653		if (!rockchip->perst_gpio)
   654			return 0;
   655	
   656		/* PCIe reset interrupt */
   657		ep->perst_irq = gpiod_to_irq(rockchip->perst_gpio);
   658		if (ep->perst_irq < 0) {
   659			dev_err(dev,
   660				"failed to get IRQ for PERST# GPIO: %d\n",
   661				ep->perst_irq);
   662	
   663			return ep->perst_irq;
   664		}
   665	
   666		/*
   667		 * The perst_gpio is active low, so when it is inactive on start, it
   668		 * is high and will trigger the perst_irq handler. So treat this initial
   669		 * IRQ as a dummy one by faking the host asserting PERST#.
   670		 */
   671		ep->perst_asserted = true;
 > 672		irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
   673		ret = devm_request_threaded_irq(dev, ep->perst_irq, NULL,
   674						rockchip_pcie_ep_perst_irq_thread,
   675						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
   676						"pcie-ep-perst", epc);
   677		if (ret) {
   678			dev_err(dev,
   679				"failed to request IRQ for PERST# GPIO: %d\n",
   680				ret);
   681	
   682			return ret;
   683		}
   684	
   685		return 0;
   686	}
   687	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

