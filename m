Return-Path: <linux-pci+bounces-27394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3DAAE910
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 20:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C915987AE4
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05F78F2F;
	Wed,  7 May 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZnVHLRFW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CA28691;
	Wed,  7 May 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642636; cv=fail; b=JlmjB5gTN1KEsR6+ZSA33ksEwrprRRX0XpR1QxMiFgCXgpmoR4E/NNFENkiLzOK6SeT2phLyLQKOo1AviG2Cn/oL9wNAwUJyXF9Usn5+7tcGKsHBZZX3FJtoHR+72pN8xQp2boPTWmb0LZQlinxZ/YUCkwHG7WTMNWg4NAVj+sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642636; c=relaxed/simple;
	bh=juTLy3oQQokPxtRzIfP7SDvMZLGwDHaU702cUddRTsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fHznv5PwQAo8FCNQj30jIDs7+wTiBRZ0yZMbqrPtwiZ7oWG6MVbK1a1pA5WR4FJxz6LlLLEzIKOQ3YyWd3ROc4BIL883L0Mm0JQvdWQn1/sBqN1I7WpIB/vN1W9lfSg8lM+01cNOghpn1/4c29ytKJHyHpMQBRbNDR6Kw+LckwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZnVHLRFW; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzOr1XgLRVEZ8cLoVSMkTs09jI0xtpKSrjfwkgKMjkjt2qSOiR+6lriC1haRbjh4tfFiwBU62jdfcQ5Twp/Vsw7yySHOMITMIId1F5/lOTHhNPnZ4RWTMuI9jogNXRxkzVckCweQKrmnNdENcJZnpWugpkHJwrtq2wzKOrDTot18uHW05wqa0q04EgCQeVhisXc8NQNBPG3/oAJT9hlSFU0ECXKy+groEEH1SZIwrm/GA0STmVwIIF19XaK+bPeEL/ojDIzbcDytZg5ot6MrJQY2s9lIloMLoutxl1XDn3IIgvDWv8/DPgCwUFqEwTTQ1MoWUrRI+sfc4lT4eyymbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juTLy3oQQokPxtRzIfP7SDvMZLGwDHaU702cUddRTsw=;
 b=UHxCoRhfBuPV5OD/7VQjVqYyfPizMN65ykRyuu+ZzhukqzV6xdNBTzBWxI4dAhCIm5ShTua95O59QCh7Izz6B1NPJC83TD+H03dH5ylRgbvD/40gCy2h4EOgZMb48x11ERtT8blYTI1wdc2R3kZM30mblfGJY77IWbgR6KfyLzEbqWlPZMMj4sGttz8aWszs32WCFxcHdqsqEmhvRC9TDof9eEoUeCKjCbZk5pMjQ8IvuPUifRqvYxCOse2vFWIEynSXTtB2eMsyEAy/vfAFOVNkMjuCItAD+BVU026szWhy7W5m1yZeEhEXAwr2gxs3HXazJimgh0595KvxjPWdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juTLy3oQQokPxtRzIfP7SDvMZLGwDHaU702cUddRTsw=;
 b=ZnVHLRFWZE2NoWbX0rWLfy0AxDZpvjyZfX9oprqbN0NJ9AFwvp79o3GpQTz29PezRxfq60g7UvFi/Uv9lWaDOWITYnu1Tl/uNunp5rIRg4Z0sysaUK640gPBpHzvGp0YwDbluEwtn3+UXPqQooeAxXD7g0mVGq6PHjOoGLlBKKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 18:30:29 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8699.019; Wed, 7 May 2025
 18:30:29 +0000
Message-ID: <1c742bcb-4296-465e-a811-79d256d2a919@amd.com>
Date: Wed, 7 May 2025 13:30:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/16] cxl/pci: Unifi CXL trace logging for CXL
 Endpoints and CXL Ports
