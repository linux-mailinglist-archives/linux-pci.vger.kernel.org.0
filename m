Return-Path: <linux-pci+bounces-36545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C59B8B92C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 00:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CCDA824B7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483742D46A4;
	Fri, 19 Sep 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nk8tBQ+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB292D374D;
	Fri, 19 Sep 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322092; cv=fail; b=avN/8MYWh73S8qw5EKkznV9/aoBMWnTjAW+d1lzkPHk8+e0Olq3y5N7y/mQOu3r39xACrpUUhxdx2FdCFaEKd1/L3vQGwFIYfIS2B0hVOnLcnATGL2MjMF/xHeIxDXsqQz9VijYXA5cU/4RZTFAwrLdym/qltW2GKpaZiY4mGo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322092; c=relaxed/simple;
	bh=z0rg/nNHqd1A2hJOGUuYi0fSmeZ9TUTYKbS6FNtzzLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itEK4wF0U3Wb2i5d9uL3IQneGpuAc8hLa0iupzraHgveE+YRwgAIk1fF29cPPgqhv//m9JWr3IotYX7jWrNbgW6kIuTQnwpWPQDCFIY1jbvkF2IK4Ul5qd/3Z7uZBF6PRrPd4iuJ/klKnCIRijYv5XLtYWD6C4mlraFlbsqoavc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nk8tBQ+u; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQCnhAd4ogXwluZATUxNvL5CuJR9NfAIGtCxJmkOS9qd7VXJ0KePD7HMQhpY6Pjjc5IlRPamYbT83DeTnguHDu4agsEEj4cKY5Sq27dWtGMsyim9QgVzIU07XkHAyuO9gN04LWbmgz1/IzbC9b8ziDpAVR6Bh/djMaeK1sf4N9aZw9k7az4/6d4QTc2MMlyEtcOoQrzcnESGvXn0TiV0jtG9q18Agz6QEEUxENmlIDxeT/QtTgurwy4bpKL50xD0xRPAQDeGdfVBid4QSVv+qjilRAfnd9DtSZd6wizlRhg0k+Ui+Dwl/STv1pADyT/kY4dUUcaL9z1nX51gq/iDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsweyLScKXuoF/HTxi11r8BjDMX9bNlmMBgK3Adk0Zo=;
 b=vzBcwDnrnzv52hSMpqcY20PDITYl+RxPOIAJJwvcQCgv2cEx5VbuyBcbiYjc4BBH1VpRa1Z3Q6UEkl4pCl6uym56AEgKT/u5//Wgo3PPsL5iBE5/U+4qqlwTy+h/ENvnht7Zb6FYCqIbgo7j3JInczPnOumSDOZd+WZ0zYXyvyYbgWHIPMA0etCs8INjkUC2xss/4VQiVMBRVUl3iF6CE054BAGi6InsP02+tDka8zRHJiTXTmn2txk+RBY5XD3Wfp2T+ZA+Cd1ajGlNXiiqLspRYbWel28NKsZImfSpYv8MEKs8F7mzDw7CK1MSDdOgapo4xXKYiitY0FALAuhXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=csie.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsweyLScKXuoF/HTxi11r8BjDMX9bNlmMBgK3Adk0Zo=;
 b=Nk8tBQ+uFXO5QDs1h4oP4TcPb98iU4vhhVjeHNFZcmj5qKnOuCsDmRgpFKA1r/e1k+X2Fsk14Fg4B17Lka0mpRtg+8Z9e0mSw0ettXHDt2p+GmTjJlqhAIyQF1dGG5pWu1aG4Eav1PdgUo/4uNerAgkC9RmI9d1PkYh2eVc0deu6mvv+OEy9hLkK8VlpTzdUz+18nHSElGhYL/wDWelYnpfzWUOkB5xIbtGVb8G8pFa2VAdDn2OhCFLvcpNx9ZdEZYJZvz0Mkv5CC62/HLOL212VNhdePDdOjeCFo7QzIYoRGRqzK+uKfuRlPXlwuYlZPNSsqIW+TfBmQef0m/UHBA==
