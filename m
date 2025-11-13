Return-Path: <linux-pci+bounces-41082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8F0C57399
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CABA4E603E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA72FFFA7;
	Thu, 13 Nov 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lTEIC8r2"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAA33F39C;
	Thu, 13 Nov 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033741; cv=fail; b=KROH+airv0tcmW2pgWdG4DiKAayVD+RSruw6Lvm4fYXIK0xSjdngvKhCw5dP9IxmbSgu1dF5uzkr/xDBzXSWw/XnH3Pp+s202YdDnzIgA0CdaZl7Knqbc8FKmIwFKZnfqW/g5tbhkbxYHhE8NYV2c18S9X1xd52PpQqxqyfe8xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033741; c=relaxed/simple;
	bh=prjBgq7/SDZxLUzTxA39yc9eriA7xZUxRXFUcXV3pnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y51Pv79TY1ie9FevWc/Cqu5tDN75tqKrvV+3hKj3Rjh41xgbLceHfeXvoIsZkpXKJFO76Idhj+rdEDtqTh14CDJH9RpYmEgklWwIejU1iRETLj/KzLxdzjiCXLJcQ/owujsfdXEeWtkaphYsoE2sQ9+tqDCjLsI/niwA18xqwCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lTEIC8r2; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkIriy+25gudBPdPu5GXg9auc4+0Ean8hhmYSxluGg7iuRXTDQPngqdp6o7dtRVfEM3493YEBH8g3mUjQU4U1kMT9Mpq0uHrcojoohe4W2ZtzAh4HmfPWk/enYosWBpzQVAO3QonWtbw7gVAP4qdb1a7SB1pCWO7v0iuVQ1Fl+2UDqvYLeVyjukIGGEHZZNW7ghoPC7EJy6kBaQ2DkzmYp8tExqhBEE9kdHLzOldGI1GeeCGPxWvGLTENGOYxet8HTp8XAccQGwtbnn98W47ywyw+2lB63XOnRxI1knskpLytBl38mxXcu4oVxLnqeljgggngSv/l3Yzct2Fce5v7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlJpM91DpHF071MBk/f1rHUjKm81sFMTcQoOO4bR2p8=;
 b=AvoUvruDtJw0c0hZvQ+I9mVHpBbojtriHjbZ3DNHDMV8L+walTVX0EeoRuoiI4EnfvREh9eDGPdzSQyDyIZujVYYlcmJzrkUTQPKuG8g7sWUb2VKfRZwxNTV7f2GskkKHtIswZB/t9zVkJ/pXYULd0WSFOCc/98dNL9iYQb423UjClR5WbDZSRaorfhRLDt1VqgIDlzTRTe5cIKkNCy9rKCr0/uPAcT6kNZYjk/bDy2riogVMZTinKsmk8d4VTuH45fZf2dBbJvnuyPftrMLLC6UGvjOKS7WTRzNNE6c5aXJhSM17rSwoUnlW14e+zcMlFM2mtYPkoV7bwZcUoHh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=redhat.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlJpM91DpHF071MBk/f1rHUjKm81sFMTcQoOO4bR2p8=;
 b=lTEIC8r2fEgI7gx2A0kYXQHn/F6DYJk+31oowuLBo3pY5gj6n8T06zSw3M2BIc+RXSyTTB0ogA3Szg82RVX//4DMAeN5RwxrETYjSSnWXwaa9sC2QL9vXvbIHbkAzeCaOo8STnfesNqgcGqpsSqAcNSa2nLqf8eEqRJH7sSj/Ho=
