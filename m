Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8D29CB22
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 22:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373766AbgJ0VWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 17:22:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33217 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373764AbgJ0VWw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 17:22:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id v4so357928edi.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:subject:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=4pNFbnuCukRyRqU/r38L8QcIUlZrV2YMUjy0m/Ty0Qg=;
        b=uWzoDYdf+Ofb3+NKyFJb9cnClj1+BWsUJVIrnT9wXdg/KUngeHCd0+05eYM80Fj4Y/
         RJ/HIIu7zBwPpIJzlOIet0ISy8BCZemIPE2AuSBsIJ8/zLpNBLE1BGzjcJHwDhu8IRkU
         twirBlEgKRY1pv2GyWrc8t/XXQy/iISQfxUlDAORyOEz3SeQnZwFtDDW/krCGosJszro
         lYLBIMyMw3DMef13c98zFCmHqvGsywB59PoFdBLIhkzXX5UsWEmxhZ1/4P1rN3asQhV/
         TtedEKp7YsUuFNf9HikQPbq0ud3k6EaKExHPX5r3mf/NgIiNTNfpy4PYhVGaeJkyTNFv
         6BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:subject:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=4pNFbnuCukRyRqU/r38L8QcIUlZrV2YMUjy0m/Ty0Qg=;
        b=cdcdkCd6n0mglzTONQWvr99vjVNh9GZY2sVrZyj7iQ2uzjfsMm2k+2AT8KKuWbOUkk
         Ts7cElX+RTs7HRPTv8HHjO6VUZUX/y7bd4nYGzc7rkX++htkTqEM7e7g2rXSi481hFpI
         G24fZ72+DxUyfEurZVSZ7qXej3LWr6c/PaEcSXOPecVqTDR3uFSykkwUyKCaAl/HeRYE
         H1tr62AlcP+yPl/9r3OKYAgcikN5FiwuHljlPbL6ZwlhORdr60awYC8bFNcXoDJGH/jX
         cbsWhx4MFXzr0kYVBBYHpW8ekYuFuO4f1vCn2I0ILOtuAhpY9yC9Gq7jqtMRMHrENCeZ
         +9OQ==
X-Gm-Message-State: AOAM530AnSSYRl8wYP2JR+vCs/el9Jr5wQ85rFmcK5yNLnnKK6PWBuwu
        rEZ9ew8R/FS4eTBm+qszXzU=
X-Google-Smtp-Source: ABdhPJxl/T9zrUbY8pcm/rV22JlNWTTLhh+A+CWyMtT5zeReMhgcXVgPCqaZgHX3Qqgvi4UKOmFRDA==
X-Received: by 2002:a05:6402:651:: with SMTP id u17mr4282406edx.206.1603833768532;
        Tue, 27 Oct 2020 14:22:48 -0700 (PDT)
