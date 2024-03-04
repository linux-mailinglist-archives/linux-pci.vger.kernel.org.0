Return-Path: <linux-pci+bounces-4416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5887023D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FB01C22456
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD33D56B;
	Mon,  4 Mar 2024 13:07:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2107.outbound.protection.partner.outlook.cn [139.219.17.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7A3D55D;
	Mon,  4 Mar 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557659; cv=fail; b=tqREbXdhSvVge+93v0CPGpu5epDf7ABEICQgc433X4OnebextnkQnnUjhslsI7gAwaeA3jJlQmT72YaTHtxNEcHtyfPLgLO3CBPts4MaSFabXDdzS2/9uX7sGN7EJ2szTiMQF8EM/1BRdWN3iZL153Khh7dU/i7tHs6plWzU50M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557659; c=relaxed/simple;
	bh=eexKpw08DUxGgzkywEXB7FR4fjVoLBm6V1J0ohopiEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbSk6HwE6ptuXTsHTR2bU6YiRhv0z6hkFpIohpEFM3JXabSCxk7w/136Dhsd7obJ/phLSuX76ABE/sy3PBCh/2jO2530jPopO8nwnkUI+/LKHOqy4BoHxdIQyigVwT4bUByVFxzb6Is1tQYjmek9bqUXZioAygKqTJ3Okqlf26w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdODi3GhUip+VpSOWq5YQkWfNI7S9YctMpA+rbiBVqOP4tlGJso8WmWaZ42fGuZsjDBYlZBnjirV6gRKox4ixDxqUZybWINXwljw+azSZpBeF6wsBu5LJzhim9D/vORUZ5yd1+dCe230x/rJ9vbaKIEwkO2G80atwMSzqA5xJqG4UAcGXp3xtlQ3aLmJjghcva1L2YtTF+u8FyYp7wriIb2yl56O9gUoAf/qcjqKshG0rbHF4teR7oswOGch2LyuZo2/dLnUtyhToCy0cuyqVgLcAQ28RNyo7vhsaVHzPR3ucw0ohIg24jZN0EPW9476QChnps2TESeQTwpIZNTnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuLgaCec2X4iRlkDxeTa7P0vo5cmxd69iq/V87PCF9Y=;
 b=VqBkB1YEnVM45AWYE4cRwCR6R9s5xxYU+8pZVN/eLDNwouND3DEwBwMiWhc5kizk1pL4UuELWnepF9CJuBUocyakoF3j6z721sRJiFr8ew/fFYy+nBBOdqFZZ+ODXasGxAuaE5xOBq02sEL0mbL/Xx0Bieo3DgHq1t7DFPVaeyGGWAvTGRlpNpKRYYk/RBuIaxkY5QfFcM8t3rz/36V3mkf/2RkSOa1VWrSlGOKKJW8dsBgPHnl2+9qHgJCCy2+Y0IqbssD3wJL9Af7iigYZERO+Mx1LIHTvGKzoqd1vNaAYA9AlLM9GGsw4FGdHD1Jwg7NnK6a8LYnhXOQmG9KokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB1205.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Mon, 4 Mar
 2024 12:52:59 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::521f:319d:d2e0:8b91]) by
 ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn ([fe80::521f:319d:d2e0:8b91%4])
 with mapi id 15.20.7316.032; Mon, 4 Mar 2024 12:52:59 +0000
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Minda Chen
	<minda.chen@starfivetech.com>
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
	Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 21/23] PCI: starfive: Add JH7110 PCIe
 controller
Thread-Topic: [PATCH v15,RESEND 21/23] PCI: starfive: Add JH7110 PCIe
 controller
Thread-Index: AQHaaWi8BSKFyVphIUWdBo9IckSBIrEhYxMAgAYv43A=
Date: Mon, 4 Mar 2024 12:52:59 +0000
Message-ID:
 <ZQ0PR01MB098190462A6A394DA292BBE58223A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
 <20240227103522.80915-22-minda.chen@starfivetech.com>
 <ZeCThFcD2HBg8/bx@lpieralisi>
