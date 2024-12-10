Return-Path: <linux-pci+bounces-17988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD559EA8D0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 07:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04473282B03
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC522B8D1;
	Tue, 10 Dec 2024 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3G5NnlQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F114A0AA;
	Tue, 10 Dec 2024 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733812678; cv=fail; b=nWjdnepj4268WwXH3efY4kVVP927fdyP5x7T3hijlgZBbO0CDXa/VSCIdX/vdVIOsSZlc2hBnYUmXCmaQbE0B0zwlmRYcgfJPq2E4cOcnXOvl6e5/W4Whz32DLikSOGFR19DTIuwQGmiZWH38wCDjlBqFCjExdXw41/w/yIxvZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733812678; c=relaxed/simple;
	bh=mPpENjrvlweAt/aifB4R+Qc9hLVgiMZBmqKxmXW6HH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ctm/t3Z7A8BWByYAGENXJYYzF0mXSyPo/c/s7PaOorlRWkPKtaHCkwAcadN9N60ps3RROzW5xRPSQOix0Tm6gbs9PKVlvl3QhLkCVw2aci6m33vmqjVQpPm4t40GGrG/x37EPpumNcf55GuHp9Cl0oO0F7IbptZ/fo4Lz2bkF50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3G5NnlQk; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIbhjQGKKNV6h/m8MmMUpvuY/1EAWwpezmtuiMbuEZ5P19eDjqBatJiBNbzQdoquYAgLtFHGoRQ6QYQ011OjXAr83slXhxyEEftVcSR9lBdRPe30dmAhxE+tnCqelrs903GeZ/GB1NY0NXlZzBtsmAU16g6V4Ko/JpFpGr550YYqLMV9W2qxYrg+6zs8uKF2VdUnigrcF2YYVVKKLZp5GQ6C172rQnZM0xuCvqoNHqgbhcCOoRq1XFWaUivA7Xg/mKFuxSOD1Yct1BfgwrYgFR8nB1IZtWpZU88PUz2cmVT/PndXmJfNSY4Pugql64v5EIWz+1S9VLl8EJk5Gr0sEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+ZeVIcAbmThO/E4IByAPqxvkwi5C2mNesWKHR/yeEg=;
 b=FKzuCelxLGXIKGSfIXJ1lphnhNhuM1TDTD7UTpOzfDiKH1hS2SP/fLqeysB1LdIeLA1i30uidrYNpup327WS4RIE3exDAOGF1a9Ns1sDNn+1P2iZpIiQJuomHLxmHLUJBBuIhIiKJZsf4W7kW7915c1yBs0nQWRKRS8BvxcB+QEq/ndwlY5HamehMDxB7q5dovTUXjzuturoRO25Wl97VEXxX82IIZZ10b0gh2xQE5LIeNxqPraqgxBon6x4DT9t85DhAjnZP0Pq8Az27jMdi4A3KXdUzBWgg0rn/lfOtw8uOK4InClvKqH5s5F9QfBgMeQUmYW/5Kg0LZ/Qio7G0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+ZeVIcAbmThO/E4IByAPqxvkwi5C2mNesWKHR/yeEg=;
 b=3G5NnlQkomBDQZh3UybWkv2N7ujBgn97QarICKb9kZgSnoFxWeF9tqhzTePm1mip3CMMZWJWWW1Jesx0acX0DAn1RbvzsAZYAUEUTpeCdCYAaaPHAzRaS3hKgMT8LiXJVbLtI9duKBwPRg9OB/UUcoV0V4muklzuAsQ7xpuGtTY=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 06:37:52 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8207.014; Tue, 10 Dec 2024
 06:37:52 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, "Gogada,
 Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB
 PCIe Root Port Bridge
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB
 PCIe Root Port Bridge
