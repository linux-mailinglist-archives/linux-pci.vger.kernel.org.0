Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11CD361328
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhDOTyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 15:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbhDOTyE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 15:54:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 243F46109D;
        Thu, 15 Apr 2021 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618516421;
        bh=FrgpnQIPZe+17c+ASqcSSv+pNsF9JRsHY2HHEvg45lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTwmxIZe47cHNoBV8cikbcMQcC4EvSJmbJAAWFdXW7S+Dm0x+GocrHZ86anWb6MIl
         A9YxmLm0SwCfWfknv8NHyhOLoy3FIb5Zt05N29EugM/cclOoF/QCSO5j7x9WpF3D7+
         l4nOAlNrAZOWQSofsAkybq70BzDiWPMW3yzKycd05nS2vnHqG45s2yxINsv4nvlXOr
         e+MN9LIim7AzHNHXXvyRusgb506ox2+A5ufQF/oAu1GRH0H2QJQQ6AhEN9qERzYEQ7
         8UQ8dKhi3pqrcDiAA5Ap/7BNcMadYMy/fy8xtz9qn+lVVDVzBzmLMOrasbU3iEaBXS
         jl+0EeOes5bbw==
Received: by pali.im (Postfix)
        id 619C4AF7; Thu, 15 Apr 2021 21:53:38 +0200 (CEST)
Date:   Thu, 15 Apr 2021 21:53:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Ingmar Klein <ingmar_klein@web.de>,
        Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210415195338.icpo5644bo76rzuc@pali>
References: <08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de>
 <20210414210350.GA2537653@bjorn-Precision-5520>
 <20210414203650.1f83a5dd@x1.home.shazbot.org>
 <eec3bb3b-9eba-a0cb-73da-88353a0d3e99@web.de>
 <20210415130119.42bf5b8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415130119.42bf5b8a@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
> [cc +Pali]
> 
> On Thu, 15 Apr 2021 20:02:23 +0200
> Ingmar Klein <ingmar_klein@web.de> wrote:
> 
> > First thanks to you both, Alex and Bjorn!
> > I am in no way an expert on this topic, so I have to fully rely on your
> > feedback, concerning this issue.
> > 
> > If you should have any other solution approach, in form of patch-set, I
> > would be glad to test it out. Just let me know, what you think might
> > make sense.
> > I will wait for your further feedback on the issue. In the meantime I
> > have my current workaround via quirk entry.
> > 
> > By the way, my layman's question:
> > Do you think, that the following topic might also apply for the QCA6174?
> > https://www.spinics.net/lists/linux-pci/msg106395.html

I have been testing more ath cards and I'm going to send a new version
of this patch with including more PCI ids.

> > Or in other words, should a similar approach be tried for the QCA6174
> > and if yes, would it bring any benefit at all?
> > I hope you can excuse me, in case the questions should not make too much
> > sense.
> 
> If you run lspci -vvv on your device, what do LnkCap and LnkSta report
> under the express capability?  I wonder if your device even supports
> >Gen1 speeds, mine does not.
> 
> I would not expect that patch to be relevant to you based on your
> report.  I understand it to resolve an issue during link retraining to a
> higher speed on boot, not during a bus reset.  Pali can correct if I'm
> wrong.  Thanks,

These two issues are are related. Both operations (PCIe Hot Reset and
PCIe Link Retraining) cause reset of ath chips. Seems that they cause
double reset. After reset these chips reads configuration from internal
EEPROM/OTP and if another reset is triggered prior chip finishes
internal configuration read then it stops working. My testing showed
that ath10k chips completely disappear from the PCIe bus, some ath9k
chips works fine but starts reporting incorrect PCI ID (0xABCD) and some
other ath9k chips reports correct PCI ID but does not work. I had
discussion with Adrian Chadd who knows probably everything about ath9k
and confirmed me that this issue is there with ath9k and ath10k chips.

He wrote me that workaround to turn card back from this "broken" state
is to do PCIe Cold Reset of the card, which means turning power supply
off for particular PCIe slot. Such thing is not supported on many
low-end boards, so workaround cannot be applied.

I was able to recover my testing cards from this "broken" state by PCIe
Warm Reset (= reset via PERST# pin).

I have tried many other reset methods (PCIe PM reset, Link Down, PCIe
Hot Reset with bigger internal, ...) but nothing worked. So seems that
the only workaround is to do PCIe Cold Reset or PCIe Warm Reset.

I will send V2 of my patch with details and explanation.

As kernel does not have API for doing PCIe Warm Reset, I think is
another argument why kernel really needs it.

I do not have any QCA6174 card for testing, but based on the fact I
reproduced this issue with more ath9k and ath10 cards and Adrian
confirmed that above reset issue is there, I think that it affects all
AR9xxx and QCAxxxx cards handled by ath9k and ath10 drivers.

I was told that AMI BIOS was patching their BIOSes found in notebooks to
avoid triggering this issue on notebooks ath9k cards.

> Alex
> 
> > Am 15.04.2021 um 04:36 schrieb Alex Williamson:
> > > On Wed, 14 Apr 2021 16:03:50 -0500
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >  
> > >> [+cc Alex]
> > >>
> > >> On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:  
> > >>> Edit: Retry, as I did not consider, that my mail-client would make this
> > >>> party html.
> > >>>
> > >>> Dear maintainers,
> > >>> I recently encountered an issue on my Proxmox server system, that
> > >>> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
> > >>> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
> > >>>
> > >>> On system boot and subsequent virtual machine start (with passed-through
> > >>> QCA6174), the VM would just freeze/hang, at the point where the ath10k
> > >>> driver loads.
> > >>> Quick search in the proxmox related topics, brought me to the following
> > >>> discussion, which suggested a PCI quirk entry for the QCA6174 in the kernel:
> > >>> https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.27513/
> > >>>
> > >>> I then went ahead, got the Proxmox kernel source (v5.4.106) and applied
> > >>> the attached patch.
> > >>> Effect was as hoped, that the VM hangs are now gone. System boots and
> > >>> runs as intended.
> > >>>
> > >>> Judging by the existing quirk entries for Atheros, I would think, that
> > >>> my proposed "fix" could be included in the vanilla kernel.
> > >>> As far as I saw, there is no entry yet, even in the latest kernel sources.  
> > >> This would need a signed-off-by; see
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361
> > >>
> > >> This is an old issue, and likely we'll end up just applying this as
> > >> yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark Atheros
> > >> AR93xx to avoid bus reset"), where it started, it seems to be
> > >> connected to 425c1b223dac ("PCI: Add Virtual Channel to save/restore
> > >> support").
> > >>
> > >> I'd like to dig into that a bit more to see if there are any clues.
> > >> AFAIK Linux itself still doesn't use VC at all, and 425c1b223dac added
> > >> a fair bit of code.  I wonder if we're restoring something out of
> > >> order or making some simple mistake in the way to restore VC config.  
> > > I don't really have any faith in that bisect report in commit
> > > c3e59ee4e766.  To double check I dug out the card from that commit,
> > > installed an old Fedora release so I could build kernel v3.13,
> > > pre-dating 425c1b223dac and tested triggering a bus reset both via
> > > setpci and by masking PM reset so that sysfs can trigger the bus reset
> > > path with the kernel save/restore code.  Both result in the system
> > > hanging when the device is accessed either restoring from the kernel
> > > bus reset or reading from the device after the setpci reset.  Thanks,
> > >
> > > Alex
> > >  
> > 
> 
