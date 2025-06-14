Return-Path: <linux-pci+bounces-29803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B429CAD9992
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 04:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EC71895630
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735264A98;
	Sat, 14 Jun 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5DVYZcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FA43AB7;
	Sat, 14 Jun 2025 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749866945; cv=none; b=Ql76lo/HxuPWRKcxPkTFC8EBKc33Q9LfErkHJ7xFhvODYCdCjMeM9ktprq0MRh1hC4uoHCe1pREUsSn/rpUXi5B3CzNhuJufWJ5dzOR53csQCp6FRC0oi5O1fKF0HpH4R6+wmcg3DzViobZ7zt3QnsEhM9qh1VUjuSfZIGl2PoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749866945; c=relaxed/simple;
	bh=T7F5BTPkmIJqijZcvCaJDzeehyOgLhWobs1d8ZTzUB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swObgkl92d3F4gMRGB9mFaX3TY5lj+WIiRDNNyS3BrsIWleXfViVnwyzkYG2Vr4OfoFEevxmJm3/QGg4Iigee/qZ8YIhchwHd6UMEPt3x0rBQrg2+0hqTnRy+YizX3hIpGSBniI7UgiNEjOJ5iY83pTuh/nS2ofSvvjsPWTTHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5DVYZcv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749866943; x=1781402943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T7F5BTPkmIJqijZcvCaJDzeehyOgLhWobs1d8ZTzUB8=;
  b=P5DVYZcv7WqOIzebe93guUWFeRU0LO/Rym1G8Bk62tW1Cb4DltyEKZgt
   ahSiN/LoaSqf2dknKfbcAK+LxKpPDg9mEUtL7E5RzmhVPhxnSiZr41wjs
   S41JntK4tKECagL06WLe+f9J6zC0iFElzH+q59Quay0ND22NvyS3uoPee
   9/ZWZlDUHEht8r8KL1t1ujjiUa2ILkouaOhrQmb5M7O1q28QQinc5Z49l
   fhKcK/5y66LKHFzYMdDUitf7OMyjn+842HgrSq2K8WZE2NSyKIb8gnTgv
   rrouZ+RphuV8wwCzMZYp7F9aLnyE75zRxk1pHZ0qsBhP+hQabalJVv4Jd
   A==;
X-CSE-ConnectionGUID: oe7szM/dSBGJp5B99AHL8Q==
X-CSE-MsgGUID: QO+3P+K0QfWcPCdvTypHrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="69668257"
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="69668257"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 19:09:02 -0700
X-CSE-ConnectionGUID: dYhVJh5yTR6s0T8b+3tZig==
X-CSE-MsgGUID: NmfKjhUOQ6mo1Nvl5ddlFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="148347803"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jun 2025 19:08:53 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQGJz-000DAM-2X;
	Sat, 14 Jun 2025 02:08:39 +0000
Date: Sat, 14 Jun 2025 10:07:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org,
	kishon@kernel.org, linus.walleij@linaro.org, p.zabel@pengutronix.de,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	elbadrym@google.com, romlem@google.com, anhphan@google.com,
	wak@google.com, yuxiaozhang@google.com, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 7/7] pci: aspeed: Add ASPEED PCIe host controller driver
