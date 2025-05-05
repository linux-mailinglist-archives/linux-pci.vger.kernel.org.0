Return-Path: <linux-pci+bounces-27145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616DAA906F
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A41C3A499C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624C1FF1B2;
	Mon,  5 May 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQv1BocS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BmebxpIL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288A17A31F;
	Mon,  5 May 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439154; cv=fail; b=lNdeMNTBhoJ6rDYLxzAszr66xYwCak536sEkP/baaD5WOjg+mJ7C27+quw6xb0CSskMi3DoyX9n+yd+b0M0AqjQuqBoGNKkax8qUbOEZ0ZS7cVcVqRvVn/VXBk4YhYZ4zPT7RddcCSycmDjcQN625S2TZjlINJI/mVqC1SekEjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439154; c=relaxed/simple;
	bh=/34UqBoUsmgqSOK2verF/rZGk0yv8lumPkAiU1inLbs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m7aq/9mkryLKjYuMkM8m0p4J9j9ioLne+y/sEUM+G7T5nA7RRePv7TzfPYw4a80I/jOl4nMuiAf9beBLOkE4UgHRv5/kUpLUA9z4SE5wb9iddTPiECgmQE2yq9EWtRKxDFJvtq6smEe3bKdbRVuX5oJ3pi52ZGpC5Kh2F2pbFhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQv1BocS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BmebxpIL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5459bfUM006124;
	Mon, 5 May 2025 09:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qlYWGbPloTD6cWkt5xzFeXLXVkFH5IGYgmudhC7wbNI=; b=
	LQv1BocS8/aYt1iMGhKqF1F0qH+MMc4WzLyRSq+lFHM4g7EkJBR6QDncbCe8dN0f
	0qE9jPky2MkaHeGoOHSCtn34NQnYuj2tnh/zRAwu91eGtH3AfJivro674IditJ6V
	0np07o8NFDiWjjKyKYFcT/VVM6Mk345aXbKmD0L4cssvIcSeo4+k+DPjItNIZh6g
	WDUjrSxZdPDecQHKrtM0YmMpQv0i0tAZfTQongfox+/6WmlEmVVwC+wAX1h+3IGI
	p3RHF8bmyEXQd8u8V+/otMIkH0Rae87XelpX5vSHf/zD1jNuOKUHBDf05idULOt4
	7YqGSIDvrh/Y+AIFIKpqjw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46etuwg10y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 09:58:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5459DMNx036063;
	Mon, 5 May 2025 09:58:34 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012039.outbound.protection.outlook.com [40.93.6.39])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k88ar2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 09:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2360xSs7tXE+M/OKzBS2A9YnM1szO+VAPlfvasftavAXJ92dK/K2+fSuofH8TmiCJ5d1M/BoRvZI12q1mN0+RVb6JuOdf2QiuZwnETcQTm8Te4jlFO6zlWfDEE4g/L+17JAcTDe0Yf4Yy1Q/ZEZPpr0pRMSFIF3Pe/TDx1af6Om41hQLyCgLyqVHd/KcPW/uv80mYuQmyi2Ykdhv4q0DCQpxKiURK9YLVtcM9fqsUSBl5D7DsQv4ZMZnvb+ysoix9coMEQLEBk6X10Kab72FIaihUZSjgSHMq48OvgP8qB/ZpfIZyAbJsQk7LkVYyc0aYeg7mdY0wSYnETE9hHWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlYWGbPloTD6cWkt5xzFeXLXVkFH5IGYgmudhC7wbNI=;
 b=UAksfuUuh6p7wBrnCoA8OWShR1/yUMU3WScOhxJviF60ljtSvoww2CXiF067KNwHlALbUA3w8NXD+BQ0QVMVBnkrRwJpPdJd3485qaP0JUvHcRFviBcSXe1t+4wyLibTZgL5yPbhxQGT+leo6rp0nq/NNhqCA+3TkBQ+gUCzQc/GZfzhvyky2xMUkg/nXEcGjBSkmArbmvxTgtCmRlwzPArAUlhTnn4VPa/FfTSO6NfZTlW0FaRl3tFBfUCuskd8A26+3ykdR/X4d66U3rlABBWM4/GBSiO5VyRS3JmtJqwDsOQzLzmiYNb3nxKiBjEhcSPH8b1WnS99E8HcKQ9PSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlYWGbPloTD6cWkt5xzFeXLXVkFH5IGYgmudhC7wbNI=;
 b=BmebxpILldIAjcTUnS/2ka1o9shuY20zUDxG27J78lScgnqkZTbXhM96ar4+5KntvP/EOt3zOVo+I2Txuu2FPuUVnVCMW8cmUA9jGBtmgAV6CBq6+EchmwieQzK9wJgNwypZe5Y09XmiuUkkHsSF32gtnXl+QCshvT3kpdiE8p0=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 09:58:31 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 09:58:31 +0000
