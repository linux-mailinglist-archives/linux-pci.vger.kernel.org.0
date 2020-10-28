Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0802D29D603
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgJ1WKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbgJ1WKd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 18:10:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518DC0613CF
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 15:10:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so702191wma.4
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=DiI7C97C1LvuL6Kea/aw/ayi/00MOXHJM94ikpzSCCY=;
        b=XnhKFOJBU0K6bXr8KXhR6OAvafivTILMGWjwwRmstav8mMYNKbVVQ42se0N0TbNiQt
         W1dCHdzVJwZC6kyYtn0kiaOKkGWK5V1qUDO/pA5DXjnqBRhge12a+LwFru5bdo6+3jKK
         7kdtQfjDEmXcJ9cUjZu5L7uH5NxvzWh106BYDz7GkMWCZtBYIZzUsCMj1L5bT1UpWf+W
         8y/KCI1cS7OyVkhqzPxIniS8580tiXXx1RB62roXGjAVgEUj8lddJ9GTeNPRJ6AxkXvu
         h+Zn/lwm6g2R7EjUkEJSRl0duhgDMegchVsz0qrETTX8nhe1cnhr08eQlfAieDQUqFU7
         rX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=DiI7C97C1LvuL6Kea/aw/ayi/00MOXHJM94ikpzSCCY=;
        b=JCTpOrYN+RvG2WF2aU8TEKqVmFvI4M21lv5o+yySlla6M+bw0JC0pWkAHopWkz8z89
         zsAdNX6BCd6mAxm6FKjK1P7ULcbSCpjuzeEMXxbx16tU/Ygm0/KNLaM8SLKH5BbCMTq0
         7Mf7VPpQAOv91w2WJ3qxv5av9czdoTO0ornWmL1QKMEjHLv5dTpKV6URVtqXGsGpuBYN
         SruQRZazB9lagDGoCnzb79LpF8epeGuvyGnxkkYCY3uOB1o3nHdEkBlsFnnu0QhUCwyo
         Mxk/6S1wp2KyzJRknAuThLGAZbmIYOhvH72tT9Lnt7QjYvrXT1pJnvHRGHMeSQiC7Qvp
         bFXQ==
X-Gm-Message-State: AOAM530tLnDaYEZaDcw84cfz9Ju8Cxbe3t+fHFOa219LUFmBkjy8kw3k
        Ra6meNsi5FjOjeplhxtRCoaHJLhtmrE=
X-Google-Smtp-Source: ABdhPJwwp0bFQpk5SRH8bQDtLpHPQ+HY3lqckA663FTvCT4QViaWg3IDBoeCIwmlhZaBllQSkCxtrQ==
X-Received: by 2002:a1c:740f:: with SMTP id p15mr309828wmc.106.1603903208014;
        Wed, 28 Oct 2020 09:40:08 -0700 (PDT)
Received: from [192.168.84.205] ([31.29.39.146])
        by smtp.gmail.com with UTF8SMTPSA id l26sm162469wmi.39.2020.10.28.09.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 09:40:07 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20201028144209.GA315566@bjorn-Precision-5520>
 <87pn52mlqk.fsf@toke.dk>
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
Date:   Wed, 28 Oct 2020 16:40:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <87pn52mlqk.fsf@toke.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KiMhHxuB6QNOnZMG2ZB2joO4S8XMXD2s1"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KiMhHxuB6QNOnZMG2ZB2joO4S8XMXD2s1
Content-Type: multipart/mixed; boundary="rjkbFg5SI7HofNopwrXO2OG3tOi0lb2De";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Message-ID: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <20201028144209.GA315566@bjorn-Precision-5520>
 <87pn52mlqk.fsf@toke.dk>
In-Reply-To: <87pn52mlqk.fsf@toke.dk>

--rjkbFg5SI7HofNopwrXO2OG3tOi0lb2De
Content-Type: multipart/mixed;
 boundary="------------54D4D40C4929633C5E0324D6"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------54D4D40C4929633C5E0324D6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 28/10/2020 16:08, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>
>>>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>>>
>>>>> [+cc vtolkm]
>>>>>
>>>>> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>>>>>> Hi everyone
>>>>>>
>>>>>> I'm trying to get a mainline kernel to run on my Turris Omnia, and=
 am
>>>>>> having some trouble getting the PCI bus to work correctly. Specifi=
cally,
>>>>>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment),=
 with
>>>>>> the resource request fix[0] applied on top.
>>>>>>
>>>>>> The kernel boots fine, and the patch in [0] makes the PCI devices =
show
>>>>>> up. But I'm still getting initialisation errors like these:
>>>>>>
>>>>>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004=
 !=3D 0xffffffff)
>>>>>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000=
000 !=3D 0xffffffff)
>>>>>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004=
 !=3D 0xffffffff)
>>>>>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000=
000 !=3D 0xffffffff)
>>>>>>
>>>>>> and the WiFi drivers fail to initialise with what appears to me to=
 be
