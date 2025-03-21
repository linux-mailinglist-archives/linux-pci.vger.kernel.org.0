Return-Path: <linux-pci+bounces-24352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC6A6BC39
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F763A97A5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58078F29;
	Fri, 21 Mar 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oA793Umm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wm9nhHSU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0284D13
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565440; cv=fail; b=GyQUoPqS4Gf+mE3oe1tWJEs/V+2xi2/1QCW/w3jiEd61NMGmpkbr3HSLUvwV0tA3LNRx0lR6RqmiCYTvOFmq2rq1oCeXdqo5S9iEMgTMSseLEkszJYocMkwPxrwEZqcctuMUKeOQH2/H6ovS7bntJKHj3IXfPZ6jku9CbNpEMeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565440; c=relaxed/simple;
	bh=Qs/yTve8HuRtLt00yshCyPiOTBHfnmglfL+IcKimPkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uQmq3wZf3y3rm8Kr3Sck1e9B6mhHEBJRGpNfzprOtJOYmOH5Aft6V7R/XY15B0HnzrV2f8wVnUsPctAMOakCBkpzHMXLUxzqHUEfzqQ6HyUoBGzx8vdtSO/ACCufjCi90pVR5xxhcP8AuGVYENtFjQ6hqZ39U4VDc2Nr/rzehDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oA793Umm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wm9nhHSU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LDggOr012353;
	Fri, 21 Mar 2025 13:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ctDHBHPxhc9hazJII7jVHE7QvPxZLmY+W8NQXqMolos=; b=
	oA793Umm16qEgAnfdrf5Zyx0WgYbJ4fhYAGTDVHQnU4xYBXAW3YnhrI0kqJ1eMOt
	LtU+0A8JzdhikI+2kBg5NAYP6hNMBc7GydT/DAhUNMMYJbHKfh9UWCSGcFL7QoTe
	NUR35xPCHap1vEALv8dmR1R7c/LHg6SCAv9puEg9huo6afLqPtSk9Arq6SPAkf6d
	AnG7isu+vxV86N5CrL7/JN4B3TU4xtyRMi9behojXcmsUcD8zZ+Hqs3hI0HK2I8l
	ry94a4b1HFUBA0x+0Ohush/wxb+4DH+j+Hx45ETIkTRl3KSm3gekK4T8zI6Pgo7n
	Lkx417HpIPFK+wPryHpLZw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka8ry2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:56:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCUCYe018685;
	Fri, 21 Mar 2025 13:56:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdqg76m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:56:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSDDj5NvXbX4ItUOEaXGJyeBspZVt+Ouw9K6Dq3QEqPeH8T6oHiAZTlWk8t/cYMh96s2xDzRmcN+HagdU1fLzztQW1JJFZ0sShvsEoO4+X9KytecTfpUmbHn5ZYaxHNN0QGHt/CaoToTjYFaxyCsMo2w26y1WdMZXMcV1SJd5rodpcXNm89pa0U/KuAHVk9R7lqalrYU/1gQXwXZtwPzKMh/1PtPmCd0vIpjZwnanQ58RXq7IxHX6YJ/KEtK6bznCIKRaXr7LDrExvQL2JxHXcZlXayVBUhTagc9ddxA8VYJ6IWVqRySo0UL36GFyEGA20m3S1gNzcM9QuoHnfYqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctDHBHPxhc9hazJII7jVHE7QvPxZLmY+W8NQXqMolos=;
 b=cH992X3y8C3h4fbzN70WpFlEHWsKPrAMSweLnAZbzrPEj7DBvf8UUF9Pr/ZLYD1ljJXE0QaRYtwI+rNGPo+YbqTE1WEpu20TozSAQb4vW1nNHn3ff9qE3HD4dnR31bAZV6IlBmrCXCaTIJn3fBQIfWhOEXzrwmRgD3K3XLrYNDJGow+YADyxMCzkSjH0WMs0rTIlS/+CdSd+dwGkU4SmORxxLvVDf9LXATp2ycUy6n7TSFU6nrRaLihiS4Idd260rxr9+cummaSsOKlfRHZ2dxUE1WH/Tp8laxsrJEn1mYoYE/YR+SdKmcAI6lSuSWpBCGYc3b1jH8CEUxqwJefm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctDHBHPxhc9hazJII7jVHE7QvPxZLmY+W8NQXqMolos=;
 b=wm9nhHSUhEt27r1VmQJn55vdhyozSh5nZskn5rt+xaPNmO1nXY0y+90FAijz8yC335C56kgNOcbsJaIAOD/tz4qQPSW9jxJa7JxLdv70VqZj0FiFmhpEdKoEortoGD68JS5lju5UFj4eqkazjpZNmHnX/Orpm+II9udHWZTAgXQ=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 13:56:23 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Fri, 21 Mar 2025
 13:56:23 +0000
