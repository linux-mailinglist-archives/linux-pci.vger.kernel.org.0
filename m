Return-Path: <linux-pci+bounces-35201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB4B3D5C0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0AF3B959B
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B54255F22;
	Sun, 31 Aug 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ky8kp+Xr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5E1DF271;
	Sun, 31 Aug 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756682652; cv=fail; b=hcS1WfC5d1GTyAEyixZT6wkDnNj19EDTWimheoTwroJ6Ny7eknQtfAk907ZLw7+jeS7iXB9sHPaOY+QZu7AyUsn0TQdZXZbeIZnYd5fwuY7twMdrOuRXDwi6OZuDk4LHOiw3VDE3vEh4RP8fiKDQToR5QRw5qytN7bMZ3Ggv2Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756682652; c=relaxed/simple;
	bh=7Y8zidxK23j6vjiL2UWVONUKRhyRgVZavuWB7cHSbng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw+c+gHCRPQjghuNlb3rJ/4LDPDROVDWRns5JrzKNoNkUaHpsNnYNxwfAioqt68jY4h0bhXvpzPUCsDCIYxOo4AzXJV4nbvBMizjttI8YzJO6x/uolltJ9qquXkSwv9ZRNQ7nPpGlBMbZ83H8aTN2UYsg7VAWSSf44B8ot0TGhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ky8kp+Xr; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g76rlOqPPPYE1uS8K8awyF8iPth9mDhSndIjvN69jUvdnlYzYRXe86KNr6EQn/Vr30xKofhvobop1U0gHjfP3pdbDtYZWf8yZkco+630Xb02XoqeTwLXsNxF1rsBArTlH3HVbdZpYlUp7zFLbKxZMkY2GeHMKLPMl9+hmBRPYgagGdmX3DeskMQJnpmavHBY6kQx1G/OyGphCbuTZPHEe01MjMH2hUnxS9wXhjAox9783Hw4o7th/6TZuBF/L/pwhr0Q5x1azvwscuMxfUZFsKRiKiMzQ8A57aZxTvjgvWT5IF2bhS3Nvgz7CepVg1Pq26P9ikC2nmw3y7mvH8/N/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydlQM7GIVSdIkpqdMGR2Ljep/zPczmfPd1mtE8YQnHI=;
 b=XkKXSihzUny2tLEDhUQQ05Vs1mCbUdXcMCFM4Ht3iBYeWTz+mA7HQIOT3bDmmOriSDoHN5HLen3N/kf4MMVCjsj5QGZ3aXIi/SIFykta9g+kMFIzRjbp5ASFScoBwZnqKx0wAJg4vX/4fJfk0xMXfmd+RSVp5sAonrRIeTii6pRkFoiLl1DSZSCl5ALcjvh2XvPf1nDrj/SzRzhjUmtmH0v9Ha/Wgj5nwuHHDhVJer12ThexBXFofLVeFV33sfJ2LKrY3EGRXEReuuUESFOUxOJ4mlsnInAgsj6MGMKwYWI3KvpqCx4NwxpgoVwPONReRYMHsN5HpT4AGqgnXB9sQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydlQM7GIVSdIkpqdMGR2Ljep/zPczmfPd1mtE8YQnHI=;
 b=Ky8kp+XrqB6aiNDFSTB34UdEGQMiWbjrtJqLYWumKUx5UHRXEhDPMLIfoNfcpxPkkUi2gUIVaWMW1m2JgyyR5wLfR3OYb1TP7xarrDNRpLgZZ+z3Fln6siVXFpf3lrq6tZt78ynh7FWHCBOXOReDTIqskInCyORH2y2m16rL5XQdvDR4i4uHTVpQqV1KR+y59w+Lh+w9RAbuQf98vc7gp+tKitHcv7aRblAZmEIXY0KvSQTnuwYB3u/YHSemLNpJ7c9C0nzE4diS68SRlwYTxXCUwrctQY5ceHAgrxmJFUWLjJEFHjHbUplDOf93xilHdr8NZ0kzLTK5+KZpkaZBVA==
