Return-Path: <linux-pci+bounces-36149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8647B57B29
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88954167584
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2063090EC;
	Mon, 15 Sep 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j6ABT3xB"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2D302CA4;
	Mon, 15 Sep 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939725; cv=fail; b=iThlJRficAXw2FaLEKFUiPtmCmKtmrpcLDUzuLI1Jtj3iXSkCtitv68BWq30xKj4yehlXXBiyLJSMwvmw4ZKq43v3+lPBd09gx/NeG5JKN8OwRwGOEHQFUMcw3rJhNgyxZ7YPYalAk/WIOEoCcKdsmqWDmz1cXsymvGLuktdlTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939725; c=relaxed/simple;
	bh=mRyvjBN0VQXetX8UHOPdc/l8fQL4GIKNfTvf41Qvq7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W8SuFAipulZxOKzIRKQUuYTjRJGKB+Rn/DueezTl91Mf9f0gtToEwD3cAtqDolxyqvuyzaxuE5ur8XTzT8WLv8HQi7u8OD2wQi7IJxBihM4nLSRW1er3ywuqc1iUe5OlvLVUArYiSCkTYzxVjx2bbcmtOH8xR72mn+9cjYx7szY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j6ABT3xB; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYY/OuchPJXSJ2CTP80xoV/axVMnv3m1d9wmYd1/T+AooPrVsv/251Acp98ede+j+9/N6XW+dtgUF2AGiTKGqWRLS1afgA7Ksp5WI1xV2Hmsae+r0jHZqhl+OBC6Yscl1EcUdityG5XSSqiVA22kphp+HMrjkIRCkRqejFYtmoq5jj2BAmIobcTV0AblwQK3hJoNqLv8Gq0l5HXJe4e2nP8ZpWRakqKckk6kRP0duPBTSRZ111QCwUPHAFN0tVkVeuD7N+aSQyPYNSKxGflRxAf968Q6gkN3LPiZ82qGwYHWFK/qUP8DOQB01Bg7MAUyV/EELp2PUrLWty8iQxHafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klqifleBECQUdCDdn7Emy4+VfUUVcqIR/du2xfFhkYs=;
 b=trSJeVEHPXv208gr5INwLw7mgz3mVG1jCxTVT9fW+r8DPNiFoXyjUCAs79/00ErNIhyGYUpHJhUrxe7Liy0pncS2Xc9g5gWF5KDweTXVT2mFhTJg1uSSMaleRYzBu55NkNm+/yV5JjH5huEPpeXvVZEGPrgM5UMTox719lre3hGovbdfDoIvZ7dM3ZGTJ+iSmI10rfzaVIxvpmcddLEWogO47k0NAFBSjzZDUgjXl6ZhlZvkhKZ2r13uHIkMr/QRPYV2EOPKr17Om2GwLn7peEZZIdb7s1/sZcy8kRltWgJwrhUQqgIX5V4IwYJNCIJK6Py/Tm0BVvnZ41mqBczQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klqifleBECQUdCDdn7Emy4+VfUUVcqIR/du2xfFhkYs=;
 b=j6ABT3xByWSP6qwb7p3/3fif5TU84jolq/vhH7m0hIKjTsaHiW7DEFx+xQ8tke1Jbpb+55maMjcXPz8IJDSRxtwv3jR83yckzzPeMRU48V/vzNrui+YgMleQG2WsjOb1PuS5NkdKt8+y7hPR58iDwDnw3dtf7dZiHvH1Gnu9SOSv3nbWgAi3b9e2zvxoyNvm1A03Ne5IJqp9nJBd1CnSS8p5ksU2xNdNXUR7Ae9pV1ftw41Yc8n8PmkVGXRgyItBiddxyzel5nSCs0mUa6DmUR7TAxW8ZkhDfGqUFTt1BpXz+nIg9t8TvKz7R8D/hVcGIfWZupQzikl/b5R0zZy8DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:35:17 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:35:17 +0000
