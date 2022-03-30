Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9A14EB911
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 05:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbiC3DyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 23:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiC3DyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 23:54:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0627657173
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 20:52:14 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220330035209epoutp03cc239e472adbcf59c0268431a04cc475~hDC3s4dVU0853908539epoutp03D
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 03:52:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220330035209epoutp03cc239e472adbcf59c0268431a04cc475~hDC3s4dVU0853908539epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648612330;
        bh=djGUbF+wvDXi6lW+luhmwwAWOcg3DG1EKXQy3c+XUts=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=tZJ9joUy9aRlQ55I8ABHLMQDm7mMY8ssjqVuWiZYoTaTqJ+VuFQlIpWt5eFv0F5MZ
         lSv8a3qGpNGKkv0uDu+QXdeGVG1e6CmAvsXYA6RfpX0To8coqHd0YBxCjMv40eBuLF
         dkG2M4h2puJMkDcxtNigzLPL5IEKOfWWPKt8Mu3c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220330035209epcas2p438e0ea0b23f93b91450f81f40b1f36aa~hDC3EC4n50926709267epcas2p4O;
        Wed, 30 Mar 2022 03:52:09 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KSsv75Pltz4x9Pp; Wed, 30 Mar
        2022 03:52:03 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-0b-6243d3e3b01d
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.9B.33036.3E3D3426; Wed, 30 Mar 2022 12:52:03 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask
 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220328143228.1902883-1-alexandr.lobakin@intel.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
Date:   Wed, 30 Mar 2022 12:52:03 +0900
X-CMS-MailID: 20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhe7jy85JBq+/a1j8/r2M0WJJU4bF
        y0OaFrvudrBbPD80i9lixZeZ7BafWlQtGnp+s1qcnXeczeLN7xfsFucWZ1r837OD3WLnnRPM
        Drwea+atYfS4vi7AY+esu+weCzaVeize85LJY9OqTjaPJ1emM3n0bVnF6LFl/2dGj8+b5AK4
        orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DuVlIo
        S8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZk
        Z1w5upytYJ53xbEV81gaGOd4djFyckgImEgcOfuSDcQWEtjBKHH8hkMXIwcHr4CgxN8dwiBh
        YQF/ic5zsxghSpQkdqyZxwwRt5b4NOUyC4jNJmApcbH1IViNiICRxLe2DrAaZoGZLBILuxUh
        VvFKzGh/ygJhS0tsX74VrJ5TwEli+udvzBBxDYkfy3qhbFGJm6vfssPY74/NZ4SwRSRa752F
        qhGUePBzN1RcSmLBk0OsEHa1xP6/v5kg7AZGif77qSBvSQjoS+y4bgwS5hXwldh4bQnYOSwC
        qhITexZDlbtITGifzARxvrbEsoWvmUFamQU0Jdbv0oeYoixx5BYLzFMNG3+zo7OZBfgkOg7/
        hYvvmPcEarqaxLyVO5knMCrPQgTzLCS7ZiHsWsDIvIpRLLWgODc9tdiowAQescn5uZsYwclX
        y2MH4+y3H/QOMTJxMB5ilOBgVhLh/XjQOUmINyWxsiq1KD++qDQntfgQoynQlxOZpUST84Hp
        P68k3tDE0sDEzMzQ3MjUwFxJnNcrZUOikEB6YklqdmpqQWoRTB8TB6dUA9Ouy4FzVh5jevCT
        4zXb9zfGO0WY9JQdnmmpx5uuNu/RnyMy7wT7558OF/gttvoUS79XMWxslv5xI2ajeufu/z5Z
        BsXzrCaI1KmkrlmS80qnurN9m1n39aM3g0KqHn0TafHKtFh39dDkuWs8z10SMFvUm234bffF
        rTdnqvq8fNmslK4l9IIt7+W89DaZrKq6pk3MX1/+NN2mHH+/xqy24dOxOcX/HUS1n+6cxXDu
        /8vvm2VjshaJtLFqZrnpBgi1PntTIHznS/lX/1n+hy8+ULUutPbWWmHK8vbmGSWHrdOUHl1Q
        nZd630jJ6NfcNO/eSY1Mp59MPaoV+axH5fW6xqvtcw6V/5tnEOBy1K/7eb0SS3FGoqEWc1Fx
        IgDxNXp+RwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5
