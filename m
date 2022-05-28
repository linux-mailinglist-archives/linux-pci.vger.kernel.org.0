Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004C7536A39
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 04:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352508AbiE1C0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 22:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiE1C0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 22:26:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E723190C;
        Fri, 27 May 2022 19:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653704799; x=1685240799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=khUH6vszZsy4AF5ZynvIyQU7qpFD2NmUUG/bJcOTCT0=;
  b=bDDbYy3cPGOB9sSUV4n+KtkCRfqINdaYhoZCoS8NML6ceuamdtDFebmc
   NVPSrjnCf0NPcYBU1+j6FCEHPrCXaP6bNLdTmXUuJua9209wnlAZpdegH
   jHK0k7RKFT9wF+o7zlGU1nAvC7pohsk4+zKGJMCYRGp74v3Igm0tThcft
   nRfD/PYloXYcUVDc0E8lB5ACgkv5K4BTP/7SFiabz9+c/r3hY48OjSqwJ
   NEBEfcv4KMroBnLjDmnR2ImRRUqOpQQzWK55ACMwLBDpFJovXhS88TpI3
   bopbMjrjsEEM3+4BYe+peMGeSjRbr7WTN2QQ39VYuVerluiIS7Ibr9qxP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274624183"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274624183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 19:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="604204638"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2022 19:26:34 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1num9x-0005Nl-Iw;
        Sat, 28 May 2022 02:26:33 +0000
Date:   Sat, 28 May 2022 10:25:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     keliu <liuke94@huawei.com>, scott.branden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, gustavo.pimentel@synopsys.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        keliu <liuke94@huawei.com>
Subject: Re: [PATCH] drivers: misc: Directly use ida_alloc()/free()
Message-ID: <202205281008.BUCRO77S-lkp@intel.com>
References: <20220527083953.2636843-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527083953.2636843-1-liuke94@huawei.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi keliu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/keliu/drivers-misc-Directly-use-ida_alloc-free/20220527-162050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 90de6805267f8c79cd2b1a36805071e257c39b5c
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220528/202205281008.BUCRO77S-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8f84e5642ea1ff2fb220c002a35c7d74ec14323
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review keliu/drivers-misc-Directly-use-ida_alloc-free/20220527-162050
        git checkout f8f84e5642ea1ff2fb220c002a35c7d74ec14323
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/dw-xdata-pcie.c:336:7: error: call to undeclared function 'ida_'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = ida_(&xdata_ida, GFP_KERNEL);
                ^
   1 error generated.


vim +/ida_ +336 drivers/misc/dw-xdata-pcie.c

   287	
   288	static int dw_xdata_pcie_probe(struct pci_dev *pdev,
   289				       const struct pci_device_id *pid)
   290	{
   291		struct device *dev = &pdev->dev;
   292		struct dw_xdata *dw;
   293		char name[24];
   294		u64 addr;
   295		int err;
   296		int id;
   297	
   298		/* Enable PCI device */
   299		err = pcim_enable_device(pdev);
   300		if (err) {
   301			dev_err(dev, "enabling device failed\n");
   302			return err;
   303		}
   304	
   305		/* Mapping PCI BAR regions */
   306		err = pcim_iomap_regions(pdev, BIT(BAR_0), pci_name(pdev));
   307		if (err) {
   308			dev_err(dev, "xData BAR I/O remapping failed\n");
   309			return err;
   310		}
   311	
   312		pci_set_master(pdev);
   313	
   314		/* Allocate memory */
   315		dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
   316		if (!dw)
   317			return -ENOMEM;
   318	
   319		/* Data structure initialization */
   320		mutex_init(&dw->mutex);
   321	
   322		dw->rg_region.vaddr = pcim_iomap_table(pdev)[BAR_0];
   323		if (!dw->rg_region.vaddr)
   324			return -ENOMEM;
   325	
   326		dw->rg_region.paddr = pdev->resource[BAR_0].start;
   327	
   328		dw->max_wr_len = pcie_get_mps(pdev);
   329		dw->max_wr_len >>= 2;
   330	
   331		dw->max_rd_len = pcie_get_readrq(pdev);
   332		dw->max_rd_len >>= 2;
   333	
   334		dw->pdev = pdev;
   335	
 > 336		id = ida_(&xdata_ida, GFP_KERNEL);
   337		if (id < 0) {
   338			dev_err(dev, "xData: unable to get id\n");
   339			return id;
   340		}
   341	
   342		snprintf(name, sizeof(name), DW_XDATA_DRIVER_NAME ".%d", id);
   343		dw->misc_dev.name = kstrdup(name, GFP_KERNEL);
   344		if (!dw->misc_dev.name) {
   345			err = -ENOMEM;
   346			goto err_ida_remove;
   347		}
   348	
   349		dw->misc_dev.minor = MISC_DYNAMIC_MINOR;
   350		dw->misc_dev.parent = dev;
   351		dw->misc_dev.groups = xdata_groups;
   352	
   353		writel(0x0, &(__dw_regs(dw)->RAM_addr));
   354		writel(0x0, &(__dw_regs(dw)->RAM_port));
   355	
   356		addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
   357		writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
   358		writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
   359		dev_dbg(dev, "xData: target address = 0x%.16llx\n", addr);
   360	
   361		dev_dbg(dev, "xData: wr_len = %zu, rd_len = %zu\n",
   362			dw->max_wr_len * 4, dw->max_rd_len * 4);
   363	
   364		/* Saving data structure reference */
   365		pci_set_drvdata(pdev, dw);
   366	
   367		/* Register misc device */
   368		err = misc_register(&dw->misc_dev);
   369		if (err) {
   370			dev_err(dev, "xData: failed to register device\n");
   371			goto err_kfree_name;
   372		}
   373	
   374		return 0;
   375	
   376	err_kfree_name:
   377		kfree(dw->misc_dev.name);
   378	
   379	err_ida_remove:
   380		ida_free(&xdata_ida, id);
   381	
   382		return err;
   383	}
   384	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
