Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993C56F117C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Apr 2023 07:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbjD1Fuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 01:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjD1Fuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 01:50:50 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54B40FE;
        Thu, 27 Apr 2023 22:50:44 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 773436047E;
        Fri, 28 Apr 2023 05:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1682661042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDtkCIn/nLZXXWzX5To63sdeI+HDe6I42ogqmZDgdf0=;
        b=CqPTpYqYfwrWmCuNy8oY8e/tOk5LM6+xGW21v3EuWn9CJHqJIqAA/OB890+1ccgm1Bl5Vb
        4PLkfD9stcFJIElUdbgFIu7nb1apqoq8840sceTb9EifsoBtkj8EyPNA89nMgApi/Gyv8f
        B13+zPYBGgPe5N2uY88mGfioCCpb6gQ=
Received: from [127.0.0.1] (fttx-pool-217.61.155.215.bambit.de [217.61.155.215])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 936D53605FC;
        Fri, 28 Apr 2023 05:50:41 +0000 (UTC)
Date:   Fri, 28 Apr 2023 07:50:42 +0200
From:   Frank Wunderlich <linux@fw-web.de>
To:     =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "frank-w@public-files.de" <frank-w@public-files.de>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <74149a72313c1b944c870a45b55893e1b9331c8e.camel@mediatek.com>
References: <20230402131347.99268-1-linux@fw-web.de> <trinity-8c5502f4-34bc-456b-9e4b-37edac37c3ed-1682530907724@3c-app-gmx-bs05> <74149a72313c1b944c870a45b55893e1b9331c8e.camel@mediatek.com>
Message-ID: <EF6EF3CD-5741-449E-B7E0-27DF9A6C297D@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 755e09e7-e3b0-4594-969c-7546f4326435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 27=2E April 2023 10:31:07 MESZ schrieb "Jianjun Wang (=E7=8E=8B=E5=BB=BA=
=E5=86=9B)" <Jianjun=2EWang@mediatek=2Ecom>:
>Hi Frank,
>
>Seems this patch has huge impact on boot time, I'm curious about the
>NVMe detection issue on mt7986, can you share the SSD model that you
>are using and the bootup logs with that SSD?

Which "huge" delay do you get in which setup? It adds a 100ms delay yes,bu=
t this seems needed to some devices working=2Ei found several sources talki=
ng about the 100ms wake-up time=2E=2E=2E

I do not have this issue,but some users in bpi-forum reorted it=2E Pcie-co=
ntroller on mt7986/bpi-r3 does simply not detect the nvme and returned ETIM=
EDOUT (110)=2E

# dmesg | grep 'pci'
[ 5=2E235564] mtk-pcie-gen3 11280000=2Epcie: host bridge /soc/pcie@1128000=
0 ranges:
[ 5=2E242938] mtk-pcie-gen3 11280000=2Epcie: Parsing ranges property=2E=2E=
=2E
[ 5=2E249235] mtk-pcie-gen3 11280000=2Epcie: MEM 0x0020000000=2E=2E0x002ff=
fffff -> 0x0020000000=20
[ 5=2E478062] mtk-pcie-gen3 11280000=2Epcie: PCIe link down, current LTSSM=
 state: detect=2Eactive (0x10 00001)
[ 5=2E487491] mtk-pcie-gen3: probe of 11280000=2Epcie failed with error -1=
10

One specific hardware is reported as example:

Adata Legend710 512GB x3

>Thanks=2E
>
>On Wed, 2023-04-26 at 19:41 +0200, Frank Wunderlich wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content=2E
>>=20
>>=20
>> Hi
>>=20
>> > Gesendet: Sonntag, 02=2E April 2023 um 15:13 Uhr
>> > Von: "Frank Wunderlich" <linux@fw-web=2Ede>
>> > De-assert PERST in separate step after reset signals to fully
>> > comply
>> > the PCIe CEM clause 2=2E2=2E
>> >=20
>> > This fixes some NVME detection issues on mt7986=2E
>> >=20
>> > Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver
>> > for MT8192")
>> > Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> > ---
>> > Patch is taken from user Ruslan aka RRKh61 (permitted me to send it
>> > with me as author)=2E
>> >=20
>> >=20
>https://urldefense=2Ecom/v3/__https://forum=2Ebanana-pi=2Eorg/t/bpi-r3-nv=
me-connection-issue/14563/17__;!!CTRNKA9wMg0ARbw!nCXEM685pkUpoiZYGKptPYccNr=
WMeN2D3jIO5_irwxZJ7c6ZzEeACIx-V2WeZHAP_0FKlDDIQ0RbDJ892prtoToDv30$
>> > ---
>> >  drivers/pci/controller/pcie-mediatek-gen3=2Ec | 8 +++++++-
>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > b/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > index b8612ce5f4d0=2E=2E176b1a04565d 100644
>> > --- a/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > +++ b/drivers/pci/controller/pcie-mediatek-gen3=2Ec
>> > @@ -350,7 +350,13 @@ static int mtk_pcie_startup_port(struct
>> > mtk_gen3_pcie *pcie)
>> >       msleep(100);
>> >=20
>> >       /* De-assert reset signals */
>> > -     val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
>> > PCIE_PE_RSTB);
>> > +     val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
>> > +     writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>> > +
>> > +     msleep(100);
>> > +
>> > +     /* De-assert PERST# signals */
>> > +     val &=3D ~(PCIE_PE_RSTB);
>> >       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>> >=20
>> >       /* Check if the link is up or not */
>>=20
>> Hi
>>=20
>> just a friendly reminder=2E=2E=2E=2Edo i miss any recipient?
>>=20
>> regards Frank
>>=20


regards Frank
