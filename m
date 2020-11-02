Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD22A2FE2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgKBQdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 11:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgKBQdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 11:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604334833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbKWk4lTBUBGa0ylPpXBJpgOZLx72W10WQDMVESut9A=;
        b=FzfC6eBfbdJgUKl0fZRR6f+PgK4kxUWl4H92ebzHj/Rj/JCg+ftMjVOxzeBfiGxHCd9wz0
        9eT5GIFQ8jvs8BPVhaNbBdr95q1TbjH+lK7BiooAgL2k9xvZhB4AiI1jAZ9Ykwfc1fTIp4
        gH+cB7GOKYPZMu0w7ywWUcrqEB5Ahqo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-_zHyotzUM9K9nACIvz1YCg-1; Mon, 02 Nov 2020 11:33:51 -0500
X-MC-Unique: _zHyotzUM9K9nACIvz1YCg-1
Received: by mail-qk1-f198.google.com with SMTP id u16so9000665qkm.22
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2020 08:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cbKWk4lTBUBGa0ylPpXBJpgOZLx72W10WQDMVESut9A=;
        b=GjNZcZx+oRV3wEFtPT3SXZflbsE7lpanvxCuOui0JWZx+JoGvWLvz6DwdSBYCRTCNd
         92nmSM21DKCVS/ReWQ/MIsfVI16g2E/eEqaUGgJbAz+WysSyWuo/4AGtyDngerQJXIIu
         NjkapfFYl3aGDWsGK2AOjZCOyUOloCY4uuQoXHnPgVtor3Uk9ielsCr9Wg6NtZdMOAHh
         LdlcO08WzRVudxbtaMqY4UTPidwVEHd4ZyYJLRYASzdRR11iH2ex56ub6tadDWxwrBb8
         4VrnwHi/SiX5n93hkjq7ONjNEY6Nq2nrZJwU+FfsBed7UbBc7JayTuMaimj4uCDRaRPf
         GGtw==
X-Gm-Message-State: AOAM530sKNiQOTpBBvsHw4BHhu8ba5W4NZW6PwBJLhRK1AUqohkzA4a4
        ImFeQSqy5CUuPAiW32StxV1oLUnAkE3eAsThZxpfDBJizRqA4sceX5n8gMW5xAAIKPk4ooH8LM7
        W3diWzeDqcNZOQXI/mqXT
X-Received: by 2002:a05:620a:408f:: with SMTP id f15mr1934486qko.276.1604334831078;
        Mon, 02 Nov 2020 08:33:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVC1YBubk+MrOgJonDoMPgB31+AO0pNSRscs67wIE2g2NIPdZBblAz5e5mgqGSd3nYkMFbpw==
X-Received: by 2002:a05:620a:408f:: with SMTP id f15mr1934466qko.276.1604334830862;
        Mon, 02 Nov 2020 08:33:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q20sm4314780qtn.80.2020.11.02.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:33:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7E8E6181CED; Mon,  2 Nov 2020 17:33:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     vtolkm@gmail.com, Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <74a188ac-969e-d28e-005e-e921fc4a1990@gmail.com>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali> <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com> <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali> <877dr3lpok.fsf@toke.dk>
 <74a188ac-969e-d28e-005e-e921fc4a1990@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 02 Nov 2020 17:33:47 +0100
Message-ID: <87v9enk9as.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@googlem=
ail.com> writes:

> On 02/11/2020 16:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>
>>> On Saturday 31 October 2020 13:49:49 Toke H=C3=B8iland-J=C3=B8rgensen w=
rote:
>>>> "=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@go=
oglemail.com> writes:
>>>>
>>>>> On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
>>>>>> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>>>>>>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>>>>>>> My experience with that WLE900VX card, aardvark driver and aspm co=
de:
>>>>>>>>
>>>>>>>> Link training in GEN2 mode for this card succeed only once after r=
eset.
>>>>>>>> Repeated link retraining fails and it fails even when aardvark is
>>>>>>>> reconfigured to GEN1 mode. Reset via PERST# signal is required to =
have
>>>>>>>> working link training.
>>>>>>>>
>>>>>>>> What I did in aardvark driver: Set mode to GEN2, do link training.=
 If
