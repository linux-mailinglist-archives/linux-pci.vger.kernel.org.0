Return-Path: <linux-pci+bounces-36549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 087FFB8BA00
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 01:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50A91C216C2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 23:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9A2D660D;
	Fri, 19 Sep 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5nDeVFS"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CB2D6417;
	Fri, 19 Sep 2025 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323719; cv=fail; b=o8/coqwX146XZXGbl1n8L3IW5L0ty5dMJjl63pZg/RvGuOlTbUDGYip1CpFv2iZtKbti8JOLVRnwHlPdEiq5pcNjeznI8vtQBXvDk7u6/i62V+XDhVun44mUiDwjJPHGoqxfpmrhMOlPIWxiR0E8crWtWs37R4YV+mw/7W1khjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323719; c=relaxed/simple;
	bh=wcqjjk6lozDghnN+UvGHfG8MoN3H3NJkbdPet8xqZbY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENOZFFwIIIxiDAceB5pCSF7UkSBBhAhRmxetTHxrHIFt+GxQVfr0txWeNS+49vIaDFjfi8St9qN23JFcw5C0Z6n0UZLQI4LZqRewvoaqFtabdk0p49aWuipkLja6ukQY+NHMWcQZj3FnVXSy60VmYlk4X69o3OM1+BCHYTfWoRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5nDeVFS; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVLxc6Tmdiw/FvVnwMrbXK3FEdg1e7PeHwUpip7vV7kUGHgmidCEUfSMmU2z9V+yH3gTzWLI8MV4ZppCEykhYA17hIeG+Ow4lahiOXq/8Hh1IBcy8nV8q4Ldy3v2/uSF1A1gV/+5jaYCtN0H+VRYeorikj+pg3ELFvMh3sQEYQYDBncH3StZS5qbcbty23z/7Q2j4p2aJ6vIxJ++Nzz5Kkm4YwcYLKKH5VMqcNZ6PT8XV6qN4dIgO5Sd/CattsO7Er5LBbZ/LPlNxry2D8W7RIjxLrlcfBIwOf5uIQsBHXI9GTQ9NN/dZa7rPeiuMM0dk+PNZx4Rs2+Z2a8XOm6zZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Qg5mfPam+hZ4EzvkfwG8c/nFVyTqd8/nbtNYm2gGE=;
 b=dk5e89/Z9K3MtAwRfF/tP8REgyftc3njeRaMF49WrALYvVNiypy2maA2WHE/XMI7JSBWig6YJCHgAS5o/fIh64tuh9pcMIcJZFtK0zFc1e0H8di9/O7b5Oy90lXJsFo/DxXeCWjcRjJXp4c7mRfvJ7kNtEVL4Um+Kw6TOBNcGa6YDtmnbnupKQv8MEFGqBKqS1h7F8BCKrJNJucEjMkr9FdmDCqqsOLWSGWExtEbjl39Yscm8K4IelPxkLlPa78ByNUU/yr2fC7iLbRQ1Se86x1WA3YQY2aJ7Es1bMp/CvFyv4FvT9tHL/Kskh2MTwg1CyPBMkXBTPV5lVOga0o0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Qg5mfPam+hZ4EzvkfwG8c/nFVyTqd8/nbtNYm2gGE=;
 b=Z5nDeVFSm4/8za0PjwMKAGBCJFzhToMnDWyo3aPsm9u3eOL6gvBzHQNeOMqfv2MKSNZ8moMtKn4AUgIb5zYuMA/v4haOqVXgKBM5xADMZYOqdOUJCgiq2n0cyQyoRRseUCyplCmN0EyX+ROTnQ6X5F/XsuNQqoBpJPObfuDT1poSG6dFMXrPvgjdHC4zRBYxOId9XYHadioAjkCZHEeN7wxyiPF+zIYU0YsBwLS10GNrRC6rBEIXkj7cgYgNLHqSCsAIA8nz/HiB/L/xl/rKRqMkLaE760HnvwFcfgCAZEkbsKZkLnEvT3E5UvXPcbIucwB/rH75Qq/18HvixpjFeg==
