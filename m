Return-Path: <linux-pci+bounces-26609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D893BA99869
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 21:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF0F1B86717
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103228A414;
	Wed, 23 Apr 2025 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FbO8YqPY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uHwPKELn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675B2F32;
	Wed, 23 Apr 2025 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436104; cv=fail; b=bxj1RWy41LYBi4QbMekXT7DPM33VxT0hZqdOdq1Lp7BcMDZp586/AHtt86NNiwl7gWqcnBnfhlPpuPaQkEz8Wlw/oHfe+EwJjaVdl2k8TZPHTR69gz7rd2C6r6SBfAr5ukp1g1xS6Hh1omvZ7sp+j1srMIHEXgC4oAKXyT0wnz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436104; c=relaxed/simple;
	bh=TD3gZ+DWVhr+qW8YB3Y1uPNExEf+1IKSHaQ/mAQZWoA=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=oiJVYp+C3VL3ihhwJG0T9iRih/+2rdP5fSWPzHwXNxih9mu9xk0H0V+faBxBZmRDFixaJ0pSrxWm4FERBtupCsshHwgdDK+eY22KEUmdYpUmQfePdHr//EIn9G0zLTcCopGeOx9dA9cgUahc0XLDF+XQSSodM1iBna6YqJMYxuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FbO8YqPY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uHwPKELn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGu47V025555;
	Wed, 23 Apr 2025 19:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=TLGjCjlDYZTe6bKD
	0Dw0Cf0ki6qKYGX9j7jO1ftQ/z4=; b=FbO8YqPYOvOsSBV2euWjnPti9t/biCW0
	CZpPjLylQDiKS2li0F17O1tudGLPWVU76We2eMnhY9t5g2BNhrk/X3Yp31fdIpLa
	A7/1yjFZf7O6UFdQ0nVgmkeeRQB3E2w6+8YxGYxPyPoL1kxQar2eL5Bu4qiiHTUb
	3Zv6mKdVCqtzUsXLBf8BEzXTbwPEkCCPjZM/ywZQrM7kwCkNCB+yXCZc/aa4U8Um
	/Ly+PFcFwmvgHYakvW5aSq++5jcuVoR4DxcoUIwJIz3aJKSMbLypNIwZEtV6W4bH
	+zOv6qlr5xn/xxW2K8g9golwCn1t0kZfEwkaFBCBmPZgT3W38ZsxiQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha20b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:21:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJIbdY025290;
	Wed, 23 Apr 2025 19:21:23 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010002.outbound.protection.outlook.com [40.93.20.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbr3bqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHmtk3aaakd152GndmobyDl/RCYGW/cWZKHbCyr5A1KXiVoLlv4GSKW72Fzdg8gDLe1e11+MV9+W+yaDdI488F1ILGHchA0GGjf5vE+XgFAdnEQ6P1UGZOqj4blEZxqHF5o7BLt26ZRi5Mh3ukFrTn41WD5XKAAbY4HxJwUR1LEs0/ZEysFdM/dzvnwplSzoj0YVSmPhWLEH/8JAuh3dJFLOM+55wLrUORarZTkfKgOTvC7+uEQS5TWXnyeQ5R5/zlEMuW8J9nG4U9qBoYopLfS5/PbYSAUTOqsRB1umM2cG8BTCyMfDMae+WE3Liybouv+g14PwwdeYEs3/EKExtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLGjCjlDYZTe6bKD0Dw0Cf0ki6qKYGX9j7jO1ftQ/z4=;
 b=NsbYvsLSDaIND4eKwFF2ArGdglRUFTm2dZUBT0TLS3oZbBqAgV9xDkfkNLPs6awrVaKoOGXkigvl1oMqVj0RyEVhhR9X3qiiNrZdSCqdo/keljwC9QC1R9MdIduj3LZBTXJm3dLcd0hvVLoosiLzkxgUrpW/Srs2RWfdWF87kfRG/+WQGeJde0GsdJmRgHlI4+9d3nhOkAq8l3UloC2csHkCyhebes2ZMtvMH02LGBJ6VldD9fuxpk4kLuV0Ezh7YFXpBMboBbZYuaIpLNm7vGytAzIW0T13bhCDC8nZg4mCL6hBzqed/mRBcwdPObGFd++nK4u8faJC9074blSUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLGjCjlDYZTe6bKD0Dw0Cf0ki6qKYGX9j7jO1ftQ/z4=;
 b=uHwPKELnD1jp4tyKiUdkN1S+OWmgxv70FR/9UtXPlTFclcJ63CNTquiuDXBtgH1QsAyxLx1erAYAnv0MDRu/0c3sLxtGxsofMSDN9Mm8kXJJjWNx9yh9+T9/eAdRXVYFPvEFJE5a1JcSY1gcs3sYMqRbXwKNysILVbdq/c8Y6lQ=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 23 Apr
 2025 19:21:20 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%3]) with mapi id 15.20.8655.030; Wed, 23 Apr 2025
 19:21:20 +0000
