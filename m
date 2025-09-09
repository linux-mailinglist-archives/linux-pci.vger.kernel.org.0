Return-Path: <linux-pci+bounces-35710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8509B49EC2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 03:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1CF3AF213
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 01:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0672634;
	Tue,  9 Sep 2025 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QlDiV5Zf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840A20A5E5
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381723; cv=fail; b=tb/pHYh3qnj3dKcSMciMVSZERecLgN+4p48kUmrDGplV9wg0dC9asos2RVwa+zdJAPOyjBcRnPqJlvVb8HCAxukpsP412m8J0/yvGGXjUcDTw2Y4X9XDQ5hRuzDo52sb4qJIuqlXMqKeOYX9L9fzgn00SQQLwklJJirrq+Ai2+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381723; c=relaxed/simple;
	bh=X+D6BWJF0Ld20x+p8cp+LJMWlCN2j9K7olTxuXUsmTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4XRTreRh83HNQPcecJPxt7izm9SPxaX+WfIWoOQxm7ECnQOza7okNLLeEFOjNj8HMiw04RIcAGUa8+FX8OeeEsKnbxDiQbbzSJBfdm6DsiyWZbqHemzYD3bpqxoJUrLxK4LUdGAhjW0k0IH2dU6Pk26WQCt1JNFwPZlNHm8h20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QlDiV5Zf; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T20k19+xAObW2jqdGFjSWC+iAChPQK4/qF+H2eP9QfFIBmhw3c9QX4wBLZwdphvtCjVWsEZQCqyOdKafZ3WDONdxPJxHc3F2rveYKOmomlSczXBeLE5Q7V4F9tNxzu+yckvcKUDkUi2qBzgQ3onXaTpVPVa9BS/R+9duOJzWv2LJeZEo5hcfzAOqWfDW7o+IgXb+jBAccTt2IOv/Y1e87hHhsN8byX33ZB3WZvetLD6jLocnzx20eVpcpWEKoOyrVile+bXcfWj3f1sspitxripPz2Er+FwBhvyuRU7nzEJ7JCSFwFdYbSeJEzsNlfnWUn76TxsS/fIXL6VTPVpw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFONaEhslQDm4rnJ08M8CxSunnXolYI+EAnrx4TbJlw=;
 b=q2cd2HO5ZS0500MH4uy4q3UAuVAqj7IX1ni0lmLPwWABCGHFmA1mqkHXTOlp+fDspD/ghhcit5nMOzPQaQebuBaraHSNNJXdbQQaiKLpw8Jg4i9DOpgjqchQs6Ril1lRIRWEgWZCwsNX6wdTqTz7ecGXndP/ORnQxe6hzq/6BAPQHzlzXhNeJhd4Cg2isGPa6wVkr0xPdRcz+hT+WBbtrkc50TewLA+5n1Xgr2WvMY7wMhsUBLZTTiCWIoEAXGXViwPqBoMsw72/oqZ7bqdyGS+QPRfNb4cCmtVObGv28kuSii+sX5NJnC/T21nljN7jAglpeilBLrRA8Wwkj9s0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFONaEhslQDm4rnJ08M8CxSunnXolYI+EAnrx4TbJlw=;
 b=QlDiV5ZfcJ7ThaVHibedKA+2IwiDVVB+uW6swttY1AVkaFh04j1zy+7DEdQM7SXw49z9gBxyY+Cmik2Ccz5lAtRIhdj2122nSQqnB7UQpEMi1siBl+HKMDJDiK0zfmRsvyVPOhiLyrxvBwdmZNBkWP8USc25tvuMCNnT44flV5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 01:35:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 01:35:17 +0000
