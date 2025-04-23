Return-Path: <linux-pci+bounces-26540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2DAA98BE9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CD9442B87
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804674040;
	Wed, 23 Apr 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLZzVNgT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HXHWP30r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E91AAA1A;
	Wed, 23 Apr 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416400; cv=fail; b=YkoosVdzKhGAF6MnAA6k7WQKXZlwQhfNy3Zv0a1LbC/n4aObUbEjPNTdHCHgjIHxtDYzNGNKxIEjgsS31+OVihYAhx06IRpg5tYc290o0bONjlZUCTW9qqVuVN0FRtWKQ3eYBTY+l5B1nrZUGtzuYkUbf+ZyGE7DbI3EpFjo3vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416400; c=relaxed/simple;
	bh=LMqsGVssv6Yl/l8BOnc7QaDhG2TkEGRyost+JFyzQlo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JnkDaU4S5WmxCIlVWBJPaMbNuVYODZPfy1JR9ruDEDF86ZThXZJqQtwmngam6IKbB9X/4DWEnZ46PqFNwwEHDLPNimcXLBKnAWDc64l5qwZLhrooNrN9L/41zjHxkzdb0eYFVUXRxiSb4Cm0smHDogVmX8bg5qtOYemG+L1NQ+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kLZzVNgT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HXHWP30r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N8fp0I023925;
	Wed, 23 Apr 2025 13:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kj70NC/RPgpTP1l8bn7qeBnHE8QN99wotbf82LMHynU=; b=
	kLZzVNgTee8lq8FHbSvM3QHdas7zhGVkS9p8/jEkOFrFTYiB4UmuAzxJPRBPSmkI
	MHKXC1+4tvx7YMAm0lYgpENLZLEpkakcnTRzZFWj2q8d+BRTvUu/nK1LEKKuLdpS
	WMmG8elARrDYmQZFS2/auMhZZ4sXX89kKYulgA0/ng6tJF2/iAvXWmr1z+CzqPdH
	cGpd+YZA/FDJhWNF4+HF/laMmm8Ou9i9RLucDQOY4le7NaeYn2sia0J6ycT2WVC2
	rUhUtCmp5QHL76lfTALKu7Y7RcH7AxRC8VRFUa0sUSdbj7dOHN30+w/KjDG5OcrN
	6+IPZECpZLj19gct/o7U3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe193m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 13:52:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NDpNBa031020;
	Wed, 23 Apr 2025 13:52:41 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k05vm72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 13:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0Z8DcGKvCJNIxYiyY1j5L9paAz1XpflH1Rzj5m71RXxiKxXg7Wcw2XVlPYCvk05/B34pkGkExzH5QZAqBcK5Mci+buRoUICw2AtxIsEbAi0S48aUKRiOcdsIU4OyipOzGIPD+iapKiB80NM6ye+wFI5h955WvGpT9YotqIrFucGLfC5KNBfgsO/rM4NVxVhOI+I9+QgoAwowQEmfoGW/IaFiUgfQhiKfwp9hZsvhmpfUBBXyaQAjWtQNw/8uNkiTt6DJzdgtDfBgf1h+jjB1AiMCkuoKkl1eJEjaKZGiizpmZRs0z9/4zvHvbCUc2vXpePUE4I7/hd9eG2Z8oc2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj70NC/RPgpTP1l8bn7qeBnHE8QN99wotbf82LMHynU=;
 b=UaL39GAX1kQOvn856SIXBIoq127rfsFzj6il8X42IuAW3kN5rcx//udeqAyzbYvTKZxyUUITpVf/NnLeS4Fo1vUwJR75dxKtHpGqHxZGHJr+RG01OOCIEwcdWYn8s8E+/v82eXEmhpDwJrbOCIT4VeNwF5Nd2nXPiF7RzRERVVQadl4EYTu0nSKu0wdGqpbRRvsBUOebfUA71uRlKmIR3mvynXsAjfQXRieGYw8htIVxJR6VQPamN5FL3R6Eavl44XkwFt2L3cG+KE/egTvsOmoDrsc3C52MIPO51lUf9xtUM78s+nGXErC2wbjUaaHelDTjm2AVAQoTsCTgt+rrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj70NC/RPgpTP1l8bn7qeBnHE8QN99wotbf82LMHynU=;
 b=HXHWP30rV4xoI5BIWtND3kwvAFyulcJIXajEibA6P5M8aMTcPgKUgoP18rP+fjbg0Duy4An/LJanF57fo7UfJmhKsaK9l+nEQVjc7NKfd33weq+D2BJObHZ4S88sHuT5f2A1+jpNzApt1FO2w4RbK1KuqGxeWVcD2RjvSB5gdrk=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 13:52:38 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 13:52:38 +0000
