Return-Path: <linux-pci+bounces-35631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B67B483F7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5223B0288
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D971231A30;
	Mon,  8 Sep 2025 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yojkMnih"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9721B199
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312025; cv=fail; b=dTujIohjkeP7Q2yk4oHBTp4qIH24Z7UifXLF7X1RrRKKze4bRMdsJwPGIq3s5wDJoTCiBio8dGhwRHYTD2RpmeKy8iu82ilFB++FfPO+N7uomc4lMb5ubzFRNQOoQxrC7TmkB7E4VHZzvCRsim2CNspKCJd6+6XvsusbSq8lyB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312025; c=relaxed/simple;
	bh=3n8OMVH9RitfQagR3nF4+CDNqeAyaHxsgMo8TVUWonc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ihQ2m6azI8S1oECsv8jXc02rJYpteapKq0nSWw3dIdHniQ0xzTZUZR/bR8hO6yk7Y2aGoZbNMIFv2zurK1cQ4u1djvzUdNewoRILbpcIzHnJf1f9K2hbb8apJucOsoYULapbGBTzeOjizvU8RQzRiZ82jTvUJAE4NEZTLNTAOQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yojkMnih; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFiz+bNcloKbC8oTvao0s0OwtHAN9+XI4Lu1gaUbHMnLEBExEaIPv4OZ9MjBa6d+ksWRkXAj2F5e7jNi2uoRfZAy+QXDlHt5SWF6ney2vPfQAc4W3GorngPjY8FDWphSVbV8reAQXRSG2Jz6vO5TZlwpcv+IIRbtY97ny63RvsEvuTLPE39I5XZaZY6l9CTjXvV1lmdpXGAG6tLK+MnRaEsr9HnLYX9MRPdRq3eMTO8Jv/vltyCeVPE7ZzXAIbGhVvucwP+yJB+aarvuXBVlv97Mg6e9CKasbjeDz0DeHE1GqzkM8Wj+yj/PguGWUFJoCjgy1oFnmpDqsKQtPHFuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4fUIFLMw5EGa/WvsEMkt33HqtUiMciYjpZ+7HxLIQQ=;
 b=gxkvtSrROkVcsB1jE0n0ouIT5Sc6JrSTc7OnLhDWSpILZ6GM/U7+a2Ow7Dzei6Kjxp7f7XhUdCxhizem/+BWt5kFWzOKgCQuVPD3tkzGLoA589QVlZ8gGVGq7h9FQiFNbN4WQZ6i1sMdQMTtgg62BTKvmOwwhRYV+CP9DcVE0McEUyHJ664+lTsssNPYYzFm3v8X9T2KzrV/ZrXUeObzeug6DDdPsaGiSqaAz/Sm9b3GES5Ix2c10wDHW2/iLBu3frPUhkN1WmGGLupkWk6nDypMob7bfdmLgPGxnsIFhILn+ce+MG5w4VMCSECLMx4xO56f34IZNdaFPkZnPZTh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4fUIFLMw5EGa/WvsEMkt33HqtUiMciYjpZ+7HxLIQQ=;
 b=yojkMnih0jspaZboVJ96192xCRpjAmLefNUEJxkr3ebKvdmj0bLZMKtVx/gMUZf38YFVckTTGTg+8m2sLFg01dpeZfCtfQiBd4dFO5DcSAeKT5xN0BArAx2qLlfEuy5xQI13pw3LYtdu133bK1e1nEN03a8hFvdCGEGmesOStAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:13:39 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:13:39 +0000
