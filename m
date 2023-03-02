Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751CD6A90E4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCCGYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCCGYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:24:20 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05513DE0
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:24:11 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230303062409epoutp019ea16aa3aa8a3bbfe3dee7974fc99de8~I1KEou58_2445824458epoutp01b
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:24:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230303062409epoutp019ea16aa3aa8a3bbfe3dee7974fc99de8~I1KEou58_2445824458epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824649;
        bh=MeVCBYLvLrGYXjWOkIs+qPzJ8YVT/+MlUmAeoXmd+lQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=u66wMTAD9d+MaWqQoXJG0cfmpAxmWJlZ4I/Nt+soJsXMbGhFXCtmOVbVY+GKm1/fc
         egsCpEMG2DNxri9GhnO5dgpRx19Z4KkzkuRF3v2wIZmjhEx7151JvBYJmTY398OyI5
         6OtEvNSwxnJkq0/EspbiQo1XSL6zsA8eHmFCv71Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230303062409epcas5p3df77997ccdcd74a6c5a331513258c3c3~I1KECbLF_2040520405epcas5p35;
        Fri,  3 Mar 2023 06:24:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PSdGZ3cMkz4x9QD; Fri,  3 Mar
        2023 06:24:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.D8.55678.68291046; Fri,  3 Mar 2023 15:24:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230302124822epcas5p2d6dd5a0769cf85a1c5b1374613898399~ImwQDGJN12791227912epcas5p20;
        Thu,  2 Mar 2023 12:48:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302124822epsmtrp2eba16532ea10de00ba01218f97abdf9c~ImwQBbkD20200202002epsmtrp2W;
        Thu,  2 Mar 2023 12:48:22 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-5b-64019286e866
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.53.31821.61B90046; Thu,  2 Mar 2023 21:48:22 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302124819epsmtip1367c0cbbde2d26452d7a567fa12e753c~ImwNe0GaC3257532575epsmtip1M;
        Thu,  2 Mar 2023 12:48:19 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <pankaj.dubey@samsung.com>, <linux-pci@vger.kernel.org>,
        <jingoohan1@gmail.com>, <jh80.chung@samsung.co>,
        <linux-arm-kernel@lists.infradead.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hongxing.zhu@nxp.com>,
        <alim.akhtar@samsung.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <m.szyprowski@samsung.com>,
        <kw@linux.com>, <devicetree@vger.kernel.org>,
        <Sergey.Semin@baikalelectronics.ru>,
        <linux-samsung-soc@vger.kernel.org>, <lukas.bulwahn@gmail.com>,
        <lpieralisi@kernel.org>
In-Reply-To: <167638945319.3745.5262086066044660323.robh@kernel.org>
Subject: RE: [PATCH 10/16] dt-bindings: PCI: Add phy-names as required
 property
