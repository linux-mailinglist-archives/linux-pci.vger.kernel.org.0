Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C4577017
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiGPQV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPQVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 12:21:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563351583F
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657988484; x=1689524484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l2/+jG6Niw3piIq8FCeuQl0krknO0ObnJv/CccaACX4=;
  b=VSQJ26fiQyTPR+zVTFs0bwSy7/DNYTlumxtGqBZFxrs5MnSAWZOnLBHD
   VuDx4RfdN6r4gY+6EXRcdath8B6PcxdQ1UgSeRxA7YgJyxh2GdZnNbEIr
   NE38/9KZVQGHataVFicwWywXA4Hum11vrS5aS5z5D08WalrgakADy5/tS
   R5mKhaDgyp74it8FnQd9R1Rtw9GI1xia7BmYwdD5Xc6TBMYju5ay6CwFS
   cUn/ZBwJilIKR+Fv5iMKYs1YuGwF49MuQVukqLVsnNP78v06Tj9OUnEzR
   Qqeh7fbHCiJz57QxcpsXFOIioz3/W2Asj4woT5jGd5nuc03KuWiXFjAAN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="286722035"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="286722035"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 09:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="546999972"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 09:21:22 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCkXh-0001nx-R8;
        Sat, 16 Jul 2022 16:21:21 +0000
Date:   Sun, 17 Jul 2022 00:21:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [helgaas-pci:pci/misc 2/2] drivers/pcmcia/omap_cf.c:240:18: error:
 implicit declaration of function 'pci_remap_iospace'; did you mean
 'pci_remap_cfgspace'?
Message-ID: <202207170012.RhbvYS0z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
head:   c86c8360959ec706576baf17237dec3004154d4b
commit: c86c8360959ec706576baf17237dec3004154d4b [2/2] arm: ioremap: Fix pci_remap_iospace() when CONFIG_MMU unset
config: arm-randconfig-r016-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170012.RhbvYS0z-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=c86c8360959ec706576baf17237dec3004154d4b
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/misc
        git checkout c86c8360959ec706576baf17237dec3004154d4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pcmcia/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pcmcia/omap_cf.c: In function 'omap_cf_set_socket':
   drivers/pcmcia/omap_cf.c:127:25: warning: variable 'control' set but not used [-Wunused-but-set-variable]
     127 |         u16             control;
         |                         ^~~~~~~
   drivers/pcmcia/omap_cf.c: In function 'omap_cf_probe':
>> drivers/pcmcia/omap_cf.c:240:18: error: implicit declaration of function 'pci_remap_iospace'; did you mean 'pci_remap_cfgspace'? [-Werror=implicit-function-declaration]
     240 |         status = pci_remap_iospace(&iospace, cf->phys_cf + SZ_4K);
         |                  ^~~~~~~~~~~~~~~~~
         |                  pci_remap_cfgspace
   cc1: some warnings being treated as errors


vim +240 drivers/pcmcia/omap_cf.c

