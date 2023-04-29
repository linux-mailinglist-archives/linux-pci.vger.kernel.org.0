Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C06F23C3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 11:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjD2JDf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Apr 2023 05:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2JDe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Apr 2023 05:03:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305DC1BE1;
        Sat, 29 Apr 2023 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1682758988; i=frank-w@public-files.de;
        bh=ryb3vuchOoJz9RS7o/F3W2E9bKSR6lft0Zkkvso8m/k=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=L5YJAr+2E2LcMEEJqJK/9d565npA56tb9dp3jQZ45+q7rx9jXNBzu577KRlWtHO7A
         A6/byWVZGY6Q40LJ7KaTYt555ERn0zxo8UvQwut2v4EWXKMbgsGxWURuBuqAq0eSCp
         0TXkBSyEb0Hti28uPSDr481LNyfqEj9qTGAQ/qHNEquYfpQ4e7xYBDoS0DPTrqZLRh
         se1Z04W3kUFsjjxvw5oXDw3Bp4keyzaPJhavsFGBuTQ+HQmK2Ibfz6w1DWbAb288A/
         p86oVuQ3ghOr/q26b/qWUGi+zj+bwlENAP4w8lVmmwZJN8LNX4594BiqLcfrNWiAjE
         jIXhxAm+IHG0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [IPv6:::1] ([80.187.107.191]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1ptVhH1XZD-000rop; Sat, 29
 Apr 2023 11:03:08 +0200
Date:   Sat, 29 Apr 2023 11:03:07 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>, "linux@fw-web.de" <linux@fw-web.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: Aw: [PATCH] PCI: mediatek-gen3: handle PERST after reset
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <cd7c2672cc7cb97086cdb8d2079ad38c7fd6367f.camel@mediatek.com>
References: <20230402131347.99268-1-linux@fw-web.de> <trinity-8c5502f4-34bc-456b-9e4b-37edac37c3ed-1682530907724@3c-app-gmx-bs05> <74149a72313c1b944c870a45b55893e1b9331c8e.camel@mediatek.com> <EF6EF3CD-5741-449E-B7E0-27DF9A6C297D@fw-web.de> <cd7c2672cc7cb97086cdb8d2079ad38c7fd6367f.camel@mediatek.com>
Message-ID: <82F47DB2-CFB9-4DA0-97A7-81F1B939A025@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JR3F6ExB6t3PQ1jvjE/YAPO0mawhIxMF9NyaDlRF6YSjDK9UCIq
 zD7WrK+S36RUkr1wp1LJSAbqfztP8GjfGx7fz0+hgCC6tBjm9vq1g/0QTZ/jDD7wYz5jUYG
 l+nyIlRo14LyhmGgkC5hyzwqTS7VeGuWGjbxdYsUBQ4AiYQMRaTp5rG4J2zjbPs9snZMGe4
 dL9vSNjCtb1aie2NKFm+A==
UI-OutboundReport: notjunk:1;M01:P0:UiIpUD1Nvy8=;X4DRTtJw5QEf48g4Z0juQBiy7cX
 qgo2iI9AyV7fO503Zzj2ceto0Hc2QWr7kno477wVNPba+/nMkMcPxBDcJCkbWJcjf3nves/6J
 NZVCok+v5Yu+3W2RkhSojP6dCpl4dRLdwgfhoOKF5HZwOZoF4bRLr8XcJGm4jkbrIowI5TF81
 kDFcXm93qAiBAuXkWcGjt5mz6qrDpm0LitqvGIGMOcBTDDiOtskhFqpcTJ4FpfnbDhRi2/1oT
 wnJs22/DXApVRKBAPFRlR7J1PAkSdoNYdbsuYE2G0nhGwrMmW2aWm/yJaT/R7swye6pyof09U
 g+0QbXU/BUGPsEnywYLXv8I7dx235Xhf/BrcC5h6TYsPjvPrFBch2sAJaMSUGcNJ1xdoLIwfW
 G58YVWywL9IzW38QuV3p9I8BENe32QuglK08UlCfuv3EHkXNdFESCO6M0K1hXham5zr/BmKzK
 WEqMRPZhqpO1o6nB2m4zh3V6xa2SqbXcKZrMQQOaQs9qx6vrdZeEkSr5qNZCWcj9c71hN8HgK
 DiO31J95MJZ0DYYhG8kkgA1fc18+dIqGmqQYLci5lTDG8Gu+HKSQFUc7Vgh/02j5nnJbwKITY
 rZvNpyaDCQmMojYMA4QwrhIWTaNEHgGHwAgVuhAH5uPxSSMyjtVe423DE6VcCeIxOhVdnNWST
 n3jW/tYKLEz7xG+LpY7Vg19n3TI0pT0QavqKoGMI0GGVM1NRXTphqQ7aPyHWMSMjSaaj7UIWq
 MrKZHe4IBeYmhZQ7aaWzSsfMx8xWlfr0WHUiSoM1yJBN2ZH7ZUf/dVc3hH/HCEvsp1gohs7ik
 3fQLUUrCqeH9SMrYNmoLyR88MH38zeuj9QCoEtA/5l1f293UBFI1rm08o4l8ujec0k9GrfVed
 FUsmXetUrbBOKhE/+W1aKohb8oZpOj4RrdBbhSwal0f8DYJaPdz2WXNF/fpzoLcRt4MNnj2H1
 l+AoXibw3rhuxDNieWKbA8dxwZ+YMWkoNdyKh6cnD0usPplmZENLKcu5lzbT/X05Mx6T+w==
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Am 29=2E April 2023 05:15:51 MESZ schrieb "Jianjun Wang (=E7=8E=8B=E5=BB=
=BA=E5=86=9B)" <Jianjun=2EWang@mediatek=2Ecom>:
>Hi Frank,
>
>On Fri, 2023-04-28 at 07:50 +0200, Frank Wunderlich wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content=2E
>>=20
>>=20
>> Am 27=2E April 2023 10:31:07 MESZ schrieb "Jianjun Wang (=E7=8E=8B=E5=
=BB=BA=E5=86=9B)" <
>> Jianjun=2EWang@mediatek=2Ecom>:
>> > Hi Frank,
>> >=20
>> > Seems this patch has huge impact on boot time, I'm curious about
>> > the
>> > NVMe detection issue on mt7986, can you share the SSD model that
>> > you
>> > are using and the bootup logs with that SSD?
>>=20
>> Which "huge" delay do you get in which setup? It adds a 100ms delay
>> yes,but this seems needed to some devices working=2Ei found several
>> sources talking about the 100ms wake-up time=2E=2E=2E

