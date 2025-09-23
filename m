Return-Path: <linux-pci+bounces-36792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C8B970D6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00667A15FD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492E2836BD;
	Tue, 23 Sep 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sdabAkyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390727A919;
	Tue, 23 Sep 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649079; cv=fail; b=KWCdvOqn99XHb9k/g+Io5gzh2xCZYBL1tJxEkPMwaCpGHHG56ApXHAXj8hMbM4+glKcxNBqjO+LfAzBiR+mk41hTEGfi5K2TartLNIg1L5WZAgleUPwn/J4ay5p0PsjLUQ36+lx88SKVNCxmIrZLJXa5A8wiffRJBBZxaiF781g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649079; c=relaxed/simple;
	bh=f7ziZWXCJTdMRMQdtbuSf3Socszj224xk0iehKiRYyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhxZz4RBrIhEc076Efmh7IO+ioP12HTccm8SOYStW3SjKEM1NptRSQjfzwYFEylmlanduQeZQqAZC6IeXhGIiSw6ob/JxQYDAErtjsXXvz6dt9oTjhdl4ybvShUg72oZ6ugtnhMpW5d4vyKd3GN4BXKFLo0GR4tcxqp17Leuwn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sdabAkyT; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqHO8ZxztFqE3hOa7+RClSVp1RQ4LKb9pSIcKtCB6AZNeKTGQjyEKjRMmUGneAMpqFB3UN9+9omPvhsNbyYPYK/Kkm7m4ZOnJmxmabRV3YrKwh/XNiqFLVyLUEUJj9GeAeiJ1TGZYCyDFmIVpXuDFlm57O7y3y+yPr7fgCAH53U8Oab2SmNI1GsCTThgKjU8v7FjavFkSDoOJm+SkzJFzL8xwjBj1XatxVGeuImm1UQPgeBCIH1ZXiYoww1RmbfHfR/jmZGEnV3qInY5RFEQEPpNpC/cwQ7PtwXniDRZDr1aZDaaF4JrFYvRY80wDhxJ8IlFWiSiopMVLwuuCa74xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJME7xPPga2KzEMqRHXlLQRb5iWUmZ6nRsRhuE9yAUM=;
 b=OuUcntZIfnl0U5Tzw6ewGC0uVWWPsopf/oMTDL3WIcW7SAnFW4Va6F4ESj2tgogFkLCfPFtGwn+/AVsbycXBQE88m2T5lW4cMUJmB6tWg9fiaRs24YDf+uMgyV7frS4JqYE2O7JoAbr+2bz+kpLDPOLw2Qd+7+0f/Vxw5acPITusVUaBcr3FDZUpiiH0d4GAj9X4C4KXyFUE0g+wU9IlmM8pjiDIAF7WGePB7BCLIgnRkzmIV2v/btSxV4mwRERD1Qp7Je6DAZDe07JOuufOUgmdHfLGGvSVzhEguBjXnOl276eo/a6AIYKe1qVbPAYTkAK6Jze+KnbSALg9FH06Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=csie.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJME7xPPga2KzEMqRHXlLQRb5iWUmZ6nRsRhuE9yAUM=;
 b=sdabAkyTyV8G+F8G2Rcf9HcRvmb+oYSnDxSnNntX08gPZJYaN0RQpJT7PiaX52FrkRZQy9CTf/B16xU/y0+EvLEM7tR6OFV0NgUBBf9ipyQl/hXjVTPV7lNOPO4XtY7urNxL9GIEovtnahpDlFWnSCBTCrgspgjNthBI5xIAvWSwv6uGTdMpnZXT3QCjtJGXXOdfpYQ2jqUJzlBDdmT8cjCNMOHN/JTB1J2truxmL5O3FiGwrdRSc7SrY4Yf7Dc/pWzXewh9AgdLELA4MMpUzvRQgCU4+gfqbrhf6Wh6GMdLD0aesnBtVARAkOhGUv8DgUK2YyeXVy4A+4bGrhxiIw==
