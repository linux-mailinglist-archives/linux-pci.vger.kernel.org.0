Return-Path: <linux-pci+bounces-26014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE23A907EB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE4188CC19
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4D920468D;
	Wed, 16 Apr 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEveKZhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E0156F20;
	Wed, 16 Apr 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818261; cv=none; b=cGgeU8/FqUy8+/+RlAq5f0Ah1kUkfDiBSKofOZvy9am56zlH/HF2FaR2VVzCBsvaefo/WWQPKW06Z1w6JE3QmQ278Uq039LzSbzlgGAWvz5R3lUqIJHq0UgtHYiijMn6MlBRbHVhrjaALmFI3sRMMZ+t/c8EN6N7JI0WEac/aAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818261; c=relaxed/simple;
	bh=DrlCq7H4f/BhvKoNnp89QVYukAc+8CBamz/LOL0QU24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMDp+x47qf6TiabTLK6GFwSf+vFAc7njw8lSYkMiz+JHW+KymEZ6ROFAH+EV7T++f6klsrGEkTsQ3JWVq/H+/id7+UwLqpAMwjjtsOJ7uuJxvL1xdvJCgLvCXt6HPYA2j1lE8/WmyG+66pHSkc0iOQnyFTus39X9Y8xANci8m5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEveKZhC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744818260; x=1776354260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DrlCq7H4f/BhvKoNnp89QVYukAc+8CBamz/LOL0QU24=;
  b=cEveKZhCh5kQ82YguAFQpNw1bVN4TCgGpX/hqpcVNHgx4P3lPg6m6N5E
   UD353cZhh5vp8wnMKBhac7gyFmHy72aBBVgSp9qQM7qHXIOkghL7wARCj
   i4D+yqD8nZs/ywLhKvpdwQvwAIpccU01IPOTFRyhTKihhkmVXD64MVm1B
   hfXEb4SRerH3WwH1fqyMsbVsS/5/HwZik9LdflfnZgHMpjVUXOb2f7Kjc
   /clp1LzPgidOxFsMe1MGiPVHGTIK0K0cqUZnrXhXKSZKccg197dVh8leD
   77RaXkqm1JIyKfO7oHOnQNpyO1foBKhO1jiAZk1D0nz3LTzGQFVs0HvvL
   w==;
X-CSE-ConnectionGUID: qDQFF9XJSxeY8WyiJWAYjQ==
X-CSE-MsgGUID: 3Cutb464SiaceBJ7bsz4Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46502077"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="46502077"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:44:19 -0700
X-CSE-ConnectionGUID: vl5eVdnbSVeNKgTS7iiEMg==
X-CSE-MsgGUID: JEjETB80Q4Od2ZkKQAt2rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="167693119"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Apr 2025 08:44:16 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u54vs-000JzQ-2v;
	Wed, 16 Apr 2025 15:44:12 +0000
Date: Wed, 16 Apr 2025 23:43:25 +0800
From: kernel test robot <lkp@intel.com>
To: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, cassel@kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	vidyas@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <202504162332.fwaFxVrL-lkp@intel.com>
References: <20250410194552.944818-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410194552.944818-1-vidyas@nvidia.com>

Hi Vidya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.15-rc2 next-20250416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vidya-Sagar/PCI-dwc-tegra194-Broaden-architecture-dependency/20250411-035134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250410194552.944818-1-vidyas%40nvidia.com
patch subject: [PATCH V2] PCI: dwc: tegra194: Broaden architecture dependency
config: arm64-kismet-CONFIG_PHY_TEGRA194_P2U-CONFIG_PCIE_TEGRA194_EP-0-0 (https://download.01.org/0day-ci/archive/20250416/202504162332.fwaFxVrL-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250416/202504162332.fwaFxVrL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504162332.fwaFxVrL-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PHY_TEGRA194_P2U when selected by PCIE_TEGRA194_EP
   WARNING: unmet direct dependencies detected for PHY_TEGRA194_P2U
     Depends on [n]: ARCH_TEGRA_194_SOC [=n] || ARCH_TEGRA_234_SOC [=n] || COMPILE_TEST [=n]
     Selected by [y]:
     - PCIE_TEGRA194_EP [=y] && PCI [=y] && ARCH_TEGRA [=y] && (ARM64 [=y] || COMPILE_TEST [=n]) && PCI_ENDPOINT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