>Some products are very sensitive to the bootup time, especially the
>platforms with many PCIe ports, adding this 100ms delay for each port
>will cause the bootup time be increased by multiple times(depending on
>the number of PCIe ports it uses), and also the wake-up time, since the
>mtk_pcie_starup_port() function will be called on resume stage=2E

Thanks for taking time for analysing it=2E

>> I do not have this issue,but some users in bpi-forum reorted it=2E
>> Pcie-controller on mt7986/bpi-r3 does simply not detect the nvme and
>> returned ETIMEDOUT (110)=2E
>Since we're already comply with the PCIe CEM specification sections
>2=2E2(PERST# signal)[1], and this issue only occurs on a few platforms,

I see there is the msleep before the reset,where the patch splits reset an=
d perst (and add the sleep between)=2E

So imho the best way is to move the existing msleep between these "splitte=
d" signals instead of adding a second one=2E I have to verify it with someo=
ne who have the issue currently=2E

>I'll inclined to it's might be a signal quality issue=2E Also I checked
>the BPI-R3 schematic diagram[2], and noticed that there are no AC
>Coupling capacitors on the transmitter side, which described in PCIe
>CEM Spec sections 4=2E7=2E1, but this schematic diagram only have part of
>it, can you help to check the board design or share the full schematic
>diagram for further analysis?=20

I gave the questions to board vendor in forum=2E

>[1]:=20
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/drivers/pci/controller/pcie-mediatek-gen3=2Ec?h=3Dv6=2E3#n344
>[2]:
>https://drive=2Egoogle=2Ecom/file/d/1mxKb8CBbnzfNSd_4esmcX_NovxaXjEb8/vie=
w
>
>Thanks=2E
>>=20
>> # dmesg | grep 'pci'
>> [ 5=2E235564] mtk-pcie-gen3 11280000=2Epcie: host bridge=20
>> /soc/pcie@11280000 ranges:
>> [ 5=2E242938] mtk-pcie-gen3 11280000=2Epcie: Parsing ranges property=2E=
=2E=2E
>> [ 5=2E249235] mtk-pcie-gen3 11280000=2Epcie: MEM
>> 0x0020000000=2E=2E0x002fffffff -> 0x0020000000
>> [ 5=2E478062] mtk-pcie-gen3 11280000=2Epcie: PCIe link down, current
>> LTSSM state: detect=2Eactive (0x10 00001)
>> [ 5=2E487491] mtk-pcie-gen3: probe of 11280000=2Epcie failed with error
>> -110
>>=20
>> One specific hardware is reported as example:
>>=20
>> Adata Legend710 512GB x3
>>=20
>> > Thanks=2E
>> >=20
>> > On Wed, 2023-04-26 at 19:41 +0200, Frank Wunderlich wrote:
>> > > External email : Please do not click links or open attachments
>> > > until
>> > > you have verified the sender or the content=2E
>> > >=20
>> > >=20
>> > > Hi
>> > >=20
>> > > > Gesendet: Sonntag, 02=2E April 2023 um 15:13 Uhr
>> > > > Von: "Frank Wunderlich" <linux@fw-web=2Ede>
>> > > > De-assert PERST in separate step after reset signals to fully
>> > > > comply
>> > > > the PCIe CEM clause 2=2E2=2E
>> > > >=20
>> > > > This fixes some NVME detection issues on mt7986=2E
>> > > >=20
>> > > > Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3
>> > > > driver
>> > > > for MT8192")
>> > > > Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> > > > ---
>> > > > Patch is taken from user Ruslan aka RRKh61 (permitted me to
>> > > > send it
>> > > > with me as author)=2E
>> > > >=20
>> > > >=20
>> >=20
>> >=20
>https://urldefense=2Ecom/v3/__https://forum=2Ebanana-pi=2Eorg/t/bpi-r3-nv=
me-connection-issue/14563/17__;!!CTRNKA9wMg0ARbw!nCXEM685pkUpoiZYGKptPYccNr=
WMeN2D3jIO5_irwxZJ7c6ZzEeACIx-V2WeZHAP_0FKlDDIQ0RbDJ892prtoToDv30$
>> > > > ---
>> > > >  drivers/pci/controller/pcie-mediatek-gen3=2Ec | 8 +++++++-
>> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
>> > > >=20
>> > > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > > > b/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > > > index b8612ce5f4d0=2E=2E176b1a04565d 100644
>> > > > --- a/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > > > +++ b/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > > > @@ -350,7 +350,13 @@ static int mtk_pcie_startup_port(struct
>> > > > mtk_gen3_pcie *pcie)
>> > > >       msleep(100);
Maybe the better way is to drop this msleep when adding the new one below =
the reset asserts?

>> > > >       /* De-assert reset signals */
>> > > > -     val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
>> > > > PCIE_PE_RSTB);
>> > > > +     val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
>> > > > +     writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>> > > > +
>> > > > +     msleep(100);
>> > > > +
>> > > > +     /* De-assert PERST# signals */
>> > > > +     val &=3D ~(PCIE_PE_RSTB);
>> > > >       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>> > > >=20
>> > > >       /* Check if the link is up or not */



regards Frank
