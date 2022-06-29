Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAB560535
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiF2QC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiF2QCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:02:40 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27383DA52;
        Wed, 29 Jun 2022 09:02:04 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220629160159usoutp0195aef3d891576469c34314f83fab9e0a~9ItEYhZw81476614766usoutp01V;
        Wed, 29 Jun 2022 16:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220629160159usoutp0195aef3d891576469c34314f83fab9e0a~9ItEYhZw81476614766usoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656518519;
        bh=tcYJ6cHRoPaK99gaiM2Fn2Barpu59KVVGgEcidot7eE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pbEedQV2nIliGVTv5KE6fPGzGACwGiB4DaPyrrAQDRtGY8StC41SyzCOGjfQIF+Gj
         m1BYyrZHEjF49mi1EGQf/xLByxR3lEGaDVdIcWtLaJKoou8F76jBEHeDzpADiR6Rk9
         dgZeS6kaeLK+lfxdmuaYQjYElwBHrVJvy7cSqco0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629160158uscas1p2e07b706b38c70042e938c4759d087c07~9ItD8looI1125111251uscas1p26;
        Wed, 29 Jun 2022 16:01:58 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id A6.2F.09749.6777CB26; Wed,
        29 Jun 2022 12:01:58 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629160158uscas1p2b7fbbe3a311de793c08e19e6f3d9a779~9ItDi7Lc10630706307uscas1p2l;
        Wed, 29 Jun 2022 16:01:58 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-ee-62bc7776c417
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 40.74.52945.6777CB26; Wed,
        29 Jun 2022 12:01:58 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Jun 2022 09:01:57 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        29 Jun 2022 09:01:57 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Lukas Wunner <lukas@wunner.de>, Ira Weiny <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Thread-Topic: (SPDM) Device attestation, secure channels from host to device
        etc: Discuss at Plumbers?
Thread-Index: AQHYhi3CI4u3mPMg/kOgHKynIq5wQa1e3nUAgAA0QYCAAATMgIAH9JUA
Date:   Wed, 29 Jun 2022 16:01:57 +0000
Message-ID: <20220629160149.GA1039216@bgt-140510-bm01>
In-Reply-To: <20220624153241.000055e2@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D57A0DB2AC729847B967819DD672713D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7djX87pl5XuSDGZNNLRoW7WPyWJJU4bF
        /7vPmSymT73AaLFzLavF6QmLmCz2P33OYrFq4TU2i87ZG9gtGnp+s1qcn3WKxeLsvONsFoc3
        nmGyePP7BbvFi+fSDvweTw7OY/JYM28No8eFxo2sHgs2lXq0HHnL6rF5hZbH4j0vmTyeXJnO
        5PHx6S0Wj8+b5DxmtG9jDeCO4rJJSc3JLEst0rdL4Mo4cukqY8FEwYpFfddZGhhn8HUxcnJI
        CJhITPh1mLWLkYtDSGAlo8TCjYuYIZxWJomGD3fYYarOXZrLCJFYyyjR1fWEHcL5BORMmg3l
        LGOU+HVuIhNIC5uAgcTv4xuZQWwRASOJK8sOgo1iFnjLInGs0RfEFhZIl7j0ag0jRE2GxPZX
        E4HqOYBsN4mbfxJAwiwCqhKnO/6ChXkFzCSuX7YHCXMKGEosaV4ENp1RQEzi+6k1TBDTxSVu
        PZnPBHG0oMSi2XuYIWwxiX+7HrJB2IoS97+/hLpGR2LB7k9sELadxJb951ghbG2JZQtfg/Xy
        As05OfMJC0SvpMTBFTdYQN6VENjNKfHp62mooS4Sy7feZYSwpSWmr7kMVdTOKPFhwj5WCGcC
        o8Sdtz+hOqwl/nVeY5/AqDILyeWzkFw1C8lVs5BcNQvJVQsYWVcxipcWF+empxYb56WW6xUn
        5haX5qXrJefnbmIEJsnT/w4X7GC8deuj3iFGJg7GQ4wSHMxKIrwLz+xMEuJNSaysSi3Kjy8q
        zUktPsQozcGiJM67LHNDopBAemJJanZqakFqEUyWiYNTqoGp8i979puDIpdb719ROiT03+kf
        l2YCC5thAtPLk7v/HNbL/qZotXrDfJO60t97u3Ok2g7zsySYi0Zndexb8KlthpyyqJr86jCe
        4tcBtlZ3g59vY7QW3XeHVcPJLv6M95e5j6TdujZoCn5fd8uj7doKG1nG7DB5/s9cZQuuTdjb
        zGNd/lMlSETq7OYtL8Q93iT8bF0aqsS8VWVfn26jHKOHoN+tsE33GhMY5t36oia6ZA3L/Iyt
        6qIfBddeLo+4/2H7HNfNsZktJmdZuQ+skVjXd+ZYhaHJ721qh155heZdqmhzCj50K1P65bOL
        qb8U7/T0iMYcFc+IC35zRvmcm9LZjQXnamrLFH+c7i3Rf6HEUpyRaKjFXFScCABFauaXAQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LJbGCapFtWvifJ4NluCYu2VfuYLJY0ZVj8
        v/ucyWL61AuMFjvXslqcnrCIyWL/0+csFqsWXmOz6Jy9gd2ioec3q8X5WadYLM7OO85mcXjj
        GSaLN79fsFu8eC7twO/x5OA8Jo8189Ywelxo3MjqsWBTqUfLkbesHptXaHks3vOSyePJlelM
        Hh+f3mLx+LxJzmNG+zbWAO4oLpuU1JzMstQifbsErowjl64yFkwUrFjUd52lgXEGXxcjJ4eE
        gInEuUtzGbsYuTiEBFYzSnR07mWCcD4xSqw7/gYqs4xR4t79TnaQFjYBA4nfxzcyg9giAkYS
        V5YdZAcpYhZ4yyKxbMFlJpCEsEC6xKVXaxghijIk3p2fyNbFyAFku0nc/JMAEmYRUJU43fGX
        GSTMK2Amcf2yPcSuNmaJi39Ogs3nFDCUWNK8CMxmFBCT+H5qDdh4ZgFxiVtP5jNBvCAgsWTP
        eWYIW1Ti5eN/rBC2osT97y/ZIep1JBbs/sQGYdtJbNl/jhXC1pZYtvA1WC+vgKDEyZlPWCB6
        JSUOrrjBMoFRYhaSdbOQjJqFZNQsJKNmIRm1gJF1FaN4aXFxbnpFsXFearlecWJucWleul5y
        fu4mRmB6Of3vcMwOxnu3PuodYmTiYDzEKMHBrCTCu/DMziQh3pTEyqrUovz4otKc1OJDjNIc
        LErivB6xE+OFBNITS1KzU1MLUotgskwcnFINTAK1ngcfMuQFdx451sZtdu7Gv+RL91NkVb8w
        d37cp9p3Xqe31ery1qg575Xuz70ZW2omK3FMdkrC3ddJdmbeXB757lNVrHfc9vTTN7j6RLq2
        Q877/qGehi9NO8PfiE3Zum//a3F/9dU79YREfussipkrsLP6hujdcPbmgu9bYkz7I/RjKwJK
        Cp4wf1a7bSjrE+cxRz5g5vGAQzcXmD7r+POwvGptzNLE/jx1nQKnVUJiBsH/paSvLw0p+jz/
        LI+R/VSjD298/ZQOzSnljlItWfY2+rmH1H4zLsHjXZvMa57yqujfUvs4ZWeYiWdkBvuCjD3n
        0mIOL+e7JOCmNv10pqaBqono4fTcp9e4pMOVWIozEg21mIuKEwHMjjvMngMAAA==
