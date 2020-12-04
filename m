Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CBF2CEF1E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgLDN6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 08:58:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:37215 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbgLDN6D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 08:58:03 -0500
IronPort-SDR: kHtdD21lpmYMeOQhadwrwW7i0LGwNgu+3vVJQUHZEeDTXfZamWl1qyEKpfr1MQLkiMnamu/oKD
 6LZUnTQpzeJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="191623472"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="gz'50?scan'50,208,50";a="191623472"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 05:57:22 -0800
IronPort-SDR: d3P565gVJItF47y7uoEpsUWx19xPU9iY+Wd5xVNyQ/T/lCtRiV/IS4v+TH4HQBg9/xNrngj4zl
 SmxpnwTiG8+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="gz'50?scan'50,208,50";a="374353697"
Received: from lkp-server02.sh.intel.com (HELO f74a175f0d75) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2020 05:57:20 -0800
Received: from kbuild by f74a175f0d75 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klBaK-00007Z-3y; Fri, 04 Dec 2020 13:57:20 +0000
Date:   Fri, 4 Dec 2020 21:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org
Subject: [pci:pci/msi 3/5] drivers/misc/mei/pci-me.c:354: undefined reference
 to `pci_disable_msi'
Message-ID: <202012042151.UuysjIQc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
head:   a06fcdc6b3ae3552cdc8c6326bd265e336fae9bf
commit: 8c608074113b24ad54477ac8bf8a50edb32efe56 [3/5] PCI/MSI: Move MSI/MSI-X init to msi.c
config: i386-randconfig-a006-20201204 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=8c608074113b24ad54477ac8bf8a50edb32efe56
        git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags pci pci/msi
        git checkout 8c608074113b24ad54477ac8bf8a50edb32efe56
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/x86_init.o:arch/x86/kernel/x86_init.c:148: undefined reference to `default_restore_msi_irqs'
   ld: arch/x86/kernel/apic/msi.o:(.data+0xbc): undefined reference to `pci_msi_mask_irq'
   ld: arch/x86/kernel/apic/msi.o:(.data+0xc4): undefined reference to `pci_msi_unmask_irq'
   ld: arch/x86/kernel/apic/msi.o: in function `native_create_pci_msi_domain':
   arch/x86/kernel/apic/msi.c:227: undefined reference to `pci_msi_create_irq_domain'
   ld: kernel/irq/msi.o: in function `msi_check_reservation_mode':
   kernel/irq/msi.c:387: undefined reference to `pci_msi_ignore_mask'
   ld: drivers/pci/probe.o: in function `pci_dev_msi_domain':
   drivers/pci/probe.c:2429: undefined reference to `pci_msi_get_device_domain'
   ld: drivers/pci/pci.o: in function `pci_restore_state':
   drivers/pci/pci.c:1687: undefined reference to `pci_restore_msi_state'
   ld: drivers/pci/pci.o: in function `pcim_release':
   drivers/pci/pci.c:1977: undefined reference to `pci_disable_msi'
   ld: drivers/pci/pci.c:1979: undefined reference to `pci_disable_msix'
   ld: drivers/pci/pci.o: in function `pci_setup':
   drivers/pci/pci.c:6500: undefined reference to `pci_no_msi'
   ld: drivers/pci/irq.o: in function `pci_request_irq':
   drivers/pci/irq.c:48: undefined reference to `pci_irq_vector'
   ld: drivers/pci/irq.o: in function `pci_free_irq':
   drivers/pci/irq.c:72: undefined reference to `pci_irq_vector'
   ld: drivers/pci/pci-acpi.o: in function `acpi_pci_init':
   drivers/pci/pci-acpi.c:1351: undefined reference to `pci_no_msi'
   ld: drivers/pci/quirks.o: in function `quirk_disable_all_msi':
   drivers/pci/quirks.c:2514: undefined reference to `pci_no_msi'
   ld: drivers/pci/quirks.o: in function `__nv_msi_ht_cap_quirk':
   drivers/pci/quirks.c:2904: undefined reference to `pci_msi_enabled'
   ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_msi_unmask_irq':
   drivers/pci/controller/dwc/pcie-designware-host.c:38: undefined reference to `pci_msi_unmask_irq'
   ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_msi_mask_irq':
   drivers/pci/controller/dwc/pcie-designware-host.c:32: undefined reference to `pci_msi_mask_irq'
   ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_pcie_allocate_domains':
   drivers/pci/controller/dwc/pcie-designware-host.c:247: undefined reference to `pci_msi_create_irq_domain'
   ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_pcie_host_init':
   drivers/pci/controller/dwc/pcie-designware-host.c:360: undefined reference to `pci_msi_enabled'
   ld: drivers/pci/controller/dwc/pcie-designware-host.c:424: undefined reference to `pci_msi_enabled'
   ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_pcie_host_deinit':
   drivers/pci/controller/dwc/pcie-designware-host.c:434: undefined reference to `pci_msi_enabled'
   ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_pcie_setup_rc':
   drivers/pci/controller/dwc/pcie-designware-host.c:545: undefined reference to `pci_msi_enabled'
   ld: drivers/acpi/pci_root.o: in function `negotiate_os_control':
   drivers/acpi/pci_root.c:441: undefined reference to `pci_msi_enabled'
   ld: drivers/tty/serial/8250/8250_pci.o: in function `pci_alloc_irq_vectors':
   include/linux/pci.h:1803: undefined reference to `pci_alloc_irq_vectors_affinity'
   ld: drivers/tty/serial/8250/8250_pci.o: in function `pciserial_init_ports':
   drivers/tty/serial/8250/8250_pci.c:3961: undefined reference to `pci_irq_vector'
   ld: drivers/tty/serial/8250/8250_exar.o: in function `pci_alloc_irq_vectors':
   include/linux/pci.h:1803: undefined reference to `pci_alloc_irq_vectors_affinity'
   ld: drivers/tty/serial/8250/8250_exar.o: in function `exar_pci_probe':
   drivers/tty/serial/8250/8250_exar.c:618: undefined reference to `pci_irq_vector'
   ld: drivers/tty/serial/8250/8250_lpss.o: in function `lpss8250_remove':
   drivers/tty/serial/8250/8250_lpss.c:352: undefined reference to `pci_free_irq_vectors'
   ld: drivers/tty/serial/8250/8250_lpss.o: in function `qrk_serial_setup_dma':
   drivers/tty/serial/8250/8250_lpss.c:186: undefined reference to `pci_irq_vector'
   ld: drivers/tty/serial/8250/8250_lpss.o: in function `pci_alloc_irq_vectors':
   include/linux/pci.h:1803: undefined reference to `pci_alloc_irq_vectors_affinity'
   ld: drivers/tty/serial/8250/8250_lpss.o: in function `lpss8250_probe':
   drivers/tty/serial/8250/8250_lpss.c:305: undefined reference to `pci_irq_vector'
   ld: drivers/tty/serial/8250/8250_lpss.c:340: undefined reference to `pci_free_irq_vectors'
   ld: drivers/tty/serial/8250/8250_mid.o: in function `pci_alloc_irq_vectors':
   include/linux/pci.h:1803: undefined reference to `pci_alloc_irq_vectors_affinity'
   ld: drivers/tty/serial/8250/8250_mid.o: in function `dnv_setup':
   drivers/tty/serial/8250/8250_mid.c:171: undefined reference to `pci_irq_vector'
   ld: drivers/tty/serial/8250/8250_mid.c:174: undefined reference to `pci_irq_vector'
   ld: drivers/misc/mei/pci-me.o: in function `mei_me_pci_suspend':
>> drivers/misc/mei/pci-me.c:354: undefined reference to `pci_disable_msi'
   ld: drivers/misc/mei/pci-me.o: in function `mei_me_probe':
>> drivers/misc/mei/pci-me.c:211: undefined reference to `pci_enable_msi'
   ld: drivers/misc/mei/pci-me.o: in function `mei_me_pci_resume':
   drivers/misc/mei/pci-me.c:370: undefined reference to `pci_enable_msi'
   ld: drivers/misc/mei/pci-txe.o: in function `mei_txe_pci_suspend':
   drivers/misc/mei/pci-txe.c:231: undefined reference to `pci_disable_msi'
   ld: drivers/misc/mei/pci-txe.o: in function `mei_txe_probe':
   drivers/misc/mei/pci-txe.c:90: undefined reference to `pci_enable_msi'
   ld: drivers/misc/mei/pci-txe.o: in function `mei_txe_pci_resume':
   drivers/misc/mei/pci-txe.c:246: undefined reference to `pci_enable_msi'
   ld: drivers/thunderbolt/nhi.o: in function `ring_request_msix':
   drivers/thunderbolt/nhi.c:409: undefined reference to `pci_irq_vector'
   ld: drivers/thunderbolt/nhi.o: in function `pci_alloc_irq_vectors':
   include/linux/pci.h:1803: undefined reference to `pci_alloc_irq_vectors_affinity'
   ld: include/linux/pci.h:1803: undefined reference to `pci_alloc_irq_vectors_affinity'
   ld: drivers/thunderbolt/nhi.o: in function `nhi_init_msi':
   drivers/thunderbolt/nhi.c:1064: undefined reference to `pci_irq_vector'

vim +354 drivers/misc/mei/pci-me.c

c919951d940f28 Tomas Winkler     2014-05-13  149  
2703d4b2e673cc Tomas Winkler     2013-02-06  150  /**
ce23139c6c2ee9 Alexander Usyskin 2014-09-29  151   * mei_me_probe - Device Initialization Routine
2703d4b2e673cc Tomas Winkler     2013-02-06  152   *
2703d4b2e673cc Tomas Winkler     2013-02-06  153   * @pdev: PCI device structure
2703d4b2e673cc Tomas Winkler     2013-02-06  154   * @ent: entry in kcs_pci_tbl
2703d4b2e673cc Tomas Winkler     2013-02-06  155   *
a8605ea2c20c2b Alexander Usyskin 2014-09-29  156   * Return: 0 on success, <0 on failure.
2703d4b2e673cc Tomas Winkler     2013-02-06  157   */
b68301e9acd30f Tomas Winkler     2013-03-27  158  static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
2703d4b2e673cc Tomas Winkler     2013-02-06  159  {
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  160  	const struct mei_cfg *cfg;
2703d4b2e673cc Tomas Winkler     2013-02-06  161  	struct mei_device *dev;
52c34561415b42 Tomas Winkler     2013-02-06  162  	struct mei_me_hw *hw;
1fa55b4e0e161b Alexander Usyskin 2015-08-02  163  	unsigned int irqflags;
2703d4b2e673cc Tomas Winkler     2013-02-06  164  	int err;
2703d4b2e673cc Tomas Winkler     2013-02-06  165  
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  166  	cfg = mei_me_get_cfg(ent->driver_data);
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  167  	if (!cfg)
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  168  		return -ENODEV;
2703d4b2e673cc Tomas Winkler     2013-02-06  169  
c919951d940f28 Tomas Winkler     2014-05-13  170  	if (!mei_me_quirk_probe(pdev, cfg))
c919951d940f28 Tomas Winkler     2014-05-13  171  		return -ENODEV;
2703d4b2e673cc Tomas Winkler     2013-02-06  172  
2703d4b2e673cc Tomas Winkler     2013-02-06  173  	/* enable pci dev */
f8a096059fc5f7 Tomas Winkler     2017-01-26  174  	err = pcim_enable_device(pdev);
2703d4b2e673cc Tomas Winkler     2013-02-06  175  	if (err) {
2703d4b2e673cc Tomas Winkler     2013-02-06  176  		dev_err(&pdev->dev, "failed to enable pci device.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  177  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  178  	}
2703d4b2e673cc Tomas Winkler     2013-02-06  179  	/* set PCI host mastering  */
2703d4b2e673cc Tomas Winkler     2013-02-06  180  	pci_set_master(pdev);
f8a096059fc5f7 Tomas Winkler     2017-01-26  181  	/* pci request regions and mapping IO device memory for mei driver */
f8a096059fc5f7 Tomas Winkler     2017-01-26  182  	err = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
2703d4b2e673cc Tomas Winkler     2013-02-06  183  	if (err) {
2703d4b2e673cc Tomas Winkler     2013-02-06  184  		dev_err(&pdev->dev, "failed to get pci regions.\n");
f8a096059fc5f7 Tomas Winkler     2017-01-26  185  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  186  	}
3ecfb168a51ddf Tomas Winkler     2013-12-17  187  
3ecfb168a51ddf Tomas Winkler     2013-12-17  188  	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) ||
3ecfb168a51ddf Tomas Winkler     2013-12-17  189  	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
3ecfb168a51ddf Tomas Winkler     2013-12-17  190  
3ecfb168a51ddf Tomas Winkler     2013-12-17  191  		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
3ecfb168a51ddf Tomas Winkler     2013-12-17  192  		if (err)
3ecfb168a51ddf Tomas Winkler     2013-12-17  193  			err = dma_set_coherent_mask(&pdev->dev,
3ecfb168a51ddf Tomas Winkler     2013-12-17  194  						    DMA_BIT_MASK(32));
3ecfb168a51ddf Tomas Winkler     2013-12-17  195  	}
3ecfb168a51ddf Tomas Winkler     2013-12-17  196  	if (err) {
3ecfb168a51ddf Tomas Winkler     2013-12-17  197  		dev_err(&pdev->dev, "No usable DMA configuration, aborting\n");
f8a096059fc5f7 Tomas Winkler     2017-01-26  198  		goto end;
3ecfb168a51ddf Tomas Winkler     2013-12-17  199  	}
3ecfb168a51ddf Tomas Winkler     2013-12-17  200  
2703d4b2e673cc Tomas Winkler     2013-02-06  201  	/* allocates and initializes the mei dev structure */
907b471ca228a5 Tomas Winkler     2019-11-07  202  	dev = mei_me_dev_init(&pdev->dev, cfg);
2703d4b2e673cc Tomas Winkler     2013-02-06  203  	if (!dev) {
2703d4b2e673cc Tomas Winkler     2013-02-06  204  		err = -ENOMEM;
f8a096059fc5f7 Tomas Winkler     2017-01-26  205  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  206  	}
52c34561415b42 Tomas Winkler     2013-02-06  207  	hw = to_me_hw(dev);
f8a096059fc5f7 Tomas Winkler     2017-01-26  208  	hw->mem_addr = pcim_iomap_table(pdev)[0];
261e071acd9bcb Tomas Winkler     2019-11-07  209  	hw->read_fws = mei_me_read_fws;
f8a096059fc5f7 Tomas Winkler     2017-01-26  210  
2703d4b2e673cc Tomas Winkler     2013-02-06 @211  	pci_enable_msi(pdev);
2703d4b2e673cc Tomas Winkler     2013-02-06  212  
fec874a81b3ec2 Benjamin Lee      2020-04-17  213  	hw->irq = pdev->irq;
fec874a81b3ec2 Benjamin Lee      2020-04-17  214  
2703d4b2e673cc Tomas Winkler     2013-02-06  215  	 /* request and enable interrupt */
1fa55b4e0e161b Alexander Usyskin 2015-08-02  216  	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;
1fa55b4e0e161b Alexander Usyskin 2015-08-02  217  
2703d4b2e673cc Tomas Winkler     2013-02-06  218  	err = request_threaded_irq(pdev->irq,
06ecd645980096 Tomas Winkler     2013-02-06  219  			mei_me_irq_quick_handler,
06ecd645980096 Tomas Winkler     2013-02-06  220  			mei_me_irq_thread_handler,
1fa55b4e0e161b Alexander Usyskin 2015-08-02  221  			irqflags, KBUILD_MODNAME, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  222  	if (err) {
2703d4b2e673cc Tomas Winkler     2013-02-06  223  		dev_err(&pdev->dev, "request_threaded_irq failure. irq = %d\n",
2703d4b2e673cc Tomas Winkler     2013-02-06  224  		       pdev->irq);
f8a096059fc5f7 Tomas Winkler     2017-01-26  225  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  226  	}
2703d4b2e673cc Tomas Winkler     2013-02-06  227  
c4d589be4405d4 Tomas Winkler     2013-03-27  228  	if (mei_start(dev)) {
2703d4b2e673cc Tomas Winkler     2013-02-06  229  		dev_err(&pdev->dev, "init hw failure.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  230  		err = -ENODEV;
2703d4b2e673cc Tomas Winkler     2013-02-06  231  		goto release_irq;
2703d4b2e673cc Tomas Winkler     2013-02-06  232  	}
2703d4b2e673cc Tomas Winkler     2013-02-06  233  
180ea05bcedbd6 Tomas Winkler     2014-03-18  234  	pm_runtime_set_autosuspend_delay(&pdev->dev, MEI_ME_RPM_TIMEOUT);
180ea05bcedbd6 Tomas Winkler     2014-03-18  235  	pm_runtime_use_autosuspend(&pdev->dev);
180ea05bcedbd6 Tomas Winkler     2014-03-18  236  
f3d8e8788b4efb Alexander Usyskin 2014-06-23  237  	err = mei_register(dev, &pdev->dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  238  	if (err)
1f7e489a285c8b Alexander Usyskin 2016-02-07  239  		goto stop;
2703d4b2e673cc Tomas Winkler     2013-02-06  240  
2703d4b2e673cc Tomas Winkler     2013-02-06  241  	pci_set_drvdata(pdev, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  242  
557909e195aea2 Alexander Usyskin 2017-08-03  243  	/*
557909e195aea2 Alexander Usyskin 2017-08-03  244  	 * MEI requires to resume from runtime suspend mode
557909e195aea2 Alexander Usyskin 2017-08-03  245  	 * in order to perform link reset flow upon system suspend.
557909e195aea2 Alexander Usyskin 2017-08-03  246  	 */
e07515563d010d Rafael J. Wysocki 2020-04-18  247  	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
557909e195aea2 Alexander Usyskin 2017-08-03  248  
e13fa90ce42d8e Tomas Winkler     2014-03-18  249  	/*
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  250  	 * ME maps runtime suspend/resume to D0i states,
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  251  	 * hence we need to go around native PCI runtime service which
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  252  	 * eventually brings the device into D3cold/hot state,
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  253  	 * but the mei device cannot wake up from D3 unlike from D0i3.
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  254  	 * To get around the PCI device native runtime pm,
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  255  	 * ME uses runtime pm domain handlers which take precedence
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  256  	 * over the driver's pm handlers.
e13fa90ce42d8e Tomas Winkler     2014-03-18  257  	 */
e13fa90ce42d8e Tomas Winkler     2014-03-18  258  	mei_me_set_pm_domain(dev);
e13fa90ce42d8e Tomas Winkler     2014-03-18  259  
cc365dcf0e5627 Tomas Winkler     2018-01-02  260  	if (mei_pg_is_enabled(dev)) {
180ea05bcedbd6 Tomas Winkler     2014-03-18  261  		pm_runtime_put_noidle(&pdev->dev);
cc365dcf0e5627 Tomas Winkler     2018-01-02  262  		if (hw->d0i3_supported)
cc365dcf0e5627 Tomas Winkler     2018-01-02  263  			pm_runtime_allow(&pdev->dev);
cc365dcf0e5627 Tomas Winkler     2018-01-02  264  	}
180ea05bcedbd6 Tomas Winkler     2014-03-18  265  
c4e87b525936da Alexander Usyskin 2013-10-21  266  	dev_dbg(&pdev->dev, "initialization successful.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  267  
2703d4b2e673cc Tomas Winkler     2013-02-06  268  	return 0;
2703d4b2e673cc Tomas Winkler     2013-02-06  269  
1f7e489a285c8b Alexander Usyskin 2016-02-07  270  stop:
1f7e489a285c8b Alexander Usyskin 2016-02-07  271  	mei_stop(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  272  release_irq:
dc844b0d99b853 Tomas Winkler     2013-11-11  273  	mei_cancel_work(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  274  	mei_disable_interrupts(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  275  	free_irq(pdev->irq, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  276  end:
2703d4b2e673cc Tomas Winkler     2013-02-06  277  	dev_err(&pdev->dev, "initialization failed.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  278  	return err;
2703d4b2e673cc Tomas Winkler     2013-02-06  279  }
2703d4b2e673cc Tomas Winkler     2013-02-06  280  
5c4c0106e94493 Tomas Winkler     2017-03-20  281  /**
5c4c0106e94493 Tomas Winkler     2017-03-20  282   * mei_me_shutdown - Device Removal Routine
5c4c0106e94493 Tomas Winkler     2017-03-20  283   *
5c4c0106e94493 Tomas Winkler     2017-03-20  284   * @pdev: PCI device structure
5c4c0106e94493 Tomas Winkler     2017-03-20  285   *
5c4c0106e94493 Tomas Winkler     2017-03-20  286   * mei_me_shutdown is called from the reboot notifier
5c4c0106e94493 Tomas Winkler     2017-03-20  287   * it's a simplified version of remove so we go down
5c4c0106e94493 Tomas Winkler     2017-03-20  288   * faster.
5c4c0106e94493 Tomas Winkler     2017-03-20  289   */
5c4c0106e94493 Tomas Winkler     2017-03-20  290  static void mei_me_shutdown(struct pci_dev *pdev)
5c4c0106e94493 Tomas Winkler     2017-03-20  291  {
5c4c0106e94493 Tomas Winkler     2017-03-20  292  	struct mei_device *dev;
5c4c0106e94493 Tomas Winkler     2017-03-20  293  
5c4c0106e94493 Tomas Winkler     2017-03-20  294  	dev = pci_get_drvdata(pdev);
5c4c0106e94493 Tomas Winkler     2017-03-20  295  	if (!dev)
5c4c0106e94493 Tomas Winkler     2017-03-20  296  		return;
5c4c0106e94493 Tomas Winkler     2017-03-20  297  
5c4c0106e94493 Tomas Winkler     2017-03-20  298  	dev_dbg(&pdev->dev, "shutdown\n");
5c4c0106e94493 Tomas Winkler     2017-03-20  299  	mei_stop(dev);
5c4c0106e94493 Tomas Winkler     2017-03-20  300  
5c4c0106e94493 Tomas Winkler     2017-03-20  301  	mei_me_unset_pm_domain(dev);
5c4c0106e94493 Tomas Winkler     2017-03-20  302  
5c4c0106e94493 Tomas Winkler     2017-03-20  303  	mei_disable_interrupts(dev);
5c4c0106e94493 Tomas Winkler     2017-03-20  304  	free_irq(pdev->irq, dev);
5c4c0106e94493 Tomas Winkler     2017-03-20  305  }
5c4c0106e94493 Tomas Winkler     2017-03-20  306  
2703d4b2e673cc Tomas Winkler     2013-02-06  307  /**
ce23139c6c2ee9 Alexander Usyskin 2014-09-29  308   * mei_me_remove - Device Removal Routine
2703d4b2e673cc Tomas Winkler     2013-02-06  309   *
2703d4b2e673cc Tomas Winkler     2013-02-06  310   * @pdev: PCI device structure
2703d4b2e673cc Tomas Winkler     2013-02-06  311   *
5c4c0106e94493 Tomas Winkler     2017-03-20  312   * mei_me_remove is called by the PCI subsystem to alert the driver
2703d4b2e673cc Tomas Winkler     2013-02-06  313   * that it should release a PCI device.
2703d4b2e673cc Tomas Winkler     2013-02-06  314   */
b68301e9acd30f Tomas Winkler     2013-03-27  315  static void mei_me_remove(struct pci_dev *pdev)
2703d4b2e673cc Tomas Winkler     2013-02-06  316  {
2703d4b2e673cc Tomas Winkler     2013-02-06  317  	struct mei_device *dev;
2703d4b2e673cc Tomas Winkler     2013-02-06  318  
2703d4b2e673cc Tomas Winkler     2013-02-06  319  	dev = pci_get_drvdata(pdev);
2703d4b2e673cc Tomas Winkler     2013-02-06  320  	if (!dev)
2703d4b2e673cc Tomas Winkler     2013-02-06  321  		return;
2703d4b2e673cc Tomas Winkler     2013-02-06  322  
180ea05bcedbd6 Tomas Winkler     2014-03-18  323  	if (mei_pg_is_enabled(dev))
180ea05bcedbd6 Tomas Winkler     2014-03-18  324  		pm_runtime_get_noresume(&pdev->dev);
180ea05bcedbd6 Tomas Winkler     2014-03-18  325  
ed6f7ac1dcae0b Paul Bolle        2013-10-17  326  	dev_dbg(&pdev->dev, "stop\n");
7cb035d9e619a8 Tomas Winkler     2013-03-10  327  	mei_stop(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  328  
e13fa90ce42d8e Tomas Winkler     2014-03-18  329  	mei_me_unset_pm_domain(dev);
e13fa90ce42d8e Tomas Winkler     2014-03-18  330  
2703d4b2e673cc Tomas Winkler     2013-02-06  331  	mei_disable_interrupts(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  332  
2703d4b2e673cc Tomas Winkler     2013-02-06  333  	free_irq(pdev->irq, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  334  
30e53bb8ffb1f3 Tomas Winkler     2013-04-05  335  	mei_deregister(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  336  }
f8a096059fc5f7 Tomas Winkler     2017-01-26  337  
16833257a1ee9f Alexander Usyskin 2014-02-18  338  #ifdef CONFIG_PM_SLEEP
b68301e9acd30f Tomas Winkler     2013-03-27  339  static int mei_me_pci_suspend(struct device *device)
2703d4b2e673cc Tomas Winkler     2013-02-06  340  {
2703d4b2e673cc Tomas Winkler     2013-02-06  341  	struct pci_dev *pdev = to_pci_dev(device);
2703d4b2e673cc Tomas Winkler     2013-02-06  342  	struct mei_device *dev = pci_get_drvdata(pdev);
2703d4b2e673cc Tomas Winkler     2013-02-06  343  
2703d4b2e673cc Tomas Winkler     2013-02-06  344  	if (!dev)
2703d4b2e673cc Tomas Winkler     2013-02-06  345  		return -ENODEV;
2703d4b2e673cc Tomas Winkler     2013-02-06  346  
ed6f7ac1dcae0b Paul Bolle        2013-10-17  347  	dev_dbg(&pdev->dev, "suspend\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  348  
7cb035d9e619a8 Tomas Winkler     2013-03-10  349  	mei_stop(dev);
7cb035d9e619a8 Tomas Winkler     2013-03-10  350  
7cb035d9e619a8 Tomas Winkler     2013-03-10  351  	mei_disable_interrupts(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  352  
2703d4b2e673cc Tomas Winkler     2013-02-06  353  	free_irq(pdev->irq, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06 @354  	pci_disable_msi(pdev);
2703d4b2e673cc Tomas Winkler     2013-02-06  355  
7cb035d9e619a8 Tomas Winkler     2013-03-10  356  	return 0;
2703d4b2e673cc Tomas Winkler     2013-02-06  357  }
2703d4b2e673cc Tomas Winkler     2013-02-06  358  

:::::: The code at line 354 was first introduced by commit
:::::: 2703d4b2e673cc240ad06d79d131fd1d0f77d65d mei: sperate interface and pci code into two files

:::::: TO: Tomas Winkler <tomas.winkler@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICLEzyl8AAy5jb25maWcAjFxLd+M2z973V/hMN+2ifXObdHq+kwUtUTZrUVRJyrGz0Ukz
njank6RvLm87//4DSF1ICvK0i2lMgHcQeACC+vabbxfs7fXp4fb1/u728+cvi98Pj4fn29fD
x8Wn+8+H/1vkalEpu+C5sD8Cc3n/+PbPf+7PP1wu3v94evLjyQ/Pd+eLzeH58fB5kT09frr/
/Q2q3z89fvPtN5mqCrFqs6zdcm2EqlrLd/bq3e93dz/8vPguP/x2f/u4+PnHc2jm9P33/q93
QTVh2lWWXX3pi1ZjU1c/n5yfnPSEMh/Kz87fn7j/hnZKVq0G8knQ/JqZlhnZrpRVYycBQVSl
qPhIEvrX9lrpzViybESZWyF5a9my5K1R2o5Uu9ac5dBMoeAfYDFYFVbm28XKrfPnxcvh9e2v
ca2WWm141cJSGVkHHVfCtrzatkzDZIUU9ur8DFrph6xkLaB3y41d3L8sHp9eseFhdVTGyn4B
3r2jilvWhGvgptUaVtqAf822vN1wXfGyXd2IYHghZQmUM5pU3khGU3Y3czXUHOGCJtwYmwNl
WJpgvOHKpHQ3amLp4pGntXY3x9qEwR8nXxwj40SIAeW8YE1pnUQEe9MXr5WxFZP86t13j0+P
h+8HBrM3W1EHZ6krwP9ntgwnVysjdq38teENJ0d4zWy2bif0Xhi1MqaVXCq9b5m1LFuHrTeG
l2JJtssa0DJEi25/mYY+HQeOmJVlf5LgUC5e3n57+fLyengYT9KKV1yLzJ3ZWqtlcIxDklmr
a5oiql94ZvHIBIKmcyCZ1ly3mhte5XTVbB2eDizJlWSiisuMkBRTuxZc42z308alEcg5S5j0
E45KMqthY2Hp4OBbpWkunJfeMpx4K1WeaL9C6YznnWIT1SqQp5ppw+nRuZHxZbMqjBOFw+PH
xdOnZOdGfa2yjVENdOQlLVdBN04MQhZ3EL5QlbesFDmzvC2ZsW22z0pCBpzu3o4ilZBde3zL
K2uOElFxszyDjo6zSdhflv/SkHxSmbapcciJbvMnMqsbN1xtnCXpLZE7BPb+4fD8Qp0DK7IN
2BMOgh70Wal2fYN2Qzr5Ho4gFNYwGJWLjDiIvpbIw4V0ZcF4xWqNMtSNNNzuyRgDlaM5l7WF
xipKpfTkrSqbyjK9j9SVJx6plimo1a8UrOJ/7O3Ln4tXGM7iFob28nr7+rK4vbt7ent8vX/8
PVk7XHaWuTa8wA89o1g7+RnJpF5bmhxVUMZBLwKrJZlwS41l1lATMSKaMRz2XuHnwiDwyOM2
uxX/F3N1a6KzZmEo0an2LdDG3YUfLd+BhASiZCIOVycpwpm5qp2kE6RJUZNzqtxqlvWEeOlG
UutAl1ySSxJPdVBtG/9HoOw2gxCpLNr0zRqaB9EmgRZCpwKMiijs1dnJKIiishvAUwVPeE7P
o4PeVKbDkdka1KzTHL3gmrs/Dh/fPh+eF58Ot69vz4cXV9zNi6BGKvOaVbZdojqFdptKsrq1
5bItysasA/W50qqpA1VXsxX354frcBXAvGe0sPsm/AQodODJtchN2F5XrHPJjrVawIm+4Xq+
3XWz4jCvdEZwXLYi40SPcERmj2Q/Vq6L+R6dXQsbRvgFxhBOO93ommebWoFAoJoEM0xjLC8A
iMpdNzTP3hQGBgB6Dgw6udyalyzAEctyg0vhjKYOwIv7zSS05m1ngCx1noB9KOgx/jASKEOI
TA0gj8C9Y1STqjQSBlKKgkedqhQqdvybXuasVTUoZ3HDEbS4TVRasiojMWvCbeCPCCp7iBwd
VZGfXqY8oBwzXjvs5NRRasczU29gLCWzOJhgX+pi/JEq2KQnCWpfAIoO8JsBoZcICUYckwhJ
RyCmXqxZ5Q164gB4A06aVdRmgY7w2q2SInQgozORTJzeUQbwsWjoQTaW78bW3U/QIcGa1SqE
b0asKlYWgYS72RSRa+ggWUGdGrMG/RZgThFJrFBto+dsPcu3AubRrTe1fND0kmktwg3cIO9e
mmlJG8HSodQtFh5uK7bR3oEkUZsd0UFflIBWSToKlkMW5MI4U4LRkXES0FsF2BX0WHSqDf+V
qA+1eJ7zPD0X0Gebouw6Oz256I1fF2GqD8+fnp4fbh/vDgv+v8MjYBkG9i9DNAPYcoQucYvD
sJyy9kSYaLuVzhkigcK/7LHvcCt9d72xjLo1ZbP0fdO6SsmagXXWG1rNl2xJCSk0GneiaLca
68OGabDkHWqcZ0MDWwpwlzRoBSXJbkM29IgB1EXnyqybogAM47DD4G1STe2N5bIFh4dhfE4U
ImOxww3gqxBlD7u7nYlDZz3r7sNlex4EnuB3aN+M1Y3z5mENMnBrg8OnGls3tnXmwV69O3z+
dH72A4Y4w0jZBsxsa5q6jgJ8gNayjQeeE5qUAXp1B0ci6tIV2E/hXcGrD8fobHd1ekkz9BLz
lXYitqi5wTM3rM3DqFxP8Ao8apXteyvWFnk2rQI6Ryw1Otx5jDoGrYGuFCqtHUVjgHhajLcm
1nfgAEmAg9XWK5AKm2gQw61Hat5dAw8g8FA5IKme5DQQNKUxJLBuqs0MnxNeks2PRyy5rnyU
BMylEcsyHbJpTM1hE2bIDpC7pWPlFLZ2LTiRMr3agiG54zTH1rg4V6BCCzDjnOlyn2EwJzRp
9cr7GSUordJcDV5IF/w2DLcBhRvXmmc+WuQ0cf38dHd4eXl6Xrx++cs7lZE/0jV0A558O4fm
jawJdYAnuODMNpp7EB0d5lbWLsIUyJ0q80KE7ovmFnBAFLLHml7sAJ/pMibwnYUdwl0fEdkw
SGTouyBngQyAfDCUWxsa7CMLk2P7nR9CTF4oU4DPKq4eQqDhy46YDuxA59n52eluZkUH6egi
sgUTZaOTFTo/a4UWJuzcOyBKCtCM4BpgEAonS+nx9R5ODcAeAM6rhoehLdgxthVOK45YsCub
zioY0HqL6qRcggSCaejkb5w1r6hYPdjgpH8fLawbDFmBYJc2hon1dk2O7EhQJ2XtXfTRM774
cGl25GYhiSa8P0KwJpulSTnT0+Vcg6CSwHuQQnyFfJxOAYOedhGtxmZmHJufZso/0OWZboyi
XWXJC0AOXFU09VpUGI/PZgbSkc9pOCzBWs20u+IAI1a70yPUtpzZnmyvxW52kbeCZeft2Txx
Zu0QhM/UAgRGe11Oy3kDPnMU3amvcDbeRPvA1U8hS3k6T/MaEt2KTNX7WO0gBq/BwvigiGlk
TAbJTxS5rHfZenV5kRarbWIrRCVkI53mL5gU5f7qMqQ71QP+ujQBDhQM1CAaoDby9pF/K3cT
0xQEoF1oF8MGvOQZFYnGcYAi9osRBKe6YicOEXrtKWA8poXr/SoEyUMrcP5Yo6cEAKiVkRxQ
NtVFIzOy/GbN1C68S1rX3KvGSBfnUhATrhyKMuhGAI5a8hU0dEoT8RZtQuoclQlhLIARlog1
4/sfJ1WwbLXIUluOy6+QMCPn7jq8rxkKsCKb01yD4+DDRd2tvYtJ4f3gTA8yjkB2RRgQLvmK
Zfv5aoPgpJVRQOaRR5UJdEkliTj6FvAuz6wB6FDN+0vQmdp2zcFlKkcD7QFi4DE/PD3evz49
R5cqgWveK4fKhQ8e5jk0q0OzPaFneHPCaQ6Hv9R1J7WdDzkzyHgB/K7A4Y+NacBxerlMpY+b
GmB34omCENUl/sPDqJ9VoC+XbJy4+LCZihlKFbTY1GQwSWSgfaJr2qFoKjQjKRGbCR3EwSv+
IopiOrEwOh2kQ1ikGFYKLwQBepLUjnZBIayOdnkRBRK30tQlQNJzqkpPPCOrnNI4DjSQKgrw
H69O/vlwEqcOdWOI51+zySnOaobekhXGiozaJodDC9BX0BooPEZ4i865mSc7y9JjeLyXD86D
KFFSyx6h48V3w69O4nWuLY2e3PjR/LZL8DcwkKcbF8GeEXmfH4D3WNdXlxeBbFmtyQ7c+Kfh
pGgARrI5jxDAaJ2utz/01uzcSuD+HcEuIWP1lZbwvoUcJC9orLa+aU9PTuZIZ+9nSedxrai5
k8Dm3lydBgLpnbK1xovpICrMdzyyT5lmZt3mDelm1+u9EWjqQGI1Sv1pJ/Rj8Ja7mB2K4bH6
rBSrCuqfJdW7qNM2N/RaZjJ3YR5QbFSsHzZCFPu2zG10ndEr7iPhh+jE+GPUn5i1snU5CWl1
PF4/1GgnbHjjWj/9fXhegJG4/f3wcHh8db2xrBaLp78wxTGIN3fBniAy2EV/uhvLKD7akcxG
1C56Ti2ybE3JeST5UIby6crJhQWGa7bhLgWGbDNpbc4BB1JWhhc8cojx+fyiIDJz/as3rq1z
whzc6LHbkfrD5OY5VJGqwD6QgTsQ0Ca/ervtBNiAolKbpk4ak6ARbZdYhlXqMKDpSrrgtJ+c
gxcmiPGO2g153UKuyNiIb6vOtB9O2km8DK5M822rtlxrkfMweBh3ybM+o2quU5bOaMksWId9
WtpYG3oTrnALfasRl7iyglWTUdiZWyS/KiCHc4NzjpnmIDzGJH2P7lSK6hJynIcUEycjFbWk
NXjSKFutNIgPfWHh5+xRLxGg7pYEVUpTrzTL0+GlNEKKjowxQ3lR9OWNX1QFDiBo1tmhd1qw
84MmAzBLOorp66Y5RlHPjbFKgrK1a3WETfO8wfRBvDW6ZhoNckl5PeO5ZDUPTndc3t04x10g
4YhI1rY4un7wd0EvAsgPJgmAcMxjI1BjE//YFJR/7NwzYEdwHwhJLaMfLRhY8Ixc9GRqYpAh
VyNeHCdT+8gHHhB6tlhTgNlj+3ZZsoo8pmhuSkB5iJHM1Zg9tyieD/99OzzefVm83N1+jny7
/ljH0QR30Fdqi9nAGCSxM+RpOuJARk1Ag4meo0+Iw4a+kuxBVkE9b1h8mU5y4ma4/J5/Px5V
5RxGQ58MsgbQujTc7dEpJLOdWdhwchR9mFJ4ARBxUDOgt3Ac99XDKDOfUplZfHy+/190ZQ9s
fhli8ejK3BVKzrc0gK+dpZh1L+os65uaD5Z0ZillCpvBZazgRGwu02GMpJ9mKq927gQDug0X
2Tk/Nec5gA0fwdOiomFzzCqy9UxHI4+RYrThbpQX/r7CDyJyYP06Vy6/+yydXamqlW7oOHhP
X4PszjLwUQQj4+Tk4+WP2+fDxymmjidTiuX8wrlLZUyYZLV3ZsmUDlp5DTIqPn4+xKosRhh9
iRP0kuVREkFElLxqUj0yEC2fcYtCpv6uijSOntTfa4Xe0TCN4BLRHZCpKej9qa/6OG59lm8v
fcHiO0Aii8Pr3Y/fhxe+CE9WCmMIlEfhiFL6n5Eb4ii50HwmCdMzsIrCCUjzVQNXAsrmOsqq
5dkJrPCvjdCUzcNsiGUTANIuPQIDwFFh4Odl6P+Op8n/XusOCIwQuhS7cDgVt+/fn5xShhf8
0CpIBXCSvjfFMtzomf3we3X/ePv8ZcEf3j7fJkeqc83Pz6K2Jvwx3gJkh5ki4JfVPQwo7p8f
/oZTu8hTLc7zSL/BzzQ8M9AKoaVDgeCj0/Gf4rrNii6FcVyQsLQPJoRZAWpV8qHxcM07Egab
Xah+LsLBCzGkTfQztoffn28Xn/p5e+sVJmDPMPTkyYpFa7zZBsAP75UbkJebPhlqmACwUQID
nsd29/40CDljCseanbaVSMvO3l+mpbZmjcuriB4m3j7f/XH/erjD0MoPHw9/wTxQPUy0tI81
dfl//TgxIJWU9f49mrjAB1U+xYtPS7p8OpfuWpdh+qdbsiMVwS8YcHg/ojQ15pdG4gXSMoyj
uhBuBqPfGwy4FjbKJeioGJAiqKq2aRdumGNYpKlcwAyzujN0NhMHEu9C8dmlFVW7NNcsCAts
MK+FalzACmOuF5EQNZmwL51raW74XTP4ILWgMpqLpvJZdVxrdMmpN3NbHucGj8/5XItrpTYJ
EVUuOrNi1aiGeHhlYO+cqfTv0AhXHHCMxShil84+ZQAvpIsNzhC9XWklS9+5+pH7l70+q7C9
Xgvr8iGTtjDHy7T5vmKoQd2jLV8j4Ts/WwqLerJNtxFfIQNa617pprsDziicfQwlYqpWJ1ex
sfJ8JnTJ4o3DF8WzFdfX7RIm6t8rJDQpEHGNZOOGkzA5zxWErtFVWynYkijtOU3+JeQEQwUI
Wd1LC5+J5mpQjRD996m+ulsijIlT+0mpA4oa5lx3bFI27YphVKiL72DIlyTj2ySKpZM7f078
K6Eu0yEdTKdAOrHDy6uEo6vnL7NnaLlqZtIR8T2wf8bZvxYnFsPwDGHEEVKXqRlFQTxlNtbj
auMOlSBOSdOTPMRRIf+LclwsVU1W0s1Z2DVoWy8ZLsltomCnL/zSU6BQymSa0d6rtwrv9VD7
Y4YnsV9+64GGuehpkNrtiSPi3QQYb51WB9XQXx/yDPOnA7lTeYPhb7QrYK1QcAlN5yjubi7K
uR3HFuUkp7ZtB1qLVMFxrSE7ucPXsaIBjxQvg2APAK/lQR94B23Eqot7nU8ILLE0A7hFZYq7
Rml28K/h5HRv7PX1LhSbWVJa3a8tWZ0ijauJLy/Oz/oLtlijDygAzFJk1odDhHowfGUwe9Pc
vdAArJXpfT3JlR6BzAD6MrX94bfbF3DD//TvHv56fvp03wX3RgANbN0CHevasfVgLLm/O9ZT
NEr81gcGq/1t0yT5/yvwtG9KI4C0AEeDhXZvZww+/RizibptM+he+HcA6UFKC/xT+BYf0oR7
1BGbavaFTWDO5+huKDobvs1BxgHGIU+G1k0jBD4BJXpRFJSjx0BMpSOdndGP9BKu9zNplhHX
+Yd/0xZ4NEenjbK2vnr38sft6btJG6gMNJ9Jy+54fHhbCmNAr4/vNlsh3UUjWbWp4IiC+tnL
pSKfd4EakD3XJn7TFZYGmHF8a9nrbAvwYLy3HPpeljM3aqY6DXvxn60BmwDGDQUxS18vjFep
3rcHV5nQQ+4DH7lrxl0pz7Poa4oBVUEF4ouXmSWra1xklue4K62PNhMKtn9M1i550V99xJ+h
CHhddkB7raHxEFaOd+5OefF/Dndvr7e/fT64bxotXOLXa+DCLkVVSIu2cGwDfsT+a8dkMi1C
jdoVgxBlUfBc4V2XrMmY29yA3Gjl4eHp+ctCjhG5abLBsWSgPstIsqph8UvQIcXI06iAi68c
t9a65F9fL4AoY3PeoKQOBn50YxVevHfjFUaVyTOvLgHDJV/4NM+LyKgnht4lbWmOIhwBMilW
mqWYAL3INnk2gyksThRb215eRCl8Pv9fxWFAxPBT72VjgoXqL28c8vFf+cj11cXJz5f0yZt7
jTEpH5OGrsHNMnCepjmZAw+FOKns3PCl0yaYRQbwu3Kp3GHPGfmy+6ZWqgxl/mbZ0Bbv5rwA
yEaTzPQJZg82+oARRuL6UEc4LBcBcLKAcYQN/VBj64BUEYXRYOYuyTn92saIc8DbXAJ4WktG
xomRvuIosS4PzuXXEQoKyQ6YswgCzZ/wcX+Gz5VUh9e/n57/xBuzUQ+MM4F5cyo9F4xAAEDx
F2iuKP/HleWC0RkHtpx50FRo6XQyne3JET9TkXrhpzTuXe0De/jFHLIpYGD5Fu80wbxgojWV
1ABMdRV+acn9bvN1ViedYTHGfOnEqY5BM03TcV6invmCmCeuND57lA31DMtztLapKp68za9A
Q6mNmPlWhK+4tXRGA1IL1Ryjjd3SHeC2tIx+3uZogIjmiaKe8ekddZhuWIgClxTZrO6L4+ab
vJ4XUMeh2fVXOJAK+4IxgD0t6NA7/LkapI2CdD1P1ixDO9fr/J5+9e7u7bf7u3dx6zJ/bwSl
mmBnL2Mx3V52so6OIn1p4pj8tyow2bjNZ7wMnP3lsa29PLq3l8TmxmOQoqahvqMmMhuSjLCT
WUNZe6mptXfkKgd45WCI3dd8Uvv/OXuWJbdxJH+ljj2HiRWp96EPEAlJsPgyAUmULwq3XTtT
EW5XR7l6p/vvNxOARABMiN49tLuETIB4JvINs9MedNWaEKxH4ANEPftxuOS7xbU4j31Po8Hd
QcftmWVuiscNlQ3sndjRxsxfqFILr6cBDjA6WhMCV13ZxFJWALJR2JHQTfMACOQlzyL9ROfW
LEJw25xeBVgmetKALSXLizTyhU0rcpL3MXpWJA3SS+loi8jGTgWrrqtJmtDuIznPKk5fY0WR
0RF5TLGCXrsundNNsYbO79Ds69jnF8CdNJEARsE5xzHNaVkc52OQxKkfckalpMgrNAIAf3/S
pu9+MWD5GLLEJ7KxuuHVSZ6FymhydZKYQC/Cq0E/Qdo9xO+BsolcfjjCKhLbvZdxDsf0NOf0
YBCjmIKoJJGOx7A+tir+gSqT9I1vU04hTtOKiBtJj5MVTEpBUVV9eXYo5Fyufkj05qPHoWC6
mA9+Uk6XLX16f/7xHigJde8OaseDbWe530HNAOByus56sLJleWzIkR2+ifjKbmHsbYzQbK+H
jLKyn0ULYrf0s5Ztd3iCksH03AHfn5+//nh6f3367RnGiSL/VxT3n+By0Ai9UH8rQbFEa7Yw
Y4dJheHEVpwFlNIkdXsQpJ4Q12PtMMnmtxZ0/bxGFvAgTw0TNFOS8WZ/jWV1rbb0TDcS7qSI
g6rmLrc0jLo2b/QHs3VY6fUmqmF0MS8K138EZOv65DrncLVXIMzeaElo5rCH4CaS5c//8/KF
cH0xyMK/VvB37BZqMscMEv5wQi1cHyat9YBzS3tDcSZdF+JbiROS4bWlYXfPvJj7lYOG+ouf
Qn7ogItoIBz7HcUUtoMCMqctwrQHVzg3D7YuQluTPeUW9RON9dKO9upIXXAIwgRbAHXCVaGQ
+ZmrhLbVILmwTuU+UNSnsOtAz6OdaRhNxfV3rM3aWwNtZINTEguNu+NE9oWGoR06usoaI7LK
FCJvU/yHOgk2JsHs/57g98XaNZe+pR2kDL3gxpDk3if7JswLKn55/f7+9voN82f2jsneImwV
/BuL9UMETL1NpVLwp6PDdFbdoA/584+Xf30/o4MYdid7hT/kn3/88fr27kROYwP52T/fUKA/
PVhDKEefaQ2M9+eGxclQQcQwDqS7c7hjQaoIU27Ym/zRYIyO+/U3mOOXbwh+Dgfb68niWGZx
Pn99xvhtDe4XEDMMUxOXsZx7LvJu6W0KKRDOzwMQPfseRixeD2bxwzJN+MM1sihhGzeP39FJ
uHv60tv8fgT4969/vL5896cNszPcnH+8Tt3KR4JmEBMIZvgwgdep+4fvXfnxn5f3L/+mD6VL
pM+WF1fcGF+cRuNN9C1krM1dMl5mgrliiynRJt5rJiLpXKGN4Dq2w/jnl89vX59+e3v5+i8/
NdYF83RQpy1fLNO1lwBqlU7WtPwIoOliTrSiMpGFgwoT4Juho3EuNN20rBHAZvcN2IKr1sCg
KqE+ql+nbrCwRbC3KkgVqrsO7KdhayWDCjvPcfcO417uub79Y4mme3d0Nxgq6qthsTbjXjOM
GrGhKO3nP16+ghQhze4Y7KpbTSXFfNkRH2rktevcJXJrLFYPhoxV4XZIqcptp2FT8ohE+tw7
6758sbzoUz20EByNv8ieFw15/cLkqLLZBlkyTdm1RC8TohLsmipn6LfjkYXWfOvu161fERmc
jLsn9LdXoF1v/eRvz/qoeZbcW5G28+SYONsx0XaqZb2jd29G72tpzz8zdqpRBwxSgUk35o6o
x6TcCXqk3mIWenvbMd5NQ9rjADMw3wzE/rxjmr+8FafIUmkwP7VcDqshibV1gdNFtzRaw4Zo
TJvZLbKmDcTn7mkdMaEi8MqRRzQQfDoWmMdwA7yNEq6rTMt3ns3Y/L6K1D3EpqwsRT1EdF+T
sGUSNmWO0njfBJIT7R6nd8g2TFAEm0TfxdrdmDxjkXN0D335qkU+72BJgdIrhnwG5L9XPO3F
EObEb9wadS6TGgTbjI493lVS9iPGX1fYvWha9AtLTDRPAaRotz3k/k0NO246C6JHQj9Fo5yL
Q4fr9xq9LdoXVeQ9IoCiX4HynGCh0Fh6SdCh3nzwCqxTtVdmnUu8Mm8Hwe/KjT6tt7d0Jrmf
HtMAUI/plRlPltBj3MklYPxnwxwBtoi68l3rpTZd6rMMrLUEenePum3eXt9fv7x+8zagkAxq
0GxX1cQCsarGJkwwarxTySnW2ys3LPvLjy/OMbiNP5+n8+4KrKBy95RTjGed2jvHsrzYxelH
tCnR4Z3q9p5Vqi77Ha3EtgwCTHTRsusSJ59SJtfTVM4mThlQgqKWmMgNF15k3DlVe6A4hZv3
oMnlejVJWeGlxhSySNeTyZRmzDQwpbK7SF7JGl9vAZT53A0as4DNPlkuJ14WTgvRPVlPKOvy
vswW03nqUEOZLFapz8juYQqPkfTQLaNtKx6bHznKRpy9ynzLXd9jZBaBA3Q4qObUsMrl3fZC
gswsDvwC17AX2pml4WkxblwcbqDSEe56HZuGXJmKuChaeDTJmoWXrFuslnMvfM1A1tOso1KA
WbDI1XW13jfcHbCFcZ5MJjNXOgnGccPPNstkMsijbkpjiVocKBwcCezEzafYxqz99fnHk/j+
4/3tz9916nIbavv+9vn7D/z607eX789PX+Fsv/yBf7qzqlALRl5e/492hzu6EHIaEgf9efbt
/fnt89O22TEnnO71P9+Rl3r6/RVfOXn6BcN4X96eoRtp5sWhMjRW6nRcDaUiNtqM0s0qcS+6
ui7jfanqfJPzHbDPI6bPk+F/T2VGWcF5tvf07vq0sCLDyBaywv04aSXZ78Pi4ADt2YZV7Mqo
tvC1E+5uR4+we+ppkd+DAiVapAzSULuCQPRCdBlgqsKdYT76oSXmtzF37PivSbpyOHADK+rd
LjBfm7ffOOdPyXQ9e/oFWO7nM/z3j2EHQUTgmmH8Oyy51vvMS7l8B1SkW1UPruXFncWHHXGW
mmWwfWpMzqWZb+qKhi+bLNEOI6OteQFp2NRVHjPp6+uVhGDvd0fW0mZd/lEHnj5w71I8clvA
0E6xXLmiiYJOXQyCAkZEiNnA6Trm9NnbRRwCoH+S04pZGBf8Bewe/bVWRO3rKpIUAcqvJ71o
+jHESMMnrqgkDsYypzlVZ2dWRRnJcAxMaNA/o1J+Afr88tuf+Jar1R0wJ2jC03PfFLc/WcWx
m2EwiPI36gmYBqBlU5CZPUtYQTNM02ye0B4PVnkFCEv6Yu8RVmt6hoGR4LS9VF2afU1m8nHG
wHLWKD+3ni3S2fOQHIw0sOP+qeUqmZK52t1KBctaAR/xspPLQmQ1qYHwqipeB3m6eBUxSNir
UsmxQZTsk98oh+vltvhjdb3wGPi5SpLkGuz83rj7wJgErU5pZajdB1WZxYhJJRb0HsNsC92O
VIC4owC6WCnByI0O548uxwmqPVUNU0XMHaigE4kjIJLECSCxdR3bYMe2bj0ztSm5VpvVikxM
6VQ2L136Z3szow/oJiuRjNPEc1N19GRksQ2rxK4OtaROY/RBN4n8QpHCrTiyhWHAWZCvbVNR
CnynTm9sci8gyqTsVToJNwe6C9rzQvruGrboquiNcwfT83UH0wvXg0+UAdntmWjbo+8VI1fr
v0Y2UQa8a+1TFEG+OOpU0eEe3q7dcUz0TlKivjfdFV/Ho9mkUfKV+8Tf+DUXgjKWurWsF0n/
oSKNvO10rPKIl4TTHi+PJgFGvwF5Otp3/sm+Q9xPsi65Vg0+B1TB3VSivj48oMOWtscPQkkv
pZEludvy9CFZjZAbk3fFWzgyq5lTZX9kZ+47BIjRHSJW6bzryPMzSIXNE5LOcZt+18ObRFyC
d7RCBcpPEeftLlYlvIJ8SKy5WaxnAIjViVyv2zKZ0FtU7Ghi/KEcWcOStSfuP0ZYnsqYE588
7OieycOFigN1PwRfYVXtHZCy6GbX0AWxh821OBWDyvND8PY80h+Rtf5uO8jVakZfdgiaJ9As
rXo/yE9QtYtoBoKP1uGBh2lZzqYjx1PXlNxNveFCL613DvF3Moms1Zazohr5XMWU/VhPVk0R
zbnJ1XRFqlPdNrnCV6s9HlWmkZ126iJBcW5zbV3VpUezqu0I1a/8MQngK/n/jc6upusJQWRZ
F7vcKo7Jt2OgQ7hrwoabqN/6sVAt7Qt/zleTv6YjM3ESufBuavNuPC3vOhXrg//Qdba/xggj
ppoduQ9MdJx1NPBYlD2INHBWyIYvHI20WzEiGja8kpg4gzw0H4t65yfY/ViwadfRHOrHIsrx
Qpsdr64x8EcyXsntyBEVi6XHrH/M2BJ2zfXIIizxxwwV17H4lbYc3cdt7o29XUxmIwcYfTMV
93imVTJdR/SrCFI1fbrbVbJYj30MtgOT5Mq1GGrQkiDJSmDXvDg1ibdzKMwSNbmbf8kF1AVr
t/CfR2lkxGMaytFNIRvTWkhR+Lm6ZbZOJ1Mq2aBXy3+zVMh1hLQAKFmPLKgspbcHZJmtk/VD
NY5GySL+TrwRWcz7Er+1TpKI+IfA2dgFIusMtXwdrcqSSt+R3nhUCQfkJ5b+WPmEp2kuJY/Y
2XF7RZ5KyTCUo4pckeI40olLVTcgB3siyTm7dsUuOOXDuorvj8qjyqZkpJZfA91zganCcDQZ
CXhTgepm2ObJv1Lg57UFqSCiWxX4pmwBy6ook5/T7Fl8qvzgZFNyPc9jG+6OQL/i4TRu7KNu
49ZiyjoRJ7EWpyhgrkcXqBNtoI2x5wkBaUP7pmzzPOItLZqIs7UOfdokMX4D1jYWAVIat75T
IHtYP0l5sxMRCmkC6nyxoW8HScvnR7kxQX7G8uJOGIIypujFQOABpNGIxhLBDd8xGfECQnir
ilUSeQumh9OED+HIxq8izAPC4b8oIwdg0expOnUO7olbjBMweZSeGdF7zXhp7msKpjzFNfx8
9LaB2s8HjCrZaOlGk7sgRyNJQG+qJgIUPMcXglq4SD3iXaNVmd79rZClH0lJNNpLxBSQA88c
nVNXvCPALfMDlzzYnbeigG7UjQtw3eHdchXB/3TJXZbKBWnlOa983Z0lUi27ZEPvaa5D5Z7O
Lxjt9sswMvAfGFL34/n56f3fNywibOMcszmWKFDRelGr6rpGwsThOM1C27BLIYHKSUF5MCHl
cQLPeu2KzKvB8MX3P/58j9rbRdUc/RB6LLgWnDy0BrjdooNbGL9oYBgAGsSpenCT6OcQZl/R
sJKpVnSHIH2zHsTxx/PbN8wm/vL9/fntvz97jmO2do0JsbR7NlmOMYJHR6EXQGXWchCOul+T
STp7jHP5dblY+Sgf6ov5dDAkfno0GfyE3um/u+sUiwc0FQ78sqkx0MBVB9kyoKLNfL6in7wN
kCiZpkdRhw39hY8qmURuHg9nOYqTJosRnNwGYreLFW1su2MWB+jvY5RdE1HfeBh680Zi1O+I
KmOLWUJnq3CRVrNkZCnMdh8ZW7mapjRx8XCmIzhA1JbTOW3X7pEymk71CE2bpLSF6I5T8bOK
+BbccTBGH3WiI5+zMvLIwtlX1W3W35EWVX1mZ0Z7s/RYx2p0R4mPchGxEfbDBEpGC6n9RinT
q6qP2T7IdDTE7NRonzLWgOA60qlNRsuE/SKrg36fKEq1NDl0/DNr/fKy9B76uBdeWRGRGnqU
zYV8P/QOR/0X/L9piI+iOMoafCmT/nx2eZS58Yalc35p39QRRHzBG30pHvZXcmQFfZWd8y29
3ILSevVIW0y5HDpt9OBTqf+ONjH0zDflrGkKrjsQrQr7Y75ezobfzS6soQzVBooTY0Mxgno3
SOifGUOTZTQGQiPCJqT93w0YN8umHOyULEkmDXMi9Ez5SXZdx9hwtOGN4U/vbc/5wSchED0p
/x7wCdJ/b/NWcmUVg75TgKl3G/flOSXm3MFZvWkZ0dxumx7cVeoBLSnqenC4Aui6R3w3tqyp
dbkjaTGIZYpsQYqcn0WVR9wF73iqzCnS1H8kyFUbAOyiDNu14HRK2QfvWGfWtsJ/EfAOK9lO
2w4f1depSut2Q/RPgzZePt0ehrkpXU1yPx1nkcMPAvJpz6v9kZGTzeR8klAq3DsGMrRHvdgh
pGsYvR8RcI08z+IjRaSLO1LTuV5Q9+KtFGyxCfl7nYfLkS/Nb62rgAnN/M66QNGAIEt0w8HZ
qax2J9AB7VkFImEk4WGPdtjAj8cfsQofJx7FwAwRhy2X1eUsJCSaiBt5xBl6X4iReA1v/Qg6
F87y5Wq5dj46gPnEzYO3ICQlD+CoXrmWnYqAj8Bqiy4TLQ3fHNNkkky9iQ/BKc3Lunio4MBs
8CKrVtMIMx7Dn0/IcGgX+7LKVMmS2YQehIHv4NqJwZWSTRh2NESITrKBz672uXt6SBaHjpty
MTEEDrZMrKE9Kxu5FxE3BheTc1Kd76HsWME6elQGdmNg/o58o8umMdWxi2f1LyPd2dV1Lrro
yOFeIvNZuEiiELAnI0OSC3lZLhIauDtWnyIbgB/UNk3SZWSiCjdK3YfUdIOaklzPq8kkic2s
QYlxai4mSJRJsprQ0qCHmMFl8xOLVZYySSilp4fEiy2+RyCaGT34Uv+gYaLsFkd8oD2j50dU
vHPTFXjtHpZJSoP2KgN5loYBQMe9R1YqV9etmneTBQ3Xf7cYEfoAfhaRG0CJKyun03kXH/Ex
2wABm8T2viHSoyt3ztVq2XU/QWXO5XrZRY8aQkfpLiIlaXT/IpRyKPFGjRaaumxqKRSPtVRm
yXS5otUqYWOGaP3EVxtWffAzloYYU0rfGyIJN93VoDPq2G4iFEDzNHGKg+C8zHC/JJNHvRTt
QIiM4+bGZPBTyDoRADA9P9/8rlb1GHlGvA+YQzF2DHDaivrRiHlKGzJDvE8X9PYitSfDhcJs
v7O5JyaGSIYkPeoYk5eYRD+gFUKlmq+i4DLTt26E/gE4nUy6G7cRxYiQZQOMXGVtCfAYUZCi
4JG0xD6a/An6I1UCAl70U6rckplmPKRutZjPYk2oRi7mk+UYLfjE1SJNoxzuJy2Ljo65rfel
5YbHSJ74KOddhD/5JCqhhAO0aj7hO92YUhANkhk1PAvWnH/GmuAaNtAN8Mtz77axdpBpN4GB
qJji+GYe6pbLxXqKfi/qkX7SUO5rc25Nm8MPliVbzeaUu4UdBhBqXoTd1zaCDXCDbrpHB5Tz
rM4jsJPwtDEGchb6PbHrRlWEKY2pAlgdhD2YbqHzsyiehm3jw5MwCgsO+3To1If1cF50XsYy
eP3aw7hwYxweVM3KZEKZlQwU40QLhi+omcUL+4Ov+j1aMH2u0mTV4zzYKKxrUiBVDSndG5Sj
sXsGvWiy7XyymMLWKY8EbDVfzog5O5d2U0S/hihmAwxqt4fVZI6jij11cN9Bba1Ye8GUE3Xu
J6UxSDlbQ9+vdfWoJZZ3xXQ2sILaYl/YNCBRShj7cfg9ICnpYk379d62BIuKabYN4A1QISQL
+GvD4jOYt6d0AWu6t7r+wTxqhMX8hvC4ocXSachfDv2mWeNtRYvQlmIWXH+6yM8/hCWy3AQl
24nz4tytJLxudXma26QGIX6SDErSsGTqMW22jLZAWSC9fAY491hxbaPef377qlMoiP+qn9CR
wHtIqHWTLhHZbAIM/fMqVpNZGhbCvzbvjVecqVWaLRMv2QmWNxnah8LSQmyMVcorbdk5LLKh
q6aJ+yTYpmWKGf/JabK12wyxiB1n4c2G6JyxN7vdOwbbYcdK7k/CreRayfl85eVdukEKSoC+
Q3l5TCYHT/i/w7blQJi3fnPUot9TFVDOJcZt5t+f3z5/ecdciWGiH6Uunu9l7M2ZNZB7dXH0
lybpSrTQPGT4azq/P5NU6EyDmHDMPq1nElA8v718/jZM2GcVrs5r3T5glc4nZCHc/E2LgYE8
189peE8xungmRZO3gW6gZDGfT9j1xKAoZsd28bdoTaEuOBcpM5kIIp0uWaSXbvZoF8A71sb6
H/EdcFFKLVZT2nAXq2p1MIHzbJcLbfHh1JLfUcgP8U7xKo94criITDb4etUpjF6gZusM9CQ2
+Pw8+qlWpSsyttFFKhoZ2TmlyImP11udExYTJw9odfX6/Z9YFUr0dtepdIiER7YpnIJCkJyf
xfBV1U6hs83CVj9I2tvAgqXYikhaDouB9nZBv5RxayPLqi7ivHvDSBZCLiOeERYJdtWGtzmL
pNewWPaq+KDYLhrx4qOOoWFY0hiOdeFu5CgmXEb/y9iVNMmN6+i/UvFO7x16WruUBx+UklKp
Tm0WlUvVRVFtV3dXTNmu8DJj//sBSC0kBarm4CXxgYu4gCAJAltw19J2wSN8YNDg7VtlcK6i
PpTZ7S3WBJ9BYODhtMiLBIQwfZg4cqN8eLBd2txr6stW9zYzOQlShbo2TKuk70q+6BKDVLiu
rVOTI5vZxKjvaSOdesgN47xuHhrTW8QzmuQbcuTeJWF61BsSHi0SlciCEp1/LmSuew8EEpoX
1z19HDd6i0nWDmwmLbmtCrz6TEtln4tU7pw6jXvFmEIg6KxN2GeZshQG/cJC4BAnmZY3K3QC
SA6NdI0xkEqTK3sDXjxuamnf9cfrGLBaciU3kbiDYtDI0JcjgQpzbwJAJyUEeR97rk0BeYYR
SQngojqQlgHsJbIDF6YEhgAZxHBhuaEtP9+UjlDalyfZYWGLXmKU1yCsqe/VJx3jwwu0v777
QOh8S9L7OuE2nQZNAb1IY2AfzyLfwSywpzo1TDrHoyV70U5vEEiJYay0ZAt0NUWnYMlPx7JM
ZkJtEoVu8HMSONOMB11UpcCwV1yFwu+TQqgvXVzJnwscRu8jx5Z8SwnTNU+OGRqL4IiWzpoT
+NMq/ctJBu/kI8aNtPg535tcsEgUdUa+MJTZ6vOlUbbaCNbq6SOStgulClMYko40xEhwB4Jh
Rrrmdq+cyI5VZL3rPrTO6hZ9YczKxBBNGVbu8n4vG3dMFO7ZnyA3B9kV3HoXJe3SRzHVnVnP
41EK99KryYnVXtv9Kyc90Anc+BPaUBqdSOYhc3uNdgRWxdAeiNX5NlmyVz9evj+/vjz9hGpj
4ck/z69kDUBd2YudMGRZllmdZ6tMxYwhqKJAjVz2iefK16kT0CbxzvdsZXFQoJ+0CJl4ihqX
VGr5Gjm6LFdL5QE8p4TrClXlLWnLVPGeuNVucvrRyzjua9We4baTallxmTcYlHhFbJMDRYzn
9whQg3nrjy6mlx4cZf4dFAf0f758+74ZXkFkXti+6+slAjFwCeJNJ1Zp6AcUbWBeFDkrBB2D
6Z2N7rkqgwbMxZV2AiJDTLnN4JRKa9S2KG6eXmbNr3LMZQrvBjCcKSsV3qUF8/2dr+cL5MAl
LzAEuAu02aFpEyMJhN5KXvAIOcQLKJ5zUq1Xfy5gfn37/vTp7k90RS6S3v37EwyMl193T5/+
fPr48enj3e8j12+wM/0AY/s/6hBJUPytZ3uasSKvuQ9U3dRJg1kZk66ANLZpx7yR0z6+Bw28
MM13OTPZiSpiWe5YvZ51VmUX8xgwKBEInbJKCAmJ1vCnE9rYS2L5u2TkFq8IenwkJHcn0rWL
GE6VCIoi0ca3yKOsyH7CEvUZtl8A/S6kwuPHx9fvJmmQFg2ae5/1Rahr9k1/OD88DI1Q8JUq
9nHDYBtBWUhwuKgn98/KIAdRKR5NjZVtvv8jBOxYU2nMqrUE1fHUN926pTEs23KeKzTBONEK
PrBCFu5Gcaq0tIgFpk45fVRrgxb9NRsdDC0sKN3fYDHFF5AVCCmdazhqaCn7PwY7MWmTw9Qf
ivYhbhqYHGDo27TocPLLM/qJlkUTZoFaCaWKt2pkt5at3w+L9axlU9ZE0CdIBrsX9LxzElr0
JzXPEeQHzmSzSEz6fJ+L/xsjRzx+//J1vdj2LVTuy4f/1oHxcev4YB5fSBrD9UqvXB8/fnzG
t68wY3mu3/5LiVDWt4PtR9HAtVo8oaL3T6s6za01Kj2r+B4jMPCwonKQu6Ku5LeZEj/qSocz
JFNP1TEn+B9dhAKIsb2q0lQVflmsXIXPSEUfB014lbSOyywqTs/EwqDd5eP3md5XB9mf/Ujm
l8FUVZokKxt60zexUEvWigm2gV13fyky+rx6Yivv65v5NdRcImyYTBfxc4FxXTd1GZ8Mflgn
tiyNMfwffSo1caVZfcm6t4rMqqro2f7cGYI3TkOQu3t8s2YFtPxbPH/gNUL3JluZXYu368XO
dVew7O3m74t8XagITAVi5Nvjt7vX588fvn99oXxhmFj0EVnhjlJ9aj818/szqAD7rjhT6zGK
OHFfohKGQ8z6Fp04lAV00zvfdiaO5qAdjvCN4RhgRMul6N7r3unENDeoUjwrds/U0FRi50k/
0ObYKFO0Ko1xiKbN7tOnL19/3X16fH0FFZeXT+jOPGHo3W48NBF9ytzOV9EbeJW21BmP+JS1
n1hhl3Q1RfvmMN7qmbI89PiPZVtaG8zSdtI5NbjTj9o5+VheqZeeHCv4W0eZwt2eXfTWr/ZR
wORwaoKa1Q9oKq/ysriK/dSBMdvsz6varC+fVLS56dnds0S+FhaGXbfI9zXarByvOm84GBbT
jWEkFABYX38bUbyH1waaXIxteahgD16Uaa2ECI8RZwdajUcE0qxqfQht+uJS9DRv/WqVquij
0Ni0q64Gimvbt1UXXYsaIxOYMroyO0jGKk9KyVY7zbtVTn36+Qr60rr9Rj8KWtvFad2uvjLH
gKeGSyPeMPjsnjzOXmBHH8v8PMpdD5+RjsLPlCFnUYP+jHQ0XjN2Yt8WiRPZlr5f0ZpJyLtD
ut18+xSqYFfXy6oWf8T1w9D31K6a4/pmV0iB1t157iqvso1C3+CGfWzbVJOkyoArnShZFybM
d6NgVRwHdja9hxcc76tbRMX14Sjx0EKM4Cra6Y7sJomwbug5pun2+J1Pv5Ru6aObLtAq0G+a
IzFaKGPyESpmCbJOhgF+ETSEThKrZ5q4jsG9nuiaJo0v+JrYcGmz+nrhIIbt162iZrycBJA5
EzmozZrnsPKjDaveirBJOsuulOxpE2v/9r/P426/evz2Xemqqw1DlMFqz/2ANJIQWJCUOd7O
MiHyqaeM2NeKAlTlaqGzXJwFjc1A1Fn+Fvby+D9P6mfwA4oB3aYrV0kzwqqMUhFnHL/F8pUq
S0BkBNAXVTpG2aQ45JcOalJl7CoQaUgvc+AGjS7OtQzFubYphamCrjskXUI2JoepLafM4Vs3
0xeGEbUaqRyG+kaZ5ZkQO5TXDnWsSHsHvInnURLJ+IUcZee2LRX7QJm+4ftNYTteTQFu2jQW
rIarPNav4RHEE6Yc711AQbDkB537uIeZdD8kV8ey/TUdWzVQhL+MkD2iMEgdotCddVFsL50M
TxVWiMKJtEacku/fO+FNXic0QL031MFjqoRg1OG0H87Q/NDGQ32h7WXmz4t3Nvk+Y2LA56eh
ZgqgYfRirTCZFqKp4aYHARuDoWAtFibXY4KgiGhniOw48aAe41Ca8sQwXogQmfNu3M68dwOf
utKSamh7fhiuh0ya9Tx4rGAJ5Ls3KTF/j7NGoMM9279R1eYQ6e9X5nD80JQ4dKkXohKHby7Z
j94q2d9FFpWYVXvX2+qm8YFKuJ4ceXzOM7yYdnYeITMm47I10vW+5RKt2/U7z/fX9HPCbMty
iO5Id7ud+matq/0+wOc0BlHH5eciBfhPUKBS1SAJieMFxLFYO+2rH7/Dvos6DpkjkaahR775
VhgkFWChV+iCwgT4JiAwATsD4BrKsOVJIwE7xyNiscZpH95sA+DZdJRWDlGzV+EIHEOuhtiv
HDKZWI48zDV48Fs4kjBwNut2K4ZDXKMpIWi30rn7xHCKMJASVcWTbSG0kfkhrmz/KAbvOmc8
ZsHjqVzRIpbgt22ZsYp6Prh8HXomJpqVW4uTmfa3dqs1EvgrLrohES42NDRlgUN2Fgbf3Wzl
NCtLkE3VuhEK/wQNsacqiwc6lk+ZQ8ockXPI6dS+G/rUA6uJI2fJ+hunR5lxmlBfemDJ0XDd
Mmdb+nZEBnSWOByLVVT+Oehf1GGAhBPzSJx/yX42JuRYHAPbJcZIsa9i2WBUorfZjaD7vkX2
PV7pvjEN8IyNSvpH4tHPkQQM06azHYeofFnUWZxnVJ5i/aKWXpWDkIojoKqOCrij6tInoEMQ
0hcBxyYkPAccohs54JlSBIbCncCmGgL1ocAKtlqCs9g7Y+qA9kUk8+woXUNicO2QGn0YdTpw
TPUOApf2mqTwbI4dzkFFG+fAjhyOorqk5rVIh9a1DPUub12W4yzcSN8n4k2+nrYLQSK4a+lY
VrLV2UINaSo1dCpKAQAqoayUVUSNsSpyyZlWRZvTrIrIgsk5BOoISSU/c+c7LtGIHPCoicgB
om2E9TMp1RDyyP3OxFH3iThLKpiwvVnlUSc9TCF6WyXzhOFWOwIH7LyJ5qnbpArlLfBS90Pk
76SGaFVry5mPJqPW6AQGBdRRQ8VP0D4rh/ZAv8ma15UhORxaosCiZu0ZNqgtaxmVedG5vmNw
5yvxRFawpaEXXct8zyLGR8HKIIJVnx7kDmysqeNyZWEgZ5MAFpcClJYCTG5kiASsSfKtjxPi
mvo4QBxLyGAqY8DIjbcqEyNi8iDieZ4p4ygwePieeVpona2B394yWJ3I/GET61mwhm4WAEy+
G4SUr4eJ5ZykO4vSoBFwKOCWtplNrd0PZUDq4uhS4RDX61nKVjc7M3LsKbUByNRGEsjuT6qR
AEi2unYy2F3VLK0yWLXJ6ZCBeuxZ1DGTxOHAbtSQOMCDx606VSzxwsommmtEqIVCYHt3F1JT
jPU92x7ksDEBZYESeIntRGlEb+xZGDkUAF8ZUR1V1LEw4CLoN0rjrmPXoTLqk5BY/vpjlVAK
T1+1NrV8cDrZTxyhju4lBiFIqaTe5kYQGHybLBVjFyXt+Y2tBHAFURCvP+fS245N1unSRw4Z
BmxiuEZuGLr5Ok8EIpuYoQjsjICTUtXg0LYywFm2RCIwlCCMe2IRFVBQ058ROOHxYEIyDm2a
1M+DG/CNW4mZrT9Ztk0p0lxj0hxmChIGCynpd6QTB+vjvmCjD3UNy6qsy7MaHSyMzyjx0CG+
Hyr2ztKZtVPDidwc1rRrV3A3t0PfFS1Rbpod4nPZD3lzgfplLfpKyqjPkxkPeMbCjrHJTSmR
BL1uCNfLm0nMuROMm/VFhn1c5/yvNzJaKifnBLN54iLrnGaXQ5e9p3hWnYsalBbqdAJ1Q7Ux
SMn3pxc0If76ifKgwR/FipGSlHElXYqD4jK0J7xgq1pqtIqUrEmGtGdU1Zd5BKyuZ92IWsi5
IQvdTOMl5WZeesXwlf5WZnS7SFew4+NkSgihX8iGsWKvOOqQ3zEgC2s7OSgVT5UUGEWKTj2h
OhHfvOqpFkGjsBgqK2KeYf7c+QNduspEYqpBwj6pYiIvJEtXI8gkap8UBu4ZV64iZ4CRgV45
vtR5lXSqMoZpTCr6ZllhNAWcEUzkAwT+/O+vH58/oGX+Oo7dmEF1SCdPHHOmnAZap8F1AsJx
0kc7zycDOCDM/fahS4dEfgy/QMcySSVTTAR4pAhLVrE4VTL/knPhPtkomhZD4ZAuRscr2irC
BP9wLywNW70Z32gZjhtiDM34jr4PWXB6z4Q498tGnanNoKt+vrj71j8zLWtTJnncZ/jkQzt6
582W2BgpmCRSjQm7x8ChtnYIHosAtFAeHEa6GuyToY1Zkbh6XkJyvj/H3WnrmVvZJqrxLxKY
GvlkWR2w8CE59im+9zLUU3CPvnSIKiHCVa430+uyYEHbKhn2NzIMyWGKDqS2Ord+TKomlaUe
ArPZo1JMFLVVZHCet+CUViumy3yxr/Yvv7MnLSsWOAr0+ahf9I/UaCe7dOXEPnDlA/WJpm4h
OTWrD469Jy/iEFfe7Ul09BSpUiYjDelgbvLjKG6bdKr6xnQ0zdRc+/GihKmi2lv6rTynnSLZ
To2TxAW7SmSFFwa6D10BwBDIxNDRpeH6QINTK1/14j4TzWsPZzndRzAyaHEV72/+2BKGXtFN
4JGm+BmP9VVibb87pikr0jF/ywLbUi04hFUuve8Z/e2qjSOZ8epUx17NCaxLG4Xk81cJ9wN/
lXL0SmpKOBoNE9UAKiV+r6XthK75OSdv0Mr1DeHeRG0pP1YyAzdUVjtpesSgqgxd8dDUscGt
Mq8ut17WBqb6tG1yqDk/3ZZ9HZiUnTmxdMSrk4QSRQGH4oY+3Zqyj2V/EgsD+s85C+9U7Kx4
RFl4cOvFd14LF5ETCOE8kl/aLxAqXJE6ZCQw9d0dNWwklrH1y7SxDZmMHLAiotUjOSIkbq5s
vcE0qXRvsU063uYX6LqNgjiyNYyG2BRyiGvQb2W7Jw2LIjJHVdhLfoi5MkN1vUAuvmtRaMHK
nWsZ+hWvPJzQprTshQklYkh+I0ccGolC50YXyoUTrb9qTOSttcTTJ64f7cjyAQrCgK7ApGxs
Zo5MviySFSgKPLJcDqlXiSoIGshbxUY739nIIKRlqcLFlaK3ypl0JFMWkUUp8DqTQzfRqLJr
/ocVPIzIyYZQtCNHVZW0NiyUNNb6nk3XpY0if2f4UMCCt8RH1b4Pdw6t2kpcoDaS5m8qi+NS
sxQRP5JXNBULKGVCZdmFVMb4wsrzSUkj6aFEqe3h/JDZBoVeYruAHHujdpyHlnYc2hnmS3ul
rKcW/D3G/lEdNWggBpy4KLfbC0MXs3aPz8vbQgsGho45yBSj2kxUdVSfN6vb9V5kkXJ01tGp
nPvq4my3Lytz37YsQysyUKCtYFvEA0/keKRewKGwpvPGu1U7IEMQKkwrFVlFHdcQXVll8y1D
aGGdjXw5qDPRsp1jtkuKmLXNtIYpurOkv6ketRZg1keJL+Hjt4z3xZ7yAtclmntbIGgxysvC
4Fu1S6bID7TfPI6je0tDVNMMHUAlWcLfrph8+wkugoMfHeZfH1//ef7wjfLvG+fUxZ84xch7
yYfVJY/RIdvSBiMBFyZ0UMXe2cGSLYLsWvToUqKhznVS2RMR/MCgXcWQMuk5P1LTdojPt9mn
nIpx23KWlQd8l6PmdqrY6AdtTT/sJ4jIDgqsGAZQbJuyye9hiByYynfYowtV+XJkBTYXDFNU
Nsk7EBRruMxi7oCF8cdvipsC4EE/fQP0Zwpbla66mq6rxtaBkUG37tD3WgsDAb16Dy1sfIa2
kc2uEUZfkmSbYTqKnmfVwA/OicbEdjZhmI4d4ctJ9FKpvxkModk5E242nz5/+PLx6evdl693
/zy9vML/0FuYdAaOqYQjwtBSH/NNCCtKm7TsmRjqWzv0sNvYRTcq/Qzr4e6l19Gmaoqbqq5a
O77n7dbAVI7lrbDMKnN2cZrJXjEXGt+dtr3WrnGVwizVv0ZQoUEMjTHiSXHSh+mIjGVtJ8/j
rhfzi0+m6bLu7t/xj4/PX+6SL+3XL/B93758/Q/8+PzX898/vj7i1l9tHDTdh2Tye9T/Xy68
wPT52+vL46+77PPfz5+fVuXoHzeQgYQXcGDKw9jN3OXUdXO+ZLF0SDkSpkgFSX+bBPnSgROP
ONXwSfJ0cf3OpeGqUpxcqCDIbzqgmlTlAV/TlhizwzRzdrIF1UQZROjktmv22bt//WsFYzio
c5cNoByq1noLR1PxMO2CZaNwaeTzHv349dPvz0C/S5/+/PE3dMzfmpTANFdzwaubOJKB34Wr
k00C86wiMCgTlpcRXBcsHHznGf0MUmfrtzoEluHhgI5fxvo0+z+ypGdEnWZG4Q44jXNzowz5
2TQ9RF7TqkzlUDZXGO0X0DD4B3BnRtSTEa3Iy76M69OQXUDKGZt7igAxOi4eZycxENQBAqLj
r+eXp7v8xzP6omxevz9/ev5GyCAxonkzYTnNucc1Xl3l56EoDEnQESs7szar03eOv+Y8ZiAe
91ncCwfnl7hEtjUfzIGsavu53MBb86Ay1mXvz/hQGXZi99e46N9FVP0YqDjyJ6wYuHe4Ev2u
p+dOqDo20aJbLaes63mm6SMXUBL09ehSXfMDtZ/gikMVa89hRmpAOlEZQdjtWOpwOaelWpNY
Vx+rPM4VS1S+uiZxN6TX4ZjKe+AZKS/p6nPe3ygDG0T2DWyBV18vHOzT7l6RoeWB536pC1r7
+PnpRdMjOCOo55AnbDyg98pML2xkgZE5PFgWDKvKb/2h7l3f3wVGuSNS7ZtsOBZ4QOaEO8oB
j8raX2zLvp5hJSlX+pjgwsbbzEbcganNLpCsLNJ4OKWu39vy1dvCcciKW1Hjy0F7KCpnH8tn
WgrbPZpeHe6t0HK8tHCC2LVSirXAWCgn/GcXRXZCf1NR102JTp6tcPeQUEcCC+8faTGUPZRb
ZZZv6SNP8JyKOk8L1qJ93Sm1dmEqx9OU2jKLU6xd2Z8gr6Nre8HV0OoLJxR6TO3IEDh9SVI3
lxiT8HHyf4xdW5PbtpL+K/O0b6dWJCVKc7byAN4kZHgzQUqUX1gTW0lcO85kx07V8b9fdIOU
cGlo/BBn1F8TxKXZaACN7oDeR7hxV5CfBaJZs2K12Z5y0iH4xt6UUueMU5lm8Gc9yFFrqBY2
EAOvz9PD1PRwDP7ISC6RwX9y1Ptws9tOm6h3vjjFKf9lAvKyTsfjGKyKVbSuPXtxt4c8O1rv
PnXOuPwSuireBo/09QqSexd6ldzM29RJM3WJFKIsIgVIsEoMUsBFnAVx9g5LHh0Y+ZloLHH0
62pckd+cwVW99y5gwcX/fbbdjq2k+S3WmzAv9M09mpsxZ7KYmXL+1Ezr6HQsAjpciMZ7YF07
lR+kGHWBGElHeodbrKLtcZudPHVcmNZRH5S5h4ljqmC5GOi3259hoYehqc9yzTSuwzV7aimO
vhvK86z2t9Ppw7hndKcduZA2QDOCMD6Gj+8pCvntSotnP41tu9ps0nAbkktlaxIzpsiOZ3vL
0pvnlAUx5kHwsnz7/fnT5SF5+/L5DzO/CDycZjXcmqYT7iDDQfYn7HzB1oHnFB33XWYtLEk1
xsHwyEQpS4PPt+wfY9NNHlE5502wM0hvHKIdAmvCA2/hPkXWjnDGs8+nZLdZHaOpoMO04ort
VF431PxMYzu1fR2tPdvBqr9hT2FqxS4OqX1ni2dtfeiCg5TynXWDXUH8cRX6TD1AjfuGioh+
MPPom3tUB15DlKk0jmS3BnL6tvBGHHjCJjzDNG5zE+j9Z7d2SyycvoDlMpLXsJBNzidFuw6s
vpRkUccbOaL6XvryQJsFoVjZ6285r0GczFH+McbR+g663el+gAaaWXoDkyVkx+3GFWkNksue
zONpZHP69zDxi60OWbvbrK1Gk4b4TJzYIVHvtyu4MPBQvFPBhTO1P09Lcblaxywn72t25JQv
BHZyl7b7wWxENVqrc0koErslKe86abp/yE1HKWtpFIRDRJ5n4XIjacYjz3LLxlIbUfbKvc+8
67Iu0K9kzesna63HnVlFsCPbU25I2GujSjsKZz1yLSuoWUBagXnd48p0+jDw7klY7eDJkr9r
nimKt+evl4ff/vn998vbQ2bvvxbJlFYZRDm4vU3S6qbnxVkn3V6z7NDjfr3xVKb7FkLJ8r+C
l2Un5wsHSJv2LEthDiCXWPs8Kbn5iDgLuiwAyLIA0Mu6DgTUqulyvq+nvM44eY1+eWOjXyOG
JuaFNH/zbNJ3v/BwJR0S6/3HPYOAzzrtuptoUCs5H87nAsIoFZawUPteroLI8fxzSZ/gOMVD
Z+LXYrW8rWhHR+A/S9M+9KWnlgy+VIoSkm0NKHcQkKW17r4EfbU3O6ppIYO3kcADui/ILEdt
KAtzw1hNmhPG0E55N3zxjiMevbfJK7k6fjRrDAR0VjRLQ7Jv/3TBbyJgPsy3a2/Hl/lOLiWp
s3+QniVYpv6EIkp7CHJI0QHJNa6z6PmHIbdqNKOexsyo4ZwLbVyOaIyOUWc03hGacV/XzPCd
nmX9WeljQ1yRSA+uxefRAJFVoohAx/nK8Sp3wLgl3VxM0WplNRSpAWUjwSfGTSGEa6wZB30I
5wypGch9xsc5WxlPYPfG08w6b6Sa5OY4Pp27xmp9RM+G8KqmyRrTKROovbSBqRvcoNmkPSsn
MnvEPOkOUG/RSxPQW6yr5ATmgzGbpHfMwD/cD4p0KGjfLQkPGX3bED7mRBoiY7/ekPsXUCkn
xh2OGHrhmnNDDuvdpspNaiK71tKNMw3vge11n3MNUzpLa6GQSla/sYCt3gahfhpLWhA4FyXP
n/735csff35/+K+HMs3srOfXyQg2t9KSCTG7fdzeB4ibpen6yZpPGYE0F46nPgs3tGzcmCw/
L4IDg6ARY3XjQHeZU5lrNs8NFOzA9AtaWsEZOACuqMYhZAal06rsD7R5YyqrKI5WjCocoUe6
7FKuLTbUt3xjoaI3LpjpQKwVe9yEq23ZUliSxcFqS1dH2hVjWlNm2I1n9pr3tMdObD5L7jvy
ubxFGi9w4VsTS1wh0GYZLsBuN7OafWP+mnATV9p0tZHtQYMcW4liSsuhD+2o4XOzHN+m5f2i
GWpNPEWtBw6os2nJ06SR2rRyCFNemqUgkefpIzqQavSsYnm9h20Ip5zDKctbkyTyD44CAHrH
TpW0w0zi9QC8KQpwDzLRX40g1wtl4nU7gNfF0bjCW8OeuADvJULEluYtmWCNxw4dkj2PZeea
weU7Ofs0uogABoeSkKBX/BKFZpmzo8MkZwCpdcjMYFAlOaVPhVXoEe5/ifw235MY5LK2hsk2
fa/E5TFSHJeuGbuBsL4MtrQvpyODUylYmnradFTx1R0RmsQ+GQqTLOBAt05tcUURGqrq7JJB
hFRKbRrzPSHFwoXkVOw+U7XDehVgxnkTaNoymoy13kxdk1TkhdfQ/C5yHN1yWPq4VTupuk7E
HsUL12Q8SomehHALE7Aeryrdt0qRg3jKhPUZQ64/Y6xYpgo0asGyYBfEdOKeBV97AjcBXIqA
NJ4Q/NgHsR4gfyaGkZmE4Ur2uNaj5FZ8F4VkEJoFNeIK1ni/OYwC+0VIpfU6wLkIrEBVJqj2
Ik1NkcZ05m8A94NA40i322d6PvZdXuV2cRKRWslbQXTE8Gf31jkm0dPZk5Qi/viR3AtYpF/o
Z2yK2PPHcJxFwq72gqpe974W2cgbi/jpcnM5o6TbL34g+Z6iRMJOuf2dSNL82TrFyIrTN9GQ
QaSsJaPZwacqu7qA0xm72Ao1M69rltpJQWyuWUa8Ex+3pwUYhB0Zykx9lWszjBkQBT+03Pnu
es5Hf8MVjFtfZABbYBl2u8B+l6SFBM0KOwfUExm1UyJJv9Ovx15J6MKMCR7tPknZKlj55EGq
CCPlLQrjeN7nNaH8ke5qk13g0GJXHyiqXK+fQCn7qgNRL5zeULEw/Lv/ag4fC585krGuZKFT
7B5DjXmeKdl5fsYpaG3pLChmbReunieDEYJ0NzUzS6nMnUHUq+mhicgQM6jOMr53tIKiknEZ
bnD2qzUlzg+NFDn71RnJvBaBFVHcQS2RKCrjag9ap5m5IFpovg9KGt7B1u57vPawG52hXej0
whk4nppuH4SB7zMrm9IaoHKM1/Fa3+dVwzY6BlVdhXp+BaWqxoNlDHZc6vzMXkxUeRQ6pMeY
IG0sviNnOzNA3o2oNJXdSbhj0wifsBxHM/qyJJ2rQmkLlbw3+xc6ct+2StQYMnug2TW/oFzr
WpY/oDhariwwtQzzDiFwdLkieNqgSodlVZLnLfXmBcMuQn9Ji6WFUE94x8O7lAI2NGYhhVHZ
509uByhYndBSLVW44PtKLuV9K70bo7GdakLmGauJXQ9VaLSp85HZKxANZxCtzl97wCNPsFGT
EW8/vdtIwaPVZu0VJheYUwZhFqPZtX5Fypo6KBa8hPTNQtqbzHA+vgq2W68up3qnamXX1T0h
X+Bg71BbEBM5VcsafMx/CVfrnaPTpvpQWuUpeobBF4BoVgQSpVsTP9zudCZNCx9YsHIWAwiI
MaS23Bc8ZZw5FuMVUB+WVxTUC4Iw9Ek6MMQFt3sbyAdesNRZHiRpZh/+Wc/BMbGzvhowWBvl
D6uhh4x6rJdD7r3etzAdWceZz6yH9p24EU1No7r2V+bsPTVjcbLrxoXnLPBaeGMcvGPv5Unj
rIGvFZFmAF+t3mvF1DO5HLD20a5g1ehhfhZoHkljooRoddbm0NhKszZ3FhJthtKdkqkvYHnS
WDoCAk7hzgNcef5hI8scZW4LOmzL1p6LLFcQXQSzHturK6Cr+1H++i8cVuhiDezyuuGeMKP1
Eu3NCpJnfTlVHOHpiphOBy760r9lmEvZqtF9QnI7Ozc3VHacXgRaC+I1fVD3vn5/fXso3i6X
b5+eXy4PaTvAyb9y/Xv9+vX1L4319W+4lvCNeOTfptUhcMMRvOM7YtABEczeRJuB6oOgASld
0rzzlCbIAUWozfgdkUSe3F8bnhbc3tNbnppb57yWVyPWdrA2SOb57G7XG1NMCKlQ4jBYUQOs
3uQztRBVcd3UdVy8MGTPSTeulPVk6mvkkiWwvqlA2fOQOGO7wzQ561kfo++rnFvxdPamgLc5
6aNUk4u1P8P1lPwM176kj5qtHq5/pqy0+CmuShpNP8lX3lVoEBpZ8VZgWbuSvoB6DEETwzi6
BTiTZeUZfHb3U82qXFDCVvVPU9KnR+Gb5IFJNIUusQSqhMopHSBP5EGdpSl8D8+XOeGqJR1O
wGSW9WvaOS2mZXu4/L53qk5c2usq6r768unt9fJy+fT97fUvOKqTJGnYwyzyjGpED0uw6Jif
f8quqkqvPmscGsOJHhzfKkym5+VD3UugfdHuma3TPo5Tn/m2G1DawOUV/m6va17l/e04rBnW
xXKuYWPSXJmGnpdEMwELtvYWyQ0ZvUh8B7FD0un4dkWGLzJYAiOiv4XIxfkd0EwOtaBPa1Wk
W6On9XrjO1+YGTb2WnCmx3piYJ2+DulXbaKd/6RjZtncr02ZbuKQeG2ShTsakOvMtHHpqYg2
ZURWVEGeUPgGj2+X8cax8b05poB1WK5DD7Ah5G0GfOKm4HvSpjh8ddkS/YnnKYQ8AD0mW7sO
t87exRUJbPc+km0cdx43QI0rCuwTtwVY010X6aHSbvRNVLo74QhBNhryHsbCkbFtaGWPWJDK
e5oCsPKfp9VXLrYB1eOSrtJJOS/LxS7yH0TNDCGhYhTdJ077voo9bm83M6Fupu4pWkX3Xl+x
8XG32hEVQCTabJ0t+Su4Wd376JAl3noKfgx9SESJ+oLQOvWKiszZCrjhdLY2o7aE0Fai2j0G
8XRKs9vW5R0e2CjoGbF4kevBILaPiRZguyPkfwboNiP4SKzMZsAnOQDv4vGdb1hyRSuqO2bg
TulS3HeOLzfFuAnC/7xTDSm+5MfRlXEYEV3Z9VLx7GYxcLBN7DoXLMidc+mFZRdCwfdq22/t
k9Ur2VenbUA2Q5L9TxCqHcn0E2LflxvnyBcR2Gl3nEN0hBa9K9rlewgoRjDglTcm/5Wrzbyj
Ol3wrphNWuc2oc1KG7RCVGFk+5AsQLwiJu8Z8LRKVOsNpa9Ez6KQ+NCAvqG6Fe68McLA7ZkI
N/aR1RWIPYBxs88AtsTLJWCGrdOBbUA0AwH3YHiGpAG5vvtl9HKiXQeeHJwLT8Eed3R2tYWj
PEbhivGUshs1kB66K0MU2Id/JhyOVF/qsE+x3ZjuGR0zV5aOwZoaHBGxMNw6G/cKU9bV/Y4E
ps29WXfIWBBRJsqp2m1sX4yFTnU60p0T/QXZ+d2xZpYtneZbYwjJVRAg7yhjZNm+y7J+vxQy
aYDBQFqQgGzvWVXAsCO+Z0nfrejBkXSf7EEISDqRns5AF/tITeJIJ9dbgGzvyRcy+Abukc7y
ujAItttRGugj7m08xm1I1glMs+3mnvbAyLjEPDpHzKXK7OOYjEi7MNRs2G2ob7imnJquAN0C
Bb2jR1sG2bcZHXDA3HIxXq3mWvBUJjdWbrBdMzX57jvWHhD39IYKrH99EpdHZZvfPVUV57o/
gGOuNtrXQ6fFc4Jn7j0TSbw9IX9MCe51nfGAut732naoRDt2uv0enGdvZ+RqT+/vy6cvzy/4
YmfzCvjZGqKz6N2E1LSzjxR01HPrBLEBzrjt8pK8fOJ0wBWAIfZod74Dc/nrDt50gnHq8Eqh
w551Zi9VLGVleTaJbddk/Ck/C5OsnBbsFqVnPAz0vFOO0r6pIfaN/tyNOhWFtzU5BD6lzpEQ
LHMjsRPSPspK21JQJbyzRaPorCf3ZdPxZrAafORHVupe5ECUr8DQORb1nJuEEyv7prXLy08Y
s8d6+XmOVWb1LE+Z5+Ybor0f+5UlHeVdAlh/4vWB1XajasHlF9ZY9DJFjxKLmGc2oW6OjUVr
5Eo4t7tpocKPVuudK70orFs3vBuqpMxbloU+WQGu/eN6dQ8/HfK8vCNOeIOykhKQ26NQyYHs
yDsRCj0XJROO3uhyJePeIap42jWiKWjvCeRowF8793/t1VD2HGXRU7m6t2S36ZRrllFMy2pI
BCi/gMz7qjbvWXmuKesXYamWyjRzSlbkqaACVOsM5M1hnQFuf90vYvarI59OvSqxLWXjISBR
KmwVCKHi7AZJ5So70FPWHMbJLEe0eQ7xGZ4scp+zyim9BxmVk1bu06ay/La0tVRXcbukPUT1
YoL0MMNyKtb1vzbnubCbYaDR72nmnh9pP2QEm1bk9o0+HT9ITUMdOimwG0Q/XzS6NlOnKhWh
PTKAJTC15m1vVMGcV80dLTnyuqJsGMA+5l1jdvVCsVQUMp8zaSd4dYRKdjsdhsQSAkVPZdMg
TQH+MjlYOSe6X44YCSMGrZtBJJZJda2g8hi782mbmFFc8iqp7dvr99dPr0RyVCj6KdEmAyDc
lOhc6XcKs9muZ6RL8GzSVISDSWXyGRGsDd6rM6NeqlbT5pBKY5b3vTSRVSQRzZ6EBKV2SOPh
ds/qh9nBUvvAnXjKMwQ9/cqWmy5Xqqi6tnKGosNiB/MjE9MhzQzEfmmb0oGysJC6bgaI+Iq3
Ddxg/So/55dvny4vL89/XV7/+YYDMHsbmUO8ZBeGi7RcWP1RyPJ5zXtIYweay0SdK5ZGJZve
12ESQSt0SPvSeSWAGReYbDkfpUqoIVPzkJhcMCHgmOxzSH6V4FAakqoFuVUpoH8JTUGul6At
KJuv375DjOzvb68vL3CTnvoa0ng7rlY4cl/Nto4gbAdyGgM4n2GzhkjtmqaH5k19b3cg4n0P
g4wx573igIyFoJxN9bfrfkbmSI1DGKwOrd0Cg4mLNgji8U4rCzl04FrlNLQhm79QMXfwDxJx
HaPwyy13QTB/P0YVr4CsLKX6bzy6QQDUbsfiGMINOrWE0sykvgtVpTw2NbEkQ3QodLYn9a6K
0PCQvjx/+0ZlgkbJTelrHagVOrzn52ncKbO6qq/SRcprOVn++wG7oG86iIXy+fK31KHfHsAj
MRX84bd/vj8k5RMolElkD1+ffyx+i88v314ffrs8/HW5fL58/h/52otR0uHy8jf63n19fbs8
fPnr99flSWgz//oMAa7d/AL4HWbpzgyhLKm89SV1xM8wq0VkKVsgTXP+aKPDKhyXrKMOIVCH
ndLIfgZoqNXvPLO8DFvZvjx/l83/+rB/+ecy644HYc9q10ebYoke/MPCQluigDbZya1VDpXn
z39cvv939s/zy7+k0rrIvv98eXi7/N8/X94uSt8rlmV2fPiOY3j56/m3l8tnp1ohzAC8PUCi
EKJDwimDHIRd47nTeGPzXkW/skCQ9Sc5awiRwwZZQRnEOKoHLu2XnNmdstClcUifRBpMdu/R
XJWgjFaDhVejtybzfpSnCNCdW323ViM6hsANgPzf0OH2cCwMe5bt8/7+mCy85OhdP1GUD486
gjULkdseHjNNDM/zecXJfNIzFsaWgZQNvb63qKpwFPnetgD2TT9vX5jW2p1JbN7Okv/fpjG1
7a6YYMVcWYOSKdPXGoqihygFJRmmDlsDe4hzdFb9WaRPVSHnbbnugWxCZHAqbDyXZkxy3FtT
UGlJjfyopEV45EmHGUhNUWtOrOu4TZ7zIRimgpAChVNYwUfIgmHLLKzji5P51FnyWSOWf8Te
GUNr3hzgYkwSboIxsRAhDUn5R7TR4wbryDperZ2xlmtvuIqaq6iM3i+YNUJtHl5Ft/3zx7cv
n+Rqq3z+IZU1ufppD8aY1U2rjL00J8NnAgYG/5Jy7vpgzw7HBuC7X2lkO/1oSydPbY03ozKw
O2hWEfeVss4EcRzJHQqX0VoNzCA0fsLt+5BAZ4thqodKLpmKAqL3hNqoXN6+/P3n5U229GaM
2wplsTMHMiEOvqwDkDbxTGo7snDrqPXqeKdwACPLShR1a12eW6iyHDRjrWU0VMWZ7JMsvfPe
Ou/DcOs8NJPhWs/9UVMuxI6BAfFaXMNflz1yTAxVxBO8Iyh4b/WANHTEVFqf+nCNhGtwFsKm
DCwNKNoSENaFQptmxolRNOMwSZFms9okqz8LYXfZQidmRprvnkF/ZWqSnD6KMrjqnykq/0mm
SQyJ1Pfv83a1nMJ+okgyWoTBUkhpmISzV6Dh/0/ZkzQnkiv9V4g+zUTMvDGbDYc5qFQF1Lg2
1wK4LxU0pt1E2+AAHG/8fv2nlEpVWlK4v4sdZKZU2pWZysXNDXY0fGGY2hYV2YUMdtIMrrQB
Vs3nrViElgSqYBFJrT3mGsb87bTbHl/fjufdU2+r5ucy7iFQTpqL0B0tgl+/Je7Mwo8DcxFZ
R4W1E6uEwhOWvRU6zNVPKmTWUsLJ5Pvuh9l2e8+pxyrEjGovQq1ct8P1CfOFxyM/u1yD0uoi
NaDvoZkq+V1DVup9rBymn898qxV/zAKt/xxQlzTDN7dAVxTNnCeQC39YFMOBGvWjqZRnL9VT
CwpMUVYQJkf3jm3XcfnxtvuT9uL3l8v+7WX37+70l79TfvWK/+4v2x+2gldUHkMumnAIXN/N
eDgwx+r/W7vZLPJy2Z0Om8uuF4NojIgnohmQ0jMqTZUN1hRHjdrUMxGrSTRqLl5AFY13EigM
0WmMY+z+j4O4KEM99o2E2cydUP/uXo+nj+Ky3/7Eut6WrpKCzIKaiUVVbAuHai2f6kjbOstw
FjOJujt+W8w//GU0qYcTRWBosTkwRXahJuqE6aRm4Q0OW7LtwcqIy8GVxzz2EgarxZMvhuFv
sjSNVEGKo70c5KIERMvFCuSNZM5DkfIxhACYyAzwgoSU/cEUt7gTBMnwZjCeYrydwBfD29GY
GO0hq8GN7iEhmgm+0AM8sFZHgLoGcXQUD43wRR0YD4wh8bcjTAXQYqeqEW4LvemvrW+JHOru
b0HC8zGakZqj9QcZ8aVsOB2NzM8zoGrO2wDHN2urodl4zDPd6xH6WtygjwHtuQEwqidpsJPx
jV2THry2G4CxPXANnI/A9eG7HeKMqCBAk7JzVJu82twc/mByY41lORxPhwYwpv3h3cSElpRA
Um+rR2VEx9P+GjNbELWR9d3d7RQZarZex/+6iqWllmiPwyCO8e1UYxk5PCyG/Vk07E+djWgo
ROQi4zjgKvNvL/vDz9/6v/N7Jp97vSZe7vsBkvUib8K937p39t+tA8UDlQjOIXB88VhQh+GK
GLRozebR1RvwTLYGIQnp3cRzjkAZsgGvHBsE9j4ys03K+CvdmMfDvh6Tvx3c8rR/ftYuJvW1
0Dzz5SOiFWJWw6bsbF+kuKikEba5Mz8nvZbYQCOkWeVoNGH88jIsH+0RbAiu73ZJJd+A9YXB
B3T/doH3gnPvIka1W5rJ7vJ9DwxRw8H2foPBv2xOjMH9HR97rqQsQi0KrN5TwiaBOGchI0mI
a/w1siQo/WD5OV3GDVAx1a0+yGbeHkIpu+mRsP0tRcj+JqFHEuytNPAJ5QEbQsZf01x92uao
zjKhrQ/gSE15SXkYnQ8VwA7R0e2kP2kwbR2A42wMUpEfk8aMQMlr08LaEMU2ZilRIvFZTOws
NhBDWASc0WqQAfU5t5QEkf5lEbxCg6SaZQ5wfDk828wNxVdL4a9qsg6hKJrYAuKNMJxap2DN
Qwa9xQ26M7ow9WwdLlo7dHCN7/7Xx+Qhzpi0Ib7aIHng+gV8s47nsbIvOkQHY12C7ghV44cB
tQB6pBAGDMzKAABUqnVrUdXGsBSzOjN61s42fdnvDhdltknxmDCBcm1W4kPgN+QZk8G9amab
pvBqQBetxKtYcaii1BGFtWXCftdxugy6LElqEwArM0E79gGQsEM8K5CiHA5XaGkmwpY5uPTe
KMu1WjevQJjKQD9eKvCbQ0PsACbz8yWoR8JciUMNCJ/JQx1Cq404MvoBjt3oNC3QtzD4GuSr
aG3ttYLslMXufF4qr4pCb108u1WDWy5nDBYylqDiQnhfx6if4pRJymmRz3F0DEHlXy1QF8++
q40dOldicIt8x92CavIfx0GipapvwIaJlo5c+hkxv8zAHkTGQ40JGwIeWU7pTNOC2BiVDixz
hGGGYJIa2vKh/gIDhA4SzuhS8cJc8pfnMC0j5WoRwFwku9JgzehoMDB/Lhq7u04Z29ilbU/H
8/H7pbf4eNud/lz2nt935wtm3bhgSyNfojvts1q6SuZ58OhVaMT1ksxFf1pidugGPq6Zycto
0p8O8OR2DMmuW+ye4TlbxroPpvhubYWJ5H0nh6fTcf+kjgMpFrF54sipM5n5ZnxkLfZXvZQ4
bMHZlVqz6/RuMHKk1ZHR7pxKWJk5p+GZ2kUxL2qIUOOlqf5CmYTsMC0yYqvJ55vzz91FsRnq
EmzoGOWWhfseEtHNlLelWRhEPn+S1PNOLGLQrcDCKGp8ddxnFEIudp1oAMZDn4Rq3qsSaFyC
DxH6yl9kcciu+iIc3qp+v/HMh2hlo0GfU3SIVtBu0MtbVWBdT267GGAWV8fjU63U2tiP2ov1
cEokYkw6D3XHsOhaWFRkFYROtGCloOrCi+rZqq4ynzistTvaclElPuS8iDCZKF7HTcs7pisg
D842rEPCeGwnmtAgX/i4GTzgaljqkeH8ZFC4qubWHXMrXl27ndl6jEhWpnjwX46//nVO4fh6
EAQZvVa/T32P4BX7QRSxA8sL0yv43HNk+BSF08nElascCGCiiSvPqSSwkgbJ7Vz9E5aMRb3S
O0lSggkxLobPM78WMTfrGXF48WRczMNfdxny6vQA3jE5Je332cHg3DdeDHcJihM+BAWE2M3w
74JS6D4jvhWzzdhrXPgssoFzmA0yx5NTE2sYfPMgs8sVGvaXHYeDeunURzRR8YIkSvEs0oJg
6ZX4fBVVDtFW62ETJTnN2ClpXY4GcZanQ3b6l6WDLi7cx0dGhVDLrpGsckSFblK/X1mskuSh
j+8YmaHZY6zX7D6M8JUhqRbOhdEQuM9CdivQOHMoV652ISMJ4X6PV/vJZaa7W/fKBMeikuTX
KgG3EP4EwxYDo03K0HWlxEwYl3fgtWXpGC6BzR12o01UTPCmoiLf+hWyLKaWLbNJUoGHRegY
/OZrtHJ6hCgUSJflLMVC56TwZJJXy8JMs2uEpPNx0FaG8UYxO6dJknaDrLzacQVyvUjLLKoU
f7kGrnKFC4hkTiMlHxb7AXIbk5Duq8wmhMjijFlUdAJCq9xUonLxDbR5BJhgER10quloosSb
UXD5/eRGCzSg4IpwPBxhwTAMGjWCgY7qj1yYkROjB3pTcNSnwR2aC8Ugmg7wvtJCcLiZ4wOu
VI0KyZKOPyOZhevA57Ir1lJGEM3jms41kXuxKrIwgfwvlqhAX47bn73i+H7aIrmWWX1FTutw
MhgPtYUWLEsE6kV+C+2OE3i0BltvtlfK25FhxynjOGDNUOogYeSlmMZEqEGIqu8UoE4RLESi
3WF32m97QhWSbZ53XDWvOBp0MtInpKr8CF/iWlzU8kriGycxUhQlOx6qufJADiFXgQpRpZpK
G97GfPd6vOzeTsct9iyeB+DWCUn00FFGCotK317Pz/bs51lcaAkpOAB0zpgPjUA2SiDFGkWv
vBXbIKHjSgTxb0KAvx+eVvvTTlGCdzegpBZjg4mBLcWDCH4gKmUD8Vvxcb7sXnvpoUd/7N9+
753hWfA7m+DOBkPoDl5fjs8MDBGx1bGVSgEELcqxCndPzmI2VmSYPR03T9vjq6scihfOSOvs
ry5O98PxFD64KvmMVLxS/SdeuyqwcBz58L55YU1zth3Fq7NJ6zK0lvZ6/7I//GvU2Sko4Blg
SSt1aWElWofgX5r67oYHaX+WBw/tc4z42ZsfGeHhqO+zBsnYgKWMJJMy4TvG36xU6izIeaTi
RE1uoBEABw5pSnA0PCIXmZHkQisPWdGWtjGS7I9leNR1vckx2T2orYFHkwMS/HvZHg/SCc+3
Dx9BXpN1NkDTATb4WUEYu6Ddwg3GKd80+FYcGo6meJDehpBxJP3R+A4PhdXRDIdj/LrtSLgN
xDWarEzG/TEufzQkeTmZ3g2xx62GoIjH45sBMiDSKQJn09lZ7wiIEzqKJI7khkvGseJ6PMaz
dOuB/QBZRM/HDkBX/nrAiSQTiwiMRaG2VxUJD4mzUvOpBXD4UNwObrARAyy3ORqaZaKsKJxc
fkdwhclfxcKCR2VleZejwYRmkS8vlTB/6G3ZcYK43ucPwOjoT62MY0OtEiFnFIEifyvZhay6
lUnNwPEPn6Y8ANcj9qPM0yjSTTEEzstpXJQe/KKo9lmQNSkEFB8lAYfQjdz4RQ5CtnhkDNG3
Mz9guxGQeVKE948NZNwgE5Z9Dc29IBjTCsB24D0a1/dpQrjHk46CaiD+D/jwl2meB3oaSRUN
H8IXhEJUhEGOxgTSiEikxvEBFCzeMF5P4gdopI6LGZceYZ0FZLYm9WCSxNw7y4GCbpu9ikmW
LdIkqGM/vr1FExoBWUqDKC3hncHX0x4Akr+MC88wR3GFQrchB6RUuUDznAPLzZ4HfVf7xBrj
Ykoae6k+AB0yiGOqbg19xSlfhAuTEsycPKaaEQf76Xh2BEyUte7e2e4EHsmbwxY8gw/7y/GE
pTW4RtZuH6K8H7AfNdUN0xuQ8wgF3z3DFnokJY56lRuG98YbmDyDEj9PdX+LBlR7IbwZ2PoT
8yFMMhpEseBM2LURaz5+ABA3BH79CDw82BQ+wc7gnKfgzeoAZJiWi1+sepfTZgtu8NaRW5Rq
GqYyBrVkCS/F2tbqEKx1tZrEjiFE1m2NlkkTOdv0DFKAC/Ergmtt1RTBU+TOUAJ7SYhpfd3C
HflBWvy8XKDlihKLbNWi2SbFGqEGvWqhXQp1GRTGHu72QTCba+/yjSFRBivIranj+TXieS7J
6dLx+AB0Xh768yv1+DPs9prpKZfYTxnepU4M3wSFpAmbxO2aXxGEFpdIgRMeu0pHFVrMPQ7x
AuM5lQFTqtmClAHWNq6nZULFmvvciId/xXUD80ioIMn0/G46wA2sAG9ykgqqtZCQBgLI1xR5
Ic3UdJmQHFb7BUyKNBbvhL4ojA3mRVvWObXVwQ2aMtm+5EyNHEi2DR8q4vv6WdppmkoKuQYz
8MHGh8MKayBtkHTphg/xbM9kZ3HtqJZ5lNBFUK/S3G9sGjUjFxKF8GbL5pxJZHmBRh0BXFqE
bOaoklkoWIPeSnUQlpDaAxUeG30FB1ZeNYANWwwQReGV+1GjwLcV2JrQ/DErQ9S2huGXjH8r
lTOyBZnWjR3Cq0K2iBMIip4QmAi10QViYCZA6KnGMdJ+WtZB2joayEOVlrrFAADA1Ip7uvNF
Bi9XON8CLm5NiRXJE9dgCQq3S/jDLC7rJR5hWeAwNwVeKy2VVQARmGbFSHPsFTANNKsgUKgy
tFTEWZDLUFg6qQSQCjwij1otHQyiM4Y524Y1+4cV6ghItCLsMp0xgSNdoaTAW6xRTByw7qZZ
a9ZEN9sfqtnrrOC7S53MBgSWOCV+ikgKyFOYznOUwZA03aVnIFLvH+gchNbCFdWipYJNPO/e
n4697+x8sI4H0MHWhqQMoHtHbB6OBBFLXQQcmIHLf5wmITiH6Ch21kU+k3/MEhAfD0KlwVip
odVEoaziUmCZK1+6D/JEXSVSzJfXVJzpfeGA7vRCOiQo1qQslVYvqjnbjZ5adQPi3VQewgIw
4KE546+0Byv4J7aAKhnY89DWExbCEla8oar7IAc/M7mdOs0LPwhxR2rK1pTa9AwCMijcofgN
+v4Ijv42GahJEH1NryFHV5EL6kZPRgM1BWm38gT6a1H6LR5bg4LsSg1m1+TbBn6k2r39NfrR
VfprI9Kmdrabro7N59VaFX55+d/ox/aLVW0jIrhr4m8oxpJhco7CK7ILCtLu4ss0katd+b0c
GL+19zYBcexKjtQiwQhIjd9YPMBe4hLneNP4senEw/UkLFjZBY+tOUkEBxBksE6MvspohpWf
Yb4djATTuLPTHyxUGCeSKpF+gAkyf8JoaB9so1jKk7BK8oyav+u5uv0YoAg4rL7PvbFmrirI
ZTfChBEyZgg4LrDdduR1bAo5uQwaZAvHGRXq5xn8FncmxndwLBhVr7qWtQbHeh2rgMATNoTf
xGMVcKoqg6Dpbjy/D1wNsS7lDoormzo8CPEZBCDHB1QQ/kL7rq1nmvqkduwFwsuiqGmGz1Si
eu2wH91Rsz8fJ5Px9M/+FxUNqQ44LzAaak5/Gs7I/4GS3I3177aYiZq1x8AMnGXctd25aru9
cZW57TsxA2dtQ2eZkbOMs9W3t07M1FHbVM2UqGPGrp5Oh64RnY6mrhbcjXRMWKSwUOqJ4/P9
gXNGGaqvo0hBw1A7W5UvYGY6Kt6YHAkemgtVIrBUKip+7CqI2eeo+Du8IVMc3Hc2sP9ZC9Vs
YwC/T8NJnZvjx6G4wS+gwdEsT2M0Ap7E0wDiJugTL+BMoK304DYtLk9JGV6v9jEPowireE6C
SNf8t5g8QGO8S3xIIZqfj7UoTKoQZ/u0cbje5rLK70M1vAQgqnI20RQJkSOAUxJSV5gSTcUj
LEd22/fT/vJhO9fx7B8f6i8mTj1UEPbPElqbuNBspoAQ/H+wm8Drau0ELAjrHvjuK61R2Vwj
YYjaX9SQFJpn0UDdeODS54qcOCj4a1+Zh1TjsSQJzqo0SPSK4ydNKRgfxiWLVB66YeKC5H6Q
sF5U3Jcue+TsCCWasGsRacZtVg0zVgX4hyMtsomhjUVGtLjlM8ZlgsZJqPqxUWMMFQ+sGOQQ
+mYRRJmqm0LR4DG9+PvLX+dv+8Nf7+fdCWLO/vlj9/K2O7UXvbQV66ZF9U2NipgJIsftz6fj
fw9/fGxeN3+8HDdPb/vDH+fN9x1r4P7pj/3hsnuGpfvHt7fvX8Rqvt+dDruX3o/N6Wl3AMV+
t6qVSDW9/WF/2W9e9v/j4ZSUd22wsWWdovd1kibaCucosPqAWXP4wlvEM3aOOGmlChpvkkS7
e9QaAJk7uBPj2b5JW9XT6ePtcuxtIfjy8dQT86FYQHJi1r25ZmOogQc2PCA+CrRJi3vKAwc7
EXaRhRZiRwHapLnqcdjBUMKWAX01G+5sCXE1/j7LbOp7Na+NrAEkbZuUXQVsX9r1NnAtmEiD
qnAlu16wFcS4E7NV/XzWH0ziKrIQSRVFVtsBaDed/0NmvyoX7MzWZDOBQV27s/dvL/vtnz93
H70tX6HPp83bjw9rYeYFsT7lL5CvBNR3yG0Sn/sFZgUhl2M8sAaAnVHLYDAe96fymYq8X37s
Dpf9dnPZPfWCA2872329/+4vP3rkfD5u9xzlby4bqzOUxtY35giMLthFSwY3WRo99iHVqb0a
SDAPi/4As0OTHQoewqVVdcAqZsfUUnbI44bJcFSf7eZ61J79mWc3t7QXMkVWX0DtslG+QiYz
RfMGNcgM2mWXWaNO+3JrBo+rnGRIMQJeyGXlMF1vGg4mh9YSXmzOP1wjp4VckCcYAM3+r8Ug
m19cGoEphInj/nl3vtgfy+lwgFUiELZJMUr3KQEb94gdHe4xXq8XRjqsBuFF5D4Y4KZ5GsmV
CWRNKPs3Wj5guYHQ60LZOsZB6Y+sKmJ/jDQ7Dtle4VZOmH2bPJ9iv69mqlbAavStDjwY3yJT
xRDDAWZQJDfzgvTtG5SdEeNbDDzuIxfxggytBhUxAisZ++Klc6SZ5TzvT1FFm8CvMvhyc7RQ
HhnY3hxEt9rqoIbRNEaRhE4L+XYlpSvwXLK6JRFWsCm5wgg4LoUEQYDoY6hNFZy9xgBqzwtY
q5l1z/h/ZPEVJCrItRUh7wh7noM8M0wGdUxdFMGgHk9wE+N2YeBRbuRCWKUwlr9AYn5ILI3j
69tpdz5rXHg7TPwNxr4pvqYWbDKyL+3oq73B+SuKNVLwXiTZ5HxzeDq+9pL312+7k3CRMYQE
uQqTIqxphjGefu7NRcAL8/scsxCXgjlOAufUOitEFFctdxTWd/8JIYhVAGaz2SOyIoCnBOei
T7/fEkqu/ZeIc4eRgUkHkoO7Z9A2CJplijQv+2+nDROhTsf3y/6A3MJR6DWHDQLPKbJMGKK5
iZQgw04aFCf25dXiggRHtRynElnnGhmKxk4agMtLkXHV4dfg7/41kmsdcF6uXe805tUmaq8u
c00sVshCIMVjHEOSMcp1PvCw1NWqILPKixqaovJ0svX4ZlrTABQfIYU3XmG2pGmz7mkxAUuZ
JeChFqdpE5Desb1eFKACaqvSsDxTBmSWUIzH5qCbyQJhtASWRLwxYeeFQnenC3jwMCHizENA
nvfPh83lnUnv2x+77c/94VmJqZv6FUQUDrku7O8vW1b4/BeUYGQ1k63+87Z7bXUv4u1V1bzp
AXtsfPH3F+VFuMEH6xJsHLuRxLVuaeKT/BH5mlkf20wQ6rBoVYi4XcovjIsI8ug8FSAOEslr
bhehWjkQaVzWALyQMUAQA0pZPdLEn/FGCQUVXM6NyNVJV0miIHFgk6Bs0nVbqFmY+BBGh40E
a4K2N9LcR5lQyFXK82V4ELuye6/lS4pE9jcgZFeYxiSzUQa4zUUIOWikxeb/VXYsu3HjyF/x
cQ67gZ0xvN5DDnp1t6allqyHu+OLkE2MIMg4E8Q2kM/felCtKrKoyRwMuFklihTJelexlFMi
DPRtwwGkWwcHtsLKA5+BzlsOg2q68s59NrFkb3IAGNcwTrqD3996P89l2zSLIwgQhCJ9b5c1
ViiWQ8QhJN2R43S8J9PSDOfssptrNUL9S5c0LVNW0+yObgUBOzlFZ4leSA55U4vpG32okJkn
2ZoXYfsD0mZgtZUKS3pgnuKJZXaUD7aKnhfTrhn248X7KGyrFxXh4zVb+KeHiWNo1W93tb1u
ozSLVgloDlJ6FR81NOlq4xloHXZwLM1t53CwtJW17A6cZn8Eg9SXMi0znrYPZWsCUgC8NSGn
B7MZxeyANhg+C9AR8X62qlG6lGxFF86t/QC+UIAodPU+qSbUPCVn75usBKJyX8AH7RLBSZEw
AcEqar8JA2gmRciwXVXVpHqhMsb4QCNjAFBuzEnQMCrAmbTk95Dj67jk55TkeTcN0801023x
HphnlVAY1Y7kcMFtj3MNvcWzh11hRlUkV6bfVrwSgpzsimy/xCCLl98J6n+odJhiVj2g20os
QHeHQp14pG5LVTwWfmxyMfyGbjrfAtvu1LLAUs2b5j7vja20LQasptxs8sRIocNnJknfFWAg
bicDrRtUZ/3Leqn19ufVjddEt74WVZEN3hqS6+eYyGIj1JQXbSOXbEDxRDMbJ54EUod2S81y
G7V+//Hl28vXC1A4Lz49PT5/Dl2wFKy9p+kq+ZSbMcLHdgVwrB7eel+BAFOdHR7/iWLcjWUx
vLs+r7oTaIMerpdRYJ2+eSh0d65J4+brf+MxXgojdqUniBZpgzJ90XWALjc4PQZ/91gTzl2+
51Yj+oXPxocvfz7+++XLkxMenwn1I7f/CNeD3+VU0KANQ8bHrMhN2ExXC5WeJhB6kKosxi1Q
8mPSbYQMsc1TrA1dtoMypBUH8vzUI5qrkC5Y8eEdfERKAHh3dflWrCru7RYoLua3mVV9OtDR
qX/AkW/dFZjo23PVpcoyzPFMQCVA6RAjluuEL0BZlAUFoeFNzaF6H36yTYO5afNdQFiKcHsA
emEW16Sptk2pc2tkPxzzdy6ivigbv7pDVOkVd9rzx/+9fqY7bctvzy8/Xp90DeQ62ZYUCU+J
0WHj2W/My/nu8ueVhcVVNu0eGIYOoBFze1GJ05PvjQ87x0muraGLVyW8GpOWVvpBR7oZoEDM
HFZ5D9tYPo+/Ld1/1kPGtE8OIIsfyqF8KPAt8mmCmprjLy2PnicH64aTw2j7wJbpHPnnfmXa
GgWI4EXlhz5Wbo57RkRi7XbkOHbTHA+2KYIsEE2JZda0gq0hsCL89awcJA+VLhXzjkzX5MmQ
eCLoeXUY53jyn5ItZyV0wGhWoYHTb69wuWt0qcB+t5zGEmteWHQEvmE501uEGUq3PZgVwBUa
BrXHXtBlI1HGGByIDuapBJl/GstR9JkJXwlyXY1pmCokz5jbySAiV0DlwsnOkJVNyRExI0oE
dmwUXjzvsIpDHmU63Nt97U/zviY/pwsq80FdajS2W9BCt310A7p7A8LpOsDKbLneCMXwrGDt
yq1fbjn86vRJMB1sw6lj1nedwZYcl9GM9gkSvNAOy1DcfXyqF5IIasic16KjjBbi5DHlHdfn
YPcyIl00f31//tdF9dfHr6/fmevtPnz7LIVTvGcDo5wapUSpZswPHYWBmYEk94/Du8uzUtFk
+xHP+ADbXSqXfbMZQqASQUF5TmqJ2Pr3f/wtshvl5bKCXe69leoZSf0mwLDHJRD/flw+8nlc
Yt/gy6YdlqYYkt46ZMc7kJtAesobYcokEzR3LbWV9ZXm+FAQez690k1ugrGpg++lxnKjFpKp
jciU3JRW3/4Zwb2yL4rWsweziRdDVhY+/tvz9y/fMIwFZvP0+vL48xH+eXz5+ObNG3nVTDPf
hkeFzo1cm7bDqyGMTGLZA04m4IxoHx2KUxHwo7ksod8eQT8eGQLkvTlSOKX/pmOvsqe4lQbm
GQYo+adoQ+LjAFEyPd89UxWxp/HzkStw5a4MGhKcDjRKTE5ZnjfqeZILkxYsZaMeMyW6f7L+
Sp8fMG1Kvo40DfhyeNFhUeSwf9mmusIA9sycw+AcOlNfWcj89OHlwwVKlx/RQxFokujt8Bex
tRr7bbgElBZeegLKQoJQfDhMJKqBQNWNQda7RwUiI9bjyEDFLbCkLvkt2GGejRZp8NZ8sVWD
QISVmcJlFQhrD3fFJtKBQqMljnRf3Bk5WDQwiglXWXXmF9Nz9s7unVMqO/9OrgTE/+z90AiJ
lzzfy5YMTVgkTJzVXELqYlAYdruzcWYby2be+XHgdCyHHZr0+l9AcynyaIny0R1aTaIt9Ie+
Kw8F08Dx0BEmKeh+J5l7kHsR/Iz6zjRJJaMc3xdvNjqFtD9KqzD2FOEDm9geQgZR5qCJ7bLy
6vf/XpPBFuVFRcESLJdo0UQhqlKhoNKpyto05PYi4wRU5uftjXnq6LuALEfScbidPPgBKxT5
OEXSVe9nwx4W/FqcD7c3k7OykdQiqy/LpyJ94V3I8ddMp1yGmTruX6WbapRhfbQtsIyLf2AW
rwqMEv0YWO/JcogtUfoN2y2ny9OtXdhQYMRq4M8YY2AC9TFcRoGaH9tQUfjToXDtWukNfhSD
eSImV2YPdbnmD+SvRJaaVhXl5ULjyP2j/ofxcORyWr5p7Uwg9faUNvDh8fkFmTWKmRmWHP3w
+VHkHOHLFxGBfoaqPzf7zIFbixOduzhzYDQiOxGZZWasaGsGyb88/MGGSVWmrrbRjO6aDRGx
eNcqjYxuJfzlvs+03x/q4vAgG6IELPQtKau+SkybKYDYFuSJk153ZqISPbxB0c7sWXcgLJH6
8cP6RCTX3JSVMp44zRj04ay5dzRPprZ3wEvQg4QbgK9Y0jd3Vft8iNyfTnoUxqj0QHXiKHV5
oHvg4hjR5/fAXdKidya6+D5OF6EBTvmKMJSiM3UFLt2xcVopPbNxNGfOitAcVilurk2Jn77K
rjihtW/ls7HrjTPNrMM7Y/WZDnTkICwADGZ5dQITMxJaPjWm5cBuZN3VOJY2RyDoidzUcbhl
9NEYHQZ5UEphHCcarEnQMreyXHgH70WuyTxLtOL4H+y+DozR6iOg+Jo1xpdOW/vOJAZipNeu
IYumfQMrhUDBmKYUROZdnXS2eZJ625RdjbdQrWwaKjdkmV7Kga7+8vkOP6D5zEwbKEDNBIio
soA5wZv6+LHhjxmTINyWplRLCsbzPzYIiFkC23ft2FBwW8SiOXeyjkDJjJRFGhsjShJibNBj
VHVflQaC3Ed2m/8fP9wRnYwFAgA=

--opJtzjQTFsWo+cga--
