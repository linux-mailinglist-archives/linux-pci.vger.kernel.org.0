Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48929F5AD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgJ2T5W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ2T4H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 15:56:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3782C0613D2
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 12:56:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h24so5465507ejg.9
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:subject:to:cc:references:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=s8xOJqGr48g5V5hjcChazKhTw26K4dpTLATZ7ozeGVE=;
        b=X2jgqnEV+56jhdiCH7YuPVKGCgOMW/IaPb4kYeZXK3nQAB1l7e/IbUrkLFdlE2WpJL
         paSFQ/iB+/p/u1vfShIM1cF6T8xec06ZKYD8a5H1WZ7aOW50jZAOtDt7XJ21zIvTF3TF
         kkIX015MdAV+jztmMZij28uwvkwy4gayqhBjUdoUigCmMVVpeg7fcdJqfYhbUNzDMyys
         fRiyzCAvZxB/kGQZNk2XgBOm6WIbK741dMgrbA7bYVHO9r66xzndFmU/D1npuWyG0yfJ
         +Ny0/e4kj9vkiCX+emhLCc0T0pQaRD3+BSSCG0qIIS6AS3txjeJB5aJWwHMB0McC3Vzp
         JX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:subject:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=s8xOJqGr48g5V5hjcChazKhTw26K4dpTLATZ7ozeGVE=;
        b=JfpCCo2iC+UDSG47cto8A7zsdyhMmdV9wQilv8wb7nQNfCYHPwC6GRl1QiyhtPsf6+
         WwoLvsWIqTm3BY7pf2JTwhXPG2EJ5MourfRCfdbi7lfSuoJqRl2XY+29JDyOTzYbJd74
         hD5Uwjh1gQtlaR3iIdnBgXjIj151jWGZwPpUzQibVht56CT24U8KlGGg+JEHSXzNtbja
         TdIcZNwlF0YGLgL/vcW/MpzSutiaFuRtR4BpVFSsRKX6fTtenEav0ZYPkHtBrCysgtDa
         FB5qS4tDa6itO0GFIPz4y32o2xaMCBNolklsF86D6/RweoMsxH+//m10N3mjZ1gYWZh8
         Cauw==
X-Gm-Message-State: AOAM533Pt7RMAxJJ2KaZ9dNVV8R71Lggk0MEjk3s6GdJaBfqsmS8o+bM
        s3/Fm8qe2/93Ja9rYh6vOyk=
X-Google-Smtp-Source: ABdhPJyX7Hkgx6bstwmUNwJOonSe6miagfW2c4lX3WJn3xSY9C+CaenUUARVYb4MjDKRyoZbLfXfTg==
X-Received: by 2002:a17:906:a40b:: with SMTP id l11mr5563864ejz.25.1604001364210;
        Thu, 29 Oct 2020 12:56:04 -0700 (PDT)
Received: from [192.168.84.205] ([95.81.30.231])
        by smtp.gmail.com with UTF8SMTPSA id h8sm2049643eds.51.2020.10.29.12.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 12:56:03 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
Subject: Re: PCI trouble on mvebu (Turris Omnia)
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
References: <20201029193022.GA476048@bjorn-Precision-5520>
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Message-ID: <d674bfec-5045-d2f2-b4cc-e17a04b5e529@gmail.com>
Date:   Thu, 29 Oct 2020 19:56:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201029193022.GA476048@bjorn-Precision-5520>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ywcb1BvY11NCk5ObuvWscBgycEF9Fuesd"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ywcb1BvY11NCk5ObuvWscBgycEF9Fuesd
Content-Type: multipart/mixed; boundary="nwJNwN6If9bPQu1XhoJpsJ1XJiMyYeQK0";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>
Message-ID: <d674bfec-5045-d2f2-b4cc-e17a04b5e529@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <20201029193022.GA476048@bjorn-Precision-5520>
In-Reply-To: <20201029193022.GA476048@bjorn-Precision-5520>

