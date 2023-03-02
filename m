Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F046A90FB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCCGZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjCCGZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:25:37 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40539515F1
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:25:03 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230303062452epoutp03caa46084102f7ebb4789f155cdd143d5~I1KsPjNsU1875718757epoutp03M
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:24:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230303062452epoutp03caa46084102f7ebb4789f155cdd143d5~I1KsPjNsU1875718757epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824692;
        bh=CppGbljzAF8PCfcULmrU15nn5y5aWs2ImPoXPZR7FrQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=p+rOKJ2Fr7zMwxQwtYu1eBViAAHHbBo/JTMZyIxJ9bRZtgm89GUwnro5UUS7nz5ZK
         rJPeVmizxDv/86+bfV4RfAMgjSzwoPtgwLGCTPDkW+sAKAELy/Oq3cD70SlMILxlKP
         g0pEj/pfdl+6rV2hYMXT0BHXVsFTKLsSMcWfq78U=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230303062451epcas5p2bee8b019ec6b081b5cedbab314ba0372~I1Krg8fu62226222262epcas5p2i;
        Fri,  3 Mar 2023 06:24:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PSdHP4H7Jz4x9Q8; Fri,  3 Mar
        2023 06:24:49 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.49.55678.1B291046; Fri,  3 Mar 2023 15:24:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230302130747epcas5p1a21d741bde8891ed92205928a44deafe~InBMxCE4O2770327703epcas5p1b;
        Thu,  2 Mar 2023 13:07:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302130747epsmtrp2dc038b179be8ae16abdad3cc0c9f0689~InBMv5dFv1472814728epsmtrp2H;
        Thu,  2 Mar 2023 13:07:47 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-f9-640192b105a5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.E3.31821.3AF90046; Thu,  2 Mar 2023 22:07:47 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302130744epsmtip1e913a0b660ea6486d2db08299f7517b6~InBKB-EQo1248112481epsmtip1K;
        Thu,  2 Mar 2023 13:07:44 +0000 (GMT)
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
In-Reply-To: <31e377b7-88bf-8737-0397-44ecca8cff54@linaro.org>
Subject: RE: [PATCH 06/16] arm64: dts: exynos: Rename the term elbi to appl
Date:   Thu, 2 Mar 2023 18:37:43 +0530
Message-ID: <139801d94d07$fc0b9e70$f422db50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwKUdRoNAvmUMlgBNONUfq7gPa3w
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTdxjH9+td71pn3fEmP8hcmnPZAgq0rpSDWN1A8Rxz4ozLNIt4oTfK
        KG3Tl00wg44R2SqvY0TsBJQxETLLKMLKmyKIICpzKcrEkUFWFt6CIIQFgW2Uw43/Pr/n+T75
        5vv88ggQzyXMX5CoMbJ6DaMmsQ1oQ0dAYFDt10ApaTO/TA2VNmBURYaKKrvZy6esDSWAmlns
        RanLc+dwKnd0GKFaJ+pxypy9yKfsfzzkU86m8xh1r7QLo4p/vsajMpcyUSqzMwulrtwcxKny
        +jmc+qfFgVNLZ6dRqs5ehLzpTU/a/8LpRusgTl+wm2h79VcY/dvDFoye6u3FaVffWR5dV5FO
        1045eHS5eQajc69WA3rW/krsxmNJO1Uso2T1YlYTr1UmahIUZMzhuKi4ULlEGiQNp8JIsYZJ
        ZhXknndig6IT1Ss5SfEnjNq0UoplDAYyZNdOvdZkZMUqrcGoIFmdUq2T6YINTLLBpEkI1rDG
        CKlEsiN0RXgiSZVb2IjpbnifrL/8FDWD0x4WIBRAQgZ/yl/GLWCDwJNoBnD8QTbubngSTwG0
        PtJxjVkAW2daeRYgWJ0oqffm6k0Afv/jPZR7jAI4X9PIc09jxHbo6ltC3OxN2BHYnkW7RQhh
        A9B1MWdVJCR2wXGbGXOzFxEDn1icwM0o8SrsKplcZRERDqfNjjX2gLfPuVA3I8Q2eOniBMJl
        EMOFkUt8ziwaZs908zmNL+xcyEbcxpCoFMLyu7/yuYE98FZ3/hp7wfGuqzjH/nB2qhXjOAFW
        1RWvGajhfF0Fj+PdsK3vPOpeBUIEwJqmEK68BRb12Hic7yaYs+hak4ugo/Q5b4Vzyy0ox36w
        9JaTnw9I67po1nXRrOsiWP93uwDQauDH6gzJCawhVLdDw37634fHa5PtYPUMAt92gOGh6eB2
        wBOAdgAFCOktOmV+QekpUjIpqaxeG6c3qVlDOwhd2XcB4u8Tr125I40xTioLl8jkcrks/A25
        lPQVva64He9JJDBGNolldaz++RxPIPQ380IUtubto6KRz3qqhpxZN4qHNAXBpyVVdwbE6ZGp
        S++FVKYcmZ9+N/y4NOrRviOnrlwf66zwP/FlUVy20HKs5/e8iMqTOaaA94P7R1pyG3OSMIcy
        NWO0YDKtLK8wY3KhjME6vn1WgD2O+ntBYUkviuyVdm1sbDMzabGvffDM9+imaSYyazT6uq37
        TNiBjP1Coum7/rxr9w9s/WUvW7DvQURHdcWHgx5+22yHm8SPc7r1ubp8n2/Ggg5Jar740ytd
        Lju4uWw5LPKjPROqlLH9Llf/ZmdtlOxOis3DNbLlOJEmrb976HPn/YGju2deao5ceMun9olK
        eOagTtU3/OLHdHpM4YDzBxI1qBhpIKI3MP8CyGB2TY8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCSnO7i+QwpBn0bhS0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLbY+3oru0VDz29Wi02Pr7FaXN41h83i7LzjbBYz
        zu9jsmj508Ji0XK0ncVi7ZG77BaLtn5ht/i/Zwe7xZ/pH1gsNm+ayuwg4vFm03d2j52z7rJ7
        LNhU6rFpVSebx51re9g83p07x+7x5Mp0Jo/NS+o9Nr7bweSxqOEjm0ffllWMHp83yQXwRHHZ
        pKTmZJalFunbJXBlnP2cUPBbuOJl/2n2BsYDAl2MHBwSAiYSc7eKdDFycQgJ7GCUeHf1BVMX
        IydQXFLi88V1ULawxMp/z9khip4xShxesxMswSagI/Hkyh9mkEEiAoeYJdorQWqYBTYxSnxe
        tpYZpEZI4DWjxMs7fCA2p4CdxKt1DWwgtrCAt8T7rsuMIDaLgIrE8blvwGxeAUuJDw07oGxB
        iZMzn7CA2MwC2hK9D1sZYexlC18zQxynIPHz6TJWEFtEwE2i5+MJVogacYmjP3uYJzAKz0Iy
        ahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgZKCltYNxz6oP
        eocYmTgYDzFKcDArifBWNzCkCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1
        tSC1CCbLxMEp1cBUbtrsMPlJnIMc18JZMsx1P+5q/dOPfzZbXvVG1UIlsWXGxgFu3yWvzrla
        vlv6ufsEn2/3+EoYfh+z8lZXNDm/REc068ut0J6vXf+0dzz/qWbzJM1s7qZVVS5bLk3va62f
        LOAsqFdxrWpdSs6u0Gnrtli+XxryP8hgYTBXtvp974l3F4vdVyk8ke7X8bu3PsHJ5fisk3c/
        7LPnThfLNNPb5TZpVVjIsv0cmbJn+7oz7nRN2fL3+vbUKJ2AnTPtdXuUK/0mZy77Pld8WuF5
        p7tejxLaxMoCFrGH5W8pn/+OsUsj7987AT/eo26pJRuOdeh9nmDY6NUyucUp5PmTmScvBmnV
        yS8NzFBO/GhY+0iJpTgj0VCLuag4EQCdB/zpdQMAAA==
