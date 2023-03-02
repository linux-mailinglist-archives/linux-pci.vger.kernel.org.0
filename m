Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFDF6A90F1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCCGZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCCGYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:24:53 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9222532AB
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:24:35 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230303062434epoutp0491fdcd7b791ccc5b070463151c15b183~I1KbNH8HH2660026600epoutp04R
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:24:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230303062434epoutp0491fdcd7b791ccc5b070463151c15b183~I1KbNH8HH2660026600epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824674;
        bh=kCLpHIp2ntYhZFS19/Ya7xmXMkiKDjN/RLKPx18wKEE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=r9NapoPNKgBys4MIQ5qYvi7Oo8TU6Tj6tmIo3lcAlnorkn2BNqoR352ZOawA/JIs/
         MNs6+6MSRH+Xl6OIJHTM2oIsFTeu1feKjpa1+vPrWmd9EEqrL4n22qSk9mPpsjlmn4
         PTu6vMj8seE//eTIMC13FCO4pBIhP7yMRbY7eUBo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230303062432epcas5p4f1ac505a3ffa99eafae7ff35e7f0e525~I1KaCfHI13000030000epcas5p4x;
        Fri,  3 Mar 2023 06:24:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PSdH33q9Jz4x9QG; Fri,  3 Mar
        2023 06:24:31 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.46.06765.F9291046; Fri,  3 Mar 2023 15:24:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230302125756epcas5p22ab3819f5605a34e3953301f24f39161~Im4mdN-lg1272612726epcas5p26;
        Thu,  2 Mar 2023 12:57:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302125756epsmtrp22edbf9a4755570a6df93ffaf4a3b2431~Im4mcMYW90769407694epsmtrp2q;
        Thu,  2 Mar 2023 12:57:56 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-e8-6401929f3181
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.93.31821.45D90046; Thu,  2 Mar 2023 21:57:56 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302125753epsmtip2b0bd9a289146d1777a951e1144417b2a~Im4jxnwrj1098910989epsmtip2V;
        Thu,  2 Mar 2023 12:57:53 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <alim.akhtar@samsung.com>, <jingoohan1@gmail.com>,
        <Sergey.Semin@baikalelectronics.ru>, <lukas.bulwahn@gmail.com>,
        <hongxing.zhu@nxp.com>, <tglx@linutronix.de>,
        <m.szyprowski@samsung.com>, <jh80.chung@samsung.co>,
        <pankaj.dubey@samsung.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <4e7f3fe5-3a5e-d4c3-d513-642184bbdb23@linaro.org>
Subject: RE: [PATCH 02/16] PCI: exynos: Rename Exynos PCIe driver to Samsung
 PCIe
