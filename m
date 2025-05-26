Return-Path: <linux-pci+bounces-28398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C21AC3AE8
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 09:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD433A3ACF
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBF1DF96F;
	Mon, 26 May 2025 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0AjMip9m"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE91876
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245978; cv=fail; b=ezSjjzMYSAM4/JSzI0A2y1xjTugHtZaMIpI8cRjCZ0NhiXBfSTRGN6RmaLHcjP3O5a3vbjo5xaJhsL+uZaoVxLbPKjx3yWgYhqTHsiMWnOolYWWR4nb8GnocrlutH4T1EQalhRDMxCLxoxh7ZMXxQO7WK4MGDYovuL9RUVyOvXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245978; c=relaxed/simple;
	bh=4L4EoQwRqm5gcWh4U+8CclUx5pGu5D7bL6EoZaKdwcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E1oMmXai6JhI4bTw+x7uZdhVdxBGvbt1dci4LWwS9Wc8IJuasse7FJHBwYQtBqGkBwBPhO2HN8YjqI6SwhO1bhUokLf3NhMWTnkg3c/Mf1FDCVh93lC8suYYznHAh8j6klurRc4yEgtEMm2RKz8KYHn5xFT1MKnoMI8oWDmqFTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0AjMip9m; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY4WAo73lp9bAzd1TG+tz6zpx0oeEA5RWysoo5NEYDfY8ubegCsGuiwAdaCLv9Y1PRs90GwyypJjF9+4FsRV+9AFMyUN8QqbppOV8DoVEP+en9BVUxHH2aOW1PE5MXUsXd5GMUPlk1GuZCW7YvfcmingKGagxwFxTjiav46PrB3pgCSh2YtN1hj2o0lJpUl+a6oPwzYjPQvJ04VS6RISXQG6QpqrF+RC9axC0VbKfMN8/YpslXWpPXTyZvyttSUhnxnOaXJPl0d8AvOaXB1vS9hbLHVXrIG3uMuWAuhOZOKlHKwweuirmO9fQJ4cw4tJzZbj3HuqHGzEVX/wwC5zxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bpfD7YOUyRSbZBxXQg4SPjBTp8Yb6KDpwQ+iyJZZ5c=;
 b=l4EFuCkgvYHi+cPMiPAuEYsbT0WHE+GsdKAUBWyZ69VBKfV1pbXaQx2BMulafYn0Feh6IyxkwGMldf3OrqeNncxuPB037olT75EIzO4NIVsDoCg6aP7nkvO9v4SP3SG8fv4N1Y7bMUxc+CsEnGlkfuUrSYFB/J4C0KsEYUv2f2Oj8d/UDExJ3G6GTrgicGt6F72AMQx+2VINzZNRyjPPn5svyAQOyjKYzEtqbxteO8woknyRDgTeC3cA7Ex8lxjq4XJmpYnZtkfkx0CJhV3vHceeXIrdId6LiUHqsl6PnkyXJHJ520ArVPHrKOMixvgKlWYgB22dD48MgFmsBSuyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bpfD7YOUyRSbZBxXQg4SPjBTp8Yb6KDpwQ+iyJZZ5c=;
 b=0AjMip9mdxIOnrxtac4y5KB9tlINCFC+LKeWXGseBd3lDMebylBIJzy8kzXNfoatikqAyEN+Omx3Xvt6Bp2hSznO7KVLx9g1usI/pNDO7OXHhK1j1iAbLFtbK1HYTFx6BDq3MQtBc00QYEUSxJNA2KsLTVyQgnmjz2o4Mfq3NtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 07:52:55 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:52:54 +0000
