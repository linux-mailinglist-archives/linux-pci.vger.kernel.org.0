Return-Path: <linux-pci+bounces-11233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC1946963
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 13:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA91C20B59
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5C14EC52;
	Sat,  3 Aug 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3ElNFyv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E8514E2F6;
	Sat,  3 Aug 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683409; cv=none; b=K3kymWgZeshG6E7tT7ww44evcB2/eYRaTMXUzDUtMhl6l1Cx5nk36Qh4ZbTQksneXf614zZG7KJy3XS7dtZlYb7BltkCX17wbOrdNjlflpmS52m8l4ktTeaXivUQrt2zmQygObrWrdSoDM3Gt9LmRwcPBFrWZqxXpdW+ajxCw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683409; c=relaxed/simple;
	bh=x3si7t6ipvGyzFV+5rMUKZh3I2NBFPG9mfGUanh83vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP0SW8DFXlvwje0CIKTnX3P1SbdQY7njQgQugEcZq5vTJROZMxQNzlsqd7laUxCHIEKLyuYag1edMjpX2+v7UHuup6QIBpOsfjiVJ9gqppCSTbNNYS+4oBNxSfuLl62Jl2/IO7cFvcVJnrRFn9SSgJW0pBwhuise0aHZuzgaT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3ElNFyv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722683407; x=1754219407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x3si7t6ipvGyzFV+5rMUKZh3I2NBFPG9mfGUanh83vw=;
  b=G3ElNFyv+kmtVDPpfGoNOfXRPjPNXirScQT04R9ZW5I9W+mSXmfCtbZg
   4Gr38IJqqfxuxDnk8EsL3vSkz8s1tEIJEMNl1ORfWMFNy3ckn94QWf18c
   zcOy/uYYaEsS50A22IO5fza2FGmVqJidvXmagjXdLrDZesrowCN2A+wze
   tA5EpBnr5+aEUM7iUs/W3uUOuOC/AOIdJ1qRRggOl15tk1e11sK9/xuKB
   dFToqdO4jmcQxLiI35ibJ0lkUoUaUUdwIzmzuSNHx1b4H2We9IfORwsj6
   2tLK91nsK1Q+oKf0YZ74yx8pUdvRwe3JgFdIACVMar5k2HR2Vdiv6gyTn
   A==;
X-CSE-ConnectionGUID: WNCmN0RiTfigdSOi0dT2wQ==
X-CSE-MsgGUID: oC2zvLB/QuC0QPkEO+QpVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24466438"
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="24466438"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 04:10:02 -0700
X-CSE-ConnectionGUID: vbop2u3rS16WtPYntLB90A==
X-CSE-MsgGUID: zuckd/NTQYq2l0XJmqlmmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="55626183"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Aug 2024 04:09:59 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saCe5-0000Ok-1V;
	Sat, 03 Aug 2024 11:09:57 +0000
Date: Sat, 3 Aug 2024 19:03:56 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 2/4] PCI: Rename pci_bridge_d3_possible() to
 pci_bridge_d3_allowed()
Message-ID: <202408031855.TEPJlfzl-lkp@intel.com>
References: <20240802-pci-bridge-d3-v5-2-2426dd9e8e27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-pci-bridge-d3-v5-2-2426dd9e8e27@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 705c1da8fa4816fb0159b5602fef1df5946a3ee2]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-portdrv-Make-use-of-pci_dev-bridge_d3-for-checking-the-D3-possibility/20240803-074434
base:   705c1da8fa4816fb0159b5602fef1df5946a3ee2
patch link:    https://lore.kernel.org/r/20240802-pci-bridge-d3-v5-2-2426dd9e8e27%40linaro.org
patch subject: [PATCH v5 2/4] PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240803/202408031855.TEPJlfzl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408031855.TEPJlfzl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408031855.TEPJlfzl-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/radeon/radeon_atpx_handler.c: In function 'radeon_atpx_detect':
>> drivers/gpu/drm/radeon/radeon_atpx_handler.c:568:59: error: 'struct pci_dev' has no member named 'bridge_d3'
     568 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
         |                                                           ^~
   drivers/gpu/drm/radeon/radeon_atpx_handler.c:578:59: error: 'struct pci_dev' has no member named 'bridge_d3'
     578 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
         |                                                           ^~
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c: In function 'amdgpu_atpx_detect':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c:628:59: error: 'struct pci_dev' has no member named 'bridge_d3'
     628 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
         |                                                           ^~
   drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c:638:59: error: 'struct pci_dev' has no member named 'bridge_d3'
     638 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
         |                                                           ^~
--
   drivers/gpu/drm/nouveau/nouveau_acpi.c: In function 'nouveau_dsm_pci_probe':
>> drivers/gpu/drm/nouveau/nouveau_acpi.c:229:32: error: 'struct pci_dev' has no member named 'bridge_d3'
     229 |                 if (parent_pdev->bridge_d3)
         |                                ^~


