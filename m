Return-Path: <linux-pci+bounces-32947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2DB12234
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41DA581537
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E2A2EF282;
	Fri, 25 Jul 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XE4OmoYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61730243378;
	Fri, 25 Jul 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461742; cv=fail; b=LScgvnY+eH6AuXAcx/GIvajm543RQChfBRVYWz/6IcSZyupWbmz8B4l7k96/NFPw/GtpQlPlKD6k6kzDPSC5ZRVWQV+ee5I8Ks71/e2fgh7J6eGFWGZKOaxabpDsrAGpehvt+Zw9OgxinBk32Mm5S1iCT2pwqsy5F/mi6Gv78Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461742; c=relaxed/simple;
	bh=UyZMB1dcPYxNJs078xJnBsifJYkKd+IEUP3g+aDoZUo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4UkwtC/LLBvlrFeI8nZswgzrEzBsPKFgX7JJ3unQq/styT6UN9/nA+360ATwUkIKze9keLBsPw5KBtamZoqkMty0SFvo+DUZPDlRZ0IDhYJQ79GXH/Z2unI/TVqLWPfLavIF7xby0g2Nm9rFS+aIgu5h0Yeljb4TPzAyxYvDnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XE4OmoYD; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0yn7HGNXbMA04KPbT8qho4gwwFAaMwLitCil7Vwlb2fXPJsG59v+Ut+T8dzoN05YVqle2dAoiPH8AtLaQwm3Ue6ySW5wwzvNbUorCdN1shY2AwwLBTQAcLVRqKu1o6rfNujufQ4lVVDUy+jXIfXU08U49Vj9aG+pHB1iQzKTrSOJ6voS+HCZjbhLJdQZ0N8UzHZkEHrIGPf4ENTsPM6h1SO3q6iIDMz4pGYHdGs4rTiXhhIqGFnDjMQOWauB+3eNG5W8jhs0W8awc1yjFsgqikYGEnCiWKOiVzFAkrY+AxDGIiHTLaMUWsWNw4fTg57iOt/cbLmw9zLQI+4r/CNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cEw2jGRRXTVNjDx8dNqM7En4f2cjK+RJPnjm/RqJSU=;
 b=CHeC+7JTlBhTSs6oVvyMHSdBIp0C5+CVNB8wbJvx7XzVQ1fU0xYtKacym6yhAQs0gvOJjcqBsVoC/Jgv5sZuD/8Ojd23KqwkzS2+Xpl65yTQ+nposo0DCnzOYbg2skVM3OxsiVMaX5Nhfo9tQC3UtuLLWtTpSLFfbw+Cdp6CH8F3aknsJS3VMUU+NqgofzTAXT1SP0yyerxZbMbvrdrbRfUSRNg3xkNnMYFqVT8dYylLEv0Ly4MM8Yi2XAzZb2UUVaGq1ddbZSfKIZVRGy3r0FUG6icwDP6IZEdCg5jUuMrQRXFc8RITPFebH/Z7MJx/F2I8XGO0T4yLJIsbFQmTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cEw2jGRRXTVNjDx8dNqM7En4f2cjK+RJPnjm/RqJSU=;
 b=XE4OmoYDa+Tmw0+MaIkZxIozURyhxTYi8os6kMP/t+WWIa/inmX0Ak2ZwWZzjh9eU/K7pxhk2rZSvPbN0C3bM5+Q5yiLTasafbnwNeU/mHe76x/8lT89kGKitmdsjOwuMhIpIBaW0Or8naQAVp8cTS2eb1PTt9BFybkFeecmUYF9oKG3tx0LVjjpY9bO5N3boy9nlIdaNtpJ/Apc7I5khufn9xkiFF2fKCN2d481UK7LQ47/zc6YmHSIdtU+ueJGxeyzuKM+5JSMgTQre8EdqvKSS3fJ2bRSC+iQIhLupw/28Wc+YudntjEJkSBnv2cf4g4cTrzUCbBmFtxp2XdM5w==
Received: from SJ0PR13CA0172.namprd13.prod.outlook.com (2603:10b6:a03:2c7::27)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 16:42:16 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::86) by SJ0PR13CA0172.outlook.office365.com
 (2603:10b6:a03:2c7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.7 via Frontend Transport; Fri,
 25 Jul 2025 16:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 16:42:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 09:42:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Jul 2025 09:41:59 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Jul 2025 09:41:58 -0700
Date: Fri, 25 Jul 2025 09:41:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ethan Zhao <etzhao1900@gmail.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>, <helgaas@kernel.org>,
	<baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 0/4] Disable ATS via iommu during PCI resets
