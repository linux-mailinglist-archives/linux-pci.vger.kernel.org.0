Return-Path: <linux-pci+bounces-21332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CDA33728
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 06:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40DA3A7C27
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 05:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903392063E9;
	Thu, 13 Feb 2025 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYiUcWqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C723BE;
	Thu, 13 Feb 2025 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739423346; cv=fail; b=c1/biGawV0cgE9v+OdNeySeKDOHleQb40gs+NA0uauN4Rz3NKlSl1WCLCall4ZXFnGL4E+QobEO9lrWrNge37Zfd4fqTkl6myQCqnhMzB5vujogVQvDSA12n6RbVhnQI5v3biC0P9FBF+ck7vZ2OWLEqDWBNxcawQoP2v3hlV5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739423346; c=relaxed/simple;
	bh=YrdkVAvM3J+SrvjXJzrfamff4L9GRnYZjMF4gPFn2HU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIR8ZZ8thmH+SEo6zdVWZ5869BTKlFghEkO3kYGba3u0owrVyT64dnSSREwFNqdARvebCN+d93uc/yCsO1nhglboehJfp0EcRr0VR2Tktf1Exp4zeVC2J1qwOeQVvsKuoC65GMREhyBr9xUleCiZ3HBl1vLNdsnLpOLckJxiOJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYiUcWqh; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re/vQC+h4MIiQ6091kqb3Gt/GZbWfQrx+SMAKm92UuCfJKc7cfR/6ef67wJL5gTjd5hVDgGeFY9AjuEGk4sp4Zia1FBzwVjikRFZfuVeY42AayY5ODTssOArpYZSJnzpsl6xeSFQMUHGNTDx1ASaAzM/X+gZDrqzwAURdDK+weqclwxmywwvtRee4LL5xTc28/BdEXftIRQA31sMjxo/4fJ1hP05WrH24prwY8zkfSxhZtYxf+TZQmMP8mCkkJQeKcYa+d3Wk6T0otg+rubM3HXVvTYcaH1zT4VqW6WBjeCFh5LokvDk4EMflwRKeYLgYYl1qTehUGDNRnLbBE/zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0Hw7HkICeLnbCc/AQCtnBWsoK2KH+maEMTBGgh5xpY=;
 b=fJwM4T5uC8DaKg6tsZ9AfHQYlBIg3qf5HMgFRBhiAc39teK+o9naGPFV8yTFqkcYEgO1NY3C8XH/GB0rC5MWxZkHjEAZlBERivXMcrAxiYo1E9/80UVZMuSPml24xYW+PnzmHwLxX0MYP5FEUsH4PVpXKsYWd/oOChTiFSx4BerprtzUOX46bC2KZFc7hb8GBmPMySgUnkPsYuDW/0rjEGdl39r6N/Gb2Lmp/Ojl7C2DLYD3Bz7VJBF+RYcD6ucjOFKzqfkb/ulYAE1QK+9aavxblTlbsiClf/z2YWwlZLZymO86QANL70i6J3V/9hX+sVP2i3aVkttZD4sVo4AZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0Hw7HkICeLnbCc/AQCtnBWsoK2KH+maEMTBGgh5xpY=;
 b=XYiUcWqhSE9aIxoOhTNSMWataD1ks9cXYOcRtppGRBvx0v5kG2q0G7PbUN4q2Ib+AzSSWVcftlEG5HrHlBQOQu14/t8J9sp5LFFNdcE4VdtJQYJKz/Y/4GtMNTLEcb3M62s2u5zW7QQn98lnS2mOqcWZDD83Orj7J51zFrTFSy/XGz5N7mTxMKBCFEpSC33t5gTdRTPECRvNMMKFiePCGE4biGcs1oj5Ah1Hyd8KiiqTqDojcOTZgPHkGSLVI6viKw7Co+4PTSc5qxlXw+vZt6z1J5pefuLPa54s8PRj4xfQNrxuko7hFcLiHZxtj5HHrlT8GKvBrnOWQcMh++tDcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 05:09:02 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%4]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 05:09:02 +0000
