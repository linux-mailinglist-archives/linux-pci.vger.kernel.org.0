Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB429C344
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 18:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821501AbgJ0Ro0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 13:44:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44226 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1821499AbgJ0RoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 13:44:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id t9so2852566wrq.11
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=N4/4QWHJ17c/eLKbNNd+sV17OqodWddmgVuOgfFTV7c=;
        b=fq4IOaftzd9lFu3raf7jd0NrcnHZqclA/NxBBnK1hSVodYds5sjR5j6ubVxpg8YU6G
         yP3NAk2v2s788q3f6Fa2Nr3TmMjxo25oyqDMIKm3c++TtqhnaDWgBoIX4SIg2GZFv1e4
         xw1zUb3DPVdSpUoup99q122ao4MECTREQDjRakaCCgvXUKB8GDwRwpz/lHi3BWeMCWbC
         fsB+tBDZQ8W2X5mGEVOWt4SBwvNGCpZLnDDHBIb6EPrQobxg7doKgcCeclDBvOX9vpYU
         fwKTwKNSymc7SNivp8hDbQpPi4maEbY/XXfLv4l+PfIwO647PhWx+/bfJaYOzrz4ieMd
         jwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=N4/4QWHJ17c/eLKbNNd+sV17OqodWddmgVuOgfFTV7c=;
        b=TXh5zT2FT0BhEnHvABa/hA5o5uzgb1VUyEoxCoWRm8aLVCG7DiP8kElF0IAmcw6HGs
         GybdlTomH4Lb3YIvL5lVnvXKCwCmQuscrwK08VQ1TF/h+CIdNov8Kqn0sog6oobIJobZ
         1vVdnVY3NBU9+aCplxVMp866zab8h+mMTrz6ZsqHQ/Iq6U2n7pzBNNWCjfofmuE3tUPc
         608GSwPD2ZAsTE9XN9C+EktdNiMLz6tUsTZ2f51cWUXW0NG9sTI55Q8j0n9wuike56vD
         rLDXjKdGwXQUk4iX/qKGeep6GgPsY5H3XTfCBtk4hOitIv5GrU53EnI0fZ8aw94DbWbb
         bUGA==
X-Gm-Message-State: AOAM531EZMuW6StVEh0k8b5jO80SQv/pTFdjRXpSDYXUew0Ig2GKB6hy
        pb4WCYksSXe2FiIUhY1g6S8=
X-Google-Smtp-Source: ABdhPJzdcxwLYEc1zLYRe45laSQiY1FbSab2aPTl2Wz+q0gHPksqb9KY5Ai/Kmdaw87jXFrGrn3tPQ==
X-Received: by 2002:a5d:4dc1:: with SMTP id f1mr4160290wru.42.1603820660093;
        Tue, 27 Oct 2020 10:44:20 -0700 (PDT)
Received: from [192.168.84.205] ([149.224.10.132])
        by smtp.gmail.com with UTF8SMTPSA id u9sm3038269wrp.65.2020.10.27.10.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 10:44:19 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com, Bjorn Helgaas <helgaas@kernel.org>
References: <20201027172006.GA186901@bjorn-Precision-5520>
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com>
Date:   Tue, 27 Oct 2020 17:44:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201027172006.GA186901@bjorn-Precision-5520>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hBNpttNKizAZJpLF3ACyw7dQPLCJ55Dex"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hBNpttNKizAZJpLF3ACyw7dQPLCJ55Dex
Content-Type: multipart/mixed; boundary="1Nd7gVyxicQ04Pn19Nn4KC8A78BqwD1hQ";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, vtolkm@googlemail.com,
 Bjorn Helgaas <helgaas@kernel.org>
Message-ID: <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <20201027172006.GA186901@bjorn-Precision-5520>
In-Reply-To: <20201027172006.GA186901@bjorn-Precision-5520>

--1Nd7gVyxicQ04Pn19Nn4KC8A78BqwD1hQ
Content-Type: multipart/mixed;
 boundary="------------E86AF3C5A444A7547DA36B6A"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------E86AF3C5A444A7547DA36B6A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 27/10/2020 18:20, Bjorn Helgaas wrote:
> [+cc vtolkm]
>
> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>> Hi everyone
>>
>> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
>> having some trouble getting the PCI bus to work correctly. Specificall=
y,
>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), wit=
h
>> the resource request fix[0] applied on top.
>>
>> The kernel boots fine, and the patch in [0] makes the PCI devices show=

>> up. But I'm still getting initialisation errors like these:
>>
>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=3D=
 0xffffffff)
>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 =
!=3D 0xffffffff)
>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D=
 0xffffffff)