Received: from BN9PR03CA0670.namprd03.prod.outlook.com (2603:10b6:408:10e::15)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:37:53 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::1d) by BN9PR03CA0670.outlook.office365.com
 (2603:10b6:408:10e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 17:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 23 Sep 2025 17:37:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 10:37:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 10:37:35 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 23 Sep 2025 10:37:32 -0700
Date: Tue, 23 Sep 2025 10:37:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: Re: [PATCH v4 1/7] iommu/arm-smmu-v3: Add release_domain to attach
 prior to release_dev()
Message-ID: <aNLa21vMlP6kgatx@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20250915123515.GE1024672@nvidia.com>
 <aM3dlQH0rk74w2CH@Asurada-Nvidia>
 <20250923172229.GD2608121@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923172229.GD2608121@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 733bb114-f303-46ec-943c-08ddfac7ec53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DYVZoqPGvghnFolQWt9uxMry4KcDi8jKQTzB1aROgWPrObMkV9xyoSQuxuxu?=
 =?us-ascii?Q?vjvnIsUr6vxVMHfZ0WrEgkLmxtnGmA36MQkL5Nmz/vsOJ4w6D8SOUpd5JAtj?=
 =?us-ascii?Q?nCekiw+4OTu18N8ZBqETEvsYH8jaDubjgnglhqYc7TUeLcuKqe2ZiFEjud4o?=
 =?us-ascii?Q?CZxoevT0836hf4huAfOhuz5c+4VQxqRABFIDGF9bgyBYX0LzcLXuhkt5pBv1?=
 =?us-ascii?Q?jSMcpZD9ggomOALHzL9dxgypTNFhFFPiPXamovMFRkLCQ2K2x5itToQzYF5A?=
 =?us-ascii?Q?axkPsAjXJNWco8LxAwP3FFYDWXYWDyid69iV4QKVtQeR3DTSDOHCbRrJQia/?=
 =?us-ascii?Q?RDIlXUrFXnnFO4lHXjTaUh2b+a08uZszwrl6i4vcogEBHKzLiB2qsB3kscfa?=
 =?us-ascii?Q?lkpBy9kC/tDNpjldUlebriqzHVA8TDVhXFffC77qqJrMBE6XG/lYR5gHGQvi?=
 =?us-ascii?Q?IerOZiSU/8ub2nJ1oHewJW8GRvQR84KybVvdcIll4KB16aM6j8wkc+MLpNle?=
 =?us-ascii?Q?EBu9246sSo1xDUHE+tsPdsDUPjeQe7pltTDm8Ot7dlDl6j3iGEMJhTrS6oEr?=
 =?us-ascii?Q?ne4kMD8BEkqRzfw8hHnA0LSG81MW5H99i4DOht+pMx77D6GuksBWqd5YWEGq?=
 =?us-ascii?Q?C4jzBc2nGVS84GxbvyMmg3pH0IT/Fz5keSsvWNGdoCrSbwszmYr1YcVowNDj?=
 =?us-ascii?Q?VpVdE75LY2IEUx0v3SYcKKyRsd1FSUxAN3dWj1eF+aKqXSpUOUhi1ccMNfCS?=
 =?us-ascii?Q?HJ1zOow0HVcHLBJYjQsgdX5QTd7DlFxy1v1QUz6oRyTOn5XgfA5xrX0hQW9u?=
 =?us-ascii?Q?gQFf5+X1FCpWgBo5gXXY4V5H448rQgjRzHHfQSu6NdRHjAFAWFNvmR/rwLq/?=
 =?us-ascii?Q?dcFtwiJN0Dpg+GixVUwEI8faZmEMjfjo1zatNiSRPPZgE+zRl/9tDYRDsQhj?=
 =?us-ascii?Q?3MSDv4JUhG9EqpUNF88TVJW+HNQTbS9YujTMVH6TUT5cbhsxYR7S2Yc0CHwN?=
 =?us-ascii?Q?xs7M+CEHsXp1xAxZbp0eyAE9ksU/fxf7LGrdWx1I/+5U/FiOhpjGtUA76oWF?=
 =?us-ascii?Q?NcM+PVyh+NF5VblYMrfX6KLUWoagdRNqlWGiXUSsTlcAf1N/0SQm8lc1G94J?=
 =?us-ascii?Q?2IBiMfrGM/3/4Aw6vcfYje8O/kokyrJqHg+qvSagFLMoFAJy6HKAb9r8u07v?=
 =?us-ascii?Q?3dHy0RPm73qwEAIE5GaAZwMqvvqgm836HEBcnghiDLQXHZNtV/VAPjH6Ek0p?=
 =?us-ascii?Q?JwuJsjqzIFDez51ozb3LeZ6nYOIv47DNwuyyQulR9XBhKium+fL2qX2/VmZ2?=
 =?us-ascii?Q?sCsVltlLKKv8NmWwX16uZ7hc3QQR4LJm8xrCbSQys/PtPFIwXMgrowcO07tz?=
 =?us-ascii?Q?gHkNlzYNubHf9LT0nqEIfCeUJanuPnC8PixGkAXkIa/fTWphgGkByCv5icWh?=
 =?us-ascii?Q?CIq4DD4saNUB8kAZMcZ+ECA4V5ELanSxzzh8WcfJNa+zipRZ9Z51YDc5pfak?=
 =?us-ascii?Q?y+dn1NX301u2NrOxMIpXrV0eZb4s/BWpW2OQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:37:52.5303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733bb114-f303-46ec-943c-08ddfac7ec53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145

On Tue, Sep 23, 2025 at 02:22:29PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 19, 2025 at 03:47:49PM -0700, Nicolin Chen wrote:
> > +/* Same as arm_smmu_blocked_ops but less set_dev_pasid */
> > +static const struct iommu_domain_ops arm_smmu_release_ops = {
> > +	.attach_dev = arm_smmu_attach_dev_blocked,
> > +};
> 
> don't worry about set_dev_pasid for the release domain, it is never
> called anyhow.
> 
> The intention is to just use identity or blocked domains as is.

Ah, I see AMD separate release_domain from blocked_domain..

OK. Will just set it to blocked_domain. And will update the commit
message as well.

Thanks
Nicolin

