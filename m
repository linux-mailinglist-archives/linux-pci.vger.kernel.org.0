Return-Path: <linux-pci+bounces-19957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF11A139A7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1388A188A87D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166501D90DB;
	Thu, 16 Jan 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBglK2gz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vJ9kRcLS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E091DE4C9
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028944; cv=fail; b=Tieoitl8qJnQe3txax7au8QC9pN1JfTBRMa6N+3pvZH/9ewAqNG6sp23WJjSjv7WRVtKSSwMKCmvH5HpKgZLbSjG2D2L5KSwYUBJJgQNT58ko0RMN0C+8173U1mfjb6+TCSwKau60YAMgIxLvd5oMtio9iOMZhSKQUTez93kRSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028944; c=relaxed/simple;
	bh=ZXDOn1vQ7SZImcmKPsbTu1FLcVg40AiKyhogjmAc3lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RmIKMaMplpdsrcHFEBKDiE4ANTXtCg/NyrZvPhotNWE4Jknasa0kyIVFtnhrfypbyJi1PQOJR0JIDBI1L9YCTwozbuzNKusbrI/aZFvEGVTdvb85PCP8tFK048oV0srIoWOrCtkKPpMrQyrFlINYxmv712md92+MwOxYKYuDVMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBglK2gz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vJ9kRcLS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBN0pO013664;
	Thu, 16 Jan 2025 12:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PU80J0VLeIGcr6pXUJOKtFu6bPSUa6nDdc8Poqs5Ecg=; b=
	hBglK2gzrkvNmgQlRhuRQ8trDcBqeEjXkeVTfT/YN2HjuXe4HQ07JX39/6kcDxCI
	ba3HIF4CQUgiBtZn5T6sgvi36q4P3ulXxTAsL+3wPzgc1OeprM4/v6Y/51kU4TV0
	iFpeGns2Xkl9iRxykuzNn9t34SW5GqWLyvfoaiEWl1TTh1wTc6xp5B5ptPkfMwdj
	O0dUYsImRWvoeNO9l+Ac4pxun4KsR1EeKY4pRWiBYRFVgoKrFMfr/K+FdcolfZT+
	WzKk902p9UJLvUNJksqPI8Ms2CDefSNPO++24+RSoIdmJzQQEY+8Yrivbv44RBuU
	hNiCC4moWVgcncwbhozfqA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7ya3fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 12:02:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBwMK4036245;
	Thu, 16 Jan 2025 12:02:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3b96rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 12:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKVqwQmLvlfSc2C97ZoRbfMOMjlDlztNzWdJAfMe3+ZEEZqk3RoWQIVHyOqFYYhggrOZ8drC4GtL7Lb3PBtFtOsiZMN4fbqVIXWux/Bypv88Jj/Y8O6UNdowb7KAyHfzEP8optojHamhdOM8VKMssZ/fMiICJcRxLNozfSsUuPqetUXz80xigIWdyS8D0kb0Q0vN70GgBMgoszXmFjG6oiuN7g2XY6uokl3VIPN2ytQ1Dylvx7+RE0sfNEsUuiJUD8t13QkdGr4tTrfOqg8GM4me+FVtdZA7+eQgJpqglLDQatWCU1pI/vsNrnjLibLGBEExOBetaviMXobBWWIC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU80J0VLeIGcr6pXUJOKtFu6bPSUa6nDdc8Poqs5Ecg=;
 b=s9pQLBEWWM26iXAbRmI3TdTetn7dbp/IImp8hKWprBt1SHTC0bKT8HI2+J8r/Mhd1Vc3pqkTv0KrtBETvO/J1Kd/gLaz5O2+4DCiLgflEoS1JGFSggD17C0yZkPq41qIM6hy3BgEiS43m+cYm+6WRckTOVMpoZ2Sp5L4zB7S+2E6I2d2YorH8f1qkvGrYN6si35eLZwB1mkMaQ78E+Xv/ymAuxAO4RdK4CwgL1uo7lLcxB4fhPt8lQPRy0dnSlh3SJvcvOrz2rA3NieeWDbT4W4A5okM4IRUC3TNb+Fbcu3vO5JPNDQnyNeP/WMfJH4Cr1wXnwmR3u4hrBYneKDUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU80J0VLeIGcr6pXUJOKtFu6bPSUa6nDdc8Poqs5Ecg=;
 b=vJ9kRcLS54DGDS/38uYZfIzzQayiRRYz6VyT+GQSLt2OLhL2efIzfYvDsNexRFli2x+0PwLRyWhWgDURNDON68yMU85Wf1WGHeQk+LoLV6iwnXg3MKNAaJqVQyO0VbgWnCCsJowQaWJVfY4wy83VPJZCTwdq/fZ/QcKxny1JoLc=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by LV8PR10MB7725.namprd10.prod.outlook.com (2603:10b6:408:1e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 12:02:13 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 12:02:13 +0000
Message-ID: <8b6796a1-5504-4d95-a565-a19272d04350@oracle.com>
Date: Thu, 16 Jan 2025 13:02:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-6-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115074301.3514927-6-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::14) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|LV8PR10MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cba6d61-2f87-44f6-e434-08dd36259cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUM0cFYrR0QybUFCLy90NTNqU0MrSWxRZlkxdEhtcHIxTnVERndqVm1nNVF0?=
 =?utf-8?B?dHJ1ZkN6Nmp2NkRDZHY0allpY3RSNUl6ellPRDlRUVg5OGhZMjhtbVRBM2dX?=
 =?utf-8?B?S28xTnJhZXlHWTlGczNzVzRWaHJlUVg3SlNlS0k5V3lKZ3ZYWlplSHp4cExW?=
 =?utf-8?B?VVROMmZnWFV5eUN0emp3a0RLNDlUVEt3MDlXYUdVRjVzeU15VHhZWXhwOE1y?=
 =?utf-8?B?R0FvaUd5cTNRd2NPU0dRcFhaUk1zTUtVYy9BcHNCWlJlVVNONzFTb1paQnFs?=
 =?utf-8?B?bUNEQWJiNC8zRDh4ZTlwb3NTSjhYcGVtSW01R0puOGJPN1RhR0F4b2ZPU21t?=
 =?utf-8?B?a1BMMzZHUThOaTZ4RlVmRjRiY2FEWGVVc1hSOUs4MzNwUk9UWXFOYWNmTWl3?=
 =?utf-8?B?bmE1UE9hZnZpcDZJK3dHVFRTNEtyWU5Td1hYSVVydDYyNVM4M0VOY1oyaFJ4?=
 =?utf-8?B?N0FNOTlaYnB5NmVybStuOHJVNnRTaDBSNGJxTHhtM2h5YVg1dW1KbGFrYjJX?=
 =?utf-8?B?RzVHOGhTTThxRUt6N3RzbERWaTlPUVdmUGorZnB0UGk3cjBpTGtuek5lVXVT?=
 =?utf-8?B?UklOL3o4bTV2OHR0Z29KYVd6ZzVqZDFLMmVWWlZGQ3hHaHZkUm9vMmtVTmMy?=
 =?utf-8?B?QXdvUG5VZXpJM004U2dTenVmdXorZlBVTjA1aGl6Vjl2NzRRa3liZXVwbGds?=
 =?utf-8?B?Y3FIMHllQlBwa3cvbnJFd0V4dHd2Z1BZc053OS9qS3d5cC92dzZlclNYNGk1?=
 =?utf-8?B?dkV6YXU4Yk9kaTRvdDNnRE9VWTFTVnFaY2ZpcnFEdnJBbi9VWmQvV3RSVHph?=
 =?utf-8?B?VzVhbGs3SU5mWDd0K1hrZlhzRFczc2ROeG9mWTBVZ1MzRU5Wckw3eGsxTHZa?=
 =?utf-8?B?UklNLzBLY29sbGg2Z1BVQi9BdUFleGlrMGJmVFJpbEw0V0I5VzZ1alhPdnU1?=
 =?utf-8?B?anhuaXdxbkpLSHRiS1djb3BrT2lmek5zRER2ajBiZ2hncWpJdUFwTlRHT0Rj?=
 =?utf-8?B?Yk5SUGV4KzJxWG0rZGpiWFJwRnNoYXJjZlNld0xRclYvVjZRMWJDelUvcHIy?=
 =?utf-8?B?RXlPcUpwNHlTVGp6ZVVXL3lIODlWdTV3RTBjOWlReTNyc21tYmxaVENyOFRz?=
 =?utf-8?B?Q0MzTk5lN01KZVQ1OFRuUG42SUVwVzk0ODdHaEg5VjNQcXlIOS91MmI0NVBS?=
 =?utf-8?B?ZXhOU2NFYTJsaUl0ZlU3dGlBblFhMlJ2Ui8yTWtVMm1jNHV0UmtCZkc2cDhM?=
 =?utf-8?B?OVNLQUdLK1BJaWJxUDZJUnRIOFpYUllVY1RQRnltMG4reFNIcjl1WHBmaFg5?=
 =?utf-8?B?Zmhhd2RlV0h2STlNNDY1NDB6Mkxwc3l1YXhoYVc4WmlHSndkaTRnU3MxNkxn?=
 =?utf-8?B?cEhaenRFTDAvWk5udDlLS0FBaitHR1NNWkcwOUFrcEY0SWpIcnUydmZuMitw?=
 =?utf-8?B?dkx5ZG5CTWpTK2ZrTGgxZi9oN0RMZlVEY01CSC90T1NYTXBQZEJtYldnVWJk?=
 =?utf-8?B?Yy8xaXJ5ZkF3WEcxV09SVExaZVMzb1cwYXdFWmM1SUhrS3RuMG9xSThSR1B4?=
 =?utf-8?B?Z0ZDQmowSGdoSWo3eGNIVTlJeVFFT2o4U29ONVhXR2QvdEJZc25ZYzVReGgy?=
 =?utf-8?B?T3E0dXNGd0VpSVN0WkdtbVc2RjJsTHozQmxHMVd0SU1maG5teTE4dzJPY0pB?=
 =?utf-8?B?VHhMSDNyZWlkeVY3Q0g1SlFRS2ZsQVF6TnpDUXNxcTY0aXJHVG5FSWdxLzhr?=
 =?utf-8?B?ZStnUUczNGV2bEVKZFJLVE91NHpsNG1hbThueWdHOHhYZGFDNEIrM2Qzczdy?=
 =?utf-8?B?UVhQeDNIY292VlVNOVN0bmkzcXQ4cVlGaGp5R0tyaU13M1dUT01FdzVabUk5?=
 =?utf-8?Q?elUVZxot10tR1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW51djNPUGlaZE9YN3J1V1dvdDdJLzJWOUZPN0VIZUNwVmFWbTlTbVQ0dXBM?=
 =?utf-8?B?TEZXaHNwSFdGQmg3UVIzbjkvMkxEU2xUamNpYmRXaHJKb1pEeG1JMFZZZHZo?=
 =?utf-8?B?QXQrWnVRZk0rTHFNcG1QZGY0K3Z4S3RlUEZPWVJWTzhPY0s0THpEYTVFSW1G?=
 =?utf-8?B?aGxnUDltaVduaStrM21aeWw3aWIvZW9aa2YvdGpHTFdQUEVVakVpVkVESVJQ?=
 =?utf-8?B?dDdSQnZadmY5SjA5Y2pZYW41VytudkVHMG93RXFENXhaQkUvQStESFhlN1gv?=
 =?utf-8?B?TlNMQ1VpSENHNXJ3bzlSalFFdkxtcXF4aGJDcUFqNGl5aUY4dXNmYXVWQml6?=
 =?utf-8?B?M1BxMG5ZVEtES2xzYit2aWZqTk54dXJlTks1akRSOGQxbHE2MXlMVlNTNGJm?=
 =?utf-8?B?em5JcjBtQjREcFd0d0llTUxNa3VZdXZpc1VnN0FsL1FDb24vUUtrZmk4NGtX?=
 =?utf-8?B?T3FNR1hLSmNvSDh3K3hUOUU3YldMUWRkalg0MWNqRFZHL2IveDk0aVN1ZUFh?=
 =?utf-8?B?R2JOczlDZnY1N0NMN1JkV29UVElmeVhFN0JHYW9TWStRT1FOQ1QrOHdwOGsx?=
 =?utf-8?B?aWx6QnFiLytXUFZnalZtZk8xaGEwTjhMc3c5UkdRWjFhUVlpOEJ1OXlyU0NC?=
 =?utf-8?B?SEp0Z3VQU1RsRDNRSHNvSlRQT0Jzc0VYTndOOVpiSVZ3UEprUVlqcFFsNVQ1?=
 =?utf-8?B?ZlJWQi9pc096WDVUbmJKenNudGJkUDc0dFRwVWx5T2RtNTNXM3cwYWhCVS8y?=
 =?utf-8?B?NWk1ZTV5dnVrUVlxZnY0c3ZZMFEvTTdSelFqdElJRDM4YWFrYmFuTUE0Z0Rk?=
 =?utf-8?B?MkJweUhCcVVzSkQ4azZ1K1ZIZTYrUlBnUFVhaFFDTEhpM21rekwrSUZYaWNi?=
 =?utf-8?B?dXdrWGdGYVY1WmdMVFFDcGYrcnJrVkhmRHVYdlNETS9CNHJMQUhJY0dsczJi?=
 =?utf-8?B?d29WcWsyUmN2cnlndUgyM2RBYm9qU2t5UWdmNDNMMy9Pc1pwNVlhcGxyY0FF?=
 =?utf-8?B?RXNocXBrRmQ3ZWV3QzAyeTk5V01OY3BFRTdPQ2RycjIyaS9lNTEzZzlEdHk3?=
 =?utf-8?B?LzFqc2JYVndOanVEMXMzTjhMWHRYU0Q0Tml4enNNZVBmOEY2Tit5S2VzdW9j?=
 =?utf-8?B?bnB5RTBJcVRBZHNhSjJCdlhXY1VwY2xnZGJ3bTIzYkJpVFM0dXdTdW0vSnBt?=
 =?utf-8?B?SGlpd1dwYWZKQi9XWTFKY0Y1b0NweG9MeDVSSFU3YXgvamdUb0JXK015ckdF?=
 =?utf-8?B?N3FZSkZBK08zSTVpajFKZFBDVFkyNXlkbVRoK1plR29DQUx6SDVEa3pkTkVi?=
 =?utf-8?B?ZXhNcytkN1E3RlRCQlI4dTR2TGJYNmpmNWx2S09nWHJwVllXZTRqR2ZXV0t0?=
 =?utf-8?B?YVp1NDRhL2REbHJlcitrSTBJVm9hc0VuekhQUmN3MDEvMDZqbnAxTFdJbldZ?=
 =?utf-8?B?LzM1QmRpNHU5Z2lGbWpNdmFhUitzTTJrUU9hMkJ4cHlxcE5WaldWcElCUVF0?=
 =?utf-8?B?TE9OVzV1T1ZmVWdSM1JlZU5jZ1p4Y2g4NWprSWptd2xnOHVRT215UUc2dW9S?=
 =?utf-8?B?UHVzaDFmVlE3eXdNWDRnTHNmY0dlT0Zla2VSWDNRQzl2emwxUC9EbWFyVTV6?=
 =?utf-8?B?ejdMMTJsK241RmRtYXZTVU12MG9Lc0xFVUE3THBNRGszcERDYmdrbkMyUlRy?=
 =?utf-8?B?dForNVBjWmF1UUJlMVpNYXBhdnN4ajRQZTAvN21qUEZjRGJjZ2xKajBWSGlz?=
 =?utf-8?B?Ky8yZ3lCR01GZVFwNGk2ZlBlMXFGUnRHWC9Xck5Iby8xVWVQQVgxTG1IaHBz?=
 =?utf-8?B?dzZ3UlhuOVlOYXNDMkMzelBTRXhXUFV3Q1VCK2xoYThhWTI4RGhEblNCQ0Z4?=
 =?utf-8?B?SGJOL2NiT1VpRWhVUW1YNzhaTGlXa0xRb3F6Q3hhUmh5a0hIN0tvcWVtRDZk?=
 =?utf-8?B?V3RKQXovSW1lUyszKzZUdUQrQjZQZUdzY1N2M1dPcWdHOFVmemtHdTdna21w?=
 =?utf-8?B?TW9iYnlhVFFLSkJGUTY3L3I3WjZtV29hSVM3SHQrc0hVT3l4L3VUaWdqTjdi?=
 =?utf-8?B?MjJ1dXJUWGF2NkZNQWU0STUvcy96U3krOTdFbWhWeWdvcThHWlBLa0I4ay9E?=
 =?utf-8?B?czJvdVNnREdhRlBaODNwZnAyQ1MyYmV2U0VHMW5paFIyYzF6ckI3SXVsN3ov?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	scrU2VUzmPi636I5yj0OEy6CVMdnR7IRQGbh4wIPQk92RhEmlAlLPfJWfMD39wfgwD8iARGnGmbdaDDHqJd1DsVHKQqWHm7f21qILa5jnzBrKMG6hpSC1tr2bRh5blp4l7NAU+itopoujiB3EFbTcVjKPCKqWAfFHi5jV17zhlwad2W3HZQ7EM5KzfcHddViFgCi+1qbT4h9Pzh6nBzIhrzqhH1o+QPcCc5iEJb3GJxxwv6dEh0eFtCYrPAQC6KADN+N3/Ah/rKd8LJs1baep+NPj8m68wmA5HaM74Xe5jauROtco+XQF0UwA+uqh2lKj66ssj6LHuwtp+wcMVTou7zPp/afuSmOeuFoMvnBNIySep8WntVqbKlRt1h8HEgr/Tl+sf5tiQn8/UM/xVhkcrRPhMP1vTx+DabEzPEUMlXOLQfedIdokYpb5+VDfcgnSb2cf4uEBG+kpSPN8ghm9vOCM+L6dKDHKHC+Q+TvrOD9UVfUblk9OYqnHwxzTD67tGHJL70aYTykD6mNkZ3e1CDY12rpeLR9oqgQjgNcjWpLwgbqwVInZe2GCgZbeW64k/CsGWk/IlQACsC0H/CkxGRqqnAi0eOFRr4h1Mmww3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cba6d61-2f87-44f6-e434-08dd36259cfa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 12:02:13.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG+6RX57NpjDLsSP1fxLyYzQyvUjPxCgsRPao/AyjW18DI/mxm4ANhen4rAHQGBHFTqABSDYij3gU5E2CzAtkuU1pnyASCABsMsEdcnqri8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160090
