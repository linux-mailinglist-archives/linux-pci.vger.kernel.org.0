Return-Path: <linux-pci+bounces-24348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D3A6BBD5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1059C3ADDD0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5A22A1D5;
	Fri, 21 Mar 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d9Ip5fBg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ozB2r4o1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA08216E01
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564410; cv=fail; b=VwFFlTqePiFAyzHd+xgPuv6nbHPRsgYSiBYm3nO1dNJaFchEBzVAN4eLpu3jHCjjnHYekAQyBnSCN5vvreuGCz2HggpWm+eWe88RI5aPh82CsYvvkFB89YELc5ZoDNmpyyjkSaX0HC9+fofYAbas5sXJvuS//1vusReITQIu3GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564410; c=relaxed/simple;
	bh=vOsvnbo/XTDPb4kCfU56RNmSuPVsZFOQeDhDAR4rD0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBF2oKanOWha5xDFQLOyOqlOOoRRwm5KmyYmCN69RJTChycFhOK59TXb7x5Rm308UTFtP61jtBpqTboYL6oRBHGC8cRUh5yMfF4YV0xVtU+mhufzeR5gXNv95VzwPOiIoQM/X0DTDjDAetwF+Z48bE5VkHlGkAEQkpSbqLl8LHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d9Ip5fBg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ozB2r4o1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4tjk0031560;
	Fri, 21 Mar 2025 13:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8wb3BoO9k1NjmahVC+yTiXOwj4vWJvJ82yCmKh/0zyc=; b=
	d9Ip5fBgHyBnzkY5D6/jMOs6hNvJKqEcRzqt5QEJz5AehFpUle/aTSwRuNTLDL/Z
	iimDQtnzy024HhvzJcXPSUld2eCw5gu6WmCUdx/IPR/4XuG5XyVxZ9qTEwc8oYE6
	p81I1p5Mzl+GVM+owWYOLPeMYuSaOe46Nx9GKwIx9PK26RxsyE4r73rjZs1I27r8
	kxi8yWQXkUeKQTZ4mWO8GOHxAB92J5HO3Q3i/tyKp559tgcf5yOtjd0xgyVugqfV
	vjBOz8U+zSlYbRqzYmH3KSeMGWZEwbkSNsnEZnvtEWTx1CpTbL812LM5tBgxwI2g
	Jmx9AxAmAg5mtoD5A2whLA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hg8fa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:39:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LC655Y022429;
	Fri, 21 Mar 2025 13:39:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc9ybtk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhE1T9XnjYMCFLEngCVQvS23FJGm87AxUXKh4d8GaWKNzlNTqUVW+y1FacZ/O7lpz0OdcKSn16W3pOPMlDtja1XL2TqaUcvJrPE7KsvEaSqDgfDuE/sKm6Z/V0qd7H+Dl/BuEE0ohZP3WdbcujaGDGIE2EMsjyK/I+lIm0SJXQ/VRLuwRj8UDNHIvyf7HHBTYFgsYz9+9LN9cX/sQj9V+tuWYH1LO+RKiRTR60Bbysymz+8gcpvwBRmhxMUgbemaZP7U8aRt7ivJlBVCYpcm9nEo0cgzLDTZJwY4kGSkp5YI6rXMGh8ilaz5xi31X3Swo8+ekIctB3xUMIaoB3if6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wb3BoO9k1NjmahVC+yTiXOwj4vWJvJ82yCmKh/0zyc=;
 b=Jd2vWS3kEdgaCJSfHWiUJfIDEpG0aBQrswWhBfZIwsAWjtykC9fpxtbD0PqXekl0KeyhFuBXoE8xg6B+2MJNGPGfZRL3+kRGurrzpA8LouiAvbhsRrk0rOIFLS1fKE2LEytgPnRjcF8ew6Lqex4Jzi0uWb3TcSSk7/kGitEkmj/QMPArVXsflP0YgsSQeMlWZ0cV8mi4y/tLePh0bwhJYDM5sV302cokNouD7dB8yZ+0S+E78KIHnJ6OAUVEfdyoBxOyOTZrcy6DOTrexttQS4F/uCO3VBo7y0yu6vLS0ywuDkef+G8v9QvkQHmibNgWpCG9lvrYnAnnAaQQQQoLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wb3BoO9k1NjmahVC+yTiXOwj4vWJvJ82yCmKh/0zyc=;
 b=ozB2r4o1t+up5LETsYE6wFfDUOWRZLUVq3Cxd3YEChoNL+M4loL45IFEQKDYTtOgupH4ea72+89W0c5D+1IOdJEjgVWSZKu27bt8RfFOLwNq2GdEpuwrEa3WMnFLWxeyj9W4vQL7FCzZoQYaXSxqI267LfMOg9U+p3dgBNqz+3g=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 13:39:43 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Fri, 21 Mar 2025
 13:39:42 +0000
