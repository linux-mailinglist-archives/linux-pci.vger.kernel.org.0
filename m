Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A13560AE4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiF2UG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiF2UG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 16:06:56 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6826537A2F;
        Wed, 29 Jun 2022 13:06:54 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220629200652usoutp017632479d5c2490f62cf38798f02dc363~9MC4jH4j40428004280usoutp01p;
        Wed, 29 Jun 2022 20:06:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220629200652usoutp017632479d5c2490f62cf38798f02dc363~9MC4jH4j40428004280usoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656533212;
        bh=/IoM1KK1CcRx1w4832PsJFqPvldv6jIT18MLDHAvc4A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=uf/sSPvoYXk25ky4lbYCuANiBRXrTHDCc3Jtpq/RfSwwKUN5CB49A3EDU/ji3RZmw
         DBxNABjJkLt3YLVXAMbNzqCep+/vUjLitOsqOwXrLEqOpRy2lx+pdACuzvQ2xsmhpw
         LnjxArEmUH1cgbgVq2w/Z4r34Ey6hjOxQHY9Peng=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629200652uscas1p2beebb906c1d4c5dcdb7b5f865aec14ab~9MC4a1Gvp3043730437uscas1p2c;
        Wed, 29 Jun 2022 20:06:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 90.F9.09642.CD0BCB26; Wed,
        29 Jun 2022 16:06:52 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629200652uscas1p2c1da644ea63a5de69e14e046379779b1~9MC4C2L5L3087730877uscas1p2k;
        Wed, 29 Jun 2022 20:06:52 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-e7-62bcb0dc8fb9
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id DA.39.52349.BD0BCB26; Wed,
        29 Jun 2022 16:06:51 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Jun 2022 13:06:51 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        29 Jun 2022 13:06:51 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 04/46] cxl/core: Rename ->decoder_range ->hpa_range
Thread-Topic: [PATCH 04/46] cxl/core: Rename ->decoder_range ->hpa_range
Thread-Index: AQHYi/PFFQgs9g8Oik+SZcMM94kI2w==
Date:   Wed, 29 Jun 2022 20:06:51 +0000
Message-ID: <20220629200651.GB1140419@bgt-140510-bm01>
In-Reply-To: <165603872867.551046.2170426227407458814.stgit@dwillia2-xfh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C853A7C8CEE724398AA551930773CD4@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRTHnd1tu60pGQrKAwyJjUS8aBEkNWqjxsR6xCt4a7TqBgnQapeq
        eCQ14kWiFkW0KxYKBkExAfHmkEM5CgoBBVGIon6QGJVSFLyqtluTfvu9ef8375fJ0KSsUBBC
        J+hSGINOmyQXSqg79V9bp/WUVGxT5v4JUfW+axOqLpxvQ6pmcx6hauXslOqJtUGoKhr5JVB1
        NLajuSJNWeFkTX5FP6H5UGZBGufNsBXUBsnsHUxSwh7GoFBvlexsyTHu6g3e15fRT5hQR2A6
        EtOAY+BJ7TlhOpLQMlyEwPH4LcEXRwlI76gi/qe43gGKb9xAcNLc6B0ZRNBpOSZyp2S4AIF9
        aLObhVgJPxtKSTcH4imQkV1DugdIbCdg+Md3yt0IwAuh6sgzAR/SQG/jFYrnSKh8avacUzgc
        6prKPRdJcSxcspo9SmK8CKquvfEwwmNh2F7sYRIHwcv3OV5tf8i7VEHyPBZcD/qEPI+H18P9
        Ij4/FXLLB4U8q6Hifh7F8xQosH307vWHJst7ip8NhprCF56nANxCg6mhwbtgAZQ5PyGeQ+F5
        13mSDx1HMGCuEvCFGUHPp+9ejVngOtkpMqMJnI8552PF+VhxPlacj1UuElxDQUaWTY5n2Ok6
        Zm8kq01mjbr4yO365Jvo32dqdtXp76Gul47IWkTQqBYBTcoDpbaW+9tk0h3a1P2MQb/FYExi
        2FoUSlPyIGlBQolWhuO1KUwiw+xiDP+7BC0OMRGKIf2o2NaU8InO0sWHtoYJJV1Wh+bg87jy
        JOdh65yIz4p6HRv++eLI4yP3uocuL1swLzQias/G+VRaQpsyYNMSRUz2N7ykpzTixGn1n6zZ
        4q9ptjF9B54+bF7eneVoz3gUbRKsLbme1j7tbY3f3TnrZEUcN+IYI1JuSB3NuA4HJBod/WuK
        K8/iX2frn9mW3ZanVIvVL6KWr42eL3XsP9gD6nznhKuugr2bH2Y2v1FGdBQnzvvSmCdeHxcT
        bfkx05Dpv9RWvTJ2oKnYr1txtyvqzuqw9KZxr+qW6lPTElWnj9tiM/NvVeYE28/M3D1JfeqD
        tZP5vQrWW0wlM3B3td+g+YacYndqoyaTBlb7F6d0/7a7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWS2cA0SffOhj1JBgcELO4+vsBmMX3qBUaL
        0xMWMVmcn3WKxeLsvONsFit//GG1uHziEqMDu8fmFVoei/e8ZPJ4sXkmo8fnTXIBLFFcNimp
        OZllqUX6dglcGWfmlxbclax4OPElUwPjZZEuRk4OCQETiVl3P7B0MXJxCAmsZpR4vPcilPOJ
        UeLH5O1QzjJGiZb1z9lBWtgEDCR+H9/IDGKLCGhLTJxzkBmkiFngFJPE918/WUASwgLuEvua
        r7BCFHlI3D2xhAXC1pPYe24CWJxFQFXi8MndYIN4BcwkZs+bwASxrZ1R4n7HLbAEp4CnxL5V
        D5hAbEYBMYnvp9aA2cwC4hK3nsxngnhCQGLJnvPMELaoxMvH/1ghbEWJ+99fskPU60gs2P2J
        DcK2k9izcxELhK0tsWzha6gjBCVOznzCAtErKXFwxQ2WCYwSs5Csm4Vk1Cwko2YhGTULyagF
        jKyrGMVLi4tz0yuKDfNSy/WKE3OLS/PS9ZLzczcxAiP69L/DkTsYj976qHeIkYmD8RCjBAez
        kgjvwjM7k4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzCrlOjBcSSE8sSc1OTS1ILYLJMnFwSjUw
        sWtd+/VvYe7Uy59S1pxd+zO68te3C057lFelLtCVmijOHyD7n7VLU+ntopjpLp3F++zWxiZY
        7W/Xmao69aahMC9TUrZxo7me+60581e9vq3w5MSMkCBfX7ljiw2VNjZ5/5ePneD8RrN2e8PT
        C6/qV006KLj52HOb8tUxMquL7s64UnpypcPDSnXx46efnL62WMtu/c9nakcPtduY1qxry4lx
        qZBOnRNQ+2Xzk28a2YWe274yu2dOu62t7zpLqE7q9sqtE3ZuDGfuXN823dp96T7904oRRUH+
        TheK175esZpTlyuGobOo6dW73NXKK2/uXyl1Z1HRiRjTNl61HJVfi57dybmkJNwm9dt+2ufU
        JUosxRmJhlrMRcWJAEftCXpXAwAA
