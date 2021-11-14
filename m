Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E744FA28
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 20:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhKNTbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 14:31:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231128AbhKNTbx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Nov 2021 14:31:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FFF16109E;
        Sun, 14 Nov 2021 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636918136;
        bh=rlipXWzfFsfe3AYgUgYFO8OmzPfwygvOe0mFRjVzbY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANuA9ZYjgnHgHUSJiBrSWe3ZsjfY5eySjXre7AxOtBLPDhJsvkPtY/kKfd6ErsqAS
         N6pHWJ23dOacXnH3Cen/4OEqU/WTG7C6c16W2AJD3aNv1RBFnbEpSHLf9ktOxf3uXa
         IdTDftIeUTkkz/lM+TDWnrlivISSww6E34hOfykHaCKlgPfcTW5437PP5LU+TV0LP1
         +u3VLIqMkOc3kXWa6WijQDazPwmh5USvyJDlDIl9g1pBdIjXj2i+8ml6eGs/i8xIiX
         WF7GGMgFAmKbfTCYgDr6QVOCrkQCCicj+c3JPpi//Q4U5QQa7yDlTzIF/OmCanhesr
         HBPoB/YyNufXQ==
Received: by pali.im (Postfix)
        id C494A9F5; Sun, 14 Nov 2021 20:28:53 +0100 (CET)
Date:   Sun, 14 Nov 2021 20:28:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     u-boot@lists.denx.de, linux-pci@vger.kernel.org,
        Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
        Phil Sutter <phil@nwl.cc>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Tom Rini <trini@konsulko.com>, Jim Wilson <jimw@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH] pci: Work around PCIe link training failures
Message-ID: <20211114192853.dj7mcc7sxtwaj3of@pali>
References: <alpine.DEB.2.21.2111140303040.19625@angie.orcam.me.uk>
 <20211114154152.kmabs4k3gdrzlzke@pali>
 <alpine.DEB.2.21.2111141655120.19625@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2111141655120.19625@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Sunday 14 November 2021 18:07:18 Maciej W. Rozycki wrote:
