Return-Path: <linux-pci+bounces-22192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD541A41DC6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 12:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EA33AAD53
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8A25C71E;
	Mon, 24 Feb 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T3mPfkmk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rYnGyVQ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718C264A9E
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396436; cv=fail; b=LK4pCOVPRQfGssOXTyr/TAXYPcAPzaiCU6rI/eqkY9vKyUeQjFEFXHVomwT8POYkC7/FFuXE8i64c4fDG6JGUmuSek4DE6UYPG9/+zcL0+Aou4niMMH7a2cDah2QT9N/vgEaCW+VXzLb3eT/swVy4GlOVdimHd81DW59SanNWzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396436; c=relaxed/simple;
	bh=FnCLzcIlkkhiSKvGi360V+unWhCuNGG4F/AGcQKyioE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MvxGP8zbmSYHXeTeVuCsL2Cxz7DDcskGxaVKszkZ9IRV7txSlg37XNL0HO0t5JRTpSckG3j4zdeyg81bQFK7qfPJIga5+R4ArqZJugb8HdRJth+2U089m7BjX1So71GDmTNFL15nYlSEd0VMzmuIVLfrXvq+ukCrA+QPgeQKBSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T3mPfkmk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rYnGyVQ/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMajg012833;
	Mon, 24 Feb 2025 11:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vX5jkJAtgnAw571SaoHnnJDx6/qjJgmtuZWtCfkWm+Q=; b=
	T3mPfkmkM+oAq09XAwBSwwBmUY+HA/zXd6wkq+JHmpWwKnpAaTXIWRJIfjfjIdyk
	iWA9ZlO7veQ1LvQcV9IEF2snttOTSjzBlB2/ZZjY9Y+nrXaZbIRby34LZUosxu23
	ldMbRijK0vHxWrcBBHYMOPeyFGymrLqL+EMX1RzsADuk29oazfeoPfZLKVQfj79R
	4eUX0HI+abzEYoC5tQWYpp+3V+hHgfxCBtQ+R3BRzpxiKv+XN9GctxpwE8x9swbO
	6a7D8QhRnbr/vuc0FqLsP7kSfV/DwddkNXMmrWi4JwhQMEC5IyY8XPyVY+XSKdU4
	lHgyWz3yQincajNUwJFEOA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bjbsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 11:27:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OB4ulB027322;
	Mon, 24 Feb 2025 11:26:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y517gvvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 11:26:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyq5EG3BD5HsMWrQXgNxqlSOTH9JGZm8p+QXMGJio9mhcuOxF+Q2QdJa3P4ePlsjLXHKlOJu9bSidy/HbvxTKfaXEiGWCvOTh1htew97a86/JCl4RUThC9kAJTvgEbKJ6TOM4zh9LIwrQ6U0lxM/nNjKHxJPtGMYIRX7cbmzXQKJczZhdXAgvlcOJ3wz4fiz7dqrPl/Ck3qLZEq6gDJaf8wSGm6vEdnMCsYridcjypf2jSuaDHHmoTnSIqWWLMVuOeeBOBWJxC7K6Q/RlKt4Z/VIK558KUQm4nkqAsOY+RMoO19qhFdhY2KSRzqJD8ZNSa4JWXC2u2v1qq/qf1is0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX5jkJAtgnAw571SaoHnnJDx6/qjJgmtuZWtCfkWm+Q=;
 b=edVdlavm79xnBUCXkAG6WnOjWZbQSB161KRmDShrFnPRhcSzbaqWVtzQUUPte0VH7yQdwLIyatzzVozv19LtmSl3jbBq+ByIBGc0LKYNNa0b4SE1Lg6K5aCqWTLCmd9Bl5oKyUf9HFbyZSQYOfAxi8a+UufHgdbwcOtEZRu9IAlzWAs5pSIdS/Joe195+vzccK/46Hd0JG3gPdhn5JHJMuvmoRrBnLEzYbaDFo55MuSAeKfJrzqu87rrXOrUHNnQuPMNX5+8Y4YGNS7eahyLBSK6aTTpeQPyCEZ9ic6t3haHGbLFrnfh0QoJz12iaLxfFhyAO5kD2sqrkhNc0CdXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX5jkJAtgnAw571SaoHnnJDx6/qjJgmtuZWtCfkWm+Q=;
 b=rYnGyVQ/pdnRRQLhAMBN745GMyHJKe8y0r6hx3BQHGsS4kkWWJGaKqFqp5b7uRzBWZJBbmYI8Gjyie/xpxwHNb/tn3QBrlSmNF7RkYg0UAofy5AaCFIjzI+W78LbRH3eumxx/0zwxnftHRLtiMm0CMizR1ycxOV+cIRDFqztYCc=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CH4PR10MB8122.namprd10.prod.outlook.com (2603:10b6:610:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 11:26:48 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:26:48 +0000
Message-ID: <bbfc780c-115c-43d4-af33-935b447f6081@oracle.com>
Date: Mon, 24 Feb 2025 12:26:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250214023543.992372-1-pandoh@google.com>
 <20250214023543.992372-3-pandoh@google.com>
 <8e94ccbf-497b-4097-87a5-761cbc7c205d@oracle.com>
 <CAMC_AXVgYegnfc-vyKuxZS-Ck=aCJ95=HqdYNraVv99kXxw1QA@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXVgYegnfc-vyKuxZS-Ck=aCJ95=HqdYNraVv99kXxw1QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CH4PR10MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7977a1-f9eb-471a-8a13-08dd54c6209a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1grcXZQdGt4ejI3OTlkVVM2RUdCcW13a290enJYZ3VQZXdJL3FiMjQxUjR1?=
 =?utf-8?B?bk0xMDV3RzdYSHhGcDM0bXRRTjMwYWFrZDdqdHNSaUVUYmkvUDc3cEtzcVhn?=
 =?utf-8?B?Nng1STRLOFIyMTBuRXBiNEd4OWNCM21hU3hVc0dIeHVNQzcwRWhTQnpqd0JY?=
 =?utf-8?B?YnNGYy9tY1RLQ1FobHE5RUVEQ0FHVFM3Y1d4bmo5Njd5YzZYTmlIdVFNWlp3?=
 =?utf-8?B?YTk2b3dQUWV6aU91UStnVVl3YU5MNGdYWHZCd0s0LzFJUFJKT1F4VU4vT0tX?=
 =?utf-8?B?TU5ZSTFFbHVwOWxMTG5FVHg3am14SnVZQlNKWWlpMUNGUSt3UEFLeWdsdmtl?=
 =?utf-8?B?bk1Dcms3T1IzN3BON3k1TEd5THR4WU9wQjJwbDUyRk1UeFNDQlZiaDlGSUFX?=
 =?utf-8?B?Wk1PUjZSczRZUHlZL0N5anlzcFRzcGc1UFhhZVlHa09PNnNmUUtrZm9HQnMr?=
 =?utf-8?B?OWhlcVEyRHNBbDhjdTQ3WVBmeXhhcjFmSGdpbDdJbDZMdFRjTUl2V3lqako5?=
 =?utf-8?B?RlBzZHZPZzMwTWNleEMvU2RRZzNUYWF3UXRSN3paRlVFeEF3VXlPNkxzTjI3?=
 =?utf-8?B?M0dLSk9EREp3eExhdFpXTEU5REk2OUpGdW5BS2xZMVI3OUxNQUxKL3pWRHdM?=
 =?utf-8?B?VDk0ck8yWEErQk54NmtsNWV1SENmTmFoKzQ2UE9FOTQ5REZkSzZWVGJ5bUZw?=
 =?utf-8?B?c1dtTzFUaHlnRlJFMk1jVUo5WllYMzZjYVg3TkpGUDBEZVE5bW1yTW1oUXRa?=
 =?utf-8?B?NUdoRm1pT09mWHYyUHphdWZ3REhPK1NTQUFIcHJrcVAvcWFOQkUxK3RaeHNV?=
 =?utf-8?B?R2pTdXVTWEVHSVJSdG8xU3FFWlpYcDg1dWx4amJ6SklSc09KTmRmOGxjN21S?=
 =?utf-8?B?ZDNIaGxRM0JUbUdDYTZ1ZldSY1o1a1NkVVdNVkk0ME9VL216MTc2b2lJRjB2?=
 =?utf-8?B?dW5wc083L0s5SFpMODVyd1IrS0Zqd2xYSGVTem4xYlBLakVmSjJUVmRQSWcv?=
 =?utf-8?B?aWxMYS9aN3VxeURNUU9KNXFKcUJFYnFja3FBMkZzVXFFMjVJUVFPUlN4Tm54?=
 =?utf-8?B?OUNyRTUyc1lONk5tWlhIODVmNGpTUUErZTltRGI3am9UU0thVnRsRzIrVldS?=
 =?utf-8?B?RzM3a2UzcHg4TFBIRW9ROFRQRXVhZ2ZCQkVrRTRrZ09KaW5pRk85V2ZiOUNL?=
 =?utf-8?B?VlRubkJpMUE1ZlpFaDIzUlRiYUowL3d6T2E0UHArVy9CS2hDeHd2SmJJbGxZ?=
 =?utf-8?B?QkZUa2VpcjBhWGtxMm1PVTl5MmFvRTVua1paVWZyYUpocStIRDZwNlhHczlP?=
 =?utf-8?B?TUt6czlEajZZNDcxV1MvdFFzcnhtYUd3K1hKYjBvWGoyUEdlRFlGMEdBN3o3?=
 =?utf-8?B?N1lLQW9sZ1JXVU1RRGFETUpxWkIydXk0eTBieEpIczhCUEVjbW40QXRPdGhj?=
 =?utf-8?B?ckhSYUFDMHdQTGZ4SVgzUmhnR05SekZTT0V1Y1l0Y2lNQkpkMytoZEJBTXVl?=
 =?utf-8?B?OVR6OGJib2E0QUJONTQwTEZzSHRmckc0U0ZaeUdtZit3cFdyZXRDQ0lXRW5w?=
 =?utf-8?B?RnY1clE0dXQ2WXdXS2pSblU1RHJPbFB4TlFmUWRIRjVrZWlyTHBQa0s4dDA5?=
 =?utf-8?B?VFRMekVnS2JqUkFDdjBDZHA2cHpUQmI0Q25yaGRnV2tBam9SWlVzWTUwR3cz?=
 =?utf-8?B?OXVuamE4d2dDSlBIQ3pTbUpIbVBuaGRVVlpwaXNBSVVoZEVOQkFqeFVGa1dB?=
 =?utf-8?B?cTB4eStBYnZkczhabFBQNzlOdTRQWFRkL0tOdkhqQkpuZHlaT1dNek5uUXpB?=
 =?utf-8?B?bCtOV1cyd2hZZkh3WnN1RGJwRXJvSHFLT1dXUXVZUDZEWHNGanBDRXVGSnBN?=
 =?utf-8?Q?t3ORJX6PALRxZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnJhUkRxN001MDZ1cWFOSXY1T01zL20zZUk4WGVQRlNqem1SZFlVVHBJOW02?=
 =?utf-8?B?bkhmMGlwbnF0TS9FSEJzbVg1YzZLYmIwU0xQdFZwL2NIZzlDc25CUElkVTA4?=
 =?utf-8?B?Um5EaXRKbE05WFZrOFZQS3dHdklNamMxWXlSdEdNclU3dk9nWWF1UXptRXI3?=
 =?utf-8?B?NUYvT21YTWJvQjdyNlV1ampSblh3dFRwNmFQZzJKU1VtbWdXWG8rR0V3WDJC?=
 =?utf-8?B?UXpYc3VZbDNESVhHbS9SbElWbWtqNEZEYWRXTnovYWJEUFBEMEFJeWQxV1ZM?=
 =?utf-8?B?NDVFdmpzdlNTU1FxUkNDbGNkcE9mMjZYVnhTeVcxOUdrOFdGdkxsYUdvK3Zu?=
 =?utf-8?B?dSthNEtjRlA1Z09QcTNBbE5ENHZYL0VFSFVKM0dMMEQ3Rmt6eXREN0ZTdFVL?=
 =?utf-8?B?YzZ1Tyt1R0ZZTFFIbVdPVnpQVER6eU91TGtTS1doME5Va09wOUNkNTRSMXQw?=
 =?utf-8?B?UlFETndwRVZEN0Q5aVJFWEw0eE0rZVlWMW5SQU1KYnNBOUJwNlc5N01xMFpG?=
 =?utf-8?B?Qm5tNXFmTXE0aVU0UnUzbjZZSDFEZFI1bjYwMU1Ia2xKTVI2ZnVNT1FSVGYx?=
 =?utf-8?B?Mm1ld3p3K1p4NUNTRHNlaWd0V1dVZ3hYWW9pdWpqWGhxZGNOTTViS3ltZEd4?=
 =?utf-8?B?Q0I1V0grOXljVnZqeHZjL1g4Y2VpakE0UU14VVg3TEgzMXlUa0NaN1d5ZEtG?=
 =?utf-8?B?elJNeTZJSWZ5amhuL0k4Q1RmQWVSNWZpSnp6SWo2UWRDdnAvQVNZN0lvZWRG?=
 =?utf-8?B?eld2b3RRZ1F5ZE9RVFVrMkRzYkUrUUFJejRORGZiNW45ZnYwdWF2bW50Slg0?=
 =?utf-8?B?dnY0SWJ5WUlGSVNVNVgralQxMktSUFJsUzNUUkpGQnYwQkhPWkxDWUNyWGJI?=
 =?utf-8?B?ZGNtek8zTmtXaFRyZFdiTDcwMXhrYUNQdXJNTUZYQnpOMGFUTjQvMlEzRGxh?=
 =?utf-8?B?ZkxPb2FtT1NoZDdTVGhjTFNxdjVreituYTFuVVUxZHJYaThvcE9XbWY5TFBw?=
 =?utf-8?B?ZjBzRnI4ZndwNWtCeEtqTHlhRUgvelZsd1BlNHpJZFB6bW1jY1RyYTNUZ2d0?=
 =?utf-8?B?OUY1S3dqTGN3MnowVmtoQXpCTlNkZCtHQ1U3VUNNL0pCcVNxV0ZaMytLR2Nq?=
 =?utf-8?B?ZUNDbjBSdndqY2hGcEt0YStleW51L2xOL3Vhem5pL2pJUVZEdjJZZ0QyZzA1?=
 =?utf-8?B?QWZXdFdVRmgweDg4em83RitLUFcybGNhVXd6QUprdXhZWU5EbkRiVmp3Y1Ex?=
 =?utf-8?B?dllIUjNrZUwzK3RNMm5EOGVCNzBPcnRWaE9QNXY3MTh2aHkzeEZ1bS9rZ2JM?=
 =?utf-8?B?ejBLMEV6RDA0TndLS1F5cXBIeFlpOFVUWVBOSHUwcWdlOUQ3NmdGdnJBZTFr?=
 =?utf-8?B?WHlONWlwakdNV2Y0N1lTZENDV2JvUS9tMzNEajZQTnZhQ0NHWGtheWR4Mi9w?=
 =?utf-8?B?UzlZRzJaQ2h6WnJZZlF3TmJ1b3VzSlVDaWV4N2MvUWEvRHRaSkg4d0hCd0F2?=
 =?utf-8?B?U2IyM0hqdUFWMnRHOVlTb3NBYm1PS0RFMUhoeHFCdlRCb1A3V1VSVkFjZ2pS?=
 =?utf-8?B?M01jcWpYeWl1eVJCMnpQMDk3SUllSTdRZGp5K1gxT2RKVFJvUVgrbzYvOXlV?=
 =?utf-8?B?ZnhTeVVRL2hHdFdUQWdoMGE5am52WEtaaVBwck43Z0ZGd3MwajUyVENzQ3F5?=
 =?utf-8?B?RjhibjZJM3RINEwzdkNzZVVvMlZLcFZRUHdUcG1wZWRtVmRUQWUxQ1lLQXdQ?=
 =?utf-8?B?Sk45NlpCZE5Da0VBK1lPbk5pZlpOVTB2Tm5TZ2Y1aEFxRlc1RUFVVE9yZHdZ?=
 =?utf-8?B?WkZpemszRCtwTlVlcmlkSjVsd1dDalN2N1doNmp6QXJpei91T1VyUWFGVGhx?=
 =?utf-8?B?aVAzVXdQN1A0TDRDM1BwMzNTTzFJQm5UMHd6Y1VIdEFKYWZuaWVQMDFGeVc5?=
 =?utf-8?B?NTFUTUxnUUxCZ21lcWV3TStaQ0NIZFhSN0JVd1pXTENGaTduang2bFB5b3E4?=
 =?utf-8?B?bzlFUTd5RVIxWkowWm1aOXh6WjVUM0o4THFvbitEeTdDbkZlYnp1YlREWnpR?=
 =?utf-8?B?cnQ3d1plemhva0lIQkVRM2JrOGxmL3BSTWVtb3BCZzhjUVR4ejZ1N2grSVdM?=
 =?utf-8?B?d29YWkoyeXhlblI3NFZrUG1Zb1NRSnZUNE8zZkRSNW9pSENIODBiM1VNTjhm?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UGU2PVq3KU6g8W0mGktdl7JBnB3ANNrlgV2o1nFD1dWK5HL+sPwzTkKxS5+Y2fycqcmifcgaYOs03LPXYqaXRlasS7MUZo27Xuc4zoqmtgLskOxczIlGyLXX27O+YSAoeWknDqSGBDk0HlgJnQ3DlCF+ggMhOMRZwyT+gvdFb9C4IxJBs+G+XDlqgFo5iHUjvmdNx78Uf4VfORpqpRvmpMAf/pxnEIXH9sjsUjTCkdaXqrUG1axny4gd8IxtHPIS5zfo7HIcs/PY1A+2lOpo6JWWVSnTb64pS6a1CuBEfXtRUeQwpxm4zK5wWQx2OyMLs0e1iLhR2iwUfkwe+HqrDvNLuthnPR4DM4t4LhS2IphjQgsUrHK0CBlT2PeeFPRRy8owDxdY4hIecs/yCMm/7/MMJceFhC9RlAq0RxkN2d9aHcEqIO/vmoIf+5gyEVH4xfqAC5tLHBJKb273dPUcuGWynUMXWXQVBLm0mHtE05G8boe6KXj0wsFh7gfxywklYnBJZ8nzSW0JCd/8K/1Xqat4tRKcT9BAPc/+yDmFPLX1heCzH9g7SCp3kCZx0u7cZNOxLB8SbkOk5EQ9ifz10gbe3C35g5XWw/HfsEJalZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7977a1-f9eb-471a-8a13-08dd54c6209a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:26:48.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFygm1pfQOUbBoj3lzy6cR5GblgPvKxpUjw6NeghCvkimY+qGGHXgKxwBSlUj0h041Ug4J3SD6lF1kdCbI4Gec2YP49LOutSbT/FTgCKQ44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240083
X-Proofpoint-ORIG-GUID: iaBmkB2hWfIzkoYUYGsPW64KRCUDHouH
X-Proofpoint-GUID: iaBmkB2hWfIzkoYUYGsPW64KRCUDHouH

On 19/02/2025 03:48, Jon Pan-Doh wrote:
> On Mon, Feb 17, 2025 at 3:25 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>> It seems that the printk's alignment is wonky after the rebase.
>> Checkpatch agrees with me here...
> 
> Odd. It passed checkpatch for me. These are the commands I used:
> 
> {Kernel home dir}$ scripts/checkpatch.pl {diff (e.g. downloaded from Patchwork)}
> {Kernel home dir}$ scripts/checkpatch.pl -f drivers/pci/pcie/aer.c

Right, that's probably I'm using checkpatch with a "strict" parameter. I 
applied all of your patches and then run:

git rebase --exec "git show --format=email HEAD | scripts/checkpatch.pl 
--strict --codespell" -i <upstream>

All the best,
Karolina

> Maybe I'm not using it correctly. Could you paste your checkpatch
> command/output?
> 
> Thanks,
> Jon