To: Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "oohall@gmail.com" <oohall@gmail.com>,
 "Benjamin.Cheatham@amd.com" <Benjamin.Cheatham@amd.com>,
 "rrichter@amd.com" <rrichter@amd.com>,
 "nathan.fontenot@amd.com" <nathan.fontenot@amd.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>, "lukas@wunner.de"
 <lukas@wunner.de>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-12-terry.bowman@amd.com>
 <20250423174442.000039b0@huawei.com>
 <c21ab32695484da996df84988dddbd0d@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <c21ab32695484da996df84988dddbd0d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:806:a7::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fe2e43-804d-488b-7f78-08dd8d953e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmN3YzZYYlBnMWxPUmhTcUE0S0xmdklaWkNaZ2hQWkJUWTY4eHRiQ2orRTM1?=
 =?utf-8?B?U3JVODlpZllaUWZScW0yWGprSEpCeWtkK2E1RjR3MHRSQUZJcDZlMDdFUkJa?=
 =?utf-8?B?Wk1PaTBWa2tRSlNvSnFQR2c0ejVxNDhNTGMyZnFCSFBNTS8zQXp4ZExsVk8r?=
 =?utf-8?B?SnpMdmhhVW96TURabXNlV3lSWUtheUZiU3dJVWJlbGFHSTZIK1pJa1V3WkdB?=
 =?utf-8?B?NTFGam5NQW9zaFhiSThxVUFKcXkvdWFXV1I2aURzSUpXMEw0RlhDaUpQWHgy?=
 =?utf-8?B?cXY3dG0rZTNTMERMcjcyM2NSaUdSaCthSGE0ZE0yUkd6cThVaFB1cUZPb2lp?=
 =?utf-8?B?RjhwQ3FKRUYrakd5TXd2SnMxSitrNStyc3JES3RmWEt6S1JqRHlIL1ZtemRK?=
 =?utf-8?B?bmJlZEdEcXNjeGRGbDNqOGV5Z3ljUkZYVytHKzNXL3RUUHdFN2dlUnNVUkxs?=
 =?utf-8?B?TzBFQ3RPb1dpeXNvVVptdWV0M2o2VHZpcmVmSnhlY0RqYnM1TjJOWUpSM2xX?=
 =?utf-8?B?YkNMV2FNOWIvV0FGWlRoMWI2MkI4NG1pL2F4MGdSL21RU0I2NnZNZ1VHZnFS?=
 =?utf-8?B?RGJyWXJkaWNlajBpY0hWWEFFYVdLQVVVYktjYi9UZ3p3b0JCT014Wnh5U28y?=
 =?utf-8?B?Z0FHVS9XdldiQlkxcnNxT2JUNHQxUGpWZXFrTHBqN0Fac245MEMrZ0FEZkQ1?=
 =?utf-8?B?MzAwTTA3Y3VCV1c1djRSOC8yNXRjYUZXUTliem9aTEhCcmZzZnVDTGhBaytW?=
 =?utf-8?B?ZkJQd0Y2dHN2VnpyZmtzKytSMUlHcUIvdTNlU1AxY2s3WmplVlhXSUxaWDVs?=
 =?utf-8?B?ZjhUTzZVYjNRd2FaRk9SR3NBZm9hcGpJK1JtT0lTejRWTE1oUEtVSVZZbk5R?=
 =?utf-8?B?YXNtb2NGQkZYZmVGV0JpOGZCSDRLV3ZFK1Vyazd0cGw1WHI2SFgyc1dBeG5y?=
 =?utf-8?B?Z1VvWWFNejZKZ3BrNUxydktWRzRqdnpwZ0xVbTdZVnpDNVhNL1hrZEt4K1Rr?=
 =?utf-8?B?L1RIdHhyaHpoQVVDTjhqUEt1TUVDREpnalQvUmtDK0hUamJGNGFPVk9ma2Rp?=
 =?utf-8?B?aU44UkpIempFbW8wTnR6YWozOTNtWllDekRqZVVLYkpYZEN5QUxmNHFXU2lz?=
 =?utf-8?B?aUt2ZUtCWG9TTUNyaTB5aUNSMzdERVlHSlVXeFFXdGlMUWFrR013aUc2VCtQ?=
 =?utf-8?B?MXU0Qmc3eE9sVWEzQmFUSHdYdFQzWVh6dndhczFrVERlVzA2cVc4dU83d3VL?=
 =?utf-8?B?Lzg2V252bkFZSWVIVkxiY0s0cDlLVXpKeXkwaWJjaTM0dDBlc09JNTc2SS9r?=
 =?utf-8?B?bjVuS1Y0NjBJTlNuKzE5Tk9wRVdvanhOTXloWk81SFpMNnlhQjN1NHoxVXlJ?=
 =?utf-8?B?aFIzN2hWc1lLbkdJZ1V2SlVWUmZtSXJiRG1sUjlRVkFIcno2am05akhLNEYr?=
 =?utf-8?B?UWNCM0dCWTRzV2ZmWXdkRUdaZlRzeDNRdW8rK0FlR0RyR3MwdFNUMzBmTy9H?=
 =?utf-8?B?VVNmWlJsa2VXSktjL2k4ZktCejU0OE41OXNrMEJvdWEvZ2lnc1hheC9Xa05j?=
 =?utf-8?B?YWVkZWNOSVlyZWkyQzJ2eGZGQXpMWVFlbUQ4QmluTkdFdFR4bTdSbjJOWVBU?=
 =?utf-8?B?WHVKWW92cytMYkZDNHFMcGxZZVNhSkdxTmk0VVRXblNNV0JQT3p3MmFGbC90?=
 =?utf-8?B?VVdpT08rYnRCLzdFbCsrWXcvV1NFbWVzMm8weUpjQXNZYVkyd2JZVWE3eld0?=
 =?utf-8?B?UjVGNTBsNUxTWjZUYmpkdng4MHViTENDakhuVjhtaTBnNWxWWnZvWFJaUDZK?=
 =?utf-8?B?RmFIa2Z5RXgxZ2w4NmxwTWk5UWE2WVNpQ0pJVjJSZExiVVRZeThjS1RyeG5T?=
 =?utf-8?B?Umxmb0ZpSHNIakFLdHY4UjYvMDE5bGY5N2ZBS2xqNHNSK1pxdDlhaGg2eFQ3?=
 =?utf-8?Q?ktvB0fom8rA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtUNWw0eUYvMVNkT05sSWxNbEhkWWk3ZmRWTklaanhDQ0NYakdSUFdNbms5?=
 =?utf-8?B?QUd0WHdzS2JENlFROTFQd04rTkRzMDFxa0JabmhweVo2TkNHbndnaHovclh0?=
 =?utf-8?B?YlMrbm4ybC9QZWtVMHA1dUV3NDlXTWprWTZNVlBPdDgyYzdXQzFydTd2RzFI?=
 =?utf-8?B?WDQ4NjZIK0dSVlg1SllaYWtrSi9RUEFlL1hOanlNczNqSHNmbk5WN2pPOERQ?=
 =?utf-8?B?YTNBVkxIR05vSnlNVGl2aXlJVFFBa1FsZlhQMWg4aWo4S0FKUGxIWnd0RXVq?=
 =?utf-8?B?c1V3YXVNbkdYTGdGVVBTOE5LVmJnakhiQWVURW1rblIvNGFwdkVUNG1JcUty?=
 =?utf-8?B?b3pkR0twQWxLREVMUVUzdEovSXdoR08zaVNBdzBHTzFBY21JNXlPb3lzSlBs?=
 =?utf-8?B?bHkrWS9STnlBRDBBci9wMnFKSDVCV1ZLd2o5MFRodVNxV0pTU2QzeWZISWIz?=
 =?utf-8?B?QlFTaE9pS1RMSEppVGVEWTNRZ2pvYTlzenlBUlhCYnBsbFFjS3NqRWdManBV?=
 =?utf-8?B?dndqaFRyaVZCSFBrK3lxQmFNbEJrc3k2OFZJQjBOOHZlTDVhdnVHRmlsYnNQ?=
 =?utf-8?B?S1pHcStFOW5UZ3gxdTdxR2VPa3FLV2xzQ3g4a3VoMnY1dFJua3Q4Z2thc1pq?=
 =?utf-8?B?U2JJRDFKVzFyUEFnelN6TlBUVTV6Q3JFaVFGNWlaRTNnUW9aTmthZnBVdmpT?=
 =?utf-8?B?enk1ZGJ5eVhTK2Rrdm5hajBhZWxaVWtOWUZHbnRaVy9aL1FOV29JUEN5Y3ZE?=
 =?utf-8?B?QzBreDlvVXE2aTJjTkh6cWtoSUpQMjJRWnZGZkJxKzNtRjdMZXo4MUtsMlky?=
 =?utf-8?B?MVB5b3dmNDFIZCtvcnovODZOVVBoNldHTm5VUjlBM25WWXRYSWUwbS80SStB?=
 =?utf-8?B?enF3WlhZakVlcG5vcGZ6b0xSWkg1WG50bXo1NVNvd1hMNXdScUVqQVg1ZUZs?=
 =?utf-8?B?UnRhSW0xVERwQ1hFYjNMbG5GbXAwZkIwNGQrTm5VWnFtYW13V2FZcjhPTi9p?=
 =?utf-8?B?YXk5MnhVT0JOc2pDWXUvUWRCNFlzUjQ3SEU5VVR5Y25PdVhYcTUxMWkvNmlz?=
 =?utf-8?B?enhteTFId2ZaeWdhb2xGK08wc3BSQVplUmxMOFd3MkhjcjFHWUkxZlBTS1FQ?=
 =?utf-8?B?V1pDbCtJZHdLajJhTVlzQjN5bjBFUWVlRHQ1aGpGRW5DM2FZcTFmUjV3TEQz?=
 =?utf-8?B?VFdGVlFxd0ZQU0tzME9rczRjNm4zV2VZUHJmOEs3TFM2dHArcGVoQTlEeTBy?=
 =?utf-8?B?a1NwZXpsY3NHOUpGeTYwb2pXdGxDUWxSRWJPQ1RaekdBT0VKR2Ivc1c4UEJh?=
 =?utf-8?B?TlBZZm1STjZPUWhlcklSYjBpZ2FYdTcxTGR0WmZ0T2lsVmdmNVhpUWxjMk1r?=
 =?utf-8?B?NlJTeTk1MEtud01xVmtPTWZIRXpJSkFmd1MraU0xR0Z5KzJ0WFZyZXd1MThP?=
 =?utf-8?B?NG5QZVF5V0taT3c3TWhBV3lsR2l1d014Z2tzbDA5aUE5Q0FIR3d6bUlYd0Z2?=
 =?utf-8?B?Nm9laitVQmZkeHpQUFI2M25NdVc4MGZyK1dleG0vNjMvcjJzT3RWQUJ6Ukw2?=
 =?utf-8?B?SmE5aWJvd1Jvdlp3S3BPTXp2aG9pUUs0YlM5cXJ0T3RsT0I5eXE5ZmxCakZZ?=
 =?utf-8?B?UlU2SFlRNStqcE5UUlFlMHI3Z0xjeFIrSE9hcFlMd09zRFhOdnE4VEs0eFMw?=
 =?utf-8?B?eWJDL0pBbHNyK3R1eFp6RlFaWHVmOFNjSmozcnFlc0FSVmVVQ1JNMzFLV1dT?=
 =?utf-8?B?ZDNRbmhEdXhJTmRBaWU1dFBVL2hRd283Rm9sRmd3TSs3ZDUyVVVUY25xWGo1?=
 =?utf-8?B?K25yaERhblJDTXRtWExyZkhPUVQ2ZFF6aExnRllYMno4UVpYV2RnWUNFZklE?=
 =?utf-8?B?YkV2KzhvcVBTZmY3SW9kV2EzUEVieVZSdExNY1BObkdsQXdDTGRsS0NBaXha?=
 =?utf-8?B?UWZ1WjNJWDYySDBjS1hiNHVpTWNiclZWWEw3UE9xZCt0TUhONjcvNGI2RzhD?=
 =?utf-8?B?TUpMMCsreGhIUVJ5VFJMM0RMTXgzYlh4V25xcWRJeklFMm9UZjd1YlE0MkRD?=
 =?utf-8?B?TGlVSUVlcU50YlNkSmJyeDJoa01KZ3RLZk82OGRENUJlTkNVUlR5cWlyeDRm?=
 =?utf-8?Q?kS7YZ5qwU0d1rznLg6hvJGt8a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fe2e43-804d-488b-7f78-08dd8d953e76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 18:30:29.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGDqDYLRL/Hl5DKOHnt+hBMaK+1UP1qCrr4ybk6cSnYCMnMJG9i5uvBHcE47TDF7nXDdGfCzcdV5QU+eBrPoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741



