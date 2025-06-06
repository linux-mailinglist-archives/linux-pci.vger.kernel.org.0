Return-Path: <linux-pci+bounces-29114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F82AD0933
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 22:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85AB1899A2C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B821420A;
	Fri,  6 Jun 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mzYMrW07"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A41DE887;
	Fri,  6 Jun 2025 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243343; cv=fail; b=Zwh593OFpi8qbW2/HVQ8a24sxP+/Zb6C67Iubou4VRbBKyoTNG99hV/lJiXX1fKJbnvjGXBNRN+XRanLCcIpM66KySaHl8RkmhluuIZt7iKTGwEI4tOl9Lw+15w1SgFbKzPTS9fkqNo8qDVT22OY9ymkA4lX9gIK9gMGyl/JIgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243343; c=relaxed/simple;
	bh=GZ4nUnuz7gglYje8DGWmKI0dU+oaUbPnWfc6YQNawgo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dpCPm1PIzibUQLGBQ1WxFyJLl8D8OLEoDFIi7SGKRFxCA64CQ3RLzuPZl9uxVSHAcUOMNtLW7OnxOVzMbRBhKREcxqGrJaSA+t4dReFkU0elQso91usAO8YKvGOPPH8gmSUxXUgn8IXhCRqhDsR4obfWzglBPK9ZGw+G5rHd8jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mzYMrW07; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRCf2pYpWq2cIPHo/z0iAcuXCRt+3Md92aWRGL+PaAMgdDX6cuUBNqeqWMBmgU32pniNnkcHua7XJz1vPsz7P2dYOuoLuzPL0uIdKq8LN/y8FjaDizhDppE4ACib+/K6c2qxmO9V3t0S69PVZsZIWD5SbJiKgF/FUzv3HI9+2xoHT03NEPwSzC9UxRItxAaIUSL3Qgbb4z8BeOtoDh2Hb8fhXZgp2abZfKI6gOr1sZ0Zw6rpdRseYjJN3W7SbcFei0Fhz6EqtbRx+UFiVMoZgdRGvdyF7BJlJesTNsFnlP+MrOOFRhgl5+PvYueENpajmASlhpZXLnAAPEAL1tXAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7XTUwpAL3FkrGs8/P52rD9uzfRuWk5b3abvz+mbiss=;
 b=i+IDRoCFPGU85X5eSb4lN9FOhOfb8lkbxjDMeEFCTAGRyiIbAIp3cqTH/QABV2Ytn7a+clvsO/PA+7/xOry0bqyylsp1Rl5U58gqGlArDL7ZGbae88A+Bbr5liiBBAOlyM1tz+OzcsXfzLBIdQ7PUcO2bx11OAqfOB+YcB6Wihgz9yMqTuj+/67jQVlTWQ8UMIhhYQYvcIXFDZ1QAeQ0Oh2bdlGkP8db1OI34Re4M3yAVam5omCklEy4SYOOwzJ8O89+uObJM33dC2YO06LZrUjs6tHW6a2nPV6MJTybsc7sblvQVObNniwHnRMpy7YP7VoE09GuW54TC9Ni/mJefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7XTUwpAL3FkrGs8/P52rD9uzfRuWk5b3abvz+mbiss=;
 b=mzYMrW076nf5EmupxEM5p6QbJqn9dea5bzTYdUt2go8ELjds2oXd0LZSaevKQnZSS2F+tblSth1YKQZGNx7vbvHwaZ5EgbkMVCvYztV/UnMX8TlvQ3tV2tL+jUeJXMHD6UfWAoai8aNe8DOf/C1uFXl60i5tHKlNH2Tja61zETM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 20:55:38 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 20:55:38 +0000
