Return-Path: <linux-pci+bounces-21599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9845A37F41
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0DC16AA13
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999719CC3E;
	Mon, 17 Feb 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yZRZBCrj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86B21660D;
	Mon, 17 Feb 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786406; cv=fail; b=d0lx857CuNnua5MBOCBUPz7IjB28gl3GGTrylKMEcNJHTJsV5/FkC2ebeau0412lBm3u9rWKFWKoFzQGHs9siT9op/2I2Lpj7SMUmLAZS6TcLliKW1uLzk+E9pH/xZE5TYzZgXzR8IxfPVViApslQS5Qbb3J68xkiylhpc/W/oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786406; c=relaxed/simple;
	bh=GomJpKvEZP5CudrGTffIA1eypW41lVVjYJTXuwyOof4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JzL5jpDNzoN1BOptYeuS/mKXKp8GaT5hIe3PwsTdgzQDz7IkGjelS689e9Jk+mB7rZ8xrMVYbYpMjoTUO8fqgFZjJKwmtX7H5aMtu01MVOkQUtSg3ZQYfHCAZWSkXkC9a/pqxWOOJ2LGd9cqO5aYEG4l1w+uMKyWp6MHjQeuFaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yZRZBCrj; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D05ouSKIEe/BAOpg1+FnCZIlf74bivCtHcp3NBAtHONL0ff6tT+FGTDC6L1ArtjAYn0OobPyhHIcWnDc5sAm6Two/Ym2B2XGFJ+kSHQP6/ol2KB6962Tr9aCS41VxGH0jqD9ByW+D49Ty3K1F9YWQqbxNT6nevQDTprGr7oPP/+9xdFd2IzW5KjJadbK3+682SlGm8baKV5Our7/wqDZkoAaAhJtNL9xeNrm24uUbRkHM24i1sffqeWn7nGSnIx/UXPZILQZInLiADCHZtoXLfsU6/R1ipPfLHSjALHaRpHaCqkH//LV5EjIe1eWOicyZ2n0BpoUKIDaWmosveuuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxf1phBvb3BYVG8IR9VPWfbh2xJbZ0dfqS6TBZXOG/4=;
 b=I9WQaztd2usf4dfFrGAZGFN0Snae9zR18UEqLo9rh2osYgoFzXKWtU1NFkjjVAlfeGeoAlmAVxEDPiorLFsehW/DDq0sbTrHFdDWGTl6/g+dEiP4f9cS0XK3B7SPjQ8E1vHcQiULDoGGYPzfjnY6Xo4Q0cP1veHrmf4ETpUYM5C2r11hqctvwDFH4l9WqJaMXS1i6bnNeJIy0wvWpnu13167MBX97JIyRgQqvj8Nw40878XeXXu/NmY5D4aJllFAo+gRAd+OUNaxFgWrNl4c8uO1WlxLkrvSeZ5LTjR6h+mN6kLn/YiKzt2NTM6C3mhqsA5u9yKJEdwvfpCWoDfI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxf1phBvb3BYVG8IR9VPWfbh2xJbZ0dfqS6TBZXOG/4=;
 b=yZRZBCrjXvHcPc7dhKlNv/dy2Yz6SXvp8LsYrTVI/Dpv1tfssmOritdJTElKtcatAQHHICpsQw7msN9Lpid3LZXcc1bQAnEOyZC4FCnoFPw0dU5HwEZeqnWA7PI7UuHwiVj+YmpOBgCTyjLtVxHIbp9R3HctPjCWFB5Gj8JXhlo=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 10:00:01 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:59:59 +0000
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
Subject: RE: [PATCH v10 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v10 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbfE+8u+Pg3Yjm6Ea/d0sQDKu0w7NCbkUAgAjLAcA=
Date: Mon, 17 Feb 2025 09:59:59 +0000
Message-ID:
 <SN7PR12MB72014DDBEE430C5FF56CACCC8BFB2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250211063852.319566-4-thippeswamy.havalige@amd.com>
 <20250211183330.GA50291@bhelgaas>
In-Reply-To: <20250211183330.GA50291@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM6PR12MB4314:EE_
x-ms-office365-filtering-correlation-id: f62a1eb0-c368-47f8-5093-08dd4f39d6df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V8/EjBDzsvaxV0gRSfTFMn5OsJIEim9iZ5iHyccenHI8jURDHQhTIdgd7SSk?=
 =?us-ascii?Q?fBQwBDNbRXHNLK0AUBdN3/HdtOe/Bg4Bb8JSzOdxygpMCtvts86gItr8pK5F?=
 =?us-ascii?Q?vRqydd5CsbvHZE12MxE2wv6wtGtXufT9l7myqPXVSOdYDvxMD/Hs9RMxLCL2?=
 =?us-ascii?Q?65pz/bPQIN2SKAfubfKReDzCJlmTAmcc86KYf8rqcFCOow8Fnj1H31WCdiwp?=
 =?us-ascii?Q?4wvi58fxBfZVL6LP/+UIQwWT5qNrmryLZKNp51wWdAjoPqAXO3jp3mGYByJb?=
 =?us-ascii?Q?MNZLwjf5MjmkfWmQYxs+7pU9h7vqdZjF1WJGqVkOejVe9iuHDczCgH6mh+8V?=
 =?us-ascii?Q?P4yp9GX2H7mVTstvSTrJe+GzHEY+N9dfBr/m2s+7/Z4Nc8byCX1sBam1C1n2?=
 =?us-ascii?Q?u/Uc1tSY0ja+C2glagD/bF3HP1MzsF9FYxocC47i6QtoCf69rcK9qFx46Qwa?=
 =?us-ascii?Q?BDgrz02jWXXTbAi4xoUXNV2IHB/tjIiRu9LB+jA2F6RmZBiGvKrNSImN1LUG?=
 =?us-ascii?Q?v+ct4IyZ22mVpaHGv2UrloqYNc842I5eJIL9P3vgTyMOASZu9D2ZjPwQUMlZ?=
 =?us-ascii?Q?Ag6HEz2WhDkewyNkppaekpuvd6bMt8R/m6tNuARTxx4V0UgxXu5NImxh0VRo?=
 =?us-ascii?Q?X9V93OS7otQJjFWvJrZUjAQy+0laijHK4vhKL/0DKt34JklQxV1BxzUZCoo/?=
 =?us-ascii?Q?rvUWlgSWQeCtHi9unOePF4UzsR9QFYT+ABnoF+b2VeBldMWAvTStujzgVfdj?=
 =?us-ascii?Q?/sGkESV+TWF7uaup3sDp0rLolHUA5LQyzq2wMK7VTzGobj7XHqiX3PMUj8Tv?=
 =?us-ascii?Q?qRg1TnMP3MgER/Csv6BiDRWUPmQ1CVm4OQrZlw9c7TsYOaurz0pHGHYYMJJq?=
 =?us-ascii?Q?AypL53xU5+kJiqalxYd4Dso/dpc4tVeNhkVNx9EB68ZRxGItWE7StQ2DKrkI?=
 =?us-ascii?Q?L+Rb0pOPLNwhDF3wgLEkezmeoUqzQUwqfderL6R6qcZsKe0CwnFV8+ddzLsj?=
 =?us-ascii?Q?pJlwEDvPkHPHTfGMoh5GyqL3nMfpsTuOIY4k7F7pW8BJuDc29nun1VlTJJ1p?=
 =?us-ascii?Q?HrpElaItex122tWQ1sjwCqpKKoyepELdFX3MapQzh3Lrf9+pwLwEbgioP4cF?=
 =?us-ascii?Q?lZ/tK4E8+GfWiFEq6dDdUJqma0JLy7bHBufzvgtuSDWmUK4oAsIcBf4s4Dd9?=
 =?us-ascii?Q?YTXJE3gyHcQBiNW1c/1G+HwfQyh/tvJ9iIvTcqbmISyAI0W0n6svCBNMepBB?=
 =?us-ascii?Q?qxIKAP+cxkHPKj4vRw1VHzP0naXhit6IH7YgUpvfbayQKfejYhJShUdTFEW+?=
 =?us-ascii?Q?RS5argCfI7Qov4zUnX+K0PGnfAx9eDj8HURIcjMPuU5NNcfnXtHrnd4MmCKD?=
 =?us-ascii?Q?RMU3a0HR1XTPVLp4hYOaJKaDe9L/JqTDTuUDxVV1q7x8Y7TXGbBpzSkMDexG?=
 =?us-ascii?Q?EqKvO1ZlHwJr+zl+sKaA2zad70lUBPZI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LcmR8kcebD+AhFEzXx7Sm8OxT/qMn1zab20mwCUu8vYnJ5LAuRPIRgRQPwms?=
 =?us-ascii?Q?XmkpleJ6gVtrpYDQ+oKIP/sp1++snOJX6mJJ8vw3Kqp76leWrvRp/xDoJJie?=
 =?us-ascii?Q?SFGInhRpip44dc2eTBOqS9DTzuBo+aZukDb50hUK9xnexIVcuH8aG5snq1PS?=
 =?us-ascii?Q?ExYs8MQGHPYY/D0CZgcJbEkQJclJoQ5x35xCqi5zblPgQCCJ9qQE79uAjroh?=
 =?us-ascii?Q?rQJEG2gvT8QmvjGOF/E1LkOcdHojtDrk1au3hRZZVXa0jJqfjqYbegvNl7bg?=
 =?us-ascii?Q?gnB4ghlbzlk6eK3+KqyEMDzl4xz9j+wVtZDE0co9lcHdI2GeOtQnGWAvM+jb?=
 =?us-ascii?Q?tvHVNj8t0QV8PPmp8B83sj2Lm6vpgBLj9fi/Bts8VirqGJxEwqLIoHjqY+wF?=
 =?us-ascii?Q?lj49S69U28HlvPR6PVIkHVS6Glcq9A4/sBiR3uTqwTANpseBDCuBEvcO/FpW?=
 =?us-ascii?Q?qAYJAKoY7FiuuE67KypUUJd/8+3VtkUHxR57xQTO8sGTcGfbzLRyyKwkms/q?=
 =?us-ascii?Q?wnvOwb0EQlGNwHBHVwHcT55Fi3qbHN0kGd6bsDryP2YopC6Hc7SXFPUJsVrG?=
 =?us-ascii?Q?n99APZTKWytUCKKVCRWJpCLJMXTewIkMswsqD6qQR09ezd+jg535dJ2twgIT?=
 =?us-ascii?Q?d2b7Vi81RrC8gLyScluZ1APV4vcDgN4+wn9Qkc2RQcZIsJGHOBiW+Wv73iL0?=
 =?us-ascii?Q?wfHFRBdjL3a35NK5bK2gN6CCUo+sjKWm1cmtYwG5GWJDHtQetIKs6uc6N8oS?=
 =?us-ascii?Q?wWwt1oWTZHXM31AXDI0We3sMv4Rzn7rg9jZEpRBF1H/hlKoireUWe2VU7vZ9?=
 =?us-ascii?Q?w8eSVylmvFLCjt3S++2PkZg4yHJsZ1mfunBVqDtT1UKuPq491lTJ33oTcl54?=
 =?us-ascii?Q?lNxUnCNnr/XV6QBx25UyDR758/ZDfzyImzcgKsTuK+XJCSi9pMWR02gvsZ/p?=
 =?us-ascii?Q?YGmtT3yLxgrgs9aCRJXtA8EYvi37C55uNbqBxRTdh4MucU2WIjvpQigXF9ur?=
 =?us-ascii?Q?2t/5eFuVaNYLvRLDGIR2shxaCuKDsiypfiKTOLudUHa87xIijYNWv4Pg+Xwc?=
 =?us-ascii?Q?DZXeEz0L6Z9Y4n4+mF7K+bYa2zXWP6MaCxYC3hHRyd8o5VLGkZWXHVKImjHB?=
 =?us-ascii?Q?MuH+z4tHbfYJcIbOIFNIL485C9SJcvpOuKl9l0QbfaZ8ZYvmkAfmuKWEL+5d?=
 =?us-ascii?Q?gTrO3u69c51mkZzaD7iguiEN9f0NzSGL/k8kQ7FCj7Gt2WXktxTu1ZlEP4JS?=
 =?us-ascii?Q?s2orHgFcLZWGPZWYm470R85btQCJhEc6Yo0v6du5ujFxeOODy47gLAwAjb40?=
 =?us-ascii?Q?BE7pzb2xDOW8O/HEKF2Xt8jwn3W+w86dQh46HLJulSbpZYw8efhnj2NQskT4?=
 =?us-ascii?Q?+VLQzofFEf9p/u86bg1BSkultJ7B8/NjtqIMZP94JFFIDJIK6JqWa/yS2Tcy?=
 =?us-ascii?Q?JSm6qwAGCdLg5V5JmtYjc6R9nRoLkO5dhqAkBR042e9jl8nq9ZHkeBUw7Voe?=
 =?us-ascii?Q?J8fTYIkpHboA4wt0WGtP90W3yXp9eS4B+ByergvxxQj6FZahEBWUQzbP/2qB?=
 =?us-ascii?Q?Fiq6o2qFAwCo/p+uG1A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f62a1eb0-c368-47f8-5093-08dd4f39d6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 09:59:59.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awibXJrtk3l0sya4xjgQ+C/vxSjVUkAuYwxDDxeDBqMmxyPOXOOYJUPjXLHSA6T2bqVxU1TyUDQ0qwePsgGjYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 12, 2025 12:04 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v10 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
>=20
> On Tue, Feb 11, 2025 at 12:08:51PM +0530, Thippeswamy Havalige wrote:
> > Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
>=20
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -27,6 +27,17 @@ config PCIE_AL
> >  	  required only for DT-based platforms. ACPI platforms with the
> >  	  Annapurna Labs PCIe controller don't need to enable this.
> >
> > +config PCIE_AMD_MDB
> > +	bool "AMD MDB Versal2 PCIe Host controller"
> > +	depends on OF || COMPILE_TEST
> > +	depends on PCI && PCI_MSI
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here if you want to enable PCIe controller support on AMD
> > +	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on
> DesignWare
> > +	  IP and therefore the driver re-uses the Designware core functions t=
o
> > +	  implement the driver.
>=20
> Wrap to fit in 75-78 columns like the rest of the file.  This gets
> chopped off in an 80 column menuconfig window.
Thank you for reviewing, I will update it in next patch.
>=20
> > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
>=20
> > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> > +
> > +#define AMD_MDB_PCIE_INTX_BIT(x)
> FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK, BIT(x))
> > +
> > +#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
> > +#define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)	BIT(((x) * 2) + 1)
>=20
> > +static void amd_mdb_intx_irq_mask(struct irq_data *data)
> > +{
> > +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct dw_pcie_rp *port =3D &pci->pp;
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	raw_spin_lock_irqsave(&port->lock, flags);
> > +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> > +	val &=3D ~AMD_MDB_PCIE_INTX_BIT(data->hwirq);
>=20
> This doesn't look right to me.  hwirq should be 0, 1, 2, or 3 (INTA,
> INTB, INTC, or INTD):
Thank you for reviewing,=20
Will update macro to following=20
#define AMD_MDB_PCIE_INTX_BIT(x) (1U << (2 * (x) + AMD_MDB_PCIE_INTR_INTX))=
.