>>>>>>>> success read "negotiated link speed" from "Link Control Status Reg=
ister"
>>>>>>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
>>>>>>>> retrain link again (for WLE900VX now it would be at GEN1). After t=
hat
>>>>>>>> card is stable and all future retraining (e.g. from aspm.c) also p=
asses.
>>>>>>>>
>>>>>>>> If I do not change aardvark mode from GEN2 to GEN1 the second link
>>>>>>>> training fails. And if I change mode to GEN1 after this failed link
>>>>>>>> training then nothing happen, link training do not success.
>>>>>>>>
>>>>>>>> So just speculation now... In current setup initialization of card=
 does
>>>>>>>> one link training at GEN2. Then aspm.c is called which is doing se=
cond
>>>>>>>> link retraining at GEN2. And if it fails then below patch issue th=
ird
>>>>>>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as aar=
dvark
>>>>>>>> then second link retraining must be at GEN1 (not GEN2) to workarou=
nd
>>>>>>>> this issue.
>>>>>>>>
>>>>>>>> Bjorn, Toke: what about trying to hack aspm.c code to never do link
>>>>>>>> retraining at GEN2 speed? And always force GEN1 speed prior link
>>>>>>>> training?
>>>>>>> Sounds like a plan. I poked around in aspm.c and must confess to be=
ing a
>>>>>>> bit lost in the soup of registers ;)
>>>>>>>
>>>>>>> So if one of you can cook up a patch, that would be most helpful!
>>>>>> I modified Bjorn's patch, explicitly set tls to 1 and added debug in=
fo
>>>>>> about cls (current link speed, that what is used by aardvark). It is
>>>>>> untested, I just tried to compile it.
>>>>>>
>>>>>> Can try it?
>>>>>>
>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>>> index 253c30cc1967..f934c0b52f41 100644
>>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>>> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link_=
state *link)
>>>>>>    	unsigned long end_jiffies;
>>>>>>    	u16 reg16;
>>>>>>=20=20=20=20
>>>>>> +	u32 lnkcap2;
>>>>>> +	u16 lnksta, lnkctl2, cls, tls;
>>>>>> +
>>>>>> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
>>>>>> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
>>>>>> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>>>>>> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
>>>>>> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>>>>>> +
>>>>>> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x =
lnkctl2 %#06x tls %#03x\n",
>>>>>> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
>>>>>> +		lnksta, cls,
>>>>>> +		lnkctl2, tls);
>>>>>> +
>>>>>> +	tls =3D 1;
>>>>>> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
>>>>>> +					PCI_EXP_LNKCTL2_TLS, tls);
>>>>>> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>>>>>> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
>>>>>> +		lnkctl2, tls);
>>>>>> +
>>>>>>    	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>>>>>>    	reg16 |=3D PCI_EXP_LNKCTL_RL;
>>>>>>    	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>>>>>> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_s=
tate *link)
>>>>>>    			break;
>>>>>>    		msleep(1);
>>>>>>    	} while (time_before(jiffies, end_jiffies));
>>>>>> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
>>>>>> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>>>>>>    	return !(reg16 & PCI_EXP_LNKSTA_LT);
>>>>>>    }
>>>>>>=20=20=20=20
>>>>> Still exhibiting the BAR update error, run tested with next--20201030
>>>> Yup, same for me :(
>>> So then it is different issue and not similar to aardvark one.
>>>
>>> Anyway, was ASPM working on some previous kernel version? Or was it
>>> always broken on Turris Omnia?
>> I tried bisecting and couldn't find a commit that worked. And OpenWrt by
>> default builds with ASPM off, so my best guess is that it was always
>> broken.
>>
>> However, the two other PCI slots *do* work with ASPM on, as long as
>> they're both occupied when booting. If I only have one card installed
>> apart from the dodge WLE900, both of them fail...
>
> Just to be sure it is not a (particular) mPCIe slot issue on the TO -=20
> did you change the device order in the mPCIe slots?

No, I didn't.

> On my node:
>
> - right slot (next to the CPU) hosts a SSD
> - centre slot hosts WLE900VX
> - left slot (over the SIM card slot) hosts the WLE200N2

That's the same order as the PCI subsystem enumerates the slots (on my
machine at least). I have WLE200/WLE900/MT76 in those three slots, which
makes slot 1 and 3 work, while slot 2 craps out. If I remove the MT76
card (as it was originally), neither of slots 1 and 2 work...

-Toke

