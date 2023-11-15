Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3E87EBE20
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 08:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjKOHd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 02:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjKOHdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 02:33:25 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A1C1
        for <linux-pci@vger.kernel.org>; Tue, 14 Nov 2023 23:33:19 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231115073318epoutp020339b414d8d69bac54d6569695a6fec7~Xu4zjETzI3123631236epoutp02c
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 07:33:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231115073318epoutp020339b414d8d69bac54d6569695a6fec7~Xu4zjETzI3123631236epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700033598;
        bh=jFCwICpuT3AUEmOuUJhZvLiJFkBLd7PkunhtjvgKb7s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=SAWNjKreOMbtuz9M1lwlppUhkfp6BvVo9lXgcWcXSfGkGzGcNy7kYqpPhDs6oP0sJ
         jrIiX0W9s0si7QwtyrpfcYzAKlxCerjsHky8qqLng+O7pbugrk7gcM+3DSGOpYyKfJ
         qQwivQ+qD989dEoBYkKkhPpSVsskWUDEDf7bqeco=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231115073317epcas5p1a8d4252301e27eff2a6542864d19a9b0~Xu4y3YJVC2573025730epcas5p1c;
        Wed, 15 Nov 2023 07:33:17 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SVZdl6W1nz4x9Q2; Wed, 15 Nov
        2023 07:33:15 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.79.19369.B3474556; Wed, 15 Nov 2023 16:33:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231115064037epcas5p47d6ba6b04cabe15dfadbb4a6f980ac0e~XuK0KQRre1154211542epcas5p48;
        Wed, 15 Nov 2023 06:40:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115064037epsmtrp2d31dd3fc5e54b397277339a539354f5c~XuK0IrSUa1145411454epsmtrp2f;
        Wed, 15 Nov 2023 06:40:37 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-69-6554743b1963
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.58.08755.5E764556; Wed, 15 Nov 2023 15:40:37 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231115064035epsmtip1a5b8bbb05dd8b71991b12c1ffe7ed671~XuKyIbS7C1869818698epsmtip15;
        Wed, 15 Nov 2023 06:40:35 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc:     <jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <20231027134849.GA23716@thinkpad>
Subject: RE: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Date:   Wed, 15 Nov 2023 12:10:33 +0530
Message-ID: <000b01da178e$a43088d0$ec919a70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFlrvPEaqAl+ZjspMpXVx4MiN0lSgK7wbyrAib+JfWxPKji4A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmpq51SUiqwerdBhYP5m1js1jSlGGx
        4stMdou9r7eyWzT0/Ga12PT4GqvF5V1z2CzOzjvOZjHj/D4mi5Y/LSwWd1s6WS0Wbf3CbvF/
        zw52B16PnbPusnss2FTqsWlVJ5vHnWt72DyeXJnO5LF5Sb1H35ZVjB6fN8kFcERl22SkJqak
        Fimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaykUJaYUwoUCkgs
        LlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Y/msyc0Gn
        asWSgz1sDYzNcl2MnBwSAiYScxfeZQSxhQT2MErcXBHbxcgFZH9ilHjwcyIrhPMNyDnUzwbT
        8f7KPmaIxF5GiXNvL0E5LxglZrReZwapYhPQkXhy5Q+YLSLgINH+9hMLSBGzwA0miWv3V4It
        5BTQk3g2dyE7iC0sYCXxfekEoH0cHCwCqhKbtsaChHkFLCUmTD7NBmELSpyc+YQFxGYW0JZY
        tvA1M8RFChI/ny5jhdjlJPF0+wtGiBpxiaM/e8COkxC4wSGx790xdogGF4mFx56wQtjCEq+O
        b4GKS0l8frcX6s10iZWbZ0AtyJH4tnkJE4RtL3HgyhwWkDuZBTQl1u/ShwjLSkw9tY4JYi+f
        RO/vJ1DlvBI75sHYyhJf/u5hgbAlJeYdu8w6gVFpFpLXZiF5bRaSF2YhbFvAyLKKUSq1oDg3
        PTXZtMBQNy+1HB7jyfm5mxjBCVorYAfj6g1/9Q4xMnEwHmKU4GBWEuE1lwtJFeJNSaysSi3K
        jy8qzUktPsRoCgzvicxSosn5wByRVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampB
        ahFMHxMHp1QDk8D55sJNq5iWNFiI58wN/eiSrlfAvczv8BLz8gWKLWyHVxTaPJL4l+F37Kz+
        xHkb6mu0Zj64MPVUmey3N1ued8+Yv1yprfVpcGcaT+709T+q2VKOV92M+PD8wbqdTqH2YVVB
        i795N3DMqWo4Wn7SbFrOq/9KPPkaG/JNrqt/+WFzovaY9KUN+q8t3jD73i8UM7rFbMPWrqK1
        sFq4mfmH10Tuc9eaFPee0Zy9l2VttdWUqcFLHm7OzhBoapXS3p4Y26e/bAbbsvVeMs+e3eBN
        Y3R/FcZ5YPdkBo7bK89N11/OrHlB+FRzUG745sxKP4dVftnBBfWHco57nXng3PLkS2Hh7NSG
        ZvYpCTz2TdKmSizFGYmGWsxFxYkACe7aGVkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSnO7T9JBUg8ULlC0ezNvGZrGkKcNi
        xZeZ7BZ7X29lt2jo+c1qsenxNVaLy7vmsFmcnXeczWLG+X1MFi1/Wlgs7rZ0slos2vqF3eL/
        nh3sDrweO2fdZfdYsKnUY9OqTjaPO9f2sHk8uTKdyWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyrj5fR9bwQ3lihnnLzA2MF6U6WLk5JAQMJF4f2UfcxcjF4eQwG5GiQn931kgEpIS
        ny+uY4KwhSVW/nvODlH0jFFi7f31YAk2AR2JJ1f+MIPYIgIOEu1vP7GAFDELPGOS6OmZzQLR
        sZZRYvbWd2wgVZwCehLP5i5kB7GFBawkvi+dwNrFyMHBIqAqsWlrLEiYV8BSYsLk02wQtqDE
        yZlPwC5iFtCW6H3YyghjL1v4mhniOgWJn0+XsUIc4STxdPsLqBpxiaM/e5gnMArPQjJqFpJR
        s5CMmoWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAo1dLcwbh91Qe9Q4xM
        HIyHGCU4mJVEeM3lQlKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0REkhPLEnNTk0tSC2C
        yTJxcEo1ME2dq+t8Jc6+Ptw///fRy01KU9bqMWf8FNmyxvj8H2/ViPo2I/awpG37DV/NXsf9
        X2mFR1m0Ds9Ri3cu69f2FLsrtCvVioWdmeXT/zL8049pFofmuqzdy9pz/map58msbStuTOWo
        iqr49qd2rsUcrocmn0zuv3TM/Lbj6vT1i8z9p3BPLukOajkXZ3Ly78qUpM1fJWt/njmkuzv5
        8bX/75iv9Wrs8M592HNi6Re26gUqu+N5LzSpRIXUBf7+ID9Jdc8j8aSQOfULM1fk28Q9e3hg
        yqUP55/NfWB1YIvwibZ8yzenI9U0OqWTr0efNs66o61/++qc3quuR3/b7zTliGFcGq3D6CGx
        izmq2Gvj3vlKLMUZiYZazEXFiQD2JsneQQMAAA==
