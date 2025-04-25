Return-Path: <linux-pci+bounces-26784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D97A9D006
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2435D16E21F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB2120298D;
	Fri, 25 Apr 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbfCDDr+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45591FE474;
	Fri, 25 Apr 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603446; cv=none; b=tn8K8NIYlq0oBjZ1xL+rHUhrj4bXBiWM3CjUFltaAQ/FEuePV0+K6/MNQo8hxIsCWLdiDS+lC2xQ+uHcQhh9cZ9sSSOoNIdPyN6t0J52Z1G+dQZGdUQCAdYMzNTzmD22ja1tTI5qcbJX02Gwa4IPt1is4xr4CfdGDApIcfVgu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603446; c=relaxed/simple;
	bh=TBq9KdPLCYipEt3LMjYzBCNDiYSUDsww3Xlc/H/UU+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYd4U4IthUoxPTTbWx0DPfwGkl9+Rb6ywz9fRuk1dd1htNFhXjuihojEb1KLprvLr57T95gr1tEAHOA5smlUaPveaeH2NPI7hg4dZ37QZ8O2kvdGgoAfL9JIG3Gfdbo76w7YJpHGyGgZAfwap3El2Ptk3eyi/VeGhrZXn5tqDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbfCDDr+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745603443; x=1777139443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TBq9KdPLCYipEt3LMjYzBCNDiYSUDsww3Xlc/H/UU+M=;
  b=cbfCDDr+zTzIKiw22K3BVohSoV27ka4hCifE4eZMUULts5OHs7Z2er20
   Dx9IMI6Ib50jiqhRX7QQ/9poKg9WFk+LWkRxlfZyp7xuMpczNuwvJcWTe
   /jR++co2/r2akqDQldT3oabZwoWW8RDMSyxS4IARdimYTdD5dtvEjyRLY
   VbxQ6rTOXJfpVpconvstJV9HZnZWQo5aAJe8DfMYS+lcJspAOMrE6r+ky
   FZOGX+aoAG92qUshDUgZVXte70qNRZuH7pn9Z3VIxsDLV6lb/WME3sZdx
   TMROR22asioXvsqr1NOCfZmyyAyC577nXEwfYZ0kNj0UibvuN5dida0ma
   g==;
X-CSE-ConnectionGUID: cD8V9hISTCa+HKE+No7tsA==
X-CSE-MsgGUID: HxGRcQBKQkm/VegN/UHJkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="57469605"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="57469605"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:50:43 -0700
X-CSE-ConnectionGUID: u3EXHBnuTkygiJUYesUmYw==
X-CSE-MsgGUID: 5pbw/rdKSqSbz0y4Pol9Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133488699"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Apr 2025 10:50:41 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8NCA-0005Pd-0P;
	Fri, 25 Apr 2025 17:50:38 +0000
Date: Sat, 26 Apr 2025 01:50:11 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 3/4] PCI: dwc: Add debugfs support for PTM context
Message-ID: <202504260156.kvLvB9N3-lkp@intel.com>
References: <20250424-pcie-ptm-v3-3-c929ebd2821c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-pcie-ptm-v3-3-c929ebd2821c@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0af2f6be1b4281385b618cb86ad946eded089ac8]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-Add-debugfs-support-for-exposing-PTM-context/20250425-001237
base:   0af2f6be1b4281385b618cb86ad946eded089ac8
patch link:    https://lore.kernel.org/r/20250424-pcie-ptm-v3-3-c929ebd2821c%40linaro.org
patch subject: [PATCH v3 3/4] PCI: dwc: Add debugfs support for PTM context
config: i386-buildonly-randconfig-005-20250425 (https://download.01.org/0day-ci/archive/20250426/202504260156.kvLvB9N3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504260156.kvLvB9N3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504260156.kvLvB9N3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/perf/dwc_pcie_pmu.c:18:
   include/linux/pci.h: In function 'pcie_ptm_create_debugfs':
   include/linux/pci.h:1911:39: warning: no return statement in function returning non-void [-Wreturn-type]
    1911 |                          const struct pcie_ptm_ops *ops) { }
         |                                       ^~~~~~~~~~~~
   In file included from drivers/perf/dwc_pcie_pmu.c:16:
   include/linux/pcie-dwc.h: At top level:
>> include/linux/pcie-dwc.h:38:38: warning: 'dwc_pcie_ptm_vsec_ids' defined but not used [-Wunused-const-variable=]
      38 | static const struct dwc_pcie_vsec_id dwc_pcie_ptm_vsec_ids[] = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~


vim +/dwc_pcie_ptm_vsec_ids +38 include/linux/pcie-dwc.h

    37	
  > 38	static const struct dwc_pcie_vsec_id dwc_pcie_ptm_vsec_ids[] = {
    39		{ .vendor_id = PCI_VENDOR_ID_QCOM, /* EP */
    40		  .vsec_id = 0x03, .vsec_rev = 0x1 },
    41		{ .vendor_id = PCI_VENDOR_ID_QCOM, /* RC */
    42		  .vsec_id = 0x04, .vsec_rev = 0x1 },
    43		{ }
    44	};
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

