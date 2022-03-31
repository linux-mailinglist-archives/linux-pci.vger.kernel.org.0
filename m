Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262044ED342
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 07:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCaFgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 01:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCaFgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 01:36:22 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FFAE7
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 22:34:32 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220331053429epoutp0227977d7d7bb4f95f4b53d90133e6d2c6~hYFgGDZEY2904529045epoutp02M
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 05:34:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220331053429epoutp0227977d7d7bb4f95f4b53d90133e6d2c6~hYFgGDZEY2904529045epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648704869;
        bh=Y2A86zVPduCgbxjCyMQPMIajGWW3pJUmYPn7yVoPpBA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uoOqroM/6pE0N9JpVhyE2VmZUaztgPCsIp4LHO/n4gRpGTxAtKfmkbStz6th9uAp8
         1ieZBNWPHv8lrNliAd3hY+KLIPhuN433PuZ2b/JDb8MkEa30OTGdy88pbuotqB/Jdl
         lrg1XZG+k68rB10fH7oNCTNXz+HgOw0BgxE8vOaQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220331053428epcas2p2e9b4477d01da9f7ae1e86739ee1441ce~hYFexKYBs2983729837epcas2p2O;
        Thu, 31 Mar 2022 05:34:28 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KTX6m00NHz4x9Qr; Thu, 31 Mar
        2022 05:34:24 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-ca-62453d5ef273
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.6C.25540.E5D35426; Thu, 31 Mar 2022 14:34:22 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
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
In-Reply-To: <YkR7G/V8E+NKBA2h@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
Date:   Thu, 31 Mar 2022 14:34:22 +0900
X-CMS-MailID: 20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmuW6crWuSQcM0MYvfv5cxWixpyrB4
        eUjTYtfdDnaL0xMWMVk8PzSL2WLFl5nsFp9aVC0aen6zWpydd5zN4s3vF+wW5xZnWvzfs4Pd
        YuedE8wOfB5r5q1h9Li+LsBj56y77B4LNpV6bF6h5bF4z0smj02rOtk8nlyZzuTRt2UVo8eW
        /Z8ZPT5vkgvgjsq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ
        0HXLzAF6QEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1pi
        ZWhgYGQKVJiQnTF31gu2gi2iFUceT2JrYHwi0sXIySEhYCLx9dsN1i5GLg4hgR2MEld/7AJy
        ODh4BQQl/u4QBqkRFvCU2LVnHxuILSSgJLFjzTxmiLi1xKcpl1lAbDYBS4mLrQ8ZQWwRgWiJ
        tY82g8WZBWaySCzsVoTYxSsxo/0pC4QtLbF9+VZGkFWcAroSPUf8IcIaEj+W9TJD2KISN1e/
        ZYex3x+bzwhhi0i03jsLVSMo8eDnbqi4lMSCJ4dYIexqif1/fzNB2A2MEv33U0FWSQjoS+y4
        bgzxoK/EtP2FIBUsAqoSu6a8gjrMRWLC2b3MEMdrSyxb+JoZpJxZQFNi/S59iCHKEkduscC8
        1LDxNzs6m1mAT6Lj8F+4+I55T6BuUZOYt3In8wRG5VmIQJ6FZNcshF0LGJlXMYqlFhTnpqcW
        GxUYw+M1OT93EyM4GWu572Cc8faD3iFGJg7GQ4wSHMxKIrwfDzonCfGmJFZWpRblxxeV5qQW
        H2I0BfpyIrOUaHI+MB/klcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+Lg
        lGpgWr/X88nJqUpPBRdUlcxbwT59jev9zflsDiWiRRq/dxl+m6A1lSOrRrSA93j/pMlfr2/P
        u5FS/H2lW/a+kIjDVqvLxD+9izb8lWGy+5n7vPqKIg7F2IrdTR962FnmaJ9+ulLsTE/LmtBL
        /yedi32ZtFfzo1GuyZyg2ms7H7+wnm1W/uDxAx3bt5O1Fv///mjLusD8og4xphrvCdPkV4r4
        O/2W/3NY4vHJ1raOwv9vJCb858w1XV6mcjfnbMee1Cv/9G/2N+xVlOHJWvhsYZdcm9HzrFWG
        LrpTDaN10hc8FDFQebOs5MnWybzbhBj28Fzv3SF2vOUcQ36w6mM5SdWlaqLHthsyHOD7YFxb
        fvicpBJLcUaioRZzUXEiAOXIOZNPBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5
