Return-Path: <linux-pci+bounces-21603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2BA3819D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6DA1887632
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE21217670;
	Mon, 17 Feb 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WO5tErP7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e9lV6EVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B52135C7
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791547; cv=fail; b=RFqUrEnP+9I1tc2GicgDO55zKY12JGqWyRkPd9T7jMHAvjcYKzfpYz7SLeFMbB/g5pWBM9H9ad7hpNhiO7uvFlzXO4BWwARMZpyxHE80qp+AL9uJm3T0RYU5hPfa/oULntYCs/ofxFT/kmziqEmvYzhXchJS6Giehi53JIIx/UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791547; c=relaxed/simple;
	bh=lwy3w38LBVRDmO2mW5gj7rbQba9z+hqBmAoxox2zb9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QrSaxKqn97oop5V0xm2l0mS8QPunXQ9uLxCN9PtIQk2LeSGtuzLV1Uku3BdacK2dmv5FaUeOwwYvGCtUjb2cnb70rS8gIMWyTeQhXVww8GZhkPTO5b7eAZ3+dHa34arqqoA/75JQdNGTNsvl7L1TrKPJsomT1hqAhZ4G6lvMw9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WO5tErP7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e9lV6EVH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HBMVk5025590;
	Mon, 17 Feb 2025 11:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h+uj49rpFWLy5xN1IpAlMqinLSkHP68LFE2P/iJKfNA=; b=
	WO5tErP7yKSY/ajVy+B0pOWv9zNKJjcubbdnWBAVJiZuHcgIproX2e3HdicDNrvv
	qNZ7H7mwInFFL5uicDgoaN1sjUJwwoCBFpGdDZu6zCuRBnnLHq6v0xJtcyWvxKvN
	y0UcvFNGTPp2umdbvXf6q7HilwwjmuFdZujJpgpGUOA745N4oS6EHfbO2KNkD934
	U78UQdQZUOxRYzwgrIyIa2sTbIpK0k2qnbB3K3kir68X75jJuUm82lBI8dCdTO0T
	Plxigwut27Gq/8mDIZpcFDAGuYj1LHwdZmDgVFv/w2BN/J1KUQ3Wu8UFKsLtRuBL
	dzfSwifdIf3gn3TpH/76Cg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhsc2ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:25:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51H9xpNN001991;
	Mon, 17 Feb 2025 11:25:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thce2bt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiVbF6qW9XZ3QuiUcB47liNV/v+Oq2SCEuYnyLEttQAwa5GgWS0vdWsev+BLPw0bVvvcKRBvpzgZ7IRFawxYEqgn21AZK0YT4Fb57+aGWm9f2FP5tOwuXIGDRDwB4v6qx6XQYnDXdxqzVif6SKjU3hF9oGOVr7pqiSW5XhtFLgV6V0Uqt9m/D89gcMuaGCuSY7t8w3d74vP4Ai15h02G+8r5wJFm3MMo6wYkZ0ApxGsqAjKb8tR2aIYdOeGhl28/qPPoEZrq9Wf002fsXlgwYh3kCflsm8zH484R2/CLcf5RkAMcBsk4upUhVlz6d+hObZM6D0oMsPp5BPGZHo1crw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+uj49rpFWLy5xN1IpAlMqinLSkHP68LFE2P/iJKfNA=;
 b=Dt0lLF0152uGVeHw1zSMuGbqF2jjmhY29y84sWp5w0nMqPF+ywalauEFVl2X2Vey+No7isSY6GInEDqRnCjn/O1B+OC9Gu5rKjSVZth8hUBI5R423FaCwle8t6MSuM7bR6tC/qh2vbZvbFFfs2VDxJcsbKGq9yKAZ3gn5zeQe3IlNuFeRK4z7WDNQJHIXHwxvAgWOE+DV3yhcJ4xqM5bWTCsv2XW4s/fGmbIY4du5h3/4GcDI20ZeSA0mjLDCZqrDo20nyPszVaAR5kS9DAmzvLVdD0nV3rJSUsPtlL7g222VB+hz9SDwDhdpATyfYqfwFfAddLuilRol3BlolHJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+uj49rpFWLy5xN1IpAlMqinLSkHP68LFE2P/iJKfNA=;
 b=e9lV6EVH3kC7aAqD53py8MBJiYjsjvoTenf4ipk9H8h1izgwGlMs9bb/1+/Fa3uhOhvAPD8WrwGFqeANbTmv9Uh/oU0rC6EVpU845DDUDGnzx+ITi7iM+fEyVYKKFiA3aacik2XnpOhxgu36bUUQzby5dJKRr/oXwl8pC0CZUyI=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Mon, 17 Feb 2025 11:25:21 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 11:25:21 +0000