Received: from MN2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:208:239::10)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 22:48:05 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::94) by MN2PR08CA0005.outlook.office365.com
 (2603:10b6:208:239::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 22:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 22:48:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 19 Sep
 2025 15:47:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 19 Sep 2025 15:47:53 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 19 Sep 2025 15:47:51 -0700
Date: Fri, 19 Sep 2025 15:47:49 -0700
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
Message-ID: <aM3dlQH0rk74w2CH@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20250915123515.GE1024672@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915123515.GE1024672@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: d68a65b7-1329-45b8-f457-08ddf7ce97f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCl7tuhenDwOjfT4C6k5OaH6jJnCVYRVJJ/KHeIjeC9EsGiFHyc5afTmTlIW?=
 =?us-ascii?Q?ENDm7euUQvCiGuYNxyV3jhsxfOuyk2mm68G6RKusBpc6cNY2SvWmD/PceP5s?=
 =?us-ascii?Q?ILsCTo/fw9M61EMgWT3Xq70TPkK9eZ+XMQhGlpRKZvC+UMKXsJVYGgcLKLrP?=
 =?us-ascii?Q?MqYHnFVZNN8soiM8wld4Pq+fvZRpPJsw2FfpNd+Na2xw1yLj3MN6b46yr9Rf?=
 =?us-ascii?Q?OPUUoNzsIV/DECDDlemLTudPe54sQ0pcqjNDctjwsNEfyxM9vRgd4p9uUiLz?=
 =?us-ascii?Q?MNp49MijbMTXc9H/83Jt5oily6K4iiNoDMADunVft87jt1Lwzvh95NEPdrWq?=
 =?us-ascii?Q?VN05/eQ1/NTkAFjCCJIDfYGJpAvDtMo01kwhqfaiPLzOAS5tqOFzU/vo56lz?=
 =?us-ascii?Q?QWwj0H0hIo61O0Qr5rgcOHvz5MOwiOspnI3ZUb8UQ3AJnHWIwpn1qyYh/wSL?=
 =?us-ascii?Q?IEmW6HhqhTOC925Q6LLbaGmmNKOT4mdMJtSOwmkJSET+CeX++fF2ZvYClJBA?=
 =?us-ascii?Q?0UrafQwa87lat7/eyWxGmOHNc/Tkn/Ld4zyIYnj0+qfQmr5YtIZdIKOkZry8?=
 =?us-ascii?Q?nEi17l3OBwmyO3FoNB39M26l5UKhrayVTKhbQ+ClkHyz7EIUX54Vp6bVa+g+?=
 =?us-ascii?Q?f6uPWGB+RuYa1O/iLNiiuu6Kh6bevIbK19XyQF/HdsJVggQp5CiQJN99pbHm?=
 =?us-ascii?Q?eRyY/AdYKHyQG/m6pfRfKKp7boXDGZRWgfeAmADNvxO5T6B5O/NZPpFFdGTG?=
 =?us-ascii?Q?0VMgkuOhlR6UZs6LNyHg55bMq3zmnUeXBOsgQQwRYBQuTI88Ma8SbmPlkb4F?=
 =?us-ascii?Q?N9uVAXz5P2TjIwzlw+da2i0LepoRfyOc75Aeh2a0yYQxEL5iTDbseAP1zNYR?=
 =?us-ascii?Q?Nay9l5K3xk97tFnis6/A87bc0oTbw9IHqcWVW9A+jsU+hmezkP4JFUUqlAze?=
 =?us-ascii?Q?YsjS/Tpf0Xhd8VZsDEsQWFBZdboxYSt4n/YY96Kg5rpLg0gGk2ljk+i7pjGC?=
 =?us-ascii?Q?98MuzqrdFlNeM1X8xB/cjL7FjgDiHKx2+s9EbRvxwuzS+vNtAtDfpLJ8lK/0?=
 =?us-ascii?Q?5TjCQyxCUtrrmPr8hTop4qYhHxI4Gj4//wpZUAqIJVHjW6G6bXPKBr3jJHhl?=
 =?us-ascii?Q?B9d4EPF8Y2RZOzmR4T+pmNdfC0qzr4RtzYDhNeUm4/JhoBEycwteOWZRup8c?=
 =?us-ascii?Q?vbEUBCUWfmE7Vd8l8VxbShUWTUg0hx0JCXJ63DYOKh+9eq7Hd9hb7llKD6j/?=
 =?us-ascii?Q?vfVHg1i5I1Cg6Lo2zjhcI2czR/ZE41Q1HZlRZhEALcAJQ7crqxGhZspAQmrq?=
 =?us-ascii?Q?atn4ObUj/DPicbUZZ52OekvPKff4V47N62uymEwiGY3UU8Nw+zB+dtFGcLAJ?=
 =?us-ascii?Q?c/bpQZ7vRlx1JJhbOmeImBLnEBCaSnjQB5QrbObXnM3Yat5980+v4fgT+Zt+?=
 =?us-ascii?Q?Qz65tXHdCUteEQC/Q1zSTJJ1IDnes2T4gFFdGQiD39fC1eTmrYpgyOIUNLf9?=
 =?us-ascii?Q?m9YsTgu+SZEnAtyd2p1vazP9VhADdN4oDwG7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 22:48:03.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68a65b7-1329-45b8-f457-08ddf7ce97f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

On Mon, Sep 15, 2025 at 09:35:15AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 12, 2025 at 09:33:06AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Monday, September 1, 2025 7:32 AM
> > > 
> > > +static int arm_smmu_attach_dev_release(struct iommu_domain *domain,
> > > +				       struct device *dev)
> > > +{
> > > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > +
> > > +	WARN_ON(master->iopf_refcount);
> 
> This doesn't look right anymore..
> 
> Now that iopf is managed automatically it technically doesn't go to
> zero until the attaches below:

I will leave this WARN_ON in the arm_smmu_release_device(), while
having a release_domain to call arm_smmu_attach_dev_blocked():

-----------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f05..3b21790938d24 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3291,6 +3291,16 @@ static struct iommu_domain arm_smmu_blocked_domain = {
 	.ops = &arm_smmu_blocked_ops,
 };
 
+/* Same as arm_smmu_blocked_ops but less set_dev_pasid */
+static const struct iommu_domain_ops arm_smmu_release_ops = {
+	.attach_dev = arm_smmu_attach_dev_blocked,
+};
+
+static struct iommu_domain arm_smmu_release_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &arm_smmu_release_ops,
+};
+
 static struct iommu_domain *
 arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				   const struct iommu_user_data *user_data)
