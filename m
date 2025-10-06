Return-Path: <linux-pci+bounces-37627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4BBBF05D
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 20:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDEF734AC61
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CD72DEA83;
	Mon,  6 Oct 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H9n6+Wua"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7C2DEA77;
	Mon,  6 Oct 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776739; cv=fail; b=UFC2xpJcomt164NUaQhCU0lBu8qPYWtwazuDXKfRQKVgiBEEV23T5fwFTI1RBTko6nqSAXcFzMXp4wIXQ9qDaNwpbLeUEfHTErlabHInMfewiFb4hF4jLUiNF+2uaZKrUK9NpVwzjByl6loZiVz3uTTwtiO3+uyq4szbEvnj6q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776739; c=relaxed/simple;
	bh=0x2yLKmycNtEU3AaTXudTLBIQTK9XdARFOhrjzwRcRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQzxM9zzncDI2wdg+JL69w/H2E3MAOwTIi83YE1N5og7zn+YHmwighsqacLhBNy58Ns/cf90t8l0Jv/vztJH9Eg02lTbg9rBGD8rrrgZXWEeWEKrVvMk4qhTDPbrDv71e3UheJUKjYEBZpZAMiOfJJCu/URUOkfCFWvEsSGqhBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H9n6+Wua; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7gSckPwUno8YsQzlNCqPsxHdwnd1JZDM2Wmt2VYsQCYWqpRKApf3ZCdnpz9kCrpisZRCoeutY+nz6boaqYh4bLy3mYcIYYwIPXA4SqsPLVRavKICX5N56FWvbGCuihi9IPtR1FBMH3Ug3cZ2q68MTHVZuk+xGEldVfZHxNFouaKyNC7QuM0p13f25+zmBCEVd1ovOKG5aNaDxyGj+aLGQL8cZnGeioEEkbI3X1M0so7CaWV2y33jcuMB1UaPoC4Z5rfd+Y1soypLHsjpD5x0Joghg63sGqUpHmsrQtLQgoLttFXltIeB2PmBJobejcTFDWxTnqPD1Q0RkkAY6+2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8sV6iEig+8cjs5N+/sUoN7+jT0L/9OOVW6OyhtcX8Y=;
 b=ot0RghF57+nbySGlzLA770x6OukXaGLM2ucttL/l9TaJg6/40yIrdXjXNoS1i0jrhVw0JW1nm2H1t8BrkQsyu+jAUkLDPi0dewB+j7vV32vkSq6B80baWjjZjjAK/MpmC5sKvnkTemrDLZ4JSWVR/snv0///PnbfsWHuOyM1Q1jMuvBZmS5VAz0diri6Ojxy8v6MhdCI6m6wf+WFzSEm2rzSvXqrGlsAz1LeDKU8vGHC7TUTxwNQikCW5jWdNxe4yh3bLNm66ALcFO96CMDXnac+LUVRTv70i0aIf0oBpMwRptc48xqB3mecGbzVdyL3mHXFdhO7SvlNPHIX6T0f8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8sV6iEig+8cjs5N+/sUoN7+jT0L/9OOVW6OyhtcX8Y=;
 b=H9n6+WuaunCz7uWhaEQEcQoI7SCSbGGSGXSTxFGBqUqLozMf9cv9wtkNmEHw66v7jG1hc17CwiaSuS80FV9bPLBd4u2iHZFfQjG1FNh/wJJXweWkbwVVFwYcPuLj60+I/U1uyVrxNLY6NVNTx5lt1yddzhp7oRHWbuhPIsAdem8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Mon, 6 Oct 2025 18:52:05 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 18:52:05 +0000