Date: Mon, 15 Sep 2025 09:35:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"krzk@kernel.org" <krzk@kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"alex@ghiti.fr" <alex@ghiti.fr>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
	"orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
	"wens@csie.org" <wens@csie.org>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"cwabbott0@gmail.com" <cwabbott0@gmail.com>,
	"quic_pbrahma@quicinc.com" <quic_pbrahma@quicinc.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v4 1/7] iommu/arm-smmu-v3: Add release_domain to attach
 prior to release_dev()
Message-ID: <20250915123515.GE1024672@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:208:32d::35) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ae7865-3ecf-4acf-1a0d-08ddf45453aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIo7fnoZItfogrWaHjNp2GIyUSiu0Cka5c8NEISfZeg2Wtb1ilEvhZHuieob?=
 =?us-ascii?Q?XPTboQpMILa3ho8Y9a0qzNwJpFM/8MLJtjEL4gNIX8SsrgumlreyUR1jONam?=
 =?us-ascii?Q?RXgS/0cQSowfJLwzFMHrZRqxwuXRraLkkj7AP51qBuGSzIuQYnVnLEgcQNbe?=
 =?us-ascii?Q?pwz+pzY6lEC0uuvFSrY+ly8S9Y3Rd6l/Y84uy76MLp2XyJhFYiYr8mUU55Ni?=
 =?us-ascii?Q?9LTDbsyeS5I17fbu0fnfhRdmi6YkcukM+NbcwYKlYu8L6xkyALHH9y2sk/4E?=
 =?us-ascii?Q?ioIG9ATyG1v+x6pdFkF9Jffuz6JEIp26Vv5GXpI/HbAKR8vR4Ysmrta2KPc0?=
 =?us-ascii?Q?Mid2pErBYYta/ZfLXSbArU3mDISuqCBtRfBsfBklCRbh/zDDJ/36L5UacM9R?=
 =?us-ascii?Q?Dyvh5ZAIFxB8g8ehkrcj3FJ7wXSWH/AmAjEwDQQp+6N+826vpF/DfqsdUkhN?=
 =?us-ascii?Q?groUf2SlfzYVKvMcOlFhzOT5jswnCW1d9KNM9Q8Tj2HXqPWwA1fiy2fu2hk4?=
 =?us-ascii?Q?XnXFn8t8461Dtp4U4n01Vg16yEsbMIt4+HNbeqhuo3BYrYef99MAWR8cyw6m?=
 =?us-ascii?Q?Njv2fEGUuaKlnb9vO0f/NqeRrWO0/5DrEQduIi+4ei5nWCLPc6T5NtmtK7+I?=
 =?us-ascii?Q?bH7BaV9bv6qIb3LKoOEUByejTwODK4qQ2dp2ghUhQyS2uq79em0cM/shzZLZ?=
 =?us-ascii?Q?/HG2KoWyqpzy2VdgbIgBUduI7mFCaquikN86gQAf//kMEd6m8KBqVM0AWPY6?=
 =?us-ascii?Q?qKdn+bVxBSccnzcblDAaTxkjzwyWizGrRNG2+oYYoROVpozfjDuabVwrAzyX?=
 =?us-ascii?Q?V1yPUs7POx4RA88Zo9NM6lZDGTdKHAHpNgGRJSCQj7nbBvN26r9wnF/OkVWv?=
 =?us-ascii?Q?Bc1X/sX5dQU8tuWHQzvo/cEa7m3+i4GubXyF9lp4GLffSTjQ2EWF/TXv0rXZ?=
 =?us-ascii?Q?kU8E24hatP8UskrFFg3/cfvXxGzVifkUEI+wv4Ppa/ZE5Cf/3sM5Ie8ffa9N?=
 =?us-ascii?Q?wnd1f3OaOU/ZByWJVmDkVUs+2WIFXwmmtKYtr9ugIM8WZBFOZxY+ELGWsXPh?=
 =?us-ascii?Q?Ee0BIM1ui7rt6FeNDEyW6X3LOSBfB4PQaFAfjFVx2CCxPxBhXANiZa/m/5/c?=
 =?us-ascii?Q?D8I86+zz8Xw6FzS3mlp0/WQdUU36IwyxJGs4pHOSewUls5Dx5Q5x92t8j7Ix?=
 =?us-ascii?Q?WPeCGxQyXdN0KEETb0+wXvNlmIrqqanZgP5pDE0ai/jtHTUldHLnnlz2fyHM?=
 =?us-ascii?Q?O2opC6hU2kpDMilQp7WBdfLksZiPtgHyzDO+O8mKKvfAWtfJlUXEi0eNuk3w?=
 =?us-ascii?Q?9cBlfZBiBzykg2DcKNc/vW6KqRKAmZCBWM6JPM9FiKC6TZ7eQE3O396BYw2C?=
 =?us-ascii?Q?ZotklMpcFN5z6ZTGgZzXZJPRWnVOM1ncVm+N4AOKpySrmLAmFJRKjimK1GYs?=
 =?us-ascii?Q?N9MmALdmdl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ekRfxFbavvkLPSAreurQzKDp1Wt7p9PGgNmmAlPq5gZVSplLawFesccSh0C?=
 =?us-ascii?Q?d20Fl5dMxJfJkHbw+goEuQO+GOutWCSG69fddGEnjQbhKH4W2KXxE+Oeub2C?=
 =?us-ascii?Q?gcOH6JCvevduRIepVJy1Qs8gUNMUIgIB9aqDqkh6uzoNI5gVAhXi7vE0OwYe?=
 =?us-ascii?Q?v7bAUuooMazYKo3OsqHFV8xLn5XvOX2iFdv/V6u63zof7yLcOwPfi5N3KkBq?=
 =?us-ascii?Q?yXzUsZcOe8AN5NdIqff+bgv/zlYFMy2hDz4OqEScDaLvUS3X8LJKo/wNlYRv?=
 =?us-ascii?Q?SlgYoJ978lqubDaqVimKBJ+oPf1srHpa8ckU5dmOaqKETBRHRUJ4xwQO+hoX?=
 =?us-ascii?Q?RO+ByhXT3O/CiUVCeSwWqrUtfcGVZ/qRVm08D1Dts7ootG45W2ZsP5TKIK4n?=
 =?us-ascii?Q?ZojUhZm7MJh4PeUe6ndKzyhu6l11zw2XHxoWKLa5HYe4vSu7KLAmKq4oeNZP?=
 =?us-ascii?Q?0fFwqvq1jtnsfEFPyDyor/uOwceEPzi4cvX/As6bavfuKy9+exNIpQG1Pjub?=
 =?us-ascii?Q?8a4sUoiF1i1ZIfiP4RCDpiA3kWGDvGWN1OxoXIfbvsoS62mzNs/LHwf5Lbsy?=
 =?us-ascii?Q?Pp+qxvghJdkHpIZUR0fwoByrJClMRsisWFq/zA441vxOFHE4s4nUQsJh2r1/?=
 =?us-ascii?Q?aozDozYzBpUmjf7QD2SggfprIEvfjFgMDrAfWAOtTS4hQZDPr0JNRU4elyTR?=
 =?us-ascii?Q?fflQowuEk7/IyTWJP11wjy1x2t5+26LVZNeMUEEeDipTdZXB7E7kWtzasQuk?=
 =?us-ascii?Q?tUiSxWE0phCbf+xHnnykRSFe7cKHCAcODwoBTi/Zh4232P9/KAOLPgbmnza9?=
 =?us-ascii?Q?gV4cVFuGQ8zfwqCMJ9RXssplzckXPT5rmS3HaJI8vZ1CZDjD4k/T6jbch26M?=
 =?us-ascii?Q?Xz1uUoZGGNvr5I405ltNBTIy2jeV2AwpSfTP82scZ1g7DC8y1gpmp4V/yv1Q?=
 =?us-ascii?Q?++u++7/KsVAPzif0c7YN1oTbXT3AdfdT3Mr0rhSG7iUg11bsaXZbJ/I1y2Jp?=
 =?us-ascii?Q?jK4L4rvB8qS6R7D2E4iFWjFGU3os7bWhW6HGPi10tagJhVh5ucofC0jlisUe?=
 =?us-ascii?Q?VNQHMr0e4hPkBufrzGv/1ZmJhdmEJgCPKEH4IMz6miWi/Yw+fcmtOxLS5eo1?=
 =?us-ascii?Q?kT6JW9H6INwZA7KuJ40vazRRMvbbb2Vvu63Vq2Y+RGK8ZrNyJF1yIZrEj3ra?=
 =?us-ascii?Q?24+TIlSlY2BtEpInhtFjxKJCKabDxCHnSPZTQ1ZnerUZ2TlPGIGLVOL20n4j?=
 =?us-ascii?Q?ysgqHTVz+MSumM9rmYfinvthC6P8bK8UXg/Rpjq4BKu1V8sJPYZ3QruUk8aG?=
 =?us-ascii?Q?HGw8qTRAD9EcZysOnU9o9AlJPO6WB0IhBASJijGEIzHJieXRfCGXtWWoqqwW?=
 =?us-ascii?Q?hNhP7c68hCl9iR2CB+Sx8dLXwrJWboKNk/thFy4Vhq5uZ5Gfp05taP78rXvG?=
 =?us-ascii?Q?wp0YZDaM3Wfnz9/uL+CXk2OYNcxs59VtKteFTvnfRvrri+nKeNflvFtAcMs3?=
 =?us-ascii?Q?AT+sYS0ceW3YtfpanaHj376yxzhG8BP/k6eIiEfsbq1LJxyhl9Upoq/y3wfi?=
 =?us-ascii?Q?z2gO91KVfWy4fpeetZ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ae7865-3ecf-4acf-1a0d-08ddf45453aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:35:17.7026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcGCWApM/RV7KXsd84AZB1/pvXMIkooDcYjSudZW4ZszAhLNoDLAng9NYtHb5W/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660

