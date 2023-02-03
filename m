Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589F168922D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjBCI0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBCI0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:26:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE85795D0E;
        Fri,  3 Feb 2023 00:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675412700; x=1706948700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oaAPFQiV9oHb7tB9lLuvJEfMSEquOivhshhLc2stFqs=;
  b=ZLROnQLJJjzEOUXfZ1m3WESn9IglvCrwl3dDPCK/idg7CJLM4jxDfbBP
   ukz1qs48OP1sXFwZ96lF8HdBrX8+pQrcZtNW80sk0dmEPtc8hhkpx0KyH
   L89qtj5kxkyXAsNGgQtaQayJ8kjgsjNEyN1k5IRr9EBBagw7CRNupTPKA
   t+u7B6aBSynjmZapycooGRJlHHZoLS2n8fIjTeDE5mgZM9ZWTO0M6F89n
   QlQuj4lgx6xDOGxCh++NjA7JkFpe8iYugZoId7ltnQ6LbQnGICWjkfsDD
   Tw5VlEr7t63+lRZfOCsCwVAdxt1Bqv/rSU8pmb3+thl4znad1X089n+f0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="316687219"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="316687219"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839520895"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="839520895"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2023 00:24:48 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNrNI-0000JD-0I;
        Fri, 03 Feb 2023 08:24:48 +0000
Date:   Fri, 3 Feb 2023 16:23:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     equu@openmail.cc, lpieralisi@kernel.org, toke@toke.dk,
        kvalo@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        robh@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, equu@openmail.cc,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 1/3] PCI: of: Match pci devices or drivers against OF
 DT nodes
Message-ID: <202302031611.JepssFdR-lkp@intel.com>
References: <20230202075524.2911058-2-equu@openmail.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202075524.2911058-2-equu@openmail.cc>
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
patch link:    https://lore.kernel.org/r/20230202075524.2911058-2-equu%40openmail.cc
patch subject: [PATCH v3 1/3] PCI: of: Match pci devices or drivers against OF DT nodes
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230203/202302031611.JepssFdR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/1c1bc10b9cc6f7a71ba1fb7bdc505195a2c3e759
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review equu-openmail-cc/wifi-ath9k-stop-loading-incompatible-DT-cal-data/20230202-165536
        git checkout 1c1bc10b9cc6f7a71ba1fb7bdc505195a2c3e759
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/of.c: In function 'of_pci_compat_to_device_id':
>> drivers/pci/of.c:296:25: error: expected ';' before '}' token
     296 |                 return 0
         |                         ^
         |                         ;
     297 |         }
         |         ~                
   drivers/pci/of.c:319:25: error: expected ';' before '}' token
     319 |                 return 0
         |                         ^
         |                         ;
     320 |         }
         |         ~                
   drivers/pci/of.c:330:25: error: expected ';' before '}' token
     330 |                 return 0
         |                         ^
         |                         ;
     331 |         }
         |         ~                
>> drivers/pci/of.c:346:25: error: expected ';' before 'compat'
     346 |                 return 0
         |                         ^
         |                         ;
     347 | 
     348 |         compat++;
         |         ~~~~~~           


vim +296 drivers/pci/of.c

   255	
   256	/**
   257	 * of_pci_compat_to_device_id() - Decode an OF compatibility string into a
   258	 * pci_device_id structure.
   259	 * @compat: the compatibility string to decode, could be NULL
   260	 * @id: pointer to a struct pci_device_id, to store the result
   261	 * @rev: pointer to output revision info, PCI_ANY_ID if no revision in @compat
   262	 * @req_pcie: pointer to output whether @compat mandates PCIe compatibility
   263	 *
   264	 * returns 0 when success, -EINVAL when failed.
   265	 */
   266	int of_pci_compat_to_device_id(const char *compat, struct pci_device_id *id,
   267				       u32 *rev, u32 *req_pcie)
   268	{
   269		union {
   270			u8 u8;
   271			u16 u16;
   272			u32 u32;
   273		} res = {0};
   274		*req_pcie = 0;
   275		*rev = PCI_ANY_ID;
   276		if (!compat || strncasecmp(compat, "pci", 3) != 0)
   277			return -EINVAL;
   278		compat += 3;
   279	
   280		if (strncasecmp(compat, "class,", 6) == 0) {
   281			/* pciclass,CCSSPP */
   282			compat += 6;
   283			if ((strlen(compat) < 4)
   284			   || kstrtouint(compat, 16, &id->class))
   285				return -EINVAL;
   286			if (id->class < 0x10000) {
   287				id->class <<= 8;
   288				id->class_mask = 0xFFFF00;
   289			} else {
   290				id->class_mask = PCI_ANY_ID;
   291			}
   292			id->vendor = PCI_ANY_ID;
   293			id->device = PCI_ANY_ID;
   294			id->subvendor = PCI_ANY_ID;
   295			id->subdevice = PCI_ANY_ID;
 > 296			return 0
   297		}
   298	
   299		if (strncasecmp(compat, "ex", 2) == 0) {
   300			/* pciex...  */
   301			*req_pcie = 1;
   302			compat += 2;
   303		}
   304		if (kstrtou16(compat, 16, &res.u16))
   305			return -EINVAL;
   306		id->vendor = res.u16;
   307		compat = strchr(compat, ',');
   308		if (!compat)
   309			return -EINVAL;
   310		compat++;
   311		if (kstrtou16(compat, 16, &res.u16))
   312			return -EINVAL;
   313		id->device = res.u16;
   314		compat = strchr(compat, '.');
   315		if (compat == NULL) {
   316			/* pciVVVV,DDDD */
   317			id->subvendor = PCI_ANY_ID;
   318			id->subdevice = PCI_ANY_ID;
   319			return 0
   320		}
   321	
   322		compat++;
   323		if (strlen(compat) == 2) {
   324			/* pciVVVV,DDDD.RR */
   325			if (kstrtou8(compat, 16, &res.u8))
   326				return -EINVAL;
   327			*rev = res.u8;
   328			id->subvendor = PCI_ANY_ID;
   329			id->subdevice = PCI_ANY_ID;
   330			return 0
   331		}
   332	
   333		if (kstrtou16(compat, 16, &res.u16))
   334			return -EINVAL;
   335		id->subvendor = res.u16;
   336		compat = strchr(compat, '.');
   337		if (!compat)
   338			return -EINVAL;
   339		compat++;
   340		if (kstrtou16(compat, 16, &res.u16))
   341			return -EINVAL;
   342		id->subdevice = res.u16;
   343		compat = strchr(compat, '.');
   344		if (compat == NULL)
   345			/* pciVVVV,DDDD.SSSS.ssss */
 > 346			return 0
   347	
   348		compat++;
   349		if (strlen(compat) == 2) {
   350			/* pciVVVV,DDDD.SSSS.ssss.RR */
   351			if (kstrtou8(compat, 16, &res.u8))
   352				return -EINVAL;
   353			*rev = res.u8;
   354		}
   355		return 0;
   356	}
   357	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