f74e48a51c38f5 David Brownell   2005-09-09  195  
f74e48a51c38f5 David Brownell   2005-09-09  196  /*
f74e48a51c38f5 David Brownell   2005-09-09  197   * NOTE:  right now the only board-specific platform_data is
f74e48a51c38f5 David Brownell   2005-09-09  198   * "what chipselect is used".  Boards could want more.
f74e48a51c38f5 David Brownell   2005-09-09  199   */
f74e48a51c38f5 David Brownell   2005-09-09  200  
b6d2cccb55b518 David Brownell   2007-04-08  201  static int __init omap_cf_probe(struct platform_device *pdev)
f74e48a51c38f5 David Brownell   2005-09-09  202  {
f74e48a51c38f5 David Brownell   2005-09-09  203  	unsigned		seg;
f74e48a51c38f5 David Brownell   2005-09-09  204  	struct omap_cf_socket	*cf;
f74e48a51c38f5 David Brownell   2005-09-09  205  	int			irq;
f74e48a51c38f5 David Brownell   2005-09-09  206  	int			status;
d87d44f7ab353d Arnd Bergmann    2019-08-05  207  	struct resource		*res;
df99e7bbbec318 Arnd Bergmann    2019-08-06  208  	struct resource		iospace = DEFINE_RES_IO(SZ_64, SZ_4K);
f74e48a51c38f5 David Brownell   2005-09-09  209  
b6d2cccb55b518 David Brownell   2007-04-08  210  	seg = (int) pdev->dev.platform_data;
f74e48a51c38f5 David Brownell   2005-09-09  211  	if (seg == 0 || seg > 3)
f74e48a51c38f5 David Brownell   2005-09-09  212  		return -ENODEV;
f74e48a51c38f5 David Brownell   2005-09-09  213  
f74e48a51c38f5 David Brownell   2005-09-09  214  	/* either CFLASH.IREQ (INT_1610_CF) or some GPIO */
f74e48a51c38f5 David Brownell   2005-09-09  215  	irq = platform_get_irq(pdev, 0);
489447380a2921 David Vrabel     2006-01-19  216  	if (irq < 0)
f74e48a51c38f5 David Brownell   2005-09-09  217  		return -EINVAL;
f74e48a51c38f5 David Brownell   2005-09-09  218  
d87d44f7ab353d Arnd Bergmann    2019-08-05  219  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
d87d44f7ab353d Arnd Bergmann    2019-08-05  220  
cd86128088554d Robert P. J. Day 2006-12-13  221  	cf = kzalloc(sizeof *cf, GFP_KERNEL);
f74e48a51c38f5 David Brownell   2005-09-09  222  	if (!cf)
f74e48a51c38f5 David Brownell   2005-09-09  223  		return -ENOMEM;
41760d0e0f1a01 Kees Cook        2017-10-21  224  	timer_setup(&cf->timer, omap_cf_timer, 0);
f74e48a51c38f5 David Brownell   2005-09-09  225  
f74e48a51c38f5 David Brownell   2005-09-09  226  	cf->pdev = pdev;
b6d2cccb55b518 David Brownell   2007-04-08  227  	platform_set_drvdata(pdev, cf);
f74e48a51c38f5 David Brownell   2005-09-09  228  
f74e48a51c38f5 David Brownell   2005-09-09  229  	/* this primarily just shuts up irq handling noise */
dace145374b8e3 Thomas Gleixner  2006-07-01  230  	status = request_irq(irq, omap_cf_irq, IRQF_SHARED,
f74e48a51c38f5 David Brownell   2005-09-09  231  			driver_name, cf);
f74e48a51c38f5 David Brownell   2005-09-09  232  	if (status < 0)
f74e48a51c38f5 David Brownell   2005-09-09  233  		goto fail0;
f74e48a51c38f5 David Brownell   2005-09-09  234  	cf->irq = irq;
f74e48a51c38f5 David Brownell   2005-09-09  235  	cf->socket.pci_irq = irq;
d87d44f7ab353d Arnd Bergmann    2019-08-05  236  	cf->phys_cf = res->start;
f74e48a51c38f5 David Brownell   2005-09-09  237  
f74e48a51c38f5 David Brownell   2005-09-09  238  	/* pcmcia layer only remaps "real" memory */
df99e7bbbec318 Arnd Bergmann    2019-08-06  239  	cf->socket.io_offset = iospace.start;
df99e7bbbec318 Arnd Bergmann    2019-08-06 @240  	status = pci_remap_iospace(&iospace, cf->phys_cf + SZ_4K);
df99e7bbbec318 Arnd Bergmann    2019-08-06  241  	if (status) {
70d3a462fc244b Wang ShaoBo      2020-11-25  242  		status = -ENOMEM;
f74e48a51c38f5 David Brownell   2005-09-09  243  		goto fail1;
70d3a462fc244b Wang ShaoBo      2020-11-25  244  	}
f74e48a51c38f5 David Brownell   2005-09-09  245  
70d3a462fc244b Wang ShaoBo      2020-11-25  246  	if (!request_mem_region(cf->phys_cf, SZ_8K, driver_name)) {
70d3a462fc244b Wang ShaoBo      2020-11-25  247  		status = -ENXIO;
f74e48a51c38f5 David Brownell   2005-09-09  248  		goto fail1;
70d3a462fc244b Wang ShaoBo      2020-11-25  249  	}
f74e48a51c38f5 David Brownell   2005-09-09  250  
f74e48a51c38f5 David Brownell   2005-09-09  251  	/* NOTE:  CF conflicts with MMC1 */
f74e48a51c38f5 David Brownell   2005-09-09  252  	omap_cfg_reg(W11_1610_CF_CD1);
f74e48a51c38f5 David Brownell   2005-09-09  253  	omap_cfg_reg(P11_1610_CF_CD2);
f74e48a51c38f5 David Brownell   2005-09-09  254  	omap_cfg_reg(R11_1610_CF_IOIS16);
f74e48a51c38f5 David Brownell   2005-09-09  255  	omap_cfg_reg(V10_1610_CF_IREQ);
f74e48a51c38f5 David Brownell   2005-09-09  256  	omap_cfg_reg(W10_1610_CF_RESET);
f74e48a51c38f5 David Brownell   2005-09-09  257  
030b15457d8069 Tony Lindgren    2008-07-03  258  	omap_writew(~(1 << seg), CF_CFG);
f74e48a51c38f5 David Brownell   2005-09-09  259  
f74e48a51c38f5 David Brownell   2005-09-09  260  	pr_info("%s: cs%d on irq %d\n", driver_name, seg, irq);
f74e48a51c38f5 David Brownell   2005-09-09  261  
f74e48a51c38f5 David Brownell   2005-09-09  262  	/* CF uses armxor_ck, which is "always" available */
f74e48a51c38f5 David Brownell   2005-09-09  263  
f74e48a51c38f5 David Brownell   2005-09-09  264  	pr_debug("%s: sts %04x cfg %04x control %04x %s\n", driver_name,
030b15457d8069 Tony Lindgren    2008-07-03  265  		omap_readw(CF_STATUS), omap_readw(CF_CFG),
030b15457d8069 Tony Lindgren    2008-07-03  266  		omap_readw(CF_CONTROL),
f74e48a51c38f5 David Brownell   2005-09-09  267  		omap_cf_present() ? "present" : "(not present)");
f74e48a51c38f5 David Brownell   2005-09-09  268  
f74e48a51c38f5 David Brownell   2005-09-09  269  	cf->socket.owner = THIS_MODULE;
b6d2cccb55b518 David Brownell   2007-04-08  270  	cf->socket.dev.parent = &pdev->dev;
f74e48a51c38f5 David Brownell   2005-09-09  271  	cf->socket.ops = &omap_cf_ops;
f74e48a51c38f5 David Brownell   2005-09-09  272  	cf->socket.resource_ops = &pccard_static_ops;
f74e48a51c38f5 David Brownell   2005-09-09  273  	cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP
f74e48a51c38f5 David Brownell   2005-09-09  274  				| SS_CAP_MEM_ALIGN;
f74e48a51c38f5 David Brownell   2005-09-09  275  	cf->socket.map_size = SZ_2K;
dcb9c39236a27c David Brownell   2006-09-30  276  	cf->socket.io[0].res = &cf->iomem;
f74e48a51c38f5 David Brownell   2005-09-09  277  
f74e48a51c38f5 David Brownell   2005-09-09  278  	status = pcmcia_register_socket(&cf->socket);
f74e48a51c38f5 David Brownell   2005-09-09  279  	if (status < 0)
f74e48a51c38f5 David Brownell   2005-09-09  280  		goto fail2;
f74e48a51c38f5 David Brownell   2005-09-09  281  
f74e48a51c38f5 David Brownell   2005-09-09  282  	cf->active = 1;
f74e48a51c38f5 David Brownell   2005-09-09  283  	mod_timer(&cf->timer, jiffies + POLL_INTERVAL);
f74e48a51c38f5 David Brownell   2005-09-09  284  	return 0;
f74e48a51c38f5 David Brownell   2005-09-09  285  
f74e48a51c38f5 David Brownell   2005-09-09  286  fail2:
f74e48a51c38f5 David Brownell   2005-09-09  287  	release_mem_region(cf->phys_cf, SZ_8K);
f74e48a51c38f5 David Brownell   2005-09-09  288  fail1:
f74e48a51c38f5 David Brownell   2005-09-09  289  	free_irq(irq, cf);
f74e48a51c38f5 David Brownell   2005-09-09  290  fail0:
f74e48a51c38f5 David Brownell   2005-09-09  291  	kfree(cf);
f74e48a51c38f5 David Brownell   2005-09-09  292  	return status;
f74e48a51c38f5 David Brownell   2005-09-09  293  }
f74e48a51c38f5 David Brownell   2005-09-09  294  

:::::: The code at line 240 was first introduced by commit
:::::: df99e7bbbec3180693b3d932a9cbc88346e2a30e ARM: omap1: use pci_remap_iospace() for omap_cf

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
