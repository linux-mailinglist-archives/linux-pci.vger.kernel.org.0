Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B936A8241
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 13:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCBMcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Mar 2023 07:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCBMcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Mar 2023 07:32:14 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C246188
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 04:32:11 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230302123209epoutp02824bf6a30a7d7f1f5096475b1cb256d8~ImiFqSpJ_1360813608epoutp02v
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 12:32:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230302123209epoutp02824bf6a30a7d7f1f5096475b1cb256d8~ImiFqSpJ_1360813608epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677760329;
        bh=w8lus32mfN0JsldgiFkE/jaxZOJ68qTXGqyvtoCNxcQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ILrvpVMk1jGLtCouwmbaSGz0PgiJH7peL4HRfpDsRvMb8MrI92E/vf3j/6i5EJ7YW
         qRcLv67yG4I2uXNJwB+INrihOZU3cxNTLQk547gaO6sh394k2QJlyUKHbRPRjLPAwD
         UoqrmFTppF7Vx9LdzBPkdNLNT5umG7ArcfrjE6uk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230302123208epcas5p4a38a06d8833ecace1c6eb7cec280b060~ImiFGeMQN1989019890epcas5p4P;
        Thu,  2 Mar 2023 12:32:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PS9Tg4sRVz4x9Pr; Thu,  2 Mar
        2023 12:32:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.02.10528.74790046; Thu,  2 Mar 2023 21:32:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302123207epcas5p3b89e4e110aaf44961fabed425666503c~ImiDVctGY1454014540epcas5p3V;
        Thu,  2 Mar 2023 12:32:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302123206epsmtrp2660aad4ee146a31982a2ecacd41652fc~ImiDUeGRw2648826488epsmtrp2B;
        Thu,  2 Mar 2023 12:32:06 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-48-64009747c4b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.23.18071.64790046; Thu,  2 Mar 2023 21:32:06 +0900 (KST)