Received: from PH7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::23)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 23:15:13 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::5) by PH7P220CA0080.outlook.office365.com
 (2603:10b6:510:32c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 23:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 23:15:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 19 Sep
 2025 16:14:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 19 Sep
 2025 16:14:48 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 19 Sep 2025 16:14:44 -0700
Date: Fri, 19 Sep 2025 16:14:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "sven@kernel.org"
	<sven@kernel.org>, "j@jannau.net" <j@jannau.net>, "alyssa@rosenzweig.io"
	<alyssa@rosenzweig.io>, "neal@gompa.dev" <neal@gompa.dev>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "krzk@kernel.org"
	<krzk@kernel.org>, "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "tjeznach@rivosinc.com"
	<tjeznach@rivosinc.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "heiko@sntech.de" <heiko@sntech.de>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"zhang.lyra@gmail.com" <zhang.lyra@gmail.com>, "wens@csie.org"
	<wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"cwabbott0@gmail.com" <cwabbott0@gmail.com>, "quic_pbrahma@quicinc.com"
	<quic_pbrahma@quicinc.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "etzhao1900@gmail.com"
	<etzhao1900@gmail.com>
Subject: Re: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aM3j48Xqlfvh44fm@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB527129A9BBF84BAC106B327E8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB527129A9BBF84BAC106B327E8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7ef5ec-8489-4649-31ee-08ddf7d262e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0GACN3qznxKYjXD0FFz200NahW22jOhyIzG6IkToK6aNz4roLC4njGUBQ7O+?=
 =?us-ascii?Q?0bVI02WX4bTxYRj7B6ZAKmBRzZsjzRT/+Gj2l0Anmpsob7+ywbMsVPzRiLTG?=
 =?us-ascii?Q?+wVg3y9DI6fAsVFlaPx42zVew39AyYgNP53XK7/DumnZX0k8ZOac1i5c6nCd?=
 =?us-ascii?Q?FaASQGIREDofqtXzipg6hpSn/PXnG/No58E1RTXI0NsvtDBSpYdWXVeHAaXT?=
 =?us-ascii?Q?1u+oc+5orfcC+22qgG+/Jw1Qrf6PWJ3kSuWlvgun4sD9m5qVqI1Qa563zp7J?=
 =?us-ascii?Q?mB1iXpGq8E0gTZ7qoIuDcJ5pXc6Y0c6b/Xqr7RJqVDs8Ctj9+q7Fr52MNAYB?=
 =?us-ascii?Q?gImTxMG3yGj08V+SY9ZgfUZEpRQPW8jCdzrmcFItjuscuXrTiKgTG9ygTeCi?=
 =?us-ascii?Q?WU5v1Kvv846bF2OgXsCEo96yadl6om6J81wLKmjxDnYrgAhERZTyGpGK+ucN?=
 =?us-ascii?Q?+9teWY76j9A+VWBTSeo1QJP3TWltPwGXVSye8r8t2qQbY77txY7FxNA301a1?=
 =?us-ascii?Q?PlRnVPGfDZuT3xjgQW1z+L2F5UMXTZQc9R/cdzd3wNqwGf+2yVTrV3CFkN+V?=
 =?us-ascii?Q?mYUeOiu70zbBvWQmvnhpfhfxmAZ5peAUXt5EVATs/CXJqax9iBgVBHlKs0LX?=
 =?us-ascii?Q?dyuXMpGkQfS2+OP9tlMDlLy2vgwZD9kwaaus61TWl4ppXIL6X7LceuZ9k2CY?=
 =?us-ascii?Q?e+sn2FrDr2eR1MKp3WEgVEbIJrjJp0xT0yVNZZJjd9NQOR/bf5dO/G+Z/z7G?=
 =?us-ascii?Q?IUrl4h90jPKe+4S8CCmCqnzasW22EEk7FhLcQgNVGIB2SlX+uYoEAUjRbIM9?=
 =?us-ascii?Q?n1qeMYLlepjrsjXclxsmJ+9D4hxU0tKydycmvPjaTfYt8Zkilt8ewgkqbnHm?=
 =?us-ascii?Q?lPkeBVXquQKWcF5u2YfWgayK8MJACn9cFVTIWug18Y6T+KCeFWnGClbRvvk2?=
 =?us-ascii?Q?dRv0jpVfgvghR7kuLef3SOhmN+zTGsJxJvEXMRH+L28NsawwMbeY4utnRuok?=
 =?us-ascii?Q?qTgo7LNOMnoZkLPENR12buZ25ZRWGRqSDivO0plIrHhodWa52cUlH4CMA7Fr?=
 =?us-ascii?Q?+JytRQ9IlsTL1KfTDCM6ZXhe/MxCvj9zD4VCdQxs62kmJ5hLWTyBEHpLK568?=
 =?us-ascii?Q?g+DXIe7TzlwWjbY7EldpAnzwKmcEqph20ERzKGrTqzBo7E5iFpgHqFjy3gel?=
 =?us-ascii?Q?enphqiSnQih6DRB6MIDHiQg/jdOH5yJdjoL/+CGX94xNWwY0mDr8GSJBrBl9?=
 =?us-ascii?Q?x0k4wxlC69NQrH2WNdIJ9J5DfbH8vWdrYAB6ciu0KNNH6mRZ8898mPUcfKZy?=
 =?us-ascii?Q?6ifxYbYlIXZpco+8+DCUW6YsACx9gmZkPm0XWxk1KdJ5J506VyzjXjBWHs2/?=
 =?us-ascii?Q?K1UaqcZKYzlUoOUCR4o75fHE/Ml9lPQyc49hsHxtK081yaMrPW3lxHYkZSXj?=
 =?us-ascii?Q?mTpzo8Ukc/R6GQQ1RtyU3eIY4BImq1aMouCCEQueplRSZlEc4AIj7niAVIlI?=
 =?us-ascii?Q?jM4lmV5ZXb4+D3afQruBDGO8Ap1GBEbVbj2T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 23:15:12.8569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7ef5ec-8489-4649-31ee-08ddf7d262e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

On Fri, Sep 12, 2025 at 09:36:38AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, September 1, 2025 7:32 AM
> > 
> > 
> > +/* Caller must be a general/external function that isn't an IOMMU callback
> > */
> >  struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
> >  {
> 
> 'general function' is not easy to get its meaning. just keep 'external'?

This is still one internal function use this:
drivers/iommu/dma-iommu.c:1785:	    iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))

So, it's not completely "external" :-/

Thanks
Nicolin

