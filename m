Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BD35044D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCaQQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 12:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233867AbhCaQPq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 12:15:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58A3F61005;
        Wed, 31 Mar 2021 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617207345;
        bh=BUNwnFSsIIQo5XpiIwa+OiY6tCAbOgLYkN+U7v0grxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAuyOkQE3voJ9HNK0pJT7be0KH/s1KtXnDPkYuuII8uaX737LBHgdqcYVFrqkAM9T
         vr5UzBEmmymprsuGn+qs2tBpPS56pJEAKhWUS0JkMy7nqspRYi5NmGBgDVb+S0kZ+8
         xcClLS+hKVjiK/lf8OB07BJ+zAt9pEPVLiq68q1KEmXpKrLrO+XIuYKqNp4XqGE15Q
         1Qj62KlbQLVZzhW+ua7wS7ms4SiBRjIPJbSKrdUb6F/rV+a0G2VON+TFRGNoAwwWqO
         unSglqNNMnSdKieFNhaJtfb0ryxpgys52WExrJGZfKGVErTNvtQgXjkX0Z0natrk1t
         2446uPgUCNQcQ==
Received: by pali.im (Postfix)
        id D346DAF7; Wed, 31 Mar 2021 18:15:42 +0200 (CEST)
Date:   Wed, 31 Mar 2021 18:15:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20210331161542.3e57qdtwnoz74xea@pali>
References: <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali>
 <874kgyc4yg.fsf@toke.dk>
 <20210326153444.cdccc3e2axqxzejy@pali>
 <87o8f5c0tt.fsf@toke.dk>
 <20210326171100.s53mslkjc7tdgs6f@pali>
 <87ft0hby6p.fsf@toke.dk>
 <20210329170929.uhpttc4oxbkghkpr@pali>
 <87im57pgjh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im57pgjh.fsf@toke.dk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 31 March 2021 16:02:42 Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > On Friday 26 March 2021 18:51:42 Toke Høiland-Jørgensen wrote:
> >> Pali Rohár <pali@kernel.org> writes:
> >> > On Friday 26 March 2021 17:54:38 Toke Høiland-Jørgensen wrote:
> >> >> So we have these
> >> >> cases:
> >> >> 
> >> >> ASPM disabled:          ath9k, ath10k and mt76 cards all work
> >> >> ASPM enabled, no patch: only mt76 card works
> >> >> ASPM enabled + patch:   ath10k and mt76 cards work
> >> >> 
> >> >> So IDK, maybe the ath9k card needs a quirk as well? Or the mvebu board
> >> >> is just generally flaky?
> >> >
> >> > I'm not sure. Maybe ASPM is somehow buggy on ath9k or needs some special
> >> > handling. But issue is not at PCI config space as ath9k driver start
> >> > initialization of this card. Needs also some debugging in ath9k driver
> >> > if it prints that strange "mac chip rev" error.
> >> 
> >> Well that's just being output because it gets a revision that it doesn't
> >> recognise - which it seems to be just reading from a register:
> >> 
> >> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath9k/hw.c#L255
> >> 
> >> The value returned is consistent with the value returned just being
> >> 0xffffffff. Which from looking at ioread32() is the value being returned
> >> on a failed read. So there's a driver bug there - the check against -EIO
> >> here is obviously nonsensical:
> >> 
> >> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath9k/hw.c#L290
> >> 
> >> But the underlying cause appears to be that the read from the register
> >> fails, which I suppose is related to something the PCI bus does?
> >> 
> >> > I think this issue should be handled separately. Could you report it
> >> > also to ath9k mailing list (and CC me)? Maybe other ath developers would
> >> > know some more details.
> >> 
> >> I'll send a patch for the nonsensical check above, but other than that I
> >> think we're still in PCI land here, or?
> >
> > First, can you try to enable my quirk also for this ath9k card with ASPM
> > enabled?
> 
> Yup, with this I get both devices working:
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8ff690c7679d..7e2f9c69f6b2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3583,6 +3583,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>   * PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset_and_no_retrain_link);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x002e, quirk_no_bus_reset_and_no_retrain_link);
>  
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus

Ok, thank you for testing!

I'm seeing that testing unit 0x0030 (AR93xx) also needs this quirk, so I
will mark all Atheros chips in above no bus reset list with no retrain
link quirk.

> >
> > I have there another ath9k card which after toggling link retraining
> > changes PCI device ID (really!) to 0xABCD. But lspci ...
> >
> > There is long story about broken ath9k cards that are reporting 0xABCD
> > id on x86 machines with specific BIOS versions. It can be find in
> > ath9k-devel mailing list archive:
> >
> > https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
> >
> > Maybe we now found root cause of this ABCD? If yes, then it also answers
> > why above ath9k driver check fails (device id was changed) and also
> > because kernel see correct id (kernel reads id before configuring ASPM
> > and therefore before triggering link retraining).
> >
> >> >> > Can you send PCI device id of your ath9k card (lspci -nn)? Because all
> >> >> > my tested ath9k cards have different PCI device id.
> >> >> 
> >> >> [root@omnia-arch ~]# lspci -nn
> >> >> 00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> >> >> 00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> >> >> 00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
> >> >> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e] (rev 01)
> >> >> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
> >> >
> >> > That is fine. Also all ath9k testing cards have id 0x002e.
> >
> > Today I found out that lspci -nn may lie! Please send output from
> > command: lspci -nn -x because real PCI device id can read only from -x
> > hexdump output.
> 
> Without the quirk added to the ath9k:
> 
> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e] (rev 01)
> 00: 8c 16 2e 00 02 00 10 00 01 00 80 02 10 00 00 00
> 10: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 a4 30
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 3d 01 00 00
> 
> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
> 00: 8c 16 3c 00 46 05 10 00 00 00 80 02 10 00 00 00
> 10: 04 00 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 20 ea 40 00 00 00 00 00 00 00 3e 01 00 00
> 
> And with:
> 
> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e] (rev 01)
> 00: 8c 16 2e 00 46 01 10 00 01 00 80 02 10 00 00 00
> 10: 04 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 a4 30
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 3d 01 00 00
> 
> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
> 00: 8c 16 3c 00 46 05 10 00 00 00 80 02 10 00 00 00
> 10: 04 00 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 20 ea 40 00 00 00 00 00 00 00 3e 01 00 00
> 

Yesterday both MJ and Bjorn told me to use lspci '-b' switch which
instruct lspci to parse capabilities from config space (instead of
kernel cache).

Could you try to run 'lspci -nn -vv' and 'lspci -nn -vv -b' and compare
results? If something changes?

Anyway I have discussion with Adrian Chadd about 0xABCD issue and these
Qualcomm/Atheros cards. When post-AR9300 card is not initialized it
reports PCI device id 0xABCD. Pre-AR9300 cards should report correct PCI
device id even when it is not initialized. WLE200 is AR9287-based, so it
reports always correct id, should not change it during usage.

But seems that also this AR9287 has issue with EEPROM/OTP as you figured
out that ath9k driver is not able to read some device id from internal
register. So please prepare patch for fixing -EIO in ath9k.

PCI vendor & device id is in first 4 bytes and as you can see it is
correct and was not changed.

So I guess lspci output would not change for this card.

> Is that change in bytes 5 and 6 significant?

At offset 0x04 is 16bit PCI Command Register.

In second (with) output is set bit 2 which means that Bus Mastering is
enabled. This is normal and required when card communicate with system.
Then is enabled bit 6 (Parity Error Response) and bit 8 (SERR# Enable),
both for error reporting. This is normal when device is active.

So nothing suspicious here.

> -Toke
> 
