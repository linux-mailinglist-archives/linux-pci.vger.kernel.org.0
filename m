Return-Path: <linux-pci+bounces-10553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8893795B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B72B21ACD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D713A87A;
	Fri, 19 Jul 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hgLhP87P"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322F2F34;
	Fri, 19 Jul 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400624; cv=fail; b=jKGxyu1xYFwp3KDZHCRzcrhOh8Fh+7XM0Xwuah9z5DH4AVIhUJenkU1sTLo+tXYK0eVgtIHRsux61mJqm3wa8IQi3ZfJyCKtW4iPmz/cCC2RbjLYs7uB1ns3M6C1PyDVCzKxHpCcWma+yodNEU/y9x7/Sh/MRlKusyrQvUKoFk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400624; c=relaxed/simple;
	bh=sk6bagv/harPPkC6ayKvHGhuR47PSSuLXDiFQqOJGNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZbl3L5xcTCdjaWxvPHhscqpyHSWRiI80MBXNMmVQjVRGoyduUAUfUGB4ID1ENiFh0wrkxrqHHO92AOeKqyvU9SUJdWYqvF4mRyksGA/VC+OV5DDzcaF74+TFTA74DVqg9wzPz8f3bcFAjcye3q284Hck2yEQWDZ9E5DlNXBoT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hgLhP87P; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NU7V0AHPJhgUm7EwiKwVjpXlFUstkdumuUIYGv/djq39qadc0QWZCM01713CXsp1UUF0pjDvEhMsaVRs25GJpZDm6bTuC/s3jAB5Zv5r4nsQNELHuT70WCKcPuO5lDdiDbM9jmJkU6+m6llBwYaM8byHd7oYoTRpR2pq7ZMFXhL9fGrnPWiNFvTEHEQypTSXdogQDgMFlllemavB+lX3r4le9uNFR1aK5HqfSDCNh4NTmeGD9LmjGiZamaF2k91pWtSUJJERkay8xxiB0eI+WdxfUggPoYenl7Upk1MPpNvfAFuYf9/rEmebzSpoVRU6CFBWqMovpi9qbh0G/i6x6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSEBlVh8KDUjoLCLyeXPPXuBsvC500znqfmusHqvi7A=;
 b=D8DqX66UOGsUfyc/KaJFapTuaQGtxtRQzI/jG2wX3WFN5WnaJ07oNUbgmKAKqlmNnG5NUPOEuJYp46as7pCL8FZRSdvfcoYFERY/Ntc1hHyRlK7dAW8/fLqaH2U7oOXaQ6gvap2QyNXuDDBDc2/02BGzQFVXE0LRWzeJAaIjQBL3UtoJYRTRZpNexbQRHpMNQvVXa+wXj25tkLZTxwRQAL4GSIy13xl3jd2VNDtW3JnBlwhG+V26dEdgrgKWVsupryYDaCPZDl8N5dYhU8YhD9MY1jku1ZDDPW5EU9dTLluQgDp/is2p8EtEy4gLHzIfzphElamkiCXbpCOQex7wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSEBlVh8KDUjoLCLyeXPPXuBsvC500znqfmusHqvi7A=;
 b=hgLhP87PQtjiIh+vAdSbt4YIEzBDjD7xfBlqg0EjQTpUQVr/sVutXi8Mp3lj9iyiJiGaeRdYrt76HFHqfDwPY1Vy7xxWUv4pJRBRj1A1O7hLb6iIrf4FKZOv/gimVNfUBJoiQNtU11Lf5GEn8UbvGItGUsX/fis4kQTtxo2VxWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 14:50:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 14:50:18 +0000
Date: Fri, 19 Jul 2024 10:50:09 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, avadhut.naik@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH v3 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20240719145009.GC17507@yaz-khff2.amd.com>
References: <b99685d9-9f3a-4c21-8d33-2eaa5de8be54@zhaoxin.com>
 <20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>
 <20240718062405.30571-4-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718062405.30571-4-LeoLiu-oc@zhaoxin.com>
