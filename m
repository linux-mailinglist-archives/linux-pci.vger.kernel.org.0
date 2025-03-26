Return-Path: <linux-pci+bounces-24797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE4A720EE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 22:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F83173FB4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02972620C4;
	Wed, 26 Mar 2025 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDGhT6TH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446F1F460E;
	Wed, 26 Mar 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025411; cv=none; b=opQiULyka7lVxagPsHpNYBryP9TTvxoS0gWAqwAs+2yKPAkw2zDyurfLXdp9GnkIPtotNFKGenYQ+YWJHAjBxtSinL2f/dlqu7EsZlphhjBwH+TDlo28v9zSNg40ZHzszqv7brAfMtSBnsIwtsX7uir0c2iYsFTxr0yIiqV91Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025411; c=relaxed/simple;
	bh=RIm2iQ3s/e/fPL2X39oO+OfIIkezi9eH0r/BTF0Mc78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEjHLs1EbRPULl91kgDvuyJoUqds48QY4N7l0RpfVWmKERo3H0dbMn+esyx5/ZTy39N72ZXiGo3iEEquyuXiGojKsM1Tz8npLtj4su89g3n00/Ho+0JDZpVw25cthpiW+pLsM+lZFEeBsv2FMzAriWLCpqkCbSig+FuFlP7Z6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDGhT6TH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743025410; x=1774561410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RIm2iQ3s/e/fPL2X39oO+OfIIkezi9eH0r/BTF0Mc78=;
  b=EDGhT6THMxO2SFytLw0Gzd3IbGtUfDR9c4TJNPRNaSD5oWSQhoizZ571
   SX6caqptluXstqJGAKbdpRlsEPoaIrxq/EEJLjl8wmQIC1ArfoA16nlix
   uu4TQS5+QCYArLh8sa2MkVyQC9RbZe7DVPZAqGKFIWT38vYDinYsIweJr
   drVPMZ/Ahv+sj3MMneNQRP8Vg8CUovXHHVdJISFMCPO1c8hwN6YMqm07I
   4AnNlTm1S/HALsh69EqzHwYnJRYSGwz5alhMZ9AdusaGlMamDlLCwueNo
   jxbs9AWRR99gA8J4MgCQd98IxWr1z88mk4WEX4qUaQuDNv4/WxSK5iIxx
   g==;
X-CSE-ConnectionGUID: bS4rCjdoSdWOtKzgN79S1A==
X-CSE-MsgGUID: n00tdjo4SmGZKBch+2cD5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44521367"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44521367"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:43:29 -0700
X-CSE-ConnectionGUID: Didorik1Q0CUaWp1ofD6TA==
X-CSE-MsgGUID: LRnfdugRTHWmIjo3hrcb1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124723729"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 26 Mar 2025 14:43:27 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txYWy-000663-38;
	Wed, 26 Mar 2025 21:43:24 +0000
Date: Thu, 27 Mar 2025 05:42:32 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 2/3] PCI: dwc: Add sysfs support for PTM context
Message-ID: <202503270545.z7lzaIQz-lkp@intel.com>
References: <20250324-pcie-ptm-v2-2-c7d8c3644b4a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-pcie-ptm-v2-2-c7d8c3644b4a@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1f5a69f1b3132054d8d82b8d7546d0af6a2ed4f6]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-Add-sysfs-support-for-exposing-PTM-context/20250324-181039
base:   1f5a69f1b3132054d8d82b8d7546d0af6a2ed4f6
patch link:    https://lore.kernel.org/r/20250324-pcie-ptm-v2-2-c7d8c3644b4a%40linaro.org
patch subject: [PATCH v2 2/3] PCI: dwc: Add sysfs support for PTM context
config: i386-randconfig-062-20250326 (https://download.01.org/0day-ci/archive/20250327/202503270545.z7lzaIQz-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250327/202503270545.z7lzaIQz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503270545.z7lzaIQz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-designware-sysfs.c:222:21: sparse: sparse: symbol 'dw_pcie_ptm_ops' was not declared. Should it be static?

vim +/dw_pcie_ptm_ops +222 drivers/pci/controller/dwc/pcie-designware-sysfs.c

   221	
 > 222	struct pcie_ptm_ops dw_pcie_ptm_ops = {
   223		.check_capability = dw_pcie_ptm_check_capability,
   224		.context_update_store = dw_pcie_ptm_context_update_store,
   225		.context_update_show = dw_pcie_ptm_context_update_show,
   226		.context_valid_store = dw_pcie_ptm_context_valid_store,
   227		.context_valid_show = dw_pcie_ptm_context_valid_show,
   228		.local_clock_show = dw_pcie_ptm_local_clock_show,
   229		.master_clock_show = dw_pcie_ptm_master_clock_show,
   230		.t1_show = dw_pcie_ptm_t1_show,
   231		.t2_show = dw_pcie_ptm_t2_show,
   232		.t3_show = dw_pcie_ptm_t3_show,
   233		.t4_show = dw_pcie_ptm_t4_show,
   234		.context_update_visible = dw_pcie_ptm_context_update_visible,
   235		.context_valid_visible = dw_pcie_ptm_context_valid_visible,
   236		.local_clock_visible = dw_pcie_ptm_local_clock_visible,
   237		.master_clock_visible = dw_pcie_ptm_master_clock_visible,
   238		.t1_visible = dw_pcie_ptm_t1_visible,
   239		.t2_visible = dw_pcie_ptm_t2_visible,
   240		.t3_visible = dw_pcie_ptm_t3_visible,
   241		.t4_visible = dw_pcie_ptm_t4_visible,
   242	};
   243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

