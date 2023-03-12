Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF456B63CD
	for <lists+linux-pci@lfdr.de>; Sun, 12 Mar 2023 09:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCLIHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Mar 2023 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCLIHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Mar 2023 04:07:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4785552A;
        Sun, 12 Mar 2023 00:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678608439; x=1710144439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YmPy1TGrnZZKXeOcBlADYDdV8fSPWUUk6Ex8sYrXxqI=;
  b=JNPg1OyKhUZ8Rb20FG9EEvlHjlCSlKaeoW+/P0+m5lt1jnO02OE8fNQJ
   jVAF7hiDOOSnAUfUToDqTyeA+LxY3/WYYtMupl6ZdTsifNGi8bNxAnwYD
   ewMfpx4JkbCPOiEifzcSx6Difko2P2YZLDNfamjKF3HAXw1moSBFIFyye
   zwD3g+knCRsGn8NpavShc3FWQY3HDKKUzeJNwISg24OgHgHD+B09cUplw
   JfGe4sJHbkHp/mq5nUsKp9MLiC+/o3iiHCnCrJZlPeUeEN97d3K+JTGrY
   rZoE9ysoVbDIzokHPH8vgmh7DZ/FLKzQyYTwz0ClH4/C2Fs+Od1f2hi5k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="364628158"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="364628158"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 00:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="628285419"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="628285419"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2023 00:07:17 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbGjc-00057l-1E;
        Sun, 12 Mar 2023 08:07:16 +0000
Date:   Sun, 12 Mar 2023 16:06:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     oe-kbuild-all@lists.linux.dev, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/7] PCI: endpoint: Pass EPF device ID to the probe
 function
Message-ID: <202303121526.qVIG9eBb-lkp@intel.com>
References: <20230307151416.176595-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307151416.176595-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

I love your patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus jonmason-ntb/ntb-next linus/master v6.3-rc1 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-endpoint-Pass-EPF-device-ID-to-the-probe-function/20230307-232050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230307151416.176595-2-manivannan.sadhasivam%40linaro.org
patch subject: [PATCH v2 1/7] PCI: endpoint: Pass EPF device ID to the probe function
config: x86_64-randconfig-a016-20220905 (https://download.01.org/0day-ci/archive/20230312/202303121526.qVIG9eBb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/26f2c0c8a0b85aceb28bc5688851fab125a55ac6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manivannan-Sadhasivam/PCI-endpoint-Pass-EPF-device-ID-to-the-probe-function/20230307-232050
        git checkout 26f2c0c8a0b85aceb28bc5688851fab125a55ac6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303121526.qVIG9eBb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/endpoint/functions/pci-epf-vntb.c:1433:27: error: initialization of 'int (*)(struct pci_epf *, const struct pci_epf_device_id *)' from incompatible pointer type 'int (*)(struct pci_epf *)' [-Werror=incompatible-pointer-types]
    1433 |         .probe          = epf_ntb_probe,
         |                           ^~~~~~~~~~~~~
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1433:27: note: (near initialization for 'epf_ntb_driver.probe')
   cc1: some warnings being treated as errors


vim +1433 drivers/pci/endpoint/functions/pci-epf-vntb.c

e35f56bb03304a Frank Li 2022-02-22  1430  
e35f56bb03304a Frank Li 2022-02-22  1431  static struct pci_epf_driver epf_ntb_driver = {
e35f56bb03304a Frank Li 2022-02-22  1432  	.driver.name    = "pci_epf_vntb",
e35f56bb03304a Frank Li 2022-02-22 @1433  	.probe          = epf_ntb_probe,
e35f56bb03304a Frank Li 2022-02-22  1434  	.id_table       = epf_ntb_ids,
e35f56bb03304a Frank Li 2022-02-22  1435  	.ops            = &epf_ntb_ops,
e35f56bb03304a Frank Li 2022-02-22  1436  	.owner          = THIS_MODULE,
e35f56bb03304a Frank Li 2022-02-22  1437  };
e35f56bb03304a Frank Li 2022-02-22  1438  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