References: <20220328143228.1902883-1-alexandr.lobakin@intel.com>
        <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
        <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Alexander Lobakin=C2=A0<alexandr.lobakin=40intel.com>=0D=0A>=20D=
ate=20:=202022-03-28=2023:34=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=
=5D=20PCI:=20dwc:=20Modify=20the=20check=20about=20MSI=20DMA=20mask=2032-bi=
t=0D=0A>=20=0D=0A>=20From:=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=A0<wangseok.=
lee=40samsung.com>=0D=0A>=20Date:=C2=A0Mon,=C2=A028=C2=A0Mar=C2=A02022=C2=
=A011:30:09=C2=A0+0900=0D=0A>=20=0D=0A>>=C2=A0If=C2=A0dma_mask=C2=A0is=C2=
=A0more=C2=A0than=C2=A032=C2=A0bits=C2=A0this=C2=A0will=C2=A0trigger=C2=A0a=
n=C2=A0error=C2=A0occurs=C2=A0when=0D=0A>>=C2=A0dma_map_single_attrs()=C2=
=A0is=C2=A0performed.=0D=0A>>=C2=A0=0D=0A>>=C2=A0dma_map_single_attrs()=C2=
=A0->=C2=A0dma_map_page_attrs()->=0D=0A>>=C2=A0error=C2=A0return=C2=A0in=C2=
=A0dma_direct_map_page().=0D=0A>>=C2=A0=0D=0A>>=C2=A0On=C2=A0ARTPEC-8,=C2=
=A0this=C2=A0fails=C2=A0with:=0D=0A>>=C2=A0artpec8-pcie=C2=A017200000.pcie:=
=C2=A0DMA=C2=A0addr=C2=A00x0000000106b052c8+2=C2=A0overflow=0D=0A>>=C2=A0(m=
ask=C2=A0ffffffff,=C2=A0bus=C2=A0limit=C2=A027fffffff)=0D=0A>=20=0D=0A>=20I=
sn't=C2=A0it=C2=A0a=C2=A0bug=C2=A0in=C2=A0the=C2=A0platform=C2=A0DMA=C2=A0c=
ode?=C2=A0dma_set_mask(32)=0D=0A>=20explicitly=C2=A0says=C2=A0that=C2=A0the=
=C2=A0system=C2=A0*must=C2=A0not*=C2=A0give=C2=A0DMA=C2=A0addresses=C2=A0wi=
der=0D=0A>=20than=C2=A032=C2=A0bits.=C2=A0If=C2=A0the=C2=A0system=C2=A0can'=
t=C2=A0satisfy=C2=A0this=C2=A0requirement,=C2=A0then=C2=A0it=0D=0A>=20shoul=
d=C2=A0return=C2=A0failure=C2=A0on=C2=A0dma_set_mask(32)=C2=A0--=C2=A0this=
=C2=A0way=C2=A0you=C2=A0will=C2=A0only=0D=0A>=20get=C2=A0the=C2=A0correspon=
ding=C2=A0warning,=C2=A0but=C2=A0there'll=C2=A0be=C2=A0no=C2=A0overflows=C2=
=A0(as=C2=A0the=0D=0A>=20mask=C2=A0will=C2=A0not=C2=A0be=C2=A0changed).=0D=
=0A>=20The=C2=A0idea=C2=A0of=C2=A0this=C2=A0call=C2=A0is=C2=A0to=C2=A0try=
=C2=A0to=C2=A0avoid=C2=A0getting=C2=A033+=C2=A0bit=C2=A0mappings=0D=0A>=20s=
o=C2=A0that=C2=A0PCI=C2=A0controllers=C2=A0which=C2=A0support=C2=A0only=C2=
=A032-bit=C2=A0masks=C2=A0could=C2=A0still=0D=0A>=20work=C2=A0correctly=C2=
=A0on=C2=A0the=C2=A064-bit=C2=A0systems.=C2=A0If=C2=A0the=C2=A0call=C2=A0fa=
ils,=C2=A0then=C2=A0this=0D=0A>=20message=C2=A0gets=C2=A0printed=C2=A0that=
=C2=A0you've=C2=A0been=C2=A0warned=C2=A0and=C2=A0it's=C2=A0your=0D=0A>=20re=
sponsibility=C2=A0to=C2=A0make=C2=A0sure=C2=A0that=C2=A0the=C2=A0controller=
=C2=A0won't=C2=A0get=C2=A0truncated=0D=0A>=20addresses.=C2=A0Having=C2=A0th=
e=C2=A0call=C2=A0succeeded=C2=A0and=C2=A0then=C2=A033+=C2=A0bit=C2=A0DMA=C2=
=A0addresses=0D=0A>=20is=C2=A0wrong.=0D=0A>=20=0D=0A>=20Please=C2=A0correct=
=C2=A0me=C2=A0if=C2=A0I'm=C2=A0wrong.=0D=0A>=20=0D=0A=0D=0AHello,=20Alexand=
er=20Lobakin=0D=0AThanks=20for=20your=20review.=0D=0A=0D=0AYou=20are=20righ=
t.=0D=0AMy=20concern=20is=20that=20case=20of=20trying=20to=20use=2033+bit=
=20dma=20mappings=20on=20=0D=0A64bit=20system.=0D=0AIt=20is=20about=20the=
=20call=20sequence=20of=20the=20functions=20related=20to=20dma=20=0D=0Asett=
ing,=20not=20the=20operation=20of=20the=20dma_set_mask()=20function.=0D=0AI=
f=20dma_set_mask(33+)=20is=20performed=20before=20dw_pcie_host_init()=0D=0A=
for=20using=2033+bit=20dma=20mapping,=20following=20error=20occurs=20=0D=0A=
in=20dma_map_single_attrs()=0D=0Aex)=20DMA=20addr=200x0000000106b052c8+2=20=
overflow=20=0D=0A=20=20=20(mask=20ffffffff,=20bus=20limit=2027fffffff)=0D=
=0Adma_set_mask(33+)=20->=20dw_pcie_host_init():=20dma_set_mask(32)=20->=0D=
=0Adma_map_single_attrs()=20->=20=0D=0Aerror=20return=20in=20dma_direct_map=
_page():=20=0D=0Abecause=20dma=20addr=20is=2033+=20but=20masking=20value=20=
is=2032=0D=0A=0D=0ASo=20if=20the=20user=20has=20already=20set=20dma_mask=20=
to=2033+=20in=20order=20to=20use=2033+,=0D=0Ai=20suggested=20to=20modify=20=
dma_set_mask(32)=20not=20to=20be=20called.=0D=0A=0D=0APlease=20let=20me=20k=
now=20your=20opinion.=0D=0A=0D=0AThank=20you.=0D=0A=0D=0A>>=C2=A0=0D=0A>>=
=C2=A0There=C2=A0is=C2=A0no=C2=A0sequence=C2=A0that=C2=A0re-sets=C2=A0dev->=
dma_mask=C2=A0to=C2=A0more=C2=A0than=C2=A032=C2=A0bits=0D=0A>>=C2=A0before=
=C2=A0call=C2=A0dma_map_single_attrs().=0D=0A>>=C2=A0The=C2=A0dev->dma_mask=
=C2=A0is=C2=A0first=C2=A0set=C2=A0just=C2=A0prior=C2=A0to=C2=A0the=C2=A0dw_=
pcie_host_init()=C2=A0call.=0D=0A>>=C2=A0Therefore,=C2=A0the=C2=A0check=C2=
=A0logic=C2=A0was=C2=A0modified=C2=A0to=C2=A0be=C2=A0performed=C2=A0only=C2=
=A0when=0D=0A>>=C2=A0the=C2=A0dev-dma_mask=C2=A0is=C2=A0not=C2=A0set=C2=A0l=
arger=C2=A0than=C2=A032=C2=A0bits.=0D=0A>>=C2=A0=0D=0A>>=C2=A0Always=C2=A0s=
etting=C2=A0dma_mask=C2=A0to=C2=A032=C2=A0bits=C2=A0is=C2=A0not=C2=A0always=
=C2=A0correct,=0D=0A>>=C2=A0for=C2=A0example=C2=A0the=C2=A0ARTPEC-8=C2=A0is=
=C2=A0an=C2=A0arm64=C2=A0platform,=C2=A0and=C2=A0can=C2=A0access=0D=0A>>=C2=
=A0more=C2=A0than=C2=A032=C2=A0bits=0D=0A>>=C2=A0=0D=0A>>=C2=A0Signed-off-b=
y:=C2=A0Wangseok=C2=A0Lee=C2=A0<wangseok.lee=40samsung.com>=0D=0A>>=C2=A0--=
-=0D=0A>>=C2=A0=C2=A0drivers/pci/controller/dwc/pcie-designware-host.c=C2=
=A0=7C=C2=A08=C2=A0+++++---=0D=0A>>=C2=A0=C2=A01=C2=A0file=C2=A0changed,=C2=
=A05=C2=A0insertions(+),=C2=A03=C2=A0deletions(-)=0D=0A>>=C2=A0=0D=0A>>=C2=
=A0diff=C2=A0--git=C2=A0a/drivers/pci/controller/dwc/pcie-designware-host.c=
=C2=A0b/drivers/pci/controller/dwc/pcie-designware-host.c=0D=0A>>=C2=A0inde=
x=C2=A02fa86f3..7e25958=C2=A0100644=0D=0A>>=C2=A0---=C2=A0a/drivers/pci/con=
troller/dwc/pcie-designware-host.c=0D=0A>>=C2=A0+++=C2=A0b/drivers/pci/cont=
roller/dwc/pcie-designware-host.c=0D=0A>>=C2=A0=40=40=C2=A0-388,9=C2=A0+388=
,11=C2=A0=40=40=C2=A0int=C2=A0dw_pcie_host_init(struct=C2=A0pcie_port=C2=A0=
*pp)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0dw_chained_msi_isr,=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pp);=0D=0A>>=C2=A0=C2=A0=0D=0A>>=C2=A0-=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=C2=A0=
=3D=C2=A0dma_set_mask(pci->dev,=C2=A0DMA_BIT_MASK(32));=0D=0A>>=C2=A0-=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=
ret)=0D=0A>>=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_warn(pci=
->dev,=C2=A0=22Failed=C2=A0to=C2=A0set=C2=A0DMA=C2=A0mask=C2=A0to=C2=A032-b=
it.=C2=A0Devices=C2=A0with=C2=A0only=C2=A032-bit=C2=A0MSI=C2=A0support=C2=
=A0may=C2=A0not=C2=A0work=C2=A0properly>=5Cn=22);=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21(*d=
ev->dma_mask=C2=A0&=C2=A0=C2=A0=7E(GENMASK(31,=C2=A00))))=C2=A0=7B=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=C2=A0=3D=C2=A0dma_se=
t_mask(pci->dev,=C2=A0DMA_BIT_MASK(32));=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=
=C2=A0(ret)=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0dev_warn(pci->dev,=C2=A0=22Failed=C2=A0to=C2=A0set=C2=A0DMA=
=C2=A0mask=C2=A0to=C2=A032-bit.=C2=A0Devices=C2=A0with=C2=A0only=C2=A032-bi=
t=C2=A0MSI=C2=A0support=C2=A0may=C2=A0not=C2=A0work=C2=A0properly=5Cn=22);=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=7D=0D=0A>>=C2=A0=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pp->msi_data=C2=A0=3D=C2=A0=
dma_map_single_attrs(pci->dev,=C2=A0&pp->msi_msg,=0D=0A>>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0sizeof(pp->msi_msg),=0D=0A>>=C2=A0--=C2=A0=0D=0A>>=C2=A02=
.9.5=0D=0A>=20=0D=0A>=20Thanks,=0D=0A>=20Al
