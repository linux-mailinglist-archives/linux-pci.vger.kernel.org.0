Return-Path: <linux-pci+bounces-34457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A0B2F9C4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 434FF4E6142
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D25327781;
	Thu, 21 Aug 2025 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jnP5BR4A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C08326D5B;
	Thu, 21 Aug 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782072; cv=fail; b=fTlMqTJgvzj2Q6++tDARHq+PmUoU3YoZSGqioSZmm9Jel1Jky+L0D6ANrRZMLDRWPiCXaflA+Z5gdetaXQC1FNz3uCDX5lMxblUsZMoSGyA7iSMgLjVjGQCu/CwiNpFZEZdMXzD5HO3iktALPZsGyh/D9ySTp372wG05Xy60xVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782072; c=relaxed/simple;
	bh=O6x4s0MUeScv8ws459IlZxC4vhf49fP6a34HXQyojW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cs4p5+17CXAST+x3uw9TqnMAlXVzKM+JRplVGUZdQVKBQmpyJvCdcfJTYn2SRjDmeCvrohg80EAXhvCjfTk4L+TBwu2Y/RHT1zyIIgfcbCAot2y+87suS5H2gDI3mtsKsjfMM+1fzlGS9UmmpxumXPGzmTiAnC/ByO9VgfKK+2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jnP5BR4A; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWWJ8zCgzvR02PPcWAPxJSgQv0A/s5pKemJV1SfouKAUs1KKVqlt/RfyMTtv1MZVlzp5ZkL5hNW0ZRw25aEayq6GiwB2WIXWYDVXm3TKOQKSEjQOvTwGf5gM3s/adeHEKrz8VNPhcVUtdkCYZHlMLDK2MP45jPlGfREDKGQsm7pcGejpUt8qvtP8smbpkWCvkg93mmo9ak7+kG0nJ8fzX/OAX3fXtwyYsXF7Mzn/m6mTgc/9Um0qFrErgFfjEIvhRYvaPeZc5qEJPpx+3pyYgF1oxqewolYS00mAuwlWYIOfVDWxMLurQFUC/Pna12IYBY9OYTUvYPsWYJLF8+w1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWmxKREeqYaPO8e5g6X3Vuo8X/Z2iY7da+RT/6VWdyI=;
 b=QG+FAFadxksJ324wMKQ03ST+MX56npcwyr38gmnddK7OOiADNo3h0s6KzH7JYyNQrzKikItx2noqNyWZYQvOArOtzWUfAy4XGeFJ+MD+fo7MDzFVoRwbQasmomyN6Vm+m0hoE3G4lIXja6HugWf2G8PUypaCt1VebOIPvzTQL8MexUU63lOJUPCx47CBgQbOPaaQIAsxdkvM5Vgf+AQgUlTbJdc+zyijfBW46Fas3sP1FFPTVARifIAQa47ojzm2L7AHTdnrYRVruImEg5jApo4yFkbob3JWkDBjr8mi34SZCUGQQCKCkw3GP4blNIO6kk2TPOqRV6JsgCkqzb1MaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWmxKREeqYaPO8e5g6X3Vuo8X/Z2iY7da+RT/6VWdyI=;
 b=jnP5BR4ATYb4Ecbv6RIYH6mI5RViBjxJcfo4Jb+BQhXrb56eiQ9CCKsxJ3nwF7PiBirBRUiJqeNMb/fvPye8Yh3h4aEA1xExz0ooNoVT5RasDEzBLL0rjSIWMUtiNRgo6TZD+7EZeWoh8UZRNwN0sCr7x8x2/aSnzCnydFSwUAfXTETrQ6jgjl+oCtSzKlaVQoBVaXmInegrrbtZlRNYIJU2cf7Pz/eZVl///pWWbRAEqtGCvYvl8jXXWLSaX68NazRW4Wx64TZVPt9fEm+BjP58+rxYne8nmWEulf4Lqx1sTkBQj8upfVE7ps7uoFTGlCUvIbHH/KkdtsDdG+fJqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:14:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 13:14:28 +0000
