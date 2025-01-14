Return-Path: <linux-pci+bounces-19754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80244A1112C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E29D3A1720
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6371FC108;
	Tue, 14 Jan 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcY7ns6i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF71FAC25;
	Tue, 14 Jan 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882951; cv=fail; b=ByCLsBcZmvJWaJcwHto0T/V6Yz/97S5+rKz/pawZGOyRuhHp8i0LWPViEN8gEJSzeMB1HGocVem5lDWaCksA/MkajMm8gfDTocqVbUmPqaXPLvare5/g6yLlAaVnLkrMoU0cgtDoZA7/A5kfjopIgl76fVrTOfL4RLqrpY4kRgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882951; c=relaxed/simple;
	bh=wWvoxR/zdl0Amv6/Ki6Vu8hq2mn89c/oYEJgYfJMNrI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tRu5p0xFiTdq3bzreNu49TFBjDQK/y1HFeF1Y1eIyE93+8tCtiXai+QNmykCJfJpWLvlrISc7klK3Oj2dlloPrQ4nZ8NHigtzLteHnOP4S6S7e72Gz+8nFtMCrAiUPhpN1olIYF4HEEHDnuktUSs2ta6B6c0ULi6EdG9jN2oaUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcY7ns6i; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QulmgohUF7D18sr/Eul/fN50cb2Om2sOrpaq7aJF3ZH+VQszioQPbCPb57dxGrC4l1yHU0Y71XdrEVnwKapFxAOTr3WYmiwlARzM0oWry8ECGmSvphXJZNXAHodqNsGxiYKqXXHaJyl4+lFa0ui5l/MdZOHF5wcdJMdMtrdvchbCCzypuqhVmhH+fDc/i4G3ikS3aUDilkdwKtx0VIBiky3U5937LArw8dKVZiiK0SfN2nuLV2E3EMYmLnRO9Eqaqa3D+akOD+s7rJgi1Hk/r/rhtq5OLLMQoxQ0qSB+Ze03788p4VhzCcCWIOkRDyxbZOwj3bGAZWMDdY8F2uziNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHY6rgNSwHDLj3/i4rZts9us65vyV1PLKq9r44Ut0m8=;
 b=Mbj3XlglHeACKgey8DSHkZQXrx0uTZTUKP8mtVUe/zee3qUKviqmfR9+kl3AmSaTCiRc313aMT467+V79dezky99majIqqh22zT2eno4iOWUn/UsR0DMBsP1hNLnoJvybF1N1SFP/Ydp0NGdWxQrQlNiE1RV0HIX2k85FSwAZ3/sOUYTeNUmk5S9mhGCoMN6wtLJJxHWeSf3GEvJaXO2C29TZehsABM8Rutnzgz97E1Oss9ZviVo6Ii7EcC1ZvgZgUYvQiv+F9QFmUxblhp71r7YQ5MxynbkvyLmYPs/J1JreNByOwMBRpNFEvpiViNWpQpTTTB/X4zkLMfrP6I7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHY6rgNSwHDLj3/i4rZts9us65vyV1PLKq9r44Ut0m8=;
 b=gcY7ns6iI1xnhWcGEtr8iJhl5L7pBTvYUEli4pdy+gYiE4K4Jf+26tdLA3fOrO/A841NSiXL3xA+fnwZlNbC0qSrVM8dPjImHD5KPe7h+ZrOlP0guWJ5eAKamlXcCNRDpcDD0jcck2UxJcCe/QjuGoC51Y+nniLH7xSGbm+U+vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Tue, 14 Jan 2025 19:29:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 19:29:06 +0000
