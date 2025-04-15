Return-Path: <linux-pci+bounces-25918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1EA89705
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8CD189DDBB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5220727A119;
	Tue, 15 Apr 2025 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4sN4Akx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2771DE8B0;
	Tue, 15 Apr 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706666; cv=none; b=ZtB3RWlh+UHSKXgmj+NsnEkJBdiiMObVEH/aH0+ma+Ipkjt1H3v6kV/yYxQeuRRIpMhY6E9W/KNpxB+e/5ihVpjuS5J5aeJLPk55hd7qKNLH7fjy0O7RHYUjcqpvAzu6sLzEFH9iukTuz+nn2x24T7Hl6FbtAoiKrDH/AJhvDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706666; c=relaxed/simple;
	bh=tTQC2d50IWaHk+pOnbgalVH8CC4lcqM8R16udFXoxsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5AhF9ofcBBqVlzbTC3yUzaRRKkwmA8Pw3lJf0p5kqbbmKRgt4O00YNeXh2Oz2QxrzlBc27APUTkAk8HHgGA3DQUSnJTh4RwTOXF9k5rlhRKU7NKyZpO/HV8nYBeXPPTxmIHu5BUXd5yL3iAvfNEoJCZsSuQhILqivnCFavKzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4sN4Akx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744706664; x=1776242664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTQC2d50IWaHk+pOnbgalVH8CC4lcqM8R16udFXoxsE=;
  b=C4sN4Akx1eCb1wXo5RoaU4yqOpI75yK8y8Ls9KHfpdAtpcUMbGd1VMX3
   KjS8f/Zz8BXMtBh5R32OZVIjoAuYDfp4TkCNF0n6mNjYlRCszMPA84acm
   kFdZTQ8PLrrxhOXQ8zipAALT76GuNBrqub/Kj+OnbKoIXw+XSWAF6P76q
   HSTB/Zq3cjVaW3XGWfZQQ1mXAAb+sgSCDGGf02G9+qGBmwuoHZ4Ps5mk1
   KJ/BKbrkItSwvnnqJG9uJ9gZ0BlIf8QfnoseOV60abSFHA3AFzX21XB91
   41/v+ButXFA8ok0M28YMEch/7LUdWwHIA+vGhLIaXjQMTYHovq1D0XmbB
   w==;
X-CSE-ConnectionGUID: PrtPQIieQEa/gYTBwV/peQ==
X-CSE-MsgGUID: M+2r/EByT6OmFFpFfGx8Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="63745014"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="63745014"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:44:23 -0700
X-CSE-ConnectionGUID: Dd7Wr1IVSUeIPUZVeoOEZQ==
X-CSE-MsgGUID: xlzBoADzQ/GGkY8cyvRjUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130593508"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Apr 2025 01:44:18 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4btv-000FQo-2S;
	Tue, 15 Apr 2025 08:44:15 +0000
Date: Tue, 15 Apr 2025 16:44:03 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_vbadigan@quicnic.com, amitk@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	jorge.ramirez@oss.qualcomm.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 8/9] PCI: pwrctrl: Add power control driver for tc9563
Message-ID: <202504151632.tCoey9d8-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250415/202504151632.tCoey9d8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250415/202504151632.tCoey9d8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504151632.tCoey9d8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:419:2: error: call to undeclared function 'gpiod_set_value'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     419 |         gpiod_set_value(ctx->reset_gpio, 1);
         |         ^
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:433:2: error: call to undeclared function 'gpiod_set_value'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     433 |         gpiod_set_value(ctx->reset_gpio, 0);
         |         ^
>> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:535:20: error: call to undeclared function 'devm_gpiod_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     535 |         ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
         |                           ^
>> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:535:49: error: use of undeclared identifier 'GPIOD_OUT_HIGH'
     535 |         ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
         |                                                        ^
   4 errors generated.