>=20
>   AMD_MDB_PCIE_INTX_BIT(0) =3D=3D 0001 0000  (INTA assert)
>   AMD_MDB_PCIE_INTX_BIT(1) =3D=3D 0002 0000  (INTA deassert)
>   AMD_MDB_PCIE_INTX_BIT(2) =3D=3D 0004 0000  (INTB assert)
>   AMD_MDB_PCIE_INTX_BIT(3) =3D=3D 0008 0000  (INTB deassert)
>=20
> Maybe the AMD_MDB_TLP_IR_ENABLE_MISC register is laid out differently
> than AMD_MDB_TLP_IR_STATUS_MISC?  If so, and you're updating a
> four-bit field, it needs a different GENMASK.
>=20
> > +	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
>=20
> This *looks* like it's supposed to be a read/modify/write of
> AMD_MDB_TLP_IR_MASK_MISC, but you read
> AMD_MDB_TLP_IR_MASK_MISC and
> then write AMD_MDB_TLP_IR_ENABLE_MISC.  Same below in
> amd_mdb_intx_irq_unmask().
- Thank you for reviewing, Here *_STATUS/ENABLE/MASK_MISC register are
Laid in the same way.
>=20
> > +	raw_spin_unlock_irqrestore(&port->lock, flags);
> > +}
> > +
> > +static void amd_mdb_intx_irq_unmask(struct irq_data *data)
> > +{
> > +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct dw_pcie_rp *port =3D &pci->pp;
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	raw_spin_lock_irqsave(&port->lock, flags);
> > +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> > +	val |=3D AMD_MDB_PCIE_INTX_BIT(data->hwirq);
> > +	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
> > +	raw_spin_unlock_irqrestore(&port->lock, flags);
> > +}
>=20
> > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)
>=20
> It'd be nice if this were close in the source file to the INTx
> mask/unmask above.
Thank you for reviewing, Will move this in next patch.
>=20
> > +{
> > +	struct amd_mdb_pcie *pcie =3D args;
> > +	unsigned long val;
> > +	int i;
> > +
> > +	val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> > +
> > +	for (i =3D 0; i < PCI_NUM_INTX; i++) {
> > +		if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> > +			generic_handle_domain_irq(pcie->intx_domain, i);
> > +		if (val & AMD_MDB_PCIE_INTR_INTX_DEASSERT(i)
> > +			generic_handle_domain_irq(pcie->intx_domain, (i *
> 2) + 1);
>=20
> Why call generic_handle_domain_irq() for deassert?  No other drivers
> do that AFAIK.  If you do need it, "(i * 2) + 1" looks completely
> wrong; it should be the hwirq value.
Thank you for reviewing, will remove this deassert generic handler in next =
patch.
>=20
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> > +static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
> > +{
> > +	struct amd_mdb_pcie *pcie =3D args;
> > +	struct device *dev;
> > +	struct irq_data *d;
> > +
> > +	dev =3D pcie->pci.dev;
> > +
> > +	/**
>=20
>   /* (not /**)
- Thank you for reviewing, Will update this in next patch.
>=20
> > +	 * In future, error reporting will be hooked to the AER subsystem.
> > +	 * Currently, the driver prints a warning message to the user.
> > +	 */
> > +	d =3D irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > +	if (intr_cause[d->hwirq].str)
> > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > +	else
> > +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> > +static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
> > +			     struct platform_device *pdev)
> > +{
> > ...
>=20
> > +
> > +	/* Plug the main event handler */
> > +	err =3D devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
> > +			       IRQF_SHARED | IRQF_NO_THREAD, "amd_mdb
> pcie_irq", pcie);
>=20
> Wrap to fit in 80 columns like the rest of the file.
-Thank you for reviewing, will update this in next patch.
>=20
> Bjorn

