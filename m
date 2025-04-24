Return-Path: <linux-pci+bounces-26637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C41A99E7D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3860B5A5E99
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9891624E5;
	Thu, 24 Apr 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MYYkVp18";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uKCnBtmq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2421DF759;
	Thu, 24 Apr 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459395; cv=fail; b=aXjGirUp8gRjDTK42MgJInZ2lF2p860x+CQKwmCN1jsvmNRApkZJlnS3qMc5mXW0ruXdpwwYhlaq51y9y+T2DMrD4b0eF+kSwl98c1MJjPgM0nqddJ+f8n7s0q9YRf3dSiRZQO7VNi9sTqiTA3GR1q07mIDp6gCH+OLRm/iO7e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459395; c=relaxed/simple;
	bh=pKXZf4a70gZOfeqdrJlKEFMfLVG9Y/mGoWBpFaxHHQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H1LoPjOb2J6QnFluIKcJOmowDPVdtv9hFzT+Cm/U5QXL5bWFNM48bg1CmlI3TUlDSkgpxBgUa18uMlz7GMt0P1ojmxgcpbnenBKQD8bHdC0dGRwMFvU8J82ppF7Bpan2KKxz058RTg6Vc9Pz6mCduhhj5VUv88BzkSGHpGcqSRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MYYkVp18; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uKCnBtmq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLMuog013977;
	Thu, 24 Apr 2025 01:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nYu3qUJbhusnloRkvjRMq9LbrDuGr9+VaJu/yAE1kuI=; b=
	MYYkVp18WUF8MAUncs3G3iOwpH+rQqMJ2NsBeMhciViiCiKhhNPYO6w6GI90MzPW
	y6HvIyY35pyX8bbj7kFXEmJQZc/eNUW+yOorc2soEwgPyORmyoxEWXdxmRAsu+j9
	nEydXEU/DX7mcfYz4FN1E+HVwRXeosemWzp25ujzthcBM2SZITCOkLJnrafbpOlc
	GftZ6s9OEyLSirP/XlT2WTe4RV0F6Wx5az/o8P8MK2MKnUCkCX2tcxTEFFseA3C1
	FKWDD4k3hk/8pneuh0BM4rTzl7a5c6xUL/z3Q8ezgOLW6ZVr5K+Jw8KkMnq7w7C3
	fVf0Fr5F0CM6iELs2CgwUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdjtqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 01:49:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0MnaG017418;
	Thu, 24 Apr 2025 01:49:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvfwr1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 01:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvqIvExkleUkEodH1lffNcON6GgmLeu4cHTnUZvS0sOVrThNdwzU41nBFQLEV+33aw/6ZFlYfjUpKubzZWgA571MChxQfhl6Mi4PKyr6hni0BdwcwZcbF6qwKh0OBOlxU83vQptokuXDF8TQpgYKC7u0KqHEkOOlN4oR5dyVjsiCkdmPMXVVnhZ9jnGOkPYSuUR5l23xGB6D8HEE2xKjDbWLDP4FZl/SEQusp/uJSFoLMX5S2Gbij1d6GpPtpWb2MDb6COPFmke5f6KqRa1J3o2ObCPwOn1U1kaqvuCyWzehTsA9l65EGORBe9zB9gOtdR2MBpMtTmyKlmsoZG8byA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYu3qUJbhusnloRkvjRMq9LbrDuGr9+VaJu/yAE1kuI=;
 b=QBSGxHtJh1Ygc3peBp3+ogSgWzo5bsS1moHYjWX0Apvzn1Pg+xHy4xqN2/TdX7xWVUTFVH6dlC5Rs3LS1tJPeJ+yhDQfkjoYmbzdIdChvYgiShazECpkxboQcn1lFlOc2DwZhIhSjb85UH8SswcqXvTFLACnFbDfikasUJWp3DuRDWOP1LHpCgl0K95hZAUvzONGS591WT1FJoXpYtEHW4YJ/MMBsSGiAFsnLWuRTuB8X1eNJxdqeOOrpgMm23Tgz0G0GRZVvw4krAtAHPbctNVZMM9xdGPdXywqED6gMSRvU4ONGwhsuC1aOdw9gfi8C711v2jG+rTgmpAWTkQYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYu3qUJbhusnloRkvjRMq9LbrDuGr9+VaJu/yAE1kuI=;
 b=uKCnBtmqoaCOKotj2J0dZ37cyB5hIRxISQRubJ5R3A1eh0X5Zoke2K6RxmU1wqk9QXY5j6R93Hj12iOwUj4N75BmcBp3a2yTq3vFK9DUJylnlW36Chu0rcmeVIsWLWAIvJthvPXWVqNff+Ub6o8ZxmTSTlbggHyxm/1N6PdwxH0=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by CY5PR10MB6024.namprd10.prod.outlook.com (2603:10b6:930:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 01:49:33 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%3]) with mapi id 15.20.8655.030; Thu, 24 Apr 2025
 01:49:33 +0000
