Return-Path: <linux-pci+bounces-4242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA986C763
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FB31C2199E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F67B3D2;
	Thu, 29 Feb 2024 10:52:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2128.outbound.protection.partner.outlook.cn [139.219.146.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AB7AE6A;
	Thu, 29 Feb 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203941; cv=fail; b=rENLyxdRWsoB0QoSj7SEiB/8v17ygMzovDVI8Vy2w3CJW6c6vvJQ7+OsiK4tnBEZG2Hy3VatRALqREAq67JTNXRdPLx044v3l602Br5O1NFaATgcDLsLG0wgAgUd6uqglb8qFt9gx2ln9jWG4Tqpnq3yf4sx0JNCmOG1FMyI57c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203941; c=relaxed/simple;
	bh=TYLIcTBq8a235/rQTlh5+qCwkf+6DeuBhBxr7XWji5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOo64C8gwjmRaaS12eYxoHxOi0YvTeEzpTHpwBPCvtt2zvEJDkK0FHYHLoZU1+9v26EW4FUrnFXmDrbdnupW7YyO9knt2scGmQlwPuD7wWSPGBqRyWu/5t8La4QqcDjHSUDd4+58o82P+Hpck205F5FFLdIasQBVt92tdvYIj38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzjQFbYe1X11HwY89hhgHEz2oquTiqMsRrVBm7cfeBuvhpamdQXl1FY7ae20n5PePaVtlwYsOIq7Sw5w+Ee7RFbmks3uIXKZw1bA9Y3bIQaI/KRGAcyqR02/g4swfgom3zLamDW60FgHr7QzGtpJueclU/R+dDicgMyX6xbsNx//uHxjBaeHELccD8A9+xh7G79JbpYkHIVU7MxHwxTXvsZCAMUoawutTGUtPf1yfAh8zyoiNL5IZGstzjrp+EBuFt0fLIsm4bIsmMRDsdLw7BK1lEzDl3kVypXyngBKizplZcitUra4dfgTWof4fwQRCZ4JeU0JlnezxzLPeUeRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcmOtKtS/+B8PwYfe+WMht+hb8ZSkx+GJ1JChEt98xs=;
 b=lL+xtlWJqhejb49zDOU+9iEX7rTZWElbp7ae+TQZNJ7wkPdPb9b6OEnJziSIf2XfOqYi7zarPDx5CoISYf+3k95O71vT9+bcxTza/Od9fXs0g1EQwRVFmX9rCHynrch7eHxEh9UT6lyQsrSGLOUJPGAHVEgeWyAG7Y6uD+hxU5C5ZH1/YuP4ambFFbNbh4sbngLRMrMtk7pbXe8Tp6QKlaUK8xUVN2/IpUXNVEhKFiAL6QafKcqneurHSpu4ESPk8xmVWUpEnJ8ScmMZmo8PTcfA6GWYZfxX+QV7fJExBiuNKjGpTHBE6P6sGTV1eIEh2BMX4FHgVsTkxl/AgRqclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 10:52:07 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7316.039; Thu, 29 Feb 2024 10:52:06 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Conor Dooley <conor@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Daire McNamara
	<daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Philipp
 Zabel <p.zabel@pengutronix.de>, Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Kevin Xie
	<kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 03/23] PCI: microchip: Move PLDA IP register
 macros to pcie-plda.h
Thread-Topic: [PATCH v15,RESEND 03/23] PCI: microchip: Move PLDA IP register
 macros to pcie-plda.h
Thread-Index: AQHaaWix3B9VZd1Go0edJtBaKihhn7EhHJoAgAALP4A=
Date: Thu, 29 Feb 2024 10:52:06 +0000
Message-ID:
 <SHXPR01MB08639980F82FD130F9CD4D73E65FA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
 <20240227103522.80915-4-minda.chen@starfivetech.com>
 <ZeBYZtxqqXn5TlvL@lpieralisi>
