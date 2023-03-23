Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109816C5EBC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 06:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCWFXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 01:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCWFXP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 01:23:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1921F5CC;
        Wed, 22 Mar 2023 22:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679548993; x=1711084993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZWhajVf94otlaDxvhMc13wCWR+0aAVrmHV4MxrPRbo=;
  b=SM4Ye3cBA24rbzkGECBg8nsTQETgbfowYR0qvdtolK3X0lMNHneV5Ogc
   0xaon6v+B2kI6FljbZv/UlRgAOfPmr7kOVD5GpOfYw8COE6j4FgtIec6e
   9hlBmaDE002lLfnxfLM2EJy6tRjw7KuAurcbEsSeOXPGfYzaac0yW/USu
   gXmilr7OdSXCubkkWM8ePdwgSKVN1qobi1ZoRtMom15ZTI9/JBgLoHZF7
   NU9QwFar725X1ZQQFBPLj5BURHu7pfiG4HzjoK3VWoUxfj7Xr8rsz1qhl
   gDMRpEPGmEN8vIQf3vEtUqm+osBxZDzSsBah0fi4HUCUYBSZY0QHY40eU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338119708"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="338119708"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="751343160"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="751343160"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2023 22:23:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfDPq-000DzY-01;
        Thu, 23 Mar 2023 05:23:10 +0000
Date:   Thu, 23 Mar 2023 13:22:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     ye.xingchen@zte.com.cn, shawn.lin@rock-chips.com
Cc:     oe-kbuild-all@lists.linux.dev, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, heiko@sntech.de,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Use dev_err_probe()
Message-ID: <202303231338.oVZa9IHF-lkp@intel.com>
References: <202303231146312337844@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303231146312337844@zte.com.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.3-rc3 next-20230323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/PCI-rockchip-Use-dev_err_probe/20230323-114809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/202303231146312337844%40zte.com.cn
patch subject: [PATCH] PCI: rockchip: Use dev_err_probe()
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230323/202303231338.oVZa9IHF-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4ad6c26e54b926f384a1bdc99892900cbfa83eea
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ye-xingchen-zte-com-cn/PCI-rockchip-Use-dev_err_probe/20230323-114809
        git checkout 4ad6c26e54b926f384a1bdc99892900cbfa83eea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303231338.oVZa9IHF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/pcie-rockchip.c: In function 'rockchip_pcie_get_phys':
>> drivers/pci/controller/pcie-rockchip.c:313:74: warning: format '%ld' expects a matching 'long int' argument [-Wformat=]
     313 |                                              "missing phy for lane %d: %ld\n", i);
         |                                                                        ~~^
         |                                                                          |
         |                                                                          long int


vim +313 drivers/pci/controller/pcie-rockchip.c

   282	
   283	int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
   284	{
   285		struct device *dev = rockchip->dev;
   286		struct phy *phy;
   287		char *name;
   288		u32 i;
   289	
   290		phy = devm_phy_get(dev, "pcie-phy");
   291		if (!IS_ERR(phy)) {
   292			rockchip->legacy_phy = true;
   293			rockchip->phys[0] = phy;
   294			dev_warn(dev, "legacy phy model is deprecated!\n");
   295			return 0;
   296		}
   297	
   298		if (PTR_ERR(phy) == -EPROBE_DEFER)
   299			return PTR_ERR(phy);
   300	
   301		dev_dbg(dev, "missing legacy phy; search for per-lane PHY\n");
   302	
   303		for (i = 0; i < MAX_LANE_NUM; i++) {
   304			name = kasprintf(GFP_KERNEL, "pcie-phy-%u", i);
   305			if (!name)
   306				return -ENOMEM;
   307	
   308			phy = devm_of_phy_get(dev, dev->of_node, name);
   309			kfree(name);
   310	
   311			if (IS_ERR(phy))
   312				return dev_err_probe(dev, PTR_ERR(phy),
 > 313						     "missing phy for lane %d: %ld\n", i);
   314	
   315			rockchip->phys[i] = phy;
   316		}
   317	
   318		return 0;
   319	}
   320	EXPORT_SYMBOL_GPL(rockchip_pcie_get_phys);
   321	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
