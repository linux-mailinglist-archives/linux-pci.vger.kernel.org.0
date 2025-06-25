Return-Path: <linux-pci+bounces-30642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60675AE8E4D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C541C20091
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333AC2DAFC1;
	Wed, 25 Jun 2025 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FA/FL83a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDA2D660E;
	Wed, 25 Jun 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878987; cv=none; b=U4LyPL8a2vOGt1TyF1KuHKln0C9qyYlbxMaYE5RDq9R8hd2UbqqJBw2KJW5t8VDHh6c62A9hbJ+pKT9yYBmIb757+y6LKngBCm5Mic1auVlbEg10Bzh9DckEFAk9MOezKyEtk/XvqEK/7tHAivYV144ka9jmUKG7DtMcUles6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878987; c=relaxed/simple;
	bh=jQ6meuQJB7EAkIgLMqxwrSHNKFvoSijnin1Z/61bJus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoZkLKIfL4m9YVLds0SftTCVeW9h/NhZy+/+xVL/R4uxxvCFIjIjTr6ZsOOW6eKVWCL0Q0qR/+MrC5LZGxzR+UTxu+E6Acw3ZSjKZC5f0CSCpHqUkxKGyDD/TNqlwJj4tghsnhjZsvBrH/7goYOpzRBfNA4u4umUuY4kVEE5x88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FA/FL83a; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750878985; x=1782414985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQ6meuQJB7EAkIgLMqxwrSHNKFvoSijnin1Z/61bJus=;
  b=FA/FL83aA+RpaGRoyKYQe8Ovykv+IC1jLgXgdO8dNmRFodAMAiRdaN2y
   U51yX3DJXopYXkJNy6gE+3YBTEjuEVe+rUr03tqC2D1npyT190MeZWSQo
   dpDLip262afZsx0g+rtE8EiahIWVksp2kVzx+AHI89KfOr6j5lEZkqD1n
   jyr/B8GhcLxG6zp9zMVdE1JYjtGSJmmByupqr0yFQtwZMu9KreKqSqVvd
   lkkbQIk2olnhH2WQJwbMW81AN7WWXal7wlAe3ReUJT+DX42vsNYGb8oaK
   ridnYYyCHCNFb2F4ZpN68HM/GcyQMZHmpJNMuru6Q8umLnNeOCIYWEg+W
   w==;
X-CSE-ConnectionGUID: HvMehxhzRhOnZUXyR4WYUQ==
X-CSE-MsgGUID: wmW+hECQQIm3Z1ttJMqFTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52280289"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="52280289"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 12:16:24 -0700
X-CSE-ConnectionGUID: DiGq+pIDQrWqFy1yzVRG6g==
X-CSE-MsgGUID: NNEVO8+jQdi+eQljjP0tqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="157800608"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 12:16:18 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUVbU-000TQO-28;
	Wed, 25 Jun 2025 19:16:16 +0000
Date: Thu, 26 Jun 2025 03:15:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: [PATCH v3 1/3] PCI: qcom: Add equalization settings for 8.0 GT/s
Message-ID: <202506260310.BUxJgnmS-lkp@intel.com>
References: <20250625085801.526669-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625085801.526669-2-quic_ziyuzhan@quicinc.com>

Hi Ziyue,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e04c78d86a9699d136910cfc0bdcf01087e3267e]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziyue-Zhang/PCI-qcom-Add-equalization-settings-for-8-0-GT-s/20250625-170049
base:   e04c78d86a9699d136910cfc0bdcf01087e3267e
patch link:    https://lore.kernel.org/r/20250625085801.526669-2-quic_ziyuzhan%40quicinc.com
patch subject: [PATCH v3 1/3] PCI: qcom: Add equalization settings for 8.0 GT/s
config: i386-buildonly-randconfig-002-20250626 (https://download.01.org/0day-ci/archive/20250626/202506260310.BUxJgnmS-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506260310.BUxJgnmS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506260310.BUxJgnmS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom-common.c:15:17: warning: unused variable 'dev' [-Wunused-variable]
      15 |         struct device *dev = pci->dev;
         |                        ^~~
   1 warning generated.


vim +/dev +15 drivers/pci/controller/dwc/pcie-qcom-common.c

    10	
    11	void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
    12	{
    13		u32 reg;
    14		u16 speed, max_speed = PCIE_SPEED_16_0GT;
  > 15		struct device *dev = pci->dev;
    16	
    17		/*
    18		 * GEN3_RELATED_OFF register is repurposed to apply equalization
    19		 * settings at various data transmission rates through registers namely
    20		 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
    21		 * determines the data rate for which these equalization settings are
    22		 * applied.
    23		 */
    24		if (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT)
    25			max_speed = pcie_link_speed[pci->max_link_speed];
    26	
    27		for (speed = PCIE_SPEED_8_0GT; speed <= max_speed; ++speed) {
    28			reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
    29			reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
    30			reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
    31			reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
    32				  speed - PCIE_SPEED_8_0GT);
    33			dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
    34	
    35			reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
    36			reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
    37				GEN3_EQ_FMDC_N_EVALS |
    38				GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
    39				GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
    40			reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
    41				FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
    42				FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
    43				FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
    44			dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
    45	
    46			reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
    47			reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
    48				GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
    49				GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
    50				GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
    51			dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
    52		}
    53	}
    54	EXPORT_SYMBOL_GPL(qcom_pcie_common_set_equalization);
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

