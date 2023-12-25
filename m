Return-Path: <linux-pci+bounces-1377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4481E1E9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 18:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BB11C20E40
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 17:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A052F89;
	Mon, 25 Dec 2023 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oE+0SKGM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63B52F92
	for <linux-pci@vger.kernel.org>; Mon, 25 Dec 2023 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703526948; x=1735062948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3ENIJ54Bb1sEvI+l3Cmwr+pU+/EnjvkusB7dQE68yw=;
  b=oE+0SKGMlgAjFT3yJRs79pwQu1gIB6Ay6OuqxWM/+HcNOkBXG+cEXTsY
   b/mRD2/lBAi2mbEawSXaX6M706i8g4IQ37qfXwYAC4BksRBtgN1UUgrnD
   SZjkNnV2b1LKo+/m8KjMuRP8KScql0GyQ6O4Ja1h3cKx0Z+ujOjEApHRn
   DqxGX0Krm5q4W3mkKAsxHQMSRRisAgGXbrUzkNqgmgDfNngaBPZel4KHN
   2OM0iVr9fTJ6+rCbJgOVvA8m0yk7J2K3RobOFvjR36JquQSt6q3iPJdCv
   enDNFebS2aXGqC+ZpEx9BM9FdN93msu8GMJBILUBbNQS8MzBwhFuLi9U9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3382179"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="3382179"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 09:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="806690418"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="806690418"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Dec 2023 09:55:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHp9H-000DWn-2C;
	Mon, 25 Dec 2023 17:54:40 +0000
Date: Tue, 26 Dec 2023 01:53:06 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew W Carlis <mattc@purestorage.com>, helgaas@kernel.org,
	bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, Matthew W Carlis <mattc@purestorage.com>
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Message-ID: <202312260105.Gu2Z5jdw-lkp@intel.com>
References: <20231223212235.34293-2-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223212235.34293-2-mattc@purestorage.com>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-W-Carlis/PCI-portdrv-Allow-DPC-if-the-OS-controls-AER-natively/20231225-154046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231223212235.34293-2-mattc%40purestorage.com
patch subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively.
config: arc-randconfig-002-20231225 (https://download.01.org/0day-ci/archive/20231226/202312260105.Gu2Z5jdw-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260105.Gu2Z5jdw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260105.Gu2Z5jdw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pcie/portdrv.c: In function 'get_port_device_capability':
>> drivers/pci/pcie/portdrv.c:272:19: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
     272 |             (dev->aer_cap && host->native_aer)))
         |                   ^~~~~~~
         |                   ats_cap


vim +272 drivers/pci/pcie/portdrv.c

   244	
   245		/* Root Ports and Root Complex Event Collectors may generate PMEs */
   246		if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
   247		     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
   248		    (pcie_ports_native || host->native_pme)) {
   249			services |= PCIE_PORT_SERVICE_PME;
   250	
   251			/*
   252			 * Disable PME interrupt on this port in case it's been enabled
   253			 * by the BIOS (the PME service driver will enable it when
   254			 * necessary).
   255			 */
   256			pcie_pme_interrupt_enable(dev, false);
   257		}
   258	
   259		/*
   260		 * _OSC AER Control is required by the OS & requires OS to control AER,
   261		 * but _OSC DPC Control isn't required by the OS to control DPC; however
   262		 * it does require the OS to control DPC. _OSC DPC Control also requres
   263		 * _OSC EDR Control (Error Disconnect Recovery) (PCI Firmware - DPC ECN rev3.2)
   264		 * PCI_Express_Base 6.1, 6.2.11 Determination of DPC Control recommends
   265		 * platform fw or OS always link control of DPC to AER.
   266		 *
   267		 * With dpc-native, allow Linux to use DPC even if it doesn't have
   268		 * permission to use AER.
   269		 */
   270		if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
   271		    pci_aer_available() && (pcie_ports_dpc_native ||
 > 272		    (dev->aer_cap && host->native_aer)))
   273			services |= PCIE_PORT_SERVICE_DPC;
   274	
   275		if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
   276		    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
   277			u32 linkcap;
   278	
   279			pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
   280			if (linkcap & PCI_EXP_LNKCAP_LBNC)
   281				services |= PCIE_PORT_SERVICE_BWNOTIF;
   282		}
   283	
   284		return services;
   285	}
   286	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

