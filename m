Return-Path: <linux-pci+bounces-19486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156FA050E1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 03:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910623A876F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 02:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD13178CC8;
	Wed,  8 Jan 2025 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="md7L0cDF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029D15FD13;
	Wed,  8 Jan 2025 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303687; cv=fail; b=CYXfDY4pRTEkc6u5vOegNkFpCioJN0pxiUoWvi62U5LqZk3C5gfCk6DAQ3wCZi8UdjZEqv+k8aoljuFbpEDQKDkwlkRlAlGJnUpoT9hjWz9wZHkczXYaCXWQ82UHfCjPdwBKBcqbdoc0Myba9wgw9I6nfXajLWwiEVzF3CZMnQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303687; c=relaxed/simple;
	bh=FumJl6LUYsXISfa2EE3p0+l8JjzxfD3a5HtHRkKWyZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5E3xTwFvGRHbLy7VOxpwMARHbPkC7F3slTQmZq0cnwEE56cExFro556NgVPjoTQ4GF9Hl3x17lH/ZTOUpJRUEz7DF+Vi80g/xDuauYrxe7IS9jIRE2g6r2WoqAP1UoG57M4bxg1Nseb5+jI2x8WiGKIim65MUT+4bZ9paDeRu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=md7L0cDF; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+0EHqr6/orE7BLsK10ebe5BYnDCow9yBDpL0i7/7o6EzwoZgokT/whnQuWMg2rsYtFobl+vFUYn88c6LvLxf5KXLviito9pHmKql4SuC5ECJtEy27MUJOMYWV6KSGkgBeyFokV/yg3BnIOjSXSVKoJ2v7alndbIy7WvQ2C7sfU6gGGKeiJJaZzaYxSMDwNbK9zPESXtp+PKmY6pG9Cv8i5mn+U0ufrC6luPB2RABFza2RSL+NOpwd7eCrl+C/wsEDorXH9rzMJx45FP6IKP9P3ugMD9V5t3IPzyeyplzpUEUtRvKkvTlZFHx/Y6pNG4ZozMq1ZFEwcoGxiBGjqV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ItqbUrLolHk5dBN/11OyIZ+e3A4zWWL7b/8DTcBBSQ=;
 b=XPhkm901teY7/zbOwi8IyHkdsYkc3bOHyiJyz62oiJLqWVketqJHpnHra30e848MkqadWYrAEgdGqeLxvJNWie12b5DeYwwbyuQoHRWRTUdT6cqOo2LBYX+65R9MJj2Yiq8hAobn9QlRnPIJ1MwApbY23Sg+c8GasgkQ8RRvtUorlYdJ1dWAifmPLL7GUHaYhc9o1Tj8PfE93qMZVxDKQxLJHnfiN/nGbBappzCJR/4vWVTgbt7TNOP2afFfWV+CMoaA+2zKKXy4NfHSZC+N4FMrE7xgH7Zj8mj58mRCsgZ37AGH95rWnt/Z3nxqiF+Jrb9A0dYkCz4LUHF3K5fZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ItqbUrLolHk5dBN/11OyIZ+e3A4zWWL7b/8DTcBBSQ=;
 b=md7L0cDFeg09iStzi2aFufJqPxcYUSWmh4RmCM/SrNTMhInbt4ydLaNtSdDGnge3EvSBXhXSL7i0m/Ap2dhhS97OSn7p8i3XrQxAhQaivCFWt0Gs+FI5KZNGx/r5cuLfFOETA4C1nLkFOjltKnqPklWHxQs35xKt7jvneu7Kz4meLMW2BHROXtV9AWrkJuEBCA8kDZrW/6rpW19d3doAGEfay1ot8LvgSBKiPkpESPXRcw5bX9ZCwGpCycMPjcPLJ46p95TCMgcCGJ91kAhTB0fTCn5SbutZjUPjx/bPOar+THKqBZcWDmM48F3WGrVRYP5yQXW5CB3LjjV/zsozLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 8 Jan
 2025 02:34:38 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 02:34:38 +0000
