Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D069F296BF3
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461301AbgJWJTO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461300AbgJWJTO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 05:19:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294FC0613CE
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 02:19:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so1011984wrq.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=nHcm2uiydIaS49UMaS3Bptnmmxm7X/9RNqugR3aoK5k=;
        b=sYP6MXzM3IWpnipO9RjgTc61Zn83rPGtlNawnn+W1hhAViMYK3hb+eA6EFxH72rkS9
         5XzGmwS2qsgfTv3Th5GniRma8Lv1EdYBYPpfVzjnmGVy5KGIdr1Vp0llOMItzePO3Ypu
         3ilgt5v8mYGVsIDl7vyV0knQxiS/8rPL6EWJK71qkbaNjJuqG5eLO1VWqX81DhdSclXQ
         r+pWCMmkxDBDioJc3R9qbyPrDf1goFmPw/2SRHbDVNyozlm3ClGIF2k69hv2/pabRrpI
         hf4PPETbHsmqswRvM8yRNyQfXHCVmS4YtCZNRuXv9HlTDjgVswDt1pumxr5e5LAagac5
         arKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=nHcm2uiydIaS49UMaS3Bptnmmxm7X/9RNqugR3aoK5k=;
        b=XcBCd8fkkmnD5eK5u/c1HSwe+mCpZ7y8uu/90OqNkRcxZ38PegrxwHaPmrS3uc4No9
         IwLs20uWEfDlSDlFM4LktJeGKY6qm+Jwu53F3mO2VIV8UTl3bzSEutLfCp7tBS6WDMNQ
         JHqaHxNKhq9KPf5o/BqZhfuIPY3YM5koO5w63+y6fXNQN+0mJcLwx0777Lk4+Gp8zcfb
         DSfhP0aTsGcG+pRHHgv6basFq6szo2TOQR8rps90d3K/KX9PdGWLs71WugozqVtOeHJr
         7iobqW1Efz6rWMxeNNO40EaYMuoiQpLmWASxe5yKDyfk2RY1SsGHXEGgWVkVaZdqNkWz
         +uog==
X-Gm-Message-State: AOAM530CPMEFR3Bb9/4BWYMzniyFy7VHse5AQAWm0ZoWYiX2eH4kGsLn
        7vxGhIzKAp+w2Opyx0WxUr8=
X-Google-Smtp-Source: ABdhPJyL/TO/SSIfujNr4O6Ca+BzHl20Tj9siE33dsDfYtK4b+fss1BzY4smiBZRgDIpIeNV6hoeHg==
X-Received: by 2002:adf:e444:: with SMTP id t4mr1696825wrm.58.1603444752527;
        Fri, 23 Oct 2020 02:19:12 -0700 (PDT)
Received: from [192.168.84.205] ([81.25.170.195])
        by smtp.gmail.com with UTF8SMTPSA id o5sm1940696wrw.76.2020.10.23.02.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 02:19:11 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <20201022220038.1339854-1-robh@kernel.org>
 <20201022220507.GW1551@shell.armlinux.org.uk>
 <20201022220924.GX1551@shell.armlinux.org.uk>
 <CAL_JsqKzGK6sgRZMEEXVZQGbMsEOi86W-2CcJiWtsvHhiR7O7A@mail.gmail.com>
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Subject: Re: [PATCH] PCI: mvebu: Fix duplicate resource requests
Message-ID: <44c28085-d1ed-d4a0-10fe-0d9d3c0a8e7e@gmail.com>
Date:   Fri, 23 Oct 2020 09:12:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKzGK6sgRZMEEXVZQGbMsEOi86W-2CcJiWtsvHhiR7O7A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ox4T87PiHyIicTSfeJyHiVWd17DK3jfrb"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ox4T87PiHyIicTSfeJyHiVWd17DK3jfrb
Content-Type: multipart/mixed; boundary="kZDZVzETstF0GCszOF4eIDYLOrCgv7sqo";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, PCI <linux-pci@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>
Message-ID: <44c28085-d1ed-d4a0-10fe-0d9d3c0a8e7e@gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Fix duplicate resource requests
References: <20201022220038.1339854-1-robh@kernel.org>
 <20201022220507.GW1551@shell.armlinux.org.uk>
 <20201022220924.GX1551@shell.armlinux.org.uk>
 <CAL_JsqKzGK6sgRZMEEXVZQGbMsEOi86W-2CcJiWtsvHhiR7O7A@mail.gmail.com>
In-Reply-To: <CAL_JsqKzGK6sgRZMEEXVZQGbMsEOi86W-2CcJiWtsvHhiR7O7A@mail.gmail.com>

--kZDZVzETstF0GCszOF4eIDYLOrCgv7sqo
Content-Type: multipart/mixed;
 boundary="------------015274E9C7A02C26A3693BC3"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------015274E9C7A02C26A3693BC3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 23/10/2020 02:51, Rob Herring wrote:
> On Thu, Oct 22, 2020 at 5:09 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
>> On Thu, Oct 22, 2020 at 11:05:07PM +0100, Russell King - ARM Linux adm=
in wrote:
>>>> @@ -1001,9 +995,12 @@ static int mvebu_pcie_parse_request_resources(=
struct mvebu_pcie *pcie)
>>>>              pcie->realio.name =3D "PCI I/O";
>>>>
>>>>              pci_add_resource(&bridge->windows, &pcie->realio);
>>>> +           ret =3D devm_request_resource(dev, &iomem_resource, &pci=
e->realio);
>>> I think you're trying to claim this resource against the wrong parent=
=2E
>> Fixing this to ioport_resource results in in working PCIe.
> Copy-n-paste... Thanks for testing.
>
> Rob

