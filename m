Return-Path: <linux-pci+bounces-32358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676CB085BE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 09:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B1F1AA0464
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13D219A8B;
	Thu, 17 Jul 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cECTN+eV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823422185AC;
	Thu, 17 Jul 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735589; cv=none; b=m4/7BZ46i5f1MOAZi0IlfGCJdJIfD1bTKTspeKwTUOR40d4GRYiUuSMeJVu3ubehWWw3l5VkwtVFkUfYA+Ifa1ZAeBxowt6MT+wjDT4YHeiHjbsohSbv07ngAO+sug6nJszvm8Gji3NuLpSQkmhToYOfYNTCWpgBsm4Q9bRyWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735589; c=relaxed/simple;
	bh=WfQDUZl8/0uR3HB4LyHO328cyXvBUlw0A/UhOlJxz1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PieC6B5ENhjhj4R1iyRvC78g4bTw6VUfhkaw1HIbqWlQ7+OyA9smpa+WWei/rhK36kmiiZ/HXqEg9iOpxjl7fO7F50X0vfGmcA8mPCNaUYEnQ6kCktHC410vY+3re0olfapb22PRrZnPyAj1kCKLeLM1fDSWkAKLchfw9/317EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cECTN+eV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752735589; x=1784271589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WfQDUZl8/0uR3HB4LyHO328cyXvBUlw0A/UhOlJxz1U=;
  b=cECTN+eVmQPVhXT/U2vkMof1i90qD/D23SrCoISImNpDAxAqykWtphGJ
   AMCD+kLBwmMG9jlI8L6A4GVmeeXPd/ALBe7UYhl7D07i9s/ov3crmTNwU
   c2DiPQ/nQ6R6vhZqrk6Y9RVmarwqo27olu4qQJkWPeHRO+tKTCawDLqhD
   mmB5tuZHpvbpG4itzJol3Tir0YVkXuB6Ahe8Dt2Qy+AesuolkdciN2079
   xho9XS9em/AymwAS6aoMtLxRU3pKA1U4tC8+cNR+I/gw7fzNModzXkAun
   J/uND1BJ1SQNs1iwTo94CZQk+VDhmiupBd6zx6elRcVuIkHeUvbp1AzIm
   Q==;
X-CSE-ConnectionGUID: onUM6+B2T7OIMYyxrxvWJQ==
X-CSE-MsgGUID: BqEkDFFhR3uduD0WAO17XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="57608558"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="57608558"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 23:59:48 -0700
X-CSE-ConnectionGUID: xCcATFy/QTatTT5/uaWjQw==
X-CSE-MsgGUID: ZIXncjgcTTumw+1qNYHO7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="188654912"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Jul 2025 23:59:42 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucIah-000DGd-10;
	Thu, 17 Jul 2025 06:59:39 +0000
Date: Thu, 17 Jul 2025 14:59:26 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
	ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Message-ID: <202507171411.xOxUslAs-lkp@intel.com>
References: <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-ASPM-Fix-the-behavior-of-pci_enable_link_state-APIs/20250716-205857
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20250716-ath-aspm-fix-v1-4-dd3e62c1b692%40oss.qualcomm.com
patch subject: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250717/202507171411.xOxUslAs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171411.xOxUslAs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171411.xOxUslAs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/main.c:22:
   drivers/net/wireless/ath/ath.h: In function 'ath_pci_aspm_state':
>> drivers/net/wireless/ath/ath.h:346:26: error: 'PCIE_LINK_STATE_L0S' undeclared (first use in this function)
     346 |                 state |= PCIE_LINK_STATE_L0S;
         |                          ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath.h:346:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/ath/ath.h:348:26: error: 'PCIE_LINK_STATE_L1' undeclared (first use in this function)
     348 |                 state |= PCIE_LINK_STATE_L1;
         |                          ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/wireless/ath/ath9k/common.h:19,
                    from drivers/net/wireless/ath/ath9k/ath9k.h:29,
                    from drivers/net/wireless/ath/ath9k/beacon.c:18:
   drivers/net/wireless/ath/ath9k/../ath.h: In function 'ath_pci_aspm_state':
>> drivers/net/wireless/ath/ath9k/../ath.h:346:26: error: 'PCIE_LINK_STATE_L0S' undeclared (first use in this function)
     346 |                 state |= PCIE_LINK_STATE_L0S;
         |                          ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath9k/../ath.h:346:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/ath/ath9k/../ath.h:348:26: error: 'PCIE_LINK_STATE_L1' undeclared (first use in this function)
     348 |                 state |= PCIE_LINK_STATE_L1;
         |                          ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/wireless/ath/carl9170/../regd.h:23,
                    from drivers/net/wireless/ath/carl9170/carl9170.h:61,
                    from drivers/net/wireless/ath/carl9170/main.c:47:
   drivers/net/wireless/ath/carl9170/../ath.h: In function 'ath_pci_aspm_state':
>> drivers/net/wireless/ath/carl9170/../ath.h:346:26: error: 'PCIE_LINK_STATE_L0S' undeclared (first use in this function)
     346 |                 state |= PCIE_LINK_STATE_L0S;
         |                          ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/carl9170/../ath.h:346:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/ath/carl9170/../ath.h:348:26: error: 'PCIE_LINK_STATE_L1' undeclared (first use in this function)
     348 |                 state |= PCIE_LINK_STATE_L1;
         |                          ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/wireless/ath/ath6kl/../regd.h:23,
                    from drivers/net/wireless/ath/ath6kl/wmi.c:24:
   drivers/net/wireless/ath/ath6kl/../ath.h: In function 'ath_pci_aspm_state':
>> drivers/net/wireless/ath/ath6kl/../ath.h:346:26: error: 'PCIE_LINK_STATE_L0S' undeclared (first use in this function)
     346 |                 state |= PCIE_LINK_STATE_L0S;
         |                          ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath6kl/../ath.h:346:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/ath/ath6kl/../ath.h:348:26: error: 'PCIE_LINK_STATE_L1' undeclared (first use in this function)
     348 |                 state |= PCIE_LINK_STATE_L1;
         |                          ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/wireless/ath/ath10k/core.h:25,
                    from drivers/net/wireless/ath/ath10k/mac.h:11,
                    from drivers/net/wireless/ath/ath10k/mac.c:9:
   drivers/net/wireless/ath/ath10k/../ath.h: In function 'ath_pci_aspm_state':
>> drivers/net/wireless/ath/ath10k/../ath.h:346:26: error: 'PCIE_LINK_STATE_L0S' undeclared (first use in this function)
     346 |                 state |= PCIE_LINK_STATE_L0S;
         |                          ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath10k/../ath.h:346:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/ath/ath10k/../ath.h:348:26: error: 'PCIE_LINK_STATE_L1' undeclared (first use in this function)
     348 |                 state |= PCIE_LINK_STATE_L1;
         |                          ^~~~~~~~~~~~~~~~~~


vim +/PCIE_LINK_STATE_L0S +346 drivers/net/wireless/ath/ath.h

   340	
   341	static inline int ath_pci_aspm_state(u16 lnkctl)
   342	{
   343		int state = 0;
   344	
   345		if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 > 346			state |= PCIE_LINK_STATE_L0S;
   347		if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 > 348			state |= PCIE_LINK_STATE_L1;
   349	
   350		return state;
   351	}
   352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

