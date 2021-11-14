Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E844F9E4
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 19:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhKNSKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 13:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNSKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 13:10:17 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202B9C061746
        for <linux-pci@vger.kernel.org>; Sun, 14 Nov 2021 10:07:21 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D526A92009C; Sun, 14 Nov 2021 19:07:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CF12592009B;
        Sun, 14 Nov 2021 18:07:18 +0000 (GMT)
Date:   Sun, 14 Nov 2021 18:07:18 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
cc:     u-boot@lists.denx.de, linux-pci@vger.kernel.org,
        Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
        Phil Sutter <phil@nwl.cc>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Tom Rini <trini@konsulko.com>, Jim Wilson <jimw@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH] pci: Work around PCIe link training failures
In-Reply-To: <20211114154152.kmabs4k3gdrzlzke@pali>
Message-ID: <alpine.DEB.2.21.2111141655120.19625@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2111140303040.19625@angie.orcam.me.uk> <20211114154152.kmabs4k3gdrzlzke@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

> > +	dm_pci_read_config32(dev, pcie_off + PCI_EXP_LNKCAP, &exp_lnkcap);
> > +	dm_pci_read_config32(dev, pcie_off + PCI_EXP_LNKCAP2, &exp_lnkcap2);
> > +	for (speed = (exp_lnkcap & PCI_EXP_LNKCAP_SLS) - 1;
> > +	     speed >= PCI_EXP_LNKCAP_SLS_2_5GB;
> > +	     speed--) {
> > +		if (exp_lnkcap2 && (exp_lnkcap2 & 1 << speed) == 0)
> > +			continue;
> 
> This check is not correct because lnkcap2 is optional also when lnkctl2
> is implemented. IIRC unimplemented lnkcap2 with implemented lnkctl2 can
> happen only for link speeds <= 5GT/s and when lnkcap2 returns zero then
> software should detect speeds from lnkcap register. And I have such PCIe
> GEN2 HW where PCIe Root Ports implements lnkctl2, but lnkcap2 returns
> zeros. So it is not corner case.

 Well, this code checks for non-zero lnkcap2 first and ignores it if it's 
zero, so I believe it does the right thing.  Have I missed anything?

> > @@ -267,6 +410,11 @@ void dm_pciauto_prescan_setup_bridge(str
> >  		cmdstat |= PCI_COMMAND_IO;
> >  	}
> >  
> > +	/* For PCIe devices see if we need to retrain the link by hand */
> > +	pcie_off = dm_pci_find_capability(dev, PCI_CAP_ID_EXP);
> > +	if (pcie_off)
> > +		dm_pciauto_exp_fixup_link(dev, pcie_off);
> > +
> >  	/* Enable memory and I/O accesses, enable bus master */
> >  	dm_pci_write_config16(dev, PCI_COMMAND, cmdstat | PCI_COMMAND_MASTER);
> 
> This code cannot be enabled globally for all PCIe devices. There are
> more PCIe cards which do not like retraining link and touching link
> retrain bit in downstream port break them (= power on/off is needed).

 Sigh.  It looks like plenty of breakage to choose from.

 However we have a case here where the link does not work anyway, so by 
trying to retrain it we're not going to make it any worse.  At worst it 
will remain in the non-working state.  I have tried hard to make my code 
rather careful in not touching links that do work, so unless I missed a 
case (please point out one if I did), this is not going to affect those 
PCIe devices that do not like link retraining.

> Could you bring this discussion to Linux PCI list? I guess that same
> issue had to be fixed also in Linux kernel and it would be great to have
> same fix in both projects.

 It could be done in Linux in addition to U-Boot, although I think doing 
that in the firmware is more important, especially as there could be a 
boot device downstream such a switch.  And depending on the platform Linux 
does not always reassign buses, so a user intervention (i.e. an explicitly 
added kernel parameter) would have to be required.

 And these are generic PCIe switches, they could be anywhere and with the 
weird combinations of hardware interfaces available now (e.g. PCI-PCIe 
bridge adapters or M.2 to regular PCIe slot adapters) virtually any 
combination is possible.

 E.g. I have a 1997-vintage dual Pentium MMX box (82439HX host bridge; 
[8086:1250]) with PCIe devices, although it does require a lot of Linux 
interventions to cope with its firmware limitations.  NB I plan to add 
some NVMe storage to that box, and I believe the ASM2824 has been used in 
some M.2 carrier boards meant for NVMe devices.

 I've cc-ed the linux-pci list in case someone there wants to chime in.

> For me it looks like Asmedia specific bug and so it should be applied
> only for affected Asmedia devices based on PCI vendor/device ids.

 It is surely one option to consider, though I'd prefer to keep this piece 
generic and enabled as widely as possible in a best effort to make things 
work seamlessly, so as to prevent end users from having to chase a similar 
problem with another device.  It was not exactly easy to figure out what 
is going on here to me and I am a professional with decades of experience.  
So what could an ordinary user do other than concluding that things do not 
work?  I think a seamless solution is always preferable.

 As I noted ASMedia declined to comment, so it's hard to say if the cause 
has been nailed correctly and which devices if any, beyond [1b21:2824], 
are affected.

 Thank you for your input.

  Maciej
