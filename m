Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9444350522
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhCaQxx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 12:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232406AbhCaQxV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 12:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DgbjJQxaI1SV4rGX0KjktrAl4EiEIsLd6qWYsSp47qo=;
        b=Ki5O/0P7G+WwJfOkuqc5iR0L4JT9YOlKIHV1DN+uF07xnSC/5yMFhNXO40K2zAgmllDr0u
        Lod8uRJRXBV1c3r+aVN9tyz2Cul3JeBpqoxWYj3s420a/Sjhu8R6qAwqctY4Q+bm9ZxaRD
        S+i4LSntFCnX9EuB01YqLt3N07PInD8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-Xkw26JvmORWqhegTt6p6Zw-1; Wed, 31 Mar 2021 12:53:12 -0400
X-MC-Unique: Xkw26JvmORWqhegTt6p6Zw-1
Received: by mail-ed1-f72.google.com with SMTP id r19so1447060edv.3
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DgbjJQxaI1SV4rGX0KjktrAl4EiEIsLd6qWYsSp47qo=;
        b=ogg41c7PFtCarbYwPLbmEeQfQHhU17XB+Mueuq77fC/UG9l7DWoPTzIW2MV+mXZynb
         hNuxqIIBr4yNMp8d8F3MUhP+K/8Pefe0N2NKj9O3ZXh/QoqY12nytwF5QuIuL1islnKu
         eCACvKz7VjLiFSxE09Pjy6bHUzUZZc9c+aweCO8LpwnK8Nt3t0s4eYimSdJKR1i1RQV1
         ELcLsN2cZLO9dRbGVdbO0y4gv1TA2kwRBxw/SOjWC1z4b3EIBk+oTJjBV/E9ifDbSY6n
         9wLPjXPSO3Jdxn3V9MExQtyQOGNAOGRifTQECe9adXGiuXaPnvWLcvcMHdRZc3m3AkiH
         HRBQ==
X-Gm-Message-State: AOAM5310Lfu8pCJwnDIsf2L0G/2Z3S2htv/cCvJYR69OKF/eoF2CGuhH
        99bHz3pz2Rhi6VpSTS/0HiF/pajtxrnDM6nNlJaLEOWz8j6FW3z/xT2WusZb+JeYEVDliqSVa9H
        RETqtkKuDRhCNN3Zz5Xje
X-Received: by 2002:a17:906:495a:: with SMTP id f26mr4438986ejt.271.1617209590831;
        Wed, 31 Mar 2021 09:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsxVxiLlOP4j4Ol3+GusyqLdmOcQhxh78uvh5p414DwCZr0HCwFEHLA8EqcEhY31FMrGPVow==
X-Received: by 2002:a17:906:495a:: with SMTP id f26mr4438945ejt.271.1617209590309;
        Wed, 31 Mar 2021 09:53:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p24sm2067022edt.5.2021.03.31.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 09:53:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E1B711801A8; Wed, 31 Mar 2021 18:53:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20210331161542.3e57qdtwnoz74xea@pali>
References: <87h7l8axqp.fsf@toke.dk> <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali> <874kgyc4yg.fsf@toke.dk>
 <20210326153444.cdccc3e2axqxzejy@pali> <87o8f5c0tt.fsf@toke.dk>
 <20210326171100.s53mslkjc7tdgs6f@pali> <87ft0hby6p.fsf@toke.dk>
 <20210329170929.uhpttc4oxbkghkpr@pali> <87im57pgjh.fsf@toke.dk>
 <20210331161542.3e57qdtwnoz74xea@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 31 Mar 2021 18:53:08 +0200