> Hi Pali,
> 
> > > +	dm_pci_read_config32(dev, pcie_off + PCI_EXP_LNKCAP, &exp_lnkcap);
> > > +	dm_pci_read_config32(dev, pcie_off + PCI_EXP_LNKCAP2, &exp_lnkcap2);
> > > +	for (speed = (exp_lnkcap & PCI_EXP_LNKCAP_SLS) - 1;
> > > +	     speed >= PCI_EXP_LNKCAP_SLS_2_5GB;
> > > +	     speed--) {
> > > +		if (exp_lnkcap2 && (exp_lnkcap2 & 1 << speed) == 0)
> > > +			continue;
> > 
> > This check is not correct because lnkcap2 is optional also when lnkctl2
> > is implemented. IIRC unimplemented lnkcap2 with implemented lnkctl2 can
> > happen only for link speeds <= 5GT/s and when lnkcap2 returns zero then
> > software should detect speeds from lnkcap register. And I have such PCIe
> > GEN2 HW where PCIe Root Ports implements lnkctl2, but lnkcap2 returns
> > zeros. So it is not corner case.
> 
>  Well, this code checks for non-zero lnkcap2 first and ignores it if it's 
> zero, so I believe it does the right thing.  Have I missed anything?

I'm reading spec again and I'm not sure now. It has following section:

  For software to determine the supported Link speeds for components
  where the Link Capabilities 2 register is either not implemented, or
  the value of its Supported Link Speeds Vector is 0000000b, software
  can read bits 3:0 of the Link Capabilities register (now defined to be
  the Max Link Speed field), and interpret the value as follows:
    0001b 2.5 GT/s Link speed supported
    0010b 5.0 GT/s and 2.5 GT/s Link speeds supported

I'm not sure how it should be interpreted, but my assumption is that
empty lnkcap2 implicates that only 5GT/s or 2.5GT/s speeds are supported
and therefore trying higher should not be done...

Also in spec is following note:

  It is strongly encouraged that software primarily utilize the
  Supported Link Speeds Vector instead of the Max Link Speed field.

So based on this note, iteration should be done via lnkcap2 bits instead
of lnkcap speed.

> > > @@ -267,6 +410,11 @@ void dm_pciauto_prescan_setup_bridge(str
> > >  		cmdstat |= PCI_COMMAND_IO;
> > >  	}
> > >  
> > > +	/* For PCIe devices see if we need to retrain the link by hand */
> > > +	pcie_off = dm_pci_find_capability(dev, PCI_CAP_ID_EXP);
> > > +	if (pcie_off)
> > > +		dm_pciauto_exp_fixup_link(dev, pcie_off);
> > > +
> > >  	/* Enable memory and I/O accesses, enable bus master */
> > >  	dm_pci_write_config16(dev, PCI_COMMAND, cmdstat | PCI_COMMAND_MASTER);
> > 
> > This code cannot be enabled globally for all PCIe devices. There are
> > more PCIe cards which do not like retraining link and touching link
> > retrain bit in downstream port break them (= power on/off is needed).
> 
>  Sigh.  It looks like plenty of breakage to choose from.
> 
>  However we have a case here where the link does not work anyway, so by 
> trying to retrain it we're not going to make it any worse.  At worst it 
> will remain in the non-working state.  I have tried hard to make my code 
> rather careful in not touching links that do work, so unless I missed a 
> case (please point out one if I did), this is not going to affect those 
> PCIe devices that do not like link retraining.

It looks like it should not cause issue. This is something which I said
to myself during debugging other issue and then I found those Atheros
wifi cards which enters into broken state if device on other side of the
PCIe link tries to retrain link. Something which I would never expect
that could be broken :-(

> > Could you bring this discussion to Linux PCI list? I guess that same
> > issue had to be fixed also in Linux kernel and it would be great to have
> > same fix in both projects.
> 
>  It could be done in Linux in addition to U-Boot, although I think doing 
> that in the firmware is more important, especially as there could be a 
> boot device downstream such a switch.  And depending on the platform Linux 
> does not always reassign buses, so a user intervention (i.e. an explicitly 
> added kernel parameter) would have to be required.

It is important to have it in both components (U-Boot and Linux). For
example native PCIe controller drivers in linux kernel as a first thing
do complete reset of controller together with connected devices. So
whatever do U-Boot is completely lost. And important is that Linux
kernel drivers should not depend on some bootloader configuration. And
note that your patch implements this workaround in CONFIG_PCI_PNP code,
so if board disable this option, workaround is not applied.

>  And these are generic PCIe switches, they could be anywhere and with the 
> weird combinations of hardware interfaces available now (e.g. PCI-PCIe 
> bridge adapters or M.2 to regular PCIe slot adapters) virtually any 
> combination is possible.
> 
>  E.g. I have a 1997-vintage dual Pentium MMX box (82439HX host bridge; 
> [8086:1250]) with PCIe devices, although it does require a lot of Linux 
> interventions to cope with its firmware limitations.  NB I plan to add 
> some NVMe storage to that box, and I believe the ASM2824 has been used in 
> some M.2 carrier boards meant for NVMe devices.

Hm... now thinking about your patch... and if it is general, applied to
all devices, should it also be applied to any type of downstream port?
Meaning also for root ports, or PCIe port of PCI/X to PCIe bridge (I
guess that such old platforms with only PCI host bridge without PCIe
could be affected too if you connect PCIe card via PCI/X to PCIe bridge
and then this bridge to host PCI slot).

Also one important note. I have some PCIe devices which do not want to
automatically negotiate maximal link speed (5 GT/s) and stay on initial
2.5 GT/s until flipping link retrain bit happen. But I have not debugged
this fully (I postponed this issue to future). So maybe this something
similar to your Asmedia issue: link speed is detected incorrectly and
software needs to setup (maximal) link speed manually.

>  I've cc-ed the linux-pci list in case someone there wants to chime in.
> 
> > For me it looks like Asmedia specific bug and so it should be applied
> > only for affected Asmedia devices based on PCI vendor/device ids.
> 
>  It is surely one option to consider, though I'd prefer to keep this piece 
> generic and enabled as widely as possible in a best effort to make things 
> work seamlessly, so as to prevent end users from having to chase a similar 
> problem with another device.  It was not exactly easy to figure out what 
> is going on here to me and I am a professional with decades of experience.  
> So what could an ordinary user do other than concluding that things do not 
> work?  I think a seamless solution is always preferable.
> 
>  As I noted ASMedia declined to comment, so it's hard to say if the cause 
> has been nailed correctly and which devices if any, beyond [1b21:2824], 
> are affected.

Yea, we do not know... And because we know that there is lot of broken
HW which works with current version, we need to be very careful when
introducing some workaround which is called on every hardware.

For example something similar like in your patch was implemented in
Marvell SerDes U-Boot driver, which controls physical layer (so on place
where nobody would expect touching higher layer code). Just this code
did not touched retrain link bit... And so it could not have worked and
was recently removed in patch series:
https://lore.kernel.org/u-boot/20210924205922.25432-1-marek.behun@nic.cz/

I'm not saying that I'm opposing this patch. Just I would like see how
is this issue will be fixed in kernel as kernel general workaround would
affect lot of more devices. And so solution accepted by kernel project
should be perfectly fine also for smaller project like U-Boot.

>  Thank you for your input.
> 
>   Maciej
