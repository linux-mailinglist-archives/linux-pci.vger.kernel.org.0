Return-Path: <linux-pci+bounces-17506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771749DFBC7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 09:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CDF28193E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB671F943D;
	Mon,  2 Dec 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="prvz0/ti"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E811D6DDC;
	Mon,  2 Dec 2024 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127701; cv=fail; b=gbSJTwKeCHj9xw3g17fB77wZ091V5Ihil94TGTguuQpg4t6l2pgzEOvqqIvUPfNm3oK/hET29ki1s/Z2yxIjBswu2DvmYTfJAm8ai+dBYRIfNVuIUP6uLnpqPiS5Y108/7gdU6bkbxgHDqJDsX0BjTfxOn6STX0m8pU7uNY5RuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127701; c=relaxed/simple;
	bh=8qOEuo2CNnGN7hi0w7UWuLMVST6sqzk5GB2dkyGTVa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PayBuKlG62LFfYGg5tvLNkKVt6ObFBxnyLELK9CTGYah68S8KPP+AVQByFf9hVdvqHjjk797Dk8q1XSyLsRKuUzgiMHqiEL0AX7R2kO6ikJo2fIlBwczWed7wr1s3nIO4ogIkgtzvEd4vS6oRfu2eiQTS4ZctFxXIsznsdVyoa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=prvz0/ti; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/5p4NeHEktE8uxOKuumNf9vGmY2D3dUaBCMVJMZCZPmghgihmaHhr2AlR8zxiRKrG4VhntUEgckfKo4h3d4z6bPtOEsczdogC6zHUZu0dLmb3HOpb7dn0orNnp60skzZXaLoY3OEJAkqsIdMLxL7ykLBED6cV8/KpSfEswwrT1VknX95uQFa2pqvqvWvTot8xukjvrbYUHSE0mjoL5PbM0/QVvZxnsfZp15moRMzqYXRd86VqRDhar0VB3/ZjxDRwlRgKdjpj9FKPuoxK0QJLpTgj/Dc4RX8ypEfUdlKVVgAaJ5/spNBqu5X8gbrPCFxJnXxUWIlSa8OUL+aYau2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mejCwjQQdkxmd+UasNZ629Ymr/KLjfqNk5atJ8izNzs=;
 b=oxzsgJ51gThzsmdI1VI8Oda0HHRhDdr4c9WOnhthTCC2iBCgT2ymnyHCXBrgQIoM8lxvYb047QK+lKYgNSCJOqHTT86vmJGXsn3w8dheZhnqvEes4umjS5dlwZBhG1cGSxBATx1ifTT3SvjhEcGsDHVbeF623S+XL/sqJpnvk4kkecJJZDvDgGyYa8G7tHapHvZ09+WcFgIvF+z8utd1iQm9i3Q4Kv1jAFhfG2yaAhw0clr8La8oB6AhgoZqwndsRWczohJ9ZHc0CwxkbBjghU0tNrvtaWlGVWSkzWIZatKijThR6Ewr02DCqWfAQTbcEADfGI0K1IGZDyilTddfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mejCwjQQdkxmd+UasNZ629Ymr/KLjfqNk5atJ8izNzs=;
 b=prvz0/tiFf/V2TCUsc6Tr6QyY8yti2zNoOmDIr7xNrUNNKPo6JGUNDbWr0N3BvX0WOdGcJwxYSxByStezcjR1R1ZA3CO/7VFH/6TawzfCJs/PD8+jJjQaiGu6VSGkUK268QB1A1bNK8jl9yPh/9oYeT3QJIDhwdJjXRU+9qMGf4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 08:21:36 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 08:21:36 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbQMPBUsv/8qTDsEOX3G1ItJvCnrLOtysAgAPsY4A=
Date: Mon, 2 Dec 2024 08:21:36 +0000
Message-ID:
 <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241127115804.2046576-3-thippeswamy.havalige@amd.com>
 <20241129202202.GA2771092@bhelgaas>
