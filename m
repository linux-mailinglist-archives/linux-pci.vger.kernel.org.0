Return-Path: <linux-pci+bounces-31182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB0DAEFFD7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ED73AA4D6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2923506D;
	Tue,  1 Jul 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oQ6JxyiS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68E192D6B
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387471; cv=none; b=MunmoiajFmK+nC55pSCYKjq5cQmFXrJ9n5yQM+P4QZjFcYaxjJpb7FrvXLzlfye3TEohz+uL+onJG3HJc9PwO64rDZhJcp3x8X5EuPmKaXemBcZQYrfyX/PhQx4xvO2cOA9YwU5fjTiNArchfzC1EXph7O39P7x7Zp/eSUb22to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387471; c=relaxed/simple;
	bh=MeoEMfOmcdkXYLCQWxw+tTZR5HMiaiUUOfDp78nk0MM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=qmGKS/IcLbUWa+8EcjKkcO7KEWk4XmFMkXnYQYpp9AYPpsZd7ppw6SPa1F5zYuy5PNc/2eO62/Jp5xX6HZcNP0L048jyq3LKdslRtd38ANCa3F3DKwKeCJQnwkj/HFzr6EvNDG86fyHDX/nhtxN1UgticizS7i+CnQOzMoAg6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oQ6JxyiS; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250701163105epoutp048db2a4e8c3093332839a97e4a7bfc5c2~OLZ7pw0kI2900329003epoutp04I
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 16:31:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250701163105epoutp048db2a4e8c3093332839a97e4a7bfc5c2~OLZ7pw0kI2900329003epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751387465;
	bh=NV08uxmKxQiLzKQgdc7Udco8g49OXPRD/TVseEZ79Sg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=oQ6JxyiSsRb8OkrahQBSHBaP4SgZZP429A35wA+5j7trNIQjUSumf681zPY38ExXE
	 DtAXWVAFrep5Qyi6a4WS7QGBjopcen1fvWduJ1uYz2zPM/3nOWhLMWxmRXHtAk8DnY
	 zHHVzSruJiYtEna+RuSmMWF/ut4IyxrOnuM6kDBk=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250701163104epcas5p1a96bded3717d037acd2cf0fd71346d8f~OLZ6XQIha2226522265epcas5p1u;
	Tue,  1 Jul 2025 16:31:04 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.176]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bWpS62zKGz6B9m6; Tue,  1 Jul
	2025 16:31:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250701133519epcas5p487e7452860a95fd78fe65dea6781a0f4~OJAdeuWxM0466004660epcas5p4i;
	Tue,  1 Jul 2025 13:35:19 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250701133516epsmtip2097055360b4361ec0ac62f1bab9d901a~OJAap0Ruh1523815238epsmtip2J;
	Tue,  1 Jul 2025 13:35:16 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Rob Herring'"
	<robh@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-fsd@tesla.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <f877b3d7-d770-4424-9813-da748775f456@kernel.org>
Subject: RE: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for
 FSD SoC
Date: Tue, 1 Jul 2025 19:05:15 +0530
Message-ID: <02bf01dbea8c$fc835cb0$f58a1610$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFUClgbainc6hQuKSBO0V8ttZVgkwGg1JXJAfs/ltABn1f9rAD4JQ8bAeFf3fS07FvF0A==
Content-Language: en-in
X-CMS-MailID: 20250701133519epcas5p487e7452860a95fd78fe65dea6781a0f4
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
	<02af01dbea78$24f01310$6ed03930$@samsung.com>
	<f877b3d7-d770-4424-9813-da748775f456@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 01 July 2025 16:55