Thread-Index: AQHbRX/9tKefBNodzkOGfTPvQMzdCrLUl76AgAD++PCACXYaAA==
Date: Tue, 10 Dec 2024 06:37:52 +0000
Message-ID:
 <SN7PR12MB72014E558437E5B6E630E72E8B3D2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241203123608.2944662-1-thippeswamy.havalige@amd.com>
 <20241203123608.2944662-2-thippeswamy.havalige@amd.com>
 <20241203144101.GA1756254-robh@kernel.org>
 <SN7PR12MB7201C658D71FDB5D8FD891838B372@SN7PR12MB7201.namprd12.prod.outlook.com>
In-Reply-To:
 <SN7PR12MB7201C658D71FDB5D8FD891838B372@SN7PR12MB7201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM6PR12MB4420:EE_
x-ms-office365-filtering-correlation-id: e1728bf6-f7de-4b8c-4e14-08dd18e52c18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?grO79wZKPTwGwcbe5WW2jNiQwEXm7E4ydB61ybQNqIFs+nW5C42vr8XrOTns?=
 =?us-ascii?Q?B1jYmGWaIr5d9m2e3UMtq9drvh2Pho3SgngF20dKYyyNfhalIldufQX1vIFT?=
 =?us-ascii?Q?tE1nwyOEj7KUlbOeicg049xTBnET/NiUDYsY/2BLxE+vvGG5KnE7VwqQVxdD?=
 =?us-ascii?Q?zwSP6LuICE0oNipqxta/h0jpH8I1SFB6t81BNUtDamPRFF9Auf7viH94LdXl?=
 =?us-ascii?Q?9oo8t8SFshyH9UmCmgWA89zbeny8Zd3sMvhX+/kiJ89Tgyn7VLBVg4HPT6MM?=
 =?us-ascii?Q?4dMBVEAgfpxvxVYkmnENslc3CnUTzf4tcvoe5Had04GKfYcSvuFtkgf+7ATD?=
 =?us-ascii?Q?4cyOa3tq6pbKBDpLjCF71/Gs1kqIVK+RiJ6EsPznxOxJ7Ymw+50jPifqFDhJ?=
 =?us-ascii?Q?ykI0tgw46bZ//9vehABUdL+cU5a369CoTBTYrMYhfTIjFoVg58F9xvx3zIZ/?=
 =?us-ascii?Q?MhlkWs989LpSMhifUMwB2sJfe9+e/ZqNms2l9Ae6vYtDFqhy0DAHUJJmu6tQ?=
 =?us-ascii?Q?74/rLmT8ZDsQzbgm02HIcfeVZjG2lKlClDAZcLBhQcTWg4bDnMZ5hmiJMaGi?=
 =?us-ascii?Q?frGJV2vkWRCXXVANp+Xf+yJMayyPzCU5l6ReDrsTPyDHoT2PcTsOQgsTq58N?=
 =?us-ascii?Q?Z4VtDjP/CMHBpyDsoywWFEfpzI8ZsxsFrKTORHMV1iYbR28OVB3NqVMGkTt7?=
 =?us-ascii?Q?ufNpLU2RD/0ltnMDrhQYm0w70EpVOKiEJgDWInAnInnRRJh+iSzPAy8Uopd4?=
 =?us-ascii?Q?cf9hwD5guOGKDIdOPGy2qlRCVBMI/sOL3/v7tjd6eFSzgnRupAaDreDYE4yF?=
 =?us-ascii?Q?3H8B0QYRa+sWblxSw/p1Y8C0hRsryiYoIZ9Gpz7TpZEZ5UZZbQGgZXav2JMw?=
 =?us-ascii?Q?jwL8PZMaotDeAvjnQeeS430C9Mqs+LS9bzashxB6YwzF392s/UzMnTENMutN?=
 =?us-ascii?Q?P0gHPW5X5EqoYl9NrWGie6PpSy8q00ijdAB0YwY/0PV/8lwo/52Ein6oDlhU?=
 =?us-ascii?Q?udqkPluahpiLHSGl3thQMgm7ng2wYNgvCBwBCQfsbZHFJYfIZBOqRtYGMxEM?=
 =?us-ascii?Q?sIp0EosvkwRCqXkh0xsg/0IM17sE0rfHhkhEDD2IvhVyteHvl2IaCU/b5TRA?=
 =?us-ascii?Q?AcAf5kqNV59awYDg7f+FeYNLVpaIBaoywD8Jg1M93+IVF9tVCUFlXTBSsrwY?=
 =?us-ascii?Q?JwPz+ELruGBZrDKBFGixkJQdSTKdxPrqYXVidz1cnDt/qKIvQGmy/pdR8Xpk?=
 =?us-ascii?Q?uW8h0MwAxaJCMuewhLjwQzUmCuIwCh+LIZJ7iwY5oIYU3XItjq9L9eMxObwj?=
 =?us-ascii?Q?v9CoCNG2vyYQccBeABl+dxqBBiLgUQWOLSKtzQFtep50QJvEQ91kPZe2jcpb?=
 =?us-ascii?Q?OPULyTs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uVsY/mUdnuH0LpvAqywWoxQqBHdEJovow35ZdT6QTbYsQiQDxvGwNbmQMFp5?=
 =?us-ascii?Q?xG6GmDu7RSuIqEEpjWrt/my6hZVo0k+9MLO09XK2ZS8w2UnCdT6258A1bgrB?=
 =?us-ascii?Q?tlqci+G+/mnjeJmO7En4uHruYCD08GJp9Nv9V3qG9qJVhnFLvVg6O5wAn0ms?=
 =?us-ascii?Q?LTebCbokFlOcL3MtwwbWKRJw0S8z6PMbM7eezQz52B9bLuB05oGZHs7vPatQ?=
 =?us-ascii?Q?XM60kWd4XC4qnNGFNfjzMqzknC4+VeYdfzXpkQJl7XcviP/GA6CY5cydz9k+?=
 =?us-ascii?Q?Bvq5fvJ/LOpfu112fAGC9oLOySbB2sxjL/zuxu1a8XICsdclcpUNKXhIdnXn?=
 =?us-ascii?Q?n70IoR9dUX1+oQKouqXkuzy70uU1D1HiEH0PKzdnNTggPF6QNRjlJLp65aaD?=
 =?us-ascii?Q?c5z2NMEpZLCNE9G4uTnILrh+l7PyBsOadTn686WuB4vH6Yah304d9maZr90a?=
 =?us-ascii?Q?VD0MlsN9F4iEgukMaFsSUA06yRMV4DCgD1Rw0UWyxsgjQ+Wvkh12jJQgWO8f?=
 =?us-ascii?Q?giLU12B/OPXeL8PrVRfjxVw4y5H97w+3Y8CekSa5Qhdif2CHimEXYkr3zk8H?=
 =?us-ascii?Q?T5xfbn0zv5eeuNecBbzB2KaE5NhK9tTDHgHf+yzxFuC3TN6XGT/3f1HJ7WgA?=
 =?us-ascii?Q?e7X+SgvbRExy1IDq92POdvYC4IHzxxcQ72MzhM9PYj7iHy8nBZxK46u/FOpU?=
 =?us-ascii?Q?hTWAyYG/e1LK7ghuZpTelu9ua7aw8OvZKIfhCto8uMQzowNND7purO5f30Zs?=
 =?us-ascii?Q?oUHhi1SVoammR4iweS453TMIbsdfqOP7PrQ+6vbgktVUqTKdDarHvAnDi6c0?=
 =?us-ascii?Q?kCLo4uYflJ0yen/fwpXtsq75P/aWb1/0zpZw7HFXZ2DlLax4JlfPipiqXAW+?=
 =?us-ascii?Q?Sdb3mriCsTOEh7tX7dHuoxDIb0m2aKAIXwAovxrLGISezThA6AHcVsBgDhIn?=
 =?us-ascii?Q?et2qx6fal5zHCEJfHm44FTY2gTnOiGwRsh+yW50Yi/NoT0c+ROMdfPzw4BSG?=
 =?us-ascii?Q?pvzDRCxbr0bAViBpjrgeC1Y26WZhaRxQAz5MXNFWTdgdalA/lUREYUbbebUU?=
 =?us-ascii?Q?zmMS93miGX6DNYEt4FlWj3SxPzX3D73vik/CU0f0NiHXziP939fa4qAPQxn9?=
 =?us-ascii?Q?Y1yel9BPVIDjmY6hLYGbARCBhUsoic655ok3WdJHGoYYpSGEP/CNz5x51C02?=
 =?us-ascii?Q?VKl+Um/UdGSXKBqisTTkQJKGu3Hh8Ntex43GkjPzeKBVTGJ+wFmgN/Z2Otol?=
 =?us-ascii?Q?DPefVzpTefnIwtkxs3yJ5PLC5gItkgx0/U0Ruzb1Ec+LxqbTm4UXOzug6LrC?=
 =?us-ascii?Q?zRzTDdAQZAUGIbOzLymfjYWTVIMJtCPB1c/n2AgCCM9Ip/3vz9zzPecaY18M?=
 =?us-ascii?Q?bN3eqMWz2yXcO0Dn/p8GGjdGZdXx9yVXsXvadOdsCSjOrjuJKi50eCToPX5V?=
 =?us-ascii?Q?O+Eyk+VKFeAkeTLaOn+QjnbFEsC2gt/mhG7B6IGDMCWV4BfLBpLonhxXjoL1?=
 =?us-ascii?Q?EQCIqBU0B+UatF7gAX9ya07MWMGaqrf07ClLZs+xOmI+ljg6pchMIvE622Zp?=
 =?us-ascii?Q?KKDtXFDfws3uVlqkMPA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1728bf6-f7de-4b8c-4e14-08dd18e52c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 06:37:52.2624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDQrsW2ZNzYRYMTsI3RWsU17Kpq8+n6EycMFaNxNJ9O5uJGJs1HShUf8DP29apjQRKqeldByLau/Md1GFzfyTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

