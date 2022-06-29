Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F10560B16
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 22:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiF2Uew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 16:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF2Uev (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 16:34:51 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895692C10C;
        Wed, 29 Jun 2022 13:34:49 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220629203448usoutp02318847ae62d98267869b8f184374df8a~9MbRdlW-t1403414034usoutp02d;
        Wed, 29 Jun 2022 20:34:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220629203448usoutp02318847ae62d98267869b8f184374df8a~9MbRdlW-t1403414034usoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656534888;
        bh=lXomARyTOr4zgBrO/xc7GHtTIlPV1c04Hr27zgTgCDo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=DoXDYnTU9wJUhHg0M+dJvd6R5eELNa1IpQhmZRsSdXjD5XvtmRCwfJRBDo75/EmRD
         /MLQvbFVRfnkXhoW6gVJFii6Xk6V4Ci81G1kWeMKjb++6/XGm+wyQM61wFd+5GrCWa
         gcOReMFB2voO/ZsLw15IUWNbjR170WvjY4hqRBzk=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220629203448uscas1p105d46b03604938b494e3acea4abe6ad6~9MbRM8mXt2673826738uscas1p1H;
        Wed, 29 Jun 2022 20:34:48 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 35.93.09760.867BCB26; Wed,
        29 Jun 2022 16:34:48 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629203448uscas1p264a7f79a1ed7f9257eefcb3064c7d943~9MbQ1nqLU1740317403uscas1p2U;
        Wed, 29 Jun 2022 20:34:48 +0000 (GMT)
X-AuditID: cbfec36d-51bff70000002620-64-62bcb76802ee
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id E2.9A.57470.767BCB26; Wed,
        29 Jun 2022 16:34:47 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Jun 2022 13:34:47 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        29 Jun 2022 13:34:47 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 06/46] cxl/core: Drop is_cxl_decoder()
