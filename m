Return-Path: <linux-pci+bounces-38455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FAEBE854A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B41835C718
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3722DF99;
	Fri, 17 Oct 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YV12dWiv"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018517B50F
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700694; cv=fail; b=R/u1OJ+97ifTA9OtPDcFGZG9AJnj79Qw8Oj1t5fzctWYci7CDM+UoARKaEeEZ4SVyNLq3M8fZV1HJOTA+iydIWkO1ybGVZwBspHbAvLfBmc7ENte1sRGW4u+50HLI6a8LWM7SrBSKtU1QCIBIV9uaTJz7Pu3aUaGsp+HlO2oRGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700694; c=relaxed/simple;
	bh=eSXJmfAZeX2UcKv0r7X7ZJvnmNqj4gk2QBgXAtNUG90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OsPBDYOlSBbDXD7F0TBw0P2aXGgHw1j8E0K3GOCYaKvHFCc7UkSFscL/f9jq62672qB7hpROZl/Ifam9Y63p70jbSivvSfgb9jd1ryZrrZeq/+UaPOk2tUH52TN/hOS6KFHJZc/cg+aCyZahCfD/Kv0J4o4M0YvjD4r+5FlV0tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YV12dWiv; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVL7DUgN4pOS9UxN5oWicz0tCncjyC73w5+Yi0oWErMhMN8d3wEn4a18CLvaPicPYaofpsDB9gDBxaeDWKqGFzNGPvjlaXxn9QcMYxw0Q9lV8KkNfA9DFOlRgYb/eb80ESxquLdUT6zAUb5myUiYt+uflfBxyT8i6TbKMnanZ8XS/R9QEX6OAmq+/UveMdFjxDn1+6TpbzGt+DvjPxx9WUOjTy1L20sP1eXssjR1YqWHBq1YVkxqunrfvS/mMVVHiZ3luxhS/eQssi2hPMXaMQVhOEKNplXp6/oSGyHT75TtwJvLxWyFzdafrdhPs0FN4UEPPTGPYLjUIRrHQpKjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Uo+uvSffdo68vVMRFT3LhFhHIV17nzh0dLz+arQquk=;
 b=I60tJcQmF3Baogb3M87DLeRH9R6S46p/EP4WasaY+45yJwIKKIN8dK59hkgV8sVnMhrVYZbnAq9VzocOAExoWI6npsIFMOkQmiDqK5WZFSllQeYna571dR/r88yAL1Pr86BuPvn76e9csKc7eBlpQ1lxje7P8XHYBvOyD+mv1frOKZU8yQUBByxeBUl02/P89M0DgoyzBNSrcDk3mGrNoBQQA5XRRzWngpEsk8dPFfCgWsyD99jwdDck/IdeHc2cUMoQHUzXoncpAOf5mGjpH6oXy3aPk2eFHkRv1+/C21G2IUpB5p+5WGWz5irzxH3wIKsYULTK87WAhLq7j2C98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Uo+uvSffdo68vVMRFT3LhFhHIV17nzh0dLz+arQquk=;
 b=YV12dWiv80YQM7WYyf3rnh+UmDpRfCO5WUsdHyR2PEkHCbvnLRaj9+k8osaATONdnoebxtR+zjJs8IXal4H8hxEcZsM5L2zodmCft++CXm0GZWa85A64fVICHIzOMOUIzQuw1cTT0kRXRKGtpFfLxPrSju6eJWDTrWI78XqkX1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 11:31:30 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 11:31:30 +0000
