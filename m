Return-Path: <linux-pci+bounces-5738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC30898C94
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 18:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A3DB2670A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802551D55D;
	Thu,  4 Apr 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xks/IabH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59512FB09;
	Thu,  4 Apr 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249347; cv=none; b=G7Zb4H298QTdWZr36aq+V7xXGkPzHkxekm2Sa5B+RhH0t739zDV/oK0EW164tAPL7mt73HLWLvPp53q/YYMLEYEI0mDuFry3XRDKFjHpkWEGdsnywOgeJDgUQvprneZBYOeZQ6+zGRDziZHFv70gfUvxZS5v8PRexMsPouxNRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249347; c=relaxed/simple;
	bh=NCHIHhS3NCawYOD9GHi3JKwQbHl1BzIb2rKZtwzxTE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F00HJJPY+r/+v8KVzeESkdDmMZiZjX3IVKbI1LGcZ4PttCzoDL05uMMQkxr1JhDZUG9RpwMgzIWBfUvVINjuZ27Xcm4Zw+mxH6KhgvZEDICYdSull+Bojmy1gctpScYOLvt5DtoE6zWjDsBmIFIp54glvcvK0F61oUVyiFUDazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xks/IabH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712249346; x=1743785346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NCHIHhS3NCawYOD9GHi3JKwQbHl1BzIb2rKZtwzxTE8=;
  b=Xks/IabHWvwe79k5oZUPuPVpYYCn/uigAWNRgCnKwn3JJbPKodMUn/Sc
   1h3ud9I0xgJcWxn9QPN14FZPSBTKLFLbCptB6CYtvKCdzilmcq0JJBwe3
   KTYOQWexyq5Z9QLcXxcYbjbfLikv4DpUv4r9QUSzslG+1mfz8pp5dL6Dq
   P/oBSTXpkEx+rSmq55eitoBb9DjZw4iY+8bmziom5CSieVSj9GTyFZJAX
   hF+XOvStBlVYrzaEShlrz5yQP6ZJ7elovyFyE4NxRLQbYPL0cdAXYn+2t
   kHBwEWb9MgtJTR07zx0s8k98jGp2nEOa46O48nTeSKjmcULCbQQ1GZcQH
   A==;
X-CSE-ConnectionGUID: p8bixpu8St6JHymqzhzJSQ==
X-CSE-MsgGUID: Ko+2F6kMQ3GkP9KqRuxSYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="32947136"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="32947136"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:49:05 -0700
X-CSE-ConnectionGUID: aE3biAaRTxu8/thS9/7KFg==
X-CSE-MsgGUID: H0B8oYeDQcelsnsC4rHSxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="49804476"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Apr 2024 09:49:02 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsQGo-0001Ic-3D;
	Thu, 04 Apr 2024 16:48:58 +0000
Date: Fri, 5 Apr 2024 00:48:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] PCI: brcmstb: Set downstream maximum {no-}snoop
 LTR values
Message-ID: <202404050015.fmF1uXeK-lkp@intel.com>
References: <20240403213902.26391-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403213902.26391-4-james.quinlan@broadcom.com>

Hi Jim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e]

url:    https://github.com/intel-lab-lkp/linux/commits/Jim-Quinlan/dt-bindings-PCI-brcmstb-Add-property-brcm-clkreq-mode/20240404-054118
base:   9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
patch link:    https://lore.kernel.org/r/20240403213902.26391-4-james.quinlan%40broadcom.com
patch subject: [PATCH v9 3/4] PCI: brcmstb: Set downstream maximum {no-}snoop LTR values
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240405/202404050015.fmF1uXeK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050015.fmF1uXeK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050015.fmF1uXeK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-brcmstb.c:728:6: warning: no previous prototype for function 'brcm_set_downstream_devs_ltr_max' [-Wmissing-prototypes]
   void brcm_set_downstream_devs_ltr_max(struct brcm_pcie *pcie)
        ^
   drivers/pci/controller/pcie-brcmstb.c:728:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void brcm_set_downstream_devs_ltr_max(struct brcm_pcie *pcie)
   ^
   static 
   1 warning generated.


vim +/brcm_set_downstream_devs_ltr_max +728 drivers/pci/controller/pcie-brcmstb.c

   727	
 > 728	void brcm_set_downstream_devs_ltr_max(struct brcm_pcie *pcie)
   729	{
   730		struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
   731		u16 ltr_fmt = FIELD_PREP(GENMASK(9, 0), BRCM_LTR_MAX_VALUE)
   732			| FIELD_PREP(GENMASK(12, 10), BRCM_LTR_MAX_SCALE)
   733			| GENMASK(15, 15);
   734	
   735		if (bridge->native_ltr)
   736			pci_walk_bus(bridge->bus, brcm_set_dev_ltr_max, &ltr_fmt);
   737	}
   738	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