Thread-Topic: [PATCH 06/46] cxl/core: Drop is_cxl_decoder()
Thread-Index: AQHYi/esL78qDLSsR02eEE+HvYuomA==
Date:   Wed, 29 Jun 2022 20:34:47 +0000
Message-ID: <20220629203440.GA1140902@bgt-140510-bm01>
In-Reply-To: <165603874340.551046.15491766127759244728.stgit@dwillia2-xfh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5997976DCBC30F47BE34FFBE44886E3B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djXc7oZ2/ckGSx4LGpx9/EFNovpUy8w
        WpyesIjJ4vysUywWZ+cdZ7NY+eMPq8XlE5cYHdg9Nq/Q8li85yWTx4vNMxk9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mp492s5a8FN3ooJ504zNzBu5+5i5OSQEDCR2Ln5PGMXIxeHkMBKRok59yey
        QTitTBKPH3Wxw1T9+7ySFSKxllHi4ptJUFWfGCVO338I5SxjlNg3fR8LSAubgIHE7+MbmUFs
        EQFtiYlzDjKDFDELnGKS+P7rJ1iRsICVxNPlZ6GKrCU+XPvDCGHrSTx9fp0NxGYRUJV4OOEW
        WA2vgJnEv4dfwOKcAl4SH56sBbuPUUBM4vupNUwgNrOAuMStJ/OZIO4WlFg0ew8zhC0m8W/X
        QzYIW1Hi/veX7BD1OhILdn9ig7DtJF4cbGKEsLUlli18DbVXUOLkzCcsEL2SEgdX3GABeUZC
        4AKHxIm1bVDLXCT+b7kODTBpib93lzFBFLUzSnyYsI8VwpnAKHHn7U+oM6wl/nVeY5/AqDIL
        yeWzkFw1C8lVs5BcNQvJVQsYWVcxipcWF+empxYb5qWW6xUn5haX5qXrJefnbmIEJqfT/w7n
        7mDcceuj3iFGJg7GQ4wSHMxKIrwLz+xMEuJNSaysSi3Kjy8qzUktPsQozcGiJM67LHNDopBA
        emJJanZqakFqEUyWiYNTqoGJ3+k2j22Zzor43Wwd9379t5pzZ5uc907WzT2VlacWijaeF+fu
        vmaTFvOn+qWZUeqb9+0vVzZc8rv/8Mye1qe33ovPWfDs7v6m9ZmSCbISbj6ljBzbAu+tWPo7
        fpp7SeOjaVM0zUJUfmo/VIpzkCp8dpWx/Z/aRL31TgXOfNlbVxwU42zc80pkSpjxuSe/FpY+
        jJkwI/vXi1z/6V87p/UUZzxwa71r+zn6gXjD1nWVvVmCHUvLhWJ/cgSEv7i29rXPlf1SkfeP
        VrX/yHp6eUelglEOi9+dErUVzh4mtUV3xHO8XRb+EpB937YlySA1Sognv85r1oP10zuyFpZG
        TOSW1nx3xfZrwcbovi1lnx4osRRnJBpqMRcVJwIArRGlvr0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWS2cA0STd9+54kg8WTDCzuPr7AZjF96gVG
        i9MTFjFZnJ91isXi7LzjbBYrf/xhtbh84hKjA7vH5hVaHov3vGTyeLF5JqPH501yASxRXDYp
        qTmZZalF+nYJXBnvfi1nLbjJWzHh3GnmBsbt3F2MnBwSAiYS/z6vZO1i5OIQEljNKHH8yHEW
        COcTo8ShhW1MEM4yRolrF3eygbSwCRhI/D6+kRnEFhHQlpg45yAzSBGzwCkmie+/frKAJIQF
        rCSeLj8LVWQt8eHaH0YIW0/i6fPrYINYBFQlHk64BVbDK2Am8e/hFzaIbR2MEgeP/wQr4hTw
        kvjwZC07iM0oICbx/dQaJhCbWUBc4taT+UwQTwhILNlznhnCFpV4+fgfK4StKHH/+0t2iHod
        iQW7P7FB2HYSLw42MULY2hLLFr6GOkJQ4uTMJywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJR
        s5CMWsDIuopRvLS4ODe9otgoL7Vcrzgxt7g0L10vOT93EyMwqk//Oxy9g/H2rY96hxiZOBgP
        MUpwMCuJ8C48szNJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/LqInxQgLpiSWp2ampBalFMFkm
        Dk6pBqYpoesiT9oeum2ZoPa4c9uhq9LhvcF1gllakT+6J2xZdTaC42CDtoVokkJD0+TjyUlf
        7r1rNmeyPtnncTWFQaVBoI9ZMfnRFu3o+11rJhxWzjd8MXHF8y1aE1aGVwt3FTPMz67oWGrx
        eWOF3c+jFYc8rltP7zxxUOhJX4bk5GuPLeJkFNsvapWcuWvmsj/1z5HfHlmWYe9mN6nUiJft
        Orqa+cj9c18l253ELtXmRwrdOybhyR2iJX7q39VrrqdYQ1UyLhU3ZxTNWPj89dJpTBUP2Q5F
        TZ+sWrxZIiwpZsoWSct1t/9Xme27rrSb0cah4GT5YVUjlbBT6vqlTcxVH3fZXdFIfxF3Qewz
        sz3zMSWW4oxEQy3mouJEAE/EosJZAwAA
X-CMS-MailID: 20220629203448uscas1p264a7f79a1ed7f9257eefcb3064c7d943
CMS-TYPE: 301P
X-CMS-RootMailID: 20220629203448uscas1p264a7f79a1ed7f9257eefcb3064c7d943
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603874340.551046.15491766127759244728.stgit@dwillia2-xfh>
        <CGME20220629203448uscas1p264a7f79a1ed7f9257eefcb3064c7d943@uscas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:43PM -0700, Dan Williams wrote:
> This helper was only used to identify the object type for lockdep
> purposes. Now that lockdep support is done with explicit lock classes,
> this helper can be dropped.
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c |    6 ------
>  drivers/cxl/cxl.h       |    1 -
>  2 files changed, 7 deletions(-)
>=20
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b51eb41aa839..13c321afe076 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -271,12 +271,6 @@ bool is_root_decoder(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
> =20
> -bool is_cxl_decoder(struct device *dev)
> -{
> -	return dev->type && dev->type->release =3D=3D cxl_decoder_release;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_cxl_decoder, CXL);
> -
>  struct cxl_decoder *to_cxl_decoder(struct device *dev)
>  {
>  	if (dev_WARN_ONCE(dev, dev->type->release !=3D cxl_decoder_release,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 35ce17872fc1..6e08fe8cc0fe 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -337,7 +337,6 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_po=
rt *port,
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
> -bool is_cxl_decoder(struct device *dev);
>  struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  					   unsigned int nr_targets);
>  struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>=20
>

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
