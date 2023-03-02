Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD536A90F4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCCGZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCCGZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:25:21 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630041B42
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:24:48 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230303062444epoutp023870c729ee3b281c4cf6be4dfe39cca4~I1Kk6GBMA2850128501epoutp02S
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:24:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230303062444epoutp023870c729ee3b281c4cf6be4dfe39cca4~I1Kk6GBMA2850128501epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824684;
        bh=zwauUbHDBFAKCXTwTd7djaLC438IrmVRoTR6ZHnZliY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jdRjUfKhyEnqzCRjUdhPSK0YUFozsW5THntCA4qHqaBXZEUyz4TFVLiMn+jRsQUaQ
         vcPRaf/uWw/hyeISfw4CNDdKnDfhOV7r1IgyFp/QxMM95+sBMPDt+KrNhbbSk90Nvo
         ImCIiKeGXmMugu/Vh+doYhBl6Dk7Hk2N/CL0XO1M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230303062443epcas5p364289d18883d9fa523bc78ec1d16f65c~I1KkUsa470481004810epcas5p3P;
        Fri,  3 Mar 2023 06:24:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PSdHG1Ls6z4x9Q4; Fri,  3 Mar
        2023 06:24:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.29.55678.AA291046; Fri,  3 Mar 2023 15:24:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302125904epcas5p3cdb417fd006eab015a7068fe0ecd0a15~Im5mCuG_B1988819888epcas5p3D;
        Thu,  2 Mar 2023 12:59:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302125904epsmtrp287ccf687d09550af19740e616e4538bb~Im5mBglt_0911209112epsmtrp2C;
        Thu,  2 Mar 2023 12:59:04 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-de-640192aa83d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.A3.31821.89D90046; Thu,  2 Mar 2023 21:59:04 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302125901epsmtip2d8b2295cff14aefe6a843cb9e5cd09f5~Im5jU73321769817698epsmtip2W;
        Thu,  2 Mar 2023 12:59:01 +0000 (GMT)
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
In-Reply-To: <649a8d88-0504-5aa9-d167-d25d394f3f26@linaro.org>
Subject: RE: [PATCH 04/16] PCI: samsung: Use clock bulk API to get clocks
Date:   Thu, 2 Mar 2023 18:29:00 +0530
Message-ID: <139701d94d06$c4867930$4d936b90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwGjiO0UA2HNtG4CchXewq7amWJQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUVRz27L1770JS1xXzQCHbrSicgF2C7RKPagLmIiUwzFjj2NBt9w7L
        sC/2gZZTkeIwOrCBJI+Vp20UpCDLw21diHhkOAkZDJZiKGIpr+QRhaC0y4Xiv29+3/ed7/ed
        M0eACJcwb0Ga2sDq1IySxNzR1i7/5wPqjgO5eKYNpW5UtGKU5ZCCquzu41Pm1nJAzSz1odRX
        86U4ZbpzE6HaJlpwKit3iU9Zbw3xqQF7GUZdqriAUSX97TwqezkbpbJ7clDqTPd1nDrVMo9T
        Kw4bTi0X30OpJusJ5FVPetL6N05/Y76O01VWI22tO4rRw0MOjJ7u68PpscFiHt1k+ZhunLbx
        6FNZMxhtaq4D9Jx1R+LmvekRCpaRszoRq5Zp5Gnq1EgyPjnl9ZRQqVgSIAmjXiJFakbFRpLR
        byQGxKYpnT1JUSajNDpHiYxeTwZFReg0RgMrUmj0hkiS1cqV2hBtoJ5R6Y3q1EA1a3hZIhYH
        hzqF76YrfqmeRbQ9wgMz13ZnAdNjx4CbABIh0NFWjh8D7gIhcR7AyYFxzEUIiVkA8w8zHDEH
        4P2S29i647uJRpQj7AA25JpwznEHwIUCvgtjxAtwbHAZcWFPworAzhzaZUCIegDHqvN4LsKN
        iIKF1ZOoC28l4mDBT+2rZpR4Bn4+fnH1UA8iDB79cQnh8BbYWzq2qkcIX3huqgzhNhLBxds1
        fC4sFloKPwWcZjvsWcxFXMGQ+NoNWh/8wOMM0bBo9iqfw1vh+IVmnMPecG66ba1mKqxtKlkL
        UMKFJsua9xXYMVjmXELgDPCHDfYgbuwDT1ys53G5j8K8pbE1uQe0Vazjp+H8AwfKYS9Y8f0A
        Px+Q5g3VzBuqmTdUMP+fVgXQOuDFavWqVFYfqg1Ws/v/e2+ZRmUFq79g5y4buHnjXmAn4AlA
        J4AChPT0OJi1SS70kDPvf8DqNCk6o5LVd4JQ530XIN7bZBrnN1IbUiQhYeIQqVQaEvaiVEJu
        93guslcmJFIZA5vOslpWt+7jCdy8s3hV01e/lct+E4T92rgnc99oQq3SbFP6dgbV1PEa3znY
        nZzGT3hqKk002NEnVRXdZWqjYvZX7du1yfe0aWL0uOx8sONnXlLcyZPFtsmh8hHNtpi4y4/H
        EGIyOLfVN1ze33JEkY2P7y28H+8fPJzYknH6Tc0/oLKXFfuZVy6fLX8Y0DXyh59lePTW237X
        /JqSP6wBlXs+MSZt9lpY/OJuVUz0XMZrZ32TFPVXzimEO5r/Kg0Pt/z5iPuT7+WYfXyeXcl8
        4nDNRypB+6WMmoaGLZ9FVbj/fiY+ksksfNiVYDceEV9BvszJ6y6a6jFIR+y1h+x+beLdxIRt
        NmIxNi6/Y9Dx1kT/ARLVKxjJTkSnZ/4Fjv7DwY4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ3pzEBAxxbkggJaDRqUKkbjNVFiTNThAWNcYtSITuwIKJSm
        i4iiNFoXKmJdKQVcCdEqYAfBKpVEBAkuFUEJKETQulEgQFFEiEupJrx9Of9yzsOhMNEHPIhK
        kKs5pZxNlBDeePkjSWiEMX+cbN7RE7NQ+8VyAhUcikeXqu1CZCrPB6hv2I6j6wM5JMr60oGh
        B84yEmkzh4WI/9AkRI338wj0/GItgYwvKgVIN6LDka7mGI6KqttIdLVsgES/bVYSjWT34qiU
        P48t82O6+EGSuWdqI5nLvIbhzRkE09pkI5geu51kHK+yBUxpQTpj6bEKmKvaPoLJumMGjIsP
        WeOz2XuJjEtM2MMp50Zt945vvtKPKWpEe/vertaCrAl64EVBegF86LTgbhbRVgD1xWLPPBC6
        XhYLPCyGN359JvXA+6/nE4BG/RngFgh6DnS8GsH0gKL86CoMHkt1ezCaB9BVWIR5Ak4Amx48
        JtwBLzoKnr3SNbpNTEfD0/WVQjfj9Ax4rfMJ6WZfejHMeDaMeXgirMtxjPoxejY82XEEeDgU
        3u3OwzzXTYVDHwtHe/zolbDg7Kl/ngBYM5SJGYDYNKbKNKbKNKbKNCZyGeBmEMgpVElxSapI
        xXw5lyJVsUkqjTxOuiM5iQejfxAebgU2c6+0CggoUAUghUn8fPdrx8lEvjI2dR+nTN6m1CRy
        qiowmcIlAb71+rptIjqOVXO7OU7BKf+rAsorSCvQfH1IpLXmHugSzY2JyKwkvWoV6d8aLEZR
        z1Z/JuPgwVvvgxd1LxWy+w8MxJ4X18lTojfUB5XZbCnp/b9zgzpzwc5dMRfSbjgdj8/VDlyf
        xQfOiN5YdNMUMmmmgW1pZpw/GkOn6+x9javU/l3rrOaEPOHCTb+ExTsWzqs5bt/saMiPyY+K
        vK3esvMp3dzyRRNlCVFOXPu6rt0uxg5HVODSyuX+0W/KwoKzpccrdAvsW3xkyRtLpxkb2t+l
        /ZiwaP1PfeeU+YtLKuJetBRJciz7rg26hhgoSK62lFxa9r1kfO8mV173cHNscNvP07i6Q2SY
        /ii12qdwBYuHGQZXGcz9ElwVz0aGY0oV+we9G16cdgMAAA==