Received: from [192.168.84.205] ([46.59.133.241])
        by smtp.gmail.com with UTF8SMTPSA id v12sm1630219ejg.11.2020.10.27.14.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 14:22:47 -0700 (PDT)
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
 <874kmfwhdb.fsf@toke.dk>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Autocrypt: addr=vtolkm@gmail.com; keydata=
 xsFNBFnci1cBEADV+6MUQB11XNt9PDm/dG33t5n6G5UhCjvkAYwgqwzemL1hE/z4/OfidLLY
 8ZgiJy6/Vsxwi6B9BM54RRCLqniD+GKc6vZVzx9mr4M1rYmGmTobXyDVR1cXDJC5khUx9pC+
 +oUDPbCsi8uXqKHCuqNNB7Xx6SrWJkVcY8hMnGg6QvOK7ZDY5JOCWw9UEcdQuUFx9y/ar2xr
 eikE4r3+XZUZxqKVkvJS6IvgiOnDtic0gq2u23vlXPXkkrijmVJi7igA4qVRV4aT8vzqyAM0
 c2NaQk4UcLkaf+Wc5oCz0Xv1ao3VTXqU0eYH5xvAAfYqmfIeqRvakOfIzpuNpWEQKhjn6cQt
 NtMN4SVGs5Uu09OVqTVuvP7CeZNt3QQ13OJLZ/y4mpikQTFXjlQSkw51tH3VqJE+GJ3lE/Z1
 Slb/kbc40ZghriZqH8MDLMPujuMuI0ki+3KPpnd6gAiMVcm/ZR9Zay14F6pHP3AfUYxt+wQH
 bDemPmxPijTrCwK0HmADOg+n5jzLdCXOnZlZgr5EHIzAox8qpybBH6XLwGOfRb1YszH8aeCi
 E3KOnvSzFJt4tW3bRUAXIsfU9Hau0y2Zd29hs5KT6p3W6Evo41L9YZ2Kh49nEH30LZWU3ef0
 gJTsk5JADz1qcc2D3w+I2rNvzN7NbT7OLCGBH5BjXmRFLvmR9wARAQABzRB2dG9sa21AZ21h
 aWwuY29twsGUBBMBCAA+FiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAlnci1cCGwMFCQYRI9kF
 CwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQcpz/R6QWWYuWoQ//RqAvkxS8SCYeCS9V2ozB
 BzGl+n4Duk8R/JH9MF31MBSqz6wT1fWSu4sKUIgyvOlHnJMQHFC5zWfBl3czTcXiKC02SCqw
 0TyekCrWsCGbNDtAXQ0pVwIrAAjHSHlt1szaZVmA8fW/WAAK/cx4GyMHa7J9Ll2S7fAiIjGC
 BsWskO9PMaWCmxZ/1CXucMr9q+7CZaDHyIFx4zuzYY06in8H7k+iAaCAuppOlI7/KZ2bgEUB
 71EgkJog0MGJyTfnztso1E7DHwg/E8TryAr8GPdNDx6L+wcyrAH/30dDpWoUmAURwsCj8o5f
 u2/b+7bpNt9D0ZipO+swhfBGs16OI0eydgU7tvFlge9fPeJQ618R7h4jLAyA4g8XSwqsDG5p
 JV4Pp+F6RgJu21U/6C3IdOJLY3ZLXJ1vNsC9Ymj46TuozAqsgJ9c1QMkASCNYqa35ag/to8v
 BfAcOH5CgpsDaISs+fXPtjZfIE+q7aapvNNrY2cg3d1DzwgiVRPCa3owCGO29biJVIJ/WoVC
 kLTJbzY0W2T0gB3dGzeL8Wr4GYOaqH9qWq0SvYXLosRoTrAi2heC5sUghTfUnc2mF4iVmyJN
 pmjxov/fnAlOcjOrBs2g7LTD9F9eVldb54F49s0RqTPyc6qpygYBHYHql3afpfZgHhHEU62S
 Q8hrqqc/mrySjlDOwU0EWdyLVwEQAL1H9kXHD02X8DPokRtFyToTdbJshYMsKnpILTQ3UJgU
 XreTDBUYTvBGoPEhlQVlFNvND6cy08IcdDi0VHl/aLm/oRVJa/AlAXPAad4HnEB0RckuKfoS
 Qoq0UDRmM+DLijguoEwSUfwfuk9XGs1arnaLNV+kJvj1O/cvwRDfPiFwYBFfNOO0iDWdVSOC
 GWirNLUBdpx4hWX0nXqHu0wql8bGInqNPp4Cc36VtCEid6aORhfzkplfmQUchHNblpYOFqdq
 NX2qQhfrN/nNY5fNhEyu6MSeSdahWYEC0RH17bTX+gmwJ61AwvgS1tsRL4ekzRtquDC4FUGL
 Drl2EM9FuqW/3Pr0Z8o2afjekLPFG/sEsuDdloBYQG/6bPKbNMnd19db09OzO+GgsiX/A7he
 0WAKz3fA1WSSY7FH4275islD9v+tLRRSspe4MRmV48tyysmHrzFXRZhrGT+M+qCX5a7KyOKV
 5o7odBTclI2nbm49a9gaskPQb2na37Wh+9/9+fWdn8MnS1cPbtjQuFGeOnFGoZ2FJ1kZFSW3
 ZNH/zsUX1LMkI/fA109zy3rOzStZEXgNahfIP/uSqP6N4/RbQY4WmtbURQEXe+CYNfI0Q5dw
 y9q/95+wzdwSLJMSksJERKVTRE1cvld03oIJEbSvZA50g1m1jqQJNjG3zHs4aoaxABEBAAHC
 wXwEGAEIACYWIQRkDmlU1vU1SI7dyAlynP9HpBZZiwUCWdyLVwIbDAUJBhEj2QAKCRBynP9H
 pBZZi2O1EACpzIUzidoN+jFBPKwD+TD1oWBjwXb2XtJw/ztBx/XHn7diGw8wh0wSpKr8/KtT
 2boSBLL4CyxWA2h+XO+TYuzyaGzB9gqPB6ghIByXpzdNS/bahaO9Edw13HWvy7Kn1E/uugrE
 veFNscx7yVtKXA90E7RYGRnrXuVnZJwjCkS8719+QMEJST6ZUK+Fw5rAIYZxpZk1ZUrDN5VB
 tRWSSUv/cwkmyVenX+Ix+hDGnPseFtEwuLu/hxtE/Mp2A5M/d/hPININEDVxXjRyPYf1/zLc
 C+l72dwIyZER2zvRBiwPJhWZi56WfmnoTIVfUeyDfY1IW6OlUbur/r0gpW4sAKNd2/705wtG
 d8n/W6jT3nFfsfk8Tw83FpJYjmQCft3r5yQiMcC8jBPXh3QUXKcAGafT8BH5S8tBRyt9ihSO
 xoCU+/2LUwNVMn8Po/lN5RmXDvbuIeP3EQTMRjTZDOujXzCE64PJCr9Gn6DasIEtjCLSWVIy
 7Hf0bmxHySkhZyl2u+2uA8kUMQzrZS/dEF5d7EeG69eKRFhs7e1jEgfOoX48q5D9Wwk3kiIe
 3rAN04w4cIPBfY9W9tsF8DoP0I3G2hp41r5FYktkVwyktIzrktnJprnpw6pOtFdsFe8hboqT
 itA8WCmUohYz6g5W+3igWYa5LWJ8nxCJbQIZaeAoTkFyGw==
