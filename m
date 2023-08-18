Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0047805C5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357803AbjHRFvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357744AbjHRFvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:51:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056032D7F;
        Thu, 17 Aug 2023 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692337881; x=1723873881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UEcu83cy8Od5Jkea6QF5T9Zq+9si5UHFbRMs9/J/T5U=;
  b=PR42pRNSABMv9ftiYuCnc9CUcYytvcUBhLp9K2ZIC2UznoKGzemdsyGs
   vTwgwL5hMCtJ8tHrn0VEn+nbuLTfrg5zsln2w7UV8aepLDgFlMBzAplhX
   XMg224W1tVkKYCt2J+jxYysMkl4GsHvVf4EzBK3nfDGFoLOgiYFyFEmGr
   vftj8LqSveZGXLRYem7dPtx/kKNlz7pxS3+waF03N70+W3SYBYxfgbAaP
   Ry+8+gZQW6OcIFl7U7Thvsq0D4NNOfSWprl2lgeRscPpI6aK18VipMp/m
   L5fb6+MZci5kiB8hB8o4PEa1BxXXUgdduDSF9tUuPVJeS4WHVbLn4CIqq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436935373"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="436935373"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 22:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065613717"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="1065613717"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 22:51:16 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWsNs-00029M-0q;
        Fri, 18 Aug 2023 05:51:01 +0000
Date:   Fri, 18 Aug 2023 13:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        lukas@wunner.de
Cc:     oe-kbuild-all@lists.linux.dev, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 1/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <202308181341.DWHmL2Au-lkp@intel.com>
References: <20230817235810.596458-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817235810.596458-1-alistair.francis@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alistair,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/sysfs-Add-a-attr_is_visible-function-to-attribute_group/20230818-080110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230817235810.596458-1-alistair.francis%40wdc.com
patch subject: [PATCH v6 1/3] PCI/DOE: Expose the DOE features via sysfs
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308181341.DWHmL2Au-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181341.DWHmL2Au-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308181341.DWHmL2Au-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/doe.c:61: warning: Function parameter or member 'sysfs_attrs' not described in 'pci_doe_mb'


vim +61 drivers/pci/doe.c

a4ff8e7a716013 Li Ming          2022-11-16  36  
9d24322e887b6a Jonathan Cameron 2022-07-19  37  /**
9d24322e887b6a Jonathan Cameron 2022-07-19  38   * struct pci_doe_mb - State for a single DOE mailbox
9d24322e887b6a Jonathan Cameron 2022-07-19  39   *
9d24322e887b6a Jonathan Cameron 2022-07-19  40   * This state is used to manage a single DOE mailbox capability.  All fields
9d24322e887b6a Jonathan Cameron 2022-07-19  41   * should be considered opaque to the consumers and the structure passed into
022b66f38195f6 Lukas Wunner     2023-03-11  42   * the helpers below after being created by pci_doe_create_mb().
9d24322e887b6a Jonathan Cameron 2022-07-19  43   *
9d24322e887b6a Jonathan Cameron 2022-07-19  44   * @pdev: PCI device this mailbox belongs to
9d24322e887b6a Jonathan Cameron 2022-07-19  45   * @cap_offset: Capability offset
9d24322e887b6a Jonathan Cameron 2022-07-19  46   * @prots: Array of protocols supported (encoded as long values)
9d24322e887b6a Jonathan Cameron 2022-07-19  47   * @wq: Wait queue for work item
9d24322e887b6a Jonathan Cameron 2022-07-19  48   * @work_queue: Queue of pci_doe_work items
9d24322e887b6a Jonathan Cameron 2022-07-19  49   * @flags: Bit array of PCI_DOE_FLAG_* flags
9d24322e887b6a Jonathan Cameron 2022-07-19  50   */
9d24322e887b6a Jonathan Cameron 2022-07-19  51  struct pci_doe_mb {
9d24322e887b6a Jonathan Cameron 2022-07-19  52  	struct pci_dev *pdev;
9d24322e887b6a Jonathan Cameron 2022-07-19  53  	u16 cap_offset;
9d24322e887b6a Jonathan Cameron 2022-07-19  54  	struct xarray prots;
9d24322e887b6a Jonathan Cameron 2022-07-19  55  
9d24322e887b6a Jonathan Cameron 2022-07-19  56  	wait_queue_head_t wq;
9d24322e887b6a Jonathan Cameron 2022-07-19  57  	struct workqueue_struct *work_queue;
9d24322e887b6a Jonathan Cameron 2022-07-19  58  	unsigned long flags;
2a8556606e90c6 Alistair Francis 2023-08-17  59  
2a8556606e90c6 Alistair Francis 2023-08-17  60  	struct device_attribute *sysfs_attrs;
9d24322e887b6a Jonathan Cameron 2022-07-19 @61  };
9d24322e887b6a Jonathan Cameron 2022-07-19  62  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
