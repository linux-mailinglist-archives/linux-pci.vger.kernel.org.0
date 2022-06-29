Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659F256079C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 19:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiF2Rq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiF2Rq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 13:46:26 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178963AA7D;
        Wed, 29 Jun 2022 10:46:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220629174623usoutp02bf63d98dd973781afcca64057fc979d8~9KIOIIVZ30568505685usoutp02v;
        Wed, 29 Jun 2022 17:46:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220629174623usoutp02bf63d98dd973781afcca64057fc979d8~9KIOIIVZ30568505685usoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656524783;
        bh=GD1vU5h6mRyxGY0KIGc7Vki7/E+WPAS3HZ04QFjyZNQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jw+r3bDnlIvpJOaMBTw4yWL0NccKC+jg6FBfNo41GWsu2UHIkMEQmMS+BPS+PsUz8
         bwGPiRsHcvvOwJ95udzjyOzUqXTfGFein7VN2JwUHEtZJUcFjuPTZi2hi6Gr2VPQHt
         fyp4JwElLHPJsAIk/rI5w5/B+r+01tc7uZw0ellk=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629174623uscas1p23ce40b9ff6c4ce7fba54479b317b90b0~9KIN9LSmC2222022220uscas1p2L;
        Wed, 29 Jun 2022 17:46:23 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 7E.BB.09749.FEF8CB26; Wed,
        29 Jun 2022 13:46:23 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629174622uscas1p2236a084ce25771a3ab57c6f006632f35~9KINvfbtB2126221262uscas1p2e;
        Wed, 29 Jun 2022 17:46:22 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-7d-62bc8feff7d5
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id C1.76.52945.EEF8CB26; Wed,
        29 Jun 2022 13:46:22 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Jun 2022 10:46:22 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        29 Jun 2022 10:46:22 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 02/46] cxl/port: Keep port->uport valid for the entire
 life of a port
Thread-Topic: [PATCH 02/46] cxl/port: Keep port->uport valid for the entire
        life of a port