X-ClientProxiedBy: BN9PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:408:f7::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 78385656-0bbb-40b4-9652-08dca8021b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLIAebiHnQUFUImyY8by7yg74qJ8FjDC9CicF1mGG/x2UeDm9hueE5bjyXtW?=
 =?us-ascii?Q?wgD5nLyWAVn57UVWfBuPEODweXyqLFgOBp4VknhbESOliBffHR/8rh5iKD0B?=
 =?us-ascii?Q?MIaXL21X5MXusLJapfEXz+oX6X5VCy1t9h4YOSDz0uMGei0sqg/IoACEgmxV?=
 =?us-ascii?Q?ALsA/txlJbAV3Oq+H/6f+Af4OVnvF/uFlSStvVlba5WmZhIa0w9ziSm/Auwa?=
 =?us-ascii?Q?qgk4vE3CR910kUprvlW9xBkLyLbyMpLAWY+3CCKMrHmY2Dl8e8fzle3afX6S?=
 =?us-ascii?Q?DyJ5Nkh63wp3xPgamNCIp1XUR8i17D8D4LyCyxQUFjH7laF56vNorNZ+Gkry?=
 =?us-ascii?Q?2FMC1EkVsGbRoKrI5PYBsOY13UetzuTOk6sBVQYxX4OGEur1f77BeTks8Tgq?=
 =?us-ascii?Q?zT1h+0nvsN4P03y84Oq404IiPYjUW+UPpdapoiVFaYSfs5cvH9n/eh8qyKT9?=
 =?us-ascii?Q?C4mXKLrNsjfFGYQJLXk0drPPiIEc7r7xOE6hXIZvW7zaMfBYxuqI39GRQ2xC?=
 =?us-ascii?Q?g9sZMu4n8AU5fpS2t1vmIyuTJcNxvkD+1wpM1mYqEf5VsVtUib01ppOqLeNc?=
 =?us-ascii?Q?Bkh8ErbVmYRhscnK0Yv7h1uQHc2GV1KB/q4rv3u5usUjbE8eueOnpK1yOhBF?=
 =?us-ascii?Q?84MK2s1XegKlg8EHswtEDqnjV4SgASheuUvlMrIOK4R78s8a4E85lXCNADfa?=
 =?us-ascii?Q?DO2nU1lCZPcXiXlGAYNddbEfxh5EON5NKNCNpD/eIbLK8WizvnYSpMZfXVBM?=
 =?us-ascii?Q?pm4QtI53/2mft626s8vJEgDY3vQ+E+nwoQkKYhNlTyYN5Hu7AOP/0R2iAbfk?=
 =?us-ascii?Q?7cTWLi3mfUCRP3GaEm1wfNo/MgRSYzNBo/nFXR3G8P5irB7EjVM1FLiot0Td?=
 =?us-ascii?Q?pcMJDF4+kyk8OGbfq7NcKql3WjK9oWEM5jl93PSDoRv+EhrSXttTEG/Kzrp5?=
 =?us-ascii?Q?EhBooSES/8E8bqtDUBMT0O64OQjp3E3zinKVNoYkAPBH6DgsvLtaNv0t7kYe?=
 =?us-ascii?Q?vmHRGHWWmqpgJXOGYTqlzZF5Y5CIoW2qodhhuvfI6Jr5l1kMp3YCd3FBhwuU?=
 =?us-ascii?Q?RFJDbnmVvuQLGfEq9Iu24Ula3SEQGl86DlrjcDF12XN9AoEpZaVqn2kCi5lt?=
 =?us-ascii?Q?zFWgHVRCAmmqTgmLrXWft/SHAGy5U3BNhFlUcvYegov/zfiBalJxCEzr1BAj?=
 =?us-ascii?Q?QPUaFEDl3ExZ0DIpaN9b8RPe3lWjpvjacZ4GOi5tG5Yw2j0POZe0U275ba1P?=
 =?us-ascii?Q?y65sp1WGvqpqj8+G9PMLkg1dPz1Drt7AeYjeYl+JDBDOAk3r6F/eLurnhA+Q?=
 =?us-ascii?Q?zR2c1VtCEVPe+hUQOhDOr+Ah+RAVD8IeuxVM6bqyQkO04Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UZgXvIMp90hPdnSeDkSuVY9fiFk0/fMJHSFtTlWOx2KjdZuK/rdZvW2H9dsH?=
 =?us-ascii?Q?qdKo32mJvbIAdx1rdMfPf6AXfin6N2RKlLxMFh0LTunn5mTyL1Q/U0Dcv8Co?=
 =?us-ascii?Q?TqeZa1Jqp/J7TzHMcztgNjqRGPsdjWhmjFyJ0jy9/bMhr8tNl+6ZmGMOoumh?=
 =?us-ascii?Q?g3jy5zwTlFEQpDWYbvajgX72ZGKeAQDNRsQoH+bgSsQ/YuASc71GDBPjH6Cu?=
 =?us-ascii?Q?Rz2NP3lbCYBnFndQLxox60gVCUT68TRqq2sSqKYk1f11X8Sx/0fhPps00Qom?=
 =?us-ascii?Q?u+gRKMszH1z7YAAjhDVrakHpjI0jDwi73i23P91KP5t9RTeTMfpbRx06I4hA?=
 =?us-ascii?Q?pLAEQGgSm3Xy+ORD0Tk2j8WAodTOxqI+Q5n3Rme8WR04efSjj3RCmLuq3ggp?=
 =?us-ascii?Q?vdrPGuMJLGAtltnIwzBCSmWhDFAxTkTKfRfq7ck2q3rvicHfbXu14Vh/WznQ?=
 =?us-ascii?Q?/pgaIfGFtIVTJvlZDQCPa8FhZAKbMvA5hSaw7Bczx0yBwWphfmvUC9VNX9AX?=
 =?us-ascii?Q?bXL431QjQ1mEtHRWrQik5x6teTkfDgXCthKWEO27H8j33xlzoN6/YgrHJQdD?=
 =?us-ascii?Q?ntfoArsWoWDTpZIAUeEHlLwGL+/4/00t/3BD9CBHPt0RJVpqvlE+ZBJbSiUB?=
 =?us-ascii?Q?xYDmSPghnMu2YDPqFOSE6sKSY/3MNkAtNRVy0//EV9v7VxraAAWcsQBfxn+3?=
 =?us-ascii?Q?gitWkURgLPOpRi0fmoVUWS4fBolkm7tbFeIb1YFphFDGC40T7jBVE/hbla1j?=
 =?us-ascii?Q?NXVl8ApBHhp8u8mtHtQ4Q5L1xouqwjb5c1FDAv2qHzoCaQXn5YnuXStTwIgi?=
 =?us-ascii?Q?/idldsK+cj74/XQKGLsU0e/YmgKEN4KFAm5h6PdlB+8POfykzdRElvlP/uMi?=
 =?us-ascii?Q?3SD5d/DEoEwicfAUFUCJEx2oLelGLBfbK8wX2bka+ecVpiaWjHQE9cWJZPtO?=
 =?us-ascii?Q?jBkYhC3a6p1sxTm+Hnu/lfk6f1yyopqyU/kX3gjY020QZBbBb7/nc/MsGHsj?=
 =?us-ascii?Q?vKgdlaT4oQ68Q2GUByEVEglyjc5bSot2ELaiVQXF6MISF97GPb+zCz2TRDNg?=
 =?us-ascii?Q?fgdMpn/Svxs35y1kQbstHpdSrdRicg7IVbx4N49an/2KqBHDyiJ+lNcnSJ26?=
 =?us-ascii?Q?yTYbR59ikJyNd7X8faXiwzSnDm3uRhhdEzUm9SL/NzS0fFroEOsdOrQidDQ5?=
 =?us-ascii?Q?0YiLmsFn4IPtoq0465zWB+QWKg9awymsB1YXGCHJmNCwVNFrTphpyuHRrmp+?=
 =?us-ascii?Q?ng94+BfWj+94SBsXGfSrUceX+NYFVXFoAdL2UsNMIr/2E+zryxT4VrQPjjjR?=
 =?us-ascii?Q?v6jVYD6XYlTxm7NW6zH3ih3VMet2XabWIowpSbsHTT5I+ZQIwa8ABI9h3Hau?=
 =?us-ascii?Q?O+OYSaCbVZuR7qdQOWX6fbtyG9g4d9qpdt5agfk0ysSy7EdEyTbBOF4b57s6?=
 =?us-ascii?Q?lUxxA6zJsxqs04stcx7eyJDS+r8nxAPVaKs9x9whIXC4vghllbkFI/qJsyff?=
 =?us-ascii?Q?0ZcuBm0VIPTJ9ZesbX8Z9s2T+ibwKTcpvNWYNGY7H/eo3UY7N0ZVe4mU3uZC?=
 =?us-ascii?Q?pWZtZ+UF43r3iS2jLDx1HnBeyKF74r/ryzh/WDXq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78385656-0bbb-40b4-9652-08dca8021b2a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:50:18.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i1S8ySb7pXhSInBCiUX3ZGoDtxXl9oruQ7llIeY0uzvXYHhpWQimBayo9V1lliRmie8x45zzwl3bKZNOqTINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

