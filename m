Return-Path: <linux-pci+bounces-29023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEBFACEE2F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB7A18938FF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB928217651;
	Thu,  5 Jun 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nWT1WMCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB3218AC1
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120987; cv=fail; b=s9bDGpzxEv91jGv6c8jC7F1eL/UmQrfEtqTVHIyth5BIsJf4gy+sokS7M1nTxQn8vHK9PDO765cWfqJ5ZAt/S6UOaofrSFeCnW2o3C9ER9C3eZmB9UPIvl1kgQn5uyBJRIiHiKkLtOZY6rU7INE8HDvfFQUkeJKW9jbPPFr+hm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120987; c=relaxed/simple;
	bh=68IiBEUM2Ik/AKB87dmxzhT/HN3NBuwGZWA63SHLNtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7w+Ui1daIWwO6Yh2QF0ZVtu8GsZmf1dd9mT1DHcpcZ8VMjSG1w1MK++wk7de0GpYMQb+btKfrC/tilqcksM3tysrAFC0LRn34aSOcMbdxyyghEz9gVD/MAKgQWkV/qIkh7dBkfngDBxx77+0DCnHnv5DLkW81NbrqVTDX9l1hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nWT1WMCl; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+turdDGAR++r2bhiPHOL5ovevgM0DFZpeZ7CLq0LdAj2QAnPVl0irrzK3VcNku+VoIcD5a13NpxhEUHVBtDVAfz9vSTAvyG4hxNVnSs9+MmiTfnDfWjD2z+6hWDsEwPMmEpFRPE7mfmGUfoSacWPNhlrgbB2eIfs85wuEWj9TcU3JJ5g0wbhigRABvIi8GMLRpHHeRzh5OswyFLo8Yr7FLM2yOzGLXZ0fbrR3HijwfAQSRhBQVb+IAY1FpSb+gzYopVr2/n82jYimGh3XRCsh9FEd1rW8D3P5fkJCrBhdz35ayxxHXc42pl+TiD99IKfLGFdxY7u1RqbW0I3YC8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRv1EBy3Dp15u6mm34bHNlC4m2p7c7IcDrBMrwKLBVM=;
 b=pzisofdA+O45i4eI7QtViqfVmcSIPpKovfRdovI9f0WC1tezR5WWYioBVXy7PWCWRgiTek+Gncj+30ixqOjOPJUrIDK/mpsz3LG75Joyyr3dD81PyewDYjPG+3AP/LYu4K9+XyLFMsaEkbd7CbkjCD1L7yyTKuTpZt2Kg8WdcGe8xygMIBiNnO98S00Fjivf54iUXEFruIZUIYdh8KU8EBIJg0fHLO/4nS5yMS5Hhc0mMiNL64MjdqWyccW9WW41Q7QKrT0ymeNh9bOnrRFR/qVynzooGEeAn0XStLniYEiNL9vM0Zx6Z0WHl7FTLI/5J0YIuGL97SPsTSNfUvdM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRv1EBy3Dp15u6mm34bHNlC4m2p7c7IcDrBMrwKLBVM=;
 b=nWT1WMClkbQRCNzC9w+1huNl0w548PqqDPAwnsxW0IX4IP1eBHAQRDZZ1f7+deqUccRjxZIbR8s6HgXZ7f4onDghzHdCEiActXzyKy31oer7LY7y1hnPkW7CokgDPBjxjzNlcG5kFuaUCRbk7lS3Gve8ZMsbK37IXuyB+ysV2rY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 10:56:23 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.037; Thu, 5 Jun 2025
 10:56:23 +0000
Message-ID: <60812b1e-d01b-40ef-9e59-c6ab970e17e2@amd.com>
Date: Thu, 5 Jun 2025 20:56:17 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: Dan Williams <dan.j.williams@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, lukas@wunner.de, sameo@rivosinc.com,
 jgg@nvidia.com, zhiw@nvidia.com
