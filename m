Return-Path: <linux-pci+bounces-26657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BFEA9A076
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BD15A8414
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE015098F;
	Thu, 24 Apr 2025 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HhgghJxt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FABk6RJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFB8F5C;
	Thu, 24 Apr 2025 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745472936; cv=fail; b=B5j8cBAz0NeX4T/ND1qJwqCXLOYBRGtBNn647qfHkqC2JhyRVwFpcXsdiINbarG5SG0nBBG9Fzr/Jffw3tZNx/jdl19rqY+kyMqUP5vMgCB0IDDxrsxZi8qWZC9zbykLQWwsDviX05lKl91n6fIQ1ZaWXFG1jWdMVY2MtQhjIsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745472936; c=relaxed/simple;
	bh=WjW6WnWvkufJzMaUM2k8FP2sjd2yHcKqIkDuPFeS9z0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N9HKYkOpUp79bCJBmVxU6NyTI9UPzRhXdpwWZdgThocd4eZoOfPhuFyjuUVBIfe1w1X0EJbkWeesR5+cw5++gGaOzklXNgmBdTSIIBLZY4Wodt4zxsPf3s63WDIJ4WGQZjKofa1WtZzSzsWa4j0IDp0PUO7GJBov438QtIhtoc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HhgghJxt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FABk6RJA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O4gfhC004252;
	Thu, 24 Apr 2025 05:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eTo6++m3n/LmRvWsYbPHOPY9AuaHzPydvOR0y3KyRuo=; b=
	HhgghJxt8l2wTPjXzPWa8ra59WrLaqkcxgAA7TNIWJUXQMtWiU0qHSDZtSp38JmK
	yV8kZtYiDhevUEauXSZIPHcFctRbCeOCrplROO4m1Gk3VEHMLkQ512wXKBCqybOz
	WlpT3/V72Qh6omrOmzYjK+7AM8K1BtTowAbi2VLDfUFyifIB3qNl3aq19dj4rJh4
	pHYQIMjRn+wCn7Ez/26LiYo0uUeanBn0MfM6FevcAIPQDlgH81EToHGik/qwUjHs
	miIT1SIC2MsDqP9fkpwWn72URlu8lIrFftBMV0J44QGSI1p72vdIuH2+7maCsVO5
	6ixCoRJEPh5ZcwVshCPa7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467egng1r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 05:35:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O2fQIn025044;
	Thu, 24 Apr 2025 05:35:14 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbrkjas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 05:35:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUh/OA4Tmc1XjalD9nsdNGjPfW/jxVp84oD4E08h4qOMuBwS/Bw/IWYzVx/yge65xWe68c7xu1YdE6aHOlSSjUmP8EB9ZAHeNvfRbn54fgy2azCm5WF5OChnKILuUn5aY8iKNVe7TaCIw9PMiwAAoI/YbIHg75hf5cxB4l3qd/TslkYROUrKWdjz1Voky7AJ0+bYoj2j1S8fJDEmm+VCztfs51Eu8j5XXfKQZ3xOu+/UvDH5sZ4vMH0nHujZHqeypjH9wJdxovWmOKiE+WES3WZTKhXTebCQmt125qzNKhMjeq8A6V1ne+ja5fdFNKNBP4d9UgmrlJFIVYHlGRCE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTo6++m3n/LmRvWsYbPHOPY9AuaHzPydvOR0y3KyRuo=;
 b=qdkJt57pov6yFGXUX8kAuWIQNGeAomQO82S8T5cxF0NbHcSCKIBN9rnrKGxIQXRz8wIjpfH5ds1EIJINhzD8zZMwBMs9o2n9whYHFbPqJLVuX/lZARZjwvZSwowWFj97pjYayEu2PrWeg3PvgEtTmTWJSRs2QPOte88PSNm3bYzHxPlKYpenWRWqr/+IJg+TP/hW3b65S6IKkPuNqLzytGfd3AeReO7ZQ4eODGfditvPeMXruSm3joQLj6oO7qxTcprcXWIs/jCqmFDO/5P2Zp+w4XGOGsWhmQ2lUTKeDYf/FjWxYomLYBlVuZM5NXMBhPYgaU+vWCieHkIn4fTtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTo6++m3n/LmRvWsYbPHOPY9AuaHzPydvOR0y3KyRuo=;
 b=FABk6RJAy7C1FGZlCJLNM4rGuSVPgedsT1bnurRF0d/20+yYCxLcyuRSAjNaEYy56Ocxb3I9hjIkncsrm8IPn6TVg/drkkX/pAx83UThcdzGZrlAQxTbvnyND3rEx+uNHAug1EDJ9X2zL+J9p4bryG2TrsSR4inOwxGwZMDcyvY=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by SJ5PPF1849371D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 05:35:11 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%3]) with mapi id 15.20.8655.030; Thu, 24 Apr 2025
 05:35:11 +0000