Message-ID: <457b32f0-b020-4a0a-a557-0ef8201cb6f8@oracle.com>
Date: Fri, 21 Mar 2025 14:56:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Consolidate CXL and native AER reporting paths
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Pan-Doh <pandoh@google.com>, Terry Bowman <terry.bowman@amd.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng
 <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20250320181736.GA1091349@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320181736.GA1091349@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::6) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SA2PR10MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: d0acea55-abb4-4408-65a7-08dd68802a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU90Qkp2RDZmZDNTN2p0VldUTHNRN1Yyb1RlaFBvejRIWWQrNkNzV0xreC93?=
 =?utf-8?B?eWFSRTNNanJoeER3NWRQbHVTSEdNNHRVZmZMdXp2VHZKcm0xVE1FMnllRC9i?=
 =?utf-8?B?LzI0d0RYeFZHeUVCamtoRVF2UXlJaXpDOXJaMiswTloxVS94dEwzVmhzT29y?=
 =?utf-8?B?Q2U0SUNYTEJLQzlLUTlCQW11L1d3TEVDeVFxMDJNdVZlejBHLzgvUVNjSm02?=
 =?utf-8?B?cWw0MXlPWlJmaTBTMU1zQVhPSlkxNW1ubkI4Yk0zSVF3K2dRTTd2aTFxV2VD?=
 =?utf-8?B?OUhQdUhTdi8zMnd6SDZoTUpmTURjVEVoSXBTU2hKTGYvLzAxVkJRMzNrWlVZ?=
 =?utf-8?B?VDR6WnljN3NNRnk0WWxEQUpKRjFYeXgwM1VjWWh6TGJhenkyVjBsaWIzd296?=
 =?utf-8?B?ekxReDhaU1J4cnBYa1FJSWt2TG4zMVJPYThHMERIM3FjWmphbXhTT1JVcFh5?=
 =?utf-8?B?amg4ejAxTmhaTzlXMUVRSXdEVmhhazMxa3N4TWJLemhJNW15TnVTNEZLSUtv?=
 =?utf-8?B?S3RJbnNJdUpDNTZ0NDFQRUdpQlhrdndKekdDSmhmRXQ3Y3ZQclJYTi9TODND?=
 =?utf-8?B?VWVLc1R1cFBYSWpTNVNSYU1VV3ExYmduR3hqenFzYWRWbFF4a2cvclJFQ3Nw?=
 =?utf-8?B?eGRpQUlETGNLSWhia1VleTZqbWVzU2Fvajg2N0NwTXNrN1pkQTMxblYxL1M5?=
 =?utf-8?B?a1gra2pIcVN3eDg5aHJ3Qk5CMThMVWFndzh4TGtVSmFIZm4ySDNqaHgrZHhl?=
 =?utf-8?B?cW9HOElDeU04WEE1ZGl4Vk9TdHRLNDN1am5xQXh1cTNBM3liQ1c4Wm56bVpZ?=
 =?utf-8?B?dFZDRThOOUdqdVFIQTZ5M0RKODB0QTFweGxNUjl5ZW0ybS9OdHVEaFBvTnAy?=
 =?utf-8?B?YlU2MkgyRWxkYTBWMDJOcnhZUFBHWlFMMmhnTzJyUHVtTnBFOWlKY2FaZ2ZH?=
 =?utf-8?B?SVpibnMxTXc0YjVvN0FZSUY0ZTlqQ25Ua3NSNVNWM0o2VEN6dlFoM3ArS1h5?=
 =?utf-8?B?WHEwMzVHQ3lYR0hVVzU4MFFYMFlrTHhRVFdpKzNuUkJQNWdaU2pPLzRSRlE3?=
 =?utf-8?B?S3VZekdMYzltd3RIUGcxZjFTOG0yOWJJU2lCL3FqZTJKWEppQlc5WHo0Q3ND?=
 =?utf-8?B?MnhvSXpYaHhKVFJIVURsWmpaQ24zMkZXdFAxanJESjJ6OGRaYzhOcXNaLzVh?=
 =?utf-8?B?WldSYmwrcTRXUGZqMXRDb0xwUzdGRm9mSVhyb3BXb1FXM2lncnlQNzdya1dy?=
 =?utf-8?B?YzlnN2VkVEkycTcyQnczZkhibG9BMmZod1c5WUNmRGdjVENMMWwrTGJtZVJz?=
 =?utf-8?B?MWhZTFpqa3BKOFRKcUFRUzc1NDM2eXRzZ293S2FoZzZHdHk3YlZHM3lpLzVS?=
 =?utf-8?B?UUZwRlFPZDFsVjdoTW9sdThmVzh6WE02VFh4aTNIYkh0ZzRncXdLV1NYYTVl?=
 =?utf-8?B?UEgyTk1yV0xLRUczRk1HL3hLYzdaV3Bha0xCeWFVLzdKTCtIWjJLS0JCZGlr?=
 =?utf-8?B?bDZPMDJHZnV6ZmkrNHpRL29QTjF4enpxbjAzcEMvN1ltdjFtRU5WWVJaNk5W?=
 =?utf-8?B?YW1OcktUMDFVMzU2UEVocTRPc0JJNndtendpZm9keks2dHF0K2I0WFVXdkpJ?=
 =?utf-8?B?ZzJQZ1NBRStUc1NYM0pubmw1TUxKd3pzRFUrNzl1K1ZNSklaeDc3NEhvOGVK?=
 =?utf-8?B?bjhtWGJ6eFNkVUlyTVgzSDI3cGc5YzlPK1ppcW9tc1l5QmFyVTNlOW9QK2FX?=
 =?utf-8?B?eGtIQVF6UEdJc3pPN3Nob1FGTjdyK0VscjNBNnpXRzYzT2xwNGlaQjB0QzRj?=
 =?utf-8?B?TlF3d2Q2TFlpeitJUndDZ05jRHA1UkJjL2VZTFIxdEkzYkwvck5xeTlJMENJ?=
 =?utf-8?B?VllwL2QzSWpNTFY1S2FsQi9KYzNHMFE2NGhxc3ZiZWtLQlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVVXM1R1MmdPN212OUZyanVnUWdsNGl1R2FBdUdRZ3BmTXE5RERiOHVFRmhB?=
 =?utf-8?B?VzI2OFZsREt2VE84THB0SUNpRkw2QWp3SklIWVYrQVlaNFdOOVFONEY4UWha?=
 =?utf-8?B?TVhxM2x2Y0N1c21XZUNBYkp5L1c0TkVwWFViWDY5MGZaQk9YbEp1dlhBNUUz?=
 =?utf-8?B?Zy9FWkRNdG8wTkJzS2NKK09kcmhqRFd4VG5BUVFTKzJUSTdkbTNkVzNOQkEw?=
 =?utf-8?B?MVovdXByZUFFdUo2RjNCRERNNW1CSVNhNlRWZmNpQjg3OC9zYzJaZzBhVHVy?=
 =?utf-8?B?bXpmTnhzQ1FwTmFiY3NuNFNRaWZoTy8xSCtNT0J6TXNOYkZZSEgrU3VPUFpL?=
 =?utf-8?B?ZnB6ZWY4VkRvUVlKazJvbXVlK1lXNzM4OVpOQmhveTY1R0NSTk94RjlSVklq?=
 =?utf-8?B?Ym8yUXdTTEZpcFExYStURm1YWFRGTlFoaW5QbTZjTGhJRlVBaWpjcU9hUUU3?=
 =?utf-8?B?SlhSbmp0Q2xWMkJOUlhkNHRhUGxKVjFNdlRyRVp2eTRhbmpJbkdlUmNGU2xr?=
 =?utf-8?B?K2FTSzVoRjhIaTNtTGRrb1lZVTNkd0dRcmhnT3lKTW9zWlczR0p3R1J0TnFX?=
 =?utf-8?B?UUx1UTRrU3IwZTJHMnY5dVdGV2lXa2NjNTNlVlEwYnU3S284SFU3eG1pSnRQ?=
 =?utf-8?B?MWxpNk1CM045WmJneGkvWXlUbWdqS2dVeCsyY0xscU0xblYwc0xPR3E1cElv?=
 =?utf-8?B?VDhINldnemZ4T0dHeDlkZERBSDdKKzQvYVhPb2lWQ1VoeWZieUtpQmJYK21O?=
 =?utf-8?B?VzFtbXJSMEE4NURNTXo0WHpIQ09DdEtjWG9nMnlpQ09GVlRWM3VmeU45TGF1?=
 =?utf-8?B?cURWZGRhWlN3Q1BTdW90dmNqUUNlZWg3SVFaRnhsZ3BjS1pLQjZrM1pERXZi?=
 =?utf-8?B?b25rdGNPdzV0SFJBdkM0VGgxSWhSQ1B2ZlJTVEZjQWYvOXVLc2V0WTU1b3FM?=
 =?utf-8?B?NHBNYUN2L0JHT3JnWjd2R3VqeGFwUjhWVXFmSEJrK3lTWWM2VjZ4bWZMZ3FM?=
 =?utf-8?B?UEU5Nmx4ajAxTWdOSmNxVXlDVVZFOHM1b09FUWpqSXBGRy8xOGtEMEpMVmxu?=
 =?utf-8?B?dVpHV0NRVVVGb1poTDFBeDRnSW1wUHhDa29EMVV6ekYzZ2E0R0FSMFpyZUVr?=
 =?utf-8?B?NnZJZndQMEdxNDNZN3NjZ0g3dk1ndUxlRHJsblpHYm9iNE53a0FtOWgrcHFI?=
 =?utf-8?B?SDRQNGR5bjc0NUZTSDlPS2lpRUxUSFZuTnhHQVViNjhsYWhkSVBGMXlvYzd4?=
 =?utf-8?B?WjkycU00MUdyZDQweWVXVWxQNWtGNkVRUEpqR3hVUlU0dEhTYzI3TXRnck5L?=
 =?utf-8?B?N3lJMzI1Q09WbkM0ZHUxZk9TVmN2UVlWazllUjdJbmhWeGJrSUU1QnZUMEtz?=
 =?utf-8?B?cXI3QVFjVU9kWkFRZUZwazVTUjZjQUZvUXVZK2kydzlVc0ZKWlcxTWxkNXN3?=
 =?utf-8?B?OThxT1AxeDcwb05uQlVyWjhjWnRRak4rbTFkdktwTFlZd2oyZnB0bmhISmk0?=
 =?utf-8?B?akZYRGdSckdyaEhFRGJUdFJDcmxaM0pyalNJWElqMUY0N1FzY3hTVmNtRjBO?=
 =?utf-8?B?ekMxN1VCUFhpR1VpSnJwZHRzUWErL0UyOU8zYmM1cHA5OWdQYXlJNGhaK09N?=
 =?utf-8?B?N2pmU0VZUWJFeU5JcFVBTnUydGpsWFBFU242VFlDWlBnWUZqaVhrWk1wbW9k?=
 =?utf-8?B?TzdoNFhlUFNYUlVwMmhMT2tYQmc3T0pURUVxUXJTZzdHbGorZ2lqeXdtR01H?=
 =?utf-8?B?RTh5RHdGREM0eGdYenRsOU1aazJzVmdzOUFESlFhOXo1SkoyeGhWZ2tZQkto?=
 =?utf-8?B?anpZSDVsd2pLTVJYMkJBd2YvdlNxQ05OZkl4NW9ad29oNTEvZGJkRDB6TjVp?=
 =?utf-8?B?bW02NEFjanU5MGF6cUpsWEYyODVxK0VxZTRQK3BRZ0xMMjNMaU5HWldZaVpo?=
 =?utf-8?B?VlB5dDdnWHBnVmN4ZEpDZmQzaUtpZkx0RVVWMnJ4Z3ZvUktSVTJYcFdYWWRZ?=
 =?utf-8?B?aURYcEdrNDNnbTkveWJDTE5YRUtyUS9ZbnFrTmlVMUlkRDJ4UlZuSExXOFNV?=
 =?utf-8?B?NkJ4TytYeG9EZVJrMlMxVE5uZkJZaEVaeWNKWXdCUDJaaGl2ZmRybElmckxt?=
 =?utf-8?B?a1dHQlNjcmJhUTVuTFBsa0d3STZCZDF1aTVZei9FVnZuVWlCcXJjb1pMUmRZ?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SLWmN0Fc7D5kRXL8subYWihqg5TRwC4cwO3ZTlolE0UxqDHnmEtECCapVXzq6U3HaNWLvpxO6YjBAljKns0PDA/QH3wj3/OgqWaNeexLKW8pSOIQRYIh//refX/zsmaRy34/kiKHnHcuriZb3sv3ZLTntuy41eMpMUKwYDPshaWAQ86lZxJkAsnqqXAfSrU3ZkCo+p55JJqDFQ2ZBIju4UKefaAG384U7RL8NpKW0REzVIZfu0GfRuSIAVavXVuzLGgkPgNRGo2pn9CvQ8e+9DHiO2AZ6oqxnnLo4p4F9JA1Mb7UUWwoA8pCGvNbrLiHDaDbwMFkhdctpkiJ76S9BSAN6swtZ5w/xbKzd9wxIsbvbaEVcFDkv4WKc0oMeBDvLjTtnnQtnTTdS3+F5ZzzuWozCIMKSoMwr3jU9LzSnL4UZ3r9cee/4kBOkCm1Hk8WWZufz/O696keW3SU5KhHU+trjA3zulHn4yCldecQRbxhbB8T4+kFbxT/10BBSotWPQ96nYPcz4oUpQFStPUI/dRFnKInOCfSQ4vxeClKw/Tt6h5mR97SRU0N+zaEG2gZ7QB1Ovs2buQddNuYGADCmTKev5klG9xyCqIQDyo49B0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0acea55-abb4-4408-65a7-08dd68802a0f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:56:22.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s57fj3YGHSJEqoRzNC63yafQjnC0AzfdbE10FvJsWZnInc1MKcUGX82kf5F3XsV//K9CkPHr1zMcQoM/oUFsqey20b0X+UN/XlHwKz/BKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210101
