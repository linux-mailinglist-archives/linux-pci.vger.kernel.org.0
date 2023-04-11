Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F16DE628
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 23:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDKVHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 17:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDKVHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 17:07:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A84482
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681247251; x=1712783251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L0YpiPfGZgI3gQUZ+5L6kYqGodIvHw6EHvQ0ghaVqm4=;
  b=RLWoL+zKPt/zI+TLN5PKoV6kyNg7yFVTWJDHUS8BavTp7qwnmVwFH+A5
   1zdja36gbeZ8NIpPuLbqkgJC7xL1nmCQe2UYKSGbgCE5eyShvvPIFDa2g
   1M2r40304lN/xGtTaWSJcSIrYUIay3c9NiQ8XTWigzWMBfyXTedozc+bx
   sanrBQ75/t8BFGYuxGMgG479cRVvaiVz3pFqFnTwtCpkMy0AKPgHvJV1v
   IZKLQYknFESwwRzhrW+gGcrPouGQEn42pEfbWzpkhzYhK4uDQpV+AGplp
   3ol8rf4WtlhFGTGgO7oOBLNn8xioRscMTT0KiO4v7P5wsG5oIQTABUP2b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346411393"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="346411393"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 14:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="691303955"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="691303955"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2023 14:07:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmLD5-000Whl-2A;
        Tue, 11 Apr 2023 21:07:27 +0000
Date:   Wed, 12 Apr 2023 05:07:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [pci:controller/qcom 17/27]
 drivers/pci/controller/dwc/pcie-qcom.c:247:1: error: type name requires a
 specifier or qualifier
Message-ID: <202304120557.LijMReu1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
head:   dc8d33452b3643f4b4c33fd4492aa7ae4e8e00d6
commit: ca0e2aad27202b971def5a3dfeffb23d80ebe350 [17/27] PCI: qcom: Add support for system suspend and resume
config: riscv-randconfig-r036-20230409 (https://download.01.org/0day-ci/archive/20230412/202304120557.LijMReu1-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=ca0e2aad27202b971def5a3dfeffb23d80ebe350
        git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
        git fetch --no-tags pci controller/qcom
        git checkout ca0e2aad27202b971def5a3dfeffb23d80ebe350
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120557.LijMReu1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom.c:247:1: error: type name requires a specifier or qualifier
   +       bool suspended;
   ^
>> drivers/pci/controller/dwc/pcie-qcom.c:247:1: error: expected member name or ';' after declaration specifiers
>> drivers/pci/controller/dwc/pcie-qcom.c:246:25: error: expected ';' at end of declaration list
           struct dentry *debugfs;
                                  ^
                                  ;
>> drivers/pci/controller/dwc/pcie-qcom.c:1574:9: error: no member named 'suspended' in 'struct qcom_pcie'
                   pcie->suspended = true;
                   ~~~~  ^
   drivers/pci/controller/dwc/pcie-qcom.c:1585:12: error: no member named 'suspended' in 'struct qcom_pcie'
           if (pcie->suspended) {
               ~~~~  ^
   drivers/pci/controller/dwc/pcie-qcom.c:1590:9: error: no member named 'suspended' in 'struct qcom_pcie'
                   pcie->suspended = false;
                   ~~~~  ^
   6 errors generated.


vim +247 drivers/pci/controller/dwc/pcie-qcom.c

   235	
   236	struct qcom_pcie {
   237		struct dw_pcie *pci;
   238		void __iomem *parf;			/* DT parf */
   239		void __iomem *elbi;			/* DT elbi */
   240		void __iomem *mhi;
   241		union qcom_pcie_resources res;
   242		struct phy *phy;
   243		struct gpio_desc *reset;
   244		struct icc_path *icc_mem;
   245		const struct qcom_pcie_cfg *cfg;
 > 246		struct dentry *debugfs;
 > 247	+	bool suspended;
   248	};
   249	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
