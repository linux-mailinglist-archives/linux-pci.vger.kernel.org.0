Return-Path: <linux-pci+bounces-18937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F149FA2BA
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1541663D7
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46957145B14;
	Sat, 21 Dec 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5SBW6uD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEE259485;
	Sat, 21 Dec 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734818698; cv=none; b=ccCABZ91B2LBse7IDZeeKX0p7Zjv0Ww+9DNazUdhxHacTaWGCEaoov3CstpjJqAbvSCye5CKRCeeUC8urSM3T64LBtxaZb4t9TFHxDkAw/mLwqZnCdbS/9Oz6GWulec0ik1e2t4mYnyXbCXqUUh2BENcQ/rf79FjdBlJXWevmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734818698; c=relaxed/simple;
	bh=CICD31YuC2DWCxXe+MIAugbnVXPhDDnOk4ss85e+Uw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu5Y03c6nkMFvV6LtPnBEIq9BttDhKHT+n5TPbu25WfJvxJQeWBTyQSarRL8yN3iJU2S3/oFcp6IDUGqYxGbozy7RatYX696dqU5yUcuPm/LhUC7rxaq/ZKhZKZsc3XCnIlPdexFiN3i2M+N3MZOXuQB28vIdaJWnZ4NcW60CEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5SBW6uD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734818697; x=1766354697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CICD31YuC2DWCxXe+MIAugbnVXPhDDnOk4ss85e+Uw4=;
  b=K5SBW6uDmpg3DOmoFCsJ+XX/kNOm+f/nBlL9WzwuN1nr/a+wN4tpeKm3
   GuXsuGKJYG6GsC7GIOXm2H+N0Rbw/PydZID0wmtU8awRlBUknRIvq3N5k
   yFdlivHp/nAmW0JVWriewfcOOcapOhqgrkfxNi6hLW9AnA5ThNS24xKwD
   3lOMp33TzuWLSEhLhhhcdStAmCIAQeEfPHUqCiqEP7/hQWDo3w+ZV2lNI
   3S1Tj3QuwJ076fIsJIQCjn/XIUPOHJx+cgrBDQy6HzkRqiEPqDmxM5HGK
   ve7aO6gYpCBKLMD2fd2RcY1Oykq5Ae6ONvkALElIyAb9ttS1+akBbMqKt
   g==;
X-CSE-ConnectionGUID: qHnGWSh1S+a+BovwM2zZCQ==
X-CSE-MsgGUID: 4FK9MrfsRCCfGZ9/dZjluA==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="39273846"
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="39273846"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 14:04:56 -0800
X-CSE-ConnectionGUID: ppUNR0XlQAKKVX8QBaEjjQ==
X-CSE-MsgGUID: G5TmL7ZYQGSNcFw1Bt+xAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="129669275"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Dec 2024 14:04:51 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tP7aZ-0002X5-2N;
	Sat, 21 Dec 2024 22:04:47 +0000
Date: Sun, 22 Dec 2024 06:04:41 +0800
From: kernel test robot <lkp@intel.com>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, andersson@kernel.org,
	konradybcio@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: [PATCH v3 2/8] phy: qcom-qmp-pcie: add dual lane PHY support for
 QCS8300
Message-ID: <202412220527.dEQSSoG8-lkp@intel.com>
References: <20241220055239.2744024-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220055239.2744024-3-quic_ziyuzhan@quicinc.com>

Hi Ziyue,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4176cf5c5651c33769de83bb61b0287f4ec7719f]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziyue-Zhang/dt-bindings-phy-qcom-sc8280xp-qmp-pcie-phy-Document-the-QCS8300-QMP-PCIe-PHY-Gen4-x2/20241220-135722
base:   4176cf5c5651c33769de83bb61b0287f4ec7719f
patch link:    https://lore.kernel.org/r/20241220055239.2744024-3-quic_ziyuzhan%40quicinc.com
patch subject: [PATCH v3 2/8] phy: qcom-qmp-pcie: add dual lane PHY support for QCS8300
config: arm64-randconfig-002-20241221 (https://download.01.org/0day-ci/archive/20241222/202412220527.dEQSSoG8-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241222/202412220527.dEQSSoG8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412220527.dEQSSoG8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-qmp-pcie.c:3419:12: error: use of undeclared identifier 'pciephy_v5_20_regs_layout'
           .regs                   = pciephy_v5_20_regs_layout,
                                     ^
   1 error generated.


vim +/pciephy_v5_20_regs_layout +3419 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c

  3390	
  3391	static const struct qmp_phy_cfg qcs8300_qmp_gen4x2_pciephy_cfg = {
  3392		.lanes			= 2,
  3393		.offsets		= &qmp_pcie_offsets_v5_20,
  3394	
  3395		.tbls = {
  3396			.serdes		= sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl,
  3397			.serdes_num		= ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl),
  3398			.tx		= sa8775p_qmp_gen4_pcie_tx_tbl,
  3399			.tx_num		= ARRAY_SIZE(sa8775p_qmp_gen4_pcie_tx_tbl),
  3400			.rx		= qcs8300_qmp_gen4x2_pcie_rx_alt_tbl,
  3401			.rx_num		= ARRAY_SIZE(qcs8300_qmp_gen4x2_pcie_rx_alt_tbl),
  3402			.pcs		= sa8775p_qmp_gen4x2_pcie_pcs_alt_tbl,
  3403			.pcs_num		= ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_pcs_alt_tbl),
  3404			.pcs_misc		= sa8775p_qmp_gen4_pcie_pcs_misc_tbl,
  3405			.pcs_misc_num	= ARRAY_SIZE(sa8775p_qmp_gen4_pcie_pcs_misc_tbl),
  3406		},
  3407	
  3408		.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
  3409			.serdes		= sa8775p_qmp_gen4x2_pcie_rc_serdes_alt_tbl,
  3410			.serdes_num	= ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_rc_serdes_alt_tbl),
  3411			.pcs_misc	= sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl,
  3412			.pcs_misc_num	= ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
  3413		},
  3414	
  3415		.reset_list		= sdm845_pciephy_reset_l,
  3416		.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
  3417		.vreg_list		= qmp_phy_vreg_l,
  3418		.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> 3419		.regs			= pciephy_v5_20_regs_layout,
  3420	
  3421		.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
  3422		.phy_status		= PHYSTATUS_4_20,
  3423	};
  3424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

