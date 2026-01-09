Return-Path: <linux-pci+bounces-44399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B75D0C140
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43D41300FEE6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39F1B4F2C;
	Fri,  9 Jan 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PAkUMl6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62C2D321B;
	Fri,  9 Jan 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767987029; cv=fail; b=kLFCXA9IBfTTT+9/Y33UU+OCyCkt0fZJmS468FG+wyA8sAsGjDpxzAvjl3mRsStJuwC/d2s4eEvMQuYbxXGPYmRJkVhT8J4/YPEKq4bOQaS3XE3Dh8sQIYtaejk7vtjNZFhVfyKUvmh+Cy0WbrDrWLohhO0tEOnHEtL3tZW9O2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767987029; c=relaxed/simple;
	bh=IQoGtrr5vsPPSQw2v6dafPXSE4WT8Mv31vN/+h9z72Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UGXzzfDGHiFwo2og/8TQu58nHR9l06fEykKpQrk8akwNQ6fMSwvIvoR7kNIwBb5wM9CfNjjp8dt+UzQjXjwsud8SHiFLv4NJCHFJwIMy2HwQrKWkEKxLoz+XPt2QILkrp1+1RSDo7AD4rj9NoprqQn3iUGdC0DKvKmNvUSDT7ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PAkUMl6z; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQGjOFbU5Ac4ypTSPTPrP7Xt825SFjCqWjIKxzDtYFt7vCsb7ypzQKvlBdYrNtKOR94RyOxOMckITscy+cTBPDOdPJJ67vbwi1t6tftByqd2uGxhb6KI8RHzqXbtZ9RC2RCnYMOmVcEJp8vPazHaC+Ot2nNU/buF6DJegbv/3Lk+3hCPqQvrA8paD3KUC395Jz1pJNEy7w1pE+ZeJMfA+4G05d45lj52oLsoVLk/EgleJBiDp7DWY8564e0ZVVh8OQ8I5uS+1ydAI6CSiu2O17wX5hTzro7wMXtBMPHZ/W50Ycki8+vgDABKWXyfWtSJsDhWR8HSlIWOYZl2RxkO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFoCnbwr1PRG7u1pDH3d60JNId9vfzElAQYiy52KMxg=;
 b=Me2rJcS9gDS0J8a74SKM+srFsR8uWT9mKXjG9Dd1It3cgo8yxU0SlU19fuIIrV+dIzbH5NSRB3gXURU1COwM6dQtBZLAT6LwHXGmQnDth5om54tCOKo1GV7/EMIqpcOZRi/XLEjVr6+ktfjVci9EyIQ8gX1W0El73TdREREST5oNDOFQqeMTen3i8FhA6rFWihJwJ+XoYnyj/ldM7UuG4ZCwRQ4oIoGoKZXDwarBdglanh2U/kQgmc4fU2xhr4xqyxtTwkgSfBnhsXwkP1D5IE9g5+OIdjtCPQP/kHlu7C4i4t3btUx614qczNtgFYeUMhe7YQVNRGdA55puxFCmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFoCnbwr1PRG7u1pDH3d60JNId9vfzElAQYiy52KMxg=;
 b=PAkUMl6ztLymbvzcfgB0CkMRbWksmj6QkKBnNQpHw/FJixQcRHS1cEMjssNly8dz7pWX8r1j7iOeYK7b3tO7YqgFxZJQoOGMn+++RMNqSwDmMEvRvUcfubys9lXBayCySgPWX2Ced3XTGpa6W99VJAzrGoJ6tr0y8JBLw3QYzTbWOtdV2uRPN/VwG/EPnqqJ5XMApURn/QR6beMfqxFy34PgrxVbiLTyV8CeRh18AOMuJQfqsQ0WLkphFOEdaRpU61ZDxCPRzkn+k+E1G4Wp1yrNUngcM9cd3wKK1Pqz4T6KkDaAhpxfpzfSW+cX6BagSWQlv2qWStQWqpO+p3JqQA==
