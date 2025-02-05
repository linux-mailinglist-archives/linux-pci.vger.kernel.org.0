Return-Path: <linux-pci+bounces-20741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258BA28F46
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55A41882C56
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D401553AB;
	Wed,  5 Feb 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iN9PkP+Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3731459F6;
	Wed,  5 Feb 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765370; cv=fail; b=PB3t936Q4Tx2RCZug+XqgsnpT/4hLXuXnnTkQ4RiR8bE7iVsK/nrBIbtIROvBY1ej9gTvyOfnm+IC3Xc+oiJqG0pjr6rRVzmOkMsptN5gERKTPG2uHCuOnSqhvq9pa0j8wo4NopZ+6sHMoUS2Pamg9cEjpmKWFKrPRPxmGQnac4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765370; c=relaxed/simple;
	bh=Xs1wLtGOUR2TXYPTXMyNNB+os9+LRxSMEspZhvfqdhY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0r2w4ioWjp2m1dX43ldEh/x1BD3Z9eQV+qHt8+o3W/lK2BxywvloNLOkzM49dbl8Wli+X3AYBzS2SDcQLvFWde/yUxvAm/J9b2nofcoNZL7aco4tt8YJCtapFaXSMq+Pyzz7BIVS5gM3fFJRDhnciZA03cJpp5WDFnXAizW8g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iN9PkP+Y; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxU3PaZelmU0WLubbqBzpUSSL7Z8FR7vIA/PqBMmXMd02b6ymk6sL/kYox5s4enIHN7NAyQgQanlTlo4ILoty0ySAfYmIGkvd6wkOtqOnK1SCK3CVhlmOtY9EZ8svThtwMoYEnBUB13TwP4xe0U5/FtSQPB2Xrw7WWVbkiUhif1klvLRvUx+Wq3oOMZjBkC2KeaKTVn2pTX8CMqLn4kYQ6WT8V982dEDPEH98pOhCrk6X274xthP+CDmLvbhlYiMEjY8VW7jwNArvB/9yOLFatvDPBPqrpLOaxlc1Do0/tOSUbDB+ou0ZXj7v7Yjoh8GcI6Zz6NYti3RBin1RxaMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3KBZJVv8jaQY8OzGgfFEflUi1t74XBduWY9GW+yCl8=;
 b=bAE89OZgYOIsxbLMqqipZzd64LbQtas7P9KD2dtx87DFXcT91mcJRO/uj19YFhbUzq+5TjT0ickI6n0xBe3u47ma/wzkChj33tK8jz6MWXL6BgV/cZ43bQfar/7JKWvTKpGZkmsw0IPYVMsl5WXXYc4Sgu5QlnwSUh+2W86cwiIqjfgxi3TRaSa8Ck9OScAyNSqYd0B0cz5R2csZ9vLjC9VdWS6tSHpIeNsmb6vNY3qjDiokiagzDmLZl90zwgCNOt+JFaF74BFi344ejYP3QLIdBa/yUCGzVDOVQUt9R2X6Sgr7jFFwgIC0RVUFzpcXudXqbERbZyZ1kPJSjYknNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3KBZJVv8jaQY8OzGgfFEflUi1t74XBduWY9GW+yCl8=;
 b=iN9PkP+YOCHflLuQv5of5wHWIxmu8hYOOAxKS6nQ+SjC/otXWaz3asoTlsqmVOt2UDOeY++2nCtY/jFD0HopxB4VC23Z0a5PoZR7McjjDguxEj9hsYLGvwsa5C3KTd4uPZV/LXAD6w1L8EL7RTeiE7ICuZfEumCrEip1gkA83Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 14:22:44 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 14:22:44 +0000
