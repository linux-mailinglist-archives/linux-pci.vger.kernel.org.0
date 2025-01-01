Return-Path: <linux-pci+bounces-19145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA89FF4E6
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 21:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A00B3A2899
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C11E25F8;
	Wed,  1 Jan 2025 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTrQOAK8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122A2110E;
	Wed,  1 Jan 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735765021; cv=none; b=RGdB4+xr8ahScAk0yzLNbuGixn+haD0KZ4O3PMmLVFNKpaO7xvc+dT/SvasqOUI7SP1JbIit/svBWBFttjXC5PwpF55wmFWuMp8ojWqmVHubEN1hy3iOIZXumg8HQ6nPLA1JQ9TVlMUBOXKIHDuvGfpuAlcv/0k01zNP6FcIWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735765021; c=relaxed/simple;
	bh=ihBTRNy+UMwbWkEtTL4jC+hWVc3E9whiFjUkfrN+9G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnLSKhHKKlV48HSkOQjTtt4Ryogg0ZPVtJgqCDg/nRjT4AI0H+1zUJuq2d2HFWdJE1qyvGALrydTbkZ5c+7Px0J6zrVJDgOt/NRacOTe169HeEIUxUhA/CJGexDyhNHNZMliCdmYCFkw3Hlmrxe3mZdblEMDMuVi+ER4ENvyvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTrQOAK8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735765019; x=1767301019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihBTRNy+UMwbWkEtTL4jC+hWVc3E9whiFjUkfrN+9G0=;
  b=HTrQOAK8IbJMWRZC7Sly5OSm8C40Wy8bwQyrFID5pbGoKhwedYHoCG+0
   uLIKbupOiaUqrte8HTrosPiCrBn8fOtIJnlxev18zyDEi9pVHH0t6R97S
   Eltj5gcpmk1nj4qOyXKtsVcGQRMUJWpd2zdF+J7AcWbJQNUJ0D4Pe3/wX
   2V7KtuP1giEvNpvOsNYAhfjZSUS4rLXBo3aoLnguJJgy1bWo3Mcm0CVc0
   4RXk5rJGpTbJA3dSQIDHlr5NAi6pWx+YYDjCjNx2hNsXPRDW1M2d7YW0U
   UksoSq0bihni0wnZjTdMk9VH09qWpmM30mCP24VZO+cVbG4z+3pwMm83w
   Q==;
X-CSE-ConnectionGUID: bPqUC7j6QtGruR3NfyCgNQ==
X-CSE-MsgGUID: 1mTlTw8xTOOfvYvE8wmOEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36028661"
X-IronPort-AV: E=Sophos;i="6.12,283,1728975600"; 
   d="scan'208";a="36028661"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 12:56:59 -0800
X-CSE-ConnectionGUID: hcQFNE7wTBOHPybxFf2cuA==
X-CSE-MsgGUID: puq7BG6LQ0GFFhhlaC26jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132269551"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jan 2025 12:56:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tT5ls-00084J-2O;
	Wed, 01 Jan 2025 20:56:52 +0000
Date: Thu, 2 Jan 2025 04:56:44 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 6/6] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
Message-ID: <202501020407.HmQQQKa0-lkp@intel.com>
References: <20241231-pci-pwrctrl-slot-v2-6-6a15088ba541@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231-pci-pwrctrl-slot-v2-6-6a15088ba541@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/regulator-Guard-of_regulator_bulk_get_all-with-CONFIG_OF/20241231-174751
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/20241231-pci-pwrctrl-slot-v2-6-6a15088ba541%40linaro.org
patch subject: [PATCH v2 6/6] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
config: x86_64-randconfig-074-20250102 (https://download.01.org/0day-ci/archive/20250102/202501020407.HmQQQKa0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250102/202501020407.HmQQQKa0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501020407.HmQQQKa0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pwrctrl/slot.c: In function 'pci_pwrctrl_slot_probe':
>> drivers/pci/pwrctrl/slot.c:39:15: error: implicit declaration of function 'of_regulator_bulk_get_all'; did you mean 'regulator_bulk_get'? [-Werror=implicit-function-declaration]
      39 |         ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
         |               regulator_bulk_get
   cc1: some warnings being treated as errors


vim +39 drivers/pci/pwrctrl/slot.c

    28	
    29	static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
    30	{
    31		struct pci_pwrctrl_slot_data *slot;
    32		struct device *dev = &pdev->dev;
    33		int ret;
    34	
    35		slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
    36		if (!slot)
    37			return -ENOMEM;
    38	
  > 39		ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
    40						&slot->supplies);
    41		if (ret < 0) {
    42			dev_err_probe(dev, ret, "Failed to get slot regulators\n");
    43			return ret;
    44		}
    45	
    46		slot->num_supplies = ret;
    47		ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
    48		if (ret < 0) {
    49			dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
    50			goto err_regulator_free;
    51		}
    52	
    53		ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
    54					       slot);
    55		if (ret)
    56			goto err_regulator_disable;
    57	
    58		pci_pwrctrl_init(&slot->ctx, dev);
    59	
    60		ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
    61		if (ret)
    62			return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
    63	
    64		return 0;
    65	
    66	err_regulator_disable:
    67		regulator_bulk_disable(slot->num_supplies, slot->supplies);
    68	err_regulator_free:
    69		regulator_bulk_free(slot->num_supplies, slot->supplies);
    70	
    71		return ret;
    72	}
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

