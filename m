Return-Path: <linux-pci+bounces-26024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A7CA909D9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3BA7ACD16
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807221ABD4;
	Wed, 16 Apr 2025 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMtpy1oe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887F21C162;
	Wed, 16 Apr 2025 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823793; cv=none; b=thyhWpkVlsvpgCQp2FBNzIy9+lj9xfXsM5snImOwDLdaBJk4ZYJniqrcE4YG9e0zVuHjb8KqrTbS+g5sOS4N4B63KlMyDYBxUQCzMeazb+EXjdfIk88CU9Jst6DUEpVFqFXyb0zWdE7R9IOGa3HOy+vs6goHitFp8uocQXgZu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823793; c=relaxed/simple;
	bh=taVQQkw3FOUMcF5ublnCq+0dNIVsAf3UO57Pec7tlNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j38tgMFOSauB876b7gABuFqEsDD0JUC1Ib6kT/mzEytjDw1YwmEUH8SsFWsuBaVDXfwe0cL/PEdar1HZGeyffb8QXcQQ/1ryO5m5It0PbR1rGBAiLaFl5MUdP+W8klwy1iPuAS3EkVqfJZ8RUWzotrnWqQYasXc74myE0SaK608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMtpy1oe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744823791; x=1776359791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=taVQQkw3FOUMcF5ublnCq+0dNIVsAf3UO57Pec7tlNk=;
  b=ZMtpy1oeSJhwIjMGUmi+/m5MKmPw/ek7Byi+DAnlb7iZgHSm5Jyi5JuG
   pOBd9AK5GFnupxm+8R5AJTBXx+Aq5aEQF+qtL5tsWSnMjQAztJQtjLqGI
   9BBA2O7ZrUpuDprWRUFmCGUG8lqsZggEKBP7cVtCeMlOS9ZFcfKnbEkyj
   z+TuwZ9ANefstpA6Nwva2ocpRelsmdHhHc/JvccxRMd5pK080fpSl3H36
   guBHtQ4hjP0WqKxy3h0g4UkOlTuelA+jjFP4Wx4ZDsFjBR8vOho+X8f4u
   0Xw8zT64bgSHizVItp7CVf/UNZNQEPz03Kxvr20Ynpq9ehP3oPECwP/sz
   Q==;
X-CSE-ConnectionGUID: znjelGkQQAS3Jw27i5uLIQ==
X-CSE-MsgGUID: RfMyVkB0REKq3xFNo+SHLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57382077"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="57382077"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 10:16:30 -0700
X-CSE-ConnectionGUID: NaxrGpnzSm+nJ/yHWfN4Jw==
X-CSE-MsgGUID: y9ug51VPSkWZljs3fe6zUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="131524887"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Apr 2025 10:16:27 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u56N6-000K76-1r;
	Wed, 16 Apr 2025 17:16:24 +0000
Date: Thu, 17 Apr 2025 01:15:59 +0800
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
Message-ID: <202504170034.ZUFz0z7Z-lkp@intel.com>
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
config: arm64-kismet-CONFIG_PHY_TEGRA194_P2U-CONFIG_PCIE_TEGRA194_HOST-0-0 (https://download.01.org/0day-ci/archive/20250417/202504170034.ZUFz0z7Z-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250417/202504170034.ZUFz0z7Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504170034.ZUFz0z7Z-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PHY_TEGRA194_P2U when selected by PCIE_TEGRA194_HOST
   WARNING: unmet direct dependencies detected for PHY_TEGRA194_P2U
     Depends on [n]: ARCH_TEGRA_194_SOC [=n] || ARCH_TEGRA_234_SOC [=n] || COMPILE_TEST [=n]
     Selected by [y]:
     - PCIE_TEGRA194_HOST [=y] && PCI [=y] && ARCH_TEGRA [=y] && (ARM64 [=y] || COMPILE_TEST [=n]) && PCI_MSI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

