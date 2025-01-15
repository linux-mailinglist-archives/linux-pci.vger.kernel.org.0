Return-Path: <linux-pci+bounces-19901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14BA1262D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B083A1DD1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B381727;
	Wed, 15 Jan 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c3nRdSji"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18F78F46;
	Wed, 15 Jan 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951975; cv=fail; b=DTpVdt0x2apX5Gz6JUKCFg1HVo6Bfx4ujqKrJ1w8fREYxt18J7JcSpzcxHEyysp7BoXSNDL2qsFOcMsDiuGKShNl8xVegXM8cDwyU11EvjF94PL1GhOPg15czPBRAne9nflRaZvC833/lQvWentQdyQO85KV5O1wFmSLRvfgLOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951975; c=relaxed/simple;
	bh=m9qYIkjZ7gdn9IMvaQ+aTa8HNePNDOjQAoUXlBPzQCQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XTcNzYyGJLz1QxNTOtv88/wwOsNgqJdT5OChvNyOgA9oEo060SmfETefYzJkLpdYeGuSCpAEmFJEcKsaO/EaVvmnTv3Gn7iqAtbhjZv9nYvbxfN8fzJXK6RSc9GiJAjBSQkYTht8wDxVR3myN2HI4/jEs+vSxuXqiGiC24Ks3pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c3nRdSji; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAt0M7TqUerw6Xepd6J5rVK/dunPKEfF46ry/v8/RQ0kjYRlx5giXv9AoOC8ZV9vik6RIRhFZxdhHfBq6mfW/fiJbRruVmkLr0xBoPAmAORdM5PNM03EtQaJQjuYK5KKdHRTaSFaf/2V0Bp4vTfmV4gg0mzMSG03oDHpco/yXxRS5VVfPsoGSURXpC0KZ1KaGla9szRPu9AAKksM+YCq4HftUpkgeD00cQrc0RDPSAjIwAE/ks6XtmDR0Fh/xaJp+tCvLJvQnGju0rdeLGxyBZwn6265pWaOvdr+WCyd1DjuFN+ddrt1TkiItgyIx2hKWRCKpB3BggDebL44SqEKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw7fN/8Pa1znfwyxN53rbi+70z0xI2otasRrG7ED+CM=;
 b=Lzf7IMHIW0YIdkayb+jHNm7MWhlMh9VE1r+HQmdBilvyAb7TIzHucbH39UPY8iJeculiT3sEXX4CBHCVeXkHtixVufZ6BpcM8h3IS7BRvxNvaX5KSji0p7P/pQrnMajpmY8C4zpEzMTHdDf16Xl394Rf33pJd2puKGtnbp3TwvjFx03h/oYlKhisr7+1ri/V6Rc6f/cpiDW6SQhXt12/TANLI3HIR0O2dSjLqXVBC0bI5ywlMQlCKP1eilHOl5AWUq8Wxwn5Rcxvh2Rmcb74U3X4PItdi1S2HrhA4SQMHpVNYD7rgm/D8iDweTltsyNVmw4R+Ip1l6YXqyKEPr1hLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw7fN/8Pa1znfwyxN53rbi+70z0xI2otasRrG7ED+CM=;
 b=c3nRdSjiCs39G/hmRgXZx3Qyy2vM4xuEnnGcq0ZJ+L+j6d1oQKDQTqVSk6+/SmXAAlZVGvjvWPdwor8cCORzVSdv/BR7OawOA84degzhWhFge/kS384XsiVJs+t1Wfw6/foNLIdxfk8TY3FlCNcKQZrP64Y0Vuraj5ZFMQnIZBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:39:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 14:39:27 +0000