Received: from SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Sun, 31 Aug
 2025 23:24:07 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::11) by SJ0PR13CA0039.outlook.office365.com
 (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.10 via Frontend Transport; Sun,
 31 Aug 2025 23:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 31 Aug 2025 23:24:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:24:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 31 Aug 2025 16:24:06 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:24:05 -0700
Date: Sun, 31 Aug 2025 16:24:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aLTZk8sK4WOX9RLk@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB52769ACDFED7201CE282FE3C8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aJ+AP18ucw3Jb6QO@Asurada-Nvidia>
 <BN9PR11MB5276CCC219B8456DAF289AD78C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aKcwMtPJuFfVA8TF@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aKcwMtPJuFfVA8TF@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be68680-a2b0-48de-b505-08dde8e57b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?poLkj2GKmQfp7Q1o8cgw5nHUPOSH1lf9fOLdEVUgJAISdRIaoSvWP4qnpwBZ?=
 =?us-ascii?Q?gQaprt7DhGER5sU9g80hg1r4y9TYYzSK/t+SxMr/qwf6LbJrfADRFLK4hnQt?=
 =?us-ascii?Q?DcdY++f9AJr4fGGbxDeI19onZ6cV0IfJLD6BNyqMcy+OtZXMazvFLwIuV6ol?=
 =?us-ascii?Q?2KoSiWrioPmafB8XGii5LxGSkijDZcEjK6F9QdEvHQxF/Xbw5BpLTgmRQkMc?=
 =?us-ascii?Q?jifTF/kSOZBi9bpIG8D9QA0kquEqV85p5E08PQT13E/04mnWfAHC7EzvU0BZ?=
 =?us-ascii?Q?k8aSK/vsQpLo3OcebtZVPqyEDSVNyO6vAmwJseIMMDpNP2PUt2o7UEkl3VgS?=
 =?us-ascii?Q?wVaiSDCppkYooxqEfvbkJrfVhRw0bNzSRJYmQY1HgNpW+4pkl8m6md4Oo0QB?=
 =?us-ascii?Q?Yz8Hmu5pp74FPOSLgOrwsmWmfBXf6V6h3OOVh+sf31XOZHplWnYVssEq4xW0?=
 =?us-ascii?Q?TwqltkmbjkRqJHM6TgpK6ZzfNkeBDoqi5heEGC9QhGhQTk1PM9GcXiJtHhYR?=
 =?us-ascii?Q?g2njDoaj6sc5IaS9lgOq1B6QGOGXvYmoGv0K0I7Fh8QeAvLYJcS4QRWqjQHn?=
 =?us-ascii?Q?w3fbh+Cda6JmlvuXGCl9gllN+iNbRo07groYAbwCHZPClYkeYXL0m/YIK3KZ?=
 =?us-ascii?Q?BU3u7uc1we3QRa2FhATFp/Qv3gO5jiJYcXygaIkd24oi12ZK6+K6cYZ8HMJm?=
 =?us-ascii?Q?9FND9IGUIwXfItUlko4w4J1H1TkIGgRby3mj6ffFf+qn4VTIqzucdkcxAxaT?=
 =?us-ascii?Q?uONY2I8iebdDvxe0dGQW/06N2/corrprr6SYS0Sju6fuFymaOcddh/sps59A?=
 =?us-ascii?Q?VBKf9CNsQ63ULdcXx+i3GLUc59tdSgrQ6+o0VgsY9aOiH2eTUaAfPkgwSVnx?=
 =?us-ascii?Q?uZuaS7AVg8OoVQXhAKqFVjiGIFvw0G3iB6xRC82lS4/DCZIb4SgazgbxFfJ2?=
 =?us-ascii?Q?LBRGpre+54O0i9RMQgFK8mn0saMJpHt/yyYw8a6SECY6irF8T3svL/vi+tsv?=
 =?us-ascii?Q?Zx0pU0mkRN+DLFZ+KMl7iHaPA0iXxsf4msBeqrhxsqGLzHdJQ2S4qwpV1l6S?=
 =?us-ascii?Q?JM9KvQV0+w3l8B/erRPSATQMsaphGiEkYO1ZCjNDEgXme6UmCrMdr7JKA6i2?=
 =?us-ascii?Q?LpP/uLY3a4DZ0Snvys/Zm5pvCErBeUxeMiaKzbmobp3cpdZpk0gjBXtmecmM?=
 =?us-ascii?Q?fxrMkdLafctPh9YAbamyr8tbe59fDxH0aySaFlA7ZIbMZYQAeZ+MZa/+jNjg?=
 =?us-ascii?Q?YNW9t1piUIYzZpRQR2YHuHntTMb+bbsxG28+Jw536FhWfq3IzpTODV7uI4u0?=
 =?us-ascii?Q?noG/fVu/RgAu3RjLfQHNdpf/GigHyN6FK9zxcAG8TVuVxl7CRkax4e0hPo/Q?=
 =?us-ascii?Q?bpv8Im2SvqZGagPX3oerltEIOavrb68iRi2achhWMTT+jcibQP3OZ7tyzs51?=
 =?us-ascii?Q?KaottdMqCBVy3VRn8no+0JrlUMM8IF8F6h0HHbSASyPxeWxy4WBQZSP5Z7xh?=
 =?us-ascii?Q?eBiR/l0XS+7d+FoAG6GgGkN4ojTnjd3J7X7c?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:24:07.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be68680-a2b0-48de-b505-08dde8e57b9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

Hi Kevin,

On Thu, Aug 21, 2025 at 07:41:57AM -0700, Nicolin Chen wrote:
> On Thu, Aug 21, 2025 at 08:07:01AM +0000, Tian, Kevin wrote:
> > Usually the difference between func() and func_locked() is only about
> > whether the caller holds a lock. If they mean to return different
> > domains, may need better naming (though I don't have a good option
> > now)...
> 
> Yea, naming is tricky here :)
> 
> Perhaps it could follow a different pattern:
>     iommu_dev_get_domain_for_driver(struct device *dev);
> 
> With a simple note highlighting to be used by IOMMU drivers in the
> iommu callback functions like attach_dev.

I am keeping this "_locked" naming in v4, as there are only two
places calling this new helper and only one of them is a driver.

Please check v4 and see if you still prefer a different name.

Thanks
Nic

