Return-Path: <linux-pci+bounces-19584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66076A06ADC
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 03:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CF41883BB6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 02:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673B1BE5E;
	Thu,  9 Jan 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XysRnAkw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE1291E
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389353; cv=none; b=IzmFy/VGneYQEJskDxD1r+4zCQuJBJmtex/dBc9MxzLIGIqYAWc55JSlZXqPLi01pKxpK6M6r75RdKWWPTtkHz0hKX1pb7JvU+3Ll0tkNT2Z9CG7Lmooveo3gplDk5PPF4TQxYKjGUyAkZAFgToXbchmjQ3RIr4n+eGwFEYO/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389353; c=relaxed/simple;
	bh=SMQyMsf70HjSuInrammB94kyTqcQWkTMR5YYsDwFvk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6/PFN/B5QQfAuPXgERjbz8XuKDrJIsuwEV1euaNDTUasAvKnz6cHMCJZ82cUqfIkJJHDUJ5lVM6p0v9ZqolMKjVsJgUvx6+9sNyx1ThNm+JmLxFhrBvUC9rvYA0XICBcr/4j3S3OuGmP60/hRr4SfnsjoCbhTBO9jGRB61EK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XysRnAkw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736389352; x=1767925352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SMQyMsf70HjSuInrammB94kyTqcQWkTMR5YYsDwFvk0=;
  b=XysRnAkw7oqHjda1GU+AZYTtjc0qCb2bCX2MZbKAqdOV3KnPYhNyzRE2
   X0L8Mv50vSW9N0tM3ZktyiWFo5mPisjZBoivrCgZojtfRpJ3XBeWuQZ6S
   Nz4HqaotINRk1OobnU2XTgwCTOT0A+sUk18NxQB+5x7DfVJY/NktT3SF6
   iltmzMa5P/IPPdfEb+dAfzc7eM2O0KRZMUgLQODs66ltqP3KvyCyh3fsy
   8nsqHRXfpJCJkDNP+W3IrLPJisdXmdRZM/hV5SDrpDCW/s1ca9I7+OF5s
   LaHih5q/Rhtqy0m6CvbOzlqu7+DlHpD/woLlZD1RoE18Q3jip7OyWtjKt
   w==;
X-CSE-ConnectionGUID: Ke/8JVkDR16DgslvMSLflA==
X-CSE-MsgGUID: fv+Lx8XMSGOTz0B4pK04lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47303493"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47303493"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 18:22:31 -0800
X-CSE-ConnectionGUID: HKd4THWQQMqaPVHrMhGiaA==
X-CSE-MsgGUID: l2ubIJo5TfGCuSmKCWmt5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="134111749"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Jan 2025 18:22:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tViBl-000Gvv-0W;
	Thu, 09 Jan 2025 02:22:25 +0000
Date: Thu, 9 Jan 2025 10:22:07 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: dwc: endpoint: Add support for BAR type
 BAR_RESIZABLE
Message-ID: <202501090927.zMSzHORM-lkp@intel.com>
References: <20250107181450.3182430-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107181450.3182430-11-cassel@kernel.org>

Hi Niklas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20250108]
[cannot apply to pci/for-linus linus/master v6.13-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Niklas-Cassel/PCI-endpoint-Add-BAR-type-BAR_RESIZABLE/20250108-021844
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250107181450.3182430-11-cassel%40kernel.org
patch subject: [PATCH 3/6] PCI: dwc: endpoint: Add support for BAR type BAR_RESIZABLE
config: arm-randconfig-003-20250109 (https://download.01.org/0day-ci/archive/20250109/202501090927.zMSzHORM-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501090927.zMSzHORM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501090927.zMSzHORM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-designware-ep.c:14:
   In file included from drivers/pci/controller/dwc/pcie-designware.h:17:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/pci/controller/dwc/pcie-designware-ep.c:259:27: warning: result of comparison of constant 140737488355328 with expression of type 'size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     259 |         if (size < SZ_1M || size > (SZ_128G * 1024))
         |                             ~~~~ ^ ~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +259 drivers/pci/controller/dwc/pcie-designware-ep.c

   249	
   250	static u32 dw_pcie_ep_bar_size_to_rebar_cap(size_t size)
   251	{
   252		u32 val;
   253	
   254		/*
   255		 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
   256		 * thus disallow a requested BAR size smaller than 1 MB.
   257		 * Disallow a requested BAR size larger than 128 TB.
   258		 */
 > 259		if (size < SZ_1M || size > (SZ_128G * 1024))
   260			return 0;
   261	
   262		val = ilog2(size);
   263		val -= 20;
   264	
   265		/* Sizes in REBAR_CAP start at BIT(4). */
   266		return BIT(val + 4);
   267	}
   268	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

