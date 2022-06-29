Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723BB560AD8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 22:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiF2UDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 16:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiF2UDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 16:03:22 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7896237CA;
        Wed, 29 Jun 2022 13:03:18 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220629200313usoutp02af2c71230e9976d49b496d6c430e0c9f~9L-sClPYy2008920089usoutp02b;
        Wed, 29 Jun 2022 20:03:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220629200313usoutp02af2c71230e9976d49b496d6c430e0c9f~9L-sClPYy2008920089usoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656532993;
        bh=b8kZMXueIyXsCuYB0ERS+5vaIE6v3zttPhNANzXvvB0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BnJNnHkME4dmNrtgEDY087HKU6SwXG73uICFn6j7YMpCw4q1hsA5nTqhbrO6N6z1R
         u5u+DDT0f6ufT2KZQKpx39G7Vs/pJBvQHqS/iH1WkGFt+67N0xvFCiqAE8g42nH29s
         UczpSVW64TNzaA3eDGep9A1MENpUvoo1AZbH8sMQ=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629200312uscas1p215029cd690a730a55f9633ad698b5cb7~9L-rzC70z2285622856uscas1p2j;
        Wed, 29 Jun 2022 20:03:12 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 59.69.09642.000BCB26; Wed,
        29 Jun 2022 16:03:12 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629200312uscas1p292303b9325dcbfe59293f002dc9e6b03~9L-rjA4u82091020910uscas1p2g;
        Wed, 29 Jun 2022 20:03:12 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-8f-62bcb000c7c0
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id A3.B8.52945.000BCB26; Wed,
        29 Jun 2022 16:03:12 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Jun 2022 13:03:11 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        29 Jun 2022 13:03:11 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 03/46] cxl/hdm: Use local hdm variable
