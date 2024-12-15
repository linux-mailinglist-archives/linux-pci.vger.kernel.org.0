Return-Path: <linux-pci+bounces-18455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE469F2395
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 13:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BD51884C1B
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A712183CA6;
	Sun, 15 Dec 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFxyBFE0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B338384;
	Sun, 15 Dec 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264343; cv=none; b=GyJIdLszxOM7M5j/f9qcC8CD2IvIhXb5KFBtP7YcWXEmnySEx++ZBPWRs9B/+sEawRV2XVVVaFQqL90UqKF9I7z4yNSptlbSKrQoXXaI3sKCX9cNa3kz5ad9qtn6eZY+vTaU2tNaQ0h6RvhyfZhXm1Jn8FX18Rr+yQKpnYCGi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264343; c=relaxed/simple;
	bh=9kJLi0dXcGI0Nv+xmsFVcopdmVnhaH0hQ44/xOLTk5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILnPeTS11Yj7iigJkbQHfIJIQk9FCs4mctQdIhcfrr4jHZIuoZBVnYOjk3PutYsrZThPn+vDti6Im3Vq2hUMeXKUpgJK0HICMSAaGXglMOGUKE7amqPJWVQbrud1HxCLV2tLrEANbICEw4qtQ3R17dGineAM703C0mhZXv7bXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFxyBFE0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734264341; x=1765800341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9kJLi0dXcGI0Nv+xmsFVcopdmVnhaH0hQ44/xOLTk5Y=;
  b=LFxyBFE0RZPF5dPu4A0OVhFrcP4XqnKPJvsT+XV+LHuqP2qhe/XrsLCF
   B/rPU9h6XlKRA+UCp0DNhAyGJk98WCKxffu/nOAPkitaP250VPlv/lwT2
   KODTCg4DnJuThJyc9e1iq4ABbiSLS3JsYyhwRVju5OH85dtNIka3etRoy
   qE59uhs/sBXFJPehaOjhz+isbPEWzCqLhivBEp2GUPiBJp2S19+MLYOJi
   5+BzlOJQXbmzJjFzwkcJmAHXVZlY1n3rHGS7xZToslLGWHZIl0Oa7x3AY
   Ev+woeog7DAlrtscYsr5S/dH8IqY8AtfLIE50odPUj1xi2brzkISQeZJp
   Q==;
X-CSE-ConnectionGUID: mHfq8e5sTjSE9uRFQay3OA==
X-CSE-MsgGUID: y3pxru5YSa+XVnGqrcJrwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="22246174"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="22246174"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 04:05:40 -0800
X-CSE-ConnectionGUID: P8R3k7+lQM2ZtLbYVrag9A==
X-CSE-MsgGUID: RVCG9s3BRyChlgkgpNp+Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="97504875"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Dec 2024 04:05:34 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMnNM-000Db4-09;
	Sun, 15 Dec 2024 12:05:32 +0000
Date: Sun, 15 Dec 2024 20:04:59 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, unicorn_wang@outlook.com, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
	lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com, helgaas@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <202412151947.yDHMy3jh-lkp@intel.com>
References: <1d82eff3670f60df24228e5c83cf663c6dd61eaf.1733726572.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d82eff3670f60df24228e5c83cf663c6dd61eaf.1733726572.git.unicorn_wang@outlook.com>