References: <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org> <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org> <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org> <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
 <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
 <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
 <683fa6f622abb_1626e100e0@dwillia2-xfh.jf.intel.com.notmuch>
 <683fa76214ebf_1626e100e1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <683fa76214ebf_1626e100e1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::23) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a1b463-6141-4d10-4859-08dda41f9c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW9HbjhVc1cvQnZreGFTSnY5ajQrZW4wMVZaVkR0S2t1RHZpKzRaMWY5OEQz?=
 =?utf-8?B?Z3lNTUlIZGhnR0E2azBTM25HME9ocGdDbXVwUVFtUlg5QlpWenc1Y0oxaWNC?=
 =?utf-8?B?dld6UkI2a3hCbjVwYUhQZnc1YmIyeHhBOFQwSENGSTk4M1gwc0UzTXFHWGVK?=
 =?utf-8?B?NDdNdEtHMWFNZzQ2MHNZVFU3Zngwa0psWXFnWlByTDJZUFYxd0JxUVBuemsy?=
 =?utf-8?B?RVpScUVmYUdBQ1ZXSFpsUndYMkQ4KzNRWDdYZmJ4Ynl6eXA1VzMvVk9MZTZv?=
 =?utf-8?B?VHpDYnF4MTZ4QThaL0pEcTFhTE85dmc4WEJyM1R3ZitBbEtlWjVpZjB4L0tX?=
 =?utf-8?B?WVFwY2xHNkQ1RlJGendycTdBSGJGL2xDSTZjcVFPb2RtNTRBbjdsdFFFWGUv?=
 =?utf-8?B?ci9hWUVTVStPSUpwdnRkK1Y4eGZUOTlySjZ0OXIyVEVUaUtxRWY2T1JvdnBo?=
 =?utf-8?B?R1VHenN1S2VPSllmU3d1czQySndmakhnNkdhZCtDdDVDeW9tMHZJajZ4K0Fl?=
 =?utf-8?B?L1hhc2Y1d0J4N2U3QmZaeUQ3RU9zUDBqZmdSc2dDdm9vbitVOGpzaHJUSVVJ?=
 =?utf-8?B?bTlQS2JxL3hBL1UrWjkyS0Q3T3A3cllvWnUrV3QwS09JajYwWjRXL3A1Rkds?=
 =?utf-8?B?bGpMYUlxVllSdWVPY1dhczA4LzlnK1gxNFF2ZElFRC9yTW5YOU1sM0txUDRL?=
 =?utf-8?B?WHUraDJPVXAvR3hrL0oxUm1rTnU0Z0REeS9Zb3hCc002eHBRR2pzeWV2YUxz?=
 =?utf-8?B?WXpuN09ZVEpna255VWE5bVZzMys5RUtMejNvZFVrN08zd3AyUFhsaytFNGRs?=
 =?utf-8?B?dGEvSFFTY3hPRDBxT2F0RzUvei9lMGJHcVhsRCtRWGx1VnZOOWoxM1VieWxs?=
 =?utf-8?B?aVBJekRUeUIzYTFzU1FMSDdTNTdkekRvNzg4SHZKNnpVa0ZpL3dmbzBMN3dq?=
 =?utf-8?B?WUZNMkxtYndmaldsdGxKbzIwRDZKcmRqWmVwQlFwNVF3NHBiMFRLNE4yMDlR?=
 =?utf-8?B?a015VHlUNExaY0p0VS9iY1U5Qi9wSCtkVkozMWNsUWNzWUFicmpKVEd1WDFQ?=
 =?utf-8?B?cHhndDNBUzA1b2s0L3dwMjA2RE5aemxlTnluZHlCK2w2OFROYjVUMWpBRWtO?=
 =?utf-8?B?eW5XMUN4bGF0RlluUVhUQ3lnYW8yWUhiaFpCSy9CWGZyRzhrNXdmZGZxRmIv?=
 =?utf-8?B?UUFxVUdpcnpFaFh1WHdFU0pXTUd5Y3VXTVRTWFMxeFFwSE5MdElSa3VvUzha?=
 =?utf-8?B?eVBYTzk5Q2ZaRGovQWd0dm5Vb2QrQ2Z0dXdpZTdlSU1aaE4reWZRdUFuSXpw?=
 =?utf-8?B?dTNLcDJoNVNVRmZ0emlIN1dsd245OUl3NVNFR0I3RnF0Z1VuUkR3aDU1OERS?=
 =?utf-8?B?Q0k5aWdXejUvWk5MNVRDN2ZmeitiMnJxYnoyVXBoYUw5OGd6YllmbkhhN290?=
 =?utf-8?B?ZzdBRmFXTEFoRVRmbDBxQzRTcTV5L0syS0cyaDBrRmZMYWUzUHNEak5VcnUz?=
 =?utf-8?B?ODh5Vm9mcUhvTHp2TWhJRm41YXRjUnBRTVIrRTZwN1F0NGh5K2cxNEkvR2V5?=
 =?utf-8?B?VXZSYkJ0TThPRUhFR09nbk5QZjZDZG94ODEwc1ZpWE1zSUZqamM1RUhUbm5S?=
 =?utf-8?B?QWl1WVlVQlFYNzM2YnF5Rjk0emUwaFJXOW9KeXI4MTVlUHhpRFk0ZWJUTEVm?=
 =?utf-8?B?bklveDZaYVBCR05RS0RPQlM1Sms5R1Yrd0FPWDlzNEs0Y3c4MTI1czBsNDVG?=
 =?utf-8?B?SmhWOXM2VmxCUytxbHJRY2JPdWFCWlFrek1VMXE1OWk2ZGhHbGdSS3VYRC9x?=
 =?utf-8?B?dUtIR0dlTUVlZkJrZGhUS0wyQjl6ZVRLQSs5cm5QWEJhbHZIdmptOTh0ZEY5?=
 =?utf-8?B?OXVuT3c3SFpBa2xhVUpTMURiSlpidFIvZnFqSktPL3VHRFBzS1lnL09mdWdH?=
 =?utf-8?Q?mGjYutimLtc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djlOZE1xRG1jTGRJVEhHN1Z3Y0Q3Lzd2UXRDdzNnekJmYzdXbFVyMGhvLzdy?=
 =?utf-8?B?dTNia2JIczRJVGtGRTB6SFRUTTh1LzFtTktDZEhRd0liRzNZODN3aHEwdyt0?=
 =?utf-8?B?R29VV1NyV2RsbnRURkRWdmtRNEFmWnhWc2ZuV2JVbUZybzdabGc2VHF4TWVo?=
 =?utf-8?B?SktyNFlIM1dZZ0R3ZTYwTnRoZG13bmFYOHBVaXUzdkpJK3NCeEEvMEw3c0Vq?=
 =?utf-8?B?RzNPQ2VjNHd5Nk1mbzBCcXFhNkJsZlNFWWgvTEtKbkJpSUI4U1JkQUI1UnMx?=
 =?utf-8?B?YjVLUFhUZXJVcFpzd2s3NU9ibytOTHM5L1E5cktIa1h5MGpRTmpCZDZKZTJ5?=
 =?utf-8?B?YitDNmtmQ0JCS1RHSm1EbEppSXo1M1E3YlI4R3VZSUZDQXZGb0d0ZFlMZFVD?=
 =?utf-8?B?Wk42Z1AxWmVNeUlxcm1TL0dFUE9HVzcwcEJkVTM4WVNlWi9va3V2WTNzbzRE?=
 =?utf-8?B?L0VFQ1pFNU81dXhvVk1vMWVyakI0eVN5WXpSRXRodXo1ZzlHMGh5dEJ5NHZ3?=
 =?utf-8?B?KzAzK2JrSDMzdVdnbnJhTEQ3ZEZOZmhzWituWUQ0WmtvQ0E2K1NnNGJwT0g0?=
 =?utf-8?B?Z0g2Nm9ocDdRalEzTHJCYUU2dHUrT0k5T3YxaGhnK2RPVDEwclNodHdvYkYy?=
 =?utf-8?B?cVZRNzdRdk9Wb0ZOMGcrVzd0WFpvVkE0M2FSMTJUZ1FsZlR3bFdySENiMnRK?=
 =?utf-8?B?NWswRHVSS2VwMkpQYTU4dlp0ZGtDNFpyV2ZrSitqMERlVnBMTGJUTEo3djZw?=
 =?utf-8?B?bHJldVJBRmlzQWFnSHNHUFF6ajB2aCtHaVpNU05SYWR0dG94S3RlTmg4Qzc0?=
 =?utf-8?B?Um5mOVZRQW9lZFpubTBlS1ZrSkRRcFI1SXRKWW5BZ21CS1E0QnNYVXhQbk42?=
 =?utf-8?B?aElwSU03allFSCs1TWJ6SEhucVYyMDY3cmdXSElBNXBBNHFaSlVFMXhFYThw?=
 =?utf-8?B?V3Q0M295K1BHMkpOaENFY1dwZVBqM0R3M0gxWGoySEhsOFh6eUJPSnY3RzhG?=
 =?utf-8?B?NXZBZWhOZHkvUXRqN3ErRDRzSm1VWHIrT242U295U21RYXFhVmJjZDJxdkxF?=
 =?utf-8?B?MzNGaGV3dWlraWIrRmRaSzJYR3Z1STZ6MkUxY1dzeWNZTUtFK05INC8vQ0ov?=
 =?utf-8?B?clNFRjhSTFJTaWVQMWRLNU5FbEllcWVCZTFKMm5RblQ2UzdDZzhwNjRURDFl?=
 =?utf-8?B?dHpqRFlwL0Z6Zk9lTnhSMWs2THV0SWd4NHJBQkw4OWYyRmtxU0gybzdCVHFl?=
 =?utf-8?B?MXpMSXo1d0hHVkVBLzZ1OFJLOVdXQ0ZYcUZaTWlPT015VTZTK3pmZ0hWRys5?=
 =?utf-8?B?WmRpMU5WRFNCemhVSStsMTFwQXRXRFhoQS9IY3Mwb0xhRk9SejNZVnBUOFZD?=
 =?utf-8?B?eVRXSUQ5MHhGaHEvaExOVFp0d0FxNzhrak9USWl6UG5iMkZyQ2x2L25sSVc2?=
 =?utf-8?B?VmQ0M1AvUFpFVncyN0JCR2pWTldkM0VHN0E5NURJN2p0QmRjQlJSWXdpbG1k?=
 =?utf-8?B?R3ZoTGpYZnFObllvUGZMQVplb08wTys0Z01RcXNxcGt5OEN4WXo4K1VZMDZ3?=
 =?utf-8?B?Snk4S1V5UkFpM1ZSR0lxeDJzYkpaejU4a216bU02Z3dZbzVKcFlUaGtDcEJS?=
 =?utf-8?B?UXJSWCtDN1NSRUlmclA4Szllby9LY0pVQ1lzSzIwSlU4TVhad1dZNXdkb0JO?=
 =?utf-8?B?MmxWTTBXZXRFbU11MzlBT0p2dlhSRkFxK3pqWnJkdWdPSWUvcnNhUjZjS0kv?=
 =?utf-8?B?SjVTcU1VbldiUlJ3N0FYWXNld2NNQ29rcythN0ZDK2dwMUJVTGZTMDBEQWRz?=
 =?utf-8?B?YUpWdHhqL0lMMlZ5NEtWb1pwMWR2RlhQTlVqSXBXZjBmZzduaEhGNzN3UTR0?=
 =?utf-8?B?Tk9CUGtlTHlKbCs5d0ZITDcxYkJscmk3K085cUVxRDNuUzBqZ0tLUFVGajgz?=
 =?utf-8?B?NGk4emJETTBwdlZvbmtYSXh0OGpJdjdRbGduRitUbEV3Y2N1Z2QxTm1mWWtl?=
 =?utf-8?B?d3JacWJQaXRpWE9JVWtvbVU0SzdCMnJsZ2hsalpTWEd5bkJmZ3RsNDhHWVFn?=
 =?utf-8?B?UFo0UVQ5T3d6aEVraXZ2S2w0SDUybFFHYXRyVVlYQ0RPRThueHdrNERNWHVy?=
 =?utf-8?Q?Qlr+IIisq8wnjXMZRvbnDZSEU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a1b463-6141-4d10-4859-08dda41f9c72
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 10:56:23.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9A/7ufb2P/QvR4en9QeLZJq3t/BsVgh71704DxD1jFaryFsYys0z3VRgF5HW4Y28ZLDG2euqHles4cQe12zkRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469



