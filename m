Return-Path: <linux-pci+bounces-16162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE79BF5DD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 19:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2A1B217D3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1758720A5CF;
	Wed,  6 Nov 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDkLwPHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6B20969F
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919538; cv=none; b=Y4EJt65EAhON4TAuGyyDs1ZSDhpj3d5wCHChraDJeAbwwuobma14KlmrRW+D8QhP53EoCQJ37xJg2+aFjvFixwseKypocff+qLlFo5HGW6oIcqVHnT/kFjdAPNCbCiVDXvkjl51J7WFNFX0NKbzt8ByJWRSPSiKZF2kFwpztNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919538; c=relaxed/simple;
	bh=yve0O4eLXbDOf5S5SW6eMuDz9aLA90dqdPjs8e7p6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CFRuMGeZxFmJ4BzOi0+eiVArwR7HcV+9cJmKCGmbNLeCv4YU6bZbdX3mNmTltzQZnAUj0luar/PJ9SRKa6y8JDfAg9V0cdcvse2Y+ZzmA0yTLmnCFYDsOxFgOp4BS1N0NhJVhwEjc2SUqELrY89vlcRFglXtV2MPPm4WVagZmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDkLwPHo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919536; x=1762455536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yve0O4eLXbDOf5S5SW6eMuDz9aLA90dqdPjs8e7p6kI=;
  b=GDkLwPHolPhcxx5guWnocI0hxsF6+lAv7cD9NxvdakKZUMjzECKct8Sl
   yFwlqAEURDYCoMEXbCyBvBIPERP86gFAlfUln76K+/R4UHGuGo6QV1pzR
   RXiGwXzet2bSE0uzLOYv/UNpyHWCy6E46K0/Gv3Y4E9zFKkHTOba8DkK7
   ei9dshCzL6bCQ6SGyct9OFkcE+Kj65h5yqUEdEAFvHn5WEE2WfPT8IL8Q
   7DmiJpH957BkeUdb6rf7tJJxtmRKAo4HQl4ZxvhX87wov08RJCvDta+26
   yPHIpn/At0ALHPWaI+xvkjkE/uFz8xtQ3p1U8QV1VoS3zoelF+dlKldbf
   Q==;
X-CSE-ConnectionGUID: bpLU5InMSBG719uY7y1E6A==
X-CSE-MsgGUID: p9R0XM8dTtueyI/LcdfFVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30959493"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30959493"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:58:55 -0800
X-CSE-ConnectionGUID: Rl0ki3B+RguWWQnYqdj/qw==
X-CSE-MsgGUID: z9DCtyhKRTixZqBtgSWysg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89813517"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 10:57:33 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8lDe-000pJc-1r;
	Wed, 06 Nov 2024 18:57:30 +0000
Date: Thu, 7 Nov 2024 02:56:31 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Fei Shao <fshao@chromium.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [pci:controller/mediatek 2/2]
 drivers/pci/controller/pcie-mediatek-gen3.c:898:14: error: implicit
 declaration of function 'of_property_read_u31'; did you mean
 'of_property_read_u32'?
Message-ID: <202411070226.YqavKDUD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
head:   2bee4c1a6fc0408242aedca80a102ef50c0dfbe5
commit: 2bee4c1a6fc0408242aedca80a102ef50c0dfbe5 [2/2] PCI: mediatek-gen3: Add support for restricting link width
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241107/202411070226.YqavKDUD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070226.YqavKDUD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070226.YqavKDUD-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-mediatek-gen3.c: In function 'mtk_pcie_parse_port':
>> drivers/pci/controller/pcie-mediatek-gen3.c:898:14: error: implicit declaration of function 'of_property_read_u31'; did you mean 'of_property_read_u32'? [-Wimplicit-function-declaration]
     898 |        ret = of_property_read_u31(dev->of_node, "num-lanes", &num_lanes);
         |              ^~~~~~~~~~~~~~~~~~~~
         |              of_property_read_u32


vim +898 drivers/pci/controller/pcie-mediatek-gen3.c

   845	
   846	static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
   847	{
   848		int i, ret, num_resets = pcie->soc->phy_resets.num_resets;
   849		struct device *dev = pcie->dev;
   850		struct platform_device *pdev = to_platform_device(dev);
   851		struct resource *regs;
   852		u32 num_lanes;
   853	
   854		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
   855		if (!regs)
   856			return -EINVAL;
   857		pcie->base = devm_ioremap_resource(dev, regs);
   858		if (IS_ERR(pcie->base)) {
   859			dev_err(dev, "failed to map register base\n");
   860			return PTR_ERR(pcie->base);
   861		}
   862	
   863		pcie->reg_base = regs->start;
   864	
   865		for (i = 0; i < num_resets; i++)
   866			pcie->phy_resets[i].id = pcie->soc->phy_resets.id[i];
   867	
   868		ret = devm_reset_control_bulk_get_optional_shared(dev, num_resets, pcie->phy_resets);
   869		if (ret) {
   870			dev_err(dev, "failed to get PHY bulk reset\n");
   871			return ret;
   872		}
   873	
   874		pcie->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
   875		if (IS_ERR(pcie->mac_reset)) {
   876			ret = PTR_ERR(pcie->mac_reset);
   877			if (ret != -EPROBE_DEFER)
   878				dev_err(dev, "failed to get MAC reset\n");
   879	
   880			return ret;
   881		}
   882	
   883		pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
   884		if (IS_ERR(pcie->phy)) {
   885			ret = PTR_ERR(pcie->phy);
   886			if (ret != -EPROBE_DEFER)
   887				dev_err(dev, "failed to get PHY\n");
   888	
   889			return ret;
   890		}
   891	
   892		pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
   893		if (pcie->num_clks < 0) {
   894			dev_err(dev, "failed to get clocks\n");
   895			return pcie->num_clks;
   896		}
   897	
 > 898	       ret = of_property_read_u31(dev->of_node, "num-lanes", &num_lanes);
   899	       if (ret == 0) {
   900		       if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
   901				dev_warn(dev, "invalid num-lanes, using controller defaults\n");
   902		       else
   903				pcie->num_lanes = num_lanes;
   904	       }
   905	
   906		return 0;
   907	}
   908	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