Thread-Topic: [PATCH 03/46] cxl/hdm: Use local hdm variable
Thread-Index: AQHYi/NCdOli68RSBE2xziq02ThdiA==
Date:   Wed, 29 Jun 2022 20:03:11 +0000
Message-ID: <20220629200303.GA1140419@bgt-140510-bm01>
In-Reply-To: <165603872171.551046.913207574344536475.stgit@dwillia2-xfh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1570C75012F9346845CADF7D59784E1@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djX87oMG/YkGRw9omdx9/EFNovmyYsZ
        LaZPvcBocXrCIiaL87NOsVicnXeczWLljz+sFpdPXGJ04PDYvELLY/Gel0wem1Z1snm82DyT
        0ePzJrkA1igum5TUnMyy1CJ9uwSujLtXHrEV/GCveLJ9InsD41a2LkZODgkBE4lJr1YwdzFy
        cQgJrGSU+HjmLStIQkiglUni3BF3mKIbc/YwQhStZZSY8XsdC4TziVHibf9/dghnGaPE5s0v
        WUBa2AQMJH4f38gMYosIaEtMnHMQzGYWeMck0XkqBMQWFrCS+NPxkwWixlri4PT3jBC2nsTF
        ib1gZ7AIqEpcuDwdrIZXwExiw4/vQHM4ODgFPCReH68HCTMKiEl8P7WGCWK8uMStJ/OZIK4W
        lFg0ew8zhC0m8W/XQ6iXFSXuf3/JDlGvI7Fg9yc2CNtOYvnR0ywQtrbEsoWvmSHWCkqcnPmE
        BaJXUuLgihtgz0sIPOCQ+LtrAiNEwkXi1KbDUEXSEtPXXIYqameU+DBhHyuEM4FR4s7bn1Bn
        WEv867zGPoFRZRaSy2chuWoWkqtmIblqFpKrFjCyrmIULy0uzk1PLTbKSy3XK07MLS7NS9dL
        zs/dxAhMVaf/Hc7fwXj91ke9Q4xMHIyHGCU4mJVEeBee2ZkkxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnHdZ5oZEIYH0xJLU7NTUgtQimCwTB6dUA1P4qrnb5y5f5MQpUCOiEOyfkOHxTUOHa7m7
        w5MXvs5ZP8+WpsrU5S4Vvv4lXqO95NLSH0XZj5e1zOWv8jXeXLtp7exkvVbmrOTnc7/fk/ER
        nMDG6erivJKHL231k6UNHJptfyO/Zhpfjv+ZJL4l4Ziv06W7jRxRxU4t5UyyrKITTu/aJHvz
        xrGnNrcXVTvqfdyewCmhfLPoSqtz/Jc7HWVlDnG2Nx5/fLJrus6yFM6MVXutnwgImQpMsSiS
        ybM9kjBtzbv2slQP7b4ZC+5PmafmmGIh9NonP+CX99X+1IevOt6s/e3B2MQUMsfjiuCp48t+
        9Irt2ftX686dae2zI8TkatmWVgflhcZOSVt0Q4mlOCPRUIu5qDgRAGDcf1/EAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWS2cA0UZdhw54kg5XrpCzuPr7AZtE8eTGj
        xfSpFxgtTk9YxGRxftYpFouz846zWaz88YfV4vKJS4wOHB6bV2h5LN7zkslj06pONo8Xm2cy
        enzeJBfAGsVlk5Kak1mWWqRvl8CVcffKI7aCH+wVT7ZPZG9g3MrWxcjJISFgInFjzh7GLkYu
        DiGB1YwSP9/MYodwPjFK7G3rYYZwljFKrN99gR2khU3AQOL38Y3MILaIgLbExDkHwWxmgXdM
        Ep2nQkBsYQEriT8dP1kgaqwlDk5/zwhh60lcnNjLCmKzCKhKXLg8HayGV8BMYsOP71DL2hgl
        JvzYBdTAwcEp4CHx+ng9SA2jgJjE91NrmCB2iUvcejKfCeIFAYkle84zQ9iiEi8f/2OFsBUl
        7n9/yQ5RryOxYPcnNgjbTmL50dMsELa2xLKFr5khbhCUODnzCQtEr6TEwRU3WCYwSsxCsm4W
        klGzkIyahWTULCSjFjCyrmIULy0uzk2vKDbOSy3XK07MLS7NS9dLzs/dxAiM8tP/DsfsYLx3
        66PeIUYmDsZDjBIczEoivAvP7EwS4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusROzFeSCA9sSQ1
        OzW1ILUIJsvEwSnVwFR78+v/zCNHVISdMk/5aEq123yfW7f7Svft4J7dWW+qItVLxdt28Vfu
        ybnIvvGYsubPVbdcVMo3MBpfUzoSm3HnpJwm63uuS5u7bvQ4fz+z2Kf1+bFjVV4Z3VVzHk9f
        orZ9woLNf3nvS3iuUnwXuyfkU/65Nu+mTQIz3fyW+M93m7CldGlI0fuSJ3ktJ0x123+vc+Du
        28bxQHZOXvJ3/niPgvSCl20hGxdF2Qo0fza9ZF4a8nfHpMzD5d1PGO5ybXqh/+gUY3s985VH
        59h1ptaGPM/8rbn0zBLFgEYZ8Y2VK27Ms5r+Uf2fh/f1V/W72goqd/1feYTfLflhzCFtBbtD
        b+zWmr/5MPtUzSp2uXglluKMREMt5qLiRAAz2mPYYQMAAA==
X-CMS-MailID: 20220629200312uscas1p292303b9325dcbfe59293f002dc9e6b03
CMS-TYPE: 301P
X-CMS-RootMailID: 20220629200312uscas1p292303b9325dcbfe59293f002dc9e6b03
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603872171.551046.913207574344536475.stgit@dwillia2-xfh>
        <CGME20220629200312uscas1p292303b9325dcbfe59293f002dc9e6b03@uscas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:21PM -0700, Dan Williams wrote:
> From: Ben Widawsky <bwidawsk@kernel.org>
>=20
> Save a few characters and use the already initialized local variable.
>=20
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index bfc8ee876278..ba3d2d959c71 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -251,8 +251,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhd=
m)
>  			return PTR_ERR(cxld);
>  		}
> =20
> -		rc =3D init_hdm_decoder(port, cxld, target_map,
> -				      cxlhdm->regs.hdm_decoder, i);
> +		rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i);
>  		if (rc) {
>  			put_device(&cxld->dev);
>  			failed++;
>=20
>=20


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
