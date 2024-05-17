Return-Path: <linux-pci+bounces-7588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB88C80A3
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 07:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BFD1F21FBA
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A11171A;
	Fri, 17 May 2024 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TF0xVBML"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54FB111A5;
	Fri, 17 May 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924115; cv=fail; b=rKaMMm4Hs057F3KnhGLZbOCOMesczcgGzCabKemZs37BuVLz1UtsvsGUWiAym0Dy5FMcmBDcvd+3q285Y9X1lI8txca7EKdkX0G302uom7Xx8Vka2ae6QnnhaHhGw9Z7lEafurZyc6wyeE75kVESVTDABnr0ucdZ90YFJc0Y3Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924115; c=relaxed/simple;
	bh=1pp7xusKTXJyM5jLM/i1CaTZH8q4bhHYQg5GghNDcM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UGrkpg1ODvLIGjo4XSya3ocBU25RNFAUwcI1dGijsmJUu6DBmZ8UCENT//OUfrRJWV637H679AGS/FcuN9Qx1NHedTvF8+PxQetlCVS3/vi1fF93gSL8DCfJundLlQOFbsVjhdo3bi1qAYiv1QWy2QciT4V747vzAiYq6lZaUMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TF0xVBML; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O90QF9RkfNEFKPRsq2UaA5FTrTq5wM9yekrXPqcW9SVWdppdiOUx1VAYdj03/G0UK3+0ljXGJsLdUCFK8YjB2PbrE81RY4bK0fll1C1KFBjWO9a8Eyg0VFfGUKdWHcLs/nmTfXwvWy7/zIMblipCYLBgL1ydEWbkCKBXsK+1z2WH7LJG+TweNTQM3U0aUnCwV8MTt77TzmsUrudb1yyUfpVtAc5n8l4fzAXaYGUKENSQ37JUnJ5b7zhi4RaetjRbBjRDV15b663GFujdODNQ0jvZJ8a9YCkWZkQHuWuMmxqujBTZUW79fSvHi25qHZUtpJAuwXwQFHG23JSJEBHS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QlruRmZ+y7jOgKHT3n1mkqTpH9RV5GAIcfw615a3Us=;
 b=S1fCMXZP7Wo3WUlGh2Bz3DDoI6SOoTEic4JaKfgYENpR+tTMtzU1wmhzlQPit48zLKa7tFekaKJDZyGFjAbzTpIxrEjBfp7GppuCiGCHMW+V34HblZuYJmwn79aQyudIRWlWJYFC8UjxcU8BMEc7N0X5scR2BggQI/yaolZrAVoyIs/9XbV4y0PnHe//sm4SeGagKWqY42L5+DzxL/QoC1xnKrZ2OWVvcH0R6BMy9Qs6XoJE8g3uJSzrs0VAMv3J8oLwjChtWRhxxlL9hWD+A+ppeIiOwWmhkDU+9R2p1B58LiCLGPsu2sxMUn0AunFWDhQmrXPjJCzTPYMDPmNNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QlruRmZ+y7jOgKHT3n1mkqTpH9RV5GAIcfw615a3Us=;
 b=TF0xVBMLuEKEx1HwZ1QZjFp1oqCFl0U43Am/7P8ei3JdTaQcM5eqqOAYu3sH31RcSWjJkSGPPhbUjQWnUcioyevNpy7ytufHDPq7Ok0EjmayeX2KmXrzGAh5qkZyLAi2aHcxiQDOYXH85XTMXBFVLdflbglw22Mn9FL76mdSJebR8QtLHglmqsBX0j9e00cXJwCKBUiwBKUiTG/HG06Hw+kRM03yRKPg3TiXFzJIYAfaTxuFacN7DZHf/GvA/ygtLygkHaGseboQPYKuph0/TmYh/6Va2CwDaBBkgcMFrc6EGKm4A1+wDP10ZRYt1l6B/09OrYqe+3gRp67cSM29eA==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 05:35:11 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 05:35:10 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Jon Hunter
	<jonathanh@nvidia.com>, Krishna Thota <kthota@nvidia.com>, Manikanta
 Maddireddy <mmaddireddy@nvidia.com>, "sagar.tv@gmail.com"
	<sagar.tv@gmail.com>
