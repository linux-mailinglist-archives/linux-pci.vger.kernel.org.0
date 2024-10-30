Return-Path: <linux-pci+bounces-15659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A46A9B6F26
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493C12846B1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C721764C;
	Wed, 30 Oct 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jvOCbekT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2221765C;
	Wed, 30 Oct 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324100; cv=fail; b=UAfJ/nOh3fNEFF4xMlph7i9emqZIx91dSLly2c7KZoa7iacbYDm0JzZaNYvTFPATNIudRSL21/2JGPSfDksIa3brytWkSTwW+NmvL2ByYagP4IeCq8p4dAO7ox6vOvKElm+QJi58M3rMkILd2G/kEIih9hKl4LZAPRAu1DLNWQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324100; c=relaxed/simple;
	bh=1fW8A0vCuFzF5tTXG03/2QAuThLteg0IT59mQIBiuTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CMV1H+gNRGfpP6o33IUsvw5fXPwxy6HA/tedEcqS8CW4Ks/eRRSUCrkr4Vu9n7o6dY8IOe5ap6sVf0I40zw7ho7modiZWvo/8/rCMK0bfL1/BpD8Kt76mG+n7p2EDgxoWagiaYgqbi6q2GhCiENZe27EAUqwHOXsewdvBB6DuEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jvOCbekT; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZsZEIenFmwotdU0uJD//FVzOj5xOWg/qiCf2tYRQ9ksUgXjyMSj/5vPQ2bVuMxpqe9vuRZgueLQ7XpGvvR3caWewDCZy55+XlW7Kc8FYXxWP47QE8suvyoHCRLVxSHUVCThaXU5hwBR4LLZ5qdUb6BN0tyYY573EtWyqnplhGc4xsoBOO7XBL+A98KVVPm8GiiRIARwIp+E72pUCmNPin8hWskqrlzIPMnqz3D/2QKYx/q4lx2Pt2zHK5YjuSANXCCR2sHFawOoVKKtKawkElE1LozbW8QDFbPIT+lcALIIchZc0EI1+fckmWdSGZl2tZzVwTggw4aDdnjz8mAWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvr2poXScmdbd0z9krZT2guoeXvvv3e4b7fjKVxLbN0=;
 b=sVNtfw+TwrXnuM+3MkdMRvPcBZKqTKnJF5imHQ/fDolyUxLQJOF6xuTQl0XdnuFNJk2zmbqKs3vKqLwYzAcwegnB/XlPBlSzTqTaE3yoxn6kXTwB/ZBV57xgZuXD47wA3Df4rEgyCyWd+nmjAdkpI4INIoBJJwrvPCeuQ0czBh9YKqNn9H1oX7kM5QVSMFquGD/Vsx0MJXoYTmoqKEnVshsHTQ0xjW+e4IUbuX69r2U/q2QvVIzaL29HwWPAHJMvbD2fxUtubk/XSHlPMxxnqM58nbaBIx+llbOv81xa3MdeVZb96qHgKozh9Rrw2DsJaK3fNB1PDieCYufBTS5ZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvr2poXScmdbd0z9krZT2guoeXvvv3e4b7fjKVxLbN0=;
 b=jvOCbekTY7HoZXd3cWzVAPjaXxytISJi7GP1DoCF4HfW7prh2biSwDEew35bOjZQiIGmPuTT/yCHVe04oqatTRnNMlci6TT4+qRjN2gk8cGaiuUeThI1B7Axp9ElFB4DCh9CrurW4d2KpWkKki8Ls5egw0L82KzGTOjt4kuwWls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:34:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 21:34:54 +0000
