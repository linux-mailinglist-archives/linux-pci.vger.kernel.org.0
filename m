Return-Path: <linux-pci+bounces-37093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A9BA39F7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F2F1C03B88
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3C271475;
	Fri, 26 Sep 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVYWlJBv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB102EB5BD;
	Fri, 26 Sep 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889960; cv=none; b=JsOU07sh64R2z1U8+r28dIPqwm+W0P07vuXMQXhWJg1Lj0E5SXFH2+0reDQfA/7sf3/Bb5iITJpeqSX6sKgOw1UqzdLdkaCNGcp1U21eKOVn/+B7nWo4dk0dxHY9oBHLXbVi1hU3fCtAbAgkm4z0nItpH9DG/KDN+xPxoKOpkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889960; c=relaxed/simple;
	bh=d4lDBbBZf+E+Vn1KVlhkxpqT6BzklI64/P5QoolGfXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQpswWfNBkxuYlJk2s6SeAS0FJfXoBVuMYeAWtCrbiW66bRgGetoYHR+fT7rRm1treJPZm7OlpemVRPp03SiCuUp1remtm/HoqPshs+t9wKYbF8X/ntBSb+dEj0L3GeS/S8SpnOrEdJPVp1jWLZ0asLSE9s0LprZX+oP7OD07F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVYWlJBv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758889959; x=1790425959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4lDBbBZf+E+Vn1KVlhkxpqT6BzklI64/P5QoolGfXU=;
  b=EVYWlJBv7VeWxpnG/PRbzJll1v+OX2znRimfKUmShD/PXToYyUMkM9fA
   oPjuBptqx52dPAGAHPppbVNMuUk8hNFLNoJV0nhvfn8jch1NGEA0tdZXB
   BYEhBR0hZuvQ2yeRtWA4+fvl/YfIUafPSFEsMur7rGwnb5zBTNJfm+j6K
   I8N5DfcGn03RrMlgBe3quoa10TKSMS6X8Ji+txG90y88pcn+y/WlzlidB
   Qgx1HL5mPi9khqznehRQUhOiGaSS7UUJpbg19ZBY01rP3z6Vl4eXmcg7J
   XurV3aKXkV+Zj3zmr09ZbU03sekfkaGDTJKCiS8eS7nfCHt5KhLG45+vR
   g==;
X-CSE-ConnectionGUID: EWhC6XBeQbags/e5upifQw==
X-CSE-MsgGUID: 7GbJaeviQTOjzQoRZK3V/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61140626"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61140626"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:32:38 -0700
X-CSE-ConnectionGUID: /WRcMq4LSQSb8mQYjQuYbQ==
X-CSE-MsgGUID: r4JmafDPRa+InV9gPFFWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="178357303"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Sep 2025 05:32:29 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v27ch-0006D7-0v;
	Fri, 26 Sep 2025 12:32:27 +0000
Date: Fri, 26 Sep 2025 20:32:00 +0800
From: kernel test robot <lkp@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, terry.bowman@amd.com
Subject: Re: [PATCH v12 06/25] CXL/AER: Introduce aer_cxl_rch.c into AER
 driver for handling CXL RCH errors
Message-ID: <202509262001.AJLzM9is-lkp@intel.com>
References: <20250925223440.3539069-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925223440.3539069-7-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 46037455cbb748c5e85071c95f2244e81986eb58]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Remove-unnecessary-CXL-Endpoint-handling-helper-functions/20250926-064816
base:   46037455cbb748c5e85071c95f2244e81986eb58
patch link:    https://lore.kernel.org/r/20250925223440.3539069-7-terry.bowman%40amd.com
patch subject: [PATCH v12 06/25] CXL/AER: Introduce aer_cxl_rch.c into AER driver for handling CXL RCH errors
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20250926/202509262001.AJLzM9is-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262001.AJLzM9is-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262001.AJLzM9is-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/of.c:18:
>> drivers/pci/pci.h:1208:69: warning: 'struct aer_err_info' declared inside parameter list will not be visible outside of this definition or declaration
    1208 | static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
         |                                                                     ^~~~~~~~~~~~
   drivers/pci/pci.h:1215:45: warning: 'struct aer_err_info' declared inside parameter list will not be visible outside of this definition or declaration
    1215 | static inline bool is_internal_error(struct aer_err_info *info) { return false; }
         |                                             ^~~~~~~~~~~~


vim +1208 drivers/pci/pci.h

  1199	
  1200	#define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
  1201		(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
  1202		 PCI_CONF1_EXT_REG(reg))
  1203	
  1204	#ifdef CONFIG_CXL_RCH_RAS
  1205	void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
  1206	void cxl_rch_enable_rcec(struct pci_dev *rcec);
  1207	#else
> 1208	static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
  1209	static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
  1210	#endif
  1211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

