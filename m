Return-Path: <linux-pci+bounces-15504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E789B42F7
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 08:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F5C1C21F37
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A802022DE;
	Tue, 29 Oct 2024 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDD2zK2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251681FCF49;
	Tue, 29 Oct 2024 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186335; cv=none; b=pO5SoNthAHSOLvOKXBqC6W6+i6qjfIm9xxT8GOQhMUCIv2pjObg0PcjJyDrcLyE8c3h4l8ASzVPiH4Y1sWDUI54P/NT6dRGyBDm3XP1GuB0cv8ustJ0q6auQ+vk3ItTuY8HGnSGnsGvDxbN6LC0dUXElqn6/q9tzBgyIDZX/9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186335; c=relaxed/simple;
	bh=BdYcTmAXb1SfXEeowtRZE7Rf2n06MdmrBquWG32nqao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu89YFFuFry2A+rSJAt5tcIbMFI1/M2hNWUZWUfNQ7xOS2EDQLp4CuGRpI/2j4JM8iK+30E0UKT4FRCZkBnApT7fKJVvumpfUmYaudakHFbqtmi9z9u7Ha7bgq9yBWHs+PpcumVNPER01cuIaqyowavWTTmOLNTpXUopOcIpJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDD2zK2y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730186333; x=1761722333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdYcTmAXb1SfXEeowtRZE7Rf2n06MdmrBquWG32nqao=;
  b=XDD2zK2y3X8oWGvs67rmpMvz0e4WxNU0+5inf4mNT79cFRA96fOsgmZa
   M4e6ICC8m8Y/aj2VYR3FmDqTGGCBFFmwLPHlx5KPOFMq4w6s/QPw9tGQ0
   Gss58xxPFYqg4qas2Cy1Z5td+CTKxrtsWAQ/xAeUDaShnBuubDfdJyuG/
   0k45CQe7mQ4kNVh73YJTxdSGBqYEya0HmD6qgN6n2TTg0cOzDq7SbasPM
   4rAOnyJYJOMSpAOx6ZQnZkbC80fQ7iGFJmKJ2tJ5EhdhYfhL2Yeo9QbKl
   9ZuLan8m20vrLpexLGL3qy0qtcdB4g/yRdk7DdGs4k2zsGPZb4T3C4ZvR
   g==;
X-CSE-ConnectionGUID: TqyIiT45RUW6A+N5yXzEXA==
X-CSE-MsgGUID: REZznhKnR/iTnjw3Xmyo+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29774257"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29774257"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 00:18:52 -0700
X-CSE-ConnectionGUID: ifNbUCZ6QHay4UdqM/kgoQ==
X-CSE-MsgGUID: qNn49BT5RyqWAcTYDzsScw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81430699"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2024 00:18:46 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5gV2-000dN8-1u;
	Tue, 29 Oct 2024 07:18:44 +0000
Date: Tue, 29 Oct 2024 15:18:37 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 2/7] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Message-ID: <202410291546.kvgEWJv7-lkp@intel.com>
References: <20241028-pci_fixup_addr-v6-2-ebebcd8fd4ff@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-pci_fixup_addr-v6-2-ebebcd8fd4ff@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/of-address-Add-parent_bus_addr-to-struct-of_pci_range/20241029-030935
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-2-ebebcd8fd4ff%40nxp.com
patch subject: [PATCH v6 2/7] PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
config: arm-defconfig (https://download.01.org/0day-ci/archive/20241029/202410291546.kvgEWJv7-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410291546.kvgEWJv7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-host.c:782:55: error: incompatible pointer types passing 'u64 *' (aka 'unsigned long long *') to parameter of type 'resource_size_t *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
                   if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
                                                                       ^~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:422:23: note: passing argument to parameter 'i_addr' here
                                           resource_size_t *i_addr)
                                                            ^
   1 error generated.


vim +782 drivers/pci/controller/dwc/pcie-designware-host.c

   745	
   746	static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
   747	{
   748		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
   749		struct dw_pcie_ob_atu_cfg atu = { 0 };
   750		struct resource_entry *entry;
   751		int i, ret;
   752	
   753		/* Note the very first outbound ATU is used for CFG IOs */
   754		if (!pci->num_ob_windows) {
   755			dev_err(pci->dev, "No outbound iATU found\n");
   756			return -EINVAL;
   757		}
   758	
   759		/*
   760		 * Ensure all out/inbound windows are disabled before proceeding with
   761		 * the MEM/IO (dma-)ranges setups.
   762		 */
   763		for (i = 0; i < pci->num_ob_windows; i++)
   764			dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
   765	
   766		for (i = 0; i < pci->num_ib_windows; i++)
   767			dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
   768	
   769		i = 0;
   770		resource_list_for_each_entry(entry, &pp->bridge->windows) {
   771			if (resource_type(entry->res) != IORESOURCE_MEM)
   772				continue;
   773	
   774			if (pci->num_ob_windows <= ++i)
   775				break;
   776	
   777			atu.index = i;
   778			atu.type = PCIE_ATU_TYPE_MEM;
   779			atu.cpu_addr = entry->res->start;
   780			atu.pci_addr = entry->res->start - entry->offset;
   781	
 > 782			if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
   783				return -EINVAL;
   784	
   785			/* Adjust iATU size if MSG TLP region was allocated before */
   786			if (pp->msg_res && pp->msg_res->parent == entry->res)
   787				atu.size = resource_size(entry->res) -
   788						resource_size(pp->msg_res);
   789			else
   790				atu.size = resource_size(entry->res);
   791	
   792			ret = dw_pcie_prog_outbound_atu(pci, &atu);
   793			if (ret) {
   794				dev_err(pci->dev, "Failed to set MEM range %pr\n",
   795					entry->res);
   796				return ret;
   797			}
   798		}
   799	
   800		if (pp->io_size) {
   801			if (pci->num_ob_windows > ++i) {
   802				atu.index = i;
   803				atu.type = PCIE_ATU_TYPE_IO;
   804				atu.cpu_addr = pp->io_base;
   805				atu.pci_addr = pp->io_bus_addr;
   806				atu.size = pp->io_size;
   807	
   808				ret = dw_pcie_prog_outbound_atu(pci, &atu);
   809				if (ret) {
   810					dev_err(pci->dev, "Failed to set IO range %pr\n",
   811						entry->res);
   812					return ret;
   813				}
   814			} else {
   815				pp->cfg0_io_shared = true;
   816			}
   817		}
   818	
   819		if (pci->num_ob_windows <= i)
   820			dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
   821				 pci->num_ob_windows);
   822	
   823		pp->msg_atu_index = i;
   824	
   825		i = 0;
   826		resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
   827			if (resource_type(entry->res) != IORESOURCE_MEM)
   828				continue;
   829	
   830			if (pci->num_ib_windows <= i)
   831				break;
   832	
   833			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
   834						       entry->res->start,
   835						       entry->res->start - entry->offset,
   836						       resource_size(entry->res));
   837			if (ret) {
   838				dev_err(pci->dev, "Failed to set DMA range %pr\n",
   839					entry->res);
   840				return ret;
   841			}
   842		}
   843	
   844		if (pci->num_ib_windows <= i)
   845			dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
   846				 pci->num_ib_windows);
   847	
   848		return 0;
   849	}
   850	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

