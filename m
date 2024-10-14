Return-Path: <linux-pci+bounces-14500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0599D59F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F191C2311B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E631AA7AB;
	Mon, 14 Oct 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cEAVo5Up"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C229A0;
	Mon, 14 Oct 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927230; cv=fail; b=sNVZtezH9iKan69MjMaB1ut/CUgxc+nVdgylTfSznn9/OjtAlsYCpgRn3kG3OnffCtG/yws3kad6g9LJ84+yy0aWXan7UBWFYLj7TpGB7ans5qTOwjwW0Tc6slc7FZwGDpbhcaavhrIzLA67pKpQG15IgjqEmb7IKMANy/qr5nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927230; c=relaxed/simple;
	bh=IOWiaKNmhgjZbprwVZkfyPiJHzV54wVUwY8DrhvNfNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rt4KjwQiyNVGz2AhwKfD26KMIE8MPM57a0QrA8Ij95K7Y0/pzYRHIBXzAHgDfCRQ/026jT4X5Z5LxK/rma7A6PDBANgny3R5eOWPRS2jjEnZajCyjnCJJ+ioi7pHmF+AzNiHtYR1X/tZHpBLR17FWDACk3lwyX6ZlbHNLbUr4bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cEAVo5Up; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+aadpL1kMs+1T9IIxEZ7g3iYD69/uTcf7jX+UjJuCvkryunPt7MjMpfoAiGqhN23qb46eIb9GWYTogqJgzrNfpysHsUxP6JmwBCeQSwwe0sGJXEPhLj7NbuWNQ+6ESHoLvWqFuz8Nf48W2d/w1jb3mHs1880lKBTdK6kMJzJ5+PYv+IBgbeYtMXZtFQ8/0ML1vbmmAZRoUzplIplnDhQmyk5BDLsrxCRyLgG6/BDqDjFPA9yDefRqagdjGukyuC7wIZ0Svd0hxgYxuFPdpkZ+oa9OGKUkaf0gFoEKlTKBk7gaNuaZvAvpoAZD4TVDZUKqPHER1FLim+Wer13+iNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xUIH/tZ7sBd64nODDdrfTJzm8M5jiAnJZbfdNqDSko=;
 b=qrM+QXCEYax80ChjdTZ2umDULgcOPadSlvlDJZYQok38ahfA4ojIvP4j1nYr3ESSDeesl3NrmslV4ZmNiHaHfatyxm35JR4ZRqc4JRfGHvug5hpl+YB9nncGsC5DD1m6To/Xvke1Lu9nXG06yDiV4BIprq2RD3Y83QGqxa2xpnKOWBxUM8fehpBggJLzG6+kkAFYWSLWaQ4BBVpQgUdlh2wnCHo0fVMcqmFppZeE+rPPpRPC/YEMLC6gkjbFgQDCWbWisiT/TRwLqwtZ8wox2jAK94gRc6TFvfmIEO2gOymvDnmaKzNusl/vprEzbl522kbQhrEpoIUU0TtEInPGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xUIH/tZ7sBd64nODDdrfTJzm8M5jiAnJZbfdNqDSko=;
 b=cEAVo5Upwj/ItPFmAmqDAcePXHv+TpHVCXKjlWHEjIavpkDrNnp2Nq2RxjUNAZvxQGVsySvGjIiSJVbTWwyaaxuk/jCRzUYx4r40VIH4HJGQrLZv0PimgHct0w1lGE99aREtNghdlEpEnvK5YP5XacVwG1y/n0SR97NPm8yR0/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Mon, 14 Oct 2024 17:33:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:33:46 +0000