In-Reply-To: <ZeBYZtxqqXn5TlvL@lpieralisi>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_
x-ms-office365-filtering-correlation-id: 3528a4af-9a6e-450f-4718-08dc391478d1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZLqciF7gDGED9cLcUDIR+yvrYIBZFd20uSIMx/pWOblhp+v4qW/BOscDRPaL6JtL3h7ZVLx4dA5n+YpKnGKLQdnEga+CeTf22KCBExsTtvplZTavc7Qa8TtEdDp69IQOQCobcgqBcahab8zCsBAaBB8/cqHMW7Z9AvS6zL06Z8nSnuiZ71hvL2em50myap8QgKSw59oGHWPWnEf/M6arhuNRMbBQgscDGuWhZ8yTILTEF+mVKPxH/A6j1MBwbpX8lrUzbtE+ZUmRJidG47sOQRMEDgaRY8pOT6oV5U6SzTU6Ev//1V8KkeUdiTjM1LquaX8ZiKmdKodg0ZqkfDcKi5nCCb5Qe0KwURpwiKXeCGL9rdijC7VShhxoeELgW58PloXh8ZV/np+QG0o5N7lGds/DmpDj0+/6HL0SWHFnWNQYfXBmyEJaEHAiPL6C7d9qRg8M+L2HwiibCDxXgrdBVv1H2amxoDcN1oesDbQcrUWj4Osxm5EST/uY8DcrdEN2bJ/62mxl4Wh2DirM+oYoEq3ECZ0a1kRUxeDrWg+SKvP7egTdUO/doCP3Dh0mVESlpxfxGzSHefKrsGaDT5i1BPH+NQID5O4iVCjqn39oC36TXjGoyn4WLXPkNVxjKNK/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?mf3/39XsbdRnhoXVYifgraUGvAUGSRlpSpJYZKjjhCg79Lumiux8VhGhzT?=
 =?iso-8859-2?Q?1F6j9x00BpKTKOCZp06UlPXtczEQFsNLfbqQSrzWQbNEukMoa7prv30j1t?=
 =?iso-8859-2?Q?7G1Zc33dgOs4Ht21f483cZOU+NfY4Q6CbKhcR9FTZjb7wWmdHo4qbogtJT?=
 =?iso-8859-2?Q?JLMVV4gfeKIeHfgcKt7kiyvDubXXlHkJKXX3vuZ+qUIKis4ACz7yYRRIDV?=
 =?iso-8859-2?Q?2SnqDm8XW8cwqKvJYSmJ41VVIsq6PQ7oyfcg8Pw6d9yWCfl3mouOaEoiND?=
 =?iso-8859-2?Q?wGkcBzCTwkHoaPBwACbi9uyKbsTHHlWJ9R/JfoUTRALF2zYcvQn0qJmb73?=
 =?iso-8859-2?Q?5I8m2p4puSaHDHJFrEDZ8frW/3s/9Cmi2qxg08VEm3QjD49XSEhvhq9hPR?=
 =?iso-8859-2?Q?rZKbJ6qx+7Rrv6li+Tl3WH84Kcw69503n5S97XTQ/VgfPmRtW6zBYCQL3L?=
 =?iso-8859-2?Q?aM7LmIaCXKlsiykvOuYVd0BwhKwEZH4GNJT0rcl4OK30clgDBTZx3KoFVK?=
 =?iso-8859-2?Q?vymQFJVtynhESOPzS1UbFWE8umM84R6TuYzuOJE6iqbWwXp/CQ8j7kN8tQ?=
 =?iso-8859-2?Q?mi6a6uM023l+n1rtpuKGPfAwKaLr/GoZGSVHUtIR8bl9D321ghdV23r9ba?=
 =?iso-8859-2?Q?hyBvt4Ydg3KikJygIcJslar/BcHypCqptLXGOin2vcP+1LItSdCWf4U9Sy?=
 =?iso-8859-2?Q?fJhkpBvyZcHJv/EQ11XW1hLh1o3DtDzP4AJmQ1AMJl3d1X/k5W9V86w+8R?=
 =?iso-8859-2?Q?IvOeYsYxTCvH8fAugmc96OmLDGZV5HQPm+cbGEoAuKCKsDWYfAtQSBJ//c?=
 =?iso-8859-2?Q?2flONVu1E4TkmkTMDoFMRTpDt+BQRGUGm0SZWheUH/m6w9so2ZC3GsMCJf?=
 =?iso-8859-2?Q?vL+o5jZXn1P7alWekUpyx55DRIjhNm7NiD3otc+enFwSx9v9OrjiKeo2g+?=
 =?iso-8859-2?Q?2uR8JV36Rwh1iIbyQQrMkghdRjzYHwTPoQaevv8gGOkaOZVDsgRGMuXXDA?=
 =?iso-8859-2?Q?yx6lRh4meO2i330desPs3jU+92fz9fP2KTsgPQRrdAiRdbE70N0orKF4/Q?=
 =?iso-8859-2?Q?cbAdC7zwcPshWCpo9g1fOv3UDLuoaGxRVnPPOP5V4oViev5LnN2t03DH95?=
 =?iso-8859-2?Q?sFY8Ue3HIFIWOYkShIM4n8P6lr3cXFcXVDPXeMhjZz6pqWWU1hb0GDF9w0?=
 =?iso-8859-2?Q?FbiwaUkvzT7xxqktSo42EiyP+g8LJFzeQkZBO7mlw+2WMj1bc4H62GSr6J?=
 =?iso-8859-2?Q?tF6x3GNIDYOI43SN2O8lgdTPZCMfLsjG7B2KZQmYFyDbeZlS3POtfivrI2?=
 =?iso-8859-2?Q?hV2iO2dSr+AACn8iN8sjxoH6aPi6ftfN3NtR/d0CIFFLPijBwPLyJ1X9gG?=
 =?iso-8859-2?Q?DRqyrpvuydzo13qae09OnsiKVgZkrcHbZj/MgtgAuAQgcmltC8dozdTyHQ?=
 =?iso-8859-2?Q?0ckDnp1mhZHNxKIUAjtBJEb6wt6B94bdwbPEnvrDk+3M1c6SadMWia6Wvk?=
 =?iso-8859-2?Q?ujCnTyXYwpJd2hnuch8UzKt/WPariU5imxpzU3dwFwETxgRZlnhqlEAP31?=
 =?iso-8859-2?Q?zBhQ/SQGcwAhnsaWGK8kDFljpIxifJSk7DhOHDB5jbO513qMVClWp4C5P6?=
 =?iso-8859-2?Q?5mcxdipRaRykmSp3TA0X4u+p9/i5zCCEgttEkZriadBZ7Y8hECc1KDdg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3528a4af-9a6e-450f-4718-08dc391478d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 10:52:06.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrH6lUAhZGteEKYlrd04Jw79vQBcjhlA3H8AaPiAUdOOd3pyw80vt1bLRf2aZ/onuVQCq0oQAvHOvghRBUUJaMfnW8cyYICYlTJdHwEhULs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863



