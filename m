Return-Path: <linux-pci+bounces-21606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1BA381AB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC1A1893F60
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28792185AB;
	Mon, 17 Feb 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMBtEhFq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="esdcUio3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A3217F5C
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791767; cv=fail; b=VVqYpmBG0UJMZlwZqckAyI0SH+mE4OlxebIUPF0rCyD4GevWi+DU0MklqYezKz77W2V+zZ2DdBRwSXvZaHnRHzW/1rv1VeOTRykZ3IL3usB8zhXBBbk8l17cz2ubrQxjMylDgVP+jI/9db7qBIGhGWGwg8lBOk2j/aPdFhtoqBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791767; c=relaxed/simple;
	bh=UPj2kit2Cj2Wqt6t+amgzuIo0he4A5IlUU4Az86N2co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hh6J5Tgn8/4bsCS2TkV+xpVzTzdGme6AbbzVqKNSiS60JUkFgZ7bdwRHkMkprn4esP4Xhyny1Pc7IS1OlLLm5xP1tq/ujHdlDCSuSaor1o9FMMGj+FyL9sYkjDGgdnSiLcYF/FtPlgeaTWBzK6wGn75YCU/nU8Er9PIGhgUWeGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CMBtEhFq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=esdcUio3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HBMX7u024686;
	Mon, 17 Feb 2025 11:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1iAcjQui9ifTB403xqHA+1j8Bycyk/svv05Tdv9bA2Y=; b=
	CMBtEhFqA0wl/NKfsnmrsZBR0UC3OQQIsW/swUs+fb7e6flyZH5b2xz4WeWOoYe1
	xvh9IuPZg/u/puuCKMt3CZd4oNtWGi+X5QnkoJWyj9zBt5xdTYtLEAzDeyFEaVJQ
	EPjW351S3XdlpwXcgwvQNCH2/3NG35xBLWdFmze9yrOEH11HUoZw8pXNz+8R++Kd
	h7FuqaG3kkCMwH2PBdrziT3ielUe3fYtwuHuVvG+TNPWm1zx6a1Y0Qk4i71F5krr
	Z2KAdv+VJfhLE+8XavvDkpCOr9QvX+uPZgOpQaXLKp4HqQ7AUVEBcNvt8R7ywBWA
	ujYnWKE8I9cjkmc3AM65ww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thuac1q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:29:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51HA9gmB007333;
	Mon, 17 Feb 2025 11:29:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc7hv6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxjOo1V14bhnDIfxYT0byRL418x+dtUhI1XmMOLetH3RZhO4FPvS6BFwm0N9KCkrPL0aAh/ka9maeS0l8HmuETXaamwXi5E76nkYi66kmqFoTNFw4H/Fs4b5YujgPDXiq4xn4+gygPuixD4VCFJVxiOpvla8kEw4lwyYnUhPqUeNledumSXdEm11fToVsrSJfYyQpLA7EPRQTC5wnOL3wIuCnWMq1+aMzTwau/DBUHQX9MYvuKN6dJB16AY+WLtkhSD9c7ZHJkZgtQJQLivtTKfSef///SJi4o10VhKU3sTWINYWHoFh8V+xx10+zIvDIIOWFUtirekUhYQHQ1kmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iAcjQui9ifTB403xqHA+1j8Bycyk/svv05Tdv9bA2Y=;
 b=mAcapEqyKjDbfMqygfpiuJ7/8WpCxT+478cgzlIxIIx4jTuDfU97Hrv+P43YJ3jNsLNK8AN5gTiiE8DxUmrTcqMdbr1qXs3/hAgXwlHW4YOLHPFetCAm2iE5bCcBa+I/bc2/0n5n1XoJz1UQIi3unh50rpI3Yio7E1i0M5rj0udPH4IQGz1QA3ardOZSOn+Yi5qx/PqT2NVhTAEdg5Wr5knw2uRDocf7eRUQX1Gy1jtOWc6uZh4oP/g5gQPOeBWVqWIIwt69r70iUfZ3Y36Z4fO9ZYJ70Z5Yq9/RmkXkpwlczWeXqS2q8wf1f5owMJHPi2eBL8Zf7W5zXknFyFXuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iAcjQui9ifTB403xqHA+1j8Bycyk/svv05Tdv9bA2Y=;
 b=esdcUio3Hiaz3aXKLr8LThkbpG595IWm/Pt2JlB3xqnrvL7dGhKZ+ctsvJWXcIF8GSgMH7dbCaeLQf7AVQbP0ZmSYOS5tKTs7H+wIHwbKpO3/xuqpqrISPW/wYGWshAw4gZeJ0J571O2kcy8ksMwMfQUz3Ch9QekvjBxivAhZYc=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by LV8PR10MB7750.namprd10.prod.outlook.com (2603:10b6:408:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 11:29:11 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 11:29:11 +0000
Message-ID: <52d8c880-85e6-47a4-9734-73a20bb42414@oracle.com>
Date: Mon, 17 Feb 2025 12:29:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] PCI/AER: Move AER stat collection out of
 __aer_print_error
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250214023543.992372-1-pandoh@google.com>
 <20250214023543.992372-4-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214023543.992372-4-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::14) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|LV8PR10MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a49f78-161d-429c-769b-08dd4f464ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXN5SnMvMFBnSk1NWldCUUlQMVNxZzYxM0VZMktnT3gwRkN0UThIenN0aDM2?=
 =?utf-8?B?bjkwZlNZN2F1ck1CTkN4Q2xIQlBIWWE0bk9yR1Z2U05MZndld01SNkxOYUNq?=
 =?utf-8?B?MGZQMHV3MmpsbjRwZDZBN1JtbklWWmhJTVYyUmJuNmtwdVFsMGdvMkx2M3o3?=
 =?utf-8?B?NERwK25ZWUx2RXYrVnlCN2xyUkltM3E4TmdrSXZvOWc1TGpYM1pEL2owOFNC?=
 =?utf-8?B?cXRuT0FVeCtkTERYNThVK09CbEx4NjYvbTgrS05VcHZOWVAyTzh1aXZIYWhs?=
 =?utf-8?B?M0hoVExVd3kvTkxhUlkvWHpVQzk0VUNGYUZvMG01Yk5JOWNDRWU2OFlVWkhD?=
 =?utf-8?B?Z2xTanU5YUVZY1E5YVplalU2SGxzOEY5aGhZZGt0YkJnVmNSd1k1eVRRekJN?=
 =?utf-8?B?Y0d5WU5KVFdKYTljdDBQN3lIeGFyTXhTK1VpN3VMMmgwdDlscndGWUVxU3JI?=
 =?utf-8?B?bmVUMHk0eHQ0c0cwekliQzUwZ2thMEw1ZkZzUDBKeUR5d1c4YzdPZHlaUmlv?=
 =?utf-8?B?TnV3dVBwaU1YMUhadmk1M0UrQ05mNW05VWRhcVlibzBlQ1J5b3FlSEJESExK?=
 =?utf-8?B?MkpCQzdXK1F1TjZXcXZkZWI2bG81RXBhM0lUc2RENXBaSHQ1em9MTTFGV2dY?=
 =?utf-8?B?RTY5d1RaQ3hxMTBLRXRtVjNHNHhacC9lTXFvVTZpb3IreU1EN2hlTHNHajRn?=
 =?utf-8?B?aFcrSTRwbnZ6TU50UlNMUUovd1J5UXdNdkxyVHk5SStkakU1T0ZLdjk1SEs2?=
 =?utf-8?B?NEhCTk9aRklwdEYzazVzbmEwbmV2MFAwUjVSY05xN0d0dk8yM3VlMHh3bWZt?=
 =?utf-8?B?RFh5SUN1eEYrT3NBYVd5NDJZdVErUWFrZk9nWitMYmU3SWdteGUzcG5tVnNC?=
 =?utf-8?B?RndwOUEvdHNmSCt4em8yT1A0UWR0TUFsbkZkUVdaUW5pOElhM1I5aUxEbHNo?=
 =?utf-8?B?cHhHcmxZVEZ1c1FpbDJnam9BTkdqUVhERHhCQTJjSzkwQTJ0aHk3ako0UFJ5?=
 =?utf-8?B?dDVuOFJ0c2pwS3M1SFVSY2RFd2JYc1dhTTBnb3ZWVVVJYWY1dzhGNk9kdGwr?=
 =?utf-8?B?QlF2amN0NGovbXB0MEFjS2lYYVVHZGI3Rm1uTHppNWxIZEY1QWlsaXRNd3ha?=
 =?utf-8?B?Z3lEcGtTNVVRek9HUVlpdjNVdjNzV1E2TFJPaHZwOUJUK0pIOE1zNndjRll6?=
 =?utf-8?B?aU9oQzhpZWkwQm80YW5DcCtmL045eUVJbmFaenNnZkpCUkZRZDBhM2hKKzJR?=
 =?utf-8?B?MGhwWis2b0lCK0JWZi9laTc4Zm1RWXF5WlFSc3ZiM0puU2JMbUs5MGdQSVpU?=
 =?utf-8?B?eHQvNzJFUmhIY3hjSDRDMkM1MHc2R2ZDL3JUTyt1QUkyaGVRYWNneTNteFlo?=
 =?utf-8?B?M1c3aTUwdmFsdVlHT1hEZ3lCRThuSFIvQ2l1UmV2QVRqdjl0SXhRL2llME95?=
 =?utf-8?B?RWl6ZUdBRTNEQXN1eGlnc00xMkdzbTR5S3RvS3U1K3haUGtrVUY4QmV0ZjUr?=
 =?utf-8?B?WjYvMllNb0ZXQjE3UWdHSFd3WlZZTmR6Wmo4QjBXRCtqOVMrM0VOMlBDeHpv?=
 =?utf-8?B?UlR3K0RpS3BmdzZZWkJnK1k5clpQeFdSNVQ0b29JZDdDWFZlSUNaZVhJSXBR?=
 =?utf-8?B?RHB4U2dod0Y1engrWk5mNzl6WnUyYkxMRzJRbmY0WGRXaFdLQmFNWkwxWmF1?=
 =?utf-8?B?RmhQSTNSMEVhcG1INUU5Q1RBVE0vbjcyeGtnTndWRmQvRENkbXUwY2U5VnZC?=
 =?utf-8?B?MUcvVlRvdkFzUlVHN0VRMm1UNkZaMXVvWkZMcjlQVXdPTWk5M0o1aXFBZmpw?=
 =?utf-8?B?akw1MWZFVlprbUZVeUZOWCtFK09VdXZKdUMzRlUrYmFHbFNUV2JzclJrcWFG?=
 =?utf-8?Q?yiYEPRcxCggI/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGg2SldDNjVCbTNYaE83MVkrMEZYTHZGYVJja1I4WVkxWmlRMU9CellzaGVC?=
 =?utf-8?B?RHNJZHRIbHVMaUphRE1jSGFlajdLcHFBemE2dVYydnMvSUMvNzlRcGhGTDlk?=
 =?utf-8?B?OWdLMWFJQnRybi83S0Y2T29TRHJhOGhDWFhQU29NYzNYZExLOG5Wd1hxZllk?=
 =?utf-8?B?eUlaRFFGTHlCZlZ0dzNTOXNzU0JZWDN1eUdudUJDMzdZejRSWTdEc1BXZ3p2?=
 =?utf-8?B?V1MrWTlNektLTlhKak1UNHZaTFlzVCtpTnNMQk9LdGNCOTZzS3ovSlQxQXho?=
 =?utf-8?B?QmFqVFpyRGRtTDdPZlozemdjMElxSDlmM3hNNC9DdkVjdHdDa2dlRm9BeEVj?=
 =?utf-8?B?WjVUOVdIU2V5Q0hYdERZdUJtc3VLaUV4RXBaY2RYNzBrRiszMFNUdzBEWGdp?=
 =?utf-8?B?d2lGdS9wVm5rMkh3MURaNVRsaGZoLzF6NFZmZWtZVk5HcTM3WnU0a0VBU0pF?=
 =?utf-8?B?V1NkWmtrN1E2UWovdmZmb25HUDdxOVVJL1l3bnZXTGtzd2R0ZHhQOW14K3FL?=
 =?utf-8?B?Q2JkTHdhN1pBeEFuNmpKUktXNUZodmxqTVVoMXhtcUwzcHhYVlE0dFZDZStF?=
 =?utf-8?B?QTNMNGtMZTUwM21EMHRzNlFoYlNacWg4OXVHNEcyRkNpaUlDaThTaXV2NFAr?=
 =?utf-8?B?aEZqRDh0cXl4cm1lMUVqTnJiM1VTdmxDaVo0ZVhGekR6WTJNYm1ZMTRGUnEv?=
 =?utf-8?B?bmo3NlBEa2hjcEVVR0l1bzVTeU5nbjljc2NETEZOY1V1S3pjbnBNelRTVG42?=
 =?utf-8?B?VldDOEhuc1NNcEZEN0VkRmsvelhOeGRGS3NUWk80RFFpbzlJUzlkK3NuSU43?=
 =?utf-8?B?UEJtRGR2a0tUNXJRUFN2SGRhaWc1eU45QWo2aW5uNkt5aEttTm5nKyt1TlFj?=
 =?utf-8?B?NXdub2puMUpSR3h5dzEydzBqQlZCTWRzWitnTkNaUkIrYzFjSHNOS2tvaElF?=
 =?utf-8?B?MEVSWDZBU1hhOWVUbWlxM1dNak9VMEp4ZTVvaWVrMEdWZExDd1pTYXpjYlNn?=
 =?utf-8?B?MXNnd25OcXZGRXcyTlJWUExXbjFvUFdzelBjKzRQOE90bnR4dWEzUXNTTitN?=
 =?utf-8?B?czNhdHlkNHlIK3k2NlBwOTVaa0thTEd2U0wrS0U5RitYM1hpd2Nlb0F1Wkp5?=
 =?utf-8?B?RHNIbXAxSWJzOStYUHVDbzZRbmpjci9DVC91KzVxYTR1aGVDdUs0NFNuY2tU?=
 =?utf-8?B?VlIwNlhYZzlvaHMxa1ZiV05TbGdSeE1SQWphSXR4aGc2ZklpWkMvQXlNZVBD?=
 =?utf-8?B?VWg0cC9oZ25JaUZ1cWhzV0tYV0l5dXY4NThuVHNmS01sMXN0OVROWWdyZjJj?=
 =?utf-8?B?dDNQcW9HUnZ4Nk5ZYmhraGVhZWtabkRFSDZ0ZTVsOUpqSFhlODByVXQxbm1r?=
 =?utf-8?B?WmFkdEFnWUV2Ym5oYVE1QVdmeThpem9KWWZYRFVYOVpON1h4Y0g4MGM0UWt3?=
 =?utf-8?B?NGhhZTdzbjJXTVMrbEVKZHE5UjNVaDZ5N2xWS3d2MUlnT3Y5b2RqWXNGdUJF?=
 =?utf-8?B?amN4Y01FRTVuTVM1bG9pcDcyMjhXZUFvaGNDeXQ0VElEakdhU0JkaGFCaHI4?=
 =?utf-8?B?NDZjZUVhbVJsbnovSTJybWxXM2NpQVliY3JkTEFYeTRxd24wbzZLWEkwRDMx?=
 =?utf-8?B?ZHF2VVRJamlzdXVJZk1RVTRlNjNlNFdMQytLZ1RZQVhnRWc1S2crbFEzMkNw?=
 =?utf-8?B?OStiVmIrRWVwdWg1bk9NaEE4bmdZYWZrNGdHN2lBUTVtUFRJeCtjb2ljTEkw?=
 =?utf-8?B?RUhUQjFsS0FLZi9BUEZncHJaeGJDRmpSM1pEVSswS05WeDVudG1zUHFuUHI5?=
 =?utf-8?B?VEFMWjlTODZ2TWVSQnF3OHI5SjVPcGE1dTJrUUxUTnIvcVNqZUhhU2hWOGN1?=
 =?utf-8?B?cmRGaUpQaTFuVVo5VXYwMWMvbXduUUltTzJrdXBCbVB6aWl3eHltcklaaEtP?=
 =?utf-8?B?aU91emk2Um1yZGpZcmFaNzdVMFV1ZHpDWUs4R3RSSmFRdFM4K1AvTFJtT3FH?=
 =?utf-8?B?Tm5HM04ra0VoaUtMbkZXTUowNngyS0l3V3lxa3pxdHZ3TExqb2I2cWk1MlE0?=
 =?utf-8?B?alJlZmdqWjdFcEhnOUFseHMxeFoxN1RBR3JQL3JiZDV2c3ZEbnZDRWVXVGlT?=
 =?utf-8?B?eFhzR2tJQ2o0VHhjWExPZDhBMEpRMm9WcEFnOWJ0MnMrM2YwaDZaUkRFT3ZU?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7PBNBUv3ut5BtK/8Xr3ruCY8+98iYKfh7sTQFqQaI+o+lS6Cw4Pn8wUtAOJWzSF5LGoOYro/lKJqvn+N0ybml5Pn+kZjYMuzp+ImbKprvnAGm+d4AislQACHqg/8DnI9n8x8zK68ZiEAMx7Og1Bwl+njhcbxPMt2uHorKPPHajer2U1/IUvPNVt2VyZT528MXLmT3PlVJay+tdRX1qHB450cb4k7o+ZMvfzrbHgkvR07M8hxPv1s7Q/M/8h5T0/KNDXF6ZcQg/iN4jmCG5EScpYmzqI9m2HsJWd0hB+LLxDrRIUd9FzVTYokYONxr9Cco2ON20db256014RWG+SzucbiaoeDpYyg4VTf/HIoApujDW1aeC0PUp5SwViXUv0YS4Lq1HV83PWMePsBRLJncn9KIYSHUWbtySiyFbifj3YARKrFt2U1n3ZdeitCPflo8xYWmx17ITLdF3fuLVWr/MD8AwIn2LhELvcUlgJ/AYXRyZqly7gMxmKWFcw7282+REGOE9MDLS6vUqvfIv1h/YcHjU2a4D0iSXomB1jlS2r5bs0CjAA8vYD4AmMJV0vcNqmmwGdwfX4I6s8g1pFCrWYbbPmAofc//t58F6yuSUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a49f78-161d-429c-769b-08dd4f464ccd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:29:11.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZcCq8SbpnZPK/5hnQIW/g+42sHHCzdPOUvcTVVjCAU6GJp2n6ZworSvNQcwIgL6lok2BIkU8Ke/+dPJvzEogXKrH5XBOdKuI3LuNiG9IQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502170101
