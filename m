Return-Path: <linux-pci+bounces-30164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD44ADFF7D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 10:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C218850ED
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2289326057E;
	Thu, 19 Jun 2025 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRCScuqd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D621A424;
	Thu, 19 Jun 2025 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320881; cv=none; b=jnkiMqK+qVMHCGlFADW4tt0A4b0pp2cFGqAND5B59n3lur0AMA91h/vq1kz7kNZFP5gkjDQTUCijNHd7mLNiSjR2e4vgQyHNgdLTyEpO4qUTgsJQmWDRk4B6FYmbEIHfwrvLjoTj4k0yT++83b6Shvjvah/bA0v1gqpOiUkf9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320881; c=relaxed/simple;
	bh=4HJuJePFef9p2ELqf3SzVRO850tg1GWyQ2TzfThmE6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIRBIrlUSfnMI4MEBZQyyyQxH2KD9F/c7e8bJf7sSiqFxKvdgOI18HoNrrajb0E0ZDlZ1eRlzvSMJbWZQsOoaR/mpnofWGS92qtegFqsUYl4n5pAp/idlOFKz9uaQI6fWJLygAR4m5uRJT7THkBwNJ/m6DXE1hdESXFuSkAFoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRCScuqd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750320879; x=1781856879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4HJuJePFef9p2ELqf3SzVRO850tg1GWyQ2TzfThmE6U=;
  b=kRCScuqdpD2i8aN/J2/WEnRUwgBy/Gv933/d4wygDccTCb6DUr4O+02l
   MCwHMF4tpTVEfvZJpBwbamisvb/uHfRI59esyD8bzKf0XwPvHvfhwujqM
   5E+Acu2B3NXp4NAYRpm9ncseRaVX99UIUrCb7qbQ83b0ePLbiutDoQBBI
   MnZW+tksKEADrBaXKogpyEI1+1WULlDgJCA3oBvDWbCHH+Op75tmkv4bI
   g1Xokg1HzOWbRkrXPfQR7CMLD4U8B+hKQLViswX97dL08om7nsPLo8MA8
   6norZHP86Scem0JGgM0r6y/hkaaMrthIIjK70omooK7oZoGJjvmAO/mBP
   w==;
X-CSE-ConnectionGUID: dNObG1LyQTyfrImNPTZGkg==
X-CSE-MsgGUID: OifD8hRDQziF40V/+K+ofw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="55197737"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="55197737"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 01:14:37 -0700
X-CSE-ConnectionGUID: wS0++O/HRfKzXmL0I2HRjg==
X-CSE-MsgGUID: 1GwMLCrPRHesJQpM8C7HWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="156336448"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Jun 2025 01:14:31 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSAPk-000KYk-1C;
	Thu, 19 Jun 2025 08:14:28 +0000
