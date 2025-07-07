Return-Path: <linux-pci+bounces-31616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E67FFAFB301
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 14:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90647189DC66
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDB1A0728;
	Mon,  7 Jul 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hvb6vXoO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D415B135;
	Mon,  7 Jul 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890655; cv=fail; b=IZnqNjhoLV08e9J5cziTYIwwOLTO/q325LIRr8uk4hTa5bSq0qdw6S3x/1ZDTxLPqUsSIHdD5vX0Y3h+Pa4ksjvBoQWLxz49LvhCtTb7RPiVzIFHkPJPaF4NrdLkY2oDwVCUmm2VMSaoVL0FiSqPuYjECeAikmKBGeTZLLBQ66E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890655; c=relaxed/simple;
	bh=PGmwpHvzMf4qJ0as3i/DTA64z7Ri7GK1Y8ETfOGEZY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MROrsWnj/3fxCwqiEDEHFuPkGFDTVuFvDEiM3P0Jw5ENC9it8sIb3bAdZN9/qdMzFHpD80av3MUXnZ+xyCaaqw6WkrSR+dfhHeopHNIHWHodA/g3KTBbzmbBxHSY0VwGmPpr3Tjd3l5b+g464+bNSqWEb6awQ0a9jdelNAY8Oiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hvb6vXoO; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSJLBOCdPhbA22U4GP6RSqGjXDJKjib4dzlTiUwSubfLSJ/AkWHX22LCxsTCdPha3IzFgLwverAYVO8ulNAXyZD8Ljbma0dXfEOsiMn8afhJlRpFE/nQV9TqYf6+4zlcD1bRMfd5Y/xL/K0RheXH21WRQcLBWu3QDwQMhcWnHjluy/ZVdAoPPg8LSveiSEEqEmRQCrYGidstWFu4gGleQupNxq3GpArZgsfGulxeAv+YyEJuFmDSwRpWeyUzL7dZF1xzsi5/V3x38pxXt2JMzLFts5lhzUGjqVQ6tvBkjzr0DZvRD1sSzXiAqF17WMiwJDc5dsF0+jhqwp1foRAf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TcBCBaEZliPLesyIthAFQHjz4tp7rTMOfm5eooTHo4=;
 b=rLN0iLkcZC75Nvhjt5CUuI916iIT1MjMuWohh6tBnZTleYgNTy5kHH1CcvV8yYToaAli/6RHtXMcYPXgo9F/0lr8WrYGRy9fgZ/W9BTjrh0moV77GT6Gr1kF+KB6gS8YRd/6Vs0COYUqx+auB6bXR1ZjiVl2//OxtnsRQd11ctCTVtsjKHKaS3dSA/zxOdmovdS9FvvmI/vmAWL6VFYHF0QJf1WkmN+5c/Cx+b2JgGkflEfiHtgUlbjz6amMILFhP7ogBfKTKV1rox8gcI+WQibwMNeOmRXdFyFczksJ9tn2qhRG3T523M9PX3OEKqkfJ/kyss9JLpHSRP4CEOj4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TcBCBaEZliPLesyIthAFQHjz4tp7rTMOfm5eooTHo4=;
 b=hvb6vXoOPdToEAX4OQlibCameKbqg5GogBgvqCRSjzkLgtJOPUGLgpn+RL3xibJUsUIEotb5ECGQDDf/DIcSBKj7kKKt/zbMxa6WsMmt+2XBsNYVXBvGwonlF4bS6rLG/8LGXD+xb0jdcpUT0wJt1G+MYhu7eikfcNPukjl0R2c=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 12:17:30 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 12:17:29 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v4 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP
 PERST#