Message-ID: <995b6552-420e-4b8c-bb92-63a8666236ea@amd.com>
Date: Wed, 30 Oct 2024 16:34:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-15-terry.bowman@amd.com>
 <20241030161120.000078b2@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241030161120.000078b2@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:805:66::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: dd56064d-c55f-4ff9-f817-08dcf92ab139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDhRdG9DZWU4NjFWbzdGd3gxOTJ2NGp6ZU9hTkowUHIxMEJrRmZpYkpQQllF?=
 =?utf-8?B?RnFQVUNRM2tWcDhJaFBzcTlkck1WSnNqak5ncWt4cVhnSS9LTmdKS2tRQ3dI?=
 =?utf-8?B?aHY2MnlFY1M2OXdGVmRFZWxCTFNYMGZXMzFJVVZWNlY3aWxIekNLWjgvb09s?=
 =?utf-8?B?T2NaTXNsNUlZNEw4YWJQQnpTSS9sMkdKMDg0RlQzWWpzRVltWjdPTlkyeFRU?=
 =?utf-8?B?cjQwNzN0VjdydTl5bUJMRTFKTW1Gb0hWdi9PZlJrbTREMW5BZDBRNGdQTlpr?=
 =?utf-8?B?RzlOaC9iRUY4ZnA0QUFwaE9PTWkrbUFkQm42MGE0YlBpbGVDMXk2S2p1dWpR?=
 =?utf-8?B?Y21qaUhkcWZLeU9jVFN6THEwS2Y5WFNnY1AwcVZib3NYOEVoUnVrZis5RGc4?=
 =?utf-8?B?NVJqWlNzbVpZZDVnRzAwa3dSTXc5UlJiRGdESmFPUHF1NGkwdWhjK3orR21O?=
 =?utf-8?B?OXdlWERFQURGbzhINkRGb3ZHUi9XYWlTOUpraVFnWUdVQWdTQ2pQVkxRYXpQ?=
 =?utf-8?B?MFVhSG9xK2l6MldEOC81UXVpMHN5b2dabWFhaGJ0YnpVZjVONlJTai9tVFA5?=
 =?utf-8?B?d2JxbmtNSmhDTExEakgyR0JtbkQ4ZGp4NmlTVEJuRTR3aDJxNDJXSmcxM1NJ?=
 =?utf-8?B?dUZLbE1DVTE5R1hUY0RjL0dVVEU4YnFlbFBGQzdZWHZvdDd2Y0g2aDViOEVt?=
 =?utf-8?B?ckswcHlnQnRFNU1VRkR1TFloUDc5SkdiSGtEMkJ6NGMweXdjZmliS1M4MERm?=
 =?utf-8?B?UUwzdXFXREUzRUpXZGdncmVnRHRrSWNCUENlZkVaWjR0U1JqRTdNcTVnK08v?=
 =?utf-8?B?Tm9DTTByUlNLbWMvclBXVzl3R1gxTGNKM2dWd2FNOUJGMC9IdzYvSjNHNmNK?=
 =?utf-8?B?US9ZSlY5VmtNczRjeC9vU2hUSWg4eDRpcy82Zjh0N1l2cUdKbEhzU09VeDdn?=
 =?utf-8?B?Zm4wYzJZTVBnOVBPcFFBQlg3YUx5R2kvTlBpTkEzYzIwR2F5RVZrdmR2MGdj?=
 =?utf-8?B?UWNhODYyd1BZellHamtuR0FOTnFoVTZ6WTVxUWZDVHRZdnM4Y0UvWDNRZW9M?=
 =?utf-8?B?blBtR0ZFcGd5Y1dXN2pLdmVyU0hBOHhlUU5kb3EwaFZZTFNmeDc5NXUwRHRx?=
 =?utf-8?B?Vms1OHhzOE1pZGJRdVRLczE1Y09PTGhmV3kveUtBK0FGWFVaOFpPQXNUT3RH?=
 =?utf-8?B?bFpBVEpWUWxlbWV2cGlWQVVUeHBqaC9DR1pYS1dML1ZjNy9taHBQL1pyMk04?=
 =?utf-8?B?aUJ6aHJOVUNiY3NaaXB0bnF6SkZzUXcrMTNhZEVQZzJwb3VmLytROFdqVTU5?=
 =?utf-8?B?ZlozWGd5TWgyemlvdEtxSmQ3V0x3TzlPMjVLdzBWNmVLT2k1WmU1UnBnQWxq?=
 =?utf-8?B?UDRTM1kvQmV3RnNzN3pMWlpLckU0cEQvMEcrZVBBNU1TN2JlczQ4VzE5dEpy?=
 =?utf-8?B?K3orWGlyY1NGaTFCRGxYYk10eFc1Qmt1ZzZXdXZ5RUlGTjN2cWdNZVNyVDY5?=
 =?utf-8?B?MXpoM2MrNXhGQ3h6eGNSMDBuK3gxUk5tY25GN2M5bkR3WEY1THFiTkdpK0JR?=
 =?utf-8?B?KzdHbnh1bTVyZkdoNDM5bmNBQURXWU95VjBpVVBEd3QvLzk4N0N0S1ovUGpn?=
 =?utf-8?B?dG1IUi9ZWnhVcENCTU05MjJ3SS91TXIzWmxBM05SUjNoUkxESUpZZytYOGI5?=
 =?utf-8?B?U0MyNHpuWUFZY0hzVDhCbExNTnFKcktCWXdFOEFmNmliZVQxMUV2ZE9HOHNL?=
 =?utf-8?Q?BifXxuo12FU3yP7McF0190aJI4+Qlezym6l4rBm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUx6V1NXVk53ZkRQbUtwb0dXaDhHcEt6bTFKL2ppSVNkZ3RjamNaaE1uNWR5?=
 =?utf-8?B?ekUxcUFkWWtnMTYvbmYzWWJQbDRRSEtLdTJKaWlkOHlDRkVTSU5tVGk4VXp2?=
 =?utf-8?B?M2RvWE1iaHY2Nkg0OS9VMWJZSWkxQjZXZm1JakFvVTIvMjRlTzJhWEpqblRn?=
 =?utf-8?B?cXBIZ3AyYU1Gck1xZFFOMy9RbFZLbFNaUmQ1eU1NRlM2Z3V5KzJ5Q29Mdi9q?=
 =?utf-8?B?VUppMnpDNm5FRWFIU2hQQnkyRW4xS0RXaitzSm1Sc0o5SlAzNnBWdC9BdjV0?=
 =?utf-8?B?YWJ4RXloRjZxWG9wRm9LZVZ6MXhlcjJjclMvMnVuYndXUFc5TkhEYlNqb0F6?=
 =?utf-8?B?c0ZZYllqc1JzUlFJNmE2NnBXaFZncXBUNHoxVVVwRTk1R3NsMGNmS0xBUHJT?=
 =?utf-8?B?NDhEMVN1ajJSNlVSSC9zRUdVeSttZzVxZURvRzZod2FKQmJibW05WFRpUWwx?=
 =?utf-8?B?NjUxNVU0ZHdmRHd6TFBJNE9CeWtqOWJhMkdzc3VYeDlwaXBwRUFYWXFJS1I5?=
 =?utf-8?B?cW5ocnFySzZndGd5bDBOajFsdkJlYjhkWVZ3SGphTG54QnRHdlhtRTFtVkEv?=
 =?utf-8?B?b0FhRnlLbkR4Q2t2TzBOWlFzWUlSSVhibytDTkxSU2NjM0dmSlpUeVBQNFNs?=
 =?utf-8?B?ZHdDVzUyUWFtZlh6eGVXaEFtc0RUZENoNytuek1rVDByMjRsb2VsOGN3c2lK?=
 =?utf-8?B?OVVBMTdpZU9sYWVtRGZNRXRhTW04eS9hRzIwZ2J0N1JRZFhCQ1U4cktRZXZK?=
 =?utf-8?B?SFpnVGxaMWs5cVBORXpTKyt0NEdhVWhFT0hRcGlQZ2xTSDdPY0lDNGhpRy94?=
 =?utf-8?B?ZS9ocytxaXRnQ1RJMEF1Vkt1NjIwTTRxZlhPOXFsWWc5amxUaVJsZ0NBM0hP?=
 =?utf-8?B?aTdQUm1ZVnlpMXFmS0RhUUIxRGJtd2lYaVVZc1JlSi9GcUpSTzFHNm85RkM4?=
 =?utf-8?B?RjhkWnBIZzFmM0cwdnZidjBtQkZMNlhhMDg5UzhKT003QnM4dmFLRzZxOTY0?=
 =?utf-8?B?RktQRmEwNHdnQ3RTOWRlVEtRTnVwU2NZaWhDNWljbmpNR0Y5S0toOW11VDQ2?=
 =?utf-8?B?Z0NLL2s1WTNONmRTdW5HSll3endLcnd0c1hwbnJHVVBJUENqajgxVzd1RXZN?=
 =?utf-8?B?YjhiWGNRVXY3em83QlI0d1hyc1g1SC9lT2lQSFcrRlV6bGcxR2JFRXZRYkwx?=
 =?utf-8?B?ODM3ZVJnT2NqTC84UHVIcWtGTTdLNmJURi9DK3J3VkExQXBZUjltaTBhK0RG?=
 =?utf-8?B?V0ZNcFNtVEhqMUcrV3MvdWVXWVFvMVpSUW9KNll3QldtWE1UdmNyNitxdnZO?=
 =?utf-8?B?cGNvMXpUMHdHRXpkcFVaSUxVb3prSnJmRUErN3FvRnZEK1Y1RFh5dDVwbXFq?=
 =?utf-8?B?R3dFRnBLTjJMaHdGN3Faay93dDBxWUZhTmlyZU00d2NldDNpRHFwMUlsTFpF?=
 =?utf-8?B?YVV0d3BoMVdKMkF2T2tiMVhyT0VlKzU4K0cyTjlZbjIzSE92Z2JwL1RZZVNi?=
 =?utf-8?B?V0ptdGRhbjljMURjZ3JPS0oyOWo2Njlrcy9QL2xPUHVOZzh5Q0l4aXUwRll2?=
 =?utf-8?B?SVVzRWNBV3k4MWNxdmFCV2FSSW1EK0ZZZ1pTN2pTYWFVakVXd3FNVTBGVzFL?=
 =?utf-8?B?eTJaZXkwSFpTclhFQWFTdlhXL0JnNXhKNUhTNGNSai9vanZwUEtGRjJOMFo4?=
 =?utf-8?B?MTMrdHRld2JILzZSVlRySURpZlF5cjV4amNncDdObGtzVkxQaWRYMUw3K1dQ?=
 =?utf-8?B?dUpzbzJhSCtKOFBWM0RhZjFVVTJLK3JOTmtGMXg3VCs0TkkwUTJkZXJzdzdS?=
 =?utf-8?B?TnVNdGxTeTZNVlowbWhsdFNLbHF3VGNwd3hEYTVlY05ublJQdWdVQUpXTm80?=
 =?utf-8?B?aGEzMXpweENoRHZ1WGgwOWlsbVkyTnFOSnczWnh5RTZONk42cWgxc2dZOXpF?=
 =?utf-8?B?MFB4Z2FWRk90TVk0enpBWEplL1NKNk9rNkdGS28waU5Hb1hUaFZtTnZ2bUtm?=
 =?utf-8?B?V1hhUTJSVkVLTE84NkdybFhKdldleVBuUnQ2K0NndGNHU3JOVEFVZ2VzRmlj?=
 =?utf-8?B?bTFZN3lUdlF5dHI0R1JXL2c5bmRiZGR0NjVkaUdueklxRlNUWUxzNDdNOVpo?=
 =?utf-8?Q?KC/qhZ3gQwbBwkbgNHQPRe0S1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56064d-c55f-4ff9-f817-08dcf92ab139
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:34:53.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4swhu+7jQTGE84LP7FLjpC2UKWRuR8pYRb2mjxrIlKIGnDfKPBXZlwHHmgfxwgxX8AokkqXsz/lQc+NH698tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651

