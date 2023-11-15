Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCB7EBE1F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 08:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjKOHdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 02:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHdV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 02:33:21 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495CE9
        for <linux-pci@vger.kernel.org>; Tue, 14 Nov 2023 23:33:13 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231115073311epoutp02bcc572623b5e879e316718aa04aeed15~Xu4s_d6Mf2996729967epoutp02N
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 07:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231115073311epoutp02bcc572623b5e879e316718aa04aeed15~Xu4s_d6Mf2996729967epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700033591;
        bh=WaeOfoNTbfhSobyw3fHef25B5qOSM0ie2Tlm8/7W3FA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=qWVzVo2fq5JeNWTYMDRT7qFQ3g3J8xsuo5UCcIkFbuj0HzBVmNFPX3t3hZwB+AAJt
         kllr4igbyZim6+mXjMPZ14jKIeJnHqcsYN42Ydww/sQU7UbY/TSoZIYvUFiMGYux0m
         K9N/7vuK4OayQmP8B5pYdFf5szJbTiwOFIldHgVs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231115073310epcas5p3c4fe7c3d699636bc9624c0dc62c695d5~Xu4sioTCH2420624206epcas5p3U;
        Wed, 15 Nov 2023 07:33:10 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SVZdc5jQKz4x9Q7; Wed, 15 Nov
        2023 07:33:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.36.08567.43474556; Wed, 15 Nov 2023 16:33:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231115063748epcas5p4fe34caf919fc11d8f22e4cf8cd34f543~XuIWiCYsX0656906569epcas5p4A;
        Wed, 15 Nov 2023 06:37:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231115063748epsmtrp116632c61935100634a84817343149e82~XuIWhRhmg1243112431epsmtrp1T;
        Wed, 15 Nov 2023 06:37:48 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-14-65547434c348
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.28.08755.C3764556; Wed, 15 Nov 2023 15:37:48 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231115063746epsmtip25dc2e9b186050cabb5c13a51eabd0048~XuIUmmknM0739707397epsmtip2Q;
        Wed, 15 Nov 2023 06:37:46 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>, <jingoohan1@gmail.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>
