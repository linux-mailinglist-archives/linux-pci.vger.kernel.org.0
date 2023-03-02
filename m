Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09766A90E0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCCGYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCCGYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:24:12 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FC13506
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:24:03 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230303062359epoutp045a9ae33b27ecfb98ec41f13db315ddf7~I1J7b0ulq2519825198epoutp04j
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230303062359epoutp045a9ae33b27ecfb98ec41f13db315ddf7~I1J7b0ulq2519825198epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824639;
        bh=jzCG/BBhzHTQaPXueFKBBk54VwhXWae/BjbpzpIVH4A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=STiyy++82ZJzZOwriwn6p+qrNkWcsAeZj1xN2dC8o0p5r7McnRw2xLopxtWj0dLCq
         ZT1etZHS88xha4n1GzPOg6pkvhEDqbp/cVUrygAXySyR2lIEf6I/gwC+nPuGVqnDJ5
         aOXhpdkIX90KLQ+55f/4dZVWoMU/k5sdis0YLC7w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230303062359epcas5p24229ec7ddaf67bdecc7360db844bc6a6~I1J6_Grkf1275812758epcas5p20;
        Fri,  3 Mar 2023 06:23:59 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PSdGN5vs8z4x9QH; Fri,  3 Mar
        2023 06:23:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.16.06765.C7291046; Fri,  3 Mar 2023 15:23:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302124730epcas5p3e335772953face43b8918e3f3d156e7f~ImvftJh1W3272932729epcas5p3B;
        Thu,  2 Mar 2023 12:47:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302124730epsmtrp1773eabce41f0842bc62df6cfbdaf764c~Imvfr_vuQ2737627376epsmtrp1o;
        Thu,  2 Mar 2023 12:47:30 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-6a-6401927c8041
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.C3.18071.2EA90046; Thu,  2 Mar 2023 21:47:30 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302124726epsmtip18c7dc6ef6ef9d8a09a0aa4b663b1ba94~ImvcBc1Oc2915429154epsmtip1N;
        Thu,  2 Mar 2023 12:47:26 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <alim.akhtar@samsung.com>, <Sergey.Semin@baikalelectronics.ru>,
        <pankaj.dubey@samsung.com>, <jh80.chung@samsung.co>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <tglx@linutronix.de>, <linux-samsung-soc@vger.kernel.org>,
        <kw@linux.com>, <jingoohan1@gmail.com>