vim +568 drivers/gpu/drm/radeon/radeon_atpx_handler.c

6a9ee8af344e3b Dave Airlie  2010-02-01  545  
82e029357d4726 Alex Deucher 2012-08-16  546  /**
82e029357d4726 Alex Deucher 2012-08-16  547   * radeon_atpx_detect - detect whether we have PX
82e029357d4726 Alex Deucher 2012-08-16  548   *
82e029357d4726 Alex Deucher 2012-08-16  549   * Check if we have a PX system (all asics).
82e029357d4726 Alex Deucher 2012-08-16  550   * Returns true if we have a PX system, false if not.
82e029357d4726 Alex Deucher 2012-08-16  551   */
6a9ee8af344e3b Dave Airlie  2010-02-01  552  static bool radeon_atpx_detect(void)
6a9ee8af344e3b Dave Airlie  2010-02-01  553  {
6a9ee8af344e3b Dave Airlie  2010-02-01  554  	char acpi_method_name[255] = { 0 };
6a9ee8af344e3b Dave Airlie  2010-02-01  555  	struct acpi_buffer buffer = {sizeof(acpi_method_name), acpi_method_name};
6a9ee8af344e3b Dave Airlie  2010-02-01  556  	struct pci_dev *pdev = NULL;
6a9ee8af344e3b Dave Airlie  2010-02-01  557  	bool has_atpx = false;
6a9ee8af344e3b Dave Airlie  2010-02-01  558  	int vga_count = 0;
bcfdd5d5105087 Alex Deucher 2016-11-28  559  	bool d3_supported = false;
bcfdd5d5105087 Alex Deucher 2016-11-28  560  	struct pci_dev *parent_pdev;
6a9ee8af344e3b Dave Airlie  2010-02-01  561  
6a9ee8af344e3b Dave Airlie  2010-02-01  562  	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
6a9ee8af344e3b Dave Airlie  2010-02-01  563  		vga_count++;
6a9ee8af344e3b Dave Airlie  2010-02-01  564  
6a9ee8af344e3b Dave Airlie  2010-02-01  565  		has_atpx |= (radeon_atpx_pci_probe_handle(pdev) == true);
bcfdd5d5105087 Alex Deucher 2016-11-28  566  
bcfdd5d5105087 Alex Deucher 2016-11-28  567  		parent_pdev = pci_upstream_bridge(pdev);
bcfdd5d5105087 Alex Deucher 2016-11-28 @568  		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
6a9ee8af344e3b Dave Airlie  2010-02-01  569  	}
6a9ee8af344e3b Dave Airlie  2010-02-01  570  
e9a4099a59cc59 Alex Deucher 2014-04-15  571  	/* some newer PX laptops mark the dGPU as a non-VGA display device */
e9a4099a59cc59 Alex Deucher 2014-04-15  572  	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
e9a4099a59cc59 Alex Deucher 2014-04-15  573  		vga_count++;
e9a4099a59cc59 Alex Deucher 2014-04-15  574  
e9a4099a59cc59 Alex Deucher 2014-04-15  575  		has_atpx |= (radeon_atpx_pci_probe_handle(pdev) == true);
bcfdd5d5105087 Alex Deucher 2016-11-28  576  
bcfdd5d5105087 Alex Deucher 2016-11-28  577  		parent_pdev = pci_upstream_bridge(pdev);
bcfdd5d5105087 Alex Deucher 2016-11-28  578  		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
e9a4099a59cc59 Alex Deucher 2014-04-15  579  	}
e9a4099a59cc59 Alex Deucher 2014-04-15  580  
6a9ee8af344e3b Dave Airlie  2010-02-01  581  	if (has_atpx && vga_count == 2) {
492b49a2f21a7c Alex Deucher 2012-08-16  582  		acpi_get_name(radeon_atpx_priv.atpx.handle, ACPI_FULL_PATHNAME, &buffer);
7ca85295d8cc28 Joe Perches  2017-02-28  583  		pr_info("vga_switcheroo: detected switching method %s handle\n",
6a9ee8af344e3b Dave Airlie  2010-02-01  584  			acpi_method_name);
6a9ee8af344e3b Dave Airlie  2010-02-01  585  		radeon_atpx_priv.atpx_detected = true;
bcfdd5d5105087 Alex Deucher 2016-11-28  586  		radeon_atpx_priv.bridge_pm_usable = d3_supported;
69ee9742f945cd Alex Deucher 2016-07-27  587  		radeon_atpx_init();
6a9ee8af344e3b Dave Airlie  2010-02-01  588  		return true;
6a9ee8af344e3b Dave Airlie  2010-02-01  589  	}
6a9ee8af344e3b Dave Airlie  2010-02-01  590  	return false;
6a9ee8af344e3b Dave Airlie  2010-02-01  591  }
6a9ee8af344e3b Dave Airlie  2010-02-01  592  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