Message-ID: <03d03828-fec2-5062-5c0b-ffc1df719911@gmail.com>
Date:   Tue, 27 Oct 2020 21:22:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <874kmfwhdb.fsf@toke.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FEB0fGojCgbAaURkG534d1exOkdB6E8eY"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FEB0fGojCgbAaURkG534d1exOkdB6E8eY
Content-Type: multipart/mixed; boundary="jHwp9XdeALhkQWGivbCIFuRr42k1mYKpz";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>
Message-ID: <03d03828-fec2-5062-5c0b-ffc1df719911@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com> <87d013wl52.fsf@toke.dk>
 <874kmfwhdb.fsf@toke.dk>
In-Reply-To: <874kmfwhdb.fsf@toke.dk>

--jHwp9XdeALhkQWGivbCIFuRr42k1mYKpz
Content-Type: multipart/mixed;
 boundary="------------B81F2B84DF522EE0AEF3509F"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------B81F2B84DF522EE0AEF3509F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 27/10/2020 21:20, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>>> Note: related issues - workaround compile ath and cfg80211 as modules=

>>>
>>> (1) https://bugzilla.kernel.org/show_bug.cgi?id=3D209863
>>> (2) https://bugzilla.kernel.org/show_bug.cgi?id=3D209855
>>> (3) https://bugzilla.kernel.org/show_bug.cgi?id=3D209853
>> Yeah, I had noticed the regdb failure but put off debugging that until=

