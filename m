Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813D74F8CBF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 05:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiDHCgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiDHCgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 22:36:18 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7D8100E31
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 19:34:14 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220408023406epoutp0431ee21a093fae5ea89ad8adf0407bddf~jyySNThiv2480224802epoutp04Q
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 02:34:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220408023406epoutp0431ee21a093fae5ea89ad8adf0407bddf~jyySNThiv2480224802epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649385246;
        bh=PmWKaHNzxX2YvMkAn2cd0Om604GhbIZN3gNtEjRgCGE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=CmWnvm1Wb/X7PaEWvzoDr50KbzIoNvrpIiqF8wun0nahZB+sJcYHBynux5vuKuM4F
         r/WQVEO2JRzEVNrPaBCypdM+UZ58xdTo8fse6GAraOxjqfAAQKRe2TZLbDbDeWkh8F
         yL0MNsxpxyAqu9wNzk0F4D75GoN/bJm6kyNaOsmc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220408023405epcas2p1d21a9f74d143517f53958c8ab1649ba5~jyyRcOD-p3161531615epcas2p1D;
        Fri,  8 Apr 2022 02:34:05 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KZMky0CbDz4x9QH; Fri,  8 Apr
        2022 02:34:02 +0000 (GMT)
X-AuditID: b6c32a48-9b7ff7000000f26c-98-624f9f19ea02
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.2B.62060.91F9F426; Fri,  8 Apr 2022 11:34:01 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
Date:   Fri, 08 Apr 2022 11:34:01 +0900
X-CMS-MailID: 20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmqa7kfP8kg1XTLC1+/17GaLGkKcPi
        5SFNi113O9gtTk9YxGTx/NAsZosVX2ayW3xqUbVo6PnNanF23nE2ize/X7BbnFucafF/zw52
        i513TjA78HmsmbeG0eP6ugCPnbPusnss2FTqsXmFlsfiPS+ZPDat6mTzeHJlOpNH35ZVjB5b
        9n9m9Pi8SS6AOyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUn
        QNctMwfoASWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJ
        laGBgZEpUGFCdsbGTbfZCjbKVXx+0MPcwLhStouRk0NCwERiRt9eti5GLg4hgR2MEpf332Hu
        YuTg4BUQlPi7QxikRljAU2LXnn1sILaQgJLEjjXzmCHi+hLXV3SzgthsAroS/xa/BJsjInCW
        UeLRnqeMIA6zwDRmif5Ln1khtvFKzGh/ygJhS0tsX76VEWQZp4CfxMopuRBhDYkfy3qZIWxR
        iZur37LD2O+PzWeEsEUkWu+dhaoRlHjwczdUXEpiwZNDUKuqJfb//c0EYTcwSvTfTwVZJQF0
        9I7rxiBhXgFfiaVzVoOVsAioSjxpnAdV7iLR8PgI2L/MAtoSyxa+BgcJs4CmxPpd+hBTlCWO
        3GKB+alh4292dDazAJ9Ex+G/cPEd855ATVeTmLdyJ/MERuVZiHCehWTXLIRdCxiZVzGKpRYU
        56anFhsVmMCjNjk/dxMjOCVreexgnP32g94hRiYOxkOMEhzMSiK8Vbk+SUK8KYmVValF+fFF
        pTmpxYcYTYG+nMgsJZqcD8wKeSXxhiaWBiZmZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg
        +pg4OKUamBKv88hVpLYVz/0XkDDtwnMntU6ZU5LHmB7ciLWqtq7jS/jgyc8beri89cCyl0Lv
        BXhmNPSZFFl/v6ysaX6AV9hiWVr/qaLft1hMheYLz50tuGjnhcINN1mYCs5lZpx42GxVoKHB
        67VDdf4Jt9q/uxcUF36xVu/ZLxYof9T/8rLaJAE22RshwR0ef0I/bLHUVt8Rcpz5v5Wu84bN
        NZlzFh+8+3rOns0srx3Wn+X2nDlv04rYt0lqvy/tcmORfd4i6c92+HPIoVUrrQ9WlIgdnqfS
        GBq5aXWu3Xmj0/GdxR9nswbbeajrd7ioc0dNvet/TYMjYrmf+OT8rg8shtMmfXzwtrepf4l8
        yt74pEUdSizFGYmGWsxFxYkA0LJArlIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5
References: <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
        <YkR7G/V8E+NKBA2h@infradead.org>
        <20220328143228.1902883-1-alexandr.lobakin@intel.com>
        <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
        <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
        <20220330093526.2728238-1-alexandr.lobakin@intel.com>
        <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Could you please review this patch in the context of the following patch?

https://patchwork.ozlabs.org/project/linux-pci/patch/20220328023009epcms2p3=
09a5dfc2ff29d0a9945f65799963193c=40epcms2p3/

