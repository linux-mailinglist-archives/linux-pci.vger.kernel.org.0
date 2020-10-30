Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04282A0888
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 15:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgJ3OyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgJ3OyJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 10:54:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEDC0613D2
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2020 07:54:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s9so6763970wro.8
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2020 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:subject:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=jzD2HVl59X0YDAG+WqtPi1o5hytTbKQnAoekM9dzEhc=;
        b=Q4vAYk3pawuscwqKmF+4xpRZpLclS2oMDJA8Y7SsjXM+kvm87RzNQiy+/V0wNxAswb
         uW9umM/q1J7tR1j328QU4o6W/NEiG1PQ/8PTp7dWLUYqw8l87fh+fDY2kv2OdzfMZ5Gv
         EzIiCUAy1tXwsuSUm/iWpN4QdNLrP88OygpbEivcmmGyffTmiaudyw/asQ7uOCvh3pUN
         7RudLso5YZ3L182bS7uG55jztgtLO03eQMOySTe698pthL5c5iSv8tBEGHPa7hr4FyK/
         eSvcV55BJY0FXf5obEhfrmlyS/z8UhdD3NVYFGWu/FXjgeNLv3MZK4GDSJamE+AudAKT
         RXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:subject:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=jzD2HVl59X0YDAG+WqtPi1o5hytTbKQnAoekM9dzEhc=;
        b=WD26KMd877hHrCoaEg4u+3PBnCWRPc6nenwPkxesmVQlAZSjNx46Dy7boskGqS3w4E
         B8Qe9gHn5uBc1NUKncJkLQ94PHJ0hg+nX9Ws0OojxAIE3tWp/Y81al+lT0jgWbx7PDfG
         EVyCR1AhHl5YTH4voqRCIl9n334CZOM91yQ7hzQj44G35swacVD44P37A7VJeOuMi/8S
         igCeN0H3g8PFq+DWBnS+dieoQiEN5XceZyeoC200y5D/F/r7eIsBSnluKCgCIaTZjbTh
         IdlPW74wnIKIE6vdfbbcujrXcegYCecyFaYntl+TiE66uGF+g3FrVsvYpgvPjJxIMyYt
         OJsQ==
X-Gm-Message-State: AOAM5304NJEmovYNjZ5GNUBsV6Z1DX/AH67QII86Nh27iR7O6hIku/7S
        LLOjAAdzv69gg4LHEKTbXIbbm3KLUDzvcQ==
X-Google-Smtp-Source: ABdhPJzmuORsLzeJhvZkc1mu4zyIaEWYz+rz7XyhrAarCDj8K3EleEX5iRycZpZVyig8d94vF6c9UQ==
X-Received: by 2002:adf:94e3:: with SMTP id 90mr3423005wrr.380.1604069647768;
        Fri, 30 Oct 2020 07:54:07 -0700 (PDT)
Received: from [192.168.84.205] ([46.59.206.4])
        by smtp.gmail.com with UTF8SMTPSA id w1sm10320597wrp.95.2020.10.30.07.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 07:54:06 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali> <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Message-ID: <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com>
Date:   Fri, 30 Oct 2020 14:54:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201030142337.yushrdcuecycfhcu@pali>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iNj1Bpp3pzEJBFUbtMYrmU9u98TV4eD9K"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iNj1Bpp3pzEJBFUbtMYrmU9u98TV4eD9K
Content-Type: multipart/mixed; boundary="2TgkLWz2pxUA87bhJxtTxlawYF3TwbdQS";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>
Message-ID: <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali> <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
In-Reply-To: <20201030142337.yushrdcuecycfhcu@pali>

--2TgkLWz2pxUA87bhJxtTxlawYF3TwbdQS
Content-Type: multipart/mixed;
 boundary="------------EE0EA5DB0EB44833C0DECFB9"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------EE0EA5DB0EB44833C0DECFB9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>> My experience with that WLE900VX card, aardvark driver and aspm code:=

>>>
>>> Link training in GEN2 mode for this card succeed only once after rese=
t.
>>> Repeated link retraining fails and it fails even when aardvark is
>>> reconfigured to GEN1 mode. Reset via PERST# signal is required to hav=
e
>>> working link training.
>>>
>>> What I did in aardvark driver: Set mode to GEN2, do link training. If=