Hi Jonathan,

On 10/30/2024 11:11 AM, Jonathan Cameron wrote:
> On Fri, 25 Oct 2024 16:03:05 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> pci_driver::cxl_err_handlers are not currrently assigned handler callbacks.
>> The handlers can't be set in the pci_driver static definition because the
>> CXL PCIe port devices are bound to the portdrv driver which is not CXL
>> driver aware.
>>
>> Add cxl_assign_port_error_handlers() in the cxl_core module. This
>> function will assign the default handlers for a CXL PCIe port device.
>>
>> When the CXL port (cxl_port or cxl_dport) is destroyed the CXL PCIe port
>> device's pci_driver::cxl_err_handlers must be set to NULL to prevent future
>> use. Create cxl_clear_port_error_handlers() and register it to be called
>> when the CXL port device (cxl_port or cxl_dport) is destroyed.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> One trivial comment inline. 
>> ---
>>  drivers/cxl/core/pci.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index eeb4a64ba5b5..5f7570c6173c 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -839,8 +839,36 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
>>  	return ue;
>>  }
>>  
>> +static const struct cxl_error_handlers cxl_port_error_handlers = {
>> +	.error_detected	= cxl_port_error_detected,
>> +	.cor_error_detected	= cxl_port_cor_error_detected,
> Odd spacing?  I'd just use a single space as aligning these almost
> always makes for messy future patches.

Thanks for pointing out. I'll fix it.

Regards,
Terry

>> +};
>> +
>> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
>> +{
>> +	struct pci_driver *pdrv = pdev->driver;
>> +
>> +	if (!pdrv)
>> +		return;
>> +
>> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
>> +}
>> +
>> +static void cxl_clear_port_error_handlers(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +	struct pci_driver *pdrv = pdev->driver;
>> +
>> +	if (!pdrv)
>> +		return;
>> +
>> +	pdrv->cxl_err_handler = NULL;
>> +}
>> +
>>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  {
>> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>> +
>>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>>  	if (port->uport_regs.ras) {
>>  		dev_warn(&port->dev, "RAS is already mapped\n");
>> @@ -853,6 +881,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
>>  		return;
>>  	}
>> +
>> +	cxl_assign_port_error_handlers(pdev);
>> +	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>>  
>> @@ -865,6 +896,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  {
>>  	struct device *dport_dev = dport->dport_dev;
>>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
>>  
>>  	if (dport->rch && host_bridge->native_aer) {
>>  		cxl_dport_map_rch_aer(dport);
>> @@ -883,6 +915,9 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
>>  		return;
>>  	}
>> +
>> +	cxl_assign_port_error_handlers(pdev);
>> +	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>  


