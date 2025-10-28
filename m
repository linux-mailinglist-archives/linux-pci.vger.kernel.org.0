Return-Path: <linux-pci+bounces-39538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6A5C15288
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB171884BF8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA06335BA6;
	Tue, 28 Oct 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVglnw6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F530BBB9;
	Tue, 28 Oct 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661403; cv=none; b=sxvgZ8JfBF24KJ7OXI+9ZDQbd1FeWLr8rJJdSbm39Hxh/tftYIQDuBOY/oa5tCzkM7K5cLy65pcB9mhMZl/o831KZDnhTIqkVBIGNmABJCkSeIxCw0TkyZM70LNSeLLeoUFZHQ4bm3yY8yGzIgKvxDp3hw2dUDdo5omXDbAEV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661403; c=relaxed/simple;
	bh=ZjKITrPWlUyYajJm3Ljrd+gMFKVlc9juJxipai/H3sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMXfNT8uEZFMGEPINVhIsOAD1RdujzWQW8wuyU3FTR2CUEEoaeEp+GT3vAhJW2fPrQ176OkA5hUv0phCR8Ewv/jg7psoo3JcOFxdw7iTbbKSkHZjfsBtk56Lgxzpj0DnEhM2k4R/vt5AVvSGGUAnLSOo23Mu2ubOdzfTzBNF1SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVglnw6/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761661402; x=1793197402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZjKITrPWlUyYajJm3Ljrd+gMFKVlc9juJxipai/H3sg=;
  b=WVglnw6/cW0pRjNcuUvjndQ4ys6FtrEqXOP3JLm5SliZ6zCcqaUK7Ipi
   lZbIB0i8UFm+z3FJK7123kIZS95aQk7Ys94VXr2IlzLyJMa3ufA+q/Z7x
   000WU58EGY28zd4YfyLZsO7y0FM9LUZ1+hCpYMs7UJw9RViKn+HjOSe1+
   YjT+nJ73tPYzzewn9vllGDncxSKD/UKw/F8qs9NimMDeOSpoX98SCWX4U
   ana4xMBTLCDIbWW6T806TuxiJKZgs0N67l8hsQqQ9AFybMh8HZ4utyKey
   pc0vHZBlGMBumjSWeEEFwTdI9DAX1BGJwSSvs5SxGAhgx34oi4xZ8JFbS
   Q==;
X-CSE-ConnectionGUID: ne/BnHNsR0eUQwY4ScpiAQ==
X-CSE-MsgGUID: w6eh6EeQQ8aO8C9sG8Gc1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63798871"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63798871"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:23:21 -0700
X-CSE-ConnectionGUID: rJqVb9lsQW6rF8W3nrYn0g==
X-CSE-MsgGUID: 5bWYwMMeSPSqrq/PhxgLNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184987007"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 Oct 2025 07:23:16 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDkbR-000JE1-2i;
	Tue, 28 Oct 2025 14:23:13 +0000
Date: Tue, 28 Oct 2025 22:22:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org,
	kishon@kernel.org, linus.walleij@linaro.org, p.zabel@pengutronix.de,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jacky_chou@aspeedtech.com
Subject: Re: [PATCH v4 8/9] PCI: aspeed: Add ASPEED PCIe RC driver
Message-ID: <202510282225.yqfv0wel-lkp@intel.com>
References: <20251027095825.181161-9-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027095825.181161-9-jacky_chou@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.18-rc3 next-20251028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-phy-aspeed-Add-ASPEED-PCIe-PHY/20251027-180856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251027095825.181161-9-jacky_chou%40aspeedtech.com
patch subject: [PATCH v4 8/9] PCI: aspeed: Add ASPEED PCIe RC driver
config: loongarch-randconfig-r113-20251028 (https://download.01.org/0day-ci/archive/20251028/202510282225.yqfv0wel-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510282225.yqfv0wel-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510282225.yqfv0wel-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/pcie-aspeed.c:1084:38: sparse: sparse: symbol 'pcie_rc_ast2600' was not declared. Should it be static?
>> drivers/pci/controller/pcie-aspeed.c:1093:38: sparse: sparse: symbol 'pcie_rc_ast2700' was not declared. Should it be static?

vim +/pcie_rc_ast2600 +1084 drivers/pci/controller/pcie-aspeed.c

  1083	
> 1084	const struct aspeed_pcie_rc_platform pcie_rc_ast2600 = {
  1085		.setup = aspeed_ast2600_setup,
  1086		.reg_intx_en = 0xc4,
  1087		.reg_intx_sts = 0xc8,
  1088		.reg_msi_en = 0xe0,
  1089		.reg_msi_sts = 0xe8,
  1090		.msi_address = 0x1e77005c,
  1091	};
  1092	
> 1093	const struct aspeed_pcie_rc_platform pcie_rc_ast2700 = {
  1094		.setup = aspeed_ast2700_setup,
  1095		.reg_intx_en = 0x40,
  1096		.reg_intx_sts = 0x48,
  1097		.reg_msi_en = 0x50,
  1098		.reg_msi_sts = 0x58,
  1099		.msi_address = 0x000000f0,
  1100	};
  1101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

