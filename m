Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299F5BD242
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 18:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiISQd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiISQdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 12:33:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B053C8D1;
        Mon, 19 Sep 2022 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663605231; x=1695141231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+aMmESksKhzCnQk5R8nRr+S8KIYQXjUvUvTxGZinTS0=;
  b=P74OuXW9bTiNH9/zvtNrmCXNtA8S1pA/eIdUxEojvQFU4xFuTGvQzMvi
   cfqxdD15f1QOwaMc2PQRc2Bv3LoVHnJunAPqMh9mks1dQqvihUe59LVgt
   HvK/Vr/9mmN1wBmZqwOdyIik2NyPzezUSq/nbm/VGCrUKHIrIiskF9rcm
   Nv4uxfg0C5JSuyK66TaSj0ktpqmEO0bfQu6xskVzYUxpzbIFtnRxI08dn
   aKEuvL/GWBFHw4X1RJf+Re0rTEPXsSIuzoJUVFYGHn6tsVyqTK3LoWgJr
   SLXEgeMsRYtk5fqzsjfYAbuik16Q62TzIozEsaUT+WKAjl4R/q0z4IBmD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286493969"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="286493969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="760935799"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2022 09:33:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaJiL-000261-2G;
        Mon, 19 Sep 2022 16:33:45 +0000
Date:   Tue, 20 Sep 2022 00:33:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, vidyas@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 8/9] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE
 in calibration
Message-ID: <202209200038.mZZFPD7g-lkp@intel.com>
References: <20220919143627.13803-9-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919143627.13803-9-vidyas@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on tegra/for-next linus/master v6.0-rc6 next-20220919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vidya-Sagar/Enhancements-to-pcie-tegra194-driver/20220919-224101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220920/202209200038.mZZFPD7g-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3b12c1aea8ddaae70567a332fc676c76076bf624
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vidya-Sagar/Enhancements-to-pcie-tegra194-driver/20220919-224101
        git checkout 3b12c1aea8ddaae70567a332fc676c76076bf624
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/phy/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/phy/tegra/phy-tegra194-p2u.c:89:5: warning: no previous prototype for 'tegra_p2u_calibrate' [-Wmissing-prototypes]
      89 | int tegra_p2u_calibrate(struct phy *x)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/tegra_p2u_calibrate +89 drivers/phy/tegra/phy-tegra194-p2u.c

    88	
  > 89	int tegra_p2u_calibrate(struct phy *x)
    90	{
    91		struct tegra_p2u *phy = phy_get_drvdata(x);
    92		u32 val;
    93	
    94		val = p2u_readl(phy, P2U_CONTROL_CMN);
    95		val |= P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE;
    96		p2u_writel(phy, val, P2U_CONTROL_CMN);
    97	
    98		return 0;
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