Message-ID: <c7b7316c-127a-4c10-8e94-bcdefd2188d4@nvidia.com>
Date: Tue, 7 Jan 2025 18:34:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com, vidyas@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com, sdonthineni@nvidia.com
References: <20250106205326.GA132024@bhelgaas>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250106205326.GA132024@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:303:16d::22) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 9449ba85-3f54-48fa-894f-08dd2f8cff47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ditRSFh0QVBQQXpLb2JTTVVTRUh1RVI0NnpLdkdqR2lrbWw0K2o0dmhNcXpt?=
 =?utf-8?B?QU1KQytBN1ZqdzZpdDZVNjU4SElwQXhSUlhNaFlqd1NHZ1Y5VTlFL0poajZ3?=
 =?utf-8?B?ZW8yNUhtNTY5MFVXOG16dmM2WnYwQ29LckN2Yll3blJJK0RSbHhUSUI3OHYz?=
 =?utf-8?B?ckhrR09XUHlZR0NDL2psZmRhZnMyQ0ZSWEtZbzhtcE4yU2xMSG9sMk9NY1NX?=
 =?utf-8?B?R1dPNlBGckdKUVhvcm9nci9pZjI3YTFwNHIzY2VsbUptNzZTRjNYRE9TNzlU?=
 =?utf-8?B?cmRaSGdQS21tcDNpVmtlQ2dWb2VvR3FGZXBmQTMzanV2TFo5N1NqYnNwZklF?=
 =?utf-8?B?T0V0SGdvYVRHVWp4b0NZdFRubG8ydm45TWRMMThhMVFoRmVhQ2N0ZHNLdXB5?=
 =?utf-8?B?R0lhK0JOb0V0eGRZekpLcklZd2hrSjcrY3FsdlpLYTZkNzJ1RkE3ZUhrOG5I?=
 =?utf-8?B?WEFnQ0Qzd3ZYaGpuZlFYUE5QdUZCTmZnZ29qeGR3cUhzdlR3NWwzK2FzYXds?=
 =?utf-8?B?YllSSWFsTVNxM2FRY0tKaHVIWXJhSDFNSG9mVHd4VkdVdXh6bkZ5L1FmL2p1?=
 =?utf-8?B?ajFGdUs0QktEcHY4TVhHWEdlSU10dGp0Wk9JdWZIekFHQWlkVDFhR2xxbjdC?=
 =?utf-8?B?MEtQVGF2T2JVK0ZVTEhXUmNPZDl4TXYxY1pTMFZ2Nyt0UUx3VWt3Yy9Jc2tt?=
 =?utf-8?B?SW9jc2pCUC9kL2dRR3o1Q2xheXJVVGRqMDdDSm5McnJYZUhsOGJNR1VGM3Nq?=
 =?utf-8?B?TjNZTzdOMm5KdkhjMTJoOVdCVFU5N09GQmtCYzZwbFJxNU1OYnFNM1hyOGoy?=
 =?utf-8?B?YThIMWROY09NQVFJbnJFM0RmbzN5TEVKSHkrbzcwaUV5UDJxZmFXbjV1SDRl?=
 =?utf-8?B?OUU4d2l6dTdLMWRUYzFGb2htOVhNOWdXYUppeCtaWEVncXJXSXIwUlJUbHhn?=
 =?utf-8?B?YytTdEJubVZOUTkrdVZwSWhFbDJzTk5Tei9lbmtjTGZTSUErNHdEOWlRRG1z?=
 =?utf-8?B?aXRKSG91NFo3cHlSZ3MxSlZ5b0dQQWMyVTlYNURIMTBWRmFqYUhtcitYQUI2?=
 =?utf-8?B?ZkFwelBmTG1jYTZIY01oanJsUGJOeUpwMmc1aG9zdmpiSjBzSHhNeTh2RGdZ?=
 =?utf-8?B?aFFRN3dGVE9qNytNRU9qYnFyVC9VR2E2cU1iVDFOQ3dHaEtTVC9ZUit5MFd5?=
 =?utf-8?B?QmJ3UWVnSDFuK2FtSkhEelZwbXY4NmpzQXhVMnYybHBnRjg1a3MwYytZV3g4?=
 =?utf-8?B?VFRIeEpFQkhFSExrTmxka2phMHFzcGtrZnlaYkZHa1RkMTV1S3dQV29XOEFI?=
 =?utf-8?B?T0dhVUZjeTBvY2hZWG4xQ29zUU42QmtjVGw3bTJZRGZTdzlCdnduUHNVaUtk?=
 =?utf-8?B?Z0p1NkhnalNTdEJUbjZxR0VWSzRNa1EzcDVBL3p6WjVrdExwMXIwSUlhNTBN?=
 =?utf-8?B?OElLempabDY4cDRSQUJwRloyWXZDTGZSem5oalR6QVA3TUpwUmZ3NlRCcG8r?=
 =?utf-8?B?NTV6Y3d6R3MzOE9odUVTMktBb3VzTGNMeWV3OXF1aUhYTEM0czRBMUliNCtp?=
 =?utf-8?B?dXFsdnA0QW9TRkZTWVpsbjk2bkJKT2IyeXBiTDdTWCs2Y25GMUdtUUh3UU91?=
 =?utf-8?B?T2hkYi8yNnZWWVFuanF0NlhCYlp5bnRDRnhTWEdndys2NE9LbUE1dTBjcnR2?=
 =?utf-8?B?cTVSK28reVRXWlFVTWV4Q3VzUndBamJNWndoYTM3RHlmWjZxM0JJUmFkcU03?=
 =?utf-8?B?LzVDQUZrZ1ZtNkl0eHVSRkRScHRWU3gyeXFVTEFBV3hsYkc5OWthVkFmUko4?=
 =?utf-8?B?QUYwYm4zTjNYMk1ZREZZL0hyZnhTa0lEcnRxamE0TUlqM3g5TGd2LzEzTlAx?=
 =?utf-8?Q?dCRelcTCeGtCO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldZN3dsQTVpTWNQQUhkcnRnbXA4WVN2OW9VclM1KzZ2cmtGZk9STjYxaXJo?=
 =?utf-8?B?R2g2MXpPenhkWER3ZmxOdWxDUk81VG8yeWJJZ1MwZllMMzVWSHhmZjFuYWxH?=
 =?utf-8?B?ZmdWVjNWSE9ybVVoYnBrdTVnY2hRK3VvdnBuU1N4K015b0phbkQwdjU5Y3hP?=
 =?utf-8?B?QzZ1ZWZYYmtDaTlQdmlqUi9CQjhhZ1ViekNsL3dFaWVuUGpsc21pajJrQ0FC?=
 =?utf-8?B?bWtvZ0JwYXA2TW1lYmlJQnA4QWxmOGtBOW1QR3UrUmd1SC8yY2cyZE9WUGda?=
 =?utf-8?B?a251QzNLS3VKVHJvM0orUllHTTg1YWF4ajRPOUdKS3ZsNFVWYzZSTkNFdncz?=
 =?utf-8?B?aG1oR0tTaG5Jc0NiQXB0dEVjc3NHeElBUTRCSVhrQVBFYU5KWldOZWwvaWhs?=
 =?utf-8?B?bFh6UC8xa1Zub2Q5MFBBckpzcEI1ZDdGaGVhVUtxc2RjUVA0UW4zdi9CbFVM?=
 =?utf-8?B?WHR0b3kydWZRYSt6OHAzSUwzTU13eG9Ubmc3a2ppWnkrVXdlQllWekVlL3Vn?=
 =?utf-8?B?TExxSmFpb293dmxEN2J0NTQ2RC84NkZ6My9YNUFkWk9XNE9ZYmt4V1FvUlM3?=
 =?utf-8?B?NldJcFNSTzdzL0krRDlCWEZOQUZGS2JxRnMvZG5UUW9yUm82ZVYrak1RaGJN?=
 =?utf-8?B?S3BsWUJsWlFHbFVhZi9ERGZUUk1idjlmWitqWXNRRnQyYjAzSWljd0MvVDRk?=
 =?utf-8?B?cjE1NWsrc2ZsVm9BcnhMNzdFV09ObklGVXJxZjZOQUdwdE9nZk9Scng3MVZ2?=
 =?utf-8?B?emM0N0xJcHEycUZXZ2phSHJZNzg5RmFIaEdzZG9YaW82RmplaUQ0M04yV1JX?=
 =?utf-8?B?dUp3TWFHYXpvSXV1ZXNvalFmUjFJbmZ1V25UMHVTdFNuNWs0dVVuZ09VY1RU?=
 =?utf-8?B?NWhabEowZ0FPSm9rWko5eVhGa0w4MmI1UWhIbHhEajFYWTM3M2JEMHpQUVRq?=
 =?utf-8?B?THBJcC9ka1hTT3duSUh1Q0ltUm1oM1JkQUQwSndEQTNqZkQxdjdYRlJtR2N1?=
 =?utf-8?B?QzhrUXJ0ckVnVFFtUmp6TWl2eHBXL2NiMmJuMlhISDY4OU5LQzVRNVVGQ2ZO?=
 =?utf-8?B?MlBNbkZlSXd2QnZOMHAwc2RlRWVQeVVWUUZGRytOWmRHQWN2R0hHVWFNN3dy?=
 =?utf-8?B?SmJMUUNiZ3AwYlFrWUR0WTB0VGhMbHlJaU9UREd1VjhUcTZrb2swYzJxNlV2?=
 =?utf-8?B?YXRFOTBDNVpIN2kwYnhLaXprdUpHMVdKcnRsRkFKZjBaSW9Fa3NaSm1xRWFl?=
 =?utf-8?B?ckhBWXBaSndJcXlZbG9zcU0wVkZBMGlBcHMvOUZJNkdESUt6NXhvUVk1bnJC?=
 =?utf-8?B?ZldLaS9CdzFPQjc3MnZQU2o0QlIrdmpsbzlRdzdJY0Rpb3VLdzZvTXRJWWl5?=
 =?utf-8?B?SFBwMWFpOU5OaGNTbVFkOUJlT3JxU3Nla2dpSVp1M05Sb0kybEl0ZitHYTdQ?=
 =?utf-8?B?TnNBU3Zvb2hOK3ZyWkRRK0FoU3lLbHNjT1drZlRSUUREWWMxbE16RUlxSVFZ?=
 =?utf-8?B?b2dQREdLV1Ywc3p6TVgyZXB0Q1lZc3pEcDZWcEplbkl2SldjU1J1cVYyZzlM?=
 =?utf-8?B?Ry9sM0N3cGtjUEZoOG9iV1hRdFB0azhLamZuYXVGV3FUY2ZTZC8wbFpXL2Nj?=
 =?utf-8?B?aEluUkViL0xrcmdIZUZsWUdVOEdZanhlM2FjcTAxOUx1YWI5aHhIaWVWQUM2?=
 =?utf-8?B?R3NidkFiN0x0NTRGaWRJKzhSYjFXUnk4TzA3TmV6K3RoWkkvL0Z4VUM4Qnhh?=
 =?utf-8?B?NVdubGMycGI3TEUrWStMWFNPdCtVR3E5THNuUnhlQUExbGZxM1B0T0V0RzVz?=
 =?utf-8?B?S2NFZlAxd2VnV0FIdzNyZEs4ditwN3A2Q2J2aGtHRW96OG40RTVEZXNSSzkz?=
 =?utf-8?B?MVJobVg0SGNFZG1iQk5mQm44L1ZGVitwbXlsb2dhRmY5TE9BZzF3cWVkZHJT?=
 =?utf-8?B?dmkyaU5ldSs1Qk0zaTV5VTZjWWhRTHJYdW1uQnpqaGNEWm5zOVpJSGYyV1FY?=
 =?utf-8?B?ZGo1Qm1VSzdWK2ludWw2bkZVQ29ldkJLdHJqODRrZ2Q1OGF4a1QwZ1hMd2E5?=
 =?utf-8?B?SWVOWnZqTndINEdoNnhGdnVBOUdDbm9UN0NjczE0TnZSZHVHdzN6WHJWN01V?=
 =?utf-8?Q?g8E11H5o8GIlBQzO1k8mi8+o8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9449ba85-3f54-48fa-894f-08dd2f8cff47
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 02:34:38.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQOOEpIDUfk/uRu2nsbi/UP2FRMo9jWoqlYhBQg8JXHMJJGjyA4Rn3GorJAQI62F4fQGIqu8vdxWtrZJZ/hiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995



