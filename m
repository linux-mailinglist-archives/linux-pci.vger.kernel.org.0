Return-Path: <linux-pci+bounces-36336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F90B7D433
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FB8170D48
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DB343D91;
	Wed, 17 Sep 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Klec7hvV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF82F25E5;
	Wed, 17 Sep 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102767; cv=none; b=lRWNYO+l9ymSX1EkZbuihjYFpRxsOSSmQAEtKdH1TNqS+nLhg/FQHSKjX/1RxYivWa7LW8fUjRhjoeCsssBA+PzhQWi74uZ/WDFThTbjjD5h8r2nuKMmOLPRfoAg+VUQVaos4J7cP+RB0yfc57ZCIiyJq/1pQ9otmgPT2Q5PE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102767; c=relaxed/simple;
	bh=BFX6ownYzY7fkpQNkKIV0Q6ij+7Fw1P1XuX9Ln822Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6fIVcnWC1VPQgXE0k9JmBTprvGpOzD3Asn20n1Kp4j+B7QniXyaM/Xd2qiigHHwfQD8hyPsKATOkmt5uGBGnqsSRjhSHyJGO5AoU8Fkoba63o1YDPydGCHExlV/K8dzvbe953zHGYqT8i65jHqucwn8U7myt7MExsfQHp9nf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Klec7hvV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758102766; x=1789638766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BFX6ownYzY7fkpQNkKIV0Q6ij+7Fw1P1XuX9Ln822Ro=;
  b=Klec7hvVXchPOEFDweWHCE9cb2KFWWdlBFL7ajZWQKxnzSfPT4pSRAMC
   oluNwc7/G2EbusJ5MMxgq+V1HAZnl5giyhQL3LqsLTkcn2A7P5XY+MCAr
   BaYtggyNBKXXkQJDJ5edPzqLDVO9wNhWRyMN9N079HM9yB+gmOW9t7yYd
   ND6W5zYpEftalkSlyXh3eY8pZXqAEcvcl0QnTr3/oywNbLunZEoXzHJfd
   6W8HaZaeKQgcq48atI0wmU4Hi12/zIdmfJIG1zZNmWeN6dUmubW2HnIWo
   2YtsSE0u0uH0dKgL8313rdKsy0I24LxVsPh27kTj7OceTe1wHa9U5cLFO
   Q==;
X-CSE-ConnectionGUID: 8os2gCkzSA65QtIDUnm0cA==
X-CSE-MsgGUID: KAty0HAESjamZaGVjIOsCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71507480"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="71507480"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 02:52:26 -0700
X-CSE-ConnectionGUID: fXDEHERxTC+QoYiDPK7aNg==
X-CSE-MsgGUID: rnd60lEbSgK/07jnyeF1WQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Sep 2025 02:52:21 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyopm-0001LH-3A;
	Wed, 17 Sep 2025 09:52:18 +0000
Date: Wed, 17 Sep 2025 17:52:16 +0800
From: kernel test robot <lkp@intel.com>
To: Randolph Lin <randolph@andestech.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com,
	paul.walmsley@sifive.com, ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, randolph.sklin@gmail.com,
	tim609@andestech.com, Randolph Lin <randolph@andestech.com>
Subject: Re: [PATCH v2 4/5] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <202509171747.yJ9wsIkH-lkp@intel.com>
References: <20250916100417.3036847-5-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916100417.3036847-5-randolph@andestech.com>

Hi Randolph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next linus/master v6.17-rc6 next-20250916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Randolph-Lin/PCI-dwc-Add-outbound-ATU-address-range-validation-callback/20250916-180841
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250916100417.3036847-5-randolph%40andestech.com
patch subject: [PATCH v2 4/5] PCI: andes: Add Andes QiLai SoC PCIe host driver support
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20250917/202509171747.yJ9wsIkH-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250917/202509171747.yJ9wsIkH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509171747.yJ9wsIkH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:28:9: warning: '__SANITIZE_ADDRESS__' macro redefined [-Wmacro-redefined]
      28 | #define __SANITIZE_ADDRESS__
         |         ^
   <built-in>:371:9: note: previous definition is here
     371 | #define __SANITIZE_ADDRESS__ 1
         |         ^
>> drivers/pci/controller/dwc/pcie-andes-qilai.c:179:22: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     179 |                 dev_err_probe(dev, ret, "Failed to Get APB registers.\n");
         |                                    ^~~
   drivers/pci/controller/dwc/pcie-andes-qilai.c:159:9: note: initialize the variable 'ret' to silence this warning
     159 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.


vim +/ret +179 drivers/pci/controller/dwc/pcie-andes-qilai.c

   153	
   154	static int qilai_pcie_probe(struct platform_device *pdev)
   155	{
   156		struct qilai_pcie *pcie;
   157		struct dw_pcie *pci;
   158		struct device *dev;
   159		int ret;
   160	
   161		pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
   162		if (!pcie)
   163			return -ENOMEM;
   164	
   165		pcie->pdev = pdev;
   166		platform_set_drvdata(pdev, pcie);
   167	
   168		pci = &pcie->pci;
   169		dev = &pcie->pdev->dev;
   170		pcie->pci.dev = dev;
   171		pcie->pci.ops = &qilai_pcie_ops;
   172		pcie->pci.pp.ops = &qilai_pcie_host_ops;
   173		pci->use_parent_dt_ranges = true;
   174	
   175		dw_pcie_cap_set(&pcie->pci, REQ_RES);
   176	
   177		pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
   178		if (IS_ERR(pcie->apb_base)) {
 > 179			dev_err_probe(dev, ret, "Failed to Get APB registers.\n");
   180			return PTR_ERR(pcie->apb_base);
   181		}
   182	
   183		ret = dw_pcie_host_init(&pcie->pci.pp);
   184		if (ret) {
   185			dev_err_probe(dev, ret, "Failed to initialize PCIe host\n");
   186			return ret;
   187		}
   188	
   189		qilai_pcie_iocp_cache_setup(&pcie->pci.pp);
   190	
   191		return 0;
   192	}
   193	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

