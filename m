Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B5D3501D3
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhCaODL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 10:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235835AbhCaOC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 10:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617199372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hlmnr+UG7BiBkvH30HcnEtujKeCz3ed2vJqeg/FJdVc=;
        b=ip33lVK/YvMR8Rw6b7UarFIvTbpxq+Urg6Pz+uvkraPoaGpG68986dsYvL2gHvO32+tV3T
        Sg7+hL5uSoOWyomw0C66EkS4/bAqub6gHyknVhOmWQn/KU+C5fptuviTOzU7WpySkOfFvs
        LlL6TwRTwzdFA04RO/6OcteeRPiw5CY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Q2rQZ3QUOf6Ghd14OMUxYA-1; Wed, 31 Mar 2021 10:02:47 -0400
X-MC-Unique: Q2rQZ3QUOf6Ghd14OMUxYA-1
Received: by mail-ej1-f69.google.com with SMTP id gv58so836789ejc.6
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 07:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Hlmnr+UG7BiBkvH30HcnEtujKeCz3ed2vJqeg/FJdVc=;
        b=hKUl3eUNfrOo+uuvFKJrxoBT52NmTp8zGS+F575KbV7BuoN+7HZZyh+3HunPvI52Vt
         I8NUotjV+5xly/B3aDPIH6AZpF0rVdXFp14iTpSJxJ4xpFEphIi25SQUGi+GcHOvPidH
         jL6lMnL93+fR1odJ6sh5UNRrn+HkS9ogJGC1Uk/q52AdotwhR35ChgGrdUmmtWJbInEg
         WrnhsauA0Cg7eBfelhXq5nZXScdM3xfMw+m+IDUpx/eHtIef/227Eo8AEyOmL85jbmUn
         Ivbet13RSm0/Pfbcp0/l/ap1zVeu3aMFnyHG6paVKmOdASQTLoHDQDKXHKAl5+dcC99l
         rZGw==
X-Gm-Message-State: AOAM533IXgjJplbSfiyWF7S3omdaqK55kX7EBq8/ciUWg1b+i3FrXL5T
        it9ZZax6ISHlpvjpSM0yDM/DusJyvODbCu2RJXsjaYO1iYaJ+vQrfRBcwUlmowtr5dnW5Rok4/C
        HmdtO86kT/PVOa6BYNa4n
X-Received: by 2002:a17:906:753:: with SMTP id z19mr3710756ejb.447.1617199364680;
        Wed, 31 Mar 2021 07:02:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRe7Y9ZHWzTmLS3+8EDQWcF0PD3xKiXOeEFU0qSXaxunupi50J+lB6I8tYs2mDqSGXffkT7g==
X-Received: by 2002:a17:906:753:: with SMTP id z19mr3710713ejb.447.1617199364155;
        Wed, 31 Mar 2021 07:02:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l10sm1710023edr.87.2021.03.31.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 07:02:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 385211801A8; Wed, 31 Mar 2021 16:02:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20210329170929.uhpttc4oxbkghkpr@pali>
References: <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali> <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali> <874kgyc4yg.fsf@toke.dk>
 <20210326153444.cdccc3e2axqxzejy@pali> <87o8f5c0tt.fsf@toke.dk>
 <20210326171100.s53mslkjc7tdgs6f@pali> <87ft0hby6p.fsf@toke.dk>
 <20210329170929.uhpttc4oxbkghkpr@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 31 Mar 2021 16:02:42 +0200