Message-ID: <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
Date: Mon, 26 May 2025 17:52:47 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5aa570dks9.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5PR01CA0013.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: fd95fb3e-0b63-43a7-6caa-08dd9c2a52a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0YwTlJmSWpaa3l4VzRGeGJ6L2VSbkhsLzVqWnJwQUE5L2I3Zm1lc0JLUXFP?=
 =?utf-8?B?TzdiNndOT3ZTT1pJS0Z6YWxMNGZob0xBbXJHVzVUSmFiZVRRMEZGRy92RkU2?=
 =?utf-8?B?c1RwTWtIQnloV2lQMjhLZ1hWbitGaGltRi9JN3JUSTlFOXRZYVdTOGZVRkQr?=
 =?utf-8?B?cVk4N0gyZXJZR04wVEFDdExuaGNobXNxSmhVTy80MWtFVjBHRVg3dmNZakFW?=
 =?utf-8?B?NU05dE05Z01yOW5DaDNRbGJFMkVPWHFOVHFlZG5DWm1SNFY5VlEyRm84T21T?=
 =?utf-8?B?NEllYlYwMkJOVmlzRGFReWIvUzYwTklhZ3A0NFEvdjg2bk94a2UzTWU2amV2?=
 =?utf-8?B?M0ZVWUU5NlcvcWpOQ0E1TTZuSU4zUk9lb3dtZGM2VlpYMndpdUJQVTdXcU5J?=
 =?utf-8?B?ZHIyY21TZGRBc3BPVGhDSFVKQmsydkhDYTV3SS85MG9XT2FDMFkvUWY1NWJB?=
 =?utf-8?B?Tndlbzg0NUNORk9YNFhZdm92Ry90YXU1UUN5N3hhZG5iamV0MFNrMW9xRG5E?=
 =?utf-8?B?L3lRbmw5TUsrSWFYTXpWSFd5c1ZMUmhmNTZiNUFnWWVRYytvZ2JtZW16S1gy?=
 =?utf-8?B?VU1vRjdtS0hrRHZzZ09LcUFuemp0Z0F1b1FoSkdVcEQzaytYdk5UY014SW84?=
 =?utf-8?B?ZjJYMjdIY1Y1cHBtR2JDaDd0ZitKd2hRWGdveFlJRlRCTGIvUGljbDNYSDJj?=
 =?utf-8?B?clRGREJVeWZHWWFBMVlUY0VWRHR2SSt2eXlXMjN4Z3J6UTNjT2xWZUV6Yi9l?=
 =?utf-8?B?ajhRMXNTVEFqelZlVlBYZVNTV0hpbmxxZGJwMjBCTkJJQ0R5S0x0SlFvUW43?=
 =?utf-8?B?eG5DNi9ZZE5NTDhjWUQ4Q1ViWldxcTQ3WnpiMno5UTVPeVEyRTh5SkhNUExM?=
 =?utf-8?B?aCtXQmVSYnhZR1IyTE4rcXhrVkpReEYzNFQxR3NTVmllUjE0dVZVTEZPNVVL?=
 =?utf-8?B?V3pBeVEwMmdHcXFFclhidzYwRkRSMFZKRmRKNkozK0tVN2VzWlBmWG9tKzJn?=
 =?utf-8?B?Y05WL29ra3lUU0tQZlZCRGo2Y1FzVXUxREdzV290alBGZDUvZnRRejkyU0F6?=
 =?utf-8?B?dVgxUDA4REo4VlFtUXZpVlpFb2tVM21saUdqZG1yQWNrS0lXUVlyWFk0QWxH?=
 =?utf-8?B?NGlEamFzSnp5ZDRVWDNDK1FUTWhvVTBheC9XRjZwd1lvYThXZ1gza1JyMGNa?=
 =?utf-8?B?eGhWeGRPUkZtVjRiQzFnaHpWKzdjWWZSMXJFNmZlSUpwWDljcVFvVU0xV0pC?=
 =?utf-8?B?dDh2c283TFUxbElsamZUdWtVOGcyWmRyMVZqRE1ucnRGUzN5U1hITzlWTk5N?=
 =?utf-8?B?OGRnZ2dVTjd3VDdPcytncS9xTDVHOUphSlNWS2xISDIvaUlNM2ZISUxBOVN5?=
 =?utf-8?B?cVU4QTJwMWRpdS9kTmhrK2ovRkROTitBV3JzdnlPdStqREszYjhlcGg2N0s5?=
 =?utf-8?B?K3RCNGxLcHJOWmFFeWNrK0d2bkdNcHRhZXBJMFN6Y3Z4UjZhM2xvckdHa0E5?=
 =?utf-8?B?YlZRNEZ2LzF5ckRoQXJtL3lKcHQycWJmb0xLcEpPTGhNVlZMaGs4TlBYTDRh?=
 =?utf-8?B?eHZicWl0NUJKT212dGlvYTZBWkhMTjJNbFBkUlVDWXBuUHhyZWIxNXZZR2Vk?=
 =?utf-8?B?ckVISDh0OUhER0FiYlFIVnhhTmpBdG12djk5U3pEdm03R01jU1B4b1pabURk?=
 =?utf-8?B?cC9aS2EwcDlrM21nMElYT2VrMWdXWC9pd2t6MDA5aXdTdWh2NktONFVqRTlM?=
 =?utf-8?B?alpPZFlKSWlNdW05YStyeHU5T0lxclJhTnhLU3p4SUhmYVQ0M0RqN1hNVVd5?=
 =?utf-8?B?amo2RjZLalVuQTFpL2tHS3RwQlkwZTNNQUJWQU1yVkVIeGhLaTU3cDhhYUJZ?=
 =?utf-8?B?aysvaUFGK09VZUtzNXAwdU1aNzNUZ3RTb1orc1d3TURBcENobDI5WXpVaHQr?=
 =?utf-8?Q?N04Og2cnDVY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzF4U2YxK1dEZjl4NDh5SmU2Nzl5K0pqaE83eERFVUZXOWY5Uy8vSkRZU2V3?=
 =?utf-8?B?MmFLSDI1ZUVKemsvR3ZGOWhSajc3NzRENVZROVlLYkI5bk8ydzhMd3drT2xs?=
 =?utf-8?B?S0ZwMTFJcGZoTm5mMDQ1bGFjSlpoNGJSN3pkUmJISGxaeE9lWkcxYWdvR2Rt?=
 =?utf-8?B?SE02N2ttY1VkUGc4cWVETmw2Sit6WUphL0dweGZlS2NNTVdwa0lIOFZsR1VV?=
 =?utf-8?B?KzBJUUVzYjcxNFFFcEcyOC9sS2ovVEdCN0NtRVlWdUtqWk1xa1BPZWJmb1Jx?=
 =?utf-8?B?ZUFESEY3SE91UDJPYTNEMWF3RWIvMVgrVVJaYzNiY28ra3ZubmZxaUlDYit6?=
 =?utf-8?B?Z3Iya2NOdnhERWNqZ0VZOGY1ZklJbnlxbG1FcWxXazVQcWtmV1ZMSExlKzcv?=
 =?utf-8?B?dGlHd2gzNnBjdW5ndk5YNnZXYWFTSEhyWjJDcVdNcG1RQ1dTWExiYnlxWW5v?=
 =?utf-8?B?THM0QjBjc3lGNzcvN1NWa0g0QjJESmZRejEyQXlSYzBvSjdDY3ZIMkpmUGQx?=
 =?utf-8?B?dDRna3hqTkY2MFdPWlpnUit1WEZLWTg2SGdYUnQ2TFpGUTFMaHp5ci9UbXUr?=
 =?utf-8?B?eURSRVd5eG8vd09Qd0J3NDdxczFSS2JVRFpVNE9aWWxHOStXNWlaOXJvdFFw?=
 =?utf-8?B?UG9XaDJQc2VjeXRzQ0h5KzJuVDh5SVgrajFSN0FMS2x5Q1BqRHJPRDU5TUdw?=
 =?utf-8?B?a0dYaWRaam9XTzNuVFNrSENyS015QVVJMWFzRGJpblZ3T2wwQUNkM2JuZ1NX?=
 =?utf-8?B?bjRib0xpSmtFSzhieE1kQVlqbnNiTjNUdk1zcUdYU3ZrbmRiWTVDTUhoaktF?=
 =?utf-8?B?SlFqWXNyb1ZVS2gyVUZlQ25RQ3R6VUJWSzljczY4ZjFWRnEvMmR0UmRCVXF0?=
 =?utf-8?B?TWRtU0xFMitYWjJhTW1hNldnQkhXcjg2a2g2bEVGRHlJZGV4QzA3dUlzaGJy?=
 =?utf-8?B?K1ZDaCtlMHl1aHRzZ2hlcHpjaUxHNHh5cSt1eUhlUmlzT1hJNE9tNDdhWWRp?=
 =?utf-8?B?aEd5eEM0Y0lJVEVpMU5EZC9SQVBrZUtrQklNKytpQ3hObDZrUmsxck1WeC91?=
 =?utf-8?B?cFZaWEJyalo2R0h4SjFQOWlYbXV4ZERJRlQ0eVJQTVl6RnhFMUVnK1lQNldM?=
 =?utf-8?B?Ni9RWEZGMWRONzdyK2hPSndmU2oxL3JhNkR0T28zRGZweldWZGd0aG1vTzB5?=
 =?utf-8?B?UmlwOEpiVXlMSkdIUE1rWWpKU1ZQRGhIbTlFMmhmYXhUSDRUYXZHYms2T3Zi?=
 =?utf-8?B?cTl3RjAvdHU4RnNRK1A3aGI4SDkyTFVQZXFBcmRwa3NpbnVEYjN6VzZCckp3?=
 =?utf-8?B?dDFrM0RhMnhRWWlWMUFpRFUzbVdDeWc3c3pqamZlZ3lDNXg5Z05tSjdSUkc3?=
 =?utf-8?B?QitOQzQ5WE9lM3V1YnA3YzZVMVB4Qm9CSXhLcDNjcDljYlJucVVmZXBMY2x4?=
 =?utf-8?B?dTRBSW1LdktkTnl4SHdtbHorM0gzdi9PTGxGSnI2OUl6TFJEUFFjMXZYTEcr?=
 =?utf-8?B?TUlCZEUyVTFLUkJIZ1VvbTloVnZjcVJVU3VYYmNSRm1ESUMxaWVmMEhpS0pZ?=
 =?utf-8?B?b3F0UFZOTkpYYTgzS01XdHAwaXd1TTJiY0JJejVmTldEcjZQM0F3S1N1U1Nq?=
 =?utf-8?B?Ykc0VkpNcmpsK0o0azdrbjkwR3NicDVyTWtGUFlwV2JxZWw4QUkwSElEQmJr?=
 =?utf-8?B?ME9CODd5ZmRteGhuNkh0NmhNNHZnNU9sWVI0cXI0K3lLMmtaV2kvbDVDbG5Z?=
 =?utf-8?B?dnRaQy82SnpXa1ZOcTd0TDRTOHM2SzI4STQ5QjUvaWJXbkR0OE5CTExLekw5?=
 =?utf-8?B?azhVZExzQUErdVF5WEF0dWRycDJFS1l0WlI4VWNQazlnaEwzSWh3OTFQTUlz?=
 =?utf-8?B?V3luUDlibDQxakdNQ2d1L2dDSERzNm9OQklHamkvM0lPbjlrRHJlc29peVRM?=
 =?utf-8?B?NU1mdkVtZERKSmJxV2ZodXNwSnJiU1NpNXZXM0VkTDluWDdRRnVMckJrbkdH?=
 =?utf-8?B?dWY0SDBraDZVb2JESHI2dHVRSW1kVWVnQ0wyQUJQblo3NGJLUDdzZGR6cHFJ?=
 =?utf-8?B?VlpEOEkwdzN5MzQ2UXdZcTlWVU5xTmg3TVZtMTRZdGVOVzBTSWJ1c3ZlWmlN?=
 =?utf-8?Q?pmW7yd/JIMmt9hs3rlehSbdMS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd95fb3e-0b63-43a7-6caa-08dd9c2a52a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:52:54.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUbCnMUUFNSj1cknP53IHAfFe6Lom4pCistrAU6yrn3+wlpBvEoqdS2/BnnC9WRTNs7ED7IIPiUQEgz79BIX4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635



On 26/5/25 15:05, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>
>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>
>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>
>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>> configurations to make the assigned device ready to be validated by
>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>
>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>> is supposed to be called from KVM vmexit handler.
>>>>
>>>> To clarify, this commit message is staled. We are proposing existing to
>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>
>>>
>>> Can you share the POC code/git repo implementing that? I am looking for
>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>
>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>> Jason, and make TDX Connect work to verify, so need more time...
>>
> 
> Since the bind/unbind operations are PCI-specific callbacks, and iommufd

Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,

> doesn’t seem to have a PCI-specific abstraction layer (unlike vfio,
> which uses vfio_pci.c), I’m wondering how iommufd intends to support
> PCI-specific TSM binding. Will there be a new interface for this, or is
> it expected to hook into something existing?
> 
> -aneesh

-- 
Alexey


