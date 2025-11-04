Return-Path: <linux-pci+bounces-40297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E9C331CF
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 22:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3301918C0AAB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B22FABF7;
	Tue,  4 Nov 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gBDj/O9v"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DC34679A;
	Tue,  4 Nov 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293271; cv=fail; b=IkPY8s5ZCyw7r9I50nAVqTkXUfGKUHl14wNp2wmLQrihgo5FhnfK6+Omv3XFW7nIqn3d4nx3qfBQCL99TVOCLGeIc149VQgkDV9KkrHhKm4ifRBMD+tqBSneOSRv/4+Qpat57IP/VcB2t9zepdQB0d3N2jXeraKgTBnAmXpViwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293271; c=relaxed/simple;
	bh=S54Bdqq65xiygZV/kUh+cbG251G2zWuslA/97UVxgXA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b1TYQSNhDPvAbjsKZ5/iUtfWbUKzNBhHyhJ2E1zJY/rKza7PvQ4memSh55nxYfH7EXx9xaVksV8ab6LQy/pPsNg4HK/N9VquqtOrznVBai4lh8QxkQdPL1H3zMU5EkOIbE56CqkPogyCZmROWcYROmsNNNrp5y72gdf60ZerNtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gBDj/O9v; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSedZo+5Cs9sLkqbF+hCQDtVesK7gBbzeED4c6A9GTjLEBHlDiPZaEmyiS/pSH5KxHdgZhHqEiMlPQG9G3rOdnwl+AGX4s2VkXVGRtnl1dWv3zOf9xucNYcxNjdf4bTOx397/nyZVuQyuPMpUIngw7SY4A4zkKiF1VjV8bYhYnejBEIHArjlowc6BeIuPRVVNxTkd2twZHwr6Oxl8rckgy/cOpzsZXCVXfIEmJWj2MbcjlErdow4C6HUVIGAm4Vcemr5+Njfe2QI3JI2qdhboICQ25YPOL19v6pozxW71mg0lrUj8FHvOtZWXpwgZ0PGbCMPK/WZJg/BKrht5DZ14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mug8zRbYRi9LKF0VnehQ8zDP0kKyy5+g87TIoOR6N6A=;
 b=h0EriVMox9ZBwIwKYO9deRpl487UULBqwqhlzNC6g82zAsIU5fpaMlOI7zzYqFijA3IhvrSg6R/hwtE4+5wn5S5yCKTyDIoDVd5hrvuKAyzi3GVvOd/Y2K6kk5SVU0ddqadPQyGhKVWjz/deJk6MMHMA+6vLK2r2I5/htRkRgmMUSO9oijnLttWO+JDnO62U1QTgk2Fq+gsFSOD1YCD2p4jovFmx2TZFgDpMvtA44RouohvEBVaUKWgoJokrf40/f+eHRi7E4FRbzZwKLn1YIuQGfAXsCGlNVn3sMQSRb1sU82ldUcwUC0TD6gU0CITccEI5SMHcfpnZONIodUFEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mug8zRbYRi9LKF0VnehQ8zDP0kKyy5+g87TIoOR6N6A=;
 b=gBDj/O9vvrCKrBQXHcx6kvEZfdxtjJbOXbiDHEnRYqlmKclaoqhGj2+r4CTSn4Lp/VCixoik7JQVvnFpCiVsUrwZfLt0ZCL8fYdhUauWOmcejRfWqKieFBuHzx7O/OW5P1xuwlAvDl8GsL63WuB6dF7Tk/p8gwvXoCecB5+2bjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 21:54:25 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 21:54:25 +0000