>>> success read "negotiated link speed" from "Link Control Status Regist=
er"
>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
>>> retrain link again (for WLE900VX now it would be at GEN1). After that=

>>> card is stable and all future retraining (e.g. from aspm.c) also pass=
es.
>>>
>>> If I do not change aardvark mode from GEN2 to GEN1 the second link
>>> training fails. And if I change mode to GEN1 after this failed link
>>> training then nothing happen, link training do not success.
>>>
>>> So just speculation now... In current setup initialization of card do=
es
>>> one link training at GEN2. Then aspm.c is called which is doing secon=
d
>>> link retraining at GEN2. And if it fails then below patch issue third=

>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as aardva=
rk
>>> then second link retraining must be at GEN1 (not GEN2) to workaround
>>> this issue.
>>>
>>> Bjorn, Toke: what about trying to hack aspm.c code to never do link
>>> retraining at GEN2 speed? And always force GEN1 speed prior link
>>> training?
>> Sounds like a plan. I poked around in aspm.c and must confess to being=
 a
>> bit lost in the soup of registers ;)
>>
>> So if one of you can cook up a patch, that would be most helpful!
> I modified Bjorn's patch, explicitly set tls to 1 and added debug info
> about cls (current link speed, that what is used by aardvark). It is
> untested, I just tried to compile it.
>
> Can try it?
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..f934c0b52f41 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link_sta=
te *link)
>   	unsigned long end_jiffies;
>   	u16 reg16;
>  =20
> +	u32 lnkcap2;
> +	u16 lnksta, lnkctl2, cls, tls;
> +
> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> +
> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x lnk=
ctl2 %#06x tls %#03x\n",
> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
> +		lnksta, cls,
> +		lnkctl2, tls);
> +
> +	tls =3D 1;
> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
> +					PCI_EXP_LNKCTL2_TLS, tls);
> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
> +		lnkctl2, tls);
> +
>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>   	reg16 |=3D PCI_EXP_LNKCTL_RL;
>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_stat=
e *link)
>   			break;
>   		msleep(1);
>   	} while (time_before(jiffies, end_jiffies));
> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
>   }
>  =20

Still exhibiting the BAR update error, run tested with next--20201030


0.396182] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
0.396205] mvebu-pcie soc:pcie: Parsing ranges property...
0.396222] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0x00f108=
0000..0x00f1081fff ->=20
0x0000080000
0.396251] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0x00f104=
0000..0x00f1041fff ->=20
0x0000040000
0.396278] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0x00f104=
4000..0x00f1045fff ->=20
0x0000044000
0.396303] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0x00f104=
8000..0x00f1049fff ->=20
0x0000048000
0.396329] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0xffffff=
ffffffffff..0x00fffffffe=20
-> 0x0100000000
0.396340] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO 0xf=
fffffffffffffff..0x00fffffffe=20
-> 0x0100000000
0.396351] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0xffffff=
ffffffffff..0x00fffffffe=20
-> 0x0200000000
0.396361] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO 0xf=
fffffffffffffff..0x00fffffffe=20
-> 0x0200000000
0.396372] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0xffffff=
ffffffffff..0x00fffffffe=20
-> 0x0300000000
0.396382] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO 0xf=
fffffffffffffff..0x00fffffffe=20
-> 0x0300000000
0.396393] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0xffffff=
ffffffffff..0x00fffffffe=20
-> 0x0400000000
0.396400] mvebu-pcie soc:pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO 0xf=
fffffffffffffff..0x00fffffffe=20
-> 0x0400000000
0.397280] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
0.397299] pci_bus 0000:00: root bus resource [bus 00-ff]
0.397314] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] =

(bus address [0x00080000-0x00081fff])
0.397327] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] =

(bus address [0x00040000-0x00041fff])
0.397348] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] =

(bus address [0x00044000-0x00045fff])
0.397360] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] =

