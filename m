Return-Path: <linux-pci+bounces-28489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB05AC60E9
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5EB1BA680B
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B084B15E97;
	Wed, 28 May 2025 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DWiFbhLw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39E1F463E
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407997; cv=none; b=ttpIcD57IJfLcX77ibXsdz1a3Db35yPn3oJGmEEMkAgbP2Om/cIw/kNCGSrgj+1rVdzQFhQ96DYo+JfQ3FtSr7KNz1y9BYiYiDZWq3P8p63BJWAQdqT3SKFUnM+WcW5KuvgJWmhjBF9UcIerpuBApjOACEW9Au49nfklovKW41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407997; c=relaxed/simple;
	bh=RAmRBDHHzANqlpI3JYHbinrRwEYGSt2L+r91eUfb3Z4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=kRbWP+uN/eP7sKRVk2Fi4rZLdNhRlNSNQprXnu92PmUrJuwaSqJ1xVRA/ws2KWNCxbpjFWlIOZMA1qa8Pw1TBgq6TSBRXdvnuWc86rygP9XycpndcJXTBaMNBXbLvoXJYhW11oZtLPZ7nYVg6g5p934WwOpyRM9QPrl2gAsKYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DWiFbhLw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250528045313epoutp0332f9bc0e55a11061ffb5cbd051c3c8b4~Dl86TuYjU1180511805epoutp03P
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250528045313epoutp0332f9bc0e55a11061ffb5cbd051c3c8b4~Dl86TuYjU1180511805epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748407993;
	bh=vSFHOFEFt4zPbb0ejbZ4wikrbzI09NuGMD6delnPcEU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=DWiFbhLwcCDPESID2XH0u0EzRYt9ziTk/RCYSp4PbRjSeOne6T6wSYQkOI4cdJWnG
	 AI9AoOoFZfj/meSnCZOO2ZHsr8Xz7Hb0rD5keu2cJu0/5PYbGrW8eJif6/cE6RCpAN
	 rRLQZBZRXn9gl/Vcbu8XbUh7tCuuX2+kTS7cmKwQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250528045313epcas5p1ecb52dad3a981012954b224ff078da52~Dl85rzEE72901229012epcas5p1v;
	Wed, 28 May 2025 04:53:13 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.177]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b6cZb2Fchz3hhTJ; Wed, 28 May
	2025 04:53:11 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250527104428epcas5p3cb5025d804a47c843123c6a5d28043ea~DXGS77eVc2227822278epcas5p3W;
	Tue, 27 May 2025 10:44:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250527104428epsmtrp126974eb37a3fcc3be8bdd3cd0c1b5709~DXGS6edHN1837918379epsmtrp17;
	Tue, 27 May 2025 10:44:28 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-33-6835978bb7d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.08.19478.B8795386; Tue, 27 May 2025 19:44:27 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104425epsmtip2ff1602fd089de9fb8e3defd993065e4d~DXGQHLWWz3084930849epsmtip2U;
	Tue, 27 May 2025 10:44:24 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.or>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>
In-Reply-To: <20250521-capable-affable-numbat-b0ce84@kuoka>
Subject: RE: [PATCH 06/10] dt-bindings: PCI: Add bindings support for Tesla
 FSD SoC