Cc:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <029a01da1334$dc1016c0$94304440$@samsung.com>
Subject: RE: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Date:   Wed, 15 Nov 2023 12:07:44 +0530
Message-ID: <000a01da178e$3f3e18c0$bdba4a40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFlrvPEaqAl+ZjspMpXVx4MiN0lSgK7wbyrAgqzZeuxPYqDUA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmhq5JSUiqwbcOHYsH87axWSxpyrBY
        8WUmu8Xe11vZLRp6frNabHp8jdXi8q45bBZn5x1ns5hxfh+TRcufFhaLRVu/sFv837OD3YHH
        Y+esu+weCzaVemxa1cnmcefaHjaPJ1emM3lsXlLv0bdlFaPH501yARxR2TYZqYkpqUUKqXnJ
        +SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLcqKZQl5pQChQISi4uV9O1s
        ivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzFhyeylhwXqti3e64
        Bsb9Sl2MnBwSAiYSi/sWs3QxcnEICexmlDi36RwbhPOJUWLuvb9QzjdGiVUfXzDCtNxeeQGq
        ZS+jxKT+NijnBaNER3c3M0gVm4COxJMrf5hBEiIC+xglTi19xwSSYBZYwygxuTuqi5GDg1PA
        SuL4ayOQsDCQ+X3pBFYQm0VAVeLa9sMsIDavgKXE+5t/mSBsQYmTM5+wQIzRlli28DUzxEUK
        Ej+fLgPrFRFwknj1dD0bRI24xNGfPWA3SAic4JBYcvIXE0SDi8SHpkVQzcISr45vYYewpSRe
        9rdB2ekSKzfPgKrJkfi2eQlUr73EgStzWEDuZxbQlFi/Sx8iLCsx9dQ6qBf5JHp/P4Eq55XY
        MQ/GVpb48ncPC4QtKTHv2GXWCYxKs5C8NgvJa7OQvDALYdsCRpZVjJKpBcW56anJpgWGeanl
        8AhPzs/dxAhOylouOxhvzP+nd4iRiYPxEKMEB7OSCK+5XEiqEG9KYmVValF+fFFpTmrxIUZT
        YHhPZJYSTc4H5oW8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqY
        Xs77tXRrqfT0STOfC5yd5+dZ46snuOaKrfZkxr6AJz4hLxxzGyos5JhLY110tnO5rMxv8NK3
        XGN2U2qqn42u7EI/b1evKRxTexaEVGxP/ZF6t6J3b4w3q8rWG72mW18s/HdBZ8HhhBdJB0R6
        Mp99mNL+ILwpkeXEBNeZF6dc3NwY8DvBQsOg1Mb8boGgyetZMQ94MtaIOq8Wdt/s4fK6eVEL
        p0qqokWLtNiDc67m9/95TVCIEH1vsFhL76najQ37tN571Ppt5BXW5nwy88WlMwZKc2IP3qq2
        C/vhMofv0mtHO54KW9VN4us/8ikc/L/0jPmJivTwBcs+m/OFftSU2iZj2LpG/Un8DXmp3bZK
        LMUZiYZazEXFiQA9ILKZUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK5NekiqwZaHQhYP5m1js1jSlGGx
        4stMdou9r7eyWzT0/Ga12PT4GqvF5V1z2CzOzjvOZjHj/D4mi5Y/LSwWi7Z+Ybf4v2cHuwOP
        x85Zd9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0S
        uDLOHkwq6NSsePSyjaWB8a9CFyMnh4SAicTtlRdYuhi5OIQEdjNKTPy2mB0iISnx+eI6Jghb
        WGLlv+fsEEXPGCU2vf/LCJJgE9CReHLlDzNIQkTgGKPE1vsLWEASzAIbGCW2HciD6NjJKLFl
        aRNQBwcHp4CVxPHXRiA1wkDm96UTWEFsFgFViWvbD4P18gpYSry/+ZcJwhaUODnzCdRMbYne
        h62MMPayha+ZIa5TkPj5dBnYHBEBJ4lXT9ezQdSISxz92cM8gVF4FpJRs5CMmoVk1CwkLQsY
        WVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHppbmDsbtqz7oHWJk4mA8xCjBwawk
        wmsuF5IqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgelA
        S/uxS+2HLzTOWh7Et46jSfSnqcitZD8RNgVjWQFbKafTfbdrGdffaEwsOGXz3Ur5/Z22+p99
        1v27uxrTumTv/QxUCP+9JPdizQH9dewf7B+3+b2M6buidYD91Y2+Lzp2Sb6le5Y+eP6PKXmB
        +sq/lyMPsEXMcbURYDjG/uRI2qnM6Wypf3z0z2170Z2uuspKsMJAxmaDlRN/RbWR2bdNu7i6
        t0m0dU3cWLsho1vlyVmDoyVXjS5OEjBY2MC457rdXbsvQiZxj56xsKtwpASmXIh5IzTbuWzO
        hJpHzpINd/xzrXd8OXSswvTSRyXvuXbFDXF3NydPMfsntnG9hZfm2iaV+wXMK5rrvTazKbEU
        ZyQaajEXFScCAGdMFJk7AwAA
X-CMS-MailID: 20231115063748epcas5p4fe34caf919fc11d8f22e4cf8cd34f543
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
        <20231009062216.6729-1-shradha.t@samsung.com>
        <029a01da1334$dc1016c0$94304440$@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Alim Akhtar =5Bmailto:alim.akhtar=40samsung.com=5D
> Sent: 09 November 2023 23:18
> To: 'Shradha Todi' <shradha.t=40samsung.com>; jingoohan1=40gmail.com;
> lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; krzysztof.kozlowski=40linaro.org
> Cc: linux-pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; =
linux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> pankaj.dubey=40samsung.com
> Subject: RE: =5BPATCH=5D PCI: exynos: Adapt to clk_bulk_* APIs
>=20
> Hi Shradha
>=20
> > -----Original Message-----
> > From: Shradha Todi <shradha.t=40samsung.com>
> > Sent: Monday, October 9, 2023 11:52 AM
> > To: jingoohan1=40gmail.com; lpieralisi=40kernel.org; kw=40linux.com;
> > robh=40kernel.org; bhelgaas=40google.com; krzysztof.kozlowski=40linaro.=
org;
> > alim.akhtar=40samsung.com
> > Cc: linux-pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org=
;
> > linux- samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> > pankaj.dubey=40samsung.com; Shradha Todi <shradha.t=40samsung.com>
> > Subject: =5BPATCH=5D PCI: exynos: Adapt to clk_bulk_* APIs
> >
> > There is no need to hardcode the clock info in the driver as driver
> > can rely on the devicetree to supply the clocks required for the
> > functioning of the peripheral. Get rid of the static clock info and
> > obtain the platform supplied clocks. The total number of clocks
> > supplied is obtained using the
> > devm_clk_bulk_get_all() API and used for the rest of the clk_bulk_* API=
s.
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pci-exynos.c =7C 46
> > ++++++-------------------
> >  1 file changed, 11 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> > b/drivers/pci/controller/dwc/pci-exynos.c
> > index 9e42cfcd99cc..023cf41fccd7 100644
> > --- a/drivers/pci/controller/dwc/pci-exynos.c
> > +++ b/drivers/pci/controller/dwc/pci-exynos.c
> > =40=40 -54,8 +54,8 =40=40
> >  struct exynos_pcie =7B
> >  	struct dw_pcie			pci;
> >  	void __iomem			*elbi_base;
> > -	struct clk			*clk;
> > -	struct clk			*bus_clk;
> > +	struct clk_bulk_data		*clks;
> > +	int				clk_cnt;
> >  	struct phy			*phy;
> >  	struct regulator_bulk_data	supplies=5B2=5D;
> >  =7D;
> > =40=40 -65,30 +65,18 =40=40 static int exynos_pcie_init_clk_resources(s=
truct
> > exynos_pcie *ep)
> >  	struct device *dev =3D ep->pci.dev;
> >  	int ret;
> >
> > -	ret =3D clk_prepare_enable(ep->clk);
> > -	if (ret) =7B
> > -		dev_err(dev, =22cannot enable pcie rc clock=22);
> > +	ret =3D devm_clk_bulk_get_all(dev, &ep->clks);
> > +	if (ret < 0)
> You can checking only for -ve value, what if  devm_clk_bulk_get_all() ret=
urn
> 0?
>=20