Thread-Topic: [PATCH v4 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP
 PERST#
Thread-Index: AQHb5l4OeHlAcLHrVEuYFWIGto5L2rQmojfw
Date: Mon, 7 Jul 2025 12:17:29 +0000
Message-ID:
 <DM4PR12MB615823FABAD39C7F3E187A99CD4FA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
In-Reply-To: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-07T12:05:48.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|SJ0PR12MB6685:EE_
x-ms-office365-filtering-correlation-id: f6245831-5e1a-4e1e-4ad8-08ddbd503e61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3hKyl2PUaMRwvxlZP1oJBfOAjQoZ2WeJUCzevQu9CQp/vAsADMF72DHP9R1T?=
 =?us-ascii?Q?vPK7srB7EJZuMqJrQJUTnvUTpYYZqTfp8TglYgii8VzSytJuzhO50pvanVnJ?=
 =?us-ascii?Q?5ZuI2AeqklTcf2lA8bnkAHO510UxvK1ILaERnyIcU18mi3WThBFXgJGPNm/z?=
 =?us-ascii?Q?mp7X1g94yVworUrxnwm4Whjn4j4jB7zGFwYM+BlEYUrJcekeP5G4an6kSCtK?=
 =?us-ascii?Q?r811dOTFCMhZDOXtId/7IuGDpNvfZnLK6IWOZIVbkSBQ+hME8Fpw4sVnSmNt?=
 =?us-ascii?Q?18gyQcKXUlTeao8mDLxAvolAIDo+n1vp9ruJ7IcquXcTn71iab79U0nzGZ/C?=
 =?us-ascii?Q?AqoBgy6YGsIG0Zt7GbLs9dZl68Odomi1iegNuMuC6PYspo7CtvOEETlhecZy?=
 =?us-ascii?Q?GrAHTlL2jmX6Y+z2oXmeXvmZ3DD9/Kqc7L+rIu8Rmt/mVcxUH/9nA9g7vHGH?=
 =?us-ascii?Q?GrK7MEYHVn1Q6PXy/rtRX8wZL5sWQcnfxJsXciwOfhr/Gru/MBB4ewOZSIrH?=
 =?us-ascii?Q?Q5IBWIAYdYkW5aQBFGX6MyBfrRLo5+8iRv4C3EVk4+uKm2adkgIdb6Nm9XRk?=
 =?us-ascii?Q?FAyB1n6ScRJ48CCu/RrRDUrtdy6SVxVQH37n/8+LLQHS20and2comyeW0PH1?=
 =?us-ascii?Q?QQFVJNJQkSHgNS7CjXP2+uyewOiAWxFau9/QGy20mwsGgdzwMwjK25Y+sGAt?=
 =?us-ascii?Q?2NDhjtEmDewbDBI/g4vfMB9PPKCdmEFckCogOGAm+WG2ZzdvtM4WCrhiEiFL?=
 =?us-ascii?Q?51C67FEKbEdDNXAQa0ESu6cgFiG5xpa9cLiWrP4z6TaD2IiinqopWrJ0xKAB?=
 =?us-ascii?Q?V2cJdsrhm2asxTzE32O4x9P6Fno5uizgSyHSIZwOUEFlTwvLJW7QzmDvWUyg?=
 =?us-ascii?Q?Y40OAfEW0DsSRyW5ow2CpVk0Haj64Dy57f94R2RSLFbriK3lqTJE267k7JYN?=
 =?us-ascii?Q?mRBFgckuqzUp4lVzR1GZ/8caXLCRiGo2t6ZHW4AaU/m+4+natrD/mKroZP72?=
 =?us-ascii?Q?Ys5yZSWkZG7MeUS6yQmmR25gQ38mv0Ilo+3QXnd6E5UMCzdFdioe58lg8UBN?=
 =?us-ascii?Q?VxnFR1vz/Q2ezFjf38ff0CQVWI5W6xr4e30nvg3mvwsQSa9BJmCvn07KZgxf?=
 =?us-ascii?Q?sQ/lLAAcHPu18p57bdBWjLSymI4FgUu5W3ilPi6s4cJ8WoYvLK/ly5QM+6Mw?=
 =?us-ascii?Q?ZUVEhSAVTbk4Hs8MCzh+XO469g+5BwnJ3L4NsBkoEa5YNaIKxPHhjyd06t6b?=
 =?us-ascii?Q?vIYUgr/JlMbTPqen8vMKWlim73IWIgvq6KfsMcrXNC8OY47ABYppbtel+Zo2?=
 =?us-ascii?Q?jz3oT/ThqZ8fhE6bmsquq7Q6gQEiU97vXdH5fbDZLQoK96+PlT3QssgsIkXG?=
 =?us-ascii?Q?TghBVhZkQKy6Y/bh948GLq5J+M0EJrD2BcIpiL6cMoahRH0Ot4es/6vCIpM/?=
 =?us-ascii?Q?xWIQRO9RBXGoKpb/KdLj96L4ocjK67GggkWNNIbFF1At708KecKaTw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U5tXmG59Ib7PLoREB+diq0rLPpoM5UNYgrbML5MGrEew5pK2i9f9yAx9CqKV?=
 =?us-ascii?Q?r4XD8Bmvq4h1scUqAS23N5ESM+3VV2pJ7FINspM1ejxTwpXilbm36ep/MccU?=
 =?us-ascii?Q?/2XzPOOgrq6ncmhM9y5n2YFVMerjWIGkMbC+U7GQT6ZmjeNToXCiZ+AJuQv6?=
 =?us-ascii?Q?aKVzSNIKMd/tyf/c7LWZ1NQNgP4KzyXxkhqXvZOyb+Sf5pGXJfELZFjTOMSd?=
 =?us-ascii?Q?Fy3xY0X3eq0hzm+miYa4szQjbBMPlpq/bU3cuKqVzb/0Ibph0rpOdgMTcySf?=
 =?us-ascii?Q?X+bBjBfTuhm5GBBJEsJuq0tFcklF6At+GeOoCMQS1Y20IbYLqpc/L0mXh+Sm?=
 =?us-ascii?Q?dQ8B/9N/iML4l7sj7TcFmq4Zoyh4UbAzWczIPYYbXzVmPm8oYF6xOQHhbQbd?=
 =?us-ascii?Q?rUFBqARQFl639c1pxMKjfjVp6JbNnjXvycjL+JAUo0gzAFdEnZWFaimlaCWP?=
 =?us-ascii?Q?dg4SQT4SQblcsCUkEnxllLuegvlgJrAXV9cUoEJdCsVmUQgM6YVPqa1XQab2?=
 =?us-ascii?Q?oKSdv0s1bHJs16SNgeavdagfgl2/TpAqcAtJMX2uMajypkUPmIzceOIlE1rj?=
 =?us-ascii?Q?KFxOHmrK1wD1gAQ5sByXG++BpRr2WPmV8slj2xRwDvIi2GIxKdKSWJWLIWNk?=
 =?us-ascii?Q?wdovZrsac2PnV7871+Di0m1A5Sx/QbLjGPCb+YBMTvd+UNT/TjypFvb0Kddn?=
 =?us-ascii?Q?DkUkOFQLutPAeMJcL6vh2mewdf1wUEDIdFdKyBzFBEKm9PZf3Kxk5BjyclDV?=
 =?us-ascii?Q?D7susgEIAE1MoKARBeFOQuDCE5olRNfFdftk5GOoFJU2Vcb1OKx+K3fDFekX?=
 =?us-ascii?Q?8/MlEQsPWrL9jGg5t+2NFJ6TpDx3z2pPm6pPXm6tdAsVzxRbynXR7Racv1m+?=
 =?us-ascii?Q?0d/6IblVeXVi72gM6KZaIMmFInJJ3dBxMUpgqppL7Ugos6AEXm7Sv0c568zQ?=
 =?us-ascii?Q?255HKDsT1nf1O81S1RZAAhPC+gj+Xqy5S2WNfOzor8XbrIcifWYJRXBoqKhx?=
 =?us-ascii?Q?jtEBQVbVFx5evuNSxUbckEpfxyRSXw3tJIeYeA6Rr3Empo3FR3p/oclzfCtc?=
 =?us-ascii?Q?t2bhouRC5YjCK7Xud0vXcWwbHVpS6YfDwY/tbdowIUPXODY2B19CkmeNIYxL?=
 =?us-ascii?Q?0t2jNKX5qFjGqPV/Xa8r7kOqbN8UWJmDVlf7g4zLg6OMX1faiX6jKK71Vp5k?=
 =?us-ascii?Q?/6/na2czezdKa25kpHqwcAIke91yzAaOCNkk7xMxNadiy5MXBgkXgjnTypSS?=
 =?us-ascii?Q?LWE6FNsNyWzMfp0wIqmi8GzgZRx+GXYwuKIJ9argx3/78KMNY1WhfFUG331/?=
 =?us-ascii?Q?65JFE3KGCmVjSrYovSovz6GLZXHSVtowX6OchZUHBQWx0vrCF1JUe/GijkY2?=
 =?us-ascii?Q?BqHx28O+TVmrNlGIj5fJfeHbUYsRT8CGC0926tYPJ8TN69DW1yBsG307TjdI?=
 =?us-ascii?Q?hmetyr7IO5JUUa4KqVMhmx/NaND0g7yTkFQUgI+4SSIObIEJYz2RBHaWorEs?=
 =?us-ascii?Q?0rm5cHiWpvBn2gbm7AfqIWHI8tsOAxRfor1ge3PH83rjc6YA261h+4aW+FN3?=
 =?us-ascii?Q?5GRnv+5OGn2wGMLC17c=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6245831-5e1a-4e1e-4ad8-08ddbd503e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 12:17:29.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLuO3a0bnrNjTc4834PvTQEkIHuDt3J8odX17eX4WD1DKWuJp6lkpvgAU9vnKNzfUDuLoYNgx/2zK3i9YpamDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

[AMD Official Use Only - AMD Internal Distribution Only]

Hi all,

Just a gentle ping on this patch series.

Patch 0001 has received a Reviewed-by from Rob Herring, and I'm waiting for=
 feedback on 0002.
Please let me know if any changes are needed.

Thanks,
Sai Krishna

> -----Original Message-----
> From: Sai Krishna Musham <sai.krishna.musham@amd.com>
> Sent: Thursday, June 26, 2025 11:19 AM
> To: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; mani@kernel=
.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.o=
rg
> Cc: lkp@intel.com; linux-pci@vger.kernel.org; devicetree@vger.kernel.org;=
 linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>; Musham, Sai Krishna
> <sai.krishna.musham@amd.com>
> Subject: [PATCH v4 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP PERS=
T#
>
> Add example usage of reset-gpios for PCIe RP PERST#
>
> Add support for PCIe Root Port PERST# signal handling
>
> Sai Krishna Musham (2):
>   dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe
>     RP PERST#
>   PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
>
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++++
>  drivers/pci/controller/dwc/pcie-amd-mdb.c     | 46 ++++++++++++++++++-
>  2 files changed, 67 insertions(+), 1 deletion(-)
>
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> --
> 2.44.1


