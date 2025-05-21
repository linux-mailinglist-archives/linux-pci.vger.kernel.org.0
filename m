Return-Path: <linux-pci+bounces-28173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2222FABEDBA
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2018949F8
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259C022D4F2;
	Wed, 21 May 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFmEEgyw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IlNtZSJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBC2343B6;
	Wed, 21 May 2025 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747815771; cv=fail; b=RSZ7uIhBW6AWadycZMcOBQ/uir3+u2GV+iHDyEoZeqh7+Uu0AjGQpiul3Uq4Ds7cjmZzWZaf4fS1Q2uVE8zJHWlBpNcE59BTVn5JICeYiw53ReHBHlEQ4PwPVY9v3w9P1VBgLAbrS1intF71SD+bhap4UVTQfCEttKxY1W0xZEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747815771; c=relaxed/simple;
	bh=qZ50V5FE2mptDIJcAJazhgWo59DSAIPRdU9Zk5sEM+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9u8FnoQKyqGFvmp4zco17ZLiDLCze6m0IEpraHqshMC+HbaHNRK6J3rHmbV13+j6Frgy6Slv2Hq2oERg/GTVnisgeCn3ox8dxL5tIRHWMp91Qa5ZrR6G/+dwy18Wec7W2vus3tSXQRJ1UQT7nCWLqqb0qdEiJ1eQ5+PQp2wuZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFmEEgyw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IlNtZSJ+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7fnkO012021;
	Wed, 21 May 2025 08:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Wk54o+1v1foRnaqHLMXaKtCvuG2upHPvIaIIQfRZDwg=; b=
	EFmEEgywGN7KJJY6dpA0ZYCK/TjLtUImr6Cz/gZcN04VLuKedsnpIWPXtpeK1Xdy
	OXQnCJMj/FXQIpXXorl3onLOYTOfYxKzQfReXpptxKHieibbGXa7UZo539mGeJRp
	RNxNrWeaFnoUZmzX8l1rqJPj4V4tbkLIuVu/z+slZIKnj4HQBjuuFkiTZ0c59Rkf
	F9f0SixEYHJrIYcaJodGMEcuibiTy1gbGilYdt54pcksxqsJ0JcnJ7vDnmWB2uvv
	Q3iojaPuko0BpZTc0BbDYq5Sll9CGNjumx5VkC3jpmdQoOwSdy95n2T2MRD+zuAH
	/WKe9pPTUzv2s8RdqhYKQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46saew83bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:22:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7tawO032226;
	Wed, 21 May 2025 08:22:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwem1vfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pII/4mfj8jNq5J6fq1oS9JOe6YKVeMgZu4K4pGFXn00NaBmyDCIEQlFjDUPzyWwBfJsSWmbaSW1NHJnakLua3EgcM364zQf+BnN5NnfoP3djNcOoPvYUFPAdT9MlouZq2+MGywG8+qjQC9Uh9GXhb6mScJw4YKUD9RW/o08zdaNd/qwozX+w+Q7029/d4enObyziOFledAt7Y3YGXgDQMvlmXGvfDjvOi8ZjMWamZwT/wg1sEpMhsP6D/7LL9dQBbK4aNSUWQWhSUcReMw6HzWYXIvAZJHlEheTYgKygQQBNCKJprkSg+CF6325fnUOH/P79e+5Od6jotWyxn6FNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk54o+1v1foRnaqHLMXaKtCvuG2upHPvIaIIQfRZDwg=;
 b=gRQD8QKH20/F27wE340fCk2WgXLLWCBA8eYMANxcmRJoGpcCe4SdsoG/IwrtjR9Deashv6/aaVNLrUko9BFdOpWmGaChQhFJPVY4PBH7KO5GTgEtjp0oK9yKUO2HBFJFBDpZv2hkKTWKPKhbGGol8fCEe/1f5soBXO7AdQUXodteffz6xROsvf7mZkHn3ihfFRLlGjoTbmN1PJR6LmYawo2H8qao0a0i/ecdkOo0pqfp5ILG8Ne1JHLc/b1e0GtGdd03c8rGhTPpeSNpE4L149CWH+WSaukYvUXc/NLmdU0zRhCAI5g2dhOu3PVrDodrG/dFFMzokaIuQDqGgacTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk54o+1v1foRnaqHLMXaKtCvuG2upHPvIaIIQfRZDwg=;
 b=IlNtZSJ+c7rZJPkq7wJBrincmKTza3OAJtVaZEyYvIN2xrBoh6O8laLa1QcxeLmeNP6fUCH1EJ8JUyGWuzDU8qziiMhPOihSByDoxy5vCRWLnPIQetEjFPUBIqgSVpbpledYlWc13bvTgMJAIiD7QmTHPvsl02HDVXrA3JEKWns=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB6567.namprd10.prod.outlook.com (2603:10b6:806:2bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 08:22:16 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 08:22:16 +0000
Message-ID: <2d2fc30c-62bd-4243-b53a-8a477b153cd6@oracle.com>
Date: Wed, 21 May 2025 13:52:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] PCI: Introduce Cray ClusterStor E1000 NVMe slot
 LED driver