Message-ID: <c920fde0-0241-4ca2-a75f-384f6f18a255@amd.com>
Date: Tue, 9 Sep 2025 11:35:09 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
 <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
 <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
 <68bb97518dea6_75db10067@dwillia2-mobl4.notmuch>
 <70c5399e-debc-48ed-a60b-e1921c111690@amd.com>
 <68bf77c923ff4_75e31005a@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68bf77c923ff4_75e31005a@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e99f3d4-c18a-4e5d-f897-08ddef412164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGRQa21wQjVFb3Jpc052WGNaNnRFMm5kZGFkWGtNRHNIS2hBVktMbEFZblpU?=
 =?utf-8?B?ZzVIdjNyejB3QzI3MmlIbitaeStHS3gzZFRnV24ySG00NDQrSUZyajkyWHQ4?=
 =?utf-8?B?UTNXeVp1a21vb1g5TDZhdkVxNUowbjFXNmpxRkdabUNPcUtMb21BeW9qM1NV?=
 =?utf-8?B?T25meGNiTERIRjZ0eTdCUndtU0ZsbFgwdDFRUXJTZDhIaHE0S3ZCcXUrTjB4?=
 =?utf-8?B?d2Myb0JTQmJyQjFrZkIzaFkrYmZ0WDBkTEhObFhjbElxYnIxUisxWDJFd05C?=
 =?utf-8?B?MlphaXFxYURUTTRxN08xc1lGSlZESzZmTDRyS2UwWTVYb09iaG5GZ3RXSmtx?=
 =?utf-8?B?QmhVYjZmQVlhQ3NaMFFoa3ZpenJPSFp4VGViWW42SlQwU1pvN2UwZ2xyRDFK?=
 =?utf-8?B?UE1BWjlLeUh0VDNmVjN1b1R6MmNZclJyQ2c2WHM3aTVwM3BlYlIycmk4eEQ5?=
 =?utf-8?B?R0xqQUtwRjVTWStHNTJWZVJpWlcwRGN6MDNkY04wbDhpV1VPS3NLd1VLZTdL?=
 =?utf-8?B?cGFkVkE5eDlGUWtteUNGWmVXb0EwZHRVSGljNHQ2Q0FkN3pxZWZtcURJL05Y?=
 =?utf-8?B?eVpaajErZlhURHVqWjcrbklVZkNiZVJjSWpOSTBONi9wVkFtK0JVUGU4VnNG?=
 =?utf-8?B?b3FXSnRYQjB5akhuejNxYW5QU1JSZkxBYzJRYXQ4U2F4TFRTaURXUndvSity?=
 =?utf-8?B?clNwOTdERnNQWXR6T1d6UnZOU1JwMTNFMnpCSWl1LzM4UUQ0dzJ6Q1VMK1U4?=
 =?utf-8?B?YmN4MGtjWG9uZTJoOUtpRVhzRmV4Z284bnJYUm5OeU5oRUxzc2VFUXR2bmZy?=
 =?utf-8?B?M2JpUmFpZCt0dzA0d2ZDNWQrNmhyQlcxVHJoN1loWFg0U2VJWktxbXMvTzEr?=
 =?utf-8?B?ZWIrRVI4VFV0dlR0Zm1BM3ZVRkFvUTh2aTNWNnJjREl2OTdaY1lsd0ZtVysr?=
 =?utf-8?B?MTczN1huWk40U1pySm9lbllraHJNRWREQUhDWStTYVRkWFY1ajEzd1N3RFZQ?=
 =?utf-8?B?NDl5c2EvN214Q053alFLOGZHMlFYcUUwazUxQmFpZWRBQXVhNmMydTNDaU5z?=
 =?utf-8?B?ZkF0dXJuUiswUnVtMzNaR3pkaTNjTlowb3lyOER4eVNUeFluWVhoYWtWa3JB?=
 =?utf-8?B?LzBDY2lKTnhBTjB5NkN2M0IrU2ZldzU5cms2UEQ0c3MzK294REEvV2lveFhq?=
 =?utf-8?B?Q3VacXVIY2lLWEJqY0JLR21Tc0JraGtCRndIbG9TNHdlb3ZZY3QyRFNNNEJF?=
 =?utf-8?B?Qi9PVkFxWkNZZnFhQmtEUnBaU1ZidVhUTEtVUnQrWkFNL0VKNDFVNFpZNGNU?=
 =?utf-8?B?VnVJSWNFM3pteUYzYm13S2pnck1kMDlWN29vU1JRZTZEUjlLenR1ZzdEVkFk?=
 =?utf-8?B?eHZIMG1KTVdDcDg2UGRpTytrOVJMcTlJVTBZakFvSFhnanhQZXcvbjRBMVVa?=
 =?utf-8?B?RWR1ZFZjMmxvKzhYd0dMMGpZRm82bkJvRlJ6UXZnK2REY0gvbkRoRUJxMlcz?=
 =?utf-8?B?Tk5YMmtlUkxlY00zdWpWMy9DRDVhb0poaTVqM01YTUJhckR1OEZURDFHTGFW?=
 =?utf-8?B?OFdDL01HclpuVklHMHphZERsSmlKeEdCZHBhUXh4L05WajR2alBYMXgyVDVo?=
 =?utf-8?B?UlBDOEpZQU5pQzlqUi9ZdktPemVRKzlveTc0ZEc1Tm5qdWdnQzN1VnJqNHpP?=
 =?utf-8?B?ZncrdnBvY0tyWTkyUTExQXQ2VHErZm92bm9PaEtoSHMxZnVQaGNMN0szd2xj?=
 =?utf-8?B?d0t2a2tLNWJWcW4zRDZqV0ZmNVR4NEcvVWVJSUx5WTVOdTdISEtnOWxrVUZn?=
 =?utf-8?B?N2tDQm5VbUU4eXNwc1BqU2dHSXdJQkEwdTJqbGhLbmtxc0VuVW5FL0F3R0c1?=
 =?utf-8?B?REZvZGhNV0dCTDVxM1d2VjRod1NpeDZVN25XRFZKRzlVVmZHV0pnV0RuREMx?=
 =?utf-8?Q?PzANUP9WNTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTFtQWo0ZHNzaEo3dUNjT1VuQW1LeTQvZVcrN3RpVHBZa3pRSE5qS0x5OUF5?=
 =?utf-8?B?cXZTcTZoVnM4RXBaNWFRWGtiTlBwVVNxVklnNnNDN3oxS0pEQTNqdmxWNlNE?=
 =?utf-8?B?MDN4QXhuMlgraUhwaFhRUy9tVSsxcUJpUjFHcitkWkVBcGJOQUJPTFFvTFMy?=
 =?utf-8?B?M1VPWHJkWVFZUlU4TnFYM1F5VDErTE5PcTl4Mm9RdXJMYnBGZHh4Tlh1bGxR?=
 =?utf-8?B?a2tLK2hUcnM4bnBzK3ExK0VZWXZickJ3a1hEL2tWZDAyeXJGOGw0QkNadWtx?=
 =?utf-8?B?VStMWDdYcWg1OW5wYTIxQU5NUFpodVl2TXNjU1hBcWhlb1dzekd6UVNZY2hZ?=
 =?utf-8?B?bURnYjdpRllLcy9RVzB0RHBGZWFuSVIrd3VVUDhLeVBjd1ErcVZRVGZIdm1m?=
 =?utf-8?B?TUxWbHEybGNqanBReHlyY3hZZmFZMW9SMndHY2dUTUVQWHBldUJHZnR0MnpO?=
 =?utf-8?B?a1VhOGZKTFFtSHN2UTBKa1ZhMjNBeW9uSDFWZnEzbjlnVTdDN2NGSjRiMkFP?=
 =?utf-8?B?Wk5vd0lUOXVwc1JYNUFKOHcwOU9QR28wbEpzczZpQThPWW15cHNJRi90K1cx?=
 =?utf-8?B?cERDSGRRM3EzcmN2Y0YwWFBqT0hsT0dObG1QempzUUl3UjJCT2lQT2RxM0xr?=
 =?utf-8?B?YmpNbUpKelZiUWp1clp0M1JUSWY5d0tqN1I1dDRsOXZwRHZiTW84TEJIUTFz?=
 =?utf-8?B?V0tXNDRuemFxQ2FSa0hQVFNsbzZrbnJWcjB2VUc3TmdLSEpRK0FVVTlUaHhU?=
 =?utf-8?B?VkNsWW1yYktJZ0NTUERwRTFiTUtEalRnWlR6R1FhSE9qZWswTWFJSGVPejA1?=
 =?utf-8?B?cnhOWDlpVWFMRnpPeEVGMGU2a28zdUR3SHoxa2VQMkIyQk1xMlFVaE9IdG9h?=
 =?utf-8?B?NmZiU1dFWjNmRy83cUJ3dnlYVVdTRm5lZDVIWCtsVDBRUmdhQkpaN252Y3Iv?=
 =?utf-8?B?S0R6TU9BWEsvRzM0NVU3S0lZQklCMWRqUVhLM29ETkloZll0b005U3lLVUhM?=
 =?utf-8?B?NVRSSU9IaUFzcWl1K0xIMHNjN2c5TkVLcE1xS0JVdjYvSlVRZG9IYnJEQSs3?=
 =?utf-8?B?OUpWSkJXT3BJaHgrTG1IaEt0QkN1WVFvSEhHZUU5SURaVjhWUUhTVndhb0pH?=
 =?utf-8?B?eXkzME1LaFg4UWNrT3AvVjRNaTR1NXhnUlhLSlhLVGhpa3Ewc2lpeS9HZ1dD?=
 =?utf-8?B?MW9wMmJpZzZzS3UvdlNiSVN0MjZ0RC9VcTdKam91Nit6bFh2MkRRbkVZVnJG?=
 =?utf-8?B?ZVFIWGU5cU9XaEZkRVpVakVCMjlpbVRLR0ZMWFpTR0duOG9Oa2FFNHp3ay81?=
 =?utf-8?B?eGNtUGl1dnpQUGI1T2VCVUwrRGdtb3BreU5CbHhIdkpPSFNmSkVhZEZaVFNr?=
 =?utf-8?B?R2FaR3NrNlc1Vm5pMDlrekcvTXljUXVFMzR3b2oyNGw5NTc3NFhINTVDdGJ6?=
 =?utf-8?B?ZzF0eC8rWG1VYVVTc2hNVzdGYWxyNGFJWVFPdnYxWUZ2bzVlN0J2OFNFNnBK?=
 =?utf-8?B?RkhuR21Xc09vSVI0YktKb0l1NzRYckF2TlJqODcxUEdGeFRtNVVXem1DZElD?=
 =?utf-8?B?b21lcFZXZGIvbzZsOEx4M1RQVVB0dEhDV2w3Mmh1Ylo2UlI0SVVrQlovUzhv?=
 =?utf-8?B?dE1rQnpXbFBxcVJIUEtnYzNBa2xoY2RrUk1DSkpRSEpQdXJoVjBtTXN0R1Zq?=
 =?utf-8?B?cEdwYVR5TFdnaHdRWEhpR0ZVTWRCdEFvZmRQSGZEYThWS3c5cm9qMnBYajE3?=
 =?utf-8?B?THpFeWNHYnFOV2Fybmh4MFZFS1R6cmk2OTZrLytYQk8vV0VHalBIb2tSSVFn?=
 =?utf-8?B?ZGtGcE1xeFMxY01zNUlkV1R0K0dLNzBXcXVKZ2VhVGVaZnRXRUJpN29KZVB0?=
 =?utf-8?B?SlEzRUJSak5MR2NXR3FZelp0TTIzcjNodjlwOUZ0M0FicDFwWE9FcmtSSVpv?=
 =?utf-8?B?MmZ6Z1k3azJaVXZ5cHJqeHNYL0VJUmg2aFJYc1I3RE5nSHh2NXZLRnFiUHlS?=
 =?utf-8?B?ZkJpVHNNdWZheGd4NG9pYTMvemcwWTd4cDBjdjRrNmtGWEUwaGdyOGhBdVlu?=
 =?utf-8?B?ZEJHNXB5TWdQRnpCODBQcERrRUM0dWRxQ3cvQlZPTG56UVN4dGJ6MXBpenE4?=
 =?utf-8?Q?6qfmlWcI8IuRV5gfVvzHN8sOu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99f3d4-c18a-4e5d-f897-08ddef412164
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 01:35:17.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B5vGfV0AgxrJ6lHLd9J8oPwCsxJXajpCCpOJNCboxHLUHAnV0K4JTi+DaSH90KDIR56rcA8nIsLCGBJ+6ZPpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353



On 9/9/25 10:41, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>>> So PCI_EXP_DEVCAP_TEE means that there may be a DSM,
>>
>> This bit I am not sure about. A bit hard to believe that PF0 is always expected to support passing through to a CVM. Thanks,
> 
> I am losing track of your specific feedback, or what changes or being

I've reread the thread, I wrongly assumed "tee" is used to decide whether to show "connect" in sysfs or not. I guess I was a bit tired^woverwhelmed when I made that comment, my bad.


> suggested here is the summary of what the spec assumptions and what the
> core supports:
> 
> Spec assumptions:
> - DEVCAP_TEE on a physical function is independent of IDE cap

Right, I just want to make sure that PF0 that manages TEE VFs does not have to have the TEE bit itself.

> - SPDM for IDE and TDISP is only allowed on physical function 0
> 
> Implementation assumptions:
> - IDE without TDISP is a use case
> - TDISP without IDE is a per TSM-DSM pairing implementation decision
> - An upstream switch port DSM can manage downstream endpoints
> - Guest needs some indication that a PCI device can attempt to be
>    locked. Either device or VMM emulation can set DEVCAP_TEE for that
>    purpose.

All true. Thanks,


-- 
Alexey


