Return-Path: <linux-pci+bounces-44089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2019CF78B7
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE9113007FF1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288EF29B8E6;
	Tue,  6 Jan 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="DPD/OxEv"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE211E520A;
	Tue,  6 Jan 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691645; cv=fail; b=ZJ4dg0zrhbhFsBolXR2RHrwogEEMJ39+i4qwtIh1XR4Nt3kOBV1Z5YFwXle6yD93XCfc/nmINfba1ZAhl8x8vF2tj3286uSt4uwB/Q4prL30JTx4wOP42UfgXVp6wZ25R7dTOtSMHvgm7hK+xadmw2Mw890OdsW0YLogJKEeNog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691645; c=relaxed/simple;
	bh=7jEBxVgKN5GiTftU8mJ44gGlw7dKCc4HDPW5jsuwAkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GohJZXrdxczXZRPIDlA9nQO4ti1kDzau5HntuwMCfyKtnSjc3SJO3P7l4M9UVxhtTyqCsm0zcUDqVIcjbmW3XtbPts+Nhftf1Wrx5QU8MRVWH4k2PkmTPGYtznt9Qn/jCOCkjrGEfWoUvyc60xBMnR7jClju+DI55A+6GYNULuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=DPD/OxEv; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzHGdBD2pPfWePE3PBXydIED4U79aGPx5tmwxwgbIdBMuGvu7/na4KF1C99Qi35umW7pRWLplxoRV7tdjbu8gdt3TERc0fdFiKMwaHVfVQQc98MHQSh+mSabZlcS5le+oY5JvnKSsZRrxIHwMyYZAakglMipu16a4y6pGCLucIO+BC8eQbM6BfaX05DqM9MSzC9GVAvWqadnIqOTYYMA2Qfzz+WxegCbDR0akeghh4tbvljhyXZMeTQQmB9TUGTCYnPjNQWSUdKLl3lTjUyDEdHmnm7TBjySvSAjf0IfIG37n7sjxmsZ2Yl5NZkvYWXUwyX0YjauVeZmKdMC/2/63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmEH1yZRZJXk/91oUg+npQSU/Smil41iqO+LJGaEwaY=;
 b=KidXnGPrUF17SRKlCDrDwrkKzu337jRkzQIudlxrxCX7I6ljAS3IcLo6ndXIFAGD5SiUWnX2w/MGv4bTpzIIqictI2TNVvFGxT5rJwF6NE9tdwoC3QLR9AHgq8+uS3nshxfhOyWY8fJxU5tGDeNF7M+d0cN4h4FgQJkm/1r/nWYc+3K3nLg1AAPPC2nu/+ZJT3cAZhiWl9LLro+QGVrFmmIYOT5Gr+wmLtflTEVBD7s/+/L+rLDKDkAjb5KXTvd4ot1kia7VIAc8yaOCfbF9bTht5q0+aH9Hp5QfVIW65JSP/wsOPGXNPETiqz6YstpICy3vQd82Y/I4cD09u8QyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=markoturk.info smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmEH1yZRZJXk/91oUg+npQSU/Smil41iqO+LJGaEwaY=;
 b=DPD/OxEv8sbbabzaW/aqD4+BknLeShBK5fQaf3VS7T4/2hhtbNme9BQ51NNJf3sZQ85jBcTSPmDLIDUysN5vW+AsUDn+tTfMIOERh3BUkg25YtQskrx9xNcqEsz0HNgjFKbqUa4ql5F6f339nwh5mY7/7PZ8UUuWBVWmtYW4fCdDfuf1j/9M40eZ9L2bNg+scmvqwrJSSb3ljuUOtZnGFV1UsrOklbsELjkorVFkstl/z2vrqVH6aAMCKqzjmO0w/bYKVmny/cWdTwwLYirR+aIySyR/N1eQjyMSn+dI/Pp6N8Wvalz+kDXegdLdPNoJRhk2IYZ5ybDDhvVqvf1Y1Q==
