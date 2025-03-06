Return-Path: <linux-pci+bounces-23032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B1A5413B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 04:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAB13A47AC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 03:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A9192D9A;
	Thu,  6 Mar 2025 03:32:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAD14F98;
	Thu,  6 Mar 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231934; cv=fail; b=dxDJiVHoLgijd8C4D5zKfmPOgPnKnChlqpDkyAA0KzAl0UavfSBpXX4i1GyZNlBBdTjS5FTNmeh/kcUuRCI6zR29blKGyy6Sn2BUT+ke00Cqe8pLlN9lZUUishIxj+jlhXMR+7YXqd/lc91037xSIcYReu+5VQCYX3jDEY4MWko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231934; c=relaxed/simple;
	bh=1QvrFgnABa2CQcV9TwcQxwah+V2seX2q9qp++5IasJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jkx/eCaZv/LT0lw7Sq6LNXheYGv5KChpqtsMGF+MMPJBtLrdyh5ySB8PfUfsArdfeu718WZ5aIE8PfndQVGUJ5vDcAetnZPQnvniiMi57vGb0RvEFFsnwlt+8JADz2U7W4PfpeNLpuAr7KCnAAhoaUqUk1D9nK8WaszOtyBSIvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBU9O1I8AQpHhnmnVgF5Ba10JEQj5Ck5xAZO+xvKbg9o6edgZW5wqK0SAfvD2ywRSVyBHcFFe3PmOStqhlEVPl8BTCt0/p9CxjPAh88AGG8y2ro5tRy7XyfZ4OCOWXQpyRDrl4TTYc5Wx3BS+KTlRJNRvA8uiMdF7N2zPiIoGL9FGq56YZ9nz4ToCYBnkkvXgWgaQQlJmgH0NK+x7pK/NbP9z9oC1SkOwUnylhJk3haQ8PD5M+3P3zv0JL9wMIgMxzOn/r0vaaouqDlrrxJDB99RKEPZ+c5c6JzAQPoHi7Bs/hWIQfrXHfDOP3SFOmdHj80S/f3GP1o5+gv5RtwlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilmj3s6mHAk4lM1Cw1WUwxHqCzk96aXZAY98VhH2MIw=;
 b=MREvlg2NaX2/aCOxQBCfupzA2L7s3fkhT7ruwLckChZMwbdT3CfSzeNBilNmH8ICwyJ0YTshHrWMhwesYzBXXhUs445SF1bym1q9YEvqEHi7XlxH+ESaxnwHRPAEB3G2KgMBqkmZrg7ufa8EIFVJMgcVoFH20OP5isBVIjGJiNuczM+/PYey5+T2L42qPgEG5KRQFsK4xcXgSAduERN1LgXekKPhM2q5TGQbfqYAXSOGctI9ynu8UgSuInxE8iz+hOmDCIzdB5uzs6mYUcXQt2rSfHmKpT8avhXIsrN9+rdRAr6dJV+igWFC3qdISTfPgaaNZenw54tDfoDEGvihBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::24) by JH0PR06MB7149.apcprd06.prod.outlook.com
 (2603:1096:990:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 03:32:06 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::5) by PS2PR01CA0012.outlook.office365.com
 (2603:1096:300:2d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 03:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 03:32:05 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6F8EA4160517;
	Thu,  6 Mar 2025 11:32:04 +0800 (CST)
Message-ID: <84a00461-b8fa-48d0-9049-9a34abfe87a3@cixtech.com>
Date: Thu, 6 Mar 2025 11:32:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add PCI quirk to disable L0s ASPM state for RTL8125
 2.5GbE Controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Chen <peter.chen@cixtech.com>, ChunHao Lin <hau@realtek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 netdev@vger.kernel.org
References: <20250305222016.GA316198@bhelgaas>
Content-Language: en-US
From: "hans.zhang" <hans.zhang@cixtech.com>
In-Reply-To: <20250305222016.GA316198@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|JH0PR06MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: c1438f1c-c8e4-438d-a2e2-08dd5c5f77e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdXdUE0d2FEejlaQVhpVDZkU216Yjk2SmdlRnE5TThZdEtLNFJYQTBhWWI2?=
 =?utf-8?B?S3JReVV0T1I2bC9KTFhMMy8xbnNvTDU2UElHaEE0TlVHWW9qNkRCMGhCSml0?=
 =?utf-8?B?N094ckw0ek9ocm51bkRjRHkzQ0ZjdlpaSjJOWkFHVkRwWFR2YW56Y1dLbnlv?=
 =?utf-8?B?V2RQblVBQkxxZ3VHa0RlbzBEUlZxKzVhS2pITVZqQkIvbE5oK2VyMFpHZ3BK?=
 =?utf-8?B?aHlLUVdSR1dpa2ZsZDhGc2dFT0FIYWF5Mm1mZ3RETDRCYUNrZmpsSldJdFBW?=
 =?utf-8?B?b1VhV3RSVVlnMmJ4ZEs0QlpMV0ZEY2MrQlIyTGxUTWcwMFJrY3NIcFpFTnNi?=
 =?utf-8?B?aHdaTnpyRnR6ZkhBbW4rMXRaVzRkOUpaUCtGdXhCcGl3RWoyQjdjdWZtMXZm?=
 =?utf-8?B?emVtYm1sV0hOeHpwK3F0YVpNS2RaenRIcVE0M3VsYUZMUEZKTHV6R1RGSEFP?=
 =?utf-8?B?SUg2MDZDQ0NJbm5jYU4vd21OOTlJeWtKdGtUUEhobG5BRERkUGpRRTN6NU5t?=
 =?utf-8?B?WXhYNnFtcm1RYXJYKy9lK3pacElPMWowVHdNYzVpQWlHV0F6NDB4QTd3V3dr?=
 =?utf-8?B?Ui84Nm1wbmZML2FKVE5MazBTWlVGWktZNFVuSVlKZTA5TXI0c2ZsOFcwZDZl?=
 =?utf-8?B?emRGTVBLOG9ydmo2aUd1SVhqQWZYOGh4eXhzclNQb2ZDaUszNkFVL3VoSVhU?=
 =?utf-8?B?UGlzUG1jdkU1dExjbXJnUy9Nb3k4bUpYM1RhcW52WmNKdVJiSUFVSm0xMmtH?=
 =?utf-8?B?aVJjZ240cTBnV21OQ3NaUUlFRlVlaFNwUm1PK00xYnZNSU5peDFHRVk3MHhU?=
 =?utf-8?B?Yno3MDdvQVdJMTU2ajFvc3pnSlRvMUY0YXVKaTdoWmVFUmQxWm5qSG5Zd3dN?=
 =?utf-8?B?VGthQnlDZlNNS042YUpnRnRTcjk2OWdGT3VBalJJTjQ0am5qVkxqdU93cXFa?=
 =?utf-8?B?Um40WG5Wc0d5RWlNWjY0L0tPVytVTkNab2ppYlVwcFZEYWFPMHdITkhYY1kw?=
 =?utf-8?B?YjFEWDdjanUraDVJWG9lcGtWelc5RUJ5ZG9EUERsUnFKKzBuZm9saDhqQ3F0?=
 =?utf-8?B?ZkoydzRuTTkvY2tTbjJNTjhkQnhrS2NWRTlieE1mMmY5ZWVXbTFRL09tK24v?=
 =?utf-8?B?aHB0Tk5LcnlVdkgzZGIrN3FHQy9OQ2RNcllVTHN3R254amJObEFFTUZoYTR6?=
 =?utf-8?B?b0VRNllmaFFmOEdxN1BWY1RHZ1k5YjJVRXIzeXlhQmNzME9ONHppWHRxbWQ2?=
 =?utf-8?B?RVdTZVpGVitsSDlrRlFjYzl2YXc1b3NrZVN5NGFsQzZXS0E0Y1dLRjNuRlJk?=
 =?utf-8?B?RU51cUw2djlsNFRkWTlIeVVvWFVtWXNQMmZXblBXTG1MVVFqYmZuRWFrYTJZ?=
 =?utf-8?B?b0RGdDhmZ2wxTVFWYmx1VE11cmRRSmhhMXg2cmhLUFZnOW1PN2xOamZvb1BH?=
 =?utf-8?B?a0RvUytFKy9SbnZKLzZsSHVtQkorZmo3TnRoY1RnZ0doY1pkVERpbWtGNU1m?=
 =?utf-8?B?dlhPcGVpUVVnbXhpenQ3UEVBamYrSUZBSEVkcVNrRmV1SjdrY2JQRUtMZ0Yy?=
 =?utf-8?B?V1llYzdERzV1bHRQTSsvS0h1MktlaGRkYTVLZFl5Tzh6SFRyZFo0NGhFdFh1?=
 =?utf-8?B?d0ZuUzN5RE5yUkZYVWZqLzBiaTVYU2hyb2dzUWIvblhPR3FNbkpmajFnK1RI?=
 =?utf-8?B?YVN1dVJNUmxxZTJPaER6bWp1ZFpZZU13SURCOEhEbVJGVmFIMjZ6c0FaTGxF?=
 =?utf-8?B?ZTlxazN1a0ZBb0doYU1vV3ZnRTdkVnk4akRUZUFVcEcyQjhNemNzOVJWZ3BE?=
 =?utf-8?B?Mnluek1SckJ5RVgrQVpMU3p3ZkNPSTFzeEVVejdPQ1piTlU3K1o3aUNOY25S?=
 =?utf-8?B?WkpsSW5xK1haYXhzQVhCT2xNeVhQR1VkUEJDdDBKRW9OZ2FFcFpKZWJUbEdw?=
 =?utf-8?Q?pxVtNJGp8X0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 03:32:05.7386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1438f1c-c8e4-438d-a2e2-08dd5c5f77e6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7149



On 2025/3/6 06:20, Bjorn Helgaas wrote:
> Sounds like this should be a documented erratum.  Realtek folks?  Or
> maybe an erratum on the other end of the link, which looks like a CIX
> Root Port:
> 
>    https://admin.pci-ids.ucw.cz/read/PC/1f6c/0001

Hi Bjorn,


Name: CIX P1 CD8180 PCI Express Root Port

0000:90:00.0 PCI bridge [0604]: Device [1f6c:0001]
0001:60:00.0 PCI bridge [0604]: Device [1f6c:0001]
0002:00:00.0 PCI bridge [0604]: Device [1f6c:0001]
0003:30:00.0 PCI bridge [0604]: Device [1f6c:0001]


This URL does not appear right, how should be changed, is it you? Or can 
you tell me who I should call to change it?

The correct answer is:
0000:90:00.0 PCI bridge [0604]: Device [1f6c:0001]
0001:C0:00.0 PCI bridge [0604]: Device [1f6c:0001]
0002:60:00.0 PCI bridge [0604]: Device [1f6c:0001]
0003:30:00.0 PCI bridge [0604]: Device [1f6c:0001]
0004:00:00.0 PCI bridge [0604]: Device [1f6c:0001]

The domain might be random, so whichever controller probes first, it's 
assigned first. The URL currently shows the BDF with one controller 
missing. That's the order in which we're going to controller probe.

Best regards,
Hans