Message-ID: <87a6qjp8nf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Wednesday 31 March 2021 16:02:42 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>=20
>> > On Friday 26 March 2021 18:51:42 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> >> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >> > On Friday 26 March 2021 17:54:38 Toke H=C3=B8iland-J=C3=B8rgensen w=
rote:
>> >> >> So we have these
>> >> >> cases:
>> >> >>=20
>> >> >> ASPM disabled:          ath9k, ath10k and mt76 cards all work
>> >> >> ASPM enabled, no patch: only mt76 card works
>> >> >> ASPM enabled + patch:   ath10k and mt76 cards work
>> >> >>=20
>> >> >> So IDK, maybe the ath9k card needs a quirk as well? Or the mvebu b=
oard
>> >> >> is just generally flaky?
>> >> >
>> >> > I'm not sure. Maybe ASPM is somehow buggy on ath9k or needs some sp=
ecial
>> >> > handling. But issue is not at PCI config space as ath9k driver start
>> >> > initialization of this card. Needs also some debugging in ath9k dri=
ver
>> >> > if it prints that strange "mac chip rev" error.
>> >>=20
>> >> Well that's just being output because it gets a revision that it does=
n't
>> >> recognise - which it seems to be just reading from a register:
>> >>=20
>> >> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/a=
th/ath9k/hw.c#L255
>> >>=20
>> >> The value returned is consistent with the value returned just being
>> >> 0xffffffff. Which from looking at ioread32() is the value being retur=
ned
>> >> on a failed read. So there's a driver bug there - the check against -=
EIO
>> >> here is obviously nonsensical:
>> >>=20
>> >> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/a=
th/ath9k/hw.c#L290
>> >>=20
>> >> But the underlying cause appears to be that the read from the register
>> >> fails, which I suppose is related to something the PCI bus does?
>> >>=20
>> >> > I think this issue should be handled separately. Could you report it
>> >> > also to ath9k mailing list (and CC me)? Maybe other ath developers =
would
>> >> > know some more details.
>> >>=20
>> >> I'll send a patch for the nonsensical check above, but other than tha=
t I
>> >> think we're still in PCI land here, or?
>> >
>> > First, can you try to enable my quirk also for this ath9k card with AS=
PM
>> > enabled?
>>=20
>> Yup, with this I get both devices working:
>>=20
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 8ff690c7679d..7e2f9c69f6b2 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3583,6 +3583,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x=
0034, quirk_no_bus_reset);
>>   * PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 re=
gister.
>>   */
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_re=
set_and_no_retrain_link);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x002e, quirk_no_bus_re=
set_and_no_retrain_link);
>>=20=20
>>  /*
>>   * Root port on some Cavium CN8xxx chips do not successfully complete a=
 bus
>
> Ok, thank you for testing!
>
> I'm seeing that testing unit 0x0030 (AR93xx) also needs this quirk, so I
> will mark all Atheros chips in above no bus reset list with no retrain
> link quirk.

SGTM.

>> >
>> > I have there another ath9k card which after toggling link retraining
>> > changes PCI device ID (really!) to 0xABCD. But lspci ...
>> >
>> > There is long story about broken ath9k cards that are reporting 0xABCD
>> > id on x86 machines with specific BIOS versions. It can be find in
>> > ath9k-devel mailing list archive:
>> >
>> > https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
>> >
>> > Maybe we now found root cause of this ABCD? If yes, then it also answe=
rs
>> > why above ath9k driver check fails (device id was changed) and also
>> > because kernel see correct id (kernel reads id before configuring ASPM
>> > and therefore before triggering link retraining).
>> >
>> >> >> > Can you send PCI device id of your ath9k card (lspci -nn)? Becau=
se all
>> >> >> > my tested ath9k cards have different PCI device id.
>> >> >>=20
>> >> >> [root@omnia-arch ~]# lspci -nn
>> >> >> 00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [1=
1ab:6820] (rev 04)
>> >> >> 00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [1=
1ab:6820] (rev 04)
>> >> >> 00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [1=
1ab:6820] (rev 04)
>> >> >> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireles=
s Network Adapter (PCI-Express) [168c:002e] (rev 01)
>> >> >> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 8=
02.11ac Wireless Network Adapter [168c:003c]
>> >> >
>> >> > That is fine. Also all ath9k testing cards have id 0x002e.
>> >
>> > Today I found out that lspci -nn may lie! Please send output from
>> > command: lspci -nn -x because real PCI device id can read only from -x
>> > hexdump output.
>>=20
>> Without the quirk added to the ath9k:
>>=20
>> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Netw=
ork Adapter (PCI-Express) [168c:002e] (rev 01)
>> 00: 8c 16 2e 00 02 00 10 00 01 00 80 02 10 00 00 00
>> 10: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 a4 30
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 3d 01 00 00
>>=20
>> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11a=
c Wireless Network Adapter [168c:003c]
>> 00: 8c 16 3c 00 46 05 10 00 00 00 80 02 10 00 00 00
>> 10: 04 00 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 20 ea 40 00 00 00 00 00 00 00 3e 01 00 00
>>=20
>> And with:
>>=20
>> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Netw=
ork Adapter (PCI-Express) [168c:002e] (rev 01)
>> 00: 8c 16 2e 00 46 01 10 00 01 00 80 02 10 00 00 00
>> 10: 04 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 a4 30
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 3d 01 00 00
>>=20
>> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11a=
c Wireless Network Adapter [168c:003c]
>> 00: 8c 16 3c 00 46 05 10 00 00 00 80 02 10 00 00 00
>> 10: 04 00 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 20 ea 40 00 00 00 00 00 00 00 3e 01 00 00
>>=20
>
> Yesterday both MJ and Bjorn told me to use lspci '-b' switch which
> instruct lspci to parse capabilities from config space (instead of
> kernel cache).
>
> Could you try to run 'lspci -nn -vv' and 'lspci -nn -vv -b' and compare
> results? If something changes?

Without -b there seems to be some [size=3DXX] suffixes to some lines, and
there are some AtomicOpsCap lines that are not there with -b. Also, the
IRQ number and memory offset for ath10k changed like this:

-	Interrupt: pin A routed to IRQ 63
-	Region 0: Memory at e0200000 (64-bit, non-prefetchable) [size=3D2M]
-	Expansion ROM at e0400000 [disabled] [size=3D64K]
+	Interrupt: pin A routed to IRQ 62
+	Region 0: Memory at e0200000 (64-bit, non-prefetchable)
+	Expansion ROM at ea200000 [disabled]

> Anyway I have discussion with Adrian Chadd about 0xABCD issue and these
> Qualcomm/Atheros cards. When post-AR9300 card is not initialized it
> reports PCI device id 0xABCD. Pre-AR9300 cards should report correct PCI
> device id even when it is not initialized. WLE200 is AR9287-based, so it
> reports always correct id, should not change it during usage.

Right, makes sense.

> But seems that also this AR9287 has issue with EEPROM/OTP as you figured
> out that ath9k driver is not able to read some device id from internal
> register. So please prepare patch for fixing -EIO in ath9k.

Yup, already did, just forgot to Cc you (sorry about that):
https://patchwork.kernel.org/project/linux-wireless/patch/20210326180819.14=
2480-1-toke@redhat.com/

> PCI vendor & device id is in first 4 bytes and as you can see it is
> correct and was not changed.
>
> So I guess lspci output would not change for this card.
>
>> Is that change in bytes 5 and 6 significant?
>
> At offset 0x04 is 16bit PCI Command Register.
>
> In second (with) output is set bit 2 which means that Bus Mastering is
> enabled. This is normal and required when card communicate with system.
> Then is enabled bit 6 (Parity Error Response) and bit 8 (SERR# Enable),
> both for error reporting. This is normal when device is active.
>
> So nothing suspicious here.

Alright, cool. Thanks a lot for your help with this :)

-Toke

