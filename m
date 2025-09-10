Return-Path: <linux-pci+bounces-35833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C1B51E60
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29EA1C86C4B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754BF28507B;
	Wed, 10 Sep 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IYI12qWQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662F22EE5;
	Wed, 10 Sep 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523379; cv=fail; b=qf4j6oYRk3rc26yyn4NhsnTJbsAVertrrs5icDWnp3o+f31KUfWPCg/oNX+0XTehxxSXNyMoVq+rjRW9Jjijzotp2Z2VtmuJEdTLzGCDfGo1lvXQUHGUhncXrIXJy3Fv6sJvaijIIkeUX+2tvATfXHeKiqdSzuxv4JO3ZdRNq3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523379; c=relaxed/simple;
	bh=f/zi2mQivL21ofP5YQPOPRzHqvZl+3WhxIKuitYyBXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XyGt7kZoVgcZuDuziMfHaO+lSIwpyXPf665+Z3CsoBuuQziAMyvkRk4MxIbhSafTYzlp10pwYpHVeHBa0H/qgmodYwRUxEhx8NFKRq8GoZ884ScOEveh4lIdwzK/ysJGVuKqXOEgx/Uwf5lJRuJWR3Fd5BsGfOPPfyph5oTKrp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IYI12qWQ; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn6zN8NyfelgI5nYT3PIyxO1hrlv8puJ99WocC4tx0t1HXoF85hkQ8+YQ9ZKBjFjwcMp3DLFWG/25QhJ21AU4HlTOaqeZ4fNFJKzHm+tskKShMZUoFhr2rBecrCuaBTJemu1cXRzIPtFT1KlSYcZu5UUGUF95b5USIRrfv2k71wYkdMALCByKuXOwpk4Y8wsw4d6tg9/md1U7NLb8C6KDypXeeR66KAEdyA1OxHDyrB8If80n/tnHjMurL4yjdHLsI2v6USSNhEZfQVQzQGyAcCzmK5HtDegV2hcQdEnMxnVfyNMelJs7IGM2hDqN0ebWzlHdZislTKiGf/UhoUbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WULOvB/ffOhFtHlgEWP+kUvb4hlrHgQiudj3V7mJCI=;
 b=lmvCmV2M/DxlhL8SIDg5IK+7aaUXBVBZwkza322jXw6v5Kx0+/HcQQ1G/EzDcabepSVBq4GIjdFATKCGtNogXPRRKz3CKRUaDrZLLa0Tvkw+fmXlE5C4c1FTqOkuICUiy9mSotUuF5olfxjWhQRyHTeEsYYI1zZZNbSVcn7PAut52u8R4hz+wneCDEOd044XadBr9T0gqlRQOgrw63fZMpHy1d15bJ1YxCK2xV5JxVRH9eg7f+s6j4WPQrdi38/qWHCXYIRx6JwD6jy0uxu8ly/6HzY0BIR98TI4us24Blfse5a9TSpBkNHCiWKV5zmKGqMp7rY6B29ZPLSWL6oI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WULOvB/ffOhFtHlgEWP+kUvb4hlrHgQiudj3V7mJCI=;
 b=IYI12qWQhYYHkZrrG3ukOj/1YtT1k/n8TnZA1QyLaLwXKG1gViqZUovtFK57AzIclUYW3txWcz7MEifyET9Ah46FlFxwlEE6euQt2F/fXZnJ9YUFyUN9R40tnL1Je15kJ7YOmVKVNptsXfhG0chYGa3CRG3UAy5D+a+WZ4LGnd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 16:56:15 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:56:10 +0000