Message-ID: <914dfa88-d36c-44c2-a7d6-22f6fbd2b86f@oracle.com>
Date: Wed, 23 Apr 2025 18:49:30 -0700
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
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|CY5PR10MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f49b051-4f14-4917-390b-08dd82d242b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ZiSWl2d05ITnBBdzR4WTFUM3FXRmIrOHIyTHFOcnhhc1E2YkdUUW5IRmNr?=
 =?utf-8?B?dEowSFhHbFFnMXZQdkNleVU4YlZLRktQdy9vUUtVYWFOTzZNNllWdkFLNXpv?=
 =?utf-8?B?WE4wRlVpdGxBVnF4T2doVmdSdURJalFsV1VQQ09hNjVIc3FQSVdSY1pCYlNF?=
 =?utf-8?B?My9wbDN1NXp2eFlpaHRMaWxQV1VBQlMvenJxTHZ4SkZYcUI2Yk5mT2k0RGsr?=
 =?utf-8?B?ZWY0SW5HSGYrZzZORDU1TFdpY2hBZFllMzUwck5rSFVpNjJsQ2NwR0t6OE9W?=
 =?utf-8?B?S1dMWm9EUzZrYXJ2ekFHVlk1cDB3ZFU2R1JsVk5JcXJ6RjRDWElKRUNsWHpP?=
 =?utf-8?B?VWE3Y3NjZ0Q5R2p0bmZ6RDcyQ2hkdWYvUmJIK3dCSEFIb2tQdTV0bUF3SC9N?=
 =?utf-8?B?aFNwZkQzRUpsajVsU3NpTXQ3ZGZJWWE2ZVJNNTdwYmZZUnRvK1daTXVBRGpo?=
 =?utf-8?B?R3pjeC9KLzdEODltTy8wb2ladHJQZHpJanJXbUxiSldGUnVmU0l2bysxbUl5?=
 =?utf-8?B?b2VNeFdHc2tMd0VITnV2d3dZL3h2Tjl4UnpyS24yRmpoNkIxN2Njekk3WFZM?=
 =?utf-8?B?c3g1M2NGRk15RjQ4bnZxR0lPd3ZNc1VUTjVJNWRZWWlBSlZwSjFUK0REMHVV?=
 =?utf-8?B?Ny9xbnc2RVVYZHVQb3hhc1BKUXFtT1ZDYWtacFl6MEFvWnNTWmtqR1p6WDBq?=
 =?utf-8?B?MEhmY3BVS2hGN3BaYkFwbm1MYkRRVVNzSHMwc2N2ano3SWdiakJ6RitqdCta?=
 =?utf-8?B?ZEhkd1JQa1hXSGluL0EvamZ2WVdqU1gwZXBNclhwNHFwa3ovaEFyQnRjT2h1?=
 =?utf-8?B?a0VlWCtPenhlcDQ2VWx3enUyM3VaV0MvaXlmaHB5TjJGMTcyMzlORXhOY3F5?=
 =?utf-8?B?Q1N0ZHBrOG1mYVVSMVo4OW13ZHlQWDFKQnU1Y2hNN3hySDdUdnZoMDYzVklT?=
 =?utf-8?B?MTNybk5rL3hZU0RER3hxWmJLWDlZTEp0UDlZUFBIRzJtUUthU3laUlllanpr?=
 =?utf-8?B?UDFuVDNWUE1OWndGZ1BIRWIyRGQ4MGpTcXFLTVZrYTRPRGVBUVhQQ04wakN4?=
 =?utf-8?B?ZDBjdlJwM1lJd1ZvK1lKbGJCUmFhZllzZWl4aE9Oc0dzM284aVV5UDhJT3lD?=
 =?utf-8?B?OEN1enhmTExZaE9mcEdFdWtEZFg5WGVMMUVtK1FXVStZZUZmcCtrZ1E0UGtu?=
 =?utf-8?B?RFZjQmZOdEp2blBxZ2RINjNVdW5aWkV1REp4OHp1NHNrL1BBVGJHZjhZUXdS?=
 =?utf-8?B?ZUsrUWZJSXBGT0Y2TURNTlEwVjFDT3BuVHBpKzlzOXdYUXNocy8zSTBhazdW?=
 =?utf-8?B?dWQzZUtHS3B5eGZxY3Urb2F5ODRseXVxdFhIWjF1WGJvQklIQzIrT1BwM05m?=
 =?utf-8?B?Z0V2QXpXRVhiTCtRRTdnd0ZpeVNSeVl3SklMY3hqQTNZaFMvOWVVOHZJcDFy?=
 =?utf-8?B?clBQZFhoQlZLZlRCNXduNnhGcXQ4cHVwY21XKzdSbHd1eU50U1pRV1k1REgx?=
 =?utf-8?B?cVl5NEZaM3N3ZlNnY0t1VVhFa2hFRGZGSWVialJ0L0VjV2IvNTNyb2pOTTNw?=
 =?utf-8?B?VXJrMTc3eDFWbmdKZ1BjSm9FRFpKNE5hSU1weDJKZmhPZnV2UWNobkh0VTZL?=
 =?utf-8?B?M3N5OTkxZlFoV1UxanJRU1NZR2x4ckhMa3hSNy9KSStmSkhiNU9wcVIxSHNS?=
 =?utf-8?B?WmVxVHZWQWxDOFUvSTlUbFpDWitsV3JJRVhsV2ZEeGxVUDZ2dlFvSkNDTm5C?=
 =?utf-8?B?bk5tekI2dUFaMFBOdUR6a2p4aU0zUm5qK3NUY2hsVTl4aTg5NWpqNHJFeGts?=
 =?utf-8?B?cVNuSzk2QkQxWEROR3FSaHBhM0s5d0grQlJvWFQ0U3FqcjBXUTFEam5uQ1Rl?=
 =?utf-8?B?RWtJb3NVT3VyelVGNGNOYnp6ekpheGVxQ1p1VEJjVmR5ZWxDZ0Z5ai8vMGIz?=
 =?utf-8?Q?Nii/LzCfim4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yjc3UERPVFNWNXhIUHA5NGREbk1RZUEwQVgvQURKUWN1ZldFd29GazI4aUJs?=
 =?utf-8?B?cFI0T1NNYllsb2lxZWNTeUZ4cHRqUmJiZjdwbEdaUUcxa2h4WnFPcmhQZ2FT?=
 =?utf-8?B?OUdBV3RsSUNMQ2RaUm1DSnNXUitaSk9GejQ4ZS9LVmllQWxqVWZuTjNMMTRS?=
 =?utf-8?B?QXBPNzcxS0ZxOXVqRkxhZVpTRklsTHJKaGlMajVxeFNGdEFNL3o4U2ljd0kx?=
 =?utf-8?B?L0ZpSXY0Wm1idjlJbm42aEFZY24vS0JocXJydTVTK29UR1Eza21BODEzWjFT?=
 =?utf-8?B?Ym5GOTVPdm9OSXUrc3pybHpuMVZlQjVna2FHRndLVy80a0NFVUJIUlF2Wnl5?=
 =?utf-8?B?Vm9naTdTRjFnZWtKU0FwR043S2liV0VtdlludDhTNzlyaVhHQStmcXJqRkNp?=
 =?utf-8?B?ZDBBVlFtbUllbDdTT3BQVXlxMUR4cVV0VFd1TmQrcnlmbmh2ZW1oVGwwMGcw?=
 =?utf-8?B?NU9vcUNBaGgxaDFwczBVdzNERUtDSTJwclRyczBKdk5taHVZbGxaUXpWS0ZS?=
 =?utf-8?B?YkxyREEzU2VNRjVxSkZ0M2hlUUFHQjlhUnRRM3ZqeVNLWklCZVNvY3RoWStp?=
 =?utf-8?B?cFVrRCtpWVRNSjN4Z1RQYWlxRnlGaHRhZDdtb1RLU2h5TXAvSmxYaVZPQUNW?=
 =?utf-8?B?UnlacitDdGVUdVlRN01yazNRKzJIaGFHeWxqMFNiUGUyRDJNcjhMamlOMDZy?=
 =?utf-8?B?WXFCK1IrU2pYUm4yTlQ4U3p4bDZGTmlPU2VUUTBwZFRGZEtGYzJQcE5LS05t?=
 =?utf-8?B?OVJYSGVYUHR5SXVJaWxhL3pTM1craUtiNnhwZ1RVMHhCL0puVWE0dU1RVVFu?=
 =?utf-8?B?Qk9OdVA5dUM2bms4MHBRUVlGT2Qxd3lZTmFzM09ZbGtqYThoSGJ4bzlrb3VE?=
 =?utf-8?B?Q3g2THVHRW81dC9yQjhhZXEwY3BabWJFZGhpL2YvTUk2SExGS09FRjBDWFVL?=
 =?utf-8?B?TDQ1U0F0QS91VmkrUHcvU0pMTjRQbjNSVWZXcXkxSFMwR0hlc3E5S3VIUG51?=
 =?utf-8?B?WWg2bGl4ZXA3UjV0anFlYUZrci9BL3hOMXpybjZ1L2haeHVmUW45eVA1T3hM?=
 =?utf-8?B?ekF1bVJTYUZ1SzZVRG1JcjdKVm81Y0hoY2NDMjRnc1NRZHFXdmExVzNsbjBk?=
 =?utf-8?B?Rk9KdVpoVmhUK2pCcWxkc29BRFdRNE5hRk9kUVZ0c2VPOWErU0JpMFFZV2c3?=
 =?utf-8?B?eEc3VHAvV1QvZTNLc2x6N0dNKytlMlY5OGVJUk9PYjRCeFk2bjhoZEs5SGJz?=
 =?utf-8?B?V0dWa0hLeHlxZURHcnd3TE5oRjNJVmhIVXVBTmY4d1g2SUlPdTcveXFkSUpG?=
 =?utf-8?B?V3NmU0ZhQ01JRkNua1E1UTg1WGlBV1ducm5xYW83b3FGdmJnVkxjeVAydTN6?=
 =?utf-8?B?VUt3SUY5SzExZWZUcTc3ZnczeVFWZGUxQzJBaTBVbmVXZ3dzVVYwOWc2MkRR?=
 =?utf-8?B?VEpDamE0SGN1aXZ1elNXYjdYV05jbDdST21vc1NyaXRKNkd0NXQ1UFhTZEVt?=
 =?utf-8?B?NG9tcU04MTVvZTV5dURlUFVxNkdmUDNIOWJob0pYdHJOaGluYTRIY1JyRXFW?=
 =?utf-8?B?Uk15bWtoV0pIYWJlVlJ3aUl2bm9ucmVJdndDbnA2UE1rckYrLzE4RkU2L0dT?=
 =?utf-8?B?VUxXZXV6ditmenM2Y2tzTWM3VGl3QnM1SWsyV0V6VlN6cGsxRmtzcnhUd2h1?=
 =?utf-8?B?N21SVmRlcFYzRnpybzdGWG9pMDlvM1RXQmpIcnJSRGZBZEVVSVdseHJGRjRy?=
 =?utf-8?B?TTdGNzZmazVSb0RaczRad2xXTUt3Q3RMMTBUeEtjbWR3OWIvOG9lZVZiRFJX?=
 =?utf-8?B?U2E5QVNDS1J6RkZkMk41OGt3d3QzM25lZUtzOEd4c2h4ekpxczhjNExPT2Zu?=
 =?utf-8?B?aHpYMmVZZmt2SlJURXlKTC8vWDdGRzZTb1RlT3g0Nk43cjhsZDUrMkFPaUlt?=
 =?utf-8?B?YlZWT28xcTYzcitkd2xleWZUQVJnYkFVT0xXem4wa3RHOVYxbHNzMm9iK2Rm?=
 =?utf-8?B?TW0xUy90VmYxckcwNHdacUs0NUE0NzNjN0lzcG1QTnpCVzBhTWpoQW5CcUhW?=
 =?utf-8?B?MXAyTXhWWnM5YlN2dTRoUWdCVVlpWHBSVEFab0NjSlVqSzZ4LzdIcExPOU45?=
 =?utf-8?Q?cReQWMzByYhOJ0YcU7aADS7HR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sTCsRy+iAzGM0cB2lNEk7FoMf+4y1Nw9EGwHrFl6Aiv6Syx8Ti5AKKN3gqXvpEzlBssPrh19wX84fKpzwJ0QvvA9nFUyDp0XR5ZLYc/0PfOr1ZM2CdmAT5J0EgDIMmLukcFH6JQbkQytMzRejvwb4BK2uUNHIJdo/nilG2bkuYL/MwJ63VnXvnuIjQe3Q1cdsyVJ9pdWWuJVK+KS0hVGlCYau1m75xReaE3+xQG/apz283BZPOuPp4g8mg8rOgvna1APN4fHE4a64/vFNA8hETfo/zPPpelj6ehYIJNsFyebL65v78wpK/ErRRLbb3cGLonSffbK5u58PuhC7NAztuZDcwfdyWT/BjNBAbdihgREI4LcqWr5mbUVk1YbhPGuHhPGFKQ+df+U1sNQY2FHIL2qY2bI1rGWIfBxpnbFfU9+K2mnk8EzIUrNPVRylKxf3IZHHBr0giU6iOrFa4ZprcrHaNQSE5GFYFQ+WS8BrpP08rjBYXq2kA/Zqn/csuFaE78mDWOKJp+j0o9HuTsNGgocW3wQAnBmMohsof5oQSve95hqD9vzzMSNoqAuxBSXmqr9xZd+d8y7tWrZuY02pacEN4zsmSDD2vQp5V7Y6LA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f49b051-4f14-4917-390b-08dd82d242b2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:49:33.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyWvy4GeajadcdfWEW/BBiuqhru4cJ1yrd7KzAXWGGCh+nQ+8pT7WtvAjFrMppx4ONHmx6qPOjA/1QfRt1Gx9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240009
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwOSBTYWx0ZWRfX5PlOThrX7yeY Zs1Aj3xeIRLC8hORwKGYJ+m1r+s1V6SxNR4smeU5Ps1dzfDeiNZNu9XxXIgC4SQtov2EfODspRu h5u4+9hUUJvMaafyvZnlbcvQtW8A2fYNWXmCfVTzCB7btsVAPahZmHZVEEw+Hpk2m4StoEalFSp
 19cZyt7xH1Y6xTGCqIPGsrmROHyCBN24xRbLAh42X9qAAWi4kRk5bzCRewvBuLComWLcljroGm7 l0M4iK2qTRpnjL4r+xnQAUDhu+lSBQ8bK8dEgA3lIFQglC5RDOqbKTQH5nGqPP2tqNeKtpOv4um 9XzYCrctio7xuMgao7tHweV+XtmFDTfXxjHzxpBwrx2e61xjomUKS+gCeLU7BH319sTB1KnfTP9 6IWiNTkb