Received: from pankajdubey02 (unknown [107.122.12.6]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302123202epsmtip200d1dfcf9283d65f0b5c1ec163b7fe7c~Imh-emAVy2740827408epsmtip2K;
        Thu,  2 Mar 2023 12:32:02 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Shradha Todi'" <shradha.t@samsung.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <alim.akhtar@samsung.com>,
        <jingoohan1@gmail.com>, <Sergey.Semin@baikalelectronics.ru>,
        <lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
        <tglx@linutronix.de>, <m.szyprowski@samsung.com>,
        <jh80.chung@samsung.co>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <a4bfad9d-b9df-28a5-6bee-5cbbca4dd23f@linaro.org>
Subject: RE: [PATCH 08/16] PCI: samsung: Rename exynos_pcie to samsung_pcie
Date:   Thu, 2 Mar 2023 18:02:01 +0530
Message-ID: <146301d94d03$002ba040$0082e0c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwF30rWoAbvCRL0BoFQ7lK7vreOg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRTm3tveFmbZXQfhHZkGb2ACE2gnLS8GcFFgl4xMki3OLGbdDb2h
        CP1Ib9nUudmxMjoEHKJWuoF8jM0RRCiMIB9K+LRGO3GDpQEiIJsIiCsQGCuKpWXKv+ec8zzv
        Oc95c/iY0IkH8jNVOkarorNJ3IfT2hsWGnHI5CUXWceC4URFKw6v5yrgF302LjS3liPQ4bRx
        4JfLZTxYPDOJwa652zyoL3RyoeW3ES68234Nhz9VDOLw8zvfotCwbuBAQ38+B37VN86DG51t
        PLhuesSBRb3nYLPlU+ygHzVvWeVR35jHeVSlJYey1F3GqbGRTpxasNl41PQ9E0o1X/+Aalpo
        Q6lqvQOnilvqEGrJ8lzaMyey4hQMLWe0QYwqXS3PVGXEk4ePyl6TSaQicYQ4FsaQQSpaycST
        ialpEcmZ2S6bZNBpOjvHlUqjWZaMSojTqnN0TJBCzeriSUYjz9ZEayJZWsnmqDIiVYzuZbFI
        dEDiIp7KUhiMy6imPPCd1plqVI84/QsQbz4gosF9Wx5vEwuJDgSU/BlegPi48CIC7pQacU+w
        ggCT7Tv0qaJ+wMD1FLoQMNTUsBXMIqDqV6ObhRNRwPa4wl3wI7oxMPlzrTvAiAYETFcVuVne
        RAIwPel0d99NHAb1F0rceQ4RDG5/f9edFxCxYLQ/H/XgXcBaNs3ZxBixH9yomsM8MwWBtQc3
        uJvYj0gGD0bWMA8nAPzR38fbbAyIm96g9EklxyNIBEOL17bwbjA72MLz4ECwtNDlcs134VRQ
        20F50jrQWFi7RX8FdN/blPJd74eBr9ujPK18QZFzGvUoBcB4Sehh7wOrv/+4NeVeMHmxdmuL
        FFiz25EryPPmbcbM24yZtxkw/9+sEuHUIXsYDavMYFiJRqxizvz34elqpQVxX0F4ShsyPvEo
        sgdB+UgPAvgY6Sc4q/eSCwVy+t33GK1aps3JZtgeROLadgkW6J+udp2RSicTR8eKoqVSaXTs
        S1IxGSB4Id6aLiQyaB2TxTAaRvtUh/K9A/VoY9Vqg+7qxsf2tYYW/sgpc33+27Ps1bOHlHMK
        x9HURE1AyT/OsiufdF8eOFIwEUc/q5182H7emuBPDsZ14sKOWztObNioopi6nvjclcr8QkIw
        bHp4Plz0/hm7LxuSR/vURIyWH9kply3K8oZSakLWq+3DO41EwK6p4c7QGfh3aVxz4hv3jwdP
        xQzcvCDlii9V/hJm3vP6yl8S6b7RNCzkQ4VEU+twznclpfIz845VzYvKkt5cb60RGH+IMXL3
        m5tIuxfh+3jHApI3FhH72VT5yRXHR8OLdHLS3tyoV0mrkg47ji7PZbTdMpQes1480LvQ/eJS
        Y2jy6ZMH9efeSqkrJjmsghaHY1qW/heSRlKHjgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSvK7bdIYUg03njC0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLbY+3oru0VDz29Wi02Pr7FaXN41h83i7LzjbBYz
        zu9jsmj508Ji0XK0ncVi7ZG77Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBknlnxiL9grWXFv2hT2BsbZol2MnBwSAiYSa461sILYQgK7GSXaJlhCxGUk
        Jq9ewQphC0us/PecvYuRC6jmBaPE+Z6D7CAJNgF9iXM/5rGCJEQELjBLPD93mgXEYRbYxCjx
        edlaZoiW14wSl57cZQJp4RSwk5j+aw9Yu7CAt8SaxolgcRYBFYmtJy6DxXkFLCVuH21ngrAF
        JU7OfMICYjMLaEv0PmxlhLGXLXzNDHGfgsTPp8vAbhURcJN4eu0nM0SNuMTLo0fYJzAKz0Iy
        ahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzglKCluYNx+6oP
        eocYmTgYDzFKcDArifBWNzCkCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1
        tSC1CCbLxMEp1cC0wqrYWT3O/PvV9OYtRzyFBfVq+BpXH7wYomm/5s9W5ghRz9WJxxgUNTZ+
        uLqtw3yd8cOHr++t/PwlpXjzH83Nb3k+8nsJxwv+5+Xbl5/3WZZP7/lTZvGUfFsbu/9NQq2J
        5y5YfRdR7BQ7mB3oUd/1Z83eXes0Fl/rDIvbFsCeNlOwLNCVOU60cKGz7af+W5ddFvxnXLO2
        IeeYoVql5+di086S3S03jrC+0JVNXbN4723L5h95iYab7Hhe8LAq8JU3Kt/7Ozm8c1vCchmZ
        LS2fI5SSDvz5t8puQ8T19yHhv7cdn/y3QWlr8s58ftElU57fs7T/oTUl00Ht5rz9LpMdTdyD
        U89O59m9c+2/WylKLMUZiYZazEXFiQBcTG9SeAMAAA==
X-CMS-MailID: 20230302123207epcas5p3b89e4e110aaf44961fabed425666503c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121436epcas5p1641de02220bea5edb23bc875b6311270
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121436epcas5p1641de02220bea5edb23bc875b6311270@epcas5p1.samsung.com>
        <20230214121333.1837-9-shradha.t@samsung.com>
        <a4bfad9d-b9df-28a5-6bee-5cbbca4dd23f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Thursday, February 16, 2023 4:37 PM
> To: Shradha Todi <shradha.t=40samsung.com>; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com;
> krzysztof.kozlowski+dt=40linaro.org; alim.akhtar=40samsung.com;
> jingoohan1=40gmail.com; Sergey.Semin=40baikalelectronics.ru;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com; tglx=40linutronix.de;
> m.szyprowski=40samsung.com; jh80.chung=40samsung.co;
> pankaj.dubey=40samsung.com
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org; linux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 08/16=5D PCI: samsung: Rename exynos_pcie to
> samsung_pcie
>=20
> On 14/02/2023 13:13, Shradha Todi wrote:
> > The platform specific structure being used is named exynos_pcie.
> > Changing it to samsung_pcie for making it generic.
> >
> > Suggested-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pci-samsung.c =7C 190
> > +++++++++++------------
> >  1 file changed, 95 insertions(+), 95 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-samsung.c
> > b/drivers/pci/controller/dwc/pci-samsung.c
> > index d5adf1017a05..be0177fcd763 100644
> > --- a/drivers/pci/controller/dwc/pci-samsung.c
> > +++ b/drivers/pci/controller/dwc/pci-samsung.c
> > =40=40 -23,7 +23,7 =40=40
> >
> >  =23include =22pcie-designware.h=22
> >
> > -=23define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
> > +=23define to_samsung_pcie(x)	dev_get_drvdata((x)->dev)
> >
> >  /* PCIe APPL registers */
> >  =23define EXYNOS_PCIE_IRQ_PULSE			0x000
> > =40=40 -51,7 +51,7 =40=40
> >  =23define EXYNOS_PCIE_APPL_SLV_ARMISC		0x120
> >  =23define EXYNOS_PCIE_APPL_SLV_DBI_ENABLE	BIT(21)
> >
> > -struct exynos_pcie =7B
> > +struct samsung_pcie =7B
>=20
> No, I don't see benefit of this at all. How we call stuff inside driver i=
s not related
> whether this is for Tesla or Exynos. We could even call it =22pony=22. :)=
 Thus
> renamings just to support new variant of Samsung device is not a good rea=
son.
>=20
Whole intention of this whole series was to make exynos-pcie driver to supp=
ort for all Samsung manufactured SoCs be it Exynos series or custom ASIC su=
ch as fsd, artpect-v8.=20

While doing so, we feel for better readability and conveying better names f=
or files, structs, internal APIs will help developers for understanding and=
 reusing it. For example we know that clock initialization will remain comm=
on (thanks for bulk_clk_xxx APIs) so we kept APIs for handling clocks start=
ing with samsung_clk_xxxx, but if we have to implement two variant of APIs,=
 or struct targeting different platforms it would be good if they have plat=
form specific prefixes. This will help in grep or future code maintenance.=
=20

Though technically all these can be done even without renaming, but if we s=
ee no impact as such, so why not use better names?
> Unless all of the old =22exynos=22 names will be soon needed for some exy=
nos-
> specific variants?
>=20

No we don't have any such plans.

> Best regards,
> Krzysztof