Message-ID: <d9d87f72-6273-4adc-934c-e25ee79bb8c7@amd.com>
Date: Mon, 14 Oct 2024 12:33:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241014172930.GA612951@bhelgaas>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241014172930.GA612951@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f4c50c-ad25-461a-61f7-08dcec765b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTRKTUNRaCtDNnFBejhXdlRyaHRhWkVDd2FwakpuRzVrZGI4dk5xNEhjMFJO?=
 =?utf-8?B?b09jN2ZFelhlYlpSeVJHRTBwMG9HYkYyZnkzSExqL0M1cFlmZWhXWTZwSzIw?=
 =?utf-8?B?UUlVMk5GVEtDcmdidmg4d2NzQkpMa3VrRFlLRWlvRnhTTzFQZjZYbGRndGY5?=
 =?utf-8?B?aUJmRkg3blFGOTVvSTZ4UVRTemVrN0x1b1JmV05WZmhEY1J6ZWRac3U2UDgz?=
 =?utf-8?B?T0Z1dUZTRlhLT3FnRXU4ZVhHNlZvWm5sN1JXam11bFVWUWpldlI2b1E1U0ta?=
 =?utf-8?B?S3AwK21Md1ZGS1VsNmhaWmQxVG5CRUc1ZE90OUJOaG1NUTRtMGZEbkhYenFU?=
 =?utf-8?B?VmtzTnUwcmhjQzd2ZjRXZnlzUS9IbUxrVklaQ1NlSjYyazhHZUVSM05kRzRh?=
 =?utf-8?B?T0pTdU9JQVdDcGJuQU9FWmZzVlFnN044MWNmMGNkc05LcythNlMxRm9ONXg3?=
 =?utf-8?B?YldJRVNwNkJURUw4RDdUNFlsL01uSEFaRTNmWU9zTzhab1BwUkRVL0lZY0gy?=
 =?utf-8?B?ZUFldEE1VjJ4Wlp1ZjZYK2ZMTHZobEdCWnZtb1JVY2txcTIzQmNtZTRFRERM?=
 =?utf-8?B?RlVGdDVUejMyb0NqV0s4RTZRMG9STm9zN0Z1NUVSdnRhZWRHMjlNamFoKy9h?=
 =?utf-8?B?bldkditKbTNZc0t3Um45QW41Z0V6Mmc0OWIxVFJwT0tZWnJ1UzJyeDFBMkVq?=
 =?utf-8?B?cEtya3JyakFhMjRWeFVTYTFReU5IMUx2dXhFTUh1cWlrYkQ2ODloUUNNbVp6?=
 =?utf-8?B?QWVCd3pOTzdjNTZybTJiMGRjNDFRSWI0YkhyWjd6U0tuNHNvbnhmSWV6N0xL?=
 =?utf-8?B?VEVNZHdpdmtHWkdOLzlvS0ZvYy9zbFVIOGFCdHRCc0dJMXZqZFVZYzNMejlp?=
 =?utf-8?B?cUVmQWc5WmJYbHFOREt4NlVIWDRQdGlQTlNPS1d1cmNXRXpuUG1wWjhpcDV4?=
 =?utf-8?B?OWljYTNHc3FDZEhyZmRoQmxhR1UrVWY4d0ZCYkdmb2pDQmxwR2owV2V0Rk5u?=
 =?utf-8?B?dU9sQnNMWExjcy9yNDB6aWtKZllTMUlEYThMOVI3R29tQVExcUZMbFVyRENW?=
 =?utf-8?B?cmhWUndVRW5FVDdnRTY0SnQ5T2tXak5MZGNITHZVL3M4L2l0ZS8xbWJIWEVM?=
 =?utf-8?B?ak1nZGVqUFhaNzRxbllYVmlXZ2NJbVRkdENNNEtRWEVnRFhZTHNmZVdNRXlY?=
 =?utf-8?B?TC9wcnljWldJeG1BMlNoV2pzbW5IajRCbm1HRW9TclgxeGpQODNHcmt1SHZ0?=
 =?utf-8?B?azZSWnpMVEVEMzF4WFhOODhMd1FPaURkMHUxcS9xZHRtU3VRVmc1L1lKbGN0?=
 =?utf-8?B?cFVyRG5hc0V2MmdNMTVVNm01bHl1c1ZqMjh2aVhzS0hmTjZ4ZmpwMDBOTjFm?=
 =?utf-8?B?SWpBR0FzQXFGelhMU0NGUHYzb2VySTZnUFRzZ0wrSFRwVDROK1cwdU9ad1BE?=
 =?utf-8?B?K3ZLbEo5UmN0b25ybnpOU1pGSGRJRUZKdiszNzI4bGZZZVdtb1pwMEl6WHVP?=
 =?utf-8?B?R2NUSk5GYUF5NGNIM0hpVGpIc2VVb21KelhRRlNvME5xcERjc3ZPWkVoclM0?=
 =?utf-8?B?RTFoc1FsdTg4eHlrdlFQcUFqb3N2a0daa2VjRDA2VnVVUlJWVklucGtBWi9Y?=
 =?utf-8?B?ckU2MUQ5NzFsa2YyRW5Vb2hCU3UrclZJQmxDd280NGRVU2JVOElKVWxqSWs1?=
 =?utf-8?B?bS9PTGRMb1QrSUcreGQrTzdtUWJOdGhXMzkxR2dWY213QmhMREJRMDRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0xaVGxKNnhkYmtlaEMyTWM0SVRnOFBDS1puamdIL1VlNFdqNklGWHpZQXlQ?=
 =?utf-8?B?TFkreWhGUEVpZkxyRGU5TWJGdkFkNWZlVU1TMU5Lengya3h6M0Jyc0EwbEZs?=
 =?utf-8?B?RUVQQXQ5WDZFUTZiMDZKSUcva2w3UmRtRThqcGRXckNBdmxCUGNQTzRtZXdC?=
 =?utf-8?B?SmpacVIrSVBEc2FzRlBKRUVzSHUzdnBKMXZkZnA1NmxoajFMUDZPa2pMTnM1?=
 =?utf-8?B?cXpzbkdidFM5OFMwY2dzb1RtVERIdkkvODBRVHdCd0w3V1JFN05HdVBrZ1Z1?=
 =?utf-8?B?QWlrOS9SV3lUanE1YlpWUHdMZXQ1ZTNQQUc3bm5RVVE0WVYwV2RGL0p5TmVp?=
 =?utf-8?B?T09DSmhqL2hvV3o5RXVKblU4Y0tRTlNLdm95RnU4R3ZQa2pyWFplUVBkdm4v?=
 =?utf-8?B?QkNOTkI1WWpEcWphT1Y1d1VLR3hlNU40d2cxTEYvMDFkRE5GUmg0Q0NUMEx3?=
 =?utf-8?B?ZEwrV3dSOStCaEd6NGR0dmFZUzhHOE5ZdWFWSmMrYit1Mmxvam1kbCtyeFls?=
 =?utf-8?B?YVNJNWZseUVKNENQcnExcXBEcjdPSktjUEdCNXZYaXBsMVJFODJVRE1wNzBs?=
 =?utf-8?B?empNd3pkS25OY2xMTkJDa1BiRERmWHdKQ0hpN2VKS0pnL1NxdGFmV3hURVB3?=
 =?utf-8?B?SmprYU5vVVVMUzZ4d1JBaC8rbHJ2b2t5Y3lFbGJZVFJnWDNQV0JKRXF5eWtw?=
 =?utf-8?B?dGw4K1c3VHhqK1NMQUY4UDJjbFpTTUVocXBzTFBZbUk0a09aS2kxS254UHNk?=
 =?utf-8?B?dmkrc1pvT2xPSTJjWStYV2J5MmRGZ1hMZk01SUcwS1NmejlRZ2tEdHBuTnJ2?=
 =?utf-8?B?UzVidmsrczk3THJ3cmNzZVFwK3dvR2VNcGpJWHBFYUpIMVZkOEZWQThVeURu?=
 =?utf-8?B?NVNFVkFvZEdDQkdSSlBLZkxtVTFXNG1jd0VCV0pJQU5paUVlUDUxZzZvc2hF?=
 =?utf-8?B?RHJMbTZSRFhjYTlUL1hUYUU0TUpyOFVENytUdVoxcElNRXNmSFFqMHdGek9y?=
 =?utf-8?B?VlpMRlgrU2dNRC9GUUplNEU1SjJldm9HZldEZlIvMmh0WkNzNndXNCszeU1Y?=
 =?utf-8?B?bm5qSmp1VnNDU1VpU2xFeGVyVW15STlrbk1YSkFjWkJWbENmTU13ZnRKMG8z?=
 =?utf-8?B?ZDltQXk4N3c1T2tOMmZmNE41bzZCQnRYSy9xV1BBNFllTi81U2RFaTA2S09M?=
 =?utf-8?B?UWtpY1JnMitmM3d1dUNqaUhiY2tsUWhIZ09pendzUDBKMUVnZ3pEYW5oVjB6?=
 =?utf-8?B?UGxPRFZTR29SOTlRWnoyNVdCZEFHQitPejYrS3pMUWY2OEtCSU1LSzVHZzVE?=
 =?utf-8?B?ZHJsNjZ2ZG5PU1UyNDM5WG9YVXE0SmJPcTNZNWlwaXUwbUxhWGhic0x0THQ4?=
 =?utf-8?B?azBqQ0lxZGh2ait1Z2hhMyszMUZQMGdDWlc2Q2dOQnlkV0o3NEpBZkhjL1NJ?=
 =?utf-8?B?KzZMSHVvcGxHem1QWnU5RmRRa3R2V0doZldQbFk3T0VkMEoyNjFpZnhEYjhT?=
 =?utf-8?B?ZlF1ZFQwT1VZcCtrSWhJb2lhbWtiWEFscWgydlBkT2VOd25WT2k0RDdYMGc5?=
 =?utf-8?B?bUlkSjRmTVFBM0cvaGxkemtqZktLa1NmZUYxY29ENnc4ZXFoVlE3V2FjOW1C?=
 =?utf-8?B?Z2dmbHl1WEo1ZTNtdUJlQlNlMk5tR1ZJS0lCUkJuNkw4Sm5UZXAvb3JLWE1j?=
 =?utf-8?B?QmVLM0RBVkNUdmpvWFFHSElrbW9DWC9SV2Q4NHk0UkI5aXhxRGlLVGdYbHFP?=
 =?utf-8?B?NlNGdXI5M2wzYU1DSjJGV2F3Qm4yVTFMd0xHTkJvcGlnaTk1VndYYjdwb0NJ?=
 =?utf-8?B?NkEyZ1ViMWtVaExuYWRSYkdxUTFEbEpaM25YbUhzWUJEMEJJN3I3N3VaNVhl?=
 =?utf-8?B?VVdCMFdqV1BObTRDOHMybU5ROU5rcWppYThMV1puMmlpQTB5NXAzc1NlWEtt?=
 =?utf-8?B?emZyNkk4ejBoeFhqNDdkY2lJY3ZXcVh3WW1COUFkSWZOL2VsbzQ5SmhWRGhC?=
 =?utf-8?B?dXRzUVUrb1JTT2Q2czV3WmcxMHZiZUlCNEhGV3lmVHF3T1dUU0ZNalFpQ0ZK?=
 =?utf-8?B?am42UTlKTk5keVFkd3BMNWhHb1J4cjFWNGZJc3FnM2JvQ2I3elFSak5Rdnls?=
 =?utf-8?Q?AzsvTwQiU++rhn/TRzZZmRFmn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f4c50c-ad25-461a-61f7-08dcec765b3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:33:46.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLPxfpCpaYTX04kYqfaEpuQMcNwz6TwgRpSDD9Sl4E14mclrNlmBJDDyBVQ8v37z0VTnNIa/26mdX0mUr2U6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927