Message-ID: <e633dcd9-2208-4eb0-aeed-61af0206f6d1@amd.com>
Date: Fri, 6 Jun 2025 15:55:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/16] cxl/pci: Update __cxl_handle_cor_ras() to return
 early if no RAS errors
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-12-terry.bowman@amd.com>
 <e2d30ea5-1b9a-4e11-9065-3b30582de09a@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <e2d30ea5-1b9a-4e11-9065-3b30582de09a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4785107a-a94d-4b91-267b-08dda53c7db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mzc5TzlvTU5YZ0NVZWpicXJpcXZvTHFMMjdlMGVXS0Jza1JkT253alY0VHp4?=
 =?utf-8?B?Qm5uWGhBY3ZsZDR1M1V2aFlJMXNCOEtvbGROUnc2R25mTEMxTExOQldZbEJY?=
 =?utf-8?B?andMaW5oNTEvNUd2ZEV4NGJyRzFzcHh5RVBlTmd1UWhlRXdCSy9pdktZVXFu?=
 =?utf-8?B?elZOZnA2L29WMVJpdmgyLzNhS0ZMclFjak9VYVNQTWNIWHR4RC9EdldRTmls?=
 =?utf-8?B?c2U4dGhGL2x3d04xU2pjT1ZoU3JMV1pSdThEQzZoOVBqR0lUVjF0bW5Zankr?=
 =?utf-8?B?US9EOEdRdVdzVVJiVFhoWUxMak93TXlSQlRYVDJtWHYyaWFINlYzNzR3Rngv?=
 =?utf-8?B?NzB6ZXJhNGgvNmlsUDBGRTRBRHd5MGEwUE14T0dsaS9TcXJBM28rZmE2bkQ3?=
 =?utf-8?B?NGwyRUphYlpQYUVDZURhczlTajB1WEZJRktsUTU0bXdmdkZrK0syUWdaZ21E?=
 =?utf-8?B?UFpDeXNGSVdVUVdYN3ZTUjJXdTFoNkRuQ3VwaiswVVQ2NDhOTklraC9XdGNp?=
 =?utf-8?B?ajl5WVlHYTcxanZ0Q1owV2FiY3A0Zk12dmthTmlCNzF6K2hEYmhMVFVVWTB3?=
 =?utf-8?B?YVF0SlB2QTFrR2xiMmVYL1ZDQjJML016c0JkREFzdjZIMmhNRG5JMnZDV3Z3?=
 =?utf-8?B?SkpGWHhTT3NueTJQbkh0ZUVMeXdsREdWWEF3ZWJJWmI5WXhtY1AwLzJXdmNw?=
 =?utf-8?B?cGQ2WWhFeHJpTkxXT28zSlR5OGg2N2R4TGFjb2pZMmZ0TnpPNWo5dE44TEtt?=
 =?utf-8?B?anc1WCttSy91WEVxTW1Kd2J6VlhyR2JtV1A0cXQrK3RBV3h1OXNMRkw2Rm9m?=
 =?utf-8?B?M2VzTWFUN1Y1VHpVTURTakpITlJvd3cwK1NzSEhMdGt5TG5EN3VxZzRPSDRC?=
 =?utf-8?B?N0VuU1lxQy9kT0xGdmJNaFQ3TUpjNGs5RFg2b2pDQXIwQ2RPa1hYZkMrbEx0?=
 =?utf-8?B?SlJnV1FKbE0wKzc4VWhsVGlod1JCeDB0YVQyNTVXeXdtQnZ2ajZYREJGM2xm?=
 =?utf-8?B?QnNJOUxZN1FvdVh1UEFiYmlJbmZyaktoWHVmVHpXbE9vMlpMS2swb0kzbmtQ?=
 =?utf-8?B?QWxHZ01LSU9LVjE0N1Izb0FtbnpMMlRBQ1hkbDE5TU8wcGRqOVg2c1ZqaWJ0?=
 =?utf-8?B?Um8yZzM5SlRmUE95eCs4NzQyM3N0L2s4NXhBVFZmTXpqS0J6cnFOMkRNSzRp?=
 =?utf-8?B?OEt1Ykw5R2FKb1E5NjZwTFNZL0h5RlVxaXMvSVdBSVlxZStlaEo5aEY5bXFy?=
 =?utf-8?B?N1kydUw5REhYS215VmhiYzR6SmtKQzlBaTM4d0lKWFNrS0xnRU5vRFB1aEVm?=
 =?utf-8?B?VlVRakhrQWIvNG4zd0dOOE5McGhweEowVHVvSWJDUXcxaHIybE1UKzRQMXZ3?=
 =?utf-8?B?WjJLRE1rNXNpQzUxTHBPTVFqVXVZbFNrMmdhVGlGUmVTdUQyZnpMSVM5TG5C?=
 =?utf-8?B?cFVvL0xQZk5NektSeFdMTVIvY21kWktUYkpTOHMxcEJFM211SWFJUGZJUXVC?=
 =?utf-8?B?NEx2TVVINHk0Z3ZrUlByUXI5bThlVEdDV1BMYzMrMWZjdXBPL2tKVmZqVVB5?=
 =?utf-8?B?NVhYK3R5NHFLdUw5MmlSdDlyekwyM2wzZldGUHdGQWgybCtaYjZHYUl6WVAz?=
 =?utf-8?B?UFYwNFQ4QnNtWDNUMytnbnNlWUM2Mll1Z3JEcHRjWlIxMzZoVkovZ0RPR0JI?=
 =?utf-8?B?RTQ5MXhlakZFRW9nU05JekhhdVFmR25UdWFxblc0bzFneFhoYWpZelM2MW4y?=
 =?utf-8?B?WlEyK3J1UjB5d1JDbTZhWFRXTElIYVRBSDd6cW40OTZUdnpKRzlMNGpCWWMy?=
 =?utf-8?B?R1pJTHZrelRJWEhwTlExbmxUL3hEdk1JR0w4UTA0T2tuaEk3cHFzdW9hbzI1?=
 =?utf-8?B?aE9rZEpVbzdNZ2poQ2NkR2oyazEwSjFpL2pGZmxnTEJQS1dGWEI5NjUvZXl0?=
 =?utf-8?B?cTNiVXhrTWN0VnJkV01PU2xSNXEycG9xeFA4a0cwRGlnUHZaT1JKLzJ0eTAy?=
 =?utf-8?B?cnQvNTgxWGV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnoyVXVRc0xpWmI4OElwTjBTMjdHaEFIeElhelYvcmU4RHBrUkxDUnFzbUhD?=
 =?utf-8?B?Q3RFY1RRbE4xTm15bE8xRjVhR0JJTDgvaUl3MHdoZXVUbXZabFdWeTJFQXNT?=
 =?utf-8?B?ZjJLSjhzSE0ydzFaa2dNUVBvZURlcGJFMi9aSmxKNXdZWFVvMjl2NlFhL0Yr?=
 =?utf-8?B?SXVHMHUvSnBkcXE4dXNwc25HSzFFWUNjc21sbFdac2J3ZlIxK3IyZUI1aVI1?=
 =?utf-8?B?T2FqemdOd2dYa254bXNlYWd4MVp2ZS96cGxwNkxXdjYvMWRSbkVteUxEYmRp?=
 =?utf-8?B?a09ySkJRK1pNcnBXTk9NTVZNZjdtSldoOXlkWCtBOUJpZnhXNXNFSXJZTzkw?=
 =?utf-8?B?c3pCSGh1NGhLMk5hSVZ1cDllQmYvK0ZtWVkrUDV6cXBlenp1b203NHJCOGd4?=
 =?utf-8?B?d0E1dS9hUTZMWm9tRm9PK09CeHpyOCtWZUkxTmpRMHFIVVphSlNoeHAxVG5l?=
 =?utf-8?B?K2paMU0zaG9zUkc0YnFnV1Q3bjdUa0pDOWMvQUt0UC9oSEUwODlxM0Rxa3BK?=
 =?utf-8?B?ak5UVnZTeFpIeWRWcXc5MlExYzBsQS9VZjVLcXV5MUxPamVMQkhSVWdPOEpI?=
 =?utf-8?B?R3FXRVFNOEVxWmxRRXorZEo0QXptNW5ZMWM5aVF6b25ab0dML0V1SUd3aERn?=
 =?utf-8?B?eHNDdGgvMG55K1ZIRTRPV0RLTG1KRVZtQlFDRFVWZEpabXA0MmF3U2FsUXVu?=
 =?utf-8?B?ZHY2RHZnOFVpTUYrdU9DSkZibWJISERpMk1wN3VmSjRKQ3dpSWkrMHAwSlB6?=
 =?utf-8?B?WXRjcXd2VURwQ2VIelo3TkVPVm1nYXU2WUxvc0ZLZUJnMGFubnVsbjBEdlhu?=
 =?utf-8?B?Z09BUytQN3BHRlFpemxtVUhJYm43RHp2TzRYS0pwMmV6M25HU1hWcnlNalNP?=
 =?utf-8?B?ZHlOZzZ2THhseCs2enJBQTliY2k5Z0hRbURlN3M2MGlpNnZTK095WUpITGxU?=
 =?utf-8?B?cmUwZ0Uvd0NSUzFBYitUUFl1OHNaQmhFVmRLVlVqTW53Nk5VWndvYjRwZSt4?=
 =?utf-8?B?OUVqNU81bFJ3NllDR3ZTQWU4S3E1ZVE3cmdMOC9aUTFIUUlQRnYrMlRRaldq?=
 =?utf-8?B?ditzbWdiSmlUdVFRQ012V0U5dU1HOTNQbUJYUTJKRTZ0Y2NycVY4ci9XTTRk?=
 =?utf-8?B?emkzMklxYThMVzF0eEw5UnAwUmNUTW1HdTUwZzJsZmNDUTlyK2RCNUIwb2NZ?=
 =?utf-8?B?ZTNwdHc1OElEa243cGpqcjdUU0xTZnh1U2gxL3VablZqUUttL3ZNd0RicFhr?=
 =?utf-8?B?c2w5NTZNUW9mZENscjFhV2NWK2Z0czhmNWp0c2VUdFBOb3J4Z1Nid2pjaGdq?=
 =?utf-8?B?SzBqSXAxeVlLOWlldkJjZTlSRHkrd013Wkg3RlZFakxJdU5YNW16RXB5T2Zm?=
 =?utf-8?B?VTNDclpZcmNDRjNwdG5tYVNwNWNRSERTaGtNcFUvdkFVV3hYeTIyMTF3U3BQ?=
 =?utf-8?B?dUw1bGR5Y29HNWlkNlVxSGlxRGRLUU5NQUpIODR6Z3ZGMHluY0dzQmNFRFZ3?=
 =?utf-8?B?SWRsOWZIdXprM1lqQ2RRL0FpendRRlRaWVlUcHRMVGlVZjNtMjIxaHRFcTZ5?=
 =?utf-8?B?c0lqQ0hpWmppN2l1M3FUeGxKcjVjVzRtRHI0SWxlczFHbjlUeVZET0tSMGp3?=
 =?utf-8?B?SS8wYmtXSHo5T3dEaVNyd3NWa1A1a0I5REpLWVBSWkRyUldaM0ZoaXRQZzg0?=
 =?utf-8?B?NVVacUpSYmVxQVNKQ21lSU82WFMrSzB1dWF5Qm5CMkF4VjErTC8yMEsrNnBx?=
 =?utf-8?B?TXlGbkw1aElKTFBjOUZVbEhwM3d0K3ZqcmpwQmFHNDd1YTh6MTFLMWJrLzJC?=
 =?utf-8?B?bkowaERnZlpQdkpwOUsrS0RRMzMrdkJXWlYweStWeXVHaU52U1RHV0F5RUxw?=
 =?utf-8?B?MzFXbFBoNzFxeFdNZzVJNWJ5RVJHajhJOGdzbXpPRlVJLzNSVTJWWjA1cW1O?=
 =?utf-8?B?QlJ1VTVkR0czcVZ5T1h1aENFUzd4c0sxNU1ubzR4bS9XNEovYldaVHUzZDBH?=
 =?utf-8?B?VEk5MkIvb1hJTUN3eGQ1TGYrZmtWU1RsWitra3BVMVAzQmRHZTh5L3dlTWgz?=
 =?utf-8?B?Ni9YT1MwSURubFc5VklBLzVQMUgxTFdLL2RJdFprQzBXU01xQ0U1M3g3cTM0?=
 =?utf-8?Q?CcMqyNQ2la933W26EhMc/fiH9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4785107a-a94d-4b91-267b-08dda53c7db1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:55:38.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB39ss1EXmQrfUkbmoEcje0Jwwd8DaldiUmLQyr8RXjwp5UzA5aPwShwXDyjY8AzzRkUcn4/3/BoGolBMP59JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456



On 6/6/2025 3:30 PM, Dave Jiang wrote:
>
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> __cxl_handle_cor_ras() is missing logic to leave the function early in the
>> case there is no RAS error. Update __cxl_handle_cor_ras() to exit early in
>> the case there is no RAS errors detected after applying the mask.
> This change is small enough that I would just fold it into the patch that introduces this function.
>
> DJ
I agree. The problem is it was already present before this series. This is a 'fix'. I had this change in:
[PATCH v9 09/16] cxl/pci: Log message if RAS registers are unmapped
but was asked to move out because it appeared as an unrelated miscellaneous patch.

Terry
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 0f4c07fd64a5..f5f87c2c3fd5 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -677,10 +677,11 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> -		trace_cxl_aer_correctable_error(dev, serial, status);
>> -	}
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	trace_cxl_aer_correctable_error(dev, serial, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)