Message-ID: <5ad954c8-2254-4f45-8018-7fa345597ee2@amd.com>
Date: Wed, 15 Jan 2025 08:39:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-6-terry.bowman@amd.com>
 <cb087065-f2f3-481c-84cf-aca2c5fd5ac4@zohomail.com>
 <708db61f-2a69-40a0-ab9a-0fdb889ff443@amd.com>
 <c7e6298c-ae12-4e86-a74b-8b3aea698772@zohomail.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <c7e6298c-ae12-4e86-a74b-8b3aea698772@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:6e::10) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: fab422d4-f170-4fe7-15bd-08dd357269b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE42eTZMT1JPSmdXaHBxTXVWOFZ6R1NlMkF0cmR2SjRNaFZlVXc0STFIQzlo?=
 =?utf-8?B?dDYwdVJyaGg3WTVXWkZpZjkyQm5mS0ZkbnRTbGVsRnZtMFVKUEJHUk1VVnNP?=
 =?utf-8?B?VUZjMXNrVkEyNlg5a0FlcFRBQkxIUmNCWng1VkM0N0loVCt6cG1Ga2ROdEFp?=
 =?utf-8?B?TUpRWHZRYklyMWRGWlczMExqL2o1emdWYzV5c1hzQ1IrRHloVTRRMk9BWFBH?=
 =?utf-8?B?RTNPU3B3Q1YyWElTM2pVUWhONXVYU0Y5UWZlQ05uclRJR3pTaHlQU0lUM3E3?=
 =?utf-8?B?NHE1NVVDN1pyLzUrd0RoQjBXeEhUdmFLMzhRUmtGbWlPWWhaV3Urb3pzdmpI?=
 =?utf-8?B?OFBENitjRGtpcjFNMjdKVW5SbFdnYnV1VXh3VkhSNE5PU0RWYWVSMlBVZGwr?=
 =?utf-8?B?R2xUYjg4ZDZMbnFNam4rYTVuaVJOdUxabE1pbTBHTVd4N0laR2lQQ1U2Rlc3?=
 =?utf-8?B?endrK1pZVU1aYldqN2YwVkRrbm9Pb21TbFFkUUROUHpQSHFiVjA1L3MzWDRX?=
 =?utf-8?B?amlGeVBQNThwUjd5dHE3a1JJU001eURMbjZaUXZUcnFsdzJVdkRseFFyU0or?=
 =?utf-8?B?SGJmMm1SUWJ2U3NuN3cwQW1ZWCtibjhjSlhFSlBxVkkvdG4rU0IwM1o2ZUU2?=
 =?utf-8?B?UGNSZkNOY3pMVEM3QlBSNmFHOEJQbnZqRlE5blJ3ZDJ6UEh0aW9OZ1FRdytx?=
 =?utf-8?B?VjBYdmt6aXZRRWx6akYvTU9WNVNXVkJpbTNvQ2lSQysrRjQrTFVpUWdJM0x3?=
 =?utf-8?B?Z0NFaFp4N1FwamNUb3IwWEVuTVVPejV2TUxuYmU3VWJqRTZ2Q3VMM1lCNklK?=
 =?utf-8?B?ZmhTSGtNK1dhZ3Jka295STM3UktCUVFaTVhaeE11WHMyaS84TUhGY3hBR1RB?=
 =?utf-8?B?QXVRVms4Y1k0YVN1OXcxbjl3NURZTFVWTlBVRkRuTFNHK0N6T3Jna29yRDJr?=
 =?utf-8?B?WC92VlNBZnI1eFVRbU5XL2xRb05maExTSEt6QmxXK0NqbzJHbmJVWnhFcFRk?=
 =?utf-8?B?NjBlYytaNVkxWEFBRkszOXZlTmQwSm5ldjJZOFZvT0JPbU5xbFNuYkVYWWdl?=
 =?utf-8?B?a2RjbEwvVDVjaGM2UjVLN3ZXMlBFY205Qm16cGtkZjFIQ2R2Q2hQNnkzZjlo?=
 =?utf-8?B?bVozNVduZnBpWEF0ZGR5T2FoRzZzZEJoUDlCM1BuaHlnL0JoRDU5UTNNNTdM?=
 =?utf-8?B?cGxORW15NTU0ckVRUDZNZ3FlRUZTNGd5RmczOUtwTjJRaU1yZjNjdDdaUFZK?=
 =?utf-8?B?RkZ0QmNPb3ZhUGVXZm9YakJ2Z05GUW81UmNsY1JhUmFkd0pRK3JaUWRPMTVB?=
 =?utf-8?B?SFJIUVN6c0ZwOXBtNnNVTzRrcytWcUZSaWlQRnlUTXJvODgxeEJGbU91Y2ZQ?=
 =?utf-8?B?KzQycDA1QzR3bFJweHplYmZWOUtsRnVCYmovMTZNeFpweGRsUk5QNlJONFNZ?=
 =?utf-8?B?MDlQeElwNEVicHNxbTA2alR4WDQ5RGxPZCtBTXBCcGwwSzlnV1dtUno0MkJn?=
 =?utf-8?B?ay9Qd0NraFh1UTZ2Yis1Mm5tQ1VvQmUrMjlkSXRjb1NTR2svR3N4ZjlXRGNx?=
 =?utf-8?B?OEE4eGdWcCswUURVR1A0YXJaR2RTbVF4NUl4WHIzbGtIMXlGeFV6aS9LY1Yv?=
 =?utf-8?B?SWZ6TWZ6RGRsaDVvNTAwWHFsbVZZUXhPRUhORk9JeHEwUjczWWE2dlpRcHNG?=
 =?utf-8?B?UEFOQmNTenU0WXV2QzBzV3prNlhpVm5FZDBtRVVLN21DNFpWMTY4Y1Btd2NW?=
 =?utf-8?B?RkdSb3ZqRjlFR3FKd2NDV3VuQ3p5SFdqZlBhWVI3Wk9EYmJGakxjSXBJSVpY?=
 =?utf-8?B?WGhLNGxneHdYSXExdG41NGQySFNrY0owcThpYjBOYUNyaGhYZ0s2SzBuQTNI?=
 =?utf-8?B?OEdhYWhaUFUvTzVQdUZNRUo3QnM0eHhzZWdGTWd5cm1aYm5HdjVXUkkwNlhl?=
 =?utf-8?Q?aaS6cRcCnrk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3BaRXlJNmVBYWpQSmZoWEExS3QzQTVmVzdtWlludU5jV241NXdiOTlEZFl6?=
 =?utf-8?B?TlJPRkV4Qi9ZN056blAwUDlacmQrZVRhTVUzN3dwNHl3ck05aTRmSm5kWEhJ?=
 =?utf-8?B?VGsrbC90TWZhclpGVW9tRmFWUVN2b0xqeEJIN2NPUmc0RkpRRzNMUW9NTjk3?=
 =?utf-8?B?dFZ2OWkwVmI0NUlqZjJzK0dlMFBTdUlGSEVtRkJJMEtrbUxieiszeVJraXJa?=
 =?utf-8?B?Q1ZRT25BTGxyV3BpemIyM1BmbTZ1UmsyY3NLSUNrVnYwQSsvRVYwVlV6Vm9z?=
 =?utf-8?B?RXhTZ1ZoWHFGZTBEWnRZYTFPWFhMNW1KMVVJZWkvN2RoWUM3RzBZL3FWT2ZX?=
 =?utf-8?B?eGZSdTgzd25KdFo4RWxhVElxaEErYldOeWdtbGpWTDQrOFkzdVhNY3hHOHFS?=
 =?utf-8?B?QTBydlpISjNkWm9QaTBkTHRhZGhvUGR5MUxKM0h3K2ZmTUVCRUw5Z09CU2Js?=
 =?utf-8?B?c0J3UlJRcG1zKzYxUE44amVxc2ZYTVdnaDBSTnUycWZzb05ybjlEcXFBUEVC?=
 =?utf-8?B?ZWEvZDQxc0ZHb281YXAvUzhVNFE2QTZ4T21YQUVwdUVVSi9iNTVtVFlHQjFx?=
 =?utf-8?B?UFo2UkhUMFZHTVE1YW9kR2QyYXdsTWt3WnZpcGNKc2FRRWVWcW5KWUQzc20r?=
 =?utf-8?B?eklYdDJYdFh1akQ4aHNrRFFIOUpkSlZzYldGSmNUQno3Q05oMW5Vbi9XWGJG?=
 =?utf-8?B?SUFnVkdaU2RWcU9WZ0lKT0tJWEY4aW1icEV4T29ISGxBZGhGSmtZaVNvd1dp?=
 =?utf-8?B?YTNhd3ZRMGw4UEdDb0JpUWNTNzdEenQ1b2NGc0FjL2Ntc0ttb0hpaC9rd29W?=
 =?utf-8?B?RkxOREt3QTUzOTM2cUt3azRINzVoc1JVdFl5VHhXeUk5VWk4dzlmOFJhcDZs?=
 =?utf-8?B?d1JqT1ZJRUNIYjhxWkZheC92Q0RWeVlGMDJBemhXSG4zK091M0M3UjFYVklQ?=
 =?utf-8?B?ZDRqM2gybitDZFVXcCtjOUpmU2kzemsvUTBEVzluUzd5d05WTGlyU3c3SzBt?=
 =?utf-8?B?Tm03QjVGdmJrQjhHemZBckI2Zjlpc0ZLNXd4TlZ1bW1vUXNRYXZzSXhVNEVC?=
 =?utf-8?B?Sm1qSi9ZNW84WDhBRmllNjhVZmpxdElyR3ZPVjRSOGQyZVcwZmdPTXVoUXZw?=
 =?utf-8?B?WnNDamp0TlZEZUgrc0U0WXRzcEdsYWtuMkc1djNRaTQ1TE9VTDJLa0wyNno2?=
 =?utf-8?B?R2pWNzY1VUVOSnNuV0Z4TUxHNE5yOTIyWkN5cVIxSi9DTFJ1U3J4Y2YxUDNt?=
 =?utf-8?B?WllhZFBheE9jYWNDN3BISTh1OGZPRDNUbEVjTnF1YmJnalNLeXFkR0RzWU1T?=
 =?utf-8?B?dGJxZ2pSVHpoc0NJK2NuNlI5b3FVYS85dXI2ZmJXdDNWelpDYmpleG16c0l1?=
 =?utf-8?B?SUU0ZUwrWTZBeFhXQW44NVowTHQ4bnFBbW0zRnVpRnFiblpNUDNGQWlIb0Js?=
 =?utf-8?B?a2JGSTEwNCtMcWlLallkZzVqOVorMk1hTGxrNXVPZnZVelVHZjBjZ2xVSHRZ?=
 =?utf-8?B?ZWFSM21UQ3pXVVFCUVptTVRsVU1SMm0zNG9hOVVVUDdYQTBKeDhCNjRsRmp5?=
 =?utf-8?B?eEswVEk3d0tMSG44Yjg4SXhWWDN6R2ZQSHR2VUtlb1c3NFdhNDBldHEzOUxt?=
 =?utf-8?B?VjdLb3FnTVlDMDh0bWp5bDJGeS9Dbk5NMENVeW1ZQUpscFJaZWg4L1N0Zk9k?=
 =?utf-8?B?V3dDOHJNbHhUZTNOTHFvcFBISGdyZnIyV1kwRDJISG9QK1JYRmNRc3hmaFlP?=
 =?utf-8?B?a3BmWVZMYXpUZDY5Q1MxOWYyTmp3UmZRbjJMVENUeFFDUDJSVmdlMXZ2TGhI?=
 =?utf-8?B?WkRoU3BtOGhZWWVrYUcvZVREWVhSNFE2bHI0My9RYTRpalhqN0pjc1laOW4y?=
 =?utf-8?B?dTY5d1JrWUtDVUxCNUk0cm5KaWdJMnVRaGZSSGV3MTQ5bFphdy9xaWp0Vk5X?=
 =?utf-8?B?K3N4U0F2VUYvN2FnbndyUnpwblBnZTRyZXpmTjlDRlBHeDBMZ29xdWF0NE9u?=
 =?utf-8?B?QUU5aWQrQ0JHV2JhR0tGN281MXZsVnEwazFDS25RdjlOQVNIWUpmOUZLVTNG?=
 =?utf-8?B?Uk5meEJaSlBpMnNhNi9JVlFQcCtFbGU5VUpUYldFQkZVR29CZHZMelBGRFJC?=
 =?utf-8?Q?rYClFdw4n5LbFIrZl0D/92mHi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab422d4-f170-4fe7-15bd-08dd357269b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:39:27.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdWfy8oOoPF2EIfiDWI8LbdZluAUna/nbOk8JhPQTtxIyioBxhbgoHZlgFvPex+BXGs8neMMYp/2UNzSCENn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785