References: <YkR7G/V8E+NKBA2h@infradead.org>
        <20220328143228.1902883-1-alexandr.lobakin@intel.com>
        <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
        <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
        <20220330093526.2728238-1-alexandr.lobakin@intel.com>
        <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Christoph Hellwig=C2=A0<hch=40infradead.org>=0D=0A>=20Date=20:=
=202022-03-31=2000:45=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=5D=20PC=
I:=20dwc:=20Modify=20the=20check=20about=20MSI=20DMA=20mask=2032-bit=0D=0A>=
=20=0D=0A>=20On=C2=A0Wed,=C2=A0Mar=C2=A030,=C2=A02022=C2=A0at=C2=A011:35:26=
AM=C2=A0+0200,=C2=A0Alexander=C2=A0Lobakin=C2=A0wrote:=0D=0A>>=C2=A0I'm=C2=
=A0not=C2=A0super=C2=A0familiar=C2=A0with=C2=A0the=C2=A0DMA=C2=A0internals,=
=C2=A0so=C2=A0adding=C2=A0Chris=C2=A0here,=0D=0A>>=C2=A0maybe=C2=A0he'd=C2=
=A0like=C2=A0to=C2=A0comment,=C2=A0but=C2=A0anyway,=C2=A0the=C2=A0lower/arc=
h=C2=A0layer=C2=A0must=0D=0A>>=C2=A0not=C2=A0give=C2=A0the=C2=A0DMA=C2=A0ad=
dresses=C2=A0wider=C2=A0than=C2=A0the=C2=A0number=C2=A0of=C2=A0bits=C2=A0pa=
ssed=C2=A0to=0D=0A>>=C2=A0dma_set_mask()=C2=A0if=C2=A0that=C2=A0call=C2=A0r=
eturned=C2=A00.=0D=0A>=20=0D=0A>=20So,=C2=A0the=C2=A0basic=C2=A0assumption=
=C2=A0in=C2=A0the=C2=A0kernel=C2=A0is=C2=A0that=C2=A032-bit=C2=A0DMA=C2=A0i=
s=C2=A0always=0D=0A>=20supported,=C2=A0and=C2=A0dma_set_maks=C2=A0for=C2=A0=
that=C2=A0should=C2=A0not=C2=A0fail.=C2=A0=C2=A0If=C2=A0the=0D=0A>=20system=
=C2=A0(or=C2=A0root=C2=A0port,=C2=A0internal=C2=A0interconnect)=C2=A0suppor=
ts=C2=A0less=C2=A0than=C2=A0that=0D=0A>=20we'll=C2=A0bounce=C2=A0buffer.=C2=
=A0=C2=A0But=C2=A0how=C2=A0and=C2=A0why=C2=A0would=C2=A0you=C2=A0hand=C2=A0=
out=C2=A0addresses=0D=0A>=20larger=C2=A0than=C2=A0that?=C2=A0=C2=A0It=C2=A0=
really=C2=A0is=C2=A0not=C2=A0valid,=C2=A0but=C2=A0I=C2=A0can't=C2=A0even=C2=
=A0see=C2=A0how=0D=0A>=20it=C2=A0could=C2=A0happen.=0D=0A=0D=0AHello,=0D=0A=
thank=20you=20for=20your=20review.=0D=0A=0D=0AYes,=20the=20dma=20address=20=
should=20not=20be=20used=20in=20excess=20of=20the=20mask=20value=0D=0Aset=
=20through=20dma_set_mask().=0D=0A=0D=0AIf=20I=20want=20to=20use=2033+bit=
=20dma=20address=20on=2064bit=20system,=20I=20have=20to=20call=0D=0Adma_set=
_mask(33+)=20again=20after=20below=20code=20in=20dw_pcie_host_init()=20is=
=0D=0Aperformed.=0D=0AThis=20is=20because=20dw_pcie_host_init(32)=20is=20al=
ways=20called=20in=20=0D=0Adw_pcie_host_init()=20without=20any=20conditions=
.=0D=0AIs=20this=20right?=0D=0A=0D=0AAlso,=20if=20I=20assign=2033+bit=20dma=
=20address=20before=20dw_pcie_host_init()=20to=20=0D=0Ause=2033+bit=20dma=
=20address=20on=2064bit=20system,=20dma_set_mask(32)=20is=20called=20=0D=0A=
and=20dma_mask=20is=20changed=20to=2032=20but=20dma=20address=20is=20mainta=
ined=2033+,=0D=0Aso=20error=20occurs.=0D=0Ait=20is=20not=20a=20issue=20with=
=20the=20dma_set_mask()=20function,=20but=20the=20=0D=0Acalled=20condition=
=20must=20need=20to=20be=20modified.=0D=0A=0D=0AThank=20you.
