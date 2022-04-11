Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9414E4FB450
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 09:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiDKHBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiDKHBd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 03:01:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4427152
        for <linux-pci@vger.kernel.org>; Sun, 10 Apr 2022 23:59:16 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220411065911epoutp01a584c8e7b5f097182d58e54853b4b022~kxVlbwZSQ2691426914epoutp01e
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 06:59:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220411065911epoutp01a584c8e7b5f097182d58e54853b4b022~kxVlbwZSQ2691426914epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649660351;
        bh=A/I1DYG8MUNCw0frxnD4RPNBXtGijVKeiFU69KmHVwM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=mddNfNmnZq745VDzK/dVbUcnxNE3pXwfrX33cJ+dexqzybh88+r8DtpHwzjOZHkIs
         Oc4zFPa8tyNy7HOGhUO8vItZ8LE+/iEK/kfzusVyaFnW3EklcyEA+v50aWBtbYhtdu
         whR3KVeCSJwwtlq30zJYvoh8lEFSKIxctz+RwwnI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220411065910epcas2p123494c34985d23171d3062c5d6221852~kxVkpqJYy2426624266epcas2p1P;
        Mon, 11 Apr 2022 06:59:10 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KcKTP5wT1z4x9Pv; Mon, 11 Apr
        2022 06:59:05 +0000 (GMT)
X-AuditID: b6c32a46-3aef8a8000009dd5-d5-6253d1b917d1
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.02.40405.9B1D3526; Mon, 11 Apr 2022 15:59:05 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YlBZHj29zCRlITpR@lpieralisi>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220411065905epcms2p56ee71c0142258494afb80ce26dc04039@epcms2p5>
Date:   Mon, 11 Apr 2022 15:59:05 +0900
X-CMS-MailID: 20220411065905epcms2p56ee71c0142258494afb80ce26dc04039
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhe7Oi8FJBrt7VS1+/17GaLGkKcPi
        5SFNi113O9gtTk9YxGTx/NAsZosVX2ayW3xqUbVo6PnNanF23nE2ize/X7BbnFucafF/zw52
        i513TjA78HmsmbeG0eP6ugCPnbPusnss2FTqsXmFlsfiPS+ZPDat6mTzeHJlOpNH35ZVjB5b
        9n9m9Pi8SS6AOyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUn
        QNctMwfoASWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJ
        laGBgZEpUGFCdsbjt79ZC5qUK57Nfc3ewNir1MXIySEhYCJx69kyxi5GLg4hgR2MEtO2T2fv
        YuTg4BUQlPi7QxikRljAU2LXnn1sILaQgJLEjjXzmCHi+hLXV3SzgthsAroS/xa/BKsRETCU
        6Dm1mglkJrPAChaJho59zBDLeCVmtD9lgbClJbYv38oIYnMKaEmsPHSLHSKuIfFjWS9UvajE
        zdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouJbHgySFWCLtaYv/f30wQdgOjRP/9VJC/JICO
        3nHdGCTMK+ArMevrCbBWFgFViQcbNkONdJHY0rcNbC2zgLbEsoWvmUFamQU0Jdbv0oeYoixx
        5BYLzFMNG3+zo7OZBfgkOg7/hYvvmPcE6hg1iXkrdzJPYFSehQjnWUh2zULYtYCReRWjWGpB
        cW56arFRgRE8apPzczcxglOyltsOxilvP+gdYmTiYDzEKMHBrCTCa5EUkCTEm5JYWZValB9f
        VJqTWnyI0RToy4nMUqLJ+cCskFcSb2hiaWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUI
        po+Jg1OqgenENG427o8pYdUti+WP61md3PzbYL7ON9czi+ZM+XBBeN/+jW/Zk4U4VVasuuyX
        +mGGyBT7D/PEHOYr3H5/wzjkEfuXpks2P3Pab4doKot3Swd27jSauIh/g8bhViOjHTpZesxp
        8ntVV1VfSOfumrDucsTTPTueO0y/eXiG7gGp1f9cMhf5ftXUvfllllrL/WlCRhc5dnz5LLSf
        fdf6oOvzvxq9Odv2r8ao4x1/7KRDsw8KFnWKCjawOt0QrLvf7njT5pKe19yf288lfS0X7utQ
        26zD0yPY/eXiibPTfFji2t+FSvN5sH9L3yHr5VjA8Lhs/+wsu8zzqT+ctj9Ss/nOMHV5Qd4F
        9/nnbqz2nhSqxFKckWioxVxUnAgAhceapFIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5