In-Reply-To: <20241129202202.GA2771092@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|LV2PR12MB5943:EE_
x-ms-office365-filtering-correlation-id: a05bc355-7520-40e3-06f9-08dd12aa5681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qrTJvG6YJS3tXogt0lMIEexaU1xGKXQzQN4V9uPvLFB+VAqsAwZBq64X3y+7?=
 =?us-ascii?Q?Qs8w6tpaGAO+nfPcMSUwx+A5Ui/X3VflEawRHZvr2t3JZ/K4zJ/FIh/jjujm?=
 =?us-ascii?Q?VZ85B3cUEjgUxBKyhcpHC41Sxg7d44UBUbHF0rnufzWFd4g1j7vF2iE0wEy1?=
 =?us-ascii?Q?XhLfbK8cHCHqI3ncyhFrWTY/O4UpeipEg3oDZbUdVm9jJBFubuuD/pQduqq3?=
 =?us-ascii?Q?uAhtuZ+wtqIvtlgjKOg8xG0XQiz44lP9b/4rCzwWGz4U8mqgK/dur4Qygw5L?=
 =?us-ascii?Q?2JFgsu6mc3g6qyNHTPRxBPruhW7gf0wDkzwzlW40/3tdlbTokvE4kZe9VP/B?=
 =?us-ascii?Q?olEvjQnQztMN+EhrfcAg9+rdDstFpidZxLhyHWeTOo3rJxVp+YUxSzLe9oJ9?=
 =?us-ascii?Q?TyCe5+kScmO+NW91u3NFoPQZ7c8NP3O1tGbFw6u+RFLzfNruGD7GcQqOclyL?=
 =?us-ascii?Q?i/IvTgDkWspshelQ1MbqZ/qV3oPefzb+Ao2nkz52EaQRT2FN2b2yTm4AC8fG?=
 =?us-ascii?Q?/SpT+EP1vzoVSyEM2qTATPEjJPPldcGSaeUbOJGZ0PdJPlMFLBkH01Vpp1y1?=
 =?us-ascii?Q?lfCWC8Xv6Ky2ciJmEFK3zL2t0swHRTUxhprl4IitV5xfshCvcK53HCDD0at6?=
 =?us-ascii?Q?MSvJyh8leiG/i66gIJ8RL6COgmspLoARe+0vxG4qa35CchMYAUF5BfYRvW5O?=
 =?us-ascii?Q?WquOu+hck+jU05P1Kr/FC8/1AHvDvk481CfDTRHyNJrWJ3x2X09zcuLDcB5w?=
 =?us-ascii?Q?+xS6q73DzR9Q7IJ/9p1aAvPAwmR9I//5HXF0DgCC3SqaxG34VYnQjPgTuoma?=
 =?us-ascii?Q?Voe2ApkWGaTmw0F4AjfG6X02qE8Vbu7vCwGFM24mZoFBSXZV2/9tOiT6P/xa?=
 =?us-ascii?Q?uiw60A+mEemEAWRW8nUQizsbeN9PIwqcVhHlJad3q+bGul7ulLW1WZtoL340?=
 =?us-ascii?Q?YnHlEZxq5ESp69bwIzMRb0g3LbZO2h6I4Ed6lQVHf/fx4f25vZBdC/iDZe3E?=
 =?us-ascii?Q?Vl0uJ0l6F7FCvhwvOtJb7UxJyP+hUflzqgZieMhF55TAB5WumLEAZum1Xx5L?=
 =?us-ascii?Q?KF1SQIzoaYSQl3vUcEQCY3jCeANd314micwKDQ6HgVCBb3/q6EL6dvooQHGi?=
 =?us-ascii?Q?RYZ857IycJGS5R3Fv03QFSglrnnBxygOTUR7k1e0fkUg1U2Xge5OxfCakuPA?=
 =?us-ascii?Q?fgUutJnQhX6NiDGLQe79/CAUnqA2zvIe8f+6fkxzLTFK/c6gY4uBPs24XY0j?=
 =?us-ascii?Q?2OjENtUR7jGR3OQGBbXnoNq/4Tr4MiI6XX2v8ktrLLMCmywXnk314C25pUCM?=
 =?us-ascii?Q?rHglSBzrxT2krAdwq/sQhyQlMl0VTPr8w9cKmn+GeOCUwROQHdrUCp8IGAHi?=
 =?us-ascii?Q?+NZr4oXsm1Q9/H/luOOYtkdToRubeEtOHoekkMdqfHvKFW9dzw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+PQem4EzBWec4Ro5LbdF04pLJtZSjAkLBM68g8HhD3od7+qLmQyvUECy733Z?=
 =?us-ascii?Q?4lOzuwVSuDc0T5Cx+PvrOuBdi9r3fEXHf6hW+UCpk6eGwpvcYRW0OkfIo7/0?=
 =?us-ascii?Q?PXe6cwvvOxAu175GX/jIyOzHy8gk+ljpFnMfI04It01PNSkgEOZMWrDEfrWU?=
 =?us-ascii?Q?h6mL3FVPfzzThijZgqwHGEnrYXBrCTe8HLhLattFXQw9DPGr5UTdBnZemzxZ?=
 =?us-ascii?Q?XwSEhM8ofUfQoiXNgeNvVKthmlu9uMbkj06KVQa/+1LesdLGyrreBPnRD6ek?=
 =?us-ascii?Q?yKWsw7RrswMobaA34Bcd1oKg5+2n6tj1HHoc07b6fZAo3zmE2PcriZjHOWTx?=
 =?us-ascii?Q?q6yESR3VhyCHR+MYTzTfDJ6JpXREkHnO+vHTInux4c+XcV6py3vGsEp3qgA5?=
 =?us-ascii?Q?lO9B+QlX0+50Ef/GS1ddMtRykJHC1yBwjL8qrM3kC+llJfrXXliKmYdX56si?=
 =?us-ascii?Q?n1IEvQpjBlEBm2Dr1oWzPkFcYsR85qYOCQJ/KCg7g8ds9VPvKp5BlKkn649D?=
 =?us-ascii?Q?uohP+GBSaGY6GE55+Y0bu7r7H07s6QnDijaJrhMkvNPzxGFq3orp9fHwVkib?=
 =?us-ascii?Q?wKi57OkvKeiRFZ0yEjFozt5Sa0s8peVg6tUoEq3c6CXhqiulBUBi/pHizFlp?=
 =?us-ascii?Q?BkqlTRaTg7huv47IoZS++p/rXDhCck4cEbIMXaLaUeYIeQR5d8GbJTUMRn0O?=
 =?us-ascii?Q?Eeafswqf2dqJuCwQwmMrH2Pi/idCi7p9NN/ER0+r7z0/2j26jJRA/ZJDV1VA?=
 =?us-ascii?Q?0dW5/N1Y93UeeLzlgLAk2EM9ejUm4wWGdy37nir8B+QR+c2solC3IiFaiNuI?=
 =?us-ascii?Q?Sqva8/2UKIGs0IiHEquLLAlOD0QEdxOj7Cr5naE6l6t1Rrva0aAufPuCHuML?=
 =?us-ascii?Q?q+Yq/jIM6fsgw+lwk6nInt91NMq7Ir0m9WHGiCCp1w236rKzO00T5RdzZ0j0?=
 =?us-ascii?Q?Pvj3cwNjMBsXukxwPxcL7oi4Q5OFEVrPVP9oD9RGqGtgkasYVMmdMi6vxl6L?=
 =?us-ascii?Q?Vfj/LrMVWJN/hkop2nPJ5p95yxZVdHJOubuY4Ffa0+gGb24/bRQ2hA7vlcvn?=
 =?us-ascii?Q?AmJBZ6SPj30ShuXfL7QomJLD7WjXaVp8zxWPUiDmC34B/EeLFlsC3ke82DS9?=
 =?us-ascii?Q?ZLeeUxd+l9oX6b+Ub6dsWAb4Gj6jVhLObR0osJ/q2IZvN0Yf7cYBZ/nfBdXO?=
 =?us-ascii?Q?vUthHifXd47u0b9VXeN8WcUys/MzrdDotYaYRAsJdn4WXESjsIBTzKT+Drgf?=
 =?us-ascii?Q?hh3P7i8GG76VMMGou409G0fqE4tnRFxz9o0liUpkvyVydsxbpFfkUv98wC6w?=
 =?us-ascii?Q?VhSy/ycezipZGIJKPHRmvg+r7wo0BJNZ+1VVtBgHV3eLda43km5ETQN0j3gp?=
 =?us-ascii?Q?aYaj5frfUUwXyiQzqaF7cs6NMxAVRWjvi2yWALgNu8lniCHlPnUtsgonMmvO?=
 =?us-ascii?Q?NyTAL+vKyXuDzmX5oEl3vXxsdNqa1f+JKv+/P9CLTAD11V7y/F8SRorwQ2uM?=
 =?us-ascii?Q?GqiBOnhql/H77DFK/XgmMdRnOw3UO17I5oeA8zAbqEZfwsCWJPVEpeYjANWu?=
 =?us-ascii?Q?CeC6l4MGItdfk9IcStE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a05bc355-7520-40e3-06f9-08dd12aa5681
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 08:21:36.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ow/Q+OEFaClezWeOqajscjrHzC2hxZ6NHgg5qVYcFGAHeBnbl1m7tlUNQbaVdNo58i6KHbtd5L4nqmsjtN3PJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, November 30, 2024 1:52 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g; linux-
> kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
>=20
> On Wed, Nov 27, 2024 at 05:28:04PM +0530, Thippeswamy Havalige wrote:
> > Add support for AMD MDB(Multimedia DMA Bridge) IP core as Root Port.
> >
> > The Versal2 devices include MDB Module. The integrated block for MDB
> > along with the integrated bridge can function as PCIe Root Port
> > controller at
> > Gen5 speed.
>=20
> What speed is Gen5?  Please include the numeric speed so we don't have to
> Google it.
Thanks for review, ll update in next patch
>=20
> > Bridge error and legacy interrupts in Versal2 MDB are handled using
> > Versal2 MDB specific interrupt line.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig        |  10 +
> >  drivers/pci/controller/dwc/Makefile       |   1 +
> >  drivers/pci/controller/dwc/pcie-amd-mdb.c | 455
> > ++++++++++++++++++++++
> >  3 files changed, 466 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig
> > b/drivers/pci/controller/dwc/Kconfig
> > index b6d6778b0698..e7ddab8da2c4 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -14,6 +14,16 @@ config PCIE_DW_EP
> >  	bool
> >  	select PCIE_DW
> >
> > +config PCIE_AMD_MDB
> > +	bool "AMD PCIe controller (host mode)"
> > +	depends on OF || COMPILE_TEST
> > +	depends on PCI && PCI_MSI
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here to enable PCIe controller support on AMD SoCs. The
> > +	  PCIe controller is based on DesignWare Hardware and uses AMD
> > +	  hardware wrappers.
>=20
> Alphabetize by vendor name.  I suppose "Advanced" *would* sort before "Am=
azon",
> but since "AMD" isn't spelled out, I think we have to sort by the initial=
ism and put
> "Ama" before "AMD".
Thanks for review, ll update in next patch
>=20
> >  config PCIE_AL
> >  	bool "Amazon Annapurna Labs PCIe controller"
> >  	depends on OF && (ARM64 || COMPILE_TEST)
>=20
> > +static void amd_mdb_mask_leg_irq(struct irq_data *data)
>=20
> s/_leg_/_intx_/
Thanks for review, ll update in next patch
>=20
> > +{
> > +	struct dw_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> > +	struct amd_mdb_pcie *pcie;
> > +	unsigned long flags;
> > +	u32 mask, val;
> > +
> > +	pcie =3D get_mdb_pcie(port);
>=20
> Here and elsewhere, this could be done in the automatic variable list abo=
ve since
> this is non-interesting setup.
>=20
> > +static void amd_mdb_unmask_leg_irq(struct irq_data *data)
>=20
> Ditto.
Thanks for review, ll update in next patch
>=20
> > +static struct irq_chip amd_mdb_leg_irq_chip =3D {
>=20
> Ditto.
Thanks for review, ll update in next patch
>=20
> > +static int amd_mdb_pcie_rp_intx_map(struct irq_domain *domain,
> > +				    unsigned int irq, irq_hw_number_t hwirq)
>=20
> "_rp_" in name unnecessary.
>=20
Thanks for review, ll update in next patch
> > +static irqreturn_t amd_mdb_pcie_rp_intr_handler(int irq, void
> > +*dev_id) {
> > +	struct dw_pcie_rp *port =3D dev_id;
> > +	struct amd_mdb_pcie *pcie;
> > +	struct device *dev;
> > +	struct irq_data *d;
> > +
> > +	pcie =3D get_mdb_pcie(port);
> > +	dev =3D pcie->pci.dev;
> > +
> > +	d =3D irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > +	if (intr_cause[d->hwirq].str)
> > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > +	else
> > +		dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
> > +
> > +	return IRQ_HANDLED;
>=20
> I see that some of these messages are "Correctable/Non-Fatal/Fatal error
> message"; I assume this Root Port doesn't have an AER Capability, and thi=
s
> interrupt is the "System Error" controlled by the Root Control Error Enab=
le bits in the
> PCIe Capability?  (See PCIe r6.0, sec 6.2.6)
>=20
> Is there any way to hook this into the AER handling so we can do somethin=
g about
> it, since the devices *below* the Root Port may support AER and may have =
useful
> information logged?
>=20
> Since this is DWC-based, I suppose these are general questions that apply=
 to all
> the similar drivers.


Thanks for review, We have this in our plan to hook platform specific error=
 interrupts=20
to AER in future will add this support.

>=20
> > +static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> > +				 struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct dw_pcie_rp *pp =3D &pci->pp;
> > +	struct device *dev =3D &pdev->dev;
> > +	int ret;
> > +
> > +	pp->ops =3D &amd_mdb_pcie_host_ops;
>=20
> This is dw-related initialization; move it down just before the first use=
 at
> dw_pcie_host_init().
Thanks for review, ll update in next patch
>=20
> > +	pcie->mdb_base =3D devm_platform_ioremap_resource_byname(pdev,
> "mdb_pcie_slcr");
> > +	if (IS_ERR(pcie->mdb_base))
> > +		return PTR_ERR(pcie->mdb_base);
> > +
> > +	ret =3D amd_mdb_pcie_rp_init_irq_domain(pcie, pdev);
>=20
> Other drivers use "*_pcie_init_irq_domain" (without "rp").  It's helpful =
to use similar
> names so it's easier to compare implementations.
>=20
> Since amd_mdb_pcie_free_irq_domains() cleans this up, I think both should=
 end
> with "domains" (with an "s") so they match
Thanks for review, ll update in next patch
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	amd_mdb_pcie_rp_init_port(pcie, pdev);
>=20
> Other drivers use "*_pcie_init_port" (without "rp").
Thanks for review, ll update in next patch
>=20
> > +	ret =3D amd_mdb_setup_irq(pcie, pdev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set up interrupts\n");
> > +		goto out;
> > +	}
> > +
> > +	ret =3D dw_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to initialize host\n");
> > +		goto out;
> > +	}
> > +
> > +	return 0;
> > +
> > +out:
> > +	amd_mdb_pcie_free_irq_domains(pcie);
> > +	return ret;
> > +}
>=20
> Bjorn

