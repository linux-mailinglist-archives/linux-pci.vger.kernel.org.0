Return-Path: <linux-pci+bounces-31156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C1AEF638
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 13:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1696C1C001F4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E24272814;
	Tue,  1 Jul 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cFsEWnz4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83068272815
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368339; cv=none; b=uouickFqJXe+nJ+85VdYlhond+A0OhmhgjuXarG/w3X3hxlTz0rAil7ow/QZgEskn5GYc1wAsVrRsZbDKoHPHvY1VIZuXW9KwEFdBoFknl7ZEx7U1AcB8IVHGOo7DS++bMhPAn4ivEIqJglvEqJeSDd5RDz5GrnagEUxoUQLY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368339; c=relaxed/simple;
	bh=M+teapMDErM1luC69yUTICbimOLTsaOpUH2S/iyezF4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=a1Kq76BQeDTLFE+1y+7k1ooxHAyXK1xSUlzeLTvDRAVbCOXlhpWxEE/aCwPXVkxnvokrK0qA1mh1vHnclHeM1f38fpcnKayktlH/N05PCYnqcTLoGTlYGYVc7gc9payZcL7nKLndRvuo3T2C9dtQO1yrzAxIKgmViXFqv1TTTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cFsEWnz4; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250701111209epoutp03900ed88098ba05093f2b9ee038362bac~OHDda6Ibw0922409224epoutp03f
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 11:12:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250701111209epoutp03900ed88098ba05093f2b9ee038362bac~OHDda6Ibw0922409224epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751368329;
	bh=YTwebVUoQkQpDDdsDBbSlrPKaFDW2GsaHKchVaUCu5k=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=cFsEWnz4p/bZVuWOkULA+mahIAzoo6OZidUhTNxWRxbJaF+y9gxkIs+loiEtNwldd
	 D5y+6OwXCoyM8FYJ6L+S6fZun41YKIz3yfAQs5hhiYX3YeByRJHm3vA/zzxMZL9SWP
	 C/jE1XS81elzOdp01jtlh8gmZvDfZYVL/ys5RiaU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250701111208epcas5p34bedc890d762054d069694d0ef399bb6~OHDcwX6uq3053630536epcas5p3U;
	Tue,  1 Jul 2025 11:12:08 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.177]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bWgN53tLPz2SSKX; Tue,  1 Jul
	2025 11:12:05 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250701110607epcas5p34c04a301caaf7d8c504eca2fec7f3139~OG_MoTLhB0394403944epcas5p3U;
	Tue,  1 Jul 2025 11:06:07 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250701110604epsmtip1b0a6d2e9ac97f7d6e2273144ea9b44df~OG_J9OoCr1403014030epsmtip1E;
	Tue,  1 Jul 2025 11:06:04 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Rob Herring'" <robh@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-fsd@tesla.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <20250627211721.GA153863-robh@kernel.org>
Subject: RE: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for
 FSD SoC
Date: Tue, 1 Jul 2025 16:36:03 +0530
Message-ID: <02af01dbea78$24f01310$6ed03930$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFUClgbainc6hQuKSBO0V8ttZVgkwGg1JXJAfs/ltABn1f9rLUC/odg
Content-Language: en-in
X-CMS-MailID: 20250701110607epcas5p34c04a301caaf7d8c504eca2fec7f3139
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03@epcas5p3.samsung.com>
	<20250625165229.3458-8-shradha.t@samsung.com>
	<20250627211721.GA153863-robh@kernel.org>



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 28 June 2025 02:47
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; linux-
> fsd@tesla.com; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org; kw@linux.com;
> bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de;
> m.szyprowski@samsung.com; jh80.chung@samsung.com; pankaj.dubey@samsung.com
> Subject: Re: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for FSD SoC
> 
> On Wed, Jun 25, 2025 at 10:22:26PM +0530, Shradha Todi wrote:
> > Document PHY device tree bindings for Tesla FSD SoCs.
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  .../bindings/phy/samsung,exynos-pcie-phy.yaml | 25 +++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> > index 41df8bb08ff7..4dc20156cdde 100644
> > --- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> > @@ -15,10 +15,13 @@ properties:
> >      const: 0
> >
> >    compatible:
> > -    const: samsung,exynos5433-pcie-phy
> > +    enum:
> > +      - samsung,exynos5433-pcie-phy
> > +      - tesla,fsd-pcie-phy
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >
> >    samsung,pmu-syscon:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> > @@ -30,6 +33,24 @@ properties:
> >      description: phandle for FSYS sysreg interface, used to control
> >                   sysreg registers bits for PCIe PHY
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - tesla,fsd-pcie-phy
> > +    then:
> > +      description:
> > +        The PHY controller nodes are represented in the aliases node
> > +        using the following format 'pciephy{n}'. Depending on whether
> > +        n is 0 or 1, the phy init sequence is chosen.
> 
> What? Don't make up your own aliases.
> 
> If the PHY instances are different, then maybe you need a different
> compatible. If this is just selecting the PHY mode, you can do that in
> PHY cells as the mode depends on the consumer.
> 

FSD PCIe has 2 instances of PHY. Both are the same HW Samsung
PHYs (Therefore share the same register offsets). But the PHY used here
does not support auto adaptation so we need to tune the PHYs
according to the use case (considering channel loss, etc). This is why we
have 2 different SW PHY initialization sequence depending on the instance
number. Do you think having different compatible (something like
tesla,fsd-pcie-phy0 and tesla,fsd-pcie-phy1) and having phy ID as platform data
is okay in this case? I actually took reference from files like:
drivers/usb/phy/phy-am335x-control.c
drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
who use alias to differentiate between register offsets for instances.

> 
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: PHY
> > +            - description: PCS
> 
> else:
>   properties:
>     reg:
>       maxItems: 1
> 

Will update. Thanks for the review!

> > +
> >  required:
> >    - "#phy-cells"
> >    - compatible
> > --
> > 2.49.0
> >