Date: Thu, 21 Aug 2025 10:14:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250821131426.GN802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <BN9PR11MB5276262E1925E2CD8AE037EF8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276262E1925E2CD8AE037EF8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 7586e769-fa89-4679-d82b-08dde0b4a8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQK9EuFKO3OIR4SqcDJWJABVv4ZZXtV+EeBqOJoVgfCcnXaxgT5tU1HmCSAA?=
 =?us-ascii?Q?Tdr/GNYtlaeTJF05raSBd2Oyp2ObfKb2QqhJ0EPp65qxhQOp3mREx2G4bRIw?=
 =?us-ascii?Q?zqJClE3bSkaFHvD0jKC2x9LnTAuBirnZdbVTEXG76v20anzC8/GT7/uObt1T?=
 =?us-ascii?Q?8mnKfSxiBFT4c8YRe0kI59k4nWYuGe4en0WLbrOlgSRlnHw4Kt8jhL8GdkBr?=
 =?us-ascii?Q?AHfgIcG+O+CETIWs2QzQno6OL4hYcbRa7aBrrqV98FyGbsv8tiSEq4C9yiNx?=
 =?us-ascii?Q?iSenvTMnQ3G7YMmw+HF2uuBUq1sdS/yG8cGLt3/f4UEdh17V9MhPet3RJ1vl?=
 =?us-ascii?Q?osl6yK4zOaJVCgwDvmykBtltQFhAgyIpbFz7FAFtwUW53z4yiocjYdb8BWsU?=
 =?us-ascii?Q?fys5PrZw1fxmeFMGonb7IbqQ/6PVGLftkUwr8XSi+0EvdXEBcARaMKKtQrhZ?=
 =?us-ascii?Q?huMrcFc4sQTdcMR+GuvBBddk5NgHdcZDS5oLol0tbUdMbxnwX5o/AA86fwe/?=
 =?us-ascii?Q?NixKY4oafBNJUADtRGW68cgm0DSD7io/B7OyC0Nd9d3jnkjp9rB9guLw6iSu?=
 =?us-ascii?Q?7DV3/EBmK1X0K9b4EfNZx+dHBD2AyfiOtRzIbLlu0IXmZ6f5fJ7CmMp8JRvf?=
 =?us-ascii?Q?Ar4WUq0y5gqUpLkIoHmswWZZjDRwD/UPPr8x+LLTlSzX6qPsIxlIrlH7aYRx?=
 =?us-ascii?Q?12lllVRsgRhU5VUic+WIZoKVM9fWkVETQ9oCiVBq+ZRl/mxXdaRJ38zTDpWS?=
 =?us-ascii?Q?2ekUy8NAOWLm+edIzG9gRrFk90QxpVnC5blEj1FhnTvoyR5uExcWtLoNFBBT?=
 =?us-ascii?Q?QtTXOYx+KhzsrZFwPVtcXLxFwElDq92d+C3b/RB44EiBdQvqzm8gmaaAqWcR?=
 =?us-ascii?Q?OKe6y4Ea+gJ2NgEPAwuhclxczeDy690dNpq0jXS83YH8mRPh3ccXcwZEiUNM?=
 =?us-ascii?Q?XUpychy18UtfOdmKISCP/8WvqrfqdzYdHpIvda1YP7QXYQiveG0009nxL3ln?=
 =?us-ascii?Q?y4rhvBO5R7ILOQisv0Rjf5Eiv+DKKyXO6R+pv1pGGEfY18lYIBX++tKbvaOe?=
 =?us-ascii?Q?ggjvJVN0oGERKMx6cshceMQ655WFlADproxW4WIX/zZa60+saOkwaWtZ3xJc?=
 =?us-ascii?Q?IDcRwSusDY+qnuCFuTiSBTJqyng1iWBHgT2TDtXei0jKb3uOo/pr6/hOC9Q3?=
 =?us-ascii?Q?zUQIB3JZgaZPxEcQHEP4JwVrxrLB8BL/JsQ8hTexE1HRDfC+LOxusXaIIy9u?=
 =?us-ascii?Q?JKg3PuTIr0jvvsFFHchrWbj8jGCeY5yFpJwTBbkq1OfRUVNRIgVuprjv74nb?=
 =?us-ascii?Q?nmRPF8WNMxInJaoLPfzvC8FHMkdYM2Ii70uuMiEDyRpK2Yu7fq8WppWHtbfN?=
 =?us-ascii?Q?QU7azf4+49IUBVPxGLdOwJ4fAldxYWSsW/WLuLKn6MFwyy7ZS0GV7o99VYf+?=
 =?us-ascii?Q?sPksM/T3g9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEk4HxLRbptnwtCUoQWzZuZllbCKR7OeQ/S8v6uhznfkWO5CTuNeHzLpBNUg?=
 =?us-ascii?Q?gYvfKZQty0a4VGc5mb7zvV1P2z7DY9o9pf9CuFLFsnG3tycsOWhgLkQUnx/Y?=
 =?us-ascii?Q?26brOPN2u43DL9urTt3TFsdHD+L0CjYrRiOhkWyBykh3qYjLcID6/aRlCvGt?=
 =?us-ascii?Q?IBIEROLN98hl6stuPbPXwPqsI2G+4ZKH8K6CAvnH4T2moCxyq90dwdZay5yo?=
 =?us-ascii?Q?VKzZasLErxQje/kErqi717upCI670AbiBroZ/0sZND3e0PbDU3LEQX/WaSnL?=
 =?us-ascii?Q?iD96cojCYJD2KYkaHYz8+0kBcCWJJ1D7h2LDzerlf5p0Xz9IPHFTbklJuBg5?=
 =?us-ascii?Q?rqNpHMXg3qwipN6dFAd/gaNu5vZADjtVcxddUFtgBtLV/pzBi0/FGXUMZj6a?=
 =?us-ascii?Q?0JSYzowG8j06heff2YhoG6XJ96aO4iYlV2DluW2xdkQIg1hgMFf75G1ZJsHI?=
 =?us-ascii?Q?nxLWxtL4ONey/eBblsGvUpPlg5hhclhJVceQp+KUC5qVO6T1My5wUF715m81?=
 =?us-ascii?Q?xQ9jTsQZ46CALG/jHAG7zq4ocQJvG07Xd8RxUgx+mdzJ/mb7QEsTigMVc9MM?=
 =?us-ascii?Q?NXDnTyaV7OE5k30SAI3V9ZsVqc6fq0exm3t10fDOjYFp9QE3vIe9KzIZwel2?=
 =?us-ascii?Q?2nJC8rnTEbsITqAAYgnFkAMlzTt9CIYyMdLQQTmP5PbYcKZtWyrLvDyLboS8?=
 =?us-ascii?Q?T3bclXEo4q4XbmzFcMnNOV1xR6GCatoEQLVLU4v0hRuaKkpJNYGOcLA47h2l?=
 =?us-ascii?Q?tYhQ3wXDeNlTUmD0pVCMGQaAWu1jdsnD+0grEBszg9j2xc7mpnhrYToj/Fw9?=
 =?us-ascii?Q?uuAgTa4kI9fO+IHDrQLbyIl6IL1F/x+QehKjPOE0rFkh36mALrsWEvYLcwl7?=
 =?us-ascii?Q?At8Xe1B0gyGu0+2qrqxQ6EhV0hr0bCkUzTzVjjQIBDgPFi0GiPWzqdOPbpe2?=
 =?us-ascii?Q?1344PBYH2v3tmEmNg7m9FKu2Y1i4Pni4C0DbaE7EJvNLa5+kNsn8An4eS5Ac?=
 =?us-ascii?Q?d75i8uK2MtYji0G0tkoT//tmGvWN6PHHjT6JF3RA6hhiVy3Lem8JR3DEvKTr?=
 =?us-ascii?Q?5YmpAqBLc+pC43YbfkGZ6PIj939JioFfUeEx67BhZr3Q3l+MKYyMCTGuWItT?=
 =?us-ascii?Q?d4I9Ymy3qzUJRWo98oo0Dfdy1KXwR46DTYUQo/A9VjVWGTb7S81Tabk1AKR/?=
 =?us-ascii?Q?XKgVXbHefJpCcNNDhP7zf74QqppLF+2T0lF67vBvOCP2tqop29JeiHIcq7ve?=
 =?us-ascii?Q?F2GrTL1wb/l/DW7O6lTbS62pxP8VODLCSlaBz7JyK1/P75YSYB1YbAKQi7o7?=
 =?us-ascii?Q?bx+J/z6yaYGLAwDM4xFsyAAYcuUBZ3hVlAn+r/d7sV4gCzHf//Y9oeC1QXAC?=
 =?us-ascii?Q?75duQ0gVRhEBZoYBG+/Y77TaPxr09ivv1XfPCtla6sCGrN3pJDDHNrkvYVjK?=
 =?us-ascii?Q?d4Brzo0+PIbratx6/ZIl0Bt4Ip8iUgrK0Mcs/nRszddzJvmxRziEzt8C79MR?=
 =?us-ascii?Q?DDP0ZkyyKEkw0CJzqFg7kd2ZAl3LEvDzFvELNgWXRupgJMjsr+V9HY9ml1VB?=
 =?us-ascii?Q?5cDq4hGYs2Xg/tGJRzZ9/2tsvOtZ6BtBtMdM1ktd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7586e769-fa89-4679-d82b-08dde0b4a8b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:14:28.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry1vLIgrHg8gI1TPHDTe3ek5U0fecfUB8LUfOzre+HJgaZCyFglWE5srh9iYDau6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072

