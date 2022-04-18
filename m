Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58A2504B36
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 05:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiDRDP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 23:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiDRDP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 23:15:28 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F813E95
        for <linux-pci@vger.kernel.org>; Sun, 17 Apr 2022 20:12:49 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220418031246epoutp0106ef51fc21083f5257cd3cbf446971e1~m3w5wpkLL0435604356epoutp019
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2022 03:12:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220418031246epoutp0106ef51fc21083f5257cd3cbf446971e1~m3w5wpkLL0435604356epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650251566;
        bh=zUYN46gQC2FviMQPjGOrDuOM538WmvvgLGp8KrFYnAM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=HAgOyWa6DwmwyEXZZw2Q/VGS7TrAdp+PS6x7+6eHfe47d5cWM8RhdbKwffRqmdiSK
         YM5uYNSCvqDdQvocpEzZK3LM7yUStvCF9qn4UIw2ZMeTeAViuvCROXtAOJVm8kieJM
         qvZwo518aTCqpyQUzgn6KVNWpuNX7dqNJj5uOT/w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220418031245epcas2p2870f3b9e2b104e9fe4a6e7869233b9f7~m3w4-jL1D1207412074epcas2p2N;
        Mon, 18 Apr 2022 03:12:45 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KhX6y0wM6z4x9Q7; Mon, 18 Apr
        2022 03:12:42 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-27-625cd729ab6d
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.A5.25540.927DC526; Mon, 18 Apr 2022 12:12:41 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
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
In-Reply-To: <c4dba770-1449-322e-ea7b-387cfbeaceb6@arm.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220418031241epcms2p10944eac3fa57d0722e15cf6ed28951be@epcms2p1>
Date:   Mon, 18 Apr 2022 12:12:41 +0900
X-CMS-MailID: 20220418031241epcms2p10944eac3fa57d0722e15cf6ed28951be
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmqa7m9Zgkg813jCx+/17GaLGkKcPi
        5SFNi113O9gtTk9YxGTx/NAsZosVX2ayW3xqUbVo6PnNanF23nE2ize/X7BbnFucafF/zw52
        i4MfnrBa7LxzgtmB32PNvDWMHtfXBXjsnHWX3WPBplKPzSu0PBbvecnksWlVJ5vHkyvTmTz6
        tqxi9Niy/zOjx+dNcgHcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5
        qbZKLj4Bum6ZOUBfKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz
        0vXyUkusDA0MjEyBChOyM15ducVUsFamYknXZbYGxvPSXYycHBICJhLXN21j6WLk4hAS2MEo
        cfDySvYuRg4OXgFBib87hEFqhAU8JXbt2ccGYgsJKEnsWDOPGSKuL3F9RTcriM0moCvxb/FL
        sBoRgQCJY9+ugc1kFtjAIvH44SZmiGW8EjPan7JA2NIS25dvZQSxOQWsJbYdmgdVoyHxY1kv
        lC0qcXP1W3YY+/2x+YwQtohE672zUDWCEg9+7oaKS0kseHKIFcKultj/9zcThN3AKNF/PxXk
        Lwmgo3dcNwYJ8wr4SkxccRTsZhYBVYkpL+ayQZS7SLT8Xgo2hllAW2LZwtfMIK3MApoS63fp
        Q0xRljhyiwXmqYaNv9nR2cwCfBIdh//CxXfMewJ1jJrEvJU7mScwKs9ChPMsJLtmIexawMi8
        ilEstaA4Nz212KjAGB61yfm5mxjByVnLfQfjjLcf9A4xMnEwHmKU4GBWEuHtWRKdJMSbklhZ
        lVqUH19UmpNafIjRFOjLicxSosn5wPyQVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7
        NbUgtQimj4mDU6qBadaNKHWhkCnMn3f8NGnh/u6yNeny0QJR24sMRues6zY3OaXOPDf3hbe6
        b5b+oXWX+s7veqUmHqNRpCBws275fMOjTbpC7FvY317cL5vx3L9hoZb7C7b9mqdOP2YJcXf4
        +/y82vyTP3MzEo+5LP7bLGfwJWHV7i8Zesvr1+5b89lhp6CFh/Thp6ePP9gXNzvDRCpy1drd
        1gxpofsmlj63/ZjrlOa6e7532dOys6/yj0+IcXq06FB85/u12gpt/Gp/OKSfh6o/U721teDy
        vkk6z0SMQuwKPe8l/HlfGx8dN42Vo8tNSXDNS/OOu+KiK5Y43rA9Za5/fN1ZL/XffQHbE553
        COtfyej2vqltd4X/thJLcUaioRZzUXEiAP3pazNXBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5
