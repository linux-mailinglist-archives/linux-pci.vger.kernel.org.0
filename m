Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB058FC57
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 14:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiHKMdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 08:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiHKMdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 08:33:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC0DF38;
        Thu, 11 Aug 2022 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660221232; x=1691757232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sePsZki6rNGWhBmuPvYhrZYvNbhkUqbQ1QhmhPMXOe8=;
  b=e5C/CF9Gb6wdTlmdRKdBA8vJK7WxBI12Mp2SiazYtFhC7PlXq64aR9M4
   vbruL2KJ+0g016c8vD9apvYMEGRZ79nGLAURINcZhgSK45PePgnUPw68P
   pZGcjHA6xYYo7xlkl3oqb20vIxTRxgHp9kutxmFCIhWYrrlhpvORlmfnP
   7p0yweDdYW51kBSoO+Rkc1SLnglBHw0W2iiRQo+ycP0DPM6jJLBKMzllP
   zsAjBumDY9nLuF0ATZnyU1oYMZmPfkgUAeNHh8PxrXM51HwJa1/QM5Yp4
   /NWqFmGif9E/mUxwGCxzXlVelMTzFl0yLOlWcBnItQf7WVt/kLJl1ULMz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="288900957"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="288900957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 05:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="708599120"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2022 05:33:49 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oM7Nk-0000Bj-1z;
        Thu, 11 Aug 2022 12:33:48 +0000
Date:   Thu, 11 Aug 2022 20:32:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will McVicker <willmcvicker@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <202208112017.jLSXQXjV-lkp@intel.com>
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
[also build test ERROR on linus/master next-20220811]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Will-McVicker/PCI-dwc-Add-support-for-64-bit-MSI-target-addresses/20220810-020421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: powerpc-randconfig-c003-20220810 (https://download.01.org/0day-ci/archive/20220811/202208112017.jLSXQXjV-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7a41faa4e02a0a8945f79e7af86d10e371b2fc12
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Will-McVicker/PCI-dwc-Add-support-for-64-bit-MSI-target-addresses/20220810-020421
        git checkout 7a41faa4e02a0a8945f79e7af86d10e371b2fc12
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware.c:85:5: error: redefinition of 'dw_pcie_msi_capabilities'
   u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
       ^
   drivers/pci/controller/dwc/pcie-designware.h:467:19: note: previous definition is here
   static inline u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
                     ^
   1 error generated.


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