Message-ID: <f601ff2f-cb1c-4cd1-983f-c344d05d34a6@amd.com>
Date: Tue, 4 Nov 2025 15:54:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 00/25] Enable CXL PCIe Port Protocol Error handling
 and logging
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, terry.bowman@amd.com
References: <20251104191140.GA1861840@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251104191140.GA1861840@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a3bb53-f50b-4d28-a97d-08de1becb895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTM4bnNPaWF6MTdxdU5vWkdDWDBxdU42OE10bWZPamdPNHIvalRheG1sMVJW?=
 =?utf-8?B?elRjR2tDR2pmT3NYSzEvMFFjVjZlM3c1eks3SUNCL3hzWEs4ZlpxUXRNZ1Uw?=
 =?utf-8?B?RXdPRElDeHk0dy9zNzZtT2E5UWJvaGM3WGUyQzFhOG42MlpLOFVSbzRwaThv?=
 =?utf-8?B?dW1CUm1rMlVQUmg4R1lPSVpXRnVhRmJzTG42bytkdG1pL2J1NVNNeTYvQk1h?=
 =?utf-8?B?VFJMazlSZnJpaW5tSlVVV1JUYUVFVjZwMXdKWUV4Y0cxQTkzTXV1L0phUTlE?=
 =?utf-8?B?SVpWYXAvSWxSNHMvQ2FYd00wMXo3aDNKN1ZGTHN0dkFpNHBJaytJVDdUR1dr?=
 =?utf-8?B?UHpnRit1OVRubmQ0QmNwU0FWSXNPTzdPbFd3VWNDMGFzVGZycm9jbHVuTjU0?=
 =?utf-8?B?Qks5T243SngwMiswVU5ZS0loRi9tSXBCVDhTdk5uZVpGbkFNZ3NiM2habWdn?=
 =?utf-8?B?NTNJM0JmbFB4WXlHQmdpM1psNnNEeFFmWElTd2NiQWc1UDkwalpLaENQUERs?=
 =?utf-8?B?NHNqVGxiU1JMd1M1TVJUTDdQTVVFRFJldU5sb3RWdytrTmZQQ05GMzVKV0VQ?=
 =?utf-8?B?VUJQTG5XVkRQRlV0Q3Vna1ozUTQrOStJUWxMZkVKRlJsTWI4YnV2Z2xwS1VR?=
 =?utf-8?B?N0JaSUhCRUdZN05yRU9obnFTamgzc0VLRkVYd2xKVUxidmZ0M3FWQzRpcUlp?=
 =?utf-8?B?UWc5OUVNN1NQMmJoMmRxMGl6UE1udG45eXExOWVuS2xGUmJySnpNSFlrc3Nw?=
 =?utf-8?B?T2hCamkydDJmdFRLNFJRZGRWcjlDcnFvRGJDb0lCeEt0UnBxdGdEZStYSXh5?=
 =?utf-8?B?VTlLWWg1SnlLRDF2Q21lb3pQTENXc1cvaW9vSGU4UlpRcGN2Z3BSUE9xNFVX?=
 =?utf-8?B?SVBQRyttK1VMOVpicnd6b0Ftd3Rudlo2WFUzN0xyaTlNZlJ6UWF1Ry9TaUFH?=
 =?utf-8?B?b0duaHlJeUhSVkIzdC8rdW1MSkpPK1Q1YjFQV1lHYnZpWDE5OFpVMTk5cWdC?=
 =?utf-8?B?RmRTbUtySjZYMTkxMmk4bE41MXA5YkZYQkJUNUJoSG9kOUV3dmhOV2NpQ2xM?=
 =?utf-8?B?bmtKZWZndDFrYzRJRi9RK1p6akhZTmJmWUlDeUxUVFNMejZWUTk4eUVVM3BE?=
 =?utf-8?B?VXdCQ2ZUTVVlOVo3bG5Jaks4UE53N0gzVFV4eEFHd0tvSEVLYnhsTThwT3pF?=
 =?utf-8?B?cHRJanJKelRJN21NSFYxTm5ISFcwbi9tMlMvTWlFVW1XbGI3Tlo1VzU2S1Z0?=
 =?utf-8?B?bEZmaW51blZwaWRjUDk0NmFENVkwSC9kWEY2dVpnTFFiMHFwdklwUi9iYS9H?=
 =?utf-8?B?ODRENHVXRGplS3F2TDhIVmIzVjdBQVluWStDYTJHMU5uUXcxQit3VHJnTXBk?=
 =?utf-8?B?Yllqd3JaZ0pLcDFjWWNPb2lMVGdSTFFhYkMrM1hvMHFWT1p4ZEl0SUV3b3dJ?=
 =?utf-8?B?U1FzU0dCd2ZMbDdDMCtXYzh2aUhnNXZJaVdDWUNIVWtrUkd4UVhLbExzTy9t?=
 =?utf-8?B?M2Zsd0hmdmdoKzZSaU9iYVg3dmZsMEtkcjFLdGd4QWJTdUk4MWVZZjNoZ1Y2?=
 =?utf-8?B?bXg0ZGxRQUpRSjB1bm04RUdhVC9RNjI3UXdWZW8zcmE3RVA0d3AwcWY4M216?=
 =?utf-8?B?dTJoODlpQ09oUyt6ZHB6bjliSjdCTEdRYk1XUWhKR3FyUHcxVzIrNkplalpM?=
 =?utf-8?B?bVptb05qZ1RjUGU4ZmdTdG1hZU5hMHduVDVHQm9vQk54YXBBMWZBc3hSQlJy?=
 =?utf-8?B?UTB3NWdqL2ZYeVVYa1FPMTJHTGZpa2phNW8vcUNBNE9UM0tSaitncUtTVTky?=
 =?utf-8?B?a1gwallYOVhncTdld0tmbkY2SlhLTmlXak5IVm1iNFpyUW9XYlo3Z2txSmV3?=
 =?utf-8?B?TU0yVUhYM29TM25oOXhid1JjMXFhZHdHZUdBaVZvc2sxaGhRYjg4MmU4U2w0?=
 =?utf-8?B?cE9KbExYdUtnd0VoVExLVmFDM3dJTTIyN3RJMzVHSHk2T0psS0tXZFkxM2Nh?=
 =?utf-8?B?UktHV09VU29BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0hHNEhXTXA0RUtUc3QybS8xbkd4YmZVeVVUQkNDRTJqdnpTS0hSWkVkaHhu?=
 =?utf-8?B?ZVFlM3pRYXJYSGtMMFVuZk9KWk5nTm52Vm1QeXNDZUVaMzRRblp5cFJSK01p?=
 =?utf-8?B?RzFycEVpeVZ6MW14UHZjTlEyZytaTSsxVUZSdk95UDIzeEtpZW1zT29LSlha?=
 =?utf-8?B?SFdKOENkaUI4ZFU3Z3JWT0xFTVRDOThSMEVlZmpHTS9oNTZNZW1BRDdySkhv?=
 =?utf-8?B?enNSeDdqTXB6ZDEvVERiM0NkMjBPTGJGMVJlQnpqd1NsQk05NFA2TlliSGxH?=
 =?utf-8?B?ZkUrMExZT1VDbi9uUTB0bUR3M3FITTJ6YWNybmZwMkRzbGkrK1YwSXNoSnVs?=
 =?utf-8?B?aWE3WHgvSWFiVjR5Z3d0Um03OUZKY1JwUDVOd0E0REp1YUF2YTFnRXFGWngw?=
 =?utf-8?B?ZUFVYkRvUlAxRUFjSXpHM0dYaTBwTE5LSGVCamk1dDNheS9WN0loN2VkNlh1?=
 =?utf-8?B?QU5tVUw1Sjd4THVoYWRzUjRQc294MWIwcWpyczA5eXJnMEdaNXBhZ2krVm5W?=
 =?utf-8?B?YkxoOFFXMU1hNFFoR3JNT1JGOWpFWStYQVN4YXVIR0RqZy80TTVOTFV3eEtz?=
 =?utf-8?B?VStjeEJTYkF3Qm9KN3hsWmRCUHBEalI4TmxDbFlucjE4MXZreldQczRFSHpv?=
 =?utf-8?B?OGFCeHBmb1lWT3d0d09VSGRSSDU1c1JpNVlMcHRBdkJaVERDNjM5SjRKcGxJ?=
 =?utf-8?B?RGFMOWVDZlVTUTlKZ3MrYVVEQXZDQjhUeHNoRjVVemJVU1o5R1RLbmEyVDJk?=
 =?utf-8?B?aTk1YXcwVDJRNFM4Rkp6UGFyLzJTS2tPc2R6VWRXT3FuOU9mYW5zRzUvTlJq?=
 =?utf-8?B?SElqQm1mRGpvU0t2aXZzZURKaGJsaXBWL0VORG95Z0Y4TkRiVTNmY3Vma0s3?=
 =?utf-8?B?MVNUQVVSSDVzUStXSmhJZWtzOFpqc3FWRXUxd3V4WXh0ZVdrNEMxd295UFBU?=
 =?utf-8?B?ZUlpSHlZc3RCKzlyTVJ6bEtwL1pmR0VuOEdGWklLTWNVSWs5UTJzVnRKUlkr?=
 =?utf-8?B?QzQwMHN1Z0FTTDNJZEJkL1JlM2QwbkQ3MW4yMW5OaW9WNVZJbmNKbFZaMHNI?=
 =?utf-8?B?Q3pEdEtMenJQUXJ2Rm5ubU1QNXZpQm90MHNkVUpjUGFjYW9GU2p6ZnRicTg1?=
 =?utf-8?B?Nnl6KzhZZFVMRHVUZTJuV2JwWmxzTjRDMFBSbzJKVHhEYkZRY3pPbGNMOGc0?=
 =?utf-8?B?aUFzb25rSFRrSVpxb0tHTnAyaXBlSU9adEZKWldSNldkRFJDcmNDSm9WZ0pa?=
 =?utf-8?B?M2o5UWdwYlRsUFZCMXhhQWcrbzh6Nlc3TEMxR1o3OEFBRU4vaTZZRlR4eEcw?=
 =?utf-8?B?STNhQUppSVdaeEhvdmJxZTRXRlVvMlROVGJ1TjhLMjhxMnp2VVFETUsxWURQ?=
 =?utf-8?B?SWJ3WnVZWklvSWNDcm8vbnoxWE01bGhuTFlEK3V1KzA2dVFNVmN0QlBRVUxN?=
 =?utf-8?B?YmJhMXUwNnpQbFg1R1FLMGc0Y2RJaUlSMFFDNEkwNzB4M1lESDV1eFQyaEJz?=
 =?utf-8?B?c2ZhVUpCVkVKVTRSWnllZk0xQ2oyODRUOW1RSmg2Z3VQanVBbVlvSmJIbnlx?=
 =?utf-8?B?clgvM1VuandWenNXZ29pMlRvVU81M0VYd1RDSVJ5QlhHZ3l4MTYrZ0RnRnln?=
 =?utf-8?B?RGNFZ0RiM3NMWUc0blBVcTJrMGl1SERuR0J5REl3TCtrazViWUhCaG1vd1Uy?=
 =?utf-8?B?SXUxUjFPQTAxR1JERllScU5TajFjdUUvZ3JnTkh5OUNnMitwWHlueEFiVUcv?=
 =?utf-8?B?SEZnYnNXQXdhV1VhUWdvdENGRThPeXU4Q1FlZjdCcE5VdUpmSm5hTDBYcTZG?=
 =?utf-8?B?MnFQMzgxbktFQ050UUN6WlpFcG10TldMVjBnUENhT1g5TjFYNlp5TXZKd3B5?=
 =?utf-8?B?aHhUbTErOVN1L2NlWE9OUGNlc2MxdnVnLzd1bjlZc2FpTjdSQVhDUUlsYlpW?=
 =?utf-8?B?MUJmTW14KzhialVpdW1uWjJLcnU5ZW5uSGJocUtkeGZ4WGxLK2Jyb3hWbzUy?=
 =?utf-8?B?NVYwMUtLWEtrSGRVd1g3RVVZS0NaM1FKOVdTMkZqZjExUFprZ1lzaUFzTnlo?=
 =?utf-8?B?aGlqMzdISDZSMGJTS28wS3BmUTRJV3NIVFRzWFdQS3hFeE9Mbm8wYTNpUmU1?=
 =?utf-8?Q?vJ9M41+TlQXdOidWO2fCdhNeQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a3bb53-f50b-4d28-a97d-08de1becb895
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 21:54:25.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21GJ5b/Flf+5xRCS2IOFmh3IsgiM+CXE0PQ28lNuSFrjy7YJyI7LqvC9+jt4cjrTsaGnV3VXhQpqOBj1NZ8aDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983