>> the PCI issue was resolved. So guess that's next on my list - thanks f=
or
>> the pointer (although I'd rather avoid the module approach as booting
>> the kernel directly from my build box over tftp is quite convenient...=

>> Let's see if there isn't another way to fix this)
> To follow up on this, everything seems to work just fine (ath10k init a=
t
> boot + regulatory db load) if I simply set:
>
> CONFIG_EXTRA_FIRMWARE=3D"ath10k/QCA988X/hw2.0/board.bin ath10k/QCA988X/=
hw2.0/firmware-5.bin regulatory.db regulatory.db.p7s"
>
> -Toke
>

That works on my node only for the regulatory files but not the ath10=20
firmware with kconfig:

 =C2=A0Symbol: EXTRA_FIRMWARE_DIR [=3D/srv/fw]
 =C2=A0Type=C2=A0 : string
 =C2=A0Defined at drivers/base/firmware_loader/Kconfig:63
 =C2=A0=C2=A0 Prompt: Firmware blobs root directory
 =C2=A0=C2=A0 Depends on: FW_LOADER [=3Dy] && EXTRA_FIRMWARE [=3Dregulato=
ry.db=20
regulatory.db.p7s board.bin firmware-5.bin]!=3D
 =C2=A0=C2=A0 Location:
 =C2=A0=C2=A0=C2=A0 -> Device Drivers
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Generic Driver Options
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware loader
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware loadi=
ng facility (FW_LOADER [=3Dy])
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Bu=
ild named firmware blobs into the kernel binary=20
(EXTRA_FIRMWARE [=3Dregulatory.db regulatory.db.p7s board.bin=20
firmware-5.bin])

But that is off thread topic anyway and bug lodged=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D209855


--------------B81F2B84DF522EE0AEF3509F
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

--------------B81F2B84DF522EE0AEF3509F--

--jHwp9XdeALhkQWGivbCIFuRr42k1mYKpz--

--FEB0fGojCgbAaURkG534d1exOkdB6E8eY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+Yj6AFAwAAAAAACgkQcpz/R6QWWYsv
Lg//dfc2jbFyugXzlJ/76qEtDlcK9bKuQ/JaAX8qiZ+JsBt/fX5YdLINqSeudBEVRHqhof6RQ04R
pqfPsZ7+rSzIm9ZZFlTXCzW+aKNmp1uQcMkEFWM8iMj+D0c89oWwBFjwLf82/qVMTFvyT6RDhoU5
2MSPLciBz+w4DCJTtxGeHWR/C/N4Xc+5Zl9u22PiO4rixVz8hDiRBSA10lwjw/1C++YsAOOmH9Jx
NGcWeRE+UCFJvAow2tl8Li8+fmHzDTHfNGbXcV8EAGVA1DVNeIuUiNaG1AaMBEn56V1ORfiDbnw4
ZIwRD4yoALvDObyMY0FqNwyNOLP2002WQUVJHAASribHI2H5cCdE9Oy59GSPndUEu+V0BrF1DfXA
pZEYmp2j+M9FlMNuIS7bbwewI6kd2M4BEtkuLMZe2y4QLrk0n9pqVCrXYq5OsCodOkE8htmRrmtV
ahbGZfv2EO0I3aIzaap/4hJERvh9BHII/VeCJiF3a0thHDWrS5FlkmB/EXXtZqVAx6gb0NJhLUF7
t4G6Zybd5vGGt0uWprc3MoXBaji0ywR8LVDQ5dDzQ3JmCu6AuahY3P0vTcuAWRZY2rph3VexA94B
/oP22Ccsdel+r2GlJ3lSytZA4lK92WVPeHvHTpv5Z2DvlExE8EuMhkCoZuSofi6dqIcHuegO7hhu
Fs8=
=Y0WI
-----END PGP SIGNATURE-----

--FEB0fGojCgbAaURkG534d1exOkdB6E8eY--