X-CMS-MailID: 20230302125904epcas5p3cdb417fd006eab015a7068fe0ecd0a15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121420epcas5p3a4419059969adfb45b379f7e7741968c
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121420epcas5p3a4419059969adfb45b379f7e7741968c@epcas5p3.samsung.com>
        <20230214121333.1837-5-shradha.t@samsung.com>
        <649a8d88-0504-5aa9-d167-d25d394f3f26@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 16 February 2023 16:33
> To: Shradha Todi <shradha.t@samsung.com>; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com;
> krzysztof.kozlowski+dt@linaro.org; alim.akhtar@samsung.com;
> jingoohan1@gmail.com; Sergey.Semin@baikalelectronics.ru;
> lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com; tglx@linutronix.de;
> m.szyprowski@samsung.com; jh80.chung@samsung.co;
> pankaj.dubey@samsung.com
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 04/16] PCI: samsung: Use clock bulk API to get clocks
> 
> On 14/02/2023 13:13, Shradha Todi wrote:
> > Adopt to clock bulk API to handle clocks.
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pci-samsung.c | 46 ++++++------------------
> >  1 file changed, 11 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-samsung.c
> b/drivers/pci/controller/dwc/pci-samsung.c
> > index cfe384aee754..6c07d3f151be 100644
> > --- a/drivers/pci/controller/dwc/pci-samsung.c
> > +++ b/drivers/pci/controller/dwc/pci-samsung.c
> > @@ -54,8 +54,8 @@
> >  struct exynos_pcie {
> >  	struct dw_pcie			pci;
> >  	void __iomem			*elbi_base;
> > -	struct clk			*clk;
> > -	struct clk			*bus_clk;
> > +	struct clk_bulk_data		*clks;
> > +	int				clk_cnt;
> >  	struct phy			*phy;
> >  	struct regulator_bulk_data	supplies[2];
> >  };
> > @@ -65,30 +65,18 @@ static int exynos_pcie_init_clk_resources(struct
> exynos_pcie *ep)
> >  	struct device *dev = ep->pci.dev;
> >  	int ret;
> >
> > -	ret = clk_prepare_enable(ep->clk);
> > -	if (ret) {
> > -		dev_err(dev, "cannot enable pcie rc clock");
> > +	ret = devm_clk_bulk_get_all(dev, &ep->clks);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >
> > -	ret = clk_prepare_enable(ep->bus_clk);
> > -	if (ret) {
> > -		dev_err(dev, "cannot enable pcie bus clock");
> > -		goto err_bus_clk;
> > -	}
> > +	ep->clk_cnt = ret;
> 
> I think this misses check if you got two clocks.
> 
> 

Got it! Thanks for pointing out. Will add the check in the next version

> Best regards,
> Krzysztof


