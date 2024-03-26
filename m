Return-Path: <linux-pci+bounces-5175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D159888C0E4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 12:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0381F63F89
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B35812B;
	Tue, 26 Mar 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzQj4fI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A277173E
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452900; cv=none; b=QsT4UiwBvISZPjI08KhnJVb3neG0vPUv3gtlxpij3ULSf574NTENHFUUQOpCbYIL0/1Qa0X5I5KVEV0mfgKNcdDyenzoqiSvi+PPyJxm2pvqwFPnjjozF0+ttZ1Laf1xEq+0EdAMZEEOLDUEAEE9daCw4EFRe4EkPHEQr6ctomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452900; c=relaxed/simple;
	bh=9OYizbJxqDIuT86ZEA0pyUhFnnWBD/UBwFMaFIh81aA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p5OMQt1i8RwD30lcnsAPsqI44FaVbiNxh8tnMMLk8OZKTR1lOC5LOxvCVTvRdIw+R/behXN9zJx3pBgMVJ3aCru0qRLsMc8Li+nfyETKg56o9aGu8o6J86cLKVIGJaQpTCIILjrHGjtkyjKOYnsl7JX8j0n0rHomzaWl5qP6ruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzQj4fI0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711452899; x=1742988899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9OYizbJxqDIuT86ZEA0pyUhFnnWBD/UBwFMaFIh81aA=;
  b=IzQj4fI0QCcKz34tG8UQJHRiUF9s3VCtDAN44BaNY+w3Gzz3/9cg6RP+
   RYjM3GlEkvBCJ2WzIX5Z4MyTcMEYj7Lm5hEHORKa7PrcjKp5OTlGtgoWW
   Tx70OPoQtG52l+ioZefENOu7ffeyxgAhxm+yOGfhfrolOyx6ejNdCNkVb
   dYb1g8oaV10QQ2c8571UZh31QHiTfgG8MILh5MuVybJQvav1kKXq7EWHF
   ORDxnf+20aZjgGtN950P5TfBi6MYM6ku4Qxcu/KI3/n1W3HjipJGVSD5z
   km1Qh2OMY0sipvMB9MPfQF9kUJ+LGpBlEFfDH1NbTRiQacDnuC7DlTyLK
   g==;
X-CSE-ConnectionGUID: r+V7mq58R8ipjn1HwfAgFA==
X-CSE-MsgGUID: WYylnPq2Q9GNPdiaMuD94g==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6685269"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6685269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20589328"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Mar 2024 04:34:56 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp54w-000NL4-0R;
	Tue, 26 Mar 2024 11:34:54 +0000
Date: Tue, 26 Mar 2024 19:34:05 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:enumeration 28/28] drivers/mfd/intel-lpss-pci.c:57:42: error:
 use of undeclared identifier 'PCI_IRQ_LEGACY'; did you mean '__WQ_LEGACY'?
Message-ID: <202403261944.ObfbvQQV-lkp@intel.com>
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
config: i386-randconfig-013-20240326 (https://download.01.org/0day-ci/archive/20240326/202403261944.ObfbvQQV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403261944.ObfbvQQV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403261944.ObfbvQQV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mfd/intel-lpss-pci.c:57:42: error: use of undeclared identifier 'PCI_IRQ_LEGACY'; did you mean '__WQ_LEGACY'?
      57 |         ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
         |                                                 ^~~~~~~~~~~~~~
         |                                                 __WQ_LEGACY
   include/linux/workqueue.h:400:2: note: '__WQ_LEGACY' declared here
     400 |         __WQ_LEGACY             = 1 << 18, /* internal: create*_workqueue() */
         |         ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ACPI_WMI
   Depends on [n]: X86_PLATFORM_DEVICES [=n] && ACPI [=y]
   Selected by [m]:
   - DRM_XE [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (m && MODULES [=y] || y && KUNIT [=y]=y) && X86 [=y] && ACPI [=y]


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

