Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ECC6A90EC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCCGYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCCGYk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:24:40 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA0F13D5B
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:24:28 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230303062426epoutp01a769ce45efe99a4138f7592097f292d8~I1KUmRucP2445624456epoutp01j
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:24:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230303062426epoutp01a769ce45efe99a4138f7592097f292d8~I1KUmRucP2445624456epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824667;
        bh=3DArT+utC+yte03ZA4K0E87osEGZS5gWGQdvjLnBraE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fesNK0njKjZH82mrZp5EmX5WP8+3vv85q9xXHbzawIOyD2+mwM1uQ4GBkJ6rbTHh9
         Pz/GFOr1M+G2ZQSnagHxzQJiLTXsnmmWywk+iWe8MbMRh9jOBs7Xy5jM9Go+E1DAXu
         GDbypV7FK2J6YdBEjcDuh8a83XvJUjQ6sh+A50AU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230303062426epcas5p129c24f71da9cab664b81d3b8ccb71003~I1KUQC5Y_2838528385epcas5p1X;
        Fri,  3 Mar 2023 06:24:26 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PSdGw38RCz4x9Q5; Fri,  3 Mar
        2023 06:24:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.46.06765.89291046; Fri,  3 Mar 2023 15:24:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302125452epcas5p32c59184cf8d9b8d313eb1aac1a74aabf~Im16_eB_x2420824208epcas5p32;
        Thu,  2 Mar 2023 12:54:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302125452epsmtrp2d9f658b9b2f028c4e0dcad81586c3d6f~Im169hR4n0562805628epsmtrp2m;
        Thu,  2 Mar 2023 12:54:52 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-cd-64019298737d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.83.31821.C9C90046; Thu,  2 Mar 2023 21:54:52 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302125449epsmtip215fc19c1c01d6a7f585e701d3265d6b6~Im14Kk1wf1098910989epsmtip2H;
        Thu,  2 Mar 2023 12:54:49 +0000 (GMT)
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
In-Reply-To: <b40cafa1-396f-e6cd-3240-bc879d5f2c8b@linaro.org>
Subject: RE: [PATCH 01/16] dt-bindings: PCI: Rename Exynos PCIe binding to
 Samsung PCIe
