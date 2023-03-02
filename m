Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDF16A90FE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCCGZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCCGZv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:25:51 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F032C15C8A
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:25:18 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230303062459epoutp0191c3a98aee72cf53325269431275aaaf~I1KzO-4n22445624456epoutp01s
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:24:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230303062459epoutp0191c3a98aee72cf53325269431275aaaf~I1KzO-4n22445624456epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824699;
        bh=sv2hnfV+RZAA1n52R0aeU8NHCNtbzK89lktgJrilOZc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=BzFyFbiwX01CjwL/2H7ZuK9vLk+lQX21u6bR1qYyNkL+a2u8VfsVB6kYdbthjBkze
         w2TPFz50V9213DDCHY/4VmthTzx+RcrSbDyOviPFGxOY6+rKsVYDCLJrd6qMGUwR8t
         0Z+WpKZCIRP+uZKMuiQWixtnzFmIO728RkqDgA2M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230303062459epcas5p3ea6871064e48c6efd24ff13ca3bc0dcf~I1Kypaotc0229702297epcas5p3B;
        Fri,  3 Mar 2023 06:24:59 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PSdHY23n6z4x9QF; Fri,  3 Mar
        2023 06:24:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.86.06765.9B291046; Fri,  3 Mar 2023 15:24:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302131016epcas5p3084bc8d556da7316c3ca50cba044a836~InDXxiSmB1466014660epcas5p3R;
        Thu,  2 Mar 2023 13:10:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302131016epsmtrp19162c5513b2eff120490acdd5e7d7d3b~InDXwiMBR0832508325epsmtrp1P;
        Thu,  2 Mar 2023 13:10:16 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-3d-640192b92341
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.84.18071.830A0046; Thu,  2 Mar 2023 22:10:16 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302131013epsmtip20cb8ea82f30448f73cc63032ab2e84dd~InDVC3y-i2302723027epsmtip2r;
        Thu,  2 Mar 2023 13:10:13 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <alim.akhtar@samsung.com>, <jingoohan1@gmail.com>,
        <Sergey.Semin@baikalelectronics.ru>, <lukas.bulwahn@gmail.com>,
        <hongxing.zhu@nxp.com>, <tglx@linutronix.de>,
        <m.szyprowski@samsung.com>, <jh80.chung@samsung.co>,
        <pankaj.dubey@samsung.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <a0c79665-adb9-a846-5a84-d85e0684c25f@linaro.org>
Subject: RE: [PATCH 15/16] PCI: samsung: Add structure to hold resource
 operations
