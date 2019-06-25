Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5D52089
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfFYCFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 22:05:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:35425 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbfFYCFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 22:05:08 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 488C6891A9;
        Tue, 25 Jun 2019 14:05:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1561428305;
        bh=+6URSfGtIdmUEn9Jok/S4j5d2CkYStHkZ1g8pNXng0E=;
        h=From:To:CC:Subject:Date:References;
        b=0k0CcKHQFnLwzTLuvJNcizX25qlsvfR4/h0JHu6wP2R8r0WiwGJF1d77CLG9OvbW8
         +q8ppt+u/Pb9+Si21qLowc4HwYnxuTDEIBneMFHuTnU2dR4cLQ69NVEa4erK6Zoi+T
         q5aMND/wS+kVACUSsJpIyboMj1IT0esbC6t+0HUeSI7Qkc7eHykIHs7kwLrZ+NtKmu
         D0ynAAVrBnQcWWAI26AADyrWxOZVh9uD56z9cHYB2ooP0l5uHVS5gcazUAPlwg4Szi
         mEXxdhwB/Azuw+KQvQ5fkGX3kEr0YSsYAw7Eg0ygcJugOmEfRlK0TE5kjArd3yAF1/
         XCa45k36Q5pFA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d1181510001>; Tue, 25 Jun 2019 14:05:05 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Tue, 25 Jun 2019 14:05:05 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 25 Jun 2019 14:05:05 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC:     Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kirkwood PCI Express and bridges
Thread-Topic: Kirkwood PCI Express and bridges
Thread-Index: AQHVJ+ZHqWcIqP7kgUutSbOlaor9TQ==
Date:   Tue, 25 Jun 2019 02:05:04 +0000
Message-ID: <dc50b20e47d94f2294b3d8889d0468c4@svr-chch-ex1.atlnz.lc>
References: <403548ec3a7543b08ca32e47a1465e70@svr-chch-ex1.atlnz.lc>
 <20190621073318.3bcd940e@windsurf>
 <936d1790c94f4b9c884bc79819b8b777@svr-chch-ex1.atlnz.lc>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/06/19 4:08 PM, Chris Packham wrote:=0A=