Date:   Thu, 2 Mar 2023 18:27:52 +0530
Message-ID: <139601d94d06$9bd85990$d3890cb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwIi2RiTAnipn4AB4ctyRQE87kyXrtiCLVA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxjd7b29t5jVXSnIC0PTVCaC46MTyttNnEPcbuacbG5hMw64oddC
        KG3TD/dBNgvDGOVDMEGgCCI0qCxjWCh0CMYhwmxC3YDVuMEC2DkYDFEQYVRYy4XNf+c573ly
        nvO8eXiotwsP4KUrdYxGSStE+Dqs5UZIaNj5M4gsst4RCIerWnBoykmD57vsXGhsqUTgw0U7
        Bi/NlhOwcGwEhR0TFgIa8he50HzPwYX9bedw2FvVg8Oy29c4MNeVi8Hcmycw+G3XEAFrLLME
        XG63EtBVOo3BJnMJutuHmjQ/IajvjUMEVW3WU+b6kzg16GjHqSm7naCcA6Ucqsl0jLoyZeVQ
        NYaHOFXYXI9QM+bNCc8fytiZxtAyRiNklKkqWbpSHivadzB5T3K0JFIcJpbCGJFQSWcysaL4
        dxLC3kxXuHOKhEdphd5NJdBarShi106NSq9jhGkqrS5WxKhlCnWUOlxLZ2r1Snm4ktG9Ko6M
        fCXaLUzJSKtoGMPUA76fzTduNSDDG04hXjxARoH7NQ/wU8g6njd5FQGuk7UEWzxCwODj37ls
        MYOAO7kmbK0lZ9K2qmpDgGOib7UYQ8BcRTPqUeHky8A54FrBPqQZBZ0nKI8IJRsQ4LxQwPE8
        eJG7wK+G+RWRgDwIrk9cc/M8HkYGgQ7Lfg/NJ6XA/udZDos3gFvlzpUpUHI7qLswgbITCcHC
        H3Vc1utdYHEO4azGD9xcyEc9voCs9QLZl0e5bEM8yLu6hLBYAP7qaSZYHABmpjpwFsvB5aay
        VQMFmGsycVj8Org+cA7zzImSIeC7tgiW3gRKbA0c1nc9KFh0rsr5wFq1hreA2aftq1v0B1Xd
        /dwiRGR8JprxmWjGZyIY/3erRrB6xJ9RazPljDZavUPJfPrfh6eqMs3IyhmE7rMio8PT4Z0I
        h4d0IoCHinz4WYbnZN58Gf35F4xGlazRKxhtJxLtXncxGuCbqnLfkVKXLI6SRkZJJJIo6Q6J
        WOTHD469lepNymkdk8Ewakaz1sfheQUYOI4ndMTd6WYsPjhe/8HeBVvr5q4r49v4hYeK/AN/
        kPb1Zf9kNyU2XgwmWoeoOnin67R805Hi417tk3tfNFT3j6NHxNKNWXkVy7Yk7uhSqY93yofb
        N94ue1qZvSep95vuxrfjOhKtgkDkF/Os6Uyc8dHpSt9p/0sHvtyflUjszi4eD8Ef9MylOOnA
        SkOSoCjovvBrV635t8GXtsIbFyfGCpbvbstP/+cAs1yNJr+VTcDq94JsRyNqlkss+Z+8Ifhq
        6XCI/OwL1rZWKOj2bdbey/ooJoZQ9+e8lvgzltE7H1CW45BUra/rK889VnH448eLf7e8bxsZ
        KV7UWX7EOufy/I7HWUSYNo0Wh6IaLf0vU4OQM48EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7bCSvG7IXIYUgwstkhYP5m1js1jSlGEx
        /8g5VotZ2+YyWnz8fY7FYsWXmewWfS8eMlvsfb2V3aKh5zerxabH11gtLu+aw2Zxdt5xNosZ
        5/cxWbT8aWGxaDnazmKx9shddotFW7+wW/zfs4Pd4s/0DywWmzdNZXYQ8Xiz6Tu7x85Zd9k9
        Fmwq9di0qpPN4861PWwe786dY/d4cmU6k8fmJfUeG9/tYPJY1PCRzaNvyypGj8+b5AJ4orhs
        UlJzMstSi/TtErgyFm6+yVIwT7SifcVMlgbGZYJdjJwcEgImEk1vTrF3MXJxCAnsYJR4+eYc
        M0RCUuLzxXVMELawxMp/z6GKnjFKHJrZDVbEJqAj8eTKHyCbg0NE4BCzRHslSA2zwCZGic/L
        1jJDNMxlkjjS2QY2iVPATuJWww+wZmGBQIm5jw+wgzSzCKhI7N3qCxLmFbCUOPd8GhOELShx
        cuYTFhCbWUBbovdhKyOMvWzha6hDFSR+Pl3GCmKLCPhJbH1ylw2iRlzi6M8e5gmMwrOQjJqF
        ZNQsJKNmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOCFoae1g3LPqg94h
        RiYOxkOMEhzMSiK81Q0MKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
        LYLJMnFwSjUwVZzsTzZYyn4pcntKXuvsm/Lf5Auea9oFLi4W3v/i4ROZvG3l3RNnce4NfvCt
        9X4QcyqHYPwNp2v25XdDH3+o2WXgIHj+g+ntqXnZaY/ndZu/7NVcmy4/T61P5dzqtckGhV+S
        9k0pvZjOtOP2y32TKpamB35zOeTVGCYvUsTMHuo0bUG6GJcV/7OawzUvEr8GmTYbHVm4+6bM
        rq2XWRWOed57dkrllvCX9jCtxtlHJwZNrL2rwpqZr/ubN+dI7JTJbasXqewLaet8tej8oQve
        cj7iyt37zrw8J1Sr9I25Ifbthf72r99lD/5p2HVy9/nZzFWXDwhbz9oolaJwYEK95pFPTfqr
        Pp/NXZkcHFxrq8RSnJFoqMVcVJwIAGi+/Wt3AwAA
X-CMS-MailID: 20230302125756epcas5p22ab3819f5605a34e3953301f24f39161
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc@epcas5p2.samsung.com>
        <20230214121333.1837-3-shradha.t@samsung.com>
        <d0d1db7e-e2a7-dddf-5c28-fed330b44cdb@linaro.org>
        <4e7f3fe5-3a5e-d4c3-d513-642184bbdb23@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 16 February 2023 16:29
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
> Subject: Re: =5BPATCH 02/16=5D PCI: exynos: Rename Exynos PCIe driver to
> Samsung PCIe
>=20
> On 16/02/2023 11:55, Krzysztof Kozlowski wrote:
> > On 14/02/2023 13:13, Shradha Todi wrote:
> >> The current PCIe controller driver is being used for Exynos5433 SoC
> >> only. In order to extend this driver for all SoCs manufactured by
> >> Samsung using DWC PCIe controller, rename this driver and make it
> >> Samsung specific instead of any Samsung SoC name.
> >>
> >> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> >> ---
> >>  MAINTAINERS                              =7C   4 +-
> >>  drivers/pci/controller/dwc/Kconfig       =7C   6 +-
> >>  drivers/pci/controller/dwc/Makefile      =7C   2 +-
> >>  drivers/pci/controller/dwc/pci-samsung.c =7C 443
> >> +++++++++++++++++++++++
> >
> > Rename missing. I am anyway not sure if this is good. What's wrong
> > with old name?
>=20
> OK, looking a bit at your further patches - doesn't it make sense to spli=
t a bit
> the driver? Maybe keep the core as pci-samsung, but some other parts in
> pci-exynso5433?
>=20

Ok agreed. So here is what I am planning, keeping in mind the next set of p=
latform support which I am planning to send out (say FSD, ARTPEC-v8):
1: We will move samsung pci driver inside dwc/samsung/
2: pci-samsung.c shall contain common APIs, helper functions, etc
3: Platform specific driver will have their own files such as pcie-exynos.c=
, pcie-fsd.c, pcie-artpec-v8.c=20
Let me know what you think of this.
I am not very keen on renaming Exynos SoC file as pcie-exyons5433.c as in f=
uture we may end up adding PCIe support for other Exynos which being
in same family (Exynos Series) will be very similar in design. Custom ASIC =
(manufactured by Samsung Foundry) is primarily driven by various
vendors and will have separate design in terms of integration of IPs in SoC=
 and we need to have support for all such SoCs manufactured under Samsung u=
mbrella.

Shradha

> Best regards,
> Krzysztof