Message-ID: <1fb6b57b-4317-404d-8361-19e1c3bd499c@oracle.com>
Date: Mon, 5 May 2025 11:58:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: "Shen, Yijun" <Yijun.Shen@dell.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250424172809.GA492728@bhelgaas>
 <61d3f860-9411-4c86-b9c4-a4524ec8ea6d@oracle.com>
 <20250425141401.0000067b@huawei.com>
 <0f4944a4-fd05-4365-9416-378a7385547b@oracle.com>
 <20250429165410.00002c86@huawei.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250429165410.00002c86@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::24) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf4e75f-b71c-47e3-9751-08dd8bbb6457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R05YNlFNd1EzSFdQVkhyMGJ1U0ZISXNmVU5YZ2cyOGJzVmExVW94MXBOTzdt?=
 =?utf-8?B?bURlcnZZTDhFc2dpVmJvQ3dHaG5CV1lnazlhT2ZpOG9tcFExOThpUWVUNVpt?=
 =?utf-8?B?K3I3TGNZMzNxd0V0REJZYTAxV2RRTTNZdWp0ZnNJUE51ZHB5MjgrWUR1UVVY?=
 =?utf-8?B?ZGRzL3pYV1h6T2VNYkVKVnFEY0ZESE5CZUU1M1Fybyt2cFBOenFEWWwrMWF5?=
 =?utf-8?B?M3FiWEI5em9HaUdpZjZuTUNmWjBNNW1WMWFnQURENzZKY0hpZFlsbnpsai9m?=
 =?utf-8?B?aGZYQmxjRlVHQkQ4TzFBdzcrZy9ucUg4Z3ZOSlN4bFFpcExuUWhEVFoxcExk?=
 =?utf-8?B?aHNoKzhGNDk4VVZja0pNalNjcW5NNkNyK3RHdlVUN0xVZ1RxM1B6M1pKZlJ2?=
 =?utf-8?B?VkdXNDNXNTRyL0FxcmJhbXFaR0ZiV0dLMmZjZ2RUazk4dERvajRuL3B2aVEw?=
 =?utf-8?B?NzVsVVJOL29xWjlJYjQxZGtlZ0RMaXdJdy9nNWFFSEIwZXU4amRKdEFMaE1X?=
 =?utf-8?B?UGd6aEI2SDJnRWkzNFEreEdzRG5mSG9zc2x5ZmFZL29lTkJjOXFxb3Y2OWRs?=
 =?utf-8?B?ckVMSmx2cFBRNXdVeEk3cFlFVVBLTG5kSFNUbDJCaVhxTHAyeHN5a2pLVXRs?=
 =?utf-8?B?eEw1WlhXT0dRaVV6RTlVMDF6d0h0YzBUUDlBNm4rYVhCbkZyRkhBaFhwRlJp?=
 =?utf-8?B?WlJPWGZpRTRUUU9RQytjVE5nelh3b3U1KzRraGhnS0xIVjR3QVBJMXJoRitQ?=
 =?utf-8?B?R1NYSHJtZ1BtQ0I5Z3dHaGZRTkJaM0FRTG4wd01vdTlmTDdhTmdUbDdvNTh6?=
 =?utf-8?B?a1Jpd0dxZW9TYlpaeGovWlo3akl4VXVtRG9lNERlK1hpYWFEVFhGSW02YS9N?=
 =?utf-8?B?b2dWS0tBem4vMDM2WTFmZ1gvZHd3OEdiR0d0OVhkdXZ1WHZLajJUMzZKN3Mw?=
 =?utf-8?B?RDYxNVNMM1dPZjMwVXZUbmVieHE1WDZWaHl2Z055dEIycFk4K29ORVludmNk?=
 =?utf-8?B?T1YwT2M3YjRPb1pJeXFObmZSVGh3ZWtkYThrYmZyZWpZZlpMdEU2ZEN0U20w?=
 =?utf-8?B?TWtiUmgvYlZPVU03WkpqNEhKcTF2SiswYmIvbDh0aUlIWnBWanZTS2FNbCtr?=
 =?utf-8?B?NXN0czhjZWs4U3dhUlNDcUllcThuQjFRK3VtN3gvelhERnVEL1VHZFd5a1Ns?=
 =?utf-8?B?VCtXUVhXWnllUFNwcVBEeEFDTUloUUdBK1VCWEYwVDB1NGdCbTU0ejF6VFNO?=
 =?utf-8?B?TWM0Mko0UW9tRXdYMmpqeTBWUEtJc29zUUZQM3RTa3E3MmFqRHdXdUhZTzh3?=
 =?utf-8?B?QkJYUVFTbGJRd0dvSEFub0lJOGc2TlVmRjFzVWxBR1VQRjZpZ2JQaytHcTJ4?=
 =?utf-8?B?eDZnQS9UQlNtWFV2VWw5S1l1QjdjK2pQS0pnQ3ltNUY0NHBtOTNOSWdyRmJn?=
 =?utf-8?B?YlNwOW9SZTYrMUJRYmhucWdIZVlZOFF6ZFNXMzZRR1Nnd1BObG13RkdBUFpK?=
 =?utf-8?B?YzM5S3M1Q0VnMUlZazI0ZlJnK2pDOGFWeCtyVk1HdDJYT0FzNGZjVmdhazk4?=
 =?utf-8?B?MFY0ZkRaNjJOdnRkN2F2aGJjWGpFN0I5UGRnK0t3Zk1oZTl6WThBc2hVVU9j?=
 =?utf-8?B?cmNHRURnbVVpT0VDbGZHZGxXTzJZdFhKQzBsbExkckY2ZHF5R0VqUno2YzV6?=
 =?utf-8?B?UWRzL0FhMGFpVXhoRDJBakNCNkJoQ3BvbnBkR3RmdklTYmdvMnVBOGx2alN0?=
 =?utf-8?B?ZFAveHpBZUZ5RnpXWFVQMnorajhUOWQwcmFNMlVvK2QrYmYyRWYyRE52akNM?=
 =?utf-8?B?b053aFZWTW1idXRJaGtBdk4xVnhJeW5sT2EyRTVENUpSOHM5Q2hrZ1ZTRXhs?=
 =?utf-8?B?aUdNRktDS2g5RHVoT2lVdyt3NEFlNC9FSjJKeHgwMllta1g2RWpRSDBBQWRL?=
 =?utf-8?Q?KGbupEvXjRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzlqcjBLdUFUa0ladUUzNUJPdTk1b3RNYkt0M2pBSC9rNi9jSUF3eURYeWEy?=
 =?utf-8?B?SU1TWU11N3RwUHJmc2RTbTFjMjNTWk5iWFd5cUl4TUFRTWFCNy9UMEswVmJI?=
 =?utf-8?B?WG9aVjJycmQxdmw1ekJ6NzJiR3BSdUhmc1dPdmZtRk1QcElRY3o4MGwrNzVR?=
 =?utf-8?B?U1ZrNWhrTGg4d3k2REVRajJhRmhtcDhFY281YStkOHZDeUl0WlJIdG1ZVjQz?=
 =?utf-8?B?empZTDQ2WmRRbURnMXF2LzNLWkY3elNucXVvV3dnQnNCTEEvTUpFZnVNeCs0?=
 =?utf-8?B?ZzJCTXdnL1V4OTRXb1JTMlhBaHVNeDZseVZwVnQwYmZlaHhRa3VsUHMzV1BI?=
 =?utf-8?B?aEFFKzhwNzJKdWgzSUR2S2V1dEp4bzJQTTNOOEJpNlJwKzhDZEJOd0EvOHow?=
 =?utf-8?B?Vm9RSnZLMjF4TUd4aGtDR3dGcVFRb0xuVTh1REErYlZmbVh4dFZyN0RGRkNF?=
 =?utf-8?B?MDc5dXFuL3BmWHFKcjZFUCsyc3krUXlmWWQremhGbFdjb095a2NJYW0rNVJq?=
 =?utf-8?B?OExXZ0Fad2RpVmk2Um5oUk9Cbm8vVGFPTjNnQ2RvN0thcGM0K2JFVW1qckRR?=
 =?utf-8?B?a25mQTVrWXYxemt5QmxqaEVIZE9iYTVjZ0U4NEFMNEtuYzBDRGtObCtFa0d2?=
 =?utf-8?B?a2xjVkNRR3dRRWNDVk9telNVTiszYVdlWmRJNnI4UVF5dEF0RTJVUWlYL2Q2?=
 =?utf-8?B?Mm4yUS8yeVFhZVR5ZG5ucFV5b1Z4Q0cwSXhMdDhPaEhEaFo5Zzd6dEtmaXZ5?=
 =?utf-8?B?ZFZCT1g0dTFSSStXZmUwYnAzeS9mZEFYQWdkQ1M2dmdjeWM3MmF6eU9WTGFV?=
 =?utf-8?B?TnVEK1RPOXM1ZzJnd0puVHNCaFczZ29VNjZ5akhId2piU25iWDI4Qnp0anhG?=
 =?utf-8?B?MzU1Y3Y2VTZ6SW1TOTE4V1NNVlFHVkpaWkhyNlE1Vk9zNkdoeUlDdVZlTzFT?=
 =?utf-8?B?UUhZbUtUZHZ5YjdVeEhieVIzcndINVd0eXdOdEdLYnJLdHVJNWtleDNOTHJk?=
 =?utf-8?B?RStKeVFLTW5VWCtPL1FIWVRsVTMxNUJTRGlRMzVvK1NMbkRpcS9uZklTRUdI?=
 =?utf-8?B?T2c4NlN0VjhmK1BneFhaa2tVeEZoaWl3alJWM1hidTV2MjNzb2xZK3QxT2g4?=
 =?utf-8?B?eHBVSmFERFo3a2FnM1ZzU2tQT2k1OGlkQWZ2WjY2Y2VSMGFQSzJEbEF6VzJT?=
 =?utf-8?B?Vmh0OVo5dytHSUJUVFVkUlh0RWdYTldRcnYxOFFBeEc0MnVnNUJ0R2tmREc5?=
 =?utf-8?B?TTZCYUZtdXNqeVlFS0RaZ3Fqa0J3dlFINVJZQnVpTUhvYi9PYlNFVGNRc3Fl?=
 =?utf-8?B?NnNtWjBXeFNmOFR1TGd6cWZYNTZKcVN4d1ZxYXJFUE9XRmFnS3ZCRUIwZllW?=
 =?utf-8?B?cFBWMzdaOW1PT245STM2SmRSU0FQUTI3dGRmdFlmMU54aGdvZmEyNHZoRFdl?=
 =?utf-8?B?TWIyQVlkcm1GQmF6T05tcTY5cHpQeDBGMHk4aG5BV1JGUjZuT29zc24yRXhs?=
 =?utf-8?B?cTRnU3UwOHlrcE1UUUtRWnJKQ2ozcVRySHJRSTFGczN4U3FReG16RXdBNGNs?=
 =?utf-8?B?djlOT0VIeWRtU2NGVnZlNTJoeU44UTNhTUxmOCs4YU4vemNLV1ZvT2VyQXlw?=
 =?utf-8?B?NFBxZHBjeXVNVEdwWEhkSmpkMDdCOGNrUjkzaHdVd2F4aloyNDZ0d09aQmNm?=
 =?utf-8?B?WDRzY01aT2UvbUFBaVRkTnJHS28zYVRqRFpNODBaOUlWSVhmRDkrTko4bnNI?=
 =?utf-8?B?VXh3aHNWK1E4NkloSnJDRUxNVU5jcW9Qc0ZwakZQQzZRc1dqc2dvUlNzZXFk?=
 =?utf-8?B?UE5lZnFLV1QvK1R2dkoxYU8yM1hJbWtMRHprZk5qNytSNkhEemFONzgydTh2?=
 =?utf-8?B?N3RUQzU5VExoQW1MUytrYmRlMVNTR1VpQlRzK2VnZGk2LzNyZE16N21WTHht?=
 =?utf-8?B?aDNRYVFGbksvbCsxb1hhbjNZaDRRcEtRYUZDL1RWeGxwZGZKSk9rSC8rMDNK?=
 =?utf-8?B?MlpsQTV6UW5ZV0p1SW9XTUp5NWxEc21sVDd4d0MvaWM4ZTlMUjR4L2h0Q1cw?=
 =?utf-8?B?bm5DY1I4d2RHR2RtRWlDMjRWNVVibTBkZmRleE0rQzZZZ3paU1NQY25zUVN5?=
 =?utf-8?B?VWlXSzhNbk0ycUpUdFVLOVFpa3JzdmY1NFNFeExxbFg1alJkeVFtcVVYbmVk?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Frsao0H2SvdY9hjMOYQCdWBTReRphWQI8/0rlphAjRjZbazyiUH9ogkNynw0uMlLPPud1smpsetlBd5lUJt/bBgUWzYSog1vZ+O4YPjkwq3YuKVhZyARAGl65K+rtz65bKUotNws//WHAvMQA5EoUKb+iXrBo02Y1fr+db0MvCZ1ZuDnG7rOv5m3O4BXHg3dDXgMp0ItVTjexrWkWmkUMuMKxt/FXYwI20niKjJVKlVp8kSG6T1GOJ3mbk/lZQzTpHuutiSi4WDhLXqtUl4yUPG3K0h3r7Sz7ZtfuofS5PHa1sBwbDCJsy0A9vbvX/kwFRs6tpSItCOEtxAdmE83jP/izAF9tET25EYEZ6WUGT4D6wduxQ0yVIja2gPY4S68+fTK6nKmkPBDiThDVxAX7y9EPaY9BVF50LL4r0H4yTiDibuMwmL3E3QvhB/d6P2dvdiW2/okW1nSxIiMWpzsnY4s0F8RjW/W1+nsPgRrtc4QN06N23PotvcemTzXkbpStoIOb7LRjhthSyC0NtQUROZeV9J+zS9dL6QDSowAoTzqZo8Mik+c1Z+2lDmsNFiqTxNfx0fzfPlXGq4Hr/hv7/KT6B1XBgsylHxBiqIHrPg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf4e75f-b71c-47e3-9751-08dd8bbb6457
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:58:31.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9YIqVt11TqPJF//yQGYzFxpqRCaOvHs/8mInfs4VydQ/eov1sSmd4wom2POF6cZZq4mHvR9k5SAtAr6UIk+5c7FF+IRFlYhXXWnNkBRLxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA5NCBTYWx0ZWRfX3jZrJbDPdvsq Bji5VcyZ7AxfBLRapIdyfdRrRB6BYk5aKRxPAIVVdaULZ61zuDlGxaRoVFy9+yDnRAOYxA6aV2g ra3un+G+XA2h/mxC7nD3GE7hNexhWG9iO7IggEccN9imJyFWIND6+1U19KGgLx26R4a89jH3gkW
 euan8lsCeckiYii8kQH/BwZoRP7k0TRTWP62pRg9VOlP4Ouri1TaQYQJFcVi/eC4IhV7j8eUa+y QzplBzX9BH8QTfvcRQJ23KoW36dXplQPpMlAGtVtLzrgreacD7i+rd2LZWAveOxXhcS+pt9PNeE Sm2UAmm9PYloZQI51gLg17Z+yp2odt3mvzvL2+sOZ1n4KFqlmyfjBk+mw4WqkxX4Kbkd4xUvk3p
 sm3txRHJVXULlSyOgagiuA/cLiWMKgnyci6gz1iMr1A1ytkjKFTjE+HBZw4JaSWm0FhI6s4g
