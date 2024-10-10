Return-Path: <linux-pci+bounces-14221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA0999202
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F62B2F4E0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB51CEEA4;
	Thu, 10 Oct 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ijy9bFwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919C188A08;
	Thu, 10 Oct 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587017; cv=none; b=fKTWsziKamJi0S81oFTviGKcOIN4ysPe+kuNC0WXy0Xh8rrgHlFyZ1R1EfoW9QblcUyMVn75UyV5vJT7g3KCP+6vOzYrtdO7ggYY/0TMFZGTWuZA2CiD+kZyfuwlcBL75sfKTSHZmksufgTxDj99MIOcn2Pr0tu5AAODnZtMZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587017; c=relaxed/simple;
	bh=Y16JbD2tTLMVZ+XQHkqkCO/EcAcy4g8c84gyNLuC2Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUeDZ3b5unJ1M1cPWFKADjUmHjqWd0I5OO3tJY60WC0djtj/ELOciwOjGDGX3mpuJcENK0Qc2E6mswLMu3B1AP17dIFLDsLsrOW+DdHvHE5ABR8f28DiQNVNKVtQfzYb1+uDBCXjoUPocrsd5JtTSkaxbho0s6BMqLg3rSg7t9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ijy9bFwY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728587016; x=1760123016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y16JbD2tTLMVZ+XQHkqkCO/EcAcy4g8c84gyNLuC2Ok=;
  b=Ijy9bFwYUn1zkDi1HgmVCQnYX08g0Eg+llbN1wqvlLHSLIOW1eOFPAmj
   MLyljcvkRmntuSM3zB74gUwdfKORhYix5O4q93s3V1UtWq7vBHpfU6Lye
   et82PDcBVU6km+nKUmcMaP4Um7/6UfOBKUOYWMlOnDlAwoACevOGemy6B
   C1RlKmDS9tHtcW+rMWv00QGFcQGT7l7/kpAJpL8G0n+o4slLUvOcFZEYg
   52kawSMlNsO8A8jSqok+IJgx8+tDhuY8aiDIKe+9Ut8xwm+eBArD9jMI2
   TwJvCdecqTSxMZkkfQU8zKj176IadS4TikHi/rMHQamuh3DdlZ1Bn/pCd
   w==;
X-CSE-ConnectionGUID: esA8UI+iTiqWcJGnXSxD6Q==
X-CSE-MsgGUID: zEQVmTkSRfasQMXtPCow8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31664562"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31664562"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 12:03:35 -0700
X-CSE-ConnectionGUID: ehKnKpFWST6T8cGjMdRl8w==
X-CSE-MsgGUID: W0m087IXRB2TQuPrC2Zyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76337924"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2024 12:03:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syyRa-000B9h-2L;
	Thu, 10 Oct 2024 19:03:26 +0000
Date: Fri, 11 Oct 2024 03:03:04 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 11/14] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <202410110257.OAO10pXN-lkp@intel.com>
References: <c5b072393d2dc157d34f6dbeff6261d142d4de69.1728300190.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b072393d2dc157d34f6dbeff6261d142d4de69.1728300190.git.andrea.porta@suse.com>

Hi Andrea,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on clk/clk-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.12-rc2 next-20241010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-della-Porta/dt-bindings-clock-Add-RaspberryPi-RP1-clock-bindings/20241007-204440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/c5b072393d2dc157d34f6dbeff6261d142d4de69.1728300190.git.andrea.porta%40suse.com
patch subject: [PATCH v2 11/14] misc: rp1: RaspberryPi RP1 misc driver
config: alpha-randconfig-r061-20241011 (https://download.01.org/0day-ci/archive/20241011/202410110257.OAO10pXN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410110257.OAO10pXN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410110257.OAO10pXN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/misc/rp1/rp1_pci.c: In function 'rp1_mask_irq':
>> drivers/misc/rp1/rp1_pci.c:139:9: error: implicit declaration of function 'pci_msi_mask_irq'; did you mean 'pci_msix_free_irq'? [-Werror=implicit-function-declaration]
     139 |         pci_msi_mask_irq(pcie_irqd);
         |         ^~~~~~~~~~~~~~~~
         |         pci_msix_free_irq
   drivers/misc/rp1/rp1_pci.c: In function 'rp1_unmask_irq':
>> drivers/misc/rp1/rp1_pci.c:147:9: error: implicit declaration of function 'pci_msi_unmask_irq' [-Werror=implicit-function-declaration]
     147 |         pci_msi_unmask_irq(pcie_irqd);
         |         ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +139 drivers/misc/rp1/rp1_pci.c

   133	
   134	static void rp1_mask_irq(struct irq_data *irqd)
   135	{
   136		struct rp1_dev *rp1 = irqd->domain->host_data;
   137		struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
   138	
 > 139		pci_msi_mask_irq(pcie_irqd);
   140	}
   141	
   142	static void rp1_unmask_irq(struct irq_data *irqd)
   143	{
   144		struct rp1_dev *rp1 = irqd->domain->host_data;
   145		struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
   146	
 > 147		pci_msi_unmask_irq(pcie_irqd);
   148	}
   149	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

