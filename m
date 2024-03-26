Return-Path: <linux-pci+bounces-5164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8C88BF2B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6625F1C3AB60
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BB4C3DE;
	Tue, 26 Mar 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VA8nVgTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33A5787D
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448399; cv=none; b=aHyQofzzTb+7I90eoZdlXlBiU1bh1dkVgaagqIlmgU6IiGtBg/sFhokmPONkKIJi867FnYDLh8ytVxBcz7wy+Ttc8icTpAVw0lhJHGQamwYItfwvQjR/HTNv3xnqHjQuiPlONjE73nYsHKEzbQHykHD1XCwOAfcpqNhIcxwkF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448399; c=relaxed/simple;
	bh=g3ASmgDCqbf8tjBm9AZOWj7TmW7sHPV4+DBr1CoVb0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gRd0jnMzE76J/1j3wwPEGMThT4IKE8saKXsqCeu9tKYymjBH70dufIw3brjlqyVuxXEjvsah3yy1MFH44bYOOOHeUTJBdu+yd8a6MoZuualTraa6reLzkWNy7wQ67ecOnLltl49NLUUIN03fOtlZSdUO3R/hK+QjZSJnyZqBR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VA8nVgTX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448398; x=1742984398;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g3ASmgDCqbf8tjBm9AZOWj7TmW7sHPV4+DBr1CoVb0A=;
  b=VA8nVgTXL2Z2J2gnajeKLCSg8z94b+vMcxhsvkIW2UoHNuoiD6WuFZCp
   IIj1JCcrxgS2oIUpree15c7y0QnUsvOU2NBa/ZFSPuLAzL2vd0nj3687H
   6uItrRcbx4keMIg08X5kzhW5xZ9xeVJnFHKWm2qc0dR566aEfMcIFf+hE
   oaCDFFRnca8lk0nPcNXL1HZC92WYHwS2wgFLGgkQv44cUgodyHZGZpmls
   JeWgDR86hr6FiV8tdOe5X4HcjARoSFGw27Tv8kukxWVsPeOdOAh+Ii3hF
   vnb7oiMCOkmXRIdopU9NymPRScyLroWwrq070qlz9qLzQ1s7kWSsIa9+U
   w==;
X-CSE-ConnectionGUID: GkRzT0h1TviI2J8P19KSAA==
X-CSE-MsgGUID: emj/Rd02QW2HP5HTmRR25g==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6355730"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6355730"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15978491"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Mar 2024 03:19:55 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp3uK-000NIp-2x;
	Tue, 26 Mar 2024 10:19:52 +0000
Date: Tue, 26 Mar 2024 18:19:43 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:enumeration 28/28] drivers/mfd/intel-lpss-pci.c:57:49: error:
 'PCI_IRQ_LEGACY' undeclared; did you mean 'NR_IRQS_LEGACY'?
