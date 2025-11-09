Return-Path: <linux-pci+bounces-40652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C452C43F6E
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 15:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F048F3AD86A
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95B1A317D;
	Sun,  9 Nov 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBQt3xoL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08928E9;
	Sun,  9 Nov 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696858; cv=none; b=aa/HQEH9qF7wkTa8SHDM9mTZvNz3blN7QnbHPbGsBvkcp9V2miseLNBnkWdMC1vHteG1KKX9c82MUC/Qz/SLBmnNG0Xbas7/bvROY/0RvkrTXLrEiMks6L4NJOslCxNk6l97Wlqcy/c+C5apD/t5B4XnpwywxvsgTq/KumIJe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696858; c=relaxed/simple;
	bh=qRmvRrnare0TWk/dp4GNb0PQAxXpydFLfOVO9gdJJl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPPdjgC3LuKKTc9RW7en7Byq57mMh2765R3saCVOWEAfdO50vXlJJWdG9v/9NB2BFbHd0jalowrlRHLEwJzJsdHQALM87fukW0F7Wfa95iWg1od+OHOEpL0opifWtwZSPtgwOmgaSsh0sTCWiHr7YuXn/dE/FhhYsOrHsXit/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBQt3xoL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762696856; x=1794232856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRmvRrnare0TWk/dp4GNb0PQAxXpydFLfOVO9gdJJl8=;
  b=eBQt3xoLFuZWA8XFt9ADpn325FmRJA36Jss9qCDYWM04gX1RIVuGUIxJ
   rKMdr1zYX74fWe2SRHuLUz4Kvm/sgn3ayPxcUuYSuOjLeh1sYwP+ZuYf3
   V+aa6ySNsQyyEFcdQi+qsbn8Wldl1FP48T1lq4sBMZ9jUGanhnifff0ct
   vNq4Os1j+eTDV+Vuei1FvedAijnTb4m0FavuMmJryZcE9641vXzkN5ikA
   NbH0yrsj+8WU66KYiMQH1R5T5VVoNJ4O0hF1Un7vZ84baXV+cvu0Pze5N
   BpPFwbFbx8bM02zE2dKRDqrKAJLBDjyadFtacFv/F3FXD5woblpWUnIlv
   A==;
X-CSE-ConnectionGUID: H0863HC9Tw+qK9IsLNdDgw==
X-CSE-MsgGUID: JJeb9jjVTSCnZTvT4aLVXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63978175"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="63978175"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 06:00:55 -0800
X-CSE-ConnectionGUID: wak9vCs2R62rKxC/6PUr/g==
X-CSE-MsgGUID: mY/wPM1hQTq/TlKA2wytsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="225718384"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Nov 2025 06:00:51 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI5yL-00023L-0H;
	Sun, 09 Nov 2025 14:00:49 +0000
Date: Sun, 9 Nov 2025 21:59:50 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, helgaas@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 03/10] PCI: cadence: Move PCIe RP common functions to
 a separate file
Message-ID: <202511092106.mkNV0iyb-lkp@intel.com>
References: <20251108140305.1120117-4-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108140305.1120117-4-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6146a0f1dfae5d37442a9ddcba012add260bceb0]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Add-module-support-for-platform-controller-driver/20251108-220607
base:   6146a0f1dfae5d37442a9ddcba012add260bceb0
patch link:    https://lore.kernel.org/r/20251108140305.1120117-4-hans.zhang%40cixtech.com
patch subject: [PATCH v11 03/10] PCI: cadence: Move PCIe RP common functions to a separate file
config: i386-randconfig-014-20251109 (https://download.01.org/0day-ci/archive/20251109/202511092106.mkNV0iyb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511092106.mkNV0iyb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511092106.mkNV0iyb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/cadence/pcie-cadence-host-common.c: In function 'cdns_pcie_host_bar_config':
>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:188:23: warning: variable 'pci_addr' set but not used [-Wunused-but-set-variable]
     188 |         u64 cpu_addr, pci_addr, size, winsize;
         |                       ^~~~~~~~


vim +/pci_addr +188 drivers/pci/controller/cadence/pcie-cadence-host-common.c

   183	
   184	int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
   185				      struct resource_entry *entry,
   186				      cdns_pcie_host_bar_ib_cfg pci_host_ib_config)
   187	{
 > 188		u64 cpu_addr, pci_addr, size, winsize;
   189		struct cdns_pcie *pcie = &rc->pcie;
   190		struct device *dev = pcie->dev;
   191		enum cdns_pcie_rp_bar bar;
   192		unsigned long flags;
   193		int ret;
   194	
   195		cpu_addr = entry->res->start;
   196		pci_addr = entry->res->start - entry->offset;
   197		flags = entry->res->flags;
   198		size = resource_size(entry->res);
   199	
   200		while (size > 0) {
   201			/*
   202			 * Try to find a minimum BAR whose size is greater than
   203			 * or equal to the remaining resource_entry size. This will
   204			 * fail if the size of each of the available BARs is less than
   205			 * the remaining resource_entry size.
   206			 *
   207			 * If a minimum BAR is found, IB ATU will be configured and
   208			 * exited.
   209			 */
   210			bar = cdns_pcie_host_find_min_bar(rc, size);
   211			if (bar != RP_BAR_UNDEFINED) {
   212				ret = pci_host_ib_config(rc, bar, cpu_addr, size, flags);
   213				if (ret)
   214					dev_err(dev, "IB BAR: %d config failed\n", bar);
   215				return ret;
   216			}
   217	
   218			/*
   219			 * If the control reaches here, it would mean the remaining
   220			 * resource_entry size cannot be fitted in a single BAR. So we
   221			 * find a maximum BAR whose size is less than or equal to the
   222			 * remaining resource_entry size and split the resource entry
   223			 * so that part of resource entry is fitted inside the maximum
   224			 * BAR. The remaining size would be fitted during the next
   225			 * iteration of the loop.
   226			 *
   227			 * If a maximum BAR is not found, there is no way we can fit
   228			 * this resource_entry, so we error out.
   229			 */
   230			bar = cdns_pcie_host_find_max_bar(rc, size);
   231			if (bar == RP_BAR_UNDEFINED) {
   232				dev_err(dev, "No free BAR to map cpu_addr %llx\n",
   233					cpu_addr);
   234				return -EINVAL;
   235			}
   236	
   237			winsize = bar_max_size[bar];
   238			ret = pci_host_ib_config(rc, bar, cpu_addr, winsize, flags);
   239			if (ret) {
   240				dev_err(dev, "IB BAR: %d config failed\n", bar);
   241				return ret;
   242			}
   243	
   244			size -= winsize;
   245			cpu_addr += winsize;
   246		}
   247	
   248		return 0;
   249	}
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