Date:   Thu, 2 Mar 2023 18:40:12 +0530
Message-ID: <139901d94d08$54fb9030$fef2b090$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwH9qfdGAn+u9fwBvPnmbq7khR1w
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTZxTGfXtve1sEdwU2XzGy7sq2gOOjUroXQ90yK7tTl5FowmKY0NAb
        ipS26W0FxxLLAsII4HeAWr4RRjdQi2DLx6YF5tgmc4PJxjBTVzOciMIaNkPdRrl147/nnPye
        POe8b44QC/YKwoTZWiNj0Co1lCAA7xmMjIp2ngCquJP2QHSrrkeAWj5Uo/qhUT6y9NQCNLc4
        iqOPPTUEqpy+jaGB+90EMpcv8pH91xt8NNZrFaBrdVcFqPrbz3ioyFuEo6LhEhx1DN0kUFO3
        h0D/9DsI5K16hKMu+2ns9VB6xv4nQTstNwm6wW6i7baPBPTUjX4BPTs6StDu8Soe3dVymL4w
        6+DRTeY5AV150QboP+zhKYH7cpLUjFLFGMSMNlOnytZmyalde9K3pyfI4iTRkkT0KiXWKnMZ
        OaXYnRKdnK1Z2pMSH1RqTEutFCXLUrHbkgw6k5ERq3WsUU4xepVGL9XHsMpc1qTNitEyxq2S
        uLgtCUtgRo664YyHr5/fnG+dayPMoCmiDAiFkJRCpy2vDAQIg8k+AO19dwmumAdwZqpKwBUL
        AF564OGXAdGyw1Ey7qcGACzx9gKumAaww/IE91EC8hXoHvdiPh1K2jHoKqF9EEZ2AuhurOD5
        wkXkNui25fuYEHIvPO78btmLkxGw9pvhZW8QmQi9lRUEp9fCkRr3MoORm2Fr432Mm0gMH99t
        5XNZyfD24EWCY9bB4cflmC8Xkm0iWFxq43EGBVyccfh1CPz9KmeAZBi8d/SIX2fB9q5qf4AG
        LnS1+PnX4OVxK+6bHyMj4bneWK69EZ7+qpPH5a6BFYtuPx4EHXVP9SboedKPc3o9rPtijH8M
        UJYVq1lWrGZZsYLl/7QGgNvAekbP5mYxbII+Xsvk/ffhmbpcO1g+g6hdDnDn1qMYF+AJgQtA
        IUaFBhWYV6mCg1TKQ+8zBl26waRhWBdIWHrv41jYs5m6pTvSGtMl0sQ4qUwmkybGyyTUuqCX
        5SOZwWSW0sjkMIyeMTz18YSiMDNP8eBU/Wrr/raeubVvpxn2Xi+9ol0tSqsttJq/NO3ccfjo
        ZAHa8H16Zttv3UP4OTR26EzEbOOx6YLOhxMj2Eup7/24+0D4xCL7ibNaMPWGvJkojhTrQR6W
        NP2QuDBv/fx64NfJRz6YM7dviG1tVxRe217evF8h7+OfH87f+rcu46cdGy/h3uyDZ80hxGSu
        p1zxTs3AllWyPeoX8QxXaeyV9s41+zJ0MvepH9wnPvW6XJeFg6JnAg7UFdcn/xX6wqa08DvG
        5z2ixPHGnyeJMGnKcxMnU22S1IU3zRqyvZ7ZeS9KLOah0V86nFHl4oiZ5taz+RPvDp03xhve
        ogoD80C4zjpJ4axaKYnCDKzyX7OLPGePBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa2xLYRzGveec9pyVJkdX9pq41WUMo8K8EoYQOcaHbSEucSs91sVuThVT
        rJPK0rFlcdtWNrNUN41ZVmvXUUq7mrmUMUNqsVImNssYmbGUVCPZt1/yPM8v/w9/Che9IyKp
        lPR9LJcuS5XwBYTVJZkwG5UPk8/NKZyIOsqsfGQ4pkAXGz08pLeWAvT1t4dAVd9LSFTwyYej
        W10WEmlO/uYh8/s2Hnp+4wIfPS5r4qPiJ7cxpB3UEkjrziVQdWM7iSos30n0x24j0WBRL4Gu
        m8/iy8RMt7mfZBr07SRTblYxZpOOz7xps/OZHo+HZPytRRhz3ZDN1PbYMKZC85XPFNSZANNn
        Hp8wYrNgsZxNTdnPcnPidggUA4ZJmfeiD/aeqAMa8E2SB8IoSM+HttxWMg8IKBF9E8CuygIQ
        CsbAvpZrWIjD4ZVAJxlkEf0RwAe2uCDz6VnQ3zqI5wGKEtNOHOZmBT04bQawz1iNh6TdAPY2
        f8SCpTA6DvpNB4PbcDoJGl74iCAT9BRY+siNB1lIL4KDBflkiEfC5hL/vw5Oz4T5vuPgPxsv
        deGh2ybCgQ9GXpDF9Croc9WRoU4EdA+cxAtBuH6ISj9EpR+i0g+ZlAPCBMawmcq05DSlNFOa
        zh6IUcrSlKr05JhdGWlm8O8NomfYQL2pN8YJMAo4AaRwiVio1gyTi4RyWdYhlsvYzqlSWaUT
        jKUISYTwaV7zdhGdLNvH7mHZTJb7n2JUWKQGW+G5XXKkxJftuBrb5InurHRZ2pcGGhyWw8VJ
        EW3qlJfD4xOKuV/rc4SeFyI0Lk5b+/61O7to4aptUdOO+s+4CcupUd84a/fkA2t2vuq526Cz
        lwaOxBq3rJdrHLU1d1X9NabGTi1vb/2KJK93g2JghOH03KlbcmqeOLxkVUtipLiiDGNd2qyo
        TfVi5wxy05L40T9malz2y1sPP6zWzY9N6G45oQhf95jnlb4K3FdnHFrTAZsCup+lK5PCVr+8
        Uba8/3yxQP2UkwTUC9p1bzr6vhi1iflry99eszbZZ+k23pHOTs2f3vn5g+Oc85Nq67rd3qWF
        z/x7EpdFZf24uWHe/RwJoVTIpNE4p5T9BTLGqm11AwAA