On 1/14/2025 7:18 PM, Li Ming wrote:
> On 1/15/2025 3:29 AM, Bowman, Terry wrote:
>> On 1/14/2025 12:54 AM, Li Ming wrote:
>>> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>>>> The AER service driver supports handling Downstream Port Protocol Errors in
>>>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>>>> mode.[1]
>>>>
>>>> CXL and PCIe Protocol Error handling have different requirements that
>>>> necessitate a separate handling path. The AER service driver may try to
>>>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>>>> suitable for CXL PCIe Port devices because of potential for system memory
>>>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>>>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>>>> Error handling does not panic the kernel in response to a UCE.
>>>>
>>>> Introduce a separate path for CXL Protocol Error handling in the AER
>>>> service driver. This will allow CXL Protocol Errors to use CXL specific
>>>> handling instead of PCIe handling. Add the CXL specific changes without
>>>> affecting or adding functionality in the PCIe handling.
>>>>
>>>> Make this update alongside the existing Downstream Port RCH error handling
>>>> logic, extending support to CXL PCIe Ports in VH mode.
>>>>
>>>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>>>> config. Update is_internal_error()'s function declaration such that it is
>>>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>>>> or disabled.
>>>>
>>>> The uncorrectable error (UCE) handling will be added in a future patch.
>>>>
>>>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>>> Upstream Switch Ports
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index f8b3350fcbb4..62be599e3bee 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>>>  	return true;
>>>>  }
>>>>  
>>>> -#ifdef CONFIG_PCIEAER_CXL
>>>> +static bool is_internal_error(struct aer_err_info *info)
>>>> +{
>>>> +	if (info->severity == AER_CORRECTABLE)
>>>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>>>  
>>>> +	return info->status & PCI_ERR_UNC_INTN;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_PCIEAER_CXL
>>>>  /**
>>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>>   * @dev: pointer to the pcie_dev data structure
>>>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>  	return (pcie_ports_native || host->native_aer);
>>>>  }
>>>>  
>>>> -static bool is_internal_error(struct aer_err_info *info)
>>>> -{
>>>> -	if (info->severity == AER_CORRECTABLE)
>>>> -		return info->status & PCI_ERR_COR_INTERNAL;
>>>> -
>>>> -	return info->status & PCI_ERR_UNC_INTN;
>>>> -}
>>>> -
>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>  {
>>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>  
>>>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>  {
>>>> -	/*
>>>> -	 * Internal errors of an RCEC indicate an AER error in an
>>>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>>>> -	 * device driver.
>>>> -	 */
>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>> -	    is_internal_error(info))
>>>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>> +
>>>> +	if (info->severity == AER_CORRECTABLE) {
>>>> +		struct pci_driver *pdrv = dev->driver;
>>>> +		int aer = dev->aer_cap;
>>>> +
>>>> +		if (aer)
>>>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>>> +					       info->status);
>>>> +
>>>> +		if (pdrv && pdrv->cxl_err_handler &&
>>>> +		    pdrv->cxl_err_handler->cor_error_detected)
>>>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>>>
>>>> +		pcie_clear_device_status(dev);
>>>> +	}
>>>>  }
>>>>  
>>>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>>>  {
>>>>  	bool handles_cxl = false;
>>>>  
>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>> -	    pcie_aer_is_native(dev))
>>>> +	if (!pcie_aer_is_native(dev))
>>>> +		return false;
>>>> +
>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>>> +	else
>>>> +		handles_cxl = pcie_is_cxl_port(dev);
>>> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>>>
>>> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>>>
>>>
>>> Ming
>> Hi Ming and Jonathan,
>>
>> RCH AER & RCH RAS are currently logged by the CXL driver's RCH handlers.
>>
>> If the recommended change is made then RCH RAS will not be logged and the
>> user would miss CXL details about the alternate protocol training failure.
>> Also, AER is not CXL required and as a result in some cases you would only
>> have the RCEC forwarded UIE/CIE message logged by the AER driver without
>> any other logging.
>>
>> Is there value in *not* logging CXL RAS for errors on an untrained RCH
>> link? Isn't it more informative to log PCIe AER and CXL RAS in this case?
>>
>> Regards,
>> Terry
> Hi Terry,
>
>
> I don't understand why the recommended change will influence RCH RAS handling, would you mind giving more details?
>
> My understanding is that above 'pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)' is used for RCH case.
>
> And the 'else' block is used for VH case, so just check if the cxl port is working on CXL mode in pcie_is_cxl_port() or adding an extra function to check it in the 'else' block. I think it will not change RCH AER & RAS handling, is it right? or do I miss other details?
>
>
> Ming

