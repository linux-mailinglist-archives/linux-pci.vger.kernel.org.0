Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ACD68947A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjBCJ5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjBCJ5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:57:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48470D6B;
        Fri,  3 Feb 2023 01:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675418224; x=1706954224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dJ2q9PwEMW0SSkG+4Ta7q5xMk9OhifxLsOSev/dtMJg=;
  b=WY+oE72gYyuMIc66EFC7gXTlXhxgutFG+tFgYP97QlJJEP9yes3U1tiV
   jMWhJdam29y8+8PM8NOCLo2iWxwRDKGmH1Y1LWKrfO0jjFspFWKPYiQ8O
   tCotDpR7iUcOJOIYn9Y7YrsJ3jS40AEslHaW5/8q2GN9nr6kGEFpD7zdb
   rwQzV/iWfJp1y/aaX4WU3oPwthliQJ2bxUwV9D0aEJbOlPRxMqYL5y+Mp
   Zw8kKKYQU2nqbpsWdgK+y6dbD7ukd60sD6llgrKrsCMjpFAEd4d0Bcn0Y
   g67ipIC85prigzmiMxV2dKvM1Z7Qe4vK9e7rAFs/3/dZPxqV5NKkEZO9a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="329994207"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="329994207"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="808324883"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="808324883"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2023 01:56:52 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNsoN-0000ND-1v;
        Fri, 03 Feb 2023 09:56:51 +0000
Date:   Fri, 3 Feb 2023 17:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     equu@openmail.cc, lpieralisi@kernel.org, toke@toke.dk,
        kvalo@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        robh@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, equu@openmail.cc
Subject: Re: [PATCH v3 2/3] wifi: ath9k: stop loading incompatible DT cal data
Message-ID: <202302031700.zxbfZuRh-lkp@intel.com>
References: <20230202075524.2911058-3-equu@openmail.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202075524.2911058-3-equu@openmail.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on helgaas-pci/for-linus wireless-next/main wireless/main linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/equu-openmail-cc/wifi-ath9k-stop-loading-incompatible-DT-cal-data/20230202-165536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
patch link:    https://lore.kernel.org/r/20230202075524.2911058-3-equu%40openmail.cc
patch subject: [PATCH v3 2/3] wifi: ath9k: stop loading incompatible DT cal data
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230203/202302031700.zxbfZuRh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b8656d7cf0ddf9edc732511d6d959c1b3a8b4ea8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review equu-openmail-cc/wifi-ath9k-stop-loading-incompatible-DT-cal-data/20230202-165536
        git checkout b8656d7cf0ddf9edc732511d6d959c1b3a8b4ea8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath10k/ drivers/net/wireless/ath/ath9k/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath9k/init.c:25:
>> include/linux/of_pci.h:23:33: warning: 'struct pci_driver' declared inside parameter list will not be visible outside of this definition or declaration
      23 |                          struct pci_driver *drv);
         |                                 ^~~~~~~~~~
   drivers/net/wireless/ath/ath9k/init.c: In function 'ath9k_nvmem_request_eeprom':
>> drivers/net/wireless/ath/ath9k/init.c:594:13: error: implicit declaration of function 'dev_is_pci' [-Werror=implicit-function-declaration]
     594 |         if (dev_is_pci(sc->dev) &&
         |             ^~~~~~~~~~
>> drivers/net/wireless/ath/ath9k/init.c:600:40: error: passing argument 2 of 'of_pci_node_match_driver' from incompatible pointer type [-Werror=incompatible-pointer-types]
     600 |                                        &ath_pci_driver)))
         |                                        ^~~~~~~~~~~~~~~
         |                                        |
         |                                        struct pci_driver *
   In file included from drivers/net/wireless/ath/ath9k/init.c:25:
   include/linux/of_pci.h:23:45: note: expected 'struct pci_driver *' but argument is of type 'struct pci_driver *'
      23 |                          struct pci_driver *drv);
         |                          ~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/dev_is_pci +594 drivers/net/wireless/ath/ath9k/init.c

   572	
   573	static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
   574	{
   575		struct ath_hw *ah = sc->sc_ah;
   576		struct nvmem_cell *cell;
   577		void *buf;
   578		size_t len;
   579		int err;
   580	
   581		/* devm_nvmem_cell_get() will get a cell first from the OF
   582		 * DT node representing the given device with nvmem-cell-name
   583		 * "calibration", and from the global lookup table as a fallback,
   584		 * and an ath9k device could be either a pci one or a platform one.
   585		 *
   586		 * If the OF DT node is not compatible with the real device, the
   587		 * calibration data got from the node should not be applied.
   588		 *
   589		 * dev_is_pci(sc->dev) && ( no OF node || caldata not from node
   590		 * || not compatible ) -> do not use caldata .
   591		 *
   592		 * !dev_is_pci(sc->dev) -> always use caldata .
   593		 */
 > 594		if (dev_is_pci(sc->dev) &&
   595		    (!sc->dev->of_node ||
   596		     !of_property_match_string(sc->dev->of_node,
   597					       "nvmem-cell-names",
   598					       "calibration") ||
   599		     !of_pci_node_match_driver(sc->dev->of_node,
 > 600					       &ath_pci_driver)))
   601			/* follow the "just return 0;" convention as
   602			 * noted below.
   603			 */
   604			return 0;
   605	
   606		cell = devm_nvmem_cell_get(sc->dev, "calibration");
   607		if (IS_ERR(cell)) {
   608			err = PTR_ERR(cell);
   609	
   610			/* nvmem cell might not be defined, or the nvmem
   611			 * subsystem isn't included. In this case, follow
   612			 * the established "just return 0;" convention of
   613			 * ath9k_init_platform to say:
   614			 * "All good. Nothing to see here. Please go on."
   615			 */
   616			if (err == -ENOENT || err == -EOPNOTSUPP)
   617				return 0;
   618	
   619			return err;
   620		}
   621	
   622		buf = nvmem_cell_read(cell, &len);
   623		if (IS_ERR(buf))
   624			return PTR_ERR(buf);
   625	
   626		/* run basic sanity checks on the returned nvram cell length.
   627		 * That length has to be a multiple of a "u16" (i.e.: & 1).
   628		 * Furthermore, it has to be more than "let's say" 512 bytes
   629		 * but less than the maximum of AR9300_EEPROM_SIZE (16kb).
   630		 */
   631		if ((len & 1) == 1 || len < 512 || len >= AR9300_EEPROM_SIZE) {
   632			kfree(buf);
   633			return -EINVAL;
   634		}
   635	
   636		/* devres manages the calibration values release on shutdown */
   637		ah->nvmem_blob = (u16 *)devm_kmemdup(sc->dev, buf, len, GFP_KERNEL);
   638		kfree(buf);
   639		if (!ah->nvmem_blob)
   640			return -ENOMEM;
   641	
   642		ah->nvmem_blob_len = len;
   643		ah->ah_flags &= ~AH_USE_EEPROM;
   644		ah->ah_flags |= AH_NO_EEP_SWAP;
   645	
   646		return 0;
   647	}
   648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
