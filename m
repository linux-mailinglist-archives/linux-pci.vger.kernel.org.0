Return-Path: <linux-pci+bounces-40957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C0AC50BC9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 07:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82D0188745E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 06:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B32DF15F;
	Wed, 12 Nov 2025 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eus6FUAE"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C692DC788;
	Wed, 12 Nov 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929596; cv=fail; b=fWCuzi+WXtcbCZh6WqkWHQWyUc7Cmd/5Eh7V97D2u6lpXFH1fNBCQQPjTk4DZg8jXVAtIrsmXYTK4uyy0nqDXMPQZlAjWwfTUd3T5nEdlo99vOx5O0NAi7fdsltYM9xasxX1H8Dz+J4HXZ0r9N5M5PtI3YgLxDT05Zvm7z3k5/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929596; c=relaxed/simple;
	bh=K8OQApxQaba/gGPvPwsLAA9hOdcdrWosZJGMlIGfL2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKr99pt0BsguwFekIjfpEx/4kDtPBXVAXRVlvSDJyXE/Bjg+3tmQHBHfOC28gzWpzmyIRyf48FpatbFuMxb1hFIajFtzSAdOhv+CB/LNrw1bqfe4Yh1eq9yGJGAp1k+KtgBguR3skayF8TO61R62Wy7KiEZTvgaEbtqwTJpFwSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eus6FUAE; arc=fail smtp.client-ip=52.101.46.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUDz2Kz4Mn/U1pR1yxOm6e6ekXz+v5qfHcrqfZodxmsaqiQhC+aRSA3qALqpZHbnDFVWndZuhhQtabkN7cPVEBcRlKk1Zex1iO9g4jM7TL5qqI2sq51bgLw787UXAGEegow1Ar6YjGPXn197bJSoh57nGXG5GWA9L5vspL5Uz+tyjCaTIhGbKXLi5WkgajzBNaJhgNFE4quq6dyaaJP8kYYKgKt6tTNlhwtYIUIayk5bbEwIZRwia7eKoJ7Lvn/cA+1ecEufTdPApGGgDvB8VXHRmC8QdfN5zYGfthcCLdL4T6MYavrWLe7DWPABGFMG/MFS5s8fcYnm5SJt13up6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/cDwCmGZwWgUMWP3Z9lLvOpk6Os4ApsRoVIDg99lMU=;
 b=aw0yYrg00ZqC18AM2P5ENI0gqvxl0shKPjjG5HJ4IaINduB2k2OP80L5I0hqcugR0L5z7RRL/W7rOe1ZHkMfspPbtkHCPA7bW35ktyEebhSXlx5yuIzjvci1s9wNLcw37UzspnmyeBvEMvLCQbHrCme4XoqFbgwIpppAjv7FasjoQxO/T2fYM4T3BADk6FH9775vW5Zr2/QNh8j+feyurhEGiUBRkOn4qjMfoCw4Q+6g4Rv8jSGnb+elhdVX+9xQrMxXWyQHfAclrZZ05fnPMoVdGbSqHv5/VXxHzXkMyxa6BwOB+0SOmo4I5ptVoNNHJSQAwqwGCJIzqZh0pvZ1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=redhat.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/cDwCmGZwWgUMWP3Z9lLvOpk6Os4ApsRoVIDg99lMU=;
 b=eus6FUAEvHBkcGQe494QKrDNjZWJ3Zb4Z2KRUOTvoTzL0LZWJSzQkGw2RvpWaTKjlAhy72Gk6UEidslqzeCszwQdmTWj8MKbWl+VTnPsku0owlqt6pfFngAC8/Trt/sy6ZG1BE2YhTmeM3tqWT45u2vxVg5VOrwrY4rVeAv9a6Y=
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by CH3PR10MB6692.namprd10.prod.outlook.com (2603:10b6:610:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:39:52 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::e8) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 06:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 06:39:51 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:39:43 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:39:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 00:39:43 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC6dfRd2207191;
	Wed, 12 Nov 2025 00:39:42 -0600
Date: Wed, 12 Nov 2025 12:09:41 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, "Zhang
 Qilong" <zhangqilong3@huawei.com>, Frank Li <Frank.Li@nxp.com>, Dan Williams
	<dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter
 guards
