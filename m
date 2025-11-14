Return-Path: <linux-pci+bounces-41220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BDAC5C26B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AE444E6681
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A52FE05A;
	Fri, 14 Nov 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iXfsI9i/"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C423741;
	Fri, 14 Nov 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110953; cv=fail; b=o+PiiIVJMGViOE2X96sKURCERF8t8JvcNqmo4VwmTOZckZKXLwBdjIoq/A8HdY3fFSfmPLKrjl3fgjcD9UbH/3AjMmNAAzC9qmQ1piWt2iQkZLxe1U/oYQ1rLzPy5O+KKaptc3nd7j4JB8zM9lA2rZUmmQilNd7qYAri/MgJH0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110953; c=relaxed/simple;
	bh=s7dTvWgUWN4PhPdiV1Nv5iflxGftpsaHRQQefThN+k8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx22DnYCFnuSNWDDOl849bHnEA/ROmBM275VbSCP8qbuRhb8eiMpeTWejz2ru2KEMDI8lm/0FtmQxBH9b3qfKo+JCFvkHzZTYrnxyCRFdOHraQ+1E9nkbpuJsUPmuN4ibzG+mluY41QXZXcpIpNi1IuRPJIRg+1TAgROuWAObOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iXfsI9i/; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8RJs9Kff2Tz2g3eHazIKE3FEYaQDwkaM4e1k6NmYwSXAJAjOWc2AjTxsLnqeE7H2kUFCD19XgKQOskRE+UZIbwdRAaW5ocL0lKKBIzfCBkHGfEydLGznXnYvipT+hiQSmMZh9aKfNrs9iNv+ip+FBxFJnZiVGdppzd9rAt0QTSkxrMsg5N9iGZJxcqBoGWDxKSVav4ywt8Pu/CHOeOcOaD9YffMt0PC90mmhVi8PD01z7ay0N5v4oYl5pQzX09ThuAcXlGDn0o2bVxAhfKXG867w2yP8RdOamEy3574nR49THHsoFZugOPHFY2NTwXEKS+3BaUY1Pa3u47D0cBLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyllwrKLjfX15Z3eXTyT7NS4hiVtOam974bw6nDnpNo=;
 b=T9KbKeGdnY9y+xB1gIQNsaXz8xC435T8JttS6ak0S+34zv3Js8/ppSNgl1YqU5aTEMvOqIn3SjomqW5A3P2oGnTPQE0/6wUhOm1Mayz4ntyRM6m4dzJ7dQJiNs55ascGmY4mh2GBQ9DNiGBawjNR++/uHSXretP9JELKVDqFg3hrRjAYkJKRocLNipd3DaHMRR0hq4S8VI9tf+up4FOK0f/8kTeotCM8f8wTMVD2aYjyUorD+on7cLeJX7JnDQ/U2ui/rKSPzZn/6k+5tuclz2DwWU5ctnj5gCXb90573zXBg/w/TrOYN0z5GI0TjeCW3AkBx+P/msd0aCWgCe2CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyllwrKLjfX15Z3eXTyT7NS4hiVtOam974bw6nDnpNo=;
 b=iXfsI9i/3SFUcTRIHIuefalPobDNTo2wa6qZ+WPoA9geD+IehJkqclLHAxi5ZS7Cxb0cdyOts2Md5dN6GkQXcV8pyntAMDkgiyr4odNqcXTnTae5inHcQtj/f3n/jX/y3yA7tWghodH5r4iscCVCWCrQJPXwKqkFwLet2wvs8eQ=
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Fri, 14 Nov 2025 09:02:25 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::a9) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 09:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:02:23 +0000
Received: from DFLE114.ent.ti.com (10.64.6.35) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Fri, 14 Nov
 2025 03:02:16 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 14
 Nov 2025 03:02:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 03:02:16 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE92EqB1715068;
	Fri, 14 Nov 2025 03:02:15 -0600
Date: Fri, 14 Nov 2025 14:32:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, "Zhang
 Qilong" <zhangqilong3@huawei.com>, Frank Li <Frank.Li@nxp.com>, Dan Williams
	<dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/3] ACPI: TAD: Use
 PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
