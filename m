Return-Path: <linux-pci+bounces-4768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9158287A171
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 03:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B39A1F2242B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22053BA2B;
	Wed, 13 Mar 2024 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXB+RAWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D5BA2D
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295895; cv=none; b=PXRovYLqARM+vbC1TafQRaM6eNT21nHfTpqjCsoLWQQeQS2IsAN6P0PfZ7fd1uTmrItusMsgjZVIb9K6lFBbXTLkhSyBYduB/xw2Rq9ViH21VjQweAgTUpeSEvO3DiYprTsx5VcGXy6im1XzM1knLbZeb/tM7ZE79iPxwKP8im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295895; c=relaxed/simple;
	bh=yeMxH9/+1pYhnfGtNPwYOAqIqg475ryfI5/WikcAPiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYbpYPI/A9kRDpkCObpB93p7zGWKoI1PzreRIORsf219KBvMIFXR12HJz6dnbpEGw/lj3Od9irIjOc1+orami31veg9AEtTWs/HQuV7K65yFwWiTq6JkK+8qjle2sH+uo2h7q0JcdCZg9C5OHsJLkF95baQXhdYcSVrRYt6S7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXB+RAWr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710295893; x=1741831893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yeMxH9/+1pYhnfGtNPwYOAqIqg475ryfI5/WikcAPiE=;
  b=QXB+RAWrzqK3MLaKfmQPsx49NlTxo7YzA39KHwkHYbJ0Q0G9KYcZXID1
   tG+ZvjjE6f+38XqcWg8hm0omVeiMnwkmepy5VERO8a9iD0qA0quhc9p7p
   C+cDIh8kOGSWsXSV2VCg41lhCOeZCrty53GdruTWjGjm0wRLIWSTi8R4O
   +2msiZDIy8NzNE+Aj//7Sizd/nRjBfXX0dQfXEUCoh8j2OoIyykKThD1h
   aHoa8EJvpw9JYj45I2Tp9pawCz3NSA6JucZx1Ov5/MTjzRY8nF437Ffbc
   7hFpbadeJWQfzdx5DNi5hYgq8LxAra3TahoqsSyy0rfDNQd8ExiyApLaM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16439459"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16439459"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 19:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="49182173"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Mar 2024 19:11:30 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkE5X-000BuV-1U;
	Wed, 13 Mar 2024 02:11:27 +0000
Date: Wed, 13 Mar 2024 10:11:02 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 5/9] PCI: endpoint: pci-epf-test: Simplify
 pci_epf_test_set_bar() loop
Message-ID: <202403131004.Z9epuI06-lkp@intel.com>
References: <20240312105152.3457899-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312105152.3457899-6-cassel@kernel.org>

Hi Niklas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20240312]
[cannot apply to pci/for-linus mani-mhi/mhi-next linus/master v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Niklas-Cassel/PCI-endpoint-pci-epf-test-Fix-incorrect-loop-increment/20240312-185512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240312105152.3457899-6-cassel%40kernel.org
patch subject: [PATCH v2 5/9] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
config: arc-randconfig-001-20240313 (https://download.01.org/0day-ci/archive/20240313/202403131004.Z9epuI06-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403131004.Z9epuI06-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403131004.Z9epuI06-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_set_bar':
>> drivers/pci/endpoint/functions/pci-epf-test.c:717:40: warning: variable 'epc_features' set but not used [-Wunused-but-set-variable]
     717 |         const struct pci_epc_features *epc_features;
         |                                        ^~~~~~~~~~~~


vim +/epc_features +717 drivers/pci/endpoint/functions/pci-epf-test.c

349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  709  
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  710  static int pci_epf_test_set_bar(struct pci_epf *epf)
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  711  {
2287a91bfd63cb Niklas Cassel          2024-03-12  712  	int bar, ret;
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  713  	struct pci_epc *epc = epf->epc;
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  714  	struct device *dev = &epf->dev;
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  715  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
3235b994950d84 Kishon Vijay Abraham I 2017-08-18  716  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
2c04c5b8eef797 Kishon Vijay Abraham I 2019-01-14 @717  	const struct pci_epc_features *epc_features;
2c04c5b8eef797 Kishon Vijay Abraham I 2019-01-14  718  
2c04c5b8eef797 Kishon Vijay Abraham I 2019-01-14  719  	epc_features = epf_test->epc_features;
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  720  
2287a91bfd63cb Niklas Cassel          2024-03-12  721  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
2287a91bfd63cb Niklas Cassel          2024-03-12  722  		if (!epf_test->reg[bar])
2c04c5b8eef797 Kishon Vijay Abraham I 2019-01-14  723  			continue;
2c04c5b8eef797 Kishon Vijay Abraham I 2019-01-14  724  
53fd3cbe5e9d79 Kishon Vijay Abraham I 2021-08-19  725  		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
2287a91bfd63cb Niklas Cassel          2024-03-12  726  				      &epf->bar[bar]);
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  727  		if (ret) {
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  728  			pci_epf_free_space(epf, epf_test->reg[bar], bar,
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  729  					   PRIMARY_INTERFACE);
798c0441bec8c4 Gustavo Pimentel       2018-05-14  730  			dev_err(dev, "Failed to set BAR%d\n", bar);
3235b994950d84 Kishon Vijay Abraham I 2017-08-18  731  			if (bar == test_reg_bar)
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  732  				return ret;
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  733  		}
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  734  	}
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  735  
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  736  	return 0;
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  737  }
349e7a85b25fa6 Kishon Vijay Abraham I 2017-03-27  738  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