In-Reply-To: <ZeCThFcD2HBg8/bx@lpieralisi>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB1205:EE_
x-ms-office365-filtering-correlation-id: f2b54047-ea85-439b-fd3f-08dc3c4a051c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QTphUh/LN8KHmG9m7BmkerHtHZ9iy6p4bqmqW/7bszO6B84Lr5ujBu9YRPjMJ0C0B/G+lDzwkKlj1UbEl9GXRwGL+AylQWqDfDfnEUF1pE2gb13DKMy00tdW8WTKS03bM/whMTxdBFDrVTR1TS6pWRcbq82UUXCZ9YKMHaejQe9S2BHqPFOOK+v2JWAIo4LjOsX/zRwIHWoVBLo9hBhXGS/PNMQfpyhkElcsC7phuWIQNGFiogaBhvNF0B2Td1Ky7x7jDWd5vVxdDZuY02Cp6x0pB0sJT1ryuwJ6ore4ceZD728eV6vPWgG8woCfohT+CxxRxQ6mjUxwV+g9nrrY6j4fyYm7id+wOo778tphLbTIiEkWAzQcgUShIhiK5t4KS3G90gdiEhxGP5tcDP2frRut8Qxd1O6F/zZZOFw0d0dCQO3wXfnDeyYujhcNMIrdSY++UMqJdqmCFcTmXGC3MzsfAZY39NQLIfHB5yn/TeIEVYd6pqGHef5goV3wYLSSx21HPsHPqatZ45cmi4Ch52RF2LJT0dmjqLw+q3b5nJpSceMA09V6L659eEdu1czUnF6Ogzex7AeQwTXygn3Z7sHBGtdraUnhc9FSbJlXXNAI7AS1YBR3ZhWUVvHS84EA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?6lniIDTPobBD5zcLSUxHLgj1INA0blJhXaLdV3KBYShwzibrZc+vcabKVn?=
 =?iso-8859-2?Q?H1JppykKF24G8Q8wHqxfHvRh1k+M4t0+M/gjGf2Kt4MSl8X1OBluUBQ6Z5?=
 =?iso-8859-2?Q?eZhl7yYdsE7tAPv5q9A6jU7bssYrcUAc4PRaZCi/8e+2oXwE5TuHsMsV+r?=
 =?iso-8859-2?Q?+v+/Osv46XxX1rdeM0cFrV+0omjerOTJjpaKNmUDV4NNfgi4v1dfaSS3KH?=
 =?iso-8859-2?Q?ywSDmi0/AhsgIlYWSatjGkjVyqGC9LMb1gwxgJdXI7Xy8w1Nf4266A5cGx?=
 =?iso-8859-2?Q?yWtiDgRTFRFilRc37wPwcos/DnW2rbNnl8IyUCDMNEXtvkxS73NhCogLHh?=
 =?iso-8859-2?Q?yJcBEWDjOOPa2EAzIZ0rJh1u/tNuuaEkWmoC+CT1FAO+2w41oJxNX6UVaR?=
 =?iso-8859-2?Q?9RHdXxHrGFXVXWwii6TbuaMqHf6Jyyhuqt5fBsExih5PKSuidN3eV5FPGJ?=
 =?iso-8859-2?Q?qspL7Q8b5pcOhKmWouo+u+Yg3tf320oS2lIL6Fi6gtkIvRPzJD8qqz/Cx1?=
 =?iso-8859-2?Q?4ueTHX937U+vlBVRvr0WY8Z3KIB/4I0oCrvMg8OQADq2NwcSWMGDWdnY3e?=
 =?iso-8859-2?Q?Zmma6GG/g4c7pghzdlgSbf289PXI4IH+5nbOSxjR7gCG3HnYlj63neIbmX?=
 =?iso-8859-2?Q?ZScOjWPjbS0QbQztGLqb7TKh6C99x8SxUFm0UteYFrmlM4ySLyA70wTxH2?=
 =?iso-8859-2?Q?5+mlP+jHkNpYaH8PBwDFCKiDbhqyJZAnvyrzNhIrQ96i4s/dopuxYSfwku?=
 =?iso-8859-2?Q?XzMy3cSDvTFZ2tcNKfdNjflvqvFihV4bFJNrbIBXuJ04c9Aq2YETDz041K?=
 =?iso-8859-2?Q?iJ6NWfofwMiDdw2l1zQ1hbxnSLxA2aUqh88Xih9tDJScjRAHlX34Je9iG5?=
 =?iso-8859-2?Q?UEv573QYfCqFdDlLovi/9k87YWoTVJCwsftRGC93A86g39O2uei2PoYAbi?=
 =?iso-8859-2?Q?Sua+8FPdATvllvYy4KZS/x17FyqebIrpAxqreH74N/6g1sZ1t8OyVPXUSc?=
 =?iso-8859-2?Q?i2US3miLQ1NwQORSwciUv46n3sU1PacZrf6HUFlU1eBVphgJvivtdOYi+J?=
 =?iso-8859-2?Q?Em0LeHOuxNuUyXDlsEEeMIrlurOAgCqjISBgYQGcB8IMCVIcef04rF1kJI?=
 =?iso-8859-2?Q?gE8UNFJOhFwgrxFy9Z2QY0VOudb+/cbqM+InLKsWlryPuGseAHzCcw+iFO?=
 =?iso-8859-2?Q?nXkmJ8LbZVAb+WJeR9yWItazhUsMQoLeYJultU6ktBIYDT9Ld3j9TmZHGk?=
 =?iso-8859-2?Q?kpPbqPkVB+yyouHpXtON4oWOwYgSBo8o4sLONBC6AWug6vu7NII9EBImtl?=
 =?iso-8859-2?Q?mtilF2CJVci96aGucr1ghJQvEE199CC+1/hrDfenHNxqOOtHJ77ixsqnNO?=
 =?iso-8859-2?Q?9lrhv8E7YTlMp/BhZ1XbtwPeRIKPfbXL73cZ4nDqHLpk4fqFFV98iNMv9g?=
 =?iso-8859-2?Q?cMQzSR2vvH1OosuWfAAG2YoUNpBBDs19flWF/vIBaHXgHfP1SzC4QS4/GA?=
 =?iso-8859-2?Q?NnJ1AcRxDJvE8bwcE6hGugVtn8Pn9OkzRqlI1WCipWGyx5atTrbPZBsFj3?=
 =?iso-8859-2?Q?+6AqgJ49nKURBwd5SFe9amRqG0YLglwdEgBKXPWUlIxCY6ehBzQXRfuafk?=
 =?iso-8859-2?Q?qvCUH0KGfqcStLyry6CgHMmkS6LNz7n7ODeuPUoXYl/op41yGXMMEmPg?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b54047-ea85-439b-fd3f-08dc3c4a051c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 12:52:59.0654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lM55YT3CnU3zYaCoaf4LLoE6LnkzumqdHWRBljuZgKE6VQI/INoMxJCQTU9Sr83zvNqg7SR8cVgMVxL9I1w5WXNTy2PJ/Qv2ydvpvT2M6CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1205

