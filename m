Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E504029CBAD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 23:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756644AbgJ0WBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 18:01:45 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44329 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756627AbgJ0WBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 18:01:45 -0400
Received: by mail-ej1-f68.google.com with SMTP id j24so787380ejc.11
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=nUKleN41fyPNv2FziJKZ6HQJOJmdNssWjWlA+E6dTG8=;
        b=bWsvFrayEyu7LME4OkN/hQLBcbt8wQS+hWl00x9nUNWUb/1SWlJetQOHAShkvLVK0x
         rlT1EqzeB0t3zE9aHM6Y9BPS82YjNpkrjv2VTiVV4B6ejGAyj4GcFTFOS/MeHzEFQCAU
         npp4k73gqOG6kvz8r7QGbrDZY3DF8EJca8p2cOE/f91a+MY/kRS4Cwe7jP1RvLPJ+5kw
         4lAWYtEcYZvlNBj96Mg+oksIgB1ct+3tBhXWhVVUAYs1kDzXgCt0efoBFrGodvjWcKBH
         0w2AUlv1sb7McRrkcphN5KlsiNXeNTglh26rJsSVWpV4/bbkvc1ppRkMaAO1Kos4Etoc
         0E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=nUKleN41fyPNv2FziJKZ6HQJOJmdNssWjWlA+E6dTG8=;
        b=QjbDFGJoxLlBHAcYLYxUPQOrD5lSF/V1wGtz3Levqctw2qdf+iqzekeZWwBPmezhU0
         4xuBI4NkNd3Qi0bp/gZKHKks90e/S9XqJ6sMWmMXMRyS8qYSJw94AqUJVQQYwLQqCZFV
         6BxxbKHO8QSlUtGT/1Kl3NpJ8bFwfrT0Jtzh8uexpqjTcQ3Njy98xc8oYNHVZ1VbO4Pm
         Fm0xW1kMGvqSoCmbOzQfwfu1/udVpE5vs8IxxDrPgPTXnblr5H5CuGAH0TTvGrJwZUk5
         I/XrEPY47BmsW4ZIW/G03ymzuwLYPt80v9YT234LbGdBVVwnDWpB35QMj+x7LImaijIR
         alPA==
X-Gm-Message-State: AOAM53147RC97YCSPlt0B7s0tAxBUExcbn2Rxfr8PAA0cJmEvbkONPuK
        +LHmDCdJUlKAyg54uPLLKPNTLCdWaIM=
X-Google-Smtp-Source: ABdhPJy3leVyAocCPH0+5m+qgR7lMczGXm38KuZRn35JCCc13EntJ5SpFeXCLvH/zQmVybZjje+DxA==
X-Received: by 2002:a17:906:a10a:: with SMTP id t10mr4708101ejy.89.1603836101530;
        Tue, 27 Oct 2020 15:01:41 -0700 (PDT)
Received: from [192.168.84.205] ([46.59.133.241])
        by smtp.gmail.com with UTF8SMTPSA id k23sm1758918ejs.100.2020.10.27.15.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 15:01:40 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com> <87d013wl52.fsf@toke.dk>
 <874kmfwhdb.fsf@toke.dk> <03d03828-fec2-5062-5c0b-ffc1df719911@gmail.com>
 <87y2jruziw.fsf@toke.dk>
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <15545174-46bf-8a35-0612-950a3dbefd0a@gmail.com>
Date:   Tue, 27 Oct 2020 22:01:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <87y2jruziw.fsf@toke.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BrtZM9vkaPmv1G66S0x25GZZTcujTpbGu"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BrtZM9vkaPmv1G66S0x25GZZTcujTpbGu
Content-Type: multipart/mixed; boundary="glrtN4QxK1CLlK9nmKk6EHW3tYIDtpXo8";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>
Message-ID: <15545174-46bf-8a35-0612-950a3dbefd0a@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com> <87d013wl52.fsf@toke.dk>
 <874kmfwhdb.fsf@toke.dk> <03d03828-fec2-5062-5c0b-ffc1df719911@gmail.com>
 <87y2jruziw.fsf@toke.dk>
In-Reply-To: <87y2jruziw.fsf@toke.dk>

