Return-Path: <linux-pci+bounces-18678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD69F613A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DCD7A2691
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386E191F75;
	Wed, 18 Dec 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY1NRPZg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D883595C;
	Wed, 18 Dec 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513393; cv=none; b=efxJg0IyX2IlC5vMfh9S6+ss4E2sp4qfTcV7GxwI5k43ENktJhuUc1jf58AHT5N9JuU9O3eJ+H5r+JDTWcnR0tOH3nRi0wQ+NLLt2j6ARqSvYLui42eeQ5ermcTDO9hsh3iBP549B5GJug/tasPNl9BhLwJXMoiv3dfg5cajOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513393; c=relaxed/simple;
	bh=VHjNUmkxb8NwWd2KTTpGrR1dRwH0Fd8j75zWptimRWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcBPXFRDyvWgOxtXOnuA1ipzBFjPgl8/05IT0jjyQfDICO+ZOBnPxeyEza56Y+exUSSJPz2hdbvYGqj92VEIoDDL/OXdgfZ+20qs09hsPNvhprs5i9ErTIAAOWRB4RMbnNHd6ATlCFiNGvnEr1wmEUTsnqcca4LRq/Zy5AhB7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY1NRPZg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734513392; x=1766049392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VHjNUmkxb8NwWd2KTTpGrR1dRwH0Fd8j75zWptimRWQ=;
  b=iY1NRPZgfeBX9jDE3YywV54+R8NNS0Be//IWM1p65tqgtSwY0p8tnynk
   n0uiWKmd/N9mt8l9n1kThQ13CaDbSx4R9YU5zqj/cCIRxU82uOa3scMTf
   Ee59KmGivstS4jp8AE+MphLPzffD0q5AlkCt/aWhpJo753mBo4gsER3c3
   uCiw/RgnRNgGOjYNPLtlgxxDnUZYK2WG066jaf+SflIM4A56hIq9i3oHK
   luwD+yaXt64GXRHs2ReQ2++2LZqhRr+v/GBl97LG8nkClSKu8RxSNEWL9
   gwVuhRE/NuUJ8H0Tu1x5sypZXAEgkRiihtBCpN027MAkRpcNZVXABESNs
   A==;
X-CSE-ConnectionGUID: hl8vLTD+Q367LUTquCxh4g==
X-CSE-MsgGUID: 7bRBiRA6RQOUwcCZ0Sljgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="38917076"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="38917076"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:16:31 -0800
X-CSE-ConnectionGUID: j7DOQrnnRJqTrRjBITYeqQ==
X-CSE-MsgGUID: eFn9hVPaRou6L4FRFzttOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98622420"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 18 Dec 2024 01:16:28 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNqAL-000GEQ-2X;
	Wed, 18 Dec 2024 09:16:25 +0000
Date: Wed, 18 Dec 2024 17:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 4/4] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
Message-ID: <202412181640.12Iufkvd-lkp@intel.com>
References: <20241210-pci-pwrctrl-slot-v1-4-eae45e488040@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-4-eae45e488040@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-pwrctrl-Move-creation-of-pwrctrl-devices-to-pci_scan_device/20241210-180256
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/20241210-pci-pwrctrl-slot-v1-4-eae45e488040%40linaro.org
patch subject: [PATCH 4/4] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
config: x86_64-randconfig-004-20241218 (https://download.01.org/0day-ci/archive/20241218/202412181640.12Iufkvd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241218/202412181640.12Iufkvd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412181640.12Iufkvd-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
>> ERROR: modpost: "of_regulator_bulk_get_all" [drivers/pci/pwrctrl/pci-pwrctl-slot.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

