Return-Path: <linux-pci+bounces-36711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE1B92F5A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508482E018F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F722F28E0;
	Mon, 22 Sep 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dfdSDLIE"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDD3168E5;
	Mon, 22 Sep 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570013; cv=fail; b=CkkShCagB4BHXehiKgHZD251ufg9ZEcIa5RNV3BmgWLyQC+6fFP56QgpFl3ersTzZzfHVY3UZv2HmiiRBTZ9X3nikHsvgZiVWuoMoqY8L4nCottuqNQbSx2S9TcKH38SoAknjwAhCbLy3y1Zr5W/SCHPfnT9UXbHlhbydeW0tfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570013; c=relaxed/simple;
	bh=CL4c2jHsVqZOpoP5Xz3GKJvVkXhdbBuUsNjRA2UE1MU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/hN8LkWQ8O6jU9b1t2GxxGwbBcK73C5t2r1OefI4G/a3aqpGucg7DGlP3juxei5vdhZwd3AV9W5Qjft1I2iydgOZSk1AnQdRbwFKyBWgg5Yo47I9j5iq1DK5pv9ng63ZUQRo7VF/2Z+1zql34S+J++z2NXEpT7owJhmGstjOXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dfdSDLIE; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJOyPGA4k7qzjV975jSTFBFhE0aKyhv3mg6r+GSxGtUEeK8iSgIsBWi4Q0cVmD/UPrhnB+RfwByAHNuC5v2+tlMzq/dmW+vzkWUyEbZhW0e2Q5uqejZLIqC/zv2CLK3LTDQu68JumUdNlx6lJ2R5GptoYyUOPlZDRHrfeTeiJ8+BSpco5KKqm5Vg0YSKq75No0Vw5SHW7VgWJr53PAgKecCdctgjv/wYHlmrpW9QhcAGN+lTJqH+BjG0aABlLPrGaDdq9dU3U3i/ouPw7Tyy+C/owV9KQy1p5h8phznedYIRCLjy3+WBhVmvEMf0CkbktuNy5gzqfRIS75+DYT9tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwQdfVHoQ89g9jRugMa62uAOoXRlQr6J3u4Shgt6m2o=;
 b=jJz3ULD05pjnBb4+MA9jexQ0M0TFLCiWfr4/ePNT5jV2+/MvkmxZnfSh0mIasHbqGr2QnWVjfCdMB9/XbiDhO7PWARtYgDWbb0kWt3nuVLANrAxPdNAAOT6QvUtqt/GohE0+ncUlvPfLmVeQ0JFKFfj0fpjLtiFJGb/ouZpnPRRdALW4I/XwZwk84/g+A/zW9+JOZurog7NkeeRatC0wyVAYbr+oD/WrnyinjPZmqexRDbxQynzr6W/vgnT0LW7jHmK6O9dW9lFE0000e9RJzk0iMKD6+wIHo+Hxun075Xu6fr+fcUq7XP3OdVcdH6Df1tn38KLHJmRMUn0pjjgTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwQdfVHoQ89g9jRugMa62uAOoXRlQr6J3u4Shgt6m2o=;
 b=dfdSDLIERJOCwLMqFjprl9MK4s9+ekXInt71a8NXZ5GAddHO58ybnVGLXH0CujGvlCs3xFeqhNEOI4bomDr9KVSPr+LWh8EWOylRIKk44yec6F0asLI/HWB+YhJHGQoZodzuCV4RDdadcHTFENy/UoVuSi3i3w9vXczCY78Eb7NnuSJxptsBR3iGY6L3wpfo5m3zGaoHjWt3sYtIR2/kCAxLpobxIBCr5P88CT35UbAv2IRex4tVjTwf8BSvkOBYBd3UD2vXJzWSkwX6axf9tj8EkXS5VXXzOEUbeVVm5o1x2djnd8qamM0l8ay0UAWl0+woWcVB9VFN01KjmU9ybQ==
