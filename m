Return-Path: <linux-pci+bounces-7069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F638BB988
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 07:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC8C284900
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 05:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814584C79;
	Sat,  4 May 2024 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJuy+ulU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25A4C9B;
	Sat,  4 May 2024 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714800684; cv=none; b=hY6/eFZB0be++gNCAL4HfnKadDUcTk0EzrPKArm7N2E7cEPn9sU69c4W4dOfcE9JxI+hkrzilDHalnh19t48ydxYsCQAxuI3riN8N3NDaU4fCGdR7ma3hVEL+fgbNLIMsyC1BdSoKCX1FuwM/rr8HS1x0svJwCiz5m7YY1vLzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714800684; c=relaxed/simple;
	bh=sJjOB3zA6SjbS1+qIxhCf9ws/CS6ok9FeDp/n7Smlnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlKXLY0WyTD4e56iQEJwLh8IZ6RaU6OHh0o36GStUwgSU4cKPBgS09t0Mr3O0oMwKg4+7uisTOlSOlwuyjRg04Rg60fBzZUCSP7/5Q6Q+I7X854hvE7X5p+ynTVeZCJCAuamp9dkI/9ugHC7GIplbKhmbN0bxRPQD4Q4cqteB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJuy+ulU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714800682; x=1746336682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJjOB3zA6SjbS1+qIxhCf9ws/CS6ok9FeDp/n7Smlnc=;
  b=hJuy+ulUPDySTSpOs0CKLC0nJKdG50ucxEJVQr78i4CQoiMFAHrU8A1R
   DFWy0Jc3vf/ekOfI9fsfgQEQ2iwvSWO543ueOkn88ag0/Z0ERU4kaCrWJ
   w6Ve/DWbHMT6BP9a6YDpbCpPIR5BEerO2jrQT3RrvbhuJPtSDS8Kvkfe9
   s2BFv01qvBjJ7tQyDeJRxiCetov2pks19l6TRGZRAhDjWvAQd5L3i60qg
   DYvDK6jehQI/x3to64oAmMIVLmcZFCeaCDLUtLjhhy58i0InvzmgdbyLj
   AskEutS7vGIfQRdriYGikBgwSAFdwmGsIoR309nhHgU7G5+xM22oapnGS
   w==;
X-CSE-ConnectionGUID: C6ek+s5pSG6WuacIS1rAUQ==
X-CSE-MsgGUID: Dtr1sDT8SHy7TTmM9crMdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10542783"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10542783"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:31:22 -0700
X-CSE-ConnectionGUID: GJtR8RFyRlepBvvKPvRTjQ==
X-CSE-MsgGUID: nSBnHCBQRGOzr6VphNgHqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="32450736"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 May 2024 22:31:18 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s37zO-000CSb-2k;
	Sat, 04 May 2024 05:31:14 +0000
Date: Sat, 4 May 2024 13:31:12 +0800
From: kernel test robot <lkp@intel.com>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	manivannan.sadhasivam@linaro.org, andersson@kernel.org,
	agross@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: qcom: Refactor common code
Message-ID: <202405041326.aSnZgClv-lkp@intel.com>
References: <20240501163610.8900-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501163610.8900-2-quic_schintav@quicinc.com>

Hi Shashank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shashank-Babu-Chinta-Venkata/PCI-qcom-Refactor-common-code/20240502-003801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240501163610.8900-2-quic_schintav%40quicinc.com
patch subject: [PATCH v4 1/3] PCI: qcom: Refactor common code
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240504/202405041326.aSnZgClv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405041326.aSnZgClv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405041326.aSnZgClv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom-common.c: In function 'qcom_pcie_common_icc_get_resource':
>> drivers/pci/controller/dwc/pcie-qcom-common.c:25:24: warning: returning 'long int' from a function with return type 'struct icc_path *' makes pointer from integer without a cast [-Wint-conversion]
      25 |                 return PTR_ERR(icc_mem_p);
         |                        ^~~~~~~~~~~~~~~~~~


vim +25 drivers/pci/controller/dwc/pcie-qcom-common.c

    15	
    16	#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
    17			Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
    18	
    19	struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
    20	{
    21		struct icc_path *icc_mem_p;
    22	
    23		icc_mem_p = devm_of_icc_get(pci->dev, path);
    24		if (IS_ERR_OR_NULL(icc_mem_p))
  > 25			return PTR_ERR(icc_mem_p);
    26		return icc_mem_p;
    27	}
    28	EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_get_resource);
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