Received: from AS4P190CA0054.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::18)
 by DU0PR10MB6702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 09:27:18 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::26) by AS4P190CA0054.outlook.office365.com
 (2603:10a6:20b:656::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 09:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 09:27:17 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 6 Jan
 2026 10:27:17 +0100
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 6 Jan
 2026 10:27:17 +0100
Message-ID: <86b8f2fc-ffe4-40f3-acf9-547e5a5a579d@de.bosch.com>
Date: Tue, 6 Jan 2026 10:27:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 2/2] rust: pci: fix typos in Bar struct's comments
To: Marko Turk <mt@markoturk.info>, <dakr@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20260105213726.73000-1-mt@markoturk.info>
 <20260105213726.73000-2-mt@markoturk.info>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20260105213726.73000-2-mt@markoturk.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|DU0PR10MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: fad1e925-0148-42f2-9b0b-08de4d05c948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDRBakU1d096cG11MmErVWNvYkVYa203M0JKdGFibGVWbExMQVJSNmNaU1ZP?=
 =?utf-8?B?QXpoUmdqWDJKbE5HZFF2Y2QrVlhFQXlGR0FoSllMK1YvOTJocjE2NktaelpY?=
 =?utf-8?B?ZEFUT29UZ3FZMFJCUFRyNi9KbmJXbm85RDlZMDhrQThWRTNodVFjenVXTm9G?=
 =?utf-8?B?cStHK1Y2RVBGUTdaVWUzRVhYK3ZjVHpCaW85blJYeFNCY3U1Z1ZZdUZrak81?=
 =?utf-8?B?cVFmMjB5VTBWYyswNUU5UlFEbUFzblJ5YVlFUEtqa29rbm9JRVRwdlg1YTZl?=
 =?utf-8?B?eUl5ZFJBTTdSZDhBajBkZm9VaTc3cXFyWFZVQzZuMEJ4L0RvZFFlTGp4aHhl?=
 =?utf-8?B?MkxBWTlldGFGLytMUXhQdE1UdHhBazdxS3hGZjkxTWRUQVJwT2owUkFSeTYz?=
 =?utf-8?B?Q2tkd25OOFBSVG16blp6eDlZdC8zOFRSWTYvWDEvV1lpNjNJdzdVSnRnYThL?=
 =?utf-8?B?NTV2RUR5ZHNrV0MwMDVxSS9tU0cvTUI0SmxrVTE5OExaK2IzZVhxTlIxSTF2?=
 =?utf-8?B?b2tzV1I5VkdUZlNHQ0ExK3RnWjNXTUxTdTVUTk5iSlA5RTdncTIyZU5MRkYr?=
 =?utf-8?B?dHJTTmM2anh2czlld09DNUJwZGJPRC9UY3lLNjV5dytIem1mYlBUK2Jabjc4?=
 =?utf-8?B?c0RNdVlVRXpNVW8rcFJOa1k2NnFPN3kyakZWU0RueEpKUTBQQzcrUkgvbGov?=
 =?utf-8?B?YkxFdTkzMzRjMmMwa29yU015MUZTUXFLZlVmaDQvdktMSExxZk1lWU95OXcx?=
 =?utf-8?B?N0Z4cHhRUHR1aU1jSkhSU1ExaU9vVzZDRkxhbnU0MnZKZmVkY2M2QjZncjZr?=
 =?utf-8?B?VXBGZEdSME1XcDVtVGpWOVcrNm9tZzlsM2UwNXZ2NnNSU2xPbzZPc0JGcDU4?=
 =?utf-8?B?NS9MRnA0SmJmb0RzdzlvWDZhakhZb1NZOEQyKzg2V3ZHem5MalUwdG1zVDdz?=
 =?utf-8?B?cldSeHNCVzBlMi9sNngyY0UxcVRLTExWTUo1d3JhNkg5Q0JVeThNMjY5a2Mx?=
 =?utf-8?B?d2NHQ2F1TTVOaXhuMG04aUxBOHNEdHBaREVMQzZyYzhMY0k1N0grRzJua3lL?=
 =?utf-8?B?QTNrSkU1Qm9oV3JkelpHdmJxZFBESU1hbmpEYmYrSDJERTQ0dS9JM29xbGRX?=
 =?utf-8?B?TktqNjl3VWNIdG1SL1lacTUxdkhCTzJ0Q2R1UWsrSGJPVGlVUVIycGpkKytQ?=
 =?utf-8?B?TzZFb2JiZVFPeGNMWlMzWjlKWjlsOXV3V3JzejBleU8vdHhsUkYyR09aSEhD?=
 =?utf-8?B?YzM3cnM4L1F2ZmJKNngwQmxZSGlkaFNYempLa0hJY05Fc1VBUm05QXdHVkRq?=
 =?utf-8?B?Z0JRS0RMeFY4bXk4UTgrUDBodmI5TkNSU1VqRm5od1RtNTlzWElQRGJLYXo0?=
 =?utf-8?B?Sk11TzI3M1hXU1pGamlteE5BTUJVcUtvTEFNT3BmZHBPU0xVTkFaZmFob0tQ?=
 =?utf-8?B?K2wvWEhGcDh5anJwbUhWVU1kUkgvRW96d0NJVTE0SUZPZzZMODREM1NBbTBO?=
 =?utf-8?B?VERTUzJabXhVRjYzU0RCL3N0QVl4VDFJSy9KSDR0NDJxd1krdHQyVVVoeitZ?=
 =?utf-8?B?U3BBSEF4S1Z2ZWovK3JCa1pFd0hxYlo0b09XNEZYK242ZFcwQW9PdGkrMnBk?=
 =?utf-8?B?TGhXS1dBTWtNak0wQ1RiUEZQUTR6OEJMTU1CNndtaENHVEJzNjJFNXcrTjQy?=
 =?utf-8?B?bGxQZjBab2ZDb2dPMXBxSmk4RnpnV3ZlekU2MG9FTURrbVRVS3VLWVpGV1U5?=
 =?utf-8?B?Z3FBaGY0MTd0NTFkRUF4L2kxU2ZudHE0ajdubWFSNldRT1daY0w4YWlhRDVr?=
 =?utf-8?B?bHdaY0JpcUJISWFzcWZDR0JtNjBkSHdSUnROazRwU0hoM00xcWFodVBJYldk?=
 =?utf-8?B?YzdUZitIMnc3T0hKVmdMTnM1Qkd0RVhyUk00azBVNHA3emxCRnhoMlc3K2l1?=
 =?utf-8?B?UThMUVkrYW02ZmxOVmJQVkZtdFFJdzZGV0pSZ3BoNXVsMmZZSXpEM0J3RjB1?=
 =?utf-8?B?RmNrZjd5eUxjM2J3WS9maExDblc5TDc5a3hhbnRVM3ptcG5naXF4VS8zdmJ0?=
 =?utf-8?B?RWFheHZhN251eDlJSHRtSkpoMmJtVVZmYWllOHAxWGUwSmFyeVZHRWUxdjlO?=
 =?utf-8?Q?squs=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:27:17.9569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad1e925-0148-42f2-9b0b-08de4d05c948
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6702

