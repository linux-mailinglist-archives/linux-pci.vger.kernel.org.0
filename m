Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6934AD20
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 18:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZRLV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 13:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhCZRLF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 13:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E52EC619FF;
        Fri, 26 Mar 2021 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616778665;
        bh=8iNushOzyU4yjvf/2b7KgfbpYeYoZ8AZAqb0V7RwRrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrqUoF6l8LICdBdD8IuQqBPP71/k5OU4kYlGZOYv2nXRQgqELndLC7RDYkAeAW/gL
         7pA7pZGOjXk4dHrfsz8GwWn5/ElveLR4B61ovvy0scClBylY8RmqTr45FxS5f3W1OG
         w9A85uuXyXAyTuLv6MgY95OPwPdKo8J4cbDRwBFM+eYzSKaWSIUKknRS1CR7Trs6R8
         rv6T9u9vFeDnD+NUwEVNQPVWZC9d49e+pEZzcCDtS7IdA6/zDlvjfc6d+efWrlLA1o
         k6PE+uHzv7e+VRN2oQEqte2Jh5JsriX2BZR3PWPFMQGdHW3QEc24ceB6U99NRVonfE
         ayzmaOvWj4ITA==
Received: by pali.im (Postfix)
        id 28598842; Fri, 26 Mar 2021 18:11:01 +0100 (CET)
Date:   Fri, 26 Mar 2021 18:11:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20210326171100.s53mslkjc7tdgs6f@pali>
References: <20201102152403.4jlmcaqkqeivuypm@pali>
 <877dr3lpok.fsf@toke.dk>
 <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali>
 <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali>
 <874kgyc4yg.fsf@toke.dk>
 <20210326153444.cdccc3e2axqxzejy@pali>
 <87o8f5c0tt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8f5c0tt.fsf@toke.dk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 26 March 2021 17:54:38 Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:
> > On Friday 26 March 2021 16:25:27 Toke Høiland-Jørgensen wrote:
> >> Pali Rohár <pali@kernel.org> writes:
> >> > Seems that this is really issue in QCA98xx chips. I have send patch
> >> > which adds quirk for these wifi chips:
> >> >
> >> > https://lore.kernel.org/linux-pci/20210326124326.21163-1-pali@kernel.org/
> >> 
> >> I tried applying that, and while it does fix the ath10k card, it seems
> >> to break the ath9k card in the slot next to it.
> >
> > Ehm, what?
> 
> I know, right?! :/
> 
> > Patch which I have sent today to mailing list calls quirk code only
> > for PCI device id used by QCA98xx cards. For all other cards it is
> > noop.
> 
> So upon further investigation this seems to be unrelated to the patch.
> Meaning that I can't reliably get the ath9k device to work again by
> reverting it. And the patch does seem to fix the ath10k device, so I
> think that's probably good.
> 
> However, the issue with ath9k does seem to be related to ASPM; if I turn
> that off in .config, I get the ath9k device back.

Ok, perfect. So this my patch is does not break ath9k.

> So we have these
> cases:
> 
> ASPM disabled:          ath9k, ath10k and mt76 cards all work
> ASPM enabled, no patch: only mt76 card works
> ASPM enabled + patch:   ath10k and mt76 cards work
> 
> So IDK, maybe the ath9k card needs a quirk as well? Or the mvebu board
> is just generally flaky?

I'm not sure. Maybe ASPM is somehow buggy on ath9k or needs some special
handling. But issue is not at PCI config space as ath9k driver start
initialization of this card. Needs also some debugging in ath9k driver
if it prints that strange "mac chip rev" error.

I think this issue should be handled separately. Could you report it
also to ath9k mailing list (and CC me)? Maybe other ath developers would
know some more details.

> > Can you send PCI device id of your ath9k card (lspci -nn)? Because all
> > my tested ath9k cards have different PCI device id.
> 
> [root@omnia-arch ~]# lspci -nn
> 00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> 00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> 00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e] (rev 01)
> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]

That is fine. Also all ath9k testing cards have id 0x002e.

> >> When booting with the
> >> patch applied, I get this in dmesg:
> >> 
> >> [    3.556599] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver
> >
> > Can you send whole dmesg log? So I can see which new err/info lines are
> > printed.
> 
> Pasting all three cases below:
...

Seem that there is no ASPM related line... But your logs are not
complete, beginning is missing. So important lines are maybe trimmed.

> >> Could there be some kind of data corruption in play here making the
> >> driver think the chip revision is wrong, or something like that? If I
> >> boot the same kernel without the patch applied, the ath9k initialisation
> >> works fine, but obviously the ath10k is then still broken...
> >
> > There is something really strange.
> >
> > Can you add debug log into pcie_change_tls_to_gen1() function to check
> > for which card is this function called?
> 
> Erm, it looks like it's never called? I added this:

Ehm? With patch it must be called otherwise ath10k card would not be
detected on PCIe bus. And you tested that patch fixes it...

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index ea5bdf6107f6..794c682d4bd3 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -198,6 +198,9 @@ static int pcie_change_tls_to_gen1(struct pci_dev *parent)
>         u32 reg32;
>         int ret;
>  
> +       printk("pcie_change_tls_to_getn1() called for device %x:%x:%x\n",
> +              parent->device, parent->subsystem_vendor, parent->subsystem_device);
> +

Try pci_err(parent, "message...\n"); if something changes?

>         /* Check if link speed can be forced to 2.5 GT/s */
>         pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &reg32);
>         if (!(reg32 & PCI_EXP_LNKCAP2_SLS_2_5GB)) {
> 
> But 'dmesg | grep called' returns nothing...
> 
> > Are you testing this new patch with or without changes to
> > mvebu_pcie_setup_hw() function?
> 
> I applied your patch on top of latest mac80211-next, which right now is
> this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=4b837ad53be2ab100dfaa99dc73a9443a8a2392d

Just to ensure that you are _not_ using hack for mvebu_pcie_setup_hw()
function in pci-mvebu.c (which I have sent few days ago).
