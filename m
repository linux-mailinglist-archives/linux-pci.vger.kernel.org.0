Return-Path: <linux-pci+bounces-23083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B9A55D32
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 02:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571C33B3EC5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DD1519BC;
	Fri,  7 Mar 2025 01:39:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020107.outbound.protection.outlook.com [52.101.128.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB366BB5B;
	Fri,  7 Mar 2025 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311542; cv=fail; b=TiTSEdW+M2bl2uyzc6ktphRUkriFQuhs9LLeK7Nhy0vy7SgonDoAG+wcertPmzFTb3qLXEsJ+ojnp6CACFtScw8J0QepRVe2Aau921/6JiJl/z0zfx/yqynSzYkzRNsaylbjHIPeFKBuHUgpNubKAw49YlUUls7yOWNzpJLEE9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311542; c=relaxed/simple;
	bh=OlgnnvVLSrBdYIMfMPZu9/VSgGBE8hfHNG02grXtGco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3eqgBwShzMHaQ7SJnZVIbdJKtSWMiFyR7pvr87LMQAG1VxT+YMlD75SYwQIzGkx9N3zU59Bncq7mtthW+fP7gPqSKQu9onaG8nGephFFmCoRMkeO1i/3RfqaTy6fqYtOoikD/fk/cN+2L/ow0MMJjlim5CCtAXVgFyKGFmb7rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.128.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGKbCQMhGlGKls5xx+kRW6dLLgnAWyIHvz6ZUQWqg2A2aYo1G/jXLmiYcVjdnZJ+N2hr0ay6+JWxlhM28krlUTY7TKad2eFoNnY+7eirKfy3yaDmbXbslv8OrL2E0jjvlMlI2UjGtxGvjQZaT5mwbNSTy4z9uoz/mDLNNAMFp59ySd5Yz1XCkDNhIHxs6cO9BNV9990h8CUM64dwwOJ01UF60o+PqFtLp8jT0acqPNCWE6TTAO9bUfnLLpRHfavOOYSxgK1JtyQF+ZurBsFACVBFAW3G7rgm8SFj30sf1PNTGhG/PthiUVCrnAuROKrjN2u0NE3JeaGvzcnqmj3Yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2Wxt2mnFkmkvbXAz0aLM5OWBdfHQFjCuUkO1Fq67wA=;
 b=OalU62QD9mqi9IifMr1c6wSnuB4EjVQL+LgZSwzHyr93xBX8YZvDlqWni8c1BEBncXOOoB29SJtU4uN+1I+wjnrefCex4BO1TXUBJxQnTRExhz26sY7L+XLFffjxGJzxcqwLmjyPnQljW+78DVx2cAP+4z8ocNOzJV7+Jabx2QSmUGp/pvofb/xixpESY1H/gMvaSH6Sog4cDdr5luw949kKEj6OoQPZPwTOhUQjdaciMSOGrJXjJDnZ1rOQoVY0mI7S4Ni6udN85djKd+9RZ/IuKI2KEZ+38sbkcNGhTv4O3fv07LXUciNjyQwaj/Op6Rs8+BuebDG9pDf+ywKONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34) by
 JH0PR06MB7032.apcprd06.prod.outlook.com (2603:1096:990:70::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 01:38:54 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:b0:cafe::8d) by SGBP274CA0022.outlook.office365.com
 (2603:1096:4:b0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 01:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 01:38:53 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C8AA24160CA0;
	Fri,  7 Mar 2025 09:38:52 +0800 (CST)
Message-ID: <79869ce4-c0d5-4b20-ad79-7b6244602d13@cixtech.com>
Date: Fri, 7 Mar 2025 09:38:52 +0800
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
References: <20250306162842.GA344204@bhelgaas>
Content-Language: en-US
From: "hans.zhang" <hans.zhang@cixtech.com>
In-Reply-To: <20250306162842.GA344204@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|JH0PR06MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3c992f-d846-4ea0-bde4-08dd5d18d1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk9lT2RDblViU1JKdUs2ZUhEM2FJOGltRmZvQXlBMVQ0QVNnbmVFcVM4RTlK?=
 =?utf-8?B?QkkxNVlxTDh1aWk1QW05ZXdZQUhmZGZXUXRSRGxmVmNLemVTQUJ0TXNHVnpy?=
 =?utf-8?B?QU83SG9mRjR6dkpmTWY0aDhZSU9uMjk0c3M2Vmg4aDZVR2JhbXYrazlWY016?=
 =?utf-8?B?UVkwM0lMR29PTUpMTFcxdnNYeVduV2lObmlsdzRBWFVnMnl6bmI2TTZzMnB3?=
 =?utf-8?B?OFJ3M0lKVmlYS2prdGFMaThYWFdJNDU2U2pUV0dyY2hNbjY3dEhoSTVBTXFi?=
 =?utf-8?B?akxTeFQ3eEwvdjNzUjZ4UFhJRWlXcFMzTk91ay9odDViSDQxNFFoUjZJQURw?=
 =?utf-8?B?aS9mL3pZR3pBRGJscmg3WkNQUVVYNWpncTQ1WmlFVzNldU91eWtlaXk3SEtp?=
 =?utf-8?B?RXFVZHdLS3l3eCtSNTFZYi8wbkNaOTNlaVhjYXB0NFE0dzRqbGN3ejJzb3dP?=
 =?utf-8?B?OU80V1dpYk1ndGd5ZWdNOStQdTVoeDJwdGdEUDU1YTVlUzNOaFk3anp0ajBN?=
 =?utf-8?B?S3JwRnVsNkF0L0tscnlhbTZ2TEJ2eHB2NVVJWVRrWEF1eGR0Z3FsenNaM2pJ?=
 =?utf-8?B?VjdySTB0V015WklMNDIvWEFzeG5COHlXMWFibVpnRjdlbmY2ZEh0VkxwcUM5?=
 =?utf-8?B?QXBZSnNPbG9LNjRGYStQY0ZjVTM4WTMwbHJKWVRHK3RnbXk0UzRrUzUzQmc2?=
 =?utf-8?B?dmNYT3hlWnhLclE5MWduNkpBL2NGUmpRZDk2c2lPbmZ2cEtlMDlYT2I3cDkx?=
 =?utf-8?B?WW5Vc2psV21vVktXeXlpU0gwcEFkWWZhdW15S2YyRkVwS1BhbWlDSVJtVnlE?=
 =?utf-8?B?NVpNb2s4WnVLMHJjQlYxUkVZMnZYbDNYK29XTjZ1eWQyMTU0VU1OZVNRZjMz?=
 =?utf-8?B?UTc5M0piZHVoY1M0MitSUDhLTUJZQ24rK3QyaEM2NlBxc2QyV0Ztb1E2Vk5N?=
 =?utf-8?B?dzdPbURnbEtIV0JaT2ZhWVRvZnJkb0hHNTdDQkZIc01tWkl0WTJyQ1crWFpv?=
 =?utf-8?B?am5TOWNNdXRwSWpzWXF3bE1kOWFyanl0bU05MVB2RnkxMGI0Rk5aY016NEls?=
 =?utf-8?B?R2F2QUFjZm1McllZcWVrMVZUdloxMUhWdUdGdEVwemYwYVNGZVVWZnM1SVdk?=
 =?utf-8?B?VFFFTXlZL2tGRkk3T0JreWlCV0hrcGJFYS9uc3FsdTN4QUlSRzFuS3h4UGJk?=
 =?utf-8?B?YWQ5ZFFVSmxzRFNvMWd2cGQrZW9rbG8rcnNrdmg2Q0IxK1ZJcjZzZms2aXQ2?=
 =?utf-8?B?cUhhU0EyWW53bFVIUTZvQ3hjc1ErVlRoL3gvMDBXc0VWYnBCNTF2R3BXbXRW?=
 =?utf-8?B?UEkvNGR0WVdWT1JuVk03dFRwaEtvNkJjOHczcVlhTFlZY2tlWG03NklFWnJC?=
 =?utf-8?B?TzZwQ1JwaE9pOURHVExRZDJrdkJGeWNsUFdJWlFlaEloSmdTQzFFOW1lQ05o?=
 =?utf-8?B?WHRWK2wrMGJEaStDdkRjbTZtUG5wZjFYaFZpUHZPTkZhaVphZlpvMVpFVUEv?=
 =?utf-8?B?STl3eDhpOVQwRUYxUGN1T3lQWU0yaWlkL3kyZUxZTDhXcGRqSjJENlBlY0lP?=
 =?utf-8?B?RHlXQXUwdjI2c2xrNmh6VFZMdHcvRFRaVVE1NFVWUXhnUnQwSE5tYnBaQmRD?=
 =?utf-8?B?bTBhU01ManhKTmtEbU5BdGlObVJkNWRqUHpQYjFrWTNsaXpWRFVpeVppS05i?=
 =?utf-8?B?dUtKNnBjdzhFbHlGTFJVSmFTTWtWbi9tZjZORGRFOXNvbXdZVCtSR2l0bG5v?=
 =?utf-8?B?MXdicHUwMHdrRFk4NjZSZEc0MlpYdXo2ZUZOUkszMldVMEdiVmFwVDlXMk9K?=
 =?utf-8?B?V1ZFTlozY0MyUE95QUl3OG9JSHN0OVlNYU85MTg3U2svL2tmWmZicHN2QkE2?=
 =?utf-8?B?T1E1Skg4MUdxVnUzNkE0VGlteFhYdTNRN2Jlbm9xY3VPVzN6MGNRM3FreGNy?=
 =?utf-8?Q?LNQUyKcJXZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 01:38:53.4099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3c992f-d846-4ea0-bde4-08dd5d18d1bb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7032



On 2025/3/7 00:28, Bjorn Helgaas wrote:
> [Some people who received this message don't often get email from helgaas@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Thu, Mar 06, 2025 at 11:32:04AM +0800, hans.zhang wrote:
>> On 2025/3/6 06:20, Bjorn Helgaas wrote:
>>> Sounds like this should be a documented erratum.  Realtek folks?  Or
>>> maybe an erratum on the other end of the link, which looks like a CIX
>>> Root Port:
>>>
>>>     https://admin.pci-ids.ucw.cz/read/PC/1f6c/0001
>>
>> Name: CIX P1 CD8180 PCI Express Root Port
>>
>> 0000:90:00.0 PCI bridge [0604]: Device [1f6c:0001]
>> 0001:60:00.0 PCI bridge [0604]: Device [1f6c:0001]
>> 0002:00:00.0 PCI bridge [0604]: Device [1f6c:0001]
>> 0003:30:00.0 PCI bridge [0604]: Device [1f6c:0001]
>>
>>
>> This URL does not appear right, how should be changed, is it you? Or can you
>> tell me who I should call to change it?
>>
>> The correct answer is:
>> 0000:90:00.0 PCI bridge [0604]: Device [1f6c:0001]
>> 0001:C0:00.0 PCI bridge [0604]: Device [1f6c:0001]
>> 0002:60:00.0 PCI bridge [0604]: Device [1f6c:0001]
>> 0003:30:00.0 PCI bridge [0604]: Device [1f6c:0001]
>> 0004:00:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 
> This part of the web page is just commentary.  In this case it's just
> an example of what devices might be on some system.  It's not a
> requirement that all systems have this many devices or devices at
> these addresses.
> 
> The only important parts are the Vendor ID, Device ID, and the name
> ("CIX P1 CD8180 PCI Express Root Port").  If those are correct, no
> need to do anything.

I see. Thank you very much Bjorn.

Best regards,
Hans