X-CMS-MailID: 20220629200652uscas1p2c1da644ea63a5de69e14e046379779b1
CMS-TYPE: 301P
X-CMS-RootMailID: 20220629200652uscas1p2c1da644ea63a5de69e14e046379779b1
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603872867.551046.2170426227407458814.stgit@dwillia2-xfh>
        <CGME20220629200652uscas1p2c1da644ea63a5de69e14e046379779b1@uscas1p2.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:28PM -0700, Dan Williams wrote:
> In preparation for growing a ->dpa_range attribute for endpoint
> decoders, rename the current ->decoder_range to the more descriptive
> ->hpa_range.
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c       |    2 +-
>  drivers/cxl/core/port.c      |    4 ++--
>  drivers/cxl/cxl.h            |    4 ++--
>  tools/testing/cxl/test/cxl.c |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ba3d2d959c71..5c070c93b07f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -172,7 +172,7 @@ static int init_hdm_decoder(struct cxl_port *port, st=
ruct cxl_decoder *cxld,
>  		return -ENXIO;
>  	}
> =20
> -	cxld->decoder_range =3D (struct range) {
> +	cxld->hpa_range =3D (struct range) {
>  		.start =3D base,
>  		.end =3D base + size - 1,
>  	};
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7810d1a8369b..98bcbbd59a75 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -78,7 +78,7 @@ static ssize_t start_show(struct device *dev, struct de=
vice_attribute *attr,
>  	if (is_root_decoder(dev))
>  		start =3D cxld->platform_res.start;
>  	else
> -		start =3D cxld->decoder_range.start;
> +		start =3D cxld->hpa_range.start;
> =20
>  	return sysfs_emit(buf, "%#llx\n", start);
>  }
> @@ -93,7 +93,7 @@ static ssize_t size_show(struct device *dev, struct dev=
ice_attribute *attr,
>  	if (is_root_decoder(dev))
>  		size =3D resource_size(&cxld->platform_res);
>  	else
> -		size =3D range_len(&cxld->decoder_range);
> +		size =3D range_len(&cxld->hpa_range);
> =20
>  	return sysfs_emit(buf, "%#llx\n", size);
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6799b27c7db2..8256728cea8d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -198,7 +198,7 @@ enum cxl_decoder_type {
>   * @dev: this decoder's device
>   * @id: kernel device name id
>   * @platform_res: address space resources considered by root decoder
> - * @decoder_range: address space resources considered by midlevel decode=
r
> + * @hpa_range: Host physical address range mapped by this decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> @@ -212,7 +212,7 @@ struct cxl_decoder {
>  	int id;
>  	union {
>  		struct resource platform_res;
> -		struct range decoder_range;
> +		struct range hpa_range;
>  	};
>  	int interleave_ways;
>  	int interleave_granularity;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 431f2bddf6c8..7a08b025f2de 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -461,7 +461,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm=
 *cxlhdm)
>  			return PTR_ERR(cxld);
>  		}
> =20
> -		cxld->decoder_range =3D (struct range) {
> +		cxld->hpa_range =3D (struct range) {
>  			.start =3D 0,
>  			.end =3D -1,
>  		};
>=20
>

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
