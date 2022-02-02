Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0944A6AAE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 05:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiBBEAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 23:00:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:54391 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbiBBEAk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 23:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643774440; x=1675310440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3PIFhmj818P6guWNz7QSEbMuO/LC/pFWN1ArnS1Hkds=;
  b=QiBPYYjppATivE6SlMM+WRgEIMw7VqD9A3FFvZskxD80Yr1WH2h0LPiE
   JhKI6w0cGKPTRJa69DTTkATunQnFT584q6442t32kzVKpvSey2ajFL7z3
   cBAOOJDqtiu+AHaQa9qzX5rmoNjrA5P3EAwIT9tzewfU0LQUETCy7vDIn
   Wvr92rX+UdJd+BDThW76de+qUkLo/eVhzKAKkrnEL15beiWcXsxDBqrdn
   4B3TYwvP3NbLXGh0WNyaRMDsLOPEkizwvrJeoCSS4TfKrRDlppS3CShxu
   g2BnFBCFSHr4NprzHi5YtM0pdv1pVUzkx4XAItLIxCEWyI9AdBoa1ibfD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="311154997"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="311154997"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 20:00:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="769162059"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2022 20:00:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF6ou-000U76-Dm; Wed, 02 Feb 2022 04:00:36 +0000
Date:   Wed, 2 Feb 2022 12:00:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bean Huo <huobean@gmail.com>, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        ffclaire1224@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, beanhuo@micron.com
Subject: Re: [PATCH] PCI: kirin: Fix kirin960-pcie probe failure issue
Message-ID: <202202021149.TJc443Qq-lkp@intel.com>
References: <20220201215941.1203155-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201215941.1203155-1-huobean@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bean,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on v5.17-rc2 next-20220201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bean-Huo/PCI-kirin-Fix-kirin960-pcie-probe-failure-issue/20220202-060120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: riscv-randconfig-r001-20220130 (https://download.01.org/0day-ci/archive/20220202/202202021149.TJc443Qq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/91a6cc1deb484e0590261edbf304784499ca1784
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bean-Huo/PCI-kirin-Fix-kirin960-pcie-probe-failure-issue/20220202-060120
        git checkout 91a6cc1deb484e0590261edbf304784499ca1784
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-kirin.c:784:13: warning: cast to smaller integer type 'enum pcie_kirin_phy_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           phy_type = (enum pcie_kirin_phy_type)of_device_get_match_data(dev);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +784 drivers/pci/controller/dwc/pcie-kirin.c

   770	
   771	static int kirin_pcie_probe(struct platform_device *pdev)
   772	{
   773		enum pcie_kirin_phy_type phy_type;
   774		struct device *dev = &pdev->dev;
   775		struct kirin_pcie *kirin_pcie;
   776		struct dw_pcie *pci;
   777		int ret;
   778	
   779		if (!dev->of_node) {
   780			dev_err(dev, "NULL node\n");
   781			return -EINVAL;
   782		}
   783	
 > 784		phy_type = (enum pcie_kirin_phy_type)of_device_get_match_data(dev);
   785	
   786		kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
   787		if (!kirin_pcie)
   788			return -ENOMEM;
   789	
   790		pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
   791		if (!pci)
   792			return -ENOMEM;
   793	
   794		pci->dev = dev;
   795		pci->ops = &kirin_dw_pcie_ops;
   796		pci->pp.ops = &kirin_pcie_host_ops;
   797		kirin_pcie->pci = pci;
   798		kirin_pcie->type = phy_type;
   799	
   800		ret = kirin_pcie_get_resource(kirin_pcie, pdev);
   801		if (ret)
   802			return ret;
   803	
   804		platform_set_drvdata(pdev, kirin_pcie);
   805	
   806		ret = kirin_pcie_power_on(pdev, kirin_pcie);
   807		if (ret)
   808			return ret;
   809	
   810		return dw_pcie_host_init(&pci->pp);
   811	}
   812	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
