Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3F56077F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiF2Rl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 13:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiF2Rl6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 13:41:58 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962F2AE3A;
        Wed, 29 Jun 2022 10:41:53 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220629174148usoutp013d5c37a78e4e58b093e03fb83cccc4ae~9KEOdL4Hx1805818058usoutp01c;
        Wed, 29 Jun 2022 17:41:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220629174148usoutp013d5c37a78e4e58b093e03fb83cccc4ae~9KEOdL4Hx1805818058usoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656524508;
        bh=VnHs2RnDDifbi76XGxcv7GObvNi0/pu7PRuljjR8vis=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=P5FtEcQEovVyI/cm1287m8iOykyZDulrGZgRos53KOC4JB845A3w/p5q8VxjHkBL4
         YMbEtj4S5ttseKGofgFiMIMFSt4MJ0UwfjlVgPQX1JNCabr1pbilDKE2bct1j/mCxP
         99CCUhcAch8UlM06+Z2foi2Me5pb+IlJ6Hjaaytw=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629174148uscas1p272ae90208dda5ce0a42fb4ac3d3e56de~9KENuxEvb1456314563uscas1p24;
        Wed, 29 Jun 2022 17:41:48 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 22.47.09642.BDE8CB26; Wed,
        29 Jun 2022 13:41:47 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629174147uscas1p211384ae262e099484440ef285be26c75~9KENgSnQJ1173611736uscas1p2e;
        Wed, 29 Jun 2022 17:41:47 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-ac-62bc8edbdf5d
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 04.F6.52349.BDE8CB26; Wed,
        29 Jun 2022 13:41:47 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Jun 2022 10:41:46 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        29 Jun 2022 10:41:46 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 01/46] tools/testing/cxl: Fix cxl_hdm_decode_init()
 calling convention
Thread-Topic: [PATCH 01/46] tools/testing/cxl: Fix cxl_hdm_decode_init()
        calling convention
Thread-Index: AQHYi9+BR05N/2uauk6b8y51LxKnvg==
Date:   Wed, 29 Jun 2022 17:41:46 +0000
Message-ID: <20220629174139.GA1139821@bgt-140510-bm01>
In-Reply-To: <165603870776.551046.8709990108936497723.stgit@dwillia2-xfh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB9E4D7DD30D564589DB36FF58D03051@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djX87q3+/YkGSx4ZWFx9/EFNovpUy8w
        WpyesIjJ4vysUywWZ+cdZ7NY+eMPq8XlE5cYHdg9Nq/Q8li85yWTx4vNMxk9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4MrY8+0ve8F04Yr+XY8YGxg/8HcxcnJICJhIvHx1hgnEFhJYySgx+7dkFyMX
        kN3KJLHsxUMWmKIL+xYyQyTWMkq87j7PBtHxiVGirysFIrGMUWLS/F+MIAk2AQOJ38c3MoPY
        IgLaEhPnHATrZhY4xSTx/ddPoLEcHMICMRKdk0ogamIldl9dxw5h60l0bu8AO4lFQFWi+ccH
        sJm8AmYSv5uWs4LYnAKeEkuO9YPNZxQQk/h+ag1YPbOAuMStJ/OZIK4WlFg0ew8zhC0m8W/X
        QzYIW1Hi/veX7BD1OhILdn9ig7DtJN6/2ws1R1ti2cLXzBB7BSVOznwCDQlJiYMrbrCA/CIh
        cIFDom/XDVaIhIvE74VNUAukJa5en8oMUdTOKPFhwj5WCGcCo8Sdtz+hqqwl/nVeY5/AqDIL
        yeWzkFw1C8lVs5BcNQvJVQsYWVcxipcWF+empxYb5aWW6xUn5haX5qXrJefnbmIEpqXT/w7n
        72C8fuuj3iFGJg7GQ4wSHMxKIrwLz+xMEuJNSaysSi3Kjy8qzUktPsQozcGiJM67LHNDopBA
        emJJanZqakFqEUyWiYNTqoGp8gm7bj/XfwMTE271NNGn/afWhbTzKkpxWFxze/+K8eapezH7
        3zJUu9g1/r7c/TbH8plEhvndTGGBfzsTjLfsVZtqz/b2b1ecRUzOgeYLfUuCsuL5Kmw/MM1Y
        9yjnjKGM6u57DrKM+wvvXFTr+PKMy9bGaD9f18Y7dj6Ff1jnHG879ZLx/uPfasW7fK4tZ+70
        ze4tb1H668e+iGnSx11ewvmfzCttCxdMnvjnkkmdtGf1TyGrdrXcPVce25uoVMjs7lu54aC2
        8G/+I6/mXft2NUInXnrKq2PMivyCIpeKZ1+VfLFk3/myHPEtAnFPBDwqnla9m8lX92F60FrJ
        77xL77Uv3rfDvHTC01VvjkxXYinOSDTUYi4qTgQA9TiwjLoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWS2cA0Ufd2354kg6NLNSzuPr7AZjF96gVG
        i9MTFjFZnJ91isXi7LzjbBYrf/xhtbh84hKjA7vH5hVaHov3vGTyeLF5JqPH501yASxRXDYp
        qTmZZalF+nYJXBl7vv1lL5guXNG/6xFjA+MH/i5GTg4JAROJC/sWMncxcnEICaxmlLjysI8J
        wvnEKLF2yR+ozDJGidlrDzGDtLAJGEj8Pr4RzBYR0JaYOOcgWBGzwCkmie+/frJ0MXJwCAvE
        SHROKoGoiZX4tfszE4StJ9G5vQPMZhFQlWj+8YERxOYVMJP43bScFWJZO6PEunNfWEASnAKe
        EkuO9YMtYxQQk/h+ag1YM7OAuMStJ/OZIH4QkFiy5zwzhC0q8fLxP1YIW1Hi/veX7BD1OhIL
        dn9ig7DtJN6/2ws1R1ti2cLXzBBHCEqcnPmEBaJXUuLgihssExglZiFZNwvJqFlIRs1CMmoW
        klELGFlXMYqXFhfnplcUG+allusVJ+YWl+al6yXn525iBMb06X+HI3cwHr31Ue8QIxMH4yFG
        CQ5mJRHehWd2JgnxpiRWVqUW5ccXleakFh9ilOZgURLnFXKdGC8kkJ5YkpqdmlqQWgSTZeLg
        lGpgypA2/aq+Ztnkkn2/TKdMFOUudF61L4srsWZR+c5tBwxyvgQuv75oV9EZtkDG92tDpfoP
        elSEOnXFRS8Li2c0OtLyafumnjmu20pMuY5oep4uDr4duEp/02SP/V27mX5Xfi6qUmHpFvR4
        6eC3Z1Nwv5WuQbCF1GvulTMOfsmJeqGzwfeL8EXeTKO8mn/PW52XpSxTvHOhrfpe5J6bRm7r
        XnS6vDn+vlsslUmP6WPpyi2fczJ0Lt5KDv990iyyb8dqp3mFE5Z/f3RZgW1P/NkLR8/m83oy
        B7hynVDNtttX9uZZrd6TQs+3jyz+ZhgkH9S/YyByZUo2u/7NRnc1F5u3fCvKOFWZFsawCxUa
        6TEqsRRnJBpqMRcVJwIA6iuWFFgDAAA=
