Return-Path: <linux-pci+bounces-13077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A613F9765D3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3755E1F24F45
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73246191F69;
	Thu, 12 Sep 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oXoYfM4j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802818BB9E;
	Thu, 12 Sep 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133895; cv=fail; b=YIbPlX2L+N/oZ2tk2HuXXaMi1thCG6z6mDYpFtc705ZBpAIgGbvttpP/gbgFsgk6AMlzexlxSLk0XpV56nySb0ZQToNv2L0WIrO6lw7a4XFSTF4Ly9+He0oC4oZV1LZcP4j/p75/jUYkxj8LlzOkwGSi5QrggYbH53NSaA6rwFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133895; c=relaxed/simple;
	bh=ZDwZXMfDtkeiXSLJFSTedi+u4tz+1+/nqPGHHsfiJN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRBztWUBgCt7vHoVsnYBYbifWCumZepnPc8GXXjbiExBuvnLHpsXgqqEk0w0CGIPg28SYjQTi0OEPhcXGsTKzFeMDqbjab2ZT6P0pGmZkC/Dr7Sb9g+3wngNvtvRAp0o+TpTgkS6wAbsqgoLULJ8gJe4i2Xco6ft0AgAY4ZXrA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oXoYfM4j; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU1t0PWoP4YmAHto7TToUDiNiJxmqlS0Pg/8sMp4DU30g/wWDnuiwX27CarUZ/Ys88twckQM/7aWCKptjtVAC1rm/fQMSOtuZgG2zrC4AUSCOUDroi/1lXzwoOsP73YSwcHmcGJy/A+F9bQVnQqFfZ7SBWPG4+bejbQy4llzu3yj8Wqv7W+dK2/sEBal3tVlQw1FZ14C3J459Cx9skUoP0j5qb0z5KKain2AOKxFtiCo/L69D6UFOv4cr9ulW3Y4z+dp11B276h7AJwCASYTeDso0wZ5EmiBw3SIrbO+sGqEw2a+xprxwHil7rliaZDqonZIxiUVKbatXVzLLqS1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMLX86tJV8PO53J2ywvkedMa2X/5dlPPiKIhe1PheN4=;
 b=WlpgStklY3HijNLyg/fXL4LNk+eNkkfUIbaizTI8zYbXXJs5glt9IyNK3B4jwj2zKYsfhuX/VD0u5OJ92HQ+6RCsQbCjwbSDdeI2fWPeFUq8LMM83ZNsngeLaSmV8GSNG/lSFlOThCiXN/sTMEe4/wygX7j8YYFNah4dauzJwJ/CpksJMwVwrGiAmW+AyVnvdeAJQ4nGHOQNlrMq7FOhnw1U64kZyG7byi1ON3f58bl37RHQS4D6KQkT+7IUq7J2sxosQqef0kNfn0+bunW4jPd42xAPX/vNtLojeOsyinpchaGciIf2K5HFOaqLiBgye2T3fWf2veL6IKo4SV4OLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMLX86tJV8PO53J2ywvkedMa2X/5dlPPiKIhe1PheN4=;
 b=oXoYfM4jBD3FD3qsljoKkRJcDYIOUeYsW1xPU246JBj3S5M1pW5l8LKBzS6PfpQKy8NM20A4zCN3e3jRPwUcuH9TM70muIFse+Sqnu2xA3UZLd1XT900lBMrpuZr2wDc8wXG6PyExWBh/iIoXgr10f+xuW+k0ocCjkaTV4f/oAc=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 09:38:10 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 09:38:09 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller-1
Thread-Topic: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller-1
Thread-Index: AQHbAD+z/TDAhGS/o0+AjqbCzuAwybJLItOAgAjKhpA=
Date: Thu, 12 Sep 2024 09:38:09 +0000
Message-ID:
 <SN7PR12MB7201E8EEEC41C74DC2ED11B68B642@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240906093148.830452-3-thippesw@amd.com>
 <20240906191915.GA425558@bhelgaas>