(bus address [0x00048000-0x00049fff])
0.397371] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
0.397383] pci_bus 0000:00: root bus resource [io=C2=A0 0x1000-0xeffff]
0.397388] pci_bus 0000:00: scanning bus
0.397495] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
0.397509] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
0.398052] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
0.398064] pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
0.398585] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
0.398597] pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
0.399755] pci_bus 0000:00: fixups for bus
0.399773] pci 0000:00:01.0: scanning [bus 00-00] behind bridge, pass 0
0.399777] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]),=20
reconfiguring
0.399784] pci 0000:00:02.0: scanning [bus 00-00] behind bridge, pass 0
0.399787] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]),=20
reconfiguring
0.399794] pci 0000:00:03.0: scanning [bus 00-00] behind bridge, pass 0
0.399797] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]),=20
reconfiguring
0.399803] pci 0000:00:01.0: scanning [bus 00-00] behind bridge, pass 1
0.400032] pci_bus 0000:01: scanning bus
0.400784] pci_bus 0000:01: fixups for bus
0.400794] pci_bus 0000:01: bus scan returning with max=3D01
0.400800] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
0.400808] pci 0000:00:02.0: scanning [bus 00-00] behind bridge, pass 1
0.401032] pci_bus 0000:02: scanning bus
0.401078] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
0.401098] pci 0000:02:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit]
0.401125] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
0.401217] pci 0000:02:00.0: supports D1 D2
0.401614] pci 0000:00:02.0: ASPM: current common clock configuration is=20
inconsistent, reconfiguring
0.401626] pci 0000:00:02.0: lnkcap2 0x00000000 sls 0x00 lnksta 0x1011=20
cls 0x1 lnkctl2 0x0000 tls 0x0
0.401632] pci 0000:00:02.0: lnkctl2 0x00000000 new tls 0x1
0.428701] pci 0000:00:02.0: lnksta 0x1011 new cls 0x1
0.429486] pci_bus 0000:02: fixups for bus
0.429498] pci_bus 0000:02: bus scan returning with max=3D02
0.429504] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
0.429514] pci 0000:00:03.0: scanning [bus 00-00] behind bridge, pass 1
0.429778] pci_bus 0000:03: scanning bus
0.429831] pci 0000:03:00.0: [168c:002e] type 00 class 0x028000
0.429854] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit]
0.429978] pci 0000:03:00.0: supports D1
0.429985] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
0.429992] pci 0000:03:00.0: PME# disabled
0.430403] pci 0000:00:03.0: ASPM: current common clock configuration is=20
inconsistent, reconfiguring
0.430416] pci 0000:00:03.0: lnkcap2 0x00000000 sls 0x00 lnksta 0x1011=20
cls 0x1 lnkctl2 0x0000 tls 0x0
0.430421] pci 0000:00:03.0: lnkctl2 0x00000000 new tls 0x1
0.460692] pci 0000:00:03.0: lnksta 0x1011 new cls 0x1
0.461459] pci_bus 0000:03: fixups for bus
0.461470] pci_bus 0000:03: bus scan returning with max=3D03
0.461476] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
0.461482] pci_bus 0000:00: bus scan returning with max=3D03
0.461552] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0000000-0xe02fffff]
0.461561] pci 0000:00:03.0: BAR 8: assigned [mem 0xe0300000-0xe03fffff]
0.461568] pci 0000:00:01.0: BAR 6: assigned [mem 0xe0400000-0xe04007ff pr=
ef]
0.461576] pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff pr=
ef]
0.461583] pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe06007ff pr=
ef]
0.461593] pci 0000:00:01.0: PCI bridge to [bus 01]
0.461620] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0000000-0xe01fffff=20
64bit]
0.461627] pci 0000:02:00.0: BAR 0: error updating (0xe0000004 !=3D 0xffff=
ffff)
0.461633] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=3D=20
0xffffffff)
0.461639] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0200000-0xe020ffff pr=
ef]
0.461645] pci 0000:00:02.0: PCI bridge to [bus 02]
0.461651] pci 0000:00:02.0:=C2=A0=C2=A0 bridge window [mem 0xe0000000-0xe=
02fffff]
0.461666] pci 0000:03:00.0: BAR 0: assigned [mem 0xe0300000-0xe030ffff=20
64bit]
0.461673] pci 0000:03:00.0: BAR 0: error updating (0xe0300004 !=3D 0xffff=
ffff)
0.461678] pci 0000:03:00.0: BAR 0: error updating (high 0x000000 !=3D=20
0xffffffff)
0.461683] pci 0000:00:03.0: PCI bridge to [bus 03]
0.461689] pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [mem 0xe0300000-0xe=
03fffff]
0.461701] pci 0000:00:01.0: Max Payload Size set to=C2=A0 128/ 128 (was 1=
28),=20
Max Read Rq=C2=A0 128
0.461710] pci 0000:00:02.0: Max Payload Size set to=C2=A0 128/ 128 (was 1=
28),=20
Max Read Rq=C2=A0 128
0.461715] pci 0000:02:00.0: Failed attempting to set the MPS
0.461721] pci 0000:02:00.0: Max Payload Size set to=C2=A0 128/ 256 (was 1=
28),=20
Max Read Rq=C2=A0 128
0.461729] pci 0000:00:03.0: Max Payload Size set to=C2=A0 128/ 128 (was 1=
28),=20
Max Read Rq=C2=A0 128
0.461734] pci 0000:03:00.0: Failed attempting to set the MPS
0.461740] pci 0000:03:00.0: Max Payload Size set to=C2=A0 128/ 128 (was 1=
28),=20
Max Read Rq=C2=A0 128
0.461855] pcieport 0000:00:01.0: assign IRQ: got 0
0.461866] pcieport 0000:00:01.0: enabling bus mastering
0.461959] pcieport 0000:00:02.0: assign IRQ: got 0
0.461966] pcieport 0000:00:02.0: enabling device (0140 -> 0142)
0.461980] pcieport 0000:00:02.0: enabling bus mastering
0.462065] pcieport 0000:00:03.0: assign IRQ: got 0
0.462070] pcieport 0000:00:03.0: enabling device (0140 -> 0142)
0.462080] pcieport 0000:00:03.0: enabling bus mastering
2.467153] pci 0000:00:03.0: enabling bus mastering
2.519024] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=3D134=