> On Tue, Feb 27, 2024 at 06:35:20PM +0800, Minda Chen wrote:
> > Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
> > with PLDA host PCIe core.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > ---
> >  MAINTAINERS                                 |   7 +
> >  drivers/pci/controller/plda/Kconfig         |  12 +
> >  drivers/pci/controller/plda/Makefile        |   1 +
> >  drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
> >  drivers/pci/controller/plda/pcie-starfive.c | 473
> > ++++++++++++++++++++
> >  5 files changed, 563 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/pci/controller/plda/pcie-starfive.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > fc9576e69a71..d3b0a0fb754f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17078,6 +17078,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/socionext,uniphier-pcie*
> >  F:	drivers/pci/controller/dwc/pcie-uniphier*
> >
> > +PCIE DRIVER FOR STARFIVE JH71x0
> > +M:	Kevin Xie <kevin.xie@starfivetech.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/pci/starfive*
> > +F:	drivers/pci/controller/plda/pcie-starfive.c
> > +
> >  PCIE DRIVER FOR ST SPEAR13XX
> >  M:	Pratyush Anand <pratyush.anand@gmail.com>
> >  L:	linux-pci@vger.kernel.org

> > diff --git a/drivers/pci/controller/plda/pcie-plda.h
> > b/drivers/pci/controller/plda/pcie-plda.h
> > index 7b69891700a4..04e385758a2f 100644
> > --- a/drivers/pci/controller/plda/pcie-plda.h
> > +++ b/drivers/pci/controller/plda/pcie-plda.h
> > @@ -10,10 +10,20 @@
> >  #define PLDA_MAX_NUM_MSI_IRQS			32
> >
> >  /* PCIe Bridge Phy Regs */
> > +#define GEN_SETTINGS				0x80
> > +#define  RP_ENABLE				1
> > +#define PCIE_PCI_IDS_DW1			0x9c
> > +#define  IDS_CLASS_CODE_SHIFT			16
> > +#define  REVISION_ID_MASK			GENMASK(7, 0)
> > +#define  CLASS_CODE_ID_MASK			GENMASK(31, 8)
> >  #define PCIE_PCI_IRQ_DW0			0xa8
> >  #define  MSIX_CAP_MASK				BIT(31)
> >  #define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
> >  #define  NUM_MSI_MSGS_SHIFT			4
> > +#define PCI_MISC				0xb4
> > +#define  PHY_FUNCTION_DIS			BIT(15)
> > +#define PCIE_WINROM				0xfc
> > +#define  PREF_MEM_WIN_64_SUPPORT		BIT(3)
> >
> >  #define IMASK_LOCAL				0x180
> >  #define  DMA_END_ENGINE_0_MASK			0x00000000u
> > @@ -65,6 +75,8 @@
> >  #define ISTATUS_HOST				0x18c
> >  #define IMSI_ADDR				0x190
> >  #define ISTATUS_MSI				0x194
> > +#define PMSG_SUPPORT_RX				0x3f0
> > +#define  PMSG_LTR_SUPPORT			BIT(2)
> >
> >  /* PCIe Master table init defines */
> >  #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> > @@ -86,6 +98,8 @@
> >  #define  PCIE_TX_RX_INTERFACE			0x00000000u
> >  #define  PCIE_CONFIG_INTERFACE			0x00000001u
> >
> > +#define CONFIG_SPACE_ADDR_OFFSET		0x1000u
> > +
> >  #define ATR_ENTRY_SIZE				32
> >
> >  enum plda_int_event {
> > @@ -200,4 +214,59 @@ static inline void plda_set_default_msi(struct
> plda_msi *msi)
> >  	msi->vector_phy =3D IMSI_ADDR;
> >  	msi->num_vectors =3D PLDA_MAX_NUM_MSI_IRQS;  } -#endif
> > +
> > +static inline void plda_pcie_enable_root_port(struct plda_pcie_rp
> > +*plda) {
> > +	u32 value;
> > +
> > +	value =3D readl_relaxed(plda->bridge_addr + GEN_SETTINGS);
> > +	value |=3D RP_ENABLE;
> > +	writel_relaxed(value, plda->bridge_addr + GEN_SETTINGS); }
> > +
> > +static inline void plda_pcie_set_standard_class(struct plda_pcie_rp
> > +*plda) {
> > +	u32 value;
> > +
> > +	/* set class code and reserve revision id */
> > +	value =3D readl_relaxed(plda->bridge_addr + PCIE_PCI_IDS_DW1);
> > +	value &=3D REVISION_ID_MASK;
> > +	value |=3D (PCI_CLASS_BRIDGE_PCI << IDS_CLASS_CODE_SHIFT);
> > +	writel_relaxed(value, plda->bridge_addr + PCIE_PCI_IDS_DW1); }
> > +
> > +static inline void plda_pcie_set_pref_win_64bit(struct plda_pcie_rp
> > +*plda) {
> > +	u32 value;
> > +
> > +	value =3D readl_relaxed(plda->bridge_addr + PCIE_WINROM);
> > +	value |=3D PREF_MEM_WIN_64_SUPPORT;
> > +	writel_relaxed(value, plda->bridge_addr + PCIE_WINROM); }
>=20
> What does this do ?
>=20