Message-ID: <70c5399e-debc-48ed-a60b-e1921c111690@amd.com>
Date: Mon, 8 Sep 2025 16:13:33 +1000
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
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68bb97518dea6_75db10067@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0013.ausprd01.prod.outlook.com (2603:10c6:10::25)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ed0e9a-3f6c-4651-1413-08ddee9eda51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRxRUpkVHJHbEhVNElXM0lKMThvU3NYZVkyK05lVlZ2TFZoTjlNZFFZbTVW?=
 =?utf-8?B?THQyMm5NZ0xLTklBZ0U5UkFERUxVWUljY0VGb093cnRkS0ZEbEZkTUhsbmt5?=
 =?utf-8?B?d2N3S2hjb3lodFZSdnQ0NlhRdVphMUZXa3pZRmxnT2w4Z2VxK2g5a2ZPZ0dH?=
 =?utf-8?B?SkdlSWZEVGt5NiszMlkrK0hSYUI3UGo4eFBZUUxpZEl6TzRmaUsxTEpyd1Nk?=
 =?utf-8?B?Wk9aYVkxcFl0TW9WK0o1bHM4Vnk2ZjZualRvZFVpSDFTb1d0eC8yekpBQmVx?=
 =?utf-8?B?QkhyTFd3WDlySERhczZrOTlhUE1qNU5MODZVNXlZMXo3dWdvcjFGdkFkcWpG?=
 =?utf-8?B?eUFRVStUUjlkUkEvbHBEdlY1ekNwOEpDYllwZld0bjNUYm5ac2JSTGlreUdz?=
 =?utf-8?B?KzVvZnphQ20vOTR3Q1ZXSVJNVVlRcFNPUEpIeU10NWQvOWgzVHRrbWZCV0lJ?=
 =?utf-8?B?SzRxQ2VyM1R1YUF0KzlydU1EMGpERlRWMEx1am1PWGJTclhFRlc5YTcyRUQw?=
 =?utf-8?B?a1NNYkdZeGNYMlJlTGduRG96K29BT3VtMkhmUmJHUUlsYXVSaEJ5eDBCYzFt?=
 =?utf-8?B?Ymw5Y0wzdmVqL2VQaXpaOXZ3T3FBamlLUkE4bWZwSEw3UXFYN0dDNVgrYnkz?=
 =?utf-8?B?STlxSTV1cmxGSEZTdGp6MTk0NHIyei8xQ3BkclVmM29GakJIeUFIdU1oKzFh?=
 =?utf-8?B?Qnd5MmtZdjBKZUl5Z0FITWdMME5MZllFUUF0UHlvM3hhRnlYWHZXT2krUE9z?=
 =?utf-8?B?Uis1b0d3dk9nMk1jd2NKZXFFb1R0RzJpeHMzTGIyMG5yMmF3dFhpZ1VSUXJC?=
 =?utf-8?B?Rk0rWTR2NC9OZ1ZhUTlNS1k4OTNSNm8xK3dHOCsrVE51bE5yM0VlWTNhMXhO?=
 =?utf-8?B?eXZ2cHoyYjUvNEoyZ2R2S3E4Mmt3czNhQ3BFWEJzK3pNdWFPZUpoVVBlL3hI?=
 =?utf-8?B?a0txbENrVGdSbzJvL1F3cTRhN05GbmNPbFI0T0c1dE8rbWxsL2QvU0NKMUR3?=
 =?utf-8?B?bVdMV0FnR0t4ZmhSbzUxRE1PcTJ6Z2pSS1JGSG5vRGkvNkd5bHZQQ3dBRVB3?=
 =?utf-8?B?YlI4eUNPTlNkcVo0M1B6WGVlL1ltMmhwTFVzek5oekpXeTdxcFdwUVZ3dVYx?=
 =?utf-8?B?RzdoYmlmL2lCZExBZkFRV0kvOVRrOWtXSFR3NWtTS2dLYjdFUVRCWkdzcC9U?=
 =?utf-8?B?TDN6L0NNZFZ3eW0rNS9Qc0RFZVJFTGxPcXVDSEdZUFIxV3U5OXZ2M1BENUw2?=
 =?utf-8?B?ZVUydmpiMGY1c0xSSkxpUG1yNVdGbGdPT0paUmdtelNCd0pTaDZVN0NXbjJH?=
 =?utf-8?B?RG1zL2U3cUV1am9kVDVWM1pUWFhGRjRFRko1TWh0dEc2OVB5VHJQdThxNjlo?=
 =?utf-8?B?T2tVbkt4Nkt0UEpIT1VFLzcya0k5QjVSYUw0SUhHdjRSa3JsaVVBOUlrTnFj?=
 =?utf-8?B?TjNSZzlic01xYktSb2RSdmIrYXhRQWNJT0cveFhBQXdkaEhOaVhWU04rR1Rm?=
 =?utf-8?B?L1V3VE1ranJad2hYVlFQMVUreTJucC9GaUhNMjZqU2s1RkxRMWRYYnNrTDZJ?=
 =?utf-8?B?eEdac3MrbnBDRENVU2oxYjNvcDAyUzlWRks5Y0xTZW5HdXdvMnBobHNGTDJu?=
 =?utf-8?B?SmxIbitsa3ltVHdSZVJoVjFhbjVZWnJ4Tm5ybjdYUlpoSXJrLzZMQkplR2lo?=
 =?utf-8?B?dHJlWnpyTk8rZTVURG5xMmVSN2czV3BLd3F0UEoxaUhzaVg1SGJ4RzNFaVFD?=
 =?utf-8?B?NitlZWJaclZJajAwQkw0UjNrTEdTWDdGWktESlFpOVZhbitQVWdNc0VwT29q?=
 =?utf-8?B?S28wNUxPLzExcHdabnZsN0FrdGRuNUtjbjRDRjlQaW5NNERPL3RHdWlCeUJZ?=
 =?utf-8?B?SXdXMmh0QXNOaktNZldXVXJENnhsbVg2Y0Y1VGVXNmJERnlKL2VtTlhkWGsw?=
 =?utf-8?Q?thUHVAA5qU0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDgvenNsVmI5cGI4K1ZmU0s3STlIek9ZM1Y3N1RBUkpXYVZlVVhLbUE1YXJV?=
 =?utf-8?B?RDljNTJFSjdkNndkdjVvcHNSYTQ5a04wU0ZrT21rY3QzMU5SMzhuc0QzM1lh?=
 =?utf-8?B?d0RZUzl4b25vRmcxS2VxQ05UUnRmeWJ0Ylg5ME90cmtVY2JYNis5NkZaRUo3?=
 =?utf-8?B?TTdnZU9tczcvSlFNNHg0Qnp4ZmZqQlhrYWpucElMZmo1cDJ4ZEJIM3licGFE?=
 =?utf-8?B?V0xmb3JKQmlHUy9LNWowWGlwZWZVZ1Zud244ZDd5aDJRTU81MEVjTTJPbDd5?=
 =?utf-8?B?NWs0djJ2WFMxNWlwY3AxNll2N0krb2R3L2hPa014K1JOSlZlcEMvK3JBQkRP?=
 =?utf-8?B?QTlyQU1JbUVwazJ0aGl2ZFU1SGhYWkZVbTQ4Rkh6aHliT1ZVRmtLMk0wSFlV?=
 =?utf-8?B?Ujczdm9XdlZoTnhSOWdqUklEMUVobFVOaUNhVFZOcy9oVllHLzRpYjlTdkhU?=
 =?utf-8?B?VnltK3hCMXpuV2dxamhDbWFxR0VEclN4ZEpUelgwdEFjVlBYVHlVcHd5MFd3?=
 =?utf-8?B?NzVIQVg1OFROOTY2dThEc043SHdzK0JmcmZ1L25lZlloMXprekJSMnlUQ2dB?=
 =?utf-8?B?VkpyZ0tZU3l6dGtscjRKTlNxZXRKOXM0ZWM4Y3UrV2VUWUJJaFFYZ2o0Qitn?=
 =?utf-8?B?NFd5TUsxR3lod04vdHA5R0U0VVEwZzlMVGJ6anJvcXdpZGUxT3BWYVZPWVNH?=
 =?utf-8?B?RDN1RUd1cmswd2JkQzRCNUk5SWxpdXVnczQ5aGJSSWRCaUZPWTlkRllpY1lm?=
 =?utf-8?B?dmZGT1g1MWExb3B6azNGL282dnhLdmVCRG8rVVhaVEg1WnQrVEhvSUtIU3Ey?=
 =?utf-8?B?eWd4enZQSjBQVUJhRDZaT0hFUXNaZzlNbG9wQkNQRUJvUjR3OXVmNDNXLzky?=
 =?utf-8?B?dnRRQ2R4Y2JhYjJjc3pTbkZyelVoMGErcHIyRXZwTitiU3h4NnpUVXlOd2Vv?=
 =?utf-8?B?RnFaVlRQdys2cDNtNXhBRWlDL0VYa0ZSa1d3Vnpyb3B5RFRnVVhpaWRwN25R?=
 =?utf-8?B?U1RVNlZ1Y2ExdExPeHZpZ3N3TTQ2QkxBV3JYYWdYMkU2SEZMMFVrUUxldDhx?=
 =?utf-8?B?bEJPVjNVQ1Q0K0d3dWNmZFQzV2Nzbk14TlhuZkFDZlg3Zk01NGZYKzFjekZG?=
 =?utf-8?B?VWhCWG1BQjZmWHhMOUEvK0thMGtOZUVaOG9sQUFteDdoclkzbHBIUFZ0OUlr?=
 =?utf-8?B?NXpZRjhNeVI5aDR4SUFsTkIydnAwcHE3Q1FxakVsaStEczFuRHB5cTdJaVp2?=
 =?utf-8?B?RUNEZlBnRWs4ZnpkMkFBTm02ZzFzYzZrWXozM1JwUG1RRVp4c252UFBXRUp1?=
 =?utf-8?B?S1JaeVU3NDdtZWtzaGY5MkwrYUJYZSt6cDhnMnA4ZjlHWHp1Ti9vVSt3cG5S?=
 =?utf-8?B?U3RJM0hnUUZRbGJSVzByVDAvRTV1SjF2Z2FFWHNVV2llbk5XS3BNRERvdjg5?=
 =?utf-8?B?d0dUeCthOSt5TWo1eEI1dDlRRkdZT09nV3JVMjQ1L25BU2lqNXR2YVJFNGVB?=
 =?utf-8?B?NnNidHVZZ3p2VEhhOUNDT01nWEhua3BKN3pGa29LeDBydHFqcnJSWjdFdHVU?=
 =?utf-8?B?c0RKdWk2N2UrSGF0UjdxdThkTjBFeGZDVXp6QlBJU0gzRlI4eHh4RERxWHp6?=
 =?utf-8?B?bytiN0hxSWJlbWlIV2ZzVXhpZTFOL29aeDdUMWxvOU9lbklLdW5DNExEekpa?=
 =?utf-8?B?S0RTS3dzWVE3amlmeEdFYXdnN04yRWN1dENpYTJnMG9QcWltWDR4cGhDNXpU?=
 =?utf-8?B?azFwTjM4YkJmOXlQdFdNQ3BFem5FaU1XUlVmSG9pMWYxU2xHeVkyWUdqV0RP?=
 =?utf-8?B?VUVpNjFOdWNnTVVXWE9VY0dleCt5dVBlVXJBeW5BR01DUDhGc2s4U29XQXpV?=
 =?utf-8?B?NnIyaGhXODQ4bzNSZlJtUlFINzk3cENrTWFHcmltazc0blpoMzhPZ1ZpeU8z?=
 =?utf-8?B?Tk9XUG5GVCtKVVExM2RlQk95Y3lQS0REZEVuMWVJZmlvNXhSK2FDMFpFQ01G?=
 =?utf-8?B?NTlsaUpXWHY2NVNsZmRqK1BmYW9IYW1pLzJSNUF1MWZzUFhGZnp3dmxxa0xo?=
 =?utf-8?B?M0dFbW81R1pwV0hoOEp3QzM0T0c4c1RZZGNqOG5HL3RaRGtJc1NualJTRm5m?=
 =?utf-8?Q?0YobIPTNjAD8KaMf9+YfZevkx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ed0e9a-3f6c-4651-1413-08ddee9eda51
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:13:39.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVoWZfwN6Bzcu+KDVTZN+v2OO3e3K8axWYtsBq/fjpzCosEp2tqh2Zg0sLuo05JU/msE0J8nLA54ZYC/i4RfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937



On 6/9/25 12:07, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> TDISP without IDE still needs to do all of SPDM (Component Measurement and
>>> Authentication),
>>
>> Support for PCI_DOE_FEATURE_CMA_SPDM says that then.
> 
> Right, the TSM core looks for that (PCI_DOE_PROTO_CMA) as part of
> connect because it needs that either for TDISP or IDE.

The quoted bit looks for PCI_EXP_DEVCAP_TEE.

>>> and the TDISP state machine.
>>
>> I'd think PCI_EXP_DEVCAP_TEE is set on something which allows
>> START_INTERFACE_REQUEST and some SRIOV devices may not want to allow
>> this on PF0. I am likely to be wrong here then. Hm.
> 
> PCI_EXP_DEVCAP_TEE is the only way to identify TDISP capable devices in
> the guest, right?

Right.

> So PCI_EXP_DEVCAP_TEE means that there may be a DSM,

This bit I am not sure about. A bit hard to believe that PF0 is always expected to support passing through to a CVM. Thanks,

> or a guest-side TSM tunnel to a DSM, that can affect the TDISP state of
> this function.


-- 
Alexey