X-Proofpoint-ORIG-GUID: Yd1SBYiHzvCLT4S4-yHMwvHHZmxnYIW4
X-Proofpoint-GUID: Yd1SBYiHzvCLT4S4-yHMwvHHZmxnYIW4


On 15/01/2025 08:42, Jon Pan-Doh wrote:
> (...)
 > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
 > index 025c50b0f293..1db70ae87f52 100644
 > --- a/drivers/pci/pcie/aer.c
 > +++ b/drivers/pci/pcie/aer.c
> @@ -676,6 +682,39 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   	}
>   }
>   
> +static void mask_reported_error(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	const char **strings;
> +	const char *errmsg;
> +	u16 aer_offset = dev->aer_cap;
> +	u16 mask_reg_offset;
> +	u32 mask;
> +	unsigned long status = info->status;
> +	int i;
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		strings = aer_correctable_error_string;
> +		mask_reg_offset = PCI_ERR_COR_MASK;
> +	} else {
> +		strings = aer_uncorrectable_error_string;
> +		mask_reg_offset = PCI_ERR_UNCOR_MASK;
> +	}
> +
> +	pci_read_config_dword(dev, aer_offset + mask_reg_offset, &mask);
> +	mask |= status;
> +	pci_write_config_dword(dev, aer_offset + mask_reg_offset, mask);
> +
> +	pci_warn(dev, "%s error(s) masked due to rate-limiting:",
> +		 aer_error_severity_string[info->severity]);
> +	for_each_set_bit(i, &status, 32) {
> +		errmsg = strings[i];
> +		if (!errmsg)
> +			errmsg = "Unknown Error Bit";
> +
> +		pci_warn(dev, "   [%2d] %-22s\n", i, errmsg);
> +	}
> +}
> +

My approach was more heavy-handed :)

To confirm that I understand the flow -- when we're processing
aer_err_info, that potentially carries a couple of errors, and we hit a
ratelimit, we mask the error bits in Error Status Register and print
a warning. After doing so, we won't see these types of errors reported
again. What if some time passes (let's say, 2 mins), and we hit a
condition that would normally generate an error but it's now masked? Are
we fine with missing it? I think we should be informed about
Uncorrectable errors as much as possible, as they indicate Link
integrity issues.

> -	if (!__ratelimit(ratelimit))
> +	if (!__ratelimit(irq_ratelimit)) {
> +		mask_reported_error(dev, info);
> +		return;
> +	}
> +	if (!__ratelimit(log_ratelimit))
>   		return;

Nit: add a line between these two ifs

All the best,
Karolina

