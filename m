Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC515E7E3A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIWPWX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiIWPWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 11:22:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72B14356D;
        Fri, 23 Sep 2022 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663946520; x=1695482520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cPxwyjbHhuihks0jZOWKPSH/Ooof7nqq1xCMFUAIxE=;
  b=BBQRr6tGkPaWNOQV8UDia5A2l16ChWLYfjZjSrm+8sY1t36kc0+MbGDm
   x3ojzo2ahHr3ISl+xru9cQd15Japexn2SJPChYZkbMRJsH5AwMCPb5mHO
   UdONT7zYRhXgcuK31BYB6rKB4xXdJRf01lcJlDEDb/HOikS1ppuXFK7pc
   50aQkK/P/QsQYZJWfon7SFsZDxyYKLNQBeUA8Wsaat/i9Uuc5W0HHnFKM
   S/pCO2Fy+KB5nwuT7dwn99uEEo3Xa0OIFfbLmBAeLkUQVmr/6lEkmjW0q
   83aQJAxe0HIr5VemdMPTAn23wOt7AJ0sEAqE1PxkYhylvHmfyOMXHnOyk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300596936"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300596936"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="653431333"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Sep 2022 08:21:57 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obkV2-0005mW-29;
        Fri, 23 Sep 2022 15:21:56 +0000
Date:   Fri, 23 Sep 2022 23:21:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaochun Lee <lixiaochun.2888@163.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Cc:     kbuild-all@lists.01.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>
Subject: Re: [PATCH v1] PCI: Set no io resource for bridges that behind VMD
 controller
Message-ID: <202209240714.ronvmf1X-lkp@intel.com>
References: <1663075485-20591-1-git-send-email-lixiaochun.2888@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663075485-20591-1-git-send-email-lixiaochun.2888@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Xiaochun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on linus/master v6.0-rc6 next-20220923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaochun-Lee/PCI-Set-no-io-resource-for-bridges-that-behind-VMD-controller/20220913-213745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220924/202209240714.ronvmf1X-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f97a8ba561d7cf5a755c8f42421138e8b1073cf9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiaochun-Lee/PCI-Set-no-io-resource-for-bridges-that-behind-VMD-controller/20220913-213745
        git checkout f97a8ba561d7cf5a755c8f42421138e8b1073cf9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/quirks.c: In function 'quirk_vmd_no_iosize':
>> drivers/pci/quirks.c:5985:13: error: implicit declaration of function 'is_vmd' [-Werror=implicit-function-declaration]
    5985 |         if (is_vmd(bridge->bus) && bridge->is_hotplug_bridge) {
         |             ^~~~~~
   cc1: some warnings being treated as errors


vim +/is_vmd +5985 drivers/pci/quirks.c

  5959	
  5960	#if defined(CONFIG_X86_64) || defined(CONFIG_X86)
  5961	/*
  5962	 * VMD-enabled root ports use Enhanced Configuration Access Mechanism (ECAM)
  5963	 * access PCI Express configuration space, and offer VMD_CFGBAR as
  5964	 * base of PCI Express configuration space for the bridges behind it.
  5965	 * The configuration space includes IO resources, but these IO
  5966	 * resources are not actually used on X86, especially the NVMes as
  5967	 * device connnected on this hot plug bridges, and it can result
  5968	 * in BAR#13 assign IO resource failed. So we clear IO resources
  5969	 * by setting an IO base value greater than limit to these bridges.
  5970	 * Hence, append kernel parameter "pci=hpiosize=0KB" can avoid
  5971	 * this BAR#13 failed messages show out.
  5972	 */
  5973	static void quirk_vmd_no_iosize(struct pci_dev *bridge)
  5974	{
  5975		u8 io_base_lo, io_limit_lo;
  5976		u16 io_low;
  5977		u32 io_upper16;
  5978		unsigned long io_mask,  base, limit;
  5979	
  5980		io_mask = PCI_IO_RANGE_MASK;
  5981		if (bridge->io_window_1k)
  5982			io_mask = PCI_IO_1K_RANGE_MASK;
  5983	
  5984		/* VMD Domain */
> 5985		if (is_vmd(bridge->bus) && bridge->is_hotplug_bridge) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
