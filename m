Return-Path: <linux-pci+bounces-33652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE5B1F1D4
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 03:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A623B90CC
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86B26B09A;
	Sat,  9 Aug 2025 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVOCl4RF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749692110;
	Sat,  9 Aug 2025 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702308; cv=none; b=FuamXKxKvNulwFxxdS+oCNjDp2VJTc3xVYweCSbAnjoBW8F867aKie2Z9cB+gBRLICL7aC4dieEsAuSmuk7a2GV3ZFRg7KM5HCEDJ2/Ks05Ab0tRR2hloHVAJq+0srzelbuVP4SiCjgaluND9dIB46DIqa7nsnf3N62VrdjwTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702308; c=relaxed/simple;
	bh=Uonffv9UePhL4GK+PXgW16pRGHLF98hyvOMHiJ5gROg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCIMa0rmVtpJ0rCGjaHLyg2r419R+GRq7mg88htG3GuY7ZgsTVKi+5gkY1Fj9/a/fGIzf3+QmDpogC0V1V+KvOgAickZS0RFWQzRqLfa8N/2V5Jma35EISl+H8wTbBdFRB0rRPfUwUNdpsBgUYfdMkWPgF6RCksGrjHvGCwX4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVOCl4RF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754702306; x=1786238306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uonffv9UePhL4GK+PXgW16pRGHLF98hyvOMHiJ5gROg=;
  b=jVOCl4RFJxNwVEI0Bm5w/WUMUPSpCYk89dGiqG83kHcUOkgDJUjB/rv0
   iM4gXbJo0valgI3UR6he1N2eRmTtM7ogadZZlr0hzEBl8ovsjj+VzwLlv
   PElq4Ap7Gs7/gbj6eWkmkX7CBIto94b/WuXuoXpM0jkdSquwCMHYugUJZ
   mQhYkujWGltBAaMPZIeXJTh6Tx+3K10BhI7D+2EKWzzbvwfiN9aXwbi60
   K5asKXYAXbDNuJP3tjn2exOa/0u/mvaXE3T1eRHTEgcIM1HYZD8df5dA6
   DqS0JyYYJKA6Kxz6gthQxke7NGxd+AWB8Y1Cm7LUaDIVz4lI3fgoOZjFD
   A==;
X-CSE-ConnectionGUID: rr67oKhgS5mCP6M/298MHg==
X-CSE-MsgGUID: KBK3EKepQgeWuXafkGlTwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56085709"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56085709"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 18:18:26 -0700
X-CSE-ConnectionGUID: z2X7KJSuRfSybDOoNxtMag==
X-CSE-MsgGUID: CSP4KToLTyG/lNaa/iHXJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169677791"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2025 18:18:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukYDt-0004RM-2A;
	Sat, 09 Aug 2025 01:18:16 +0000
Date: Sat, 9 Aug 2025 09:17:32 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, robh@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v6 09/12] PCI: sky1: Add PCIe host support for CIX Sky1
Message-ID: <202508090801.2N4FsR6h-lkp@intel.com>
References: <20250808072929.4090694-10-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808072929.4090694-10-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 37816488247ddddbc3de113c78c83572274b1e2e]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Split-PCIe-controller-header-file/20250808-154018
base:   37816488247ddddbc3de113c78c83572274b1e2e
patch link:    https://lore.kernel.org/r/20250808072929.4090694-10-hans.zhang%40cixtech.com
patch subject: [PATCH v6 09/12] PCI: sky1: Add PCIe host support for CIX Sky1
config: microblaze-randconfig-r052-20250809 (https://download.01.org/0day-ci/archive/20250809/202508090801.2N4FsR6h-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090801.2N4FsR6h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090801.2N4FsR6h-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/pci/controller/cadence/pci-sky1.o: in function `sky1_pcie_remove':
>> (.text+0xc): undefined reference to `pci_ecam_free'
   microblaze-linux-ld: drivers/pci/controller/cadence/pci-sky1.o: in function `sky1_pcie_probe':
>> (.text+0x168): undefined reference to `pci_generic_ecam_ops'
>> microblaze-linux-ld: (.text+0x188): undefined reference to `pci_ecam_create'
>> microblaze-linux-ld: (.text+0x268): undefined reference to `pci_generic_ecam_ops'
>> microblaze-linux-ld: (.text+0x318): undefined reference to `pci_ecam_free'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