> To: Shradha Todi <shradha.t=40samsung.com>; 'Rob Herring' <robh=40kernel.=
org>
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-=
kernel=40lists.infradead.org; linux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-phy=
=40lists.infradead.org; linux-
> fsd=40tesla.com; mani=40kernel.org; lpieralisi=40kernel.org; kw=40linux.c=
om; bhelgaas=40google.com;
> jingoohan1=40gmail.com; krzk+dt=40kernel.org; conor+dt=40kernel.org; alim=
.akhtar=40samsung.com;
> vkoul=40kernel.org; kishon=40kernel.org; arnd=40arndb.de; m.szyprowski=40=
samsung.com;
> jh80.chung=40samsung.com; pankaj.dubey=40samsung.com
> Subject: Re: =5BPATCH v2 07/10=5D dt-bindings: phy: Add PHY bindings supp=
ort for FSD SoC
>=20
> On 01/07/2025 13:06, Shradha Todi wrote:
> >
> >
> >> -----Original Message-----
> >> From: Rob Herring <robh=40kernel.org>
> >> Sent: 28 June 2025 02:47
> >> To: Shradha Todi <shradha.t=40samsung.com>
> >> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-a=
rm-kernel=40lists.infradead.org;
> > linux-
> >> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-p=
hy=40lists.infradead.org; linux-
> >> fsd=40tesla.com; manivannan.sadhasivam=40linaro.org; lpieralisi=40kern=
el.org; kw=40linux.com;
> >> bhelgaas=40google.com; jingoohan1=40gmail.com; krzk+dt=40kernel.org; c=
onor+dt=40kernel.org;
> >> alim.akhtar=40samsung.com; vkoul=40kernel.org; kishon=40kernel.org; ar=
nd=40arndb.de;
> >> m.szyprowski=40samsung.com; jh80.chung=40samsung.com; pankaj.dubey=40s=
amsung.com
> >> Subject: Re: =5BPATCH v2 07/10=5D dt-bindings: phy: Add PHY bindings s=
upport for FSD SoC
> >>
> >> On Wed, Jun 25, 2025 at 10:22:26PM +0530, Shradha Todi wrote:
> >>> Document PHY device tree bindings for Tesla FSD SoCs.
> >>>
> >>> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> >>> ---
> >>>  .../bindings/phy/samsung,exynos-pcie-phy.yaml =7C 25 +++++++++++++++=
++--
> >>>  1 file changed, 23 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pci=
e-phy.yaml
> >> b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> >>> index 41df8bb08ff7..4dc20156cdde 100644
> >>> --- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.y=
aml
> >>> +++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.y=
aml
> >>> =40=40 -15,10 +15,13 =40=40 properties:
> >>>      const: 0
> >>>
> >>>    compatible:
> >>> -    const: samsung,exynos5433-pcie-phy
> >>> +    enum:
> >>> +      - samsung,exynos5433-pcie-phy
> >>> +      - tesla,fsd-pcie-phy
> >>>
> >>>    reg:
> >>> -    maxItems: 1
> >>> +    minItems: 1
> >>> +    maxItems: 2
> >>>
> >>>    samsung,pmu-syscon:
> >>>      =24ref: /schemas/types.yaml=23/definitions/phandle
> >>> =40=40 -30,6 +33,24 =40=40 properties:
> >>>      description: phandle for FSYS sysreg interface, used to control
> >>>                   sysreg registers bits for PCIe PHY
> >>>
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - tesla,fsd-pcie-phy
> >>> +    then:
> >>> +      description:
> >>> +        The PHY controller nodes are represented in the aliases node
> >>> +        using the following format 'pciephy=7Bn=7D'. Depending on wh=
ether
> >>> +        n is 0 or 1, the phy init sequence is chosen.
> >>
> >> What? Don't make up your own aliases.
> >>
> >> If the PHY instances are different, then maybe you need a different
> >> compatible. If this is just selecting the PHY mode, you can do that in
> >> PHY cells as the mode depends on the consumer.
> >>
> >
> > FSD PCIe has 2 instances of PHY. Both are the same HW Samsung
> > PHYs (Therefore share the same register offsets). But the PHY used here
>=20
> So same?
>=20
> > does not support auto adaptation so we need to tune the PHYs
> > according to the use case (considering channel loss, etc). This is why =
we
>=20
> So not same? Decide. Either it is same or not, cannot be both.
>=20
> If you mean that some wiring is different on the board, then how does it
> differ in soc thus how it is per-soc property? If these are use-cases,
> then how is even suitable for DT?
>=20
> I use your Tesla FSD differently and then I exchange DTSI and compatibles=
?
>=20
> You are no describing real problem and both binding and your
> explanations are vague and imprecise. Binding tells nothing about it, so
> it is example of skipping important decisions.
>=20
> > have 2 different SW PHY initialization sequence depending on the instan=
ce
> > number. Do you think having different compatible (something like
> > tesla,fsd-pcie-phy0 and tesla,fsd-pcie-phy1) and having phy ID as platf=
orm data
> > is okay in this case? I actually took reference from files like:
>=20
> And in different use case on same soc you are going to reverse
> compatibles or instance IDs?
>

Even though both the PHYs are exactly identical in terms of hardware,
they need to be programmed/initialized/configured differently.

Sorry for my misuse of the word =22use-case=22. To clarify, these configura=
tions
will always remain the same for FSD SoC even if you use it differently.

I will use different compatibles for them as I understand that it is the be=
st
option.
=20
> > drivers/usb/phy/phy-am335x-control.c
>=20
> So you took 15 years old hardware, code and binding as an example.
>=20
> No, don't do that ever.
>=20
> Anyway, poor choices even in newer code should not drive your design.
> Design it properly, describe the hardware.
>=20
> > drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > who use alias to differentiate between register offsets for instances.
>=20
>=20
>=20
> Best regards,
> Krzysztof