This is an internal register to enable the prefetchable memory window
64-bit addressing support. ( disabled by default)
After this enable configuration, the address translation config in DTS
and ATU about 64-bit prefetchable memory are useful.

I will add the annotation here in the next version.

> > +static inline void plda_pcie_disable_ltr(struct plda_pcie_rp *plda) {
> > +	u32 value;
> > +
> > +	value =3D readl_relaxed(plda->bridge_addr + PMSG_SUPPORT_RX);
> > +	value &=3D ~PMSG_LTR_SUPPORT;
> > +	writel_relaxed(value, plda->bridge_addr + PMSG_SUPPORT_RX); }
> > +
> > +static inline void plda_pcie_disable_func(struct plda_pcie_rp *plda)
> > +{
> > +	u32 value;
> > +
> > +	value =3D readl_relaxed(plda->bridge_addr + PCI_MISC);
> > +	value |=3D PHY_FUNCTION_DIS;
> > +	writel_relaxed(value, plda->bridge_addr + PCI_MISC); }
> > +
> > +static inline void plda_pcie_write_rc_bar(struct plda_pcie_rp *plda,
> > +u64 val) {
> > +	void __iomem *addr =3D plda->bridge_addr +
> CONFIG_SPACE_ADDR_OFFSET;
> > +
> > +	writel_relaxed(lower_32_bits(val), addr + PCI_BASE_ADDRESS_0);
> > +	writel_relaxed(upper_32_bits(val), addr + PCI_BASE_ADDRESS_1); }
> > +#endif /* _PCIE_PLDA_H */
> > diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> > b/drivers/pci/controller/plda/pcie-starfive.c
> > new file mode 100644
> > index 000000000000..9bb9f0e29565
> > --- /dev/null
> > +++ b/drivers/pci/controller/plda/pcie-starfive.c
> > @@ -0,0 +1,473 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * PCIe host controller driver for StarFive JH7110 Soc.
> > + *
> > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/pci.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include "../../pci.h"
> > +
> > +#include "pcie-plda.h"
> > +
> > +#define PCIE_FUNC_NUM			4
> > +
> > +/* system control */
> > +#define STG_SYSCON_PCIE0_BASE			0x48
> > +#define STG_SYSCON_PCIE1_BASE			0x1f8
> > +
> > +#define STG_SYSCON_AR_OFFSET			0x78
> > +#define STG_SYSCON_AXI4_SLVL_AR_MASK		GENMASK(22, 8)
> > +#define STG_SYSCON_AXI4_SLVL_PHY_AR(x)
> 	FIELD_PREP(GENMASK(20, 17), x)
> > +#define STG_SYSCON_AW_OFFSET			0x7c
> > +#define STG_SYSCON_AXI4_SLVL_AW_MASK		GENMASK(14, 0)
> > +#define STG_SYSCON_AXI4_SLVL_PHY_AW(x)
> 	FIELD_PREP(GENMASK(12, 9), x)
> > +#define STG_SYSCON_CLKREQ			BIT(22)
> > +#define STG_SYSCON_CKREF_SRC_MASK		GENMASK(19, 18)
> > +#define STG_SYSCON_RP_NEP_OFFSET		0xe8
> > +#define STG_SYSCON_K_RP_NEP			BIT(8)
> > +#define STG_SYSCON_LNKSTA_OFFSET		0x170
> > +#define DATA_LINK_ACTIVE			BIT(5)
> > +
> > +/* Parameters for the waiting for link up routine */
> > +#define LINK_WAIT_MAX_RETRIES	10
> > +#define LINK_WAIT_USLEEP_MIN	90000
> > +#define LINK_WAIT_USLEEP_MAX	100000
> > +
> > +struct starfive_jh7110_pcie {
> > +	struct plda_pcie_rp plda;
> > +	struct reset_control *resets;
> > +	struct clk_bulk_data *clks;
> > +	struct regmap *reg_syscon;
> > +	struct gpio_desc *power_gpio;
> > +	struct gpio_desc *reset_gpio;
> > +	struct phy *phy;
> > +
> > +	unsigned int stg_pcie_base;
> > +	int num_clks;
> > +};
> > +
> > +/*
> > + * The BAR0/1 of bridge should be hidden during enumeration to
> > + * avoid the sizing and resource allocation by PCIe core.
>=20
> Please explain. This is what's preventing this driver to re-use the
> PCI_HOST_COMMON infrastructure and it is unclear why.
>=20

Sorry, we didn't explain it clearly enough here.
JH7110 PCIe port BAR0/1 is configured as 64-bit prefetchable memory
space, PCIe read and write requests targeting BAR0/1 are routed to so
called 'Bridge Configuration space' in PLDA datasheet, which contains
the bridge internal registers, such as interrupt, DMA & ATU registers...

JH7110 can access the Bridge Configuration space by local bus, and don`t
want the bridge internal registers accessed by the DMA from EP devices.
Thus, they are unimplemented and should be hidden.

I will modify the annotation in next version if you think it is ok.

> > + */
> > +static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned in=
t
> devfn,
> > +				      int offset)
> > +{
> > +	if (pci_is_root_bus(bus) && !devfn &&
> > +	    (offset =3D=3D PCI_BASE_ADDRESS_0 || offset =3D=3D PCI_BASE_ADDRE=
SS_1))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static int starfive_pcie_config_write(struct pci_bus *bus, unsigned in=
t devfn,
> > +				      int where, int size, u32 value) {
> > +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
> > +		return PCIBIOS_SUCCESSFUL;
> > +
> > +	return pci_generic_config_write(bus, devfn, where, size, value); }
> > +
> > +static int starfive_pcie_config_read(struct pci_bus *bus, unsigned int=
 devfn,
> > +				     int where, int size, u32 *value) {
> > +	if (starfive_pcie_hide_rc_bar(bus, devfn, where)) {
> > +		*value =3D 0;
> > +		return PCIBIOS_SUCCESSFUL;
> > +	}
> > +
> > +	return pci_generic_config_read(bus, devfn, where, size, value); }
> > +
> > +static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
> > +				  struct device *dev)
> > +{
> > +	int domain_nr;
> > +
> > +	pcie->num_clks =3D devm_clk_bulk_get_all(dev, &pcie->clks);
> > +	if (pcie->num_clks < 0)
> > +		return dev_err_probe(dev, pcie->num_clks,
> > +				     "failed to get pcie clocks\n");
> > +
> > +	pcie->resets =3D devm_reset_control_array_get_exclusive(dev);
> > +	if (IS_ERR(pcie->resets))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->resets),
> > +				     "failed to get pcie resets");
> > +
> > +	pcie->reg_syscon =3D
> > +		syscon_regmap_lookup_by_phandle(dev->of_node,
> > +						"starfive,stg-syscon");
> > +
> > +	if (IS_ERR(pcie->reg_syscon))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
> > +				     "failed to parse starfive,stg-syscon\n");
> > +
> > +	pcie->phy =3D devm_phy_optional_get(dev, NULL);
> > +	if (IS_ERR(pcie->phy))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->phy),
> > +				     "failed to get pcie phy\n");
> > +
> > +	domain_nr =3D of_get_pci_domain_nr(dev->of_node);
> > +
> > +	if (domain_nr < 0 || domain_nr > 1)
> > +		return dev_err_probe(dev, -ENODEV,
> > +				     "failed to get valid pcie domain\n");
> > +
> > +	if (domain_nr =3D=3D 0)
> > +		pcie->stg_pcie_base =3D STG_SYSCON_PCIE0_BASE;
> > +	else
> > +		pcie->stg_pcie_base =3D STG_SYSCON_PCIE1_BASE;
>=20
> I don't agree with this. The domain number is a software allocated value
> attached to a controller. It is written nowhere that you can't swap them =
and
> leave this code path broken.
>=20