>>>>>> errors related to the bus rather than to the drivers themselves:
>>>>>>
>>>>>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported =
by this driver
>>>>>> [    3.517049] ath: phy0: Unable to initialize hardware; initializ=
ation status: -95
>>>>>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
>>>>>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
>>>>>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed w=
ith rc=3D134
>>>>>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
>>>>>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state f=
rom D3hot to D0 (config space inaccessible)
>>>>>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device :=
 -110
>>>>>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error=
 -110
>>>>>>
>>>>>> lspci looks OK, though:
>>>>>>
>>>>>> # lspci
>>>>>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev=
 04)
>>>>>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev=
 04)
>>>>>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev=
 04)
>>>>>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Netwo=
rk Adapter (PCI-Express) (rev 01)
>>>>>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac=
 Wireless Network Adapter (rev ff)
>>>>>>
>>>>>> Does anyone have any clue what could be going on here? Is this a b=
ug, or
>>>>>> did I miss something in my config or other initialisation? I've tr=
ied
>>>>>> with both the stock u-boot distributed with the board, and with an=

>>>>>> upstream u-boot from latest master; doesn't seem to make any diffe=
rent.
>>>>> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
>>>>> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 but =
I
>>>>> don't think we have a fix yet.
>>>> Yes! Turning that off does indeed help! Thanks a bunch :)
>>>>
>>>> You mention that bisecting this would be helpful - I can try that
>>>> tomorrow; any idea when this was last working?
>>> OK, so I tried to bisect this, but, erm, I couldn't find a working
>>> revision to start from? I went all the way back to 4.10 (which is the=

>>> first version to include the device tree file for the Omnia), and eve=
n
>>> on that, the wireless cards were failing to initialise with ASPM
>>> enabled...
>> I have no personal experience with this device; all I know is that the=

>> bugzilla suggests that it worked in v5.4, which isn't much help.
>>
>> Possibly the apparent regression was really a .config change, i.e.,
>> CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and it
>> "worked" but got enabled later and it started failing?
> Yeah, I suspect so. The OpenWrt config disables CONFIG_PCIEASPM by
> default and only turns it on for specific targets. So I guess that it's=

> most likely that this has never worked...
>
>> Maybe the debug patch below would be worth trying to see if it makes
>> any difference?  If it *does* help, try omitting the first hunk to see=

>> if we just need to apply the quirk_enable_clear_retrain_link() quirk.
> Tried, doesn't help...
>
> -Toke
>

Found this patch

https://github.com/openwrt/openwrt/blob/7c0496f29bed87326f1bf591ca25ace82=
373cfc7/target/linux/mvebu/patches-5.4/405-PCI-aardvark-Improve-link-trai=
ning.patch=20


that mentions the Compex WLE900VX card, which reading the lspci verbose=20
output from the bugtracker seems to the device being troubled.





--------------54D4D40C4929633C5E0324D6
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

--------------54D4D40C4929633C5E0324D6--

--rjkbFg5SI7HofNopwrXO2OG3tOi0lb2De--

--KiMhHxuB6QNOnZMG2ZB2joO4S8XMXD2s1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+ZnuUFAwAAAAAACgkQcpz/R6QWWYtP
kg/+Mq/SH3xCS32h132hIOoJSLxUtbjWwJdVyIFyJmHwY5H2koAbcsohYsL0yyH/EMTdiY7LX4OE
lT6ZtxCrA8R4ZuGgv9hTUqIhI7BuBVhIp/XLj5TrPaDKBtfmJnTUGZExoZtzQWmZXBytt3g7MTn8
THvhlQ5ZCc1PVRHn4sznXbGe191kHX4mz+Bi1ma/JKCnhlRxbcDZmntgatEyWmgAkmDDzxg5zsP8
AqdjZSeImrX2aXn86eCckq9GO6Ohtp9wghXpCdlcdkmzFaIe0tFNe1CWMBhMbLLtnQNpk1aPFkoJ
wbLDNwXFei54YqlXhEsgMzm/bBcN+KsEy3ABou+VQG5sHYZrdgh9W/5wKbhgveuYnCFmZ7Ii1ajG
NvMxVDviWg7880GtH0kp6zyIgc+C+yp9JZkRqZoxOYZVfs/MSTdRgmtpXOJDjGJCDUbXNXVntZBm
8f0EJ5COX4xKEJvBS/JHzH3np9gZfNT373UYoB7pVuxfmNyDfcjp/M3g1dOmvFKACn9SDBn5CCvE
QgehPYa/gMcap0A2675Qs5z+RVPCM+RJeBHRbq2W5v2lI9tDe2lVusUSFpcxmLAZ5mqRH4D0hIRT
CIZbfTP8otWpIWGBow1JYEdKSxAGxHLSAgT2wg9yEh1WjdczGjENKbkCrpktnE/uYBX8KHoYs8L4
Qoc=
=U7wX
-----END PGP SIGNATURE-----

--KiMhHxuB6QNOnZMG2ZB2joO4S8XMXD2s1--