Am 1/5/2026 um 10:37 PM schrieb Marko Turk:
> Fix a typo in the doc-comment of the Bar structure: 'inststance ->
> instance'.
> 
> Add also 'is' to the comment inside Bar's `new()` function (suggested
> by Dirk):
> // `pdev` is valid by the invariants of `Device`.
> 
> Fixes: bf9651f84b4e ("rust: pci: implement I/O mappable `pci::Bar`")
> Suggested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Marko Turk <mt@markoturk.info>

Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Same for patch 1/2.

Thanks!

Dirk

> ---
> Changes since v1:
>    - updated commit msg
>    - added Fixes: tag
>    - fixed another typo as suggested by Dirk
> 
> Link to v1: https://lore.kernel.org/lkml/20260103143119.96095-1-mt@markoturk.info/
> 
>   rust/kernel/pci/io.rs | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 0d55c3139b6f..82a4f1eba2f5 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -20,7 +20,7 @@
>   ///
>   /// # Invariants
>   ///
> -/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
> +/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
>   /// memory mapped PCI BAR and its size.
>   pub struct Bar<const SIZE: usize = 0> {
>       pdev: ARef<Device>,
> @@ -54,7 +54,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
>           let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
>           if ioptr == 0 {
>               // SAFETY:
> -            // `pdev` valid by the invariants of `Device`.
> +            // `pdev` is valid by the invariants of `Device`.
>               // `num` is checked for validity by a previous call to `Device::resource_len`.
>               unsafe { bindings::pci_release_region(pdev.as_raw(), num) };
>               return Err(ENOMEM);