Message-ID: <01c07206-de24-47bc-9a53-5d8abf417e32@amd.com>
Date: Wed, 10 Sep 2025 11:56:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-7-terry.bowman@amd.com>
 <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:802:20::21) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 244a3a5a-a52d-411a-985a-08ddf08af10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2RCVEkrV2h4d1A0UFlUTjFrVldWdm9PMGVMdjNENGNwL0dGUjhDcHZGdGpZ?=
 =?utf-8?B?dDlUK29LWU5oRFFaSHZwbjVKUVc3QS9NVmZHNzZKT0poZnlGd2EzWUlHYWJH?=
 =?utf-8?B?UXNWbEUyZEd1WDRMVE4xWDFIT0dEMEpNQlIvc09taUVHVUJSVXBlMXBrRUxR?=
 =?utf-8?B?bEVKTloxWFNESFNGRlVHUjRiei9IY2dVNzFYWkRoWFQrYTMzTWQxOUtRNlBL?=
 =?utf-8?B?R3dCRDZNUVUxWGhJVHhIbGhtZ3ZYU1NKTUVGVWxWRkR2d1hyUlp2cXJOTkpj?=
 =?utf-8?B?c0d6ZHlkcG9QdUxvZk9mUWhuRk96SFgyY0VTeHNGYkxVbU9RbUJQZGlla1Y1?=
 =?utf-8?B?Q0kyZlZnRDYyRkl3RkRUNU1zRnd0ZWw2Y3JsZS80dW1yYVJEYmxUZzNCTzl3?=
 =?utf-8?B?NjdBSWEvdHpDRmo1M3BJZ1lpWUZHQWJiNW80UTVnNDkzWm5CREhscld3Qlo5?=
 =?utf-8?B?ZHBZQkZqMXFaVFNHemN5aUFxZVA0RHVCNXU5TnlMM2NIMWZUYmFGOTRrTVZ2?=
 =?utf-8?B?N1JJczVaQTFpcTdGK0xtV3k4N1Rtdk1vbjJwc0FCQS9GeWRaU0tua1U2TDZ4?=
 =?utf-8?B?L1FSM1Y1dVVsT2JnR29jNHhCc0h6ZnFiNno4NWg4aXVlV2J0aWpxTjM0Nmw1?=
 =?utf-8?B?QXFpU1d3Y2JsSzN4S2g2SDlPSHQvbXpnU1krSkFHT0lMUjJFT2M3RGtwOGh1?=
 =?utf-8?B?ZWtNcE9jQW9oVmJqN3NTTVhUYzBxSDNJRXZkRWlOSkJKUlhxVjVFNjViYkF1?=
 =?utf-8?B?NkNLR3cxRXRRUDVxeHI5eE8yZ1ZPcEJMa3g0M2xacm9ZUUNFSEIxZW54SW8w?=
 =?utf-8?B?S1JiQkpoaHluSjlNdzZubnlSYnpCdU1DSWVzQlBvcnFOTmhPQW5YSnlOc2pR?=
 =?utf-8?B?cjQ0RmxRQzNSeEM5S1FuUXdONGowRzV3YVk5dDgwK05lRWJoYmFXWXNzK0tO?=
 =?utf-8?B?Y04zdlhlZkVHcVNyd28xNWxWNXVzeEhFMWlYWERuUzZya3RSbmY5ZlQ4VlBX?=
 =?utf-8?B?UUpOUkk5RVFycWllMGRqWmRrdmVrTTBtcm8xTDNvRVB4RFB6b0g3VENyQzdw?=
 =?utf-8?B?MnJTUFV1bm8zY2orSTVvRFZUa0t1VjVlR29mcFAvUzY4VHFzOWVieEt5eWFQ?=
 =?utf-8?B?bkNtNnhhNDZHMVhYNS9JdVhzWFBqUlRLQnU2a2Q2dGI2ZmJUeklTdW9jMUc1?=
 =?utf-8?B?N1BXcmxGV2kyTTRrNWFiZFhDRW5OQ2VUM2hLSEdXQUFsaWtOaEdhVXhUNHlI?=
 =?utf-8?B?YVVpVTVPRk0rcUJUcnVMTTY5WEh2bUwxYW52ZjdkaHczQXQ2NUh5TFJUd2pJ?=
 =?utf-8?B?L2NNRFpIemRqVmZYdzNNckdTUTNjSGd6ZUM4dW5hbk9Ka1JrVElQMU8xYTFC?=
 =?utf-8?B?MWNzd3ZNd3ZpS0tHNVl2dS9scHZ4UHU1YzFSUDM2VzhvdVo0TEkyeTZ3TVRy?=
 =?utf-8?B?WTRRQ2hNSFpUVHM4RW02UnFNSnJhZmZWOTFPdzBEWlYrSHdVMWtzaWlsYTFt?=
 =?utf-8?B?RS9TL3N1ZUF6WU4rOXJGbW5hWFRJM202Y3dRUlhTMEQ1TlBEdlQ2TTMvYTVU?=
 =?utf-8?B?b1BqMWpCSTVJNUd0TUlmeUV5blVFYkoyYzR0K3NxZTNuaDVYNWt0UXJZMjV4?=
 =?utf-8?B?MlRMVDFUVEJEWW1WVDhVMUcrTm93Mk1KVW1TdU92bTg2emM0QjUyWS9KQUkx?=
 =?utf-8?B?em1SQU56YU5OeEFRYUs2SG1mNHgxcmNZOXhrZ1F2emlZcWM0NE5zNWdJV1N2?=
 =?utf-8?B?RGNCR2s3RXBLbzZFb1BnZUM2V2RTNENCT0NDREs5ckNlNzZnbm9rVnlTWnp0?=
 =?utf-8?B?S1FNVmtLSUtQK1NCZm1Za1VKQjNYajJhU0lZb2h1NjNTbmJhN3pXU3BaMmgr?=
 =?utf-8?B?S0crL3ZjN3lZbStjSVdhRVFxUmEwZURZVDZISjVrWVVaNlNWWnI3TjZkZkhF?=
 =?utf-8?B?QnVNZkVIZFNISnJwajE4Vm5JRVBXWmFPRy90b0E5aFd0bWtuY096OVRYUGp3?=
 =?utf-8?B?Njk2SkZNV1JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlN2UlFFUXlGSjdid0lJdVMwZ3Bkd1lhUHNYS3QwckYwN3UxMm5hMnA3RVRv?=
 =?utf-8?B?Z05WZDdhZWlYNTlsWlBLWU5ZM2RGN1lvU1J5RGV5cW9CTC9KU3VKRjlVMFUz?=
 =?utf-8?B?QXZmSGZvdVFhaElaZU9xb00zVk1hdC9Sc3JlNEJwZndBRlpaWWhrR3VvZWE5?=
 =?utf-8?B?QnRJQmR3MGpkTXdJVUkvQWJsYUgwVHk5ZVRvUjlzaTJTVGFieXRWMkdxRVVY?=
 =?utf-8?B?M2VVTG5YaS9xeGhmZGlXdHhQQUFvbnIzTEgveDI1Umo4cEM1S0Z6MDgyOE5a?=
 =?utf-8?B?S0NuYlkvbXBwanNaTHFPMkpKMWNDR1l5enlrZWlua2Q3U0J0K2Y1bHhzcnNS?=
 =?utf-8?B?UWp2QXB6VnlWQ0Y4c2xQNUFSR2hFY29lbHAxM1hmdFByUGdkNlZ3ZjBLOS94?=
 =?utf-8?B?bXA0NDhRZWhYZ0hObDAxeEtRb2xuRFJoSkUxdmMrNGdFbnNhWkJiMGdwNHhy?=
 =?utf-8?B?R0I3WTJZWGgxeWdPdjhLbHFlVTJYc0JFMFg5V1YwTURZWUwxazJWOWJ4TlVr?=
 =?utf-8?B?MVFVVVNSa3JZTit3N1NtMm9BQWFzYlpMejJORlF4OFYxU3AvYVNkd0FsdGt6?=
 =?utf-8?B?MUdpanU1Y0RJbEtWVmczVWY5VXRoZUN3R0FIbG9vVzVvQnZSYU5XUUNSUHNB?=
 =?utf-8?B?bXZpaXoyWk9hcWZWZTZ4WDFWZm5sYlc2ZTJyQ0pXaHFjYVFIUkhhVGJ6N01v?=
 =?utf-8?B?V2tjdFVDYVdLd2VvZVJZRHpmSzFyOXJDcmFMUGU0amdodkltYU9DalRBZCt1?=
 =?utf-8?B?WFBrQ00rS3NDT29zRmVXZGtZeCs5dW9jL2VMVFVrYzVnWW9XRTIvZFBsaGdV?=
 =?utf-8?B?ZnZleVZpL1drRDRkbVVJUEpVSkhBTVgvTDRPcVlYdko5OGFqbXJ5WHVGVWFI?=
 =?utf-8?B?QUFWeDFxRTBkYzI3dDlFVm8wTDVOckVlRTRubDZJdnA2bTJvYWVVb0RJL1Rk?=
 =?utf-8?B?aHdJMWMvS2RPWVlYVGhPbXJVWTNFc20zOHRwV0dJcUV1K25pbU85VU9kbDlj?=
 =?utf-8?B?ZzNNSWdkSmZjZGY4M1R0YUhKRkNVZmE2MHZiZ0xRdGJRYWV6VURycHlVckdY?=
 =?utf-8?B?WW9ZRVhpWWNESWdKaHFqQW1mczNlUW1xdlJ2UlpUakZ4bGgvN2V1Nk5LNXZz?=
 =?utf-8?B?WjRmeDdEQ2E1ZFRZYTdFN2JKdDBXaytzWEhEQzBjdW4xSHJ6SVJUL0xaaXRt?=
 =?utf-8?B?eVFVVXNwaTgrbFNaVjVVMXE0dG5MY2FFdU1JcncyNTMvVjlYazNRTGpMOWNT?=
 =?utf-8?B?NmV3K2FtK0RwdUNiWkF5UmovcDNIYmt3d3VNNFJLMjJmdkV2MzNVeHV2Uk1t?=
 =?utf-8?B?VWF2TWdmSEsxZmpJcEM4MzBRc2htcmVkb1VwdWk1K2Rva1lqRWREQUZaS1Y2?=
 =?utf-8?B?KzdSdGV6TVM3Y242NzJFVWRFbFZwRCtlQWRDOWNSQW9xOU9rYUpJU3pHUU1X?=
 =?utf-8?B?NXFDSlMwTHo3UTdZd2krbkFqYkFBS0c4Y3JZM1pwVkY4U0hPSzM4MlR6c2J5?=
 =?utf-8?B?bUxjc1ZBS2RXbGdHaTRQTzlLVzQzcGF1NEV1TmJNUVJHY0R6ZHltaDM1RjM2?=
 =?utf-8?B?ZXJuSFovdjU2Nkg2aHhvdjZqK3pJcXFqZHJDYjROd3Y3eFhsMmJwTEt4Uzdl?=
 =?utf-8?B?MVRseG1rSXhEbmdYVDkyNEdYRGNKNW9NMzU2d2NYWkIvSmhlbzd6QjJQYlc1?=
 =?utf-8?B?U1UxSlU1M3hlTUhrRnE3Yjg1N3pqaGhyalNHV0pLSm9IV2lyYXZqMVpyRU5Y?=
 =?utf-8?B?YzV5QmxOV1ltRDc3c2Q3bGE3RmdWdEpwV0FzL0xXYmtBOG1pMmk5S3MxM0V0?=
 =?utf-8?B?YXFqMFd0Y016VmR3dkVqTW50TjdYelNXS015MVpobVFYdkRYcFRVSTNoa0RM?=
 =?utf-8?B?aFBEenlPYWo1K3dYVFNxOTBDWit4WEpyWFozUklPUmZlRzNIdnJkYkd3NnAv?=
 =?utf-8?B?dDVsVkZpNlV2WXVhVkZCOW9BU1NvVWpQREdNdTh1K25zUG41MnJwekJ2TENx?=
 =?utf-8?B?VHZ1ZFZ5T0YzS3czUXdTUng3eWpmQlpyd0tuNDh0eHNIUkU5YmxVRFVnSE42?=
 =?utf-8?B?LzA4NGw3Z0s4RndrS25uRnU1ZGxkeFM3OHFUb2d2MituNmd0d0NMV01JeVQ4?=
 =?utf-8?Q?oxlcs7g41ojSwq76gyR/MN1jh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244a3a5a-a52d-411a-985a-08ddf08af10c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:56:09.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGP9+obgRf6WLS2AWnEL25wPg7nhIsZlssHCosbSeUmy83sfDovFpTczJ4VyANxsDUA1n2eRW9ORzBuRUFEqnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978