Date: Tue, 27 May 2025 16:14:24 +0530
Message-ID: <0e2501dbcef4$51f144f0$f5d3ced0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gHPV3xcAfUWlT4CDvGzQLI5Pdaw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSvG73dNMMg5OfzS0ezNvGZvF30jF2
	iyVNGRZr9p5jsph/5ByrxY1fbawWK77MZLc42vqf2eLlrHtsFufPb2C3aOj5zWqx6fE1VovL
	u+awWZydd5zNYsKqbywWZ78vYLJo+dPCYrH2yF12i7stnawW//fsYLfYeecEs4Oox+9fkxg9
	ds66y+6xYFOpx6ZVnWwed67tYfN4cmU6k8fmJfUefVtWMXoc+TqdxePzJrkArigum5TUnMyy
	1CJ9uwSujGe71jAX/DOsmNa2mKmB8bBaFyMnh4SAicTlf5OYuxi5OIQEtjNKPFt6iBkiISnx
	+eI6JghbWGLlv+fsEEXPGCXOzG0CK2IT0JF4cuUPmC0ioCux+cZysCJmge0sEmeWPmQESQgJ
	vGKU2HrLHMTmFLCWWNH4gBXEFhYIlph+cw4biM0ioCqxYucjsHpeAUuJvtvv2SBsQYmTM5+w
	gNjMAtoSvQ9bGWHsZQtfQ12qIPHz6TJWiCPcJPq+X2OHqBGXOPqzh3kCo/AsJKNmIRk1C8mo
	WUhaFjCyrGIUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQITgBaQTsYl63/q3eIkYmD8RCjBAez
	kgjvtgkmGUK8KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1M
	zbynNX9l6hpdrf115Ndj6TDV79qrltyqPWLwao1u8y8/FxUpnrbolcVLnwmI3G536Ba40qAR
	nKjl+/XXyQkT9vVmtnEo/97657LSEkex/eWxh7bsf7SNbU+PeDnT3f3LtLaKbdSu0HscEtC3
	ZpKX9rGwrIorG82jjGSnZarNty7PO5t23OH4pg0+XapiipO/T756oCS4IFVOZYfD5I+5WU/N
	0lWcSsQmyz3UNt3UO+2lxwqn3Z0Pj85ueJk3+ad6g4PHjPowt2DOZ2w/OF8vOJ3OfXK53POF
	G0xCfecl8BjElzPrX/85a8L3OVvOK5q8Pt/98tytFr/WxxfO202brZy65HZ85KPZm0MnMF/Y
	psRSnJFoqMVcVJwIAPW8ddNvAwAA
X-CMS-MailID: 20250527104428epcas5p3cb5025d804a47c843123c6a5d28043ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193248epcas5p2543146c715eb249ea6c2ce3c78d03b34
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193248epcas5p2543146c715eb249ea6c2ce3c78d03b34@epcas5p2.samsung.com>
	<20250518193152.63476-7-shradha.t@samsung.com>
	<20250521-capable-affable-numbat-b0ce84@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 21 May 2025 15:07
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-=
kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.or;
> linux-kernel=40vger.kernel.org; linux-phy=40lists.infradead.org; manivann=
an.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=40gm=
ail.com; krzk+dt=40kernel.org; conor+dt=40kernel.org;
> alim.akhtar=40samsung.com; vkoul=40kernel.org; kishon=40kernel.org; arnd=
=40arndb.de; m.szyprowski=40samsung.com;
> jh80.chung=40samsung.com
> Subject: Re: =5BPATCH 06/10=5D dt-bindings: PCI: Add bindings support for=
 Tesla FSD SoC
>=20
> On Mon, May 19, 2025 at 01:01:48AM GMT, Shradha Todi wrote:
> > Document the PCIe controller device tree bindings for Tesla FSD SoC
> > for both RC and EP.
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  .../bindings/pci/samsung,exynos-pcie-ep.yaml  =7C  66 ++++++
> >  .../bindings/pci/samsung,exynos-pcie.yaml     =7C 199 ++++++++++++----=
--
> >  2 files changed, 198 insertions(+), 67 deletions(-)  create mode
> > 100644
> > Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml
> > b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml
> > new file mode 100644
> > index 000000000000..5d4a9067f727
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yam
> > +++ l
>=20
> Filename matching compatible.

Okay, will change it to tesla,fsd-pcie-ep.yaml

