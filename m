Return-Path: <linux-pci+bounces-5736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFC1898C80
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382F11C25CF5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9AE1D559;
	Thu,  4 Apr 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qp5jlMUK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822F1F945;
	Thu,  4 Apr 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249315; cv=none; b=KyrGtGc8ZT/OFEDWpdJH/tfUOfcj3a7BCuBMpHw8ZlrpYCPc8x7IivjR/5TaLsW7ZOt/JEVpsAVsgLe+O0Ow4WpUf3MlMyLkDZC6uTZsG/yBJCeU4+6JeHiSlN8KWQwQZehsI3sEGulXg9+f5KvIjeR491Dbl6YiCXKMgWG7cME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249315; c=relaxed/simple;
	bh=4+baO60/HkS8UEwh6dSBVKOlPPoYLPD8QXa9JwEp79U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4sPoBCoposnqivR1gcItX9YpBGOGtfNOg6zNPWkqUwF1XXxcN/vwbo1IS7RIZ37qtFq6JqCNPPCs1EZ/2M4+MggXWZk9/8v2RQCCdkGImeFwq38QC3o8+jetIXRe2JI2I8x55DWE3wgB2YqCQnYnKHsvx1fg6BHSwPD8wswKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qp5jlMUK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712249314; x=1743785314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4+baO60/HkS8UEwh6dSBVKOlPPoYLPD8QXa9JwEp79U=;
  b=Qp5jlMUK0iOxzjD8Q9e8eJ5atyZulISqdhw38BCPv4mMlqnYekqrvQsh
   aGSXmDq7e9YtrZK7SfAWQVtmv7YYuuX72S9OR5vfl7NogCwH1a7qCRepd
   pB7VTuM4VuTy07mkMuihm3nQTfHsYRToPPq96aZU7J0+hmx6KGn8RxtM+
   fQR/G29NaaRYkDW150APCefIustM1OoFzDbZkXdM3ILHR7QH/X5E6xjbL
   dWrjHPeBeyI5/9UdaWZOCptyUzE199fNMXFPg2/Dm1BQy4oeDHsVKrdYQ
   Mtbp4nxNrFYyhQfemd8dehaILySDtP93jIiS23+RHsLbOY8WtDmdB9QWu
   g==;
X-CSE-ConnectionGUID: qjiki0FtRjmHpoj/GMWYlQ==
X-CSE-MsgGUID: F4vEdzfkRmWw69I52rONDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7671623"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7671623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:48:04 -0700
X-CSE-ConnectionGUID: czlhlvDrQJSA4NTlZ8L56A==
X-CSE-MsgGUID: Ai+mWD5GSb6eXXkGMVH61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18891118"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Apr 2024 09:48:00 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsQFq-0001IY-04;
	Thu, 04 Apr 2024 16:47:58 +0000
Date: Fri, 5 Apr 2024 00:47:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] PCI: brcmstb: Set downstream maximum {no-}snoop
 LTR values
Message-ID: <202404050014.hKb6rKUM-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240405/202404050014.hKb6rKUM-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050014.hKb6rKUM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050014.hKb6rKUM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-brcmstb.c:728:6: warning: no previous prototype for 'brcm_set_downstream_devs_ltr_max' [-Wmissing-prototypes]
     728 | void brcm_set_downstream_devs_ltr_max(struct brcm_pcie *pcie)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

