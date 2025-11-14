Return-Path: <linux-pci+bounces-41221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBCC5C244
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2767D35103D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6FA2F83BA;
	Fri, 14 Nov 2025 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BBtnV+6n"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716622C326F;
	Fri, 14 Nov 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110988; cv=fail; b=YuREHFUvhhCgnUETcY+bQdtXGxwr/IO4p3KMs9/7R4F/Jc4SJFtz1W4HtmrZayUN0p/3LDhwufH4M4anJVP+Z8fu4cPKj7qXld6vrWSOUMfInyQoS2d54MIL1aps+L2CjUifL4HF83Q81wYj2hiaYgYCpRQncc6Oft+u8VN2+tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110988; c=relaxed/simple;
	bh=VqozsP8jaV2A0Lm6vdr3vuzmR/1GX5lKPUyvGAhl6Dk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwktUVCqYNE/i1RFq2O8cjVTe8/r6Nn53cTaOc0O47Pa/ADWLJe+EyuStoXowchjvCRxMnQ3Tmpf8w0ej+Y9deXho+VEmSztNpBWYbk7iyJmFxSzeLg0MIE9tLcdII9FNvgZvdUPRi6xaCK8besD1+U9K7bcoDRwP48sLJOeAF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BBtnV+6n; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8nt5D9YJmBqNbXr8+W15yppDHZ8De6foi31uulGEEqWSAJx8wqd3UV3g361y7vE+hzv86tPy2xEtXtMtYuHQutrL24RcqVPMsqbRlLE435NjqbdHKUPbEFhBeO4hCCuW+A+qlMOmMCnhf2W/cXiOWtCN/dw0wWiB8tY9PZyrCtk8ZujW6j8jAW+ILIPUH6vtxG1WqdvPeLlo41Ng2qJPIX53hs3CSkbs180QvWHc051hiOXaUyjvmA7TjoLcP9ATUADEHHV3aKIDEqlV80SHTPGHN8qWH2NqgZtSGUboItdMxLX0Wm4xe91Ay5AA11BL7J8rDd85vC03fOGKMdFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8oyFpXk/GMi65JsF4UZ1QSUXfh4u2927iQz+zK81hU=;
 b=ckIZyuM0CWM1IRZUxDj/lA9Ru0jGR3PyoN4Q2Es56ccAAEz5VGGBFROzUdi883Mi+XKd9lcLgMQbHBbfacMb2ETqa/U+wPn/Xyk+ebwJ6Hgk50aqO666qGkeu0tJXiYX8XIfo2lvraw00Lm6ajlofCn0fIbLp/eAbmq1xujHocW3j/ceszlu3w6RZDCiGQUYSIthucHrbAhmvJ9KGmcdskOXgT22p+/yB23G/D9dyC2YR7mN1qLyjHOARYlJJWredhXZbsqg8pDuoEvkvTXruGiUxdwJZloztaYTRmdPqLywioTz5r57TWdqK7cVXy08r2lBUUIFq22X25fCbLX17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8oyFpXk/GMi65JsF4UZ1QSUXfh4u2927iQz+zK81hU=;
 b=BBtnV+6nzzCwaExRb+7J6IqdWwByO24GOcEBoUXJ+zMcMHzMcKTcDgFuEfGSK28ACr8L+TWuqYyp8qUw3dLvzs01AMdZPDHf6uz6+dGxP7wDuuREqMwp5lr0BC+DclMPXjPeE58Q9ABtGNvHHPsPwjXhAOYNuixdIs/ZIDlJaVg=