Message-ID: <aIOz1bzgfK9q0n4b@Asurada-Nvidia>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b234ab-94ce-4b98-1b85-08ddcb9a3725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZyhEi2D+lXWw0sI6YM7NHdhhBU++5S0CobsBzxNEwBmRv/x7+1oYumpXFGk?=
 =?us-ascii?Q?ytohOxdv0mylpjZgfuG63qCWz9kfPgyazKy2ib6m0pZ8OmbIHeGpGMtJ8hr5?=
 =?us-ascii?Q?1V0AtW18oRzaT8zm6ozPqw3hgx7IlCUl0SUPy8QLpCQ+2VZLZoEo68wHZdV6?=
 =?us-ascii?Q?v2yQTQ57eiido+GZCH0JikrdixNhmT/2X4J/IPhM+M4NQfhza9oZKnB2EWjS?=
 =?us-ascii?Q?Un8e7UOb0pD9wU+IGUO+mecVqL3OZEtU8qNPbpn9o0zDs+C7CeF2IC+YgtZP?=
 =?us-ascii?Q?zJUFGdOHwSZuYNb23XjWRB0vPhRozxpFdIAbJJ5EVUcJok4n5xzvPsCI22ZS?=
 =?us-ascii?Q?NHRunguvPnQ+WPmefzVNVcVhtNRbqcEPu3G7zAeHkt0Jr2JnYo5b7XPwQAFD?=
 =?us-ascii?Q?FRksJymMWbMbEWCeUz8MNEV3qjsz1isB16VCcF8RI9V9GnXkR5i2wYnhVd2A?=
 =?us-ascii?Q?eZL/NQQ/mQrlBtPstf8uGLGDD5YEAjS0QvKSouTP5uvNWYlJy917g9/JPfYW?=
 =?us-ascii?Q?G/KiwhJGrO4nDoZHV0Djz6uUWdrTQCSOaQFSXaNPblnTzegCnveW4s/REExR?=
 =?us-ascii?Q?V4F+PGz0CcO5gLqZB7k+WZ6cu1H/FNgyjP96EDpSl9QlsJteqpBwXY8Xz5o/?=
 =?us-ascii?Q?ab229L2uocikIQ+1DKTYv/iHESr7jhdRUG1mlAHGbk68VdgSALX3fbblcQ80?=
 =?us-ascii?Q?M4yz7SRC/2eWZmcwb0kJheLqvSxDFvvOYy/tyvn+IfqFZwBQfQ68KrOYcYpT?=
 =?us-ascii?Q?juVY+YWqm1EUNUa4q2oYAEgJPTsazw1s5sYljocFm6xGjrRWL1p+yD/NMMN1?=
 =?us-ascii?Q?xKTeiijeTAxv/uo2Z4D1hLW/7pjQz7Usk10ik49g6QtkKxcIb724b8RAH/LR?=
 =?us-ascii?Q?+3Lo5O1KymwE86Np75m0GI+havFKGiV4EI+bK462eBBH6isgTBJ7rIXM4PZg?=
 =?us-ascii?Q?J4dCOd2e/MGpiCIujomeoog/wo9lfSxHvHsrrxy4NL3MBO65hJw1aej0kNo9?=
 =?us-ascii?Q?8ddubwOOcixVHH7bej7Y0hlVIEoyIy6d1ikY/tvaxQ0RnEKKj839/xRtnVTS?=
 =?us-ascii?Q?G+u2T/XSwKgQNSAG1D2qm3R77EyAHZ3qce124VhaGvGb2ndgMIVRxD1LlXdo?=
 =?us-ascii?Q?JB0EXhrxNBHYw2aSBTKCqFllJAJt2zlqNOuHR+8XNcnTEpJBAvc9JzIQO1fj?=
 =?us-ascii?Q?AH0Inzce7Kkpk0k4j1kGcvEc0TsMjiJExZQ2lZon5GxYXqx9TDRe13RpbSeD?=
 =?us-ascii?Q?2Ua+rJ8eAmrKG7M48/CLwccwwVnsCT90v6TF+xpv2HDF6LEd8wMQ8nNwhT1R?=
 =?us-ascii?Q?ma/R2I/6cRTS2kGK3rmh8+IiFV7SvREZkPkXlDjH+hAfjbAutypToRYwu8Dz?=
 =?us-ascii?Q?LSO6G5XHA5Fkv95S4CAtsDc2Ovlp3q7zPfHpPgFHGTelDFRRUbVv4LASSj4X?=
 =?us-ascii?Q?vXUxAooyNz4uOGonrYVi7sJ2hRYRsBui503qv4nCERZIJzzW0vCmlWbbHdJH?=
 =?us-ascii?Q?O2HcNSIxQ6dLCWfoRl1im0h7bdLk5l6F/vV7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:42:16.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b234ab-94ce-4b98-1b85-08ddcb9a3725
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

On Thu, Jul 24, 2025 at 02:50:53PM +0800, Ethan Zhao wrote:
> On 6/28/2025 3:42 PM, Nicolin Chen wrote:
> > PCIe permits a device to ignore ATS invalidation TLPs, while processing a
> > reset. This creates a problem visible to the OS where an ATS invalidation
> > command will time out: e.g. an SVA domain will have no coordination with a
> > reset event and can racily issue ATS invalidations to a resetting device.
> > 
> > The OS should do something to mitigate this as we do not want production
> > systems to be reporting critical ATS failures, especially in a hypervisor
> > environment. Broadly, OS could arrange to ignore the timeouts, block page
> > table mutations to prevent invalidations, or disable and block ATS.
> > 
> > The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
> > block ATS before initiating a Function Level Reset. It also mentions that
> > other reset methods could have the same vulnerability as well.
> > 
> > Provide a callback from the PCI subsystem that will enclose the reset and
> > have the iommu core temporarily change all the attached domain to BLOCKED.
> > After attaching a BLOCKED domain, IOMMU drivers should fence any incoming
> > ATS queries, synchronously stop issuing new ATS invalidations, and wait
> > for all ATS invalidations to complete. This can avoid any ATS invaliation
> > timeouts.
> 
> This approach seems effective for reset operations initiated through
> software interface functions, but how would we handle those triggered by
> hardware mechanisms? For example, resets caused by PCIe DPC mechanisms,
> device firmware, or manual hot-plug operations?

That's a good point. But I am not sure what SW can do about those.

IIUIC, DPC resets PCI at the HW level, SW only gets a notification
after the HW reset finishes. So, during this HW reset, iommu might
issue ATC invalidations (resulting in invalidation timeout noises)
since at the SW level the device is still actively attached to an
IOMMU instance. Right?

Nicolin