--nwJNwN6If9bPQu1XhoJpsJ1XJiMyYeQK0
Content-Type: multipart/mixed;
 boundary="------------13EC78665517B0D3BD68C53A"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------13EC78665517B0D3BD68C53A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 29/10/2020 20:30, Bjorn Helgaas wrote:
> On Thu, Oct 29, 2020 at 12:12:21PM +0100, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>> I have been testing mainline kernel on Turris Omnia with two PCIe
>>> default cards (WLE200 and WLE900) and it worked fine. But I do not kn=
ow
>>> if I had ASPM enabled or not.
>>>
>>> So it is working fine for you when CONFIG_PCIEASPM is disabled and wh=
ole
>>> issue is only when CONFIG_PCIEASPM is enabled?
>> Yup, exactly. And I'm also currently testing with the default WLE200/9=
00
>> cards... I just tried sticking an MT76-based WiFi card into the third
>> PCI slot, and that doesn't come up either when I enable PCIEASPM.
> Huh.  So IIUC, the following cases all try to retrain the link and it
> fails to come up again:
>
>    - aardvark + WLE900VX (see commit 43fc679ced18)
>    - mvebu + WLE200
>    - mvebu + WLE900
>    - mvebu + MT76
>
> In all these cases, Linux was able to enumerate the NIC, which means
> the link was up when firmware handed it off.
>
> I think Linux decided the Common Clock Configuration was wrong, so it
> tried to fix it and retrain the link, and the link didn't come back
> up.
>
> I don't have "lspci -vv" output from all of them, but in vtolkm's
> case, the firmware handed off with:
>
>    00:02.0 Root Port to [bus 02]  SlotClk+ CommClk+
>    02:00.0 QCA986x/988x NIC       SlotClk+ CommClk-
>
> Per spec (PCIe r5, sec 7.5.3.7), SlotClk is HwInit and CommClk is RW
> and should power up as 0.  If I'm reading the implementation note
> correctly, if SlotClk is set on both ends of the link, software should
> set CommClk, so the config above *does* look wrong, and CommClk+ on
> the Root Port suggests that firmware set it.
>
> I think both the aardvark and mvebu systems probably use U-Boot.  I
> don't know U-Boot at all, but I don't see anything in it that touches
> Link Control.  I'm curious what happens if you put one of these cards
> in a PC.  If anybody tries it, please collect the "sudo lspci -vv" and
> dmesg output.
>
> We could quirk these NICs to avoid the retrain, but since aardvark and
> mvebu have no obvious connection and WLE200/WLE900 and MT76 have no
> obvious connection, I doubt there's a simple hardware defect that
> explains all these.
>
> Maybe we're doing something wrong in the retrain, but obviously the
> link came up in the first place.  AFAIK the only thing we're changing
> is the CommClk setting, and that looks legitimate per spec.
>
> Another experiment: build kernel without CONFIG_PCIEASPM, set $ROOT
> and $NIC appropriately, and try the following:
>
>    # Set $ROOT and $NIC (update to match your system):
>
>      # ROOT=3D00:02.0
>      # NIC=3D02:00.0
>
>    # Dump the Root Port and NIC Link registers:
>
>      # setpci -s$ROOT CAP_EXP+0xc.l              # Link Capabilities
>      # setpci -s$ROOT CAP_EXP+0x10.w             # Link Control
>      # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status
>
>      # setpci -s$NIC  CAP_EXP+0xc.l              # Link Capabilities
>      # setpci -s$NIC  CAP_EXP+0x10.w             # Link Control
>      # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status
>
>    # Retrain the link:
>
>      # setpci -s$ROOT CAP_EXP+0x10.w=3D0x0020      # Link Control Retra=
in Link
>      # sleep 1
>      # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status
>      # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status
>
>    # Set CommClk+ and retrain the link:
>
>      # setpci -s$NIC  CAP_EXP+0x10.w=3D0x0040      # Link Control Commo=
n Clock
>      # setpci -s$ROOT CAP_EXP+0x10.w=3D0x0040      # Link Control Commo=
n Clock
>      # setpci -s$ROOT CAP_EXP+0x10.w=3D0x0060      # Link Control RL + =
CC
>      # sleep 1
>      # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status
>      # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status

