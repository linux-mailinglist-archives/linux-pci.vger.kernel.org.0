Return-Path: <linux-pci+bounces-10747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D5793B7C7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 22:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C5C1F24F43
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6216167D83;
	Wed, 24 Jul 2024 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jzo9YyBB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526477F15;
	Wed, 24 Jul 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851748; cv=fail; b=AacCnWZ8ihS1zrACE/xB5oMl/gv3feVz9lAUoCYXCp1coAD5yKNlMIBBhH6pt6Q6KJVqbsyYp+L/5lfZTn3NC2yMdCxpKg/P78LSF2uGpYKH23P9aF+zHE4uRHaCOSKttvp0GsL2xvb2ZZwEmMi0wOSwk9rJ8JGIV/i+Bky+O2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851748; c=relaxed/simple;
	bh=RPbdkJcvKiZp0MkhXH3mfda98xffEchXP4UWnnDLY5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZaoH7pR/qjtjlvuO4ZLsQ72oh18iaOcQZkNnhknFlihY1t0UBZuenCxmyDgOuwlvd4se1sSx4NSKnbl5dCMXTQsYAUaDaW78T29C0lKXl2P23jVyPUzMEcbMsvqQd1FGRjcrPHFbjPHwJa+8SOkEZZKgW77krJ888BL6a35mfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jzo9YyBB; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPC2O/iBnkqpeyrFgJ9V3owcMcSMXJlhJfgw8mRZRaCTOyaWOxUZ5TkmGsBefqwd4JuT26kg10NOiYOZ6iVmnU0+0L2TRJHp1TCIrfn4Xb/LUB8C11vLPNvfNl7/E1Bk+CV0mVbB2AQyeStCS8lxN9vh6z2uVeGGUMUhgn/3ZS38blXN0FT8Rn0COBmVJP9dO6ji5/O0RNTa9YgTKTrKYsGc6WTYlwVYVOC5nertMsEXnLKqVTL3P29i1uPxfn1XbD+4OK57kHjYNaY46cMPLlvgpC74I04te6Vsq7/kZpT8HJ0FofXz8VYwz1EGrSO30dBMaCMil1x/c/WpVenIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USSKTJPhMM8kXGJMP47iJK45PpbW6W9vl116Kc9QRSA=;
 b=soWaMWwKiB85nYMTc3znMUxu7EBr37dWSVFMN73ti8a0tnMe56pmytWInWf0R4SZT15T5KpREc/aRQqZ72HH+kG+k4rd+vAH31b+mpZ0hN2U8ixGh9ZZ8OSTsj/zG38IbZMYNjkBCg4dNsRJcasDDtvgNCP9DAvCZgLUrHL74MQrNCAixdd9YE55brZDekDdDfLYmR1ufYBtR5sGCFe2cbyHn7A8xLnDa4JbQssky+Tx1ySCy2kfXgd5oFrsGDg3djtWdzCIY6N5x9tAxCYm5gqf/9qx0VWDdXWk8x/FnTi/qBDUFS9zIY1R4PphutZt6zu06RCuuKBEMD/WloPwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USSKTJPhMM8kXGJMP47iJK45PpbW6W9vl116Kc9QRSA=;
 b=jzo9YyBBhNKiere9//GcXLvOmp7zCwg51S0RHkxpGKMEIQ9GyeSWAxQXoiC9aZxCw7+AAKRIRJQpzXvQERw8FTPsHc2OtUP15hqLfMDvmsZxnpqRYv4LqFPtS7Sya4yREUOFGegamztugblDbirrc8rHNyJMps/jBp+rrTPKH3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 20:09:04 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7784.020; Wed, 24 Jul 2024
 20:09:04 +0000