Message-ID: <202506140931.MWdyPxX1-lkp@intel.com>
References: <20250613033001.3153637-8-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613033001.3153637-8-jacky_chou@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.16-rc1 next-20250613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-phy-Add-document-for-ASPEED-PCIe-PHY/20250613-113331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250613033001.3153637-8-jacky_chou%40aspeedtech.com
patch subject: [PATCH 7/7] pci: aspeed: Add ASPEED PCIe host controller driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250614/202506140931.MWdyPxX1-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250614/202506140931.MWdyPxX1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506140931.MWdyPxX1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-aspeed.c:481:6: warning: variable 'status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     481 |         if (bus->number == 0) {
         |             ^~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-aspeed.c:541:9: note: uninitialized use occurs here
     541 |         writel(status, pcie->reg + H2X_CFGE_INT_STS);
         |                ^~~~~~
   drivers/pci/controller/pcie-aspeed.c:481:2: note: remove the 'if' if its condition is always false
     481 |         if (bus->number == 0) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~
     482 |                 /* Internal access to bridge */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     483 |                 writel(TLP_BYTE_EN(0xf) << 16 | (where & ~3), pcie->reg + H2X_CFGI_TLP);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     484 |                 writel(CFGI_TLP_FIRE, pcie->reg + H2X_CFGI_CTRL);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     485 |                 *val = readl(pcie->reg + H2X_CFGI_RET_DATA);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     486 |         } else {
         |         ~~~~~~
   drivers/pci/controller/pcie-aspeed.c:474:24: note: initialize the variable 'status' to silence this warning
     474 |         u32 bdf_offset, status;
         |                               ^
         |                                = 0
   drivers/pci/controller/pcie-aspeed.c:573:6: warning: variable 'status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     573 |         if (bus->number == 0) {
         |             ^~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-aspeed.c:622:9: note: uninitialized use occurs here
     622 |         writel(status, pcie->reg + H2X_CFGE_INT_STS);
         |                ^~~~~~
   drivers/pci/controller/pcie-aspeed.c:573:2: note: remove the 'if' if its condition is always false
     573 |         if (bus->number == 0) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~
     574 |                 /* Internal access to bridge */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     575 |                 writel(CFGI_WRITE | TLP_BYTE_EN(byte_en) << 16 | (where & ~3),
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     576 |                        pcie->reg + H2X_CFGI_TLP);
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~
     577 |                 writel(val, pcie->reg + H2X_CFGI_WR_DATA);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     578 |                 writel(CFGI_TLP_FIRE, pcie->reg + H2X_CFGI_CTRL);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     579 |         } else {
         |         ~~~~~~
   drivers/pci/controller/pcie-aspeed.c:552:24: note: initialize the variable 'status' to silence this warning
     552 |         u32 bdf_offset, status, type;
         |                               ^
         |                                = 0
   2 warnings generated.


vim +481 drivers/pci/controller/pcie-aspeed.c

   469	
   470	static int aspeed_ast2700_rd_conf(struct pci_bus *bus, unsigned int devfn,
   471					  int where, int size, u32 *val)
   472	{
   473		struct aspeed_pcie *pcie = bus->sysdata;
   474		u32 bdf_offset, status;
   475		u8 type;
   476		int ret;
   477	
   478		if ((bus->number == 0 && devfn != 0))
   479			return PCIBIOS_DEVICE_NOT_FOUND;
   480	
 > 481		if (bus->number == 0) {
   482			/* Internal access to bridge */
   483			writel(TLP_BYTE_EN(0xf) << 16 | (where & ~3), pcie->reg + H2X_CFGI_TLP);
   484			writel(CFGI_TLP_FIRE, pcie->reg + H2X_CFGI_CTRL);
   485			*val = readl(pcie->reg + H2X_CFGI_RET_DATA);
   486		} else {
   487			if (!aspeed_ast2700_get_link(pcie))
   488				return PCIBIOS_DEVICE_NOT_FOUND;
   489	
   490			bdf_offset = aspeed_pcie_get_bdf_offset(bus, devfn, where);
   491	
   492			type = (bus->number == 1) ? PCI_HEADER_TYPE_NORMAL : PCI_HEADER_TYPE_BRIDGE;
   493	
   494			writel(CRG_READ_FMTTYPE(type) | CRG_PAYLOAD_SIZE, pcie->reg + H2X_CFGE_TLP_1ST);
   495			writel(AST2700_TX_DESC1_VALUE | (pcie->tx_tag << 8) | TLP_BYTE_EN(0xf),
   496			       pcie->reg + H2X_CFGE_TLP_NEXT);
   497			writel(bdf_offset, pcie->reg + H2X_CFGE_TLP_NEXT);
   498			writel(CFGE_TX_IDLE | CFGE_RX_BUSY, pcie->reg + H2X_CFGE_INT_STS);
   499			writel(CFGE_TLP_FIRE, pcie->reg + H2X_CFGE_CTRL);
   500	
   501			ret = readl_poll_timeout(pcie->reg + H2X_CFGE_INT_STS, status,
   502						 (status & CFGE_TX_IDLE), 0, 50);
   503			if (ret) {
   504				dev_err(pcie->dev,
   505					"[%X:%02X:%02X.%02X]CR tx timeout sts: 0x%08x\n",
   506					pcie->domain, bus->number, PCI_SLOT(devfn),
   507					PCI_FUNC(devfn), status);
   508				ret = PCIBIOS_SET_FAILED;
   509				*val = ~0;
   510				goto out;
   511			}
   512	
   513			ret = readl_poll_timeout(pcie->reg + H2X_CFGE_INT_STS, status,
   514						 (status & CFGE_RX_BUSY), 0, 50000);
   515			if (ret) {
   516				dev_err(pcie->dev,
   517					"[%X:%02X:%02X.%02X]CR rx timeoutsts: 0x%08x\n",
   518					pcie->domain, bus->number, PCI_SLOT(devfn),
   519					PCI_FUNC(devfn), status);
   520				ret = PCIBIOS_SET_FAILED;
   521				*val = ~0;
   522				goto out;
   523			}
   524			*val = readl(pcie->reg + H2X_CFGE_RET_DATA);
   525		}
   526	
   527		switch (size) {
   528		case 1:
   529			*val = (*val >> ((where & 3) * 8)) & 0xff;
   530			break;
   531		case 2:
   532			*val = (*val >> ((where & 2) * 8)) & 0xffff;
   533			break;
   534		case 4:
   535		default:
   536			break;
   537		}
   538	
   539		ret = PCIBIOS_SUCCESSFUL;
   540	out:
   541		writel(status, pcie->reg + H2X_CFGE_INT_STS);
   542		pcie->tx_tag = (pcie->tx_tag + 1) % 0xF;
   543		return ret;
   544	}
   545	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