Hi Robh,

Thank you for your comments. I mistakenly mentioned Bjorn in my earlier mes=
sage.
My apologies for the oversight.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Havalige, Thippeswamy
> Sent: Wednesday, December 4, 2024 12:02 PM
> To: Rob Herring <robh@kernel.org>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; krzk+dt@kernel.org; conor+dt@kernel.org=
;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MD=
B
> PCIe Root Port Bridge
>=20
> Hi Bjorn,
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, December 3, 2024 8:11 PM
> > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > manivannan.sadhasivam@linaro.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; linux- kernel@vger.kernel.org;
> > jingoohan1@gmail.com; Simek, Michal <michal.simek@amd.com>; Gogada,
> > Bharat Kumar <bharat.kumar.gogada@amd.com>
> > Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2
> > MDB PCIe Root Port Bridge
> >
> > On Tue, Dec 03, 2024 at 06:06:07PM +0530, Thippeswamy Havalige wrote:
> > > Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> > >
> > > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > ---
> > > Changes in v2:
> > > -------------
> > > - Modify patch subject.
> > > - Add pcie host bridge reference.
> > > - Modify filename as per compatible string.
> > > - Remove standard PCI properties.
> > > - Modify interrupt controller description.
> > > - Indentation
> > > ---
> > >  .../bindings/pci/amd,versal2-mdb-host.yaml    | 132 ++++++++++++++++=
++
> > >  1 file changed, 132 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > > b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > > new file mode 100644
> > > index 000000000000..75795bab8254
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yam
> > > +++ l
> > > @@ -0,0 +1,132 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/amd,mdb-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
> > > +
> > > +maintainers:
> > > +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: amd,versal2-mdb-host
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: MDB PCIe controller 0 SLCR
> >
> > SLCR is not defined anywhere.
> Thanks for review, Here SLCR refers to mdb_pcie_slcr should I modify it t=
o lower
> case?
> >
> > > +      - description: configuration region
> > > +      - description: data bus interface
> > > +      - description: address translation unit register
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: mdb_pcie_slcr
> > > +      - const: config
> > > +      - const: dbi
> > > +      - const: atu
> >
> > DWC based it seems. You need to reference the DWC schema.
> - Thanks for the review, Here should I add both dwc and pci-host-bridge h=
ost bridge
> schema.
> > > +
> > > +  ranges:
> > > +    maxItems: 2
> > > +
> > > +  msi-map:
> > > +    maxItems: 1
> > > +
> > > +  bus-range:
> > > +    maxItems: 1
> >
> > Already defined in the common schema. Plus you obviously didn't test
> > anything with this because bus-range must be exactly 2 entries. 1 is no=
t valid.
> - Thanks for the review, Will remove it in next patch.
> >
> > > +
> > > +  "#address-cells":
> > > +    const: 3
> > > +
> > > +  "#size-cells":
> > > +    const: 2
> >
> > Both of these are also already defined in the pci-host-bridge.yaml.
> Thanks for the review, Will update in next patch.
> >
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  interrupt-map-mask:
> > > +    items:
> > > +      - const: 0
> > > +      - const: 0
> > > +      - const: 0
> > > +      - const: 7
> > > +
> > > +  interrupt-map:
> > > +    maxItems: 4
> > > +
> > > +  "#interrupt-cells":
> > > +    const: 1
> > > +
> > > +  interrupt-controller:
> > > +    description: identifies the node as an interrupt controller
> > > +    type: object
> > > +    properties:
> > > +      interrupt-controller: true
> > > +
> > > +      "#address-cells":
> > > +        const: 0
> > > +
> > > +      "#interrupt-cells":
> > > +        const: 1
> > > +
> > > +    required:
> > > +      - interrupt-controller
> > > +      - "#address-cells"
> > > +      - "#interrupt-cells"
> > > +
> > > +    additionalProperties: false
> >
> > Move this before 'properties'.
> - Thanks for the review, I will update in next patch.
> >
> > > +
> > > +required:
> > > +  - reg
> > > +  - reg-names
> > > +  - interrupts
> > > +  - interrupt-map
> > > +  - interrupt-map-mask
> > > +  - msi-map
> > > +  - ranges
> >
> > Already required by common schema.
> Thanks for the review, will update in next patch.
> >
> > > +  - "#interrupt-cells"
> > > +  - interrupt-controller
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +
> >
> > Drop blank line.
> Thanks for the review, will update in next patch.
> >
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    soc {
> > > +        #address-cells =3D <2>;
> > > +        #size-cells =3D <2>;
> > > +        pci@ed931000 {
> >
> > pcie@...
> Thanks for the review, will update in next patch.
> >
> > > +            compatible =3D "amd,versal2-mdb-host";
> > > +            reg =3D <0x0 0xed931000 0x0 0x2000>,
> > > +                  <0x1000 0x100000 0x0 0xff00000>,
> > > +                  <0x1000 0x0 0x0 0x100000>,
> > > +                  <0x0 0xed860000 0x0 0x2000>;
> > > +            reg-names =3D "mdb_pcie_slcr", "config", "dbi", "atu";
> > > +            ranges =3D <0x2000000 0x00 0xa8000000 0x00 0xa8000000
> > > + 0x00
> > 0x10000000>,
> > > +                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x1000=
000>;
> > > +            interrupts =3D <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-parent =3D <&gic>;
> > > +            interrupt-map-mask =3D <0 0 0 7>;
> > > +            interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> > > +                            <0 0 0 2 &pcie_intc_0 1>,
> > > +                            <0 0 0 3 &pcie_intc_0 2>,
> > > +                            <0 0 0 4 &pcie_intc_0 3>;
> > > +            msi-map =3D <0x0 &gic_its 0x00 0x10000>;
> > > +            #address-cells =3D <3>;
> > > +            #size-cells =3D <2>;
> > > +            #interrupt-cells =3D <1>;
> > > +            device_type =3D "pci";
> > > +            pcie_intc_0: interrupt-controller {
> > > +                #address-cells =3D <0>;
> > > +                #interrupt-cells =3D <1>;
> > > +                interrupt-controller;
> > > +           };
> > > +        };
> > > +    };
> > > --
> > > 2.34.1
> > >
> Regards,
> Thippeswamy H