X-CMS-MailID: 20230302131016epcas5p3084bc8d556da7316c3ca50cba044a836
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121503epcas5p291dce2b37ec4cdabcfecbf8fbdfcca51
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121503epcas5p291dce2b37ec4cdabcfecbf8fbdfcca51@epcas5p2.samsung.com>
        <20230214121333.1837-16-shradha.t@samsung.com>
        <a0c79665-adb9-a846-5a84-d85e0684c25f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 16 February 2023 16:42
> To: Shradha Todi <shradha.t=40samsung.com>; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com;
> krzysztof.kozlowski+dt=40linaro.org; alim.akhtar=40samsung.com;
> jingoohan1=40gmail.com; Sergey.Semin=40baikalelectronics.ru;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com; tglx=40linutronix.de;
> m.szyprowski=40samsung.com; jh80.chung=40samsung.co;
> pankaj.dubey=40samsung.com
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org; linux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 15/16=5D PCI: samsung: Add structure to hold resour=
ce
> operations
>=20
> On 14/02/2023 13:13, Shradha Todi wrote:
> > Some resources might differ based on platforms and we
>=20
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://protect2.fireeye.com/v1/url?k=3D66656d8a-07ee78a5-6664e6c5-
> 74fe485cbfe7-a61191c61bcf38f7&q=3D1&e=3D80994c2d-d0ca-4b83-a7ca-
> 5242c4bb701f&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.18-
> rc4%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-
> patches.rst%23L586
>=20
> Wrapping looks a bit short...

Ack

>=20
> > need platform specific functions to initialize or alter them. For
> > better code reusibility, making a separate
>=20
> typo, I think it is: re-usability

Ack

>=20
> > res_ops which will hold all such function pointers or other resource
> > specific data.
>=20
> Are you saying that interrupts differ in different devices?
>=20

Yes, the interrupts are routed and integrated differently for the different=
 platforms

> >
> > This patch includes adding function pointer for IRQ
>=20
> Do not use =22This commit/patch=22.
> https://protect2.fireeye.com/v1/url?k=3Dffdc2502-9e57302d-ffddae4d-
> 74fe485cbfe7-49aeaacd1141660f&q=3D1&e=3D80994c2d-d0ca-4b83-a7ca-
> 5242c4bb701f&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17.1%2
> Fsource%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L95
>=20

Ack