Run tested the patch with 5.9.1 and it seems fixing the issue, not sure=20
about the meaning of "BAR 0: error updating":


mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
mvebu-pcie soc:pcie: Parsing ranges property...
mvebu-pcie soc:pcie: MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
mvebu-pcie soc:pcie: MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
mvebu-pcie soc:pcie: MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
mvebu-pcie soc:pcie: MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000=

mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000=

mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000=

mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000=

mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus=20
address [0x00080000-0x00081fff])
pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus=20
address [0x00040000-0x00041fff])
pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus=20
address [0x00044000-0x00045fff])
pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus=20
address [0x00048000-0x00049fff])
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [io=C2=A0 0x1000-0xeffff]
pci_bus 0000:00: scanning bus
pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
pci_bus 0000:00: fixups for bus
pci 0000:00:01.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
pci 0000:00:02.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
pci 0000:00:03.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
pci 0000:00:01.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci_bus 0000:01: fixups for bus
pci_bus 0000:01: bus scan returning with max=3D01
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:02.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:02: scanning bus
pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
pci 0000:02:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit]
pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
pci 0000:02:00.0: supports D1 D2
pci 0000:00:02.0: ASPM: current common clock configuration is=20
inconsistent, reconfiguring
pci_bus 0000:02: fixups for bus
pci_bus 0000:02: bus scan returning with max=3D02
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
pci 0000:00:03.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:03: scanning bus
pci 0000:03:00.0: [168c:002e] type 00 class 0x028000
pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:03:00.0: supports D1
pci 0000:03:00.0: PME# supported from D0 D1 D3hot
pci 0000:03:00.0: PME# disabled
pci 0000:00:03.0: ASPM: current common clock configuration is=20
inconsistent, reconfiguring
pci_bus 0000:03: fixups for bus
pci_bus 0000:03: bus scan returning with max=3D03
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
pci_bus 0000:00: bus scan returning with max=3D03
pci 0000:00:02.0: BAR 8: assigned [mem 0xe0000000-0xe02fffff]
pci 0000:00:03.0: BAR 8: assigned [mem 0xe0300000-0xe03fffff]
pci 0000:00:01.0: BAR 6: assigned [mem 0xe0400000-0xe04007ff pref]
pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff pref]
pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe06007ff pref]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: BAR 0: assigned [mem 0xe0000000-0xe01fffff 64bit]
pci 0000:02:00.0: BAR 0: error updating (0xe0000004 !=3D 0xffffffff)
pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=3D 0xffffffff)
pci 0000:02:00.0: BAR 6: assigned [mem 0xe0200000-0xe020ffff pref]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:00:02.0: bridge window [mem 0xe0000000-0xe02fffff]
pci 0000:03:00.0: BAR 0: assigned [mem 0xe0300000-0xe030ffff 64bit]
pci 0000:03:00.0: BAR 0: error updating (0xe0300004 !=3D 0xffffffff)
pci 0000:03:00.0: BAR 0: error updating (high 0x000000 !=3D 0xffffffff)
pci 0000:00:03.0: PCI bridge to [bus 03]
pci 0000:00:03.0: bridge window [mem 0xe0300000-0xe03fffff]
pci 0000:00:03.0: enabling device (0140 -> 0142)
pci 0000:00:03.0: enabling bus mastering
pci 0000:00:02.0: enabling device (0140 -> 0142)
pci 0000:00:02.0: enabling bus mastering

----

Pardon the ignorance, how the further workflow of the patch from=20
patchwork, commit to next (5.10) branch and then backport to 5.9?





--------------015274E9C7A02C26A3693BC3
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

--------------015274E9C7A02C26A3693BC3--

--kZDZVzETstF0GCszOF4eIDYLOrCgv7sqo--

--Ox4T87PiHyIicTSfeJyHiVWd17DK3jfrb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+SnpgFAwAAAAAACgkQcpz/R6QWWYuL
RBAAiY8cJwbqplnqBSFAiGTEs1tHDEsX0yPqquryBcSZVa7BuEWDynnRshgS19vIB5XaHHORLdOl
NiXnVdWtzyAhHOX7JJ2kGKGN5zcMqyChDoylHKJ29I1mLrLk9Sn4QcibdCNnt1jkkARnxWr4LDYo
2xdRuO9MJhhS2eVvsCDfqhtsDVnCwj/DpkseFesVv9ivQUogC7kMfGM8LrkJ0aD85XbsNz7vr07u
wUxEbc7JL5IoN3uyEDUe0r0CyH3SFdOFrtbvt/0UUNL4d33vSXGB5zcC2yzG7wtoTLuESULBO8QF
wzXqpXTdpHDeJieghJdCmsl2tA+ESRvDLwk1JkBWJGg6iAmC3EPBpjyQFWMfEoXSE1z86ruo8tN6
nUt4OYrXbSigiq32PqEfj6T/UtDkXVUUDlVbb86Sx83wVrPlLx+e8C/F3pwaeVqOJG7whN3LZLwN
orN+2FNnq239sKu+NpFskCJe8Km/fwbppO+rbXiRq9Ui9eK2Lk+qENn8UsOCa5jVIGri+ni5vSpu
4V6CD/VPYYPe7OfJ1B/OFsbN0vNjEYQRo8fYSFLSntCDE9ysvBi4rQAhD5kLfZAl7yBztSOi63fE
0XzR5G914KW7KOYNsF/VeCW2G3LvxuPlpzuc+5ZRlh0RcYm2cISgJwLocRYpjpnsh8N34pghnEDo
IGs=
=0Ob4
-----END PGP SIGNATURE-----

--Ox4T87PiHyIicTSfeJyHiVWd17DK3jfrb--