To: Tony Hutter <hutter2@llnl.gov>, Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>, mariusz.tkaczyk@linux.intel.com,
        minyard@acm.org
Cc: linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <553813b6-1d44-488c-b41b-4be08e1c1733@llnl.gov>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <553813b6-1d44-488c-b41b-4be08e1c1733@llnl.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b9e66e-f67d-4d14-ce31-08dd984098a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFVseUhHTU9rRFVlS2VBM1JLSHk3VjlhSFR0Y3BrUHhoenNpVEg4ZzF6eDhK?=
 =?utf-8?B?OFQvcnlGYll0SU1ia2ZKbmpNQll0RzgyUUo0ZHFZNlNHUFdoeVlKNWl2eVNF?=
 =?utf-8?B?ZmMxU1B4VEhTcjBGK2F1MUpONU5YVWduWW4vUXdRV3JRaG1GNkZDbGROMVZU?=
 =?utf-8?B?SzRnNGpKZDFwZnFOazREVStYL2ZVNSs4SXJNaVVRbDFKa3FYT2thbjJQa2FO?=
 =?utf-8?B?N3VYSlE0aDdvb2JSK05mNU9obkhDNjVXc0dkWjVLRmVQaFdaRlpJWEhEYnJ4?=
 =?utf-8?B?TElvakVtQ3l3MmxoSXQ5VnViMEw3S0xpM3EyNzJjcXgzdWZnWkk0UFZVeFZO?=
 =?utf-8?B?R2VLQ1JTbkRKYnAva28zblVkZHBqY3c1aWZydW5GMHEvQ0VQOXRGb3J3UzZH?=
 =?utf-8?B?MWx5ZXVwOVp0KzhXYVhzRFl6TWUzTVhtUUVMTFljcWk2aVUvTktCSDFuZVZn?=
 =?utf-8?B?bG00cHJKaHdlem9qOWxnNWFYU3NHMXE5M1BMMHpyb1YyVG9YSWZ3OFV2cUVK?=
 =?utf-8?B?bSszSFZ4Sy9zVE9YUmNiS3pBaVNGQWFnOHE2amlQTmJJMmMrRldIbTVnN3Y5?=
 =?utf-8?B?MXN3b0NMbWFSSWlJcnNuWmx5SGtYVVlMMklVNC9uZzlzdHZOa2swanlkQ1Nj?=
 =?utf-8?B?MWt1V2JEVkxoQWJaK3dQNXF0aGRibnBZUktEYkN2ekRQSHE2ZkRuNjVuRkhZ?=
 =?utf-8?B?TENiTGFoZmJURHVCZEk4TDdadXRzOXdvNnE5TUlLRjNtUmJoWnVzR3VCbEJR?=
 =?utf-8?B?NU5ueDZVZEdYK1RCc1pTYXlBclhZTElPZWF1N01GK1JnSHZyNDVxMmdZMnpM?=
 =?utf-8?B?SFVybG5lQXVlT0U2U0dKc2VUS1B5R1lxVlZ3eFZwMHh0T1VNME1FU0hFUnBi?=
 =?utf-8?B?aWlQbGNUeFRsRkhHRmd2WlRQZ1lscDc1MDU3d0k1Wlhydnd2Mm1EVFZDMFll?=
 =?utf-8?B?M3ZPcjc1Tjl1anEwdVR5bTNZUkdiNWoxakYxZjR4WVlRMkNPWkYvNXp0RXFw?=
 =?utf-8?B?aHZ5YU1zQjcrREluM3JwZW5JbVlHaXNKQzR6QVBlbFVJK04yTTk5ejltS3Mv?=
 =?utf-8?B?SU52ODdEUzJLUnpCcVBsVlRYaTJMY0tlcDNmTmpsT09xNytxTWh4SktGeU5z?=
 =?utf-8?B?d1lCUTJSeW9YVkhVaVB0NldTcUc4K0l1YlhDM25TT1FOb0RyclJQbHc0dEtP?=
 =?utf-8?B?Zk9iQ1Y4RWo1cDBmdGVGZndjYnZmaEgzbHRZaTZ0Y0E4M1BGczRsdWMvazdy?=
 =?utf-8?B?RUFHL0pINE9LZUpLK3Q4RVlpdlh2eTEzaEtWckZYSWlxeEhycWovT2pjazhw?=
 =?utf-8?B?NzcwcHRUajdJWWQrQytZUFF3WVpyakIrUXcwRDZmR1gxOEltakE4R2RFUlpY?=
 =?utf-8?B?SGxWS0l3T0U1OHlWWHhGL3IrbkQwWjJxWjRQNDA4ZU0vRVV1b29pWE9iQ0s1?=
 =?utf-8?B?Rlp6R1NyQ0dobTFLNmFFdGRjbklzYjRZU1gwYy9FQVh6ZEhVZmNlRDNuRHB4?=
 =?utf-8?B?cVNYWGxjczJXamxOMXErbXprNnhjKzg5UHQyN0xYUXoyaWt1U0RrcWVVMXh1?=
 =?utf-8?B?V2hOOFhrdTcvcGdUR2RKWFJ5LzhTdjF1UnBWMnhsZnhjcDRBNUdGVFdoWTAr?=
 =?utf-8?B?dDNQRnBTRkxZaUdZWCtYWWQySDQ2T0lJVzl5UUNUWTlxanlnM0hnYTB0VnpU?=
 =?utf-8?B?MzhNN3g2empweGJvRlFUTUorWWtWOE13c1gzTWdvcm9laHhmZWx0Y0tBSlV3?=
 =?utf-8?B?LzhRQzhBQTF3dVpaMkora2pPaFFRRVl1VnphOHc4MjVpeDZYT2l2V3Q5WC8v?=
 =?utf-8?B?dGVyZWR0M1NuZE05YXRXOFFzMWR1UmFyT3ljZ0w2ZEhHZ3hXRG1TbDBUUnla?=
 =?utf-8?B?TFVVREVlTVV0MEZ4TUYzeURQeVdHY2NDamNqd0Vsbkh4QnVwQUVOZjN1cWs1?=
 =?utf-8?Q?nMvUddCBnYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVNDVktZMjl4QTViNUdiUjhEcWtRcTYzK2UxUWxVckRkMHdkNFh1WTdlQXJ4?=
 =?utf-8?B?enVYRmxhUWtlRXVXY2xFdHpyaldhckRnWWtDVE1odnpIZzBTaDBpd3RDTHQy?=
 =?utf-8?B?Q1dFTTdzWEpaWFVFZmRxVFl4c1k5RElYcHhIRUlZL0p3Q05LcThvQ2o1dXVT?=
 =?utf-8?B?c2dSOVJjUmNlNkJDUmdvME9nTld3cktZZGkxUGtzOCs5SWlkdWR2NjRIOVF5?=
 =?utf-8?B?MFk1eHVCYkZCUG4vNmY0bEkyUkhSNjJRTTJIZ1pYc29GdUUvZHlNcjZUTlNR?=
 =?utf-8?B?dzNjVDMwQUpMc25aaGtkNzN1MytDSjcrdDl5VytBYmVUUDVPUm42VExDODhX?=
 =?utf-8?B?NExUWm8za0g5cEE5MUNUNzJURkIxMTNhVTQ2MlkxMGNYRHgvY2JmbzhsSDlC?=
 =?utf-8?B?c0ZnZHIvUnZISTBnSGdmRGl5dG9iVUIwVXRMMXRUdTExNUhDMVQ0cjRNWnZk?=
 =?utf-8?B?N2tqTmg3SWw3N0dBditwWjlaQkoyT21wR3lzUHpBdWl2REM4RWxBSHEzUDl5?=
 =?utf-8?B?UGZydUZtcGhIOUhMVnROKzhOeS9kYzlTdjhSMjNzcG5FVUVZeEpsSDlMYXVx?=
 =?utf-8?B?b1YwVE5uckZydEVQb2dDblMrWWF0dG1LR2JjVnd4cWg1YUovMllUZFhoZUpu?=
 =?utf-8?B?REJ3QUtRQk94RDkxZGRQUmRxWVRmbmFzUWlOK0xLUGIrVnhTRFlqZ2RBemc0?=
 =?utf-8?B?aUlRVk11S1VCRHdVUHYzKzdnRmRtdGE3UGwzMXpXNTQ0eVNoekF5bFJCelJi?=
 =?utf-8?B?WER0UGJTOUF1WFBBUnVNSHVUMENZUnZBNnhWMkxNTTBFWmw0QWd6dEtHK0Vm?=
 =?utf-8?B?OFVJZWt2RExNOW5zWWJYMkNCVFJwRzFvM3ZVMnRvVUpmTFl2U0pkZ0dWWTlt?=
 =?utf-8?B?Um1jZDVuOXBEd3J5WU5uV05FcVpSbUZRUFZXcmsydmpIVVRQYjhBL1FUVEtq?=
 =?utf-8?B?b0Z6emtsUStlSTR1QUpqUS8zVDRWLzFqemZEdmVxSGNlMzVLa3U3V1hGUndr?=
 =?utf-8?B?WldVdk1BOTVKSE5vczdpVmI5TXIyc29BQkI0YjJIZTg0V2Yxc0xRMVhuVXNJ?=
 =?utf-8?B?VTZaQjhDbFQxeVBUVzFjUkIybERIR2RyR2JlRFZpeWVRUlNRUTg3U1BFMUlT?=
 =?utf-8?B?QmlOcDRaazNiV2VNYmtFUXVCeGYyYnZKODFtZVRwYUhyaHJPdVFONG9xZGpn?=
 =?utf-8?B?ZTM0WHdPUkZGWmRHQUhzc0ZoWVJmSUh2UDh0SkZvcndNbGxlV1p2YXFqY3pC?=
 =?utf-8?B?NHJwVlRUenZacEpCMU9jNkZia3Z6TXdjL1ZKNzdSdjBOOVplRHNYM002bXRV?=
 =?utf-8?B?QVVMWjZ0SlhGZHRteE01WEk0M09KSUVMRkxFWVFzZmlVUkk3bUE4dkh6OFhV?=
 =?utf-8?B?Y3NvRlNMYU9EWHM5eXcvdnB3T3BLRzM3czZZVk40UHRHVjZuNVJWZDFuWUZX?=
 =?utf-8?B?ZDFicVRKNmtZVGZvM0ozUElCaWFYa0tpZHVOVzRMMWlRVTRHNXF2VkFwdWoy?=
 =?utf-8?B?VEcrMm5MVi9raFNyanRKM0RRekp1OVBmTjVIaXkzdVNhc0NUZFlsdnd4MEEy?=
 =?utf-8?B?N0VYZktJeDFhK21iNmtTRkV0bFdYVjVYWnFRT3FDRkRxaW84Y2pHbjlwbktm?=
 =?utf-8?B?UCtNU1pBZVozQ2pXMldVOHhaT0srUTdTNU5GU0VrNVBDdWpQOTBCS29xNXRt?=
 =?utf-8?B?ZXllaXM0TlpFcWMxc0dxQVM1Tk40TElRT2o3eHA1REppbzdDUlVSM2h3Uk1S?=
 =?utf-8?B?VndXamFvaElTeEVTZ3pBTHFONWNXT1lML2x6Qk9nS25zcUlyRGdmL1h6TE9W?=
 =?utf-8?B?NXdETEIwTFZIeEFESVpaMkRsa0pVQldrdEpycmR2OExPMDhGUGFFYVJSMkZw?=
 =?utf-8?B?Smg5QTh1OFIrendyczRvWGw5WEdNdlhUOUdBRGd3bFdXQmZ3VnpsVDNLbmNV?=
 =?utf-8?B?SlBHS0xNUE90aFJRK1Juem8xMEJGRFIvOWtYMWlWRGc4bU5tT24zbmJ5Rmh0?=
 =?utf-8?B?bi9GdW1QUzI5eXJ3amJ2SmgrNUh4V1lmQ1ZiRnJBNy90WkE2R21keVI1R0tJ?=
 =?utf-8?B?M3hnM002OTdBVkpTcVQ5amJlU1o5dFBybTdDSXNZN2hpYmtWRHYzVURzNEla?=
 =?utf-8?B?cEYxMm1lYkthOGkyclFTVDRkakFQdU1hNlNKWWl5Qmd0SmdMMkNENzFKQW1G?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BVzM8Sguhdz+HiuX80ebanVwiqtuxkjwO7avGwHyLAFObJuDaADgsrK6APmflaHprZJtW8hGiw/kfudmle6ujtF5MAmA6xmQoibA76iDrZwyEkO2mOxkFoL1kQp0Tky7dL3MZMbgvld/14O4lu+EMFhCj9H7/ZAqTO3H5gBAxi+32AmDJ9nRteTAjUqWKcUJ2OeGYEf7cSqLEwq6mAX/HcZtPI3GXRA6fNIgDeJVHvF+6xbKu7/rfn3V9bUmG58XG0PGczvaBfuaoZb0GJmM4hMM4nX9pIRtf7cSRblPnweyWRAI2TgOVAcBc2TuiAxCDdYEFgQVC4s3ukv/k1pzMLpEdqzaP2h+dpxhwr6/d0j6CkNjD4Lw9qb/QAmJWyoCZHj7oh144G+NN6+WL3O8c8s6ltX8SDGWrB8D7ZHFOAAyfPuH6oVvKDWQXo0TF9LMGu3WYjvXIib2rcHNcetJo5M6NuwgLCR1bKuyWD7dYo4n8D1LJLsGt80/rAqjR6MJoPTTzvv8158c4gCLT+WygG68yUFW10TX1ia+HJp6UjYYMjdltw+CKk5kFCuvsFSEDZj4ZY24QE1ClaX7s8hD1njsSw6X3rQMkt5HZvCOOVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b9e66e-f67d-4d14-ce31-08dd984098a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:22:16.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ob1WSviQvzFsASGg4PiP326nRsbgAyx3H9HcH97mQURDy8kiGgVInQNzaiZvpyAzK1Jn+v27KszqRMYp2vgEVycFjx9+HIEntjZc07wpR70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210081