In-Reply-To: <20240906191915.GA425558@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ2PR12MB8652:EE_
x-ms-office365-filtering-correlation-id: 5d81f067-2ed0-4365-45de-08dcd30e9cb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HpQJDZB99z7Zjb606HMi+naN3L3LdTKf43iSgZCZcMS15x26OGRVHeNLpSZ2?=
 =?us-ascii?Q?crJ04cXrU5pn8PlxVeS6vtZtynbeR1P2JE785otU9Bgcc0uGMVNZdPGdImIu?=
 =?us-ascii?Q?73OANA6LOHyH+SlaQ74v0yqNxnwDK/kntoOCQI1ufx8A3Q3n7WMMA+qNV7qX?=
 =?us-ascii?Q?fFb5zUMmzzgyvsS8u42WI6p+N5duUarTK9lp9m/2uFlFOKus5toCHSF5KRI6?=
 =?us-ascii?Q?Mldwc4u2RXJBWuF5XOa9DcCzcBxy/buFAnxo9svWIiJAhradsx9Sxs7IxXFS?=
 =?us-ascii?Q?027+cnI7+AD5sRetytByXMBa8zmwZ61lLykco9DtOVTgDvi19ViVevTmAi82?=
 =?us-ascii?Q?OmTPXLDBW/0GJBNXBbkMbMZZ4RNvc/C2ESFtDj4QGo45T/ZXklURXvW3htt7?=
 =?us-ascii?Q?sSKe8/ikQv3U46pKgg9ss37qUqCa1aTy/yT2Pej/g85ph3QJHMtRnB5al6mt?=
 =?us-ascii?Q?Nt76IfH1mgsahhIGB5H4ngDWdfLkvKHbaVkaPCysZfSgidpQrHUUvEDVnsGS?=
 =?us-ascii?Q?a7TsCHd86FUqlVnCEuP2DIsusYqoHIU1k4OZyfyUEB9gN1kID+bFaca2C0Si?=
 =?us-ascii?Q?pR9L3uxz89ISCPfmbWmDuNxQR+x4Ftjga4k7ozwXfOmC2VV9VKTe/pZW9Zhu?=
 =?us-ascii?Q?j7Y6E1Xg8qQm/RSw4q00rks0q04/igRlCcSdptLDfnM7bah16cE80YF+aTZO?=
 =?us-ascii?Q?ita60JDRVBSI4N54Yn3mf6wtwBBzmTjsavCFs6r2hRf6JHtzJBe3O3naodef?=
 =?us-ascii?Q?F1rGgQprVEnMkUyeUAy7uzFTl05L7UymlN6S/u39UzLSMudh/miyLqPGxmgS?=
 =?us-ascii?Q?fELDt3NyPKI+JnXP4nHE9yLy+6p3r4w8MF0YdUMbX+GNASQJCOmU2rrXFpRG?=
 =?us-ascii?Q?DLluzPJJrSr+QXMkEwp7rWDs9EsctBb41goFbgv4VBAq2AS0N3jxV5mzVcsq?=
 =?us-ascii?Q?Zlg48aU3S5Uy2WSV5+pNOljoU7K6SezACOEhEHNF73vlkpy0fNQlShpcBTvk?=
 =?us-ascii?Q?TDK+ESYkjWPk0Z+cGNXbIBN3Wq33wDYSJ8K1Qjiy2cnZ4IEGjytieK7hvSiX?=
 =?us-ascii?Q?1xhbvg15huY/s22bYp2YmSp1AidE5H1npAOz+URSxv9M4fX7nHFzkQdrpJai?=
 =?us-ascii?Q?Bzk4B9j+d2PRSKVCO2qkxfwO5lS+GHUeKNJ9zp8aLNKUeT79e7gTkPG29s0F?=
 =?us-ascii?Q?mgNiJggEptyyWJDP0Lcvv1E9XmSfZOtoHt0HoglSpjLfA7s17NYmte3uEbln?=
 =?us-ascii?Q?8YDBD4dc5mPUZKZtKpQt2aMpCPPTTm8cZ3V6drnqEz9JkdN8P6xhegph0hnd?=
 =?us-ascii?Q?U9GlK6OuYnnbe/v4+5TNQYzwGbCBD9Tes8iYRg7+4l0jUu6l8Uy4tJYcNxAW?=
 =?us-ascii?Q?vxD/woPpw44MsPxS8EFMmSMDGVAs8leFlKFHbeQwYQfkhEqX9A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vEK0miNxIulmNvlLciW9U4LOqQ5lJPsi1zmUNa0f+iqwLcuM5XhCUim3sUKT?=
 =?us-ascii?Q?r++cnu+9I0Vq6CLDk8NZfjYFCFXH34yksOUcHxadGsYOdKwswNrAzO2X2b8U?=
 =?us-ascii?Q?9Wt3Ue0EJ7AJexgliPh4ERIvl1p17a4Kc/lPXPC3FOoJKjnLVZMLhBINmvjT?=
 =?us-ascii?Q?VR6JRjMlqvw7xaFhcyb17paYOGOil1RwRfxHNQhitGGKJXTBkXnGvsLIsLsL?=
 =?us-ascii?Q?FcMVy1tvlUoVzxwulVDQtEdVC0MoM/MakpKw/GwWwh4cmVz/KPZoboJXuAJ7?=
 =?us-ascii?Q?K3j0TAlTYkEPjz255wYOYomBNKXnDoLdhn67kWGLuIgheZfQWHoWFZvSs00H?=
 =?us-ascii?Q?N6PjwjGfpXnO2QVjNQvPE0/JiWNLxS9N2uegxPDhqh21m7zukojtm9E5WHU3?=
 =?us-ascii?Q?vpus2Pa0Lz+P2BAAUtkih5YDJxQsG+lDZIjU98ds63nK7RvrWV2/X1HSvXN3?=
 =?us-ascii?Q?xaw8s9up9aLXZhGbKkxUwXFj2yX0jD05kaB9QPlaW4zU/MynHiYrFozABQWI?=
 =?us-ascii?Q?4+uA1gLLvL0ZuI2hU0dz44BSZ4eEa6YikBYOcy/kCUwPmCJvqT3TtzgryiM+?=
 =?us-ascii?Q?LAxyfJwepe3coA8OoN24kR24oYq8f9Kzo/hK6o2EboLg042BMbKoZILP2SIf?=
 =?us-ascii?Q?2Ve4xf7PUIKrXBYkzD22cO3WUIL9ER/TTsLzebruTrPcQNPfz3XPvDjPfVkF?=
 =?us-ascii?Q?fvlidDDCj3tmk5ULT0MgOTmXs1D9GmdNuvtm5EVSpT7j8rus33WK+lFCTga6?=
 =?us-ascii?Q?E2Pg7cGHefU8vPksjZwrs7wnPP13B3uLz644TNFWc5vL/WHwcwtG73qwD/Ig?=
 =?us-ascii?Q?OrgBQPhYJlc0irjgBB7XRrhRh+7LQ+ZvMQfRo+A/IRV6oVT1bTuD1WrSR0Uh?=
 =?us-ascii?Q?URTeHOThWRjGYBACIw8tqnohO2d+NVIraCexSQc8Mvbmd5Sw6yEVK9oyMoSJ?=
 =?us-ascii?Q?egGgM+pgwn6V6Jtg3B7+9OE2CwaG1/KcFa3sARwTb4ZJjukpfagHRfNdkzlz?=
 =?us-ascii?Q?OdKokZYsiwD/LJFA9p3oQYjJyuQje+E2sCM++aW9MbotUcxCj39K+buxQnIz?=
 =?us-ascii?Q?fwT8zdiQZEXxv2xlc4sZCJeYMPjycN+g5Uy0ivqs2bwMmjxkFX/gPM9wQ7Vd?=
 =?us-ascii?Q?OAlv8GvKDUeNYktHlTd08LmTd1TOJlI+9wpJs/5pw6k26Xxgae8/MX5A1S+f?=
 =?us-ascii?Q?iF6QGNry7tXL3hNLhNgTvyq4MNOngAIMw+rJTxl7P6nqudarBYAcSC3pn9Fu?=
 =?us-ascii?Q?nv97+eXbXnuIC/KENViJOtS73klfqaeCTR19FA0kChesCEKZdeqynZJcX+it?=
 =?us-ascii?Q?2e2aCioGLq9qG2Afmq3iv20A4L1657kZRws69KF2X+G2Oq3zAuwg+EcOxVv7?=
 =?us-ascii?Q?icJy6quvqcxw3I5h89qqFB+6pehxvnB+mK+QgpooNfkSfAQg87XGin+Pma7T?=
 =?us-ascii?Q?uTbpWEVgHfpISDNsnDER0WavL5nmdxGAnUvsRjrZE6NelogvOjbjIbh/4Z1l?=
 =?us-ascii?Q?fYpF5KSLUnPo+rVJK3Ae52M3kLZXWHgyplkhtqcLRPPCJYkvccCrc8mbPuMO?=
 =?us-ascii?Q?+sI3O1IsczCX8v4e05o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d81f067-2ed0-4365-45de-08dcd30e9cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 09:38:09.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhhFAp6on29FpN8Io3ZWSChWkOFJduqu8idxeINafGgQCyESsyQ5jt6wUBwZpeFlqyToTd4OCsp50/gpihlhPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652