> Hi Thomas,=0A=
> =0A=
> On 21/06/19 6:17 PM, Thomas Petazzoni wrote:=0A=
>> Hello Chris,=0A=
>>=0A=
>> On Fri, 21 Jun 2019 04:03:27 +0000=0A=
>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:=0A=
>>=0A=
>>> I'm in the process of updating the kernel version used on our products=
=0A=
>>> from 4.4 -> 5.1.=0A=
>>>=0A=
>>> We have one product that uses a Kirkwood CPU, IDT PCI bridge and Marvel=
l=0A=
>>> Switch ASIC. The Switch ASIC presents as multiple PCI devices.=0A=
>>>=0A=
>>> The hardware setup looks like this=0A=
>>>                                         __________=0A=
>>> [ Kirkwood ] --- [ IDT 5T5 ] ---+---  |          |=0A=
>>>                                  +---  |  Switch  |=0A=
>>>                                  +---  |          |=0A=
>>>                                  +---  |__________|=0A=
>>>=0A=
>>> On the 4.4 based kernel things are fine=0A=
>>>=0A=
>>> [root@awplus flash]# lspci -t=0A=
>>> -[0000:00]---01.0-[01-06]----00.0-[02-06]--+-02.0-[03]----00.0=0A=
>>>                                               +-03.0-[04]----00.0=0A=
>>>                                               +-04.0-[05]----00.0=0A=
>>>                                               \-05.0-[06]----00.0=0A=
>>>=0A=
>>> But on the 5.1 based kernel things get a little weird=0A=
>>>=0A=
>>> [root@awplus flash]# lspci -t=0A=
>>> -[0000:00]---01.0-[01-06]--+-00.0-[02-06]--=0A=
>>>                               +-01.0=0A=
>>>                               +-02.0-[02-06]--=0A=
>>>                               +-03.0-[02-06]--=0A=
>>>                               +-04.0-[02-06]--=0A=
>>>                               +-05.0-[02-06]--=0A=
>>>                               +-06.0-[02-06]--=0A=
>>>                               +-07.0-[02-06]--=0A=
>>>                               +-08.0-[02-06]--=0A=
>>>                               +-09.0-[02-06]--=0A=
>>>                               +-0a.0-[02-06]--=0A=
>>>                               +-0b.0-[02-06]--=0A=
>>>                               +-0c.0-[02-06]--=0A=
>>>                               +-0d.0-[02-06]--=0A=
>>>                               +-0e.0-[02-06]--=0A=
>>>                               +-0f.0-[02-06]--=0A=
>>>                               +-10.0-[02-06]--=0A=
>>>                               +-11.0-[02-06]--=0A=
>>>                               +-12.0-[02-06]--=0A=
>>>                               +-13.0-[02-06]--=0A=
>>>                               +-14.0-[02-06]--=0A=
>>>                               +-15.0-[02-06]--=0A=
>>>                               +-16.0-[02-06]--=0A=
>>>                               +-17.0-[02-06]--=0A=
>>>                               +-18.0-[02-06]--=0A=
>>>                               +-19.0-[02-06]--=0A=
>>>                               +-1a.0-[02-06]--=0A=
>>>                               +-1b.0-[02-06]--=0A=
>>>                               +-1c.0-[02-06]--=0A=
>>>                               +-1d.0-[02-06]--=0A=
>>>                               +-1e.0-[02-06]--=0A=
>>>                               \-1f.0-[02-06]--+-02.0-[03]----00.0=0A=
>>>                                               +-03.0-[04]----00.0=0A=
>>>                                               +-04.0-[05]----00.0=0A=
>>>                                               \-05.0-[06]----00.0=0A=
>>>=0A=
>>>=0A=
>>> I'll start bisecting to see where things started going wrong. I just=0A=
>>> wondered if this rings any bells for anyone.=0A=
>>=0A=
>> I am almost sure that the culprit is=0A=
>> 1f08673eef1236f7d02d93fcf596bb8531ef0d12 ("PCI: mvebu: Convert to PCI=0A=
>> emulated bridge config space").=0A=
> =0A=
> The problem seems to pre-date this commit. I've gone back as far as 4.18=
=0A=
> and the problem still exists (in fact there are more duplicate devices).=
=0A=
> I'll keep going back (unfortunately due to out platform being out of=0A=
> tree it's not a simple bisect).=0A=
> =0A=
>> I still think it makes sense to share the bridge emulation code between=
=0A=
>> the mvebu and aardvark drivers, but this sharing has required making=0A=
>> the code very different, with lots of subtle differences in behavior in=
=0A=
>> how registers are emulated.=0A=
> =0A=
> Agreed. Bugs love to hide in duplicated code.=0A=
> =0A=
> I will admit to being ignorant about the need for an emulated bridge. I=
=0A=
> know it has something to do with the type of transaction used for the=0A=
> downstream devices. I also know that these systems won't work without an=
=0A=
> emulated bridge.=0A=
> =0A=
>> Unfortunately, I don't have access to one of these complicated PCI=0A=
>> setup with a HW switch on the way, so I couldn't test this kind of=0A=
>> setups.=0A=
>>=0A=
>> Do you mind helping with figuring out what the issues are ? That would=
=0A=
>> be really nice.=0A=
> =0A=
> No problem. As I said I'll keep going to find a point where behaviour=0A=
> turns bad for me. I suspect we might find other problems along the way.=
=0A=
> =0A=
=0A=
Some progress. Our defconfig had CONFIG_CMDLINE=3D"pci=3Dpcie_scan_all" in =
=0A=
it. This dated back to before we were using a devicetree with our =0A=
kirkwood platforms. At some point this started having an effect on the =0A=
emulated bridge.=0A=
