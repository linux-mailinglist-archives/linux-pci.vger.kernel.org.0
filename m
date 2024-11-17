Return-Path: <linux-pci+bounces-16995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548B9D022F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 06:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0A4286CBE
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 05:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3214438DD6;
	Sun, 17 Nov 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4ZG+lih"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3926296;
	Sun, 17 Nov 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731823147; cv=none; b=HeFG+Xfr35trIYrNZe//qWBpreYMsVb4lrzOLtGCTq4g8X2TWWNaQabSETutyOaRhtLTvRi+48/sBFjzcHfMqo7wSK4twj+ZjlCJ4wGAbBA2e6PQJkozbX8gT1fvW9YD/Kp9/x5/6wKDiI5Efv/yyBk5v+dJmuPUJhHaR2L3cYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731823147; c=relaxed/simple;
	bh=JXzZ87r2R4QApQTlvo1KFc0dOMyqdnTVTxsRQDE9zB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7AwfCoMEdI0XH3fi/BhK43X1OZJfTihMS4HzDM9ZN36qhhGZYOhNMqqiVuREmj1pIHtMm0sdwf/i/nY3yKTEJ+O5WZ5H+TppeCNpcHKP8CNjP+vyuy+w1ScqhyH0aFBhAYYy8Iv3IVkwXQ1rIjrw6smOt/ySPqUvuDjQjvepLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4ZG+lih; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731823145; x=1763359145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXzZ87r2R4QApQTlvo1KFc0dOMyqdnTVTxsRQDE9zB8=;
  b=G4ZG+liheS5HOjxQSctf7qtiBt73SgKVFhZsYrHGeWdslhrwGVqq2g2E
   s+f5I38EB0LW2GtzC+KNaZP+a6nDNmsUOBNihRsa591QLdWva+y4dfHPs
   aAXevAf/+IQWWTyOFrU6zow91wprQFGzO0VoNh6LVVN5QL86UHu2SQWCS
   J5HKyRizOe2AFVmO11OgbPhlr4sHRDPMdMv/rhvPdZibb53GRCte6F6Ob
   sDSTeGB+f+2PkIV7pozPuaOpv1LR0tSYVppLZaNXELnJEO2QOgPPveg23
   KRS2tY/GkmtbGPqhtMtsH+mo38Urv9/G+OTMwE6/UBIal95wRsKdPUAKg
   g==;
X-CSE-ConnectionGUID: l3Z96moqTnGhQ4xM5nZ0kg==
X-CSE-MsgGUID: av6kc0iCQz20G9758SD3CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="43183451"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="43183451"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:59:04 -0800
X-CSE-ConnectionGUID: POm7vyX4TC6fMjdHIMjGMQ==
X-CSE-MsgGUID: J7mQVOdOTp6avvQ+UDDERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="89698889"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Nov 2024 21:59:00 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCYJF-0001a5-2d;
	Sun, 17 Nov 2024 05:58:57 +0000
Date: Sun, 17 Nov 2024 13:58:51 +0800
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
Message-ID: <202411171502.1POu4enK-lkp@intel.com>
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
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20241117/202411171502.1POu4enK-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171502.1POu4enK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171502.1POu4enK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/access.c:8:
>> drivers/pci/pci.h:803:12: warning: 'of_pci_get_equalization_presets' defined but not used [-Wunused-function]
     803 | static int of_pci_get_equalization_presets(struct device *dev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/msi/pcidev_msi.c:5:
>> drivers/pci/msi/../pci.h:803:12: warning: 'of_pci_get_equalization_presets' defined but not used [-Wunused-function]
     803 | static int of_pci_get_equalization_presets(struct device *dev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/pcie/aspm.c:27:
>> drivers/pci/pcie/../pci.h:803:12: warning: 'of_pci_get_equalization_presets' defined but not used [-Wunused-function]
     803 | static int of_pci_get_equalization_presets(struct device *dev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/of_pci_get_equalization_presets +803 drivers/pci/pci.h

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

