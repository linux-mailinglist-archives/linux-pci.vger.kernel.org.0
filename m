Return-Path: <linux-pci+bounces-24530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7761A6DC93
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD823AA616
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584225F78D;
	Mon, 24 Mar 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+4OM8Ie"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50444C7C;
	Mon, 24 Mar 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825232; cv=none; b=pCgZVLsHI2mDfsmkm/1WnPzq67egI3JojUq0aJOaVZga3Y5pjiE5bpvRwcs+FPiK6++28t6iOh4rVOXfzH62iMcris7tCHXn3HQTphWdsg+RGaByxFHfO/ec7Ckug8N35i2SdBGmMdQ1yQRv5ZfsfA+3d24qu3FTnf/KLMdOw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825232; c=relaxed/simple;
	bh=jHYmZAm72tXV8VRTMDAeJrYugQzQdJqdki7GVsa3neo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf8yqsfzWzkbU3wkiIq62E1B7fjnWpILzktD1JD4iK2w+2iRDk8IL5QZ2tomFZPQN94TiXxJ7lXk5k8OB+hWADTiYDMySNRt3YPk0Dk7Xn+jesOp8+imYcZQvIKCIZWC2Ovfc6yzuHUuSJoOtbxqgc8VDYsEAv/VpVzgyrwiWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+4OM8Ie; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742825231; x=1774361231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jHYmZAm72tXV8VRTMDAeJrYugQzQdJqdki7GVsa3neo=;
  b=F+4OM8IejLNcGnk076MO4JVe8DwxQJ+ig/L/GIv49ReTsxOKhz+kkha2
   rI/llFnwjntmbBcF0xdDTsdMiMBW7VlF7QYHR1XPntc3VTLoYCF2/W/7T
   CWo7/gsOsgT7PgIuUifMhy/R5FHoyy2alT2Tdiz+knZ5HPpgjCv2Z0Qwd
   ZsVI93YKy3GEpiyK90ItIsfqfCIyqncETk0xpbnnUNNeIvqv+YRO8eMaw
   U8qgBMYPfs80xSO9bzaEen5ueYGJVjpHyanEN5cI9v2WoAW7l4KVDuQSp
   dRm/yYR6OzotUmwr+iXxSzb6tGzT9fmia5O/HvHDeeNF3mRH+Uy+l5+pT
   Q==;
X-CSE-ConnectionGUID: Ay+Ghp/URGGWywbfRk3CfQ==
X-CSE-MsgGUID: rWN6WtrQQqGSyGnm1D4dVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="46775513"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="46775513"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:07:10 -0700
X-CSE-ConnectionGUID: S83qCIn5RBKupRlz1oqrEA==
X-CSE-MsgGUID: 08XG4bZ+SR+gTS0loiFomQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124520586"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 24 Mar 2025 07:07:08 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twiS5-0003eP-0D;
	Mon, 24 Mar 2025 14:06:53 +0000
Date: Mon, 24 Mar 2025 22:06:03 +0800
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
Message-ID: <202503242112.lOewj3sy-lkp@intel.com>
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
config: csky-randconfig-001-20250324 (https://download.01.org/0day-ci/archive/20250324/202503242112.lOewj3sy-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503242112.lOewj3sy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503242112.lOewj3sy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/perf/dwc_pcie_pmu.c:16:
>> include/linux/pcie-dwc.h:38:38: warning: 'dwc_pcie_ptm_vsec_ids' defined but not used [-Wunused-const-variable=]
      38 | static const struct dwc_pcie_vsec_id dwc_pcie_ptm_vsec_ids[] = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~


vim +/dwc_pcie_ptm_vsec_ids +38 include/linux/pcie-dwc.h

    37	
  > 38	static const struct dwc_pcie_vsec_id dwc_pcie_ptm_vsec_ids[] = {
    39		{ .vendor_id = PCI_VENDOR_ID_QCOM, /* EP */
    40		  .vsec_id = 0x03, .vsec_rev = 0x1 },
    41		{ .vendor_id = PCI_VENDOR_ID_QCOM, /* RC */
    42		  .vsec_id = 0x04, .vsec_rev = 0x1 },
    43		{ }
    44	};
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