Date:   Thu, 2 Mar 2023 18:18:19 +0530
Message-ID: <139301d94d05$45d1c190$d17544b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwD2M2WLAWiR33oCmWP87q7ukImw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxjd/ehtQat3BcJL50i5jiAoSLFllymbiZ27A0lwS5aoS+CG3rTY
        0tZ+iJuZNg2DSfhOVCwMlHVEmLCsRYalkoWPGQ3WHxBQB0hXFg04EFqZHQzX0rLx7zzPc07O
        c943DwfhLWN8TqFKz2hVtJLAwtHugcTE5NI6SJp6Y5lLTjd1Y6TFJCebB50s0tz9LUQurjhR
        8rr3CpuseuZCSGPFCou0usdY5Ii9ESPvN93ByPoHfTBZslqCkiVDZSjZMTjJJltuetnka0cP
        m1y9/AIlbdaLyMEI6rn1LzZ1yzzJpq5aDZS1/QJGTYw5MGre6WRTM6OXYcpmOU/9NN8DUy3G
        RYyq6mqHKI81NnfrccUBOUNLGa2AURWopYUqWSaR/WneoTxxeqowWZhBvksIVHQRk0lIjuQm
        Hy5U+iMSgtO00uBv5dI6HbH3/QNatUHPCORqnT6TYDRSpUakSdHRRTqDSpaiYvTvCVNT08R+
        Yr5C3tjpQDWLUWdmHcAIuXjlUBgH4CJQ+9TOLofCOTy8FwKXRh6xgsUSBDqay0KFBwLjE9Xs
        DUm5exgOYB5uh8D1G8lB0jMImC3VrMAAw/eAmdFVJIAj8XhgMk+jARKC16LAWDmBBgZhuATY
        bk5jARyBHwUDUx3rYhR/B/zd4vVzOBwungF6PepAm4u/Ce5emVmXIvhu0HptDgkuJAC+P1pZ
        Qa/DYNI9iAQ50WDIV4EEfAHeHAYufWPHggIJ8P35WyhNBJi90xXCfOCZvx3iyECbrT5koATL
        NgscxB+AX0Yb13dD8ETwo31vsP02uHivEw76bgOVKzMhOhf0NG3gncD7jwMN4hjQ9OsIqwYi
        zJuimTdFM2+KYP7f7SqEtkMxjEZXJGN0Yk2aiin+778L1EVWaP0AkrJ6INf0i5R+COZA/RDg
        IEQk96zxDSmPK6W/+JLRqvO0BiWj64fE/ueuRfhRBWr/Ban0eUJRRqooPT1dlLEvXUhEcxMy
        7xbwcBmtZxQMo2G0GzqYE8Y3wvvNC/HjS2OxzvKSnJeWredy+xUvP5+OFX81fjrq2MAC/2u4
        a1vnGtlX+btQ8aquICd66WxCWWn9XLjr+4YwhH8uZo+tT3Q0nx55ZMp2z5kXog+KF0wn2kY9
        rWutzdzHn+0CNSWFWcPbhT/4IqWnBGeUssXwxxGTWya+u2DfHefOv/fkw1m5a+h2wvNd+11s
        SXbuFmfcUs1x2dwO9xH3w5OG156GQ7IHSR+3HbOMNc5vL973KjJC0mAvnt9pfEpZYnwfVTvy
        rPwZcmHxpOK+V9L7yVuVTLkRrxIM56wlVlCdMEV3xu0QXvP+bNLEn/DhLcZTU7dM5/VP0h5O
        1ZXyswhUJ6eFSYhWR/8L7I3nPIkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSnK7YbIYUg8dXlC0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLxeZNU5kdhD3ebPrO7rFz1l12jwWbSj02
        repk87hzbQ+bx7tz59g9nlyZzuSxeUm9x8Z3O5g8FjV8ZPPo27KK0ePzJrkAnigum5TUnMyy
        1CJ9uwSujLerdrMUHBWt2PV2CnsD41qhLkZODgkBE4mux2eYQGwhgR2MEke3cEPEJSU+X1zH
        BGELS6z895wdouYZo8TJJj0Qm01AR+LJlT/MILaIgKpE06wHLF2MXBzMAotZJCb/ugHmCAl8
        YpSY/mAjWBWngIvE5q0P2LoYOTiEBfwlLnbxgYRZBFQkfi36wgIS5hWwlNj9OR8kzCsgKHFy
        5hMWEJtZQFui92ErI4y9bOFrZojbFCR+Pl3GCnGDm8Tdx0eYIWrEJY7+7GGewCg8C8moWUhG
        zUIyahaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJTgJbWDsY9qz7oHWJk
        4mA8xCjBwawkwlvdwJAixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQi
        mCwTB6dUA9N8E90NCer10zu3O4m2+1SLN9dEflSYuyrofZCx4WRZVY3gs40nDyxK3524wrfs
        jJzH4aC1K28nT3pUJhb7Y2eIbdFSwceiFt8X7dyz55Hql7LF5yNmbk6d3/txzu+l9/WnSN+f
        9K5dXkSQl/taUPWKGzKyEuqiEXkzC/oPrLyn0Zk59xbXraLLyQlBr74vTw2PnDfRPj0tfq9U
        vwjrkbIl1f4+Qo9C++dV+tS/7X37yaXJpa7t7ZFoyY9Fhj8dM/7xroz+aFXsFXfqquaVQ35M
        ZgklD4O47ovsOvnL4M3Xo9+2pc3JXOlSWb2E48vFTh/xlLcdTk4z9FZyT/9Xt31WUpGnCas6
        529FO9dpOUosxRmJhlrMRcWJAISBV0hwAwAA
X-CMS-MailID: 20230302124822epcas5p2d6dd5a0769cf85a1c5b1374613898399
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1@epcas5p1.samsung.com>
        <20230214121333.1837-11-shradha.t@samsung.com>
        <167638945319.3745.5262086066044660323.robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Rob Herring =5Bmailto:robh=40kernel.org=5D
> Sent: 14 February 2023 21:43
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: pankaj.dubey=40samsung.com; linux-pci=40vger.kernel.org;
> jingoohan1=40gmail.com; jh80.chung=40samsung.co; linux-arm-
> kernel=40lists.infradead.org; tglx=40linutronix.de; linux-
> kernel=40vger.kernel.org; hongxing.zhu=40nxp.com;
> alim.akhtar=40samsung.com; bhelgaas=40google.com;
> krzysztof.kozlowski+dt=40linaro.org; m.szyprowski=40samsung.com;
> kw=40linux.com; devicetree=40vger.kernel.org;
> Sergey.Semin=40baikalelectronics.ru; linux-samsung-soc=40vger.kernel.org;
> lukas.bulwahn=40gmail.com; lpieralisi=40kernel.org
> Subject: Re: =5BPATCH 10/16=5D dt-bindings: PCI: Add phy-names as require=
d
> property
>=20
>=20
> On Tue, 14 Feb 2023 17:43:27 +0530, Shradha Todi wrote:
> > To replace devm_of_phy_get with devm_phy_get to get the PHY pointer
> > using non DT version, we need to add phy-names property in DT and make
> > it a required property with const value.
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  Documentation/devicetree/bindings/pci/samsung,pcie.yaml =7C 5 +++++
> >  1 file changed, 5 insertions(+)
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/pci/samsung,exynos-
> pcie.example.dtb: pcie=4015700000: 'phy-names' is a required property
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://protect2.fireeye.com/v1/url?k=3D788bbab7-19f652f0-788a31f8-
> 74fe485fff30-c0e59906b0eee0e1&q=3D1&e=3D33c2cefb-9526-43d7-9446-
> b159854d2369&u=3Dhttps%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fdev
> icetree-bindings%2Fpatch%2F20230214121333.1837-11-
> shradha.t%40samsung.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your
> schema.

Thanks for review. Sorry, I missed to update the example. Anyway I will get=
 rid of this patch all together=21

