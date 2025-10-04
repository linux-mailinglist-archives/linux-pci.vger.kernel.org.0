Return-Path: <linux-pci+bounces-37595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB540BB89A6
	for <lists+linux-pci@lfdr.de>; Sat, 04 Oct 2025 06:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39B074E5A35
	for <lists+linux-pci@lfdr.de>; Sat,  4 Oct 2025 04:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1321ADCB;
	Sat,  4 Oct 2025 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhJhfSVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DE21C9F9;
	Sat,  4 Oct 2025 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552962; cv=none; b=NZM6e2WK1PFx42nl1OQqX+VlBmOXxVgHGtntmv796IO19kF7B7FAu0JswydYxXFlUZYzG16Ao0qpDEbpsMb3OFEt/e6vg39LZEYN3jqXbMuvSqHyo+p/F7RaTRpdsV9tPGy3jkTTUbW2XCpLhrd+GdkuV7dub5TKLMmIsXRF1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552962; c=relaxed/simple;
	bh=PNvfYT2zxLYtc1zFaIJE5ItnL96oO0muyalbaJ3ykVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Byf3pDrZ8HV8U5cIpbexCRt9MlG6rG8a83KML/e7WhoeO+Cd645yW5cJiKG5vlXj+KzkO+5bCEalSxvnl7Y27f4AQgtRzww/Ba1Zh836cM15Pt+gVFGqqGWVI+iqgsQcgUrOjdgLDseVEDs8MRnpfZvzFXzYUNiMeJIh1w1vNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhJhfSVb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759552960; x=1791088960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PNvfYT2zxLYtc1zFaIJE5ItnL96oO0muyalbaJ3ykVo=;
  b=QhJhfSVb5Np1rEsim9fDTVu+DTSf+nOsib2tssAn8KNkAC8NwxDsYtW5
   CWivzcVWT1x6Q5iw0SWweh2RPpYnoMYGdbWSxzgAbxhf2laT+EwLvwKNV
   R3Ge8wDkdoDiDOaTzF7sARCM9G7WQ+n39mhQVMUcjLbKl7s1sfIvbPbsY
   cN5Yy4FOrsd2kFkRxSKQ1VxOEcbhLbCDGuFs70rZYuyF4Eoqs1soSNaL0
   c+nbfsbfUTEVVVFWGuSLctSJs40zYmev1/3BGVwJy7NOrrc/uLvbdPsbk
   wIDs1z4u3i3MHoiWSKMcSkwTYj8NjtWmrq+mamfPy9OwsC05YDjSOaUc7
   A==;
X-CSE-ConnectionGUID: rvRRkBxVQayFlLYRqYD3WA==
X-CSE-MsgGUID: t1rR+NHOSvelmTLDhAkYiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="73181653"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="73181653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 21:42:39 -0700
X-CSE-ConnectionGUID: 8X8Sje8WQD+jHHwvJFYn0A==
X-CSE-MsgGUID: Bdc8UeCeRLWyRHmYvhv/mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="210420621"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Oct 2025 21:42:36 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4u6M-00055X-0v;
	Sat, 04 Oct 2025 04:42:34 +0000
Date: Sat, 4 Oct 2025 12:42:26 +0800
From: kernel test robot <lkp@intel.com>
To: Radu Rendec <rrendec@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Enable MSI affinity support
Message-ID: <202510041241.KgbWC5KM-lkp@intel.com>
References: <20251003160421.951448-4-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003160421.951448-4-rrendec@redhat.com>

Hi Radu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on pci/next pci/for-linus mani-mhi/mhi-next linus/master v6.17 next-20251003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Rendec/genirq-Add-interrupt-redirection-infrastructure/20251004-000948
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20251003160421.951448-4-rrendec%40redhat.com
patch subject: [PATCH 3/3] PCI: dwc: Enable MSI affinity support
config: i386-randconfig-002-20251004 (https://download.01.org/0day-ci/archive/20251004/202510041241.KgbWC5KM-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251004/202510041241.KgbWC5KM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510041241.KgbWC5KM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-host.c:137:13: warning: 'dw_pci_pre_redirect' defined but not used [-Wunused-function]
     137 | static void dw_pci_pre_redirect(struct irq_data *d)
         |             ^~~~~~~~~~~~~~~~~~~


vim +/dw_pci_pre_redirect +137 drivers/pci/controller/dwc/pcie-designware-host.c

   136	
 > 137	static void dw_pci_pre_redirect(struct irq_data *d)
   138	{
   139		struct dw_pcie_rp *pp  = irq_data_get_irq_chip_data(d);
   140		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
   141		unsigned int res, bit, ctrl;
   142	
   143		ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
   144		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
   145		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
   146	
   147		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
   148	}
   149	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

