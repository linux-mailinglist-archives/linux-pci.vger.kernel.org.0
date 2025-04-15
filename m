Return-Path: <linux-pci+bounces-25919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC2A89743
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47917A8F96
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E727A934;
	Tue, 15 Apr 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCNG06Zg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C427587B;
	Tue, 15 Apr 2025 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707454; cv=none; b=rQquDOXlYNT5BO+7lN9pIJh4seDVFBOwyZ4aZ3cMcU4wkOf91/3x2SMe/bOTvOSGvrYOzshItjAkZEeufb2uTcbkFt7V2aWXz6/9haKlIrZkEoobyyyxdozUSPUmrOBvORLPXNIu17Km1lQa5Fen+xqGYiY7PI301mVamGtDngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707454; c=relaxed/simple;
	bh=eMyCf7JgTaYNzOO8bQT/94aK8xIHbnRnd+ieVFJguP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA+v8Iy40ZUqPZW/CBFkEM3W8z82I7RliaTpQYZCh9FNLtV8M7QGNNugB5TWf0Yd+AGF1IGurBenhvPqt8SjdPU8+U4o1gsAUFNGDg/L0VrbF3W3inWem09uKYpwtujSazatkoq41VYXuTaYQbllgell689hRgtCbxnCH7s3ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCNG06Zg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744707453; x=1776243453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMyCf7JgTaYNzOO8bQT/94aK8xIHbnRnd+ieVFJguP0=;
  b=JCNG06Zghq3J9Wyvd+38ShIcwlbg6e/brJXVYFiunC0iF7c0W7bCj/m4
   EcZgAUVLMh2clNnyibtIxhQR69vZmTobsRTTcvxSDYn/R/h9+aNOK4ISl
   888eua3gsakUfZlfkoGaGAIQEoIJa/WjX2ZEAbxk89gZbdcEmV8COEWal
   LKJMMAmAQyzUBXeLL8CHabKWSDG4+sXFdIHOTS14KaIy/1lhJztr+GAJR
   wTlBtKom8qdPRITV8zCveEIv4JRpWdfhd5DLwmj5/PfODcUw/lfFwXTHR
   ML9y5YeeKT0XTVhhPLqqOPf3PXNhIbM/vXecLGneOOJu5L7YJPovTTmsc
   A==;
X-CSE-ConnectionGUID: O7UF0gGBSPGmAkc/Jzixzg==
X-CSE-MsgGUID: MRjtePyaQc+v53qrh1+itQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="56865428"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="56865428"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:56:25 -0700
X-CSE-ConnectionGUID: 1qM+DGONSr21Dv5eCUNEng==
X-CSE-MsgGUID: tEM4dnMdQlG2I38t2Bo5iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="135242196"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Apr 2025 01:56:19 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4c5Z-000FSI-0u;
	Tue, 15 Apr 2025 08:56:17 +0000
Date: Tue, 15 Apr 2025 16:55:47 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: oe-kbuild-all@lists.linux.dev, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 8/9] PCI: pwrctrl: Add power control driver for tc9563
Message-ID: <202504151624.8fF601aD-lkp@intel.com>
References: <20250412-qps615_v4_1-v5-8-5b6a06132fec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-8-5b6a06132fec@oss.qualcomm.com>

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on f4d2ef48250ad057e4f00087967b5ff366da9f39]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/dt-bindings-PCI-Add-binding-for-Toshiba-TC9563-PCIe-switch/20250414-123816
base:   f4d2ef48250ad057e4f00087967b5ff366da9f39
patch link:    https://lore.kernel.org/r/20250412-qps615_v4_1-v5-8-5b6a06132fec%40oss.qualcomm.com
patch subject: [PATCH v5 8/9] PCI: pwrctrl: Add power control driver for tc9563
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20250415/202504151624.8fF601aD-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250415/202504151624.8fF601aD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504151624.8fF601aD-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c: In function 'tc9563_pwrctrl_set_l0s_l1_entry_delay':
>> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:257:34: error: implicit declaration of function 'u32_replace_bits' [-Wimplicit-function-declaration]
     257 |                         rd_val = u32_replace_bits(rd_val, units, TC9563_ETH_L1_DELAY_MASK);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c: In function 'tc9563_pwrctrl_power_off':
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:419:9: error: implicit declaration of function 'gpiod_set_value' [-Wimplicit-function-declaration]
     419 |         gpiod_set_value(ctx->reset_gpio, 1);
         |         ^~~~~~~~~~~~~~~
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c: In function 'tc9563_pwrctrl_probe':
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:535:27: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'em_pd_get'? [-Wimplicit-function-declaration]
     535 |         ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
         |                           ^~~~~~~~~~~~~~
         |                           em_pd_get
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:535:56: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
     535 |         ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
         |                                                        ^~~~~~~~~~~~~~
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:535:56: note: each undeclared identifier is reported only once for each function it appears in


vim +/u32_replace_bits +257 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c

   238	
   239	static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl_ctx *ctx,
   240							 enum tc9563_pwrctrl_ports port, bool is_l1, u32 ns)
   241	{
   242		u32 rd_val, units;
   243		int ret;
   244	
   245		if (ns < 256)
   246			return 0;
   247	
   248		/* convert to units of 256ns */
   249		units = ns / 256;
   250	
   251		if (port == TC9563_ETHERNET) {
   252			ret = tc9563_pwrctrl_i2c_read(ctx->client, TC9563_EMBEDDED_ETH_DELAY, &rd_val);
   253			if (ret)
   254				return ret;
   255	
   256			if (is_l1)
 > 257				rd_val = u32_replace_bits(rd_val, units, TC9563_ETH_L1_DELAY_MASK);
   258			else
   259				rd_val = u32_replace_bits(rd_val, units, TC9563_ETH_L0S_DELAY_MASK);
   260	
   261			return tc9563_pwrctrl_i2c_write(ctx->client, TC9563_EMBEDDED_ETH_DELAY, rd_val);
   262		}
   263	
   264		ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT, BIT(port));
   265		if (ret)
   266			return ret;
   267	
   268		return tc9563_pwrctrl_i2c_write(ctx->client,
   269					       is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY, units);
   270	}
   271	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

