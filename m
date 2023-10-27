Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B117D8F4D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjJ0HMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 03:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjJ0HMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 03:12:05 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DDD1B1
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 00:12:00 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231027071158epoutp02eef561c6e4f3551e9a73caee5a7edeeb~R5VwPzn170218902189epoutp02V
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 07:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231027071158epoutp02eef561c6e4f3551e9a73caee5a7edeeb~R5VwPzn170218902189epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698390718;
        bh=XinEXqbMGYYXEdTEUQ6Gxi75JRlQ0apA3Uu3KoNEONQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Fixw7w7j0kbV7fHtj+7nAyHSot2zlj5lrO/Y8BNgyixVlJz6WUlp9PutDY57NRtM5
         9Kuw6NUzgJjBgwyWSoVAdQIA2EQ63TbOSRVWm/DcUZ+RBeGZ/Gqwh44p/GBBnwVz3u
         9vCtoM/CLkL+lY9XOta1/BEhFaAg+we7ycSgtDes=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231027071157epcas5p412d8c4007d98798f39809bc775f623b0~R5Vvwtdsi2566125661epcas5p4d;
        Fri, 27 Oct 2023 07:11:57 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SGv3v5rlSz4x9QB; Fri, 27 Oct
        2023 07:11:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.6A.09672.8B26B356; Fri, 27 Oct 2023 16:11:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231027063746epcas5p1256399d02b1255f65b6e766a13da92cd~R435iH_-D2895828958epcas5p1P;
        Fri, 27 Oct 2023 06:37:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231027063746epsmtrp1a947182f52274b9b4fdafaf6d4cb332d~R435hXZ_40137601376epsmtrp1n;
        Fri, 27 Oct 2023 06:37:46 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-2c-653b62b8ecfd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.52.08755.ABA5B356; Fri, 27 Oct 2023 15:37:46 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231027063744epsmtip1ad1884e37ef89dbc96485af6ccb07398~R433nhDDm2102021020epsmtip1R;
        Fri, 27 Oct 2023 06:37:44 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     <jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>