Thnak you.
> --------- Original Message ---------
> Sender : Wangseok Lee <wangseok.lee=40samsung.com>Foundry Design Service=
=ED=8C=80(Foundry)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>=20Date=20:=
=202022-03-31=2014:34=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=5D=20PC=
I:=20dwc:=20Modify=20the=20check=20about=20MSI=20DMA=20mask=2032-bit=0D=0A>=
=20=0D=0A>>=C2=A0---------=C2=A0Original=C2=A0Message=C2=A0---------=0D=0A>=
>=C2=A0Sender=C2=A0:=C2=A0Christoph=C2=A0Hellwig=C2=A0<hch=40infradead.org>=
=0D=0A>>=C2=A0Date=C2=A0:=C2=A02022-03-31=C2=A000:45=C2=A0(GMT+9)=0D=0A>>=
=C2=A0Title=C2=A0:=C2=A0Re:=C2=A0=5BPATCH=5D=C2=A0PCI:=C2=A0dwc:=C2=A0Modif=
y=C2=A0the=C2=A0check=C2=A0about=C2=A0MSI=C2=A0DMA=C2=A0mask=C2=A032-bit=0D=
=0A>>=C2=A0=0D=0A>>=C2=A0On=C2=A0Wed,=C2=A0Mar=C2=A030,=C2=A02022=C2=A0at=
=C2=A011:35:26AM=C2=A0+0200,=C2=A0Alexander=C2=A0Lobakin=C2=A0wrote:=0D=0A>=
>>=C2=A0I'm=C2=A0not=C2=A0super=C2=A0familiar=C2=A0with=C2=A0the=C2=A0DMA=
=C2=A0internals,=C2=A0so=C2=A0adding=C2=A0Chris=C2=A0here,=0D=0A>>>=C2=A0ma=
ybe=C2=A0he'd=C2=A0like=C2=A0to=C2=A0comment,=C2=A0but=C2=A0anyway,=C2=A0th=
e=C2=A0lower/arch=C2=A0layer=C2=A0must=0D=0A>>>=C2=A0not=C2=A0give=C2=A0the=
=C2=A0DMA=C2=A0addresses=C2=A0wider=C2=A0than=C2=A0the=C2=A0number=C2=A0of=
=C2=A0bits=C2=A0passed=C2=A0to=0D=0A>>>=C2=A0dma_set_mask()=C2=A0if=C2=A0th=
at=C2=A0call=C2=A0returned=C2=A00.=0D=0A>>=C2=A0=0D=0A>>=C2=A0So,=C2=A0the=
=C2=A0basic=C2=A0assumption=C2=A0in=C2=A0the=C2=A0kernel=C2=A0is=C2=A0that=
=C2=A032-bit=C2=A0DMA=C2=A0is=C2=A0always=0D=0A>>=C2=A0supported,=C2=A0and=
=C2=A0dma_set_maks=C2=A0for=C2=A0that=C2=A0should=C2=A0not=C2=A0fail.=C2=A0=
=C2=A0If=C2=A0the=0D=0A>>=C2=A0system=C2=A0(or=C2=A0root=C2=A0port,=C2=A0in=
ternal=C2=A0interconnect)=C2=A0supports=C2=A0less=C2=A0than=C2=A0that=0D=0A=
>>=C2=A0we'll=C2=A0bounce=C2=A0buffer.=C2=A0=C2=A0But=C2=A0how=C2=A0and=C2=
=A0why=C2=A0would=C2=A0you=C2=A0hand=C2=A0out=C2=A0addresses=0D=0A>>=C2=A0l=
arger=C2=A0than=C2=A0that?=C2=A0=C2=A0It=C2=A0really=C2=A0is=C2=A0not=C2=A0=
valid,=C2=A0but=C2=A0I=C2=A0can't=C2=A0even=C2=A0see=C2=A0how=0D=0A>>=C2=A0=
it=C2=A0could=C2=A0happen.=0D=0A>=20=0D=0A>=20Hello,=0D=0A>=20thank=C2=A0yo=
u=C2=A0for=C2=A0your=C2=A0review.=0D=0A>=20=0D=0A>=20Yes,=C2=A0the=C2=A0dma=
=C2=A0address=C2=A0should=C2=A0not=C2=A0be=C2=A0used=C2=A0in=C2=A0excess=C2=
=A0of=C2=A0the=C2=A0mask=C2=A0value=0D=0A>=20set=C2=A0through=C2=A0dma_set_=
mask().=0D=0A>=20=0D=0A>=20If=C2=A0I=C2=A0want=C2=A0to=C2=A0use=C2=A033+bit=
=C2=A0dma=C2=A0address=C2=A0on=C2=A064bit=C2=A0system,=C2=A0I=C2=A0have=C2=
=A0to=C2=A0call=0D=0A>=20dma_set_mask(33+)=C2=A0again=C2=A0after=C2=A0below=
=C2=A0code=C2=A0in=C2=A0dw_pcie_host_init()=C2=A0is=0D=0A>=20performed.=0D=
=0A>=20This=C2=A0is=C2=A0because=C2=A0dw_pcie_host_init(32)=C2=A0is=C2=A0al=
ways=C2=A0called=C2=A0in=C2=A0=0D=0A>=20dw_pcie_host_init()=C2=A0without=C2=
=A0any=C2=A0conditions.=0D=0A>=20Is=C2=A0this=C2=A0right?=0D=0A>=20=0D=0A>=
=20Also,=C2=A0if=C2=A0I=C2=A0assign=C2=A033+bit=C2=A0dma=C2=A0address=C2=A0=
before=C2=A0dw_pcie_host_init()=C2=A0to=C2=A0=0D=0A>=20use=C2=A033+bit=C2=
=A0dma=C2=A0address=C2=A0on=C2=A064bit=C2=A0system,=C2=A0dma_set_mask(32)=
=C2=A0is=C2=A0called=C2=A0=0D=0A>=20and=C2=A0dma_mask=C2=A0is=C2=A0changed=
=C2=A0to=C2=A032=C2=A0but=C2=A0dma=C2=A0address=C2=A0is=C2=A0maintained=C2=
=A033+,=0D=0A>=20so=C2=A0error=C2=A0occurs.=0D=0A>=20it=C2=A0is=C2=A0not=C2=
=A0a=C2=A0issue=C2=A0with=C2=A0the=C2=A0dma_set_mask()=C2=A0function,=C2=A0=
but=C2=A0the=C2=A0=0D=0A>=20called=C2=A0condition=C2=A0must=C2=A0need=C2=A0=
to=C2=A0be=C2=A0modified.=0D=0A>=20=0D=0A>=20Thank=C2=A0you.
