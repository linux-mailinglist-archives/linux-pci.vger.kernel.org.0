Return-Path: <linux-pci+bounces-12160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9595DEEC
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E67E282F39
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD0C2AF1D;
	Sat, 24 Aug 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hu1GeOvK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04929422;
	Sat, 24 Aug 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724516175; cv=none; b=NPpFYzLgGYIsisI2dLk315zu7RHhf8iRwUnuPuWbabybo4YfUJvkXBB4OQVTu50cDdcerXBhe4PBjdPPj95Wf08Umu0QyIe0qXmgrzJ4PKUd+3mRNvla/JX+FojGDqQd0XCqMV4TZTGM4v8QfY6BzoxGwZdL37CDJexj2MvwzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724516175; c=relaxed/simple;
	bh=5npEBL0N5rPhX3B2EfF8IFc285nRsHadiz1RjjaWL/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLCCRDQC759nrjP9o6b8isJgsO58rlqhyvW4nOnVFu3McHUDJ+vklUvtVXegk5EU+a+7JdGwiYWPrYh8/bsupymCvBjCOGAK69Obj+HWh7PkRUwU3jZhzh0Hbc0vZFRgQPC243vFhBTgDVV+fH63maAFGPmagAOd0d/oEtq0Chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hu1GeOvK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724516173; x=1756052173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5npEBL0N5rPhX3B2EfF8IFc285nRsHadiz1RjjaWL/U=;
  b=hu1GeOvKjeyW3kNoef0xrmtdRcL5/1AVu2BQwLGgjKHSaU+n51RCCLt3
   qLqFGkollv5nhcb9Dj8+ycrY1uM37BKBE6Om1vukUVr81Dv9wfXJjSk8M
   9chO5/CuM04+M8q7+tswCdObgFrtZ4E9y73Bg987odyIHI0X7f/5kJ2CC
   ZAYg1gHYhxy3I9qN6gRDP5SW2/rJGdLn++7kbjGt6euzDoD897qj7m+CV
   FPilAtebjMei6u8u8nx1zZB+b0Emy7ChyYhWAoi9MZ9o2U8HXQ9gii+pF
   PlO5Ap4UOQmGJIYka2cm/DAKBnEFvw0YMH0fsBY/2wsypFT/qJ75AMOA7
   w==;
X-CSE-ConnectionGUID: 3B8zq2/tTBKg5Cv3OmZWKg==
X-CSE-MsgGUID: dgS0Gw4MSvm/SKHV0qcsrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="26746293"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="26746293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 09:16:13 -0700
X-CSE-ConnectionGUID: J0vPG9XxRUKOTBqkmAGLcw==
X-CSE-MsgGUID: FBFCYa8eTWWkXBpfMNzgWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="66418332"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Aug 2024 09:16:08 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shtQr-000Eb5-2p;
	Sat, 24 Aug 2024 16:16:05 +0000
Date: Sun, 25 Aug 2024 00:15:25 +0800
From: kernel test robot <lkp@intel.com>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
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
Message-ID: <202408242300.2ECtncwN-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240824/202408242300.2ECtncwN-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240824/202408242300.2ECtncwN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408242300.2ECtncwN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom-ep.c:321:55: error: too few arguments to function call, expected 3, have 2
     321 |         ret = qcom_pcie_common_icc_init(pci, pcie_ep->icc_mem);
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~                      ^
   drivers/pci/controller/dwc/pcie-qcom-common.h:14:5: note: 'qcom_pcie_common_icc_init' declared here
      14 | int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
         |     ^                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +321 drivers/pci/controller/dwc/pcie-qcom-ep.c

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

