Return-Path: <linux-pci+bounces-17626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB19E3391
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 07:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319D4B249CB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 06:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FC181CE1;
	Wed,  4 Dec 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kHyyELfh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86164189BAC;
	Wed,  4 Dec 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733293931; cv=fail; b=I0F7Iy+kCU6Y7FmCMIK8hJ2TiCqIygrRXeitkWa6Z+jEa4Mk/LWphHQiQckrF5aDy79APSc2yN1XQYYLLKUtyccHSb7f+NwXMx11+Vr54Am+8I1moDynWN+1k6f6eeHVjAuHCXY5sXYeJZQICznNk7csbEE3xioGW8HPM3gOXCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733293931; c=relaxed/simple;
	bh=h+cKenHcjvaAVlhWlKHu5qkzqa7YrOALddlCagNp/iM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kJm+r54YJwljUOmY8LaLKRS6bWYjFVvxVbTOTV0Grx7K8qpxz2Agdeq4P0AuiGyTrV2O0qlWqBUDv4Q8/ACTMT++KNhYS8kSXZUk6SIiMA8Tct9mniCmgvLa6by6t/swczmOYylLOcVz5Phh+5ApuliM/G777khOFtmxh1OzvGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kHyyELfh; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3ff3V13fQVNsqqDKFGZpjmi16uSKNlEm36zHUtd4CsBvq3xl2n5R06v9mUApYYQxL6AcsBvIHGZokczSqmIhc5WBrgjzGO1VXY2ke6otTJiGS60KQxQHAlBo7mO3daA9FSqims7Y9NljFa2OHiVbW2M/WbSadPkkM8viqF796Nw+Dqq3mYFHmn7sH7H9BRBf6+fYsH3bQfLv7/qjnDUC3lIe/Ip38uOwm6qMC0Xme9gekOFNshsRedr6JvVRXA0yGMUwTAaYe8s5nDEuAwea9l2S5ynLNg8QMWD/CQljsOOvNK5Z7B7p/S0mp776lDdnIS+2cF3k+6yu4J8PId75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8klByCOFIPSmgvSvAUg1IziJfIkK302O/M6LwSkJzU4=;
 b=HMr3Q/USZiqYACBxpE3EeMNAPtlHPnUWZ9mLPrLxZ20V+gEkMvZu34msJLhT++LiHEe47mfvjlx53PggBuz7sVXa1a8V0MsGFYJdVy05hPnamJde7XlpLDvQxTe1ATZaz7i4mJp18WNZSOtIqNl/iLEzLOo47l4Xvdp3f7hVEeSOO1q5reBl9bTutoATK+qxVmW4ES8zLMMjz79XBKC7OMIFMKtZFrmfamriC+TH2oqwE0vSSN3v8X8C+M5+Jgcc/vtSU+9WVhORsYJDQcULK2HmDSvEQTepCSNC63Py50g9+OR4LidI2sercw9ThqrwWDoIp4YC7IYYEwPFlXJjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8klByCOFIPSmgvSvAUg1IziJfIkK302O/M6LwSkJzU4=;
 b=kHyyELfhUZcwSMEnZiMnTR4gciqowOZGM6UAAP6CuNHSNWRQM7Ifzdy1AuErsmqTxiiu+gQNBJs4ct76fMYNo+ZRBXHEK4ZYuINuNm/swqbGNNZjdOkCU7T0nNqXf5mQvMkqOv0My/XVlFB9VUP9Y3fqENOp5UjJbHa8TYum/GE=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 06:32:06 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8207.014; Wed, 4 Dec 2024
 06:32:06 +0000
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
Thread-Index: AQHbRX/9tKefBNodzkOGfTPvQMzdCrLUl76AgAD++PA=
Date: Wed, 4 Dec 2024 06:32:05 +0000
Message-ID:
 <SN7PR12MB7201C658D71FDB5D8FD891838B372@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241203123608.2944662-1-thippeswamy.havalige@amd.com>
 <20241203123608.2944662-2-thippeswamy.havalige@amd.com>
 <20241203144101.GA1756254-robh@kernel.org>