Date: Thu, 19 Jun 2025 16:14:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org,
	kishon@kernel.org, linus.walleij@linaro.org, p.zabel@pengutronix.de,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, elbadrym@google.com, romlem@google.com,
	anhphan@google.com, wak@google.com, yuxiaozhang@google.com,
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH 7/7] pci: aspeed: Add ASPEED PCIe host controller driver
Message-ID: <202506191639.jNEto4NW-lkp@intel.com>
References: <20250613033001.3153637-8-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613033001.3153637-8-jacky_chou@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus robh/for-next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.16-rc2 next-20250618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-phy-Add-document-for-ASPEED-PCIe-PHY/20250613-113331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250613033001.3153637-8-jacky_chou%40aspeedtech.com
patch subject: [PATCH 7/7] pci: aspeed: Add ASPEED PCIe host controller driver
config: x86_64-randconfig-007-20250619 (https://download.01.org/0day-ci/archive/20250619/202506191639.jNEto4NW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250619/202506191639.jNEto4NW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506191639.jNEto4NW-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `arch_setup_msi_irqs':
>> drivers/pci/msi/legacy.c:31: undefined reference to `msi_domain_first_desc'
>> ld: drivers/pci/msi/legacy.c:31: undefined reference to `msi_next_desc'
   ld: vmlinux.o: in function `arch_teardown_msi_irqs':
   drivers/pci/msi/legacy.c:45: undefined reference to `msi_domain_first_desc'
   ld: drivers/pci/msi/legacy.c:45: undefined reference to `msi_next_desc'
   ld: vmlinux.o: in function `pci_msi_setup_check_result':
   drivers/pci/msi/legacy.c:60: undefined reference to `msi_domain_first_desc'
   ld: drivers/pci/msi/legacy.c:60: undefined reference to `msi_next_desc'
   ld: vmlinux.o: in function `pci_msi_legacy_setup_msi_irqs':
>> drivers/pci/msi/legacy.c:72: undefined reference to `msi_device_populate_sysfs'
   ld: vmlinux.o: in function `pci_msi_legacy_teardown_msi_irqs':
>> drivers/pci/msi/legacy.c:78: undefined reference to `msi_device_destroy_sysfs'


vim +31 drivers/pci/msi/legacy.c

a01e09ef123789 Thomas Gleixner 2021-12-06  18  
a01e09ef123789 Thomas Gleixner 2021-12-06  19  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
a01e09ef123789 Thomas Gleixner 2021-12-06  20  {
a01e09ef123789 Thomas Gleixner 2021-12-06  21  	struct msi_desc *desc;
a01e09ef123789 Thomas Gleixner 2021-12-06  22  	int ret;
a01e09ef123789 Thomas Gleixner 2021-12-06  23  
a01e09ef123789 Thomas Gleixner 2021-12-06  24  	/*
a01e09ef123789 Thomas Gleixner 2021-12-06  25  	 * If an architecture wants to support multiple MSI, it needs to
a01e09ef123789 Thomas Gleixner 2021-12-06  26  	 * override arch_setup_msi_irqs()
a01e09ef123789 Thomas Gleixner 2021-12-06  27  	 */
a01e09ef123789 Thomas Gleixner 2021-12-06  28  	if (type == PCI_CAP_ID_MSI && nvec > 1)
a01e09ef123789 Thomas Gleixner 2021-12-06  29  		return 1;
a01e09ef123789 Thomas Gleixner 2021-12-06  30  
ae24e28fef1468 Thomas Gleixner 2021-12-06 @31  	msi_for_each_desc(desc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
a01e09ef123789 Thomas Gleixner 2021-12-06  32  		ret = arch_setup_msi_irq(dev, desc);
a01e09ef123789 Thomas Gleixner 2021-12-06  33  		if (ret)
a01e09ef123789 Thomas Gleixner 2021-12-06  34  			return ret < 0 ? ret : -ENOSPC;
a01e09ef123789 Thomas Gleixner 2021-12-06  35  	}
a01e09ef123789 Thomas Gleixner 2021-12-06  36  
a01e09ef123789 Thomas Gleixner 2021-12-06  37  	return 0;
a01e09ef123789 Thomas Gleixner 2021-12-06  38  }
a01e09ef123789 Thomas Gleixner 2021-12-06  39  
a01e09ef123789 Thomas Gleixner 2021-12-06  40  void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
a01e09ef123789 Thomas Gleixner 2021-12-06  41  {
a01e09ef123789 Thomas Gleixner 2021-12-06  42  	struct msi_desc *desc;
a01e09ef123789 Thomas Gleixner 2021-12-06  43  	int i;
a01e09ef123789 Thomas Gleixner 2021-12-06  44  
ae24e28fef1468 Thomas Gleixner 2021-12-06  45  	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED) {
a01e09ef123789 Thomas Gleixner 2021-12-06  46  		for (i = 0; i < desc->nvec_used; i++)
a01e09ef123789 Thomas Gleixner 2021-12-06  47  			arch_teardown_msi_irq(desc->irq + i);
a01e09ef123789 Thomas Gleixner 2021-12-06  48  	}
a01e09ef123789 Thomas Gleixner 2021-12-06  49  }
aa423ac4221abd Thomas Gleixner 2021-12-06  50  
60bf9b33c82c0e Thomas Gleixner 2021-12-06  51  static int pci_msi_setup_check_result(struct pci_dev *dev, int type, int ret)
60bf9b33c82c0e Thomas Gleixner 2021-12-06  52  {
ae24e28fef1468 Thomas Gleixner 2021-12-06  53  	struct msi_desc *desc;
60bf9b33c82c0e Thomas Gleixner 2021-12-06  54  	int avail = 0;
60bf9b33c82c0e Thomas Gleixner 2021-12-06  55  
60bf9b33c82c0e Thomas Gleixner 2021-12-06  56  	if (type != PCI_CAP_ID_MSIX || ret >= 0)
60bf9b33c82c0e Thomas Gleixner 2021-12-06  57  		return ret;
60bf9b33c82c0e Thomas Gleixner 2021-12-06  58  
60bf9b33c82c0e Thomas Gleixner 2021-12-06  59  	/* Scan the MSI descriptors for successfully allocated ones. */
ae24e28fef1468 Thomas Gleixner 2021-12-06  60  	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED)
60bf9b33c82c0e Thomas Gleixner 2021-12-06  61  		avail++;
ae24e28fef1468 Thomas Gleixner 2021-12-06  62  
60bf9b33c82c0e Thomas Gleixner 2021-12-06  63  	return avail ? avail : ret;
60bf9b33c82c0e Thomas Gleixner 2021-12-06  64  }
60bf9b33c82c0e Thomas Gleixner 2021-12-06  65  
aa423ac4221abd Thomas Gleixner 2021-12-06  66  int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
aa423ac4221abd Thomas Gleixner 2021-12-06  67  {
60bf9b33c82c0e Thomas Gleixner 2021-12-06  68  	int ret = arch_setup_msi_irqs(dev, nvec, type);
60bf9b33c82c0e Thomas Gleixner 2021-12-06  69  
ffd84485e6beb9 Thomas Gleixner 2021-12-10  70  	ret = pci_msi_setup_check_result(dev, type, ret);
ffd84485e6beb9 Thomas Gleixner 2021-12-10  71  	if (!ret)
ffd84485e6beb9 Thomas Gleixner 2021-12-10 @72  		ret = msi_device_populate_sysfs(&dev->dev);
ffd84485e6beb9 Thomas Gleixner 2021-12-10  73  	return ret;
aa423ac4221abd Thomas Gleixner 2021-12-06  74  }
aa423ac4221abd Thomas Gleixner 2021-12-06  75  
aa423ac4221abd Thomas Gleixner 2021-12-06  76  void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
aa423ac4221abd Thomas Gleixner 2021-12-06  77  {
ffd84485e6beb9 Thomas Gleixner 2021-12-10 @78  	msi_device_destroy_sysfs(&dev->dev);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

