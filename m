Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8964FB816
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbiDKJuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344779AbiDKJuX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 05:50:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056C41331
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 02:47:56 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220411094749epoutp01df1cb553072e6a8c8fe6a011cbd5cfc6~kzo0_ipd12872028720epoutp01_
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 09:47:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220411094749epoutp01df1cb553072e6a8c8fe6a011cbd5cfc6~kzo0_ipd12872028720epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649670469;
        bh=svqA29oyQi328R6wMQM84WeEQf7p4MLZ9J4SAa3QCFs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=iYR+IMWLJLyocTewzXGCOrovcInYABkqUfEBLzlrqE314QLOShrqfWLY4wJDxWJqR
         lQWRc7VvQtEinRTicFJSLcoakFn1+L+EteE93bbOh8deePECK55TxafiCVa93jEgBE
         HAWLfJNRjgRzYesd0KKE/4YgckNif817IJRu+gjg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220411094748epcas2p3342c0388079455e7fa46ac97d688eeda~kzo0B9Rir0383803838epcas2p3u;
        Mon, 11 Apr 2022 09:47:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KcPD11vBGz4x9Px; Mon, 11 Apr
        2022 09:47:45 +0000 (GMT)
X-AuditID: b6c32a46-ba1ff70000009dd5-98-6253f941bc64
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.BC.40405.149F3526; Mon, 11 Apr 2022 18:47:45 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
In-Reply-To: <YlPUc5qzqu4wcxX0@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220411094744epcms2p152a3a161ce35835464b7e745dd86050a@epcms2p1>
Date:   Mon, 11 Apr 2022 18:47:44 +0900
X-CMS-MailID: 20220411094744epcms2p152a3a161ce35835464b7e745dd86050a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmma7jz+Akg8NX2S1+/17GaLGkKcPi
        5SFNi113O9gtTk9YxGTx/NAsZosVX2ayW3xqUbVo6PnNanF23nE2ize/X7BbnFucafF/zw52
        i513TjA78HmsmbeG0eP6ugCPnbPusnss2FTqsXmFlsfiPS+ZPDat6mTzeHJlOpNH35ZVjB5b
        9n9m9Pi8SS6AOyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUn
        QNctMwfoASWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJ
        laGBgZEpUGFCdsahj52MBUtUKjadec3awLhSuYuRk0NCwERiQ8MXNhBbSGAHo8SnJ65djBwc
        vAKCEn93CIOEhQU8JXbt2QdVoiSxY808Zoi4vsT1Fd2sIDabgK7Ev8UvwWpEBDQlbi1vB6rh
        4mAW2MAi8fjhJmaIXbwSM9qfskDY0hLbl29lBLE5gZqf/5/ABBHXkPixrBeqXlTi5uq37DD2
        +2PzGSFsEYnWe2ehagQlHvzcDRWXkljw5BArhF0tsf/vb6iZDYwS/fdTQf6SADp6x3VjkDCv
        gK/EtSXLwcazCKhKbN60A2qMi8Sc3dvBbGYBbYllC18zg7QyA/21fpc+xBRliSO3WGCeatj4
        mx2dzSzAJ9Fx+C9cfMe8J1DHqEnMW7mTeQKj8ixEOM9CsmsWwq4FjMyrGMVSC4pz01OLjQqM
        4DGbnJ+7iRGckLXcdjBOeftB7xAjEwfjIUYJDmYlEV6LpIAkId6UxMqq1KL8+KLSnNTiQ4ym
        QF9OZJYSTc4H5oS8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1M
        9SEhS7K5685rH5cxq6lecIxR/VaGxzJGc9Ygc73Wn67Zl/71ZtQkpLyJnhf2nGnyystLErJv
        OF/etO+PbPoCe82klU3V7e0nI3hVvznJWpktY0l/d+X+keC1iewm5/U4Vr+y+Fu3Qeb/jgu9
        kfmHDgo/i3r1bHFmdNiBt2cYZp3/ddmX08e0Jrj74X0pJWvmCdsP2J26nvTY+OH8VYZOzX3h
        XE/yp/LuevyvULahlIf1Ve3Ptas0rvkH2m+5xb/I+bkrh8E0my8vrXf78cz1P1lzKyLeVan9
        7HYBkSo7pU12ff80cw+4rct9kB+is3tN9I0v/VuCeo/t/yI92yLse/raTnPBOI3lBqyPGqWU
        WIozEg21mIuKEwFsYQU5UQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5
References: <YlPUc5qzqu4wcxX0@infradead.org>
        <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
        <YkR7G/V8E+NKBA2h@infradead.org>
        <20220328143228.1902883-1-alexandr.lobakin@intel.com>
        <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
        <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
        <20220330093526.2728238-1-alexandr.lobakin@intel.com>
        <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
        <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
        <20220411065905epcms2p56ee71c0142258494afb80ce26dc04039@epcms2p5>
        <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On=C2=A0Mon,=C2=A0Apr=C2=A011,=C2=A02022=C2=A0at=C2=A003:59:05PM=C2=A0+09=
