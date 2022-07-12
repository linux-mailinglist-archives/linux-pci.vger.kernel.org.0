Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91957290D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiGLWLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 18:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiGLWLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 18:11:13 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43068BD394;
        Tue, 12 Jul 2022 15:11:08 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220712221103usoutp0226615f7f73ec5d3bacfe2e1fe6a1de04~BNIBNQtRu1022710227usoutp029;
        Tue, 12 Jul 2022 22:11:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220712221103usoutp0226615f7f73ec5d3bacfe2e1fe6a1de04~BNIBNQtRu1022710227usoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657663863;
        bh=iWyVIuuKN1RX5S4TsL6EoerpdN622CMVEKU5naRCKdc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZwIfvCd7eHcJADJavnvM4pE3zhTFp+NYiECTiRLCHuCIYkF98uyUYNTYFMDFzLwct
         iq8fi661XTT2keok8oue4EOJtiY3hAF1gl6XU95pfiRZ0s7eJfF5HauQ+jyhfe4Px+
         2bSeOpMPUhg6ymIaJmIJNh60oTq0awXSvLAsB1iY=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220712221103uscas1p25bd856c029123a60e5637302a17c3ee3~BNIA8fY7K2897928979uscas1p2Y;
        Tue, 12 Jul 2022 22:11:03 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id CF.06.09760.771FDC26; Tue,
        12 Jul 2022 18:11:03 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220712221103uscas1p2b5e7ab2a1074067efc8bd7af6bf92213~BNIAvilgr3161731617uscas1p2U;
        Tue, 12 Jul 2022 22:11:03 +0000 (GMT)
X-AuditID: cbfec36d-503ff70000002620-b6-62cdf1775a55
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id E2.79.52945.671FDC26; Tue,
        12 Jul 2022 18:11:02 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Jul 2022 15:11:02 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Tue,
        12 Jul 2022 15:11:02 -0700
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
Thread-Index: AQHYi9+BR05N/2uauk6b8y51LxKnvq12/GIAgATZvgA=
Date:   Tue, 12 Jul 2022 22:11:01 +0000
Message-ID: <20220712221055.GA1367622@bgt-140510-bm01>
In-Reply-To: <62c9dfcc4bd7c_2c74df294c1@dwillia2-xfh.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0189145084D414799F73CABBF917BD6@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djX87rlH88mGTR957K4+/gCm8X0qRcY
        LU5PWMRkcX7WKRaLs/OOs1ms/PGH1eLyiUuMDuwem1doeSze85LJ48XmmYwenzfJBbBEcdmk
        pOZklqUW6dslcGWcfbaTvWCGeMXrSzkNjHuFuhg5OSQETCRefdjO1sXIxSEksJJR4taqY+wQ
        TiuTxP2HXSwwVe0fWlggEmsZJV4f/wHlfGKU2LbgPDOEs4xR4unHZ8wgLWwCBhK/j28Es0UE
        tCUmzjkIVsQscIpJ4vuvn0DtHBzCAjESnZNKIGpiJXZfXccOYVtJ9DVPZQKxWQRUJVb9vQN2
        Bq+AmcSeh4tZQWxOAVuJuRdvgNUzCohJfD+1BqyeWUBc4taT+UwQZwtKLJq9hxnCFpP4t+sh
        G4StKHH/+0t2iHodiQW7P7FB2HYS+598gJqjLbFs4WtmiL2CEidnPoEGhaTEwRU3wL6XELjC
        IbH9QyfUAheJ3vW/oRZLS0xfcxmqqJ1R4sOEfawQzgRGiTtvf0KdYS3xr/Ma+wRGlVlILp+F
        5KpZSK6aheSqWUiuWsDIuopRvLS4ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwMZ3+dzh3B+OO
        Wx/1DjEycTAeYpTgYFYS4f1z9lSSEG9KYmVValF+fFFpTmrxIUZpDhYlcd5lmRsShQTSE0tS
        s1NTC1KLYLJMHJxSDUwpzZ5S7TXaO9/eOV0vvNKT3+TFdd7Drebnn29a8srkYqxoy53rZ89K
        mDLfmGX36b7IBsX9KvFbGaTCPM0PKOgeYry55HXu2bV3ndZcuns0YOLX9Qs9fGRfB6317mOv
        rJ+eeG8tf+fjuYtfZz45Pu35n7trDrpP9Mpb5LNyd5zO2jBx9jvHtoZ0d65efTT9eOtLnfJH
        7vmHrE9r7fG5snfqjLcH2e7skcnf2sT8plv5RqR7nwjjTbejr9/XL91d/efgD2s126eHjnu9
        Yuc//+sc3/Pio5/yag52fHC/8TjjpqHRu2vvBEtap4iwJzs/jxGLm3dCLfauR4qjjFhto4+m
        SUzZmsbgx/Wndjn3z+bcp8RSnJFoqMVcVJwIAPKe/CC7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWS2cA0Sbfs49kkgwmt5hZ3H19gs5g+9QKj
        xekJi5gszs86xWJxdt5xNouVP/6wWlw+cYnRgd1j8wotj8V7XjJ5vNg8k9Hj8ya5AJYoLpuU
        1JzMstQifbsEroyzz3ayF8wQr3h9KaeBca9QFyMnh4SAiUT7hxaWLkYuDiGB1YwSi6buZAJJ
        CAl8YpRY080HkVjGKDFpykxGkASbgIHE7+MbmUFsEQFtiYlzDjKDFDELnGKS+P7rJ9AoDg5h
        gRiJzkklEDWxEr92f2aCsK0k+pqngtksAqoSq/7eYQGxeQXMJPY8XMwKsWw3k8Sd7kNgRZwC
        thJzL95gB7EZBcQkvp9aAxZnFhCXuPVkPhPECwISS/acZ4awRSVePv7HCmErStz//pIdol5H
        YsHuT2wQtp3E/icfoOZoSyxb+JoZ4ghBiZMzn7BA9EpKHFxxg2UCo8QsJOtmIRk1C8moWUhG
        zUIyagEj6ypG8dLi4tz0imLjvNRyveLE3OLSvHS95PzcTYzAeD7973DMDsZ7tz7qHWJk4mA8
        xCjBwawkwvvn7KkkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwesRPjhQTSE0tSs1NTC1KLYLJM
        HJxSDUweTnVLj8360LLRwdfC48sNk+2tS7TSzE+/fZmx60yyWEqp3IokSd5y7s4XOed2f/ip
        Zux8rur/W42L/G4ZiQkHc/6cy4uIyZPYcHaBavXqH3u3yDadPHnswr92u9gboTksohMd9L+4
        /xFa3fJP/2qi2hrLSWX3Hnk0/n1xRvulylVJwVmL5Nm/HN3KKdzvM7MqUtfny865wuYXHHmv
        fP/2yels5KOq+5b2ji9cD64sfnm57/5H3YiOrKdCE4Qdm3euUl9oLpD364KL7YulPXpGU4Kv
        Ouv13lLYsfJenDD/Q8/mMC5hNdl5wRtyNeJTPzgunHHjqzrHlpV+Pgb1vwz3soVpHs3b7vtd
        vUix8YESS3FGoqEWc1FxIgCbuSsuVgMAAA==
