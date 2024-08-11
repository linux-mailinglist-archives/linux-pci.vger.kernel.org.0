Return-Path: <linux-pci+bounces-11577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACD94DF80
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 03:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B600B20B4A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 01:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09FE8F48;
	Sun, 11 Aug 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvT7gL2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5179F4;
	Sun, 11 Aug 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723341419; cv=none; b=l5DO5oCT82XYrAOyI4nrU/OsgWxA+pSDdttqVpU7pDjSu+lYHm9x86+p0AAyDa/FCeIxdGgokKnX4ylUGqhbUNYPIPqXKX6Qbg5Fw5OIQo9CKDoFhkCUCnEaEDtU4FE2D0ogWHgj7SSEVYuHO2C5lYgL+uD+NjgYGcnyq6V32Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723341419; c=relaxed/simple;
	bh=59PP7CaPhlDP4SUY1u/O8YQ9mjsKRPQfXKJTDBytGhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE8Mjq/BNx69/ookf6E6s1wfPQLZfGzwLaZqjdPsw0weLd08PVWcgQdETb+mTCW4F6/kBqiQxE5m6h+PFBqdkLtDPSxCmPXESItqJWt4qiSVnSH+nJ0g4p1R1TOtAmF0yTzi6dl99311yvWEsqk0/foXrVdn7ojdnrkJRk//wHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvT7gL2B; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723341417; x=1754877417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59PP7CaPhlDP4SUY1u/O8YQ9mjsKRPQfXKJTDBytGhA=;
  b=fvT7gL2BF7sMN38+Mm+n6NJG9vWwC2uHwkjaKcvCr8NEXgLcnmgn7fTr
   nIHEsazUhOpMgOR2BPDX4F+454UBcl2kttf2Z6fGmGiXJpm71QSeEf2mr
   gcIRraCoZywgRFpD2zuJAr3nOwXrgfchYPRFaEa4vxnPfuMdJSM6Ojxix
   U0uDUEgZOIsZA/Nztck9MD1QkFFmKdGZZLCG2RALUgHQZ0R0hpXpmF2T3
   ShLuIUOPcCq9iycfouVmvteD90GiXj6r3kTBuS5JhtNqiB6Ml9V6D3/0l
   VqRGO86/jkC8QxyI1tP+PEWYbMX7wMky7po5tbQ5/pJwnrqy8ZsJviHYC
   Q==;
X-CSE-ConnectionGUID: a0EthqJ/QwOgc15+BcPWtA==
X-CSE-MsgGUID: /b/AP466RdiB4HqIOrZ5YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="32058934"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="32058934"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 18:56:56 -0700
X-CSE-ConnectionGUID: SdMMT+ARR/6mOsKGnILDUQ==
X-CSE-MsgGUID: /zYR/EjbSXaY1/KNkoqy8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="57815696"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 10 Aug 2024 18:56:53 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scxpC-000AU3-0n;
	Sun, 11 Aug 2024 01:56:50 +0000
Date: Sun, 11 Aug 2024 09:56:20 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <202408110938.hFwAHjZo-lkp@intel.com>
References: <20240731-pci-qcom-hotplug-v3-5-a1426afdee3b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-pci-qcom-hotplug-v3-5-a1426afdee3b@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-ep-Drop-the-redundant-masking-of-global-IRQ-events/20240802-024847
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/20240731-pci-qcom-hotplug-v3-5-a1426afdee3b%40linaro.org
patch subject: [PATCH v3 05/13] PCI: endpoint: Assign PCI domain number for endpoint controllers
config: x86_64-randconfig-161-20240810 (https://download.01.org/0day-ci/archive/20240811/202408110938.hFwAHjZo-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408110938.hFwAHjZo-lkp@intel.com/

smatch warnings:
drivers/pci/endpoint/pci-epc-core.c:914 __pci_epc_create() warn: inconsistent indenting

vim +914 drivers/pci/endpoint/pci-epc-core.c

   870	
   871	/**
   872	 * __pci_epc_create() - create a new endpoint controller (EPC) device
   873	 * @dev: device that is creating the new EPC
   874	 * @ops: function pointers for performing EPC operations
   875	 * @owner: the owner of the module that creates the EPC device
   876	 *
   877	 * Invoke to create a new EPC device and add it to pci_epc class.
   878	 */
   879	struct pci_epc *
   880	__pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
   881			 struct module *owner)
   882	{
   883		int ret;
   884		struct pci_epc *epc;
   885	
   886		if (WARN_ON(!dev)) {
   887			ret = -EINVAL;
   888			goto err_ret;
   889		}
   890	
   891		epc = kzalloc(sizeof(*epc), GFP_KERNEL);
   892		if (!epc) {
   893			ret = -ENOMEM;
   894			goto err_ret;
   895		}
   896	
   897		mutex_init(&epc->lock);
   898		mutex_init(&epc->list_lock);
   899		INIT_LIST_HEAD(&epc->pci_epf);
   900	
   901		device_initialize(&epc->dev);
   902		epc->dev.class = &pci_epc_class;
   903		epc->dev.parent = dev;
   904		epc->dev.release = pci_epc_release;
   905		epc->ops = ops;
   906	
   907		#ifdef CONFIG_PCI_DOMAINS_GENERIC
   908			epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
   909		#else
   910			/*
   911			 * TODO: If the architecture doesn't support generic PCI
   912			 * domains, then a custom implementation has to be used.
   913			 */
 > 914			WARN_ONCE(1, "This architecture doesn't support generic PCI domains\n");
   915		#endif
   916	
   917		ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
   918		if (ret)
   919			goto put_dev;
   920	
   921		ret = device_add(&epc->dev);
   922		if (ret)
   923			goto put_dev;
   924	
   925		epc->group = pci_ep_cfs_add_epc_group(dev_name(dev));
   926	
   927		return epc;
   928	
   929	put_dev:
   930		put_device(&epc->dev);
   931	
   932	err_ret:
   933		return ERR_PTR(ret);
   934	}
   935	EXPORT_SYMBOL_GPL(__pci_epc_create);
   936	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