X-Proofpoint-GUID: Yl2DAUoIXbhNCOnHP0LbA0pjLtWJYiCC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4MSBTYWx0ZWRfX4cnZjHFpGHwM BwqoJ7I1UettdgSefpckXXFVs+89fVe/lejXi1tyZHio+MZfUn7nmLwJFO8YqBQzQWZ3Gk5uL57 O6UoG0N2wdAvx/xX7vlPn5HBn03zdXhfyiEtCo6z344IU22N8+Veh2ifTh343VMF2gu+tRWt5Ka
 MB+Iha8rIQcoEuNiYaLyVFxc8oV7P+cj4ZWZZ7pvU0Kscb8DS5F+yE2FcT1BFpRJpW2AAWPUuNc C19uj84ZLyE2TuXjhZDzM9NA/JXmLON79LROMUOEma6LWBMgux6ULOjUKeAVpcHxJpO4LcVsUWN j9HjyUirQvweA2N0pLBkr3lS9Wt10JDqLYlou0sqbVPEPvve7MzzVwHvYhbfukUcqK2DOO1+NBT
 f4g+4sxfIWsm1je7PPxDeUKDCQBifmtpFmuo9AaZsECrN7wXLTyq+M03U/kMKEq18be7AD22
X-Proofpoint-ORIG-GUID: Yl2DAUoIXbhNCOnHP0LbA0pjLtWJYiCC
X-Authority-Analysis: v=2.4 cv=V7F90fni c=1 sm=1 tr=0 ts=682d8d3c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=xfFmMR3ya0G0WbDnzncA:9 a=QEXdDO2ut3YA:10


> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 123c4c7c2ab5..75c77cec0b21 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
>   
>   	  When in doubt, say Y.
>   
> +config HOTPLUG_PCI_PCIE_CRAY_E1000
> +	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
> +	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
> +	help
> +	  Say Y here if you have a Cray ClusterStor E1000 and want to control
> +	  your NVMe slot LEDs.  Without this driver is it not possible

typo is it ->  it is

> +	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
> +
> +	  When in doubt, say N.
> +
>   endif # HOTPLUG_PCI
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 40aaf31fe338..82a1f0592d0a 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
>   				pciehp_ctrl.o	\
>   				pciehp_pci.o	\
>   				pciehp_hpc.o
> +ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +pciehp-objs		+=	pciehp_craye1k.o
> +endif
>   
>   shpchp-objs		:=	shpchp_core.o	\
>   				shpchp_ctrl.o	\
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 273dd8c66f4e..ea68ae041547 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -198,6 +198,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
>   
>   int pciehp_slot_reset(struct pcie_device *dev);
>   
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
> +int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
> +bool is_craye1k_slot(struct controller *ctrl);
> +int craye1k_init(void);
> +#endif
> +
>   static inline const char *slot_name(struct controller *ctrl)
>   {
>   	return hotplug_slot_name(&ctrl->hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ff458e692fed..9a7a7b320810 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
>   		ops->get_attention_status = pciehp_get_raw_indicator_status;
>   		ops->set_attention_status = pciehp_set_raw_indicator_status;
>   	}
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +	if (is_craye1k_slot(ctrl)) {
> +		/* slots 1-24 on Cray E1000s are controlled differently */
> +		ops->get_attention_status = craye1k_get_attention_status;
> +		ops->set_attention_status = craye1k_set_attention_status;
> +	}
> +#endif
>   
>   	/* register this slot with the hotplug pci core */
>   	ctrl->hotplug_slot.ops = ops;
> @@ -404,6 +411,11 @@ int __init pcie_hp_init(void)
>   	pr_debug("pcie_port_service_register = %d\n", retval);
>   	if (retval)
>   		pr_debug("Failure to register service\n");
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +	retval = craye1k_init();
> +	if (retval)
> +		pr_debug("Failure to register Cray E1000 extensions");
> +#endif
>   
>   	return retval;
>   }
> diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
> new file mode 100644
> index 000000000000..844b36882316
> --- /dev/null
> +++ b/drivers/pci/hotplug/pciehp_craye1k.c
> @@ -0,0 +1,659 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022-2024 Lawrence Livermore National Security, LLC
> + */
> +/*
> + * Cray ClusterStor E1000 hotplug slot LED driver extensions
> + *
> + * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
> + * It provides hotplug attention status callbacks for the 24 NVMe slots on
> + * the E1000.  This allows users to access the E1000's locate and fault
> + * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
> + * This driver uses IPMI to communicate with the E1000 controller to toggle
> + * the LEDs.
> + *
> + * This driver is based off of ibmpex.c
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/dmi.h>
> +#include <linux/ipmi.h>
> +#include <linux/ipmi_smi.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +#include <linux/random.h>
> +#include "pciehp.h"
> +
> +/* Cray E1000 commands */
> +#define CRAYE1K_CMD_NETFN       0x3c
> +#define CRAYE1K_CMD_PRIMARY     0x33
> +#define CRAYE1K_CMD_FAULT_LED   0x39
> +#define CRAYE1K_CMD_LOCATE_LED  0x22
> +
> +/* Subcommands */
> +#define CRAYE1K_GET_LED		0x0
> +#define CRAYE1K_SET_LED		0x1
> +#define CRAYE1K_SET_PRIMARY		0x1

