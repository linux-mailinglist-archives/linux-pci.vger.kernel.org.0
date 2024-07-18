Return-Path: <linux-pci+bounces-10506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D77F934F70
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E62D1C20FE6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B213D62E;
	Thu, 18 Jul 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3I/wAYui"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04E14290E;
	Thu, 18 Jul 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314484; cv=fail; b=Oc9TXW4K+1XTAhWuH1++NWRAOLa5Y+y/LHAS/09h2e012jngR+jW6ynoEyWZ+W4JuLA7UWk1o4kTxdKQxologZYznnXZg8cOBwwdLuCM5rZSsH5r4wXR/B8hAwCqfgom2C7wR996xrxDtG9WgBqIUh8rOUal3SiSG2yZWZoZmH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314484; c=relaxed/simple;
	bh=IY9fmgc0pqT0TvTmNciLpI0G9o3W0DAj4MMZhp+1zD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J64FUBBIZml87w30xE09DVvRJPJEN02u7I9LOL3oxF4uByj/HxnByiz7aqthKBjsZOnuNcXcAX1FRnFZ8qiIbdm315qrVlaWmqVAWuowy4igPmL1k5xsHye95BZGZdV0JPoZBbe8KdxVuJ/yAp7k9sYcINNqJWM4Cao2qEAPWUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3I/wAYui; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI3e07IXqwfec3Oz1aDaeYVV6Orw8vOfWdS/AcqOyupvdqab8HbF4Km1fDuKrJv+j02GEOyD1RvMKTJ4f5mt+jOnvonZckJ/1mZwFtCDJvCMocQA9AnY180sHvFTdaUtFCtj8vlwS/b2+5hXtbyf5zPQ0Xu4m2GL4RJyWEtJNbHIiVgNBuqhL2SR9+51Vvo4tZNZcTI6bAlzAz2/0wbyod5ohgYCSutczYe0cfQx6MPwnDHOfUL8pp+yjAHa8fJPvTc11gdqg9QQ4Sd0sJ3bJrtQfOg+WGkMB6+DRXT+hf9l3bBaHKDrBanEt6t2WwOZSmB0jhlYXnaFE61Ky/Uqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CscrVHGAlmXz1MBDWPJvFwvW9KuTKr7Z5Oixg1igi8=;
 b=UMzgSkWghjNRTQDxyl9vwhuPCNVGeK5HQuJPfiKJi3usReYcwoyiGhkYufTUYULDU9yVgDCcw83V7dienlyut0XVEL2uC2YPQjS2PXxWo7s+8IeFMXae+GR3iWxwA2BvdyCtlcILICGgUV8mHUBuioqWoOnGl/4JXWZEL4nsipMonSkx0+oRPJBaie6Hvv91oxZTx9hSBxFqeZ1NY0yuoHaxLiD1gI6+ktN52Dk4m4gk2IRqAAD1C00bSh2YREO5HFA7Cc6sVSneV1iIH+PEKiBYjxiKAUMgpZGrVjoDeicQC1oU1N4YzC5IbO7nl0mEbwpZGw59a7Q0K0we4f9uKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CscrVHGAlmXz1MBDWPJvFwvW9KuTKr7Z5Oixg1igi8=;
 b=3I/wAYuieA47c/aaPwxhB+ORDQJLJwp6ErtvMVFy8UznLfxZFVOuYePe8hq84Q+Mcf00i6z778sLwgU82NEKzIgXEjQ5ItSWl/keuirWMwQGljIT5id0A+0o82b+cYnwO9JIuNiLnq0jeSn3R53bLYy7lwIodNAa4RG3Gs0/aw8=
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 14:54:39 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ce) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Thu, 18 Jul 2024 14:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:54:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:54:37 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 18 Jul 2024 09:54:36 -0500
Message-ID: <34a71336-e0fd-4b37-b415-d22e3131f001@amd.com>
Date: Thu, 18 Jul 2024 10:54:35 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] x86/PCI: Move some logic to new function
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
 <20240716193246.1909697-2-stewart.hildebrand@amd.com>
 <757f5fcdc14c8f22e52a34974f2e48fe2dcea4d5.camel@redhat.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <757f5fcdc14c8f22e52a34974f2e48fe2dcea4d5.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3447af-37b4-48e6-905b-08dca7398c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXVqR09CNmlmN1VzV00vNFM3N3l4MHI1eHpXOG5rTUVGclNtMjlqR1IrMDg4?=
 =?utf-8?B?RTE0Wm1UckdDbHJudzNMbUhyaWxEUG0zYVVtV0U1L0lrYjM1cFZzWmQwd0tH?=
 =?utf-8?B?Y0FNVVVPc0IzRHBPQzE3M0gwbzFIZXdCdHZwUlVXU2VzbmZkTTV6eXlhQUJp?=
 =?utf-8?B?dVZtVXB3cW01MXdnOFg2TjNESW9XNmR6dzlaZFJlM0dQZkVKUTRxT2c5ZCtv?=
 =?utf-8?B?bzVXcENkSE5RY1hrc3h2amZrMlpHZm9QdHJNeWIrY0xzaE5LNDdRaGFNSTd0?=
 =?utf-8?B?RWNaZEZ0L3k5NFgvclJwMnlXb0VpQmJ0WFMzZEQ3azk4YUxSNkMwY2wrejRN?=
 =?utf-8?B?MXNQK3BYL0NNL25objc3UHcyL3NpM3pZY2prbHJQNW94T3hQcHlEQWJRZlFR?=
 =?utf-8?B?MnBhaHNXZlk5d29pSkg4a1Zyd01wRHdRUE1rZmtIZlRjOHlYS0lscEFCallx?=
 =?utf-8?B?ZFIweEVjeVRLMEJRa2gvU0pNcTBkVEZnMFR4Ym9NaTBxK3JiakVzZ0EzKzVW?=
 =?utf-8?B?bHVFSXgzRmNJOC9majNBaU1QQ1psdE9RdE5Vd0IwWVI3dVFNZ0JlRFpHM3E4?=
 =?utf-8?B?MVVIQ2FYOXcwRzkzd0ExY0s0dGw3QmJzN212ZVNlbmNVaGd2RDJScFpEeDg3?=
 =?utf-8?B?UGpFbGVQMkhBZm5PRGN4WDI3bmY0Qzg5cy9jN0JHdjRTd2VzelJGR1NMTGdk?=
 =?utf-8?B?N3FKWUlTWGt2QklDbm9XSWZta0dJQ3I1MEdjcVhNZkNXSFBoNFRNSFJ3T21W?=
 =?utf-8?B?dGFXeUdvRS9EcWxaK2hiSHNzd2V6YzJpZzhHbGpCZ09kTW9IQnNHWGdrWHFO?=
 =?utf-8?B?OUFUbERKMGZSRTBpK2pxQS9FZzZKR2QzamZwSkR1clpGQ3NzcGdva2NZdnV1?=
 =?utf-8?B?T29HUDg3cGNvQU9QSFRpSkI1c2d2RkYvdHVOQjc2SHVlN0J1clE1OUsvVHUz?=
 =?utf-8?B?RGN3RmJiYzZEbW92V1c0VWJVbUVqMGdEY2g2NGtWMU1sTzdtOFU4aitiMjlj?=
 =?utf-8?B?cytUWjRSQnZ3cThZWTVXYTByS1hvR1Q4anNQSTNtSVFXN1RVZ0pMZnoxVGhv?=
 =?utf-8?B?R3NqV3hlcmVvMGMzTHFRcEhrcmZIbTlNWXdITmVuY3lhd3hXN0VwemhrQXRw?=
 =?utf-8?B?RzFwS0RUY3BuUUdNMnJLQmNIbFIyb2ZYSENsbjhQSHFlSXNNWVhkMVVVN01O?=
 =?utf-8?B?NExaNWsxVTk1WTBMd3pnL3BrTUtuN0hEOHlNbXVQM2Q1ME5UTTcydElsQVdp?=
 =?utf-8?B?UUVFUVZ4WDcyWDlyOGd3cDRlN2ZNdkdZTVZPYnRtdG9MWXJmTjcxV3RFSWMz?=
 =?utf-8?B?RjViVUl6RnBVNlpJSUFaMkNzVDljSjBld0QwZGdYV3JHL2J4bGlVU2UzdnVa?=
 =?utf-8?B?YnBIU2FkV2dybEJRUlBjdUhKL2Y2eXZEUjEzekcxOTNwVUJGUzRMd25xZGlG?=
 =?utf-8?B?aHg5VDNhLzQ2WGV2cEFrTmlESkg2ZkJlVktjWGpoUmNXcVkwbkRDMlZkckFB?=
 =?utf-8?B?dDl4Q3NBOTd3TlMzanNib3piOUVyVmpXYS9hbG1qcDRUMDlMblVlaTJoaTlW?=
 =?utf-8?B?L0FCM3l0R25KRnVPYXJwU1FEdGJwdHI5Q1E1WkxKcmI3dTFsN1ZXNy9MQkVn?=
 =?utf-8?B?MWdQV1RYcUVWNVZ5S0xubWVFT1ExQi8wSldiN2ZGVGJqUmlJY0k1dUFBOElP?=
 =?utf-8?B?aDdYdjhqNUxwV08vMTc3UjZHd2g5S3ovQTVTNDJtaU5GMzQxbFE0Rkpsd0Fr?=
 =?utf-8?B?ajhBbmlRYURvS2FQUnFraEZWMDVsK3JGcm43YjJQTmFXN2gwUVNlNG9kQUFa?=
 =?utf-8?B?eUh0VExUaDUwRTI0R3c0ckM5NXFydVZIbGlqZ2JSK1cvMDJIYjBveTduNXJE?=
 =?utf-8?B?TjJsUllsQ3Rpcyt6Q2Noc2NDNFFKMEpqQWtqWmYwMTdZMTBPUlFMbUQ1Zm4r?=
 =?utf-8?Q?11i2jIOJRQcRGZqoWK7uOUCLXYavqdsu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:54:38.2657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3447af-37b4-48e6-905b-08dca7398c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358

On 7/17/24 15:28, Philipp Stanner wrote:
> On Tue, 2024-07-16 at 15:32 -0400, Stewart Hildebrand wrote:
>> ... to reduce indentation level. Take the opportunity to remove
>> redundant info from debug print string.
> 
> Is that intended to be the final commit message or is it still a draft?
> 
> I'd call the commit "x86/PCI: Improve code readability" (or sth like
> that) since that is what the commit is about. It's not so much about
> the code move per se.
> 
> and have a short message such as:
> 
> "
> The indentation in pcibios_allocate_dev_resources() is unusally deep.
> 
> Improve that by moving some of its code to the new function
> alloc_resource().
> 
> As we're at it, remove redundant information from dev_dbg().
> "
> 
> 
> Regards,
> P.

Thanks for the suggestion. I'll rework it.