Hi Bjorn,

Thanks, for your comments.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, September 7, 2024 12:49 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: manivannan.sadhasivam@linaro.org; robh@kernel.org; linux-
> pci@vger.kernel.org; bhelgaas@google.com; linux-arm-kernel@lists.infradea=
d.org;
> linux-kernel@vger.kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> devicetree@vger.kernel.org; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Simek, Michal <michal.simek@amd.com>;
> lpieralisi@kernel.org; kw@linux.com
> Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Roo=
t Port
> controller-1
>=20
> On Fri, Sep 06, 2024 at 03:01:48PM +0530, Thippeswamy Havalige wrote:
> > In the CPM5, controller-1 has platform-specific error interrupt bits
> > located at different offsets compared to controller-0.
>=20
> Technically mentions a difference between controller-0 and
> controller-1, but doesn't say what the patch does.
I'll update required detailed description in next patch.
>=20
> > Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 39 +++++++++++++++++++-----
> >  1 file changed, 32 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/con=
troller/pcie-
> xilinx-cpm.c
> > index a0f5e1d67b04..d672f620bc4c 100644
> > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -30,10 +30,13 @@
> >  #define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
> >  #define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
> >  #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> > -#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> > +#define XILINX_CPM_PCIE0_MISC_IR_LOCAL	BIT(1)
> > +#define XILINX_CPM_PCIE1_MISC_IR_LOCAL	BIT(2)
> >
> > -#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> > -#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> > +#define XILINX_CPM_PCIE0_IR_STATUS       0x000002A0
> > +#define XILINX_CPM_PCIE1_IR_STATUS       0x000002B4
> > +#define XILINX_CPM_PCIE0_IR_ENABLE       0x000002A8
> > +#define XILINX_CPM_PCIE1_IR_ENABLE       0x000002BC
>=20
> These are all indented with spaces; should use tabs like the other
> definitions above.
Thanks, will add proper tabs in next patch.
>=20
> >  #define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
>=20
> Same here (although you didn't change this one).
>=20
> >  #define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
> > @@ -280,10 +283,17 @@ static void xilinx_cpm_pcie_event_flow(struct
> irq_desc *desc)
> >  	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
> >
> >  	if (port->variant->version =3D=3D CPM5) {
> > -		val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE_IR_STATUS);
> > +		val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE0_IR_STATUS);
> >  		if (val)
> >  			writel_relaxed(val, port->cpm_base +
> > -					    XILINX_CPM_PCIE_IR_STATUS);
> > +					    XILINX_CPM_PCIE0_IR_STATUS);
> > +	}
> > +
> > +	else if (port->variant->version =3D=3D CPM5_HOST1) {
> > +		val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE1_IR_STATUS);
> > +		if (val)
> > +			writel_relaxed(val, port->cpm_base +
> > +					    XILINX_CPM_PCIE1_IR_STATUS);
> >  	}
>=20
> When possible, I think it would be nicer to encode this difference in
> the data, i.e., in struct xilinx_cpm_variant, than in the code.  For
> example,
>=20
>     struct xilinx_cpm_variant {
>       enum xilinx_cpm_version version;
>  +    u32 ir_status;
>     }
>=20
>     static const struct xilinx_cpm_variant cpm5_host =3D {
>       .version =3D CPM5,
>  +    .ir_status =3D XILINX_CPM_PCIE0_IR_STATUS,
>     };
>=20
>     static const struct xilinx_cpm_variant cpm5_host =3D {
>       .version =3D CPM5_HOST1,
>  +    .ir_status =3D XILINX_CPM_PCIE1_IR_STATUS,
>     };
>=20
> Then this code could look like this, where it basically tests a
> *feature* instead of checking for all the different variants:
>=20
>   struct xilinx_cpm_variant *variant =3D port->variant;
>=20
>   if (variant->ir_status) {
>     val =3D readl_relaxed(port->cpm_base + variant->ir_status);
>     if (val)
>       writel_relaxed(port->cpm_base + variant->ir_status);
>   }
>=20
> (Apparently the CPM variant doesn't require this at all?)
>=20
> >  	/*
> > @@ -483,12 +493,19 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie *port)
> >  	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> >  	 * CPM SLCR block.
> >  	 */
> > -	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> > +	writel(XILINX_CPM_PCIE0_MISC_IR_LOCAL,
> >  	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> >
> >  	if (port->variant->version =3D=3D CPM5) {
> >  		writel(XILINX_CPM_PCIE_IR_LOCAL,
> > -		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
> > +		       port->cpm_base + XILINX_CPM_PCIE0_IR_ENABLE);
> > +	}
> > +
> > +	else if (port->variant->version =3D=3D CPM5_HOST1) {
> > +		writel(XILINX_CPM_PCIE1_MISC_IR_LOCAL,
> > +		       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> > +		writel(XILINX_CPM_PCIE_IR_LOCAL,
> > +		       port->cpm_base + XILINX_CPM_PCIE1_IR_ENABLE);
>=20
> This looks questionable and worth a comment if this is what you
> intend.
>=20
>   CPM
>     - sets PCIE0_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE
>=20
>   CPM5
>     - sets PCIE0_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE
>     - sets PCIE_IR_LOCAL in PCIE0_IR_ENABLE
>=20
>   CPM5_HOST1
>     - sets PCIE0_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE
>     - sets PCIE1_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE (overwrite)
>     - sets PCIE_IR_LOCAL in PCIE1_IR_ENABLE
>=20
> The CPM5_HOST1 overwrite looks either wrong or like the first write
> was unnecessary.
Yes, the initial write is unnecessary here. I will fix this in next patch.
>=20
> You might be able to simplify this by adding .misc_ir_value,
> .ir_enable, and .ir_local_value:
>=20
>   struct xilinx_cpm_variant *variant =3D port->variant;
>=20
>   writel(variant->misc_ir_value,
>          port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
>   if (variant->ir_enable)
>     writel(variant->ir_local_value, port->cpm_base + ir_enable);
>=20
> >  	/* Enable the Bridge enable bit */
>=20
> Unrelated to *this* patch except for being in the diff context, but
> "enable the enable bit" is unclear because "enable" isn't something
> you can do to a bit; you can *set* or *clear* a bit.
>=20
> Bjorn