Message-ID: <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
Date: Wed, 23 Apr 2025 22:35:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
        willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20250423232828.GV1213339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: c9003dd1-64c4-434e-3bc9-08dd82f1c81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUdteHZuQ1BtSmdsMi81V3AzOGVNblQrRElnczdIaWFGalhPSk1jbFloRnBm?=
 =?utf-8?B?RE1EaitwMkpGVmkxZytEcjVFNFJDU0oxMzEzRERKcGxMdVcyY29ZTDhTUEVr?=
 =?utf-8?B?K1d1aVBoUjRXMHhTVVp1Z21EL2wxdk9weWxTRWxxaklqMkl5RHlJM0VEVDN6?=
 =?utf-8?B?SE0veEttTldhY1RYcTI2dGd0eHpMdkpNTG1uNDZOOFRuRTZJUmdJV2Z3R0ky?=
 =?utf-8?B?bDN4NDVZVVRwK21YLytsd2VDWUhwYkhVOGRWYmlFNTBDWXI3UVA1U2laMzgy?=
 =?utf-8?B?OHZZRTYwcEkrd0wvR3NYYXM2VjVVSWRuMUFpUEdmc29mdkdIWHMxbmt0SkJH?=
 =?utf-8?B?Mmp2TDhiSXp3UXVnZm5GLzc1TldmVzVMbFVhRDYrQmFvWkZRdjRzQkNDSVE5?=
 =?utf-8?B?QktLVzI5dnViQ2I2U1R1a3c5QXpIL1RUVkY3czBuRmN1bUsvM09nZFRGYm1B?=
 =?utf-8?B?cFRza21LRldkOWczKzFJbmdGazg4MjhBMFVmdG1PUnplKytCQjBkbUZvblZu?=
 =?utf-8?B?SnFRT21GbzZrTDJFVVpOUnZuZHhkYnI5K0VoVDRUTUpFRzlUTkZHWVNuOVNw?=
 =?utf-8?B?OTYxV1ZWeGEvSjNIYUhxQjRmbnUxUWFDbVcrYmpaRHdaYkZSZEtHU2JoTmVz?=
 =?utf-8?B?dmEwbmwxbEF2VXZnMXhCWnpXT2FrWjk2Z0tPeVRzVDdvK2VYWUZwaC9vUnQx?=
 =?utf-8?B?VGZlSWViUFgzaVdZVGRvMWc3aHZvdTMzS3pTYzBKVWVLZW00cWlLSGVHRHZl?=
 =?utf-8?B?eU1QQk5TdU9ZcHl1ZEg0UjBYUldiTmdWQXZpQTA5eWJXWGFMTHBmYjhTTVFK?=
 =?utf-8?B?UjJLYVJmVnp1SVhodm1iODVFRGRFNnJPT251UFJHbXEvR0ZtaUtvVk9Pa1VF?=
 =?utf-8?B?WGZxenZINTBydnVhUGtMeVEzWU5PaDVKY1BzeGxRN3hTQ21RY2x2Z3oxOXlT?=
 =?utf-8?B?VEt2VmxnT3d5aC9GUDJoWmRtQUo3VURma2tSTzFDZEM3ZTBJdG1wOEd1U09l?=
 =?utf-8?B?Q0ZNbUVMcytkc25tc2xaV2lZVE42UTA0c2dDMVJsVkI0NVBmemtzR3VXQjRD?=
 =?utf-8?B?TWl4WVgwdVpYOVR4UGRkRlFpSmZkMnU0NitFQ0Q0N2dsb0kxdmNLYjBRUlFF?=
 =?utf-8?B?N2tRNXFkR1RFNzFNeSsxQTB2dDQvZW9USlZ6YTlCdmIwL3VRMUk4WTZyZmUw?=
 =?utf-8?B?RUV5WURBS3ljTjhjYk5lOG9iVCtCNldRbUJ3TXFKN2RibFhNdGJxUXVqUith?=
 =?utf-8?B?akVVNUhrRFRId29vRlhLUTV1SFJleEhGSEZmN0pUUEwzRTNwMW13UlJkSU5R?=
 =?utf-8?B?UWdVVnBnbXBjQ0o1VTl5c20wdDh2a0JMcC94SDZOY01wZUFNWUkvVGxjS0ZY?=
 =?utf-8?B?MVgwZUVYRUsrNVAwY1JIUzBxbDArRDRIcnFxNnFnZUM4WmF3NVlQNEZkNEhX?=
 =?utf-8?B?R3d5a3J2T3FXUTNWZDJEd0VzR205YmdvU29zUTk4QTFYVkF1K21ic042SnZ2?=
 =?utf-8?B?MUtZUnhiOGJRUHA0VDRKV2F0L2xMZmFSOU00Q3RvTXRIbGYvZXpVWHFmVU9j?=
 =?utf-8?B?eVJZcEtGY1N4NWlxZDFrOGppMHFWRmNEYnVmUkRybXVZZVRLeGdPZjk4bExT?=
 =?utf-8?B?Mm5OdTdTd2k0KytVU3JSaUlXNk0vckpUOWxOTHp5WjlSR2xzNkNMWFZYV28r?=
 =?utf-8?B?MlZGUFNCaHArZFoyN0RpRDZ3Y2wxZTNreUJZaExhYTZBQVZGcTN4cVR4K1JB?=
 =?utf-8?B?NU5pZ2VyOUVsTFh2ekhlYlJqUzc2OVhaSmYva25EWHFVOTBzeTJ5Q01vYWl3?=
 =?utf-8?B?b0FndnVZMDB1b0hRU090bkVDb3JML3R4cCtmVHRrL2JTR3kxU1hLb3BVWHNw?=
 =?utf-8?B?WE0zNzBxTUdmSTc2UWpQcVFJdXE1TUxJVmlEQm1VNFNzR2RoSm5OZTZGek9P?=
 =?utf-8?Q?QC4Iwq0tvs8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDRPd3BVYlVEaEIyQndTU2pvUXkwMXhFLzhleHJ6bEZPbDR0cVRoU3lEUW14?=
 =?utf-8?B?SFh4SnQ0emtLUFFvVUJrZ3dNRHdqMi9SWkgrVzVHTFBhR25QeEN1THlQRWlz?=
 =?utf-8?B?ck1GcElldzl1UWRGV0Y0Rm54MUFlc2JwRU92YTN6UUIvMkJqdENteWRycXM5?=
 =?utf-8?B?dnlHNzBUaUIvaVZvYWY1djJQUlZ4Q0lRNDhCRUIrLzRpZ1ZaVE8xVGJqcU9H?=
 =?utf-8?B?SGExZ2pVQ01YRS9EMXFHS1A2OFhPRE90UThQQWgxSW15NEpsZ1NEUThPY2VI?=
 =?utf-8?B?UzhHeEtnQldvSXBKUDhVcHUvNm9DOENDNkI4NmNmRGlINmRidEx4dkYvYmYy?=
 =?utf-8?B?SUgvMlMzdWhPWnhpMGQ1NnZmZUoyLzkyZ2JXM1AxUzFwcVBGTitLcmo3Q0M0?=
 =?utf-8?B?QllwSDhvVC9IUkFjS2EyQThPYW9qMEdLMWgxY0xjTkdZTjN0MmljeElXK1p0?=
 =?utf-8?B?SWpWNDlYNVhUY2pLVHVPVTh5RHAvbWZVc0IxSENIdXYxWHYrTWd3TzRYaGlt?=
 =?utf-8?B?aE1TWWtlUjg5T1FjVXhjRzY4dTdFcVZGR1B1QkhYQWZDYTRVZWIxRGpsZWdw?=
 =?utf-8?B?R2NjbVN6L3J1RFlsOXJQTzRoYTdCRXp4aDRReWRsa1FnbDRxNVRLa3RyOHdj?=
 =?utf-8?B?Z2NDZDl4bnV6WUp0enJ4ME04b2VLdklRaVJQZGwwTmhwcEFRMG91SVluZUdj?=
 =?utf-8?B?WXZUSGZUckRDZEZPRkd3eVhOU1BYTURpcnl4djMwdjRXVlppd0pqcHAxWGl3?=
 =?utf-8?B?MEZlVVZHd2ZFRDZZVFM1NkI2N2drNWdzMXIzWVQzcStiR2JvTVR1eVQvYzg3?=
 =?utf-8?B?VEoxV0xPUGJZNU5lc2xSMnR2SzJLVURNSnpEWE1TVTVsendhdVMrZUZpd2lB?=
 =?utf-8?B?eHdEWHRvVUpTbHJnMDFtR3IveEpvaWdhWmZYWGJaTUlDOWlObnI4TExRRS9O?=
 =?utf-8?B?U0d5MVdzdDQ5TVFQQlRlTXJQZDdGZ25HaU1ld0VhQUQ5ZDdiRWdlcERCVis4?=
 =?utf-8?B?dTFiaWFsbTdLSi9NVUZMSkUzbTB3NnRSTnV0dDUxZ0pvcFVtTS9ULzB0cU9p?=
 =?utf-8?B?MllRajBpN0grSFVyMWcvRm1RakRKbTdSOWRNNnhlN0V0NDUvcEVkNDNjQyta?=
 =?utf-8?B?ZkN2YjhQd09SN08yT2IzNjFEd1BOdDIyRlVFNkkrL2NRZUdIdjBzSnhpQ2pL?=
 =?utf-8?B?OVFFQ0RFVG5ORnFOV2RZVC9laFl0MXlESmlTeGpVQnVDZjBFNnZHSmkyVDAv?=
 =?utf-8?B?MnRUbEErcEp6Q3lnME1NbmF5cTBhcHFCWWkzakF5TGpLZXRldC90b0NvdUpU?=
 =?utf-8?B?NVAraldERkhaNk16QXZxQWZ6ekNVbi85dGpiT2d2c01wdTdWdXFPTlBjR3lm?=
 =?utf-8?B?dzFIbWhncHk1YkZsd2xiaXphZk1MVzhHM08yT2JJdXByMml1c21tM1lLTk9V?=
 =?utf-8?B?RGMvbjZ4VzFFUjJZcXdDeDhNSFpTcGhTd3F0aGIzWHBkOWMzNklsR3ZJcjIw?=
 =?utf-8?B?TXYxWUsrQVFGZENsd3A1Q0p6cGIxZVNWaWhFeGJKWnV6SU0yeXdjLzZmQ3FY?=
 =?utf-8?B?WVJLRHFsM1dwcnZwalp1OGNCZE16cDJvWXdKZHZOV0huOE83SDFxbmdOMEY5?=
 =?utf-8?B?VE9yaUZYbitQRVBSTDRUcHdPc0pYdDF6d0xGVTdsQXA5REVzRlpRNVdUNUpW?=
 =?utf-8?B?VlFNZ2NiWkhoZ3Fqbjd0MlBFejZEV0lCSVdFeWRPWjNHTWxoWkRVWGJWZUp1?=
 =?utf-8?B?TkZ3T0NkMCtyNzA1emJEdXFWUFhidDlvODVtWGU3RzVQTzJQN2ExTW13a20z?=
 =?utf-8?B?VHpQS0txbEZqVk0zZExoYVdpdjc0Z2luQUNCbGg3NnlJS1JLWE03N1VOVzZo?=
 =?utf-8?B?cFMwV1grUW9oQ3BtOWZHOW4vWE53NnR3aWNVd2ZzK0pGcTlKVnNSc09xQnA3?=
 =?utf-8?B?WkpHMnMxZkdrMzRMdk9QcCtHWEcvaUhDdGhuaERXSmI5c0JyQW9FTVZQWEZl?=
 =?utf-8?B?V3V4MXBBSXdZY0JDVDBHT1FVYlBPOU9FUC9aY1R2d0ZXRTBLM040Y2pNQklx?=
 =?utf-8?B?a0IxejNhK3NjdXNzT0NrZCt2Mkh2aUpuRXhYT2hnV1l6eTZId2Rkc1QrdzlW?=
 =?utf-8?Q?rE9WcTmPXR7QREXfv5ScwN4rL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/zrBxidf+e6KtzXmkhZNfGUzN0+GiX/BT0WnF1dyg9XEDgbisHcPbGOfHRnD+CyV7Fp4C7CwXiRKoO3RPCGIgWVGC/taQNyN8Oe7gjo+vIOKfvTjjRUBGlrQgQ0KAc0tfmQmj0WIeNMqXRZOdHUyt8gKkAGWkjvYDzfxIcawK9Qw+LxJ6xh2BR7jIBg5F+o1Em8Fqtl4LcUR75zmugEwfGdLEsoNwtCgGYFUN3pqLCOZoh8Qob53S3B2GXwh+i15RQSzL91+ZaFYHbgTA/WjnGTNapy8rusMlnwSLzkBICgK7G72lq3aoz1/4vaFs9NwEAhJVE/ouhZJzG2VruDJco04ZSgWOej9xfwca9P6z+yOhgMC5+v0/ONI5erTjq7lAFZr/SRw8DxEwqLqcoXKy3bYKX+MDSONRPJtCAzOBb0n0ogQJMyQyU4TNWYj6Xj/rRAMPhKI3WkIpSbsvHZywxH8PqAhsSBIfzhaO/U/YQXTrMuURgApx+Jr5cdd/0pi7+NR0rVhJUWcYxeDfi8AwK7451oCso+BY3yRswYQXAbWW4YGpeGWPbFWN6XucQ834g/BhU+gb8etxEqHDYJ2yl1btvDFFKZ/5fDOCaVfNTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9003dd1-64c4-434e-3bc9-08dd82f1c81d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 05:35:11.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbglvPhYaAfFNtk9YDPj6nNP6CQVefRZ3XF4Qvx7g4lT/YzLakkl5MJhEEhpuw+sQ81YAINpJVUh/Od/MSGxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240034