00,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>>=C2=A0driver_init()=C2=A0->=
=0D=0A>>=C2=A0->=C2=A0platform_dma_configure()=C2=A0/=C2=A0platform.c=0D=0A=
>>=C2=A0=C2=A0=C2=A0=7C->=C2=A0of_dma_configure()=C2=A0=0D=0A>>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=7C->=C2=A0of_dma_configure_id()=0D=0A>>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:Here,=C2=A0set=C2=A0dma=C2=A0=
of=C2=A033+=C2=A0address.=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dma_set_mask(0xf=60ffff=60ffff),=C2=A0bus_dma_limit(0xf=
=60ffff=60ffff)=0D=0A>=20=0D=0A>=20Where=C2=A0do=C2=A0we=C2=A0set=C2=A0a=C2=
=A0large=C2=A0than=C2=A032-bit=C2=A0dma=C2=A0mask=C2=A0here?=C2=A0=C2=A0I=
=C2=A0can't=C2=A0find=C2=A0the=0D=0A>=20code,=C2=A0and=C2=A0if=C2=A0there=
=C2=A0is=C2=A0we=C2=A0need=C2=A0to=C2=A0fix=C2=A0it.=C2=A0=C2=A0In=C2=A0Lin=
ux=C2=A0devices=C2=A0to=C2=A0come=0D=0A>=20up=C2=A0with=C2=A032-bit=C2=A0DM=
A=C2=A0masks=C2=A0for=C2=A0historical=C2=A0reasons=C2=A0(they=C2=A0really=
=C2=A0should=0D=0A>=20with=C2=A0a=C2=A0zero=C2=A0dma=C2=A0mask,=C2=A0but=C2=
=A0it=C2=A0is=C2=A0probably=C2=A0to=C2=A0lte=C2=A0to=C2=A0fix=C2=A0it).=0D=
=0A>=20=0D=0A>>=C2=A0->=C2=A0artpec8_pcie_probe()=C2=A0/=C2=A0artpec-8=C2=
=A0pcie=C2=A0driver=C2=A0code=0D=0A>>=C2=A0=C2=A0=C2=A0=7C->=C2=A0dw_pcie_h=
ost_init()=C2=A0/=C2=A0pcie-designware-host.c=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=7C->=C2=A0dma_set_mask(32)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:=C2=A0Here,=C2=A0set=C2=A0the=C2=A0dma=
=C2=A0mask=C2=A0of=C2=A032=C2=A0addresses.=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=7C->=C2=A0dma_map_single_attrs()=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C->=C2=A0dma_map_page_attrs()=0D=
=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=7C->=C2=A0dma_direct_map_page()=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:=C2=A0Error=C2=
=A0return=C2=A0occurs=C2=A0here.=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma=C2=
=A0address=C2=A0has=C2=A033+=C2=A0address=C2=A0and=C2=A0=0D=0A>>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dma=C2=A0bus=C2=A0limit=C2=A0is=C2=A033+.=C2=A0=0D=0A>>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0However,=C2=A0this=C2=A0is=C2=A0because=C2=A0the=
=C2=A0mask=C2=A0value=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0has=C2=A032=
=C2=A0addresses.=0D=0A>=20=0D=0A>=20If=C2=A0the=C2=A0dma_mask=C2=A0is=C2=A0=
set=C2=A0to=C2=A032-bits,=C2=A0we=C2=A0should=C2=A0never=C2=A0generate=C2=
=A0a=0D=0A>=20large=C2=A0dma=C2=A0address,=C2=A0but=C2=A0bounce=C2=A0if=C2=
=A0it=C2=A0would=C2=A0othewise=C2=A0generate=C2=A0a=0D=0A>=20larger=C2=A0ad=
dress.=0D=0A>=20=0D=0A>=20That=C2=A0being=C2=A0said=C2=A0I=C2=A0think=C2=A0=
this=C2=A0code=C2=A0would=C2=A0be=C2=A0much=C2=A0better=C2=A0off=C2=A0using=
=0D=0A>=20dma_alloc_coherent=C2=A0anyway.=0D=0A>=20=0D=0A>>=C2=A0Therefore,=
=C2=A0the=C2=A0dma_set_mask(32)(in=C2=A0dw_pcie_host_init())=0D=0A>>=C2=A0w=
as=C2=A0modified=C2=A0to=C2=A0be=C2=A0performed=C2=A0only=C2=A0when=0D=0A>>=
=C2=A0the=C2=A0dev-dma_mask=C2=A0is=C2=A0not=C2=A0set=C2=A0larger=C2=A0than=
=C2=A032=C2=A0bits.=0D=0A>=20=0D=0A>=20So=C2=A0what=C2=A0sets=C2=A0dev->dma=
_mask=C2=A0to=C2=A0a=C2=A0larger=C2=A0than=C2=A032-bit=C2=A0value=C2=A0here=
?=0D=0A>=20We=C2=A0need=C2=A0to=C2=A0find=C2=A0and=C2=A0fix=C2=A0that.=0D=
=0A=0D=0AAt=20the=20code=20of=20of_dma_configure_id()=20of=20driver/of/devi=
ce.c..=0D=0AIn=20the=2064bit=20system,=20if=20the=20dma=20start=20addr=20is=
=20used=20as=200x1'0000'0000=0D=0Aand=20the=20size=20is=20used=20as=200xf'0=
000'0000,=20=22u64=20end=22=20is=200xf'ffff'ffff.=20=0D=0AAnd=20the=20dma_m=
ask=20value=20is=20changed=20from=200xffff'ffff'ffff'ffff=20to=0D=0A0xf'fff=
f'ffffff=20due=20to=20the=20code=20below.=0D=0A=0D=0A181=20line,=20driver/o=
f/device.c=0D=0A-------------------------------------------------=0D=0Aend=
=20=3D=20dma_start=20+=20size=20-=201;=0D=0Amask=20=3D=20DMA_BIT_MASK(ilog2=
(end)=20+=201);=0D=0Adev->coherent_dma_mask=20&=3D=20mask;=0D=0A*dev->dma_m=
ask=20&=3D=20mask;=0D=0A-------------------------------------------------=
=0D=0APlease=20let=20me=20know=20if=20I'm=20mistaken.=0D=0A=0D=0AThank=20yo=
u.