>=20
> On Tue, Feb 27, 2024 at 06:35:02PM +0800, Minda Chen wrote:
> > Move PLDA PCIe host controller IP registers macros to pcie-plda.h,
> > including bridge registers and PLDA IRQ event number.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  MAINTAINERS                                   |   8 ++
> >  .../pci/controller/plda/pcie-microchip-host.c | 108 +++---------------
> >  drivers/pci/controller/plda/pcie-plda.h       | 108 ++++++++++++++++++
> >  3 files changed, 132 insertions(+), 92 deletions(-)  create mode
> > 100644 drivers/pci/controller/plda/pcie-plda.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 9f7e907c8749..fc9576e69a71 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16814,6 +16814,14 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> >  F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> >
> > +PCI DRIVER FOR PLDA PCIE IP
> > +M:	Daire McNamara <daire.mcnamara@microchip.com>
> > +M:	Kevin Xie <kevin.xie@starfivetech.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/pci/plda,*
>=20
> This is an unrelated change. It belongs to the patch adding DT bindings o=
r I am
> reading it wrong ?
>=20
> Lorenzo
>=20
You are right. Thanks
Moveing "F: Documentation/devicetree/bindings/pci/plda,*" to 1st patch is b=
etter.
This patch just add " F:	drivers/pci/controller/plda/*plda*"

