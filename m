Return-Path: <linux-pci+bounces-21331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF960A336C0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 05:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3838C18878DD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD4204C31;
	Thu, 13 Feb 2025 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8tCngVD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBF70810;
	Thu, 13 Feb 2025 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420255; cv=none; b=G3HpvPCKrIJ7v2KGytGW4ghNGg6GbesZY6xi6HN379GoEG5UzW1Gm8apuLyhlcLgjD5kjSyiY92yfrhUyNLZTuInPfr8bcHOabM4YyLPKfYzgNsvMtJiJFIzHaqSTKowvbHb5JmX72odCgggMk4J/hAo5GwcXFWq1FTysvPGnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420255; c=relaxed/simple;
	bh=NwUCbncyWQlYDdWANe/dC2fuauZaHSWGGIIgoSJyz84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS/pbnk8hBTmXxIvzXfQAA9iJFsOEZmcDlOicFU2uL6HdIq2vPzhUwFjEcL+90sENZ+gaPKil0IHDGJRp5infQY7dTCeK/hvU+INuYDMEHg+PxQoiLX+JWOXiXLfPIwYk3KoSgm1n5M/0STEgbL70vIWaCKNHjCpsKzznCCVnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8tCngVD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739420253; x=1770956253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NwUCbncyWQlYDdWANe/dC2fuauZaHSWGGIIgoSJyz84=;
  b=V8tCngVDJX+tPyF2QMOB+rO4PtEKByQTsYehslJre9lx4zJW3Ye1nJKo
   z7Lg/3OjyJNwSNMPLjOvX5jh1WauvekkgJp1fxZfW5FbQjJW9XTwRjCa2
   NA0nmCu1ROtXkwxcpboHEZhbbQFm0MIWOwofu9VpILk6QBzivtfX2yOQr
   XwRDbthHHpGtXisfPpL4zjGK85ux64hCHZaiDrlh6X2MNZcwJl+cUs6gX
   g/LwYisKW8PeIZf1jsbSXMYvXsT20SsImyAJryFix5E3BUytQXZSZDLD1
   1/ZhqRdo1hLDBM7KCKCK8OpuhIBgTJ4uZ7LUpxY2OvMu4zTqtFman1eEn
   g==;
X-CSE-ConnectionGUID: kxBMgvetQBiYy32X5ou3XA==
X-CSE-MsgGUID: BIJgSb0oS62JgcAHg0p9Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51501686"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="51501686"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 20:17:32 -0800
X-CSE-ConnectionGUID: PtolVEeJT5eOD7M52x2ZTA==
X-CSE-MsgGUID: 4JQc8phaTK+L8aHulps4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="113022499"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2025 20:17:28 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiQfF-0016V9-2s;
	Thu, 13 Feb 2025 04:17:25 +0000
Date: Thu, 13 Feb 2025 12:16:58 +0800
From: kernel test robot <lkp@intel.com>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>, Marc Zyngier <maz@kernel.org>,
	Stan Skowronek <stan@corellium.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 7/7] PCI: apple: Add T602x PCIe support
Message-ID: <202502131258.hhEIy45J-lkp@intel.com>
References: <20250211-pcie-t6-v1-7-b60e6d2501bb@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-pcie-t6-v1-7-b60e6d2501bb@rosenzweig.io>

Hi Alyssa,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/Alyssa-Rosenzweig/dt-bindings-pci-apple-pcie-Add-t6020-support/20250212-035900
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250211-pcie-t6-v1-7-b60e6d2501bb%40rosenzweig.io
patch subject: [PATCH 7/7] PCI: apple: Add T602x PCIe support
config: s390-randconfig-002-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131258.hhEIy45J-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 6807164500e9920638e2ab0cdb4bf8321d24f8eb)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131258.hhEIy45J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131258.hhEIy45J-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pcie-apple.c:467:19: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     467 |                         writel_relaxed(FIELD_PREP(PORT_MSIMAP_TARGET, i) |
         |                                        ^
   1 error generated.


vim +/FIELD_PREP +467 drivers/pci/controller/pcie-apple.c

   429	
   430	static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
   431	{
   432		struct fwnode_handle *fwnode = &port->np->fwnode;
   433		struct apple_pcie *pcie = port->pcie;
   434		unsigned int irq;
   435	
   436		/* FIXME: consider moving each interrupt under each port */
   437		irq = irq_of_parse_and_map(to_of_node(dev_fwnode(port->pcie->dev)),
   438					   port->idx);
   439		if (!irq)
   440			return -ENXIO;
   441	
   442		port->domain = irq_domain_create_linear(fwnode, 32,
   443							&apple_port_irq_domain_ops,
   444							port);
   445		if (!port->domain)
   446			return -ENOMEM;
   447	
   448		/* Disable all interrupts */
   449		writel_relaxed(~0, port->base + PORT_INTMSK);
   450		writel_relaxed(~0, port->base + PORT_INTSTAT);
   451		writel_relaxed(~0, port->base + PORT_LINKCMDSTS);
   452	
   453		irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
   454	
   455		/* Configure MSI base address */
   456		BUILD_BUG_ON(upper_32_bits(DOORBELL_ADDR));
   457		writel_relaxed(lower_32_bits(DOORBELL_ADDR),
   458			       port->base + pcie->hw->port_msiaddr);
   459		if (pcie->hw->port_msiaddr_hi)
   460			writel_relaxed(0, port->base + pcie->hw->port_msiaddr_hi);
   461	
   462		/* Enable MSIs, shared between all ports */
   463		if (pcie->hw->port_msimap) {
   464			int i;
   465	
   466			for (i = 0; i < pcie->nvecs; i++) {
 > 467				writel_relaxed(FIELD_PREP(PORT_MSIMAP_TARGET, i) |
   468					       PORT_MSIMAP_ENABLE,
   469					       port->base + pcie->hw->port_msimap + 4 * i);
   470			}
   471	
   472			writel_relaxed(PORT_MSICFG_EN, port->base + PORT_MSICFG);
   473		} else {
   474			writel_relaxed(0, port->base + PORT_MSIBASE);
   475			writel_relaxed((ilog2(pcie->nvecs) << PORT_MSICFG_L2MSINUM_SHIFT) |
   476				PORT_MSICFG_EN, port->base + PORT_MSICFG);
   477		}
   478	
   479		return 0;
   480	}
   481	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