Thread-Index: AQHYi+Al+3mugtmgg0G1bAQs/bDPgA==
Date:   Wed, 29 Jun 2022 17:46:22 +0000
Message-ID: <20220629174621.GB1139821@bgt-140510-bm01>
In-Reply-To: <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <169DC7407D0E1C44AA1111688B856697@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+845m8fB6Kgr39bdlEJrFkUMHboiYhHR/aZFHe2kI122zS4G
        eQlbLaEVqTgvZZqXsshJXmpFLc3mLLWLNStCssxSdJnO5aXajsH+e573ed7v+/Hxkbh3KUdI
        yhVqRqmg4/y4PKL66dCLJf0XjFFLz5zliD9+buWKszNbkdiiu4aJW/RNhPh5QSNXXD4yxhG/
        evYSST1kVWWBsiJjDyb7VpWDZIOGOZuICJ7kABMnP8oog8P282KL3/8hEvL4x7ubv+ApqJ+n
        RSQJ1ArobpNpEY/0psoRXG7JIFiTjkFt+gOkRZ6uUqvGiLHBLQSXKsc5rPmJwJBhQqwpQeDI
        H8adK1xqKYw2Vrq0gAqCi3mPcWcJp5owsP92EM7Ah4oEg8aO2NIeSM264eGEElAiMKfJnWOC
        CoBSazPuHPOplWC7n+wce1LrIFvXiTk1oqaDvanCpXHKFzq6rmAstRdcyzXirJ4OE/c6uaye
        D5/sPR5sfzFcvf+Ty+oweNs7hLM6CEoKf7g0/9855pwugt2dAY/L3rmeCKjXJORnOThssAau
        F1VMXjwTsiteTZY0CAZ0Dzms0SH40OeYxAiFiXPtHjrkr3cj17tR6d2o9G5Uejeqq4hzA/km
        qlTxMYxquYI5JlLR8apERYwo+nC8Af37S5aJJwm1qKPDJjIhjEQmBCTuJ+AXNtdFefMP0CeS
        GOXhfcrEOEZlQjNJws+XXyK/Q3tTMbSaOcQwCYzyf4qRnsIUrGE4tH2wxXddZceu2lnRZtGC
        On/RdoGFLj+IhUelychRqfp8Pf1x/KQGC20c19Z150p9rI+mRk5paIhI7x1iNrStXVgTgL/B
        ckyrgszhuRE1VuHXadrIXQ7jkYPDeyVVBh9JSEBBD55lUAPT1++I9Rr6deFUwYBhd9vWzZkn
        dwjmnV5WNs2Utvqlf75sU2tmRkbxRsHp0a+L5F6FD0ZmfTifFn3rrmHtKZ+K2wNSRnemJ+TK
        21TKEpyzc2X9JebmtvrXzw7129QBcxW7L4dpUn/9aG+fXbJXIu21ckbMIfXEmDXJnre+2RYs
        NG+5WJ1dfvT2m3Hh9w2rJdU2i/lJsh+hiqWXBeJKFf0XOFiyIroDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWS2cA0Sfdd/54kg7ebDCzuPr7AZjF96gVG
        i9MTFjFZnJ91isXi7LzjbBYrf/xhtbh84hKjA7vH5hVaHov3vGTyeLF5JqPH501yASxRXDYp
        qTmZZalF+nYJXBlLbv9nKZjDW/H8zFPmBsb3XF2MnBwSAiYSF9r3MHUxcnEICaxmlLjZs40Z
        wvnEKDH/8Sw2CGcZo0Tju/+MIC1sAgYSv49vZAaxRQS0JSbOOQjWwSxwikni+6+fLCAJYYFo
        iU3t3xkhimIkXu45DWRzANl6EiebMkHCLAKqEstvnmEGCfMKmEl83F0PsaudUeLY94Vg8zkF
        PCWmT3jIBGIzCohJfD+1BsxmFhCXuPVkPhPECwISS/acZ4awRSVePv7HCmErStz//pIdol5H
        YsHuT2wQtp3E9TdfmSFsbYllC1+D2bwCghInZz5hgeiVlDi44gbLBEaJWUjWzUIyahaSUbOQ
        jJqFZNQCRtZVjOKlxcW56RXFxnmp5XrFibnFpXnpesn5uZsYgRF9+t/hmB2M92591DvEyMTB
        eIhRgoNZSYR34ZmdSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5PWInxgsJpCeWpGanphakFsFk
        mTg4pRqY1LeusNOq/8+2YO53ryuqX/bO2mF7LvSEUpvtu0lqd/zyJfIO608w9/25/up7jihZ
        8QhTQ4nzj0OKEp+3ra+7e2mT4rQy3e+VAq3TRW6Eb5e5bXDZTG/SwyimHP785q1Vq4W66q+l
        aU6/cCn4a7Hp86tNr+ct4vPKKbOfvFL4VMqHkxXX2s8vlPNy7Qk4dHbhGVkDywXT1kXbaLoU
        cR9xrbr9v3+Bo2Lo4t09oTcibCMjmj/u5Wk4vmjr6vjPBUFt975PONl01vDaQxGfbIHLmzvq
        Qj+Wal+5ZaaUvdVfX+hpyv/TVVdXXjrs/JxlvuTzGN8TZgsrLJovcgZ6rFn6WebiYWvBE5+2
        sy5j75W+o8RSnJFoqMVcVJwIAPi8+YtXAwAA
X-CMS-MailID: 20220629174622uscas1p2236a084ce25771a3ab57c6f006632f35
CMS-TYPE: 301P
X-CMS-RootMailID: 20220629174622uscas1p2236a084ce25771a3ab57c6f006632f35
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
        <CGME20220629174622uscas1p2236a084ce25771a3ab57c6f006632f35@uscas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:14PM -0700, Dan Williams wrote:
> The upcoming region provisioning implementation has a need to
> dereference port->uport during the port unregister flow. Specifically,
> endpoint decoders need to be able to lookup their corresponding memdev
> via port->uport.
>=20
> The existing ->dead flag was added for cases where the core was
> committed to tearing down the port, but needed to drop locks before
> calling device_unregister(). Reuse that flag to indicate to
> delete_endpoint() that it has no "release action" work to do as
> unregister_port() will handle it.
>=20
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index dbce99bdffab..7810d1a8369b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -370,7 +370,7 @@ static void unregister_port(void *_port)
>  		lock_dev =3D &parent->dev;
> =20
>  	device_lock_assert(lock_dev);
> -	port->uport =3D NULL;
> +	port->dead =3D true;
>  	device_unregister(&port->dev);
>  }
> =20
> @@ -857,7 +857,7 @@ static void delete_endpoint(void *data)
>  	parent =3D &parent_port->dev;
> =20
>  	device_lock(parent);
> -	if (parent->driver && endpoint->uport) {
> +	if (parent->driver && !endpoint->dead) {
>  		devm_release_action(parent, cxl_unlink_uport, endpoint);
>  		devm_release_action(parent, unregister_port, endpoint);
>  	}
>=20
>


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