> > +F:	drivers/pci/controller/plda/*plda*
> > +
> >  PCI DRIVER FOR RENESAS R-CAR
> >  M:	Marek Vasut <marek.vasut+renesas@gmail.com>
> >  M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> > b/drivers/pci/controller/plda/pcie-microchip-host.c
> > index cb09a8137e25..d9030d550482 100644
> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/platform_device.h>
> >
> >  #include "../../pci.h"
> > +#include "pcie-plda.h"
> >
> >  /* Number of MSI IRQs */
> >  #define MC_MAX_NUM_MSI_IRQS			32
> > @@ -30,84 +31,6 @@
> >  #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
> >  #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
> >
> > -/* PCIe Bridge Phy Regs */
> > -#define PCIE_PCI_IRQ_DW0			0xa8
> > -#define  MSIX_CAP_MASK				BIT(31)
> > -#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
> > -#define  NUM_MSI_MSGS_SHIFT			4
> > -
> > -#define IMASK_LOCAL				0x180
> > -#define  DMA_END_ENGINE_0_MASK			0x00000000u
> > -#define  DMA_END_ENGINE_0_SHIFT			0
> > -#define  DMA_END_ENGINE_1_MASK			0x00000000u
> > -#define  DMA_END_ENGINE_1_SHIFT			1
> > -#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
> > -#define  DMA_ERROR_ENGINE_0_SHIFT		8
> > -#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
> > -#define  DMA_ERROR_ENGINE_1_SHIFT		9
> > -#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
> > -#define  A_ATR_EVT_POST_ERR_SHIFT		16
> > -#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
> > -#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
> > -#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
> > -#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
> > -#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
> > -#define  A_ATR_EVT_DOORBELL_SHIFT		19
> > -#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
> > -#define  P_ATR_EVT_POST_ERR_SHIFT		20
> > -#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
> > -#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
> > -#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
> > -#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
> > -#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
> > -#define  P_ATR_EVT_DOORBELL_SHIFT		23
> > -#define  PM_MSI_INT_INTA_MASK			0x01000000u
> > -#define  PM_MSI_INT_INTA_SHIFT			24
> > -#define  PM_MSI_INT_INTB_MASK			0x02000000u
> > -#define  PM_MSI_INT_INTB_SHIFT			25
> > -#define  PM_MSI_INT_INTC_MASK			0x04000000u
> > -#define  PM_MSI_INT_INTC_SHIFT			26
> > -#define  PM_MSI_INT_INTD_MASK			0x08000000u
> > -#define  PM_MSI_INT_INTD_SHIFT			27
> > -#define  PM_MSI_INT_INTX_MASK			0x0f000000u
> > -#define  PM_MSI_INT_INTX_SHIFT			24
> > -#define  PM_MSI_INT_MSI_MASK			0x10000000u
> > -#define  PM_MSI_INT_MSI_SHIFT			28
> > -#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
> > -#define  PM_MSI_INT_AER_EVT_SHIFT		29
> > -#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
> > -#define  PM_MSI_INT_EVENTS_SHIFT		30
> > -#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
> > -#define  PM_MSI_INT_SYS_ERR_SHIFT		31
> > -#define  NUM_LOCAL_EVENTS			15
> > -#define ISTATUS_LOCAL				0x184
> > -#define IMASK_HOST				0x188
> > -#define ISTATUS_HOST				0x18c
> > -#define IMSI_ADDR				0x190
> > -#define ISTATUS_MSI				0x194
> > -
> > -/* PCIe Master table init defines */
> > -#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> > -#define  ATR0_PCIE_ATR_SIZE			0x25
> > -#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
> > -#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
> > -#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
> > -#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
> > -#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
> > -
> > -/* PCIe AXI slave table init defines */
> > -#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> > -#define  ATR_SIZE_SHIFT				1
> > -#define  ATR_IMPL_ENABLE			1
> > -#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
> > -#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
> > -#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
> > -#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> > -#define  PCIE_TX_RX_INTERFACE			0x00000000u
> > -#define  PCIE_CONFIG_INTERFACE			0x00000001u
> > -
> > -#define ATR_ENTRY_SIZE				32
> > -
> >  /* PCIe Controller Phy Regs */
> >  #define SEC_ERROR_EVENT_CNT			0x20
> >  #define DED_ERROR_EVENT_CNT			0x24
> > @@ -179,20 +102,21 @@
> >  #define EVENT_LOCAL_DMA_END_ENGINE_1		12
> >  #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
> >  #define EVENT_LOCAL_DMA_ERROR_ENGINE_1		14
> > -#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		15
> > -#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		16
> > -#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	17
> > -#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		18
> > -#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		19
> > -#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		20
> > -#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	21
> > -#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		22
> > -#define EVENT_LOCAL_PM_MSI_INT_INTX		23
> > -#define EVENT_LOCAL_PM_MSI_INT_MSI		24
> > -#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		25
> > -#define EVENT_LOCAL_PM_MSI_INT_EVENTS		26
> > -#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		27
> > -#define NUM_EVENTS				28
> > +#define NUM_MC_EVENTS				15
> > +#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		(NUM_MC_EVENTS
> + PLDA_AXI_POST_ERR)
> > +#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS
> + PLDA_AXI_FETCH_ERR)
> > +#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS +
> PLDA_AXI_DISCARD_ERR)
> > +#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		(NUM_MC_EVENTS
> + PLDA_AXI_DOORBELL)
> > +#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		(NUM_MC_EVENTS
> + PLDA_PCIE_POST_ERR)
> > +#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS
> + PLDA_PCIE_FETCH_ERR)
> > +#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS +
> PLDA_PCIE_DISCARD_ERR)
> > +#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		(NUM_MC_EVENTS
> + PLDA_PCIE_DOORBELL)
> > +#define EVENT_LOCAL_PM_MSI_INT_INTX		(NUM_MC_EVENTS +
> PLDA_INTX)
> > +#define EVENT_LOCAL_PM_MSI_INT_MSI		(NUM_MC_EVENTS +
> PLDA_MSI)
> > +#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		(NUM_MC_EVENTS
> + PLDA_AER_EVENT)
> > +#define EVENT_LOCAL_PM_MSI_INT_EVENTS		(NUM_MC_EVENTS +
> PLDA_MISC_EVENTS)
> > +#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		(NUM_MC_EVENTS
> + PLDA_SYS_ERR)
> > +#define NUM_EVENTS				(NUM_MC_EVENTS +
> PLDA_INT_EVENT_NUM)
> >
> >  #define PCIE_EVENT_CAUSE(x, s)	\
> >  	[EVENT_PCIE_ ## x] =3D { __stringify(x), s } diff --git
> > a/drivers/pci/controller/plda/pcie-plda.h
> > b/drivers/pci/controller/plda/pcie-plda.h
> > new file mode 100644
> > index 000000000000..65e0f3b72184
> > --- /dev/null
> > +++ b/drivers/pci/controller/plda/pcie-plda.h
> > @@ -0,0 +1,108 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * PLDA PCIe host controller driver
> > + */
> > +
> > +#ifndef _PCIE_PLDA_H
> > +#define _PCIE_PLDA_H
> > +
> > +/* PCIe Bridge Phy Regs */
> > +#define PCIE_PCI_IRQ_DW0			0xa8
> > +#define  MSIX_CAP_MASK				BIT(31)
> > +#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
> > +#define  NUM_MSI_MSGS_SHIFT			4
> > +
> > +#define IMASK_LOCAL				0x180
> > +#define  DMA_END_ENGINE_0_MASK			0x00000000u
> > +#define  DMA_END_ENGINE_0_SHIFT			0
> > +#define  DMA_END_ENGINE_1_MASK			0x00000000u
> > +#define  DMA_END_ENGINE_1_SHIFT			1
> > +#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
> > +#define  DMA_ERROR_ENGINE_0_SHIFT		8
> > +#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
> > +#define  DMA_ERROR_ENGINE_1_SHIFT		9
> > +#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
> > +#define  A_ATR_EVT_POST_ERR_SHIFT		16
> > +#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
> > +#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
> > +#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
> > +#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
> > +#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
> > +#define  A_ATR_EVT_DOORBELL_SHIFT		19
> > +#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
> > +#define  P_ATR_EVT_POST_ERR_SHIFT		20
> > +#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
> > +#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
> > +#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
> > +#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
> > +#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
> > +#define  P_ATR_EVT_DOORBELL_SHIFT		23
> > +#define  PM_MSI_INT_INTA_MASK			0x01000000u
> > +#define  PM_MSI_INT_INTA_SHIFT			24
> > +#define  PM_MSI_INT_INTB_MASK			0x02000000u
> > +#define  PM_MSI_INT_INTB_SHIFT			25
> > +#define  PM_MSI_INT_INTC_MASK			0x04000000u
> > +#define  PM_MSI_INT_INTC_SHIFT			26
> > +#define  PM_MSI_INT_INTD_MASK			0x08000000u
> > +#define  PM_MSI_INT_INTD_SHIFT			27
> > +#define  PM_MSI_INT_INTX_MASK			0x0f000000u
> > +#define  PM_MSI_INT_INTX_SHIFT			24
> > +#define  PM_MSI_INT_MSI_MASK			0x10000000u
> > +#define  PM_MSI_INT_MSI_SHIFT			28
> > +#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
> > +#define  PM_MSI_INT_AER_EVT_SHIFT		29
> > +#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
> > +#define  PM_MSI_INT_EVENTS_SHIFT		30
> > +#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
> > +#define  PM_MSI_INT_SYS_ERR_SHIFT		31
> > +#define  NUM_LOCAL_EVENTS			15
> > +#define ISTATUS_LOCAL				0x184
> > +#define IMASK_HOST				0x188
> > +#define ISTATUS_HOST				0x18c
> > +#define IMSI_ADDR				0x190
> > +#define ISTATUS_MSI				0x194
> > +
> > +/* PCIe Master table init defines */
> > +#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> > +#define  ATR0_PCIE_ATR_SIZE			0x25
> > +#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
> > +#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
> > +#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
> > +#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
> > +#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
> > +
> > +/* PCIe AXI slave table init defines */
> > +#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> > +#define  ATR_SIZE_SHIFT				1
> > +#define  ATR_IMPL_ENABLE			1
> > +#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
> > +#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
> > +#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
> > +#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> > +#define  PCIE_TX_RX_INTERFACE			0x00000000u
> > +#define  PCIE_CONFIG_INTERFACE			0x00000001u
> > +
> > +#define ATR_ENTRY_SIZE				32
> > +
> > +enum plda_int_event {
> > +	PLDA_AXI_POST_ERR,
> > +	PLDA_AXI_FETCH_ERR,
> > +	PLDA_AXI_DISCARD_ERR,
> > +	PLDA_AXI_DOORBELL,
> > +	PLDA_PCIE_POST_ERR,
> > +	PLDA_PCIE_FETCH_ERR,
> > +	PLDA_PCIE_DISCARD_ERR,
> > +	PLDA_PCIE_DOORBELL,
> > +	PLDA_INTX,
> > +	PLDA_MSI,
> > +	PLDA_AER_EVENT,
> > +	PLDA_MISC_EVENTS,
> > +	PLDA_SYS_ERR,
> > +	PLDA_INT_EVENT_NUM
> > +};
> > +
> > +#define PLDA_NUM_DMA_EVENTS			16
> > +
> > +#define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS +
> PLDA_INT_EVENT_NUM)
> > +
> > +#endif
> > --
> > 2.17.1
> >