On Thu, Jul 18, 2024 at 02:24:05PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Call the func pci_acpi_program_hest_aer_params() for every PCIe device,
> the purpose of this function is to extract register value from HEST PCIe
> AER structures and program them into AER Capabilities. This function
> applies to all hardware platforms that has a PCI Express AER structure
> in HEST.
> 
> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> ---
>  drivers/pci/pci-acpi.c | 101 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h      |   9 ++++
>  drivers/pci/probe.c    |   1 +
>  3 files changed, 111 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 004575091596..b522e8b226b8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/rwsem.h>
> +#include <acpi/apei.h>
>  #include "pci.h"
>  
>  /*
> @@ -783,6 +784,106 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  	return -ENODEV;
>  }
>  
> +#ifdef CONFIG_ACPI_APEI
> +/*
> + * program_hest_aer_common() - configure AER common registers for Root Ports,
> + * Endpoints and PCIe to PCI/PCI-X bridges
> + */
> +static void program_hest_aer_common(struct acpi_hest_aer_common aer_common, struct pci_dev *dev,
> +				    int pos)
> +{
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_mask;
> +	u32 adv_cap;
> +
> +	uncor_mask = aer_common.uncorrectable_mask;
> +	uncor_severity = aer_common.uncorrectable_severity;
> +	cor_mask = aer_common.correctable_mask;
> +	adv_cap = aer_common.advanced_capabilities;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
> +	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
> +	pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
> +}
> +
> +static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root, struct pci_dev *dev, int pos)
> +{
> +	u32 root_err_cmd;
> +
> +	root_err_cmd = aer_root->root_error_command;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
> +}
> +
> +static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_bridge,
> +				    struct pci_dev *dev, int pos)
> +{
> +	u32 uncor_mask2;
> +	u32 uncor_severity2;
> +	u32 adv_cap2;
> +
> +	uncor_mask2 = hest_aer_bridge->uncorrectable_mask2;
> +	uncor_severity2 = hest_aer_bridge->uncorrectable_severity2;
> +	adv_cap2 = hest_aer_bridge->advanced_capabilities2;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_severity2);
> +	pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
> +}
> +
> +static void program_hest_aer_params(struct hest_parse_aer_info info)
> +{
> +	struct pci_dev *dev;
> +	int port_type;
> +	int pos;
> +	struct acpi_hest_aer_root *hest_aer_root;
> +	struct acpi_hest_aer *hest_aer_endpoint;
> +	struct acpi_hest_aer_bridge *hest_aer_bridge;
> +
> +	dev = info.pci_dev;
> +	port_type = pci_pcie_type(dev);
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!pos)
> +		return;
> +
> +	switch (port_type) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		hest_aer_root = info.hest_aer_root_port;
> +		program_hest_aer_common(hest_aer_root->aer, dev, pos);
> +		program_hest_aer_root(hest_aer_root, dev, pos);
> +		break;
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		hest_aer_endpoint = info.hest_aer_endpoint;
> +		program_hest_aer_common(hest_aer_endpoint->aer, dev, pos);
> +		break;
> +	case PCI_EXP_TYPE_PCI_BRIDGE:
> +		hest_aer_bridge = info.hest_aer_bridge;
> +		program_hest_aer_common(hest_aer_bridge->aer, dev, pos);
> +		program_hest_aer_bridge(hest_aer_bridge, dev, pos);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
> +{
> +	struct hest_parse_aer_info info = {
> +		.pci_dev = dev
> +	};
> +
> +	if (!pci_is_pcie(dev))
> +		return -ENODEV;
> +
> +	if (apei_hest_parse(hest_parse_pcie_aer, &info) == 1)
> +		program_hest_aer_params(info);
> +
> +	return 0;
> +}
> +#endif
> +
>  /**
>   * pciehp_is_native - Check whether a hotplug port is handled by the OS
>   * @bridge: Hotplug port to check
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fd44565c4756..03b5339f399f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -731,6 +731,15 @@ static inline void pci_save_aer_state(struct pci_dev *dev) { }
>  static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_ACPI_APEI
> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
> +#else
> +static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_ACPI
>  int pci_acpi_program_hp_params(struct pci_dev *dev);
>  extern const struct attribute_group pci_dev_acpi_attr_group;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4c367f13acdc..f7d80b2a9d1d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2267,6 +2267,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  	pci_configure_serr(dev);
>  
>  	pci_acpi_program_hp_params(dev);
> +	pci_acpi_program_hest_aer_params(dev);
>  }
>  
>  static void pci_release_capabilities(struct pci_dev *dev)
> -- 

I don't see where this accounts for _OSC negotiation. The OS must be
granted control of AER before accessing AER registers in general.

Thanks,
Yazen

