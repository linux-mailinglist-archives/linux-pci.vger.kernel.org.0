Return-Path: <linux-pci+bounces-16994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3589D022B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 06:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F578B21F59
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186F282F4;
	Sun, 17 Nov 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPAZtno1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF015E96;
	Sun, 17 Nov 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731822545; cv=none; b=Hbq5/V4qxHieaLoOI6/mf5QBd2xffGDQk0xaMKsZp1TqIhY3pkDhMKRWRva9NB6t6eExEt6M/mxFVcLZtJgerkvGNaUgqBuONOSjcxSXcR7gEapVe1WoZTWCLhBIkvyYQSGoPGEWm9kHTI/H91mpbbhL+4ljN+23kh58/8hON1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731822545; c=relaxed/simple;
	bh=K5mcIFf6KWqYvD7AWDGPfJ4yz3xBRzhejZq9iMDkX8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDOyhp1pENp+HkTxwu5a3cMIILRk2MWBk2VdK7mYoLMcD4FQxvBWLTd7rtlc5lrQYyCGm1GVUuBB9vXvdst002uXePtim/BsgdrBbyx0jSHx+T7iOoUWmhlFD1mSo056a7F6xmK014yZAjVPHXEecDNGtFtDJQqIdQprghsok8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPAZtno1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731822544; x=1763358544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K5mcIFf6KWqYvD7AWDGPfJ4yz3xBRzhejZq9iMDkX8I=;
  b=QPAZtno1hcK9ot5OgCilhSI7YJu1uCwTZuXQFB9QjakDdhAaelGkJsxk
   q/p7uHSEtyYUsxV3FRyhiQJw7bIAXhaWsjIVeew4jRNx7WNFpDGtGkRXc
   PPqK0KZH3nIQC+C1uapcIp/1SsXyJPt/YKaSavnOL/AyItFgLao76q0Iv
   RZGhs4Kr/ief/NPKCZDrYLdNi3112k2KB3kLzJO5gtaXVTmAnFB/ehy0g
   2CMiH/FstIxDc3ysLg/m9i6UrfttzxKo546xRqeYM2kGA3/jYX/vB/nUG
   2XWUVOg6kd0wVuOT2HamkfBNx+3Gi0XHQPBZ/Xq4tO4m85mGG2nk/NYtZ
   A==;
X-CSE-ConnectionGUID: BrR0WxswTSSUQRNRJUcRtQ==
X-CSE-MsgGUID: aovsbX5hT/aDTDwvBC6TyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31176351"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31176351"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:49:04 -0800
X-CSE-ConnectionGUID: RfKSW4tFSdOtMaW5d3L56g==
X-CSE-MsgGUID: 2M7UIhSVQLGr9mmiGOdWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="88818447"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Nov 2024 21:49:00 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCY9Z-0001Zt-0V;
	Sun, 17 Nov 2024 05:48:57 +0000
Date: Sun, 17 Nov 2024 13:48:34 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
	kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?unknown-8bit?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Message-ID: <202411171316.4RG7T90F-lkp@intel.com>
References: <20241116-presets-v1-2-878a837a4fee@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116-presets-v1-2-878a837a4fee@quicinc.com>

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 81983758430957d9a5cb3333fe324fd70cf63e7e]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/arm64-dts-qcom-x1e80100-Add-PCIe-lane-equalization-preset-properties/20241117-000950
base:   81983758430957d9a5cb3333fe324fd70cf63e7e
patch link:    https://lore.kernel.org/r/20241116-presets-v1-2-878a837a4fee%40quicinc.com
patch subject: [PATCH 2/4] PCI: of: Add API to retrieve equalization presets from device tree
config: i386-buildonly-randconfig-005-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171316.4RG7T90F-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171316.4RG7T90F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171316.4RG7T90F-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-designware.c:23:
>> drivers/pci/controller/dwc/../../pci.h:803:12: warning: 'of_pci_get_equalization_presets' defined but not used [-Wunused-function]
     803 | static int of_pci_get_equalization_presets(struct device *dev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/of_pci_get_equalization_presets +803 drivers/pci/controller/dwc/../../pci.h

   802	
 > 803	static int of_pci_get_equalization_presets(struct device *dev,
   804						   struct pci_eq_presets *presets,
   805						   int num_lanes)
   806	{
   807		return 0;
   808	}
   809	#endif /* CONFIG_OF */
   810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