X-Proofpoint-ORIG-GUID: TyoGVM7Jj4KSqUpzau4w5FMHGL2LLTku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAzNCBTYWx0ZWRfX22kLMVhHXLEj +gq+msiYi5TFAm05fns0x5rgH4jMRUzDRRs9TlJOu/mSnK/fLxI3kwNVbQu1mcczDsut0SMZtWb g3s7IPtCg8zD0nDHNSdwLTfC/0SCwckSnNCF7GnBHbVQeir2EurNTweuxIYYtO3SjXcbtXxUM0K
 KzMj3Bt7lnwW9iUK6NHz619BmF0+2ySp+FiUGmdoFscSWimzG89WQXEBgQp1WUQYxN2nnrDhrhB fnd7vQ5uZpMSkqg+sGjC1CVJvxTQsJZ3siVQSI1MhAIBaFzG5bhG1h7/L5zIHgUdmSYHtQRpUbu Rw+CemcmqYYztKcjLuLCTAX5hL7Y6Yjx+pdG1W0w3qI//wPPF7x3e5HeH/SucJ9ayJ2cvhPwUAy bGaOjvQY
X-Proofpoint-GUID: TyoGVM7Jj4KSqUpzau4w5FMHGL2LLTku


On 4/23/2025 4:28 PM, Jason Gunthorpe wrote:
>> The flow of a single test run:
>>    1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
>> and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
>>    2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
>> reserved virtual address space sequentially to form a continual VA
>> space
> Like is there any chance that each of these 61440 VMA's is a single
> 2MB folio from device-dax, or could it be?
> 
> IIRC device-dax does could not use folios until 6.15 so I'm assuming
> it is not folios even if it is a pmd mapping?
> 

I just ran the mr registration stress test in 6.15-rc3, much better!

What's changed?  is it folio for device-dax?  none of the code in 
ib_umem_get() has changed though, it still loops through 'npages' doing

   pinned = pin_user_pages_fast(cur_base,
         min_t(unsigned long, npages, PAGE_SIZE / sizeof(struct page *)),
         gup_flags, page_list);
   ret = sg_alloc_append_table_from_pages(&umem->sgt_append, page_list, 
pinned, 0,
         pinned << PAGE_SHIFT, ib_dma_max_seg_size(device), npages, 
GFP_KERNEL);

for up to 64 4K-pages at a time, and zone_device_pages_have_same_pgmap() 
is expected to be called for each 4K page, showing no awareness of large 
folio.

thanks,
-jane