On 11/4/2025 1:11 PM, Bjorn Helgaas wrote:
> On Tue, Nov 04, 2025 at 11:02:40AM -0600, Terry Bowman wrote:
>> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
>> Endpoints (EP). Previous versions of this series can be found here:
>> https://lore.kernel.org/linux-cxl/20250925223440.3539069-1-terry.bowman@amd.com/
>> ...
>> Terry Bowman (24):
>>   CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
>>   PCI/CXL: Introduce pcie_is_cxl()
>>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
>>   cxl/pci: Remove unnecessary CXL RCH handling helper functions
>>   cxl: Move CXL driver's RCH error handling into core/ras_rch.c
>>   CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with
>>     guard() lock
>>   CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
>>   PCI/AER: Report CXL or PCIe bus error type in trace logging
>>   cxl/pci: Update RAS handler interfaces to also support CXL Ports
>>   cxl/pci: Log message if RAS registers are unmapped
>>   cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
>>   cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
>>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
>>   CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
>>   CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL
>>     errors
>>   cxl: Introduce cxl_pci_drv_bound() to check for bound driver
>>   cxl: Change CXL handlers to use guard() instead of scoped_guard()
>>   cxl/pci: Introduce CXL protocol error handlers for Endpoints
>>   CXL/PCI: Introduce CXL Port protocol error handlers
>>   PCI/AER: Dequeue forwarded CXL error
>>   CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
>>   CXL/PCI: Introduce CXL uncorrectable protocol error recovery
>>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
>>   CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
> Is the mix of "CXL/PCI" vs "cxl/pci" in the above telling me
> something, or should they all match?
>
> As a rule of thumb, I'm going to look at things that start with "PCI"
> and skip most of the rest on the assumption that the rest only have
> incidental effects on PCI.
I think there was logic behind the (un)capitalized but I forget the reasoning. It's 
better to keep it simple. I'll change to use PCI/CXL and AER/CXL.

Terry

