Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C49529917
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 07:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiEQFf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 01:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiEQFfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 01:35:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32441330;
        Mon, 16 May 2022 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652765717; x=1684301717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AXHno5RHVab92K6v0hp/3a+LZPPYkq6/Jj0D8I/tXTg=;
  b=VmaKZSUS56pthSxGSt6SFIaTipWz33fXBFVe+dkxLOYcskJUu07B8Ayq
   kvVzCvYRJbHFMqmQu/TkYZ3BKcncWqYtxMVkx+f+8HP5GbS7P0hFaHw6Q
   VMNiDxTWBqmpUCUoDFWaCCIJh0EbwBzqTcR0WFVKhpjVOsK8j75vPAAmQ
   QNUVYGbEO40prLSHqRFqLYORjo+feSsdF41fHozbmIg6ENEpLuUjK0YxY
   IstFfQKtF992YIR6RsG62ROuZzVeukBahtZc1oftvXQPE1/+8Axf3jUcf
   g8eoAQxu6KDUwAuJp8Y5AQ+/VzMTx0m7fQBjm1to357HcdCzaRNt2lVPR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="296339251"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="296339251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 22:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="741602029"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2022 22:35:08 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqprP-0000e9-Ub;
        Tue, 17 May 2022 05:35:07 +0000
Date:   Tue, 17 May 2022 13:34:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "windy.bi.enflame" <windy.bi.enflame@gmail.com>,
        bhelgaas@google.com
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "windy.bi.enflame" <windy.bi.enflame@gmail.com>
Subject: Re: [PATCH] drivers/pci: wait downstream hierarchy ready instead of
 slot itself ready, after secondary bus reset
Message-ID: <202205171330.ye71SisD-lkp@intel.com>
References: <20220516173047.123317-1-windy.bi.enflame@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516173047.123317-1-windy.bi.enflame@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi "windy.bi.enflame",

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on v5.18-rc7 next-20220516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/windy-bi-enflame/drivers-pci-wait-downstream-hierarchy-ready-instead-of-slot-itself-ready-after-secondary-bus-reset/20220517-013158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220517/202205171330.ye71SisD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/99d829ca818d01cbd8bd4f95353f58a01723fe21
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review windy-bi-enflame/drivers-pci-wait-downstream-hierarchy-ready-instead-of-slot-itself-ready-after-secondary-bus-reset/20220517-013158
        git checkout 99d829ca818d01cbd8bd4f95353f58a01723fe21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/pci.c:5052:5: warning: no previous prototype for 'pci_bridge_secondary_bus_wait' [-Wmissing-prototypes]
    5052 | int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pci_bridge_secondary_bus_wait +5052 drivers/pci/pci.c

  5051	
> 5052	int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
  5053	{
  5054		struct pci_dev *dev;
  5055		int delay = 1;
  5056	
  5057		if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
  5058			return 0;
  5059	
  5060		list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
  5061			while (!pci_device_is_present(dev)) {
  5062				if (delay > timeout) {
  5063					pci_warn(dev, "secondary bus not ready after %dms\n", delay);
  5064					return -ENOTTY;
  5065				}
  5066	
  5067				msleep(delay);
  5068				delay *= 2;
  5069			}
  5070		}
  5071	
  5072		return 0;
  5073	}
  5074	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
