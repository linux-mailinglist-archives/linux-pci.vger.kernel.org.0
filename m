Return-Path: <linux-pci+bounces-34750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD3B35E89
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB053A9BBA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83E2FDC5C;
	Tue, 26 Aug 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1/FgCEr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21B2FAC02;
	Tue, 26 Aug 2025 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209534; cv=none; b=ZiAlzhZ3KzoSnVH8XKorAEeXLCJwU+iX2lBsFW5ww5h9aYGuyIFMiQqMiz/cqFNO6hsgDzoMXjrE0NbGoN6Zz6R1N8ib7jkBO0s5SMUMsAn6FVwu8KE8v3Jgvxlbib/Q6AzU7xW0MNdFAK1Rf+vIih9F1y4QPivUMu7jdNlbjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209534; c=relaxed/simple;
	bh=FiLdpzWIyitQAvUhRt0r7ylePb3Gfbmw/UQAmdcgXEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOVlFT9Z+jfkybUgdZ2MO4V8ivCAuucTUPHfstX0B7IxAmZvEcrXhTwJAKjXaETD6ZZRYVDG2O+2xtDPRuOvaJ6DcIi1vYf73VLFnV5nZzglyh7ihVkCkTsJoDHPncGYLb8ZTaBY+D7ZTrbd8Gv83rZzZLByj7sn7Y+IvCOFhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1/FgCEr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756209533; x=1787745533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FiLdpzWIyitQAvUhRt0r7ylePb3Gfbmw/UQAmdcgXEk=;
  b=i1/FgCEr8DpQs5LNQZfjJCJkjALv0x6fcW6E3cRGP+xyXxCQDpZ1iMs8
   1yG1Nt1Ce4IGAbknuSJH8RqnUCJ2kJE2rBRe8v7/h6e2+2TyHPRerwi1t
   kBlDJdVY3F2HB+yiKEsFX+gBoYTD8IpACP0J+38Ma0nM9HZVwNRUCrjqT
   0kGNa4gm2600RO2+KOUNJFyGu54zpoEQTqiSo2U79MWDw+ASPFd4C2MAM
   17u15evc0u82Tsv4gXKsvR1+UDhvNcJVlR0SscZEsEijPSl0JuG+asWw1
   f6aAUPqTxgPfK+8P5SODiZr+AGWlz6p7QOnFosSWbsK+bM2YntKKiD2VB
   Q==;
X-CSE-ConnectionGUID: lretp7gRSN6w8RUTAsRsPQ==
X-CSE-MsgGUID: GWYyxSHISW202zhmSKzm1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62273148"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62273148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:58:53 -0700
X-CSE-ConnectionGUID: swsxi+ibRkW6mDaVWnZiAQ==
X-CSE-MsgGUID: lA8PD4I8St+RXG09a7iRsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173955138"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Aug 2025 04:58:50 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqsK7-000PFD-1E;
	Tue, 26 Aug 2025 11:58:47 +0000
Date: Tue, 26 Aug 2025 19:58:02 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
	jingoohan1@gmail.com, mani@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v2] PCI: endpoint: Implement capability search using PCI
 core APIs
Message-ID: <202508261929.5s2blqmA-lkp@intel.com>
References: <20250819145828.438541-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819145828.438541-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8742b2d8935f476449ef37e263bc4da3295c7b58]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-endpoint-Implement-capability-search-using-PCI-core-APIs/20250819-231353
base:   8742b2d8935f476449ef37e263bc4da3295c7b58
patch link:    https://lore.kernel.org/r/20250819145828.438541-1-18255117159%40163.com
patch subject: [PATCH v2] PCI: endpoint: Implement capability search using PCI core APIs
config: x86_64-randconfig-002-20250826 (https://download.01.org/0day-ci/archive/20250826/202508261929.5s2blqmA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508261929.5s2blqmA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508261929.5s2blqmA-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_find_capability':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:74:16: error: implicit declaration of function 'PCI_FIND_NEXT_CAP' [-Werror=implicit-function-declaration]
      74 |         return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
         |                ^~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-ep.c:74:34: error: 'dw_pcie_ep_read_cfg' undeclared (first use in this function); did you mean 'dw_pcie_ep_read_dbi'?
      74 |         return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
         |                                  ^~~~~~~~~~~~~~~~~~~
         |                                  dw_pcie_ep_read_dbi
   drivers/pci/controller/dwc/pcie-designware-ep.c:74:34: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/pci/controller/dwc/pcie-designware-ep.c:76:1: warning: control reaches end of non-void function [-Wreturn-type]
      76 | }
         | ^
   cc1: some warnings being treated as errors


vim +/PCI_FIND_NEXT_CAP +74 drivers/pci/controller/dwc/pcie-designware-ep.c

    71	
    72	static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
    73	{
  > 74		return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
    75					 cap, ep, func_no);
  > 76	}
    77	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

