Return-Path: <linux-pci+bounces-34617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A3B32394
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 22:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8368D3B4D4B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB72D7395;
	Fri, 22 Aug 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXrWGKDB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2752D6E43;
	Fri, 22 Aug 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894438; cv=none; b=cMc5hfCxmbNj2WtHPW18FijxHFjPNdOzzYwtnWUsIkyTeVwDWBpiY+bbfS1j9l//FZ0UPXNUJIG2ZcT19cc+karl+aQ78KcrjP2HcPHU990sKVhPCvpPg2DDsDj2WtmRdqturRh3NQJBZ7g3rodT04o+5AVIHxmgQ6gjRF5VOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894438; c=relaxed/simple;
	bh=nBBEMD50am9Y7qJr724iPY3HOOKdLMrU80RREAyH+ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c47koYtG3aIpFxIkFRbJ3Fc3bGOil26Q9zOpxq5kS1p0pbqRPlG5OuZhlIdre8Qekpfp//cJkOdXajeQ9/5wiR75qjQz33mWVIwr7n/hm7LSBFjK2uvzKqpi3JtMuCsdiouAZjH5lhWgYUwHTLmAVPrm7/qlFgLLU88Giut/kuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXrWGKDB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755894437; x=1787430437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBBEMD50am9Y7qJr724iPY3HOOKdLMrU80RREAyH+ss=;
  b=RXrWGKDBy1dPzg0XaxsQ4Znwr66Vzk1RU7LKfkexFdbnIk5sH6XyHNK/
   2wo+bv1cnocnlwKwCXtVv19so9I3Y3VsqaKrecThJ3QY6XO+HxpIFai34
   ziNbKmLKBc5brQnIxOtZ0t9KrKspMGK71rdE+62hYk5AlFutBsJHqexH4
   lI9bUejvYSJ67AQfVIYjU/wLPah/EpZKDYjf7VvD7kv487YDD0GFuqQC5
   J7e8E7lDDcuyKOpjAI8t+kxRdMM/ueeTqnbyD2LEViMbE8sifKBSaIniI
   /vj2gTJKi/Gy9adPFC5pbMJQPxQHkjWf34SI20XbC+cWTwFkOT42yUWR1
   w==;
X-CSE-ConnectionGUID: DkwwdW/rRpu9pUFaE5rrMA==
X-CSE-MsgGUID: a/cQqoQnSRGeEU5xppeycw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69309216"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69309216"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:27:17 -0700
X-CSE-ConnectionGUID: DgFzLDNZTOK71KTPManp9g==
X-CSE-MsgGUID: hWX/oXuPSo2ykphPDpUs5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168981270"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 22 Aug 2025 13:27:12 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upYLu-000Lnf-1c;
	Fri, 22 Aug 2025 20:27:10 +0000
Date: Sat, 23 Aug 2025 04:26:42 +0800
From: kernel test robot <lkp@intel.com>
To: Ziyao via B4 Relay <devnull+liziyao.uniontech.com@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	niecheng1@uniontech.com, zhanjun@uniontech.com,
	guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>,
	Lain Fearyncess Yang <fsf@live.com>, Mingcong Bai <jeffbai@aosc.io>,
	Ayden Meng <aydenmeng@yeah.net>, Ziyao <liziyao@uniontech.com>
Subject: Re: [PATCH RESEND] PCI: Override PCIe bridge supported speeds for
 older Loongson 3C6000 series steppings
Message-ID: <202508230402.VUq5Fewo-lkp@intel.com>
References: <20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com>

Hi Ziyao,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3957a5720157264dcc41415fbec7c51c4000fc2d]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziyao-via-B4-Relay/PCI-Override-PCIe-bridge-supported-speeds-for-older-Loongson-3C6000-series-steppings/20250822-171721
base:   3957a5720157264dcc41415fbec7c51c4000fc2d
patch link:    https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd%40uniontech.com
patch subject: [PATCH RESEND] PCI: Override PCIe bridge supported speeds for older Loongson 3C6000 series steppings
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20250823/202508230402.VUq5Fewo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508230402.VUq5Fewo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508230402.VUq5Fewo-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/pci/quirks.c:21:
>> drivers/pci/quirks.c:1980:58: error: 'quirk_loongson_secondary_bridge_supported_speeds' undeclared here (not in a function); did you mean 'quirk_loongson_pci_bridge_supported_speeds'?
    1980 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, quirk_loongson_secondary_bridge_supported_speeds);
         |                                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2318:57: note: in definition of macro 'DECLARE_PCI_FIXUP_SECTION'
    2318 |                 = { vendor, device, class, class_shift, hook };
         |                                                         ^~~~
   drivers/pci/quirks.c:1980:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
    1980 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, quirk_loongson_secondary_bridge_supported_speeds);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/quirks.c:1965:13: warning: 'quirk_loongson_pci_bridge_supported_speeds' defined but not used [-Wunused-function]
    1965 | static void quirk_loongson_pci_bridge_supported_speeds(struct pci_dev *pdev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1980 drivers/pci/quirks.c

  1958	
  1959	/*
  1960	 * Older steppings of the Loongson 3C6000 series incorrectly report the
  1961	 * supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
  1962	 * only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
  1963	 * up to 16 GT/s.
  1964	 */
> 1965	static void quirk_loongson_pci_bridge_supported_speeds(struct pci_dev *pdev)
  1966	{
  1967		switch (pdev->bus->max_bus_speed) {
  1968		case PCIE_SPEED_16_0GT:
  1969			pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
  1970		case PCIE_SPEED_8_0GT:
  1971			pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
  1972		case PCIE_SPEED_5_0GT:
  1973			pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
  1974		case PCIE_SPEED_2_5GT:
  1975			pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
  1976		default:
  1977			break;
  1978		}
  1979	}
> 1980	DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, quirk_loongson_secondary_bridge_supported_speeds);
  1981	DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, quirk_loongson_secondary_bridge_supported_speeds);
  1982	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