Message-ID: <76f71dff-1009-4b83-bbc2-9465af0e0edd@nvidia.com>
Date: Thu, 13 Feb 2025 13:08:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Use downstream bridges for distributing resources
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: bhelgaas@google.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carol Soto <csoto@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Chris Chiu <chris.chiu@canonical.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20241204022457.51322-1-kaihengf@nvidia.com>
 <20241204054809.GD4955@black.fi.intel.com>
 <99a4ee84-e41d-472d-8935-8f2a2de837ec@nvidia.com>
 <aa6aea6a-c082-489f-84df-a1fe5686dee7@nvidia.com>
Content-Language: en-US
In-Reply-To: <aa6aea6a-c082-489f-84df-a1fe5686dee7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::19) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 454182a1-0526-4066-1787-08dd4bec87be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGJIenZQWEE2aExNdk9WTWRKbUpDSTBhQkF1RE5qQVBSejR1M2Y0VEdxOTFo?=
 =?utf-8?B?RFZWaGFKQWVTZGFSNG03M29QYWNTZys0UUNPc1MzSkthTHJpdUtidDVPZEpW?=
 =?utf-8?B?ZjVidWozTkJWb2gxbUlyNDdBaE1ySzJKRjZSTzloN0VNMy91RUx3RnpuaEM5?=
 =?utf-8?B?cCtBL295cVZoWjE0RXRweHYra2JrSGkzVE9jYUdZMTVXNGlpTTQ2VE1pUjdm?=
 =?utf-8?B?QzBXSDNTYnBUaWthdVphZUlZUldKTEg3Tng0N01NU1VJcXZHOENCUUdhc0tm?=
 =?utf-8?B?SnNWVHBGT2Y3MGRQN2FwUXBnRDBtOWtscFJTY2M0UUZWNGV1aUZEelIvN0t3?=
 =?utf-8?B?OENQUndhZ0RhTWJ6OVAvQXlCajh1OW9MQlNwWnZ3dDZqQlM2TlFDR1pUMlVM?=
 =?utf-8?B?bXR4U1NtM203NEFuZFEwODJPcmRrUmg3RnNpNkM4Q2lTWE5rdE8zT0hEZlNq?=
 =?utf-8?B?QmtmUG9yQ3ppVy9nZmZ2Mnl2M2dqTkdoU0xadlc1R2FGMGF4SHI1aEZLR3Na?=
 =?utf-8?B?MlRGWG8ySlYybHNwdFByZVFLdXoydjlrY2lqVTI2OXNpT3JwY29ISVM1R3o2?=
 =?utf-8?B?QVAwYVJPOVNGeVQrL1VNbXorSDJTNnZvdWJlR2dURWtycXE1YW16ZmxLQ08w?=
 =?utf-8?B?SXVna3pYOFF1UHNBcDJ6bW9GK001clZqcHVHclhsQUN1dkRnWll3c1BJU2NK?=
 =?utf-8?B?bUV5ekRlR2x0Z2UrOTh6cVVsUE5QNmVxTGx4OFRRME1YVDFKbzBTOGkrVVZN?=
 =?utf-8?B?SUkvdVIwZkhTeUd4QVVuamY5SDZjYzdrZ3ZIN1JEaS9mSVBuUnVGQXFzdVFG?=
 =?utf-8?B?UFBHeHhzZCs3K0ZEcTh0aitCYUNWcjQ1U0VxUEFYOWNGTEo3TXBZeVJORjhq?=
 =?utf-8?B?TUZQS2ZGOGRVd0VOV0tXd0NrZTZtYlluc3hNekJ6ejZ5ZWtjS29HcUtadUdM?=
 =?utf-8?B?RmZHTGhZc25uNFdYUGtrNW9sOEdCZmRZeXZ3QStWbDh1N1U1ajk2R1FQWUZ3?=
 =?utf-8?B?QnpoVVdtRHdqaDg1NmZTSHdxZTRmNWZjZU1xSG51UW8xZ2kzNTFnNTNROVFq?=
 =?utf-8?B?eTF0dENFT3NMRlNMTldrK2ZvRFUwM3Q3UHp0bGl3WmZBcmd3UVVQWW1qNkFx?=
 =?utf-8?B?cjFXM244dDd1c3NEVng2ZGQ1bjF5SzdkSU5SQnRwVWtNVVEvNm1DN1BBMGVw?=
 =?utf-8?B?ek9sbHZXUTV0emFnK3daNkJ4TElvQzJJUWFxaG96QXZORmdrR2QvdzVZLzRs?=
 =?utf-8?B?RC9sVERkV0Y0VDJUdk5HakFjNDkrRE5objZneStHaG4vdFdZZnRFQkVZWS9z?=
 =?utf-8?B?WFhGUXEwTEIxZFVKU0lyUGFaYzdDMjFlOEZtSlQwVmUvK09EbzZqenN6bVJj?=
 =?utf-8?B?ZnRSN1BhNm52azZ6bGF5WUNYaGdUSTFVN1gwSit4czh3QitsZ1YxRDRYVmZI?=
 =?utf-8?B?MCt4Yk90azhVb3hSQXRlYVZ2Zk10N2IybE80M21oOTlNcmFPWFZQdFNlLzIx?=
 =?utf-8?B?aHhHWVdwV0ppclI2MHZHbWg5NzRaMXNQZW01WG10eE9CUVVQY2RTWVRJYTlV?=
 =?utf-8?B?TjYwc0hESXFJSVlRRHNCSjZrckNkQ1NmUXJFRTRTSllIT0k2VjNVaC9yMXJt?=
 =?utf-8?B?K2VFN0hnQ2U4MHBlY21GYUlXMEE5SHFkd0dtZnJhNmw5bVhDR3BQZEJOS2x1?=
 =?utf-8?B?bzFOZktVaTcwZFZrNmF5VjJ2VHpXckVUcHEyQURkRHY4VFRCMEV1ZCtaeXFr?=
 =?utf-8?B?djFrR1Z2VlNmNjlOVU8rdndTbjc0SjBybGpxTW10R1JhSmpTVWlnMjlVVStF?=
 =?utf-8?B?NWJ6TWpnajVPRHFCaE02UW05VEd6eDJNUkVqVEVLaE1kcDN3cXhNTjBsNWVW?=
 =?utf-8?Q?Csx4HK6nYg/ds?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhGWXh1UUROSjdieGJmbkc2TTNvcU9HZG4vTjN4eWFDcWFFNDFmSCt0VzhZ?=
 =?utf-8?B?Qk52dHJ4OW5mV3FrcG5CTG92ZTZtSWVuZjhHRStLOExUbyt4WDNBdnAyb3Ru?=
 =?utf-8?B?SGloTktTOGhLRDRrNDRVcU1RbExvdmNHL0o4UGFjR2dodFA2Z043VXhtWHdz?=
 =?utf-8?B?bm56bFhFNjhkTmNPSVUvUEdsT01Ba2xtVkZ0cWNMa3R1TVFzVytnZ0ZzSTA2?=
 =?utf-8?B?Z2JZeFI3NllMcU1UVlNGc3RST0JEempCRGlUWDBVTUxEayt4Q3hERWhhdjFR?=
 =?utf-8?B?MmN0d29pSnZiam1XUGJXU0J1RXJYYVh5aXlaVjBMaTdOVVRmK3lPTVBPYWla?=
 =?utf-8?B?ekZvZzFQaHh2dFZvQ3g5V1BHcThEb0J0cGVpSnZjWTIySlR2bVNMVWZVcHkv?=
 =?utf-8?B?TW5oZWR4eFk5Sm5nNzFiT3psbk9RV2ZENkpvOUlYSlRCZUI2Ykdid0dCeUxs?=
 =?utf-8?B?MWEva2FkamcxRWVucndQL3VnUG9pcGdzbjU3UUtwWHZUcmxoOHQrME5kcm01?=
 =?utf-8?B?OWFTeGNnR21CVWJYdURBUk1CZjZsQkZTbW0yUG1UUzR0YlJxYmJRTGgvb0pH?=
 =?utf-8?B?aGkxa3YvQVhDQmQ4ZVpUWDEybHpuNjAzSTR6ajh5R05ReWExTnF3MjkvWEtH?=
 =?utf-8?B?aXhJeDNpdWRMcCt2UnFyc0dGVyt5bkVFWUZSUm9YdSswdU1SU01sRkxoYTJN?=
 =?utf-8?B?QTRYY2NXcW80dGlzVGpHOEgvcWNOcitkMTlubk9XVGNlRlJiSlcyUm0zOUxM?=
 =?utf-8?B?bmw0NnNGeW0zcFVQQmJ5dDZHRzFPdXR3NDhyUmRtemFnSm01Z1NhRmJIRXJ6?=
 =?utf-8?B?ZWJHa2Y5eU1qbFVNeVlvMG5mYy95OXRBQVlDdDUvQU9NeWRzR05KRmJod3Bt?=
 =?utf-8?B?dE4zM0lwZlhIMkVyNk5sd2FGMUl5amVFRmhHenREV0tLbTIwMk11L01Xbnp0?=
 =?utf-8?B?VzNvVTBFb1RzbEUva0Z1YjVBUlBPaktxWXQ3VVBoNHdMa1U5WFZFYTNVdE0z?=
 =?utf-8?B?d1RzTjJCK2xib0ZxZ3ZMa2VSclFKcWo4S3lVUkVtazQzcFZIa3U0UlJ3b2NW?=
 =?utf-8?B?UVU3eDdkeTZoc29Nd1JUTVVleTlvYWxObWtHcElKdzZSRGxMUGFmK1dlam52?=
 =?utf-8?B?TUJOWU1hNm9YSHVCL3dwUzJXSXBuNVlROENJMFNVa3RPMXBFOHgwQmVUb3J4?=
 =?utf-8?B?M2YvdHEyUnAwUEdxU1N6QWpVa3RDZG4rVGxBSi9nRUg3emhyY2lVU1I1eEF6?=
 =?utf-8?B?WEo1YnNlM1pla3p4dnZKYUlUcy8vWW1sZ2lzRktHNXAwOGZpNzU2Z1o0Q1V0?=
 =?utf-8?B?bXRHVmhGTGVXVGRzTXBkMEt2YXlOVEZmM2xjQTcyMnNXei9XZXdLRlQ1cGQr?=
 =?utf-8?B?b0d2UWRJTXo4d0FiZjhER2ZPdXNEQjk4YkpQZUJEQWc1Y2hrVVlnZjlyNEx1?=
 =?utf-8?B?L2pOVTdwV0d4UHBteHNXMmhCMVNyQlo1ek44cmxDeFY3ZjFUYzBsVDJNTGdT?=
 =?utf-8?B?MkdZK2Y1VW5CdHlzc0ZxTGVZMnJZbk81TnlVWVpqMHFFUnl1K3NCL0hueDFC?=
 =?utf-8?B?bXFqcXREVVk3UjFHa05EWTFKM0ZGdkFQTXZIUmwxZUpLcnovWDQxY3FIVDFF?=
 =?utf-8?B?U1hMak15NDc2bDFuSHVEZTUyL2h2eG4wdzhPbDJBaXhQTHNkTFgvOE41M0pa?=
 =?utf-8?B?WWFrMjI3bFZUZytycXQzZ1JuZkNxdDVmRTlHWTFFR2cwd1RDaXd4THIzYmNW?=
 =?utf-8?B?dzFPM2dhTTNQVnVwSGhtSUUwWEJoSmxBeEtNUHIzK00xNm8zNk45dFBwRmdv?=
 =?utf-8?B?QUNOL2ZiWlhRMzl3QVhlOHA1d1daaVUvVzZLVjhYZjJKVmZZOEoxRU5BajhR?=
 =?utf-8?B?NitnSjZFS1Vkd1FmZmNoTW1TUmhYQklsN1A1cFIxY3hsOXRYYUFZeHIzcEZF?=
 =?utf-8?B?aXN5Vit5dFkwOHFPRVYraDV2YWRzS2JKMTcyTk85dTh6allhRDd0TkJBZVo1?=
 =?utf-8?B?R2hXS0U0M25UUE1BUldaMEF4VlRZb203dWI2VFMwM21DcUZMZk5lRkxHbGF5?=
 =?utf-8?B?WUxGWXcvdElKSXNOQW5OZE9YcThueUJtbkJPY29mdWdZWlo1dVdyT1plbHlK?=
 =?utf-8?Q?faj9cfj8homUuRTUt2jB5gz7K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454182a1-0526-4066-1787-08dd4bec87be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:09:02.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adnexTRB2AC0teiQQpmDZCsCLPEV3ze6pupCLYd8McM2eTNNSpd5z5ipj1f4dNQtvv4zRiybBBkAzZaA9TurXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362



