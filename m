Return-Path: <linux-pci+bounces-7200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3C8BEE94
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 23:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6EB2B20841
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6473164;
	Tue,  7 May 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYq7jawS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEC71B4C;
	Tue,  7 May 2024 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115916; cv=none; b=pc0fEyLv0QojeMgKGE779nnHYAMj4snsXmJjsGC7mdfjDbcKpq5p4nmDpF7yHJ/5JwYcvlAhFyLlOGFG3iAJ7IikcrWHimwIZ9i4pDplE241MJD9NfRWS+rRBrRGeWdilJxaQXD5SuxUDpIwSMTh0DbsuV5W0/oD1cxIo9R+okg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115916; c=relaxed/simple;
	bh=yL7SPd/Z+l9glPuW2PWEe52G5klrbEChtwcCMsumYCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGjvDgUv+R4bTbeM3T1A/x9AV/x+LGN875fN5iLRsNLvHtCAJHr6z2QCHR1CMf7mCXw1iFAzMDb032Vpp8WFmuGdyttnm0hxBeFNrVr6gJJKoLfw9HWmgQIm+AM10fCYRvGErcBuKiIbOJa2hayi4QMUmY5PS09MuNglTIgS5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYq7jawS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715115914; x=1746651914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yL7SPd/Z+l9glPuW2PWEe52G5klrbEChtwcCMsumYCU=;
  b=cYq7jawS10DmQQNcLcflLUThlT5khwYwXJvAZiSD6G4m50wU/gQ2pNjY
   sgEF/HWzeCL8i0JCyR5pwd/18mnIQlA6cT5mBpcq0nL9XAf7Jhq+51iyw
   bhA9yOcO3CbBE47ybzVlmdVyqPkaPJPpfE2b1k+zxkBNL6RH75+ybzESM
   In88r7mFtExqW6vFencxrMPJRGC9fKs2rC/kRgQreyeq1dR8NeXLV0AQL
   tqv0QME0Fp+7Oy64HaH48QxMjmGJusivmcKPeFqtV10V/cbWWrisThXMp
   QCuqbj4ur4P6gTmsXVfHjB6XyMgynov+fXLM8bE7+RUVxMdyHqoh7J1R2
   A==;
X-CSE-ConnectionGUID: YscN/smtQISMNr9B7j2iMw==
X-CSE-MsgGUID: AeCZlkQ0QzqKGcs2YE3MRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21613617"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21613617"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 14:03:54 -0700
X-CSE-ConnectionGUID: EdySXaasTj2nzIjcY31PIA==
X-CSE-MsgGUID: u4wKf0RIRd6hD7WFn21Oig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28750477"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 May 2024 14:03:49 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4RyV-0002dG-0W;
	Tue, 07 May 2024 21:03:47 +0000
Date: Wed, 8 May 2024 05:02:51 +0800
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
Message-ID: <202405080444.RUQms5qs-lkp@intel.com>
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
[also build test WARNING on pci/for-linus linus/master v6.9-rc7 next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shashank-Babu-Chinta-Venkata/PCI-qcom-Refactor-common-code/20240502-003801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240501163610.8900-2-quic_schintav%40quicinc.com
patch subject: [PATCH v4 1/3] PCI: qcom: Refactor common code
config: mips-randconfig-r112-20240508 (https://download.01.org/0day-ci/archive/20240508/202405080444.RUQms5qs-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240508/202405080444.RUQms5qs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080444.RUQms5qs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-qcom-common.c:25:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected struct icc_path * @@     got long @@
   drivers/pci/controller/dwc/pcie-qcom-common.c:25:31: sparse:     expected struct icc_path *
   drivers/pci/controller/dwc/pcie-qcom-common.c:25:31: sparse:     got long

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