In-Reply-To: <20241203144101.GA1756254-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA0PR12MB8228:EE_
x-ms-office365-filtering-correlation-id: cf470f45-fcfe-4927-a3a0-08dd142d5f36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U6wa3n3kbd4Uc8ysWnhfL/ANiTWJSvUaZ/LBYkZqIMqHqep2xzXKqNjWdW01?=
 =?us-ascii?Q?bTEZ6lRmrkCysEERQ6bQ8FqIjml34NlAAsXpH3gU+hCepL5N3OltUT7yxff0?=
 =?us-ascii?Q?Fb39rk3qoWvXNXJZzdIGjFQ5ABjbASydTLAK7OxRpCUbXnUaCsOT9qvkXaYy?=
 =?us-ascii?Q?UDT/2Ifxp+09b+UA+0jfBmm+MSZQdPzxYpAzufBZmZbgIvXyfCmmDvdFUThb?=
 =?us-ascii?Q?oVnph6AQywHStWuc+L2bYYRmQzqxOMFMr87ucoftNs764MmP9CTRHshtyBxX?=
 =?us-ascii?Q?m3FV9zzOogzOjbV8G2FdxDTunEOgKCXflwWi2iaHfXxQMu3jodWRp6RHxTCo?=
 =?us-ascii?Q?sS1pgPeUO+9CpFCxN9NSVQn2+zSGjvYPxt+A7apxBe4SnnZrmZ6C6CDRQt5p?=
 =?us-ascii?Q?cCGDhR2DJZpYrvc/883HEIf8tPktSA73y3ht3/d5jPjtmvEWCAt885bURuZv?=
 =?us-ascii?Q?bDShCRO68S1FmbwH1o29E1UmScdMG5JV8xxas4V3GQ/BKyXWHOmbRoo10OjK?=
 =?us-ascii?Q?BHoYhjb4AyiTulyjLA7oVsqZCJpDI6er5zMYoX/HJzcOI7gNy31f0k6bDmBe?=
 =?us-ascii?Q?xwYbajqT3t2rLl0bQ5E+FoQiyDJPOxLWwyAgyVF3xfVZl+zrt8KtB0vd5kLM?=
 =?us-ascii?Q?4FFkvI5qX9Dq1kjJu3GOlH9fhJiwS/LNAGfFNzD6XHLV6d1ZjtmUgFFivaiW?=
 =?us-ascii?Q?qjH8gZOObrKZt87qw7nFGlPfPH6+1eJP9ZwQx1sNkYwyJPy4Rkfcz9zUL71x?=
 =?us-ascii?Q?0KRnmAws+vloUnQW3+nyTR6WMPBkwEzG34pc/LMNEPFmz+1/BqdWavzrXTaZ?=
 =?us-ascii?Q?zugFDXqNBVChth3L8thu8Twfe2nQZFr7WD0s9h7FaNNNf8e/eJl3LEWNOvc+?=
 =?us-ascii?Q?H1P2w7dJX/7Oop1/pe18vHItoOm/X8qDU8X3P8SVxW+GavWwWrn7Vci5D7Aa?=
 =?us-ascii?Q?o7meajQt9dfnf2FfvW+KawNTIa7G35Jk0f57nVwFKKAEOTMWgkl+M0EWcteH?=
 =?us-ascii?Q?ZV9v8J8X04ATaBNBQxTtMhfgWKKe0NerD+jNXYeUjE/gtnLhV/SW3YfNaOC5?=
 =?us-ascii?Q?dlj3vvRk2FaG6WWoQl/sw6S+cZFEd17F9T9eyVNMEgt9E8dM7grwj4mQEGwv?=
 =?us-ascii?Q?AhHUgHGrcPIV5LrIniobJJxA80npMiX3eFSFrCE4tYY8+LhDqaySdYAVWaDR?=
 =?us-ascii?Q?QQNdGiFt2y8V64iT5JyYmGLqBNN2C0dgQKkXicB+PCMbFAZPuwb4fovN4K2C?=
 =?us-ascii?Q?aFII1YFiQsDvN+V1Adprmkvj8B4kG3gM/ik6r0XnkC2tYPMDjHVeQq8FmxKm?=
 =?us-ascii?Q?ySRSbdwqR4x/MdS66kp/DtYqPOwOtFQlri1xdrTSvAEVbuQuClb8v7IJPivK?=
 =?us-ascii?Q?01ae00M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dJk0OOmbQSf2IzSP7dHyL1j/Ues487ABkCYXOT5j+6R222dIlErWc75ce1KW?=
 =?us-ascii?Q?XRKGOPWlHVK+S7l8B7D3K27gTxEHwPzt36mkOR+Svs+3GmXRcGFTEAvYyvy8?=
 =?us-ascii?Q?iDH6zP7pyPvsD3tmHINEFAcuoslmiZfp822/1GV1qAzSWpuJn51JC0+KrBbi?=
 =?us-ascii?Q?JPHa8FzhH9dwdSlE7X9H2ZI+lxBfsqRYsS+ufP7NrvFvV/Aqy7jmmqBZfX7m?=
 =?us-ascii?Q?wv/C+ofC/DGh+0ckzuEhjQ1LbRzcTxc6ytdRn0IWUjckSrS+T4l56TtkSoRs?=
 =?us-ascii?Q?rJD/X7SWs8mm5iTfXC7DbnGArIplck7xI0k5WlNnrpnnSj/P9x9Bq9A/jSKI?=
 =?us-ascii?Q?YOrHQ8hnJRMsgYR0VCdVjTYJXBmwDmeiwHwc+2qyA5qBi9loYSOYaNOQqRzY?=
 =?us-ascii?Q?HYSMwtebFa4CqacozeNIcOyv5EDacZrhIsLoLsV5m1YEklrj1TZq+lgY6tn5?=
 =?us-ascii?Q?7uHwmMH3bVZ6EgNeKBbn2dJEiEUHRW3dbxJHt1kD7P41sngaFgOmIfLPmlsc?=
 =?us-ascii?Q?r+o2CdMXZ4v2aZAQrUEzABQeX7x62q1U5qYF9GN4l4v6sSB5Is59I5xx16tj?=
 =?us-ascii?Q?tjdJRwEkNyfVKgfXfMYYdwUypPuasUYRZOjhbIfqEG+xAMWSgZkPSQoYE6Mw?=
 =?us-ascii?Q?ZnQTX2qQRdrSxr4ccm65Hgt1l8jZiSeJttmcHYrwxxybW0/3qtKk8Q9TmUBI?=
 =?us-ascii?Q?FmvSuDOHJfD8qyUlGtjac79Gz8peqJs8ZAvRhREEevPt9QTBW6EVuJ9UmS6v?=
 =?us-ascii?Q?QhJ+KmxrrW2m964DDRQ7j9lk1t9EmBvIYW2dQsq1emVR/GLovjJgl/NFaDWK?=
 =?us-ascii?Q?SR64FMzlJD//kjkKKbwv6GGZjenq4c+8114y8aODzlTo2bl22Xkd7KZ2pn6a?=
 =?us-ascii?Q?1HhwP/BRcU+WeWc0j8IifCTXYpqKu5Czdpb7kQy5FAASTvQxd20A7dEiMNLl?=
 =?us-ascii?Q?naDc4vz4lgvRmbIYJgwy7Lmv9XVMUHHIjoBzaJ9AipTWGux6ncFX5iHMpZKj?=
 =?us-ascii?Q?cSP/sSEkKsTgNOSs6kstvktSdsaza32O8K/uqPlFFmXWN2P4GmJ5AOGwCEdw?=
 =?us-ascii?Q?3PJ0juLEtcYQNV8x87H4FC4h7zPwwQoKt7ygKHwfh9rb707Gw6CbDme+s7zI?=
 =?us-ascii?Q?MftOkzqqBAVp2KAS9B+sbp+bh0TTgaUwWl5j/W4SoQWSIzTJicT35G2Qtcwe?=
 =?us-ascii?Q?VQbvyOv+ew9lFKWKNg1hHCdSmkOeGx+hpN10J5qqg4PD0jNvMkAMPB3nDHsH?=
 =?us-ascii?Q?jx6MTOMrPk/Fqes1bkcwPan93t4nsdc0g+V2DcLecuLPYyZv96Pz5zMszKIq?=
 =?us-ascii?Q?ae2BXe5ikEc2mfTKblphTjCfRdJ27safwTgeDoRiD1jmHRt//ld6ELBeBAVk?=
 =?us-ascii?Q?FA0fs/LE+WOaoB4mPvljGXFzsaSqbC4Va2kv377pORT3T6FKa+yd9ZxGcRe1?=
 =?us-ascii?Q?j9KAexbUw/L1xLpXpkH6ZkXCHJUVg4dYSiRNYT9Nw2jIHyPzeJcPvH4ekr6v?=
 =?us-ascii?Q?YYhfNv4wC4YURD2vuL1Jd50pdy3LmIBfTLNUJEfEPUKVecMYBBljK/TfhXW1?=
 =?us-ascii?Q?2J7XndoRRvTeeqCjKEA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf470f45-fcfe-4927-a3a0-08dd142d5f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 06:32:05.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sMJJJbdKzT+IX7kg86gDWjnH2cr6ehDaZF8yZNc6UBAtLWpCGASKVlXwm/UN42gITsVn8NK7uI0+SlBj2FNCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228

