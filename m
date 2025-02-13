Return-Path: <linux-pci+bounces-21358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE95A348CA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAAA1619C2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83E26B0B3;
	Thu, 13 Feb 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mG06PNH1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A0lujOqR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A46F099
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462467; cv=fail; b=dG95V2OHXc6r3pwoL1w55omyy/9k9a3JA1+xGpxW5bG7a526qXmSrWwl6EbMN1aoEjaHKMnQa0nPT/nVqJ7ZxOKbKvG9Np7ccC/BJgSyKgF9I/NGkxTwxpvUVaLHEstN0LIPmoo8U1kQpOfd5rms1uckZASGLB2f/L5Te58+92o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462467; c=relaxed/simple;
	bh=aGnJ9gwoDARIQEWUGVitEHTzKijAp2+r2SinoqyGDC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KmmTFX46BBt5hXV3YGDATEXpg5cDx2DYzzGVuTr6YJCGBHOmt4uc662iYYJT0WzS+OjWHLro7fZpaSpe8PFsx/ZAYgGU6213ynUZoAr/znxS686+W9uHQDRcT8SSTIhNWssBV8YNJcGjpYlKi7Nex5D1GJxJ2gXg3Jgv6BJVA/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mG06PNH1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A0lujOqR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DFfUe7005036;
	Thu, 13 Feb 2025 16:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tm4aL9oi7CFv2+jPLLOtu+XuofS2AVjiPdl/wAgAdAE=; b=
	mG06PNH1LJCn0BbZT0Txx0iue+62BnjlsX/q9A6lDtg622/q8PLI4OzhtepUWvev
	xEZ434N4ZHwbvSJ4xS9E/dk/aAwp2ned1+IsazbjsJw9CdSMbB34iyZPiZUS3X+c
	N60bvalIcEIbmsknmaLpQbgzI9f4MwAwTFDqPPdGXc6pnvhZXavbmNZz21Q34KiT
	qwjIHYRo0ySrmAiJG4sYb7JlldGin9mF0i0M4MgsCPeNfPAgau58d+SxZrISaoov
	tdbuVtNTzYOaLisor4g0CNMtxnTL7tzGK+P4ybPgtwz2i/bnIk7LExQqXejpHcy+
	xA7I+T3c8F7b2V3aZ+wZZg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqa24b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 16:00:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DG0ARp012375;
	Thu, 13 Feb 2025 16:00:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbvhqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 16:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQVOkKzsGSQFxamm02kWGbDKdwehsL4QwF4uKAFpUO5NDFsHPQbSUJYKiDsA+jbLVZBe7m/oUVo6VhUK1emOksnjlG0sfj3tKRfvp5a+8mgjUqrrsWgL78ZD3cCPVJGGbAbiYG/w3nLF20JB+nHhqAk099PoGgr1FJhPdgYzkKN28ppxtM5a2OZcdctMpNwoFP1lc/6/UeYzr5uveqk/2FQb8D8R1lE+BgpkkH4JlhoIU4BYxT8OwycHOVcAd9C8Vl5CkBRV2lcZzFbal5du3caApeeLx1DdS8mxQyu5rr2H07V1rym99W7m71vywGhUZDQzXlcKRna5EOO6rA6ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm4aL9oi7CFv2+jPLLOtu+XuofS2AVjiPdl/wAgAdAE=;
 b=E64bXTI0o6XXJww44g+MdHQ2K7SdKcQTEmrEY9JVe1uKaXAJEoLg9MyuAkGLk5ePdeKT4vcDywJFlf4s9vYJP2Js24SXJPs4of+J2C+izF5NXlkSokbJzF4zOkZOwsSwQ0vSzRujMGli4g94h1DS4OLcfvyZmTAAd0pebTCWjhXfIZKLW63Dif2PfWDlJgr8sEM+PX0jUO2snvyDjWasDZ27h96ogrCuT8Bl7CdKulXaW25RSbYChiaPba1dppRLntmd9XrnaDbdzNhoYqPdkeHWE1gfbJ4/K+iXLBU2tpGpm+TlBV5Ks905jRiZw8cKSgiTQmD6sHmkZSCaIwLLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm4aL9oi7CFv2+jPLLOtu+XuofS2AVjiPdl/wAgAdAE=;
 b=A0lujOqRsPiHwK4QuOrZnpr58w7LrW8xrgKuaU7B8g8wc5C/BXiXjbQoloocKZGZWiEG97K0Mqrr7do/rDLz2csxBzEPWoXuKZNGYix6UpNGHoNAVwXo4an9BynHVifzinKTu+7gSwNtj2sx+5A71AOwDbbJuw1JSnRM/2Tp3hY=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DM4PR10MB7391.namprd10.prod.outlook.com (2603:10b6:8:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 16:00:49 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 16:00:48 +0000
Message-ID: <7eccf9a4-dda1-49a5-abcd-75f1a3a850de@oracle.com>
Date: Thu, 13 Feb 2025 17:00:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Rate limit AER logs/IRQs
To: Jon Pan-Doh <pandoh@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <8f26a854-5d49-4993-a838-efec7270155a@oracle.com>
 <CAMC_AXXVQHZZFeDxsdqGzCuCS24iCZDHEZcbOppu9Vxvt-gH6Q@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXXVQHZZFeDxsdqGzCuCS24iCZDHEZcbOppu9Vxvt-gH6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::16) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DM4PR10MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c5c5d9-1f84-4128-1e14-08dd4c479517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkRBNHVxdkpnbVM2RXhFQlFoTUt3N0xtS0F1aWhkSnhvdTJkODVsT2YyOTM2?=
 =?utf-8?B?T2E4eXFiUWExbHZvN1F6QVQxNHBjQU4zOHE0Q2NoOVVnNzZFLy9GUVZDa1NE?=
 =?utf-8?B?SGttWlZMcVlFWWtzNnRIQVNhekprY1J1VnVTYkdqdm9OYmtGM0pYQ1hTZ0Vm?=
 =?utf-8?B?MGVmUFExQmxzYkpiODB4Nk9xQnVuTzhRTnRZeGVDZEZkVUFjbENneWF6eXk4?=
 =?utf-8?B?SlpRRTJ4WHZtcm1oOEhsSDE2Y2F5emZBb0dudHhMaUdsS0JvUmg2dVpYSitC?=
 =?utf-8?B?RWJuODgzWHRwSVBkUllTOUVyakh3SXpqelB1dmt6ek9HZnpvSVBibDMzTGg1?=
 =?utf-8?B?eE80ZjcrQ0FKdG5NZmVObFRCVXFkWWsxUnB2VGxudmV2YkdyMlNzbVJnS3RY?=
 =?utf-8?B?b0d0QjRGMkE4TzZXWDNKZ3hzcFU3RWRCa1cwNmh6SGw4UzlXc2RISEJvNGZU?=
 =?utf-8?B?OUFzV1loRFdLNzcrVWNkbnpZSTB0S3J2VTd2SWNxTjlZYzNjSWFTSW1mSFFJ?=
 =?utf-8?B?eVpONXBxODRUaVBuWXN6SUFxNFhLMjExV1lITHA0K0VDSlNPVVVTODhic1Fh?=
 =?utf-8?B?NldxU1N3eTQveHlxaWh4TXFXbVRsbDBMbXpSdE0xQ3hJOVdKVnVQZmZhMGRy?=
 =?utf-8?B?ejNkUGhsTWxJTXZqd3o0Y2s2Vjd3VFpwK1F1SE1EaTlDTUJqZGJKTlVvZnZC?=
 =?utf-8?B?MzJFbjl4UnRnOUFKVWMvRzZ5OHR2RHcvNXVjRnJuV29oeFd2OWdYcFhXM2JD?=
 =?utf-8?B?M1BOek1LbzhTWFd5eDJWY2VxbXpwMHpsWVl4VHBoRlJBRHY2RGpQeTA5UWtY?=
 =?utf-8?B?QXY4aWNLN3NLV1JwREVmdHowK0RFZi8vZHI0SXM5dXVzM0grUWFBRXhrZ3hJ?=
 =?utf-8?B?dmFOanArL3VQNEdPeG5UeGJFSEk0d0RvaENuN2xFcmxFaVY1Y0pacHc2aHFj?=
 =?utf-8?B?ZHYrS0I0MjFlNEduZjI5ODZMRWRjeHdrNW1GeFpUSnNEUzhtNHd3SEV2QS9S?=
 =?utf-8?B?T3l1SGFBSTVUVW1pR01naXpTMy9jQWpQZnFtOStGbTE0Uk9qTDZVdzNjelZ1?=
 =?utf-8?B?c0RTY3lEZ0tZZzZ3Q0hWUStVKzJiV0hDQzFpdXpxZ1VSSUQ1dmZZSVlEWjI2?=
 =?utf-8?B?Zm96RG1TNzIyTHRSOURmTzhsV0d3TytHU3JYSVBzcXQ3Y0txeS9JL2lCWXRW?=
 =?utf-8?B?WndMd1Q5SHZXQjkxWnRiWHQxWFFlYVNEbGZ0emhNN0dlNE5GUUl5a0tvSU9B?=
 =?utf-8?B?YnZHTmJ0Mm15SzUrb016RVRSVkNQTzRoL1RTM0doRzF0eU5IZ3hyY0NYTElQ?=
 =?utf-8?B?SXBYWnRUVGNjWVQ2ZW9ObW5NbFc4cHBEeHBqYlJJREtzL0E0VVhjSFM4S0ts?=
 =?utf-8?B?SVRwZHpxTnc1ZXpXdFNWc29Pa1R2MzNkeFJ3ekUvN04wVXVIdTRweHg1eXpN?=
 =?utf-8?B?RzVYRlQrZUd1VWR0WmUwM2ZaUGNNSXMybml0NlIwNXA1RGhBNUZiYURqU2x6?=
 =?utf-8?B?QVJkalJ0YzdVNjViQ2YzeXluTU5RSFc5TW9yN3ZiSnpCOXFPN3lwQ3JySHNz?=
 =?utf-8?B?SGtTQmdwTlYvRFNFSE4zdloxN3NhN1R6R2FtUU5mQ0xVcXlEd1ZoSk5NbEZO?=
 =?utf-8?B?bm5IVVZ2bzl0UnJxYnhrU3RjMk0rTDROWWV4NkFDRkJCa2VaWWtPQkhyRU80?=
 =?utf-8?B?bmZXVVdWT1hWbnpzTjBib3lDODNXcWw2WnMwd1V4Wkcrb09Dd1o2Nk5vSnl6?=
 =?utf-8?B?Q3M2Zzc5cjFEU0RCaUs1WTVkRm5JMDVYL0x0S0dMNjJQZUlhdGZnU2VXbjFu?=
 =?utf-8?B?UWhINGFZUzJ0RUhyN3J6S1luTDBEWmJCNGJ3MTVxVnI5MmRzcEhORFVwTFZX?=
 =?utf-8?Q?jtcyslig7W8cP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUM4cHJETFNGbFBJR1krS1p0OTUwZ0JDR2xFbnB4djFvNkJjVE1rSTZFUXhI?=
 =?utf-8?B?YmhaQnFmZlMyZno2djNPNGh1bi9qRU16bHk5TDVqNUF0Z2svRU1lQm43Tmd1?=
 =?utf-8?B?RUVsL3NXa3dCMDJlNlNvdVpnZXljTHV5aEV3WFh4N091MnNPN2lwcWNlWnY4?=
 =?utf-8?B?M2pDd2xkTUZBVjJRcFdqRUVxUWtCT3dSellRRVcrQ2s0WHhWaEN2MFNnR3hO?=
 =?utf-8?B?VStmNFFFTVIrS2VQTGNlTkUyYUJndzU2ZWplRnhrWGx6YXRmWThVVGdFVkRC?=
 =?utf-8?B?QmtqNWhmRkMwSkVXQkYwank0MFh2aFpva1lqNkcyaVVFeUVKU2d1VG5wV0o1?=
 =?utf-8?B?cVhvempKMEtaQUEvOXdhZVBmYWgyVDdmbTNHVGtSeU5WakdBTHBTZEZrMGFW?=
 =?utf-8?B?S2t6WU1yTGRDWW4xMnNabUtXWTJBR2lvZ29rM2d5bjJpYlhGZzFVT1hqMlp6?=
 =?utf-8?B?UGJLMU5BaENJenlqSnl3OEEyb2tYMlRxQ3NWb3JEVnZLcU9mbmlXeEFZK29C?=
 =?utf-8?B?S2JIUGlsbkV2ajZJMjN1TTZMdUZyNFVSVjRYZFBBbVFuVUZBdWdsSnZ0Rlov?=
 =?utf-8?B?cUhqaVlIQzVxSUh5enlDcFBjckVFTDFyWExKZERxOHF1S1lZVjNTK1lqQnVT?=
 =?utf-8?B?SXlLa2NNaTM3WVZFVzNGWFlLNVdRRWpKTVdYWmxTdGVqUm9HeDVtLzZSM2Rp?=
 =?utf-8?B?TVcyZ2Z2dnFGbzBmanNhSWFTa1FqMlFaMjdLVUlmWlFULzNUaFd5REZWR1Nl?=
 =?utf-8?B?YytlczVDcDQ2c0FBN0NiVEN6czZJMW93emR1L2FZcm54ZEZ1OEVBbEtPVzJW?=
 =?utf-8?B?Ky9DcWVIaG5zSVpLSjZSYy9mUzB5TzAyNkhnaGlWUThHZHVKZHMzTFVaZXFD?=
 =?utf-8?B?RXpJTGNyaDZOQmxVVG5ZNi9TWkZSb0I1anVzMTZDdm4xNm1UelJzYnFMVHE2?=
 =?utf-8?B?NnlqclBWekozQ2NxVWp6ZzNsS1NqeUIyZGhvVVRQQWlpS2hLT0RsM3JxWE80?=
 =?utf-8?B?SytYb0JQMTUyejRrdVhiSE1ROFgycDB1RDhZUEtBZjNVWk56eDQvcHphU2VH?=
 =?utf-8?B?OS90Wml2OVlXY2ljRTBYSW1QaHV0NjhkekZnckZ1OXVSWC9DaFRacDYraEZW?=
 =?utf-8?B?bzRYYStKT1FBb0YyaUdNcHo0Ty9oOTRaY3hGckIxSmxyaDJRRFdPaGRaaFVQ?=
 =?utf-8?B?OWxtNEEydndPVzg2Z2lNYTlreUd3dEcwTDZyUk5YL3JyRStUR2hUZ090MEpJ?=
 =?utf-8?B?V084YjNsaGg4VzZ0eXl6OVo3VUlxbndrTDQxdWdvNXRlSk50RlBYUTFKMUtJ?=
 =?utf-8?B?ZXBzLytEQ2tqTTl5UU8rcmx2UmtqQTd5dXFUTjJWclNZMTFLUXFNOVpuUzM4?=
 =?utf-8?B?Y05XQkt6S0ZmZzVhNktkekJoWVlkamxrOFFqWVVPK0VoUFN4OGcvK2JYd2Qr?=
 =?utf-8?B?d1JFdUhrN1Z1dnVud2tpalFWRkdqY1d4dS9PWjdWOWR6cUhlTWRMYzR1dVZk?=
 =?utf-8?B?d1cwMWlObzlOaTFxams4Znh0UStoR2lpOTZNQ1hpa01RSU4zT1R1NllzTlNx?=
 =?utf-8?B?bWs2TGQyL0wwT1BoNEdKbmpUVVRMY1NQQVIrMW9rOVRnSDdQL2Y0WVBSakNn?=
 =?utf-8?B?SkdldzdRcGdBYmd3STRiMlZsNEM0Yk9TMCt4WGJLZGtNTmdrb2gwcE5lQk9o?=
 =?utf-8?B?MkdEWkZya2pVTExkcS80QVdQZUdUczJ4clhmTXh6eFYrcGV5UWVGRnVqVUdO?=
 =?utf-8?B?dnRKa1BtRmFCNzRJRXFMS0cyN2xqSVJNTnlncktaemhZS3ZtWGFQQzZNbjhX?=
 =?utf-8?B?cEVNWHNiSy9vWDFnQzlPU04vN2Z0aGRxNU81SWtySU9kUkRQdjh6VFFGNXpT?=
 =?utf-8?B?Q1FGc3dUS1JvUGlDRHNIWWJFNmpOR3FBM2NLZE50a0JOVXBPZ1gxWkpJZGI1?=
 =?utf-8?B?ejc3UXphZzd0dVpTMEllVnlGQmFITjZwOENiQkdpMTRQMXZ4cjBsM3krcGlE?=
 =?utf-8?B?ZU1LWkt5dlRyMjlTNUJoWjVGaUhwekpLUE56STRaL3hHV3AzNS9BcnFKWjlt?=
 =?utf-8?B?UEcvTXlyTDduc3lLZHArR2k5OC9KeUM4VlF3TENldjhoM1pZRyt1a3oxelk2?=
 =?utf-8?B?U1M5c2pQdHlKSWVOTnVoZ3dyTUVDREVRYlBqYlVFMEZYRnVPTExlVlRmSTdK?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U7fljY0gEdPEZou/7JyIzv7Pc+Ng8OTbCOcLd9QEtfk88hsNwpy+lFNIQdfRZfqwfKCNVygbQPUOETJ/6NvqPUuDmm4E4bYy0aLZcpbx9WNIDuMXsUrRw5bt+VS1b2QpdPYml+eb8WCieC4B3vuf3572xU9VvNhGRKb1/ptUXj8lIR01Q8iVNytFwwS0bp8HVqREaIQsBM4hh495uCs+oDX47191KGFoR44lRbNeXkh4QXLE9fDVRR0ffc2Z5/xwOQA9DurkuN6PGorpek/bjnBvYfsa1mCYfe2/38l6PNU4KXd97e/MPLAkUYMRH9z/DlCzxYJXRi2xQ1HdW3IvDMaLWXNaJYVmkOtGTLx/ljQwXXV97coxZW5v84Uhq+YMQjg20+wSM9EJmNedq2XIsXrQZg001ZGJZ+qJnVWGaYLoeejlbM7KAQhbRInZAEhu3R1nSdAVwcMG/9I/FCgh/mn9Myc0mzFPaOvU8TAp1n3iCzZUtw+Je86Ir0pJRzQ86/g36/3v4TsRPrfFfGXlKDnCuNo+UMd1ylFWnxO3Qx3T5WBKRGMaUzPpRIAhbghk4qJvZw7znOI3hKge/3FanLYrLp28VpObJ0d+7sRTfao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c5c5d9-1f84-4128-1e14-08dd4c479517
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:00:48.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc6CkKKw0RCUW298gSCtdvDG4mhcOCYK4hdJtOYkux18vRmGIy6piFRbNiRzqZ1xjqcTR4YVvJLVWAI0pbcZV/Hkv4kzQ+45RaFpUyM3/aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=968 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130117
X-Proofpoint-ORIG-GUID: xIy4h01v0aao-v_t8jwYowFPScTZ-MS_
X-Proofpoint-GUID: xIy4h01v0aao-v_t8jwYowFPScTZ-MS_

On 13/02/2025 00:19, Jon Pan-Doh wrote:
> 
> Sorry for the delayed response. I was on vacation and hadn't had time
> to address the comments.

It's alright, there's no need to apologize for it :)

> I think splitting the series into log
> ratelimits vs. irq ratelimits is a good idea as we continue to discuss
> the latter. I'll aim to send out v2 by the end of week.

OK, sounds good

> One outstanding item (mentioned off-list) is Bjorn's desire to
> consolidate the logging paths (aer_print_error() for AER IRQ and
> pci_print_error() for CXL/GHES) as a prerequisite (clean up/reduce
> tech debt). Maybe you could help with this?

I'd need to dive into CXL part and ramp up, but I think that's something 
I can help with. Does it mean that you'd rebase this series on the top 
of the proposed cleanup?

All the best,
Karolina

> 
> Thanks,
> Jon