Received: from SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17)
 by SA1PR10MB6493.namprd10.prod.outlook.com (2603:10b6:806:29c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 09:03:02 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::88) by SJ0PR05CA0132.outlook.office365.com
 (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Fri,
 14 Nov 2025 09:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:03:00 +0000
Received: from DFLE105.ent.ti.com (10.64.6.26) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Fri, 14 Nov
 2025 03:02:55 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 14
 Nov 2025 03:02:55 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 03:02:55 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE92sZ91715918;
	Fri, 14 Nov 2025 03:02:54 -0600
Date: Fri, 14 Nov 2025 14:32:53 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, "Zhang
 Qilong" <zhangqilong3@huawei.com>, Frank Li <Frank.Li@nxp.com>, Dan Williams
	<dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>
Subject: Re: [PATCH v2 3/3] PCI/sysfs: Use
 PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
Message-ID: <20251114090253.n5m43jdvg5rv2bbb@lcpd911>
References: <5959587.DvuYhMxLoT@rafael.j.wysocki>
 <3932581.kQq0lBPeGt@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3932581.kQq0lBPeGt@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SA1PR10MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: cff481f0-93c3-48b4-b246-08de235c9c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3R7qD+x1Bb2K+c6kHBk+XYPiPJ8bZCoFOhPM5XCEGlVttvEAd9U0TrvBbpp?=
 =?us-ascii?Q?NmxVcsx2QTQY/17VZ4Pw2htbetaXJfCub35e0+1l9dE1LBXc+nOmgwPj/Pi3?=
 =?us-ascii?Q?t/fg1mhD9KncqPwEFZNSZtzNjWvht6kw7ZlwZV17tc6doJKSZy56b1PFxkjt?=
 =?us-ascii?Q?UMfNgZKMZOqxNctkZhFbdgpSaVS6Kf5IFfBSdjUQPAWwj5vLAIyQZ3dMh53+?=
 =?us-ascii?Q?WXwMXihbzf4Jo4oVqUGbR/99i3jnZHsgO8yY45kBPTXRbR4wbY2QoGeEY2nc?=
 =?us-ascii?Q?yMe5td4a0mfcklJ4T+ql99xKOqLU61du2ZPto7rLubAYRQmB8T89eKwWGl5J?=
 =?us-ascii?Q?/Wdarqas9rDSglmg3ErpjyxEKcQsnGFanP7CJ91WWbQWjkiRRen6hta6NA3L?=
 =?us-ascii?Q?Nd5AgwpUWPzzXmRmCpy+xH+JZdr3vPQjrJ3FOV+lWZe+ruyWnzr7P7MISF45?=
 =?us-ascii?Q?cOIlVqeBqIRkkDMYR1WU5p1RzNn1leFx+NlNXZZ1K5WcgNx5N27kgwmGhxkj?=
 =?us-ascii?Q?qFC4E9Qq/lm6et6brdeJZZFcIXpdvIPj8fOrssy5enPu/DMGEu2t2aCGO2bi?=
 =?us-ascii?Q?b7bk6FMAbxKwxBRuUDm+9egzr2yp83XlpH4aoQxGLF1M+YNaaY3JndUx5w5c?=
 =?us-ascii?Q?aO4fw74ruwcNpLXDmBDm+NjQWleRBH6AC2lN88kvgeB9IqCIvKqn3yCzYVgf?=
 =?us-ascii?Q?GPbA6OcTuP2I3dxJZtkrapdNyp9F28jUKtw+NDe0E6hB2eej/ccfjeBOOf6i?=
 =?us-ascii?Q?ibCCtmJor0lkMRq9WZ74kZdDBNJSP+0ZMbzVwkK5d/66LXg78UDMEgN8CpeV?=
 =?us-ascii?Q?BKG5MXoVXTAkJiPjK+LFxtC2+EjdAyGLtsQETnncnhlexQyKcHDm57ETRYPU?=
 =?us-ascii?Q?DDlIRFIuQEEBKfDKgV0J7wD8tLJwmQJng4I76WeXQ6Z/rMHrjOpkG3ZMPKTM?=
 =?us-ascii?Q?7CfeJm2HD6vjGat8BE/iooCawtBkNU/KaIJCHCd/BuK+V7nDIt8dhaG4ormt?=
 =?us-ascii?Q?kqgVEh8VybJzh8z8pUbbcACBfM5VKIzmuHPI6RZLnR73D3VzzL1MqRv2b0fy?=
 =?us-ascii?Q?mpsI1LPDS/K8Fe5FaX7y6dLhpfxgNx3HjU3tWlXznLt5hSNT/8WIkF+KLe9+?=
 =?us-ascii?Q?bGZs16twFAY+66TSEjFPbGteHg/7CIus686tKDS12QG39YZGmZdfJVyx2be9?=
 =?us-ascii?Q?oWGTFSecprsSigIxE6m5a5g1pgfeApB3PWytAxN3TL0rnA0Jw/y+pijHuS++?=
 =?us-ascii?Q?1pVmbMw4j51Znsja3yXjToG6Uxt3uYfpbDoaQRU+Fm+xfYGCfZqStsnMXmKG?=
 =?us-ascii?Q?fXZHmhYP0om3j8JZ0Zc7ok/13GLyG4PJv4KpDmVFIvax/yAJuhkhSkVcVwyS?=
 =?us-ascii?Q?Lxq4IjvVuq3H8o0F3FNt3AawuURtQwOn7qb28vgVi7Py+mm7FxA2jm6LgvrG?=
 =?us-ascii?Q?IX19JGKFVq24jw0leJVW011RzxyWbusPsPH0JRFI9r+IfgGQXtjqkW7uuvRq?=
 =?us-ascii?Q?vskiVH3sWoTFE3UnxqoyDwFj4qEqJslebkpRo/urIx7lvcg3cHDvE9lcPYo0?=
 =?us-ascii?Q?7rUVMkq82JRNqepbDRc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:03:00.1003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff481f0-93c3-48b4-b246-08de235c9c73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6493

On Nov 13, 2025 at 20:35:27 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macros
> to make the code look more straightforward.
> 
> No intentional funtional impact.

Same here ...

Reviewed-by: Dhruva Gole <d-gole@ti.com> 

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Adjust to the changes in patch [1/3].
> 
> ---
>  drivers/pci/pci-sysfs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct
>  		return count;
>  	}
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>  		return -ENXIO;
>  
>  	if (sysfs_streq(buf, "default")) {
> 
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