On 8/28/2025 3:53 PM, Dave Jiang wrote:
>
> On 8/26/25 6:35 PM, Terry Bowman wrote:
>> The restricted CXL Host (RCH) AER error handling logic currently resides
>> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
>> conditionally compiled using #ifdefs.
>>
>> Improve the AER driver maintainability by separating the RCH specific logic
>> from the AER driver's core functionality and removing the ifdefs. Introduce
>> drivers/pci/pcie/rch_aer.c for moving the RCH AER logic into.
>>
>> Move the CXL logic into the new file but leave helper functions in aer.c
>> for now as they will be moved in future patch for CXL virtual hierarchy
>> handling.
>>
>> 2 changes are required to maintain compilation after the move. Change
>> cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static inorder for
>> accessing from the AER driver in aer.c.
>>
>> Introduce CONFIG_CXL_RCH_RAS in cxl/Kconfig. Update pcie/pcie/Makefile to
>> conditionally compile rch_aer.c file using CONFIG_CXL_RCH_RAS.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>> Changes in v10->v11:
>> - Remove changes in code-split and move to earlier, new patch
>> - Add #include <linux/bitfield.h> to cxl_ras.c
>> - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
>> to aer.h, more localized.
>> - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
>> ---
>>  drivers/cxl/Kconfig        |   9 +++-
>>  drivers/cxl/core/ras.c     |   3 ++
>>  drivers/pci/pci.h          |  20 +++++++
>>  drivers/pci/pcie/Makefile  |   1 +
>>  drivers/pci/pcie/aer.c     | 108 +++----------------------------------
>>  drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++
> I wonder if this should be cxl_rch_aer.c to be clear that it's cxl related code. 
>
> DJ

Good idea. I'll make the change.

I know Dan had an interest in the naming for this file. Dan, let me know if 
this is a problem or needs to be discussed.

Terry


