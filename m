Return-Path: <linux-pci+bounces-24237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9CA6A942
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 16:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D74467A51
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFB1E1DF6;
	Thu, 20 Mar 2025 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gj5IZWEx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TfKPi8Ns"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595E3C2F
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482788; cv=fail; b=jeCnPUohLLkeI8SBVSkcxMIK7gl22ZUfoD8ZzTYKVCsIb6HGmAZttaGoKn36tmQhpwxyRd5NSBnbkI+CSFpVc7/D/zcUQw06IoevhiHw2W/QnnIkFmRf3VqWdKNJqvtIjiJoYVYql2Mk1BEBm3Zm6RMdVmuDaTrUon0Emcb0QhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482788; c=relaxed/simple;
	bh=VRcwoQVJlp1T7VGzi6OKqhZfY8Q0SbtjUW/dmsrwPY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VoHyfyvxM/3hFdtFfZEkSt4ltTH7XgWo69O4FOku6RCmQHqFADn/1aBgWD9gfLB/3CWkSV04qdvhPa3QhsjwS7B9Gg2tGkD1/NZZape/MyyuAwiYl3H/BUYI+PpI3pjs3EX0dq5/ZAR8EbeAp4MN7Ug2/mJfNtiez23W6vq4D6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gj5IZWEx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TfKPi8Ns; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDMkFm010401;
	Thu, 20 Mar 2025 14:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8JhgMLd8STADG7q64f9jiRbfWrIIr2TXWkhqG6TckLc=; b=
	Gj5IZWExJa8iVSoP7qEx/WAXTqsIRMshJz7zqr7xFpdZuC34uM2TZM7n5TifEmd7
	9H+dPMgpbTB1I6xCmn8JJtDhLErN0dnkGPcUQDJk+ncPArbfBhOQLDB9G/QTl27r
	CEl2t8D8ECnSLBBvk8V3otGVTslzaAuIgehM31/s0O5pii3k2vFnvKJUvaGE2Bix
	TMfCdYgRaxhl8yPRraC0IP0Voaa6WMTZcd8P0N+eW3tk1uFYKNAcx2yEJ+AreyuB
	CxquunHpyGf+tjMs2lBwA/+vtGzRi8OqSZ9s/1pYxl13hS/NUSL8F0KvyR8zUFyO
	1xrvM3onZwrAZlwQiVadQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m16fj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:59:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDXnfH004511;
	Thu, 20 Mar 2025 14:59:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ftmx5cfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYYeHddod/mrTKwyjcQuVoSVluj6AjUlOWwxvlBF2dPa9IETupuBShtbloJR+fDUSg5h09TMP1Yv2Dn2D97Y6yJEZ2PTDes0pP6Gw1DsH7wnVhApztLaql/0YSJmIlkgSeH4SQ7nVT0XCH6OI/rxTzHDGcXoNGJ62USyelvkxmijzJLKsnLfXZ1/y+5RGNaqBsRYdPEnAlSXoJMyFcUQaacci1IB5f448c+zjX42xF6PxWa+xLPC+TyrwAzlHPHm96vOJXw3DJBn9uciAyxcYQzGJOV0mFN6OiEZGp8zOD3nFs0PK5jDXeEgv38y9yZ/+n/5yZ/AcorAPF5f+BaxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JhgMLd8STADG7q64f9jiRbfWrIIr2TXWkhqG6TckLc=;
 b=m9VSWpYyibqeAhdidBo5pSoCFlMPP/2D1JDSG5UeIHEz5ERnKQio4YI8m4kOhB7GSGj4KXGYR1DnzFIvyLSPIhJTf0zyIMqpTzjxr9VXLrP0UkybaoogSATqKINE4turQxL2Q0PGokYiGlaWDhcqN/5Ta77iouf/qai7rdNT0t0pMQDpkV7GlhtV+vm71xOrNvSSq93HiOdtsRsR55qAF7AfnL7OkJp9FQx7/9Xnj+X/hmxpfD1FPYZDUYRAHiKyIWVmm3l8kiqDfqRDCFmD3h6Kw4REOYk1PGCMvvaevHjQOG6ybQfUn2s+nKkyahfYHwwWmm4dFkBaO72sySvrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JhgMLd8STADG7q64f9jiRbfWrIIr2TXWkhqG6TckLc=;
 b=TfKPi8NsATn9itqW62YK1sY/LwX5CWqOcu7z4sTie5Zimb6L9bJFwnJSVKEFPRx2FO9o+f1ybM/s1EAS3RPUkbyOADK44N4uqprfosaPmIC1PsSmFieo+jUjKhn2C+3WDpaLobGHqV6M41JRXWlWZZ1H8FVFnj1nVyhx/yTThNE=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SA1PR10MB6637.namprd10.prod.outlook.com (2603:10b6:806:2be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 14:59:28 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Thu, 20 Mar 2025
 14:59:28 +0000
Message-ID: <93a5832f-3e64-40ce-b089-b94181e8ba09@oracle.com>
Date: Thu, 20 Mar 2025 15:59:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] PCI/AER: Move AER stat collection out of
 __aer_print_error()