Message-ID: <9ac12446-816c-4f99-b4de-24d51d457185@amd.com>
Date: Wed, 5 Feb 2025 08:22:40 -0600
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
 <5ad954c8-2254-4f45-8018-7fa345597ee2@amd.com>
 <a8950b91-3485-4dd5-9d84-7d3a3031b752@zohomail.com>
 <2b9a8693-2218-4109-b20f-8a57618d9006@amd.com>
 <77f23d53-5bbb-451d-b1c5-272e016b77f4@zohomail.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <77f23d53-5bbb-451d-b1c5-272e016b77f4@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0110.namprd05.prod.outlook.com
 (2603:10b6:803:42::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc025cf-2b0c-4990-8c1e-08dd45f08e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWl5T2xrTVZ6aWtqV3VIUTJRZlRpT0xVaHk3V2k0blNRdDhEVDk2VFFpNTNt?=
 =?utf-8?B?WG5pVzFDKzdHZGpFTUE4NnUwZGd4ZE84U2RJcFBqYTJJbUVMb3ZHMklEbkpY?=
 =?utf-8?B?M0xSM2w0dHUwYS85UWpjVlZvQ1RGMSt5WVJwdVZTV0pMUURrNTY3QWdxRzFt?=
 =?utf-8?B?MFNiTXFXRUdWSXM3STVRckYxMHlYdmQyUE5DVTNaUUZTeFJvV2JHb05DTVVH?=
 =?utf-8?B?MWptbHVLMndNY0tvZkdteHp2WDEzNVBBNWcxR3o3ZlpEV3VmeEg2NUM5NFBW?=
 =?utf-8?B?VHoxWThMbWxqTUZaRVNKcXk4Z2x6elg2M2Ria1VZdmlUYzhxQWhaemhUcDM1?=
 =?utf-8?B?bjZTV2xmYzdNazhiRlhQOEZWcW4vNlNnR2VkWUhaT2tzS1lNRXluWHN3aDVr?=
 =?utf-8?B?VFoyNy9JL3JtSUFodlZPVWVxN2Q2WS9OZ1pTS1JiY3hjU2huZkdIclpweUM4?=
 =?utf-8?B?dUlKNy9NT2wyYjBVMGdTOFBqSVUxL2h6OUM5QWpHd2FpMmc4OExieFh3ZGZU?=
 =?utf-8?B?QmxwUlVRWDY1dTRpVkc5eGFNc0JjeTZ5MzVlTWo4NjdwY25UOC9sVHBWTzAw?=
 =?utf-8?B?RUFwL3lJZ2k1b21aYURxeHpMeE10QjE1ck5RTDF5Vk90VlVYRk9hdlhYb3dy?=
 =?utf-8?B?UUVaODhPY2ZGeldxaFhVR0M4czdINWg2S1pZL3JLdHpVWkk3UGdqZWNTczRq?=
 =?utf-8?B?SzFybVJOTDZMdUpJaG80YnBrQmFBbkVETm1UN3d2aDJWV3RKQWRkb1VuRDh4?=
 =?utf-8?B?bXFEd0ZNNGlldGtJK3MvNWFNaFpyL0Q0L1dUR2xSYWhnd1VoNWRkWG40dzhQ?=
 =?utf-8?B?aktmQWlPaDVCT1ZtZVFPMENMQ2I1cjRwMlk2SGhRUzlWVHJna3pLeWhDTis4?=
 =?utf-8?B?bnVUdWcxREpnUndVcW5JR3J3RGtZbUM4UXVKUHFvY040ZHF0TjlOQzdiMC96?=
 =?utf-8?B?SlBpSFFCY3RwU3l1aHJ6akEwMmFaNzZGWkNWUE9jcjY1QkVMUFNUN0NjblA3?=
 =?utf-8?B?bHFNQXlUZVpoQXlhL1FmeHhwYUhwVm5XV3pJNXpPUnRuSjFMSCtjSmRFWjk5?=
 =?utf-8?B?Z29McURMSm5ldHdoZUthUGZWMlhDTHZVOWpvMVJpR05EVlhmK1VBVVFGRW5B?=
 =?utf-8?B?VjlQTmNPVXdjbDM3QmpVMGVQVXBiRkNHTElCQ0J6YnB5WmpsbzFvK1BEUTF1?=
 =?utf-8?B?RWxGUWh1UjVQMFRZVzFTQnNGTFAxdUFWWXRWZFhmdWJPcW9vemJHZmVCYjMx?=
 =?utf-8?B?V2lvVXBrbkdhMUJKWjRYS3hWYmg2bkpGY3hOSW5jUEV4SmVQUlg5ZVRNN3pY?=
 =?utf-8?B?Q3B0bVVuR1MxT1o4OFQxRHpoczJENTlCVUhrVTJjV2RwTVdObE55UWsrN1I4?=
 =?utf-8?B?aEh5M3ZIWHFrTU5VRFErN2MwTWJHQ2lrL3grMEwyYUlybUNvUG0rTEhUOWt2?=
 =?utf-8?B?L0NTQ1Z5Z3Z5RGYzektBTjdJemJYWml4KzNFMEZvZjc2YitrZXRyblorOXJt?=
 =?utf-8?B?cVRnRmJCcWhiaCtqeEJpZzlXNmtoclNxcTRvVk4yYVNLU2tjWkZHejFqU1c5?=
 =?utf-8?B?MzBRdFpNM2FzbGo2YWNXaElCNjM1bk1uZi9WOGJYa2k4Q0JycVd2R3RyOTkx?=
 =?utf-8?B?Uk9hL0ZXZjhmU0dmY3pXKzJhaVh6cURQYVo4clV6L0tjSC81RmZDR281ZjVH?=
 =?utf-8?B?R1dpSGJYaHBkZHFzS1dqcFB0aVZtWTR3Y3hZKytKWmJEd1Jib3F0WjhVa2Z2?=
 =?utf-8?B?dXpyVVpvNUk1cjdQZ1RMVlRXNGpBUHZ2dkZIeVk0eW8xVEU1TFhIbEJsOG1V?=
 =?utf-8?B?QnMrOGxmbDhTWFVSWFdiQ0xSU1NqdFhxdUpMMFkxZVNRTDM1UHJqWU1LVDlG?=
 =?utf-8?B?VFk1ZEZVLzVHTy9VeDRaQVZveWhzM3RzY29iMmlDMG1mYXI0Y253MDk0aTMv?=
 =?utf-8?Q?vDhhKZBXoko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGdOYndPWERaVHN5cXhtZ1h5aklPUVVzN3FCNHpxSldKaFp3SzNHamJVc0d5?=
 =?utf-8?B?V0MwdGU0aWFrY0tsUTMvYjNKVUZtbDU0VXA3eU9jek9uSGZSWWkydm1sMGQr?=
 =?utf-8?B?azVqRndpL0txT0dLemhmbkpnL3RwS2xmdDdSS1RrSjhZZllueUV4VkozYmhT?=
 =?utf-8?B?aGsxMWh4MVp4S24wcUJXSldhK3VGVUl6VUxGTUlKWlo5d0RuTDk0eExKdTR3?=
 =?utf-8?B?bTUvR2JkVktzclRhREIrYVZBWnlvUFY5NXlXUmZSa1pRak0yQk1IUDZTMmhR?=
 =?utf-8?B?VmtBd3JScURXa1Zab0hsV0MxWVM4b1RITnZIMWN5WEhWVEFmTTgrUGVReGlH?=
 =?utf-8?B?dC9mZW9CZTIyQ1M3UGRKbjA3RUdYVVU2d2lCdTJlREJGQXBTeGNUOEt6Z0c2?=
 =?utf-8?B?RiswalI3UEpjOGRGNFpSamhubGhIalhhcTA4ZFJRMCtCRDJ6VGhLWUFuRHhK?=
 =?utf-8?B?SGVRMHBzRm5JLzdoR0xEakNKeXhaTHlMMmhlYjUzSldIZnRKS294NzZhaWVT?=
 =?utf-8?B?MEVZZFM3N3FsSlJBSVg4N3Zwekx4cGZlUDIwYkJKbk10d1IwbjRPRlA0ZFlO?=
 =?utf-8?B?REVtUmljZnQ4OFFVRldnQlJDU3BhdzN6bnZNS3ZPTjFUUHJTMk9LRjA4N2t2?=
 =?utf-8?B?RkZMd0pRd3VnTXRmNENUUkkzVHUzenFhR243Nm9VRFczL1FpaUwxNDNQTWR3?=
 =?utf-8?B?ZXAycDlkWFlyNVhxN1JWMUY5NFYzcEc2cjBmMnRpQWJBT21GSjZXRDR6WUsw?=
 =?utf-8?B?amNMR3cvOFFhdnBYV1l5cG8rZXRIZ1JENVR3cW9OTDZSU2NLc3FkUDdPei9C?=
 =?utf-8?B?K3U2dExuSDV4Q2lVWFNSYi8vcFJZU3RKbUFleEFmU21rVnNFVUVTYTdWK1pW?=
 =?utf-8?B?bHdLR1B0WXRNUmpRUXRZOVlSamFyTjUwYlo5SkNuUWs4V1p2MEhpQVZocFNL?=
 =?utf-8?B?QmxGa2tmT1R2MFlSVktWaXFkUEdGTWxDMUJwTlAwTXhmUCttVk54SndWeGtB?=
 =?utf-8?B?KzF2b0tvdTVaaDYzeGcyV1F3elptTllTWXpFY2t2eHdERXRkQnFoQjdNMHZW?=
 =?utf-8?B?RkV4dnRNTDVkR1VIV2ZONzFHYUhYRG9vN0NmU1Zka05lYW1zeXlEaUJ6TGIx?=
 =?utf-8?B?aHJsNW1RWEw0WUtxOGROdWlPelRaZkFWZFJaYkJOcitiUXlGUlYwTVRuaXdt?=
 =?utf-8?B?UVVuZTVKNC8vMG1QbkVMc3pxazRKUkFxSU5pWXloYjhNbUFGWG5Ndk5DMFdU?=
 =?utf-8?B?NGZydEIrb0xCWW1wNEE0SmswT0pOZDF2Y2pPNVJXcFUzZFVQRXk1cm5pZHFW?=
 =?utf-8?B?ZDJXam5HSTB6YjJIVnY3Snh4bUd2REZldnZnZjZLcDE4ZGtHRGtUMis1RVdy?=
 =?utf-8?B?MThkYzNQWGdlZ0NWd25vVWRabG5pUWxiY2pONFd6NlR1a3FRcXc2ZXRNUXd4?=
 =?utf-8?B?ME5aa3FUOFBDVnJaNnpmalFKNU1OYlBqNmxzaG1tem96Vjdrb1c4U0VIYk40?=
 =?utf-8?B?NmVURk96WVJxd210UFIvYVFOVVVCOW5Oc2FYQk5NSENVL2Nrekd6TVI0cnBM?=
 =?utf-8?B?enBHN09kVzl0UUlXNEc1MkprV0dPS0EzWDVqSEZhbytScGpYZEl5ZUpzVlZO?=
 =?utf-8?B?a0U4UjliUkRvYmxpYTRRVnBpNkwvdnRLRW4vMHp3c25RcW1Nd3VsSVoxcjlM?=
 =?utf-8?B?R3doZ1pFQzJXUFRqQUpxZ0VwTlU3M0I1SnNGQ0ZUdHV3YkJEM0FtMldJSjA2?=
 =?utf-8?B?bVdjZUkwMHZZS3l6T0Rqbks2aWZGWDcxb1VuKzUyL1pnMzJkeE1henVaK2pB?=
 =?utf-8?B?MEViYmJpT1hZZ0R1ZThuMktpS05zL1lRemdwSGZ0MDUwRFZoOGR2djZ2eHd4?=
 =?utf-8?B?NGwxZ3h0dmJZUFp5WXpaNTJ3Y2VEQkdMQ0x4ckcxU0NlTmxjSDVvYk9UMXNQ?=
 =?utf-8?B?WEZLRXdtRHlBb1pBUXdTNWpoc2dpa3BaUjRZRGw5dXdTUE1xa1FZNW9Lb3JB?=
 =?utf-8?B?cnBrY3VWWS81NE1DbUx3VUJiK0pOYjk3bG9YT1Y4WlF2aExqWFVLTTRheVUv?=
 =?utf-8?B?SktzZndMV1FvQUxYUmkzdVZiS0FKTEwwL1NPcEpza0ozZFRzSXdETGRtN056?=
 =?utf-8?Q?LGAMZxwfaC+dCwOjBrSCTUSd9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc025cf-2b0c-4990-8c1e-08dd45f08e2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 14:22:43.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zF3Twr+QNbaCqu7ny2vtEJKsr9e9PNCO2gExlmq7z6BItjvKtFhj2dDWL2SNUC4qHPBUWKalTutbl7FMajzaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627



On 2/5/2025 7:58 AM, Li Ming wrote:
> On 2/5/2025 11:46 AM, Bowman, Terry wrote:
>> On 1/15/2025 9:15 PM, Li Ming wrote:
>>> On 1/15/2025 10:39 PM, Bowman, Terry wrote:
>>>> On 1/14/2025 7:18 PM, Li Ming wrote:
>>>>> On 1/15/2025 3:29 AM, Bowman, Terry wrote:
>>>>>> On 1/14/2025 12:54 AM, Li Ming wrote:
>>>>>>> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>>>>>>>> The AER service driver supports handling Downstream Port Protocol Errors in
>>>>>>>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>>>>>>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>>>>>>>> mode.[1]
>>>>>>>>
>>>>>>>> CXL and PCIe Protocol Error handling have different requirements that
>>>>>>>> necessitate a separate handling path. The AER service driver may try to
>>>>>>>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>>>>>>>> suitable for CXL PCIe Port devices because of potential for system memory
>>>>>>>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>>>>>>>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>>>>>>>> Error handling does not panic the kernel in response to a UCE.
>>>>>>>>
>>>>>>>> Introduce a separate path for CXL Protocol Error handling in the AER
>>>>>>>> service driver. This will allow CXL Protocol Errors to use CXL specific
>>>>>>>> handling instead of PCIe handling. Add the CXL specific changes without
>>>>>>>> affecting or adding functionality in the PCIe handling.
>>>>>>>>
>>>>>>>> Make this update alongside the existing Downstream Port RCH error handling
>>>>>>>> logic, extending support to CXL PCIe Ports in VH mode.
>>>>>>>>
>>>>>>>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>>>>>>>> config. Update is_internal_error()'s function declaration such that it is
>>>>>>>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>>>>>>>> or disabled.
>>>>>>>>
>>>>>>>> The uncorrectable error (UCE) handling will be added in a future patch.
>>>>>>>>
>>>>>>>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>>>>>>> Upstream Switch Ports
>>>>>>>>
>>>>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>>>>> ---
>>>>>>>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>>>>>>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>>>>> index f8b3350fcbb4..62be599e3bee 100644
>>>>>>>> --- a/drivers/pci/pcie/aer.c
>>>>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>>>>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>>>>>>>  	return true;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> -#ifdef CONFIG_PCIEAER_CXL
>>>>>>>> +static bool is_internal_error(struct aer_err_info *info)
>>>>>>>> +{
>>>>>>>> +	if (info->severity == AER_CORRECTABLE)
>>>>>>>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>>>>>>>  
>>>>>>>> +	return info->status & PCI_ERR_UNC_INTN;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_PCIEAER_CXL
>>>>>>>>  /**
>>>>>>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>>>>>>   * @dev: pointer to the pcie_dev data structure
>>>>>>>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>>>>>  	return (pcie_ports_native || host->native_aer);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> -static bool is_internal_error(struct aer_err_info *info)
>>>>>>>> -{
>>>>>>>> -	if (info->severity == AER_CORRECTABLE)
>>>>>>>> -		return info->status & PCI_ERR_COR_INTERNAL;
>>>>>>>> -
>>>>>>>> -	return info->status & PCI_ERR_UNC_INTN;
>>>>>>>> -}
>>>>>>>> -
>>>>>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>>>>  {
>>>>>>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>>>>>>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>>>>  
>>>>>>>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>>>  {
>>>>>>>> -	/*
>>>>>>>> -	 * Internal errors of an RCEC indicate an AER error in an
>>>>>>>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>>>>>>>> -	 * device driver.
>>>>>>>> -	 */
>>>>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>>>>> -	    is_internal_error(info))
>>>>>>>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>>>>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>>>>> +
>>>>>>>> +	if (info->severity == AER_CORRECTABLE) {
>>>>>>>> +		struct pci_driver *pdrv = dev->driver;
>>>>>>>> +		int aer = dev->aer_cap;
>>>>>>>> +
>>>>>>>> +		if (aer)
>>>>>>>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>>>>>>> +					       info->status);
>>>>>>>> +
>>>>>>>> +		if (pdrv && pdrv->cxl_err_handler &&
>>>>>>>> +		    pdrv->cxl_err_handler->cor_error_detected)
>>>>>>>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>>>>>>>
>>>>>>>> +		pcie_clear_device_status(dev);
>>>>>>>> +	}
>>>>>>>>  }
>>>>>>>>  
>>>>>>>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>>>>>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>>>>>>>  {
>>>>>>>>  	bool handles_cxl = false;
>>>>>>>>  
>>>>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>>>>> -	    pcie_aer_is_native(dev))
>>>>>>>> +	if (!pcie_aer_is_native(dev))
>>>>>>>> +		return false;
>>>>>>>> +
>>>>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>>>>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>>>>>>> +	else
>>>>>>>> +		handles_cxl = pcie_is_cxl_port(dev);
>>>>>>> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>>>>>>>
>>>>>>> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>>>>>>>
>>>>>>>
>>>>>>> Ming
>>>>>> Hi Ming and Jonathan,
>>>>>>
>>>>>> RCH AER & RCH RAS are currently logged by the CXL driver's RCH handlers.
>>>>>>
>>>>>> If the recommended change is made then RCH RAS will not be logged and the
>>>>>> user would miss CXL details about the alternate protocol training failure.
>>>>>> Also, AER is not CXL required and as a result in some cases you would only
>>>>>> have the RCEC forwarded UIE/CIE message logged by the AER driver without
>>>>>> any other logging.
>>>>>>
>>>>>> Is there value in *not* logging CXL RAS for errors on an untrained RCH
>>>>>> link? Isn't it more informative to log PCIe AER and CXL RAS in this case?
>>>>>>
>>>>>> Regards,
>>>>>> Terry
>>>>> Hi Terry,
>>>>>
>>>>>
>>>>> I don't understand why the recommended change will influence RCH RAS handling, would you mind giving more details?
>>>>>
>>>>> My understanding is that above 'pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)' is used for RCH case.
>>>>>
>>>>> And the 'else' block is used for VH case, so just check if the cxl port is working on CXL mode in pcie_is_cxl_port() or adding an extra function to check it in the 'else' block. I think it will not change RCH AER & RAS handling, is it right? or do I miss other details?
>>>>>
>>>>>
>>>>> Ming
>>>> Hi Ming,
>>>>
>>>> You're recommending this example case is handled by pci_aer_handle_error() rather than cxl_handle_error(). Correct me if I misunderstood. And, I believe this should continue to be handled by cxl_handle_error(). There are 2 issues with the recommended approach that deserve to be mentioned.
>>> I guess that what you thought is the recommended change using pci_aer_handle_error() to handle CXL RAS issues? If yes, it is not what I meant.
>>>
>>> handles_cxl_errors() is used to distinguish if the errors is a CXL error or a PCIe error. if the returned value of handles_cxl_errors() is 'true', that means the error is a CXL error. Then invoking either cxl_handle_error() or pcie_aer_handle_error() depending on the returned value. I think no problem in this part.
>>>
>>> handles_cxl_errors() is using pcie_is_cxl_port() to distinguish CXL errors for VH cases. the implementation of pcie_is_cxl_port() is only checking if there is a DVSEC ID 3 exposed on the CXL RP/DSP/USP. I think it is not enough.
>>>
>>> For example, If a CXL device connected to a CXL RP, there is no problem, because the return value of handles_cxl_errors() will be 'true' then cxl_handle_error() will be invoked to handle the errors.
>>>
>>> If a PCIe device connected to a CXL RP, the CXL RP is working on PCIe mode, the CXL RP is possible to expose a DVSEC ID 3[1]. If the CXL RP has a DVSEC ID 3 in the case, the return value of handles_cxl_errors() is also 'true' and also invoking cxl_handle_error() to handle the error, I thinks it is not right, the CXL RP is working on PCIe mode, the error should be a PCIe error, and it should be handled by pcie_aer_handle_error(). So my suggestion is about checking if the CXL RP/DSP/USP is working on CXL mode in pcie_is_cxl_port() for VH cases.
>>>
>>>
>>> [1] CXL r3.1 - 9.12.3 Enumerating CXL RPs and DSPs
>>>
>>>    "CXL root port or DSP connected to a PCIe device/switch may or may not expose theCXL DVSEC ID 3 and the CXL DVSEC ID 7 capability structures."
>>>
>> Hi Ming,
>>
>> I apologize for the delayed response. Thanks for the patience in explaining.
>>
>> In your example using a RP with downstream non-CXL device, the RP AER will log the
>> RP's CE/UCE and RAS status for a protocol error. It's not helpful in this case
>> because it's a non-CXL device but it is failing alternate prootcol training that can
>> also happen with a CXL endpoint. I expect the RAS registers contain details about
>> the failed CXL training in the endpoint case.
>>
>> I believe we should give the user as much error details within reason. And for CXL using
>> AER CE/UCE errors, this should include the RAS logging. If we rely on the PCIe handling path,
>> this information will not be logged.
>>
>> Also, CE/UCE AER is logged in the CXL handling path. The AER driver logs AER status before
>> calling the CE/UCE CXL handlers.
>>
>> Are there any other use cases or reasons why to use PCIe handling if alt. protocol training
>> fails? Is there anything lost by using CXL handling?
> One problem I realized is if using cxl_handle_error() instead of pci_aer_handle_error() for the above case I described(a CXL RP is working on PCIe mode because it connected to a PCIe device), the CXL RP will miss pcie_do_recovery() invoked in pci_aer_handle_error() when the error is an UCE, and it will also miss pcie error handler implemented in pcie port driver. 
>
> It means that AER handling logic is different between CXL RP working on PCIe mode and PCIe RP. I am not sure whether it is OK.
>
>
> Although cxl_handle_error() includes cxl_do_recovery() implemented in patch #7, cxl_do_recovery() seems like only for CXL cases(CXL RP working on CXL mode), is it suitable for pcie port recovery(CXL RP working on PCIe mode)?
>
> Please correct me if I am wrong.
>
>
> Ming

