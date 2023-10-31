Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F77DD913
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjJaXE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjJaXE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 19:04:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209BC103;
        Tue, 31 Oct 2023 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698793466; x=1730329466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rrdo+pxc08eDuJsbTiYZVvEMJaUTmPZQSBv0NuXRWOU=;
  b=bmVR+nPfEcqzuAksavwnrj9DzkYsLpL3Yolpz8S0jwz6uJMtMq+HVNhp
   HNkabBant4QD2sHZO3UcPm1j+jUB7ASas4l+j66QZncsmMfyj32zlLSA0
   wTIHh0xbeYRtJPGdTlZzSv1iV2w6zFwPc11kfbGReziRO1so8YOxShGTU
   kxSpdYxuAh1ZnHmcKz6ZHXTVAfLfuCcAECOYDCJ8UmQvBjgUoh+KjWfRr
   04c6iRRLhv/J01b48saEYsa9l93mFBfbodwVpaj5zNV9zhB+Tqcx801+Y
   E5q+ellffiet65WPJHOrBwsC90xJaZG61aXRss771/cXpd5qAj+VS9VXh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387276548"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="387276548"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 16:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="8855384"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Oct 2023 16:03:56 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxxm6-0000Ro-2b;
        Tue, 31 Oct 2023 23:03:54 +0000
Date:   Wed, 1 Nov 2023 07:02:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>, bhelgaas@google.com,
        mika.westerberg@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Alexander.Deucher@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <202311010646.KCczSLIW-lkp@intel.com>
References: <20231031133438.5299-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031133438.5299-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/for-linus]
[also build test WARNING on westeri-thunderbolt/next linus/master v6.6 next-20231031]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PCI-Ignore-PCIe-ports-used-for-tunneling-in-pcie_bandwidth_available/20231031-224221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20231031133438.5299-2-mario.limonciello%40amd.com
patch subject: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in pcie_bandwidth_available()
config: arc-randconfig-002-20231101 (https://download.01.org/0day-ci/archive/20231101/202311010646.KCczSLIW-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311010646.KCczSLIW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311010646.KCczSLIW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci.c:6234: warning: Function parameter or member 'pdev' not described in 'pcie_is_tunneling_port'
>> drivers/pci/pci.c:6234: warning: Excess function parameter 'dev' description in 'pcie_is_tunneling_port'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_OV7670
   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
   Selected by [y]:
   - VIDEO_CAFE_CCIC [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && PCI [=y] && I2C [=y] && VIDEO_DEV [=y] && COMMON_CLK [=y]


vim +6234 drivers/pci/pci.c

  6225	
  6226	/**
  6227	 * pcie_is_tunneling_port - Check if a PCI device is used for TBT3/USB4 tunneling
  6228	 * @dev: PCI device to check
  6229	 *
  6230	 * Returns true if the device is used for PCIe tunneling, false otherwise.
  6231	 */
  6232	static bool
  6233	pcie_is_tunneling_port(struct pci_dev *pdev)
> 6234	{
  6235		struct device_link *link;
  6236		struct pci_dev *supplier;
  6237	
  6238		/* Intel TBT3 bridge */
  6239		if (pdev->is_thunderbolt)
  6240			return true;
  6241	
  6242		if (!pci_is_pcie(pdev))
  6243			return false;
  6244	
  6245		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
  6246			return false;
  6247	
  6248		/* PCIe root port used for tunneling linked to USB4 router */
  6249		list_for_each_entry(link, &pdev->dev.links.suppliers, c_node) {
  6250			supplier = to_pci_dev(link->supplier);
  6251			if (!supplier)
  6252				continue;
  6253			if (supplier->class == PCI_CLASS_SERIAL_USB_USB4)
  6254				return true;
  6255		}
  6256	
  6257		return false;
  6258	}
  6259	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
