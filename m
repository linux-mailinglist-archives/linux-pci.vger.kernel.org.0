Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472BB7E70B7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 18:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjKIRsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 12:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344832AbjKIRsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 12:48:01 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792DC2D65
        for <linux-pci@vger.kernel.org>; Thu,  9 Nov 2023 09:47:58 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231109174755epoutp01a7e3137e707ba385956db09d6b2d0353~WBZujuJIP2861228612epoutp01K
        for <linux-pci@vger.kernel.org>; Thu,  9 Nov 2023 17:47:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231109174755epoutp01a7e3137e707ba385956db09d6b2d0353~WBZujuJIP2861228612epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699552075;
        bh=+MsuTqt+R/+qC3Q5ehB+Ei90sZRfVYqO8hJ6amRUbpQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QhmZSZ0ptYqaZFTRWi+z9gobDeN5Bcg53AnorchiP1Yqr9aB0K1t/j5uuq9VMMqQn
         +sdWEjTOxRXs9Wzo4aK7BC4BVi/dN0iqNFiDmLb8euIfNXdvzb5KnBBjAFRwTSGbrV
         tptjJtlam/MvkuzvY8T9EOoSc85s2w+6H7dkuSs0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231109174754epcas5p4912033781bc564ee36d8e4f6d2ebe894~WBZtr4hDF1312413124epcas5p4M;
        Thu,  9 Nov 2023 17:47:54 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SR8Yh6LxBz4x9Pq; Thu,  9 Nov
        2023 17:47:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.A5.19369.84B1D456; Fri, 10 Nov 2023 02:47:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231109174751epcas5p426dc425c385f3f6bd645ea5622832627~WBZq9JtI81274912749epcas5p4I;
        Thu,  9 Nov 2023 17:47:51 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231109174751epsmtrp1697b881b2d535a0c49866d735a1b5439~WBZq8WBHW1669316693epsmtrp1h;
        Thu,  9 Nov 2023 17:47:51 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-36-654d1b4819c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.D8.07368.74B1D456; Fri, 10 Nov 2023 02:47:51 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231109174749epsmtip1d358366aacea81785baf5837092940eb~WBZpRmmHO0160601606epsmtip1i;
        Thu,  9 Nov 2023 17:47:49 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Shradha Todi'" <shradha.t@samsung.com>, <jingoohan1@gmail.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>