On 1/6/25 12:53, Bjorn Helgaas wrote:
> On Mon, Jan 06, 2025 at 12:34:00PM -0800, Tushar Dave wrote:
>> On 1/2/25 10:40, Jason Gunthorpe wrote:
>>> On Fri, Dec 13, 2024 at 12:29:42PM -0800, Tushar Dave wrote:
>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index dc663c0ca670..fc1c37910d1c 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -4654,11 +4654,10 @@
>>>>    				Format:
>>>>    				<ACS flags>@<pci_dev>[; ...]
>>>>    				Specify one or more PCI devices (in the format
>>>> -				specified above) optionally prepended with flags
>>>> -				and separated by semicolons. The respective
>>>> -				capabilities will be enabled, disabled or
>>>> -				unchanged based on what is specified in
>>>> -				flags.
>>>> +				specified above) prepended with flags and separated
>>>> +				by semicolons. The respective capabilities will be
>>>> +				enabled, disabled or unchanged based on what is
>>>> +				specified in flags.
>>>>    				ACS Flags is defined as follows:
>>>>    				  bit-0 : ACS Source Validation
>>>> @@ -4673,7 +4672,7 @@
>>>>    				  '1' – force enabled
>>>>    				  'x' – unchanged
>>>>    				For example,
>>>> -				  pci=config_acs=10x
>>>> +				  pci=config_acs=10x@pci:0:0
>>>>    				would configure all devices that support
>>>>    				ACS to enable P2P Request Redirect, disable
>>>>    				Translation Blocking, and leave Source
>>>
>>> Is this an unrelated change? The format of the command line shouldn't
>>> be changed to fix the described bug, why is the documentation changed?
>>
>> The documentation as it is (i.e. without my patch), is not correct.
>>
>> IOW, config_acs parameter does require flags and it is not optional. Without
>> flags it results into "ACS Flags missing". Therefore I remove word
>> "optionally" from the documentation text.
>>
>> Secondly, the syntax in the example 'pci=config_acs=10x' is incorrect. The
>> correct syntax should be 'pci=config_acs=10x@pci:0:0' that would configure
>> all devices that support ACS to enable P2P Request Redirect, disable
>> Translation Blocking, and leave Source Validation unchanged from whatever
>> power-up or firmware set it to.
> 
> I'd suggest a separate patch to fix the documentation so we don't try
> to relate the doc changes with the code changes.

Sure thing. I will send a separate patch for the doc changes.

-Tushar