On 5/7/2025 11:28 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Sent: 23 April 2025 17:45
>> To: Terry Bowman <terry.bowman@amd.com>
>> Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> pci@vger.kernel.org; nifan.cxl@gmail.com; dave@stgolabs.net;
>> dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com;
>> dan.j.williams@intel.com; bhelgaas@google.com; mahesh@linux.ibm.com;
>> ira.weiny@intel.com; oohall@gmail.com; Benjamin.Cheatham@amd.com;
>> rrichter@amd.com; nathan.fontenot@amd.com;
>> Smita.KoralahalliChannabasappa@amd.com; lukas@wunner.de;
>> ming.li@zohomail.com; PradeepVineshReddy.Kodamati@amd.com; Shiju Jose
>> <shiju.jose@huawei.com>
>> Subject: Re: [PATCH v8 11/16] cxl/pci: Unifi CXL trace logging for CXL Endpoints
>> and CXL Ports
>>
>> On Wed, 26 Mar 2025 20:47:12 -0500
>> Terry Bowman <terry.bowman@amd.com> wrote:
>>
>> Unify.
>>
>>
>>> CXL currently has separate trace routines for CXL Port errors and CXL
>>> Endpoint errors. This is inconvnenient for the user because they must
>>> enable 2 sets of trace routines. Make updates to the trace logging
>>> such that a single trace routine logs both CXL Endpoint and CXL Port
>>> protocol errors.
>>>
>>> Also, CXL RAS errors are currently logged using the associated CXL
>>> port's name returned from devname(). They are typically named with
>>> 'port1', 'port2', etc. to indicate the hierarchial location in the CXL topology.
>>> But, this doesn't clearly indicate the CXL card or slot reporting the
>>> error.
>>>
>>> Update the logging to also log the corresponding PCIe devname. This
>>> will give a PCIe SBDF or ACPI object name (in case of CXL HB). This
>>> will provide details helping users understand which physical slot and
>>> card has the error.
>>>
>>> Below is example output after making these changes.
>>>
>>> Correctable error example output:
>>> cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0
>> (pci0000:0c) status='Received Error From Physical Layer'
>>> Uncorrectable error example output:
>>> cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0
>> (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory
>> Byte Enable Parity Error'
>>
>> I'm not sure the pcie parent is adding much... Why bother with that?
>>
>> Shiju, is this going to affect rasdaemon handling?
> Hi Jonathan,
>
> Yes. Renaming the existing fields in the trace events will result failure
> while parsing the fields in the rasdaemon.
>
>> I'd assume we can't just rename fields in the tracepoints and combining them
>> will also presumably make a mess?
>>
>> Jonathan
>>
> [...]
> Thanks,
> Shiju
>
Shiju and Jonathan,

I will remove the parent field.

-Terry

