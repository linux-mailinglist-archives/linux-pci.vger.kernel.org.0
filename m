Return-Path: <linux-pci+bounces-42075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F45C86C90
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 20:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98ED7353483
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8F32D0C7;
	Tue, 25 Nov 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EWFH5OyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D6285CA2;
	Tue, 25 Nov 2025 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098385; cv=fail; b=R7YrQkDFq0QBgD8Nsr9UJ5fQ1QUlLeUN6DF2sbmczm1IDYTnySyOcIaQ2DjhdUrCcJaqY1VDZBe25tfVUGRnfTmWYQx1372llypVujwe9gRMDTcsbZY26+3O37BGk2YfdVbnpLDRgZ+t9lhL8cCLtkmEfRlVQ4ljXqE4fdIn3g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098385; c=relaxed/simple;
	bh=KXBPknPZPI9d3iEODWRQLDHIZ3T8vqpGqK1pyg1qOd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dGGyOz1GZuYRYz+9cadj50qljTDdHPsmwhvjL23FYI/d0zTis9gcCzbuT5lv3mkBpCiK6vGykVRjq5SixMbNb9rU0xz2Ir2DcunxjHN3XGMJ5ce8Km14lSlDGRcioQJvA7+xblToXjlhsGqO+OQDAB7kwngNu+n2Qrolj+cN034=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EWFH5OyO; arc=fail smtp.client-ip=52.101.61.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJWoWOg7CKC9xZP5cZEFeXgOf3GMlDiKW8gjchJPiQ8yxm9tEGgUXFTqsgu2aKnOGng5wpnyK4q+l5tiAYT3zHefFdVJrGMdzC5PPcjkGv11IGN7TYt4j/lumgd23wCMoEsNkpGd5HckTaCx+IUQ/gDwJJSJSB8iwqUqzo45B4pH7ag/wVG0TO59urEuR8t4V5ScAw8nE+hrUMHk7cIyyZIx5pGh7y4HbBTQKK1zAZc7EE4ki0Of5Ci7DhAwZcGJ1JbRTZAu30GCCvns3duT+nLl15Lse6mnWGlAW4NvetVWQJUZOHjE7nYqj28nkdhN2ppJlnS902jH2VIJW5qrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG8BPHCD9rb2gV2Ikj6GDzgi/3F0eBuHhtaPP5VyoLc=;
 b=gteV2crusbm5BZL0m+A/vfvST9NA8MuzKP2rzeAGn+fdnSurfnQqmgJAF36e9P8hhsmB0SX7ipJQQbAMeajOF0xHX+gb3EphZPYC6hhfOqXej6W61qb2yjoPiW7K2l8YnD9M3BGbWZu7lSJHer3INI8U2PzHfewD8U0nwpBs0vdH7LSob98EpL1r/6lP/Uqfqm4kdj34LycqLHc4fI1xCrHKCoKiF1WhFkEvDbuLMwzZRUcAzRGJ3IvT5QUGR/DrQOuVvKoOlBuHr74vy3S0qYhnMCxTHBQSxlXxZ6rMAEnC/++eG+7cMcDiZzKPbYzjW+4gFQNUr1OE1kXMF0RQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG8BPHCD9rb2gV2Ikj6GDzgi/3F0eBuHhtaPP5VyoLc=;
 b=EWFH5OyOMWGlT8UhS4/qw4glV0AESNRdm8DqHIKqYsxN+qyo4eMMWs+6/yvjLaa79TzaS3y4vExv6mO0/9ixI+939hCHUVMcdHPYw07Cc1IAywVu7BHDurhz9qxryoC2Ew8qhzoQT4QFDQkOOQ10MPYJRqCRzPWb3PST23+mkGo7hUuB1G59GW/RDoUcpAWFfID7n9jJs+2NiBX/YOCGAq3DLM4NdepWRPxHeLlcQedfb6UZXUbkpH8tmjLvIAtkKwqOx/anQFcnMyvL5B9NCDghw+L7/iHavA+Lt+hwfFOwYQPWTiqgYkXXdvOg8CjjL5Ma+cFdjEARl6lQ6YjQcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:19:36 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:19:35 +0000