Message-ID: <8e94ccbf-497b-4097-87a5-761cbc7c205d@oracle.com>
Date: Mon, 17 Feb 2025 12:25:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
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
 <20250214023543.992372-3-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214023543.992372-3-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:208:14::32) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 027b7358-7cd1-439c-8067-08dd4f45c3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVFZdlc1YzR6R0dpMTZuaDg3b0VLYkwybGt3MmswZXRWOG8ySE4rRjdvRnFa?=
 =?utf-8?B?ejNLbmt1cHBraUV6SEhQMDNmWEdyNHhCcE0xSnZDYnI2NU5JN25LM1JnQk5S?=
 =?utf-8?B?K0pKSXVGbnFQNVNVNDQvSXEwSGNPaVU2VktsU0hOWndMbElmUm9zVlpGSUtC?=
 =?utf-8?B?T3FwOTgwMXpkcjR3NWpNWnFnZy9jMy8vWUNRZHhVTTA1OEdtUzk5ajVvT0NH?=
 =?utf-8?B?aWRRUmhhTnI4NnVmV2xsZE5NeGVDWDJmYVR6V2RsUUdLQUhpTERCV3ljNzJm?=
 =?utf-8?B?NXhock9kYnVyS0NNNzlleUduY0liT3VscFNaNUFzdG9NbVdVWHpHN21KMEk1?=
 =?utf-8?B?T2VMQk5UTmh4T2NuRnMyazVjeUxrL0tHNXJsUUoxY3RNNUFnekFaTFVxcHdu?=
 =?utf-8?B?TEphL0g2NE5SeXNFQXgrQkpmMktqUk5mcXlvQlhtQVVsMGdHYi9nOUE1NDMv?=
 =?utf-8?B?Z2wrbmV2SzduQ3diZGw0UFpiNzNiWkVmUU4rcHV3SkkvREQ0ckNXMkw3TCtQ?=
 =?utf-8?B?c2VsSnZYM3dtczhRdmZhZGM5dnlySmlaWXFuMEVtWUdYQU5KdXg5TTVBWU1k?=
 =?utf-8?B?TzQ1S2x0UzFTVmZ4NkV2ZjJsYXpqNzlUT093Z0JxRmtUZGFrVFhzNThqNGpj?=
 =?utf-8?B?Vmh3cVU4anpZdlljRThGKzQ2amdtTnJEeFRta1loVU5pbDVsdEM5cVdtL1F1?=
 =?utf-8?B?dUc0Und2Y0FLa2t3QmpjZWZBYmRzS1NMYU1UWm9PMEZwK2hieGhsNVpBSGho?=
 =?utf-8?B?M2hHVW05UUd2ZUFDcWxjV1ExdWk1UVIvZE80R2QyK0RQb0p3NnhiM3Y0Z1A4?=
 =?utf-8?B?OEsvbnltclhnbXVIWkR3NXdmY1FqV0twc1drNysrSWozSnVJdmk1MjVYNXN3?=
 =?utf-8?B?OVBwSzRTVThVRm1yVE0wakFScWdNV3VZS08wUzVGZUFqenBFUmNvR2pFK3cz?=
 =?utf-8?B?WmF1elNDaEdPdGNIbXBhelVXY2NKOXRpcFJDVmtsL1F4WkEvaG1lQy80ZzY2?=
 =?utf-8?B?c0pYUWJNcnY2bHpJa0tDUkpmVVJtV0tVR3FQMFkxeXF1amNVejRUQWVQVmRE?=
 =?utf-8?B?QU5xQmZXYzZsalJoRlFiMDZJdzY0U2x3VUwrbXZkUzVUZXR2c1ROTVJ4NWtK?=
 =?utf-8?B?dzJ2SnRlZnBZYjJOOGpBOHI2Z0FXa0RDYkloTlFMRGZiWW9SOGFaSS9xUnZu?=
 =?utf-8?B?ellyQUhDblRKcTFRQUFBOWN6U1ZhK1VKSjBvV3docGhoUE9pS0UrK2k1RlZ0?=
 =?utf-8?B?Z3IrQW9vMjNFbWt2V1dhRGk4UUtyWFdhMWZVdHVMS3ZyLzlXY01VcStzWmNq?=
 =?utf-8?B?RlVLS2dFc20wZE1DUURZckhjVzZPVUJSMTVsMWRIcVNkcWtiR2hSY1VtV0FW?=
 =?utf-8?B?UGk4NXhhQlZuQTZkSWtNV2c5Q2ZaQjdYQklHR0s2eUJqNDZwMTEvbG5XMXgr?=
 =?utf-8?B?RWVsdDYxY3dYOEdvaW1TeU1RMFROUnBwbStmRlpVUHU3Ync5by9BcmQwL25m?=
 =?utf-8?B?aXNhb3Yvd2JJSWdaRDJlQm5pOGgyMFlnZHArQXhZcnI2endkblczNlZFZTAv?=
 =?utf-8?B?UHNaYVpBSGVXUE1oNC80c2hYaUlybFJkUW1rcmNwdDUydGZEWmhsR3NyY3JE?=
 =?utf-8?B?eGlGb2xUNzJCZUo0TFdwTmVZYW8vVHhHUVFybTY5QVBmTEhHS1Nvb28xeDJM?=
 =?utf-8?B?WjRRc1ZhRnNQbDZRU01qNmR0eEY2b0I0aDBXTTJIN2hRbklWbFNsNzNJOTIx?=
 =?utf-8?B?OXFkcDJJZ1U0WHZhVW96UG51cVN0a3VJZnNJVEhwOU1yR3FhMGthMkRtMkFN?=
 =?utf-8?B?Wjl2b01zQTA3Z0JQeWRId3ppRTJNUmFOWG9xTDR5dTFwWGNqejZyK1Y5ajVz?=
 =?utf-8?Q?Gj6Q0pPY98eTj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlpzSFZndUpzUjljc1dzYmJOb2htWkdYenNoVytITHNuMXpSU0x6R2Vjbklk?=
 =?utf-8?B?ZVJQRGVTVTlPc2tOQTJmQ3J5enZIM043TUE4STJibmdqVkVCZks0SUdzaE93?=
 =?utf-8?B?RXBsNmVwZ0JmTUQvbWIzV29sN1V6Yk1NRFpZNWJmM2o4aFF1amluOUxpaEc5?=
 =?utf-8?B?YlltWTQxcmhLWFZkdTJvVFBodjdTRHplaThJTGloWCtrcmVTVjNjOGI1VVVZ?=
 =?utf-8?B?Nk1TQVFPV1I1bWxzVm9aamFNcEpaK2kyRU1SMmxmUnIycGwvVEZCS0xjbjhM?=
 =?utf-8?B?ZU14dlVpeHRKOVNxOW1sb3BLQlNvM1RnaDhiMVo4bEMyd29iRmdhSGpBVis4?=
 =?utf-8?B?RnNjY0kzNnRlU3BpUWprZ3N2ZDN4UXE3dFVYVDhCOE53QUZGQTBhWU0vd2ZO?=
 =?utf-8?B?OXRkS09NSnRpclZUVUhrZ2RPb1hyYkpJTzhsS0tKb09sVDJJWC9CNklPWlJH?=
 =?utf-8?B?dGVIQVdIeVZNRDF1aFoxYlhKaEsxUGRZaTRYNzErSVhVVkJzcGl0dWM4OGtT?=
 =?utf-8?B?dVVFdnZRZmh0MHFtUCthLytXMkc3dEtxaWoyd2xUdGNRVy9xckRPODc3Sjh1?=
 =?utf-8?B?dmRsblNTYXd0R1MrMnJ1dTUxZXB6TFJFS3R1UllrWjl6dTBWa0Fqa1Z2cWJU?=
 =?utf-8?B?c1JrMUN1bnpsMWRWTHB5MG1wdEM5MU93d1Fzdmk2WSt5THFGVEF3dHlvZUh6?=
 =?utf-8?B?aHhqRk9YYTFjQ0ZTSVJiU0g5cjF6c3dvbXpucjJ4c2VKZWtKYitXN0pXZlRv?=
 =?utf-8?B?aENKVXkwSCtWTUQvVnVjZktaVFFONGtHQ1FFcjA5bHduRFlGRSswcGhYaUNx?=
 =?utf-8?B?R0NhOTk1SHY0ekpSaGN2akVWWERjUFJyYnlNVkswNEgvb05TamdwQk9SdFlr?=
 =?utf-8?B?VHliR2d0ODluWlZrSW5pVEMrK2ZNekdqNVpZSGxPQkhHa2dNMklnMjJtQ1g2?=
 =?utf-8?B?VmorN25lcFpmV2w4Y1Ntazd4VEo4c0xCb1U3eDJ1eEFReVA4MjVFcHc1dDEz?=
 =?utf-8?B?Vms5c2FLOFNLNkhjTzVaZEsxUHA1R0V5enRObWVVWXRJUnJLb3M1UW8xTHJm?=
 =?utf-8?B?eDlJMDVGbGhGRTZzWll3YWdoZDZVUUlhWjlPVmpiWjJtRGd2ZXF2WC8vaFBO?=
 =?utf-8?B?cEQ4enRFdkNuVFVXaGlJZTRCbGh2Rkg4VUx1VXFNUnhVQUhwc1ZUazZzK0RI?=
 =?utf-8?B?dVNiN0pwTWk1OFRMb28yODFxdDEvNk5VeDAzcmpnMXpDbjNpa1ZzTmYvNzgy?=
 =?utf-8?B?YTVtYkpVYkUvYUp2eHRUb2xmK01ncGFjK2R6OG1tYnl6SCtMMHk0TWZhejFj?=
 =?utf-8?B?aEpFTC8rMDRXVVRySHNZNXR3VlVld0NrWjR2aGxTKzVlTkZtWE9mVWtTS0tY?=
 =?utf-8?B?TDVjcGgyTkxURGUwczRvZ1RDdi84SjMyaDhWUnBza1hZMFRWN0lqT1UyaVE5?=
 =?utf-8?B?RVp4TFVWbTJJbkJ2ZkFENHZKSTF2aHp4Unp1emNhMy9QMm9MbUNxdXBRUCtz?=
 =?utf-8?B?eDhsdjRsQVBML2NnUndqamFWMDZWaWlkZmZKSVNsRUU5WHRxV1V1S2lQQ0Rp?=
 =?utf-8?B?QkUzdGNFWGNLVTRoSkgzRGZ0MFNmamNMN3NxYWFQYnc3S0FaTm5LWmQ1aXRE?=
 =?utf-8?B?RmNiRGhuVzVQUzVZL1ZWVTBDWmdyV2NCNHpHb0E4eFdwREVmdFRET0xXbklE?=
 =?utf-8?B?M093amt5R3Z5STF2YjQ3TTZFSUFZMHlCM2RnRWFUOFE1VVJaTXRnQXBncUZL?=
 =?utf-8?B?NnhIdWRpcFcyYUZsKzVCeVNUbTkxbHYzMlVJTFQxM0xOWGhrS3BNSDZ3OEds?=
 =?utf-8?B?Mi9VUlBKS2dzbVlhRjlHcHN4cm5Xc0MxeDBqVjN4NDZXYXloUzJCTDRQejEw?=
 =?utf-8?B?cHdwZklodUc3dDVIMlZiczBpSnhWc0ZMNUFMNU96eVJWSGxrTVVuWWVPNEtt?=
 =?utf-8?B?TDk5ZjNHQzhpSFk4bTlPQjdma3M2aDZET1VBbTJ6eDk3K1lHdU16YzVtYm1x?=
 =?utf-8?B?MjRMVHJOYWVuM2RscGJmbG9wL2c3dkt6L1Yyb0VCMmhTTnNCQmFQRHNqYmdk?=
 =?utf-8?B?d0dlV1VnWm9rbVBwZVRNVEl3UFNLckpVUWZzYkp2TGVRbzd6RTRGcTkvNEhM?=
 =?utf-8?B?UzdwcE5QK2U4VjJoSW1NYWM4V0xsNUdYQkdBR1FyWjVlNUZISGNhNmFtR0R1?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fb7CYY/XBHDKHoGMhLnx7yx5tnrtn5CxS+pmuqGATyBulXhGlTv16qkGtJy2yU7w8xy1DnBZd+6PtJ5FbfMHEro76gr99IPdxocNf635zhqgIIKR+sgLlYzMRMmTDGI6mmebSNnOj5Swts8F2xWstJlifwenV2wBjtCUmqpx2iietK7OqwOb1cdqJDSr7a2SOkGax/tq8UmysE++S/xGioJwUa0OZFqmXIAGSRPMKyHrH2cYPmLbdpVcvZHz1wMHKg2UD0oRf8Dsp9n1lQjWgDjHG8om3LuJMNHPlheQcWklWXQMKUke82D38hx2mpZgPwZkYJpPoLBeyMrWUxwT2o9X+n0SXquuSSSrFdkDCqyLdf+J6zk3YdYEM/bdPjaesmZzFv7qr/nlT8XxBMtySVt1D2HDjyeYwEjXmhrT8/lrDsMug36+aYyGz8IZ9rdpU8VCyr1gtpP0MZ7w2Zai3ljUkBJPiDTL5pDy/N0Zx9cqR2a1zbGYieJnQGbhKLscmX/4kh7udwgq6xTgXEoSFgLNETOb4CnJlrWtOHcr1ZsDn/0Bsg26KU4fQjiV4dl3lVlpF+cIb/WDY/JOdD7ElTbKG7S48OY9Lz5B9ImVoBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027b7358-7cd1-439c-8067-08dd4f45c3e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:25:21.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L1NaP6kTrj8IJGSfImDBfxDQEqQeL4jRcpBGFvjjnZIUScjBN3xZxVritBtxAqQJOqe+WmzYP8h7sIFQvtNZXzJ1/hdTzJgHIgLo5/7Ois=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502170100