ROOT=3D00:02.0
NIC=3D02:00.0
setpci -s$ROOT CAP_EXP+0xc.l
0003ac12
setpci -s$ROOT CAP_EXP+0x10.w
0040
setpci -s$ROOT CAP_EXP+0x12.w
1011
setpci -s$NIC=C2=A0 CAP_EXP+0xc.l

00036c11
setpci -s$NIC=C2=A0 CAP_EXP+0x10.w
0000
setpci -s$NIC=C2=A0 CAP_EXP+0x12.w
1011
setpci -s$ROOT CAP_EXP+0x10.w=3D0x0020
sleep 1
setpci -s$ROOT CAP_EXP+0x12.w
1011
setpci -s$NIC=C2=A0 CAP_EXP+0x12.w
setpci: 0000:02:00.0: Instance #0 of Capability 0010 not found - there=20
are no capabilities with that id.
setpci -s$NIC=C2=A0 CAP_EXP+0x10.w=3D0x0040
setpci: 0000:02:00.0: Instance #0 of Capability 0010 not found - there=20
are no capabilities with that id.
setpci -s$ROOT CAP_EXP+0x10.w=3D0x0040
setpci -s$ROOT CAP_EXP+0x10.w=3D0x0060
sleep 1
setpci -s$ROOT CAP_EXP+0x12.w
1811
setpci -s$NIC=C2=A0 CAP_EXP+0x12.w
setpci: 0000:02:00.0: Instance #0 of Capability 0010 not found - there=20
are no capabilities with that id.


--------------13EC78665517B0D3BD68C53A
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

--------------13EC78665517B0D3BD68C53A--

--nwJNwN6If9bPQu1XhoJpsJ1XJiMyYeQK0--

--Ywcb1BvY11NCk5ObuvWscBgycEF9Fuesd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+bHlIFAwAAAAAACgkQcpz/R6QWWYuW
PA/9EsU8Vv2Ad2FgTmSQf1RwXhdniVuef/To9SvlA2UQWz+Cd4ALkzzcWJvlePEJy0yoEybRjYqI
NofdGmPAf+4y8P/STYbN0yjG5KKUklfTF7UwNiiYTxD1w1wljyPpTqdtllgVepbqnmzjZWhSBVAq
gj+rZQPD3toumvcX++PxNGisR6R5YeOGyJ8F8Nslt4tBFL9iU9MqyGY8bhseWdaVpF6YlNu36KXZ
h/xhmRmLQUa2jBNtZxfn51SbgkeeSkwuBg807Z4m+CnGwBByY5jgf4l1AUcni/pU89hn874w5c14
rdTbvhs3cNVqNsHQ6ru+wa7Wq+WjyJgHMVwEjMATitwtfandYtxaa3MG2x+jgX/usekAbaOiD+3X
Cp68i4pi5rJlNFdxmxp2H7dTnk4ziW+zROmqqvXQMc0InPOZ3E2/JuezJy5e+spYDTcaqeHbpfa4
/wE4QvsBK7n2BVfds0iljTNwTDNvcIiA0gRl0B6U0YbiZ1LcA4Z1tjwKcY9IdHFi7E+0q9PkHH7U
vR65zlCbBZHOlNjLpjyE0JwEv5uRaCdtjYtCbNfxr4eTMjZxK7S19YjZzobbo3dbRUTQZ6P7CBL6
4memYDH1ZaQtYfkL7VqCAJqY7PWvasRp4ff/KjH3SbyMlIzBhAuh4J6Nxgwj82GISvSdaloBVjNo
Gr4=
=9cdf
-----END PGP SIGNATURE-----

--Ywcb1BvY11NCk5ObuvWscBgycEF9Fuesd--