Message-ID: <f690cd8b-4d11-4fc6-8ae8-73996b7b3c21@oracle.com>
Date: Fri, 21 Mar 2025 14:39:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] PCI/AER: Rename aer_print_port_info() to
 aer_printrp_info()
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
        Sargun Dhillon <sargun@meta.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20250321015806.954866-1-pandoh@google.com>
 <20250321015806.954866-5-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250321015806.954866-5-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::19) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|PH0PR10MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a525b8b-69f3-494e-0064-08dd687dd5d3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cEFZMkRkSkF5RkZhdUZsQmNnTG9FdlZlaGZLMTlTbjJEZkRvUEo0NWhwQlpC?=
 =?utf-8?B?a0hJWURqM1VhMm5Zd1pSWmN2bmFEeFNiVXFIUHJZSXU0YlNSRWw1dG9VdEls?=
 =?utf-8?B?eDlrUC9SMUg1aFFGWjRvYzc1KzRsT2pJUjByc1VSSlNuYnAyR3JrUU5sSEND?=
 =?utf-8?B?N3U3eWRzMVYweVdMZnRLMGphaWRiZ1BEanBlYTNlaE5ldzVrOElhanJUbEU4?=
 =?utf-8?B?Mk0rbnFlcHNEYjZNdW9FQytiSUgrYm9yaFBUNVJTdEZ5NitDSjV6OVJrbmxO?=
 =?utf-8?B?M25lQmVBd2lncjdSS2dBOW5GMkdCcW9XR21hR2toQzhtWjJ2c2FKaUhJL1VL?=
 =?utf-8?B?Nnhwdm8rS2dJVTdvK21GRHJkcjFCYXBsV25xeFVCand1T1Y3L0FjUHlUdzJK?=
 =?utf-8?B?emlMcXZPZVpJamtDaWZYakNZLzZUYlpwZmlCSHhha3N1dUhsb1NMdnBHTU9V?=
 =?utf-8?B?R1lCYTF1RUhINnZaVlB6a3ViWVNjY2lFekVyOUZ1dHFvOHMwMDB0QnllOGMx?=
 =?utf-8?B?cjBKZGJ4ZHJXbXVlSTY4Vy9Td2luZVhQRnVrY0dtMElVV0g4NFBiOC8xWUZG?=
 =?utf-8?B?Qkw2VElURVF4OHNEVVZQc1R3Mi9qTjkwdHhYRysyUkdDV2tvUGg3WU53WUpm?=
 =?utf-8?B?RHRMaUJtMnBtWTRVQnBPRWgvb2Z0MHBHcXdseG5zeEpmMFZnYURNdG9iL2My?=
 =?utf-8?B?TG96REF3M3FIQWNVWGhiaytZckRtelNTSTRWVmI2N0Q5cHBwY0lmaEJYbnNQ?=
 =?utf-8?B?OUppSncwcDdFYTd3Y3BtWW93aVJob25BamN3UW9VV2NNYlZyOCtOT0JvdGx5?=
 =?utf-8?B?YmpyK29Iei9uRHRLK0crUnA4dXZtUXlvam1oUVorTFZ4SURGYkE4a2pvbUlV?=
 =?utf-8?B?MUo2aUpvRmlkTk1JRjhtWnBmcVI1dlVCbFRBSEVHNVNXdTAxSGF0TExkUzFG?=
 =?utf-8?B?TDVhblNyUmNnWGJaeWpwblJnNDlaSk1lRHo3STBGVW9kYnNJOWZKUkNBKzFZ?=
 =?utf-8?B?K0RmdThYNEcyL2xpOFdmbkdCeTQ3SWhaWnVLYjFDcU0vYzdSYk9yN3JWemV6?=
 =?utf-8?B?TjhLRE9CQlN1WVRYUnJTSC8rRHlxS0NsMVVxZDJ4VDhaVWhrRUNUVk1SbnFT?=
 =?utf-8?B?UjVBVVMvRjJxYnp5anJmNFlQZkdPbjI2d25GU3B4c0V2NllLVy9DeFN6Z2Ri?=
 =?utf-8?B?N1hDR09IdFUvaGJPY0x1TmptQWZ3NUtneU9DMEdpeDdOUnJIM080TmJscVJO?=
 =?utf-8?B?OTc5VFVNb1ZuYkdMYmpVS2VMYlhIR1puRmkzZWVySUJSREdDanFVWDFGeHFj?=
 =?utf-8?B?dVI2d1F5eklJaXQ2VVNPcHNTKzdSN3M4dktZajZEWm1mVHZ0MkIxcXBwdGQ4?=
 =?utf-8?B?RVJTcTBBNjhGSmlSUHRCT0hrMEMxaU9WK3hCSDJXeE9scFhiTHIzaG9ZbWdM?=
 =?utf-8?B?bm03a0xtaEtWdVFIcmxhWFpIVnNPbml4TE4xRWhIaE1taEtYYzMwVzhUZnhC?=
 =?utf-8?B?WkJWazN5SWZ4bHNmZjNHUEtWbmxRNGRzUjg2NGRyRVBEdkxLWjJOWTEwZUNr?=
 =?utf-8?B?MjZqTUM0TC9oSGZ5cFQ5T0FwZ0w1VHRxdkdhWG5FdURGck4wOWhZekE0SmQz?=
 =?utf-8?B?OGNOUkw2elR6U3lxSmpKb0VvS2c0NnVCVW5nL0NVWk9nQURRWTRDbTIxKy82?=
 =?utf-8?B?WkhzdXhpcGw3YzlLVHFCVkhZbkNXQVp6SkMrRU5CUmtaTzlBeUl2NEJZKzhQ?=
 =?utf-8?B?SlNzaFpSVXRQb3I1a01FRTl5aHgwWHZzMUhGZGN5bzJNaERKV3pHTkc5QTA0?=
 =?utf-8?B?V3dYd2d6N2xSdUpQN1JIQVdiMUtjT2tObzVFUm8wcVVpTlNJMGF5V2t0UU4w?=
 =?utf-8?Q?Jf10lPqY+hqo3?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TzFhZlFTSG54UnlnVnlQSUZjcVBnL2t6MWRSbzNGb2tlbEY3aTlCc2JlTXo4?=
 =?utf-8?B?TXVmNXFxL1Y0c2QyRWhPdkt1bk9Gb29GM1dnWVNKZ2FNYU1Ed1ZDNWVuTkVi?=
 =?utf-8?B?MXRsL2dqeUJqTDdta25jeHlFUmhVSUNoQjdLWXNmeEFDWXg0SFl3Y2NIWHhj?=
 =?utf-8?B?blhXR3ZkanZCYjloVnNVU0dYek9nR3ZJSnJlZ1R1aVFmVnVyNFVoY2lDZnRB?=
 =?utf-8?B?Y1FackJVRFdaZEI4N3d1MzBneDVNVUJOZmpJcG1lZFpDOHd4VnpxdUswYm4r?=
 =?utf-8?B?MXVSME42SC9KOXFINndtVUl4WFFHWUpxMmhaYU5aTWYrQUIxUU41NHdTbCty?=
 =?utf-8?B?dkJWMzdsTkozOXdabTVBeGZOc1dHT3VWRWlWN2pqQTJtZnZWaUJoajZxOVN3?=
 =?utf-8?B?M2hxTzJzUUMwaWRqWmg2V2JKL01QZW1ydmgvUXA5emZDNWRXMGNxUEd5N0c3?=
 =?utf-8?B?WDdPZG1UdEN2R0FnUlh6WUxDeW9RV1Q3L3VBY1ZVVW1ySUQrQmZHUmE5bEts?=
 =?utf-8?B?clZtYmw5ZlUvWS9LSVppMkxmVk9kcThubWNmT0VQWEhyZ0NJZEpURkkzWDFt?=
 =?utf-8?B?blJUTUMwQnJXUytjV1FobEQ3cGE2RGc1Q1VjTWYwR09TaVFaYnQrakxhRE9J?=
 =?utf-8?B?TUoySG9hU3JwVEgvYTlGbDh0VytMTmJDUVZmT1VNd282ek5SVnlyMEdhbSta?=
 =?utf-8?B?c0UxYnJJRW8vMlJyaE5odDdDNnNSNFB5N3BwQ1RoNzkyT1N5alprT0RwZmh0?=
 =?utf-8?B?ckwreDdUTkZ1cnBYelEzRlljNU9TN0NWOFIveVh1NWZOWkRUVHplQnRCa1JB?=
 =?utf-8?B?Qm1QVHovSVIwRjZjNm9mOXhuZURRc2pXRTRiYTlpaytmNkdVa0FkNGlvc0s3?=
 =?utf-8?B?WUZvbXkxTEhkcW1MMEMvSzZ2cHdTODBiMVNtYTRRek9OUjVoL0c0V3EyWENv?=
 =?utf-8?B?VzFNbWgxMXBOWDdQZjR0SWRsUHg4SjBnR3ZDOCtWTGtEd0l0ZnVPS05KcnhD?=
 =?utf-8?B?SkIrQVRJUVRYNnRubDlnRU5JM2ZXM29FdUVndi9WSmVCVnYvcWQ2RGg1ZDZS?=
 =?utf-8?B?OGl0U0F2WlpyeFU3emZmaEE4dXdhTVRpSjVudThhWVA1T1JHRjFYUWhVcHl6?=
 =?utf-8?B?UHkvN1lWc1dHVnJyWHlnQXpYSndweXZKdlplcTMwbTdtOE8rZlQydGJ1ZTZV?=
 =?utf-8?B?ZFJnektRMU9ldHFCaE1za1JxbjNPUHRjRzhJOGF1MEh4dzFWUUMxTUZJN3hr?=
 =?utf-8?B?UGxKTnhnMUNDQTZtUGE2WXFNTXZVQjMvRGxlOG9temxFOUdYeENDOXhYNzU1?=
 =?utf-8?B?eFlhRVlBdUcwQmFDTzRCcUNpdnRZaHFkdXJTTDlvRGhoWXZ3OWs0YU9TS3Ex?=
 =?utf-8?B?T0RiWktBRHVWYiszMTliQnJTTElIeERtM0dTWHlCQ1duZnBaSUhwYWkvN0lG?=
 =?utf-8?B?WGlLeWxZMW04WTN6ck1WWXhhTzI5UWxsMVlWYUc3RjFHQ3lqNmhtZExRaE9n?=
 =?utf-8?B?RnAwREdHRERkWmxwbDc2MWZYbHRDOWsvWk9mRExORnhJTy9CVU4vcVdVTERk?=
 =?utf-8?B?dXNQamFoYXAxT3pqM1BwVUJRQi8yWEVySzRnaGo4NlYxTEVDUTd2UHI5Yjhi?=
 =?utf-8?B?b3NzVit0SVlyOWtRQnpsTXpFaXVGeFQvTURxc2V4WmRTMUxVWlNlSXNRWGNT?=
 =?utf-8?B?N2t2VVBacHdlRlk5MEFlZ29jNFQ2YjNvV2xxVVRyWW5RbC83NDEzbGU3czF1?=
 =?utf-8?B?d09xbkVXaUh6THByaEp6RGNHUEJzWGxaYTArQWNwSk5oTk9NNVFFYzcwU3F6?=
 =?utf-8?B?ZitZU0tKY2VWVTFwcTdLVFFnVkZ1MzdodEZ1UU0rNHNVbHBZL2RaOW1MUURN?=
 =?utf-8?B?NEVqY09CN0g0dzlSanZXSWp0eWdJdG4wNnNjaXVhYUNHM0tQK2U2UnRDeWd0?=
 =?utf-8?B?S2ttazBCZWdKd08wYUdqazJNUVVUTC9ZRVd1eUR3U0c2VzJ5Qzhmai83dDQy?=
 =?utf-8?B?NlJDTGo2TXJQUlhDa0FSakQyd2xCOEk5bEhRUkpETUJyR1QyZG04SVkwY0dE?=
 =?utf-8?B?dUlxcDdnZkxpRnhxamN5UUFGK1Z1UDZyQjBtSG9xZTVyakRQc3lGZ29rZHRw?=
 =?utf-8?B?SmlyVnVERkhoSUROYlN4NlpCQnFPbE1DWDQ3RE51ZlVtMFF1QVl1Z252TlJP?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hYHXaHdNAsRabUj60Dq3cXKgkhpRF7vFzdsrqnDRsi1kXUJJoWMab4cdJmX1wZ8iQHG/TRHptjCjKd4LmyGziOxAjN+vLiCzp0x+4t8osHOXUsRWGTIvuRiDEmvtjHcbkY4seKCkoiFlRX/+8YtQbqJlhc6UchzVImraISyGYndeBYCDEOB+OqhB4LtrKI1FGeCzNKbt+4jUkqwDgk21srDHMVynjN1+T+8ETwC1p7+BoYBGrKx3G/4yyolFKVHJEt3stqFwau1C3A0U/85s8qma7EhCdtN98yWvLWdfkNf/fHQ8nx9dirApcbHot+sswziCS4A5k3dYlbHLE/FkJbOb2dXvmletdyV+Sxrq14Xb5rLUTkmEgkHGU3izVQYBzy08UoSUc1toIHn6GpCc0WD+JgJOPN1NpbcCm/WSwcyc5+JATgWc+IKSbBESq7VvD3DXgBFE5LGlKsSYU1K6TjAslV+jOiLW3XfIl2m8al276Ynvl5mCisVuCpvNhL3ThZ5OZECvyZNiCSx8+7U3emv78B9XxMYoy+7FmGkUbC91HsGR5cu8qTFzzljUxTitvk7RYv7GX3u6TLWJZcUwh//6Ozvm3LEoD9cK+baEiuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a525b8b-69f3-494e-0064-08dd687dd5d3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:39:42.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSHT7m7aqP3rZaxUJScBTYjuBf2Zk1D96014W6N1Amg14EfJGQxb3ljkkZgTyIJIv3vp6STm0OrFUpJu7OwY4iujMQvwEDpyX2MmHXMxFAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210101