> > initialization which will help to move common operations for host init
> > into the probe sequence.
> >
> > Suggested-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pci-samsung.c =7C 26
> > ++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-samsung.c
> > b/drivers/pci/controller/dwc/pci-samsung.c
> > index 47ca2a6a545d..01882f2d06c7 100644
> > --- a/drivers/pci/controller/dwc/pci-samsung.c
> > +++ b/drivers/pci/controller/dwc/pci-samsung.c
> > =40=40 -55,6 +55,7 =40=40 struct samsung_pcie_pdata =7B
> >  	struct pci_ops				*pci_ops;
> >  	const struct dw_pcie_ops		*dwc_ops;
> >  	const struct dw_pcie_host_ops		*host_ops;
> > +	const struct samsung_res_ops		*res_ops;
> >  =7D;
> >
> >  /*
> > =40=40 -77,6 +78,10 =40=40 struct samsung_pcie =7B
> >  	struct regulator_bulk_data	supplies=5B2=5D;
> >  =7D;
> >
> > +struct samsung_res_ops =7B
> > +	int (*irq_init)(struct samsung_pcie *sp, struct platform_device
> > +*pdev); =7D;
> > +
> >  static int samsung_pcie_init_clk_resources(struct samsung_pcie *sp)
> > =7B
> >  	struct device *dev =3D sp->pci.dev;
> > =40=40 -276,7 +281,7 =40=40 static const struct dw_pcie_host_ops
> exynos_pcie_host_ops =3D =7B
> >  	.host_init =3D exynos_pcie_host_init,
> >  =7D;
> >
> > -static int exynos_add_pcie_port(struct samsung_pcie *sp,
> > +static int exynos_irq_init(struct samsung_pcie *sp,
> >  				       struct platform_device *pdev)  =7B
> >  	struct dw_pcie *pci =3D &sp->pci;
> > =40=40 -295,15 +300,8 =40=40 static int exynos_add_pcie_port(struct
> samsung_pcie *sp,
> >  		return ret;
> >  	=7D
> >
> > -	pp->ops =3D &exynos_pcie_host_ops;
> >  	pp->msi_irq=5B0=5D =3D -ENODEV;
> >
> > -	ret =3D dw_pcie_host_init(pp);
> > -	if (ret) =7B
> > -		dev_err(dev, =22failed to initialize host=5Cn=22);
> > -		return ret;
> > -	=7D
> > -
> >  	return 0;
> >  =7D
> >
> > =40=40 -314,6 +312,10 =40=40 static const struct dw_pcie_ops
> exynos_dw_pcie_ops =3D =7B
> >  	.start_link =3D exynos_pcie_start_link,  =7D;
> >
> > +static const struct samsung_res_ops exynos_res_ops_data =3D =7B
> > +	.irq_init		=3D exynos_irq_init,
> > +=7D;
> > +
> >  static int samsung_pcie_probe(struct platform_device *pdev)  =7B
> >  	struct device *dev =3D &pdev->dev;
> > =40=40 -357,7 +359,12 =40=40 static int samsung_pcie_probe(struct
> > platform_device *pdev)
> >
> >  	platform_set_drvdata(pdev, sp);
> >
> > -	ret =3D exynos_add_pcie_port(sp, pdev);
> > +	if (pdata->res_ops->irq_init)
> > +		pdata->res_ops->irq_init(sp, pdev);
>=20
> Check return value and handle errors.
>=20

Ack

> > +
> > +	sp->pci.pp.ops =3D pdata->host_ops;
> > +
> > +	ret =3D dw_pcie_host_init(&sp->pci.pp);
> >  	if (ret < 0)
> >  		goto fail_probe;
> >
> > =40=40 -428,6 +435,7 =40=40 static const struct samsung_pcie_pdata
> exynos_5433_pcie_rc_pdata =3D =7B
> >  	.dwc_ops		=3D &exynos_dw_pcie_ops,
> >  	.pci_ops		=3D &exynos_pci_ops,
> >  	.host_ops		=3D &exynos_pcie_host_ops,
> > +	.res_ops		=3D &exynos_res_ops_data,
> >  =7D;
> >
> >  static const struct of_device_id samsung_pcie_of_match=5B=5D =3D =7B
>=20
> Best regards,
> Krzysztof