Message-ID: <708db61f-2a69-40a0-ab9a-0fdb889ff443@amd.com>
Date: Tue, 14 Jan 2025 13:29:02 -0600
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
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <cb087065-f2f3-481c-84cf-aca2c5fd5ac4@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: e1648d94-94aa-4797-b4f6-08dd34d1b5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEVQZi82Y2NTSnFFM2VwMHRuNUhmMGE0WnBjMm4vL29kekQ4Qlk0cmlzZHVG?=
 =?utf-8?B?aythSmlQWDZlYUNxZ1lTNUdJQ3Z6dmlHQmNyT3ppK2tPaUpneTFYQS82dGM0?=
 =?utf-8?B?eVNaUUIvckR2MVpwdDFFU1FTcGt0WGJaOEFHWGJtaVYxeE1LeEt3RkNRaElC?=
 =?utf-8?B?aXFpOWJmMGJXdlYvdzFPR3ZzZ2Q3K1d1ZFd6NDBVSFNuNVQra1Y3YjkxaVRw?=
 =?utf-8?B?Tmg4ZGpQV2srR0tTeFZFQmdaOHRra09VS2FLalJ3TVYycUUzUmFaMFRvVWF4?=
 =?utf-8?B?dVZoM0c1a1oyT0JJUWNrb25GSU1qTWZreHEzcXNDVlJOTFhGdFNNREV3TklV?=
 =?utf-8?B?bHd2VHBwVUo5YnBTNjhxUnJ0MGZxSTBlaEpyS0U1bU5BdXcwZTNyczBqTnpZ?=
 =?utf-8?B?MURZWXlFT2p6TExqRDNaa2lObDhvVU1hdk92RnFYY1ZvVlVOdHFwVDhxVURY?=
 =?utf-8?B?eWJ1QUMrd2Vra2cva0k5RnJSYlM3Q25pUGJBczRpalFmQ1ZmWkg3WWJtSmd6?=
 =?utf-8?B?TlNwTFNOSmxMeUR0VmY0RVFnNGFIUWkzREdvMHM1dGZVNlRtSGcyZ3krbjJn?=
 =?utf-8?B?WHdSUGR4R2hMRHZSNmpLeEhkZEJ3WVJFRlVPWjNnS0szQmtBa0pGVy9Bbnc3?=
 =?utf-8?B?bkcwOUVSMEpoTUNhRXVoY1JFRVA3ZnlhYUpXbktqMjJoZnNqaXdZM0hzemxk?=
 =?utf-8?B?NjhHbDNSL3Q2Q3h0S0E3QlV6ajkwSVY3YVIwU1NrTEhUS1VsdUlQSGNKQ21z?=
 =?utf-8?B?eEFwdXVmVno4dGhEcXpvOFFmdzdOS0lWMkRrOVZYYzBVc1JYTE9NZ1loKzVI?=
 =?utf-8?B?OUtUZEQ0dzZRVit1TkdYR1NTdmZHdW1GN2ZZSlJQbE5PWlBwOWRXeHBDZ05N?=
 =?utf-8?B?cUJ0a210cytUSXViSitsT1FiYWJIenpoRyt4Q04zdnNhd0pUOTRCbVJPNU5W?=
 =?utf-8?B?eXV4VWlxVHBzcW02REJMSGxUSXlDeDNJcWNQY2xQM2huOHBpTlYreGQ1ZjFx?=
 =?utf-8?B?elJ4RmhCRWFCa0NFNXRNYTdGNDVIdVpvOG5FbVd3eWpSK1VzcUJvZ0s5OWw4?=
 =?utf-8?B?cmFLZG9xU0Q3cUh2Ky9tSWJ5WGtvKzRWaTFLcVhJYnNPNkFhQUxQQ0Z2NFo0?=
 =?utf-8?B?bUN3MC9kbEx2Wk9ITHIyNlBBVjEvWldBSVFUY1Jxa2w5SkxrZzhDSW9oWjhX?=
 =?utf-8?B?WlRpSGxnQnVXV09pdzl0UFdXbDZtQlBkU0dCWlRtZFJFVUJmbzFBd0dCSndL?=
 =?utf-8?B?dHhsVUZXT0pVVHE3eENFd2orUG12WWUvWk5VcDN4NXJ1cmhieWs0bEVkbi92?=
 =?utf-8?B?UFNnaDUxQ0N3d0pTOVhMTjNRSFVka3Y0WUMwNzNvZndnanBlUEQza0VKTDhy?=
 =?utf-8?B?bTJsRHhzRWNBNXhRdjdPdTk2WFRzR2dXRWZUKzVtQ0tVMW01dEdVc3hhTktK?=
 =?utf-8?B?bHBtYW9JZFRLZ3BDWlV3Ykp6R09zdm9VY3V0Z05CUDd3TDJobHAvWktEbkVQ?=
 =?utf-8?B?ci9Ja1g2Tll5UXN4anUvNGEycGpWaFkyTVRvM1JORzhxKzJGS3hZOGhOMkdT?=
 =?utf-8?B?aEd3bVV5Zm05SGpqaXQ5UFpRTzEyd1NPVE9zcndCa1E4MmVsNnJzK01YOVBZ?=
 =?utf-8?B?NjdMT3gvZ3RCL0Fsejkrcml4eFhwUERoT1lnRDBKbWlYQTVLZTk5N1RlU0J3?=
 =?utf-8?B?MnMxNHN1MUs5Z2YzRXZQTHFObndpY2pkTk9XQ3pGRXQxV3VaWWdiWWQvSm1y?=
 =?utf-8?B?a3hkY1JQZ1FKZWJManU3SGhuUEhMOWJNTHF4OUhlbnYyY2paNENVSy80VEwz?=
 =?utf-8?B?WkJqQlFXZG0wTk9rbTB3TktYQkZJR3l1NHp2TkdHRU40cExPU0tTRk0vL0c5?=
 =?utf-8?B?TnhwSkcyS1pybXp0dGFVRXlFeW1zTGRESkN5ZXpYSEliSi83dFVHWUNXUHVS?=
 =?utf-8?Q?QVYHfkBPbVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnhiblJnMG1EOE0yck9YU21OOE1ncnNUSm9XaU5iMlRVSVppTkRsVXZBOGZ3?=
 =?utf-8?B?YWIyRDRLL1RjV2xyY2szYmxXckJicHQxdjg3Y1d1NldpSTNCcXRkSFV4MjhV?=
 =?utf-8?B?UHBpRHRMZ0R4N0RxSFBhZVZicVNsVWhkTXlPRE0rWUVGbTUxTWYvbldMdno5?=
 =?utf-8?B?N0ZuWExtZWJiU2Y4bm92YmprMWlIZlpBM2VyempxeGdEM0xEUWk5dXVQRm1V?=
 =?utf-8?B?TXpCbWVZc2diS1BJczhBa1dGVElzWmUyREJpYjkyS2h0SFhRZ3VIcDhVTEEr?=
 =?utf-8?B?aHM5a1VWaEVtRzJPSjdacGFLY1RtUGpiRFhFVUVFRnpVUDR5SFYwcVhzbXdx?=
 =?utf-8?B?dFNTREZjSkJVMnVKU2NwdjV2TUdQRUh3NXR3YnpSRzJiUkIrQ3lPZUdKY3Z0?=
 =?utf-8?B?VDJsd0JBdDNJZHUyanREWjdpQ2hsSDFXT2NVSTdhZWNEVVBZY0h1NEJKZ3VY?=
 =?utf-8?B?WEdDWWRQVFVORG9ZZmt0cW15RVR5eTVhRGFrQ1U0YlZHOTlrTk1VLy91YmVN?=
 =?utf-8?B?UW1pYmFsYWpPNk5ybG5kOTc0SGhNTmhsTDNQSUhNLzhhU0dlc3BYcHUwZ0lu?=
 =?utf-8?B?YUFUU2ZxSmU1NlNQT3VpUXdYaHRjcXMyM0lyL3NzbmxYNE1INk1JSFdiRW0w?=
 =?utf-8?B?YkxIckE2OFBGZ1dBMmhhWnR2UmtLcFVUZk1ueUVDTGkyWmUzNTQ1YkZ1aVNO?=
 =?utf-8?B?UWphL0JJUWdGa3pyTE1ZazlhTTVaeG9hK0xaZDlIRGZMRFRvRUdaV1NkZnV6?=
 =?utf-8?B?RjhUZ0cya2ZacXB6Qkh6eXlDbEt6c0JDUjRJWTNRbCtYak52V0N5TlBQb3hw?=
 =?utf-8?B?cXZYMEhSV2RwOEljU2VjMDFabEdsdVZtcW9pSDhrejkwMnhvM0dWNUh4cXZZ?=
 =?utf-8?B?QUlKalVtdm9uSnZJdFZ3ZTJWU1h2c0tTek9MUlRCU3pFTVZpWDkyaTB4U2FG?=
 =?utf-8?B?bEZQOE9EMnZmVnJTbHB2TmRERnYybHl6QU9TNjU5Vk1FN1h5Q3JaVndEQWUx?=
 =?utf-8?B?TnJsL0Rxb3dyTnhyQWFkdmRubTRscFcvQVVHeTBIR1Z5TCs3YU9acmhmRUdB?=
 =?utf-8?B?UFB6MDNnYS9wL2lrK24zcmN4SXRaNDRFdTdyd2YvVDFGLzh5U28zVzhCUElR?=
 =?utf-8?B?L1R2VDBRRWZrNFJTc3A1NUJCTHNocmRvYlRJdkpMdHJ0VW91Si8zS3gvbVE0?=
 =?utf-8?B?end3WU83MGo4a253aEZISTJnVEVMN3FJTUJnTmh4ektHM3Y1cFpCOFcwRkdk?=
 =?utf-8?B?bjJKSGNIOWpoMXlLaDgzTGNIMzR1NzRIcHlMREpnTlM5dXRpandWRUV3bUxV?=
 =?utf-8?B?UTdyUGlpajVtQUQzR2lXbWMzcCs5aW4yZnllL0E0UGkwZEVkUHNGeUJyMnVo?=
 =?utf-8?B?bGt0OTJWWlJJMlBvZHRaRnZ5eGoxZkxqMkF2UlR6WE5OOVJ6SDFpSjJESHRQ?=
 =?utf-8?B?Y29IK0ZwTmxQU090Szh0N1BUbXh1WGtlbVdEcnE1TEZQUnlXc2VRTEk0Wi9R?=
 =?utf-8?B?NWtvNlh6TGpqR1hjTTc3alYvb3U5MGpQbHVlTDNFQkwvNVMzWERGbjNGMlpr?=
 =?utf-8?B?ZnVMSUp1WmxSeFBjQ0hBMVRmbHVSMUIraS9VRUJCanFoc3FDOFRZT0U2ZEJm?=
 =?utf-8?B?clVPL1hjektUWTcvU1R2cHk5ZTFPRGgyMHFhQW1XYld2aWZLOFVqY1JjZlJL?=
 =?utf-8?B?U1RhOXMxdjE1d3BqcmZOZEMzV0JwNmlVdm5teHRRZXE3bnRFcHJWd2NHajc2?=
 =?utf-8?B?SElBbWRVcDlHUXlGL2RlM2xYc0FCVmg1bS9wNDZLY1R3c3VaekthNi8yRTFm?=
 =?utf-8?B?cHc0OTFmdEU2UUJWcWhPT2JFSStpTXhXOW5HalRxb0w2eUZzQ0hTclB3ZDkz?=
 =?utf-8?B?Z0lNenRaNTYvSmE3Ylh0RGxEdTdhL3pmalpibjRZMlNVZ3RlMWpUVVhSOU5R?=
 =?utf-8?B?d3VEeFFVTUk5UW9UNXFKZ3RPUkI2SWVGYzk2Umowd2RxcDdUUEdadTNKZDdr?=
 =?utf-8?B?bjJOa3hQT01ZeCtxekpvd3ZzYTBEQVFKNGJncjV1TTRaTllnVnNaOTdrdWFT?=
 =?utf-8?B?VjVtakpLSmdPVktwM3YvOVY4TmpMYTNjZTY0NGc3azRVdzNJSVg1Q3dEWkF2?=
 =?utf-8?Q?7kOZ/lXHLxE0N/UimIgzJ7PKF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1648d94-94aa-4797-b4f6-08dd34d1b5c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:29:06.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EMITTfTjbUcXTPzVcGMZcD3gB8Tr36y0HdERPcJ4nWbD1jrXK4g5rGPh4atgQL23K/LsUy8+kjAyzT3nZdvyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273