We set 'linux,pci-domain =3D <0>' in our pcie0 DTS node, and <1> for=20
pcie1. The value should be static now.

As the STG system controller defines different bases in PCIe RP0 & RP1,
we have to identify which controller is doing the hardware initialization.
We discussed this before with other maintainers, do you have a better
suggestion?

> > +	pcie->reset_gpio =3D devm_gpiod_get_optional(dev, "perst",
> > +						   GPIOD_OUT_HIGH);
> > +	if (IS_ERR(pcie->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
> > +				     "failed to get perst-gpio\n");
> > +
> > +	pcie->power_gpio =3D devm_gpiod_get_optional(dev, "enable",
> > +						   GPIOD_OUT_LOW);
> > +	if (IS_ERR(pcie->power_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
> > +				     "failed to get power-gpio\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static struct pci_ops starfive_pcie_ops =3D {
> > +	.map_bus	=3D plda_pcie_map_bus,
>=20
> It looks like this is an ECAM driver with the read/config quirks for read=
/write in
> the method below. Please explain why they are needed.
>=20

Yes, that's for the hide RC BAR operations mentioned above.

> > +	.read           =3D starfive_pcie_config_read,
> > +	.write          =3D starfive_pcie_config_write,
> > +};
> > +
> > +static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie
> > +*pcie) {
> > +	struct device *dev =3D pcie->plda.dev;
> > +	int ret;
> > +
> > +	/* PCIe PCI Standard Configuration Identification Settings. */
> > +	plda_pcie_set_standard_class(plda);
> > +
> > +	/*
> > +	 * The LTR message forwarding of PCIe Message Reception was set by
> > +core
>=20
> "LTR message forwarding of PCIe Message Reception".
>=20
> What is this referring to ?
>=20

Sorry, this sentence is ambiguous.
"PCIe Message Reception" is a register to enable the function about forward=
ing
specific PCIe messages to AXI application, such as ATS/LTR/OBFF messages...
Here we clear bit 2 to disable the LTR message forwarding to the AXI applic=
ation.

I will modify the annotation in next version if you think it is ok.

Thank you for your valuable comments.
Kevin.

> Thanks,
> Lorenzo
>=20
> > +	 * as default, but the forward id & addr are also need to be reset.
> > +	 * If we do not disable LTR message forwarding here, or set a legal
> > +	 * forwarding address, the kernel will get stuck after the driver pro=
be.
> > +	 * To workaround, disable the LTR message forwarding support on
> > +	 * PCIe Message Reception.
> > +	 */
> > +	plda_pcie_disable_ltr(plda);
> > +
> > +	/* Prefetchable memory window 64-bit addressing support */
> > +	plda_pcie_set_pref_win_64bit(plda);
> > +
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

