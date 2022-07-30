Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5A5858EA
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jul 2022 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiG3GyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jul 2022 02:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3GyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jul 2022 02:54:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28820DEC2
        for <linux-pci@vger.kernel.org>; Fri, 29 Jul 2022 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659164040; x=1690700040;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vPUzb5p6CVhPeXa9SFOrsy/WZQ/mfX+6MNlHTTFO8No=;
  b=OLXYBRo1toq9GldmV5iMdwbCJN5rlTtrgcI8PbjGGPXLyEK+3OjLIMBf
   fOfuCbjCaSQhid65NedBPHQBg1UQov6fBhG2uO2qfcHj3CUqAnsG+QGba
   O2rIr0ZXlQC3g9zFvoO17na2kV7XOfaWg3d/2LPNGkscxF6ic8Apdtvdk
   JXBJeDiQyHZyPMRuCV5oe/M3BgJ79hDVcu2QWE8zp3R7Jx+Jbfmpz82Dt
   zTKRB5jVcsgc7CiAjCfH7yBwOUgvFEi3PV81V+gD96EBCbieNCeSDS8dj
   8/CDIvCI90KVj3WQdbamBXiuVEdtGjZGAp76/X5kAQitU/trkXcAbST4E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="375201067"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="375201067"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="669494439"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2022 23:53:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHgMD-000CYd-2T;
        Sat, 30 Jul 2022 06:53:53 +0000
Date:   Sat, 30 Jul 2022 14:53:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [helgaas-pci:pci/header-cleanup-immutable 2/6]
 arch/x86/kernel/cpu/cyrix.c:277:3: error: use of undeclared identifier
 'isa_dma_bridge_buggy'
Message-ID: <202207301404.VdeSPptt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/header-cleanup-immutable
head:   933c5a4f87d92a865d1db76caf190f1a4a1927f9
commit: abb4970ac33514c84b143516583eaf8cc47abd67 [2/6] PCI: Move isa_dma_bridge_buggy out of asm/dma.h
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220730/202207301404.VdeSPptt-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=abb4970ac33514c84b143516583eaf8cc47abd67
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/header-cleanup-immutable
        git checkout abb4970ac33514c84b143516583eaf8cc47abd67
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the helgaas-pci/pci/header-cleanup-immutable HEAD 933c5a4f87d92a865d1db76caf190f1a4a1927f9 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/cyrix.c:277:3: error: use of undeclared identifier 'isa_dma_bridge_buggy'
                   isa_dma_bridge_buggy = 2;
                   ^
   1 error generated.


vim +/isa_dma_bridge_buggy +277 arch/x86/kernel/cpu/cyrix.c

