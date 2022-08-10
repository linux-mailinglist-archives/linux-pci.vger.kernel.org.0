Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1158F171
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiHJRTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiHJRTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 13:19:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6979689;
        Wed, 10 Aug 2022 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660151948; x=1691687948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ef+DHYdbzGOT9VmbF4AU1qjTEw0foAtWlyqWOp7YlpI=;
  b=Fh1IaWYrnTETd5FN1iwhwH9dfZZ9NZr+puUhW0FaNVcqNXrILzp6esu3
   KxE15H6SrCJXj0yLsSB/kRgp0s0zlVvPtKOGi780Uul1zF/dKv2Bm8xM9
   cw/bV59e7rQL3FrHsOfX2QVhC2kAKekdVrQpfdpDh+d+RMJ0qlqno3NHR
   vxUhrBDA9N+aL0ie4B5HLICb8SfL7/DELSSjO0x20V+jVYkOI11SvhD0T
   rCrfDmQrM7oRFQCQqb0on3CkXx56LDJkRbbXcvw13AWoAtcWZT7OOIYEb
   XnV4FgyDIdxinv40i1/9skC5KZ4FDI4q8zB4bdoq22AVd/3OFHtc5EutI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="288713713"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="288713713"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 10:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="781304563"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2022 10:18:57 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLpM8-0000WU-30;
        Wed, 10 Aug 2022 17:18:56 +0000
Date:   Thu, 11 Aug 2022 01:18:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will McVicker <willmcvicker@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <202208110116.R0hD7l2c-lkp@intel.com>
References: <20220809180051.1063653-3-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809180051.1063653-3-willmcvicker@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Will,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on linus/master next-20220810]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Will-McVicker/PCI-dwc-Add-support-for-64-bit-MSI-target-addresses/20220810-020421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: sparc-buildonly-randconfig-r004-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110116.R0hD7l2c-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7a41faa4e02a0a8945f79e7af86d10e371b2fc12
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Will-McVicker/PCI-dwc-Add-support-for-64-bit-MSI-target-addresses/20220810-020421
        git checkout 7a41faa4e02a0a8945f79e7af86d10e371b2fc12
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware.c:85:5: error: redefinition of 'dw_pcie_msi_capabilities'
      85 | u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/controller/dwc/pcie-designware.c:20:
   drivers/pci/controller/dwc/pcie-designware.h:467:19: note: previous definition of 'dw_pcie_msi_capabilities' with type 'u16(struct dw_pcie *)' {aka 'short unsigned int(struct dw_pcie *)'}
     467 | static inline u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/dw_pcie_msi_capabilities +85 drivers/pci/controller/dwc/pcie-designware.c

    84	
  > 85	u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
    86	{
    87		u8 offset;
    88	
    89		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
    90		return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
    91	}
    92	EXPORT_SYMBOL_GPL(dw_pcie_msi_capabilities);
    93	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