Message-ID: <87im57pgjh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Friday 26 March 2021 18:51:42 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> > On Friday 26 March 2021 17:54:38 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> >> So we have these
>> >> cases:
>> >>=20
>> >> ASPM disabled:          ath9k, ath10k and mt76 cards all work
>> >> ASPM enabled, no patch: only mt76 card works
>> >> ASPM enabled + patch:   ath10k and mt76 cards work
>> >>=20
>> >> So IDK, maybe the ath9k card needs a quirk as well? Or the mvebu board
>> >> is just generally flaky?
>> >
>> > I'm not sure. Maybe ASPM is somehow buggy on ath9k or needs some speci=
al
>> > handling. But issue is not at PCI config space as ath9k driver start
>> > initialization of this card. Needs also some debugging in ath9k driver
>> > if it prints that strange "mac chip rev" error.
>>=20
>> Well that's just being output because it gets a revision that it doesn't
>> recognise - which it seems to be just reading from a register:
>>=20
>> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/=
ath9k/hw.c#L255
>>=20
>> The value returned is consistent with the value returned just being
>> 0xffffffff. Which from looking at ioread32() is the value being returned
>> on a failed read. So there's a driver bug there - the check against -EIO
>> here is obviously nonsensical:
>>=20
>> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/=
ath9k/hw.c#L290
>>=20
>> But the underlying cause appears to be that the read from the register
>> fails, which I suppose is related to something the PCI bus does?
>>=20
>> > I think this issue should be handled separately. Could you report it
>> > also to ath9k mailing list (and CC me)? Maybe other ath developers wou=
ld
>> > know some more details.
>>=20
>> I'll send a patch for the nonsensical check above, but other than that I
>> think we're still in PCI land here, or?
>
> First, can you try to enable my quirk also for this ath9k card with ASPM
> enabled?

Yup, with this I get both devices working:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8ff690c7679d..7e2f9c69f6b2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3583,6 +3583,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003=
4, quirk_no_bus_reset);
  * PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 regis=
ter.
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset=
_and_no_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x002e, quirk_no_bus_reset=
_and_no_retrain_link);
=20
 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus

>
> I have there another ath9k card which after toggling link retraining
> changes PCI device ID (really!) to 0xABCD. But lspci ...
>
> There is long story about broken ath9k cards that are reporting 0xABCD
> id on x86 machines with specific BIOS versions. It can be find in
> ath9k-devel mailing list archive:
>
> https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
>
> Maybe we now found root cause of this ABCD? If yes, then it also answers
> why above ath9k driver check fails (device id was changed) and also
> because kernel see correct id (kernel reads id before configuring ASPM
> and therefore before triggering link retraining).
>
>> >> > Can you send PCI device id of your ath9k card (lspci -nn)? Because =
all
>> >> > my tested ath9k cards have different PCI device id.
>> >>=20
>> >> [root@omnia-arch ~]# lspci -nn
>> >> 00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab=
:6820] (rev 04)
>> >> 00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab=
:6820] (rev 04)
>> >> 00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab=
:6820] (rev 04)
>> >> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless N=
etwork Adapter (PCI-Express) [168c:002e] (rev 01)
>> >> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.=
11ac Wireless Network Adapter [168c:003c]
>> >
>> > That is fine. Also all ath9k testing cards have id 0x002e.
>
> Today I found out that lspci -nn may lie! Please send output from
> command: lspci -nn -x because real PCI device id can read only from -x
> hexdump output.

Without the quirk added to the ath9k:

01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network=
 Adapter (PCI-Express) [168c:002e] (rev 01)
00: 8c 16 2e 00 02 00 10 00 01 00 80 02 10 00 00 00
10: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 a4 30
30: 00 00 00 00 40 00 00 00 00 00 00 00 3d 01 00 00

02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac W=
ireless Network Adapter [168c:003c]
00: 8c 16 3c 00 46 05 10 00 00 00 80 02 10 00 00 00
10: 04 00 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 20 ea 40 00 00 00 00 00 00 00 3e 01 00 00

And with:

01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network=
 Adapter (PCI-Express) [168c:002e] (rev 01)
00: 8c 16 2e 00 46 01 10 00 01 00 80 02 10 00 00 00
10: 04 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 a4 30
30: 00 00 00 00 40 00 00 00 00 00 00 00 3d 01 00 00

02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac W=
ireless Network Adapter [168c:003c]
00: 8c 16 3c 00 46 05 10 00 00 00 80 02 10 00 00 00
10: 04 00 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 20 ea 40 00 00 00 00 00 00 00 3e 01 00 00



Is that change in bytes 5 and 6 significant?

-Toke

