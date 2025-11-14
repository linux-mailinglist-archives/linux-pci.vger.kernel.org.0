Return-Path: <linux-pci+bounces-41218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D3C5C196
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 09:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641D03B410A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788022727E5;
	Fri, 14 Nov 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R4VUaI+X"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6412DDA1;
	Fri, 14 Nov 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110450; cv=fail; b=QWPYux64/a3ARzJMV/fOPfAOXzb3jWlXuSsgf5cfwaa0XGEnB771hLrLpOcrH8vjkI1DL5tWvV84u+UOMuqsJ4vbpqGFbxWgXeAoplv4+FY8SM2nSPJUeZpBtAX4Xi4p7KVN5Zepwml8yPjgZNz4pVkeww3HgsGP5HjHpBvdOz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110450; c=relaxed/simple;
	bh=Zb5GZcv9XoRmTonp23BK7ahB9LApqkp945KTCQMbYHw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHjuIO0Ql+krdf2m37O5xW3NkmPSmVwmUbtAHHwLyEtV28mvaRP8EyVJsZnraDS4iV7o38GUXieq+zdVJPID4JEufzJ3XKu/e+HdAhxYgtvCoiNyOd+7OcjnQ+ajrJqflRnxepgNIaak9p30sHAeQHhzItq0mP47ivVuSI7Q0Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R4VUaI+X; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS5TAotEWZ/bUIlQKlpy1mrpbQ0XXo37fhZTnfmWkDFk/pJxY2VEi5qNEDkA6oJqwOBCVhSwCiANQG5/l8oYfuq/XN0tmxk5ZyKUzgAdZuIN5g68Vwd5xJaj8hGGQ/gslFPoQucdqjFDvKn3JhpWl79eJ9veSl+W+yvChRf1ubxB8TOB09ieOQ0HCrEXgOZFzMc+FspJPePBxJajzANjj12g6KdAZKc0IlxiNJ3jYMrriGHuRvD+01WlWT0EdAkxKFdTc9m+iuKj/SuVvqy0mh06+qanju2ZIa54Z8hCUv87GmMFqUUMcepgQThAikWtDpSvobeQqfOzvICFCIjTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0P13tOeq2Cdkfkq5eQBJXHqLUwgm9+Yl4q+wgEvcAI=;
 b=r0kSJKrWp/E5sCEgCm9EmhasT0PFBs+FwPnXrjaEOAdRXgUmFYWphDfoy9zrwad99WM+X4riuYaPAQteCBjnDeiOzXDrmNnSWuD/7vCHmYpEhozeSrmZWRWu7U9lSgggo03i+ytaPYsL1fC6VPYgmuAFMe+j5szF0fdlmWXZPU87d/sIWlbGHdDCSmKbFCQuTto7MDXJ9lYpn8REfGtrgygQ5sVHTc3/MOTCWFAB1qQqWSzVWMqJRYMjE6a/Sh/u85+JhkTTO1mQFbtJqODlMIPPNuZ7KQf7UGpBBam1mVpqTiLO9KuPxl7xc4JkmgT+0jppyOG94XjXCo3wvJobIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0P13tOeq2Cdkfkq5eQBJXHqLUwgm9+Yl4q+wgEvcAI=;
 b=R4VUaI+X5vcNLIFDirs7y1OrrGX1Bo1gaPIMHRfZPvYoz0hDrc4pX8EIEcVuNFl6WQcnMIpDg1s1GjtH4IjKO5bp1JoLdFchYTQVOwdTaO90q3eSGYY5FKOr4/+n2C2mKk/lBbB+pvAUwcGO2hIJuNK8O86vFYRB3O/TRX9ahW4=
Received: from DS0PR17CA0010.namprd17.prod.outlook.com (2603:10b6:8:191::26)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 08:54:02 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::97) by DS0PR17CA0010.outlook.office365.com
 (2603:10b6:8:191::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 08:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 08:54:01 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 02:53:56 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 02:53:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 02:53:56 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE8rtJi1740195;
	Fri, 14 Nov 2025 02:53:56 -0600
Date: Fri, 14 Nov 2025 14:23:55 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, "Zhang
 Qilong" <zhangqilong3@huawei.com>, Frank Li <Frank.Li@nxp.com>, Dan Williams
	<dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/3] PM: runtime: Wrapper macros for
 ACQUIRE()/ACQUIRE_ERR()
