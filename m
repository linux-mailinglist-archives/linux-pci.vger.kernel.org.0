Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9262A2F86
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgKBQSu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 11:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQSu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 11:18:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB259C0617A6
        for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2020 08:18:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id x7so15318672wrl.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2020 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=QDeuwvxTzDolhRYyFyptF/3VQlovfi+Ipp5EA1QHEEk=;
        b=jztXaNHE77C3KHKICkvpEocqf/VBwDTbzpbKlRYkwWfk3VBoi6sw883ToEwyJXFHfB
         /0T7MYmkXyQe207RvwMNOt28/lxWhF6cvhzmpJF8/4hCu3uN0+D1db72s/GvIyfZvoiu
         ot5CTWkjbCG+daFnJjj8sv96Tjqnr+nGPPXVx1jJZaFN30veexgvL66d3LgEy4dhO2u9
         ZmqTaY7CraPOhKk9vOlVyhSg+8Fsq82u1XSkzDAw+Xdj72LV5n7adFydpWfIf7zB+vwV
         HPnSR5c+dv8PVr2jHY7huNgr5DK6aE6KGq2RzbtgvkKQx3soN2fxiDu8QAgc18HLWio0
         R9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=QDeuwvxTzDolhRYyFyptF/3VQlovfi+Ipp5EA1QHEEk=;
        b=qX80LB369nnZ5QrR3XHjd5CfbOKbsZRoDcwQXTGwUWMyiWVwI1FEUU2mV23ZRDepZB
         3t9h5Vqer+8wmvVhlVZM5pqhjYMiXgUmcqSBY+BtwnaZuQshD74FOGNDNK6F7tpHII/I
         8EJ7Cjc9VR5Tpd7w+j9XeMS10TgsytfPBnCemCVUb0JF5DH/HgDUU96pBBaCJV+G3I3x
         BIP1p4dftgUYPa/aGJstqte+RuwF6EZtHQKFNYyzGhlWsGSqWUydujOn6Z6nG4o0tlIz
         glFoWZkHNerhhE7KHrFYm5dBf45rE+B2PUllk3hEY81sjZGP9tJl2+My6+4hVhTE0cgf
         QRPQ==
X-Gm-Message-State: AOAM533QxKNWBa1dmF1gAxVujCwHuwi2vUmo4zHdxLsef3aOBj59vLuJ
        3xiqFV2kqynixOKHSI6h4mUEV4vINi4=
X-Google-Smtp-Source: ABdhPJwbVTGwmXsaG/DBKEckz7ZXk0dw4OTtzciT1xjuaiUbxWAC6G/7gxVn4FN/pgLd/ao3Qaeggg==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr20980102wrv.36.1604333928599;
        Mon, 02 Nov 2020 08:18:48 -0800 (PST)
Received: from [192.168.84.205] ([149.224.92.143])
        by smtp.gmail.com with UTF8SMTPSA id t5sm16907836wmg.19.2020.11.02.08.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:18:47 -0800 (PST)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
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
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com> <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali> <877dr3lpok.fsf@toke.dk>
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <74a188ac-969e-d28e-005e-e921fc4a1990@gmail.com>
Date:   Mon, 2 Nov 2020 16:18:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <877dr3lpok.fsf@toke.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2MxNYuYkGkRSWu1ik0YKYb6tBACpOxBkl"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2MxNYuYkGkRSWu1ik0YKYb6tBACpOxBkl
Content-Type: multipart/mixed; boundary="rxAEt67WFpY2X1cVcmWAavF0B0wVkK5EI";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>
Message-ID: <74a188ac-969e-d28e-005e-e921fc4a1990@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali> <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com> <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali> <877dr3lpok.fsf@toke.dk>
In-Reply-To: <877dr3lpok.fsf@toke.dk>

--rxAEt67WFpY2X1cVcmWAavF0B0wVkK5EI
Content-Type: multipart/mixed;
 boundary="------------B1AD90CCD108371E03EAF763"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------B1AD90CCD108371E03EAF763
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 02/11/2020 16:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Pali Roh=C3=A1r <pali@kernel.org> writes:
>
>> On Saturday 31 October 2020 13:49:49 Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>>> "=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@g=
ooglemail.com> writes:
>>>
>>>> On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
>>>>> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=C3=B8rgensen=
 wrote:
>>>>>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>>>>>> My experience with that WLE900VX card, aardvark driver and aspm c=
ode:
>>>>>>>
>>>>>>> Link training in GEN2 mode for this card succeed only once after =
reset.
>>>>>>> Repeated link retraining fails and it fails even when aardvark is=

>>>>>>> reconfigured to GEN1 mode. Reset via PERST# signal is required to=
 have