On Fri, Sep 12, 2025 at 09:33:06AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, September 1, 2025 7:32 AM
> > 
> > +static int arm_smmu_attach_dev_release(struct iommu_domain *domain,
> > +				       struct device *dev)
> > +{
> > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +
> > +	WARN_ON(master->iopf_refcount);

This doesn't look right anymore..

Now that iopf is managed automatically it technically doesn't go to
zero until the attaches below:

> > +
> > +	/* Put the STE back to what arm_smmu_init_strtab() sets */
> > +	if (dev->iommu->require_direct)
> > +
> > 	arm_smmu_attach_dev_identity(&arm_smmu_identity_domain,
> > dev);
> > +	else
> > +
> > 	arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain,
> > dev);

And I'd argue the attaches internally should have the assertion. If no
pasids and blocked/identity the iopf == 0.

> it's a bit confusing that a BLOCKED domain type could turn to the
> identity mode, though this movement doesn't change the original
> behavior.

That isn't what is happening here..

If dev->iommu->require_direct is set we prevent attaching BLOCKING
domains entirely:

	if (dev->iommu->require_direct &&
	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
	     new_domain == group->blocking_domain)) {
		dev_warn(dev,
			 "Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
		return -EINVAL;
	}

So in most sane cases the above will never convert BLOCKING to
IDENTITY. What it is doing is preserving the RMRs...

Also, I don't think this should be in the smmu driver, every driver
should have this same logic, it is part of the definition of RMR
Let's put it in the core code:

	if (!dev->iommu->attach_deferred && ops->release_domain) {
		struct iommu_domain *release_domain = ops->release_domain;

		/*
		 * If the device requires direct mappings then it should not 
		 * be parked on a BLOCKED domain during release as that would
		 * break the direct mappings.
		 */
		if (dev->iommu->require_direct && ops->identity_domain &&
		    release_domain == ops->blocked_domain)
			release_domain = ops->identity_domain;

		release_domain->ops->attach_dev(release_domain, dev);
	}

Jason