^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  190  
148f9bb87745ed arch/x86/kernel/cpu/cyrix.c  Paul Gortmaker       2013-06-18  191  static void init_cyrix(struct cpuinfo_x86 *c)
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  192  {
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  193  	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  194  	char *buf = c->x86_model_id;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  195  	const char *p = NULL;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  196  
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  197  	/*
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  198  	 * Bit 31 in normal CPUID used for nonstandard 3DNow ID;
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  199  	 * 3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  200  	 */
1d007cd5aeea2c arch/x86/kernel/cpu/cyrix.c  Ingo Molnar          2008-02-26  201  	clear_cpu_cap(c, 0*32+31);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  202  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  203  	/* Cyrix used bit 24 in extended (AMD) CPUID for Cyrix MMX extensions */
1d007cd5aeea2c arch/x86/kernel/cpu/cyrix.c  Ingo Molnar          2008-02-26  204  	if (test_cpu_cap(c, 1*32+24)) {
1d007cd5aeea2c arch/x86/kernel/cpu/cyrix.c  Ingo Molnar          2008-02-26  205  		clear_cpu_cap(c, 1*32+24);
1d007cd5aeea2c arch/x86/kernel/cpu/cyrix.c  Ingo Molnar          2008-02-26  206  		set_cpu_cap(c, X86_FEATURE_CXMMX);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  207  	}
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  208  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  209  	do_cyrix_devid(&dir0, &dir1);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  210  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  211  	check_cx686_slop(c);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  212  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  213  	Cx86_dir0_msb = dir0_msn = dir0 >> 4; /* identifies CPU "family"   */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  214  	dir0_lsn = dir0 & 0xf;                /* model or clock multiplier */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  215  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  216  	/* common case step number/rev -- exceptions handled below */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  217  	c->x86_model = (dir1 >> 4) + 1;
b399151cb48db3 arch/x86/kernel/cpu/cyrix.c  Jia Zhang            2018-01-01  218  	c->x86_stepping = dir1 & 0xf;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  219  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  220  	/* Now cook; the original recipe is by Channing Corn, from Cyrix.
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  221  	 * We do the same thing for each generation: we work out
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  222  	 * the model, multiplier and stepping.  Black magic included,
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  223  	 * to make the silicon step/rev numbers match the printed ones.
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  224  	 */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  225  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  226  	switch (dir0_msn) {
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  227  		unsigned char tmp;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  228  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  229  	case 0: /* Cx486SLC/DLC/SRx/DRx */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  230  		p = Cx486_name[dir0_lsn & 7];
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  231  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  232  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  233  	case 1: /* Cx486S/DX/DX2/DX4 */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  234  		p = (dir0_lsn & 8) ? Cx486D_name[dir0_lsn & 5]
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  235  			: Cx486S_name[dir0_lsn & 3];
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  236  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  237  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  238  	case 2: /* 5x86 */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  239  		Cx86_cb[2] = cyrix_model_mult1[dir0_lsn & 5];
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  240  		p = Cx86_cb+2;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  241  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  242  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  243  	case 3: /* 6x86/6x86L */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  244  		Cx86_cb[1] = ' ';
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  245  		Cx86_cb[2] = cyrix_model_mult1[dir0_lsn & 5];
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  246  		if (dir1 > 0x21) { /* 686L */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  247  			Cx86_cb[0] = 'L';
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  248  			p = Cx86_cb;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  249  			(c->x86_model)++;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  250  		} else             /* 686 */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  251  			p = Cx86_cb+1;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  252  		/* Emulate MTRRs using Cyrix's ARRs. */
1d007cd5aeea2c arch/x86/kernel/cpu/cyrix.c  Ingo Molnar          2008-02-26  253  		set_cpu_cap(c, X86_FEATURE_CYRIX_ARR);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  254  		/* 6x86's contain this bug */
c5b41a67505cc3 arch/x86/kernel/cpu/cyrix.c  Borislav Petkov      2013-03-20  255  		set_cpu_bug(c, X86_BUG_COMA);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  256  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  257  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  258  	case 4: /* MediaGX/GXm or Geode GXM/GXLV/GX1 */
ae1d557d8f30cb arch/x86/kernel/cpu/cyrix.c  Christian Sünkenberg 2017-06-04  259  	case 11: /* GX1 with inverted Device ID */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  260  #ifdef CONFIG_PCI
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  261  	{
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  262  		u32 vendor, device;
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  263  		/*
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  264  		 * It isn't really a PCI quirk directly, but the cure is the
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  265  		 * same. The MediaGX has deep magic SMM stuff that handles the
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  266  		 * SB emulation. It throws away the fifo on disable_dma() which
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  267  		 * is wrong and ruins the audio.
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  268  		 *
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  269  		 *  Bug2: VSA1 has a wrap bug so that using maximum sized DMA
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  270  		 *  causes bad things. According to NatSemi VSA2 has another
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  271  		 *  bug to do with 'hlt'. I've not seen any boards using VSA2
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  272  		 *  and X doesn't seem to support it either so who cares 8).
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  273  		 *  VSA1 we work around however.
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  274  		 */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  275  
1b74dde7c47c19 arch/x86/kernel/cpu/cyrix.c  Chen Yucong          2016-02-02  276  		pr_info("Working around Cyrix MediaGX virtual DMA bugs.\n");
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16 @277  		isa_dma_bridge_buggy = 2;
cefc01130ba2bb arch/i386/kernel/cpu/cyrix.c Andreas Mohr         2006-06-23  278  
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  279  		/* We do this before the PCI layer is running. However we
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  280  		   are safe here as we know the bridge must be a Cyrix
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  281  		   companion and must be present */
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  282  		vendor = read_pci_config_16(0, 0, 0x12, PCI_VENDOR_ID);
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  283  		device = read_pci_config_16(0, 0, 0x12, PCI_DEVICE_ID);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  284  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  285  		/*
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  286  		 *  The 5510/5520 companion chips have a funky PIT.
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  287  		 */
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  288  		if (vendor == PCI_VENDOR_ID_CYRIX &&
8bdbd962ecfcbd arch/x86/kernel/cpu/cyrix.c  Alan Cox             2009-07-04  289  			(device == PCI_DEVICE_ID_CYRIX_5510 ||
8bdbd962ecfcbd arch/x86/kernel/cpu/cyrix.c  Alan Cox             2009-07-04  290  					device == PCI_DEVICE_ID_CYRIX_5520))
5a90cf205c9227 arch/i386/kernel/cpu/cyrix.c John Stultz          2007-05-02  291  			mark_tsc_unstable("cyrix 5510/5520 detected");
120fad72401ebe arch/i386/kernel/cpu/cyrix.c Alan Cox             2007-02-13  292  	}
cefc01130ba2bb arch/i386/kernel/cpu/cyrix.c Andreas Mohr         2006-06-23  293  #endif
d9f6e12fb0b7fc arch/x86/kernel/cpu/cyrix.c  Ingo Molnar          2021-03-18  294  		c->x86_cache_size = 16;	/* Yep 16K integrated cache that's it */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  295  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  296  		/* GXm supports extended cpuid levels 'ala' AMD */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  297  		if (c->cpuid_level == 2) {
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  298  			/* Enable cxMMX extensions (GX1 Datasheet 54) */
18fb053f9b827b arch/x86/kernel/cpu/cyrix.c  Matthew Whitehead    2019-03-14  299  			setCx86(CX86_CCR7, getCx86(CX86_CCR7) | 1);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  300  
2632f01a66d75f arch/i386/kernel/cpu/cyrix.c takada               2007-02-13  301  			/*
2632f01a66d75f arch/i386/kernel/cpu/cyrix.c takada               2007-02-13  302  			 * GXm : 0x30 ... 0x5f GXm  datasheet 51
2632f01a66d75f arch/i386/kernel/cpu/cyrix.c takada               2007-02-13  303  			 * GXlv: 0x6x          GXlv datasheet 54
2632f01a66d75f arch/i386/kernel/cpu/cyrix.c takada               2007-02-13  304  			 *  ?  : 0x7x
2632f01a66d75f arch/i386/kernel/cpu/cyrix.c takada               2007-02-13  305  			 * GX1 : 0x8x          GX1  datasheet 56
2632f01a66d75f arch/i386/kernel/cpu/cyrix.c takada               2007-02-13  306  			 */
8bdbd962ecfcbd arch/x86/kernel/cpu/cyrix.c  Alan Cox             2009-07-04  307  			if ((0x30 <= dir1 && dir1 <= 0x6f) ||
8bdbd962ecfcbd arch/x86/kernel/cpu/cyrix.c  Alan Cox             2009-07-04  308  					(0x80 <= dir1 && dir1 <= 0x8f))
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  309  				geode_configure();
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  310  			return;
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  311  		} else { /* MediaGX */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  312  			Cx86_cb[2] = (dir0_lsn & 1) ? '3' : '4';
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  313  			p = Cx86_cb+2;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  314  			c->x86_model = (dir1 & 0x20) ? 1 : 2;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  315  		}
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  316  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  317  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  318  	case 5: /* 6x86MX/M II */
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  319  		if (dir1 > 7) {
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  320  			dir0_msn++;  /* M II */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  321  			/* Enable MMX extensions (App note 108) */
18fb053f9b827b arch/x86/kernel/cpu/cyrix.c  Matthew Whitehead    2019-03-14  322  			setCx86(CX86_CCR7, getCx86(CX86_CCR7)|1);
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  323  		} else {
c5b41a67505cc3 arch/x86/kernel/cpu/cyrix.c  Borislav Petkov      2013-03-20  324  			/* A 6x86MX - it has the bug. */
c5b41a67505cc3 arch/x86/kernel/cpu/cyrix.c  Borislav Petkov      2013-03-20  325  			set_cpu_bug(c, X86_BUG_COMA);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  326  		}
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  327  		tmp = (!(dir0_lsn & 7) || dir0_lsn & 1) ? 2 : 0;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  328  		Cx86_cb[tmp] = cyrix_model_mult2[dir0_lsn & 7];
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  329  		p = Cx86_cb+tmp;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  330  		if (((dir1 & 0x0f) > 4) || ((dir1 & 0xf0) == 0x20))
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  331  			(c->x86_model)++;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  332  		/* Emulate MTRRs using Cyrix's ARRs. */
1d007cd5aeea2c arch/x86/kernel/cpu/cyrix.c  Ingo Molnar          2008-02-26  333  		set_cpu_cap(c, X86_FEATURE_CYRIX_ARR);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  334  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  335  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  336  	case 0xf:  /* Cyrix 486 without DEVID registers */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  337  		switch (dir0_lsn) {
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  338  		case 0xd:  /* either a 486SLC or DLC w/o DEVID */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  339  			dir0_msn = 0;
a402a8dffc9f83 arch/x86/kernel/cpu/cyrix.c  Borislav Petkov      2016-04-04  340  			p = Cx486_name[!!boot_cpu_has(X86_FEATURE_FPU)];
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  341  			break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  342  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  343  		case 0xe:  /* a 486S A step */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  344  			dir0_msn = 0;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  345  			p = Cx486S_name[0];
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  346  			break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  347  		}
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  348  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  349  
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  350  	default:  /* unknown (shouldn't happen, we know everyone ;-) */
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  351  		dir0_msn = 7;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  352  		break;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  353  	}
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  354  	strcpy(buf, Cx86_model[dir0_msn & 7]);
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  355  	if (p)
adf85265b455f0 arch/x86/kernel/cpu/cyrix.c  Paolo Ciarrocchi     2008-02-22  356  		strcat(buf, p);
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  357  	return;
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  358  }
^1da177e4c3f41 arch/i386/kernel/cpu/cyrix.c Linus Torvalds       2005-04-16  359  

:::::: The code at line 277 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