Message-ID: <20251114090214.z5lx2rwog76j6opc@lcpd911>
References: <5959587.DvuYhMxLoT@rafael.j.wysocki>
 <2040585.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2040585.PYKUYFuaPT@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 2854b1b8-da11-4119-83bd-08de235c8672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JKPahThiiPXXuEyZrC/TGug22ReFJ+hRbTC37nImDorTikJwqb2wipBRgEH3?=
 =?us-ascii?Q?RKM1/hYleFJQNbnzr4/KlyxqH5VaUXZBpMxcLZRUUsV9IsmfN5epYIFU+Ebe?=
 =?us-ascii?Q?dvvCBf00CGGXaS3Yc5BGkq0k/lcJONCEzvFIG/JwAObM+3Wy/uwto5yaZpkA?=
 =?us-ascii?Q?Ii0JO0rRttfyOYRGBvo8sDTT18rMWG/BbCw8eqCd0Ir/uPC1aFgliylApJ1b?=
 =?us-ascii?Q?F5a4683sGCzedjTBCmYRxeFLpMUpOx7B7HzT/PiAFlOejtAtV+M1Li+4LWZx?=
 =?us-ascii?Q?qMjX4hONIpuI1MyYGsqLgAbTsFm6C74v6X6hTjfYccHnJS2qh0Gm0T1P0vxO?=
 =?us-ascii?Q?45hC9K8D7NO3Oixa/E0o9Rxwr5KR1kVF8VlxjrNgicuJ8ZTpwPcBTGCnkyDz?=
 =?us-ascii?Q?hIZlFW6d8A4pTOSuawtSJS7+uo8udsez0mkbbOssyzSzg50eXTMzScKQ9NDN?=
 =?us-ascii?Q?eQwDRNIqw1VVK1VoSnaIfR1bjSTJ7oDD3/jyZqxVpqCObscYL2w6gEAeOsZV?=
 =?us-ascii?Q?+G+J28aeaKVIoDB3d0PcTEgY4XU8Umn8b8W9ihgE7KcpPwvdqqdF0T3Az/lJ?=
 =?us-ascii?Q?C5jsUW9C/dIYxc3aUe6nsGGOM6rbc6lKa9fvo9TXChvMfXCPuCc5XHIWiHkO?=
 =?us-ascii?Q?GkQeCeRFDH81BV8owVzUzJB8aYhGKKMZwDV4rgWk2fK7jZtz9QUK9serFjvW?=
 =?us-ascii?Q?0hAC4jPMzCjVzFakCOcvFkBYQ5aZoZ7R5pJhUYo9jMdqBGqDYio2ShJrOQR7?=
 =?us-ascii?Q?6CGO6rsq0pK+5TL16ee2u00/TsHTahQsVb86b+grcYInbSH7mX0UVC2t0u94?=
 =?us-ascii?Q?bNzwZmGSrR8XkLoCXgQXu8oQHE+nu/TTKmne+l1xVAkcYrjJnV/Ya7QJpykk?=
 =?us-ascii?Q?gTdhscWa6RNpDonQMSD4RWAU5k9ZoRPBKL0z2QVOBXXgSOcp/u2nDiTLozTj?=
 =?us-ascii?Q?Cj0qOo/VGhppYn3x98HwULZA7ovOEi5U76LT83ir5KEN8K03eCcGLcpKtIfw?=
 =?us-ascii?Q?5Yi/2WByS88o9aQYbvdKZdz53RFG2lTFiVFQWqnTEmE+byONHI9ajRQ6K1Gq?=
 =?us-ascii?Q?vXx9vz8Gak+GJ2WT8oa2GLqwS91P2DWqbplCAtI/Dcl36EVGr5PABg78/KDl?=
 =?us-ascii?Q?MFKIQWEyuh0xlXjUTR2H69SFYhXDPu3nKv5bSHyLmEq6hcdR4UPACbRgIxhD?=
 =?us-ascii?Q?YLlrzP4nEL40wPYBySTqz2X1acIs/pzhfYDBuu1zySKiGibnEj/RJwbpJBNu?=
 =?us-ascii?Q?0+xGMr6Y6APLaKKg65O9ZlrqTO8pgbIo/VN082H82KC5X1B5oVto2r4ct9gx?=
 =?us-ascii?Q?6d9iAQHsoyq03N6tHT8RkUUA4LQiPFIfQR1p6zXLg+pHYuxxJIJbFYJUTVwu?=
 =?us-ascii?Q?KEOnzz9zHp6FypUCOqa2YFuw9vNCYJJ2Nki383KQD4Kd7UGMEda41zBJnbbf?=
 =?us-ascii?Q?xKKxkomthof4KnJXrxsIx9IC14Bbr+oKPknuA/kSBJWJm/klaUOpeK3d2pam?=
 =?us-ascii?Q?fYpe21OOu9eEzQD5pMO3Lf9KQ9Zouqa9Lf1S3V2DqBGY6W2DI6xG9kdD2pPE?=
 =?us-ascii?Q?0nYIh6PVm1Lcr0Y+jsU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:02:23.1868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2854b1b8-da11-4119-83bd-08de235c8672
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152

On Nov 13, 2025 at 20:34:53 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macros
> to make the code look more straightforward.
> 
> No intentional funtional impact.

Nit: 'functional'

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Adjust to the changes in patch [1/3].
> 
> ---
>  drivers/acpi/acpi_tad.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -90,8 +90,8 @@ static int acpi_tad_set_real_time(struct
>  	args[0].buffer.pointer = (u8 *)rt;
>  	args[0].buffer.length = sizeof(*rt);
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>  		return -ENXIO;
>  
>  	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
> @@ -137,8 +137,8 @@ static int acpi_tad_get_real_time(struct
>  {
>  	int ret;
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>  		return -ENXIO;
>  
>  	ret = acpi_tad_evaluate_grt(dev, rt);
> @@ -275,8 +275,8 @@ static int acpi_tad_wake_set(struct devi
>  	args[0].integer.value = timer_id;
>  	args[1].integer.value = value;
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>  		return -ENXIO;
>  
>  	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
> @@ -322,8 +322,8 @@ static ssize_t acpi_tad_wake_read(struct
>  
>  	args[0].integer.value = timer_id;
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>  		return -ENXIO;
>  
>  	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
> @@ -377,8 +377,8 @@ static int acpi_tad_clear_status(struct
>  
>  	args[0].integer.value = timer_id;
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>  		return -ENXIO;
>  
>  	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
> @@ -417,8 +417,8 @@ static ssize_t acpi_tad_status_read(stru
>  
>  	args[0].integer.value = timer_id;
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>  		return -ENXIO;
>  
>  	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
> 
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