X-Proofpoint-GUID: s9564EZuWF_tvkq8dbIRvGlYgRMYLT2j
X-Proofpoint-ORIG-GUID: s9564EZuWF_tvkq8dbIRvGlYgRMYLT2j
X-Authority-Analysis: v=2.4 cv=eNgTjGp1 c=1 sm=1 tr=0 ts=68188bcb cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=5pG2b1FMK3LYbF3W20UA:9 a=QEXdDO2ut3YA:10

On 29/04/2025 17:54, Jonathan Cameron wrote:
> On Fri, 25 Apr 2025 16:12:26 +0200
> Karolina Stolarek <karolina.stolarek@oracle.com> wrote:
>>
>> OK, that means even if we manage to inject a PCIe error, AER wouldn't be
>> able to look up the Source ID and other values it needs to report an
>> error, which is not quite the solution I was looking for.
> 
> Isn't the source ID in the CPER record? (Device ID field) or do
> you mean something else?

Ah, sorry, I got confused on the way. I meant that even if we have the 
Device ID in CPER set, the specific device has no data in aer_regs if we 
inject an error using the GHES error injection script. We probably would 
end up with !info->status in aer_print_error(), thus printing only a 
line about "Inaccessible" agent and return early.

>>> The aim is specifically to allow exercising FW first error handling
>>> paths because it's a pain to get real systems that have firmware to inject
>>> the full range of what the kernel etc need to handle.
>>
>> Does this include PCIe errors? If so, that probably doesn't make sense
>> to try to test my patch on an actual system?
> 
> Ideally test it on a real system as well, but indeed the intent is to
> allow testing of PCI errors on emulation.

I understand. Do you have pointers on how to inject it on a real system? 
All info I could find about FW error injection pointed to the qemu 
scripts I mentioned.

>>> x86 support for emulated injection is a work in progress (more of a mess wrt
>>> to the different ways the event signaling is handled than it is on arm64).
>>>
>>> I did have an earlier version of that work wired up to the same
>>> hooks as the native CXL error injection but I dropped it from my QEMU
>>> CXL staging tree for now as it was a pain to rebase whilst Mauro was rapidly
>>> revising the infrastructure.  I'll bring it back when I get time.
>>
>> I understand, I saw some of your series while looking for ways to test
>> my patch. Thank you very much for your work. As you can see, there are
>> people actually looking forward to it :)
> 
> Great!  I'll try and get back to wiring it all up again sometime soon.

Awesome, thanks.

Bjorn, is this patch blocking the ratelimiting series? Would it be 
acceptable to use public logs in the commit message? I'm asking because 
it looks like there's no easy way to trigger the GHES path, or it would 
take some time, further delaying the ratelimiting work.

All the best,
Karolina

> 
> Jonathan
> 