Cc:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <20231009062216.6729-1-shradha.t@samsung.com>
Subject: RE: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Date:   Thu, 9 Nov 2023 23:17:48 +0530
Message-ID: <029a01da1334$dc1016c0$94304440$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFlrvPEaqAl+ZjspMpXVx4MiN0lSgK7wbyrsUUpUjA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmpq6HtG+qwYon+hZLmjIsVnyZyW6x
        9/VWdouGnt+sFpseX2O1uLxrDpvF2XnH2SxmnN/HZNHyp4XFYtHWL+wW//fsYLfoPVzrwOOx
        c9Zddo8Fm0o9Nq3qZPO4c20Pm8eTK9OZPDYvqffo27KK0ePzJrkAjqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygU5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rnz2yawFxxXrOhqmsna
        wHhUuouRk0NCwETi08x9rCC2kMAeRolTPV5djFxA9idGiZ4vV9ghnG+MEgsv/mGC6ZjW+5gN
        IrGXUaLh7gRmCOcFo8TnxcvAZrEJ6ErsWNwGViUCUvVq2VFGkASzwBpGicndUSA2p4CVxL/j
        p9lAbGEg+/vSCWDNLAIqEucXLmUBsXkFLCUuvr0AZQtKnJz5hAVijrbEsoWvmSFOUpD4+RRk
        MQfQMiuJ05fZIUrEJV4ePQL2goTACQ6JhZuPsIDUSAi4SOzbZQzRKizx6vgWdghbSuJlfxs7
        RImHxKI/UhDhDIm3y9czQtj2EgeuzAGbwiygKbF+lz7EJj6J3t9PmCA6eSU62oQgqlUlmt9d
        ZYGwpSUmdnezQtgeEo9m3WOcwKg4C8lbs5C8NQvJ/bMQli1gZFnFKJVaUJybnppsWmCom5da
        Do/u5PzcTYzgdKwVsINx9Ya/eocYmTgYDzFKcDArifBeMPFJFeJNSaysSi3Kjy8qzUktPsRo
        CgzsicxSosn5wIyQVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QD
        0/ZgcbECuVurXrTnCWls6z896Xxyyis+s8wNU+WVV/7yW+kdNOVu8++V/bF5334WHzQ++cSu
        7nb/xfctqstqA3W+n56WcGaju2121OxjC6rPuF4qrp45cZfyeREn4YMTN0t4KS9ZERN5wLLr
        TqacYi2nF6uPNNOWyCU5CTGqc7JnSu378S50Aeumf8YhMlb30/foX7C47uny5uAfu8xgd78H
        P2zDVbx+ikfemcVp0eBlWd+7hWEe1/oVIseP3bOxtz1TOIFFZf/y+weXro3RiGS6r8r83fZl
        SVjshh0bHf59lTwq9pEv+QDDt0X/88yzgg+E315WxXSwN8r5OOfdV//X3ZmQUytw+QWHuUnh
        fyWW4oxEQy3mouJEAPN3DcVQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnK67tG+qwYETkhZLmjIsVnyZyW6x
        9/VWdouGnt+sFpseX2O1uLxrDpvF2XnH2SxmnN/HZNHyp4XFYtHWL+wW//fsYLfoPVzrwOOx
        c9Zddo8Fm0o9Nq3qZPO4c20Pm8eTK9OZPDYvqffo27KK0ePzJrkAjigum5TUnMyy1CJ9uwSu
        jG27X7EWbFKomLNtDlsD4zqpLkZODgkBE4lpvY/Zuhi5OIQEdjNK7D5yhgUiIS1xfeMEdghb
        WGLlv+fsEEXPGCVO9f9nBkmwCehK7FjcBtYtInCUUeLo7j5WkASzwAZGiW0H8iA6uhklllw6
        wAaS4BSwkvh3/DSYLQxkf186AayBRUBF4vzCpWCreQUsJS6+vQBlC0qcnPmEBWKotsTTm0/h
        7GULXzNDnKcg8fPpMqA5HEBXWEmcvswOUSIu8fLoEfYJjMKzkEyahWTSLCSTZiFpWcDIsopR
        MrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzgytTR2MN6b/0/vECMTB+MhRgkOZiUR3gsm
        PqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1ML2bseNs
        oJG4TNeUpdNnMax/5Pdsh5OpTMBnbxGhyOB6FSm/+bYFqe0xVTOb8zZs4K/LYs1Lsr4R3qJ9
        P2bNggvFcy0yz+0+nXG75mPBjJ/ql7j9VTM7Xu6YLS58Z1JAuQpHzoT0vTt7ipQ28j1auTDs
        6d6ptqd2n3hz0/FIuckpNyn1uL+ny1vl5wqoLTFle9vL7Cjek/pt14lrtqwbHzW6Gl54aSkn
        HBP1tnJm/bXMWM0zJ/Ytmm250ps33XHtROWQ98tlZtfZz0i9J7ztnE2i8o3fPPeDV58tF083
        0LaY6fBk/amDs+dsXPXIRmQzo+nE2XbBN+q9ZvI9mFS4TlBoh9a2NevvLYlfNUex6qYSS3FG
        oqEWc1FxIgC6hBHROwMAAA==
X-CMS-MailID: 20231109174751epcas5p426dc425c385f3f6bd645ea5622832627
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
        <20231009062216.6729-1-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shradha

> -----Original Message-----
> From: Shradha Todi <shradha.t=40samsung.com>
> Sent: Monday, October 9, 2023 11:52 AM
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
You can checking only for -ve value, what if  devm_clk_bulk_get_all() retur=
n 0?

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