Message-ID: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
Date: Wed, 23 Apr 2025 12:21:15 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca,
        willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
From: jane.chu@oracle.com
Subject: Report: Performance regression from ib_umem_get on zone device pages
Cc: jane.chu@oracle.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0461.namprd03.prod.outlook.com
 (2603:10b6:408:139::16) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|PH7PR10MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c5c6f6-e4b2-494c-9062-08dd829c073a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2oxeWE2R1I4ZGV5bkRPRkx3SG5paVU1K2xuVUpkOEo1UFlDcytTOVVSSTl6?=
 =?utf-8?B?WWJGNjN0OTlaVmFBN0dEcmdOSjRRcXVYVytvajhURDdCck1NeS95ZzFxRXNt?=
 =?utf-8?B?di9ydUJpZStZSEg4RVhUT21OWlBKc3lYSEdsVDd5ZTdOeERjZXZrTjNZanMx?=
 =?utf-8?B?US8vcENsTWtsT0RudkZrN1ZnTjEyc1ZKYjJOdGZ1dHIyekZ0b0lTT3BFam9L?=
 =?utf-8?B?Z2RBRS9sRXZZbDBFc3JzRkFOa1hERVJjS1g4a2NDU1FUU3N0d2kwSFpHZkh6?=
 =?utf-8?B?RGFPbUFGZnNWWDByU2NKZjlnZlo4c00zMVhqbmpnUkU5SXdzaDh5YXMxdkx3?=
 =?utf-8?B?NmlBcUJoNXZiVEZUajJ4WXVFTGk5MFVONjNOL1BxWUxrVERCeUlVTGc5R2lF?=
 =?utf-8?B?NUZqTW9aM1JKUlo1WDFrWXh5R09wQVFpTkNxTVhLb2dTL1FYTTdORno4cDZi?=
 =?utf-8?B?UG1hYit4TENiNFJDSkRZdlV4NmtLUlljVTNlTHgrQjZaZEJHOUpiTU8rbzBt?=
 =?utf-8?B?aHJBaEhZQ1NhQUdDbXgzZkRYUExOdG9kNzQvSm1YeHUyWWVMSVY5d3RPdExo?=
 =?utf-8?B?cExPMWVqUjdnaytxemRVNUZFYmg3T2haYlJPMDYzTDR0Rit3dDlTbzNsMmFU?=
 =?utf-8?B?Q3FGck82TEVVcldUdk5MYVBkdmJib3RCYjAybUxKTWpjdUtDVXdDbmFQaUhE?=
 =?utf-8?B?U2c1SzRYbytMc2NjWFVuMnZHaFY0UW9yOW0xemUybTZqNmRiSVJuZUg4Z2tv?=
 =?utf-8?B?ZHE1NGUvY0FZbzJpS20rcTg0R0JoVWMwUkVlWWZJME5vVDFueE9ZRjhpdlhZ?=
 =?utf-8?B?b2lQUk5wOFVEMlBBRExpaGcxalRBQ3BWV0p4cXdTR1ZaVTNrSyttVS9xUWdo?=
 =?utf-8?B?NGQ4bkZFaURTQ2U0OVhJSHhPM2NwUHBveVF3dEszT1BTNHR1N280UW9QcktH?=
 =?utf-8?B?Z1RLMWRFMUkxN3Z5cmNvbC9IRjM1OXdKbk8xT1YvaG1ORlljb2oxVk9KRlQy?=
 =?utf-8?B?TXg0NVRhS21FdkRNZXVXUGZEMmFGVXdVa056SEYwUzFMWEhLd1pzd3k4V3Nm?=
 =?utf-8?B?VXVod3FScW82Uld5K2FMSm1RODNTL0JIaThHZjZWZGJBZXpQM2I0cDBtc3dz?=
 =?utf-8?B?R2pjeWc5K2ZhWVZMbGxMZGtWRWtPUzVMTjcxbHlsaVlSa2Q5U1Y2Zmo3YlUx?=
 =?utf-8?B?WTZMVmZpSFM0VmlBT3JFQlBZcWRhOVNiUG80WXVpMnl6WGtoUlF6aE9Wcmh0?=
 =?utf-8?B?VGFQUHlxcklPTDdsY0ZXN3l6c2NyVHNYRUMrMGR3NWZKVVhiR2o0N0hoRHU4?=
 =?utf-8?B?NGRpR20wcFEzaHppK2lMdTgyQjVBNVFUN1NsYTBSRERTWkpZV3R3Y2ZQNDQ5?=
 =?utf-8?B?ZmNhMlNrMkN3V3ZTRGRYR1RJYjVFVUw0cWRhZnJxak9xUGZoTG5od3gzNDc0?=
 =?utf-8?B?cEtONjVGbnJZVS9obDJmWSs1YytBSWY3NUp1UmtCem1CbmRVY2N0QUxveWdY?=
 =?utf-8?B?Z0tyU0IwYkJGZll2WGp1a3RpZjhEVHROc25vYUNDaEJubzNUWitibS9QdTYy?=
 =?utf-8?B?YldRQXFFRkVFZ0VDMHlQeStrbmRwWEo3NHFPV1ZZOHZPVEhhY0pzcTMzdm1Q?=
 =?utf-8?B?ZkZXTlJCeUQ0a1d2VWlBYU96dVRpRjczOFhyd25USGRpeTd3NjRmdnljQ0FF?=
 =?utf-8?B?MmhYdHlEbEZFWlhReXBrQ3ZubWZMNXUvNmV2NTdsK01WSWtZbGxodGZCTS83?=
 =?utf-8?B?WWZndGlKSzFCa3dsYXFFeW94T1JYc2EzZFEwNjQzNXB5NWZIVGhOc2dlK05O?=
 =?utf-8?B?dFJHcm80Ty90Z3dZakp2bzdEdzN4WXA4Vm1yY2EwcW1DVy9WbjhyQ1lTaGV4?=
 =?utf-8?B?SFFSNFY3Skh6NnM5Yi9ucUhpU0R3eWVJWGFrNGpIanNpVU01akRGdFgrTkho?=
 =?utf-8?B?Z1k4enZTRHZEdWhTSXM2MFNEanhoL3B3NndETzdEbHpRT3Y3OUNkdEZTVWdj?=
 =?utf-8?B?SHFIN081VzNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnNwYjAzRUhjK3YrNnJFdkRUcXFFS1RSODVaMjRpRHdSVlR6S0lRc0o5aDYz?=
 =?utf-8?B?UUdiQktBK1VmSEZyU0hwWitTZFZudHJOc0tNaUFpMUFpR0N5d0JnVVp4amtx?=
 =?utf-8?B?dmhMZVkzQWNmcFI0aU9sbjNlQUpoSGxqNS9jNksrd3BFOVJXTVZ6QmRTVm9i?=
 =?utf-8?B?anNIWUMzWE92dEFLdkhyanZUeDdiaCtNbzNER2tUL2gzMWQ5ZEJoODViM05W?=
 =?utf-8?B?MklBLzdoTjFNREZaQXFxNGxPd1RMT0FQY2FySXN6czZXalRIZ1NTaHVaaTYx?=
 =?utf-8?B?T3NOU1FYRjZnTjFhWkdOZE1XcEdsTU90WWpXWEFGY01EVkk1Sm1HRjZtQ1NU?=
 =?utf-8?B?bjM5VjFYQi9kSmVPSDA1VVpSWU9ucXRVb1JVcms0U0ppN2xhek10NlNhYTR4?=
 =?utf-8?B?QVQ3VThYcndNR2Y3MXZWQU9hckhsT0VWNGM5Z0VzdU5aQ2o3WkwvbFJYT1dS?=
 =?utf-8?B?WUVhWWE0UnFSSllSV3pOa09PNmFVcFlMdWd6YTVYUWlvR0pTWGJad0RlNUJZ?=
 =?utf-8?B?Sm1zdktIbktNUjlFUExoazNyTUJiaVlzZVQ2T0hxdkZQSXhGMnRld0ltQzhi?=
 =?utf-8?B?QjhYMXRCRzV6b3BuMjY0QmdvTXpYV0ZLcWRtNEIzR3QyZWFKMnVmbnlCcUVX?=
 =?utf-8?B?eGZlbEdwSUhMRytVc1NqYmdKMjNVbk9kUFZsc29mUk1NZWdPOEV1REgzT3F1?=
 =?utf-8?B?Tnl3dmd5Rys0TS9HREVHRW1nQytTZkJVd1ZXUmI2L0M3M09YZHlYcVd2bXoz?=
 =?utf-8?B?QVJHaUJtak13dUJRZUpNaUlIYXRmRkp3WW0vNGcxVUFLU1lycUEyM3B0OFhT?=
 =?utf-8?B?Z2cyRXZyMVp4ZFN6K2xjQ2hLZzBndEZwSnR0enJtSFAzM2FaM3hsekZLZmU3?=
 =?utf-8?B?M0hFRVIxWHFYTEZWblA1UE5oTndmbzFWbnNaaEh6T1h6RytsNStocENsaEJp?=
 =?utf-8?B?VktrWmlCMDcwZ0hIYUVNWnNKdFlJcitGYnlBalpieGMvZkFGSnRCRTJKZDZy?=
 =?utf-8?B?UytzZklRbUdCSGdTWHB6bkNTT3VvbVQ4ZEFCUlZlck1CVWlxWllZQ3MzQk15?=
 =?utf-8?B?allmOGk0M2kzaVhCUjJxaDQ2ZTdmWDFZQzFQWEMrRFF4OFU3emc4RE5tUFcy?=
 =?utf-8?B?Zi9IOVg1cjMyYW1YSElCVUtObEQ0ajV3a241NXVxc0VvNlFTdDFDeE9zNWha?=
 =?utf-8?B?K2FCcmU3NHdQaFhERHV6TUJSSytTQlhyQndjQ1p4MUxtM2M4RlZjVHV0Vm42?=
 =?utf-8?B?a2NnTldsRHRIVVJadDVXbU0yWThpTlFEaWxWVzJXOWlzaEJXTjdQcGVGbkRt?=
 =?utf-8?B?Vzg3WmtTOG91NDFPb1lLT3FYdDl6dXZ0ZEY1SzlqcFlXTmYvQ2Q5VFJlTTl5?=
 =?utf-8?B?ZEVGbDlydWt4WldPNzJCSkVFS2JpT2lTc0V3ZnFSQzN6aVg3VzM3ZFBMd1No?=
 =?utf-8?B?ditQL2UzWWxDSS9KbFFCeWZ1eW54U09ERzhNVEordnVieGZLZEROUzNnZVVS?=
 =?utf-8?B?SkM5OFhScmFHbTRYclB6SkJ2eDQzbGQvdzEyR1llZnZqRlE0NjcwRnYyWkpN?=
 =?utf-8?B?aWsxeVBOUThndzhzdEsyWU9MdXI3dkM1dUZHb05PS0ZzV05RYXU4UGpSOWRF?=
 =?utf-8?B?aW1DcEJFUE8zcTN0bWx6TVB5WHdqb1JiOUtCNGw1TzlWUFp6OE1PTkxueWJG?=
 =?utf-8?B?ei81VURCUHRubWFDZldPbTVBdnFXbWpoK0lwWjdqUEZqK1N2THJzVW1jR2lk?=
 =?utf-8?B?b2RkSzE4UEoxTXdiNFBHd3JWL3hhSklQOUtFQnJNaWJSUjV2cnFJcHRxZ2V3?=
 =?utf-8?B?MndudWxOdE11Smg4WXhJMVFwenQwNVRVSFkrc09ESWZBblBxV1FnSlBzSk1E?=
 =?utf-8?B?Z0xZQmZDUHJobmlnYU5DOWgyVkIyQm0zVEtIVS9FSy9jZ0ZQUEJLUW1Zc0dZ?=
 =?utf-8?B?WFlCNkVDc0JjNGF6aDB3NkJUSFN4TmRJNC9OcUlZb2tMNHlxU1BQWDZJRWhY?=
 =?utf-8?B?dzR6Q2xzcDJ4ZDFiYjh3OUVxWVpyZDF5NnJkczhqaGlqR3lEaUxqOG10VjZE?=
 =?utf-8?B?VHFCTC9FM09UTWVEZ3QvZHBTNFpINnBkMjBDVUR2a0E4QlpTRVdOa0gvN1lJ?=
 =?utf-8?Q?pYdvRLru1MoAJREbOLOC5ZN0O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E2B1HxAJE9R/1NvSyYWVKYS7eMvqNZGr0ANTD3Z/9aEB2l0UEHKq59kVAgT5mY4i5zBplQwcJloDuKYeKHm6iWf+roLQTIuOqsuMhppe1dwy18dVoY4yTlh3UNEs+nVfiXyT2d5par374qgjcTE5xiRYx9mkDxcEojYGVlL6sIBghbYmBt9XcFZmuyNWbgjcdl8eM929usDrQrb4BCKa/1J3HOWtyos7NSn0sB7ZU2VG2xOK7qgoEEcSRijUAFwTqZwbh266uQD1m1Z45NXXXAc25tD1rPvbbavysDO0FoFyyVZUPu4Rl/iW/Tyt1GxkxwMxExJU0+SRj0dSSz6h16OLAhXko71BehY2kiwwnaULNu7v/DrfHL454Kh+eL9iNCMI8mxCGWHEVTTYRanUCymZp+vaS0c1x6eG8TatQcW0D/I3/APOhl/hIjgIZE1cwld9rb0dLwBXiZ3NzWxmAoicOWQUiHLg/u+0QAUTbY2gDMHsAgZLE5O0qP2iOK9XmbmOJXlIw/b//Ipv+eqvh1mBQaqTY+1n97y9yflizYoOlQOGqNVF9rHT2Nm/0XOuoHIWd9XzKLPe/yDvbOnUeSB4QxxFCyX1fEb5lb3ZH/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c5c6f6-e4b2-494c-9062-08dd829c073a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 19:21:20.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqwuZeKcw6YdB8A+AlRowDHil4CWR1A3g6SB7MymipAzrx/4F8HhgvSvJ8k8L/LndSOMZiiqwI9PxZhXj8vIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_10,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEzMyBTYWx0ZWRfX+AdvapfSgyVd TGERAlILAMRC97IBCCH4AGnR41iyhE0wfkExFcWn1NMGmk2l4/6U8Ce98/xQgMT4+xOYIDQl25V m97HkrOqSdw/lMxZEuTD9bMtcPY8xS340PARYVJ76f5WKWmG4a0pCtK/JIWwgkMDXyo829bCc1/
 OLb9Qk3Wgw5D57azEBsJ/kKg2VYyK/VqTs4tcLSCe7uyNLSc1W4aRHHALfEnOu9LefnpVFOHMqg SlA+2MTx3VlzjGgl2AZGMsfPqVWKJKDMjys+DwytsoxjpOwVkem9ZWyuZkp1pxMghfmkUc7d0/d q9tInYn3ATXexg5c6bLQcXJuSXtw/Vz9vXfRVvNrrl3dvCYDyF/ukud9yibCepolnDaOGme6zeb GyjaMZ/e
