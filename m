Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F035916A5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 23:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiHLVNB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiHLVNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 17:13:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574B16599;
        Fri, 12 Aug 2022 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660338779; x=1691874779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+MgGPOFWi4b+KDvImOqRcMS3e42YWnZGtwsNNODWnPE=;
  b=NhxJFyNU/HBeFVrn/45rGnbNh+S7IxnmVD2oK33LSaw+9Wz98GCKSBKh
   4H7IStiW0ieIituBRaSG8dlqXzdmgcCSF+axp+EYt1+GBWWDq1LuL3hpe
   TDVg4iT0iip2rirr7CKpYaV+XX9Q2XobyTds9EVDyqiIo+0ES94JcJh+p
   KXZdhNfsPsuB3otvv67SuiXDt7XSZfBtm4n/XdJ6MLgXHDqmfvQmU1/cV
   2Gf/gTTxSRvWgRWTNV8baJJIrMdJlREmAU7J3vUSNFnO9q6xSLwqgk0o/
   bSr42dWWwG/hQBg0DFHSE8eVcgr47mZFye0oJNXgMOpOcdfuhhfcwtURT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377979611"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377979611"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 14:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="582230200"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2022 14:12:56 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMbxg-0000wr-0q;
        Fri, 12 Aug 2022 21:12:56 +0000
Date:   Sat, 13 Aug 2022 05:12:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Fix endianity when accessing pci emul bridge
 members
Message-ID: <202208130542.WpzYnXZ3-lkp@intel.com>
References: <20220812094058.16141-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812094058.16141-1-pali@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi "Pali,

I love your patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pali-Roh-r/PCI-mvebu-Fix-endianity-when-accessing-pci-emul-bridge-members/20220812-174306
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-randconfig-s041-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130542.WpzYnXZ3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/525898e0a8389f8bb560edbce3f07a3ec2550968
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pali-Roh-r/PCI-mvebu-Fix-endianity-when-accessing-pci-emul-bridge-members/20220812-174306
        git checkout 525898e0a8389f8bb560edbce3f07a3ec2550968
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/pci/controller/pci-mvebu.c:538:25: sparse: sparse: restricted __le16 degrades to integer
>> drivers/pci/controller/pci-mvebu.c:538:25: sparse: sparse: cast to restricted __le16
   drivers/pci/controller/pci-mvebu.c:541:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:541:26: sparse: sparse: cast to restricted __le16

vim +538 drivers/pci/controller/pci-mvebu.c

   518	
   519	static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
   520	{
   521		struct mvebu_pcie_window desired = {};
   522		struct pci_bridge_emul_conf *conf = &port->bridge.conf;
   523	
   524		/* Are the new iobase/iolimit values invalid? */
   525		if (conf->iolimit < conf->iobase ||
   526		    le16_to_cpu(conf->iolimitupper) < le16_to_cpu(conf->iobaseupper))
   527			return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
   528						     &desired, &port->iowin);
   529	
   530		/*
   531		 * We read the PCI-to-PCI bridge emulated registers, and
   532		 * calculate the base address and size of the address decoding
   533		 * window to setup, according to the PCI-to-PCI bridge
   534		 * specifications. iobase is the bus address, port->iowin_base
   535		 * is the CPU address.
   536		 */
   537		desired.remap = ((conf->iobase & 0xF0) << 8) |
 > 538				le16_to_cpu(conf->iobaseupper << 16);
   539		desired.base = port->pcie->io.start + desired.remap;
   540		desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
   541				 le16_to_cpu(conf->iolimitupper << 16)) -
   542				desired.remap) +
   543			       1;
   544	
   545		return mvebu_pcie_set_window(port, port->io_target, port->io_attr, &desired,
   546					     &port->iowin);
   547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
