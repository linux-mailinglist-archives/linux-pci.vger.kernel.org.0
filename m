Return-Path: <linux-pci+bounces-34520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEAFB30F0B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EB43ACE40
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E392E54B9;
	Fri, 22 Aug 2025 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8YQS/SD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9C1C2324;
	Fri, 22 Aug 2025 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844555; cv=fail; b=gu3gOkuQtmd0KmDrg8G6uUreXzVOYUdesZMHP6YofvglSyAhGtsIvqSaxkRTRjMQwmLjjdFkzaWl57XwXbn68NmevyRPzvxK0S6orhaVGRxEZq1CUg/hPR8j6AhEESu46AngygQzIkvV/XdxpxEbYGeg451m+kv7yMXBH9XWPHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844555; c=relaxed/simple;
	bh=uXfKph7AtR1antxfRpH44a4CDfBdtLSmkiyudXJCkX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG215w6fH8PD5pmIYlg5WRIQzoXmVVxK4UxX2QDd1/vAW4GOt/c7MTiODtrBn3wPObCIEfGkyziJMaCBvX3KER7Z+ubXr9KFWeQqj4YRLAgR8wI23N8TDfyBvihknidDqz1hB6mRuoPp+zosk4ripwfU6Bgl/OG2rKTgKLCcUTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8YQS/SD; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9l8v/r2LaCp6Ltu5WaGe77XYXbDQNBTPxbbHUuHykcqzhGB2QcQg+3hZGzxhKcl6qJZAH2rC4VYCNjCdGugJylNF6BODxwx3rnUCFn3ZRO+Gayut3ReL247xrNs+9JdvWgu6BLJq1+4b6N0AW1QrylXrUKv4Md2SL5P2+JLtL5PS0WxVTMgPEBgekU5S61PuYnQrg7/AJZ0pznrPKclYAGVBxzUeFQpgql9m8nEk6Pm/jyBfx2mtNT9AA4EN3dC/Zw+EnshWD7GDEJAPfTWJeywcyZ1mWT405WKG3cu4tkk+X//4TD+qcPVDz/ycvdxHsiEPYqBk+I0ad0rJuliAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSaBx6ZMpvbi8an/DIsinjDx4qcpumfHMlxHMB027a8=;
 b=VlmOudrxTzS2ph5z5eGL54X1kquqBZTF3/mbMvNZpWEclmGeUkn93nizCSaUjI55a9EmN3Na8bSlvOGCHwGB0Ux/XMbYUOWXLR71h5skMRw3FQ4OCnq9BPqx8kHK6oo0oXSTWtxtuSu9UfiZff9jKFT4T3PTjAWN3ithnkHzN1PbVVT5pXGC9hchiX+5Zm91rN8HGrGD+8DU6jJkmoP7rMJBP9uVf5Go0slAJsZCqnEX2doPG/cbITqhaokV4i2i+xWbVmzcnToEQIAq9DbuoBeQFDdPeDU1jaCdNp14McbyNcdgYeHL9T3fJj1tImxuQXWHzUOQxjqNqzliEZ5oow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSaBx6ZMpvbi8an/DIsinjDx4qcpumfHMlxHMB027a8=;
 b=M8YQS/SDHjbfRSGIdPlzKLNmRnds+kpCe0ErLj6+d5xylS9DZY99dOdzqGHBR5W2pu3ACmvFHHtXOsux9MjgiixODhw+I6PqOaNcCHNir2ov4D8wOwih1iozRkKAgTJ+HZ2aWqX/MBizFsRR2yQhz/uLCKLpHurvqeghwbYOBvFfOucXxGCJygbrUxNgqCB2nNfVDEmBacGYL4RfxCp4rLAMEpuA0m+CQL+mWd1e3ayZ6JJwEL5x27PC71p1RpU9lWeR1KyXE4W3cpEoXGEbNw4TJl+ze6WL8alEYclKcGhKcOs1rexcBH6U8JVf+wlWSfT2NCVpIybgKS9lVq2PqA==