References: <c4dba770-1449-322e-ea7b-387cfbeaceb6@arm.com>
        <YkR7G/V8E+NKBA2h@infradead.org>
        <20220328143228.1902883-1-alexandr.lobakin@intel.com>
        <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
        <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
        <20220330093526.2728238-1-alexandr.lobakin@intel.com>
        <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
        <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
        <20220411065905epcms2p56ee71c0142258494afb80ce26dc04039@epcms2p5>
        <20220411094744epcms2p152a3a161ce35835464b7e745dd86050a@epcms2p1>
        <YlQk/9hFnb+/TpHo@infradead.org>
        <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A02022-04-11=C2=A013:54,=C2=A0Christoph=C2=A0Hellwig=C2=A0wrote:=0D=
=0A>=20Yeah,=C2=A0there's=C2=A0some=C2=A0smelly=C2=A0history=C2=A0here...=
=C2=A0Originally,=C2=A0of_dma_configure()=C2=A0=0D=0A>=20pre-set=C2=A0the=
=C2=A0masks=C2=A0as=C2=A0an=C2=A0attempt=C2=A0to=C2=A0impose=C2=A0any=C2=A0=
restriction=C2=A0represented=C2=A0by=C2=A0=0D=0A>=20DT=C2=A0=22dma-ranges=
=22=C2=A0-=C2=A0the=C2=A0platform=C2=A0it=C2=A0was=C2=A0implemented=C2=A0in=
=C2=A0aid=C2=A0of=C2=A0happened=C2=A0to=C2=A0=0D=0A>=20have=C2=A0a=C2=A031-=
bit=C2=A0DMA=C2=A0range,=C2=A0which=C2=A0may=C2=A0well=C2=A0have=C2=A0colou=
red=C2=A0some=C2=A0implicit=C2=A0=0D=0A>=20assumptions.=C2=A0IIRC,=C2=A0whe=
n=C2=A0I=C2=A0first=C2=A0implemented=C2=A0the=C2=A0separate=C2=A0bus_dma_ma=
sk=C2=A0to=C2=A0=0D=0A>=20properly=C2=A0solve=C2=A0the=C2=A0general=C2=A0co=
nstraint=C2=A0problem,=C2=A0I=C2=A0left=C2=A0the=C2=A0other=C2=A0=0D=0A>=20=
mask-setting=C2=A0in=C2=A0place=C2=A0since=C2=A0even=C2=A0though=C2=A0it=C2=
=A0shouldn't=C2=A0have=C2=A0served=C2=A0any=C2=A0=0D=0A>=20purpose=C2=A0any=
=C2=A0more,=C2=A0I=C2=A0figured=C2=A0it=C2=A0wasn't=C2=A0actively=C2=A0harm=
ful,=C2=A0and=C2=A0by=C2=A0that=C2=A0=0D=0A>=20point=C2=A0it=C2=A0had=C2=A0=
been=C2=A0around=C2=A0long=C2=A0enough=C2=A0that=C2=A0I=C2=A0was=C2=A0a=C2=
=A0little=C2=A0wary=C2=A0of=C2=A0opening=C2=A0=0D=0A>=20a=C2=A0can=C2=A0of=
=C2=A0worms=C2=A0if=C2=A0anything=C2=A0*had*=C2=A0erroneously=C2=A0started=
=C2=A0relying=C2=A0on=C2=A0it.=0D=0A>=20=0D=0A>=20I'm=C2=A0not=C2=A0against=
=C2=A0making=C2=A0the=C2=A0change=C2=A0now=C2=A0though=C2=A0-=C2=A0I'm=C2=
=A0about=C2=A0to=C2=A0get=C2=A0to=C2=A0the=C2=A0=0D=0A>=20point=C2=A0of=C2=
=A0turning=C2=A0all=C2=A0the=C2=A0dma_configure=C2=A0stuff=C2=A0inside-out=
=C2=A0in=C2=A0the=C2=A0course=C2=A0of=C2=A0=0D=0A>=20my=C2=A0IOMMU=C2=A0rew=
ork=C2=A0anyway,=C2=A0so=C2=A0I=C2=A0fully=C2=A0expect=C2=A0to=C2=A0be=C2=
=A0breaking=C2=A0things=C2=A0and=C2=A0=0D=0A>=20picking=C2=A0up=C2=A0the=C2=
=A0pieces.=C2=A0Getting=C2=A0this=C2=A0in=C2=A0first=C2=A0so=C2=A0it's=C2=
=A0easily=C2=A0bisectable=C2=A0=0D=0A>=20and=C2=A0leaves=C2=A0me=C2=A0less=
=C2=A0code=C2=A0to=C2=A0further=C2=A0break=C2=A0seems=C2=A0most=C2=A0sensib=
le=C2=A0:)=0D=0A>=20=0D=0A>=20If=C2=A0you're=C2=A0happy=C2=A0to=C2=A0write=
=C2=A0up=C2=A0the=C2=A0patch,=C2=A0please=C2=A0also=C2=A0do=C2=A0the=C2=A0e=
quivalent=C2=A0for=C2=A0=0D=0A>=20acpi_arch_dma_setup()=C2=A0too.=0D=0A>=20=
=0D=0A>=20This=C2=A0is=C2=A0all=C2=A0orthogonal=C2=A0to=C2=A0why=C2=A0the=
=C2=A0original=C2=A0patch=C2=A0in=C2=A0this=C2=A0thread=C2=A0is=C2=A0=0D=0A=
>=20wrong,=C2=A0though.=C2=A0If=C2=A0the=C2=A0pcie-designware=C2=A0driver=
=C2=A0could=C2=A0somehow=C2=A0guarantee=C2=A0=0D=0A>=20that=C2=A0all=C2=A0e=
ndpoint=C2=A0functions=C2=A0present,=C2=A0or=C2=A0able=C2=A0to=C2=A0appear=
=C2=A0later,=C2=A0can=C2=A0handle=C2=A0=0D=0A>=20MSI=C2=A0addresses=C2=A0of=
=C2=A0some=C2=A0width=C2=A0>32,=C2=A0then=C2=A0it=C2=A0could=C2=A0set=C2=A0=
its=C2=A0DMA=C2=A0mask=C2=A0for=C2=A0the=C2=A0=0D=0A>=20fake=C2=A0DMA=C2=A0=
mapping=C2=A0accordingly,=C2=A0but=C2=A0that=C2=A0has=C2=A0nothing=C2=A0at=
=C2=A0all=C2=A0to=C2=A0do=C2=A0with=C2=A0how=C2=A0=0D=0A>=20many=C2=A0addre=
ss=C2=A0bits=C2=A0might=C2=A0happen=C2=A0to=C2=A0be=C2=A0wired=C2=A0up=C2=
=A0on=C2=A0the=C2=A0external=C2=A0AXI=C2=A0interface.=0D=0A>=20=0D=0A>=20Ro=
bin.=0D=0A=0D=0AHi,=0D=0AThank=20you=20for=20your=20review.=0D=0AIt=20is=20=
clear=20there=20is=20something=20we=20don't=20understand=20here,=0D=0AI'll=
=20return=20when=20we=20have=20done=20some=20more=20work=20in=20this.