References: <YlBZHj29zCRlITpR@lpieralisi> <Yk/CxUxR/iRb9j8l@infradead.org>
        <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
        <YkR7G/V8E+NKBA2h@infradead.org>
        <20220328143228.1902883-1-alexandr.lobakin@intel.com>
        <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
        <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
        <20220330093526.2728238-1-alexandr.lobakin@intel.com>
        <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
        <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
        <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On=C2=A0Fri,=C2=A0Apr=C2=A008,=C2=A02022=C2=A0at=C2=A002:32:46PM=C2=A0+09=
00,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>=C2=A0>=C2=A0---------=C2=A0Or=
iginal=C2=A0Message=C2=A0---------=0D=0A>=C2=A0>=C2=A0Sender=C2=A0:=C2=A0Ch=
ristoph=C2=A0Hellwig=C2=A0<hch=40infradead.org>=0D=0A>=C2=A0>=C2=A0Date=C2=
=A0:=C2=A02022-04-08=C2=A014:06=C2=A0(GMT+9)=0D=0A>=C2=A0>=C2=A0Title=C2=A0=
:=C2=A0Re:=C2=A0=5BPATCH=5D=C2=A0PCI:=C2=A0dwc:=C2=A0Modify=C2=A0the=C2=A0c=
heck=C2=A0about=C2=A0MSI=C2=A0DMA=C2=A0mask=C2=A032-bit=0D=0A>=C2=A0>=C2=A0=
=0D=0A>=C2=A0>=C2=A0On=C2=A0Fri,=C2=A0Apr=C2=A008,=C2=A02022=C2=A0at=C2=A01=
1:34:01AM=C2=A0+0900,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>=C2=A0>>=C2=
=A0Hi,=0D=0A>=C2=A0>>=C2=A0=0D=0A>=C2=A0>>=C2=A0Could=C2=A0you=C2=A0please=
=C2=A0review=C2=A0this=C2=A0patch=C2=A0in=C2=A0the=C2=A0context=C2=A0of=C2=
=A0the=C2=A0following=C2=A0patch?=0D=0A>=C2=A0>>=C2=A0=0D=0A>=C2=A0>>=C2=A0=
https://protect2.fireeye.com/v1/url?k=3Ddff16c49-806a5556-dff0e706-000babdf=
ecba-c817c3fb701d2897&q=3D1&e=3D5862d6bb-abdb-4e80-b515-8bc024accd0c&u=3Dht=
tps%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F2022032802=
3009epcms2p309a5dfc2ff29d0a9945f65799963193c%40epcms2p=0D=0A>=C2=A0>=C2=A0=
=0D=0A>=C2=A0>=C2=A0Isn't=C2=A0that=C2=A0the=C2=A0same=C2=A0(broken)=C2=A0p=
atch?=0D=0A>=C2=A0=0D=0A>=C2=A0yes,=C2=A0The=C2=A0same=C2=A0patch=C2=A0that=
=C2=A0was=C2=A0reviewing.=0D=0A>=C2=A0I=C2=A0would=C2=A0like=C2=A0to=C2=A0c=
ontinue=C2=A0reviewing=C2=A0the=C2=A0pcie-designware-host.c=C2=A0patch=C2=
=A0below.=0D=0A>=C2=A0https://lore.kernel.org/all/20220328023009epcms2p309a=
5dfc2ff29d0a9945f65799963193c=40epcms2p3/=0D=0A>=20=0D=0A>=20Would=C2=A0you=
=C2=A0please=C2=A0instead=C2=A0provide=C2=A0call=C2=A0stack=C2=A0(full)=C2=
=A0details=C2=A0of=C2=A0the=0D=0A>=20problem=C2=A0you=C2=A0are=C2=A0trying=
=C2=A0to=C2=A0fix=C2=A0?=C2=A0You=C2=A0received=C2=A0feedback=C2=A0already=
=C2=A0on=C2=A0the=0D=0A>=20information=C2=A0you=C2=A0provided=C2=A0-=C2=A0t=
o=C2=A0understand=C2=A0where=C2=A0the=C2=A0problem=C2=A0is=C2=A0I=C2=A0woul=
d=0D=0A>=20ask=C2=A0you=C2=A0please=C2=A0the=C2=A0full=C2=A0call=C2=A0stack=
=C2=A0leading=C2=A0to=C2=A0the=C2=A0failure=C2=A0(inclusive=C2=A0of=0D=0A>=
=20kernel=C2=A0version,=C2=A0platform,=C2=A0firmware=C2=A0and=C2=A0whether=
=C2=A0you=C2=A0are=C2=A0using=C2=A0a=C2=A0vanilla=0D=0A>=20kernel=C2=A0or=
=C2=A0out=C2=A0of=C2=A0tree=C2=A0patches=C2=A0on=C2=A0top=C2=A0-=C2=A0in=C2=
=A0which=C2=A0case=C2=A0we=C2=A0can't=C2=A0really=0D=0A>=20help),=C2=A0it=
=C2=A0is=C2=A0impossible=C2=A0to=C2=A0comment=C2=A0further=C2=A0otherwise.=
=0D=0A>=20=0D=0A>=20Thanks,=0D=0A>=20Lorenzo=0D=0A=0D=0ATake=20artpec-8=20S=
oC=20using=2064bit=20system=20as=20an=20example.=0D=0Aartpec-8=20is=20curre=
ntly=20upstreaming.=20=0D=0AHowever,=20I=20think=20the=20same=20phenomenon=
=20will=20occur=20=0D=0Ain=20platform=20that=20uses=20other=2064bit=20syste=
ms.=0D=0A=0D=0Adriver_init()=20->=0D=0A->=20platform_dma_configure()=20/=20=
platform.c=0D=0A=20=20=7C->=20of_dma_configure()=20=0D=0A=20=20=20=20=20=7C=
->=20of_dma_configure_id()=0D=0A=20=20=20=20=20=20=20=20:Here,=20set=20dma=
=20of=2033+=20address.=0D=0A=20=20=20=20=20=20=20=20=20dma_set_mask(0xf=60f=
fff=60ffff),=20bus_dma_limit(0xf=60ffff=60ffff)=0D=0A->=20artpec8_pcie_prob=
e()=20/=20artpec-8=20pcie=20driver=20code=0D=0A=20=20=7C->=20dw_pcie_host_i=
nit()=20/=20pcie-designware-host.c=0D=0A=20=20=20=20=20=7C->=20dma_set_mask=
(32)=0D=0A=20=20=20=20=20=20=20=20=20:=20Here,=20set=20the=20dma=20mask=20o=
f=2032=20addresses.=0D=0A=20=20=20=20=20=7C->=20dma_map_single_attrs()=20=
=0D=0A=20=20=20=20=20=20=20=20=7C->=20dma_map_page_attrs()=0D=0A=20=20=20=
=20=20=20=20=20=20=20=20=7C->=20dma_direct_map_page()=0D=0A=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20:=20Error=20return=20occurs=20here.=0D=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20dma=20address=20has=2033+=20addre=
ss=20and=20=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20dma=20bus=
=20limit=20is=2033+.=20=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20However,=20this=20is=20because=20the=20mask=20value=20=0D=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20has=2032=20addresses.=0D=0A=0D=0A=0D=0A=
Therefore,=20the=20dma_set_mask(32)(in=20dw_pcie_host_init())=0D=0Awas=20mo=
dified=20to=20be=20performed=20only=20when=0D=0Athe=20dev-dma_mask=20is=20n=
ot=20set=20larger=20than=2032=20bits.=0D=0A=0D=0AThank=20you.