Received: from PH8PR05CA0003.namprd05.prod.outlook.com (2603:10b6:510:2cc::24)
 by CH1PPF4C9628624.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 22 Sep
 2025 19:40:07 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::1e) by PH8PR05CA0003.outlook.office365.com
 (2603:10b6:510:2cc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 19:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 19:40:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 22 Sep
 2025 12:39:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 12:39:47 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34 via Frontend
 Transport; Mon, 22 Sep 2025 12:39:44 -0700
Date: Mon, 22 Sep 2025 12:39:42 -0700
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
Subject: Re: [PATCH v4 6/7] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Message-ID: <aNGl/pos6os95dHh@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <0f6021b500c74db33af8118210dd7a2b2fd31b3c.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271BE949150D4C2B5EC589A8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271BE949150D4C2B5EC589A8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CH1PPF4C9628624:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea5e492-fda6-4cfb-fe5c-08ddfa0fd47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBp2iPgKLaVqUipOWDYd/uahSr20F34zUA18MxEmr8eKFUh0whf0exxHuuw0?=
 =?us-ascii?Q?M9Zvu0/ivVeydZG+wgKL8XBgbqCZWrptldEMJKyTIP3aRxqfTfVpKinRiOfz?=
 =?us-ascii?Q?XIoPVOtKf/YW3LkAui0MNiksK0Jp5ztvX6J+JJwKnvyvGFntwEWIytJj6VFd?=
 =?us-ascii?Q?+r7v1KEujJcxWPD2P+W/4Z09CyDvjaNiHBQTL+dd/m8qlfKPBcxHObTBLjCZ?=
 =?us-ascii?Q?wQXkTzyDS53cbgbVN2N6HBr+PVGcChq6FqQm6qTFJjZaEah/uv0q/JbGBaAa?=
 =?us-ascii?Q?0JsWocnu8C17uscswJab7SusPdhZ0O6jdCZT8KqEwGIHnxpimxjX0JtRoCmt?=
 =?us-ascii?Q?PtrcZDqOoNqXecC30uBButoO5ZOswrhNGrl/Cp7ad8pe9VLnOWxIKdiEhi7p?=
 =?us-ascii?Q?YtWXONkzan19oWeiS+kekqelrykik7zyWkKMFp1pmm/+7fGoBzooSJ48/6qH?=
 =?us-ascii?Q?CYiqM7yuXhz5kJe6MTjIh7jE1Ue2Wb1rLtybp8F/vjQUK4Fob/92YqcLqWyF?=
 =?us-ascii?Q?Xmae/D8NxoCHfek1aowhj3QcqtLtYDIBubIHzDZEUm0N8VvS8Lm+Ca+t+LZe?=
 =?us-ascii?Q?bf75kaDTjwzVtz8evUYIp9ClMgCOlZ/XO+2ZAxala+P/7KV9HYx7gMxFNei/?=
 =?us-ascii?Q?BT9Lcp+bNXx8Hx2NFM05cYREZHnc7pDxlXQ0i39tbjPwLVtZgzUgHjmeMCjp?=
 =?us-ascii?Q?xL79I8PhY0EA2Q1gdggqRtfiILI/uaVknAiqsk2tz6KSRhqduMBgNbz8f5VZ?=
 =?us-ascii?Q?VWgQtw3OwIPoJgs31qXjGvcShVtB43GvfAme4oeUF6ySV8Ttn4BrDdZ3jB4H?=
 =?us-ascii?Q?+sQ3VAANPcmO8VO5BjtNhn5K9Qb5mFb6iDf/LhQuwBac7ty9LX9cXTEpdGhW?=
 =?us-ascii?Q?mISMfJ2MulVIv6pXM5oIWlY5eFZmPa2muyeHToryjD3QPjOVtIY6CQTJnD4l?=
 =?us-ascii?Q?jzxvN8eX0m7BS5Uxz69C21FNyXnTWKIge86snSfz9spLUrUh9vyybaIC/AlD?=
 =?us-ascii?Q?zslj0ouRoYXj0RXVLj3K5/JzSQbZ7alNsFdc+nW7IYlEeXxvTBOSrfYI9Nbe?=
 =?us-ascii?Q?OmTV4l4TE6JSJFhYZU5SB/ql8yr9uk2SCWm6qbRCMCByBxvlFD7/fncoyr84?=
 =?us-ascii?Q?mQ/+gHaF9Kqf4RzvWzH5rPIelNu8ZMAlyZj1JP2QDFBYv3ebwZSOHsfVP2DV?=
 =?us-ascii?Q?05Um3v9bsUBcy+GP+xpViLq1atdCspH2ArfJRK/u54qb5xKpi6iN8xbn5psa?=
 =?us-ascii?Q?ZzJAOEf/TfyUgWtxqWK8/unq1JjThTbJUdbXbUtD9hoQ5ZXmHPwLrSsxuZbx?=
 =?us-ascii?Q?FNUrkX1qjMM/U7FDMvxrE3cqDeeHNLzHONm+9KaLVZ5Ux1U3JKyIUas4BSMT?=
 =?us-ascii?Q?ZQYtJi+qXxYFi/e5NwQ6jOm2YFewhSYTKI4jJtEQ2EgYH3sFAUJ4rh8/qtWW?=
 =?us-ascii?Q?Tg1IhKw+QmXLoGSqicfx2HT6h7/GS5hlvDPTPrMRjxLkrXGZb5kr3BRHpdCm?=
 =?us-ascii?Q?s575dz/ejljm4wg4WkZzIA1tGoGoKtMUcU+G?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 19:40:05.1641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea5e492-fda6-4cfb-fe5c-08ddfa0fd47a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4C9628624

On Fri, Sep 12, 2025 at 09:49:13AM +0000, Tian, Kevin wrote:
> given it impacts uAPI:
> 
>   - now attach/replace can be done anytime
>   - with this series attach/replace is rejected when a device is being reset
>   - later with compat testing ops attach/replace can be done again at
>     any time
> 
> we should be cautious here, especially if this series goes into 6.18 (likely
> the next LTS version) the interim behavior change may last long. yes
> we discussed that no know usage would want to do attach/replace
> while a device is being reset, but I wonder whether we should instead 
> wait for a full solution to avoid unnecessary uAPI change back-and-forth...

That's a very fair point. To keep the uAPI consistent:

I will split the series, making a smaller preparatory one, as a
part-1 for release_domain and old_domain.

Part-2 will roll out a can_attach op across drivers. And part-3
should have the final reset patches.

Thanks
Nicolin