Hi Ming,

Yes, the plan is to handle CXL protocol errors in a separate CXL path than PCIe protocol errors.

You stated this is a problem. Can you elaborate on the issue ?

Regards,
Terry

>> Terry
>>>> First, the RCH Downstream Port (DP) is implemented as an RCRB and does not have a
>>>> SBDF.[1] The RCH AER error is reported with the RCEC SBDF in the AER SRC_ID register.[2] The
>>>> RCEC is used to find the RCH's handlers using a CXL unique procedure (see cxl_handle_error()).
>>>>
>>>> The logic in pci_aer_handle_error() operates on a 'struct pci_dev' type and pci_aer_handle_error() is not plumbed to support searching for the RCH handlers.
>>>>
>>>> Using pci_aer_handle_error would require significant changes to support a CXL RCH
>>>> in addition to a PCIe device. These changes are already in cxl_handle_error().
>>>>  
>>>> Another issue to note is the CXL RAS information will (should) not be logged with this
>>>> recommended change. pci_aer_handle_error is PCIe specific and is not aware of CXL RAS. As a result,pci_aer_handle_error() is not suited to log the CXL RAS.
>>>>
>>>> The example scenario was the RCH DP failed training. The user needs to know why training
>>>> failed and these details are stored in the CXL RAS registers. Again, CXL RAS needs to be logged
>>>> as well but CXL specific awareness shouldn't be added to pci_aer_handle_error().
>>> For these two issues, handles_cxl_errors() is always using "pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)" for RCH cases. I believe no change on this part, the return value of handles_cxl_errors() will be 'true' as expected in the cases you mentioned, cxl_handle_error() will help to handle these errors.
>>>
>>>
>>> Ming
>>>
>>>> Terry
>>>>
>>>> [1] CXL r3.1 - 8.2 Memory Mapped Registers
>>>> [2] CXL r3.1 - 12.2.1.1 RCH Downstream Port-detected Errors+
>>>>>>>>  
>>>>>>>>  	return handles_cxl;
>>>>>>>>  }
>>>>>>>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>>>>>>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>>>>>>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>>>>>>>  				    struct aer_err_info *info) { }
>>>>>>>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>>>>>>> +{
>>>>>>>> +	return false;
>>>>>>>> +}
>>>>>>>>  #endif
>>>>>>>>  
>>>>>>>>  /**
>>>>>>>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>>>  
>>>>>>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>>>  {
>>>>>>>> -	cxl_handle_error(dev, info);
>>>>>>>> -	pci_aer_handle_error(dev, info);
>>>>>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>>>>>> +		cxl_handle_error(dev, info);
>>>>>>>> +	else
>>>>>>>> +		pci_aer_handle_error(dev, info);
>>>>>>>> +
>>>>>>>>  	pci_dev_put(dev);
>>>>>>>>  }
>>>>>>>>  
>