Thanks for the review=21
Return value of 0 means there were no clocks to get but it does not indicat=
e failure. It can mean
that the device does not need any clock handling in the driver. =22 clk_bul=
k_prepare_enable=22 takes
care of num_clks being 0 and returns success anyway. I have seen other driv=
ers handling in a similar way.

> >  		return ret;
> > -	=7D
> >
> > -	ret =3D clk_prepare_enable(ep->bus_clk);
> > -	if (ret) =7B
> > -		dev_err(dev, =22cannot enable pcie bus clock=22);
> > -		goto err_bus_clk;
> > -	=7D
> > +	ep->clk_cnt =3D ret;
> >
> > -	return 0;
> > -
> > -err_bus_clk:
> > -	clk_disable_unprepare(ep->clk);
> > -
> > -	return ret;
> > +	return clk_bulk_prepare_enable(ep->clk_cnt, ep->clks);
> >  =7D
> >
> >  static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)  =
=7B
> > -	clk_disable_unprepare(ep->bus_clk);
> > -	clk_disable_unprepare(ep->clk);
> > +	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
> >  =7D
> >
> >  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> > =40=40 -
> > 332,17 +320,9 =40=40 static int exynos_pcie_probe(struct platform_devic=
e
> > *pdev)
> >  	if (IS_ERR(ep->elbi_base))
> >  		return PTR_ERR(ep->elbi_base);
> >
> > -	ep->clk =3D devm_clk_get(dev, =22pcie=22);
> > -	if (IS_ERR(ep->clk)) =7B
> > -		dev_err(dev, =22Failed to get pcie rc clock=5Cn=22);
> > -		return PTR_ERR(ep->clk);
> > -	=7D
> > -
> > -	ep->bus_clk =3D devm_clk_get(dev, =22pcie_bus=22);
> > -	if (IS_ERR(ep->bus_clk)) =7B
> > -		dev_err(dev, =22Failed to get pcie bus clock=5Cn=22);
> > -		return PTR_ERR(ep->bus_clk);
> > -	=7D
> > +	ret =3D exynos_pcie_init_clk_resources(ep);
> > +	if (ret < 0)
> > +		return ret;
> >
> >  	ep->supplies=5B0=5D.supply =3D =22vdd18=22;
> >  	ep->supplies=5B1=5D.supply =3D =22vdd10=22;
> > =40=40 -351,10 +331,6 =40=40 static int exynos_pcie_probe(struct
> > platform_device
> > *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > -	ret =3D exynos_pcie_init_clk_resources(ep);
> > -	if (ret)
> > -		return ret;
> > -
> >  	ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep-
> > >supplies);
> >  	if (ret)
> >  		return ret;
> > =40=40 -369,8 +345,8 =40=40 static int exynos_pcie_probe(struct
> > platform_device
> > *pdev)
> >
> >  fail_probe:
> >  	phy_exit(ep->phy);
> > -	exynos_pcie_deinit_clk_resources(ep);
> >  	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> > +	exynos_pcie_deinit_clk_resources(ep);
> >
> >  	return ret;
> >  =7D
> > --
> > 2.17.1
>=20