X-CMS-MailID: 20220629160158uscas1p2b7fbbe3a311de793c08e19e6f3d9a779
CMS-TYPE: 301P
X-CMS-RootMailID: 20220624143249uscas1p1ae96e45ccb5b3b4f22a5b863c7a6fc9f
References: <20220609124702.000037b0@Huawei.com>
        <YqICCSd/6Vxidu+v@iweiny-desk3> <20220617112124.00002296@Huawei.com>
        <20220620165217.GA18451@wunner.de> <20220622124638.00004456@Huawei.com>
        <20220624120830.00002eef@Huawei.com> <20220624141531.GA32171@wunner.de>
        <CGME20220624143249uscas1p1ae96e45ccb5b3b4f22a5b863c7a6fc9f@uscas1p1.samsung.com>
        <20220624153241.000055e2@Huawei.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 03:32:41PM +0100, Jonathan Cameron wrote:
> On Fri, 24 Jun 2022 16:15:31 +0200
> Lukas Wunner <lukas@wunner.de> wrote:
>=20
> > On Fri, Jun 24, 2022 at 12:08:30PM +0100, Jonathan Cameron wrote:
> > > I've put this in for now: =20
> >=20
> > Perfect!  For me as a non-native English speaker, it would have been
> > a lot more difficult to write up such an excellent description,
> > so thanks for doing this.
>=20
> It always feels a bit like cheating when you get to write these
> things in your first language!
> >=20
> > > Hence this proposal for a BoF rather than session in=20
> > > either PCI or CXL uconf. =20
> >=20

I am planning to be attending plumbers in person and am quite interested in=
=20
this BOF.


> > I think this has overlap with the Confidential Computing uconf as well,
> > so that might be another potentially interested audience.
> >=20
> > (Link encryption is by its very nature "confidential computing",
> > and attestation is explicitly mentioned on the CC uconf page:
> > https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D103=
69d39-71bd8872-10371676-74fe485fb305-1ce6f2197c6a68d6&q=3D1&e=3D6639a8eb-2d=
66-432f-a3d9-760b3e8def9f&u=3Dhttps*3A*2F*2Flpc.events*2Fevent*2F16*2Fcontr=
ibutions*2F1143*2F__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!UGKGabNBEqfdQU-FrF-b=
Enhwu9mRW4PRGa1LoMvehedU3XRfsZzuoHGUZUVWHVD3p26pNa-le6OwJPQwMs7wV4kiu9GUb9l=
d$  )
> >=20
> > Thanks,
> >=20
> > Lukas
> >=20
>=20
> Good point. That is an area in which we need dance around what we
> can an can't say (i.e. what is public from various standards orgs) but th=
ey=20
> may well still be interested.
>=20
> Added=20
> - Confidential compute community
> to list of people who might be interested.
>=20
> +CC Joerg so he knows this proposal exists and can perhaps drag in anyone
> else who might be interested.
>=20
> https://urldefense.com/v3/__https://lore.kernel.org/all/20220624120830.00=
002eef@Huawei.com/__;!!EwVzqGoTKBqv-0DWAJBm!UGKGabNBEqfdQU-FrF-bEnhwu9mRW4P=
RGa1LoMvehedU3XRfsZzuoHGUZUVWHVD3p26pNa-le6OwJPQwMs7wV4kiu68CJwlU$=20
> for abstract.
>=20
> Thanks,
>=20
> Jonathan
> =