X-CMS-MailID: 20230302130747epcas5p1a21d741bde8891ed92205928a44deafe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121428epcas5p3d91e877e62a78008d2b0d6066efea059
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121428epcas5p3d91e877e62a78008d2b0d6066efea059@epcas5p3.samsung.com>
        <20230214121333.1837-7-shradha.t@samsung.com>
        <31e377b7-88bf-8737-0397-44ecca8cff54@linaro.org>
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
> Sent: 16 February 2023 16:34
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
> Subject: Re: =5BPATCH 06/16=5D arm64: dts: exynos: Rename the term elbi t=
o appl
>=20
> On 14/02/2023 13:13, Shradha Todi wrote:
> > DT uses the name elbi in reg-names for application logic registers
> > which is a wrong nomenclature. This patch fixes the same.
> >
> > This commit shouldn't be applied without changes
> > =22dt-bindings: PCI: Rename the term elbi to appl=22 and
> > =22PCI: samsung: Rename the term elbi to appl=22
>=20
> Dependencies and patch ordering goes after '---', because there is no poi=
nt
> to store it in git history.
>=20

Understood will take care in next set of patches.

> Anyway, that's an ABI break and Exynos5433 is quite stable, so without cl=
ear
> indication of fixed bug, we should not do this.
>=20

We have strong technical reason to do so.

As per DWC PCIe UM, ELBI delivers an inbound register RD/WR received by the=
 controller to external application registers when the controller
is expected to generate the PCIe completion of this register RD/WR.
In this driver register space which is currently marked as ELBI, is not use=
d for this purpose (Not sure why original author has named this set of regi=
sters as ELBI)
So to keep this technically correct, it should be marked as application spe=
cific wrapper register space.
We used name as =22appl=22 taking reference from intel-gw-pcie.yaml's simil=
ar register space named as =22app=22, whereas in nvidia,tegra194-pcie.yaml =
it's named =22appl=22.=20

So our argument is if a future Samsung manufactured SoC having DWC PCIe con=
troller comes with support of real ELBI interface, we need to use the name =
elbi.
We know such SoC exists but they are not yet upstreamed.

Ready to adopt the best possible suggested method to make this happen but I=
 really think the name ELBI is misleading.

>=20
> Best regards,
> Krzysztof