Date:   Thu, 2 Mar 2023 18:24:47 +0530
Message-ID: <139501d94d06$2e159850$8a40c8f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwGR6AZAAi0lqPMB7TDvZq7o8Rtg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0xTZxjH955zek7LbQco8MKmko5F0AEtlvbUyGXTmZN0iV1gH+BLPdIT
        Siht0xacurmGgG4IboAE7KBcVi/ggKzcEcjkItGNukWCWQIMETYiG+MWlIu41sLmt9/z5v9/
        nvf/vnm4qN8GHsLN0JpYg5bRCHAPrH0gIjyyogSohK0vAqgpaztO2XLVVPWgg0NZ2qsAtbTp
        wKibq1cJ6vLcY5TqnW8jKHPhJoeyPxnjUA+7K3FqxDqMUxUP+hAqbysPo/KGLmJU4+AEQdW1
        rRLUy55OgtoqX8SoFnsZmsin/7I/I+guywRB19izaXvDVzg9PtaD0wsOB0HPjJYjdIvtC/qH
        hU6ErjMv4fTl1gZAr9j3KrxSM4+oWUbFGkJZbZpOlaFNjxPIk5RHlbESoShSJKOkglAtk8XG
        CY59pIg8nqFx5hSE5jCabOeRgjEaBdHxRwy6bBMbqtYZTXECVq/S6MX6KCOTZczWpkdpWdNh
        kVAYE+sUnsxU3yruRfRfBnxaNjsEzGDFtwDwuJAUw47caaQAeHD9yNsADtzqwN3FMoDWvDbg
        LlYAHL9Ri+5a2l4276i6AbxWeolwF3MAzv7WSLhUOPkenBndeuXgk3YU9l+kXSKUbAJwprbI
        OZHL5ZHxcGI6w4X+ZAqsmQxzyTEyDP7efZPjYm9SBi3blTvsC+9dncFcjJIH4fXa+Z0LhcL1
        2escVxs+eRzWb8jckiA4tF6IuqZCspoHn2/+CVwaSB6DPc1qt9UfPh1uJdwcAlcWenE3p8P6
        loqd9hq41mJD3JwAfxytxFxtUDICNndHu4/3wLL7TYh7rA8s2pzZkXvDTusuvwNXX/Rgbg6G
        1rsPOd8AgeW1YJbXglleS2D5f1oNwBpAMKs3ZqWzxlj9IS17+r/vTtNl2cGrJTgg7wTTU4tR
        /QDhgn4AuaiA733O/IbKz1vFnDnLGnRKQ7aGNfaDWOdrF6MhAWk65xZpTUqRWCYUSyQSseyQ
        RCQI8t4fdy/Nj0xnTGwmy+pZw64P4fJCzMgpReOSMgaZ3KNI2jy3d3he99k/DbKRJkfpaMDZ
        5bdtgXTJh+d7z0/lwAs5qcU/D8XGFC72RCR87SmdwNFL2/llCRtjue+fCKYdT6+86zXM+0Ta
        nvvx4dkkeeOalDNV3lmYlPU5uyyVf/D30CD/0aQt1fbWxOy88n5iRNL3vMRgH/O25CfFjZg7
        yeP7bMoHJbWBB6VVnr/2KS9YU/Se1eHfnkmIelS1r686ZTztl6LCtfzUxGsDJ58/Hgma2wq+
        Q/whHuB3VSi7ThVHh7eevl2qia9OLqgHYYGoPN/jGTPqE+4VEX40/4R4ivBvvNvRtNby3Ztm
        uY+meM63bj/2ZD15SyjAjGpGdAA1GJl/AbfraCCNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ3pzLRaHUqVW4lLKkaFgqJEL4agRiXjkrhHRY1tZFgipaQD
        LhC1mGpjRdwFJoCKFVlcByEVK5gCElQQlYBG61rUiJIiJi4Qamo14e3Lf77z5zwcCpO/wcdS
        SSlprCFFm6wipHh1vWpCaEHBsLgZbp5Gb4qqCWTdn4jONrSKEV9dCFBvfyuOSr/nkyjn01sM
        3emuIpExu1+MhPcdYvS0poBALUVNBMp7VCtCpgETjkyNZhxdaXCSqLjqO4k8dhuJBnLdOKoU
        TmPzFcwX4QfJ3OKdJHNOSGeE8kME87LDTjA9ra0k42rPFTGV1n3MjR6biCk29hJMzs1ywPQJ
        41eOiJVGxbHJSTtYw/RojTTx2qtvWGqLYtfF2ueYEVT7WYCEgnQErPJcI7wsp20AnsnS+nIl
        7Ht8VeRjf1g2+JH0OR8AfNE12csErYau9gHMAihKQTswaN5tAVIKowUA+0quYD6/G8AGV6TX
        kdDR0PkuyRv70+vh4LOyvwpOB8HXNaViL8voSMgPFvxjP9ic78K9jNEh8MjbA+A/l5zvxnyn
        TYS/ukrEvhNiYNnvSJ8SABt/ZWPHgD8/pIkf0sQPaeKHrJwDeDlQsqmcLkHHhafOTGF3hnFa
        HZeekhC2Ta8TwN8nCA62AXu5O8wBRBRwAEhhKoUs0zgsTi6L0+7OYA36rYb0ZJZzgEAKVwXI
        2izNW+V0gjaN3c6yqazh/1REScYaReOy1QNnLv6Q5rg79frc7RyK3HLK5LEuG/ng6s/QeYXK
        Uc4LbbeuZ6oitGOE/s3hWOBP5Vc57kTxy4GZ2KFxv+tlZq/LW/dog6DImbSkxFARcyI0Y9Xm
        FZuOLJlGxNv3TqQe1A2vALdv586pKa5YG6JpuZT/ea5jw2cs07rvaEx8lJme0nS6p2Me9e1w
        96FY49nYOm7X1PX5tfVRIU8WCJ7OrD1UdH9jliT5TkZQvd9Sddrikcf7TPzvPe1NGn7R3aqu
        e7KFEYGj8Y0Cst/3OBYQ7bNONq18uKY0KOyyfsKNZnVSp6XmKLqnrryuRAGBNvPqupuyKZUu
        jU7SZi06qMK5RG14MGbgtH8AegIDInMDAAA=
X-CMS-MailID: 20230302125452epcas5p32c59184cf8d9b8d313eb1aac1a74aabf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a@epcas5p3.samsung.com>
        <20230214121333.1837-2-shradha.t@samsung.com>
        <b40cafa1-396f-e6cd-3240-bc879d5f2c8b@linaro.org>
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
> Sent: 16 February 2023 16:24
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
> Subject: Re: =5BPATCH 01/16=5D dt-bindings: PCI: Rename Exynos PCIe bindi=
ng to
> Samsung PCIe
>=20
> On 14/02/2023 13:13, Shradha Todi wrote:
> > The current DT bindings is being used for Exynos5433 SoC only.
> > In order to extend this binding for all SoCs manufactured by Samsung
> > using DWC PCIe controller, renaming this file to a more generic name.
>=20
> Thank you for your patch. There is something to discuss/improve.
>=20
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  .../pci/=7Bsamsung,exynos-pcie.yaml =3D> samsung,pcie.yaml=7D     =7C =
6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)  rename
> > Documentation/devicetree/bindings/pci/=7Bsamsung,exynos-pcie.yaml =3D>
> > samsung,pcie.yaml=7D (93%)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
> > similarity index 93%
> > rename from
> > Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > rename to Documentation/devicetree/bindings/pci/samsung,pcie.yaml
> > index f20ed7e709f7..6cd36d9ccba0 100644
> > --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
>=20
> We keep the name rather tied to compatible, not generic. There are no oth=
er
> compatibles here, so I don't think we should rename it.
>=20

Our intention to rename was to have a common name for Samsung manufactured =
SoCs having PCIe controller.
Though this change may not be a blocker for us but we feel it will be good =
to have a common name as this file will
not have bindings only for Exynos series of SoC (Samsung Sys. LSI designed)=
 but also custom ASICs such as FSD / ARTPEC SoC (Samsung Foundry designed).=
=20
We hope we are not breaking any ABI as such in this patch.

Shradha

> Best regards,
> Krzysztof