Received: from SA0PR11CA0077.namprd11.prod.outlook.com (2603:10b6:806:d2::22)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 06:35:49 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::af) by SA0PR11CA0077.outlook.office365.com
 (2603:10b6:806:d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 06:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 06:35:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 21 Aug
 2025 23:35:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 21 Aug
 2025 23:35:31 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 21 Aug 2025 23:35:29 -0700
Date: Thu, 21 Aug 2025 23:35:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Ethan Zhao <etzhao1900@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <will@kernel.org>,
	<robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <aKgPr3mUcIsd1iuT@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
 <20250821130741.GL802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821130741.GL802098@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: cca042d2-1c0e-4496-2be8-08dde1462254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZ4dsTPs/jiTU4IzPa9jyKumxU+3mch7NtrjaFEH/bTk2AaqPEBHVJyGWtB7?=
 =?us-ascii?Q?3eNpQgQTWjpBZCmNpQratT4Pbi5PeR7IOua2305HEOtXuBqjDE/4VahNI+gl?=
 =?us-ascii?Q?bxNNPGU3HqWwhdPZKDplkv/QcVkVhfFRP1sHGVtqpaiLonY2+DabDzpx7PHm?=
 =?us-ascii?Q?v1w1JFXNai0agi8MGYt1z5aWIDPRGUrbHtTQf5WDILxpVl4RAT58N3FzYzPz?=
 =?us-ascii?Q?E4pluT3n4E3MJXZaeIoBS88aSIaidSgdbdU07nWlJ6JhJIpdQ82W7yZ05VNy?=
 =?us-ascii?Q?ueLUsIs8t6EtByCoj3R9oSSHAYkO2lHAf6/emSrQc1mThjwEo2EmOML3ZGFU?=
 =?us-ascii?Q?LkGaQ5wQyE1G4QnQiYryGJ+AUANN3p6nAiR9ycxvQLCJokAssmWpUn8RDJrE?=
 =?us-ascii?Q?Pu5qZ/iAYK6IIvgrSecWwj3HAZhTojIpa5FgeauZ5SEVe5Mlf3aUQI2bC997?=
 =?us-ascii?Q?Cl5MBJZ2mPbG4j95UNFV5gSEac2CiSfw7kqotXZsTBjSbcGhLlEFOqT5h1oT?=
 =?us-ascii?Q?UK/mYbR6g096T0zPJoWifh0zRcOstMq6qbjKwz4vAOkVh7Nux1KMe0KSm/fK?=
 =?us-ascii?Q?C6zMnzDtzjI7jSGSttL4vYjWcGJVbE59W9IBIJ2H3yYLMX3MC+zLYXKdtIHn?=
 =?us-ascii?Q?v1u7XlDQkpCk3Hb7E3A8n5u6lbuoic+L/8q/91Nv5iOllQC41ZXA/bDlic5i?=
 =?us-ascii?Q?iFArhPSxpNig1cITCEMWWhPbh9yl88rc7r6K8/P95zEWA8zQPajG3x/OYphn?=
 =?us-ascii?Q?TzdfTtfyfZ+ZaKDdudkuD7dW8IKY/e3M+RRHTvtWubpOLCOxFDJ7ZT/ZiVzf?=
 =?us-ascii?Q?igLlx41Bkyp+As73B6wcuPJ+F0IU9V/BV1zEomz7A+ebVZc1WGzhfqFoKer1?=
 =?us-ascii?Q?xjvc8eENkV6foh4M/8gvZa3FNuvWaGq2ydm23uCpV1Cl3IMxn1z43B7DK2Mz?=
 =?us-ascii?Q?reWvThrHlNA3S17/NnPLMHRWXoh9Jekl8sYJN8Vv4WvgA6JJEqtfPIJs5QkA?=
 =?us-ascii?Q?GFHOC+/b3haFZmzb0zLhT8EumKVNVgneq88cG3m0s6xrtvX4uUKpN1ak4SHz?=
 =?us-ascii?Q?AcCC6/J8Y90If/qnjHl8cJpUOIuwR76j3oK+qhmH3oometCXInxCsl8k2N+a?=
 =?us-ascii?Q?GuwM9yUk+54RHFZC0tAJo1pUdmEJC+J9SVJVSxBknH858tfL6f/7/Adu2RUU?=
 =?us-ascii?Q?pLO6F2bQMrw6OpNfwGnR0mcJNsNZ1BaAFkF9A+QQAwVdKm1QPcHjCe4C7ARH?=
 =?us-ascii?Q?l6WAPJhVfdysaC1rcUQPEhdDW1viFEZMRvy02raO3xkdpBMY0DO9O/IfAP+c?=
 =?us-ascii?Q?kE+s+0SN9O59VZOYENa2qhFCfVTh4u5QzRU01ntBogjthMj1E675NT+jt2/M?=
 =?us-ascii?Q?kvdC5bR6rcKUqt5PCxUEfesa0PwRyKkQy6D3tJKJ08qcruSXz6Wy61qIGSUf?=
 =?us-ascii?Q?iZTe4aFGuXFv+RnErRVq2eD/vQEeGsx9LDGBVMeYFNDau9Qoo9O1iXFxL0BD?=
 =?us-ascii?Q?M279IbBLpjtah4/VibLPDSsyaLiRrUI0Hqus?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 06:35:49.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca042d2-1c0e-4496-2be8-08dde1462254
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773

On Thu, Aug 21, 2025 at 10:07:41AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 19, 2025 at 02:59:07PM -0700, Nicolin Chen wrote:
> >  c) multiple pci_devs with their own RIDs
> > 
> >     In this case, either FLR or IOMMU only resets the PF. That
> >     being said, VFs might be affected since PF is resetting?
> >     If there is an issue, I don't see it coming from the IOMMU-
> >     level reset..
> 
> It would still allow the ATS issue from the VF side. The VF could be
> pushing an invalidation during the PF reset that will get clobbered.
> 
> I haven't fully checked but I think Linux doesn't really (easially?)
> allow resetting a PF while a VF is present...

Hmm, what if the PF encountered some fault? Does Linux have a choice
not to reset PF?

> Arguably if the PF is reset the VFs should have their translations
> blocked too.

Yea, that sounds plausible to me. But, prior to that (an IOMMU-level
reset), should VFs be first reset at the PCI level?

Thanks
Nicolin