>=20
> > =40=40 -0,0 +1,66 =40=40
> > +=23 SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +=24id:
> > +https://protect2.fireeye.com/v1/url?k=3D011d92c7-5e86abcb-011c1988-000=
b
> > +abff3563-f87bc6d1cb527c28&q=3D1&e=3D3d0e8e81-bcdc-412b-ba41-5d5936c37c=
73&
> > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2Fsamsung%2Cexynos-pci=
e
> > +-ep.yaml%23
> > +=24schema:
> > +https://protect2.fireeye.com/v1/url?k=3Ddc0b3b6d-83900261-dc0ab022-000=
b
> > +abff3563-91c2c3470c50d358&q=3D1&e=3D3d0e8e81-bcdc-412b-ba41-5d5936c37c=
73&
> > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Samsung SoC series PCIe Endpoint Controller
> > +
> > +maintainers:
> > +  - Shradha Todi <shradha.t=40samsung.co>
> > +
> > +description: =7C+
> > +  Samsung SoCs PCIe endpoint controller is based on the Synopsys
> > +DesignWare
> > +  PCIe IP and thus inherits all the common properties defined in
> > +  snps,dw-pcie-ep.yaml.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>=20
> Drop
>=20
> > +      - enum:
> > +          - tesla,fsd-pcie-ep
> > +
> > +allOf:
> > +  - =24ref: /schemas/pci/snps,dw-pcie-ep.yaml=23
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - tesla,fsd-pcie-ep
>=20
> What is the point of this if:? There are no other variants.
>=20
> Also, missing constraints for all the properties. This is really incomple=
te.
>=20

Will add the constraints

> > +    then:
> > +      properties:
> > +        samsung,syscon-pcie:
> > +          description: phandle for system control registers, used to
> > +                       control signals at system level
>=20
> Where is the type defined? Look how such properties are described - there=
 are plenty of examples.
>=20
> > +
> > +      required:
> > +        - samsung,syscon-pcie
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - =7C
> > +    =23include <dt-bindings/clock/fsd-clk.h>
> > +    =23include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    bus =7B
> > +        =23address-cells =3D <2>;
> > +        =23size-cells =3D <2>;
> > +        pcieep0: pcie-ep=4016a00000 =7B
> > +            compatible =3D =22tesla,fsd-pcie-ep=22;
> > +            reg =3D <0x0 0x168b0000 0x0 0x1000>,
> > +                  <0x0 0x16a00000 0x0 0x2000>,
> > +                  <0x0 0x16a01000 0x0 0x80>,
> > +                  <0x0 0x17000000 0x0 0xff0000>;
> > +            reg-names =3D =22elbi=22, =22dbi=22, =22dbi2=22, =22addr_s=
pace=22;
> > +            clocks =3D <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
> > +                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
> > +                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
> > +                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
> > +            clock-names =3D =22aux=22, =22dbi=22, =22mstr=22, =22slv=
=22;
> > +            num-lanes =3D <4>;
> > +            samsung,syscon-pcie =3D <&sysreg_fsys1 0x50c>;
> > +            phys =3D <&pciephy1>;
> > +        =7D;
> > +    =7D;
> > +...
> > diff --git
> > a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > index f20ed7e709f7..a3803bf0ef84 100644
> > --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > =40=40 -11,78 +11,113 =40=40 maintainers:
> >    - Jaehoon Chung <jh80.chung=40samsung.com>
> >
> >  description: =7C+
> > -  Exynos5433 SoC PCIe host controller is based on the Synopsys
> > DesignWare
> > +  Samsung SoCs PCIe host controller is based on the Synopsys
> > + DesignWare
> >    PCIe IP and thus inherits all the common properties defined in
> >    snps,dw-pcie.yaml.
> >
> > -allOf:
> > -  - =24ref: /schemas/pci/snps,dw-pcie.yaml=23
> > -
> >  properties:
> >    compatible:
> > -    const: samsung,exynos5433-pcie
> > -
> > -  reg:
> > -    items:
> > -      - description: Data Bus Interface (DBI) registers.
> > -      - description: External Local Bus interface (ELBI) registers.
> > -      - description: PCIe configuration space region.
> > -
>=20
> No, I do not understand any of this change. Properties are defined in top=
-level. Why all this is being removed?
>=20

I changed the binding file to include both FSD and exynos which have quite =
a few different DT properties and constraints. I understand
I should keep the common properties like reg, phys defined in top-level. Wi=
ll do that.

>=20
> Best regards,
> Krzysztof