Message-ID: <c51f0f8b-99c2-49df-9112-650b3c5382f4@oracle.com>
Date: Wed, 23 Apr 2025 15:52:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
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
References: <81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bc0ac2-e86c-4686-12da-08dd826e1bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cExnTzEwdHRSNE9sbjdGTElBQjFTcEFab1F4L1dQRHdJOXNHQ29uWS8xQU9L?=
 =?utf-8?B?b1ZFMlBEVFlzYUx3VlltalVGeUNSQmh4NFhoY2RFVFF3cVNKV1h1NTdoVmhm?=
 =?utf-8?B?eTR5MzkzNUlWTDYvVDdDN05vYVp6OEhoUHErYS9aQkN5K1VEcEhPSm5qb01L?=
 =?utf-8?B?ZERBaEYxcWNGSEJHNGxUTkNWdlV6U2owREhQaUduSUc5b3M4WVE2a2pHZlpo?=
 =?utf-8?B?ejg1N0w0S2VkOGJ0dEVkUVRwNUthbk9JNlZGR0FWQVBFSFY2d1FIc0NOQi9R?=
 =?utf-8?B?WDNPTzNQeEY1ak9KSVRiYitQTWtrMzRENU5lMU1ab2p4VmtSYkRYL1FoRVZl?=
 =?utf-8?B?cXZnWFhrRGhFM2JFUThMTDRrd0FVdlhnL1JEN1FMVGVESEQyQS9ZVS9WOGFQ?=
 =?utf-8?B?QW9ZM2ZxRE5pS3l0WkZZdDRnOEI1WkhMbGU2MXR4bnRaV1V4TTFHTU5Qb0dL?=
 =?utf-8?B?ZUVjV1p5dUpEaHpPTTNhT21BZXh1WDR4TGtWQ3lTUlFNbytlZStrem5OT0x0?=
 =?utf-8?B?d3NTODFyTnFoMWhmQjdnTUtRalMvZUw0Y1Y5cE1nTDBQcHdQSGNYdFQvRlU3?=
 =?utf-8?B?U3duYUtqcmNWNVRLSUU2dyt5RWd3SE9xdmp2TjgvS3BLTUt6bFNNZ3NicGVu?=
 =?utf-8?B?eFVUemZFN0s5U0hkYm4zNFJhU3U5Rkc2NzVkeHVPL1RnalBDdUVLNjMxSzBT?=
 =?utf-8?B?U2VqZE43NVpNNHBKOG1GVk55OHA0MXNGNEx4M3kzMkE0Uzc1cUF3YWhUSU1Y?=
 =?utf-8?B?MUN4TUtCMllNa2w0ekVCQmFwcVM2MVlGUHRySlRFWEVuZ1J6ckZ6b2dJSkhp?=
 =?utf-8?B?S2xzbVh2TGdWL1FmUGlCNzZEelRLYlloc3F0YTUvdlZpUWloejFGazZ3OFFU?=
 =?utf-8?B?eCswaFlHNkN6Ny9SK09zNTdsOXl2b0I5ejNKZmdsQTJDTmo1RzdOM0p3eHBP?=
 =?utf-8?B?RmNDMDdodG9td0FMekg1ZXkyNHVyUW9iV2I2dU5vbTczV1hKQzl1L3pYeWhL?=
 =?utf-8?B?bExUaHg4c2JrNi9YSlQrQ1lqanMvU3RpVWtOWTlkYy9ydVJFTFU3MWN4OW50?=
 =?utf-8?B?c21zZHdMTElja1M4bEtHR05YaGh6TXhlcEZ6b05rTDdjemJjZU9DT2NOMXhR?=
 =?utf-8?B?UE5aanduZG5XMFkzL1c0WG5OQ3VYdGlPL0dYVEViNFJXaVJ4VU16Q1BiUmIr?=
 =?utf-8?B?ekg5eUhvWWVhK0JJbHFBZjI1OWlFYXhqVFBqWWZqbDlzaDB6dHFUWlV0UGtN?=
 =?utf-8?B?RkQvb0ZrYVUrSU1wbmJ2OHhXcjl1eDI4VHRHNzRRbERRaU40MEtZVDYyWUdx?=
 =?utf-8?B?QkJOOUYrc0lrbGZOblFxT0FYbjV2V29OWDlkeWgzbndSN0FCQmx5bHVyenJz?=
 =?utf-8?B?a1R4aWJGN3BKZ25BQW9za1ZvWElKQlJTNGQvSUxaTmxna0pHWjdtbndhd0ZX?=
 =?utf-8?B?U2crRTRBNlhDRXNOZ0p6TjZJT2xOMW0vWVdFQ0I1ZFQ2d05rbTVydGR6SEZm?=
 =?utf-8?B?OVJaNzVsTWRIaUgyZWJPRlBOa3FJellCSk1KNWFhWHl4TlVGTnozOFhKN0w2?=
 =?utf-8?B?Z0dzcDZVRitHcXpDQUpGQ2dOWWRHOC9YdmhUU21sbURqSGZBaGhhOCtHYkNJ?=
 =?utf-8?B?L0JqVi9Id05nTFk3UWswUUNGeGVxRjJaRTdmYVRSK3lLaWdnNE5UajRkRzVy?=
 =?utf-8?B?WXlsNE8rR05ZMUVlTnREek00cVhkNWZWWUZKdFFFSGFEek9RYS9jUnU2bFgv?=
 =?utf-8?B?b1kzY0lrSG1lRVloMDl5dGVZK29yMzBKdEZmM0xLV1pCN2EzQXRZTVVMUEs4?=
 =?utf-8?B?TEpGQ25tdUVOSGZEbU0xbmRHK1BoOUJ6cnI4dGd1UlAwM09JM1UrN2V6MnY0?=
 =?utf-8?B?cUtxNzlMU05PN1c1b2VqK0oxM21JTi91cG12YVhVZE5XdXphTk00djBmZEZF?=
 =?utf-8?Q?aZLBcD+yn6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVKNk5kaTVDZFZ4OFhVMzEvYUwzRFRkejgzdkI2R0g5RXU2eFBHQlJkTkcy?=
 =?utf-8?B?K1drN0dKNEhxRERqSHM5aWxCSnhEVkdxbTdIWitxcE5KUkpkd0VLYVd0WlMr?=
 =?utf-8?B?ais4UDdZdENFWEpYWWtJbDNCY1lxMFduWElqWnczK001cjFEeDRxQXlWMm1z?=
 =?utf-8?B?b2R0LzR3M0dMV29HeDhLSTZHbWVTdS9rSnlibTl5QmVzdk11d3d0VGZBaGM1?=
 =?utf-8?B?OWIxa2xBSGV5WjVaS00vbm1vTS9xaXJIQTV1dkp1SzRzQVo2VGdkWE1rb21V?=
 =?utf-8?B?SHVieVJYZ0dCOTltZlNwTDN3WGoyeFlqTDFKc3lrZjkvMkh5REtiMDFwcU9h?=
 =?utf-8?B?NlRrMHRXVUNvYjJtb0dWZHB1Zkt0UTRMNUg5UzlPb0tPbkF1OVkxQ0FoYzhR?=
 =?utf-8?B?ZUN1WSt0Skk0alB4Ungwb2UwQmZYQ1gyMlBWR21UV1A5YlZsOUdibXBqTlk5?=
 =?utf-8?B?RnVMYUxQdjRBVmc5M1U2SlB6TmplcVhZc1dRVFVWWFdpeWZ0eUZXNmQyTG1Q?=
 =?utf-8?B?aDgzaDRkelUwbVhWdER2Vm1JUVQvRWNpZXk0WEQrdlBmbVVFeTFaTUZPQnpy?=
 =?utf-8?B?RVBvWG9ncjRCQkIzWHlYU3pRQVkzcUdjUG1ncnFqV0wwUVA0QlFHYXBWME9q?=
 =?utf-8?B?SnR0TnUxbHJNcTVjdjZQeVk5enhkOURmY2daR2U2T05VK1MrbDVRYUJFdko1?=
 =?utf-8?B?am8vZUNRdWxHRjRKREZSMFkzZFcrRlJ4ZFVsWlhweWc3MGFJYjA3RHVEMHpJ?=
 =?utf-8?B?aTBLYzV4anJXaVByZk5rdUZjS3RXY1d2MHR2YWRHZXZvMTRJeGVXaklGY2Ev?=
 =?utf-8?B?QkVYTkV0ay95U3ZDT3hkSnYzS3J0TFdBUExvZGJOOUxDbXpVSVFaVXROd2Rk?=
 =?utf-8?B?am9JWlFvOHhRWCt3RHhaaXN3RFd5OHdqT3VUc0VQd0tqZEw4RXdmTlZhSGZt?=
 =?utf-8?B?OExBMWQrWE9KS1ZPWHlFaFYzYjNyV1QxUmVrOS9wUW82U283NWh1Wmd2OGdj?=
 =?utf-8?B?T1YrcFo1MnlDNFllcWhVdThENzBNeEVSaHZYb0NKTW5KLzV4dzFENXFkbkR2?=
 =?utf-8?B?ajhwWW4xL0ZVTXlmcG0yMDJlVlhEZUROTitvVG8va3RwVFYwUG1BOHFoMkNK?=
 =?utf-8?B?ZlUxQWRod2M1S3RCNXBVSWR1bGJYWGZ6TU5EMjJxYjVESk1KbUhYQ0ppZkV6?=
 =?utf-8?B?NnV2VmlnL0RLMW16MVBJZGZrOHNLS05paGY0cTdkbHdJTUsrdWY2YnFWZTU1?=
 =?utf-8?B?UlljUFdMNkhWMEl6cXhrZnE2YXBLekl6NTlGa1Q2c0NtNEFNTFZlQVkvYi9W?=
 =?utf-8?B?MWhMZU52SVV0S1kwUkw2ZkdVTmFES3FLWnEwUGVwWXRiN0lleGdwNVBENTFs?=
 =?utf-8?B?ZXVOY0ZndVBOUXpUTTdKNThsTEpzZ2xvd3ZEYlZGSjV6TW1JSUF1QXZxVTc5?=
 =?utf-8?B?SitMaFNpWkRQM3dldUFieG9SQ3k4QjZuaHpnUXZsaHpOTis1dk9mWXVab2pX?=
 =?utf-8?B?bmxpaVdXV1hmNXZrYTUzMlVTdlZSNnhqd3JOOHlFdmsrMEY5NmRNL2hvSEVk?=
 =?utf-8?B?VlRPMlhTNWlPbXUrVTYvRXhyeFAyak1wN3JQR0Nod1pVK0Z3QUtEd3IvQUt5?=
 =?utf-8?B?SHhMYkFlM0d0Y1JTSVRaUy9pNzVOcFNtd1hicDJIV1hubjduVkRpUUtWaG00?=
 =?utf-8?B?Uk5MVk9IRGVxVTQ2dGY5dUI5NU45OXFXQ1lrb2NpSTdJVUgvOFdmNEp0d0RB?=
 =?utf-8?B?dnpHUjJyTHRuUnZsaWtOdUhuSGFkNFF2c3ovdC9FdUU5NHlSb3VVMllWWEpI?=
 =?utf-8?B?MFhYY2NLUmdmY28xUTl1TjZ5RVpKN0V4QUVqbURHcWVqTDlNWjgwVHgyRGVi?=
 =?utf-8?B?QWF3SGhVMlV2N2paTzFOeUIwQVNKK0Uxdk04bTlyekNJbytidVQ0TkdvMENv?=
 =?utf-8?B?ZU1zYjZFUVBKRXJjczVPOEdGN3RVOVVVUWpRMzRUck9Nd2ZJR29xY3dqMU82?=
 =?utf-8?B?Z1I3YjV1S1pLVURTbzZWR1FXT1ZWZVZ5VStGK0ZiUTM0K2YycDExL3c0b3lP?=
 =?utf-8?B?RFpJR3VmZ3NkbzdMdVp1NHdSaFZ4VFFuclRFcUVyQ2pkMlg4d3hrdndDbkNR?=
 =?utf-8?B?dWZzTVQyQmlybVlXazRmWm8xNUgzQnByTldWV3NhTEh1MHpwS3FLM2w5d0Nr?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9//EhLKs3By3a5wimrDoove8LQlsh32AmHMZbDA51IqIizcoaQVBIspvjWPFgYDPrsXwPV1O3UnY1XHtE7KHk/2xBr9r4sinjvnLj/wsjGnpD5nZVpY1yTEhuLP/pxpxA+gkgWPOt4pJQM+hVuAMCum2tDntpPTVFz3U9Bm83VgUbyuFQedE/5q0ezEcZkd1/3OdmRcXy1Gn/j3ZB0BQHhyeVpxr9d86Tr5Q4aDWfCCxedbix0RePDTzr5AMjvOVfOGIaoT0ny+LJXDdz2w2R9QfJwyLiRa6fwd5hL2xsaQHl8dkrjGbGD101+k9VHfZDI731ApBDvA1uiEfhPZePXnQurWJKaHIViIMv+EmNzXQmbRDNCoIrZi58L7BdagafNp5liuN06dZYbahRjNo3CEhQ6sjGs+JmLg4XSHIkmq/ShqA36F413FkvyHXL0e/Bfpirm7/ZK5MngX60CEqGh7Xdgel0Lg4IIlneTf+FrfmTW3H9Aus3N4kQnqcVKi4HyM7YQrjO175s3z9c2lBSzwW8/dn3c0Hbdtz9YIAeVfTIt8a1zJOnO/RfXL+mWApfS31ga7swCzaCugFoERyovmg2poIQifwh76KckN3FqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bc0ac2-e86c-4686-12da-08dd826e1bcd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:52:38.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/fMgxHy4iJcDyyTKu7dVKFD1x0bOwdO2PUWv9eeX33ni2pmI3L7pMTXvc6H5BiQGzxER1Lb5qbklLGqFt+7OJlTB8ESPBaA5+lc2X6JyGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230097