Message-ID: <4304146d-9bcd-422f-b4dd-79b4a74329cb@amd.com>
Date: Wed, 24 Jul 2024 15:08:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alejandro Lucero Palau <alucerop@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com
References: <20240724153627.GA800043@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240724153627.GA800043@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b4f06c-aec3-4f20-d4ec-08dcac1c7764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2RUbDI4cG1KMXhtTCt3enpKTG1tRjE4NFVnMXAzRUkxdGdMaFVpTytwSG1X?=
 =?utf-8?B?L2Y3VDZ2a0xyc0pCSDhUdUFHSnZjd041WEdDZVloUWxheEZ4WngvMHU3cHFN?=
 =?utf-8?B?MHlBY0FiNml3RVJnTHVWOUs0T2M3R3h4V0l6OW01TWRIdmF5YVdpOENraEgr?=
 =?utf-8?B?UjdsM0sreVFZdzZKMGlySFByaU1WZGJ2Q2pGMUNxTzBBaGFFckpZejhOc1ln?=
 =?utf-8?B?Wk5BdVJyQmphR3hwc1NKTGhHQXduTU96OEQvRm5TZ3VjZWhwV1dHcDBGcWdX?=
 =?utf-8?B?MjdRdSsrVENhWTRsNk4xMEhkNTE1RUlDeEUvendyMnI3dTJqdkVuQXdqallF?=
 =?utf-8?B?eXJ4UGhLWFMxMkI1WHg0S0xWK1EzbG5MT1pFN0gwQ3lHQUZnb004MGFTeWtR?=
 =?utf-8?B?U1d5M1kxUElXbld6WThRcUdSbmR6QkZSYkxHM0JnZnlVZ2sxcUNmN1o3WkVS?=
 =?utf-8?B?YWRhQ2UvTDBVZGFqME9FaEx3NDZzeWE0SkwrVUFhRmpBMUhsTU9laVN5cG5Z?=
 =?utf-8?B?RVJBZ3dwYWJSWEw4Q2xMK2V4ek1XREFJN3JoRjNuYUx0aXhoVkRveUx1aGda?=
 =?utf-8?B?NHBkN0VHREJVeldYc0U4SmV3TlFrOGxQcnJFZkswS1lLQWgwa0FIRWUrSlpa?=
 =?utf-8?B?N1BLOUU4ZEZBc1ZCNVR6cXNjODA3QXZ5SjNpYkVQbFI2YkF0Ym05YVgrZ3F1?=
 =?utf-8?B?aFpManBmL2VFc2dkN1gzSEYvbWtKeWZCcXUvTksvclpaRmllWjdCRlNwOXlp?=
 =?utf-8?B?ZlhSMkFqY0prT0hQQ0lKNEFUb1JPZlp1eFM1a0tSbU5MZFo2RWE1eFB4T29j?=
 =?utf-8?B?V0h0SlJncmFVVU1iUG9xY3FMSFBEdVZmMUZkODlLdkNkMTk4alVreldXSWtm?=
 =?utf-8?B?UXBJSUlhK3QxY1U2NDRDbzhDMnlBb3pmeVJSQmJXOHJPVnJQOFlmb2hpOWsv?=
 =?utf-8?B?U01OR2ltSGEvY0kxcERjd3E2aGtuR3ZuOVFzWnE0WDdWRm9EdU44RDJBL0ox?=
 =?utf-8?B?WlJpMWhFTTFMaSsvdkJCWTZFZUJycXRYRmsvVmhrQzBLMHk2S3dzc0lIV0pm?=
 =?utf-8?B?Vnk3WS9FWWp0QmdtN0FJN2N5OE8rcHRhZWdDSU9kV0htQ2FoZDhUUS9wQktL?=
 =?utf-8?B?YWgzWWV2YitaWkQ4VXRSUzRJYlZVQ0dNUlFhRzMvK1pnQ1Q4UHFvUHNlUE9X?=
 =?utf-8?B?dXcwTFArSDNHa2NCQVFpK2NBS2NNdFhuRm1pWXF5blhTeEpKT0ZuMGp3S1BD?=
 =?utf-8?B?d0tndTRsS09uVjV2M0oremVhQUxxZWlnY3BBT3BydnBFWWtmQlBXSnNHa1BL?=
 =?utf-8?B?RkF2UFoyTjlJNXZLTWVpR1Z1UGptMWZKQVByM1doTCtDb3F4TlVNOVZIdkJR?=
 =?utf-8?B?SngxbUtFdU1pSXViaEtpR3F5UlNzZHEvUSs2cjdEUytOUnllZ3lPSjJDT0dC?=
 =?utf-8?B?ODBDWXNya2dzWi9JSVFadWloVFp2YnNIQjdUOFJxMWo0ZHhQc2Q0aXN5S1ZJ?=
 =?utf-8?B?Skp2d0p0WldxbysyTU0wRjZVSHg4dXVyTlVNUjZVaVBWNkJzb3NUbW00S1F6?=
 =?utf-8?B?dVV5OGNnY3Y3NVJHMSt3d2ViZGpjUFhRaFMzeitPOU9jbjFJL0MxMDFtNk9n?=
 =?utf-8?B?Zlp4d3ZMQUVObXl5SjJtUXlUWmpLUXQ4eEVSYTlIYWU2ODdtY3FnN3FmbS9P?=
 =?utf-8?B?Yzk2K0cyVEw2S1NZUmhERDNwTFUzTE5NMTV4YkV3aXB6bU9URG1OQTZCcTQz?=
 =?utf-8?B?d0F1NlJKMW1obWpsMytVUEV0WFB4OGlGTW1vNTkyaUVRK3RrL1FKN2pFWE5y?=
 =?utf-8?B?UlgwMi9iK2VkOU00WVhYQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmxwSlkyQkwzQjlDNXFteThwd3VPV0ZJWlJIVzNZOE45TVlOZGEzZkxNeTRN?=
 =?utf-8?B?YVRhL1E1dlJDanhPQ2xuOUtNb0NKUzRrdThZT2JZZEMvbkp2NjFIL0xRbnVU?=
 =?utf-8?B?dEpZUDVSS2V4SVZKb0FzSUlXSEFHZnlaSTJvVTUzcUMxaFVTU0VWa3NtVmQ3?=
 =?utf-8?B?WjlFMGtub25tV1U0NWVEY1ZtbHF0cmVwcVRBNFFSVEJyVktpU2hYTUhKbDlv?=
 =?utf-8?B?UHNJTG1ZMUZYbmxWWGltcDEvZy9WYjNZMzZuYjB6T1ZQUmY0TGNMUFF0WlRz?=
 =?utf-8?B?UVdiaHQ3Zk1yRXhZc24wSURrU2xRSTJQOGZjVVM0ZGhOWU1JN0hPck55aXJQ?=
 =?utf-8?B?TnNFTmhSbCtwc1d3RFdLbzVhS2p2TDFUL05lQ0VvNEZYanlvSGp1cFlKcnF4?=
 =?utf-8?B?MHNPZGFudkd4WUNuaC9NRTZaOEVCWXZ5Tmh1SFV3VTBFUktBNE5kYlN6aXFl?=
 =?utf-8?B?c1RZWTExdnhDdXJPQndRWTk0MnZnV2xVTEZiOHJyYjNlWnVkUmxPYWpoZzNG?=
 =?utf-8?B?WEkvd3FWbktCWk1SRFE5amozVXBnOGhiRG9GU3N6MHkrUDRFSUVxR3pSa3J4?=
 =?utf-8?B?OFYvbjRYZTdTRnFDV1d0Nm4rTW43SFBwOUVvbVc1OWl2ZE9LNHBvaFh4UXNn?=
 =?utf-8?B?QXpOWXFaUmpyUHcwV1F0MVdhZkhkTU9tSjdGZVJSRHBMaWVCeFNRaGNMYm9E?=
 =?utf-8?B?K1JKTHFYWGhFSEE0bnNsQ2RjTVltMjdRTG95VmFBZDVtSGdPbUh6RFdFMlR2?=
 =?utf-8?B?TThpdzVDVHVaQ0dlWU10VGh1eVZOczRFaWpMb2xCbDQzaDVZM0VPYlduOHF6?=
 =?utf-8?B?ZG9ZODZxRkxwVlZjaUZleHpkYXd2T043eTJVdS83VWVMZkFhays1OHpsNVRQ?=
 =?utf-8?B?ZlA1U3VWQ0NMbXIzeWNXeFBBTnhKRmt2dlgwNFI0ekFMVzNqRW02MTg4UXdT?=
 =?utf-8?B?OGVKa2dqekVzYzBJeWdVQkRFZEpsY0N3cTlJdndrLzNPQ1ZjQUkrTDQvVG02?=
 =?utf-8?B?ZTNYa3dHbFBSeWZRY3BPODdrSmZ6aUdHam1NS2U5eFFiVHBCQVVsTURSTVQ2?=
 =?utf-8?B?NnJrMUMvcGw3RTZRbjBYWTRTdjNwb0RQd2tOZkxtbFE3TUEySzJLZnlhbkpp?=
 =?utf-8?B?eWdiK2s3aXVCcWp2cVlwTks5cHNFOUtQczdXUzJkN2dRYUF3K0pDMUp1bUww?=
 =?utf-8?B?TXM0TGFmVFZkNDZEb1BVc1haQVIvaUt0bGJ6VWxxOGJLazlDekYxWkdQQkxV?=
 =?utf-8?B?NmpnbjlZM1lILzN0MFdmZW42NUlaUEpmK2lOMmNqTTh5blQ5OWh4Q0JCV3dp?=
 =?utf-8?B?dHdub1RJKzBTQ0RqQlVNaDcwemJDZzhCOUtFa2l1M2VoYU1yNUxaVmdTcDZh?=
 =?utf-8?B?ZzYxMGNOU2FLbEZFVk5ydVlxMkZWMVEyWGFaRGl3R1JPaTRFUXh1ekcrZ2Fa?=
 =?utf-8?B?OGN3SEwyUjlCN3BiazQ2L21TUnFVUzRVampBOXJJYTJLbERnYkk5UFc1YVRl?=
 =?utf-8?B?UHgvL3EvVUpBbnh0dEpLL25EVFRMdDlPMGR5bFQ1c2pDSXhadm9LV2d1Rzkv?=
 =?utf-8?B?UGhLZzJFUkpXZXJjQTYzNGZSQkFOQVFVdHpEMTVaUHNyWTlPTXNCTTJDeGJs?=
 =?utf-8?B?bHZtVU13U1BLdk04d2xYeVl4R1Q3NmFSUit2cHF1czhVaVVaMHh6N2JDanN4?=
 =?utf-8?B?WUlwK0VYenRXTDRTZVdGVkdOWUhjbFl6K2FqcGtpZXhHMk9LRU1YUkpWV2Uv?=
 =?utf-8?B?Nk1QV29BK2dVbzNzY3UvUDdMODV4NHRRVW5QMTJkYUlIV3Q5ZEsrY3R4MDh2?=
 =?utf-8?B?MVBYUHAzeHNGVzZTZHhqelE0ak5NU3RLbHZjTE12cG4vbEJLMTE1aHNua0w2?=
 =?utf-8?B?MWxoWmlwZm9McHdZRWJWa3dxcUxScjc3cXdnUXBoVVZkZjFaaGhKMFd1ejNW?=
 =?utf-8?B?Mlo0eVQvVTFIb0ZrZm1KVmx2UExtWEdRVUkxNHhZTG9FZlV2MUVwVExwVjQz?=
 =?utf-8?B?clR4R01VM3V1Y3Mrb2pCNEpUSXRqY2xzMGpOTEJDR0hyZm40MjJRQUdQOG9R?=
 =?utf-8?B?ZGRzbTk4bVpMNEkwUEE5dVRYTUdtQlR4V0lWaktDVjdkTXJpUUVDUTJMMjg1?=
 =?utf-8?Q?NmLg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b4f06c-aec3-4f20-d4ec-08dcac1c7764
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 20:09:04.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtsZk8jWxB7OXH6vSvOJQ2wt58Agth65y2ZN8TKhLxdmNlVjgryUmPF56xRWPQmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529



On 7/24/24 10:36, Bjorn Helgaas wrote:
> On Wed, Jul 24, 2024 at 03:45:34PM +0100, Alejandro Lucero Palau wrote:
>> On 7/17/24 21:55, Wei Huang wrote:
>>> TLP headers with incorrect steering tags (e.g. caused by buggy driver)
>>> can potentially cause issues when the system hardware consumes the tags.
>>> Provide a kernel option, with related helper functions, to completely
>>> prevent TPH from being enabled.
>>
>> Maybe rephrase it for including a potential buggy device, including the cpu.
>>
>> Also, what about handling this with a no-tph-allow device list instead of a
>> generic binary option for the whole system?
>>
>> Foreseeing some buggy or poor-performance implementations, or specific use
>> cases where it could be counterproductive, maybe supporting both options.
> 
> Makes sense if/when we need it.  IMO no point in adding an empty list
> of known-broken devices.

We can add quirks.c, or something similar later, after TPH support is
enabled.