Message-ID: <b0715438-af4f-441a-84c0-8e4abc621df6@nvidia.com>
Date: Tue, 25 Nov 2025 11:19:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io trait
To: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dakr@kernel.org,
 bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
 cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, joelagnelf@nvidia.com,
 zhiwang@kernel.org
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com>
 <DEHU2XNZ50HW.281CCT1CZ79CF@nvidia.com>
 <DEHU7A4DWOSX.PZ4CCKLAH9QV@nvidia.com>
 <CAH5fLgiCgMse0-L9Fb_r=3umucTqNosfO4R+1YVzOqavo07zMg@mail.gmail.com>
 <DEHUVC6D60HX.CBJ6ZKGUMA8K@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DEHUVC6D60HX.CBJ6ZKGUMA8K@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: e31fb6e3-9c90-46f9-c803-08de2c5791f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2hqMEFGTXp2dXIrT0RKMUl3czRsMFNsZ1gyeE1Da2dWMFVzb09zQ0NZVEJl?=
 =?utf-8?B?MU9rZHpaQUp1UXYyM2cya2RZTXE2QnpZMWlia3VNWDFYWmRSclY0aXpsem56?=
 =?utf-8?B?alN5aGZwZE9CTnl1dkxlNWN3Vk1vVGVtSXg3NWMwa3BQWCtnMTJ4VGM3TFM3?=
 =?utf-8?B?VVozMzZmQ0ZQTmZJNWh4WVA1aWVhcG92UUNINTRKU1RiRTkyclByN0xhRnVm?=
 =?utf-8?B?UVMvVW56WHJkbjFuUUtnZ3lNRWtlL3VVVVVrL2R2em1FaStjTENSZkU0b2Vu?=
 =?utf-8?B?UmViUXNmbzdnWFJVdWpZQ29LemdYeCsrcnhTVHJuWXVSUDluTGNlVGFlMUtw?=
 =?utf-8?B?R2FPN1YrZlVLVURrSUsvV2s4UUczY25yOUVpTE92aHBLTHhYeDcvRnJJQ2Qv?=
 =?utf-8?B?b2cwelpKeEF0MEVkRzVSMHVzVGozYXoza0VEMUN2YXE2NkxGdUdPcktyYlZN?=
 =?utf-8?B?elFMUVM4bnphbWlROEZ3M1psb0JqTkQvMFV5SUlpbkh2aFc1emNYWFdqUmFK?=
 =?utf-8?B?TUxvSzBtc1lJUzdDWjBXaXBCNWd0YjEwRHhaQVR3Ym9OaTVCZWZGQVZlM0ZC?=
 =?utf-8?B?ZzRnb1VZelJJZllpL0VkejBNdEZwWGxRZVBuanU2TzRXeWE5eHVnWlluaGc2?=
 =?utf-8?B?UXJGWTRjbktrdEJBZ3lyQXBvajJHMFZxRWh6YkREK0toZjFOQ05PUS8xWjJa?=
 =?utf-8?B?MUNDMlV2YXNjM3FOa2c4OXFjNXQ5RzdZdXh5Nm1qQnR2c3U4RUY5MG40Mkw2?=
 =?utf-8?B?RXYrcDZQVkN0UWI2YmMxOGxGcjhnVzBMdVN0bmVhV0ZKYVFhWUtCaTZJbWhI?=
 =?utf-8?B?bnlQaWptdmlKMDRvek1EZkUvWmVjZ3NTZzR2eml3bVNhM1U1WHpCMnBFZXpm?=
 =?utf-8?B?VlJwSE1sZWlFUWk5WlFUdGI0dFVlNHpTdzh0b0ttbmVmVWRHKzJIQzFLRk51?=
 =?utf-8?B?VnJ3WjJ6d0VmVlFnQmw5eDY5NXpZYm1ZWjRGZXhYMzM2azlGWUFycFUyRFVy?=
 =?utf-8?B?cHd6clRxSm53WGhiZTk2bXp5Q0NjQy9MRUU5RGNvcE9kZ0gzT0FoWHpaT0l4?=
 =?utf-8?B?SmhRajJNZVltMEZrNTI5QURtSTIwZTFneHNFY3d4WkUwSkJlNk8zUjBtejZ2?=
 =?utf-8?B?ZGFVWnF6cmpjMDVjcWo1Y2FFZTlQQXJobE5KK09jMFlTVHdpNFBqRGZaZHdz?=
 =?utf-8?B?Y3IwRGV3c2pFK0tjTklJU2F3UVpCd3lrWVJUT0JWN0ttd3F2blROdVM4c3I0?=
 =?utf-8?B?Sm9zdzJFOEZ6Z2poOGhEMFYrM3pMdldsMEsyZ1lpREovTzQ5R0JJaXc2VHN6?=
 =?utf-8?B?cHNhVkxDSnNqa1AxakRLU1EyV3NoYkZMV3NVaTYwVUNaWlM5VENIekp4MHcx?=
 =?utf-8?B?NFZuLzVIZGpXeTZrMllJZWdGc1IvRGVyTWRIWExFcDUxVFcrT1hQMFRqZndQ?=
 =?utf-8?B?R0ozTTBZRHJPOVFwbEhjcHRUaXlSOU5JakJ2QVhxYk5uVE9JUUhOZTkxZzF6?=
 =?utf-8?B?YmFSNEs3Sm1oOFNGekJ5ZGxHaG1nZ3l6YW1pL2hwTThyOHJ0R2cyMHhhTXdk?=
 =?utf-8?B?ZSthcElySlREakVLQlk1cEtFNVlQYzFxbVBJaWZ4YVd1MVgyZHBwelhiU2hJ?=
 =?utf-8?B?TTBvRm5PZ0szemdOMWJFbzhkWjdlOFBrd0ErZVVJdWdZTWJuVVhrbEtWWHh1?=
 =?utf-8?B?TFlWZlpYOXV1RFk0RlllZ0oybVFaR3M4VU5welR1bldSWmJZdUxZOWsyR0R6?=
 =?utf-8?B?bjd1N3h2QXRuSHhmQi9BKy9FYkUreUdYcUdLRHFkS1lGTDc2bE1EQVFWOWtL?=
 =?utf-8?B?VElxRkZQNVFqUDB4N1ZsRUk4cjR6OUJKMkpyaVRKMlhYL2o1OWUrYXF6N0x6?=
 =?utf-8?B?d2UrZGtVOUlSMkYzc3BtOEdaRUtaYlVnVjRnN3djZXQ3MTRnWmQxZUlURk5j?=
 =?utf-8?Q?jRC1UpfWoIoG3uy0qODzmCRIkTj74xYv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFk4V1MrV0NXYmQ0M3Z5eXRmQ0RjampSMUZjY0k3VnNMWXhxRmMybnFpZWZ2?=
 =?utf-8?B?Sit5VzVVUEE1WjVyVGdrSjhTN3pJTU95UWpsRzl6RllRK0kxOEhtQXZUQkg0?=
 =?utf-8?B?U0ZoMjN4YWY4RTI4a3hCQUpLZjRnMm1nN1I3ai90Y1ltVFFtVG5QZ09KYkJw?=
 =?utf-8?B?SUNWTVlycEl1b3l3Mjl3ZTltSDlvbjhDNGNReldBTldvcXc5OVh2OHpzRFVo?=
 =?utf-8?B?bnRRWnlsQzl6RmhvK1NwVUljOWsyRng4Z2pCN3pTQk4wY2ZTcy9jNGFUQVQ4?=
 =?utf-8?B?emlsRG1XQmVQc1M3Rktub0pDZVdBSk4rSmNHQ1p4bGU4RFZiSXJlWlllZjZO?=
 =?utf-8?B?dmNnNHZGQTRWQ0dUa0J2RnB0eTd4cTg5QjR2cnllcEwxYTd4MDUrcElla2VS?=
 =?utf-8?B?OTlqNGN1M1EvcE5qZitBQ1hTZ3phQkhKQ1NVVlU5eVJieW1hZ0VWdmF1b3Bk?=
 =?utf-8?B?NzBUMnVyQ2YzQmNiVStEa3czb2RNd3lpZ1BsR0ZBZGhpNFdSRVc4ampzc0pv?=
 =?utf-8?B?OUFZZHNYeWdPalhtV3lOV1BLUkFLdnlUSXVWYWc3bFFKZnc5TWpxNlo0Mnd1?=
 =?utf-8?B?MVNvYVBxeXhyWVd0NHJjMGtHWVZsbk5qRk5GU3ZMTHJkYUlSNkdSWWRsN1pW?=
 =?utf-8?B?cFhJRzFibFg1N04wcm9acm40bGxsR0F3cUJENU04ZFhCRS9xanV2L3BlN0lq?=
 =?utf-8?B?bVlMTWZKRUdHTHEwY2hLV2dqeU9FSm1zODlWZmVCRVNZcmNXZEJ1ekRCb3Ux?=
 =?utf-8?B?WFB1cUpxckFjLzlQV3lBNDZKeTlId0NrRWVGRkRXcTllRFpkR0R4N1V6Nk1r?=
 =?utf-8?B?TnJIaDhUVmNBSmJFVFg3emNoWWxncE8wZlYvNWdrT2d3c3FiVENUcDhyaXln?=
 =?utf-8?B?VkpWUituZ0RHbmVpWlZkMzErTXJHWkduWHowOUdXQklUTGIvVVp0NUtUQkUr?=
 =?utf-8?B?MEZienFxWXZkeVBPVm9WbzBBcmw4dUQzUHk3dDhScTR1RnUyTEJHZSt1MjZK?=
 =?utf-8?B?KzFLdlF5c081L2s5V2NxUzJVZ29hamNyVHpJKzdZa1hDSHVwZWh3VWx1bkVY?=
 =?utf-8?B?Nm5PaTNiVzBFdnlDMXRzdXZ5eUVoVUZlakp6YjJYRGFiTk9xWlZoTXp5ckpL?=
 =?utf-8?B?ZHBsYkJmOVNEVTRJTjBuWkgvMEkxd0E5MmpQVzdnY3pFMmYxem1MNWp5NkRE?=
 =?utf-8?B?V2ZaZjRhSFJ4NEVNa3BFeXpEK21ORWREQzBOTFNibVIvaTVDc0ljL01MRk9L?=
 =?utf-8?B?dkw3ZVRRdlBvSjM5c0tTbndra0hnc1NJcXlVdkg2ekwyUytVS3loNXVmRHZZ?=
 =?utf-8?B?TlFrblVSekJxTE5Zczg3YktNVW42SVAxall5Zi84MEJPWGIrQUU1ZmdLcDMv?=
 =?utf-8?B?eTBTak5VcWNiUXJjSGdvcVBhQ25yUWxhTSttVTBiU2VhVnJaWHB4RHhoeWdV?=
 =?utf-8?B?SURId3ZHKzRMaXpEOGpqU1dEMDNDdEFHdkN6dUE5cG1CcEMxSnQrSlZrV1lM?=
 =?utf-8?B?SnY3V2hYT0FqMGlSS2w3NHFyWHlGdlhrblhXc0puYXIzT2s4TElna0JNT2JV?=
 =?utf-8?B?WmwwYzY3aDJoNm5rWlRmY0d3ckxtbDJXTktkbEVpUGVYMkpzQks2Q2dCcHZo?=
 =?utf-8?B?RU9zTTduWTNFSVdmTkFxbFBDWWJCYVZDU3FvaTlqaS9sV084MVpIZlBBTWNE?=
 =?utf-8?B?S2EwdVBYanNDVXZiQklieU4wejhRL2ZXb3owenZNK0o1Nmk1VWV2M204cXg5?=
 =?utf-8?B?Slo4S3hxN1pMT0I0OXc4NGxxejduRUVOMUlRY2ExQUJ2dDU5KzBTbDBNbkRp?=
 =?utf-8?B?Z3FCcnZOQkdOdUQ0NWtNcVhSaEQwa1cxMk1uQXU2aU03WW9JSGNUVG9CWjdW?=
 =?utf-8?B?YlZBYkx3dzMwbVp2RytUUkZ5Qmx0TTRKbzhubjZ2UEk4YWlwRm9SWHYzRURK?=
 =?utf-8?B?K1ZVTWM3ZHZiUWxpQ1NEa1lhZldPVXN1bzB0c3l6NE91WnY0TUtzcFlxZTgy?=
 =?utf-8?B?WmFRdzRBbUZHRnF4MUk2VURjaEhvNVNFcytZNjFoQ2hZSjZHNEwyRVMvNkoy?=
 =?utf-8?B?SWw3K25oKytuNWZNZGJhY1YwZmlTcmphYWZuNWdBTUJFVjVWR1laYWUwanVM?=
 =?utf-8?Q?KfKVBXZeySiy7CstCupEmzZPe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31fb6e3-9c90-46f9-c803-08de2c5791f3
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:19:35.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0WfY8Ll8zEhiphWkqYnp8cOYiDT25Uo9ZNPnbirU61CYdOxiIHli6zQ9PrUKKUIR6g/BVTOggk0vWmeNjq8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332

On 11/25/25 6:46 AM, Alexandre Courbot wrote:
> On Tue Nov 25, 2025 at 11:22 PM JST, Alice Ryhl wrote:
>> On Tue, Nov 25, 2025 at 3:15 PM Alexandre Courbot <acourbot@nvidia.com> wrote:
...
>> If you have IoInfallible depend on IoFallible, then you can place
>> `addr` on IoFallible.
> 
> Indeed. Maybe we could even make `IoInfallible` automatically
> implemented, since it just needs to `unwrap_unchecked` the fallible
> implementation if the range is valid.
> 
>> (And I still think you should rename IoFallible to Io and IoInfallible
>> to IoKnownSize.)
> 
> Agreed, there are other reasons for I/O to fail than a bad index so this
> should not be part of the name of these traits.

Great! That neatly fixes the naming problem that was bothering me about
Io*, too.

thanks,
-- 
John Hubbard