Message-ID: <43070157-cfc3-4ef2-8b2a-e677515e8bce@amd.com>
Date: Fri, 17 Oct 2025 22:31:12 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <68ba3c9f508ed_75e3100ef@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <68ba3c9f508ed_75e3100ef@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8P300CA0004.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::25) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: b96ff560-69a2-4b71-26a7-08de0d70b772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlBRZEt2bDdKNG9IRm10bWtKdmVoN3dET2laUU1sMnBOcHdPZm9oWkV5Y0dj?=
 =?utf-8?B?aDhpaGxQY2xWU3pwS0ZjZGk0eVNIWG8zYkVMcS92Y21WbkJjWHBGci9lbzBM?=
 =?utf-8?B?YklMOGpHRjlaVGx5NWdOSklpa2tKQ1Q0bnF3TEhoSVhqb1JZNnNGYUlpVjNL?=
 =?utf-8?B?dkszYWRyMkVyQTV1T2hiUUtOYStxVDIreGQ3ZTc3b1NDa3JxN2s1amlwNjkr?=
 =?utf-8?B?RVdQS2tDZUJQbVdmc1A0dHRyblNUVGhPN1hJWDVyR01mbHpObjhEQ0RnMHF6?=
 =?utf-8?B?dzJ6c2phYVVYUlJXUXJjSGxPRTYvRzQyN1J2WVRVOXo5RU9KclRWOEM0Q0w3?=
 =?utf-8?B?QzVUeHlvODU1TWN5cy80Wk5adW5acitXR0ZUWkJhM2pJeFFjYTNnMDFTaGtt?=
 =?utf-8?B?OCtZc01raDhKRThQcmhUMjBPYVBXbGw4WU9JSnBXSkpFaFJ0MUtTaVcrMldz?=
 =?utf-8?B?dmpHZjhlRTA5dFJQQUJaWWk0ODZUWENpRmVKc0lNdjlmeG5WbGduMlBXb0ZR?=
 =?utf-8?B?SGk4emlxb2U2cnB2a2srSTR6b25HUC9hbnY5dU81dWlJYXJ6VHZjYnpsRmhm?=
 =?utf-8?B?NFdXV2NreUk2dGYzVU53eVNBVFM1UWNrV2xpc0J1cEdOeHpaS1h5VEtSNlUv?=
 =?utf-8?B?OEUraENacXVsQ082SjJOazJTQ0VtcFY1M3ZCSVRyQ0hpcXVkY3Q1cVNxY2dS?=
 =?utf-8?B?U3kyK2tacnV1RmlvRlpBcVlzQzFKeTB1R25vZEZOMTlLaVVXMXd2YlplbW40?=
 =?utf-8?B?VnBEc2pjeHFxbnMzWFNtRkFFMkE5Vm9VS29lMWVNeTJiSnBreEsrZzVFMCsv?=
 =?utf-8?B?ODJrZDdnUUpoTzhrZ1h1emhybEdvYU8xZldFZXJuUmdoUTV4amJrNGtpR1V2?=
 =?utf-8?B?a0M2ZjNmb25LS1pRNFFlVUhDSFNYYkorQU85ZXA4UllRMCtWZzFjNUFZUnVY?=
 =?utf-8?B?Szl5NU90Mi84YjZNVHhIWk9UcG0xOXpDSGFpL0owNXpiRkp0dGF1TkZaWGxh?=
 =?utf-8?B?eUMvWC9lT1Fhdms0Nlh3Ky82ZVVGL0hvQUE2TWQwaE8reWxPNU9BUWdBNmlw?=
 =?utf-8?B?aVFvdGVJdTdzQjVTeGZXZE5VQ2xkQVNxNXA3OGxTbVltbXRld2tHM0lMeHNK?=
 =?utf-8?B?NGZzTHhaTG5BQzA5VlF4MnFMQVp2YUVlWUpncldGbm5nVWJtT1Njai8vQ3ZN?=
 =?utf-8?B?VTY0MENwK2FrQ1laYkgzSW56NERmUC9tUTQ1NFYvazd6KzJhWmZxYU5ZNEJo?=
 =?utf-8?B?dWZXbWJmZDhHbkdrcjE5aG91MFhkQ2lwUzlRWlJPRFR2RTFqZS91NEswem4y?=
 =?utf-8?B?ZzIvbEJRWmNNWlJVUHBrMUVNckIvVmlNMTB2ODFyRkc4elk1dmpTcThPY3V4?=
 =?utf-8?B?V2pIVFNidTNMTGFDaHFZMGJiSUFnT0dHY2Zqc3BWN3VvQWttYTZQOW9jRGdp?=
 =?utf-8?B?RC85RHcxb2pnVVAreVVFUlVRelowdWtCdzUyREdFVklMR0hLeUxZS0w0L045?=
 =?utf-8?B?NXhqK3VLR2JvV1lBeHcyS1ZDMG5hcVVMZnFVdXNSWFMrSW9ia2szSTU4VjZH?=
 =?utf-8?B?anBvSW03UDBka1RvNlJ3N3VUa0U3Tlg3bmJEcDBJTzFLRVBqbm5WMW9sOXRY?=
 =?utf-8?B?aWFtanoybzdISW0vUWwybVNKN29LTTRwd0IwUnFOSWViQXBoY3FFejVyWFJ3?=
 =?utf-8?B?SFQvY09Ua1hXdTAzazczRzN1cTBORHJvL0ROc3UwM0RTOG1hZEx5Rmx1d3gx?=
 =?utf-8?B?R3hybXM4dTRDOEJGUjNpYzRXd2k0dHA0RkJKQXg2Z2F3bXFKdmpSTUhNKzdR?=
 =?utf-8?B?QzY4dlM3Rlo3Y1VWWFVkaTRHTVBPeDdDSzlCeWhoU2FPb3F6NDRyd2ZRUjIw?=
 =?utf-8?B?d0dGcUZxYThHc1JJZ1ZRQ2FyWXlOOHNPcXB2ejBMZlJ4SjdlT3ZFOTJXNVBh?=
 =?utf-8?B?RDhUdjJIYW80aEoySHZPTng2akFhazNpOUlhdU5IK1did1RXajMxWEVYNVNR?=
 =?utf-8?B?WThRd0d1bG1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzR0ajNoa2xraUNncitqM1YrNkRTaVNkT3VIOFVQQ1QzS1FjMWxlUDRZSWY2?=
 =?utf-8?B?OHhjK0Z4c3VhQmVsOVE3dVEzdGpRUytyaXprL3hWenNJUHFXa0tYb2w2V3R4?=
 =?utf-8?B?NC9IRGtkMFBtb1FDOHhzUC85QjF4ZTBRU2g4MlJmVlBHWXhLWDZURjg4S1dB?=
 =?utf-8?B?ZGRzTVVJVTVtZy9EZVZkVzJqcWlwYVBrbUVKVVkwV0tjOTRmeXAwUVRvdklm?=
 =?utf-8?B?T3BSVlNic2s4NlBVVXk5eFJySGdsNjlUN2h1cWZsaitSYWpLYnhtZ1U0ZUpZ?=
 =?utf-8?B?NlcydExFRCtEdkJkVGRlVFZZTjVVK0RCSXh5ckNXdUNOdFVNRTdLbzV5YjJW?=
 =?utf-8?B?d2llb1NGT013NkpjaU01WnNvaDZhbzRndUdxK3llM3JTVjdxd1ExUkg0S004?=
 =?utf-8?B?WXYxQS80K3VYVzBkUEhxKzdJa2tzRmwzNDAyQ0tJWVFSdTJtSW8vRkpCY2tt?=
 =?utf-8?B?TkZhZ1BQWUVPRFpKemYwMXJPTHlhczQyd1l2cmNpeFJ4ZWkxbDRYUWxJaEE0?=
 =?utf-8?B?K2RPbzQ2S1d2dXdoUU5mcUo1QWg3K0Q2MXVRSEdqcGlETnRLN0tUelRmN2x1?=
 =?utf-8?B?Y1o3cFpLVHJtVEpyVDBLQ3BjdXBNeC84YkljT1EycEg5dWFsQnBpSjl3KzU4?=
 =?utf-8?B?VTRUTUJpY1pRZkQ1TDNJTzFOWW5ncTcxRnlZVmhjbjY5aVhqajBNbGtBK1Fo?=
 =?utf-8?B?M2pGSDVjZlZOdVpYZCtCa3pGL1V5WjJFUjFYMlA3aTBJbEhPWTNzemkyKzFV?=
 =?utf-8?B?R0pHMVBIVDh0RFZxMVBWUDNvV3Z0YXN4MTQ3di9GT0tiK2FtNkJSSU8wSklz?=
 =?utf-8?B?RWl5blpxV01QRWdHNDBsaGdUTzY3dmYxT2RyTjlhNUFQK1VTcmF0Vkp6dTh3?=
 =?utf-8?B?UHR1bVkyTjFnendqbWlyMk1UR2REYmNrUDlkTTNwZlo1eEZXbXBKRzlVbUww?=
 =?utf-8?B?VkVaUmlNSGdFdmJNN1BmSE1Gd2ZwSGFESWYveEYvZXRNOVU0RUFaUEFPWGlB?=
 =?utf-8?B?R2Ntb0lSd1pxNFlvbFRUYjNmSGJYK1lNb1diL1BxYnRuZ0xtZW81ZE0vN1lF?=
 =?utf-8?B?UlkrWkFUajVrY0pCaDA2UVFIY2owM3U2OGp4aDFWa2lMQW9yMG0zMitWUzUz?=
 =?utf-8?B?RldDam83MUQ2YXp4L3pDeUt6aTRpZGtWMnpVUGtkbjUrZEVFS2x1UUNlc2dt?=
 =?utf-8?B?b3R6Uktwa3E0UUdaQWhOaXQxeHFhTVBCMUFDZ2UrSmhtRmhMT1MxWHdBRTdR?=
 =?utf-8?B?V3RIWUFmeTc2UTlMdjZzZ094bytIRW9UbzlnNll0ZHdlVnZjcHF3eDNWTEhR?=
 =?utf-8?B?QU5yMy81aGt0N0wvVlpETGR1bmJyNXJlOHpFaGV6UVVjZWlkVzdJNkl2UHpt?=
 =?utf-8?B?Q2xjTEVOM1gyeklwWHZpQmFJSW9ZVFg3cnhiTlJYbzc1R1pqK0VGQmVUYkRr?=
 =?utf-8?B?WjBKbmdidXowdFl3Y0YreTYzaG5nZ2U4YVU4RXpQczdobjd2SlFxQk00WmZu?=
 =?utf-8?B?eEVvcllRZm41Q1VQMVR2K2I2UU9qcDlGdU56ajFlZWt5dGdEUk45V1FaaWxp?=
 =?utf-8?B?c3dJcG9UckUxYWhLbi9VUHQvU0M3TzFwUlk1bW1lWWJ6S2tzYlVONDFweWJq?=
 =?utf-8?B?NElZVXA0U1Evd3hzdFJjMWhuUEhTdDFRT0NleTlNVHA3MGxPckIxMnV6T20z?=
 =?utf-8?B?b2J1SGNnMm8wVnM3Myt0K1lqRndmRWhra3QxNVlzb0kvY3R5cWp6dXgrYWZO?=
 =?utf-8?B?RVprMXJPY29xbEF2bi9wcEJsVUFFb3dVa3p0M0ZvNmJBenJBbnl1RFBSWVp1?=
 =?utf-8?B?QmVLdWdsNm9vdzRwc09ZNWRqRWtkR3l4NTZMUS9rc1JsWXVwS1R0YlVOd2VT?=
 =?utf-8?B?WWxKUnNkeGxocVZ4V3pONFphbUlNcklORlVrU3lTejJHNFlKbnZNOUtjSitz?=
 =?utf-8?B?TzF6TFV2Y1ErUCttTEE5bk9YN2MzZEV2QThHNnNhYkhMQ0ROMWpHbkd5L2kr?=
 =?utf-8?B?SEtHbUNyL0JySStOdERyY1duM2Z2VlpZaTJRVTh3aUFmYnFEZXNuYTFPaDh1?=
 =?utf-8?B?QUtYaEY1aDB2QVJadjkrWkY3UzlURHFFcXE3OUl5TEtpY2pOOS9kR1NxcERW?=
 =?utf-8?Q?YHwNPy0GpdeVM+53TSxhVjMpx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96ff560-69a2-4b71-26a7-08de0d70b772
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 11:31:30.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efbza7pq+HneHapTgms2G3abw2MJTcsaph2ioFglsdzYd3rkPp2EO7IMmx2kuH/F/alQig2CTFCotFTNW3umCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669