--glrtN4QxK1CLlK9nmKk6EHW3tYIDtpXo8
Content-Type: multipart/mixed;
 boundary="------------EC1D6C053E8350127B2E7536"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------EC1D6C053E8350127B2E7536
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 27/10/2020 22:31, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> To follow up on this, everything seems to work just fine (ath10k init=
 at
>>> boot + regulatory db load) if I simply set:
>>>
>>> CONFIG_EXTRA_FIRMWARE=3D"ath10k/QCA988X/hw2.0/board.bin ath10k/QCA988=
X/hw2.0/firmware-5.bin regulatory.db regulatory.db.p7s"
>>>
>>> -Toke
>>>
>> That works on my node only for the regulatory files but not the ath10
>> firmware with kconfig:
>>
>>   =C2=A0Symbol: EXTRA_FIRMWARE_DIR [=3D/srv/fw]
>>   =C2=A0Type=C2=A0 : string
>>   =C2=A0Defined at drivers/base/firmware_loader/Kconfig:63
>>   =C2=A0=C2=A0 Prompt: Firmware blobs root directory
>>   =C2=A0=C2=A0 Depends on: FW_LOADER [=3Dy] && EXTRA_FIRMWARE [=3Dregu=
latory.db
>> regulatory.db.p7s board.bin firmware-5.bin]!=3D
>>   =C2=A0=C2=A0 Location:
>>   =C2=A0=C2=A0=C2=A0 -> Device Drivers
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Generic Driver Options
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware loader
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware l=
oading facility (FW_LOADER [=3Dy])
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
> Build named firmware blobs into the kernel binary
>> (EXTRA_FIRMWARE [=3Dregulatory.db regulatory.db.p7s board.bin
>> firmware-5.bin])
> I think that's because you're missing the path prefix
> (ath10k/QCA988X/hw2.0/) from board.bin and firmware-5.bin?
> request_firmware() uses the full path...
>
> -Toke

Well, that would be weird/strange having to specify the path prefix for=20
build-in firmware,considering:

 =C2=A0CONFIG_FW_LOADER:

 =C2=A0This enables the firmware loading facility in the kernel. The kern=
el
 =C2=A0will first look for built-in firmware, if it has any. Next, it wil=
l
 =C2=A0look for the requested firmware in a series of filesystem paths:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o firmware_class path module parame=
ter or kernel boot param
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware/updates/UTS_RELEASE=

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware/updates
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware/UTS_RELEASE
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware

----

Nevertheless, I tried with same path prefix as per your kconfig but the=20
compilation fails, which I am not surprised since the ath10 blobs are=20
not located at that path

 =C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0 drivers/base/firmware_loader/builtin/=
regulatory.db.gen.S
 =C2=A0 UPD drivers/base/firmware_loader/builtin/regulatory.db.p7s.gen.S
make[4]: *** No rule to make target=20
'/srv/fw/ath10k/QCA988X/hw2.0/board.bin', needed by=20
'drivers/base/firmware_loader/builtin/ath10k/QCA988X/hw2.0/board.bin.gen.=
o'.=20
Stop.
make[4]: *** Waiting for unfinished jobs....
 =C2=A0 UPD=20
drivers/base/firmware_loader/builtin/ath10k/QCA988X/hw2.0/board.bin.gen.S=

make[3]: *** [scripts/Makefile.build:500:=20
drivers/base/firmware_loader/builtin] Error 2
make[2]: *** [scripts/Makefile.build:500: drivers/base/firmware_loader]=20
Error 2
make[1]: *** [scripts/Makefile.build:500: drivers/base] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1799: drivers] Error 2
make: *** Waiting for unfinished jobs....

I suspect that since you are booting the kernel directly from my build=20
box over tftp it accesses the ath10 firmware blobs on the build box.




--------------EC1D6C053E8350127B2E7536
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

--------------EC1D6C053E8350127B2E7536--

--glrtN4QxK1CLlK9nmKk6EHW3tYIDtpXo8--

--BrtZM9vkaPmv1G66S0x25GZZTcujTpbGu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+YmMQFAwAAAAAACgkQcpz/R6QWWYup
/Q/5Aa63R+WcY7udO8B2wfui69q3h2uDwKFeWe9k/qmyME4ogEsLpc15+0PcWUp9uaGyEelhsNbY
RWTfLTIndYiMoxWv64C+8DcWSa4tqOgpYqp3CKJlWj70MKx8QUL/gqP2Hnef28UgHGXl9zesk+Yy
T99bQ7+gPwNMf6L9eRCG2W9Tb6ApqV/p/fFz+Rjm6mYHxdkD1MuMrCR/Rfd6fElLYCtYl7t/8/OV
3hNIertZDEJBXAZAHLbcAcqHAuybpQ7via3dwl2SsOs6RIBQYiSDbDGIjiiZ96kgyHEwrrt4d1se
xgX0QwiyGbMFUbgcc8CFzBEE2ZascFZVRNkH/Y1T9Pshj+skEV+Y2x04YP1vVZZPIOtXzH6tGl5g
v2bS/eF2BOuAnJqcqBRmVX46mkTSfmW3R5rpKVEbxjw4lGVWkQMHVt9oMLhW5ro6+elanI6CERgl
LHoQ8ALVf8Qxln+6NpnuaYVvZx+WvV5hLiFh4DxHqM3+xTJ3xBlbxyaktssqWxUggjuEqnPnfQ0r
HnZgKD+VLnEeR2A+bfl38ER3xxt5RQWm/lyshrxLwdwhXVfMIwpPXbjKsnN3VsWVkQtVcRKaRl1s
Uk0RD16ix6FE7GU/EQIi2/Zf9v1C5P5vMxUXhxX9ffTdtgw1f6W6pBGcQr7v9ODjCgH+D0TpXI+m
IIs=
=x8Ad
-----END PGP SIGNATURE-----

--BrtZM9vkaPmv1G66S0x25GZZTcujTpbGu--
