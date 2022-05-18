Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6252C1BA
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 20:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiERSEx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiERSEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 14:04:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80F1E389D
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 11:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B73C4B82180
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 18:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAD9C385A9;
        Wed, 18 May 2022 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652897089;
        bh=0ubs4ekni+Wl9XbnkoKIXnSy4SRin4z/5b5T1RY/5vU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j2rkl5+VhYwjwkw5kd71dN1vtEcBTGyzHR919/d91vnaIkAqLOFOYSuzy1z7Q/T/I
         wygq34q1GKj2hJ2BIukS07Lx0fMlfaK5gUXqIoYpE6WdKLeGdJfaqVdZOyIGEBKrtz
         5YBU3QmkwzoncTk/0OZWZccqiOESvu3BjQPpYHs+iBOp+Nxbl8qm2iFSZLH1dD8nFc
         U9CpSiIYyGCjARTtG0/7MNu0CdsL1UhmV4eA7FiipLb+h00VcwiBtHyeyJ2ouBmfW8
         DvlVxWi0IUY37xhWexXSdqqlAFwB/nDc4CraKmkY+mHOq4fQu73iWHrC79HZpqE8Vw
         ey/d2OdVRYIDw==
Date:   Wed, 18 May 2022 20:04:43 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kbuild-all@lists.01.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [lpieralisi-pci:pci/aardvark 2/2]
 drivers/pci/controller/pci-aardvark.c:1071:54: error:
 'PCI_EXP_SLTCAP_PSN_SHIFT' undeclared; did you mean 'PCI_EXP_SLTCAP_PSN'?
Message-ID: <20220518200443.3a3d3e10@thinkpad>
In-Reply-To: <202205190153.mz8wMTVG-lkp@intel.com>
References: <202205190153.mz8wMTVG-lkp@intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

seems that patch 04/18 is needed. Was it merged into another repository?

Marek


On Thu, 19 May 2022 01:26:22 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/aardvark
> head:   bf8dd34079057e2c761eb914b70b49f4a455fc18
> commit: bf8dd34079057e2c761eb914b70b49f4a455fc18 [2/2] PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
> config: ia64-buildonly-randconfig-r003-20220518 (https://download.01.org/0day-ci/archive/20220519/202205190153.mz8wMTVG-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=bf8dd34079057e2c761eb914b70b49f4a455fc18
>         git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>         git fetch --no-tags lpieralisi-pci pci/aardvark
>         git checkout bf8dd34079057e2c761eb914b70b49f4a455fc18
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/controller/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/ia64/include/asm/pgtable.h:153,
>                     from include/linux/pgtable.h:6,
>                     from arch/ia64/include/asm/uaccess.h:40,
>                     from include/linux/uaccess.h:11,
>                     from arch/ia64/include/asm/sections.h:11,
>                     from include/linux/interrupt.h:21,
>                     from drivers/pci/controller/pci-aardvark.c:13:
>    arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
>    arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
>      127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
>          |                                                ^~~~~~~
>    In file included from include/linux/byteorder/little_endian.h:5,
>                     from arch/ia64/include/uapi/asm/byteorder.h:5,
>                     from include/asm-generic/bitops/le.h:6,
>                     from arch/ia64/include/asm/bitops.h:446,
>                     from include/linux/bitops.h:33,
>                     from include/linux/thread_info.h:27,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/ia64/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/rcupdate.h:27,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from include/linux/delay.h:23,
>                     from drivers/pci/controller/pci-aardvark.c:11:
>    drivers/pci/controller/pci-aardvark.c: In function 'advk_sw_pci_bridge_init':
> >> drivers/pci/controller/pci-aardvark.c:1071:54: error: 'PCI_EXP_SLTCAP_PSN_SHIFT' undeclared (first use in this function); did you mean 'PCI_EXP_SLTCAP_PSN'?  
>     1071 |         bridge->pcie_conf.slotcap = cpu_to_le32(1 << PCI_EXP_SLTCAP_PSN_SHIFT);
>          |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
>       34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
>          |                                                   ^
>    drivers/pci/controller/pci-aardvark.c:1071:37: note: in expansion of macro 'cpu_to_le32'
>     1071 |         bridge->pcie_conf.slotcap = cpu_to_le32(1 << PCI_EXP_SLTCAP_PSN_SHIFT);
>          |                                     ^~~~~~~~~~~
>    drivers/pci/controller/pci-aardvark.c:1071:54: note: each undeclared identifier is reported only once for each function it appears in
>     1071 |         bridge->pcie_conf.slotcap = cpu_to_le32(1 << PCI_EXP_SLTCAP_PSN_SHIFT);
>          |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
>       34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
>          |                                                   ^
>    drivers/pci/controller/pci-aardvark.c:1071:37: note: in expansion of macro 'cpu_to_le32'
>     1071 |         bridge->pcie_conf.slotcap = cpu_to_le32(1 << PCI_EXP_SLTCAP_PSN_SHIFT);
>          |                                     ^~~~~~~~~~~
> 
> 
> vim +1071 drivers/pci/controller/pci-aardvark.c
> 
>   1028	
>   1029	/*
>   1030	 * Initialize the configuration space of the PCI-to-PCI bridge
>   1031	 * associated with the given PCIe interface.
>   1032	 */
>   1033	static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>   1034	{
>   1035		struct pci_bridge_emul *bridge = &pcie->bridge;
>   1036	
>   1037		bridge->conf.vendor =
>   1038			cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
>   1039		bridge->conf.device =
>   1040			cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16);
>   1041		bridge->conf.class_revision =
>   1042			cpu_to_le32(advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff);
>   1043	
>   1044		/* Support 32 bits I/O addressing */
>   1045		bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
>   1046		bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
>   1047	
>   1048		/* Support 64 bits memory pref */
>   1049		bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
>   1050		bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
>   1051	
>   1052		/* Support interrupt A for MSI feature */
>   1053		bridge->conf.intpin = PCI_INTERRUPT_INTA;
>   1054	
>   1055		/*
>   1056		 * Aardvark HW provides PCIe Capability structure in version 2 and
>   1057		 * indicate slot support, which is emulated.
>   1058		 */
>   1059		bridge->pcie_conf.cap = cpu_to_le16(2 | PCI_EXP_FLAGS_SLOT);
>   1060	
>   1061		/*
>   1062		 * Set Presence Detect State bit permanently since there is no support
>   1063		 * for unplugging the card nor detecting whether it is plugged. (If a
>   1064		 * platform exists in the future that supports it, via a GPIO for
>   1065		 * example, it should be implemented via this bit.)
>   1066		 *
>   1067		 * Set physical slot number to 1 since there is only one port and zero
>   1068		 * value is reserved for ports within the same silicon as Root Port
>   1069		 * which is not our case.
>   1070		 */
> > 1071		bridge->pcie_conf.slotcap = cpu_to_le32(1 << PCI_EXP_SLTCAP_PSN_SHIFT);  
>   1072		bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
>   1073	
>   1074		/* Indicates supports for Completion Retry Status */
>   1075		bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
>   1076	
>   1077		bridge->has_pcie = true;
>   1078		bridge->data = pcie;
>   1079		bridge->ops = &advk_pci_bridge_emul_ops;
>   1080	
>   1081		return pci_bridge_emul_init(bridge, 0);
>   1082	}
>   1083	
> 