On 10/14/24 12:29, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 12:22:08PM -0500, Terry Bowman wrote:
>> On 10/10/24 14:07, Bjorn Helgaas wrote:
>>> On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
>>>> This is a continuation of the CXL port error handling RFC from earlier.[1]
>>>> The RFC resulted in the decision to add CXL PCIe port error handling to
>>>> the existing RCH downstream port handling. This patchset adds the CXL PCIe
>>>> port handling and logging.
>> ...
> 
>>>>     Downstream switch port CE:
>>>>     root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
>>>>     [  177.114442] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
>>>>     [  177.115602] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
>>>>     [  177.116973] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>>>>     [  177.117985] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
>>>>     [  177.118809] pcieport 0000:0e:00.0:    [14] CorrIntErr
>>>>     [  177.119521] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>>>>     [  177.119521]
>>>>     [  177.122037] cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'
>>>
>>> Thanks for the hints about how to test this; it's helpful to have
>>> those in the email archives.  Remove the timestamps and non-relevant
>>> call trace entries unless they add useful information.  AFAICT they're
>>> just distractions in this case.
>>
>> I'll remove the test logging and details from the cover sheet. I'm
>> unable to find how to attach using git tools. Instead of an
>> atatachment, I can locate the log files and details on a public
>> github. Let me know if this is not acceptable.
> 
> It's fine to keep this in the cover sheet, and I'd rather have it
> there, where lore will archive it reliably forever, than to have a
> pointer to some other github that may eventually disappear even though
> it's public today.
> 
> I just meant to remove irrelevant information like the timestamps.
> 
> Bjorn

Ok, I'll cleanup and leave here. Thanks.

Regards,
Terry