@@ -3582,12 +3592,6 @@ static void arm_smmu_release_device(struct device *dev)
 
 	WARN_ON(master->iopf_refcount);
 
-	/* Put the STE back to what arm_smmu_init_strtab() sets */
-	if (dev->iommu->require_direct)
-		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev);
-	else
-		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
-
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
@@ -3678,6 +3682,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
+	.release_domain		= &arm_smmu_release_domain,
 	.capable		= arm_smmu_capable,
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
-----------------------------------------------------------------

> > > +
> > > +	/* Put the STE back to what arm_smmu_init_strtab() sets */
> > > +	if (dev->iommu->require_direct)
> > > +
> > > 	arm_smmu_attach_dev_identity(&arm_smmu_identity_domain,
> > > dev);
> > > +	else
> > > +
> > > 	arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain,
> > > dev);
> 
> And I'd argue the attaches internally should have the assertion. If no
> pasids and blocked/identity the iopf == 0.

Ack. I will try a separate SMMU patch from this series.

> Also, I don't think this should be in the smmu driver, every driver
> should have this same logic, it is part of the definition of RMR
> Let's put it in the core code:

Ack. Adding this patch prior to the SMMU release_domain:

-----------------------------------------------------------------
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri, 19 Sep 2025 22:26:45 +0000
Subject: [PATCH] iommu: Use identity_domain as release_domain for
 require_direct

If dev->iommu->require_direct is set, the core prevent attaching a BLOCKED
domains entirely in __iommu_device_set_domain():

	if (dev->iommu->require_direct &&
	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
	     new_domain == group->blocking_domain)) {
		dev_warn(dev, "....");
		return -EINVAL;
	}

Thus, in most sane cases, the above will never convert BLOCKED to IDENTITY
in order to preserve the RMRs (direct mappings).

A similar situation would happen to the release_domain: while driver might
have set it to a BLOCKED domain, replace it with an IDENTITY for RMRs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 08ba7b929580f..438458b465cac 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -516,8 +516,20 @@ static void iommu_deinit_device(struct device *dev)
 	 * Regardless, if a delayed attach never occurred, then the release
 	 * should still avoid touching any hardware configuration either.
 	 */
-	if (!dev->iommu->attach_deferred && ops->release_domain)
-		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+	if (!dev->iommu->attach_deferred && ops->release_domain) {
+		struct iommu_domain *release_domain = ops->release_domain;
+
+		/*
+		 * If the device requires direct mappings then it should not
+		 * be parked on a BLOCKED domain during release as that would
+		 * break the direct mappings.
+		 */
+		if (dev->iommu->require_direct && ops->identity_domain &&
+		    release_domain == ops->blocked_domain)
+			release_domain = ops->identity_domain;
+
+		release_domain->ops->attach_dev(release_domain, dev);
+	}
 
 	if (ops->release_device)
 		ops->release_device(dev);
-- 
2.43.0

-----------------------------------------------------------------

Thanks
Nicolin