In-Reply-To: <167638944926.3699.15638999253407034271.robh@kernel.org>
Subject: RE: [PATCH 05/16] dt-bindings: PCI: Rename the term elbi to appl
Date:   Thu, 2 Mar 2023 18:17:14 +0530
Message-ID: <139201d94d05$26da8290$748f87b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwG8wiHRAhWtsysBm4ANqa7q4hdA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVCTdRzvt+fZnmGse2SWP2Z23KNoULyMl/mgLLlS7ilEV513ndLRE3sC
        Ym/t2SqSq2VcEanzDecmEHiIMCWOsQgWkKBi4A27E8wMr6mDwBkCIsYB1sYDxX+f78vn+/l+
        fr/7CpGQvwUSYa7GwOg1tIoQLEObzkdERBUcBsrY3qH1pKe8SUBW7c0hv73QyydtTWWAHJ/p
        RcmaSStGHhi+hZCmfTN80nHnGp+86ioVkO7ySwLy+JV2Hlk4W4iShRe/Qsm6Czcx8uT3kxj5
        T2szRs5axlCy0VGCpIipe45HGNViu4lRFQ4j5bB/LaAGrrUKqNHeXozy9ll4VGPVZ1TDaDOP
        OmkaF1AHnHZAPXA8pwjelZecw9BKRh/GaLK0ylxNtpxIezPzlcxEWaw0SppEbiDCNLSakRNb
        timiUnNVfotE2Ie0yuhPKWiWJWJeStZrjQYmLEfLGuQEo1OqdAm6aJZWs0ZNdrSGMWyUxsbG
        Jfob38nLGbTe5+vanvl44M4JYAKl4mIQJIR4Avz5cQtWDJYJQ/AfAXTfdqJcMAGg80Ydnwum
        ABwYaOctUo52jgi4QhuA7S3VPC4YBtDTcQoEugT4i9DbN4sE8Ao8HO61eebnIrgZhZc75tBA
        IQjfCit8D/gBLMZfheazj+fJKL4WFo9OzZNFeBIcrHXzObwcdlu981wEfwFWV/oQbqUwOD1Y
        zefEUqG1rAHhelbCi9P7kIAwxE8EwdrS8/5Vhf5gC7xeGcxxxfDuJSfGYQkcMX+5gLNhbePx
        hfkqONVYtWB/MzzXV4oGxiB4BKx3xXDp1bCk5zseJ/sU3D/jXWgXwebyRbwGTs61ohwOheVd
        V/kHAWFb4sy2xJltiQPb/2oVALWDUEbHqrMZNlEXr2E++u/Hs7RqB5g/gci0ZnDbMxbdCXhC
        0AmgECFWiPaYnlCGiJR0/ieMXpupN6oYthMk+p/7ECJ5OkvrvyGNIVOakBSbIJPJEpLiZVJi
        pWi9vDsrBM+mDUwew+gY/SKPJwySmHg9h9Jdcmr6041jDQV/JNO1D9WVfwln39e7RlIcr/UX
        vbXKFa7AjL7prlOe5XB3geWLM7/Zt+6m+l+WVKzK0Frqj3mev/vTmUiS51XEjQQfcZkbrp8O
        rkiXSN0T7Bs19ej2orizEUjPo/vWb7DB8PR62w7HB/tvsSb39rK5wme9v9cBn1jmyzhyz0yk
        a/dYpGY0oiNv1xW7FSQLi1YX/6nY9F5Djexhv68bLbHoQow9O+NbNnTdOHc5P6Z72E2nHlS3
        iU2bn2wuD920Rn5alB989G1JePzrxT+MjJcc5oX6yInBsrW/2J102lRpi/PXY8p1n+/Y2ZdS
        IsGGYt5VZAwRKJtDSyMRPUv/C0O3zDeLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSnO6jWQwpBj1z1C0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLxeZNU5kdhD3ebPrO7rFz1l12jwWbSj02
        repk87hzbQ+bx7tz59g9nlyZzuSxeUm9x8Z3O5g8FjV8ZPPo27KK0ePzJrkAnigum5TUnMyy
        1CJ9uwSujEkX/7EVdItVHLp7l7WB8ZFQFyMnh4SAicSUQy/Zuhi5OIQEdjNKbFjSxgKRkJT4
        fHEdE4QtLLHy33N2EFtI4BmjxJpeNxCbTUBH4smVP8wgtoiAqkTTrAdgvcwCi1kknixSghj6
        iVGic+4/sEGcAq4SC15/ZgWxhQU8JfrX/GMEsVkEVCS63n0DG8QrYCnxdOVZVghbUOLkzCdQ
        Q7Uleh+2MsLYyxa+ZoY4TkHi59NlrBBHuEnMnLuRGaJGXOLozx7mCYzCs5CMmoVk1Cwko2Yh
        aVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4DWhp7mDcvuqD3iFGJg7GQ4wS
        HMxKIrzVDQwpQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBK
        NTAFBD8/sk3p7qMf8lc/Zm9yqf7XK/PiF+P0fkGviXYLmp8yMqf/YuYLOr1y2uygkI/rdY8/
        cLidWf04al5xi8zOjpK7OU5aGYtmqKsduPrdTEROYbGmQ4jvhTP1EgZONqaMKserrrUH+zd1
        GGtX24tuS7maonezJu6y8po5M0zeXfd/t3eD2ZQLPU22Kjb7i0R+Zd6bmu22JKn74MzXSqqx
        R6c5tu35q+fj2tc0S081SuZEl8Z28RVPNiXti/zOVHdrd93fl6v5RbTOlErN917/Y/6qSQZn
        H2uFnLdirlJfKCb5lv/zlZDQxmLne6VfHsTcv3nvWu9N4ci5/+wuzFibuLnrdVLmsscrsrud
        ZuxTYinOSDTUYi4qTgQAIRSE1nIDAAA=
X-CMS-MailID: 20230302124730epcas5p3e335772953face43b8918e3f3d156e7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499@epcas5p3.samsung.com>
        <20230214121333.1837-6-shradha.t@samsung.com>
        <167638944926.3699.15638999253407034271.robh@kernel.org>
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
> Cc: alim.akhtar=40samsung.com; Sergey.Semin=40baikalelectronics.ru;
> pankaj.dubey=40samsung.com; jh80.chung=40samsung.co;
> krzysztof.kozlowski+dt=40linaro.org; devicetree=40vger.kernel.org;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com; bhelgaas=40google.com;
> linux-pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org;
> m.szyprowski=40samsung.com; linux-kernel=40vger.kernel.org;
> lpieralisi=40kernel.org; tglx=40linutronix.de; linux-samsung-
> soc=40vger.kernel.org; kw=40linux.com; jingoohan1=40gmail.com
> Subject: Re: =5BPATCH 05/16=5D dt-bindings: PCI: Rename the term elbi to =
appl
>=20
>=20
> On Tue, 14 Feb 2023 17:43:22 +0530, Shradha Todi wrote:
> > DT uses the name elbi in reg-names for application logic registers
> > which is a wrong nomenclature. This patch fixes the same.
> >
> > This commit shouldn't be applied without changes
> > =22arm64: dts: Rename the term elbi to appl=22 and
> > =22PCI: samsung: Rename the term elbi to appl=22
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  Documentation/devicetree/bindings/pci/samsung,pcie.yaml =7C 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
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
> ci/linux/Documentation/devicetree/bindings/pci/samsung,pcie.example.dtb
> : pcie=4015700000: reg-names:1: 'appl' was expected
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://protect2.fireeye.com/v1/url?k=3Db0812da3-d10a3895-b080a6ec-
> 74fe485fffe0-cf137b875436d997&q=3D1&e=3D09e1c000-01c6-48c4-8fff-
> 94e474b2862c&u=3Dhttps%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fdev
> icetree-bindings%2Fpatch%2F20230214121333.1837-6-
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

Thanks for review. Sorry, I missed to update the example. Will take care in=
 next patch set.