Message-ID: <20251112063941.kbg44srt5f7rfkjb@lcpd911>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13883374.uLZWGnKmhe@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CH3PR10MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: d095273b-ff1e-4d90-ea57-08de21b64854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Opqh2cXOAcc32zkx78y2/8Qm/8BsfS41ENvzEKKENQzquGnTSOnPcOD72k5F?=
 =?us-ascii?Q?KWC5YphokE769kfsQnasmwRheHgjyfi+4XoJpx3nUNlFyyFSvG13woJw/30M?=
 =?us-ascii?Q?VCrivJSyvMlGMB1mcIb+uY50KLYd0dReUO/vfCes1u2VBJbIUmvIqx5GFbGg?=
 =?us-ascii?Q?xuh22bmh0PHlCdPkw4Rr411Q6Tz5xHxFakuinuZ6R4rR9ubhvNVCgyMvZCvI?=
 =?us-ascii?Q?ApZLo/jTsBsBpVsPXPC/lnXVtPaouol1YqZ8hCMMIN/XCJtvZMZdu3a7xerb?=
 =?us-ascii?Q?Es2KpAkxzKDr+y3+lNNXzM7cTsSMmqV2HPCjdww1RCzljHQykb6Pj4IrKvPE?=
 =?us-ascii?Q?Xn/LT/YwhE4TvJHa8KHgNGdQIYzgHF0A0JAaZIt9tOvDfITPTgR1gcRDD9vo?=
 =?us-ascii?Q?W0mwIP50lf931ZXHglESW1B7WXPw7IBx5e0mmt3wwSSGgWSrTcgIyB+e9Zg5?=
 =?us-ascii?Q?7LiV5xByyLD5Dnw0rhhezw7FMev/EabTdXqo3enrWkuTI+4bRlf/vardcO3a?=
 =?us-ascii?Q?qpdijinlRAvlduafb7OcNqmfAgc7OAxmCcO+FDmMw5Gr62I4t6ZWUVh00OK6?=
 =?us-ascii?Q?wNIn669HVI2qtxrlh17qh2uIrFUEbWOUvpN8Vh6ZuAm/N2RkNeZl2MV2Gpy2?=
 =?us-ascii?Q?fyNrjxw5OSEHKpZAU5YzDa7OOqbAAZ3i9B9zI01bAlApxRHrcdTlbM5NGZry?=
 =?us-ascii?Q?YNR0EScNQsLKu7nSdHtGESYIn/o7c2L0Jo1pBz7N4gzhIvWRvnzDiE22iyAf?=
 =?us-ascii?Q?2JtPFbq5e21e73dorcNEUevprIyCNF0Zkeme1GLliom98zWtx9TP8mOobTZi?=
 =?us-ascii?Q?868g18Bn7SC/s/WJEX/gczaB3dQ9MQf+tRKgKXoSMq0mAh1UjEuNVJK6H+p5?=
 =?us-ascii?Q?OHyMSGo29DVAkl2Zqy8Im4xqePROp0UVKuESFnRj+JKGydJG75iwUorSLbD/?=
 =?us-ascii?Q?+C7Rwk3sy/cAV9VakSXnIcoyos0smfeB5Gei8hzUuRrxMMNyic0M7zATeaEF?=
 =?us-ascii?Q?1bBsY7yv8jhDD39HwZKhjczCne+Cn7i5w0bFQ6AnQgQAyo2J2tG0HQdR8llm?=
 =?us-ascii?Q?H05YjwZMg4UMHZ0t/mION4XmaAttkoL4JSTklOoOU5ySz4aXq2lwl7bK2TrO?=
 =?us-ascii?Q?M9vEqMvGNqHIYdqRuots3pGGgtM5alPMOvo8mCDgWUYibaMY4FTSdI81lrfO?=
 =?us-ascii?Q?wrWgk7z5q1vqFA72QsCY4m7VoaYM0wJgiZGg6t14aKqLYT8YFlE6rUJuVdU9?=
 =?us-ascii?Q?zL3GRHUXl7bxRGgw4Nd5GReWukkMUTIxtAUNtiXG1FwOQXc8UcqBtagb8bQ4?=
 =?us-ascii?Q?EDar3TyauqJYyD3kaP7y4OCZrWF69c0b5O2x9cUXjLQuTKcqGrQiwTdS0bpc?=
 =?us-ascii?Q?YFEuGRbE8FK591ZGjAUkgRCnwGVynAJJFLnHZy7sBMKN84Ko4cHWFkdncoVV?=
 =?us-ascii?Q?HvfPbsc+BIqzearAu6zgnxQiFh5ScaQDUQJEZMpN0ExM1l+T8c+IALcY0EJO?=
 =?us-ascii?Q?2TiVVtiRwEJiXpe+YAoa81s9psDvJjstAUuttbk/y1qYkfzUIu6cNm6S+kQB?=
 =?us-ascii?Q?RHnEakDYxEue/9GNeRo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:39:51.3096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d095273b-ff1e-4d90-ea57-08de21b64854
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6692

On Nov 07, 2025 at 19:35:09 +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> The runtime PM usage counter guards introduced recently:
> 
> https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysocki/
> 
> and then fixed:
> 
> https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/
> 
> should generally work, but using them feels sort of arcane and cryptic
> even though the underlying concept is relatively straightforward.
> 
> For this reason, runtime PM wrapper macros around ACQUIRE() and
> ACQUIRE_ERR() involving the new guards are introduced in this series
> (patch [1/3]) and then used in the code already using the guards (patches
> [2/3] and [3/3]) to make it look more straightforward.

The patches look okay to me,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

