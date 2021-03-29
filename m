Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A955834D5C5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 19:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhC2RJh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 13:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhC2RJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 13:09:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACC3A6196C;
        Mon, 29 Mar 2021 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617037772;
        bh=bhvt+t47VTVGr9fOOy6yfX7BF4QGIZKFXRGUPjYvIAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXwRQmqAXT9gZBzO2vjTAMXrrwxU8CrLkhAm3/WrTq7rqhjzstFXBfV5r+EAkIgbj
         d+7lwIYfMI4A3qhE7Z/4AEEMVNL/FZ0Puh1dYX0M4U9SChDK5J7GD9a/CX1H3QcBVu
         AMznuRZFwhglZMgqR6sb3Gta8RG9A/yLYmAAdY6aMwff8MI1bCcZxKCmxiGme4JT2g
         ufcgoyHvUNMlTG8g4WZXbVu8chv/DT2AvzCXhz0RDeOzQBeCgKkV5zHD7Z5nwAYyFF
         0vCWLM3H3hpTC6ObI1/iyph7SyWrOIMxdKYBgR2tDasgp8vPt5vbfpG5Br55vIDd1z
         7SgpwnjFScFig==
Received: by pali.im (Postfix)
        id 5E60CA79; Mon, 29 Mar 2021 19:09:29 +0200 (CEST)
Date:   Mon, 29 Mar 2021 19:09:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20210329170929.uhpttc4oxbkghkpr@pali>
References: <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali>
 <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali>
 <874kgyc4yg.fsf@toke.dk>
 <20210326153444.cdccc3e2axqxzejy@pali>
 <87o8f5c0tt.fsf@toke.dk>
 <20210326171100.s53mslkjc7tdgs6f@pali>
 <87ft0hby6p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ft0hby6p.fsf@toke.dk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 26 March 2021 18:51:42 Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:
> > On Friday 26 March 2021 17:54:38 Toke Høiland-Jørgensen wrote:
> >> So we have these
> >> cases:
> >> 
> >> ASPM disabled:          ath9k, ath10k and mt76 cards all work
> >> ASPM enabled, no patch: only mt76 card works
> >> ASPM enabled + patch:   ath10k and mt76 cards work
> >> 
> >> So IDK, maybe the ath9k card needs a quirk as well? Or the mvebu board
> >> is just generally flaky?
> >
> > I'm not sure. Maybe ASPM is somehow buggy on ath9k or needs some special
> > handling. But issue is not at PCI config space as ath9k driver start
> > initialization of this card. Needs also some debugging in ath9k driver
> > if it prints that strange "mac chip rev" error.
> 
> Well that's just being output because it gets a revision that it doesn't
> recognise - which it seems to be just reading from a register:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath9k/hw.c#L255
> 
> The value returned is consistent with the value returned just being
> 0xffffffff. Which from looking at ioread32() is the value being returned
> on a failed read. So there's a driver bug there - the check against -EIO
> here is obviously nonsensical:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath9k/hw.c#L290
> 
> But the underlying cause appears to be that the read from the register
> fails, which I suppose is related to something the PCI bus does?
> 
> > I think this issue should be handled separately. Could you report it
> > also to ath9k mailing list (and CC me)? Maybe other ath developers would
> > know some more details.
> 
> I'll send a patch for the nonsensical check above, but other than that I
> think we're still in PCI land here, or?

First, can you try to enable my quirk also for this ath9k card with ASPM
enabled?

I have there another ath9k card which after toggling link retraining
changes PCI device ID (really!) to 0xABCD. But lspci ...

There is long story about broken ath9k cards that are reporting 0xABCD
id on x86 machines with specific BIOS versions. It can be find in
ath9k-devel mailing list archive:

https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html

Maybe we now found root cause of this ABCD? If yes, then it also answers
why above ath9k driver check fails (device id was changed) and also
because kernel see correct id (kernel reads id before configuring ASPM
and therefore before triggering link retraining).

> >> > Can you send PCI device id of your ath9k card (lspci -nn)? Because all
> >> > my tested ath9k cards have different PCI device id.
> >> 
> >> [root@omnia-arch ~]# lspci -nn
> >> 00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> >> 00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> >> 00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> >> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e] (rev 01)
> >> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
> >
> > That is fine. Also all ath9k testing cards have id 0x002e.

Today I found out that lspci -nn may lie! Please send output from
command: lspci -nn -x because real PCI device id can read only from -x
hexdump output.

> >> >> When booting with the
> >> >> patch applied, I get this in dmesg:
> >> >> 
> >> >> [    3.556599] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver
