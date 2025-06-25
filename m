Return-Path: <linux-pci+bounces-30572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689EAAE75D3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 06:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E78F3BE489
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 04:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE413D531;
	Wed, 25 Jun 2025 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g1vsUelU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918F4C83;
	Wed, 25 Jun 2025 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750825665; cv=fail; b=MPUKSs0oeizQeob12SiM8S4NZQ7mqxgy2rVxFU2aFLup3empu4y1A/PlGdo3DelFt/82IWKVW3kKFMcjEehq+b1aQy0nbZuuTWxwHN1HX6AQgOh4Qg6zaMF4iFRZePPn4Siw8sUn8QYTMgezRmQ441thQ4T2zyY0jgCT2h30RqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750825665; c=relaxed/simple;
	bh=GsCtyfpC6qqPg3fe5F/Zt3Not+7YrU9q690S1WRwsWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVcq46q5bcX3L/y1cq6cjcWK8ywDwfgDhcsKu/4p5m4MSi283aEfzsjo+xM17X0XFTBEZoZ6mYDsNnEKVza7vxbW67k78E0i8ECs1zyqzRwHr8V0L78De0WE6sKkXtGqagKg3L3sjeF3zcYcGpZkJ4Fh17p7F+dG123lOLtNIF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g1vsUelU; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA+zTjrDYaksi/txQzvaGlxM3jJcHLlN2q8GNi4gKmjbUdAob3OmrYtdrm9wd7Zmrej6FpXi/98Q9ckV+umenFE6OQEpYlAerau5Np3a+UAqU8FfVpio5kETgCGPHUXQI14H3Wl6pyIuOJ1ovLverpFk03NAxN+vAI8Eh3nlG3IY5T3EVfx7AV2tusReqV1JVaVKXTgZG1vJtXgrEvLHTph7AZ9vJ+vpa0S3I1utgXmgi5LIsaPf0pYZQE2V5XMnnA8cQ+wh/xv54I1cyXRJhA4eE284nD+Zhjo78p3q5T13/kuSmHKCegDKmimW1aCB9Nk32RPMZ5U3E7bdvJItOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcGYMswSAlMVmfBapWKRtLFoWdk+qMLcbIXO+P7rlsY=;
 b=Bg6NII19GkrSBmdpvKYauMocz30CYY+GiEdv4E6Uz0S3p5HyAcus3Gxm/GeqCQe4Jrf3kT9V70LCavoWwuPPJPtKZP32NBsm0xflj62ahPtTNN0wbBsNVkqGeFT1VJ5Ep2n8mvjUx6LfiSVAZxHwOxqMpTcP1CTCJt/yfaEfJ2FJ4bPKf8OCLI9Fc3Z7Ivmn+Ml8RGG6msCM/+rUttwfcP0PTY7tFgX6J9sxlxdhNiuXIMpWOJ0NILyGR8AlOoOHggYJgSdVJXUa0HdY8rxp0XUdFaojFTkKnpu84zGICBQetlyhNaLkMu1/tDLc6BuHs7iclDkjMiY1i2dUqdRWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcGYMswSAlMVmfBapWKRtLFoWdk+qMLcbIXO+P7rlsY=;
 b=g1vsUelUeUX3v2IO3Z0xmoVytC/z66ujmuUKxN1zm4HIX49nUxjk2sVFip9Cp2ZFi5YFDyGXJV2UbnY5fOebPT6/BmI3O0BnruNTjmhVpkSqFKwUvooS+m0eeS2GmGrZ++32DYZr2vrsb99Ai8nft996rRth33uaWh6SXzfrpeI=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 25 Jun
 2025 04:27:40 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 04:27:40 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v3 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Topic: [PATCH v3 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Index: AQHb4ChgTLxKLGgzJ0qdVcTUmtrF8rQSgf2AgADNr4A=
Date: Wed, 25 Jun 2025 04:27:40 +0000
Message-ID:
 <DM4PR12MB615857BF931389A86C21E164CD7BA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250618080931.2472366-3-sai.krishna.musham@amd.com>
 <20250624160049.GA1479461@bhelgaas>
In-Reply-To: <20250624160049.GA1479461@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-25T04:16:59.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|CH3PR12MB9729:EE_
x-ms-office365-filtering-correlation-id: d4cc9915-f0b6-4864-5ac0-08ddb3a09f6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lpZqKVuXJrObo20/lcRGkOmcZeNgHUNBWKwE7JIEV7Zr72+dMAHZ5H56t5Xd?=
 =?us-ascii?Q?JdJOCIISp+k/3jBe8kZHEYfSWOB9HGJYATBY51Yu/COz+YDch+fbh3PuRdWA?=
 =?us-ascii?Q?J+8plrJiznI064YYhQxICNbi5QyT1W/4zkE6DV8KHIvU+RXDh+bw/It+FQjG?=
 =?us-ascii?Q?Hd0Dm04yTmRlXm8DivHhJiytLi6gevQLXOWI3dQRkwP5YtwFqlC5Em9pnvb2?=
 =?us-ascii?Q?6yQ0+59DKwGhdT6y4LNg7njxMZecUmtNwNT9hlXOQg1QQLLeV/vf9Njenw7x?=
 =?us-ascii?Q?oKeUUYbymNJ/JoJVjEeo/R7GYAXkdsTUuVQSUo4iUdZPoadxkW8SakdVvtGv?=
 =?us-ascii?Q?Kk3j4//YrJg/iECdXfCd5cmg79xxp10VDOnpZ5AAKJMDYNHDk2BTdhdjH8zM?=
 =?us-ascii?Q?e6tStPUWG/rM4Kvzugjsglskm3oKGBWFoB50nnpNnPOABBfmt2W35m28UKC/?=
 =?us-ascii?Q?0aA1tbSJYDPCzdY0Hvks/QaRXi5Y6SbIBsjA2rfrQlTsKNmPk/CG88AGjp63?=
 =?us-ascii?Q?+YwzStwd1x5MaTMizXcrFVDTPCQj6lHscOW4R/SRAmUsX1gK1NhHquypkHdi?=
 =?us-ascii?Q?iznFFE4v0CTtuH27lEasj3tBCH7OTP9JKPRPWoNIooPVGeUc/yMMQ0YMqbYQ?=
 =?us-ascii?Q?QLJuvAyBfvh30DX6JtyP95pZnVrNgCPz751V3F9HVEN8IBfXRasMq4A9hEEb?=
 =?us-ascii?Q?y/DKXyrYj4jE2ezzxXV+zee94qzy/pjxSK3OSG2CrEDpxXhzfdG01uqErqYe?=
 =?us-ascii?Q?sbVtsUVymjBRmsK1Iwfj2+gC1UH3/pfGBzbGH1aUAe2aqSHiU6BAo/8MteC/?=
 =?us-ascii?Q?ro17sZwaxsaDsWUnUeilKuJh8BMq4kGnA5kg9mx3ZVGIFN95JuEOixzILR9X?=
 =?us-ascii?Q?eP5slSBjJgvZF1Z6dzExGKBfJ/Gb5E18ZZm1QKxuT6s8hiBa3DjHwpsFAadm?=
 =?us-ascii?Q?dvAbzbAjOnpEyOVZLXnW9wog53ytbu1ha/thI/b3TVZDq3312XRu9+xFb+Od?=
 =?us-ascii?Q?6wnNmAM3wqdZYW2bKp9N4hxykd8ZNJcZYxa5LWkfSln5OsPLPJ5wpPpemX8O?=
 =?us-ascii?Q?W4+BLBzRHaRhKYpGHLsExNmSzDiP18vL6R2qPAamgiCaRjQpCPXHlzl42QAM?=
 =?us-ascii?Q?5cVfOLJzRCd2Pm7aVTwAaoyXhyh2doH/ixQ4IOjqi6tk0i/xS9oNNwEdMZ38?=
 =?us-ascii?Q?7AGCvSZbRkY/1XFG6CjPx1IfkNGd7FKwI4ufD4/fBFbpO3dc2v7yIRkqK2Ij?=
 =?us-ascii?Q?IUAZfLmQMAo8lKCfWNuTEMWIbTbk3/bm8ACIfmxpjrEzZ8ctvk8/E4Jn4XC8?=
 =?us-ascii?Q?8pT3+ErZj3jk5P2BVWSgvjxIvF629dX+xcrAXNrcpnGnvmatg4jfxJYgIbZb?=
 =?us-ascii?Q?UM5vtkiBckUCaq0fb0OXpT5YXam3ytsCdx8DSPexjvRZcfwDII66QhQIIn+g?=
 =?us-ascii?Q?NaKCncn+MSwVgfW2CuRpf5zZcmeju9UXAW+jEEZc2ooosEGFe4TWe6Q+b0Uq?=
 =?us-ascii?Q?h9LApDCGa2igFe4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SYF4zLH66U9oytFKi4vCqWqerflimuw6Uso00d/DmVZQNYhFCrhY4vHhCDwV?=
 =?us-ascii?Q?gNUFJC1qHPIgPNm6VmDuHFB3TBy3fvkp4Gxr/TJy/wlS1a2XhkZ4mJmX1iE8?=
 =?us-ascii?Q?recpNgc0O13oV6VczA/uIio6jdr1V7TTXh1pqRp5PuToHq3kqduogzPdKhlU?=
 =?us-ascii?Q?y0Wme8oaz3GfdMHvzxd79SWEyWo+ermqqXpHS9gpD9fvK0B4OZprZxrWY9JS?=
 =?us-ascii?Q?iJZ79mSrePyo1J34LenutqnhN9wBtuOx8LTcyJkCmJjLu/yoMK30j1WOEn68?=
 =?us-ascii?Q?Ap7RQXCbmURZj5RJWPhku1zNLZh7A06F7xQbz07qBHtP5EBsuk1SDz1p4vyR?=
 =?us-ascii?Q?8eK19Sa1FkFzDYbfiFuHfxElTzCU5Ol5TRyo+Liq4saGmQF6KlHzH285NV3l?=
 =?us-ascii?Q?JiMqYC3+DLD1QQ0fcAcbX51MLXX3i14tPWbgMPvJwW0gQTOgHHqnsQciNVaH?=
 =?us-ascii?Q?NaZl4tSiVDJW9lzWZ70Q5LAZSblSKzozSIddz1AwLYZ5tPyChdgSz59gnaLx?=
 =?us-ascii?Q?BgrhR+nWQ7TFWwh1LD4aW6pJjkIHDvRA1satPVvu/DbzpT8rYYXlXEh+qzCg?=
 =?us-ascii?Q?JIZwSAMl03j/ZvrlnB6A+wxJi/VkJr0i1uloX9Jqea9oxd4gDqbCI08eXXhL?=
 =?us-ascii?Q?oaO9eL1+qBNR8sJ4MgVy4mekjtD/YeNkijJK1QSkLPVtP2oyKrONq171Vp0U?=
 =?us-ascii?Q?yGsdsc/uC2AfzbZFIBx3i27HQfKsYp2qIZNwP4dY+EZtdYSI/7C9NLf4uaeV?=
 =?us-ascii?Q?Vymrc64crX9wuLstfVg77vtx9TQbiSHqizJQSS8/oklIS1qBsCDsvbOywVh6?=
 =?us-ascii?Q?ckOluyIJidEcGJRvYF6JoU/qWd8vNCOFSedohzGqdFrRGxD2NJbBXdPIFGy/?=
 =?us-ascii?Q?z+e85Bxk4yntrgMKd27KduL/fH8iJeFL56VsI/tNHJVetczVF3zNJ3MNUdVr?=
 =?us-ascii?Q?CLnkyFeFV3Xc8cAdmm6IUozkI+dU8fF0Foamh+LZqCi0iEGLF3Dsml4sECeL?=
 =?us-ascii?Q?SY1DVICE2ZJhLE970ZybMLnMMaRgffx+2uVUjoVE/6JPbsxD9BZQ+/reUdeL?=
 =?us-ascii?Q?dnRrFP20cYksLCJ4AHj4UdHSW6PgeW8FS3I933+WG7iwPT8AOhH8kzEDmyuP?=
 =?us-ascii?Q?dxuYE10iw2+6uom2+ovMy+SxZ/HArKvxMGjcyali2pngfl9jTW0R9pbCqarn?=
 =?us-ascii?Q?/nN8to4kfh8KgYIvGCspAwrYErCZyKqZBRRLIKfan7IgzztcSXkS3YJt2w+D?=
 =?us-ascii?Q?FD2mKf1duzDRpbXo4r4Vt9Zg/W5ASX7U8QPNIP5h01n3swugqNAvVmQKwdop?=
 =?us-ascii?Q?lAwer2MiuVbS+ONXxM0hnRR6AwKLsCOVRFYZsEP+9PETwDlCPTlmkn005JLy?=
 =?us-ascii?Q?nxBX91N62VCtyVZPQGBqLkSk9GhJyby2QJKkN7Ob6XBjqulGVH50ZskDs1LG?=
 =?us-ascii?Q?1BVRh9BOeKQer/Ic+xr5ANrNmdKu1Jr2AyNS69xJAjAg1MwNMcUCMTGw8Egi?=
 =?us-ascii?Q?yMsr9X2LT7QH6FSKuNwlqGwUiTamFK7kZQoUlCgbwngzkb5HwnVWpgriZOQH?=
 =?us-ascii?Q?mWsNDrOPk2oh5Os0rHE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cc9915-f0b6-4864-5ac0-08ddb3a09f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 04:27:40.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0YqdEGXYQnKFGX0U4VWTtMVGAkM1+Xy2Kr8wXhi27vdwtGHBR/rWoSZ0b29GZBpXjlCAwBeNnyuyq7uPsDWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, June 24, 2025 9:31 PM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; mani@kernel=
.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.o=
rg;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: Re: [PATCH v3 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
> signal handling
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, Jun 18, 2025 at 01:39:31PM +0530, Sai Krishna Musham wrote:
> > Add GPIO based PERST# signal handling for AMD Versal Gen 2 MDB
> > PCIe Root Port.
> >
> > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > ---
> > Changes in v3:
> > - Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpio=
s
> property.
> >
> > Changes in v2:
> > - Change delay to PCIE_T_PVPERL_MS
>
> v3 https://lore.kernel.org/r/20250618080931.2472366-1-
> sai.krishna.musham@amd.com/
> v2 https://lore.kernel.org/r/20250429090046.1512000-1-
> sai.krishna.musham@amd.com/
> v1 https://lore.kernel.org/r/20250326041507.98232-1-
> sai.krishna.musham@amd.com/
>

Sure, I will add the lore links. Thanks

> > ---
> >  drivers/pci/controller/dwc/pcie-amd-mdb.c | 45 ++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > index 4eb2a4e8189d..b4c5b71900a5 100644
> > --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/resource.h>
> >  #include <linux/types.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> >  #define AMD_MDB_TLP_IR_STATUS_MISC           0x4C0
> > @@ -63,6 +64,7 @@ struct amd_mdb_pcie {
> >       void __iomem                    *slcr;
> >       struct irq_domain               *intx_domain;
> >       struct irq_domain               *mdb_domain;
> > +     struct gpio_desc                *perst_gpio;
> >       int                             intx_irq;
> >  };
> >
> > @@ -284,7 +286,7 @@ static int amd_mdb_pcie_init_irq_domains(struct
> amd_mdb_pcie *pcie,
> >       struct device_node *pcie_intc_node;
> >       int err;
> >
> > -     pcie_intc_node =3D of_get_next_child(node, NULL);
> > +     pcie_intc_node =3D of_get_child_by_name(node, "interrupt-controll=
er");
>
> Is this change logically part of the PERST# support?  If not, this
> could be a separate patch.
>

Yes, this change is logically part of the PERST# support patch.

Previously, the interrupt-controller node was the only child under the PCIe=
 node,
so we used of_get_next_child() to retrieve it. With this patch, a new PCIe =
bridge
node has been added as a child node, which could lead to ambiguity or incor=
rect
parsing.

To ensure we explicitly retrieve the correct node and avoid potential issue=
s, I replaced
of_get_next_child() with of_get_child_by_name() to directly access the 'int=
errupt-controller'
node.

> >       if (!pcie_intc_node) {
> >               dev_err(dev, "No PCIe Intc node found\n");
> >               return -ENODEV;
> > @@ -402,6 +404,34 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie
> *pcie,
> >       return 0;
> >  }
> >
> > +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> > +{
> > +     struct device *dev =3D pcie->pci.dev;
> > +     struct device_node *pcie_port_node;
> > +
> > +     pcie_port_node =3D of_get_next_child_with_prefix(dev->of_node, NU=
LL, "pcie");
> > +     if (!pcie_port_node) {
> > +             dev_err(dev, "No PCIe Bridge node found\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Request the GPIO for PCIe reset signal and assert */
> > +     pcie->perst_gpio =3D devm_fwnode_gpiod_get(dev,
> of_fwnode_handle(pcie_port_node),
> > +                                              "reset", GPIOD_OUT_HIGH,=
 NULL);
> > +     if (IS_ERR(pcie->perst_gpio)) {
> > +             if (PTR_ERR(pcie->perst_gpio) !=3D -ENOENT) {
> > +                     of_node_put(pcie_port_node);
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +             }
> > +             pcie->perst_gpio =3D NULL;
> > +     }
> > +
> > +     of_node_put(pcie_port_node);
> > +
> > +     return 0;
> > +}
> > +
> >  static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> >                                struct platform_device *pdev)
> >  {
> > @@ -426,6 +456,14 @@ static int amd_mdb_add_pcie_port(struct
> amd_mdb_pcie *pcie,
> >
> >       pp->ops =3D &amd_mdb_pcie_host_ops;
> >
> > +     if (pcie->perst_gpio) {
> > +             mdelay(PCIE_T_PVPERL_MS);
> > +
> > +             /* Deassert the reset signal */
> > +             gpiod_set_value_cansleep(pcie->perst_gpio, 0);
> > +             mdelay(PCIE_T_RRS_READY_MS);
> > +     }
> > +
> >       err =3D dw_pcie_host_init(pp);
> >       if (err) {
> >               dev_err(dev, "Failed to initialize host, err=3D%d\n", err=
);
> > @@ -444,6 +482,7 @@ static int amd_mdb_pcie_probe(struct platform_devic=
e
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct amd_mdb_pcie *pcie;
> >       struct dw_pcie *pci;
> > +     int ret;
> >
> >       pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> >       if (!pcie)
> > @@ -454,6 +493,10 @@ static int amd_mdb_pcie_probe(struct platform_devi=
ce
> *pdev)
> >
> >       platform_set_drvdata(pdev, pcie);
> >
> > +     ret =3D amd_mdb_parse_pcie_port(pcie);
> > +     if (ret)
> > +             return ret;
> > +
> >       return amd_mdb_add_pcie_port(pcie, pdev);
> >  }
> >
> > --
> > 2.43.0
> >

Thanks,
Sai krishna