Cc:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <20231009062216.6729-1-shradha.t@samsung.com>
Subject: RE: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Date:   Fri, 27 Oct 2023 12:07:43 +0530
Message-ID: <0b4801da08a0$18877110$49965330$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFlrvPEaqAl+ZjspMpXVx4MiN0lSgK7wbyrsTAEGMA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmpu6OJOtUg/PzDC0ezNvGZrGkKcNi
        xZeZ7BZ7X29lt2jo+c1qsenxNVaLy7vmsFmcnXeczWLG+X1MFi1/WlgsFm39wm7xf88Odgce
        j52z7rJ7LNhU6rFpVSebx51re9g8nlyZzuSxeUm9R9+WVYwenzfJBXBEZdtkpCampBYppOYl
        56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2qpFCWmFMKFApILC5W0rez
        KcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOeLdkEVPBQsWKU2/P
        sjYwrpHuYuTkkBAwkbiwsJW1i5GLQ0hgN6PE5c+/mSCcT4wS55achHK+MUpM7mhihWl5sHYT
        G0RiL6PEhDen2CGcF4wS31btZAepYhPQkXhy5Q8zSEJEYB2jxLE/nWAJZoE1QLO6o0BsTgEr
        iX/HT7OB2MJA9velE8BWsAioSsx4vxOomYODV8BSYstssGN5BQQlTs58wgIxRlti2cLXzBAX
        KUj8fLoMrFUEaMzh1nlQq8Qljv7sAbtBQuAEh8ShtS+hXnCReHmmnRHCFpZ4dXwLO4QtJfGy
        vw3KTpdYuXkG1IIciW+blzBB2PYSB67MYQG5jVlAU2L9Ln2IsKzE1FPrmCD28kn0/n4CVc4r
        sWMejK0s8eXvHhYIW1Ji3rHLrBMYlWYheW0WktdmIXlhFsK2BYwsqxglUwuKc9NTi00LjPNS
        y+Exnpyfu4kRnJa1vHcwPnrwQe8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM
        psDgnsgsJZqcD8wMeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1
        MAkcmbTgUIP0jpYDk0QPTn3hUrDkjndjqdjMmiwe1so7wewlwRv+mU5qsgqYtKZ8esLtjEk1
        9vZLeVitFHxXnjmiWb3sUnHUwU1ZXEJ/t2xiE3RS/SFRMHlL8g8ziYiyg2cvyxQs5z5q6Twv
        7/6JiC1T3p9otmJl9/5ruqm/9X2T6Y7eLREmrR8VNPZ4q274sKxcJHrHWi8+X0GeS1s63aZG
        PWt1VbXvMGC7svx1cq3W6tV/37QpHn5suqFq7pvMJ5fMn73PUaplE1h/6amwqKZBsVqc1xv9
        eaVvQ7yfxAdGPhd78enxJ8WO8IdtH+ZUeb0u3dZYMz+F23LO3ZbGoD2nJt7u/35eaupz21NL
        y5VYijMSDbWYi4oTAefG60pUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnO6uKOtUgys3hCwezNvGZrGkKcNi
        xZeZ7BZ7X29lt2jo+c1qsenxNVaLy7vmsFmcnXeczWLG+X1MFi1/WlgsFm39wm7xf88Odgce
        j52z7rJ7LNhU6rFpVSebx51re9g8nlyZzuSxeUm9R9+WVYwenzfJBXBEcdmkpOZklqUW6dsl
        cGW83j+NsaBNoeL9x49sDYz9Ul2MnBwSAiYSD9ZuYuti5OIQEtjNKPHt1FQ2iISkxOeL65gg
        bGGJlf+es0MUPWOUeHmjG6yITUBH4smVP8wgCRGBbYwSs1t6WUASzAIbGCW2HciD6OhmlFhy
        6QBYB6eAlcS/46fBbGEg+/vSCawgNouAqsSM9zuBJnFw8ApYSmyZLQ0S5hUQlDg58wnUTG2J
        3oetjDD2soWvmSGuU5D4+XQZ2BgRoJGHW+exQ9SISxz92cM8gVF4FpJRs5CMmoVk1CwkLQsY
        WVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHppbmDsbtqz7oHWJk4mA8xCjBwawk
        whvpY5EqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgWnW
        zATOlq0GDzNCTVWjvO4VbWl5cPZ019SJ1sUcaiqdMdNNmquePb2+ZuaUnimRMTszlixIanjX
        kHzR0YCXxWCDeVDt8n3+0nL77gdMzWEOcG9s2sG5zzLi/ofaO9NKov6Lb7webMFkGtF//s8i
        xvC9sSV8L0x7OKZ0mKg6bv7k/UPRQzxE7JyXYSOrYJiZd+7t291eKScm7nHncVE8dyt7390P
        ntfP9J7rWM7A/nTepi0GAl/nmCbEzLqv36m+qy/n77mXXHFy0wQVu7Ua+/xVbstOmvGljOf5
        i9cGF6+q31qcHbK/7Mz5dQyq7z4IThS27fpZJ58p8NaF4f+CHS4xhh/ON6i7/PO+86hRW4ml
        OCPRUIu5qDgRAIDWXTo8AwAA
X-CMS-MailID: 20231027063746epcas5p1256399d02b1255f65b6e766a13da92cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
        <20231009062216.6729-1-shradha.t@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle reminder to review this patch. Thanks in advance=21

