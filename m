Return-Path: <linux-pci+bounces-38715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B3BEFA5E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B8A189CC1F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B80E2D8DA8;
	Mon, 20 Oct 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlDP9fC7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFD29ACD7;
	Mon, 20 Oct 2025 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944809; cv=none; b=toSVk+puDfhE8blrp4CwcCFQaCbsIx7ZKIr9km+nq6ojT1Fvekxr9nKbqOC9UfZnbNTHYeqMpDi9oz7cb1qImIAMGqwU5bFmndvfCEKhgpJ3+dTBKQ1sAXBlY2r7E0diKITTL7yUtn8fdofqgGAV5YK008wA0CLPrDfdgfVz1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944809; c=relaxed/simple;
	bh=UUFihtK4Ok4cUMT7emCE/58qLLeQEky4Qc5eIDDDrrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEFIeIbBTDRVGqP5y2cE7dzV3GHJQDqBCas4NWMwzfQd4vc8ITKYyDQee9wjsNy3hisMRf5WdoI3ZmTdQSi2EFnA5Qe53n3Maqw3jy48c0luYvtiSRiSyjD786lOXNN+9wwaZUnyGRFZcljzQSDzPNZ6UNcWrtXOGEf4tSboiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlDP9fC7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760944807; x=1792480807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUFihtK4Ok4cUMT7emCE/58qLLeQEky4Qc5eIDDDrrg=;
  b=jlDP9fC7cqImlFqioOyL3Ucbb7kcNVjGS2wZo3OfYnLDFui27mlSYKhd
   ZI1M54AS6qpHPxkvsC6Edvhu6ijzLcpPduxvNGjiPtIVjJnqzkrDKN0ZA
   SBVp7ZelTUuvhg2D4fRyhn0ynphwqf/snEQkqDAtweT/NYr3EW5qubteA
   siWUQbq4jKo/B1wtn8e9QHFkqauDfkrvnRQlB40K5SdMn9ePTHWQ1D2xD
   d7S/7q2rJHLeprgNhJlMyryRzq2TAXopIXg6A9IDoMQC477ZxRcBlkPED
   rBaVh1ns8QgHKdKN69xy3a6AI5VpZwhtOHrpRljxSynwv7KXEfNene6Dg
   A==;
X-CSE-ConnectionGUID: 4fEUnsuaSZqcSmy3qW9F5w==
X-CSE-MsgGUID: T9Srv4kHQmu1C7K4uaanww==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63099337"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63099337"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 00:20:06 -0700
X-CSE-ConnectionGUID: QSZApNFnR6+WKt45uNjbJQ==
X-CSE-MsgGUID: 9IjP+zuSTS6864fyXuru/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="214228153"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 20 Oct 2025 00:20:02 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAkBU-0009an-0H;
	Mon, 20 Oct 2025 07:20:00 +0000
Date: Mon, 20 Oct 2025 15:19:34 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, helgaas@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mpillai@cadence.com, fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com, peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Message-ID: <202510201553.x7S0SaZ1-lkp@intel.com>
References: <20251020042857.706786-5-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020042857.706786-5-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 211ddde0823f1442e4ad052a2f30f050145ccada]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Add-module-support-for-platform-controller-driver/20251020-123246
base:   211ddde0823f1442e4ad052a2f30f050145ccada
patch link:    https://lore.kernel.org/r/20251020042857.706786-5-hans.zhang%40cixtech.com
patch subject: [PATCH v10 04/10] PCI: cadence: Add support for High Perf Architecture (HPA) controller
config: i386-buildonly-randconfig-002-20251020 (https://download.01.org/0day-ci/archive/20251020/202510201553.x7S0SaZ1-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251020/202510201553.x7S0SaZ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510201553.x7S0SaZ1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:96:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      96 |         if (rc->quirk_retrain_flag)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:98:9: note: uninitialized use occurs here
      98 |         return ret;
         |                ^~~
   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:96:2: note: remove the 'if' if its condition is always true
      96 |         if (rc->quirk_retrain_flag)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      97 |                 ret = cdns_pcie_retrain(pcie);
   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:84:18: note: initialize the variable 'ret' to silence this warning
      84 |         int retries, ret;
         |                         ^
         |                          = 0
   1 warning generated.


vim +96 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c

    79	
    80	static int cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie)
    81	{
    82		struct device *dev = pcie->dev;
    83		struct cdns_pcie_rc *rc;
    84		int retries, ret;
    85	
    86		rc = container_of(pcie, struct cdns_pcie_rc, pcie);
    87	
    88		/* Check if the link is up or not */
    89		for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
    90			if (cdns_pcie_hpa_link_up(pcie)) {
    91				dev_info(dev, "Link up\n");
    92				return 0;
    93			}
    94			usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
    95		}
  > 96		if (rc->quirk_retrain_flag)
    97			ret = cdns_pcie_retrain(pcie);
    98		return ret;
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

