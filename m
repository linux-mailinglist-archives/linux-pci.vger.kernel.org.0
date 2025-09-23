Return-Path: <linux-pci+bounces-36796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3F0B9713E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B6D2E74F8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F8286D7F;
	Tue, 23 Sep 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WLAPkdAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CF284B2E;
	Tue, 23 Sep 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649500; cv=fail; b=YDdDtoea+hSNM8vsBDgABG8Q/3TGWSpqAE5TFIldKmBMgtinNhBCDGhWxMzYtLJxso6c3Y9RSHtzX4+gJK0B5gGQat8OXYMywi/wK0WJl46/ZrDOEb3mwPazfqoEbNiecEj+roYIYhZF8cLGXD9R9fiN+LJc4bsuUQ0EBs/DvJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649500; c=relaxed/simple;
	bh=FuX4X297hH/+2j7w0VlSrU6r+VCn+BioX2j1XjyvsIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L/SPID74vdCUoG9R67g4vdXBB1b3J586z5RRw7Vut2vZzWRFBRJEVHHWRVo7UsOQVPJHMstYFOFbL/mQM5YakJwJiRw3kaR8K8KHd581da/nzIBsTmJ2ANT16wWYT2DM6dOCGG/4FMRFSpch9o2591Z4rxGFdfcWY6cy5o6AgWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WLAPkdAi; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwMTghX01vqRw2fZP3EueonWZ9A6lYzqlJRu6YRxbkefs363lyjm4ySRg3Gul4zOA8julCqqoEmaowPNldw3n7EZHXQPoqasfqwfHmSsVKVlp7bJnutitzPyLFcL5C/atepEbxRyAz3ncfinqHUChbtRCwM7aQm/Q18uM/XlS7fsNnYq7mZGYYoeCmnpRsNVY/tVnPP8avYK0bUyIKuSystund10/yBm/3wJ3wqh8fAAGefQm+y+YQ0T6VHV5MjyNiZjd03ZfnQPKVVpFm9t3wct4jx/T0jdCqKaGM7x8sb60I6ZKDCBqzl5q+hsYtILR3efJ9MYyAj9wL44t++6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7fXghZprSkEomIOakBTE94foja5QniDVrPAQLNg4tE=;
 b=m7zy6XCEuNS/6qWZt0Oz2V2Evg59swCDfgy1Npj15DckHLCGkJwd0+jYJ5Z25ue21mb4a6Cncbm3MiyHhaAnsg5S1/lkhDCHQ3B1I+AFXURLGENKaJj09p5ghXEZli4Zn7dY402kRFm9Iam7fmkUHRX0m49BFG4hdYxeqytcyaTYstnDOr3eQZEMvdeZh7yFveg321ff83IaG0wXQ84svlLgvlrhIvSSzzcSCGOFERzP1+BL3ydfOQbUXG6tXoBUHIkw2quOneyxHwi43bDO1LSBI/T22DrUdL5Cr5MW0JdQYsbZaHiTEuSjL6Z755P8gtr2SnSfYzR1jBX88DLY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7fXghZprSkEomIOakBTE94foja5QniDVrPAQLNg4tE=;
 b=WLAPkdAisZfDQJ7er2qZKvSOL+scESPMg2fVCEJaPYCYM+Owg0gJw1TfSDK2hqO7u9dA+GiEbuEu0UBgqYVqyD9Qy0usGfL3bxXwmYSVion1VEPK7WVDSGGAOJBF/+ZLznSDuTU4zRJJzstyyt9JibsM4WwTusFZHaw3run/y16LTUf64Zndt+67SNHJjeSzM84ntTdygK0i/XV1Gqh/hyytjRTcJBv/bLlUoLrUQwsCrc7hRhIaDtS+s0fHpXJqWm3o+K+hAaXp6+2X+obM77iU/NI3uI5KOLHjhDj5NvngQAAGFZ1wbelVROmyw823DpmE/XNgXM0Pbx8P+5W/5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:44:55 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 17:44:55 +0000