X-Proofpoint-ORIG-GUID: rxo0B5AohoNfJ67Rhegdu582KtUyhw5m
X-Proofpoint-GUID: rxo0B5AohoNfJ67Rhegdu582KtUyhw5m


On 4/23/2025 4:28 PM, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 12:21:15PM -0700, jane.chu@oracle.com wrote:
> 
>> So this looks like a case of CPU cache thrashing, but I don't know to fix
>> it. Could someone help address the issue?  I'd be happy to help verifying.
> 
> I don't know that we can even really fix it if that is the cause.. But
> it seems suspect, if you are only doing 2M at a time per CPU core then
> that is only 512 struct pages or 32k of data. The GUP process will
> have touched all of that if device-dax is not creating folios. So why
> did it fall out of the cache?
> 
> If it is creating folios then maybe we can improve things by
> recovering the folios before adding the pages.
> 
> Or is something weird going on like the device-dax is using 1G folios
> and all of these pins and checks are sharing and bouncing the same
> struct page cache lines?

I used ndctl to create 12 device-dax instances in 2M alignment by 
default, and mmap the device-dax memory in 2M alignment and 2M-multiple 
size, that should lead to the default 2MB hugepage mapping.

> 
> Can the device-dax implement memfd_pin_folios()?

Could you elaborate? or perhaps Dan Williams could comment?

> 
>> The flow of a single test run:
>>    1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
>> and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
>>    2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
>> reserved virtual address space sequentially to form a continual VA
>> space
> 
> Like is there any chance that each of these 61440 VMA's is a single
> 2MB folio from device-dax, or could it be?

That's 61440 mrs of 2MB each, they came from 12 device-dax.
The test process mmap them into its pre-reserved VMA, so the entire VMA 
range is 61440 * 2M = 122880MB, or about 31million 4K-pages.

When it comes to mr registration via ibv_reg_mr(), there'll be about 
31million of ->pgmap dereferences from "a->pgmap == b->pgmap", give the 
small L1 Dcache, that is how I see the cache thrashing happening.

> 
> IIRC device-dax does could not use folios until 6.15 so I'm assuming
> it is not folios even if it is a pmd mapping?

Probably not, there are very little change to device-dax, but Dan can 
correct me.

In theory, the problem could be observed by using any kind of zone 
device pages for the mrs, have you seen anything like this?

thanks,
-jane

> 
> Jason
> 