X-CMS-MailID: 20231115064037epcas5p47d6ba6b04cabe15dfadbb4a6f980ac0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
        <20231009062216.6729-1-shradha.t@samsung.com>
        <20231027134849.GA23716@thinkpad>
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
> From: Manivannan Sadhasivam =5Bmailto:manivannan.sadhasivam=40linaro.org=
=5D
> Sent: 27 October 2023 19:19
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: jingoohan1=40gmail.com; lpieralisi=40kernel.org; kw=40linux.com;
> robh=40kernel.org; bhelgaas=40google.com; krzysztof.kozlowski=40linaro.or=
g;
> alim.akhtar=40samsung.com; linux-pci=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; pankaj.dubey=40samsung.com
> Subject: Re: =5BPATCH=5D PCI: exynos: Adapt to clk_bulk_* APIs
>=20
> On Mon, Oct 09, 2023 at 11:52:16AM +0530, Shradha Todi wrote:
> > There is no need to hardcode the clock info in the driver as driver
> > can rely on the devicetree to supply the clocks required for the
> > functioning of the peripheral. Get rid of the static clock info and
> > obtain the platform supplied clocks. The total number of clocks
> > supplied is obtained using the devm_clk_bulk_get_all() API and used
> > for the rest of the clk_bulk_* APIs.
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
> exynos_pcie *ep)
> >  	struct device *dev =3D ep->pci.dev;
> >  	int ret;
> >
> > -	ret =3D clk_prepare_enable(ep->clk);
> > -	if (ret) =7B
> > -		dev_err(dev, =22cannot enable pcie rc clock=22);
> > +	ret =3D devm_clk_bulk_get_all(dev, &ep->clks);
> > +	if (ret < 0)
>=20
> Please use =21(ret) here and below to be consistent with the driver.
>=20

In this case, only negative values indicate failure. Hence we cannot use (=
=21ret) here.

> >  		return ret;
> > -	=7D
> >
> > -	ret =3D clk_prepare_enable(ep->bus_clk);
> > -	if (ret) =7B
> > -		dev_err(dev, =22cannot enable pcie bus clock=22);
> > -		goto err_bus_clk;
> > -	=7D
> > +	ep->clk_cnt =3D ret;
>=20
> Since clk_cnt is =22int=22, you can just use it directly instead of =22re=
t=22.
>=20

Thanks for this suggestion=21 Will take care in v2.

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
> >  static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
> > =7B
> > -	clk_disable_unprepare(ep->bus_clk);
> > -	clk_disable_unprepare(ep->clk);
> > +	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
> >  =7D
> >
> >  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> > =40=40 -332,17 +320,9 =40=40 static int exynos_pcie_probe(struct
> platform_device *pdev)
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
> platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > -	ret =3D exynos_pcie_init_clk_resources(ep);
> > -	if (ret)
> > -		return ret;
> > -
> >  	ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep-
> >supplies);
> >  	if (ret)
>=20
> You need to disable_unprepare() clocks in error path here and above.
>=20

Thanks for pointing out=21 Will take care in v2.

> - Mani
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A