X-Proofpoint-GUID: nl5RI7pzVJUPEr4n8Kj6L5yJU93nz-tt
X-Proofpoint-ORIG-GUID: nl5RI7pzVJUPEr4n8Kj6L5yJU93nz-tt

On 14/02/2025 03:35, Jon Pan-Doh wrote:
> From: Karolina Stolarek <karolina.stolarek@oracle.com>
> 
> When reporting an AER error, we check its type multiple times
> to determine the log level for each message. Do this check only
> in the top-level function and propagate the result down the call
> chain. Make aer_print_port_info output to match the level of the
> reported error.
> 
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Reviewed-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pci.h      |  2 +-
>   drivers/pci/pcie/aer.c | 43 ++++++++++++++++++++++--------------------
>   drivers/pci/pcie/dpc.c |  2 +-
>   3 files changed, 25 insertions(+), 22 deletions(-)

(...)

> @@ -773,13 +772,13 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	__aer_print_error(dev, &info);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> +	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> +	__aer_print_error(dev, &info, level);
> +	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
>   		aer_error_layer[layer], aer_agent_string[agent]);

It seems that the printk's alignment is wonky after the rebase. 
Checkpatch agrees with me here...

>   
>   	if (aer_severity != AER_CORRECTABLE)
> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> +		aer_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
>   			aer->uncor_severity);
...and here

All the best,
Karolina