>>>>>>> working link training.
>>>>>>>
>>>>>>> What I did in aardvark driver: Set mode to GEN2, do link training=
=2E If
>>>>>>> success read "negotiated link speed" from "Link Control Status Re=
gister"
>>>>>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And the=
n
>>>>>>> retrain link again (for WLE900VX now it would be at GEN1). After =
that
>>>>>>> card is stable and all future retraining (e.g. from aspm.c) also =
passes.
>>>>>>>
>>>>>>> If I do not change aardvark mode from GEN2 to GEN1 the second lin=
k
>>>>>>> training fails. And if I change mode to GEN1 after this failed li=
nk
>>>>>>> training then nothing happen, link training do not success.
>>>>>>>
>>>>>>> So just speculation now... In current setup initialization of car=
d does
>>>>>>> one link training at GEN2. Then aspm.c is called which is doing s=
econd
>>>>>>> link retraining at GEN2. And if it fails then below patch issue t=
hird
>>>>>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as aa=
rdvark
>>>>>>> then second link retraining must be at GEN1 (not GEN2) to workaro=
und
>>>>>>> this issue.
>>>>>>>
>>>>>>> Bjorn, Toke: what about trying to hack aspm.c code to never do li=
nk
>>>>>>> retraining at GEN2 speed? And always force GEN1 speed prior link
>>>>>>> training?
>>>>>> Sounds like a plan. I poked around in aspm.c and must confess to b=
eing a
>>>>>> bit lost in the soup of registers ;)
>>>>>>
>>>>>> So if one of you can cook up a patch, that would be most helpful!
>>>>> I modified Bjorn's patch, explicitly set tls to 1 and added debug i=
nfo
>>>>> about cls (current link speed, that what is used by aardvark). It i=
s
>>>>> untested, I just tried to compile it.
>>>>>
>>>>> Can try it?
>>>>>
>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>> index 253c30cc1967..f934c0b52f41 100644
>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link=
_state *link)
>>>>>    	unsigned long end_jiffies;
>>>>>    	u16 reg16;
>>>>>   =20
>>>>> +	u32 lnkcap2;
>>>>> +	u16 lnksta, lnkctl2, cls, tls;
>>>>> +
>>>>> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
>>>>> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
>>>>> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>>>>> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
>>>>> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>>>>> +
>>>>> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x=
 lnkctl2 %#06x tls %#03x\n",
>>>>> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
>>>>> +		lnksta, cls,
>>>>> +		lnkctl2, tls);
>>>>> +
>>>>> +	tls =3D 1;
>>>>> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
>>>>> +					PCI_EXP_LNKCTL2_TLS, tls);
>>>>> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>>>>> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
>>>>> +		lnkctl2, tls);
>>>>> +
>>>>>    	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>>>>>    	reg16 |=3D PCI_EXP_LNKCTL_RL;
>>>>>    	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>>>>> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_=
state *link)
>>>>>    			break;
>>>>>    		msleep(1);
>>>>>    	} while (time_before(jiffies, end_jiffies));
>>>>> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
>>>>> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>>>>>    	return !(reg16 & PCI_EXP_LNKSTA_LT);
>>>>>    }
>>>>>   =20
>>>> Still exhibiting the BAR update error, run tested with next--2020103=
0
>>> Yup, same for me :(
>> So then it is different issue and not similar to aardvark one.
>>
>> Anyway, was ASPM working on some previous kernel version? Or was it
>> always broken on Turris Omnia?
> I tried bisecting and couldn't find a commit that worked. And OpenWrt b=
y
> default builds with ASPM off, so my best guess is that it was always
> broken.
>
> However, the two other PCI slots *do* work with ASPM on, as long as
> they're both occupied when booting. If I only have one card installed
> apart from the dodge WLE900, both of them fail...

Just to be sure it is not a (particular) mPCIe slot issue on the TO -=20
did you change the device order in the mPCIe slots?

On my node:

- right slot (next to the CPU) hosts a SSD
- centre slot hosts WLE900VX
- left slot (over the SIM card slot) hosts the WLE200N2


--------------B1AD90CCD108371E03EAF763
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

--------------B1AD90CCD108371E03EAF763--

--rxAEt67WFpY2X1cVcmWAavF0B0wVkK5EI--

--2MxNYuYkGkRSWu1ik0YKYb6tBACpOxBkl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+gMWUFAwAAAAAACgkQcpz/R6QWWYuQ
PA//QZeWTLNtMYFQHuktY+k0TJ8yr5rcd3FDYxNSLflsMkuDBbVx2zcsgevoMqd4xquGcVnRdPol
+pb4pmMVWumZX1ovhjLMEG43QxpP2+mYC8Nr4rExZ/Sf2AMDlhHjWTnb+KeE0LIjnm0ChkcCkTt9
GXJC33Ev820r2S22GGS3b7ICNIxEWxgJB2B5jR+1A4zqsZ9Zunrv71FZy5RDKoXtyaUw2wDCNY9v
ttweS5BrOWqMPdF7ehVRI/h+3MbpRfJ8oE/WvKWHFLZCOkrkHdMZPkVSbVESnt+NhxxTdOljhqpG
qAAJF03EqwnDJ0iCQaJGaeSpVPt47SQ/mizrSHHphZWgYHhP2hVOpY+9tvVB7pdLqmJBaxBqkBFb
nGiSsO2Rtzlfj014blIl9G0SJpvd+oZVMOCE0Aq08WoFBXqiRFZxVMMhlA2EsXeAt66NuP/qB+hF
X15JWVD2X68l+hFiAfNbn8cMvAgXzIBN1pRycl9g0rPa1stDDNinSiF5IC+nCcV2dsEQ5uaGJqnV
mjxSwcF2Vl5yCw47s9IG2UuifYrv8luqTSlQdwC5SLdHenieBeSIYBFcZv/Ys4At+tZsTNK7ZxXW
bqio2hqcFHFN9yh3lJjAiZpAG+ILXhC9PZml1UxgG7snCd34ffIRzzXT512Bw18WCrET9n+fv0ws
7RE=
=02eO
-----END PGP SIGNATURE-----

--2MxNYuYkGkRSWu1ik0YKYb6tBACpOxBkl--