Message-ID: <202403261840.1RP419n5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
head:   8694697a54096ae97eb38bf4144f2d96c64c68f2
commit: 8694697a54096ae97eb38bf4144f2d96c64c68f2 [28/28] PCI: Remove PCI_IRQ_LEGACY
config: i386-buildonly-randconfig-001-20240326 (https://download.01.org/0day-ci/archive/20240326/202403261840.1RP419n5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403261840.1RP419n5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403261840.1RP419n5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mfd/intel-lpss-pci.c: In function 'intel_lpss_pci_probe':
>> drivers/mfd/intel-lpss-pci.c:57:49: error: 'PCI_IRQ_LEGACY' undeclared (first use in this function); did you mean 'NR_IRQS_LEGACY'?
      57 |         ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
         |                                                 ^~~~~~~~~~~~~~
         |                                                 NR_IRQS_LEGACY
   drivers/mfd/intel-lpss-pci.c:57:49: note: each undeclared identifier is reported only once for each function it appears in


vim +57 drivers/mfd/intel-lpss-pci.c

e6b142060b2401 Hans de Goede        2021-12-03  44  
4b45efe8526359 Andy Shevchenko      2015-07-27  45  static int intel_lpss_pci_probe(struct pci_dev *pdev,
4b45efe8526359 Andy Shevchenko      2015-07-27  46  				const struct pci_device_id *id)
4b45efe8526359 Andy Shevchenko      2015-07-27  47  {
9ffe4c1089f6c3 Andy Shevchenko      2023-11-24  48  	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
ac9538f6007e1c Aleksandrs Vinarskis 2023-12-21  49  	const struct pci_device_id *quirk_pci_info;
4b45efe8526359 Andy Shevchenko      2015-07-27  50  	struct intel_lpss_platform_info *info;
4b45efe8526359 Andy Shevchenko      2015-07-27  51  	int ret;
4b45efe8526359 Andy Shevchenko      2015-07-27  52  
4b45efe8526359 Andy Shevchenko      2015-07-27  53  	ret = pcim_enable_device(pdev);
4b45efe8526359 Andy Shevchenko      2015-07-27  54  	if (ret)
4b45efe8526359 Andy Shevchenko      2015-07-27  55  		return ret;
4b45efe8526359 Andy Shevchenko      2015-07-27  56  
6978c7d2dd81e0 Andy Shevchenko      2023-11-06 @57  	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
0c679fffd67605 Andy Shevchenko      2023-11-30  58  	if (ret < 0)
6978c7d2dd81e0 Andy Shevchenko      2023-11-06  59  		return ret;
6978c7d2dd81e0 Andy Shevchenko      2023-11-06  60  
9ffe4c1089f6c3 Andy Shevchenko      2023-11-24  61  	info = devm_kmemdup(&pdev->dev, data, sizeof(*info), GFP_KERNEL);
4b45efe8526359 Andy Shevchenko      2015-07-27  62  	if (!info)
4b45efe8526359 Andy Shevchenko      2015-07-27  63  		return -ENOMEM;
4b45efe8526359 Andy Shevchenko      2015-07-27  64  
3b6dba220e67ed Andy Shevchenko      2023-11-24  65  	/* No need to check mem and irq here as intel_lpss_probe() does it for us */
6978c7d2dd81e0 Andy Shevchenko      2023-11-06  66  	info->mem = pci_resource_n(pdev, 0);
6978c7d2dd81e0 Andy Shevchenko      2023-11-06  67  	info->irq = pci_irq_vector(pdev, 0);
4b45efe8526359 Andy Shevchenko      2015-07-27  68  
ac9538f6007e1c Aleksandrs Vinarskis 2023-12-21  69  	quirk_pci_info = pci_match_id(quirk_ids, pdev);
ac9538f6007e1c Aleksandrs Vinarskis 2023-12-21  70  	if (quirk_pci_info)
ac9538f6007e1c Aleksandrs Vinarskis 2023-12-21  71  		info->quirks = quirk_pci_info->driver_data;
e6b142060b2401 Hans de Goede        2021-12-03  72  
76380a607ba0b2 Kai-Heng Feng        2019-07-05  73  	pdev->d3cold_delay = 0;
76380a607ba0b2 Kai-Heng Feng        2019-07-05  74  
4b45efe8526359 Andy Shevchenko      2015-07-27  75  	/* Probably it is enough to set this for iDMA capable devices only */
4b45efe8526359 Andy Shevchenko      2015-07-27  76  	pci_set_master(pdev);
85a9419a254e23 Andy Shevchenko      2016-11-15  77  	pci_try_set_mwi(pdev);
4b45efe8526359 Andy Shevchenko      2015-07-27  78  
4b45efe8526359 Andy Shevchenko      2015-07-27  79  	ret = intel_lpss_probe(&pdev->dev, info);
4b45efe8526359 Andy Shevchenko      2015-07-27  80  	if (ret)
4b45efe8526359 Andy Shevchenko      2015-07-27  81  		return ret;
4b45efe8526359 Andy Shevchenko      2015-07-27  82  
4b45efe8526359 Andy Shevchenko      2015-07-27  83  	pm_runtime_put(&pdev->dev);
4b45efe8526359 Andy Shevchenko      2015-07-27  84  	pm_runtime_allow(&pdev->dev);
4b45efe8526359 Andy Shevchenko      2015-07-27  85  
4b45efe8526359 Andy Shevchenko      2015-07-27  86  	return 0;
4b45efe8526359 Andy Shevchenko      2015-07-27  87  }
4b45efe8526359 Andy Shevchenko      2015-07-27  88  

:::::: The code at line 57 was first introduced by commit
:::::: 6978c7d2dd81e0a3f9d30d1fbdb013a5ae5fabaf mfd: intel-lpss: Use PCI APIs instead of dereferencing

:::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
:::::: CC: Lee Jones <lee@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