X-Proofpoint-GUID: 4mb0vOx31Zoz6ta_rSdYa9Tq44-6BBfg
X-Proofpoint-ORIG-GUID: 4mb0vOx31Zoz6ta_rSdYa9Tq44-6BBfg

On 20/03/2025 19:17, Bjorn Helgaas wrote:
> 
> Maybe there's CXL magic that I missed.  It looks like Terry's series
> changes some of this path.  And GHES also currently uses
> pci_print_aer().  Some sample logs at [1,2].

Maybe that's it, thanks a lot for the pointers.

> Looking at v6.14-rc1, only aer_print_error() logs the "error status"
> string, and only pci_print_aer() logs "aer_status", "aer_layer", etc.
> 
> The previous path is:
> 
>    pci_print_aer
>      pci_err("aer_status: 0x%08x, aer_mask: 0x%08x\n")    <--
>      __aer_print_error
>      pci_err("aer_layer=%s, aer_agent=%s\n")              <--
>      pcie_print_tlp_log
> 
> New path is:
> 
>    aer_print_error
>      pci_printk("PCIe Bus Error: severity=%s, type=%s, (%s)\n")
>      pci_printk("  device [%04x:%04x] error status/mask=%08x/%08x\n)
>      __aer_print_error
>      pcie_print_tlp_log
> 
> So I expected that the lines I marked in pci_print_aer() would be
> different.

Hmm, that seems to be the case. But still, the question is if going with 
the new format that matches what's in AER a bad or disruptive thing. I'd 
like to try going in the direction of using one way of reporting AER 
errors, if possible.

I will send v2 on Monday (with the memset move) and we can keep 
discussing other changes in the patch.

All the best,
Karolina

> 
> Bjorn
> 
> [1] https://lore.kernel.org/lkml/2149597.8uJZFlvqrj@xrated/T/
> [2] https://lore.kernel.org/all/e8a58616-aeae-ad78-d496-6dfcef4ddcaa@arm.com/T/