Hi Ming,

You're recommending this example case is handled by pci_aer_handle_error() rather than cxl_handle_error(). Correct me if I misunderstood. And, I believe this should continue to be handled by cxl_handle_error(). There are 2 issues with the recommended approach that deserve to be mentioned.

First, the RCH Downstream Port (DP) is implemented as an RCRB and does not have a
SBDF.[1] The RCH AER error is reported with the RCEC SBDF in the AER SRC_ID register.[2] The
RCEC is used to find the RCH's handlers using a CXL unique procedure (see cxl_handle_error()).

The logic in pci_aer_handle_error() operates on a 'struct pci_dev' type and pci_aer_handle_error() is not plumbed to support searching for the RCH handlers.

Using pci_aer_handle_error would require significant changes to support a CXL RCH
in addition to a PCIe device. These changes are already in cxl_handle_error().
 
Another issue to note is the CXL RAS information will (should) not be logged with this
recommended change. pci_aer_handle_error is PCIe specific and is not aware of CXL RAS. As a result,pci_aer_handle_error() is not suited to log the CXL RAS.

The example scenario was the RCH DP failed training. The user needs to know why training
failed and these details are stored in the CXL RAS registers. Again, CXL RAS needs to be logged
as well but CXL specific awareness shouldn't be added to pci_aer_handle_error().

Terry

[1] CXL r3.1 - 8.2 Memory Mapped Registers
[2] CXL r3.1 - 12.2.1.1 RCH Downstream Port-detected Errors
>>>>  
>>>>  	return handles_cxl;
>>>>  }
>>>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>>>  				    struct aer_err_info *info) { }
>>>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>>> +{
>>>> +	return false;
>>>> +}
>>>>  #endif
>>>>  
>>>>  /**
>>>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>  
>>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>  {
>>>> -	cxl_handle_error(dev, info);
>>>> -	pci_aer_handle_error(dev, info);
>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>> +		cxl_handle_error(dev, info);
>>>> +	else
>>>> +		pci_aer_handle_error(dev, info);
>>>> +
>>>>  	pci_dev_put(dev);
>>>>  }
>>>>  
>