X-Proofpoint-ORIG-GUID: isRLe_7vgZIqBfQUoPryrE3syUlz7goj
X-Proofpoint-GUID: isRLe_7vgZIqBfQUoPryrE3syUlz7goj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5NyBTYWx0ZWRfX8/XR0eIPVoJz WxxtF9NdqRyBFAIFVH9Msvpxcq4FBXfPdSqsvKR4KL/DiaVoUxnBA0WGUEdATP9DOJK7fpfd4i9 po/OGHOeOoxVN5B+lFFFsqtNqRpalkumGxA5OQqDfT80GoO6JpLlXyrQxyVn94g3yKF6S8V+Oy7
 Xylww1ksmqi/pH5BIAzuHMF5xlaaBQZ/Sp/+z0qB46KHh2wfTDN4B1i2t6Lw0LbBOehVmsTxh/Z PlvGUbAfCwivh4NMStQD9/B/00OGRWNIG+2TXLKbbt4OzAbGcJDelR6Q+JzMBkyvjqHVXarza9Y hpPv9vwfBRLZSKJZd0+WWZ0YbxxjPS8deVH7TogxVG13B/BOXUWd1ZTqycwozMdpuOAGTk3b2e8 GXXve2jr

Hi Bjorn,

On 25/03/2025 16:07, Karolina Stolarek wrote:
> Currently, CXL and GHES feature use pci_print_aer() function to
> log AER errors. Its implementation is pretty similar to aer_print_error(),
> duplicating the way how native PCIe devices report errors. We shouldn't
> log messages differently only because they are coming from a different
> code path.
> 
> Make CXL devices and GHES to call aer_print_error() when reporting
> AER errors. Add a wrapper, aer_print_platform_error(), that translates
> aer_capabilities_regs to aer_err_info so we can use pci_print_aer()
> function.
> 
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
> v2:
>    - Don't expose aer_err_info to the world; as aer_recover_queue()
>      is tightly connected to the ghes code, introduce a wrapper for
>      aer_print_error()
>    - Move aer_err_info memset to the wrapper, don't expect the
>      caller to clean it for us
> 
>    I'm still working on the logs; in the meantime, I think, we can
>    continue reviewing the patch.