Message-ID: <20251114085355.qgz54ekuivaz2ah5@lcpd911>
References: <5959587.DvuYhMxLoT@rafael.j.wysocki>
 <3400866.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3400866.aeNJFYEL58@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MW4PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7db2d1-3056-4db1-4a70-08de235b5b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?58l6MbdVXTpxs4RA7BKd1SzQ8naRtjMzTc+OxMhaWLU0b8+9HUiIjFQq52JD?=
 =?us-ascii?Q?Ktggo0AhEkHkgHgILDOLJwZUnE78J8l23IN5gkw+N35+QqbvAKoqXxNu+NhN?=
 =?us-ascii?Q?iVyq6CXpEinrnBcUtw9IaxRHa+dUixbVZWD1wMRsePV2Ny9qeqdIYbietTjP?=
 =?us-ascii?Q?S1vHHZyLDrhNtSfzOF9eA4EJj/HzoliUOP/wfhIrdEJPsYUU3CFUxvj7wXlP?=
 =?us-ascii?Q?sgVxq79zz9UZQB7TjbFM0FgwOZ6RF3yDUa3/rtfMy016my3Jhmo4rSwuKCbT?=
 =?us-ascii?Q?GpyThfuFQdIiTNELpzIuIEFFtcqyFT2KIyy5kNr3uNFmaHTLwkW3GwWjKMQ2?=
 =?us-ascii?Q?uw4qoVtv1lid4oRBba0WWpwnttUQia4scEGi6mkySgsJYL+nawCsWdXhuqQ6?=
 =?us-ascii?Q?qbpDz0FLmlyZj9KJoWlrjxm8TH3s38eiSYW2gNKLCSGv9F4zMNvfvcp8ef2I?=
 =?us-ascii?Q?qugvz2iK59G0g5dewoTKf+vGfZcIImKmI50MqebIBrksSlZ6Zb+sPuSCGO00?=
 =?us-ascii?Q?oJspDNnWSeq3z22mjTwCkK6Jw1X1YNmDWYxQ39+om95j5WWjStO1gAqGjqvT?=
 =?us-ascii?Q?L9HSst04PDYIaHW3ygRybaM0WGA5IXG3uJhvVxlYY4ae94Ti+PbWb5sdkCtN?=
 =?us-ascii?Q?p4M+aOFkI6xn5aaOX1R52PT5v5rt8uDFVDrAPginWhpmxvKyzJr+lNHIFr4z?=
 =?us-ascii?Q?AFiURDVGsG+cdohQlKwAOIEFIqJ9TFwmcy8ySPDEEG6NzoeBiVO791LHXAN7?=
 =?us-ascii?Q?IgCtZLA68d1owU5gwtoK6uQX0dJclhn25k0vPrdiR/3UStPdFJZoSEhIQVKa?=
 =?us-ascii?Q?u6/pER++z+Q5BRUi/ed+N+wwuHEipIhGgO28rGk9AJbj4NKkaWUwgtUwqtmF?=
 =?us-ascii?Q?axUk+E7WvQt3p8KywK28tPoQbH5FjTYg0jHa6Ua5ZRqA2EnB77LUrk3LqLhC?=
 =?us-ascii?Q?mNz8qkTdjbpGGDLcQePgYYP1fF/OQAu2u5Ax6zhCMU7zW1CziW41jc8KXvGH?=
 =?us-ascii?Q?g9S6zI1MwVkW5lixHjKCGHyvCKB6JoSKz+L6cEm7sA1XHhO+duZ7W37WpG2b?=
 =?us-ascii?Q?FGlsmCgUk1ZIk2pfDoaMUJbTIRZz2KDfiyla+MQJnWS2RsScjh5VvDL55Z0x?=
 =?us-ascii?Q?D7iXP4Lr+09viElFoFfx8sxf3JW4GzXqq7vTzkOP06uvv0DsXkqU1rUjPhzL?=
 =?us-ascii?Q?lhAw1RcQ2T8rb+aD3CM56PLpJY6gxsf3pWHntHF2zKnKXFo0lbRQwChDIGHD?=
 =?us-ascii?Q?OO88FPGA68Azypqe7sMOJaIPozJYm1PC8OsHqkj6Tf4lIhPyG/BvnvQCq/Ko?=
 =?us-ascii?Q?iY527RtbPoOK5LyrmxoA7655yH1+Coax6hKrGSRPcJUTDeem8cbxeXZaMDkd?=
 =?us-ascii?Q?iFYjLhbfNepqLcya3mNVN3lO6zAlv4ARLUT44ZMfZEOEhmhMcYG4sGTthUnG?=
 =?us-ascii?Q?S5o7ppseFY0AmtuFGW5dZBw5KNZGFN9rzusfBvDsMpjCv2Ar9niMKIFSMSCI?=
 =?us-ascii?Q?oImlSf41RVWdlMsVdJgefV9ALy7LfZ+xcL7lMFgNOZ5YUafe1KK9lzY1BLC7?=
 =?us-ascii?Q?sfKccK96p0szrVDLe0c=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 08:54:01.3402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7db2d1-3056-4db1-4a70-08de235b5b4c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680