> -----Original Message-----
> From: Shradha Todi =5Bmailto:shradha.t=40samsung.com=5D
> Sent: 09 October 2023 11:52
> To: jingoohan1=40gmail.com; lpieralisi=40kernel.org; kw=40linux.com;
> robh=40kernel.org; bhelgaas=40google.com; krzysztof.kozlowski=40linaro.or=
g;
> alim.akhtar=40samsung.com
> Cc: linux-pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; =
linux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> pankaj.dubey=40samsung.com; Shradha Todi <shradha.t=40samsung.com>
> Subject: =5BPATCH=5D PCI: exynos: Adapt to clk_bulk_* APIs
>=20
> There is no need to hardcode the clock info in the driver as driver can r=
ely on
> the devicetree to supply the clocks required for the functioning of the
> peripheral. Get rid of the static clock info and obtain the platform supp=
lied
> clocks. The total number of clocks supplied is obtained using the
> devm_clk_bulk_get_all() API and used for the rest of the clk_bulk_* APIs.
>=20
> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c =7C 46 ++++++-------------------
>  1 file changed, 11 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> b/drivers/pci/controller/dwc/pci-exynos.c
> index 9e42cfcd99cc..023cf41fccd7 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> =40=40 -54,8 +54,8 =40=40
>  struct exynos_pcie =7B
>  	struct dw_pcie			pci;
>  	void __iomem			*elbi_base;
> -	struct clk			*clk;
> -	struct clk			*bus_clk;
> +	struct clk_bulk_data		*clks;
> +	int				clk_cnt;
>  	struct phy			*phy;
>  	struct regulator_bulk_data	supplies=5B2=5D;
>  =7D;
> =40=40 -65,30 +65,18 =40=40 static int exynos_pcie_init_clk_resources(str=
uct
> exynos_pcie *ep)
>  	struct device *dev =3D ep->pci.dev;
>  	int ret;
>=20
> -	ret =3D clk_prepare_enable(ep->clk);
> -	if (ret) =7B
> -		dev_err(dev, =22cannot enable pcie rc clock=22);
> +	ret =3D devm_clk_bulk_get_all(dev, &ep->clks);
> +	if (ret < 0)
>  		return ret;
> -	=7D
>=20
> -	ret =3D clk_prepare_enable(ep->bus_clk);
> -	if (ret) =7B
> -		dev_err(dev, =22cannot enable pcie bus clock=22);
> -		goto err_bus_clk;
> -	=7D
> +	ep->clk_cnt =3D ret;
>=20
> -	return 0;
> -
> -err_bus_clk:
> -	clk_disable_unprepare(ep->clk);
> -
> -	return ret;
> +	return clk_bulk_prepare_enable(ep->clk_cnt, ep->clks);
>  =7D
>=20
>  static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)  =
=7B
> -	clk_disable_unprepare(ep->bus_clk);
> -	clk_disable_unprepare(ep->clk);
> +	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
>  =7D
>=20
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg) =40=
=40 -
> 332,17 +320,9 =40=40 static int exynos_pcie_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(ep->elbi_base))
>  		return PTR_ERR(ep->elbi_base);
>=20
> -	ep->clk =3D devm_clk_get(dev, =22pcie=22);
> -	if (IS_ERR(ep->clk)) =7B
> -		dev_err(dev, =22Failed to get pcie rc clock=5Cn=22);
> -		return PTR_ERR(ep->clk);
> -	=7D
> -
> -	ep->bus_clk =3D devm_clk_get(dev, =22pcie_bus=22);
> -	if (IS_ERR(ep->bus_clk)) =7B
> -		dev_err(dev, =22Failed to get pcie bus clock=5Cn=22);
> -		return PTR_ERR(ep->bus_clk);
> -	=7D
> +	ret =3D exynos_pcie_init_clk_resources(ep);
> +	if (ret < 0)
> +		return ret;
>=20
>  	ep->supplies=5B0=5D.supply =3D =22vdd18=22;
>  	ep->supplies=5B1=5D.supply =3D =22vdd10=22;
> =40=40 -351,10 +331,6 =40=40 static int exynos_pcie_probe(struct platform=
_device
> *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D exynos_pcie_init_clk_resources(ep);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep-
> >supplies);
>  	if (ret)
>  		return ret;
> =40=40 -369,8 +345,8 =40=40 static int exynos_pcie_probe(struct platform_=
device
> *pdev)
>=20
>  fail_probe:
>  	phy_exit(ep->phy);
> -	exynos_pcie_deinit_clk_resources(ep);
>  	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +	exynos_pcie_deinit_clk_resources(ep);
>=20
>  	return ret;
>  =7D
> --
> 2.17.1


