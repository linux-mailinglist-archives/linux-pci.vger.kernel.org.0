Return-Path: <linux-pci+bounces-12164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54595DF6D
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 20:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375AE1F21E36
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7A4D9FE;
	Sat, 24 Aug 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLOlvG8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777346444;
	Sat, 24 Aug 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522838; cv=none; b=coHJt4Vv+DqWd/nheTNo6sXRdz0D+useaAv8fkXVRPvvGsZDBCEu+7qciwH6D//azbZS+glOXg+7Eei1xWN8VnYtldKEukE/QQV2fEuBIrfoYX3t0RIQc+YolX2GwovTOC2mxoE9frVU2CpcYPz6zQ64M1+qLRY2GdEPwUZ3Fgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522838; c=relaxed/simple;
	bh=R0OLMJUVdM4TQ8DHQAOzmYCPJfMohLxpBesvfQ/mu0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEVjlJHUc/gRYBZfBizIGRRRng1UHjNJOO8LfwGiDdEFSCkYVjKCNmDWe5VcZAPDPRUJgR0esrJE9oIPiRXrLiVFGfqMG54iIm1ZFYKS2mrIzPOJj0FkxvSSeYkn0Kw4xjMH+JtuP8gsSWqu4Bx05RyToSFSdle84n8oSbZy9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLOlvG8D; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724522837; x=1756058837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R0OLMJUVdM4TQ8DHQAOzmYCPJfMohLxpBesvfQ/mu0Y=;
  b=fLOlvG8DE2vHXG/KvLNj8la3E1BIf5C9AVKPMaJ4ZrbT2bwzSzDBz7IS
   LrtiEhGs9vV5Oq7H/ogZQA29YLsY39m4voQMlPkGJorv9z+fMzYloUd6b
   ySXLj1Z2nOkS4956v9zAGGQgA0Dc933L3ijY8m1DEH43WxW1aMYV114lR
   WcVIe0CGg/UrSlfxCLAHM3AFhkM3L7axgh6POqnqnzdXymu6Xx6VVsraY
   SJAOMO5YuPo9thic+LHCgVfbl+t595VUzZcN55dWfB/3EWi12VT49sg8g
   jLG3RKONSmm81yhcpVpmgNtpxlzQ+VkGm+GRW8tQj2tG6K8/B8Y1ER88S
   g==;
X-CSE-ConnectionGUID: QWpFrgt3RoiIo0/jZ/TDnQ==
X-CSE-MsgGUID: Ci1UV9p2TJSsu11RlsTn0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22953099"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="22953099"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 11:07:17 -0700
X-CSE-ConnectionGUID: 4gfmJLFwSCmbYJA1ATfaXg==
X-CSE-MsgGUID: +j9lB1OzTdigwV2EAOQ2zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="66813144"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Aug 2024 11:07:11 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shvAK-000Eff-3D;
	Sat, 24 Aug 2024 18:07:08 +0000
Date: Sun, 25 Aug 2024 02:06:59 +0800
From: kernel test robot <lkp@intel.com>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Refactor common code
Message-ID: <202408242341.lywV11DL-lkp@intel.com>
References: <20240821170917.21018-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821170917.21018-2-quic_schintav@quicinc.com>

Hi Shashank,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on linus/master v6.11-rc4]
[cannot apply to pci/for-linus next-20240823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shashank-Babu-Chinta-Venkata/PCI-qcom-Refactor-common-code/20240822-011229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240821170917.21018-2-quic_schintav%40quicinc.com
patch subject: [PATCH v5 1/3] PCI: qcom: Refactor common code
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240824/202408242341.lywV11DL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240824/202408242341.lywV11DL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408242341.lywV11DL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom-ep.c: In function 'qcom_pcie_enable_resources':
>> drivers/pci/controller/dwc/pcie-qcom-ep.c:321:15: error: too few arguments to function 'qcom_pcie_common_icc_init'
     321 |         ret = qcom_pcie_common_icc_init(pci, pcie_ep->icc_mem);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/controller/dwc/pcie-qcom-ep.c:28:
   drivers/pci/controller/dwc/pcie-qcom-common.h:14:5: note: declared here
      14 | int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/qcom_pcie_common_icc_init +321 drivers/pci/controller/dwc/pcie-qcom-ep.c

   295	
   296	static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
   297	{
   298		struct dw_pcie *pci = &pcie_ep->pci;
   299		int ret;
   300	
   301		ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
   302		if (ret)
   303			return ret;
   304	
   305		ret = qcom_pcie_ep_core_reset(pcie_ep);
   306		if (ret)
   307			goto err_disable_clk;
   308	
   309		ret = phy_init(pcie_ep->phy);
   310		if (ret)
   311			goto err_disable_clk;
   312	
   313		ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_EP);
   314		if (ret)
   315			goto err_phy_exit;
   316	
   317		ret = phy_power_on(pcie_ep->phy);
   318		if (ret)
   319			goto err_phy_exit;
   320	
 > 321		ret = qcom_pcie_common_icc_init(pci, pcie_ep->icc_mem);
   322		if (ret) {
   323			dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
   324				ret);
   325			goto err_phy_off;
   326		}
   327	
   328		return 0;
   329	
   330	err_phy_off:
   331		phy_power_off(pcie_ep->phy);
   332	err_phy_exit:
   333		phy_exit(pcie_ep->phy);
   334	err_disable_clk:
   335		clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
   336	
   337		return ret;
   338	}
   339	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