Subject: RE: [PATCH V7 0/4] PCI: Add support for preserving boot configuration
Thread-Topic: [PATCH V7 0/4] PCI: Add support for preserving boot
 configuration
Thread-Index: AQHaoW8O6T9QgBu4DUGMsjcflgWlrrGa9G9g
Date: Fri, 17 May 2024 05:35:10 +0000
Message-ID:
 <PH8PR12MB667485001077FF106E728320B8EE2@PH8PR12MB6674.namprd12.prod.outlook.com>
References: <20240508174138.3630283-1-vidyas@nvidia.com>
In-Reply-To: <20240508174138.3630283-1-vidyas@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6674:EE_|DM6PR12MB4418:EE_
x-ms-office365-filtering-correlation-id: f2e0661f-75c3-4f2d-28d3-08dc76331e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Afh7qSObmrYmA7knUN4ithXmPTq+9McS5w0OuWFlhhhzn4HqIa4KHGhmJsLi?=
 =?us-ascii?Q?zit6Fqj1c7lKPlDZHijkAdrM35iXs9Eub+HlDpHEQjRGW/y+dSByLYu9ml7u?=
 =?us-ascii?Q?kMq4+T+j4+6PhmXQvLKr/QMc1CkbdfDnHY5hKgMOlhlZclIk2wzzS4JNZawb?=
 =?us-ascii?Q?6SRD8uI8/LePmNt/mO7I6wP0kGETOJvwAArcnzBtERYdRShfp4pdt9S6A5m3?=
 =?us-ascii?Q?C/BS9g7bh0lIHGXKmqWTft8x+PfJSugDoUGVNf+BBFKusE812bFytzHdLSY0?=
 =?us-ascii?Q?0gU3+NN5vfHUW8nIMFvx15osv+8YZAI89dvj1G8vKk65g9MNmKoB84cNq0NW?=
 =?us-ascii?Q?Cf+v4QfaXXbnMBxueBi+wq8PEVl0DEIykDe/gQsLZ5KCpTd4FC0lhZsSzDiP?=
 =?us-ascii?Q?IorIuQ48tuyNCvNyCM0/WJ9Oup69/bplQztEqLhsgDe5nfo3zDCU4ZA/BBMY?=
 =?us-ascii?Q?hXz5Z7e9cmDLSO7AOJ6VUbY79hLR/F9ZcTSf96S/oR8RYd6C8X0YC5bI716t?=
 =?us-ascii?Q?zGpW0wIvB5T46Rdccv01Btqc67OgYv/i5kH0soS0xKjzE6asC4c8mCUlKDNO?=
 =?us-ascii?Q?rZfOox5lG91iwNIg9kWTUR2Q2RSnB1fym8MwfOz02QvYmU/cnvs0zNO91PL/?=
 =?us-ascii?Q?UsnWPAuCmOWLLMR5bMhtN2ZgO2SGM+mIESfpiFIJRVglR5jil8xB5M5+8inF?=
 =?us-ascii?Q?mY92Z+L5gmMUb2Pecb8flY8GQTz1BoENvUxbWd619uy6WMMy9KauIjc1gu9h?=
 =?us-ascii?Q?PJjO0nKX14ehXHXcw7CSbURqGojFRxCLozG0BACm9+HuiW3A5BoboWtU3td8?=
 =?us-ascii?Q?IGYO/C2VU13ajlJxh00qmw0fHsopzHfl1R8BKkG303nPoFWzcOrYHVQ24kvD?=
 =?us-ascii?Q?ev0Ava6WDIdWzlY+CNF7zp4WzACECcX2A40M4vj47fOeYroZ7oG/a63a3Keo?=
 =?us-ascii?Q?lgzJtbg8zlxu9LTVvdSOVTvERPmFPX6Qi3i+lHGcTfvXuPpphYyaTh+Qv6vX?=
 =?us-ascii?Q?Weoc8ea9FrWjx9y3M75wMbnCK0oMO3Uyp9MEtjHZfIAoMXnaXmIRYGbRtM0Z?=
 =?us-ascii?Q?cpGojZxxQKsgmNlJPBjcFZqhO2UcO8R0t1i0dBJYJm4m3DvwJP+QBV0dUvUu?=
 =?us-ascii?Q?ZFonpGSuHTrZi/k2tPTsE0VZyEWEYJBfVtan4jTClR6KTfZq+GpOx+7tUOyP?=
 =?us-ascii?Q?bEHAPKnYuBhfb6KbAOXp7PrVoqysbBc9rP5iSyZ2fuD76oPsFlaKxPcRwNs+?=
 =?us-ascii?Q?WKXuc9gWTIqVWGZUsOYx9UggaDd488FC+NZEEdca9iI+/ccZ2y/BlDZ3mpcS?=
 =?us-ascii?Q?rsE5T9Sqs23YFqEr+j03vdeLoJw8wGjsqwyseQBLR6GztQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wp+OV9tOqWbRLDKv6rBJBZUS9atyPzA7h+lQbpdn2zuWE+jYX0rN5c6Uzy8j?=
 =?us-ascii?Q?bEyQhrtWXOPKO/m9h3ggjS3OemTMfD9ifqlCufrh9/rJ7tSxs9B4xkgrftD7?=
 =?us-ascii?Q?JIcRB3znxdF0w2LaThUC16JHhFpLeJqluYA3GthmROWnVnNBGsnaPwWnP701?=
 =?us-ascii?Q?ZMFOnGydXUT+1YtiGKeTG8iIdqg5KcepTYUusGIM5AX+G5WI4KNEJjID/CuY?=
 =?us-ascii?Q?LJ8iVLk8WJZ8A3XogY0iniuwEUKk0hi2pVS+/cfrtCZxonXb2tbUG/+Y8Q0Z?=
 =?us-ascii?Q?YWNx0ZdXYZt+uhNzaqDRCLFZmLfF+tSAdvcrd30itoTVTywaRLiln/dgusVo?=
 =?us-ascii?Q?Su+45N3rXABcgtXqB1WTihcWtAZ/iObX4gqUmGByesMlwnd2831IULxQ+UDm?=
 =?us-ascii?Q?JdOqft+6T3VXFQnRvLHWwOXK8ZzBP1Qr9/ECpVn3Ew5xv+43KdFu7m7w+Kvl?=
 =?us-ascii?Q?v8drMCPEoIZKBOskP8p0q+FF1yt7PQ+AmmmTYwJJ/zELt1i/L0AyY+OLIlQR?=
 =?us-ascii?Q?sKXAGQeLLsO0xhWEDPQv2bR+qfwOHVa3UJXw5GP4GbEUsU4ak1y/fRqgF3fm?=
 =?us-ascii?Q?gMu4rYe522YN4xsf5TnTeMltzKPqnIdpT1DdAGxDuHazPyvnl6ca+MFYq2xw?=
 =?us-ascii?Q?ODO4neXanCty82BHMVQ9q5Ah1rZc2Uo3L/Es+dIrZPjFryKVw7JOcv6xagHL?=
 =?us-ascii?Q?cQbO7m9BmvS5GZgjcCBA9RVuwmyW4accvIJtpT1avU6Osvqmjg+UZm9yrGGI?=
 =?us-ascii?Q?RYly4B5Ow+BTgB7zq6Cd6pt41SwVcviztuRaWxd3jLsyq+o+g11NA159X8WA?=
 =?us-ascii?Q?xyy9yzRV0D31vz9pi0wwFGeGGyEze8FkxTcUUzqWmkjn+1iTwg24HB0foqJy?=
 =?us-ascii?Q?H018opcCU0UgQrxYMg8Vnj/p+GfxpWqUddlqrraAuBTbY08LlK9aTPjsH1cQ?=
 =?us-ascii?Q?vMbrRALONy//ONbdzH4x0P6Ji2r2NpHyt+6SgBKjmJtO7/8CbJ859cx30McN?=
 =?us-ascii?Q?vPJ1W0tjMrBiIdt5AUDDFcEXyJllycypa19cTU6kvwcIt+7EeM4jWbqfoo90?=
 =?us-ascii?Q?jTzW1JvSIhXCB5OKmMT9UPapVkoSXN2mVX0nMWAW6Sob02oAcx/NLOL+YLIZ?=
 =?us-ascii?Q?jgzpNxGH/X36a0pf+IGOpfdjI9ZSn6lUbDSCsrFOS1qbZVeOJOLGp7d7q8/y?=
 =?us-ascii?Q?ka2Gg5IO/BTGBRKe5jiV0Zl9bm4wMBPmNVb9VP2mzoLa5WOS+Dek474Mg1Yj?=
 =?us-ascii?Q?A/1Hz1wwhi0EQ0FVBszwNbv8fYxT3pnB6ANn0lWwznNvDh61uRnE7V64zzb7?=
 =?us-ascii?Q?WFXQ3Vr+t76tHL7h2PB0vGazIofVehdoKKtcGJGOP/OpsxBbRDdZH8zgVrZU?=
 =?us-ascii?Q?MxMEcR0rRqz/+A4d7YYbGgDj5wf6ms9unHJwXxCWowLZCUFGyI8xrHWiFL93?=
 =?us-ascii?Q?Y3MfB6X4WfbgM5GXEDRvsrBFh5IkqUfvJctmbY937x1OE5KJmvpgxhFRUQnN?=
 =?us-ascii?Q?wZZU3Wo5utAYM28cS8oRSAQigpdI1bCq/nWYLdmOJTmZxR7sLndla8oe8DaK?=
 =?us-ascii?Q?oRVfyEb7ByxXHW1aNjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e0661f-75c3-4f2d-28d3-08dc76331e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 05:35:10.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7DAQC3ueG2uRovskuEwnTb+xljx9VCXPZm7ILKD93yy9o9/BJISqfNPhXZ/5xyMC2NXk1u0PEtLzBVL2MMLHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418

