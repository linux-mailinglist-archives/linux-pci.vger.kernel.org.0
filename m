Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7089E6897DB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 12:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBCLjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 06:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBCLjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 06:39:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203389B6C0;
        Fri,  3 Feb 2023 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675424341; x=1706960341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IwlRkDcHwHBKdH4tsEJMEjumxbzdWvfwZJP6tuNYlA=;
  b=GTZ4hPwCiHnw/DMTFLRNXUvhBDSwp661vcaYY98twuxFRlN6ocGO+4Vh
   qsu4BVJA35Z+MKKE7RAnlzpmmwXfghDtH/Zd6fnBjeKsWeJtZYYonpJx6
   HqhGTLa+NSNUDx1XQ6+GZOkWBgLFa3gpBHRHw+0dO/GFVcXzYLAE553ji
   quKTe11B/sB7qw6kB28TwOBrJuj6ei0pXCfx8jgPjWlgZH5ThdDSlgKWT
   rWLOXWRzEkkzdAtwgz3VccZqi1yZ9xUqu3zFqbpilQLcqhf87DNHUkfZz
   piNHWRgKnubE2YYBZ5HyxxZ0raRy5saB/Go6d5LJi8xaeIll4EOHsLlKF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="330012833"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330012833"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 03:39:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="994497039"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="994497039"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2023 03:38:57 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNuPB-0000Rf-0s;
        Fri, 03 Feb 2023 11:38:57 +0000
Date:   Fri, 3 Feb 2023 19:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     equu@openmail.cc, lpieralisi@kernel.org, toke@toke.dk,
        kvalo@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        robh@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, equu@openmail.cc,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/3] wifi: ath10k: only load compatible DT cal data
Message-ID: <202302031943.aLVT61nB-lkp@intel.com>
References: <20230202075524.2911058-4-equu@openmail.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202075524.2911058-4-equu@openmail.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on helgaas-pci/for-linus wireless-next/main wireless/main linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/equu-openmail-cc/wifi-ath9k-stop-loading-incompatible-DT-cal-data/20230202-165536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
patch link:    https://lore.kernel.org/r/20230202075524.2911058-4-equu%40openmail.cc
patch subject: [PATCH v3 3/3] wifi: ath10k: only load compatible DT cal data
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230203/202302031943.aLVT61nB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d2ef9bc195ade55c010e64762b135a46a62f3fdd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review equu-openmail-cc/wifi-ath9k-stop-loading-incompatible-DT-cal-data/20230202-165536
        git checkout d2ef9bc195ade55c010e64762b135a46a62f3fdd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath10k/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath10k/core.c:16:
   include/linux/of_pci.h:23:33: warning: 'struct pci_driver' declared inside parameter list will not be visible outside of this definition or declaration
      23 |                          struct pci_driver *drv);
         |                                 ^~~~~~~~~~
   drivers/net/wireless/ath/ath10k/core.c: In function 'ath10k_download_cal_nvmem':
>> drivers/net/wireless/ath/ath10k/core.c:1987:40: error: passing argument 2 of 'of_pci_node_match_driver' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1987 |                                        &ath10k_pci_driver)))
         |                                        ^~~~~~~~~~~~~~~~~~
         |                                        |
         |                                        struct pci_driver *
   In file included from drivers/net/wireless/ath/ath10k/core.c:16:
   include/linux/of_pci.h:23:45: note: expected 'struct pci_driver *' but argument is of type 'struct pci_driver *'
      23 |                          struct pci_driver *drv);
         |                          ~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/of_pci_node_match_driver +1987 drivers/net/wireless/ath/ath10k/core.c

  1955	
  1956	static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
  1957	{
  1958		struct nvmem_cell *cell;
  1959		void *buf;
  1960		size_t len;
  1961		int ret;
  1962	
  1963		/* devm_nvmem_cell_get() will get a cell first from the OF
  1964		 * DT node representing the given device with nvmem-cell-name
  1965		 * "calibration", and from the global lookup table as a fallback,
  1966		 * and an ath10k device could be either a pci one or a platform one.
  1967		 *
  1968		 * If the OF DT node is not compatible with the real device, the
  1969		 * calibration data got from the node should not be applied.
  1970		 *
  1971		 * dev_is_pci(ar->dev) && ( no OF node || caldata not from node
  1972		 * || not compatible ) -> do not use caldata .
  1973		 *
  1974		 * !dev_is_pci(ar->dev) -> always use caldata .
  1975		 *
  1976		 * The judgement for compatibility differs with ath9k for many
  1977		 * DT using "qcom,ath10k" as compatibility string.
  1978		 */
  1979		if (dev_is_pci(ar->dev) &&
  1980		    (!ar->dev->of_node ||
  1981		     (of_property_match_string(ar->dev->of_node,
  1982					       "nvmem-cell-names",
  1983					       cell_name) < 0) ||
  1984		     !of_device_is_compatible(ar->dev->of_node,
  1985					      "qcom,ath10k") ||
  1986		     !of_pci_node_match_driver(ar->dev->of_node,
> 1987					       &ath10k_pci_driver)))
  1988			return -ENOENT;
  1989	
  1990		cell = devm_nvmem_cell_get(ar->dev, cell_name);
  1991		if (IS_ERR(cell)) {
  1992			ret = PTR_ERR(cell);
  1993			return ret;
  1994		}
  1995	
  1996		buf = nvmem_cell_read(cell, &len);
  1997		if (IS_ERR(buf))
  1998			return PTR_ERR(buf);
  1999	
  2000		if (ar->hw_params.cal_data_len != len) {
  2001			kfree(buf);
  2002			ath10k_warn(ar, "invalid calibration data length in nvmem-cell '%s': %zu != %u\n",
  2003				    cell_name, len, ar->hw_params.cal_data_len);
  2004			return -EMSGSIZE;
  2005		}
  2006	
  2007		ret = ath10k_download_board_data(ar, buf, len);
  2008		kfree(buf);
  2009		if (ret)
  2010			ath10k_warn(ar, "failed to download calibration data from nvmem-cell '%s': %d\n",
  2011				    cell_name, ret);
  2012	
  2013		return ret;
  2014	}
  2015	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
