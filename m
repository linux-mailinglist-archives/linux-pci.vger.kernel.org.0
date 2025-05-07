Return-Path: <linux-pci+bounces-27396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3248FAAEC81
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 21:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C375032A9
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 19:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD528E602;
	Wed,  7 May 2025 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ms1h0sL6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BB28E5E5;
	Wed,  7 May 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647653; cv=none; b=rmULv9rfm4SkLkJQnQiVERgKzK3ull9wrWnOuhvtdzFT5kLrKEEBHax9/+Pa2ae16CNVjBJkI6U9TEpcwqomjnufDTaxP4hxs/nvlmSIDho3jP5ZLHM7+/X2LLpNxksXetJUjA4JMEhFatIAhxGvUDPsIcPfCBMANbvC99CiKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647653; c=relaxed/simple;
	bh=pHqrZ5HueZDBkUl2l/yst8f9HhyNSyT7n4oy9SPTS/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZITjF2t3VhRJISvkbdKynFgc6CxnfO/PXd2VBXvGKePYbYJy4bGI7Q2vZ/oDR807FGPnEKePl37vrVTwWBAFkahloYODrtPOSGIRRM21ZhAPZxLerBifjolPFA9YPsRk1xdMxHRkpi6aTB08RBXDxn1wGm/JPypFodpeN3/4t24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ms1h0sL6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746647651; x=1778183651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pHqrZ5HueZDBkUl2l/yst8f9HhyNSyT7n4oy9SPTS/o=;
  b=Ms1h0sL60bK6HEZej2FN8VhtTKZFolTWWh+taDpfS5/myg6mT8FweC8q
   J2K6zlV10BzZaf8G6CaRG4QRbLnwc7re7O/NOUD/TvwZgopzcXUjemzh2
   osRwPqszGPZbFycipXT72aT7FiHjSDcU3EDykIdf9klCY9gh362p2klQZ
   NcygcU02zm7cwI++GmtwZJ6+BwXpDX6yOImoDDjEwvAxQoFLQhyljQSHf
   PvwCeED6H5wgVb4rOxv05ikBtAltUBdcLpSZP4+Uzgtg1rZxdp3IBB3ya
   GtbmuC9CKMPuG2CKgMlrJGVPcDf6CSQvTVpKBUOKoQvjuHNPfhNQjvu+c
   Q==;
X-CSE-ConnectionGUID: zM+IpxtrSECd8ik9wo2iEw==
X-CSE-MsgGUID: mD/I6pT2RbyjIFPcsDjT2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52215252"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="52215252"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:54:11 -0700
X-CSE-ConnectionGUID: vjCpnfdORVu9jJ79BLDyJA==
X-CSE-MsgGUID: 5f5VkCX2S86VmF1a5OwHsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="135935834"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 May 2025 12:54:07 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCkqC-00090R-20;
	Wed, 07 May 2025 19:54:04 +0000
Date: Thu, 8 May 2025 03:54:03 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH v5 3/3] PCI: tegra: Allow building as a module
Message-ID: <202505080510.T9Y6L5rd-lkp@intel.com>
References: <20250505-pci-tegra-module-v5-3-827aaac998ba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pci-tegra-module-v5-3-827aaac998ba@gmail.com>

Hi Aaron,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus tip/irq/core tegra/for-next linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Kling-via-B4-Relay/cpuidle-tegra-Export-tegra_cpuidle_pcie_irqs_in_use/20250506-102907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250505-pci-tegra-module-v5-3-827aaac998ba%40gmail.com
patch subject: [PATCH v5 3/3] PCI: tegra: Allow building as a module
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250508/202505080510.T9Y6L5rd-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505080510.T9Y6L5rd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505080510.T9Y6L5rd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pci-tegra.c:2574:13: warning: 'tegra_pcie_debugfs_exit' defined but not used [-Wunused-function]
    2574 | static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/tegra_pcie_debugfs_exit +2574 drivers/pci/controller/pci-tegra.c

2cb989f6e99aa8 drivers/pci/host/pci-tegra.c Thierry Reding       2014-07-22  2573  
662b94c3195654 drivers/pci/host/pci-tegra.c Manikanta Maddireddy 2018-02-28 @2574  static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
662b94c3195654 drivers/pci/host/pci-tegra.c Manikanta Maddireddy 2018-02-28  2575  {
662b94c3195654 drivers/pci/host/pci-tegra.c Manikanta Maddireddy 2018-02-28  2576  	debugfs_remove_recursive(pcie->debugfs);
662b94c3195654 drivers/pci/host/pci-tegra.c Manikanta Maddireddy 2018-02-28  2577  	pcie->debugfs = NULL;
662b94c3195654 drivers/pci/host/pci-tegra.c Manikanta Maddireddy 2018-02-28  2578  }
662b94c3195654 drivers/pci/host/pci-tegra.c Manikanta Maddireddy 2018-02-28  2579  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