2.531459] ath10k_pci 0000:02:00.0: assign IRQ: got 0
2.536915] pci 0000:00:02.0: enabling bus mastering
2.540553] ath10k_pci 0000:02:00.0: can't change power state from D3hot=20
to D0 (config space inaccessible)
2.580450] ath10k_pci 0000:02:00.0: failed to wake up device : -110
2.586973] ath10k_pci 0000:02:00.0: disabling bus mastering
2.587220] ath10k_pci: probe of 0000:02:00.0 failed with error -110
2.605598] ehci-pci: EHCI PCI platform driver



--------------EE0EA5DB0EB44833C0DECFB9
Content-Type: application/pgp-keys;
 name="OpenPGP_0x729CFF47A416598B.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0x729CFF47A416598B.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFnci1cBEADV+6MUQB11XNt9PDm/dG33t5n6G5UhCjvkAYwgqwzemL1hE/z4/OfidLLY8=
Zgi
Jy6/Vsxwi6B9BM54RRCLqniD+GKc6vZVzx9mr4M1rYmGmTobXyDVR1cXDJC5khUx9pC++oUDP=
bCs
i8uXqKHCuqNNB7Xx6SrWJkVcY8hMnGg6QvOK7ZDY5JOCWw9UEcdQuUFx9y/ar2xreikE4r3+X=
ZUZ
xqKVkvJS6IvgiOnDtic0gq2u23vlXPXkkrijmVJi7igA4qVRV4aT8vzqyAM0c2NaQk4UcLkaf=
+Wc
5oCz0Xv1ao3VTXqU0eYH5xvAAfYqmfIeqRvakOfIzpuNpWEQKhjn6cQtNtMN4SVGs5Uu09OVq=
TVu
vP7CeZNt3QQ13OJLZ/y4mpikQTFXjlQSkw51tH3VqJE+GJ3lE/Z1Slb/kbc40ZghriZqH8MDL=
MPu
juMuI0ki+3KPpnd6gAiMVcm/ZR9Zay14F6pHP3AfUYxt+wQHbDemPmxPijTrCwK0HmADOg+n5=
jzL
dCXOnZlZgr5EHIzAox8qpybBH6XLwGOfRb1YszH8aeCiE3KOnvSzFJt4tW3bRUAXIsfU9Hau0=
y2Z
d29hs5KT6p3W6Evo41L9YZ2Kh49nEH30LZWU3ef0gJTsk5JADz1qcc2D3w+I2rNvzN7NbT7OL=
CGB
H5BjXmRFLvmR9wARAQABzRB2dG9sa21AZ21haWwuY29twsGUBBMBCAA+FiEEZA5pVNb1NUiO3=
cgJ
cpz/R6QWWYsFAlnci1cCGwMFCQYRI9kFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQcpz/R=
6QW
WYuWoQ//RqAvkxS8SCYeCS9V2ozBBzGl+n4Duk8R/JH9MF31MBSqz6wT1fWSu4sKUIgyvOlHn=
JMQ
HFC5zWfBl3czTcXiKC02SCqw0TyekCrWsCGbNDtAXQ0pVwIrAAjHSHlt1szaZVmA8fW/WAAK/=
cx4
GyMHa7J9Ll2S7fAiIjGCBsWskO9PMaWCmxZ/1CXucMr9q+7CZaDHyIFx4zuzYY06in8H7k+iA=
aCA
uppOlI7/KZ2bgEUB71EgkJog0MGJyTfnztso1E7DHwg/E8TryAr8GPdNDx6L+wcyrAH/30dDp=
WoU
mAURwsCj8o5fu2/b+7bpNt9D0ZipO+swhfBGs16OI0eydgU7tvFlge9fPeJQ618R7h4jLAyA4=
g8X
SwqsDG5pJV4Pp+F6RgJu21U/6C3IdOJLY3ZLXJ1vNsC9Ymj46TuozAqsgJ9c1QMkASCNYqa35=
ag/
to8vBfAcOH5CgpsDaISs+fXPtjZfIE+q7aapvNNrY2cg3d1DzwgiVRPCa3owCGO29biJVIJ/W=
oVC
kLTJbzY0W2T0gB3dGzeL8Wr4GYOaqH9qWq0SvYXLosRoTrAi2heC5sUghTfUnc2mF4iVmyJNp=
mjx
ov/fnAlOcjOrBs2g7LTD9F9eVldb54F49s0RqTPyc6qpygYBHYHql3afpfZgHhHEU62SQ8hrq=
qc/
mrySjlDOwU0EWdyLVwEQAL1H9kXHD02X8DPokRtFyToTdbJshYMsKnpILTQ3UJgUXreTDBUYT=
vBG
oPEhlQVlFNvND6cy08IcdDi0VHl/aLm/oRVJa/AlAXPAad4HnEB0RckuKfoSQoq0UDRmM+DLi=
jgu
oEwSUfwfuk9XGs1arnaLNV+kJvj1O/cvwRDfPiFwYBFfNOO0iDWdVSOCGWirNLUBdpx4hWX0n=
XqH
u0wql8bGInqNPp4Cc36VtCEid6aORhfzkplfmQUchHNblpYOFqdqNX2qQhfrN/nNY5fNhEyu6=
MSe
SdahWYEC0RH17bTX+gmwJ61AwvgS1tsRL4ekzRtquDC4FUGLDrl2EM9FuqW/3Pr0Z8o2afjek=
LPF
G/sEsuDdloBYQG/6bPKbNMnd19db09OzO+GgsiX/A7he0WAKz3fA1WSSY7FH4275islD9v+tL=
RRS
spe4MRmV48tyysmHrzFXRZhrGT+M+qCX5a7KyOKV5o7odBTclI2nbm49a9gaskPQb2na37Wh+=
9/9
+fWdn8MnS1cPbtjQuFGeOnFGoZ2FJ1kZFSW3ZNH/zsUX1LMkI/fA109zy3rOzStZEXgNahfIP=
/uS
qP6N4/RbQY4WmtbURQEXe+CYNfI0Q5dwy9q/95+wzdwSLJMSksJERKVTRE1cvld03oIJEbSvZ=
A50
g1m1jqQJNjG3zHs4aoaxABEBAAHCwXwEGAEIACYWIQRkDmlU1vU1SI7dyAlynP9HpBZZiwUCW=
dyL
VwIbDAUJBhEj2QAKCRBynP9HpBZZi2O1EACpzIUzidoN+jFBPKwD+TD1oWBjwXb2XtJw/ztBx=
/XH
n7diGw8wh0wSpKr8/KtT2boSBLL4CyxWA2h+XO+TYuzyaGzB9gqPB6ghIByXpzdNS/bahaO9E=
dw1
3HWvy7Kn1E/uugrEveFNscx7yVtKXA90E7RYGRnrXuVnZJwjCkS8719+QMEJST6ZUK+Fw5rAI=
YZx
pZk1ZUrDN5VBtRWSSUv/cwkmyVenX+Ix+hDGnPseFtEwuLu/hxtE/Mp2A5M/d/hPININEDVxX=
jRy
PYf1/zLcC+l72dwIyZER2zvRBiwPJhWZi56WfmnoTIVfUeyDfY1IW6OlUbur/r0gpW4sAKNd2=
/70
5wtGd8n/W6jT3nFfsfk8Tw83FpJYjmQCft3r5yQiMcC8jBPXh3QUXKcAGafT8BH5S8tBRyt9i=
hSO
xoCU+/2LUwNVMn8Po/lN5RmXDvbuIeP3EQTMRjTZDOujXzCE64PJCr9Gn6DasIEtjCLSWVIy7=
Hf0
bmxHySkhZyl2u+2uA8kUMQzrZS/dEF5d7EeG69eKRFhs7e1jEgfOoX48q5D9Wwk3kiIe3rAN0=
4w4
cIPBfY9W9tsF8DoP0I3G2hp41r5FYktkVwyktIzrktnJprnpw6pOtFdsFe8hboqTitA8WCmUo=
hYz
6g5W+3igWYa5LWJ8nxCJbQIZaeAoTkFyGw=3D=3D
=3DBH6L
-----END PGP PUBLIC KEY BLOCK-----

