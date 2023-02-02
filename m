Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F768765A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 08:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBBH1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 02:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBBH1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 02:27:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E306E421;
        Wed,  1 Feb 2023 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675322839; x=1706858839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CsNdO7enAaB1DnnDD0uULEpC8X/6XBAenIZVjgTdu/M=;
  b=GmZ5YhPLO7NLl85RrItAzQPgZKIAnkGTmuCyqCt4lhgscg0v3+KYJt+Q
   d+kcAUwINVkCjb/GG4VESIYKdblwbq2FZhZA9sHiqo8jbXki5Mim4VpTF
   JBuVYj1L6NLJlu5XJtRjZ2cKZirXeG2zA1KpK6UmuaLXCIJONG6o24HSd
   dp/nZ1/A4I65fYL9v/TH31LRxxKm1WFlUGdBF3bK7ubZcEDomLvW/u2SS
   fwmQqCpfQdYGBpHPxqeuFx68sgZCzIQgPHiOXjA3BiNo4V8Pzu+9a/hkY
   lyUV+aLj4K1zCB3FqrPBUKATg+VeK6G+yyiHTzauP2cMwW63ogHlAV/qO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="312023378"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="312023378"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 23:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="910644221"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="910644221"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2023 23:27:16 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNU03-0006H6-2A;
        Thu, 02 Feb 2023 07:27:15 +0000
Date:   Thu, 2 Feb 2023 15:26:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     equu@openmail.cc, lpieralisi@kernel.org, toke@toke.dk,
        kvalo@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        robh@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, equu@openmail.cc
Subject: Re: [PATCH v2 3/3] wifi: ath10k: only load compatible DT cal data
Message-ID: <202302021511.hIXEXftH-lkp@intel.com>
References: <20230202041823.2879262-4-equu@openmail.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202041823.2879262-4-equu@openmail.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on helgaas-pci/for-linus wireless-next/main wireless/main linus/master v6.2-rc6 next-20230202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/equu-openmail-cc/wifi-ath9k-stop-loading-incompatible-DT-cal-data/20230202-131914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
patch link:    https://lore.kernel.org/r/20230202041823.2879262-4-equu%40openmail.cc
patch subject: [PATCH v2 3/3] wifi: ath10k: only load compatible DT cal data
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230202/202302021511.hIXEXftH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d3f328c8809b6349090ad2a2ee78250d657edb58
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review equu-openmail-cc/wifi-ath9k-stop-loading-incompatible-DT-cal-data/20230202-131914
        git checkout d3f328c8809b6349090ad2a2ee78250d657edb58
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath10k/core.c: In function 'ath10k_download_cal_nvmem':
   drivers/net/wireless/ath/ath10k/core.c:1985:15: error: implicit declaration of function 'of_pci_node_match_device' [-Werror=implicit-function-declaration]
    1985 |              !of_pci_node_match_device(ar->dev->of_node,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath10k/core.c:1987:24: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    1987 |                 return ERR_PTR(-ENOENT);
         |                        ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1987 drivers/net/wireless/ath/ath10k/core.c

  1954	
  1955	static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
  1956	{
  1957		struct nvmem_cell *cell;
  1958		void *buf;
  1959		size_t len;
  1960		int ret;
  1961	
  1962		/* devm_nvmem_cell_get() will get a cell first from the OF
  1963		 * DT node representing the given device with nvmem-cell-name
  1964		 * "calibration", and from the global lookup table as a fallback,
  1965		 * and an ath9k device could be either a pci one or a platform one.
  1966		 *
  1967		 * If the OF DT node is not compatible with the real device, the
  1968		 * calibration data got from the node should not be applied.
  1969		 *
  1970		 * dev_is_pci(ar->dev) && ( no OF node || caldata not from node
  1971		 * || not compatible ) -> do not use caldata .
  1972		 *
  1973		 * !dev_is_pci(ar->dev) -> always use caldata .
  1974		 *
  1975		 * The judgement for compatibility differs with ath9k for many
  1976		 * DT using "qcom,ath10k" as compatibility string.
  1977		 */
  1978		if (dev_is_pci(ar->dev) &&
  1979		    (!ar->dev->of_node ||
  1980		     (of_property_match_string(ar->dev->of_node,
  1981					       "nvmem-cell-names",
  1982					       cell_name) < 0) ||
  1983		     !of_device_is_compatible(ar->dev->of_node,
  1984					      "qcom,ath10k") ||
  1985		     !of_pci_node_match_device(ar->dev->of_node,
  1986					       &ath10k_pci_driver)))
> 1987			return ERR_PTR(-ENOENT);
  1988	
  1989		cell = devm_nvmem_cell_get(ar->dev, cell_name);
  1990		if (IS_ERR(cell)) {
  1991			ret = PTR_ERR(cell);
  1992			return ret;
  1993		}
  1994	
  1995		buf = nvmem_cell_read(cell, &len);
  1996		if (IS_ERR(buf))
  1997			return PTR_ERR(buf);
  1998	
  1999		if (ar->hw_params.cal_data_len != len) {
  2000			kfree(buf);
  2001			ath10k_warn(ar, "invalid calibration data length in nvmem-cell '%s': %zu != %u\n",
  2002				    cell_name, len, ar->hw_params.cal_data_len);
  2003			return -EMSGSIZE;
  2004		}
  2005	
  2006		ret = ath10k_download_board_data(ar, buf, len);
  2007		kfree(buf);
  2008		if (ret)
  2009			ath10k_warn(ar, "failed to download calibration data from nvmem-cell '%s': %d\n",
  2010				    cell_name, ret);
  2011	
  2012		return ret;
  2013	}
  2014	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