X-CMS-MailID: 20220712221103uscas1p2b5e7ab2a1074067efc8bd7af6bf92213
CMS-TYPE: 301P
X-CMS-RootMailID: 20220629174147uscas1p211384ae262e099484440ef285be26c75
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603870776.551046.8709990108936497723.stgit@dwillia2-xfh>
        <CGME20220629174147uscas1p211384ae262e099484440ef285be26c75@uscas1p2.samsung.com>
        <20220629174139.GA1139821@bgt-140510-bm01>
        <62c9dfcc4bd7c_2c74df294c1@dwillia2-xfh.notmuch>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 09, 2022 at 01:06:36PM -0700, Dan Williams wrote:
> Adam Manzanares wrote:
> > On Thu, Jun 23, 2022 at 07:45:07PM -0700, Dan Williams wrote:
> > > This failing signature:
> > >=20
> > > [    8.392669] cxl_bus_probe: cxl_port endpoint2: probe: 970997760
> > > [    8.392670] cxl_port: probe of endpoint2 failed with error 9709977=
60
> > > [    8.392719] create_endpoint: cxl_mem mem0: add: endpoint2
> > > [    8.392721] cxl_mem mem0: endpoint2 failed probe
> > > [    8.392725] cxl_bus_probe: cxl_mem mem0: probe: -6
> > >=20
> > > ...shows cxl_hdm_decode_init() resulting in a return code ("970997760=
")
> > > that looks like stack corruption. The problem goes away if
> > > cxl_hdm_decode_init() is not mocked via __wrap_cxl_hdm_decode_init().
> > >=20
> > > The corruption results from the mismatch that the calling convention =
for
> > > cxl_hdm_decode_init() is:
> > >=20
> > > int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *=
cxlhdm)
> > >=20
> > > ...and __wrap_cxl_hdm_decode_init() is:
> > >=20
> > > bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct c=
xl_hdm *cxlhdm)
> > >=20
> > > ...i.e. an int is expected but __wrap_hdm_decode_init() returns bool.
> > >=20
> > > Fix the convention and cleanup the organization to match
> > > __wrap_cxl_await_media_ready() as the difference was a red herring th=
at
> > > distracted from finding the bug.
> > >=20
> > > Fixes: 92804edb11f0 ("cxl/pci: Drop @info argument to cxl_hdm_decode_=
init()")
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  tools/testing/cxl/test/mock.c |    8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/m=
ock.c
> > > index f1f8c40948c5..bce6a21df0d5 100644
> > > --- a/tools/testing/cxl/test/mock.c
> > > +++ b/tools/testing/cxl/test/mock.c
> > > @@ -208,13 +208,15 @@ int __wrap_cxl_await_media_ready(struct cxl_dev=
_state *cxlds)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
> > > =20
> > > -bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> > > -				struct cxl_hdm *cxlhdm)
> > > +int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> > > +			       struct cxl_hdm *cxlhdm)
> > >  {
> > >  	int rc =3D 0, index;
> > >  	struct cxl_mock_ops *ops =3D get_cxl_mock_ops(&index);
> > > =20
> > > -	if (!ops || !ops->is_mock_dev(cxlds->dev))
> > > +	if (ops && ops->is_mock_dev(cxlds->dev))
> > > +		rc =3D 0;
> > > +	else
> > >  		rc =3D cxl_hdm_decode_init(cxlds, cxlhdm);
> > >  	put_cxl_mock_ops(index);
> > > =20
> > >=20
> >=20
> >=20
> > Looks good.
> >=20
> > Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
>=20
> Just fyi, b4 did not auto-apply this tag due to the missing "-", caught
> it manually.

Ouch, thanks for pointing this out. Updated my template. =
