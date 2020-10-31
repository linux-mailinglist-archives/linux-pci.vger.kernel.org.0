Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A181F2A177B
	for <lists+linux-pci@lfdr.de>; Sat, 31 Oct 2020 13:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgJaMt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Oct 2020 08:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgJaMt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Oct 2020 08:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604148595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHqG6s2lT3VDoj/QAMTo8QRxHVGhqbEvNUDz3n60Bsk=;
        b=BX9QRJ1XSFRQ+wh1TwCaV1ZbejpU7f1EakSgGMBlOq93iwgPcqjr3mQrCpRDPkR+IdCv97
        c0zPY92bpW5w+HmqIFD93pOdVrcP9Z3ScP30GOFAeyHOWcDY8Jpu1RomI9J1TLpFBtJbRx
        2+hFqkLi8Au4iQXc4ghdztWK5fT6bKQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-QaAW6Ac-N8mVNCC7t-lOSQ-1; Sat, 31 Oct 2020 08:49:53 -0400
X-MC-Unique: QaAW6Ac-N8mVNCC7t-lOSQ-1
Received: by mail-il1-f197.google.com with SMTP id t6so6667762ilj.10
        for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2020 05:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GHqG6s2lT3VDoj/QAMTo8QRxHVGhqbEvNUDz3n60Bsk=;
        b=LOQZUjoJ/MV/9XLukHsANkqBG0G9URXraMoubGzLrl//D9L4YZWfsPBhApGn+/6twP
         PPdk2ZhzHRtdv+BGyHjbFT07llgixapa+Q72IQfdpRuGtgDs4la+LP2AiiXExniGGdPb
         ju9O4Mg86XMQUFyI+5ZRsPAp4V8zMooWSCV829WsRSQEmmpu3Hn3SAgD3C7gqRGnH36M
         tVVv1htEIKxN3m46ZIp04Rf8yD3mBSLzi4471GZtkYIR0ChRweEbCSdx2Re3xCi2K7QE
         1yVOdQyTUNsqF7rw005bJP7+bCRBzWCnQxgm5mP1OmPbYdFIbVRBJFxlcQr1vgckBh0j
         9qbQ==
X-Gm-Message-State: AOAM532NVaFxNJFKHnzpg9f/IWCrivcw2HO3RP3dHjQrEVMJdURmv5FG
        13eeT3vG+b67I9/IsSvQ80wX4JEvl4xRQ206UBRGOk/Gj5cVyFs5sPm6fyS+4N2cgy6xitypIn2
        A9XP0mfR6anmBqkvDUI2s
X-Received: by 2002:a92:9f0c:: with SMTP id u12mr5281344ili.113.1604148592549;
        Sat, 31 Oct 2020 05:49:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgUjuecdKZIBdMAl5N6k3YLEsb/g4tH353sQ6qnIBRy3b4xsC11uKWq3BLHCBrr3uLq/ZPxg==
X-Received: by 2002:a92:9f0c:: with SMTP id u12mr5281329ili.113.1604148592167;
        Sat, 31 Oct 2020 05:49:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r4sm6917700ilj.43.2020.10.31.05.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 05:49:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 96071181AD1; Sat, 31 Oct 2020 13:49:49 +0100 (CET)
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
In-Reply-To: <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali> <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 31 Oct 2020 13:49:49 +0100
Message-ID: <87zh42lfv6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@googlem=
ail.com> writes:

> On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
>> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>>> My experience with that WLE900VX card, aardvark driver and aspm code:
>>>>
>>>> Link training in GEN2 mode for this card succeed only once after reset.
>>>> Repeated link retraining fails and it fails even when aardvark is
>>>> reconfigured to GEN1 mode. Reset via PERST# signal is required to have
>>>> working link training.
>>>>
>>>> What I did in aardvark driver: Set mode to GEN2, do link training. If
>>>> success read "negotiated link speed" from "Link Control Status Registe=
r"
>>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
>>>> retrain link again (for WLE900VX now it would be at GEN1). After that
>>>> card is stable and all future retraining (e.g. from aspm.c) also passe=
s.
>>>>
>>>> If I do not change aardvark mode from GEN2 to GEN1 the second link
>>>> training fails. And if I change mode to GEN1 after this failed link
>>>> training then nothing happen, link training do not success.
>>>>
>>>> So just speculation now... In current setup initialization of card does
>>>> one link training at GEN2. Then aspm.c is called which is doing second
>>>> link retraining at GEN2. And if it fails then below patch issue third
>>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as aardvark
>>>> then second link retraining must be at GEN1 (not GEN2) to workaround
>>>> this issue.
>>>>
>>>> Bjorn, Toke: what about trying to hack aspm.c code to never do link
>>>> retraining at GEN2 speed? And always force GEN1 speed prior link
>>>> training?
>>> Sounds like a plan. I poked around in aspm.c and must confess to being a
>>> bit lost in the soup of registers ;)
>>>
>>> So if one of you can cook up a patch, that would be most helpful!
>> I modified Bjorn's patch, explicitly set tls to 1 and added debug info
>> about cls (current link speed, that what is used by aardvark). It is
>> untested, I just tried to compile it.
>>
>> Can try it?
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 253c30cc1967..f934c0b52f41 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link_stat=
e *link)
>>   	unsigned long end_jiffies;
>>   	u16 reg16;
>>=20=20=20
>> +	u32 lnkcap2;
>> +	u16 lnksta, lnkctl2, cls, tls;
>> +
>> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
>> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
>> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
>> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>> +
>> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x lnkc=
tl2 %#06x tls %#03x\n",
>> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
>> +		lnksta, cls,
>> +		lnkctl2, tls);
>> +
>> +	tls =3D 1;
>> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
>> +					PCI_EXP_LNKCTL2_TLS, tls);
>> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
>> +		lnkctl2, tls);
>> +
>>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>>   	reg16 |=3D PCI_EXP_LNKCTL_RL;
>>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_state=
 *link)
>>   			break;
>>   		msleep(1);
>>   	} while (time_before(jiffies, end_jiffies));
>> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
>> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
>>   }
>>=20=20=20
>
> Still exhibiting the BAR update error, run tested with next--20201030

Yup, same for me :(

-Toke

