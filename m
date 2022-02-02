Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF10E4A7832
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 19:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346746AbiBBSqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 13:46:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:26423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346741AbiBBSqU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 13:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643827580; x=1675363580;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XADQLfKTFk9nlqWNH1nShJB7exmuvLV1Th5WEwBCHf8=;
  b=BMetzgKtnuNPvPNotrJR9PvbJHQm65vBFlNg+xYGClVWU8N3P16P46Ip
   Sja+q7+0UGLUWV8mvg6TDi2y9X41sxxtj41EF2ZlYn3S9Xj6bJb3KkAia
   6ZFIGUvdJGjf6gJCycOzhzoAphOk+EqtPLug8zObkOvZoTQCI/d36jmtm
   ib36eY4p1AxWRbLH+oZdA1zjqPpP102jdCZ3sKUEo5+L7bG64EPfD2nyK
   CwRkuX8IuSMWN6g1VqLLVt5M5NYjDbeGtmMy10RxzCxLa7bY/x3ZSkCb+
   6zFGbDJ4qW1f8aPoteQwnAGbljnd6raUCQgBxJsAKU713CeAJenX9Zwz4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334353580"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="334353580"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="566103141"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2022 10:46:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFKe2-000Uyr-1m; Wed, 02 Feb 2022 18:46:18 +0000
Date:   Thu, 3 Feb 2022 02:45:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus 2/2]
 drivers/pci/controller/dwc/pcie-kirin.c:764:44: error: expected '}' before
 ';' token
Message-ID: <202202030204.2ItojgUO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
head:   6b85e10dcff3a98d40f9fbbefc5bb854fa6b50c1
commit: 6b85e10dcff3a98d40f9fbbefc5bb854fa6b50c1 [2/2] PCI: kirin: Add dev struct for of_device_get_match_data()
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220203/202202030204.2ItojgUO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=6b85e10dcff3a98d40f9fbbefc5bb854fa6b50c1
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci for-linus
        git checkout 6b85e10dcff3a98d40f9fbbefc5bb854fa6b50c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-kirin.c:764:44: error: expected '}' before ';' token
     764 |         .phy_type = PCIE_KIRIN_INTERNAL_PHY;
         |                                            ^
   drivers/pci/controller/dwc/pcie-kirin.c:763:54: note: to match this '{'
     763 | static const struct kirin_pcie_data kirin_960_data = {
         |                                                      ^
   drivers/pci/controller/dwc/pcie-kirin.c:768:44: error: expected '}' before ';' token
     768 |         .phy_type = PCIE_KIRIN_EXTERNAL_PHY;
         |                                            ^
   drivers/pci/controller/dwc/pcie-kirin.c:767:54: note: to match this '{'
     767 | static const struct kirin_pcie_data kirin_970_data = {
         |                                                      ^
   drivers/pci/controller/dwc/pcie-kirin.c: In function 'kirin_pcie_probe':
>> drivers/pci/controller/dwc/pcie-kirin.c:790:14: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     790 |         data = of_device_get_match_data(dev);
         |              ^


vim +764 drivers/pci/controller/dwc/pcie-kirin.c

   762	
   763	static const struct kirin_pcie_data kirin_960_data = {
 > 764		.phy_type = PCIE_KIRIN_INTERNAL_PHY;
   765	};
   766	
   767	static const struct kirin_pcie_data kirin_970_data = {
 > 768		.phy_type = PCIE_KIRIN_EXTERNAL_PHY;
   769	};
   770	
   771	static const struct of_device_id kirin_pcie_match[] = {
   772		{ .compatible = "hisilicon,kirin960-pcie", .data = &kirin_960_data },
   773		{ .compatible = "hisilicon,kirin970-pcie", .data = &kirin_970_data },
   774		{},
   775	};
   776	
   777	static int kirin_pcie_probe(struct platform_device *pdev)
   778	{
   779		struct kirin_pcie_data *data;
   780		struct device *dev = &pdev->dev;
   781		struct kirin_pcie *kirin_pcie;
   782		struct dw_pcie *pci;
   783		int ret;
   784	
   785		if (!dev->of_node) {
   786			dev_err(dev, "NULL node\n");
   787			return -EINVAL;
   788		}
   789	
 > 790		data = of_device_get_match_data(dev);
   791		if (!data) {
   792			dev_err(dev, "OF data missing\n");
   793			return -EINVAL;
   794		}
   795	
   796		kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
   797		if (!kirin_pcie)
   798			return -ENOMEM;
   799	
   800		pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
   801		if (!pci)
   802			return -ENOMEM;
   803	
   804		pci->dev = dev;
   805		pci->ops = &kirin_dw_pcie_ops;
   806		pci->pp.ops = &kirin_pcie_host_ops;
   807		kirin_pcie->pci = pci;
   808		kirin_pcie->type = data->phy_type;
   809	
   810		ret = kirin_pcie_get_resource(kirin_pcie, pdev);
   811		if (ret)
   812			return ret;
   813	
   814		platform_set_drvdata(pdev, kirin_pcie);
   815	
   816		ret = kirin_pcie_power_on(pdev, kirin_pcie);
   817		if (ret)
   818			return ret;
   819	
   820		return dw_pcie_host_init(&pci->pp);
   821	}
   822	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
