Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE13A006A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhFHSnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 14:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234479AbhFHSkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 14:40:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DAC1613B9;
        Tue,  8 Jun 2021 18:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623177289;
        bh=KOUjznsu5PhZ56lcrsU5gsdMb3/6MPsOd8rjaTQXDD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9e6C5CAViqqZKp6tvp5VT5OMU8e0MMlsdP0E41kqgX/lfaaSXUmUOdPI9S898HCj
         IZshLDdUgIUbEg9SWjZ76snI4HAmHSJA2wkcYSRJZ53itUUQTK534C71VVlGoTSgK5
         qnSZxZRevoiTkMUTGuRq3yMoj4weM5EtMxN3D8WrbQMtKv42zP0xefr5HGwuFE0uGA
         odYiDfhl3UiLKZWmncrGlugfw4LdCWKWxgJzKZNwOntTS2uAxnkRaW2nQwJHAJo2Hd
         cNPR0znRtnsxCYiEQ3irae7R9Qa0ENOUDhBocDHGAZTsxgNHFWdo63Y0dnwlnwL7lW
         3VhWVGOCWzJ+A==
Received: by pali.im (Postfix)
        id B978E7CC; Tue,  8 Jun 2021 20:34:46 +0200 (CEST)
Date:   Tue, 8 Jun 2021 20:34:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ingmar Klein <ingmar_klein@web.de>
Cc:     bhelgaas@google.com, Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210608183446.3qvj52tm6c2bhtvu@pali>
References: <20210525221215.GA1235899@bjorn-Precision-5520>
 <19c3850e-e29c-3e39-9d44-9623a4f97346@web.de>
 <20210528182135.e7uiugoyuj7hjilb@pali>
 <8e443996-cead-a826-78ab-1c3f899228cb@web.de>
 <f72fad24-3b4a-2c62-55be-041ab4e67371@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f72fad24-3b4a-2c62-55be-041ab4e67371@web.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello! So should I add also 0x003e device id in next patch iteration?