Hi Bjorn,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, December 3, 2024 8:11 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; krzk+dt@kernel.org; conor+dt@kernel.org=
;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MD=
B
> PCIe Root Port Bridge
>=20
> On Tue, Dec 03, 2024 at 06:06:07PM +0530, Thippeswamy Havalige wrote:
> > Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > ---
> > Changes in v2:
> > -------------
> > - Modify patch subject.
> > - Add pcie host bridge reference.
> > - Modify filename as per compatible string.
> > - Remove standard PCI properties.
> > - Modify interrupt controller description.
> > - Indentation
> > ---
> >  .../bindings/pci/amd,versal2-mdb-host.yaml    | 132 ++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > new file mode 100644
> > index 000000000000..75795bab8254
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > @@ -0,0 +1,132 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/amd,mdb-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
> > +
> > +maintainers:
> > +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: amd,versal2-mdb-host
> > +
> > +  reg:
> > +    items:
> > +      - description: MDB PCIe controller 0 SLCR
>=20
> SLCR is not defined anywhere.
Thanks for review, Here SLCR refers to mdb_pcie_slcr should I modify it to =
lower case?=20
>=20
> > +      - description: configuration region
> > +      - description: data bus interface
> > +      - description: address translation unit register
> > +
> > +  reg-names:
> > +    items:
> > +      - const: mdb_pcie_slcr
> > +      - const: config
> > +      - const: dbi
> > +      - const: atu
>=20
> DWC based it seems. You need to reference the DWC schema.
- Thanks for the review, Here should I add both dwc and pci-host-bridge hos=
t bridge schema.
> > +
> > +  ranges:
> > +    maxItems: 2
> > +
> > +  msi-map:
> > +    maxItems: 1
> > +
> > +  bus-range:
> > +    maxItems: 1
>=20
> Already defined in the common schema. Plus you obviously didn't test anyt=
hing with
> this because bus-range must be exactly 2 entries. 1 is not valid.
- Thanks for the review, Will remove it in next patch.
>=20
> > +
> > +  "#address-cells":
> > +    const: 3
> > +
> > +  "#size-cells":
> > +    const: 2
>=20
> Both of these are also already defined in the pci-host-bridge.yaml.
Thanks for the review, Will update in next patch.
>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-map-mask:
> > +    items:
> > +      - const: 0
> > +      - const: 0
> > +      - const: 0
> > +      - const: 7
> > +
> > +  interrupt-map:
> > +    maxItems: 4
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> > +  interrupt-controller:
> > +    description: identifies the node as an interrupt controller
> > +    type: object
> > +    properties:
> > +      interrupt-controller: true
> > +
> > +      "#address-cells":
> > +        const: 0
> > +
> > +      "#interrupt-cells":
> > +        const: 1
> > +
> > +    required:
> > +      - interrupt-controller
> > +      - "#address-cells"
> > +      - "#interrupt-cells"
> > +
> > +    additionalProperties: false
>=20
> Move this before 'properties'.
- Thanks for the review, I will update in next patch.
>=20
> > +
> > +required:
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - msi-map
> > +  - ranges
>=20
> Already required by common schema.
Thanks for the review, will update in next patch.
>=20
> > +  - "#interrupt-cells"
> > +  - interrupt-controller
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +
>=20
> Drop blank line.
Thanks for the review, will update in next patch.
>=20
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +        pci@ed931000 {
>=20
> pcie@...
Thanks for the review, will update in next patch.
>=20
> > +            compatible =3D "amd,versal2-mdb-host";
> > +            reg =3D <0x0 0xed931000 0x0 0x2000>,
> > +                  <0x1000 0x100000 0x0 0xff00000>,
> > +                  <0x1000 0x0 0x0 0x100000>,
> > +                  <0x0 0xed860000 0x0 0x2000>;
> > +            reg-names =3D "mdb_pcie_slcr", "config", "dbi", "atu";
> > +            ranges =3D <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00
> 0x10000000>,
> > +                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x100000=
0>;
> > +            interrupts =3D <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-parent =3D <&gic>;
> > +            interrupt-map-mask =3D <0 0 0 7>;
> > +            interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> > +                            <0 0 0 2 &pcie_intc_0 1>,
> > +                            <0 0 0 3 &pcie_intc_0 2>,
> > +                            <0 0 0 4 &pcie_intc_0 3>;
> > +            msi-map =3D <0x0 &gic_its 0x00 0x10000>;
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            #interrupt-cells =3D <1>;
> > +            device_type =3D "pci";
> > +            pcie_intc_0: interrupt-controller {
> > +                #address-cells =3D <0>;
> > +                #interrupt-cells =3D <1>;
> > +                interrupt-controller;
> > +           };
> > +        };
> > +    };
> > --
> > 2.34.1
> >
Regards,
Thippeswamy H