>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 =
!=3D 0xffffffff)
>>
>> and the WiFi drivers fail to initialise with what appears to me to be
>> errors related to the bus rather than to the drivers themselves:
>>
>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by t=
his driver
>> [    3.517049] ath: phy0: Unable to initialize hardware; initializatio=
n status: -95
>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with =
rc=3D134
>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from =
D3hot to D0 (config space inaccessible)
>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -11=
0
>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -11=
0
>>
>> lspci looks OK, though:
>>
>> # lspci
>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)=

>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)=

>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)=

>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network A=
dapter (PCI-Express) (rev 01)
>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wir=
eless Network Adapter (rev ff)
>>
>> Does anyone have any clue what could be going on here? Is this a bug, =
or
>> did I miss something in my config or other initialisation? I've tried
>> with both the stock u-boot distributed with the board, and with an
>> upstream u-boot from latest master; doesn't seem to make any different=
=2E
> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 but I
> don't think we have a fix yet.
>

Got the same device working with > 5.10.0-rc1-next-20201027-to-dirty <=20
but ASPM turned off, as mentioned in the cited bug report.


 =C2=A0dmesg | grep ath

ath10k_pci 0000:02:00.0: enabling device (0140 -> 0142)
ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mod=
e 0
ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chip_id=20
0x043202ff sub 0000:0000
ath9k 0000:03:00.0: enabling device (0140 -> 0142)
ath10k_pci 0000:02:00.0: kconfig debug 1 debugfs 0 tracing 1 dfs 0=20
testmode 0
ath10k_pci 0000:02:00.0: firmware ver 10.2.4-1.0-00047 api 5 features=20
no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
ath: EEPROM regdomain sanitized
ath: EEPROM regdomain: 0x64
ath: EEPROM indicates we should expect a direct regpair map
ath: Country alpha2 being used: 00
ath: Regpair used: 0x64
ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 bebc7c08
ath10k_pci 0000:02:00.0: htt-ver 2.1 wmi-op 5 htt-op 2 cal otp max-sta=20
128 raw 0 hwcrypto 1
ath: EEPROM regdomain sanitized
ath: EEPROM regdomain: 0x64
ath: EEPROM indicates we should expect a direct regpair map
ath: Country alpha2 being used: 00
ath: Regpair used: 0x64
ath10k_pci 0000:02:00.0: pdev param 0 not supported by firmware

----

Note: related issues - workaround compile ath and cfg80211 as modules

(1) https://bugzilla.kernel.org/show_bug.cgi?id=3D209863
(2) https://bugzilla.kernel.org/show_bug.cgi?id=3D209855
(3) https://bugzilla.kernel.org/show_bug.cgi?id=3D209853





--------------E86AF3C5A444A7547DA36B6A
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

--------------E86AF3C5A444A7547DA36B6A--

--1Nd7gVyxicQ04Pn19Nn4KC8A78BqwD1hQ--

--hBNpttNKizAZJpLF3ACyw7dQPLCJ55Dex
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+YXHEFAwAAAAAACgkQcpz/R6QWWYsw
ghAAsIwQRkvZhLqyZl07GYmJwnB4MXJMjP3/tdwvINZd5QXPPf6hcG1/vdXJXLpeh4jWR3T3aJQY
cD4UijSaBP9Bs82kji6Poa/UjHWua3sxQy/nGYLclQ8JmFg4h/dOERvhnJuqNhvAnxSR0A0NrtwR
lYnvLcWZJ4XUWkesu4sjImEedavc4wrtuCj9E4ROewjfB0601o6Ph17HopWoblVeK5GPeqhaeXFu
O2k8mMABFCu72rm6s/LoZVgWJExYdpyDUK0d0xQth47Ee1Aq0JLwCy4A3PmmQFpWCgaEuLPyB5w2
7BKriDNF3vS28qDyBHFOoQCnlP0cYsLhna1KWNUhjeeSBtu4dSwjH/DIkft2S1XduyRSLV6kbkji
FAxmzpZfIm818LzTGRx9kLevTwgme7KRSplxsNfdKVep+3c5afVYmIliswo3XZ9TmT335tLgXi9V
AhpYvMNKUI5T/rBCqdvA8tqIo88HVcm1oxBuzbnNa7OoTGZnpeAyJbGLYCuRojFeYbm19b2hN99w
7fFw8+l3B/eWh7wVWdmUYGlYNQyvybyGbySWC6Rz82kl5bdEJSSg0rDczG+uubDjT7eZm3snWDtu
wEnNOI+61QyA+VY1yR/VqVVS0N7+AGMfKZk2BlI/KwrqttgSAG5PSvOOL1BWu43esR3FjeBW9ZWJ
Me0=
=xDF1
-----END PGP SIGNATURE-----

--hBNpttNKizAZJpLF3ACyw7dQPLCJ55Dex--