X-Proofpoint-GUID: fRlBp7Pe5KRq7DWqik61vqujScvclo1E
X-Proofpoint-ORIG-GUID: fRlBp7Pe5KRq7DWqik61vqujScvclo1E

On 14/02/2025 03:35, Jon Pan-Doh wrote:
> Decouple stat collection from internal AER print functions. AERs from ghes
> or cxl drivers have stat collection in pci_print_aer as that is where
> aer_err_info is populated.
> 
> Tested using aer-inject[1]. AER sysfs counters still updated correctly.

I don't think we have to mention that it was tested. In other patches 
you mention specific examples that illustrate the change nicely, but we 
don't get the same value from the statement above.

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pci.h      |  1 +
>   drivers/pci/pcie/aer.c | 10 ++++++----
>   drivers/pci/pcie/dpc.c |  1 +
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 8cb816ee5388..26104aee06c0 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -550,6 +550,7 @@ struct aer_err_info {
>   };
>   
>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
>   
>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f1fdaa052cf6..d6edb95d468f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -617,8 +617,7 @@ const struct attribute_group aer_stats_attr_group = {
>   	.is_visible = aer_stats_attrs_are_visible,
>   };
>   
> -static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
> -				   struct aer_err_info *info)
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>   {
>   	unsigned long status = info->status & ~info->mask;
>   	int i, max = -1;
> @@ -691,7 +690,6 @@ static void __aer_print_error(struct pci_dev *dev,
>   		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>   				info->first_error == i ? " (First)" : "");
>   	}
> -	pci_dev_aer_stats_incr(dev, info);
>   }
>   
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> @@ -772,6 +770,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> +	pci_dev_aer_stats_incr(dev, &info);

With this change, we increment the stats when we iterate the recovery 
queue in ghes_handle_aer. Is there a possibility that in the GHES path 
we would increment the stats twice? First via AER module (aer_isr) and 
then in aer_recover_work_func, or is it either/or?

All the best,
Karolina

