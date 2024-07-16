Return-Path: <linux-pci+bounces-10376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B1F932B2B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A54F1C22DE2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B019F47B;
	Tue, 16 Jul 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnSaJsGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB5F9E8;
	Tue, 16 Jul 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144529; cv=none; b=cO/YZLXQZShHtd+9DM6RrayQOpQVqhuRN17Uyir5hSApScKQ58zmzJgjjwJXEDGHxjkDeXdJ61bLIFaohHb835tDNDglvtuJWrxvhaA8C4AKa2MqLULDHbLxfzSuOs7MCGC4Xa4YzQX4LlT0gwrxsCa5E1Wh0ln66M4ebJKgwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144529; c=relaxed/simple;
	bh=3K3HETqJm/ZpKc+V9IVxrUF1fl+PRjx9X/4MZOmKgiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqghypbe1VZteRfUsOX1wjJfc4ZBnTKqucZG7yRzEVBSA5qa3syWofBQEYW8gssEMZQlqD9bs+kIE2awLqMyGR4k6JSvU3/6+sXYlzFp5secNU0+WxvJb7oR+xCVnHqbXGrjVRRBqStT2rIuL4lBJXJunZ+yyD21kEhJOOC+MhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnSaJsGD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721144528; x=1752680528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3K3HETqJm/ZpKc+V9IVxrUF1fl+PRjx9X/4MZOmKgiI=;
  b=YnSaJsGDct8n9k5I33VKgPskUIx89iftfDhcZPu141UhNcofXMYq5PJv
   8FSBPDRrxMzLNFgJc7GUC3ZFf1wPRkixe30boTvLZM92oXJQakG+Wozzc
   gcbcZcpByRv/X2zqjKOEokBatc9ltuWuBdY0rtjArL4w9pAsLPNPxi8QX
   SWFHsCYU7Z4dhB/PK2cWLj63HtwYtwkJPeTRHOtmuhXIid9Z6zXkwlAVi
   RCRZRShE7u6KLMshUobwzN9C4h0enNLnawrBEa/dQYxsI1RR5cwvCtm0k
   Y9S6KqytgLsaBiHwvC23GsJeiqxekOAUV3aMBE7iuZxoSwi31mouTF/eK
   Q==;
X-CSE-ConnectionGUID: MuFkh7rLQcmJ2QxGZz2APg==
X-CSE-MsgGUID: jpalR6obQwC1MgNyPCcOjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29200476"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29200476"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 08:42:07 -0700
X-CSE-ConnectionGUID: RIs+OzhpQTufLz9ioQbl6A==
X-CSE-MsgGUID: 6ifkXvsmSRiAbDvZ718bpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="50136221"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jul 2024 08:42:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTkJV-000fOs-1x;
	Tue, 16 Jul 2024 15:42:01 +0000
Date: Tue, 16 Jul 2024 23:41:08 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 06/14] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <202407162357.A9pxRKuo-lkp@intel.com>
References: <20240715-pci-qcom-hotplug-v1-6-5f3765cc873a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-pci-qcom-hotplug-v1-6-5f3765cc873a@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 91e3b24eb7d297d9d99030800ed96944b8652eaf]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-ep-Drop-the-redundant-masking-of-global-IRQ-events/20240716-014703
base:   91e3b24eb7d297d9d99030800ed96944b8652eaf
patch link:    https://lore.kernel.org/r/20240715-pci-qcom-hotplug-v1-6-5f3765cc873a%40linaro.org
patch subject: [PATCH 06/14] PCI: endpoint: Assign PCI domain number for endpoint controllers
config: i386-randconfig-001-20240716 (https://download.01.org/0day-ci/archive/20240716/202407162357.A9pxRKuo-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240716/202407162357.A9pxRKuo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407162357.A9pxRKuo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/endpoint/pci-epc-core.c:902:19: error: call to undeclared function 'pci_bus_find_domain_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     902 |         epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
         |                          ^
   1 error generated.


vim +/pci_bus_find_domain_nr +902 drivers/pci/endpoint/pci-epc-core.c

   866	
   867	/**
   868	 * __pci_epc_create() - create a new endpoint controller (EPC) device
   869	 * @dev: device that is creating the new EPC
   870	 * @ops: function pointers for performing EPC operations
   871	 * @owner: the owner of the module that creates the EPC device
   872	 *
   873	 * Invoke to create a new EPC device and add it to pci_epc class.
   874	 */
   875	struct pci_epc *
   876	__pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
   877			 struct module *owner)
   878	{
   879		int ret;
   880		struct pci_epc *epc;
   881	
   882		if (WARN_ON(!dev)) {
   883			ret = -EINVAL;
   884			goto err_ret;
   885		}
   886	
   887		epc = kzalloc(sizeof(*epc), GFP_KERNEL);
   888		if (!epc) {
   889			ret = -ENOMEM;
   890			goto err_ret;
   891		}
   892	
   893		mutex_init(&epc->lock);
   894		mutex_init(&epc->list_lock);
   895		INIT_LIST_HEAD(&epc->pci_epf);
   896	
   897		device_initialize(&epc->dev);
   898		epc->dev.class = &pci_epc_class;
   899		epc->dev.parent = dev;
   900		epc->dev.release = pci_epc_release;
   901		epc->ops = ops;
 > 902		epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
   903	
   904		ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
   905		if (ret)
   906			goto put_dev;
   907	
   908		ret = device_add(&epc->dev);
   909		if (ret)
   910			goto put_dev;
   911	
   912		epc->group = pci_ep_cfs_add_epc_group(dev_name(dev));
   913	
   914		return epc;
   915	
   916	put_dev:
   917		put_device(&epc->dev);
   918	
   919	err_ret:
   920		return ERR_PTR(ret);
   921	}
   922	EXPORT_SYMBOL_GPL(__pci_epc_create);
   923	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