Date: Tue, 23 Sep 2025 14:44:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
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
Message-ID: <20250923174453.GF2608121@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20250915123515.GE1024672@nvidia.com>
 <aM3dlQH0rk74w2CH@Asurada-Nvidia>
 <20250923172229.GD2608121@nvidia.com>
 <aNLa21vMlP6kgatx@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNLa21vMlP6kgatx@Asurada-Nvidia>
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fcdd46-0cdd-425e-adaf-08ddfac8e7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6caAF27eS8EYoQA4ygLz4CrgnOS5mtwxgaVT7PDoogDDucTkfIqlFVO6vFn6?=
 =?us-ascii?Q?jZ1f5wUyTiSc7z2TG1aXbG+BA//4cBANjTOlzbJl0e8PXiOeuDKWiAQEEN+g?=
 =?us-ascii?Q?dMyC37Wk4HHhj5/ekUkO0SEd4OBANzKy9b/J9Xny1BU/Eq/PBukjrQzX8c/X?=
 =?us-ascii?Q?ovJqqUk4ybBMiKzQQkVEX9otipPFHalxu8hc2x6J8VKwDRblkMmP+xA4dYLh?=
 =?us-ascii?Q?7pnCt8ofDQ9J1PjqNne7GUTPJ4uGJD7FpkvvbcUBHdUn8onPQfl8Bw7ekfrE?=
 =?us-ascii?Q?nRWGBANnAkLoQtFbgJNjMH37JdwKQHmxfmxUV+yDC8baHRAPHM2wXuc8hWAr?=
 =?us-ascii?Q?huvVr2YxgXRUzOQJMOfHKiW2FJFtxQ4+AojyAoj8mhKLoLUh2DGNAKlQCYXb?=
 =?us-ascii?Q?+zKxizuk1nBRj0Vb+eWDn/aInsd00w82laXV7dq1sLtaUG1XO538rKip0UP0?=
 =?us-ascii?Q?nFWCotxfjmxxK0vwFNtBcXlZSP/2JVX70Blh2FbJX5ODMgdNxtwlNwDcvx90?=
 =?us-ascii?Q?5CLlLvT2MAI9gLElAVnk3C13RCp+jnAzUfaw6lqT8AiU3caW8oFdKUwB51Om?=
 =?us-ascii?Q?8kDr82lyDyVX/sagkcxhSeRL2OKvB840tHfvia33bOEJSZnQPqKI4FHLWtVg?=
 =?us-ascii?Q?/08MRYMa4HKEmivcXCig2tOqBOJJv1YGZ3e8FwONmYRZ6Iuy+REr3Mqo4rMG?=
 =?us-ascii?Q?IrV5z1tbH+8wlrVn8EcR4a/DXz5Vbms8cWDaj1vq69Jt8yXOCEfj+k6WNw7e?=
 =?us-ascii?Q?ZshZf5PBRmS9nEyb/dMvDdNjf0BXElVjJYrmHxhxjIS5GZfYeFPR1SuEHEH2?=
 =?us-ascii?Q?0QGMDQrlSMiHHDmqCr/BOMxoSsjb8TDJksv5nrazdzuUSwIgwInMMdDtN1pg?=
 =?us-ascii?Q?gySjE8V1VbXvySVDyfCM8NEkG+UcOuBN9jWnygRBIypNWrMBUAopxpQS0K4S?=
 =?us-ascii?Q?ZHLNqAYj0xoEncv/SUK/BLO0xRFXuMr21YF5nTA1+5z6+WJiYGRTIAOtc/YA?=
 =?us-ascii?Q?GUPtUfF5vdalHY2TJhGeDFUOUn5cvu3xkYYs4Kz3IWIaHzNFv2I3C8XdNZi8?=
 =?us-ascii?Q?APxzwkhM4FWqMIlDMXHEK8RrS1t6AbcGgXy6q864vxHOEE647tc4nAvyS+KA?=
 =?us-ascii?Q?ra6iBojH1JvJ3DOBmarohIf4uzK6Gs3u2XZuCOGPgQYqjkYe0cjIGzG1T05k?=
 =?us-ascii?Q?UAnQQWdAYa3VYrjIDdngKuZVuDiVOdeudY/HhFBzCRPQ4pJ+WTzCmK4AL/kg?=
 =?us-ascii?Q?9en0ra3M15AB4t/5E5sy3dOqGWlGyHdfij9gFNyiL4dbQdAnRpTvLmT+cMxY?=
 =?us-ascii?Q?PZ9suW3Nz6T/itBolr5g7GLEBWY56eCa7Sp0bbhE5FpB5kgFjRlIJS2Smi+C?=
 =?us-ascii?Q?81CnD54YomKQMgnpwpBHdAKgNk5g8WCD87KsxuV1t0LNFbp7BpUZoIxSBS8n?=
 =?us-ascii?Q?ZNvHfuoa/RM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ibl/EkcekxoPFYpv13foA+I5azZ5NulRS5zHpBgCSkl+nyNBPYoSVZB9H4CN?=
 =?us-ascii?Q?ZBm8a364YpchUGXzdMY1tVUggIWmh1LycUeNoFkf8/pPkVN5nFfVUSjINJQw?=
 =?us-ascii?Q?Yl5ez8XenMVWtcHKufzPmlEdf075seH55AJJnlGS3QUDlmqMkWpn4yaavVJj?=
 =?us-ascii?Q?dn5LXt58PYo4/BkOR9PfyAkWzSay0XUVI8Z6SuVK5JK9iGRtzgx+8v/wkZBF?=
 =?us-ascii?Q?QFqzIsLNMm+LzjBltMtBYxNIa7Jv/cLETLt9GyUpWGD3TvWCdI44D7R5e+qA?=
 =?us-ascii?Q?hfXzbrNts6q2j8hvnrGWtXOTA+DI/eMsChDNjSOfbnzqG5CF53UxRvjyXrim?=
 =?us-ascii?Q?nsQPcOAA4y2eQKbV9MG8tHevj+EOq+QquYVzJOorOeWOeSpRh5+OOYSVfryb?=
 =?us-ascii?Q?V6wYe3sclpJYrV1I8AKSrLIOcjC5w0F82oRzIqViB3axEw1orR9Fis/f0RiT?=
 =?us-ascii?Q?LaV7mhkrtgZestyuPqJM41agpz2OpRekh5WO6yb1ChuOjdrNgOckm6z4oX9H?=
 =?us-ascii?Q?qunTJ6TdecI0YOWGk+OP9/CALBdqhzG7Z/gAoI5tZHcMZNrnWgV6l4SQ2ZKy?=
 =?us-ascii?Q?lbz6Q/rcbwZ/12sWn347I1LgQzjbqhdfsOEjAVlza7efhNL3FQWHh9ZYNkYf?=
 =?us-ascii?Q?q3eX7DLbhCLmPhVWYocfDbw0f+N/nDIA5VP4A8qDjuKML8pXKbfTkD3+zytD?=
 =?us-ascii?Q?5aoR02sOPaKR58K7G5qKfF+Uskb3hQG8jNg7aB+svtGDJm70e30X7buY9apA?=
 =?us-ascii?Q?MEJ139i3fzo9KzQoKjG/iZPyWRN4zE1xVXaEPlyND5k4iB/BwHoQYMEIj2p8?=
 =?us-ascii?Q?1yGt7e53Wn+MKvI61ZVbsu49HIzisPdEi1IbGG7eZU/irfQvuVQQgic9BJFW?=
 =?us-ascii?Q?PmzlTNncdD06MFVH8XIV3vMvB9c3sqI6AzJEwegGI1Zdiik+Q0D/nHsB9bzk?=
 =?us-ascii?Q?NpTkxM69emHuvuIkiObj3O4nUA1+Wp/J6PSmt4cLxjsl5/db98Ghrqo+MkSM?=
 =?us-ascii?Q?nJ1haj+cAUvWdwtSAoqCuIn8Lzm+MVzJQ9OyLT0j0VCcyca0i2tXVtZncVrE?=
 =?us-ascii?Q?GgbwxpDZejWOwPmTnl7drYBqAb5U2NoLI2L1ae0qAMYqfyk+YUpCSWH8oB0o?=
 =?us-ascii?Q?d6w/E+icIO7CTAQI/iQDNsDdRyuGt/Z1suvEgILYLtV0T4qPgJXRFeZ3Kc1o?=
 =?us-ascii?Q?ZTa1o08/m+EA1lcJVbAosL9FbQcV3slfWQkCxaaglw303prsmtjGX6mqQQ+m?=
 =?us-ascii?Q?dJuoNh9Xiier/AVcOdYZFbu6uwD6Mk2ktihtmkgeENWa8x72bOXyTuH8ylqj?=
 =?us-ascii?Q?z2KatFL2XX2a8vDs55WqvQShigHWNQGAxALrNKg6wb6KvyU+1XHcfV0m+jnE?=
 =?us-ascii?Q?xXZ5D/DJYyd/j3mRcNyWQn53rA7+Fx5PxTNJaQYCmchyxymg9E71+4PA7DeJ?=
 =?us-ascii?Q?uMHkzlxq0dsJv8EyPigzDewM8ebVoL/Kf2N1S2RmCTqzzFuep5XnO7HpRTpd?=
 =?us-ascii?Q?cyr6DLsc1xp2XKydKUk1gt1c4iXMb+76PYu+eBrkZbcNDJM8SM4LSkqQ6Fzj?=
 =?us-ascii?Q?AisQDohQBfNNO1fm5DL5rGFf6a2eUClZQeJ7Y6x7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fcdd46-0cdd-425e-adaf-08ddfac8e7fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:44:55.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45dJcyPLr/byDY5hgOHKlITgcH/5VXtfqhOzJY9K3f981w5rEaESNvo3nCkljwSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

On Tue, Sep 23, 2025 at 10:37:31AM -0700, Nicolin Chen wrote:
> On Tue, Sep 23, 2025 at 02:22:29PM -0300, Jason Gunthorpe wrote:
> > On Fri, Sep 19, 2025 at 03:47:49PM -0700, Nicolin Chen wrote:
> > > +/* Same as arm_smmu_blocked_ops but less set_dev_pasid */
> > > +static const struct iommu_domain_ops arm_smmu_release_ops = {
> > > +	.attach_dev = arm_smmu_attach_dev_blocked,
> > > +};
> > 
> > don't worry about set_dev_pasid for the release domain, it is never
> > called anyhow.
> > 
> > The intention is to just use identity or blocked domains as is.
> 
> Ah, I see AMD separate release_domain from blocked_domain..

Send a patch for AMD since you found it?

Jason

