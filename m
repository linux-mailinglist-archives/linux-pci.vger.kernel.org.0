Return-Path: <linux-pci+bounces-11914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFBF959419
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 07:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73C4B2142E
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 05:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9816849A;
	Wed, 21 Aug 2024 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1YDhg97x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994979D1;
	Wed, 21 Aug 2024 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218460; cv=fail; b=feSW4Ei9wjzC5VdtfnLyURf3WalCCU5pQPgV2UG2d3LaeKxexiGgOt70ZVpX7nmLcruSofrlpfPenRpsSjX2Er6bttejuktTs2kYQ7PuWMR+ygvPcj3Zx+ZzStunjj+hKi0Haro/p1T4mX68nN5Oei4Vx6uDsn7RTF7tBIt68II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218460; c=relaxed/simple;
	bh=qyebF4nw36iPXPg+YPvlIU1TKEfbXHQ9WxeTsBdPiXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C1N4OPZvUfu5ICLFqGhVRZzwJu8j3lLJyRFQ7z058VKfhV4mnplmeG9tQefG2SZ5ca/e+xuZyk+5Ld+Ggs3n4geL3a1FnLcMRENXIbUP8F0u5igV3z1ZpFHi463J2bnaOLEHz9q5iUjrrZ2pJzPOWSi9uYBnhX0AfJOTa3axIPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1YDhg97x; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXlAhk0r316y28jptNagV+B9zJNE7281X7Ie/gFnhUxSelIUeqQ+GBnbLu+1f/Pfk9aqrV89szRiw5qKP0vnALnUBZm0c0szTPnRFbtL1MCH2lxEehuXiK+VRKPNDkQZUeVf8OjZroAqY9sdxir1FN7QNZ9Q923LEiYxLoiJSreAU5FEssd57PyR4FNHe5bBOhJcwo/qgfiKeTjVUiv3JneDjmBd2fiCvHCZfyNFVDx+hBaqXTIWilQPMtH4/Wwql4Kw9CXJGspipTOgUfM9fMiTjNzx5ODE0vCTLJowOnMdI6BEezGEEqoRPCoBZB7imM7g9lb4CjSQ0DM4p83MJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VCjjhRYl+cex8qmh/i52ElTNI4p/8K/Bu5NsCPVB+8=;
 b=lyJ7Rx51lBvgQRaRaw9afkRmScUODUq7Lcvss4jRd80Wi+0Rj6/6ZxT4qJCEuRFjeH4UUMppG58mIhWVY2MMFnU1dW+Ck9O/cQsGHhmQAa61xBasO2Zz30424ucK1O7tx3t0uSQpxtzwkqwnc09k0t8vqWQ/HBuApozcqKPM1DDSjhR+uv2mnm1RFujKciKaDbHN6Bv7A5Odc0BRGMIJROpjvOdtT64F3nS25wjrRmooRtmTa8tH2D76K1ZR2B3w6PvdCa+qxKN2yO2Zbeus0HQGNymfVJAcM9dxFnt/DhUXYkPP/lZ21ZUdPAfiS1Ebgwb8eClxrhoSYPx747+r4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VCjjhRYl+cex8qmh/i52ElTNI4p/8K/Bu5NsCPVB+8=;
 b=1YDhg97xpTdFrdGcEg3hKy0szqc/YDk6PEJ7qlD8OiIcPFmOX06hodNvOQU246g5o/hafL+sHb6hdbHakWG3G5dm2TzZKrzG6o0juBL3K9JCmpDYcFgMSrfrtFfzjAN35hi31CX16LL3PyBnR97EyN6lcSOIqSX+7jH63h6bCms=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 05:34:12 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7875.018; Wed, 21 Aug 2024
 05:34:12 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Thread-Topic: [PATCH v4 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port
 driver
Thread-Index: AQHa65WTirLKPezFCEeaPEvmYIB3ZLIxQDKg
Date: Wed, 21 Aug 2024 05:34:11 +0000
Message-ID:
 <SN7PR12MB7201A15E2FB9B8A9E8E6BAA98B8E2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240811022345.1178203-1-thippesw@amd.com>
 <20240811022345.1178203-3-thippesw@amd.com>
In-Reply-To: <20240811022345.1178203-3-thippesw@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH0PR12MB7983:EE_
x-ms-office365-filtering-correlation-id: e0ec9bcb-a9d3-49ff-6540-08dcc1a2e325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vcK4imBM3JAc0XrCmZ4QkVOHmSgQZh9kWlz87fhXksL55IeIKf5m7GlJ1OxF?=
 =?us-ascii?Q?zsChF+nd0Z2y1F5r4SFIstgOdnz2xXeCMUqeNyNqwYo9hTFPZi0/oYiEqG+9?=
 =?us-ascii?Q?iUSCflJtX5ooYqAdaLxfDkXsaE7mvE+bCZnU5j2EYUegexvWC2G7OJSKFibQ?=
 =?us-ascii?Q?0e1yEoHVCfh6r8xp5iGGDnUph/hlTF0JXOxbzR6mg6KLwcA5pxR6U+DNNDdJ?=
 =?us-ascii?Q?vvx9IdmId0MMLdGxu0Y+9SC02zSwHHZNY91wjYdgk/cjh5/0gzI6/5Mhv5QA?=
 =?us-ascii?Q?4AUWdbg7fA6qKRPL0W1G5hkCbLAvSJGp937BpuBsvyevikkCrYAICNOxEuxu?=
 =?us-ascii?Q?2FIPUBFY7Tw3eTkpnXkwnVqdpZ9SWuT5vNrkugxZ0RAqboh7pitkthBNglUt?=
 =?us-ascii?Q?LK5Ali7eG+HPUZv/PzwlCT6E52O+p3KeLgFbg4LJHKHO1K6DTRuEAQ6nhy8p?=
 =?us-ascii?Q?7gaDOHwaGpijKQcqbnmobn9ji8WqkBc/tQmummv1mTWp+aAhKqWBE2K5EGGn?=
 =?us-ascii?Q?+O3FDnKSUfHAW1Woaj69R/1IXfa6IFET8Oip7ajC32cOm2W/fMOxk6JPElEi?=
 =?us-ascii?Q?HD8UC7Ecg79kOyPuN9Fu+cBIP5x6fKzechOpI5Qfb7kxGxdNIo/Pi/7yL6Cy?=
 =?us-ascii?Q?6ovBeQWRmQC4C+SdiKFdlEsduJh7uO8bQ581N5eqonSkGrSFFwUUs+AkTVkL?=
 =?us-ascii?Q?PxmPUmKaNTglyViQ3sutQR/2V9dt+/x+pVNNSqFrSRUnzPsCmj5Xrk8c4WEr?=
 =?us-ascii?Q?9VlTKiZL5fyYfEsIcdoE2FouqPar2k94LFHS6gXLZ2oercJ1R6FIdzIpeQpH?=
 =?us-ascii?Q?gWS8nIuvKWtdssoLyZ/mSmNmLyfsFwHYJyTdbLDiFk1EC5g2vE2hWSRptFwM?=
 =?us-ascii?Q?SwIt6CstlSTBWHdBiXSiPEYxLETjoS2P2MowzMq4sf/9r4A5Ck+tF/IlOGJZ?=
 =?us-ascii?Q?mJT1S/SlCJVWz/KLt/+xdDKKeM852EmTamNpncqnGbkD0wcB/lMTAeHNql/L?=
 =?us-ascii?Q?OPlZ+d0yhb6xcGlXLdJTm5N5ykJlNSUE+/jOGD1NljC0TrCwxfZzOTRdASvZ?=
 =?us-ascii?Q?sHLiwIHce1TrC9Vm+argPElknvRjjDOnu3r2/XuASz6nZn1Iq31HZRxvXaM0?=
 =?us-ascii?Q?iIvA4PMSYYj5IuGXTAaMA50SV192AGWnintV4GcgtyYeTRi90ICCBs4gRUAT?=
 =?us-ascii?Q?O/GCG1fLAdVH6vJ026eAMPopDK6fDYuzz6IXkEjZXsUTgoONF4uW/UZTKiC5?=
 =?us-ascii?Q?SWC6U6zYZ1//K9h82+VwkJEVxwFVyue0OWarX2BzpLtYOKO8+J8GMLk2uuYU?=
 =?us-ascii?Q?UD+6Yd1iInROxr39dCNW94IOwRh0msnHGjWeU/QIfTm2ALfSz30EWZgMX3fa?=
 =?us-ascii?Q?kNfC9eDT6kg/7U6VL2P6solpDH9wmRaqkZA4HTYNgikb+1peBFACrFuft8KP?=
 =?us-ascii?Q?iPNEfMtYgh4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fYiiE/qFfeysQhvHjiF7eUOBGdasy3X9qIKn4fqTatOHPIqHbl2KOYY9Ti7d?=
 =?us-ascii?Q?JytnbWGrIZ/Z6vlVAid9rFtZ7ECUV/L+um7uNg+lBbwfAUv6pjpwprOyZsIg?=
 =?us-ascii?Q?8AkronkelrW8zbLI5e28VDAaHi2j6T/2OhQkulzuf4xVfxJDrdbOenInbEQp?=
 =?us-ascii?Q?whsq6aTqfyaErTtWXOzvDoO0mrCPNUgGyvUxqzNm75aBXJR2BK/7F7BKoADc?=
 =?us-ascii?Q?0xaGknVWUtT5a1+HBmHRomxjpjfghOyZNbN7AoOA/WoeW2LgeGxfZf+kpo2O?=
 =?us-ascii?Q?ZhXRb7XwKei1RHkI1JFjNud/Z9amKPZ/v6LcZ28AJgj6eFChed6Ay8GnJiUz?=
 =?us-ascii?Q?I9lqN8+EpcqJejayBmudNkbAG1qXjN91yJPvEWbrzCKVt4CqCg1ow6JVe0Tq?=
 =?us-ascii?Q?sM1WV+OCHn2NceK9XTWW68JplnOvfXBmCUnC+nMX40LrPJimG7NquXBmPgtu?=
 =?us-ascii?Q?bM9D3MFgNEE4IbE9inAbUMbLOpaDnfVmZLQ1R2ambGr4wNUaQN9dcFqDu04m?=
 =?us-ascii?Q?hrAIBF1HpPdBYTpj+0BBSgpnkbU3F7I/t2T1LwyL72Jqu8HBzhpvZWa7C8rm?=
 =?us-ascii?Q?hQ6jBeF1pZUegcRIP0TAT7g5EBCWLbW1JOZP8yQyLgF0AAa5B/OZLz2RI8nu?=
 =?us-ascii?Q?QALUR6hO+bjARS5wqRdS80dzHFTQ4J9OmX4FCGHe52/CbJdRI0kYnuYhFnAB?=
 =?us-ascii?Q?XGK++5LP0bgzvS0cTWz3ooDDidiuiOTLmeacuD7T2CJkb1P77gl//fZCYFOe?=
 =?us-ascii?Q?Sqs/3CRyUzTKXevWN3kjVQIBmt0TcxOTdx5hZVCa5PVD/SgpHDih2Hpn/ant?=
 =?us-ascii?Q?XvpvVa3Nr20eQTXZEYUfypY1jyvsrR5BPQx7Q5VXHRbKLLTwX9K5CbOiM06j?=
 =?us-ascii?Q?V4gdsCV4Gwlpzzmk7xRafIPN16x9Llt43Cr3iY+Ibyp5VRiGf/PE2ybpv6Gp?=
 =?us-ascii?Q?eIoxp9bISxAemGhLmEemTWVTvMmSm3PX+oG/7ZpSz/Bn95gjOi9oMgFJmO3L?=
 =?us-ascii?Q?/uhTVitiYlHEBBlUq/wu4QZnbID9WtkvwW4PEMfr5DmBs//yfLLvhgK+RW3I?=
 =?us-ascii?Q?L+tYLPry2rmWZkl9gLlhrY+DFxIrYo2jmXrsoz829BmR8HX/2YJjigCinzU8?=
 =?us-ascii?Q?FBbKNdla/M94dG8Vfc+oTbHM0YrLKRfJYdTIGyy9N2etOqtQYbiTwdixRLKY?=
 =?us-ascii?Q?urY3mDAOgoHPjnUFiJQxiLcpixwqeREO8PJ4oj3fvh8/wwtQKqfddjJsTQd4?=
 =?us-ascii?Q?vHL/49CPpd43ayezCAP2nZfevIms0ifFkmlGTnRRSe/IkrMgpEXM1vbZ5zOy?=
 =?us-ascii?Q?VM3BwOjEy2hC7rWA196Z+AvmaB5ql13jiKlOGvgV4uOtppG+ASfsHMpqrOsj?=
 =?us-ascii?Q?VCu8N0ycgWTVTukHHC0qqX8363L9OQEB/D81b0kYIkbbdeeEvR0mJb5M1S0T?=
 =?us-ascii?Q?fj2aqAAoqGUZZeZEmbvWPoR6KZmczKJ+Ym6dMTsyYDsjGkFkhw6SSq/LhSFR?=
 =?us-ascii?Q?cHoKvGjfoErL6Rwtd1iVz0cAKj0xhn1wEKes2RaOtGZJr6S9WgbnTCH/LU3L?=
 =?us-ascii?Q?bEgDEPTtNPo9MmeoeZI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ec9bcb-a9d3-49ff-6540-08dcc1a2e325
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 05:34:11.9297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbA1WraMzeKT4r1i2OEKukL2lsPkFj5mB0J6i3wbTd5X9u8kVQWPmTdHrsARMZj0fyBIW5LznNZnY00wQSTmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

Hi Bjorn,

Can you please update this patch.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Thippeswamy Havalige <thippesw@amd.com>
> Sent: Sunday, August 11, 2024 7:54 AM
> To: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
> kernel@lists.infradead.org; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: [PATCH v4 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port drive=
r
>=20
> Add support for Xilinx QDMA Soft IP core as Root Port.
>=20
> The Versal Prime devices support QDMA soft IP module in programmable
> logic.
>=20
> The integrated QDMA Soft IP block has integrated bridge function that can
> act as PCIe Root Port.
>=20
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> ---
>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 54 ++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> ---
> changes in v4:
> - none
>=20
> changes in v3:
> - Modify macro value to lower case.
> - Change return type based QDMA compatible.
>=20
> changes in v2:
> - Add description for struct pl_dma_pcie
> ---
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index 5be5dfd8398f..1ea6a1d265bb 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -13,6 +13,7 @@
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/of_platform.h>
>=20
>  #include "../pci.h"
>  #include "pcie-xilinx-common.h"
> @@ -71,10 +72,24 @@
>=20
>  /* Phy Status/Control Register definitions */
>  #define XILINX_PCIE_DMA_REG_PSCR_LNKUP	BIT(11)
> +#define QDMA_BRIDGE_BASE_OFF		0xcd8
>=20
>  /* Number of MSI IRQs */
>  #define XILINX_NUM_MSI_IRQS	64
>=20
> +enum xilinx_pl_dma_version {
> +	XDMA,
> +	QDMA,
> +};
> +
> +/**
> + * struct xilinx_pl_dma_variant - PL DMA PCIe variant information
> + * @version: DMA version
> + */
> +struct xilinx_pl_dma_variant {
> +	enum xilinx_pl_dma_version version;
> +};
> +
>  struct xilinx_msi {
>  	struct irq_domain	*msi_domain;
>  	unsigned long		*bitmap;
> @@ -88,6 +103,7 @@ struct xilinx_msi {
>   * struct pl_dma_pcie - PCIe port information
>   * @dev: Device pointer
>   * @reg_base: IO Mapped Register Base
> + * @cfg_base: IO Mapped Configuration Base
>   * @irq: Interrupt number
>   * @cfg: Holds mappings of config space window
>   * @phys_reg_base: Physical address of reg base
> @@ -97,10 +113,12 @@ struct xilinx_msi {
>   * @msi: MSI information
>   * @intx_irq: INTx error interrupt number
>   * @lock: Lock protecting shared register access
> + * @variant: PL DMA PCIe version check pointer
>   */
>  struct pl_dma_pcie {
>  	struct device			*dev;
>  	void __iomem			*reg_base;
> +	void __iomem			*cfg_base;
>  	int				irq;
>  	struct pci_config_window	*cfg;
>  	phys_addr_t			phys_reg_base;
> @@ -110,16 +128,23 @@ struct pl_dma_pcie {
>  	struct xilinx_msi		msi;
>  	int				intx_irq;
>  	raw_spinlock_t			lock;
> +	const struct xilinx_pl_dma_variant   *variant;
>  };
>=20
>  static inline u32 pcie_read(struct pl_dma_pcie *port, u32 reg)
>  {
> +	if (port->variant->version =3D=3D QDMA)
> +		return readl(port->reg_base + reg +
> QDMA_BRIDGE_BASE_OFF);
> +
>  	return readl(port->reg_base + reg);
>  }
>=20
>  static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32 reg=
)
>  {
> -	writel(val, port->reg_base + reg);
> +	if (port->variant->version =3D=3D QDMA)
> +		writel(val, port->reg_base + reg +
> QDMA_BRIDGE_BASE_OFF);
> +	else
> +		writel(val, port->reg_base + reg);
>  }
>=20
>  static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
> @@ -173,6 +198,9 @@ static void __iomem
> *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
>  	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
>  		return NULL;
>=20
> +	if (port->variant->version =3D=3D QDMA)
> +		return port->cfg_base + PCIE_ECAM_OFFSET(bus->number,
> devfn, where);
> +
>  	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn,
> where);
>  }
>=20
> @@ -731,6 +759,15 @@ static int xilinx_pl_dma_pcie_parse_dt(struct
> pl_dma_pcie *port,
>=20
>  	port->reg_base =3D port->cfg->win;
>=20
> +	if (port->variant->version =3D=3D QDMA) {
> +		port->cfg_base =3D port->cfg->win;
> +		res =3D platform_get_resource_byname(pdev,
> IORESOURCE_MEM, "breg");
> +		port->reg_base =3D devm_ioremap_resource(dev, res);
> +		if (IS_ERR(port->reg_base))
> +			return PTR_ERR(port->reg_base);
> +		port->phys_reg_base =3D res->start;
> +	}
> +
>  	err =3D xilinx_request_msi_irq(port);
>  	if (err) {
>  		pci_ecam_free(port->cfg);
> @@ -760,6 +797,8 @@ static int xilinx_pl_dma_pcie_probe(struct
> platform_device *pdev)
>  	if (!bus)
>  		return -ENODEV;
>=20
> +	port->variant =3D of_device_get_match_data(dev);
> +
>  	err =3D xilinx_pl_dma_pcie_parse_dt(port, bus->res);
>  	if (err) {
>  		dev_err(dev, "Parsing DT failed\n");
> @@ -791,9 +830,22 @@ static int xilinx_pl_dma_pcie_probe(struct
> platform_device *pdev)
>  	return err;
>  }
>=20
> +static const struct xilinx_pl_dma_variant xdma_host =3D {
> +	.version =3D XDMA,
> +};
> +
> +static const struct xilinx_pl_dma_variant qdma_host =3D {
> +	.version =3D QDMA,
> +};
> +
>  static const struct of_device_id xilinx_pl_dma_pcie_of_match[] =3D {
>  	{
>  		.compatible =3D "xlnx,xdma-host-3.00",
> +		.data =3D &xdma_host,
> +	},
> +	{
> +		.compatible =3D "xlnx,qdma-host-3.00",
> +		.data =3D &qdma_host,
>  	},
>  	{}
>  };
> --
> 2.34.1