X-Proofpoint-GUID: UuYweM41QaQgMWX3X2_IN1ukC6bZF8YU
X-Proofpoint-ORIG-GUID: UuYweM41QaQgMWX3X2_IN1ukC6bZF8YU

Hi,

I recently looked at an mr cache registration regression issue that 
follows device-dax backed mr memory, not system RAM backed mr memory.

It boils down to
   1567b49d1a40 lib/scatterlist: add check when merging zone device pages
   [PATCH v11 5/9] lib/scatterlist: add check when merging zone device pages
   https://lore.kernel.org/all/20221021174116.7200-6-logang@deltatee.com/

that went into v6.2-rc1.

The line that introduced the regression is
   ib_uverbs_reg_mr
     mlx5_ib_reg_user_mr
       ib_umem_get
         sg_alloc_append_table_from_pages
           pages_are_mergeable
             zone_device_pages_have_same_pgmap(a,b)
               return a->pgmap == b->pgmap               <-------

Sub "return a->pgmap == b->pgmap" with "return true" purely as an 
experiment and the regression reliably went away.

So this looks like a case of CPU cache thrashing, but I don't know to 
fix it. Could someone help address the issue?  I'd be happy to help 
verifying.

My test system is a two-socket bare metal Intel(R) Xeon(R) Platinum 
8352Y with with 12 Intel NVDIMMs installed.

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Model name:          Intel(R) Xeon(R) Platinum 8352Y CPU @ 2.20GHz
L1d cache:           48K        <----
L1i cache:           32K
L2 cache:            1280K
L3 cache:            49152K
NUMA node0 CPU(s):   0-31,64-95
NUMA node1 CPU(s):   32-63,96-127