Hi Chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-pci-Add-Sophgo-SG2042-PCIe-host/20241209-152613
base:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
patch link:    https://lore.kernel.org/r/1d82eff3670f60df24228e5c83cf663c6dd61eaf.1733726572.git.unicorn_wang%40outlook.com
patch subject: [PATCH v2 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
config: sh-randconfig-r071-20241215 (https://download.01.org/0day-ci/archive/20241215/202412151947.yDHMy3jh-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412151947.yDHMy3jh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412151947.yDHMy3jh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/cadence/pcie-sg2042.c:23:
   drivers/pci/controller/cadence/../../../irqchip/irq-msi-lib.h:25:39: warning: 'struct msi_domain_info' declared inside parameter list will not be visible outside of this definition or declaration
      25 |                                struct msi_domain_info *info);
         |                                       ^~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:306:15: error: variable 'sg2042_pcie_msi_parent_ops' has initializer but incomplete type
     306 | static struct msi_parent_ops sg2042_pcie_msi_parent_ops = {
         |               ^~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:307:10: error: 'struct msi_parent_ops' has no member named 'required_flags'
     307 |         .required_flags         = SG2042_PCIE_MSI_FLAGS_REQUIRED,
         |          ^~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:301:41: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
     301 | #define SG2042_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |      \
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:307:35: note: in expansion of macro 'SG2042_PCIE_MSI_FLAGS_REQUIRED'
     307 |         .required_flags         = SG2042_PCIE_MSI_FLAGS_REQUIRED,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:302:41: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
     302 |                                         MSI_FLAG_USE_DEF_CHIP_OPS)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:307:35: note: in expansion of macro 'SG2042_PCIE_MSI_FLAGS_REQUIRED'
     307 |         .required_flags         = SG2042_PCIE_MSI_FLAGS_REQUIRED,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:301:40: warning: excess elements in struct initializer
     301 | #define SG2042_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |      \
         |                                        ^
   drivers/pci/controller/cadence/pcie-sg2042.c:307:35: note: in expansion of macro 'SG2042_PCIE_MSI_FLAGS_REQUIRED'
     307 |         .required_flags         = SG2042_PCIE_MSI_FLAGS_REQUIRED,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:301:40: note: (near initialization for 'sg2042_pcie_msi_parent_ops')
     301 | #define SG2042_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |      \
         |                                        ^
   drivers/pci/controller/cadence/pcie-sg2042.c:307:35: note: in expansion of macro 'SG2042_PCIE_MSI_FLAGS_REQUIRED'
     307 |         .required_flags         = SG2042_PCIE_MSI_FLAGS_REQUIRED,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:308:10: error: 'struct msi_parent_ops' has no member named 'supported_flags'
     308 |         .supported_flags        = SG2042_PCIE_MSI_FLAGS_SUPPORTED,
         |          ^~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:304:41: error: 'MSI_GENERIC_FLAGS_MASK' undeclared here (not in a function)
     304 | #define SG2042_PCIE_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:308:35: note: in expansion of macro 'SG2042_PCIE_MSI_FLAGS_SUPPORTED'
     308 |         .supported_flags        = SG2042_PCIE_MSI_FLAGS_SUPPORTED,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:304:41: warning: excess elements in struct initializer
     304 | #define SG2042_PCIE_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:308:35: note: in expansion of macro 'SG2042_PCIE_MSI_FLAGS_SUPPORTED'
     308 |         .supported_flags        = SG2042_PCIE_MSI_FLAGS_SUPPORTED,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:304:41: note: (near initialization for 'sg2042_pcie_msi_parent_ops')
     304 | #define SG2042_PCIE_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:308:35: note: in expansion of macro 'SG2042_PCIE_MSI_FLAGS_SUPPORTED'
     308 |         .supported_flags        = SG2042_PCIE_MSI_FLAGS_SUPPORTED,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:309:10: error: 'struct msi_parent_ops' has no member named 'bus_select_mask'
     309 |         .bus_select_mask        = MATCH_PCI_MSI,
         |          ^~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/../../../irqchip/irq-msi-lib.h:15:33: warning: excess elements in struct initializer
      15 | #define MATCH_PCI_MSI           (0)
         |                                 ^
   drivers/pci/controller/cadence/pcie-sg2042.c:309:35: note: in expansion of macro 'MATCH_PCI_MSI'
     309 |         .bus_select_mask        = MATCH_PCI_MSI,
         |                                   ^~~~~~~~~~~~~
   drivers/pci/controller/cadence/../../../irqchip/irq-msi-lib.h:15:33: note: (near initialization for 'sg2042_pcie_msi_parent_ops')
      15 | #define MATCH_PCI_MSI           (0)
         |                                 ^
   drivers/pci/controller/cadence/pcie-sg2042.c:309:35: note: in expansion of macro 'MATCH_PCI_MSI'
     309 |         .bus_select_mask        = MATCH_PCI_MSI,
         |                                   ^~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-sg2042.c:310:10: error: 'struct msi_parent_ops' has no member named 'bus_select_token'
     310 |         .bus_select_token       = DOMAIN_BUS_NEXUS,
         |          ^~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:310:35: warning: excess elements in struct initializer
     310 |         .bus_select_token       = DOMAIN_BUS_NEXUS,
         |                                   ^~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:310:35: note: (near initialization for 'sg2042_pcie_msi_parent_ops')
>> drivers/pci/controller/cadence/pcie-sg2042.c:311:10: error: 'struct msi_parent_ops' has no member named 'prefix'
     311 |         .prefix                 = "SG2042-",
         |          ^~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:311:35: warning: excess elements in struct initializer
     311 |         .prefix                 = "SG2042-",
         |                                   ^~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:311:35: note: (near initialization for 'sg2042_pcie_msi_parent_ops')
>> drivers/pci/controller/cadence/pcie-sg2042.c:312:10: error: 'struct msi_parent_ops' has no member named 'init_dev_msi_info'
     312 |         .init_dev_msi_info      = msi_lib_init_dev_msi_info,
         |          ^~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:312:35: warning: excess elements in struct initializer
     312 |         .init_dev_msi_info      = msi_lib_init_dev_msi_info,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-sg2042.c:312:35: note: (near initialization for 'sg2042_pcie_msi_parent_ops')
   drivers/pci/controller/cadence/pcie-sg2042.c: In function 'sg2042_pcie_setup_msi':
>> drivers/pci/controller/cadence/pcie-sg2042.c:344:22: error: 'struct irq_domain' has no member named 'msi_parent_ops'
     344 |         parent_domain->msi_parent_ops = &sg2042_pcie_msi_parent_ops;
         |                      ^~
   drivers/pci/controller/cadence/pcie-sg2042.c: At top level:
>> drivers/pci/controller/cadence/pcie-sg2042.c:306:30: error: storage size of 'sg2042_pcie_msi_parent_ops' isn't known
     306 | static struct msi_parent_ops sg2042_pcie_msi_parent_ops = {
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sg2042_pcie_msi_parent_ops +306 drivers/pci/controller/cadence/pcie-sg2042.c

   300	
 > 301	#define SG2042_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
 > 302						MSI_FLAG_USE_DEF_CHIP_OPS)
   303	
 > 304	#define SG2042_PCIE_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
   305	
 > 306	static struct msi_parent_ops sg2042_pcie_msi_parent_ops = {
 > 307		.required_flags		= SG2042_PCIE_MSI_FLAGS_REQUIRED,
 > 308		.supported_flags	= SG2042_PCIE_MSI_FLAGS_SUPPORTED,
 > 309		.bus_select_mask	= MATCH_PCI_MSI,
 > 310		.bus_select_token	= DOMAIN_BUS_NEXUS,
 > 311		.prefix			= "SG2042-",
 > 312		.init_dev_msi_info	= msi_lib_init_dev_msi_info,
   313	};
   314	
   315	static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie, struct device_node *msi_node)
   316	{
   317		struct device *dev = pcie->cdns_pcie->dev;
   318		struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
   319		struct irq_domain *parent_domain;
   320		int ret = 0;
   321	
   322		if (!of_property_read_bool(msi_node, "msi-controller"))
   323			return -ENODEV;
   324	
   325		ret = of_irq_get_byname(msi_node, "msi");
   326		if (ret <= 0) {
   327			dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
   328			return ret;
   329		}
   330		pcie->msi_irq = ret;
   331	
   332		irq_set_chained_handler_and_data(pcie->msi_irq,
   333						 sg2042_pcie_msi_chained_isr, pcie);
   334	
   335		parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
   336							 &sg2042_pcie_msi_domain_ops, pcie);
   337		if (!parent_domain) {
   338			dev_err(dev, "%pfw: Failed to create IRQ domain\n", fwnode);
   339			return -ENOMEM;
   340		}
   341		irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
   342	
   343		parent_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
 > 344		parent_domain->msi_parent_ops = &sg2042_pcie_msi_parent_ops;
   345	
   346		pcie->msi_domain = parent_domain;
   347	
   348		ret = sg2042_pcie_init_msi_data(pcie);
   349		if (ret) {
   350			dev_err(dev, "Failed to initialize MSI data!\n");
   351			return ret;
   352		}
   353	
   354		return 0;
   355	}
   356	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