On 2025/1/20 2:39 PM, Kai-Heng Feng wrote:
> 
> 
> On 2024/12/18 7:12 PM, Kai-Heng Feng wrote:
>> Hi Bjorn,
>>
>> On 2024/12/4 1:48 PM, Mika Westerberg wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Dec 04, 2024 at 10:24:57AM +0800, Kai-Heng Feng wrote:
>>>> Commit 7180c1d08639 ("PCI: Distribute available resources for root
>>>> buses, too") breaks BAR assignment on some devcies:
>>>> [   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 
>>>> 64bit pref]: assigned
>>>> [   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 
>>>> 64bit pref]: assigned
>>>> [   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: 
>>>> can't assign; no space
>>>> [   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: 
>>>> failed to assign
>>>> [   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>>> can't assign; no space
>>>> [   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>>> failed to assign
>>>> [   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>>> can't assign; no space
>>>> [   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>>> failed to assign
>>>>
>>>> The apertures of domain 0006 before the commit:
>>>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>>>        6300c0000000-6300c8ffffff : PCI Bus 0006:03
>>>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>>>            6300c0000000-6300c1ffffff : mlx5_core
>>>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>>>            6300c2000000-6300c3ffffff : mlx5_core
>>>>          6300c4000000-6300c47fffff : 0006:03:00.2
>>>>          6300c4800000-6300c67fffff : 0006:03:00.0
>>>>          6300c6800000-6300c87fffff : 0006:03:00.1
>>>>        6300c9000000-6300c9bfffff : PCI Bus 0006:04
>>>>          6300c9000000-6300c9bfffff : PCI Bus 0006:05
>>>>            6300c9000000-6300c91fffff : PCI Bus 0006:06
>>>>            6300c9200000-6300c93fffff : PCI Bus 0006:07
>>>>            6300c9400000-6300c95fffff : PCI Bus 0006:08
>>>>            6300c9600000-6300c97fffff : PCI Bus 0006:09
>>>>
>>>> After the commit:
>>>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>>>        6300c0000000-6300c43fffff : PCI Bus 0006:03
>>>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>>>            6300c0000000-6300c1ffffff : mlx5_core
>>>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>>>            6300c2000000-6300c3ffffff : mlx5_core
>>>>        6300c4400000-6300c4dfffff : PCI Bus 0006:04
>>>>          6300c4400000-6300c4dfffff : PCI Bus 0006:05
>>>>            6300c4400000-6300c45fffff : PCI Bus 0006:06
>>>>            6300c4600000-6300c47fffff : PCI Bus 0006:07
>>>>            6300c4800000-6300c49fffff : PCI Bus 0006:08
>>>>            6300c4a00000-6300c4bfffff : PCI Bus 0006:09
>>>>
>>>> We can see that the window of 0006:03 gets shrunken too much and 0006:04
>>>> eats away the window for 0006:03:00.2.
>>>>
>>>> The offending commit distributes the upstream bridge's resources
>>>> multiple times to every downstream bridges, hence makes the aperture
>>>> smaller than desired because calculation of io_per_b, mmio_per_b and
>>>> mmio_pref_per_b becomes incorrect.
>>>>
>>>> Instead, distributing downstream bridges' own resources to resolve the
>>>> issue.
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
>>>> Cc: Carol Soto <csoto@nvidia.com>
>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Cc: Chris Chiu <chris.chiu@canonical.com>
>>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Is it possible to pickup this up in 6.13 window?
> 
> Now 6.14 window is open, is it possible to include this fix?

Another gentle ping...

> 
> Kai-Heng
> 
>>
>> Kai-Heng
> 