Hi Bjorn,
Thanks for reviewing and refactoring V6 patch.
Could you please review this V7 series as well?

Thanks,
Vidya Sagar

> -----Original Message-----
> From: Vidya Sagar <vidyas@nvidia.com>
> Sent: Wednesday, May 8, 2024 11:12 PM
> To: bhelgaas@google.com; rafael@kernel.org; lenb@kernel.org; will@kernel.=
org;
> lpieralisi@kernel.org; kw@linux.com; robh@kernel.org; frowand.list@gmail.=
com
> Cc: linux-pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jon Hunt=
er
> <jonathanh@nvidia.com>; Krishna Thota <kthota@nvidia.com>; Manikanta
> Maddireddy <mmaddireddy@nvidia.com>; Vidya Sagar <vidyas@nvidia.com>;
> sagar.tv@gmail.com
> Subject: [PATCH V7 0/4] PCI: Add support for preserving boot configuratio=
n
>=20
> Add support for preserving the boot configuration done by the platform fi=
rmware
> per host bridge basis, based on the presence of 'linux,pci-probe-only' pr=
operty in
> the respective PCI host bridge device-tree node. It also unifies the ACPI=
 and DT
> based boot flows in this regard.
>=20
> This patch series is a complete version of the incomplete series (
> https://lore.kernel.org/linux-pci/20240421190914.374399-1-
> helgaas@kernel.org/ ) posted by Bjorn which in turn was an attempted spli=
t work
> of the single V6 patch ( https://lore.kernel.org/linux-
> pci/20240418174043.3750240-1-vidyas@nvidia.com/ ) posted by me.
>=20
> Vidya Sagar (4):
>   PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to
>     pci_register_host_bridge()
>   PCI: of: Add of_pci_preserve_config() for per-host bridge support
>   PCI: Unify ACPI and DT 'preserve config' support
>   PCI: Use preserve_config in place of pci_flags
>=20
>  drivers/acpi/pci_root.c                  | 12 ------
>  drivers/pci/controller/pci-host-common.c |  4 --
>  drivers/pci/of.c                         | 54 +++++++++++++++++++-----
>  drivers/pci/pci-acpi.c                   | 22 ++++++++++
>  drivers/pci/pci.h                        | 12 ++++++
>  drivers/pci/probe.c                      | 34 ++++++++++-----
>  6 files changed, 101 insertions(+), 37 deletions(-)
>=20
> --
> 2.25.1


