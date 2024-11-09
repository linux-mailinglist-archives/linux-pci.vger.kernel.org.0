Return-Path: <linux-pci+bounces-16376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E204A9C301E
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 00:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA611F21813
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2024 23:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF91A08B2;
	Sat,  9 Nov 2024 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkNnBGwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0319F411;
	Sat,  9 Nov 2024 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731195971; cv=none; b=TR3audH/RGREwaJeE4SeLd/EXAZThlgbew4jJzRIzA0HyqLpSTjJ3iRKskFy7Z+1Gj7aScIJcpMoprnNu6DvqPrCNVm5AwbY1abs+PeTxw6zU8tzv0xC2i+zXCBOk+K13uFri5AM5+oUSsPZAiWwb7MBKtnlhhpO9pn5KDWOzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731195971; c=relaxed/simple;
	bh=pYLrqg0RBAlLP/P2QvwUbnmxPxiYUQ+kcVAYOcIZwxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5G1cB7J/wq4BWcNFz4QoZ574rsK++IZ+k+aJWxbTM5A+6ddLNkbbAe+m4P88JQ1NVD0U2+oU/mhKTwRvyAc1U+wZ2ExGAfZPcldtCWf9Xj+DfEslKYLOFZMQZQuQCbxvOqbNivGTJTZpzbK9+5xDOsa8mbJJBZuAf+Gp4etAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkNnBGwF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731195969; x=1762731969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pYLrqg0RBAlLP/P2QvwUbnmxPxiYUQ+kcVAYOcIZwxE=;
  b=mkNnBGwFB01WYZGC2QpJ9FeaoqfW2Mqw+ID3Nh/UqVGYbp44AyhycZTl
   V1fbrwsRvnvq3u3KlpFjzbLwuXAAOZ/jDghX47YstsUx3OBirvfaQ0O3u
   2XEE8zuqHbX6svsix6rybGE1SawXyu81h0e9f4SYXJTpmerYi9+4Lu2+3
   NVlZV8heiD+HL1jKIK6eGfIU5TfZ2CYFMNf0WIRRXBif3UCv0gwW+LZX8
   VYKd40hRbG+ouhlZdcxwkzdDC9spL8LlUtUHdOkgs80h+0++D+F8520DO
   IASp+btaYxNN6liFy0fz9+J2z0xllxr0wo2mlYjfk7wd2Um+qJl9ocoSk
   A==;
X-CSE-ConnectionGUID: Ff+ILeE9RgO0J4Fvplw5PQ==
X-CSE-MsgGUID: 1fUHTcHPSVKdvZekRb4czQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53608772"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53608772"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 15:46:09 -0800
X-CSE-ConnectionGUID: x6nyOXvNS5aYX9Aia9e2fg==
X-CSE-MsgGUID: eo7rNjmZR0K0Dz6J4HwabA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="86303661"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Nov 2024 15:46:05 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9v9X-000smE-0F;
	Sat, 09 Nov 2024 23:46:03 +0000
Date: Sun, 10 Nov 2024 07:45:48 +0800
From: kernel test robot <lkp@intel.com>
To: Mayank Rana <quic_mrana@quicinc.com>, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, will@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_krichai@quicinc.com, Mayank Rana <quic_mrana@quicinc.com>
Subject: Re: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root
 complex functionality
Message-ID: <202411100738.kCgjRkIv-lkp@intel.com>
References: <20241106221341.2218416-5-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106221341.2218416-5-quic_mrana@quicinc.com>

Hi Mayank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus mani-mhi/mhi-next robh/for-next linus/master v6.12-rc6 next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mayank-Rana/PCI-dwc-Export-dwc-MSI-controller-related-APIs/20241107-061634
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241106221341.2218416-5-quic_mrana%40quicinc.com
patch subject: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root complex functionality
config: powerpc-randconfig-r131-20241109 (https://download.01.org/0day-ci/archive/20241110/202411100738.kCgjRkIv-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241110/202411100738.kCgjRkIv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411100738.kCgjRkIv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-qcom.c:1613:27: sparse: sparse: symbol 'pci_qcom_ecam_ops' was not declared. Should it be static?

vim +/pci_qcom_ecam_ops +1613 drivers/pci/controller/dwc/pcie-qcom.c

  1611	
  1612	/* ECAM ops */
> 1613	const struct pci_ecam_ops pci_qcom_ecam_ops = {
  1614		.init		= qcom_pcie_ecam_host_init,
  1615		.pci_ops	= {
  1616			.map_bus	= pci_ecam_map_bus,
  1617			.read		= pci_generic_config_read,
  1618			.write		= pci_generic_config_write,
  1619		}
  1620	};
  1621	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