On Nov 13, 2025 at 20:33:33 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add wrapper macros for ACQUIRE()/ACQUIRE_ERR() and runtime PM
> usage counter guards introduced recently: pm_runtime_active_try,
> pm_runtime_active_auto_try, pm_runtime_active_try_enabled, and
> pm_runtime_active_auto_try_enabled.
> 
> The new macros should be more straightforward to use.
> 
> For example, they can be used for rewriting a piece of code like below:
> 
>         ACQUIRE(pm_runtime_active_try, pm)(dev);
>         if ((ret = ACQUIRE_ERR(pm_runtime_active_try, &pm)))
>                 return ret;
> 
> in the following way:
> 
>         PM_RUNTIME_ACQUIRE(dev, pm);
>         if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
>                 return ret;
> 
> If the original code does not care about the specific error code
> returned when attepmting to resume the device:
> 
>         ACQUIRE(pm_runtime_active_try, pm)(dev);
>         if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
>                 return -ENXIO;
> 
> it may be changed like this:
> 
>         PM_RUNTIME_ACQUIRE(dev, pm);
>         if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>                 return -ENXIO;
> 
> Link: https://lore.kernel.org/linux-pm/5068916.31r3eYUQgx@rafael.j.wysocki/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
> v1 -> v2:
>    * The new macros take the guard variable name as a parameter.
>    * The new ERR macro takes a guard variable pointer as a parameter (Dan).
>    * Added underscore prefix to the macro parameter names.
> 
> ---
>  include/linux/pm_runtime.h |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -637,6 +637,30 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>  		  pm_runtime_resume_and_get(_T), _RET == 0)
>  
> +/* ACQUIRE() wrapper macros for the guards defined above. */
> +
> +#define PM_RUNTIME_ACQUIRE(_dev, _var)			\
> +	ACQUIRE(pm_runtime_active_try, _var)(_dev)
> +
> +#define PM_RUNTIME_ACQUIRE_AUTOSUSPEND(_dev, _var)	\
> +	ACQUIRE(pm_runtime_active_auto_try, _var)(_dev)
> +
> +#define PM_RUNTIME_ACQUIRE_IF_ENABLED(_dev, _var)	\
> +	ACQUIRE(pm_runtime_active_try_enabled, _var)(_dev)
> +
> +#define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)	\
> +	ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
> +
> +/*
> + * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
> + *
> + * Always check PM_RUNTIME_ACQUIRE_ERR() after using one of the
> + * PM_RUNTIME_ACQUIRE*() macros defined above (yes, it can be used with
> + * any of them) and if it is nonzero, avoid accessing the given device.
> + */
> +#define PM_RUNTIME_ACQUIRE_ERR(_var_ptr)	\
> +	ACQUIRE_ERR(pm_runtime_active, _var_ptr)
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