I wasn't able to produce logs for the CXL path (that is, Restricted CXL 
Device, as CXL1.1 devices not supported by the driver due to a missing 
functionality; confirmed by Terry) and faced issues when trying to 
inject errors via GHES. Is the lack of logs a blocker for this patch? I 
tested other CXL scenarios and my changes didn't cause regression, as 
far as I know.

All the best,
Karolina

> 
>   drivers/cxl/core/pci.c |  2 +-
>   drivers/pci/pcie/aer.c | 64 ++++++++++++++++++++----------------------
>   include/linux/aer.h    |  4 +--
>   3 files changed, 33 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 013b869b66cb..9ba711365388 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -885,7 +885,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>   	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>   		return;
>   
> -	pci_print_aer(pdev, severity, &aer_regs);
> +	aer_print_platform_error(pdev, severity, &aer_regs);
>   
>   	if (severity == AER_CORRECTABLE)
>   		cxl_handle_rdport_cor_ras(cxlds, dport);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..ec34bc9b2332 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -760,47 +760,42 @@ int cper_severity_to_aer(int cper_severity)
>   EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>   #endif
>   
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		   struct aer_capability_regs *aer)
> +static void populate_aer_err_info(struct aer_err_info *info, int severity,
> +				  struct aer_capability_regs *aer_regs)
>   {
> -	int layer, agent, tlp_header_valid = 0;
> -	u32 status, mask;
> -	struct aer_err_info info;
> -
> -	if (aer_severity == AER_CORRECTABLE) {
> -		status = aer->cor_status;
> -		mask = aer->cor_mask;
> -	} else {
> -		status = aer->uncor_status;
> -		mask = aer->uncor_mask;
> -		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> -	}
> -
> -	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> -	agent = AER_GET_AGENT(aer_severity, status);
> +	int tlp_header_valid;
>   
>   	memset(&info, 0, sizeof(info));
> -	info.severity = aer_severity;
> -	info.status = status;
> -	info.mask = mask;
> -	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	__aer_print_error(dev, &info);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> -		aer_error_layer[layer], aer_agent_string[agent]);
> +	info->severity = severity;
> +	info->first_error = PCI_ERR_CAP_FEP(aer_regs->cap_control);
>   
> -	if (aer_severity != AER_CORRECTABLE)
> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -			aer->uncor_severity);
> +	if (severity == AER_CORRECTABLE) {
> +		info->id = aer_regs->cor_err_source;
> +		info->status = aer_regs->cor_status;
> +		info->mask = aer_regs->cor_mask;
> +	} else {
> +		info->id = aer_regs->uncor_err_source;
> +		info->status = aer_regs->uncor_status;
> +		info->mask = aer_regs->uncor_mask;
> +		tlp_header_valid = info->status & AER_LOG_TLP_MASKS;
> +
> +		if (tlp_header_valid) {
> +			info->tlp_header_valid = tlp_header_valid;
> +			info->tlp = aer_regs->header_log;
> +		}
> +	}
> +}
>   
> -	if (tlp_header_valid)
> -		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> +void aer_print_platform_error(struct pci_dev *pdev, int severity,
> +			      struct aer_capability_regs *aer_regs)
> +{
> +	struct aer_err_info info;
>   
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> -			aer_severity, tlp_header_valid, &aer->header_log);
> +	populate_aer_err_info(&info, severity, aer_regs);
> +	aer_print_error(pdev, &info);
>   }
> -EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> +EXPORT_SYMBOL_NS_GPL(aer_print_platform_error, "CXL");
>   
>   /**
>    * add_error_device - list device to be handled
> @@ -1146,7 +1141,8 @@ static void aer_recover_work_func(struct work_struct *work)
>   			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>   			continue;
>   		}
> -		pci_print_aer(pdev, entry.severity, entry.regs);
> +
> +		aer_print_platform_error(pdev, entry.severity, entry.regs);
>   
>   		/*
>   		 * Memory for aer_capability_regs(entry.regs) is being
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..5593352dfb51 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -64,8 +64,8 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>   #endif
>   
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		    struct aer_capability_regs *aer);
> +void aer_print_platform_error(struct pci_dev *pdev, int severity,
> +			      struct aer_capability_regs *aer_regs);
>   int cper_severity_to_aer(int cper_severity);
>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>   		       int severity, struct aer_capability_regs *aer_regs);