On 1/14/2025 12:54 AM, Li Ming wrote:
> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>> The AER service driver supports handling Downstream Port Protocol Errors in
>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>> mode.[1]
>>
>> CXL and PCIe Protocol Error handling have different requirements that
>> necessitate a separate handling path. The AER service driver may try to
>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>> suitable for CXL PCIe Port devices because of potential for system memory
>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>> Error handling does not panic the kernel in response to a UCE.
>>
>> Introduce a separate path for CXL Protocol Error handling in the AER
>> service driver. This will allow CXL Protocol Errors to use CXL specific
>> handling instead of PCIe handling. Add the CXL specific changes without
>> affecting or adding functionality in the PCIe handling.
>>
>> Make this update alongside the existing Downstream Port RCH error handling
>> logic, extending support to CXL PCIe Ports in VH mode.
>>
>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>> config. Update is_internal_error()'s function declaration such that it is
>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>> or disabled.
>>
>> The uncorrectable error (UCE) handling will be added in a future patch.
>>
>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>> Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index f8b3350fcbb4..62be599e3bee 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>  	return true;
>>  }
>>  
>> -#ifdef CONFIG_PCIEAER_CXL
>> +static bool is_internal_error(struct aer_err_info *info)
>> +{
>> +	if (info->severity == AER_CORRECTABLE)
>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>  
>> +	return info->status & PCI_ERR_UNC_INTN;
>> +}
>> +
>> +#ifdef CONFIG_PCIEAER_CXL
>>  /**
>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>   * @dev: pointer to the pcie_dev data structure
>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>  	return (pcie_ports_native || host->native_aer);
>>  }
>>  
>> -static bool is_internal_error(struct aer_err_info *info)
>> -{
>> -	if (info->severity == AER_CORRECTABLE)
>> -		return info->status & PCI_ERR_COR_INTERNAL;
>> -
>> -	return info->status & PCI_ERR_UNC_INTN;
>> -}
>> -
>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  
>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	/*
>> -	 * Internal errors of an RCEC indicate an AER error in an
>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>> -	 * device driver.
>> -	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    is_internal_error(info))
>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +
>> +	if (info->severity == AER_CORRECTABLE) {
>> +		struct pci_driver *pdrv = dev->driver;
>> +		int aer = dev->aer_cap;
>> +
>> +		if (aer)
>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>> +					       info->status);
>> +
>> +		if (pdrv && pdrv->cxl_err_handler &&
>> +		    pdrv->cxl_err_handler->cor_error_detected)
>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>
>> +		pcie_clear_device_status(dev);
>> +	}
>>  }
>>  
>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>  {
>>  	bool handles_cxl = false;
>>  
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    pcie_aer_is_native(dev))
>> +	if (!pcie_aer_is_native(dev))
>> +		return false;
>> +
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>> +	else
>> +		handles_cxl = pcie_is_cxl_port(dev);
> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>
> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>
>
> Ming

Hi Ming and Jonathan,

RCH AER & RCH RAS are currently logged by the CXL driver's RCH handlers.

If the recommended change is made then RCH RAS will not be logged and the
user would miss CXL details about the alternate protocol training failure.
Also, AER is not CXL required and as a result in some cases you would only
have the RCEC forwarded UIE/CIE message logged by the AER driver without
any other logging.

Is there value in *not* logging CXL RAS for errors on an untrained RCH
link? Isn't it more informative to log PCIe AER and CXL RAS in this case?

Regards,
Terry

>>  
>>  	return handles_cxl;
>>  }
>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>  				    struct aer_err_info *info) { }
>> +static bool handles_cxl_errors(struct pci_dev *dev)
>> +{
>> +	return false;
>> +}
>>  #endif
>>  
>>  /**
>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	cxl_handle_error(dev, info);
>> -	pci_aer_handle_error(dev, info);
>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>> +		cxl_handle_error(dev, info);
>> +	else
>> +		pci_aer_handle_error(dev, info);
>> +
>>  	pci_dev_put(dev);
>>  }
>>  
>