X-CMS-MailID: 20220629174147uscas1p211384ae262e099484440ef285be26c75
CMS-TYPE: 301P
X-CMS-RootMailID: 20220629174147uscas1p211384ae262e099484440ef285be26c75
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603870776.551046.8709990108936497723.stgit@dwillia2-xfh>
        <CGME20220629174147uscas1p211384ae262e099484440ef285be26c75@uscas1p2.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:07PM -0700, Dan Williams wrote:
> This failing signature:
>=20
> [    8.392669] cxl_bus_probe: cxl_port endpoint2: probe: 970997760
> [    8.392670] cxl_port: probe of endpoint2 failed with error 970997760
> [    8.392719] create_endpoint: cxl_mem mem0: add: endpoint2
> [    8.392721] cxl_mem mem0: endpoint2 failed probe
> [    8.392725] cxl_bus_probe: cxl_mem mem0: probe: -6
>=20
> ...shows cxl_hdm_decode_init() resulting in a return code ("970997760")
> that looks like stack corruption. The problem goes away if
> cxl_hdm_decode_init() is not mocked via __wrap_cxl_hdm_decode_init().
>=20
> The corruption results from the mismatch that the calling convention for
> cxl_hdm_decode_init() is:
>=20
> int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlh=
dm)
>=20
> ...and __wrap_cxl_hdm_decode_init() is:
>=20
> bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_h=
dm *cxlhdm)
>=20
> ...i.e. an int is expected but __wrap_hdm_decode_init() returns bool.
>=20
> Fix the convention and cleanup the organization to match
> __wrap_cxl_await_media_ready() as the difference was a red herring that
> distracted from finding the bug.
>=20
> Fixes: 92804edb11f0 ("cxl/pci: Drop @info argument to cxl_hdm_decode_init=
()")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  tools/testing/cxl/test/mock.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.=
c
> index f1f8c40948c5..bce6a21df0d5 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -208,13 +208,15 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_sta=
te *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
> =20
> -bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> -				struct cxl_hdm *cxlhdm)
> +int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> +			       struct cxl_hdm *cxlhdm)
>  {
>  	int rc =3D 0, index;
>  	struct cxl_mock_ops *ops =3D get_cxl_mock_ops(&index);
> =20
> -	if (!ops || !ops->is_mock_dev(cxlds->dev))
> +	if (ops && ops->is_mock_dev(cxlds->dev))
> +		rc =3D 0;
> +	else
>  		rc =3D cxl_hdm_decode_init(cxlds, cxlhdm);
>  	put_cxl_mock_ops(index);
> =20
>=20


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> =
