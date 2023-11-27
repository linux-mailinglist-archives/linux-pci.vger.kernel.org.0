Return-Path: <linux-pci+bounces-183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A57FA454
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 16:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17B91C209A2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D2321A5;
	Mon, 27 Nov 2023 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUlSKWKW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9759B;
	Mon, 27 Nov 2023 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701098612; x=1732634612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Wqod83dtCrso4isvNiZ+Vk/m33qzkX26zuYmvK9EBY=;
  b=JUlSKWKWrPcUoounMT7SITj2dmGhFtko4PZZRCyeYNnsRAouHG7sQDZ1
   yCNWUPQ+bN1miPOfgPoIMQehhrj/Z8uOj+AKQVvROlDA+STJ8gYg5rtcD
   McQe026kwEmVre89rLH/4QL5zXhplamyj9zR6SQugNnE+skXL/Bpx69aW
   QBtVV1Vt3Xa1cWygrNIfhSaMGYBednCsg5GSTj85zgcW4NF1tcNrY2mZ6
   wVyTPtpnUj1oLYyzkeuGXkZLTEmije4rRAhuZ6vTJe+2Qa6MM5g+OJcc/
   oVvp7vG3GDoyr7lICRHMKM60lE7fzO13ITZPw65O2NVk580FazJlovruU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383111037"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="383111037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 07:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="797269356"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="797269356"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2023 07:23:28 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7dSI-0006MV-0Y;
	Mon, 27 Nov 2023 15:23:26 +0000
Date: Mon, 27 Nov 2023 23:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: wangdong28 <wangdong202303@163.com>, nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, rafael@kernel.org,
	lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, wangdong202303@163.com,
	ahuang12@lenovo.com, Dong Wang <wangdong28@lenovo.com>
Subject: Re: [PATCH] PCI/ACPI: Add extra slot register check for non-ACPI
 device
Message-ID: <202311272056.KtldqGiA-lkp@intel.com>
References: <1701065447-13963-1-git-send-email-wangdong202303@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701065447-13963-1-git-send-email-wangdong202303@163.com>

Hi wangdong28,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/acpi-bus rafael-pm/devprop linus/master v6.7-rc3 next-20231127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wangdong28/PCI-ACPI-Add-extra-slot-register-check-for-non-ACPI-device/20231127-141554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/1701065447-13963-1-git-send-email-wangdong202303%40163.com
patch subject: [PATCH] PCI/ACPI: Add extra slot register check for non-ACPI device
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20231127/202311272056.KtldqGiA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231127/202311272056.KtldqGiA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311272056.KtldqGiA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pci-acpi.c: In function 'pci_check_extra_slot_register':
>> drivers/pci/pci-acpi.c:896:14: error: implicit declaration of function 'is_vmd' [-Werror=implicit-function-declaration]
     896 |         if (!is_vmd(bus) || !pdev || pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap))
         |              ^~~~~~
   cc1: some warnings being treated as errors


vim +/is_vmd +896 drivers/pci/pci-acpi.c

   888	
   889	static void pci_check_extra_slot_register(struct pci_bus *bus)
   890	{
   891		struct pci_dev *pdev = bus->self;
   892		char slot_name[SLOT_NAME_SIZE];
   893		struct pci_slot *pci_slot;
   894		u32 slot_cap, slot_nr;
   895	
 > 896		if (!is_vmd(bus) || !pdev || pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap))
   897			return;
   898	
   899		if (!(slot_cap & PCI_EXP_SLTCAP_HPC)) {
   900			slot_nr = (slot_cap & PCI_EXP_SLTCAP_PSN) >> 19;
   901			snprintf(slot_name, SLOT_NAME_SIZE, "%u", slot_nr);
   902			pci_slot = pci_create_slot(bus, 0, slot_name, NULL);
   903			if (IS_ERR(pci_slot))
   904				pr_err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot));
   905		}
   906	}
   907	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