On 5/9/25 11:27, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
>>> +			    bool enable)
>>> +{
>>> +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
>>> +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
>>
>> There was:
>> FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
>>
>> and now it is gone, why? And it is not in any change log, took me a while to find out what broke.
> 
> Oh, sorry, it results from this feedback.
> 
> http://lore.kernel.org/9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com
> 
> ...but since the address association registers are not programmed then
> nothing routes TLPs to the IDE stream. My mistake.
> 
> We may eventually need the ability for the stream allocation path to also
> allocate a traffic class in the root-port, but for now this assumes single
> device TC==0.
> 
> For now I am adding this:
> 
> -- 8< --
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 4f5aa42e05ef..610603865d9e 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -379,10 +379,12 @@ struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide
>   }
>   EXPORT_SYMBOL_GPL(pci_ide_to_settings);
>   
> -static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
> +			    struct pci_ide_partner *settings, int pos,
>   			    bool enable)
>   {
>   	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, settings->default_stream) |
>   		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
>   		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
>   		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> @@ -424,7 +426,7 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>   	 * Setup control register early for devices that expect
>   	 * stream_id is set during key programming.
>   	 */
> -	set_ide_sel_ctl(pdev, ide, pos, false);
> +	set_ide_sel_ctl(pdev, ide, settings, pos, false);
>   	settings->setup = 1;
>   }
>   EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> @@ -481,12 +483,12 @@ int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
>   
>   	pos = sel_ide_offset(pdev, settings);
>   
> -	set_ide_sel_ctl(pdev, ide, pos, true);
> +	set_ide_sel_ctl(pdev, ide, settings, pos, true);
>   
>   	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
>   	if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
>   	    PCI_IDE_SEL_STS_STATE_SECURE) {
> -		set_ide_sel_ctl(pdev, ide, pos, false);
> +		set_ide_sel_ctl(pdev, ide, settings, pos, false);
>   		return -ENXIO;
>   	}
>   
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index cf1f7a10e8e0..a2d3fb4a289b 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -24,6 +24,8 @@ enum pci_ide_partner_select {
>    * @rid_start: Partner Port Requester ID range start
>    * @rid_start: Partner Port Requester ID range end
>    * @stream_index: Selective IDE Stream Register Block selection
> + * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
> + * 		    address and RID association registers
>    * @setup: flag to track whether to run pci_ide_stream_teardown() for this
>    *	   partner slot
>    * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
> @@ -32,6 +34,7 @@ struct pci_ide_partner {
>   	u16 rid_start;
>   	u16 rid_end;
>   	u8 stream_index;
> +	unsigned int default_stream:1;


This sets "Default" on both ends and the rootport does not need it in my setup (it does not seem to affect anything though) - the  rootport always knows the stream ID from the RMP entry of a MMIO being accessed. May be move it to pci_ide_partner? Thanks,

>   	unsigned int setup:1;
>   	unsigned int enable:1;
>   };

-- 
Alexey