vim +/gpiod_set_value +419 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c

   416	
   417	static void tc9563_pwrctrl_power_off(struct tc9563_pwrctrl_ctx *ctx)
   418	{
 > 419		gpiod_set_value(ctx->reset_gpio, 1);
   420	
   421		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
   422	}
   423	
   424	static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
   425	{
   426		struct tc9563_pwrctrl_cfg *cfg;
   427		int ret, i;
   428	
   429		ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
   430		if (ret < 0)
   431			return dev_err_probe(ctx->pwrctrl.dev, ret, "cannot enable regulators\n");
   432	
   433		gpiod_set_value(ctx->reset_gpio, 0);
   434	
   435		 /* wait for the internal osc frequency to stablise */
   436		usleep_range(10000, 10500);
   437	
   438		ret = tc9563_pwrctrl_assert_deassert_reset(ctx, false);
   439		if (ret)
   440			goto power_off;
   441	
   442		for (i = 0; i < TC9563_MAX; i++) {
   443			cfg = &ctx->cfg[i];
   444			ret = tc9563_pwrctrl_disable_port(ctx, i);
   445			if (ret) {
   446				dev_err(ctx->pwrctrl.dev, "Disabling port failed\n");
   447				goto power_off;
   448			}
   449	
   450			ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
   451			if (ret) {
   452				dev_err(ctx->pwrctrl.dev, "Setting L0s entry delay failed\n");
   453				goto power_off;
   454			}
   455	
   456			ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
   457			if (ret) {
   458				dev_err(ctx->pwrctrl.dev, "Setting L1 entry delay failed\n");
   459				goto power_off;
   460			}
   461	
   462			ret = tc9563_pwrctrl_set_tx_amplitude(ctx, i, cfg->tx_amp);
   463			if (ret) {
   464				dev_err(ctx->pwrctrl.dev, "Setting Tx amplitube failed\n");
   465				goto power_off;
   466			}
   467	
   468			ret = tc9563_pwrctrl_set_nfts(ctx, i, cfg->nfts);
   469			if (ret) {
   470				dev_err(ctx->pwrctrl.dev, "Setting nfts failed\n");
   471				goto power_off;
   472			}
   473	
   474			ret = tc9563_pwrctrl_disable_dfe(ctx, i);
   475			if (ret) {
   476				dev_err(ctx->pwrctrl.dev, "Disabling DFE failed\n");
   477				goto power_off;
   478			}
   479		}
   480	
   481		ret = tc9563_pwrctrl_assert_deassert_reset(ctx, true);
   482		if (!ret)
   483			return 0;
   484	
   485	power_off:
   486		tc9563_pwrctrl_power_off(ctx);
   487		return ret;
   488	}
   489	
   490	static int tc9563_pwrctrl_probe(struct platform_device *pdev)
   491	{
   492		struct pci_host_bridge *bridge = to_pci_host_bridge(pdev->dev.parent);
   493		struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
   494		struct pci_bus *bus = bridge->bus;
   495		struct device *dev = &pdev->dev;
   496		enum tc9563_pwrctrl_ports port;
   497		struct tc9563_pwrctrl_ctx *ctx;
   498		struct device_node *i2c_node;
   499		int ret, addr;
   500	
   501		ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
   502		if (!ctx)
   503			return -ENOMEM;
   504	
   505		ret = of_property_read_u32_index(pdev->dev.of_node, "i2c-parent", 1, &addr);
   506		if (ret)
   507			return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
   508	
   509		i2c_node = of_parse_phandle(dev->of_node, "i2c-parent", 0);
   510		ctx->adapter = of_find_i2c_adapter_by_node(i2c_node);
   511		of_node_put(i2c_node);
   512		if (!ctx->adapter)
   513			return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
   514	
   515		ctx->client = i2c_new_dummy_device(ctx->adapter, addr);
   516		if (IS_ERR(ctx->client)) {
   517			dev_err(dev, "Failed to create I2C client\n");
   518			i2c_put_adapter(ctx->adapter);
   519			return PTR_ERR(ctx->client);
   520		}
   521	
   522		ctx->supplies[0].supply = "vddc";
   523		ctx->supplies[1].supply = "vdd18";
   524		ctx->supplies[2].supply = "vdd09";
   525		ctx->supplies[3].supply = "vddio1";
   526		ctx->supplies[4].supply = "vddio2";
   527		ctx->supplies[5].supply = "vddio18";
   528		ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies), ctx->supplies);
   529		if (ret) {
   530			dev_err_probe(dev, ret,
   531				      "failed to get supply regulator\n");
   532			goto remove_i2c;
   533		}
   534	
 > 535		ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
   536		if (IS_ERR(ctx->reset_gpio)) {
   537			ret = dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "failed to get reset GPIO\n");
   538			goto remove_i2c;
   539		}
   540	
   541		pci_pwrctrl_init(&ctx->pwrctrl, dev);
   542	
   543		port = TC9563_USP;
   544		ret = tc9563_pwrctrl_parse_device_dt(ctx, pdev->dev.of_node, port);
   545		if (ret) {
   546			dev_err(dev, "failed to parse device tree properties: %d\n", ret);
   547			goto remove_i2c;
   548		}
   549	
   550		/*
   551		 * Downstream ports are always children of the upstream port.
   552		 * The first node represents DSP1, the second node represents DSP2, and so on.
   553		 */
   554		for_each_child_of_node_scoped(pdev->dev.of_node, child) {
   555			ret = tc9563_pwrctrl_parse_device_dt(ctx, child, port++);
   556			if (ret)
   557				break;
   558			/* Embedded ethernet device are under DSP3 */
   559			if (port == TC9563_DSP3)
   560				for_each_child_of_node_scoped(child, child1) {
   561					ret = tc9563_pwrctrl_parse_device_dt(ctx, child1, port++);
   562					if (ret)
   563						break;
   564				}
   565		}
   566		if (ret) {
   567			dev_err(dev, "failed to parse device tree properties: %d\n", ret);
   568			goto remove_i2c;
   569		}
   570	
   571		if (!pcie_link_is_active(pci_dev) && bridge->ops->stop_link)
   572			bridge->ops->stop_link(bus);
   573	
   574		ret = tc9563_pwrctrl_bring_up(ctx);
   575		if (ret)
   576			goto remove_i2c;
   577	
   578		if (!pcie_link_is_active(pci_dev) && bridge->ops->start_link) {
   579			ret = bridge->ops->start_link(bus);
   580			if (ret)
   581				goto power_off;
   582		}
   583	
   584		ret = devm_pci_pwrctrl_device_set_ready(dev, &ctx->pwrctrl);
   585		if (ret)
   586			goto power_off;
   587	
   588		platform_set_drvdata(pdev, ctx);
   589	
   590		return 0;
   591	
   592	power_off:
   593		tc9563_pwrctrl_power_off(ctx);
   594	remove_i2c:
   595		i2c_unregister_device(ctx->client);
   596		i2c_put_adapter(ctx->adapter);
   597		return ret;
   598	}
   599	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

