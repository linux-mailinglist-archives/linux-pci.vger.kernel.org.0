Return-Path: <linux-pci+bounces-24471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A58A6D094
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC873AB3EF
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12FC16FF44;
	Sun, 23 Mar 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcKtqF87"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575713A244;
	Sun, 23 Mar 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742754879; cv=none; b=MACv7ojRUq9OMasarBKdmXpH7T3siK6Zy0askfPZbKdaHhzCrsOscXJtMiJ4VW28ZTKkFTWD93FzSpeAVmDooq0sQzY38bH83TltwkFeRpKBjh6gbJydnzXag657iBAK4BgmyCZcKRS9X1Z5Qy5ElTbUv9SjU/TPR+ScWrrh4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742754879; c=relaxed/simple;
	bh=V4lGD2kl1AWdAODTodLLT4BLOKqOQQLoDFD7RL4Sxrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG9VIEbnu8mGncf40qH22ZBqL4ViwMt9bLnuzuyAryUULbKTfe9pONjetEeSTL7mTGz59AsO5kTnEFXglHxUAGxnLDdl6g0VUkQEspyJFCvYKoZ/RCbOjd3eszk/ZGurPTCtNwzJiRCqN7L24ftGiTXYXd//wxPlhcx/0tXRwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcKtqF87; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742754877; x=1774290877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V4lGD2kl1AWdAODTodLLT4BLOKqOQQLoDFD7RL4Sxrg=;
  b=HcKtqF87PN8Fsp6NET5Do4M1oWOFHaImY8/3QQfwdZe6Wf2ovnxuUWOs
   Lc8mUBbvzYWZ/xypCVR3r1g8wnlMMfPzzUpJHwwiQynMBW16DFp6T91sB
   NrGPNVJOUOeulfMsU8pDiErXAtG59G+mxFaowPfhA5ZlrwfC3sijmvkoP
   WKdlqLg6zI/tnU7zvJM4+kDGRLc1vn5hmz4YUNaLjwDgmXFuinaPWPkNz
   KD02SQKPyql/nn4tpK6MooEpTbWIkm9fUK1T9Aq0uJm4vW2emXbvfDkIJ
   r2B158KxgYaBkHd9PmMXwtZYbliP45vP++0NQYsW8XV84BO8EmDa84F5c
   g==;
X-CSE-ConnectionGUID: 6WGUWiqdRK6hBj5tTBdEMA==
X-CSE-MsgGUID: uAvvnRZ8QQSs/0LFDoaxgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="44077439"
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="44077439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 11:34:37 -0700
X-CSE-ConnectionGUID: mW1NtRtiTbCw9fG3kayQag==
X-CSE-MsgGUID: lVT5J/0/TeCMasr+OO+OoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="124015959"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2025 11:34:34 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twQ9Y-0002uO-19;
	Sun, 23 Mar 2025 18:34:32 +0000
Date: Mon, 24 Mar 2025 02:33:34 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
Message-ID: <202503240212.GtZsXgoK-lkp@intel.com>
References: <20250323164852.430546-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323164852.430546-4-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250324-005300
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250323164852.430546-4-18255117159%40163.com
patch subject: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
config: csky-randconfig-001-20250324 (https://download.01.org/0day-ci/archive/20250324/202503240212.GtZsXgoK-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503240212.GtZsXgoK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503240212.GtZsXgoK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/cadence/pcie-cadence.c: In function 'cdns_pcie_find_capability':
>> drivers/pci/controller/cadence/pcie-cadence.c:28:16: error: implicit declaration of function 'pci_host_bridge_find_capability'; did you mean 'cdns_pcie_find_capability'? [-Wimplicit-function-declaration]
      28 |         return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                cdns_pcie_find_capability
   drivers/pci/controller/cadence/pcie-cadence.c: In function 'cdns_pcie_find_ext_capability':
>> drivers/pci/controller/cadence/pcie-cadence.c:33:16: error: implicit declaration of function 'pci_host_bridge_find_ext_capability'; did you mean 'cdns_pcie_find_ext_capability'? [-Wimplicit-function-declaration]
      33 |         return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                cdns_pcie_find_ext_capability


vim +28 drivers/pci/controller/cadence/pcie-cadence.c

    25	
    26	u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
    27	{
  > 28		return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
    29	}
    30	
    31	u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
    32	{
  > 33		return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
    34	}
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