On Saturday 05 June 2021 16:46:36 Ingmar Klein wrote:
> Hi Pali and Bjorn,
> 
> finally found the time to test.
> Pali's v3 patch seems to work like a charm for my card with "0x003e" id
> as well.
> Just finished compiling a pve-kernel v5.11.21 with Pali's patch,
> slightly adjusted for my test card and the Ubuntu kernel source (no
> functional differences, just minor adjustments to make it fit the
> Proxmox pve-kernel).
> 
> System works just fine, in contrast to without patch. Of course, no long
> term tests, yet. However, it is looking really good.
> Thanks guys!
> 
> Best regards,
> Ingmar
> 
> 
> Am 28.05.2021 um 20:47 schrieb Ingmar Klein:
> > Hi Pali,
> > sorry for not checking that detail!
> > Of course no problem that you couldn't test that ID. Will be glad to
> > do so.
> > 
> > I'll let you know how this turns out.
> > 
> > Best regards,
> > Ingmar
> > 
> > 
> > Am 28.05.2021 um 20:21 schrieb Pali Rohár:
> > > Hello Ingmar!
> > > 
> > > Now I see that in your patch you have Atheros card with id 0x003e:
> > > https://lore.kernel.org/linux-pci/08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de/
> > > 
> > > 
> > > With my patch I have tested 5 different Atheros cards but none has id
> > > 0x003e:
> > > https://lore.kernel.org/linux-pci/20210505163357.16012-1-pali@kernel.org/
> > > 
> > > 
> > > So my patch does not fix that issue for your 0x003e card. I just do not
> > > have such card for testing.
> > > 
> > > Could you try to apply my patch and then add your id 0x003e into quirk
> > > list if it helps?
> > > 
> > > On Friday 28 May 2021 20:08:52 Ingmar Klein wrote:
> > > > Thanks to both of you, Bjorn and Pali!
> > > > I had hoped that Pali would come with an appropriate fix. Good to know,
> > > > that this is taken care of.
> > > > 
> > > > Will test ASAP, but I am confident, that it will work anyway.
> > > > Should it unexpectedly not fix my issues, I'll let you know.
> > > > Have a nice weekend!
> > > > Best regards,
> > > > Ingmar
> > > > 
> > > > 
> > > > Am 26.05.2021 um 00:12 schrieb Bjorn Helgaas:
> > > > > On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Rohár wrote:
> > > > > > Hello!
> > > > > > 
> > > > > > On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
> > > > > > > [cc +Pali]
> > > > > > > 
> > > > > > > On Thu, 15 Apr 2021 20:02:23 +0200
> > > > > > > Ingmar Klein <ingmar_klein@web.de> wrote:
> > > > > > > 
> > > > > > > > First thanks to you both, Alex and Bjorn!
> > > > > > > > I am in no way an expert on this topic, so I have to fully rely
> > > > > > > > on your
> > > > > > > > feedback, concerning this issue.
> > > > > > > > 
> > > > > > > > If you should have any other solution approach, in form of
> > > > > > > > patch-set, I
> > > > > > > > would be glad to test it out. Just let me know, what you think
> > > > > > > > might
> > > > > > > > make sense.
> > > > > > > > I will wait for your further feedback on the issue. In the
> > > > > > > > meantime I
> > > > > > > > have my current workaround via quirk entry.
> > > > > > > > 
> > > > > > > > By the way, my layman's question:
> > > > > > > > Do you think, that the following topic might also apply for the
> > > > > > > > QCA6174?
> > > > > > > > https://www.spinics.net/lists/linux-pci/msg106395.html
> > > > > > I have been testing more ath cards and I'm going to send a new
> > > > > > version
> > > > > > of this patch with including more PCI ids.
> > > > > Dropping this patch in favor of Pali's new version.
> > > > > 
> > > > > > > > Or in other words, should a similar approach be tried for the
> > > > > > > > QCA6174
> > > > > > > > and if yes, would it bring any benefit at all?
> > > > > > > > I hope you can excuse me, in case the questions should not make
> > > > > > > > too much
> > > > > > > > sense.
> > > > > > > If you run lspci -vvv on your device, what do LnkCap and LnkSta
> > > > > > > report
> > > > > > > under the express capability?  I wonder if your device even supports
> > > > > > > > Gen1 speeds, mine does not.
> > > > > > > I would not expect that patch to be relevant to you based on your
> > > > > > > report.  I understand it to resolve an issue during link
> > > > > > > retraining to a
> > > > > > > higher speed on boot, not during a bus reset.  Pali can correct
> > > > > > > if I'm
> > > > > > > wrong.  Thanks,
> > > > > > These two issues are are related. Both operations (PCIe Hot Reset and
> > > > > > PCIe Link Retraining) cause reset of ath chips. Seems that they cause
> > > > > > double reset. After reset these chips reads configuration from
> > > > > > internal
> > > > > > EEPROM/OTP and if another reset is triggered prior chip finishes
> > > > > > internal configuration read then it stops working. My testing showed
> > > > > > that ath10k chips completely disappear from the PCIe bus, some ath9k
> > > > > > chips works fine but starts reporting incorrect PCI ID (0xABCD)
> > > > > > and some
> > > > > > other ath9k chips reports correct PCI ID but does not work. I had
> > > > > > discussion with Adrian Chadd who knows probably everything about
> > > > > > ath9k
> > > > > > and confirmed me that this issue is there with ath9k and ath10k
> > > > > > chips.
> > > > > > 
> > > > > > He wrote me that workaround to turn card back from this "broken"
> > > > > > state
> > > > > > is to do PCIe Cold Reset of the card, which means turning power
> > > > > > supply
> > > > > > off for particular PCIe slot. Such thing is not supported on many
> > > > > > low-end boards, so workaround cannot be applied.
> > > > > > 
> > > > > > I was able to recover my testing cards from this "broken" state by
> > > > > > PCIe
> > > > > > Warm Reset (= reset via PERST# pin).
> > > > > > 
> > > > > > I have tried many other reset methods (PCIe PM reset, Link Down, PCIe
> > > > > > Hot Reset with bigger internal, ...) but nothing worked. So seems
> > > > > > that
> > > > > > the only workaround is to do PCIe Cold Reset or PCIe Warm Reset.
> > > > > > 
> > > > > > I will send V2 of my patch with details and explanation.
> > > > > > 
> > > > > > As kernel does not have API for doing PCIe Warm Reset, I think is
> > > > > > another argument why kernel really needs it.
> > > > > > 
> > > > > > I do not have any QCA6174 card for testing, but based on the fact I
> > > > > > reproduced this issue with more ath9k and ath10 cards and Adrian
> > > > > > confirmed that above reset issue is there, I think that it affects
> > > > > > all
> > > > > > AR9xxx and QCAxxxx cards handled by ath9k and ath10 drivers.
> > > > > > 
> > > > > > I was told that AMI BIOS was patching their BIOSes found in
> > > > > > notebooks to
> > > > > > avoid triggering this issue on notebooks ath9k cards.
> > > > > > 
> > > > > > > Alex
> > > > > > > 
> > > > > > > > Am 15.04.2021 um 04:36 schrieb Alex Williamson:
> > > > > > > > > On Wed, 14 Apr 2021 16:03:50 -0500
> > > > > > > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > 
> > > > > > > > > > [+cc Alex]
> > > > > > > > > > 
> > > > > > > > > > On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
> > > > > > > > > > > Edit: Retry, as I did not consider, that my mail-client would
> > > > > > > > > > > make this
> > > > > > > > > > > party html.
> > > > > > > > > > > 
> > > > > > > > > > > Dear maintainers,
> > > > > > > > > > > I recently encountered an issue on my Proxmox server system,
> > > > > > > > > > > that
> > > > > > > > > > > includes a Qualcomm QCA6174 m.2 PCIe wifi module.
> > > > > > > > > > > https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
> > > > > > > > > > > 
> > > > > > > > > > > On system boot and subsequent virtual machine start (with
> > > > > > > > > > > passed-through
> > > > > > > > > > > QCA6174), the VM would just freeze/hang, at the point where
> > > > > > > > > > > the ath10k
> > > > > > > > > > > driver loads.
> > > > > > > > > > > Quick search in the proxmox related topics, brought me to the
> > > > > > > > > > > following
> > > > > > > > > > > discussion, which suggested a PCI quirk entry for the QCA6174
> > > > > > > > > > > in the kernel:
> > > > > > > > > > > https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.27513/
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > I then went ahead, got the Proxmox kernel source (v5.4.106)
> > > > > > > > > > > and applied
> > > > > > > > > > > the attached patch.
> > > > > > > > > > > Effect was as hoped, that the VM hangs are now gone. System
> > > > > > > > > > > boots and
> > > > > > > > > > > runs as intended.
> > > > > > > > > > > 
> > > > > > > > > > > Judging by the existing quirk entries for Atheros, I would
> > > > > > > > > > > think, that
> > > > > > > > > > > my proposed "fix" could be included in the vanilla kernel.
> > > > > > > > > > > As far as I saw, there is no entry yet, even in the latest
> > > > > > > > > > > kernel sources.
> > > > > > > > > > This would need a signed-off-by; see
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > This is an old issue, and likely we'll end up just applying
> > > > > > > > > > this as
> > > > > > > > > > yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark
> > > > > > > > > > Atheros
> > > > > > > > > > AR93xx to avoid bus reset"), where it started, it seems to be
> > > > > > > > > > connected to 425c1b223dac ("PCI: Add Virtual Channel to
> > > > > > > > > > save/restore
> > > > > > > > > > support").
> > > > > > > > > > 
> > > > > > > > > > I'd like to dig into that a bit more to see if there are any
> > > > > > > > > > clues.
> > > > > > > > > > AFAIK Linux itself still doesn't use VC at all, and
> > > > > > > > > > 425c1b223dac added
> > > > > > > > > > a fair bit of code.  I wonder if we're restoring something out of
> > > > > > > > > > order or making some simple mistake in the way to restore VC
> > > > > > > > > > config.
> > > > > > > > > I don't really have any faith in that bisect report in commit
> > > > > > > > > c3e59ee4e766.  To double check I dug out the card from that
> > > > > > > > > commit,
> > > > > > > > > installed an old Fedora release so I could build kernel v3.13,
> > > > > > > > > pre-dating 425c1b223dac and tested triggering a bus reset both via
> > > > > > > > > setpci and by masking PM reset so that sysfs can trigger the
> > > > > > > > > bus reset
> > > > > > > > > path with the kernel save/restore code.  Both result in the system
> > > > > > > > > hanging when the device is accessed either restoring from the
> > > > > > > > > kernel
> > > > > > > > > bus reset or reading from the device after the setpci reset. 
> > > > > > > > > Thanks,
> > > > > > > > > 
> > > > > > > > > Alex
> > > > > > > > > 