On Thu, Aug 21, 2025 at 08:11:05AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, August 19, 2025 1:23 AM
> > 
> > ... I found that in SMMUv3 driver, iommu_get_domain_for_dev() is
> > used to get the RID domain for an SVA domain:
> >     arm_smmu_set_pasid()
> >     arm_smmu_blocking_set_dev_pasid()
> > 
> > These two are already given an "old" (SVA) domain pointer, FWIW.
> > 
> > So, we may change to passing in the old domain as you suggested,
> > yet we still have to fix the iommu_get_domain_for_dev() in order
> > to reflect the RID domain correctly for the driver that calls it
> > (or even potentially) in some group->mutex locked context where
> > the RID domain might not be naturally passed in.
> > 
> 
> Out of curiosity.
> 
> arm_smmu_blocking_set_dev_pasid()
> 
> 	/*                              
> 	 * When the last user of the CD table goes away downgrade the STE back
> 	 * to a non-cd_table one.
> 	 */
> 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
> 		struct iommu_domain *sid_domain =
> 			iommu_get_domain_for_dev(master->dev);
> 
> 		if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> 		   sid_domain->type == IOMMU_DOMAIN_BLOCKED)
> 			sid_domain->ops->attach_dev(sid_domain, dev); 
> 	}
> 
> why cannot downgrade apply to the case where the RID is attached to
> a DMA domain?

If the RID is a PAGING domain then it must be a S1 paging domain and there is
no downgrade possible.

It is impossible for the RID to be a S2 paging domain while ssids are
in use.

Jason

