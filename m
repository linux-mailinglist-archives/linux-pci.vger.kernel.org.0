Return-Path: <linux-pci+bounces-26332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6026A95144
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 14:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601653AD38F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE2B265613;
	Mon, 21 Apr 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOJYzMKp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE91DB546;
	Mon, 21 Apr 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240310; cv=none; b=XjAhF27D66yJ/0VRa34Lhwshxo3nzXAbguO73dc3TcKGuk5FVonwMVC9Jw2e9ydKc13IEaxpoDxZ0FF3WCkEjg36L89mckoYVvJTeCYqSSw4yc40Q9egMIpPKctiC/vk60n8SG+h1tv1mJVjgNPAZ7zJgNa3UJUewr8hkQ8QiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240310; c=relaxed/simple;
	bh=scE+oan0V3netAVnAvlStP1ceftqTg7r+IH2oYiDtA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDNk5lHRWkXMAIvQXiH+o6vlVEm/03rLIUYjvDj2vdsG6b8+kwu6WleanbIEme6bjEuIN5HpvcdGvMNX97YLd5M/NULvUSRK8URgrFmBpjavsCdxrOPd+yxusqSioMgqxd7AufH5+zKPF1jclAE2g3dUN+uPPpU/eUlQEw0HmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOJYzMKp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745240309; x=1776776309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=scE+oan0V3netAVnAvlStP1ceftqTg7r+IH2oYiDtA0=;
  b=hOJYzMKp0lhGZ7TSVyrm0sTHH/Gz47pSB02Y2xGQEuJIMQ+3HJxmLeGn
   rzGMgLh+o41bPIu9gxBIAPDOgcfReLUfP2+dPs5RNy8UDNKzYNbix8kgP
   iqWDITwV5b4anueUF2zqnWWl2WKaT98m5VzKGvKLRuoEoqgWqcpdi2cfW
   nDS8QsgbUVhfotbXZzbZit0crQqD8Y5zHn4i35yyMfvBVoCM002l7RmgS
   kVurj620U04SqCHhffS6g2brnL2uFdpBdzGbTlIsXgKrzIM+p8HGD1hno
   KDv4buhM5MAxJv9JJU9wuRZ1565xhi5/ExNrdCE9PwzQ45TWunNLIXiVF
   g==;
X-CSE-ConnectionGUID: zpg5nw5aQY+D5iR2zeo+mA==
X-CSE-MsgGUID: IfQvi4qgTLa7ZfMO9ox1EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46901430"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="46901430"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 05:58:28 -0700
X-CSE-ConnectionGUID: xw4oGS9qTp6pCxf+CYcwUA==
X-CSE-MsgGUID: 3qeUjkA+TPa1bVpKzRS+nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="132229155"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Apr 2025 05:58:25 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6qj8-00007j-2d;
	Mon, 21 Apr 2025 12:58:22 +0000
Date: Mon, 21 Apr 2025 20:57:36 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
Message-ID: <202504212046.SmbccNZH-lkp@intel.com>
References: <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on e3a854b577cb05ceb77c0eba54bfef98a03278fa]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Kling-via-B4-Relay/irqdomain-Export-irq_domain_free_irqs/20250421-110400
base:   e3a854b577cb05ceb77c0eba54bfef98a03278fa
patch link:    https://lore.kernel.org/r/20250420-pci-tegra-module-v1-2-c0a1f831354a%40gmail.com
patch subject: [PATCH 2/2] PCI: tegra: Allow building as a module
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20250421/202504212046.SmbccNZH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250421/202504212046.SmbccNZH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504212046.SmbccNZH-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
ERROR: modpost: "__aeabi_uldivmod" [fs/bcachefs/bcachefs.ko] undefined!
>> ERROR: modpost: "tegra_cpuidle_pcie_irqs_in_use" [drivers/pci/controller/pci-tegra.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