# cat /proc/meminfo
MemTotal:       263744088 kB
MemFree:        252151828 kB
MemAvailable:   251806008 kB

There are 12 device-dax instances configured exactly the same -
# ndctl list -m devdax | egrep -m 1 'map'
     "map":"mem",
# ndctl list -m devdax | egrep -c 'map'
12
# ndctl list -m devdax
[
   {
     "dev":"namespace1.0",
     "mode":"devdax",
     "map":"mem",
     "size":135289372672,
     "uuid":"a67deda8-e5b3-4a6e-bea2-c1ebdc0fd996",
     "chardev":"dax1.0",
     "align":2097152
   },
[..]

The system is idle unless running mr registration test. The test 
attempts to register 61440 mrs by 64 threads in parallel, each mr is 2MB 
and is backed by device-dax memory.

The flow of a single test run:
   1. reserve virtual address space for (61440 * 2MB) via mmap with 
PROT_NONE and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
   2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the 
reserved virtual address space sequentially to form a continual VA space
   3. touch the entire mapped memory page by page
   4. take timestamp,
      create 40 pthreads, each thread registers (61440 / 40) mrs via 
ibv_reg_mr(),
      take another timestamp after pthread_join
   5. wait 10 seconds
   6. repeat step 4 except for deregistration via ibv_dereg_mr()
   7. tear down everything

I hope the above description is helpful as I am not at liberty to share 
the test code.

Here is the highlight from perfdiff comparing the culprit(PATCH 5/9) 
against the baseline(PATCH 4/9).

baseline = 49580e690755 block: add check when merging zone device pages
culprit  = 1567b49d1a40 lib/scatterlist: add check when merging zone 
device pages

# Baseline  Delta Abs  Shared Object              Symbol
# ........  .........  ......................... 
............................................................
#
     26.53%    -19.46%  [kernel.kallsyms]          [k] follow_page_mask
     49.15%    +11.56%  [kernel.kallsyms]          [k] 
native_queued_spin_lock_slowpath
                +1.38%  [kernel.kallsyms]          [k] 
pages_are_mergeable       <----
                +0.82%  [kernel.kallsyms]          [k] 
__rdma_block_iter_next
      0.74%     +0.68%  [kernel.kallsyms]          [k] osq_lock
                +0.56%  [kernel.kallsyms]          [k] 
mlx5r_umr_update_mr_pas
      2.25%     +0.49%  [kernel.kallsyms]          [k] 
follow_pmd_mask.isra.0
      1.92%     +0.37%  [kernel.kallsyms]          [k] _raw_spin_lock
      1.13%     +0.35%  [kernel.kallsyms]          [k] __get_user_pages

With baseline, per mr registration takes ~2950 nanoseconds, +- 50ns,
with culprit, per mr registration takes ~6850 nanoseconds, +- 50ns.

Regards,
-jane