Message-ID: <3920762d-67af-4a55-a763-825231572abb@amd.com>
Date: Mon, 6 Oct 2025 13:52:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/25] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-6-terry.bowman@amd.com>
 <c1b197a0-31b3-4321-94c0-9f0394b78065@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <c1b197a0-31b3-4321-94c0-9f0394b78065@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5e5e2d-ce0a-4132-1506-08de05097165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGhuWnUwQ1dZK2dINTRiZDdhSnBNaVppQ3JNYllDeWJsOWxPaGxDUHpDbjdU?=
 =?utf-8?B?d05LazQxeTlWaVFaV2ZmUGtMRGxKTXJiUGYyMklPM3RJM3ZHL09WeGRQdjEv?=
 =?utf-8?B?WDRNOGJFVzZzSzFWbldtdzU2NTBxNTU3ZUg5ckgvR0dBTkhQYk1YYVB0MDNL?=
 =?utf-8?B?QytEY3p3azNkM0NsREF4T3hvTE5WeldzcERPSjFIUkE2OHJjQ3pweCttNzVJ?=
 =?utf-8?B?MDlUT3NBSDFOdlcrOUZObDB5MExXU1lTeHlESjM4TEpQZzl0QVhpS3piS3Ji?=
 =?utf-8?B?WGtOSkpQWjVwNHBGWHpjb0I1Wk5yNWdEWThQYnNzWVM5S1BFMXRwQTVzZmRs?=
 =?utf-8?B?RXl0aGw4aHIvRndtdm51RHdiYnhuZ2lReDh6cmR2Z3BJMjdFT0hEaFdQbEhV?=
 =?utf-8?B?cU0zRFdRWUlQYmJmbFU2aWFCZkZCQmluYXM0aVFxR29OdVBEY01MM205Y2Mx?=
 =?utf-8?B?dmNyUVhHNVZibVU0YXRHUVRyRW90QitwbERkSDZkVUZxd1hjRHQvTHNMZldz?=
 =?utf-8?B?NXRLZDdWNlZSRGFPWHFTbUNnUlpSdkszWmc5QVBkWkZFNDhsTFVBYkFsb2lQ?=
 =?utf-8?B?dUhNaUwwdE1pTzRrbGNpSm9JSkRPelZvZ01aTHZ6aUpUenJPQU43aGpqbi9t?=
 =?utf-8?B?TVhXbitQeWU2MGQ0TDNZUTRZdFRLOXpWdU1BVFJkT1pXSmNoc3llUHpMcWlG?=
 =?utf-8?B?NnhrbFhSVEZYT0dYcnZ4c2VHWkZFdEphcXRzS01XNDB1UWpMaXB4bm4vK0ps?=
 =?utf-8?B?UmZSZFVDM1dvemMzdjFTajhQcStsUTlVZWtKOGxEZWNvUk5vZ1ZhV3o1V2ph?=
 =?utf-8?B?SHFNTnFuM2kxZVJxTlBpeWJlY2NUSGx5cFl4RW1vMEVRRmdVVnRyQkc5YUJr?=
 =?utf-8?B?NVNZck4rQWdBWDM3aVZPd0ROb1oySHNDTE5ZOVlwMEdpanVURW9TR3NJK0lh?=
 =?utf-8?B?UTVldUQyZWpXb3lDbWliZy9lQ3Zvbkw0dEJSVm9wNUpOaVBzYXNML21zNjVQ?=
 =?utf-8?B?K3psc2s5azRVdVBjaEFiSjlsUG5TWC9yTTZxU3I3RW5nSWFNQmxxVTRzN08x?=
 =?utf-8?B?eHFVbTEwZzdlSm8ySnRNcjNjUHRsaDRXRURqWmhpZUxVY1JqN1cwWXlTeDZD?=
 =?utf-8?B?U0NyNm9SSk4xdC9nQnAzdUZMS3lDOWRYekhpNG5GcjZOdmU0NTMrMUhqNk5V?=
 =?utf-8?B?alJvSU0zTStvbmt2aG5mWCtKcWpmSmswUVpHMGVxTzFJN1JYckxWM0x1TThu?=
 =?utf-8?B?aUdEMGJPUzM4cWRSbkZqZEJKekZlSmhxcnVFQ0Nwd1hlRVVnREZCV1VGbUo3?=
 =?utf-8?B?ZVU0UDV0YzljMWtLQU9Va3paZDA3WnRtNE0rU04vZFIwMldBRnhtTE5ZTTR5?=
 =?utf-8?B?TFlEQ1dRWllHWlhneFcvbjVFTTNhTlRMVVVldENmVHdDcVFkamxRMWllTFpM?=
 =?utf-8?B?M1hNdnk3Qko3TC9kUFhTYm1SMWorTEJtVzQrd0c3SkJzZ2FyQ29MOGdjRjVT?=
 =?utf-8?B?Q2Erd2xpUTdvRkR3TVNsNXpmNmUybjdwUE9ITVNwMEFHeEJTSGxsMm91ZTNF?=
 =?utf-8?B?Sk45aTk4SmIyTFdiLzZJRXV0NXovczlpcXRBbFNIVDdkV2RQU2dXR1hhUUhh?=
 =?utf-8?B?UDZ5YjNiUkhEUXJ5UVlnUFh6eXc5eFlKYWhyWWN0dm14Nk15S3RsVUNCcURZ?=
 =?utf-8?B?K0RWRWJTWEJhcm5KTGdqZXpRRjBhSSt1UjIvR3RXQXlSTHhtVlZBeU1FNHRK?=
 =?utf-8?B?TmZFc1JEdFdrSmsvSUdmVjhzM0lGbnlMdVhrM0dRS0F4UEtNOG1kU2R3QzZL?=
 =?utf-8?B?Q0dPUlh4aG45OXdISzJtN1JYRWVXcE10cExPNVVBODZJQStTMjhDYUtkNFRZ?=
 =?utf-8?B?UzA3bFNTNi9vSnZTNjlRcDAxRnM0cjhtQ0FqRGVSQXRtUVFqUXBmdGkrTHZ1?=
 =?utf-8?Q?7H3f1cqWHrOVn/SiZ1nZOGqIhFQChwCs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlRheGg4d20zVDR5RGd4WjdjV1NwM3RTa3B6VU9hK0cxS1VpK2xJTU8zVnZI?=
 =?utf-8?B?ZWUzZnBBY1E5RUFkZCtORENYeXJkQ0MwU3NzVDVIUEtCVlRZVXZSaWlIMUFX?=
 =?utf-8?B?RnI5RVkrUlhEcC83TlVWNlpReGs0NVl3M3Zsem90Q1F4MUV1cVZWZjVoaW5r?=
 =?utf-8?B?Slo1QjRRazcyeUl6ajZMQTNUOUpVNTROUmgxVXN5V3l2NTBFV1ZTdm1KWVJ1?=
 =?utf-8?B?Z0k1UWRHNVVwUlpvbVM3MTdtVTVNdEhYTkM2OVdlTFVURnFvNXJLV2Zvb1N2?=
 =?utf-8?B?OVordHJpckt0ek5QU0hSaTNTUmtsREhvbzBja0xqVGlUUkR2emVmMThUQWcz?=
 =?utf-8?B?dW05KzhGLzZaRG5nOHdFNjRKeVQydFhEV0xMdTA0bHF5UGNvSGJZV0RPYVNV?=
 =?utf-8?B?b2RnL2xVRGJPQmUrOGNFSnlLRzJuUE5pV29NbGdYVHNaaThYaW15S0dkZTNS?=
 =?utf-8?B?dk92RTU0QVV5ZFlvSjk1ZlRyeUJha1dsN2dsbzROWTdERmh4aWp1Y1FGNk1J?=
 =?utf-8?B?ZndHelBWZHBLMXE5c3pxTmlxQTc3NzNoOEtrQ056WTBwU2pWNFdRdFB5ajNC?=
 =?utf-8?B?Z1VBa3pPN0NRbnhZaDdLOHZlK25zVEQ0L0RpSUdxU0hZdmpwblh3OEhFN3lK?=
 =?utf-8?B?eUlBcjMyakwrMFJYS0xudmpQcWhNbkx4TTJVZ1hCN3E0cDh3NExMd2ZrNVhV?=
 =?utf-8?B?RXIzT0Ywa0hQaEM4OUovbTR1VkQ0ak1JMGpxNTV0RmNIblAvamRFR1VnSVBa?=
 =?utf-8?B?ZUhHVTdDb2RHR0szTTJ0cWJkaXptWWR0OUdHd25qb0pnQSszY29iTnhoTnc5?=
 =?utf-8?B?cnBLTThIendsRDZYcVRtN2RYd0FQMTJYY3dZWTk4cTlXSzNMbjhGNlhnTi84?=
 =?utf-8?B?Yy9VemwvYURxdGl5YlFhSW9yclZia1FiR3oxK093OTA1ZEY5T3QrQUhVdWFO?=
 =?utf-8?B?SDNRWDZuRmhtbnllUUgyTWJuTHhmVDdMTXo3R1dLeWZQbFY2c2oxSG9VZC9N?=
 =?utf-8?B?REp5MEVydTR2blA0SEM0R3FVTmtueGliSmZabE9LdW5OZDVJaWtwbXJzL0Fa?=
 =?utf-8?B?eEhud0tFT1FqUk4rNmNkM21uQ0pMWldpS2MvVnFaN2R1UktRVTdzVktZL2M2?=
 =?utf-8?B?TThHUmUyL2VKQ0JGV0hRVFpCQTFqSDhWVTNzZ1ZUdlA2R1FOaDNzZm0zY1A1?=
 =?utf-8?B?dm9LcDVLNTh5eEhlN3N2aFBGbjFlOTN4RmtkRTJCS0ovVTlSbWsxUnhad2g5?=
 =?utf-8?B?OUdMVmtGcG5MVU9rOW84dnYyV0U4aHlMaUhjM285VXJlaFJoUVhSRU5PSDE0?=
 =?utf-8?B?WEQ4UWhlOGRGdGVwMjF0K0FNb01OTDBrR253UlEzM0NzR0F5VXNnUjF3dWRN?=
 =?utf-8?B?R0k1ekY5Rm51b0dJSmQvdUFpVjVQUmVONFdaMGdXTmpHQXM2ck9IUXF0OTBw?=
 =?utf-8?B?UGEvWUV4TG90N0RIL0ZVeGxndzZsT0p6aUdFSTNJV0xsUXFidnhCblF4MnVj?=
 =?utf-8?B?M0I1L0JZUXNmZjNwc05oRlUrTWdra3hDajhGWlkvSlAzTFI0dnM0cFVZdUlu?=
 =?utf-8?B?YWVUZVZGQWpnNk1iZUw4aU9XZWZNWm1kS3MyTlpETzVzOVBsSzg2MlF1OG0v?=
 =?utf-8?B?WDVRbklBMDg3MUZnVHFpMzF6WnYxNzhGK1lKQjYzQkk1QVFYY2IzdFRNOVJV?=
 =?utf-8?B?SFZYbFg4VWU4cTJPamE1RGd5QkVMSmszbmJRMEZJVGFmL01wemJKbk5jT0pH?=
 =?utf-8?B?dHI0aFRkSjZNdGgxS2kxL1NEYWVYZ1BQc0FMQmlRVEc5OXF0elRtYXpZRmdw?=
 =?utf-8?B?VTRmNzRSYTlKaTNjSC9uMUloMDZOQ1ZsR1NYcWxDL1AramZja21MdUV2ZnJL?=
 =?utf-8?B?ai84U2YybVNWMHlUYXNjenBpMXlzdC9RQjlmcTBTZ0dKR0l2OVd1U2NOSU9m?=
 =?utf-8?B?REFHUkpEc01iQ2pBSGp3SnNkdkh4VWVKc0kvZHNTcDJ4eXdJUXpKUTNvTldF?=
 =?utf-8?B?V2Z0N081ZXZoTjFtQVZQYWtWbDh3UG0zMmFuRnhBeTF1d0E2MW5kMk1LdXFn?=
 =?utf-8?B?RTNPQWN1SVZVZEJwUTBCN1NEalFHYmw2ZmxwWG9Yb3k5K1dYSEVLNGxqOURK?=
 =?utf-8?Q?Kyamv3byKamnc9WAEe0W8ZhuI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5e5e2d-ce0a-4132-1506-08de05097165
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 18:52:05.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgZqLnn9BUka1DXmoR/ww8JsSOYaNBLN/b4gHM0c4y20ksCu9KIsylnprYXIRFpTvOmQlLEqqGnIZvF6CHxAtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963



On 10/3/2025 3:11 PM, Cheatham, Benjamin wrote:
> [snip]
>
>> +
>> +config CXL_RCH_RAS
>> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
>> +	def_bool n
>> +	depends on CXL_RAS
>> +	help
>> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
> Seems a little terse for a config help message. Maybe something like: "RAS support for
> Restricted CXL Hosts (RCH) as defined in the CXL 1.1 specification."?
>
> Do we also want to default to 'n' here? I realize that 1.1 devices aren't exactly popular
> but 2.0+ devices/hosts are still pretty new. I haven't looked at the rest of the series yet,
> but if this is the majority of the RCH support then it's small enough to include by default
> imo.
>
> I'm fine with leaving 'n' as the default but I thought I'd make the argument for including
> it by default just in case.
Sure, the help message can be expanded. It would be good to use default 'n' if possible, 
but, we can default 'y' if we see a need. I'm not aware of what degree, or if any, the RCH 
is used.

Terry

