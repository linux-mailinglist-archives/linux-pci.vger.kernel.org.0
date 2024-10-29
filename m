Return-Path: <linux-pci+bounces-15502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98259B41B5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 06:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8882F2837E0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 05:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182E14900E;
	Tue, 29 Oct 2024 05:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3ule/1n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FD191F88;
	Tue, 29 Oct 2024 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730178290; cv=none; b=WkvVuuPv+ddG6VLdE7RGOh+mFuLCsCO8AMQOUA50hR4L3PdnylwjWX5xzStczbhvRtgxaUvXXQ3TQGBEJh1vBptI0aUBWmbK83/QfCXvUwtUAoNl7oFQ4m9w9aCIPG8PJ3+9S51PWz/Rlp6dqiElRAWXTRD8eKQg3nCCQefyZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730178290; c=relaxed/simple;
	bh=eGsFmqlXjXC4FsEHXAfrFjTNhT0vyVCmz3/UORuqf6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtiCNo5lc6lLarAoFHcrETwTvVhw7tBwY0AKA+vecpP22XOMYzCDRxph0oxxQ0Vmse4tBAIrycxyISTctETvPjlS40MJHuTQAYscxxVIXtprq9bm7TgE9AXT/pMyzMGaryuJmdAAwrStEET7PS7+wxrOA+hBB0xiyNWz3trHFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3ule/1n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730178288; x=1761714288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eGsFmqlXjXC4FsEHXAfrFjTNhT0vyVCmz3/UORuqf6U=;
  b=T3ule/1nW9zlAOHMbTrDH4R3Hp59UCZKLJPGt8PZr8J3K/hDjGDQVToQ
   QVgV2E8325Oq9guajCt6MJ7ED337pgdKoYdhqUxYdcSTCz1f1YrwFUqFZ
   deup71eF6Bco9UhGIcUoSS8wpljL3ZpRwXeTdQ0Ji4fARy9vNlhyNkFwv
   gf5u3fGWa2p+bZzTNWM4YOWmG4NM5QukKRkNuSo25DXTPUGKEXaIBvNP0
   F0lsl6XWJSmKOfmqDpZn/7fxk4ERoXEyZ2RHxX0aclTw8ftkkW4K0Menc
   7+F8uqZFLqEsL9HOYQfupNfxxB/HxeTfZPcsGBEW60ReP9IjshOl732hL
   Q==;
X-CSE-ConnectionGUID: VrJgjH3VS3WZ8UQTZ86wpA==
X-CSE-MsgGUID: VRSAhRIaSlOBn8O+C89Jlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40336874"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40336874"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 22:04:47 -0700
X-CSE-ConnectionGUID: sfkKswGJSqOzH3FBCbYCjQ==
X-CSE-MsgGUID: e9zpuIaGT2elSMJfzcABGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81926546"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2024 22:04:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5ePH-000dGk-2w;
	Tue, 29 Oct 2024 05:04:39 +0000
Date: Tue, 29 Oct 2024 13:03:41 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 2/7] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Message-ID: <202410291248.Qc61mosK-lkp@intel.com>
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
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20241029/202410291248.Qc61mosK-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410291248.Qc61mosK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291248.Qc61mosK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware-host.c: In function 'dw_pcie_iatu_setup':
>> drivers/pci/controller/dwc/pcie-designware-host.c:782:69: error: passing argument 3 of 'dw_pcie_get_untranslate_addr' from incompatible pointer type [-Wincompatible-pointer-types]
     782 |                 if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
         |                                                                     ^~~~~~~~~~~~~
         |                                                                     |
         |                                                                     u64 * {aka long long unsigned int *}
   drivers/pci/controller/dwc/pcie-designware-host.c:422:58: note: expected 'resource_size_t *' {aka 'unsigned int *'} but argument is of type 'u64 *' {aka 'long long unsigned int *'}
     422 |                                         resource_size_t *i_addr)
         |                                         ~~~~~~~~~~~~~~~~~^~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/dw_pcie_get_untranslate_addr +782 drivers/pci/controller/dwc/pcie-designware-host.c

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