Received: from CH2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:5a::26)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 19:30:25 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::ed) by CH2PR08CA0016.outlook.office365.com
 (2603:10b6:610:5a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 19:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 19:30:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 11:30:06 -0800
Received: from [10.64.161.125] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 11:30:01 -0800
Message-ID: <98048a3f-5a01-4c40-af72-c29d3ed805df@nvidia.com>
Date: Fri, 9 Jan 2026 20:29:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Add ASPEED vendor ID to pci_ids.h
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<jammy_huang@aspeedtech.com>, <mochs@nvidia.com>
References: <20251217154529.377586-1-nirmoyd@nvidia.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <20251217154529.377586-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a9f3b2-c6c8-40ef-2d14-08de4fb58900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWFCY25kN3lKNU5XeGd1UER3VWk4TEZmV2MxZHhhMUw2MjN4dFJhSDhOeFJn?=
 =?utf-8?B?Qkd6YXlFRkJJVzd4cnFUclZ3K2daVjMxS3RibkhROWI3SzRZUVJTTDVTWkp1?=
 =?utf-8?B?OTNsVDNsbkVDRE5NY1hCM3FLOUR5YklHaWNaR2dCN3NDakJkNzZNRGFyVmlT?=
 =?utf-8?B?RHhYUWljVEh3S2h0T1l5aU5pZjFSakhRM0NZRGZwSG9pdWdjY0lJNGtvck1G?=
 =?utf-8?B?RVVOWVViSG9pOFNXWWNWOGdyM3JUVjVpeWE1eDR1Y1ZSUjVMdithdEx2YXBG?=
 =?utf-8?B?dTJ5Y2RZb0Q2QXZZK0E3eTJYbXQrUktTTE1uR0dXd01VWmw4d2lwd1c1K1FK?=
 =?utf-8?B?RVN3bGxVbGZQZTNXUVJXRnpwSjVQYkNsRlQ5TGtRSm4rVGtUMllFVG1ndGR1?=
 =?utf-8?B?NFJuWUx3QWpYVjdHZERvd25mQU9KbnNlNFZmb05FWkg3am1sOTFnL2ZibDNQ?=
 =?utf-8?B?Y3JNbUJwQXdIRmFVM3dkYzc5T0xESHMyZWdJelB2VE1RaGVYNmR1SHlRTEN4?=
 =?utf-8?B?OFFORnRyZGRvVEVPQWtsbVpScDhBVXJkRmR2UUZ2aDJyalpGVGVpMnN3Y2pu?=
 =?utf-8?B?Z2tsQmN2NUtJOWN1by9zVll6ampqZE5XZzJ2aGhaZzlZT0NsczBaSm1SNm1a?=
 =?utf-8?B?aS84d1BSWlN4UUtYMGdzOHhYUi9WM3hndnFYcnRuaFVDL2ZhVG9iWmtKVFE4?=
 =?utf-8?B?NXhKRlVLVVVTTmlqK2ZTVWV1clR2UkwrMGtpa0pteHFXa0I4YmVlbmJsQnl0?=
 =?utf-8?B?dnEzSDdjS0MvTFBySW4rQ3kwV0tpaUZBWU8yRUlMYWdGbHZSTklMUlhiT1hL?=
 =?utf-8?B?ZHg4d3VoVW1VQVJ6dmtOUFdGRVBveHI3TXRucHkrTVFkTXo0TkpHd04xeGsz?=
 =?utf-8?B?WHYweGFYQ0RwRHYrMzdGdUZhTUt0TUJGbEhZSFpzb0F2MWdQWU4xLzVEd2lq?=
 =?utf-8?B?SlM2M3Q4RmNKTmNia2NEWEZreDJkUGllOHlZRTZCM3F5emxqVTNFQmpNU0pl?=
 =?utf-8?B?Yk0rQm50UWJUMVZDOXE5VW5DSUhESTRZWVROcUZFcldOZTJrM2tBTTVVZVdj?=
 =?utf-8?B?SWRsU3M3WjR2c21HNXdDc1lSUFNxcTA1UWU2WDhadzBETjUwTVBxSVVhZmhF?=
 =?utf-8?B?SnhBdDJveHdvWTk0R2lHb3JSUEkzZmRjL2YzTlUvSjl4aDBJd2lGcWVBUk9E?=
 =?utf-8?B?QXR2ejMxczBTdXNGSlNjbGZnTDNwU216WExmaHFEcll0d1NXd0ZNQWg4TSs2?=
 =?utf-8?B?Rjc1ZUNZY29mT1BiTFlSMHZ6L1E3YjNuOEhzaTk1R1NKaE1TbWZlNExna2JF?=
 =?utf-8?B?ODV4YkFjWVAzODB4MWMyUlNWOGpZYnJYM3l2UGFhZFUwbVhVakxNYTA3YjV4?=
 =?utf-8?B?VTNiRTN2ZkdRQXFyOEVaaXFsS3pwUzRhNG5iTzE3TTdyUTRpdXJwc3RkQVht?=
 =?utf-8?B?bkJTb1FiTTUxaUxKVXFyR0VCSEFYajZJZGxndnNhYzUvbU10b0FORDUzTVlv?=
 =?utf-8?B?NElhaUxjaXlzTUNOZDhvdHIzNEpnTzBLUGRzeWRiQldFSnZhb2V3T1FQYXcz?=
 =?utf-8?B?N0NScTJ1NW0xajUvdjc5ZWo3TTl5VW5Zc0NvekVodEhpclN5MjhBaVBSQlpT?=
 =?utf-8?B?RzUwSkl2bDNQSmYrbkR6R1JYd21SR3NEY1dzVW9DTmhMOHV3MWhhZTJNTW4w?=
 =?utf-8?B?UWtDZWNobWdVbEd0UElzaU85YThWNzloV0k3Y3NSZ08ycEN0MTZxQ1drOHZr?=
 =?utf-8?B?YW5OYWJqT3AveG15YjlQZHEyTmloWlNXNjFuM0dQUnp4QWRaUEVLSkdITHlS?=
 =?utf-8?B?aFpuZUl1L25YQXVycjdmNFBqWjE2UG9RYVpWRUdWWCs4RFBVVlBsM2ZXU2NH?=
 =?utf-8?B?SnhIbDBnUWd3M1NuNDhDVWNmZEo0M2dLTTBJcWwyUG4veDYvWjF5N0ErU2dT?=
 =?utf-8?B?SlRXckpYbytlVUZhTTB5elI3K3F4MTNIOEs5SUcxSnRxR0ZFbGY0Y0RFR3ZV?=
 =?utf-8?B?enIzaW5lYzVkY0tkeHdDTGR6Mk9KdEg5NXdzaFNXYjZKSnVrbzBJWEZXc1Jq?=
 =?utf-8?B?ejdrUU16czZUU0RnR0NpTU5HdGluVTdFS0Ywcit4cFZ2SmZ6clhMNkNCTDQw?=
 =?utf-8?Q?PUqA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:30:23.7867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a9f3b2-c6c8-40ef-2d14-08de4fb58900
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698

Hi Bjorn,


Happy new year! Gentle reminder on this patch series.


Regards,

Nirmoy

On 17.12.25 16:45, Nirmoy Das wrote:
> Add PCI_VENDOR_ID_ASPEED to the shared pci_ids.h header and remove the
> duplicate local definition from ehci-pci.c.
>
> This prepares for adding a PCI quirk for ASPEED devices.
>
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>   drivers/usb/host/ehci-pci.c | 1 -
>   include/linux/pci_ids.h     | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 889dc4426271..bd3a63555594 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -21,7 +21,6 @@ static const char hcd_name[] = "ehci-pci";
>   /* defined here to avoid adding to pci_ids.h for single instance use */
>   #define PCI_DEVICE_ID_INTEL_CE4100_USB	0x2e70
>   
> -#define PCI_VENDOR_ID_ASPEED		0x1a03
>   #define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
>   
>   /*-------------------------------------------------------------------------*/
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a9a089566b7c..30dd854a9156 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2583,6 +2583,8 @@
>   #define PCI_DEVICE_ID_NETRONOME_NFP3800_VF	0x3803
>   #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
>   
> +#define PCI_VENDOR_ID_ASPEED		0x1a03
> +
>   #define PCI_VENDOR_ID_QMI		0x1a32
>   
>   #define PCI_VENDOR_ID_AZWAVE		0x1a3b