To: Jon Pan-Doh <pandoh@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-4-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320082057.622983-4-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::12) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SA1PR10MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e3fc21-3fe0-4c6c-2a1a-08dd67bfcff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzBDZDcxWmM4K2lXR09aMnVVaDV1MlE1UGVWYXBqaU1tb3VQR2VDYll5Zldp?=
 =?utf-8?B?ZUlQRVpHSFVBeUd5OU80Rlh6RWh3U25XK1J0ZHZ6TXJxMVd3RnFtSnFJOXF3?=
 =?utf-8?B?NGh0aHJtUnNOT1Y5cjdMRWtpcHlFaVVEcHhDTWZrM3NiTnZZMEhXaUdnZ0ZS?=
 =?utf-8?B?YkdubTBQMS84d2VrUkhZV0xJZ0JyZG1yOUErTm9JNS9ybEJPaGtRNGVPWGNK?=
 =?utf-8?B?KzBIUW1lQ0FjOHNGRVdKdUM2NGloTUQzNGt1N1VBbGtTcEpib3l2NXhBeDVu?=
 =?utf-8?B?NHpzVTFhQVM0dEJmRGhVWXZUV2xuWk5BRnhFWjJxdk5KRTlsU3MyS0pKVmNM?=
 =?utf-8?B?WXV2N082dUthaElnMjlaWU9odkJaVFFBR24rRjFtZFBHNEVNZ3Q2d2dieDhl?=
 =?utf-8?B?eU5BeEhwdlhJV3FQNHdYQnE3NjNOUlIvdVJ4OWI3VjA4dHpUcUJMOEl2b2w3?=
 =?utf-8?B?ejRhUFRVbkErTzU5VjZPLy9NVmxMU1dJSmg4dzhSSnZIdGwyaENkU0Q3c3pN?=
 =?utf-8?B?dkl5WnJOMmZRRlZTUExnbjBEcExrUHEzY3NTdFJ5VlZDUVhzZHYyM3EyTlBw?=
 =?utf-8?B?SVEzSkx1TnkrMDFZc1pmSDRsVVlKL0k1cXhoZlVHUngwbjNjTUx1bzlHeTR5?=
 =?utf-8?B?N0wxMzNJdm10RnQwdUR6blMyaHcyQ3ZLTUI0cHpEaFAwUjNrM2JjSG9ZZHhv?=
 =?utf-8?B?MUZ1dThSa3QxMW1KclBlQmNZVDNXRm9vYkhoUGlZRjBHWDRKazBQaC9aaUhu?=
 =?utf-8?B?b2ovT3dpNUNWMHJBM21Od1BKams5alc4dVBublM3Y3RBakRFRm5iUkg4WFlM?=
 =?utf-8?B?ZjhiQ1BoL2d5aWplR3FrZW1vZUVMcVdTenUwWGV3THBoL3NDN2RZQmRENHAx?=
 =?utf-8?B?OTlXQzNCOThvYUZjTkZYRzBwZHEvSzJPK3U5ODVSMlpvVGppbDBld1VwTTY2?=
 =?utf-8?B?NEY3eW51VFdJeXM4Ly84d3QxY21aeGZZTlByRThhSnFrYjMyVys5RWt2djZQ?=
 =?utf-8?B?clp3MmlMclBEMUQvNEdXdndMWUp2M3ZBSTVvcnREeWxrUXBmejJJM3BwbXNw?=
 =?utf-8?B?MlVlUVV2a3ZrSmdPdU9Eb1BWeTZKKzk0cjUxQXBURlJxYXdpaWFJU2ZQTFFH?=
 =?utf-8?B?cytQZHJoRER6OWRvQkI1NlVtV0ZDRFc5NmJuQzFQZXlobmFPZUNwQVkza2ln?=
 =?utf-8?B?dzhPbDY0djJlVjNyOGVKNHRhaDJScUFyeEhSMDlCZFhoVGJHL3N2NDFIVnN4?=
 =?utf-8?B?OXVNcHJheU0vd2xnMkZDK3NLaVhla0ZTM1ZuNmQ0RmtBQ1hncldjcHRVNisz?=
 =?utf-8?B?NGNwWVp4ODhsemZIbVpKWEdGU3lNcDBDNlg4a1Y1dDdaTVZLV2RKdERKbmFl?=
 =?utf-8?B?TjVFV0tmTzZieXpKS29PcHhiNWVyNGdleCtycldZMEMxS3VudEx5ZGxBU3ll?=
 =?utf-8?B?RTYrbVVnZDM2Q3Y0YWMybTZiZUN4R2FacDRWbkkvYjBsT2Job1I2M09LZFpk?=
 =?utf-8?B?Um1VRkNTV0x6a29MM1ZGT2RWa0xBLzFnT2hLWmRHWEdZeGNPZVBHcHJsV21n?=
 =?utf-8?B?cnFyS0FxbGxMMC8zQmRGVC9EdnUyM2xqenBEeWEyeGhZamNwL3o1c3VlQ25O?=
 =?utf-8?B?KzE1V1Zlb3JlL2tIaWE1cndyWDFoS29lRlFCWlh3NWhDUlkyL1VSRDRTMTBm?=
 =?utf-8?B?SmZ3ZVpydlcrSG9oanVHRHZBMjhuQjFxNDNHMUhWTmZtS1htYlpZVzBLVzBP?=
 =?utf-8?B?VFZxN3E1aUxON1g2YXZycG0vQVRKRzUyM2xyeWx1eDIwTVFBdzVYeEdMd05W?=
 =?utf-8?B?UGlJVk1ObS9LeTdHVFRtdXN4ZWlvREJ3ZnJKWGZWUGVzTjA4bkllMDZLR2Vw?=
 =?utf-8?Q?n715dgR/Pws6Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS92cERUN2VlcWNreTVnYXpsSitqTGY3WmtGeE8xc3NBMHNDd3hyZHNyRzE2?=
 =?utf-8?B?VFo0SEpHeUsrR1Z0M1pOT1kzblA0QVRDWXAzakQxTHJBRmtrS2cvQ2llM29m?=
 =?utf-8?B?a214LzhXN2l1bFFiSVhMS0xpRWlvekVZYm0xY1ZTWTkzNEgwenBRb0dvQUlV?=
 =?utf-8?B?YjQweDNOUTYvWnZFREs0U1VoOWhLcitabkJPWTJrZ1hKanRjejhVWFN3bXdl?=
 =?utf-8?B?UVc2blptL2ZEZndkR3MrbGRZRkVxWCsxWjFOV2RHLzdocWRYa21ja3I5dW9h?=
 =?utf-8?B?Q1RoeWRXTkF4WDFFNEZnNldPR2xvZGJ2aFRYVWt1OStUdUY2U1gweTBnVTBp?=
 =?utf-8?B?eDludnJSa3R4TmtneHNESnpuVUIvdHlLZWF5WlBWVStxaWd6SlU2NFU5NVBj?=
 =?utf-8?B?VDFEenJVQXBvY2tmdkRsRjUzY2lIbjdSRlErOUFjUk9YVDhUNm5UV1kvVS90?=
 =?utf-8?B?OXdnenlCTDNlODJMNjRzemJ2YzUyT0g2U0hlWm1zaUFCOHhidmRYWjZIYjNh?=
 =?utf-8?B?MXRiZGlSa3BFYk40RFRsZjNKUVdoV2h1MWxyQ1JlbFBidGNqTzNWZThUMUtB?=
 =?utf-8?B?eHZEbVhrMWhTeC9EY2pIdFgyR1ViR3ZhYjFTNHNGeThyTkIrdERmeVNPUDVU?=
 =?utf-8?B?QzNNeWw2ekJKdUR3QnNpUTBIQ2d6ZDRwb3dON3I4K1BxQlE2dk9KNWovUmly?=
 =?utf-8?B?TDhKekJDVlVFanBoS0xmTG51VTB0U09xaTZvelFlWDhCOEVtY1YxTDVEcjU4?=
 =?utf-8?B?dGlrb3VsSTU4dzQ0QVQwbFcwRk9ERjNNc3k2MmNTcUYyVGNBSGtiTkRNczJ1?=
 =?utf-8?B?UlFEMkVSclZxWEtpSVhWTnlkelZBK0hLUEIxWlFoZDZKM1l6Qmh4cnF6U0FM?=
 =?utf-8?B?YVh0L2t5cUZ5R2I2MG9kNklHZDI2TUFORmc3bXdVOVVtazNGellKV2REMXZK?=
 =?utf-8?B?MUl0bVdWZEt4cG5rVlpZUExCL3B6TVcrMVhGVnoyek1LaDFwUHVDU2xmUlJo?=
 =?utf-8?B?TnBLcEJVelZxOGtJV3k3ZnBTU3BlRXRwakFWRzJFSjg0UHNtMGdxSmNUeW9G?=
 =?utf-8?B?QnR3aXk5S3FOc3Z4cnFWQ3dZMmJBcWJ2dU9iWUdwMGN5bW9jdEx6c2lxRFQz?=
 =?utf-8?B?U3dpUEdScTNZc21lbkZodWF6UVVzZWU4TEE2ZXl2QmVUUVdwMVA0dUpCRzVX?=
 =?utf-8?B?eWc5VWtsZ0h5Nk52ZVMxMjhxUzdxcjR6akVBZGZNYjNFUldiWmdibHN4aS9K?=
 =?utf-8?B?RVVpQTBvWjc4bUZzejhkNG9sS2JGQkdFRnkzSjJOVXk5YXNEWkxDaVlXbFo0?=
 =?utf-8?B?MlhWUW04aXlZYzhwUDNaaWVrVzNSWVBQeDRTNFVwSlpNWnR5WVZrWEdLTWZD?=
 =?utf-8?B?dXNteWUxOXlaSjlDVDB4cmVaSGdoTEVOSGswU25qWFQrZE50T3pXNFNVQjFm?=
 =?utf-8?B?OGtNSW1QT3FzMHIrazFxWUs2KytCL1NEWHlpaXVzT3B5SmlWUEZHRUJMc0Vt?=
 =?utf-8?B?M3FYMHJWQ1oydVFib0VwQnh0WEhrdFpzc1RPdzdPa0xTdnZVZjRPUFlBQnMw?=
 =?utf-8?B?dVA2c1ZBUE5xUU1mMk5sUC9GUTY2OEJwVmFyTDAvZk8xZFFrbVROMk1LZFJF?=
 =?utf-8?B?WnMwVDQ5TGZLNmFJUGR5QWJFMDlkbnN1STkvUjRDUE1XQ3hzNWRUaVJ2M3Qr?=
 =?utf-8?B?bnBHaUpMc0tKbi9Nd1J2MmJtYURmbEkwZHNuL2drS2FpdUh2SnJvQ2l4UGR6?=
 =?utf-8?B?VHNXemtGYkNPUk93VzVkMnR1S0FmTmxUY3FSWXhLdXlHaWhIR1g0QnJZWXl5?=
 =?utf-8?B?MTdsVG1CTENpajNmTmZoVmMzaUJLT1ZLUXVpa3pkdlFLai84bU40aXZmblNp?=
 =?utf-8?B?S3R4dk9oRFNFaUF6OUtYRjdEYUhhSG5rVy8wVCtwcGkyckNpNDdwN3dsNWdx?=
 =?utf-8?B?blVsaWdtaitQYmRUSWRHb0xpWlFINUQwN09VOHEzOS9nWTFkRVV1V1lROHRL?=
 =?utf-8?B?bXFVNnRvKzd2VFlxbFYxemlodHh6VjY1ellvM1czZjRRVDFEN0RKdWNWaytw?=
 =?utf-8?B?MFJuOUVSb21DVS9vbkhOTWZtcmVUZ0s5ZmM4SSt3cS9XcWlUSEJvMnBQMlN1?=
 =?utf-8?B?eFBKdDhwMHVQT0c5cVA0NE5Qd1hvN01DUDkzU3gxR0lYNVpHUk1yenArOVFw?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6OM1AttF5u4iXxsEYxMsd8ngeovCG1Ii2NGMmt8Qu4MJST7y5nx8TmqW4I3PV7FxKUSsEQ/GI5yyZZ8MRsiI193wJ5zXHJICkoMpfo3pEnwxz0/lNrcpa3bAYewQ5BdMsgv5lFoXTcFXnEVfHCTlKfaSphgs1wioEfsyGGlWy/WP3Qji6vOdWDvLtBWOZLiTkAz0BBUQDcani5x/vDpwNc6qo+2FO05maCc0EeNGpJAGyRz351Uo1y+cLShMcbbV/z9hNokRcdRa/h+iJCaRdajxxmbMrNyJR0mLixAZVB6aoabu6FlAF7tKmNb8QquW9hg+wcRWgVkH8U8/LVS3thhUmxBkqyt6kFO9jHeQWrbULQp0UIpwKbKihK0j/9RpotSzY7iBYLQc44umAWAQzqHvXSxenCOPqliZEL3MVlz9YD3Ecpn6xaDMESE8igSXWEHE4CcuuOtTAMpBQ20JWSg8nmM1IbkzpifHg4/G4v0bKgfjW2ylw2QTgC9CdmjMZ/PuFMg0vffjiSBXENSUNL0cRF2d5rRYnSY4dXRwi2tPNKuSe70ksKAP+1A1ncF9qdpNWvSc7S8RDhhYIH7F2pkhGoiNgGz+VIgLm8ZKk64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e3fc21-3fe0-4c6c-2a1a-08dd67bfcff7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:59:28.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEZDGFOkAxlHplpz/oGRmTzdd1no6moj/PSIelX+rI5r6GeIcei2FUegQuro1+JspkTqreLeS4MKldRxQfyi2mdrPlb1tYAqLTeN4qy3y8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200093
X-Proofpoint-GUID: bujz-eRbHumFhKu0uM1vwtuLbD8xMCGp
X-Proofpoint-ORIG-GUID: bujz-eRbHumFhKu0uM1vwtuLbD8xMCGp

On 20/03/2025 09:20, Jon Pan-Doh wrote:
> Decouple stat collection from internal AER print functions. Prerequisite
> to add ratelimits to logs while leaving stats unaffected. Also simplifies
> control flow as stats collection is no longer buried in nested functions.
> 
> AERs from ghes or cxl drivers are a minor exception. Stat collection occurs
> in pci_print_aer(), an external interface, as that is where aer_err_info
> is populated.

Hopefully, I'll get my patch in sooner than later, and the second 
paragraph (and the related changes) will go away.

As for the first one, I'd restructure it to chain all the sentences 
together. I'm thinking about something like this:

"
Decouple stat collection from internal AER print functions, so the 
ratelimit does not impact the error counters. The stats collection is no 
longer buried in nested functions, simplifying the function flow.
"

All the best,
Karolina