X-Proofpoint-GUID: rhg2RxCs2BNKR9oUcwigNdoKZamNB1Zn
X-Proofpoint-ORIG-GUID: rhg2RxCs2BNKR9oUcwigNdoKZamNB1Zn

On 21/03/2025 02:58, Jon Pan-Doh wrote:
> Update function/param names to be more descriptive. This is a
> preparatory patch for when source devices are iterated through
> to institue rate limits.

This commit description doesn't provide enough information on why and 
how we make the names more descriptive. With this change, we want to 
make it clear that this function logs information about the Root Port 
that received an error message, not just a generic PCIe Port.

Also, there's a typo in the subject:
s/aer_printrp_info()/aer_print_rp_info()/

I'm fine with the code changes but I'd like to see the new commit 
description before giving the r-b.

All the best,
Karolina

> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reported-by: Sargun Dhillon <sargun@meta.com>
> ---
>   drivers/pci/pcie/aer.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e5db1fdd8421..3c63a6963608 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -727,15 +727,15 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>   			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> +static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info *info)
>   {
>   	u8 bus = info->id >> 8;
>   	u8 devfn = info->id & 0xff;
>   
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +	pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
>   		 info->multi_error_valid ? "Multiple " : "",
>   		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> +		 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
>   		 PCI_FUNC(devfn));
>   }
>   
> @@ -1299,7 +1299,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   			e_info.multi_error_valid = 1;
>   		else
>   			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
> +		aer_print_rp_info(pdev, &e_info);
>   
>   		if (find_source_device(pdev, &e_info))
>   			aer_process_err_devices(&e_info, KERN_WARNING);
> @@ -1318,7 +1318,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		else
>   			e_info.multi_error_valid = 0;
>   
> -		aer_print_port_info(pdev, &e_info);
> +		aer_print_rp_info(pdev, &e_info);
>   
>   		if (find_source_device(pdev, &e_info))
>   			aer_process_err_devices(&e_info, KERN_ERR);