--------------EE0EA5DB0EB44833C0DECFB9--

--2TgkLWz2pxUA87bhJxtTxlawYF3TwbdQS--

--iNj1Bpp3pzEJBFUbtMYrmU9u98TV4eD9K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+cKQ0FAwAAAAAACgkQcpz/R6QWWYvD
8w/8C3f/a1QnYW/i2MakuPVJleqdfL8uZVZsFGDc9qfOL8tzz9TQIXqeRsyyRDwdo8xHDH6XOhj1
PHKGhFSmSV/f2MX5nokFVeBQjKUsKAyIDtLULnCtLKHJNuduGXm6Aup25taQZx6/b9LWOYiA07Ac
lhR7Iwr+ZKariOU6aKFOqvMRpnm0iqEK2/Xgk7xGhZxaC4yYdNKQN/dKMMf3jQmvQwRoGyLOw/hK
iA6bfDbDCsAQRggOL+9VNwtjd+NAI/RVipRU39NzdxulTMzYMeDhexm1/qdTKrRZAq4JZIRvMLG5
+0pIVVPZgePZALyA/Z3Q7PyVaWs5dde9yQPdEfRrSwB+ttVmX7WMCrClHf0+8/7X7mrpUITP95A4
rQvhDviJXlkS0WSmfxP2sUTzzbO/qYVt9OdbPqwGZ8F9+PUMWKbdU0+i+jss1Si1zxg6xYX5NtEb
nazVTm1WEDYVpuhM09rEKLRCX2XAMAoHC6oUDRkYYC2LipKDG0o6hJYWM1SkFmh2W0prxy5s6YjK
F40VtySfJOPIFCAgVSp/ySC8BhhSMAzxaCxXuFEpcVWNOznPIf/0t0IjjgIGmrkkfDvdeV2bXbiL
o71FAkKR8M8VGykzPMh9/da3iWVb0PNH1ix36CgJTWyTHNL3Qey04pT+tYGEkPU7WBjOnTVKWvfA
eo4=
=zAEh
-----END PGP SIGNATURE-----

--iNj1Bpp3pzEJBFUbtMYrmU9u98TV4eD9K--
