Return-Path: <linux-pci+bounces-10381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC89932E91
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F270E1C21EFC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593619E7EB;
	Tue, 16 Jul 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsWxI3rX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12C1E528;
	Tue, 16 Jul 2024 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148495; cv=none; b=HiWEaVLmQz5K0sddodXNNGJG1NNts1L+URnufdUPcE0DwefzZ4N1CtUwxUAwpQF0FCIcc7b+x1w9hW/je/82FWOVMu4wsD8+eFdua+rOvQ+YoQHRFZtOpKuL5PVEu7Z+/5RDuFyr2kLd7L2TJbok1B89fmZBsRAFTNs82MG1rtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148495; c=relaxed/simple;
	bh=ZejX7sQYy7OqqD/lZfJcjG1n/50PzY0tqu1osR9XdOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1szyRAAVkU99EJ43L0acr8+bfNFKBWb2gLyW+dapHkZ59xO+O83ueETataDXB7WPUPo6PglUshORIOMMb/H2GMaCycLPtgrwmwF/TVpCiNBodV4+S/GclMkbHTwH6nfiz5XugpkBAFX2BLV84WatpLyZW0Gm6dwXJHq61nz2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsWxI3rX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721148492; x=1752684492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZejX7sQYy7OqqD/lZfJcjG1n/50PzY0tqu1osR9XdOI=;
  b=HsWxI3rXBxtvvTDiSglORt4lo6gy9jsQLvmYjKU+rlKD8qPNvEcNk4gK
   wH6vNqP3ZHaSuHtv2rqQW4TFT8g10z5ss0NY3wIcTcCz12gogDlMtq5LV
   DOflPek9tWWUfxBjTqIE/01vqLtXm4WRl2GgzvxqUNENSAUblTLz69+im
   HD3EPrRTrXh3CGevSUPoX99HyYFoZUg2m2V8yfHgzxzsEDX+8anshiN9O
   Jw2GfuMLYY/3dO/8Cax4QufvqL6Zg7UnNQY9o9DYu6QIOgqEsw+uIi3LJ
   qXjJd9ZmZmR77IRG3J6bJBihwC9Y9J9fhU8UsniktITnqo4GVw6lvZ3yk
   g==;
X-CSE-ConnectionGUID: rxAUC8Q9Q1+tdKPZkvC96Q==
X-CSE-MsgGUID: D6dkMJesTwu43nhVcAqlCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="30017576"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="30017576"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 09:48:11 -0700
X-CSE-ConnectionGUID: y8Ea+zk+QLKYSTNmND2bUQ==
X-CSE-MsgGUID: lFusUqOWS0SdtKdYPWrdOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="49812047"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jul 2024 09:48:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTlLR-000fSm-31;
	Tue, 16 Jul 2024 16:48:05 +0000
Date: Wed, 17 Jul 2024 00:47:59 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 06/14] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <202407170032.WTPexEVV-lkp@intel.com>
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
config: i386-randconfig-011-20240716 (https://download.01.org/0day-ci/archive/20240717/202407170032.WTPexEVV-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240717/202407170032.WTPexEVV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407170032.WTPexEVV-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-epc-core.c: In function '__pci_epc_create':
>> drivers/pci/endpoint/pci-epc-core.c:902:19: error: implicit declaration of function 'pci_bus_find_domain_nr'; did you mean 'pci_bus_find_capability'? [-Werror=implicit-function-declaration]
     epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
                      ^~~~~~~~~~~~~~~~~~~~~~
                      pci_bus_find_capability
   cc1: some warnings being treated as errors


vim +902 drivers/pci/endpoint/pci-epc-core.c

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

