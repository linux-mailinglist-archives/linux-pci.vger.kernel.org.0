Return-Path: <linux-pci+bounces-24349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D7A6BBE6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980B917F89C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FAB22A4EA;
	Fri, 21 Mar 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="flTLkf59";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P3sk1zEL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F6216E01
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564649; cv=fail; b=Dldx79qVn1RoK11mMXlX9htdnsGkA8RuLuq4WrmNGI1kqq60vi9/ZWb+vCndXBJO4M+52rkDem6ohxKytJLU3/wyBB3fzq/8onHG22KG0ccxfkWOSHi5s/803sDbYducECwl3FwsVsKTXS3J5hjkpGkGux8P8b81OLLLSaH2yxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564649; c=relaxed/simple;
	bh=74OAkR+FWPbGFMthc+EGvfwb0rsqc2MHd+YJDg5Qj08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=duSLkNP1+NPrfJsU668qaefDF82g06mkbc4evWR9Vo59nv7ooWejgMMb8ur/QeoKQkOvmGeccot8q41sCE5ohDehjtFswCqDUJRnmzZB8k1Ml1ywRyshEo0XMhzh7BhQGnSNw+R8WoUEhyNXk37s0SSynUOUGlJ3ZcTrvr3Tl1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=flTLkf59; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P3sk1zEL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4tihm030143;
	Fri, 21 Mar 2025 13:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ds5ifq97RgjdBVd9Td+4g1UmiC9qWjejRh+FidkudKo=; b=
	flTLkf59QMLpUjtsVweLJkOFgutrwALFybFWJz+Z4KNzZe3vCRzU7Flzdp9ZHQ5M
	W98d+d8p6BhEpFJWS/yq40CD7tIkDuPYwwM9Q6JsfpfCr8ma0NYXPC1V6qgr24tX
	bZ4B7lPkYNsf2NXa7I/c8whJTLManusBw8Ys5qKNm+ZSFtI2qjNPucWooji2ww6z
	+p5BH8CzluMMUqY7OTTNUUD20gxFwkMq+Qb8IbGjXo3anAJUPV1YvuR1Py3/EmKY
	WwgV8u2AbJ8snE5DF62qZe/lb2Frft/6MAqEMLpHOtfB+UMTzBeWptRy0czUMHIK
	MGeXX0A0RZNyS/1czlmYzg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbgm46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:38:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCkW55022409;
	Fri, 21 Mar 2025 13:38:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc9yaxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg2+dEMLz2z1BDzNsacMA4r3OcQW/w2ehBciCvm/dauK5zpyp5On6jIS1Vl1RnUSJ3MleqnDbvASvzd9BBWRUdq+3WE6Le94CuWbMRnQ4Uueneb9VlDSFeUi+s0B1HouXJsk54oPkUkZqwCJpDN52fal3DvK7kp/PtmxsjbO908dBOebCrd+Jvf25ewiPGTzwuF3aQ3h3SqOv2nf7q9cLQkBTJs0WP5FTGQyAnyhxw0DEzMIacZafB4krjRR2GcyXvroqo9O+2sjpQ08bSnYu6r6Irrv18x1RW05OPDckfnx9zYLnq+j0JcM61sLe9wUI+rMIN6I0eB97+0rIORuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds5ifq97RgjdBVd9Td+4g1UmiC9qWjejRh+FidkudKo=;
 b=OvSbpb2L9UrxkXV0vZOk8hV/Uys+WQuYYH0PdcUrWSBJxP1RNGyNqbn5eb709phxcAaDafOIHMJQ5RHm8l6qTLBRjFh/zJmaB/XUf32kbPSZg1kjnyieNjxB73XCpkBQW9/ZoZH6kbuBXu6WVGEKF0oprihS1RU0u6T7rs620V/SlOtDFfKStPbFlRYLm8eiYrPYfY3l2/EZMoAA+L6urn5S/Z2JhEcmwYW3CWkKAjFt5AqGg3XSmBe1e1g80nfzm9LZGWj7GQBF7GWX3d0xuEq/gBSmpb2ItFA9YQwY6CfbK4CTrVEMm5b4OjLC7AMRORXMv9WsZRL13j7ic4RNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds5ifq97RgjdBVd9Td+4g1UmiC9qWjejRh+FidkudKo=;
 b=P3sk1zELc12M1RrMBaQCVDi041I1+NQJBwJo04cb9rb/ntDwlsFc+UDgAugTxgimsQJ7XnDX6tPYAsJaHtTfd7ioykQMGX4M6qlTDDBwGtbObjuaIqJ82cbpcIc5R5ueFwTYn1HeoOKEee7JL53ebhTwR3IOjvCRZnT+fPf+G88=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by MW4PR10MB5882.namprd10.prod.outlook.com (2603:10b6:303:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 13:38:48 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Fri, 21 Mar 2025
 13:38:48 +0000
Message-ID: <e4092396-e11c-4ae4-9732-5cdbbb44ca24@oracle.com>
Date: Fri, 21 Mar 2025 14:38:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] PCI/AER: Rename struct aer_stats to aer_report
To: Jon Pan-Doh <pandoh@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-5-pandoh@google.com>
 <9aeae39b-b923-453f-975a-cf9445459b0e@linux.intel.com>
 <CAMC_AXWYgGKKsqSCwckFzdT27ntY3fmwjft0v87Otp=WO6yzvw@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXWYgGKKsqSCwckFzdT27ntY3fmwjft0v87Otp=WO6yzvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|MW4PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 2262821d-e2fc-48e1-32d5-08dd687db58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzdVNllZSG43eUlsZWx2VUpKT1ZEbGs3UHpmZkN6S2xGVVBtbTN6ZzNEcjlm?=
 =?utf-8?B?TnpQRk1GRVZ1RSt6UG1SQTVVNmcwYTkwaEp1ME5zUlVydjdvaVArYm1UL2N3?=
 =?utf-8?B?MHlPREhQazdzV2RYV3pjNURDaStLRWRYUTkxdXg3R2VVZlBvNnVXTTFQLzlx?=
 =?utf-8?B?ZWNtUzlKUVVJMnFjODVadW9VT1NmdG1PQmZHU3hzYUp4WGhhUnF4dHRVczRt?=
 =?utf-8?B?Uy9aOWdpell3ZG1FMDJmaE8vcFJ1aGdkTjB1Q1g3clVlVkw1UElnYXZZUktR?=
 =?utf-8?B?dTB3OUgvUzV1RjFZVnRDZ1FLYjh5Q0ZFQ0xJZ3VJZkU2MnFPZm9GZ1lBM1Nz?=
 =?utf-8?B?aG5XQ0srYlNOS01KcXJQVmtZRkVyYVhzelRXak9NdHlXY0VlTnVyajFZekM0?=
 =?utf-8?B?RWVOZDRmVmd4cC9UOXhDRHlnZkxyOVRsdlM1MmUzdm1ja1FmT1ZRUHJYL1oz?=
 =?utf-8?B?WkZ0WXpad25SQVNIMndlcHlVdzJIVHYvOVNnaTE3SGoxR21rMHhSbnYxYkM4?=
 =?utf-8?B?SnF6aEZ6R0prdC82WnNpdUQwQmxSM1MyMnVsRE5BZDdQa1gyRW5hUm1Hem92?=
 =?utf-8?B?bnFXUmhaN0VheWJHcFQwbkRJRHUxMHZwTEpKZElYV0FqOExLWXJOdDVmUGNh?=
 =?utf-8?B?Tys2QlE2Z1RZOWIvYlpaSmEyUjl3NWxMaTdXUmpEMC9wd0pOemxiek5qVCsv?=
 =?utf-8?B?OGU4ODZlaVU2M0FRRFR6dkwvOHhSdXlRdHBrMkNQZjlYS3JIbGNkVSttRllO?=
 =?utf-8?B?MDBWV1FxcndmbDA3cHZEbzhJMnFjNlhkVzZuZ1B4WEtzcDQxNWpPWExrb2ND?=
 =?utf-8?B?TFU3ZGpLZnpaeVJENENiK1loRkNtenE4M0hHbXhwZ2NRb0Rsd3hJWmw5KzJ0?=
 =?utf-8?B?RTh2QTVFTFdGb2J4SjI2ZmEva0F1VU5NYXBZRnJhQXkxN3cwTFp5Z2tNNE8r?=
 =?utf-8?B?NmtjV2lVWlErRng1Mm9IdFJaeEdUZVB4VXRyeUpHS01CYWpIUUtzMmtiRmNJ?=
 =?utf-8?B?RUYyeEJOQjhISTAvWndhUmdyQnNOZ1BZLzUzc1Flc2hHY3hOUHlMVzB6T2lD?=
 =?utf-8?B?SFpKNWF5TDdUUzlxYXBVR0h5dEY1NlczWnVBYklsMXJxenhLbVd1dEVtMU5y?=
 =?utf-8?B?YzBNbkZ5SW5yNlY2ME5kV2ZKNUtzQUR0M0lRcXVINkp4Yko4WnhLTGxkbW1H?=
 =?utf-8?B?eFVqVjFkWHJTcVIrRG5LNHZneDlYYWZhWG9aa1VQUFRuZ1cyclB6SnZZaE5L?=
 =?utf-8?B?aUV3OWdkck5JYzZTbjhHc3JBNGc3WXRpanN2SFgvUXg0cnM5MVhPN3FXdWp3?=
 =?utf-8?B?djBIQWlmWitMRTF1OG4wY2ptQUJWUzhnVXJKT3ErcFUxNUROeGNlVTN2U1BQ?=
 =?utf-8?B?ZEtaSEgwT2tmMTZRWFUzWjRUQ1pYb0J2UytQWW14RmpreGFJVDdwbld5QjVV?=
 =?utf-8?B?SU9vWjVyRUFoWlR0MFJMVFNYdHM2UUdwTkhRVlFtUGp5V2doeXRKU2hHSHBZ?=
 =?utf-8?B?VGQyTXdzV1B4U0NnYm5iY3hVMVMrWEtEdDhaeUtNN3FMOGM2bUpucW9LZHF2?=
 =?utf-8?B?Z0FoSkFCZ0VzUW02b1BZUWc2RHRmWGpMUWVpcEs4azBRL0Q3byt4QlF4NE1N?=
 =?utf-8?B?QkVIc0lBbzBiejRCTVFsNENvQmhncHRNdmpwcUtRS1gvUlFlQncyR1dlWFdj?=
 =?utf-8?B?d29qT1dUNmo4VG8zMmtaOUhPT1ZYblRBbFNPTC9WVVd2WVJoMk1RUUVMVXhv?=
 =?utf-8?B?eVhyYWhlcXlnL1NiVWZEOEFIbVdPSWV6ZGh4Y3pjTFV5TC9CQWFrQmMwcDdZ?=
 =?utf-8?B?bDI2YmJBTlN5Mll3SktXeWQ4ZWlWWXZCNklITlRTb2RxU0ZxbDlJSS92WTcz?=
 =?utf-8?Q?0U4/amrqeCotF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGFzM2luaXF0MVlsRWt3RE50b3RrckF4UlRMU2lXcStpbHBhZzBxY2I3ME10?=
 =?utf-8?B?ZUNGdVJDRGduS0JES3hZbkhnTk1sRWhwbGhoUmVxN0VEdWxmdkc4WE10QTZZ?=
 =?utf-8?B?ZUZJR1BDaWV0NDJENXp6S3EwSWdoZVpNcU1NY1BrZjlDbDhGMldjOGtZbmZz?=
 =?utf-8?B?c2ZYTTZ5ZExXbVM0czRDamdITHN2dTdoaUxqSEt5dm5rUlBQUDN0cmtZME1m?=
 =?utf-8?B?NGkxSDBMYm4zSjB0RXVselB6Rmw5RGw5OUxoSDNjbWZZV1lLSHB2dGtSdWlm?=
 =?utf-8?B?SDFnSHNucjZwd2dCSTVhY3dYeDdaa0drY1VGNWQyVTlvNEMzMENSZUViZWdX?=
 =?utf-8?B?TW9RUGNHZFFBMUpDTEFOWVdnZlB6b0tvSzVJR2xRb2FPVUNWamNzcEtadjRt?=
 =?utf-8?B?REpyYXFCOEV2dDR1VkU2dlBWK1lBSThvaHl6UU02OFI3bzhrU0JWcVIwUWZm?=
 =?utf-8?B?QUsxbHN4RXVkTHNNaGtPc3VNMUI3b2ZXS09NK3FJNmNsaFQrNzJTSUdtT3dt?=
 =?utf-8?B?VGpjRkdvbG9BcG0reHJXMkgzaStBVExaOUYvUzljbHIvRndRMlZuTm5LejFQ?=
 =?utf-8?B?aDYrenBwUWc2QlhWaWJ2M1JOWGwyUCtBWEFQNkgvMCtISnFsTGkzV09IRXZI?=
 =?utf-8?B?a2NkM0RjbU1jckRoTmd0S1hVRzBqdUtDNUFKVGRtWFpvR3BKaUF6WCt4bFAr?=
 =?utf-8?B?dlZiaGY5ME1uaExBWGU1Tml0aUsxYjk3N055N1cxd1c5OWlMZ0hWQ0dWOU90?=
 =?utf-8?B?ZTNNV1M3S1M0NzRTNXRTM3B3ZnN5dlBjVmJqbDl5Mnh2NURSbHVpTVgwc3pV?=
 =?utf-8?B?dnM1VXRaUU1mbXdGekE0Zzh3T0MzL1dHeUo2Qk1CTUJrTEtKOXN0T1Y4WVAw?=
 =?utf-8?B?U2hSZDhlTkVFNGtBVSttdVhFR1hDRk5jeVN1RW5YMXBzd1duK3NEdzZIbFZK?=
 =?utf-8?B?MmxIY1lHTnhyREJCMWdzSmRlQUVyT1hqY1VVNUs0ajNudlZLWkd0c29VUTVk?=
 =?utf-8?B?WDB5ck9UNXBqenluU3ZxeGV4VjFkbTEvbGUzSWhyem1yOHQ1N1g2bjBpSENo?=
 =?utf-8?B?SVltK0VGdFlTUDVPU3FHTU5zakg3TzdNRXN3a0tmU3hKQjc2QituL24yM1J6?=
 =?utf-8?B?b01KdGE2ZTY4M25GaVJjM1BnNVg0dXMzQXhnRm5OQjhLZ0Z5UTJwUFQ3MGhG?=
 =?utf-8?B?SUR6ZUFOZTN4RHVXK1F4bTRTZUxMSEt0VmdCQWxFTjJEdU10UU9qMlhJbkw2?=
 =?utf-8?B?QitrUVl2N282b1dRblM3c21NYnpUQitEdG0vblRQeUUzOUpSMVcvVzI4K09C?=
 =?utf-8?B?T2FnbWtTUkJ4TkhxaDVHQ1pFZ3JRR1RoTXFsQUdmK1cyTEhVa2FKOGhZaHJQ?=
 =?utf-8?B?S2YzZjFQWThIMm0zMTRHNWdJYWlIbXUwYVNsL0hldjFjTGp6VTgrT095dUd3?=
 =?utf-8?B?dENIbU5vd2lUZEtCK3N4dnQxQW4rQWZQZ0trRURVUFZZSURaSEJXSHF6S3RK?=
 =?utf-8?B?MXExZWdqcFJpWkxZRGhaYW4wMGduQ1F0OWVrNFlxNENCT0VkNnpvaW9wSEJ6?=
 =?utf-8?B?cnAxR0NuVnkrYS9uUG1yY0VneDlFSFhRSlNjaHZXbi9NaStsdDlibFVKcXFJ?=
 =?utf-8?B?b0xBSXROM09YWEpFRUtIM0pWZUxNeW5CLzA1WnVMaEVTQWNnMlptYStsMXMz?=
 =?utf-8?B?dk9vUEV0WXZzN1pWdG1hSUZ5bWtUMTdKRzhjOEVVZ01nTTlFR0dqdmlQNURG?=
 =?utf-8?B?enN5NnFVd3IwZytOQ3lSVXhyckh5UVhsbTJqdUNBNDAwRm01UzN0TFM5M3lD?=
 =?utf-8?B?SDdxc1BQVWZkaTljTmVVeGRydzZPV0xoczVZRGlyVFBYOGRpaHU4TWQ3SUxM?=
 =?utf-8?B?dlZkRHh4cCtsNGZxUDZ6bWppcVRzQThialRaU2N1N2tNcjRvd3k1aElqRFZD?=
 =?utf-8?B?V0thcGNnamJQOWRqdTFkY2owUnFIdzF6UTNBZS9CRm96MjBaNGZoSmxuNVpM?=
 =?utf-8?B?ZmFHTjRqbTQ2eGsrM0k5SDFPYzVBTnE3bVdVRUZzMm5jRXovbEthRmNQV3Z0?=
 =?utf-8?B?eEwxYTc2MElSNERoWVZaa2E0aktDd1NjWW84S3NVd2NaN3BJTlBPWTZEdXdT?=
 =?utf-8?B?czJRcFNCc1RYcmZoNmFtbXZjblNyZVFZTUlkTm8rR0dTaW1ETE03WXd2YVdD?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7aSrAavMMHJJ+ZzYAVVGYZNWOncF5S3D2zECo8NGDVfE1yGxmTPZp/d/wi/wnCBMLVGBBWfT5S8L3MvdrYzFxiEWaCtnh4UAxOSz5J/Vt18lp8faSrn2oJt6UdNUyopXDpzV5hrgOH4hcSJKTN2Potn/rjtCMTw93Pqgg4KhxkSYEdLYUjp724T6P+DJiPMkh+vvrkHGvnAnvCiUt6pDvevd1dKROajDJF9h7qFAOApnnDIqpGpuaVbjEzJ//Xi/KB835kY/ID0YmoidspaGWPN/XdWhtpSugZsi8Ywn0yEF5sNfGO4UN4XkF5SZTA8Z5qfGNmzwwrAtk+nAjnvMN2AyEanvAU9nWSjkHuWKUfRKeJoRqZknh/g+gDn0psWhPhOC1pFalaK2j2LfatMT5svZYP9uNdmt+vv5flhfRhUh55KXQeoP0VTRetto4CR7cYtaN1D2GexXR7JwnDjIEcqiAau+/Mo8TvDzYqram6L0UR5LHNbKFX3V5prQNgXzjX1ZA8UvcsQZPzj/X+ds9ReoTd3Vm6JLSh6QhKsa3vBay51YTd+8sXXfl8+Ndcx8hKhLpSlteOLheuBfmYcVUXs5IWFocZTX5cRY/ygm6gk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2262821d-e2fc-48e1-32d5-08dd687db58d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:38:48.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5k7fQZkZxwyI4VcNzM2CVxbuHVwrY0gXx/2xRDMLU+TNpVC9hIfFhzmbc6OFHGR6DONd4NqXlxK/cSin9LsAbH6Wxz+P501M4FRTQKhNVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210101
X-Proofpoint-GUID: w_S18iIRIYi4V_HRmXiFiWBnu6nET7p-
X-Proofpoint-ORIG-GUID: w_S18iIRIYi4V_HRmXiFiWBnu6nET7p-

On 20/03/2025 20:53, Jon Pan-Doh wrote:
>
> Ok. Karolina, given that Sathyanarayanan and Bjorn are partial to aer_info,
> should I switch back to aer_info? Or do you still have strong objections?

No objections, let's go with aer_info. You can keep my rb, I don't 
expect bigger changes here.

All the best,
Karolina

> 
> Thanks,
> Jon