both defined as 0x1
This is likely intentional because they belong to different context, it 
is ok.
what about prefix CRAYE1K_SUBCMD_ for subcommands?

> +
> +/*
> + * Milliseconds to wait after get/set LED command.  200ms value found though
> + * experimentation
> + */
> +#define	CRAYE1K_POST_CMD_WAIT_MS	200
> +
> +struct craye1k {
> +	struct device *dev;   /* BMC device */
> +	struct mutex lock;
> +	struct completion read_complete;
> +	struct ipmi_addr address;
> +	struct ipmi_user *user;
> +	int iface;
> +
> +	long tx_msg_id;
> +	struct kernel_ipmi_msg tx_msg;
> +	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
> +	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
> +	unsigned long rx_msg_len;
> +	unsigned char rx_result;	/* IPMI completion code */
> +
> +	/* Parent dir for all our debugfs entries */
> +	struct dentry *parent;
> +
> +	/* debugfs stats */
> +	u64 check_primary;
> +	u64 check_primary_failed;
> +	u64 was_already_primary;
> +	u64 was_not_already_primary;
> +	u64 set_primary;
> +	u64 set_initial_primary_failed;
> +	u64 set_primary_failed;
> +	u64 set_led_locate_failed;
> +	u64 set_led_fault_failed;
> +	u64 set_led_readback_failed;
> +	u64 set_led_failed;
> +	u64 get_led_failed;
> +	u64 completion_timeout;
> +	u64 wrong_msgid;
> +	u64 request_failed;
> +
> +	/* debugfs configuration options */
> +
> +	/* Print info on spurious IPMI messages */
> +	bool print_errors;
> +
> +	/* Retries for kernel IPMI layer */
> +	u32 ipmi_retries;
> +
> +	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
> +	u32 ipmi_timeout_ms;
> +
> +	/* Timeout in ms to wait for E1000 message completion */
> +	u32 completion_timeout_ms;
> +};
> +
> +/*
> + * Make our craye1k a global so get/set_attention_status() can access it.
> + * This is safe since there's only one node controller on the board, and so it's
> + * impossible to instantiate more than one craye1k.
> + */
> +static struct craye1k *craye1k_global;
> +
> +/* Return parent dir dentry */
> +static struct dentry *
> +craye1k_debugfs_init(struct craye1k *craye1k)
> +{
> +	umode_t mode = 0644;
> +	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
> +

if (!parent) is correct! but debugfs_create_dir() can return ERR_PTR
what about check for IS_ERR(parent) to make fully robust?

> +	if (!parent)
> +		return NULL;
> +
> +	debugfs_create_x64("check_primary", mode, parent,
> +			   &craye1k->check_primary);
> +	debugfs_create_x64("check_primary_failed", mode, parent,
> +			   &craye1k->check_primary_failed);
> +	debugfs_create_x64("was_already_primary", mode, parent,
> +			   &craye1k->was_already_primary);
> +	debugfs_create_x64("was_not_already_primary", mode, parent,
> +			   &craye1k->was_not_already_primary);
> +	debugfs_create_x64("set_primary", mode, parent,
> +			   &craye1k->set_primary);
> +	debugfs_create_x64("set_initial_primary_failed", mode, parent,
> +			   &craye1k->set_initial_primary_failed);
> +	debugfs_create_x64("set_primary_failed", mode, parent,
> +			   &craye1k->set_primary_failed);
> +	debugfs_create_x64("set_led_locate_failed", mode, parent,
> +			   &craye1k->set_led_locate_failed);
> +	debugfs_create_x64("set_led_fault_failed", mode, parent,
> +			   &craye1k->set_led_fault_failed);
> +	debugfs_create_x64("set_led_readback_failed", mode, parent,
> +			   &craye1k->set_led_readback_failed);
> +	debugfs_create_x64("set_led_failed", mode, parent,
> +			   &craye1k->set_led_failed);
> +	debugfs_create_x64("get_led_failed", mode, parent,
> +			   &craye1k->get_led_failed);
> +	debugfs_create_x64("completion_timeout", mode, parent,
> +			   &craye1k->completion_timeout);
> +	debugfs_create_x64("wrong_msgid", mode, parent,
> +			   &craye1k->wrong_msgid);
> +	debugfs_create_x64("request_failed", mode, parent,
> +			   &craye1k->request_failed);
> +
> +	debugfs_create_x32("ipmi_retries", mode, parent,
> +			   &craye1k->ipmi_retries);
> +	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
> +			   &craye1k->ipmi_timeout_ms);
> +	debugfs_create_x32("completion_timeout_ms", mode, parent,
> +			   &craye1k->completion_timeout_ms);
> +	debugfs_create_bool("print_errors", mode, parent,
> +			    &craye1k->print_errors);
> +
> +	return parent;
> +}
[clip]
> +static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
> +					  u8 *status, bool set_primary)
> +{
> +	unsigned char slot;
> +	int locate, fault;
> +	struct craye1k *craye1k;
> +
> +	craye1k = craye1k_global;
> +	slot = PSN(to_ctrl(hotplug_slot));
> +
> +	if (set_primary) {
> +		if (craye1k_set_primary(craye1k) != 0) {
> +			craye1k->get_led_failed++;
> +			return -EIO;
> +		}
> +	}
> +

-EIO when craye1k_set_primary() fails,but -EINVAL when LED reads fail
is it not both hardware I/O failures case ?

> +	locate = craye1k_get_slot_led(craye1k, slot, true);
> +	if (locate == -1) {
> +		craye1k->get_led_failed++;
> +		return -EINVAL;
> +	}
> +	msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +	fault = craye1k_get_slot_led(craye1k, slot, false);
> +	if (fault == -1) {
> +		craye1k->get_led_failed++;
> +		return -EINVAL;
> +	}
> +	msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +	*status = locate << 1 | fault;
> +
> +	return 0;
> +}


Thanks,
Alok

