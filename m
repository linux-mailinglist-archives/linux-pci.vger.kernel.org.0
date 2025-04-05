Return-Path: <linux-pci+bounces-25334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A1A7CB12
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105AD1893231
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2975119C546;
	Sat,  5 Apr 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZX8xhOLR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC7199931;
	Sat,  5 Apr 2025 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743874789; cv=none; b=i7U8bIf8Wr/aCR57J6jT087TYIE5qqRHWCd9uV2eikx9b5oHu8o8l6zjJgtows6HaACgZVcZUt6YDSWEAmE1zMseQZtlE0ALQk0Cr/8QarFy2iFMqrcyCjqBwYGieONVrx8rQcsudGJSGcavqDAcczayOBIxwWniNTZYDc5otmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743874789; c=relaxed/simple;
	bh=cLoWa6W3Dyyrw2RNgGHlXiflRBqEsqjNsnatGYOyAbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeWsiHY5khw1r5ivVEEuuulhKrQMKncg3ZDwW4xVct1fbpf7cQCn5ENxgGjTVyX4ULNt3xC+7sUEWP626zKPcWIhIHylKP0UWUW3YdrBqg/cJr3NKc0eZ907IB9tYxHKy0GGgKInrA0xzj4Tkz/M4e17N4PZwZ5Qk/A3OGx751k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZX8xhOLR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743874787; x=1775410787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cLoWa6W3Dyyrw2RNgGHlXiflRBqEsqjNsnatGYOyAbE=;
  b=ZX8xhOLRA4NG6+fLu2CMbyQ9wAfYG2TnV4CV9/vx98IfArqRfNaMTvUr
   t0LLnUSkMWULW1oc+TplOhl7TboyNR6EaKTYlgNrHFHQdw12T3CRfXzLE
   /PROsoLvC6wzTNRYKpjO5aLdm7oAORczD/8LWwO5LBJhGAlENQQUk3zDN
   QbEEAqN66V4yQr82UykmEjna1l4Q7Vy+3zg2zOefTkkI0xya9wXNC+Bhu
   bxxbsZ527UckMpFt1GzlRnyydJsr9E0oqptQqshjB8nROaSL+KJygcI9o
   jBPg1D98D+MfAPX3NSOLI0A9cXYgSiLARmcS7RPmrq8eskXiWiFMuqhoe
   w==;
X-CSE-ConnectionGUID: jZn8pSUWSF2vIV9INehEfQ==
X-CSE-MsgGUID: tU4Q/p2uSj6GA91wtwqcFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45184591"
X-IronPort-AV: E=Sophos;i="6.15,191,1739865600"; 
   d="scan'208";a="45184591"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 10:39:47 -0700
X-CSE-ConnectionGUID: Q0kGPG/CQpKSUF8fnQaNPw==
X-CSE-MsgGUID: rSkLGwsQQMe8s9UYBz7AQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,191,1739865600"; 
   d="scan'208";a="128087199"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2025 10:39:42 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u17Ua-0002BD-0U;
	Sat, 05 Apr 2025 17:39:40 +0000
Date: Sun, 6 Apr 2025 01:38:41 +0800
From: kernel test robot <lkp@intel.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 1/3] PCI: endpoint: add epc_feature argument for
 pci_epf_free_space()
Message-ID: <202504060122.RXfUdGx9-lkp@intel.com>
References: <20250404-pci-ep-size-alignment-v2-1-c3a0db4cfc57@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-pci-ep-size-alignment-v2-1-c3a0db4cfc57@baylibre.com>

Hi Jerome,

kernel test robot noticed the following build errors:

[auto build test ERROR on dea140198b846f7432d78566b7b0b83979c72c2b]

url:    https://github.com/intel-lab-lkp/linux/commits/Jerome-Brunet/PCI-endpoint-add-epc_feature-argument-for-pci_epf_free_space/20250405-014733
base:   dea140198b846f7432d78566b7b0b83979c72c2b
patch link:    https://lore.kernel.org/r/20250404-pci-ep-size-alignment-v2-1-c3a0db4cfc57%40baylibre.com
patch subject: [PATCH v2 1/3] PCI: endpoint: add epc_feature argument for pci_epf_free_space()
config: loongarch-randconfig-001-20250405 (https://download.01.org/0day-ci/archive/20250406/202504060122.RXfUdGx9-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504060122.RXfUdGx9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504060122.RXfUdGx9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/target/pci-epf.c: In function 'nvmet_pci_epf_free_bar':
>> drivers/nvme/target/pci-epf.c:2165:9: error: too few arguments to function 'pci_epf_free_space'
    2165 |         pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
         |         ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/pci-epc.h:12,
                    from drivers/nvme/target/pci-epf.c:19:
   include/linux/pci-epf.h:224:6: note: declared here
     224 | void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
         |      ^~~~~~~~~~~~~~~~~~


vim +/pci_epf_free_space +2165 drivers/nvme/target/pci-epf.c

0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2157  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2158  static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2159  {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2160  	struct pci_epf *epf = nvme_epf->epf;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2161  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2162  	if (!nvme_epf->reg_bar)
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2163  		return;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2164  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04 @2165  	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2166  	nvme_epf->reg_bar = NULL;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2167  }
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  2168  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