Received: from DM6PR14CA0039.namprd14.prod.outlook.com (2603:10b6:5:18f::16)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Thu, 13 Nov 2025 11:35:35 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::ca) by DM6PR14CA0039.outlook.office365.com
 (2603:10b6:5:18f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 11:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 11:35:35 +0000
Received: from DLEE100.ent.ti.com (157.170.170.30) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Thu, 13 Nov
 2025 05:35:31 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 13
 Nov 2025 05:35:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 05:35:30 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ADBZTNL196701;
	Thu, 13 Nov 2025 05:35:30 -0600
Date: Thu, 13 Nov 2025 17:05:29 +0530
From: Dhruva Gole <d-gole@ti.com>
To: <dan.j.williams@intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Frank Li <Frank.Li@nxp.com>, Linux PM
	<linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Takashi
 Iwai" <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Zhang Qilong
	<zhangqilong3@huawei.com>, Linux PCI <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter
 guards
Message-ID: <20251113113529.vnfvc6cqmk2ct4kl@lcpd911>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
 <20251112063941.kbg44srt5f7rfkjb@lcpd911>
 <5068916.31r3eYUQgx@rafael.j.wysocki>
 <6914fbb5a6ce_1d911001b@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6914fbb5a6ce_1d911001b@dwillia2-mobl4.notmuch>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8ac5fd-9ee8-4562-d863-08de22a8c303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SM3TMchYjPnnnHjKIVSZPDFx6b1VOTQKr0EL8i4pU5LTZRwshaGXv6OmASwv?=
 =?us-ascii?Q?iWa+gQSCbRKQzmGUY3EuCOGvtBEcwzvBeKHerTVz0z0DoYlNFVumve6KmAoy?=
 =?us-ascii?Q?POJ2t/Jp/4dV0uYGBpHaQQPn71LDqxXwZiwJj0pdUNGGUM5Vk9V2gD09Td81?=
 =?us-ascii?Q?k7iddO8ZHytjgpkkSEfUtXM4qraGimVMiN2ubBwivUf5PMYZ6S+JRWSgJ7x5?=
 =?us-ascii?Q?7pD7ggW0M7DcwKQakTKCY4lY9WxMuHiguZibnWjitvm39dX5bMyWp71e/vVD?=
 =?us-ascii?Q?az6g3or4q+/2Y4FVfgmFx/v6SawZTqpjDVBeDUKOUafR24PbAV8QSWusVNt7?=
 =?us-ascii?Q?y7G9orQuu6HQ7PBImkjkVbecXWeAJ2D/C5SLgLYbyfDOzh6TFY0sfr2xPZXi?=
 =?us-ascii?Q?K+XQU5ycBVkHO3ghJlQ3rgyKSTQ7lktobV8qdtHvh5AWJtZNfTAAmJ1XD8Dv?=
 =?us-ascii?Q?c+W2qy44w7bJXsfCAkhXLgu+guBdxhHgZJZgSVfmjrGp0HTCxFS9/gNOZzIw?=
 =?us-ascii?Q?ZQAcOMf0tqLO0wwEnXPUz+A3HXof2LRVUeWOYzQjkMQbeVpw5OCE66AhLxVH?=
 =?us-ascii?Q?9Ik8ktQlBItVR3s+byy2zH8VFdobE/9MXL4ih+djqvKjNL11m6gL2g2r/4dZ?=
 =?us-ascii?Q?f5AJX9WLZvJLpN0Gf/YwEgwd8EKDknTUbe2IcN+WWZZgsXZLT8AztbztoQBS?=
 =?us-ascii?Q?G+JnvlW5uskzVcUKsinIh1fUMbmCDhpmm0aJBOKx4zv4ttuntIro7DWVDc0p?=
 =?us-ascii?Q?o2UWs/97PEZfq5+wR5C21lFhOqn2cJv0f8QWTv84XZOm+JGxrdkpRPrlrVQV?=
 =?us-ascii?Q?KXi81QVrT8YyHtmsRgoBjuezWf2Bju/44tJJcn+mF125A37GGvtHibniXvZq?=
 =?us-ascii?Q?2Szz9fYymO36ixcWpHhBs06V/2VZU01/XcfhnDeM4+pwtkZEcMpnPhWn4v+q?=
 =?us-ascii?Q?re5RbpWW5gBdu8D1+ZmETsU/gReOGJTVkHJMSOGjNV4IEouIC1BOC2YNpyCl?=
 =?us-ascii?Q?9B0kgwVUWfM+WlUUCVWVpxezGcDxwRMS7t0X6hSUonY9LP3fRN3QzafmaTkw?=
 =?us-ascii?Q?tp7FBDoyg/miw48sSipUgxEtNlocvZey4/cN5hvNRhW4HKEpgGjd8a80yvbF?=
 =?us-ascii?Q?2zFFS6yy4qU4UMhtqXitUwESZjGRM/ZQp8Lmj7IfeaROcvucRuRr0ZBo6vES?=
 =?us-ascii?Q?G3uppeNeINDCH7nlAASfrIrqeuz0LFPcZAYFGFm/+l/+P4KMgfCfIkpJk7Uj?=
 =?us-ascii?Q?qHK7vH8QhpoLVQdplJ3oLX8/cEwNBDPurxW9xnisgXx8YDVkaua1OH4D7iv5?=
 =?us-ascii?Q?03F0Q6hL3Lrg4Csx1O/MK4eWBpDXusG6uqNsHWXT1IAIZnoTGwNsbPztP5Rt?=
 =?us-ascii?Q?Okd40E2eTvfNAMs0PNAJKpzGOdB6c95JlDQxvZyiHqi4v7ZJ+8zP4ZZf+r1n?=
 =?us-ascii?Q?gPY6P4mgd8VPk+vxrEQKe57TOYx4ki8BEVhnF5NRt6dUAtF6C0kbHQ3KUCOl?=
 =?us-ascii?Q?dcKvq4DVZzCX/nOvqITVnQ5nnWl3+98UNfrK2s/f3o20Qp1DScA+IEhRIvrQ?=
 =?us-ascii?Q?lqsrve4YlsmBejU0ZjY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:35:35.3915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8ac5fd-9ee8-4562-d863-08de22a8c303
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135

On Nov 12, 2025 at 13:27:17 -0800, dan.j.williams@intel.com wrote:
> Rafael J. Wysocki wrote:
> > On Wednesday, November 12, 2025 7:39:41 AM CET Dhruva Gole wrote:
> > > On Nov 07, 2025 at 19:35:09 +0100, Rafael J. Wysocki wrote:
> > > > Hi All,
> > > > 
> > > > The runtime PM usage counter guards introduced recently:
> > > > 
> > > > https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysocki/
> > > > 
> > > > and then fixed:
> > > > 
> > > > https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/
> > > > 
> > > > should generally work, but using them feels sort of arcane and cryptic
> > > > even though the underlying concept is relatively straightforward.
> > > > 
> > > > For this reason, runtime PM wrapper macros around ACQUIRE() and
> > > > ACQUIRE_ERR() involving the new guards are introduced in this series
> > > > (patch [1/3]) and then used in the code already using the guards (patches
> > > > [2/3] and [3/3]) to make it look more straightforward.
> > > 
> > > The patches look okay to me,
> > > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > 
> > Thank you and Jonathan for the tags, but since Frank is not convinced, let me
> > bounce one more idea off all of you.
> > 
> > Namely, I think that Frank has a point when he wonders if PM_RUNTIME_ACQUIRE_ERR
> > hides too much information and I agree with Jonathan that may be misunderstood,
> > so what about defining the wrapper macros so they don't hide the guard variable
> > name, like in the patch below?
> 
> I had been reluctant about offering an enthusiastic tag on this series
> given that information hiding, but with this change:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> However, I prefer that the scope variable declaration vs usage
> (reference) cases should maintain visual separation with an operator,
> i.e.:
> 
>         PM_RUNTIME_ACQUIRE(dev, pm);
>         if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>                 return -ENXIO;
> 
> Otherwise we have a case of different flavors of *_ACQUIRE_ERR
> implementing various styles. I initially looked at hiding the '&':
> 
> http://lore.kernel.org/681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch
> 
> ...but it grew on me precisely because it provides a clue about how this
> magic operates.

Yeah you're right, I agree. Having users explicitly pass on the '&' provides much
more clarity on what's going on than hiding it internally.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