On 4/6/25 11:54, Dan Williams wrote:
> Dan Williams wrote:
>> Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 4/6/25 08:47, Dan Williams wrote:
>>>> Suzuki K Poulose wrote:
>>>> [..]
>>>>>> Ok, something like this? and iommufd will call tsm_bind()?
>>>>>
>>>>> Remember that there may be other devices, AMBA CHI based devices
>>>>> being assigned. Not sure if they pretend to be PCI or not.
>>>>
>>>> I have been thinking about this especially with the relative ease of
>>>> creating samples/devsec/ given the existing Linux infrastructure
>>>> emulating PCI host bridges.
>>>>
>>>> Why not require PCI emulation for non-PCI devices? The tipping point is
>>>> whether the relative maintenance burden of not needing to maintain
>>>> multi-bus Device Security infrastructure outweighs the complexity of
>>>> impedance matching those other buses to PCI.
>>>>
>>>> Make "PCI" the lingua franca of Device Security.
>>>
>>> This is how virtio started, and now it has to behave like a proper PCI
>>> device, i.e. use DMA API. Or ivshmem which maps memory as "PCI" (which
>>> it is not PCI but the guest does not know it) and is deprecated now.
>>> Not the best idea to enforce PCI from day1 imho.
>>
>> VFIO is a Linux convention. PCIe TDISP is an industry standard protocol.
> 
> Oh, sorry you said "virtio" not "vfio", 

"virtio" is just not a Linux convention, Windows (at least guests) uses it, and there were even punks developing physical devices implementing virtio, hence the recommendation of iommu_platform=on in QEMU command line for virtio devices.

> but the point is still that we
> have not even got one implementation of a bus Device Security protocol
> upstream, let alone multiple.

And my point is that TSM does not actually do anything with PCI except SPDM/DOE which can happily live in a library or DOE (and called from CCP or TDX drivers) and the rest can be just "device", not "pci_dev". I wonder if+how nailing TSM to PCI makes your life somehow easier, it is not going to help my case. Thanks,


-- 
Alexey


