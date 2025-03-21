Return-Path: <linux-pci+bounces-24350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF50A6BBED
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709E31890EE0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA113D69;
	Fri, 21 Mar 2025 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1hd6xQ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VCJ/b+Rz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71BB663
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564814; cv=fail; b=kogR6Mn8bZcsbi+XObvi2ii8CdY7b+oBjAazhYdDFiGhuFjtXU8PfWaUbpSwuefChx0ENrV7zzPcP1U8eSfmmtawEvjbvDezoVGrGiRQb/lJMI0XtyzHPko7xMLeTpcWBaJJwtx1+UrDEh8KUu6jf8FWWLrCDW10UeUxDQuDRf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564814; c=relaxed/simple;
	bh=uOgR8TdG97BigfJ1/hPqaagCcGHlT7Hxuun2ehX5ZUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eV7I3wMbYSt2E4pi/9HOtMJH+Hi5nLVLO+1PmXfhPelJgGPj5Wd3xl31TDuasbjFVcZG1yz/33t/uKOzIcIgOePikaA0HFt7ETFSgtAwIVB8qsgwLyqhBdklVHa/T2CWY11NxbI6e3QeSt4V2YN+nhFb4qFWXna5tJhfAqMVqv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1hd6xQ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VCJ/b+Rz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LDfvFK011390;
	Fri, 21 Mar 2025 13:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eQGQGJp0JAzepTT7ftDo83IcRDRCPw7RhSHUpmhZI7s=; b=
	I1hd6xQ+6qrZn8cCAY54o7HDtd8542U080hMokQaDNk+qnWMOGw0afrDkAsSs/Za
	1bKHi1T45Y0gwTeoOqxwo3dlhqy29WwKJHV8b51zkV6evIDZuR+uAJ3s9nFLWhRt
	EljalWGfamLLtm/z5KGG3IAaPpQGRoGxmtNQ4dEMDjh6c5nieep/6JiogRLyN9Zd
	v7b5t38eJo7BxAhUiBFEJ3nWqkfExzNPlP1+ZMD0KYYLAyqDOXi7XUEwzNrlUH3x
	id6tb5nPuTVThjcdnOJ1vqq0mUNQotT43B7R0a4gEFXYUhGlldXRp/oq/SNScpL9
	PqAJmOFkjNzJhEGJTo8wgw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka8ray-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:46:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCHHPU009868;
	Fri, 21 Mar 2025 13:46:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm443sg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qul61zY2+qQsQ5LkzTfMA+zvAjzJ+Aqg1kvg8iWzny6M7m6RLfE353CHG6EuCe7Qpc42y74cUE3BghNEr3DwrBOb7e3ESZhcR+Ah0clzuobYLdDtosyrcWZVQe90Q2KLm6/uSb7TDxhpdxzotUmRsLLYY6jFgZwXyKZVyfBpxY5Xiq+0lab2FPKdtz6ufDBcW492LWAD9xKNG8BQLqWERis4bKv6nGY61/WPRrmHoBlsgagQ3D3euAHWNO7ga3Fa8h59kVZDiiZyq1nvcgpJfKIoVu7pYjLvFp7NNzjXY4E90BpQfPaqLbJQmOea/pk6kpzYORNvhzjlGz/n6dFYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQGQGJp0JAzepTT7ftDo83IcRDRCPw7RhSHUpmhZI7s=;
 b=Kp2gsKAPdA+lGOFQEw2yxcOG+fg13L/5vbfv1+Chk7O0I8dE5nHYx9eRmx8oXOgF1IPB5o2FgOilW3xbjjYR10o7lmvozefbhpbcVu81A//RgNBTuQlziQk8Zl462ALoFvVstXLOQvcT+rpLdxOj4xTh/YwCLS78iUySVLp83IybN6kIi52ztTcUC5FZVIALVgvdk6pQWqDlbBkg14tRjwep/gVCjgYLSSIOZHKexu4zY8vSmUVJHGItKi6FkGiduZAMQxsK/TF5nf8GwW+TIprpjwjUe2NeKwhqHNi8WFTxwBCxO6NEsE0/BWNWRQZxxnJzVzUPJfflOygZaMVK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQGQGJp0JAzepTT7ftDo83IcRDRCPw7RhSHUpmhZI7s=;
 b=VCJ/b+RzWkxmMBPG7OWpdKeI/bNMr+oE6gI5Aw/2zoekHiYg+pxToMttBfyqINJ0Xm67/qWiADp6R3qi7Yyxk1ROzcBRAcwwz26i9hVdOifZzk1rap1TbQQpx1TAJWi5dM0LvUXjLgv/7kCBZ8JOFSybNOEuYm8OgDFehjoz5RI=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CH0PR10MB7440.namprd10.prod.outlook.com (2603:10b6:610:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 13:46:30 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Fri, 21 Mar 2025
 13:46:30 +0000
Message-ID: <e028eed2-440d-4094-bbf4-016ae5c0acf0@oracle.com>
Date: Fri, 21 Mar 2025 14:46:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
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
 <20250321015806.954866-7-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250321015806.954866-7-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CH0PR10MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc5d5f5-7fb3-42ff-5716-08dd687ec8a4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cnYxOCtLWjVMazVKZWVJOHVGSnVoL0hkYnBqS1ZWS1JmZEI5RHFxNDBySTdu?=
 =?utf-8?B?VGZSbi82Y25nM2E4UVBlZDJ0d1MrbXpIT2UvQm1tYnRZNWZFM2hWVGpVN3VV?=
 =?utf-8?B?d0pYdzdKWEMwbmd2NTltM2tHSEt1b2VwcWhvZkZyUno0bXhWL1FoZjk2enk2?=
 =?utf-8?B?NjExU0t4enFDTmNiMXZ0Ym92MGN5T3l6YkRMdDc3aDdzVnl5VElqSFk1bzJv?=
 =?utf-8?B?OW5nMUlzV2FMYWM3TGEzT3hNWEROODk2VWlINGZVWWx3ajNNbjhpZnBnWGxS?=
 =?utf-8?B?ZmdMNytxbFZMVm1SNDhnLzk4UzYyV3RrejhvUDRLWStlS1E1VUNaR05QUVhM?=
 =?utf-8?B?dWZFenVCSU5mRUc1NW0yWnRxU0tHbVR1dWptRW9qU25Tem5pRmpkdjlnMnJz?=
 =?utf-8?B?TkhZWGYvcXVPZFpBbDJaOTBQWTdVWFZoUHpCSjRkN2hOOFlwbEM2MW1hbDBh?=
 =?utf-8?B?QVlzcHEveGp0dDZ6TjFmYXJJeUREd1NDMFIyY0pYakYyNjJQeTN4WVZ6UHNG?=
 =?utf-8?B?dGw3bXVIWi9Pci81OG5JT0NFNk1vVTV0TGNzR1hWakI2OEVXRkt0ZVJxdmxI?=
 =?utf-8?B?dWZvd0paVlRkNVEzNFRsVmd1SXNFTmlwRks3UzA5SGxBUGJjcU11VGpoZmVJ?=
 =?utf-8?B?TUo0eGZsOXJ0SlRTY0FmeHhETExYMWxRVzFvTitkY1d1MTBIdXV2eU9NUlNN?=
 =?utf-8?B?Y0NGenBXL3p0T1NKTW1NR0I5TkZ5RFRTTTZmblFkY1c1djZXVXFqYmhoSDVW?=
 =?utf-8?B?Y1ZENTNsVGJybHdGSThsV09tNm1QMWxNOU5wWjBOOGFhcmxtUjR0NGMzZ1lr?=
 =?utf-8?B?SURKNTd5Vi8vSEVtOTdtd0NRT2pnSjI0WkdwbVB4eGVJZGZ3dlJ1STYzS1JY?=
 =?utf-8?B?bnFLQkdBZS96WndySndIczFzbkJsdXBabklsR1RYTXBsRUxtUUwrWGR3WWJr?=
 =?utf-8?B?ZUExOWNDM1BnUGp5SzgwWWFpclU4WmQ2QndyeEdzcUNpRlVvTmZlNW9paldw?=
 =?utf-8?B?ZFJvQW5mc2YzZUJGKzJLRFBySE5mR1J1aWU0bmhJR1ZrZTFORFFxcFVncytR?=
 =?utf-8?B?RmIwYUcwN08wamNvYWtodW0veWdWVndCbkkxWnF6Q1FseXEvaW9nM21KVC9o?=
 =?utf-8?B?YWZ5MzJyelBkQU8xL0ZOblF0dUh0ckhrcEswQS9NbjdQR1hGdGVYUGlrUEcv?=
 =?utf-8?B?dFRESm9WWWNaU01TdkY3cm01R29iTVJyL3JSYTJWMGtabmRDOTFkaHNzaFRV?=
 =?utf-8?B?S3VSVHZVWkRiSVgxbUNLUTBkYWpYUnpMM0FGSktWaWRYR1FmTGNQdmRtbmtK?=
 =?utf-8?B?U3p3aXRnRDR1ODRkSWx5cndhTkNYZkFKVytzdDRlMjhKMXVJcWdtdlhWTmNV?=
 =?utf-8?B?TDh6RmhXRUJINmYwUXJ2NnE3a3UzWm50Nml4YWpXMnhENkpWUi9QcGtub1ky?=
 =?utf-8?B?a3R2emZkb2lYU3J2bDhzd3MwTUJaM2JWUG10cmE3TFVaL3JUN3E4SHROaEhu?=
 =?utf-8?B?b0ZKendNMWY1V1NTT2tFMmcvbVFpNSt0cjRpd1F5VFl6UWdjeElmZjlpT1Nq?=
 =?utf-8?B?Z1ozN2lISkFMWW9kSlNlbHMxQU00a1JiSFl5cXRraVBncW5RZ0tWQkJoQXlD?=
 =?utf-8?B?WnF4YWNvVDBnQ3hlTEFDSncwQU9oSmM5TzBXVk0zQTZFdlFFcTZhdkFlQUJs?=
 =?utf-8?B?VytpdHVrWXBoR2ZYWkM4MGNEMlUxU3hxalZCTThXdWJWYTdHTkV0bFFBbmtL?=
 =?utf-8?B?b0VsQUFZSTgweUx3T1R3SnVCUHpaVWp5QjVxM0FkVnMrclF2V1RDY3VzZHBk?=
 =?utf-8?B?RlFWejU5dFYrekxZTHJZMXJRbHFOOVpMMWE3REN5QmN3bnBwQ0luajFwaXYr?=
 =?utf-8?Q?rZEsE3UIMCnMq?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZkFMZjF0ZXV4cGp3YjJqODBFM0d1ZCtDSE9TbU9HZHg2V0FZdW5GYnlYWnJZ?=
 =?utf-8?B?YUlDM0JCUFFnQm1hQkIvOGl5WmpFSjY2dlk5c3lRQW1IQWtBYWtGZ3o3ZU5h?=
 =?utf-8?B?Q3Nacm9LOTg0dzBJN2VvaW4wL1dheENoWHdKbm1nTmUwZUhEVm1CaGhnMmRa?=
 =?utf-8?B?WTZDL3J1UTRQY21adEtqK2hudi9rZ0ZQZ1l3a1oyRDBvWkk0Z0h1Y3QvaW1N?=
 =?utf-8?B?UVQveExaMzRqaU9HUjZUejg0OC9wTCtDVTVCUm9sNksxSWJJQU53Mmk4OG5H?=
 =?utf-8?B?UURBVWpIQk81QTZmdG5zOWtiUVZMSzFPbDQyd2YxUlM3ellrNUNIb2JVZ2NG?=
 =?utf-8?B?UlVWK2tDUklMWWZzRkVzUjQrRW1maUk4TktWa2c4d0l1aDFxR3FWaGdyNEV1?=
 =?utf-8?B?WFhjMUhneDlVVUpnNkpma2RjWDA4LzJydWRNaDd4VDdobnE2TEc0WDg0YVVh?=
 =?utf-8?B?WEprWEJoR2lERHdhTVdrbWx5RnVPRzlMNlpJV0FPTjNRWUhTTEtUelNwOGYr?=
 =?utf-8?B?NldTYVd1NTZzZkVNZHJ1cXpHN1hySFJDUzgzYlZzVHUrcDZubG91T0pjZVJF?=
 =?utf-8?B?UHJ5NGVyemllUzVCUjVNQ1FFdTBDbUJkTmFDQmcwd0p5Z0Q0OWVKeXpUcFJQ?=
 =?utf-8?B?R0JYaE8wSHV2QUxrS0dqVm5lc0xIVUlmTVY4OHJHT2pkSXV2WEttY25yMjlF?=
 =?utf-8?B?bVBoQ2wyRkpyYnRQWkNlS3l4KzZwWGIzaHNZWFhqalRreDI4ZFUwU05lVmxi?=
 =?utf-8?B?dDN1TlhhbG1jMHdJOFVoYzFLbEF0ZGt0cExGem1aSFVMenhLcnJNWFJaSTFU?=
 =?utf-8?B?Q1J1eG04Smx3SGdVaUd4S3pOY2VtQkNzOXZUUHZqRk5zSFNKMHdPd3E3Uit0?=
 =?utf-8?B?MkdIVldMUXIvNjBjQW9DYnNld1c4bzVyOE1yYzlkcFVpOWVkSk1SWUNiUU5s?=
 =?utf-8?B?Wjd2Zk1KTWRwbUxvQlVmV1pKQzE4TFFQY0VDUms5SXc3TkMwQzZ3NzRuY1JJ?=
 =?utf-8?B?amhDbWQzZnNLdDdZdUhueUJQa0J4dDlPMHpGbVMwa1NpcVZpcVdCRzJ6cWFV?=
 =?utf-8?B?anUzU3BxSGJEMXZiVFFMVEtLZERxOVc3MnZNZmN4V2Npa0RaeWMvQlNyK1k1?=
 =?utf-8?B?TEVKNEc2RENtazJHNVBQUWtTNjhSbFQzejc2NGlBWml4TkZWZ3o4cDRZbG9y?=
 =?utf-8?B?Mm9zbzRUS25FWEZGMXlobTRsV1NONTZZbFV5YncvL3liY3E4YTBSZzZmZDdm?=
 =?utf-8?B?enYrUUtJVkNYc3BuK2tZTjFHa3F5d01xcVNrQVVSTnM3RUVPV0Y4NFBFRWZM?=
 =?utf-8?B?UkdTTmpaMzcrTFRqcHJIblMwRnZoVGF4d0VxS2VKRmRlV0dpSmZEOHVzZnpi?=
 =?utf-8?B?U0R3OUswOTFrYTNPQi9hVUtwWjJoUnhaS29YVkt2Y2hqZ0JSaVBqZXprZnJS?=
 =?utf-8?B?WFZjaTdNVXRabnpVSWpyMzZ3T0V6VVBGTm5xYTRyK2lQdGtIQWR1Y0VnbUN4?=
 =?utf-8?B?R0loVUpUalY2a2ttcnNFNGNBRTY3RFN1VW9kbFkrc3k4WGphcThjcGIzYktK?=
 =?utf-8?B?ay9qS3dNcWxQZ3lINHQwZkRranRnUzlXT3h4K3pDQ0RGTnRtN3NGS3g3c3Vm?=
 =?utf-8?B?NE5JVVJnYWV2QWlIcWNGODlSU0p2UzRoSmlrV0ppSmNwSWE0TE55L0dwdFI2?=
 =?utf-8?B?VWdsVEJ5T2lmdG82dXlKa3VkQjZkKzVBNEZibHBNZjZRNWQ2dDFIczJmU0x2?=
 =?utf-8?B?TTFpVW9qUTJTODFuVHRQbTBodkR0TW1XcFlNVmNMM2lCUUVnUHBFOWN1UlFE?=
 =?utf-8?B?U0t2UU54TlhzUzRFU1JPaVRoUGMxQXJOckMrYlllbmUzNjNTbEtXOUs5Q3ZU?=
 =?utf-8?B?K3FUWFFab3plOVhKSXgyb2M5WG5ETzZ6ZnJCbG9lN3JXS2g2ek0rTUl3V3Az?=
 =?utf-8?B?RHp5RnNDbUZQaWVGSzBqWDJCc2VmK0FFQ3hOMTdYelNyUC9mZGY0SjdvYnY5?=
 =?utf-8?B?RmFUWGRjdkl0N1FGM2hXMjgyT3YrSmlZWGpHUDlMdmI1MmtHVUhBZnhjZWVp?=
 =?utf-8?B?aGxRZ3p5UnJjaVB0NlJlN1piUjBJVG54bUY0LzZNemw1V0ljL0F6eXpJRFhw?=
 =?utf-8?B?Qk12SUFYVXRCanBEbkFLOUM3aDEwK1psN0hNeUo3ZVFOY0Y1anhCSlRWTWVM?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YpN91tUM696VmZlfv5+wWg2JNuIIrxZY5qCJgNA/JvJq3bWiBixCDVUrDCWWY1IleArEs4pFcFIM2XapwIpiZ9YqQ7iMAHIlUipny000Y6QgvMyj74Vf58zOEsEdTxA0S9MkRn2R5R8o47DBnc+Lnmn9RnsGstYz+pj3hcOZE/gu0wDPnCd2yL5hxYHnt6QOTzla7cVSidrUFOBKmWODuNOhrAitZu6K7k8DwkK+eX7iKvqQhw3fNE2NKPEVrWJ56qukVG2aTvK1oj4GpC1wWo/QTajl+vd0FFxgFVLN33Y1NPASWd489Pxgxw6M6QIUhyXvfCOsr5l1h5aA7DhZutkYCWPyYl1WiORy7NSiOzfK+6gjS9qum05Igv7JwB9jJ8ELvqJBD+ZnZ+EwXYRnpO06jlzEvMzdOKGYZEbRV63w1qfESj98OB66r0Zq03gQ/6go6ElXE6afoZN0P5eeo4lpZzr/Qhhjw8yuy4e2Gx08oigjVUMMlKIPHtRmYMR6kgCQcXoeoywQfd1Y9r5jaa3aAx5AVClf59UEuG2vGGmu1a4kVEyr6b9nhB8w4EJ2rYUK7HtFLfVynLct3+P5soZXJQ29Y61R5c7AYF87ggs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc5d5f5-7fb3-42ff-5716-08dd687ec8a4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:46:30.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHNkxITMnYhrfr6jc5dnoSjMlJePi3z/vEwhJlHjrtepb+H89Cxh14fXD3JhXk8eXeDJaFSIjulpho2QD8OGOG7axncLrwwa6wpRNCqdUcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210101
X-Proofpoint-GUID: iH3ZgYCk_Fzoj37dr18BcoHMpUUlbZvY
X-Proofpoint-ORIG-GUID: iH3ZgYCk_Fzoj37dr18BcoHMpUUlbZvY

On 21/03/2025 02:58, Jon Pan-Doh wrote:
 >
>   
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> -		     const char *level)
> +		     const char *level, bool ratelimited)

Ideally, we would like to be able to extract the "ratelimited" flag from 
the aer_err_info struct, with no need for extra parameters in this function.

>   static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info *info)
>   {
>   	u8 bus = info->id >> 8;
>   	u8 devfn = info->id & 0xff;
> +	struct pci_dev *dev;
> +	bool ratelimited = false;
> +	int i;
>   
> -	pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +	/* extract endpoint device ratelimit */
> +	for (i = 0; i < info->error_dev_num; i++) {
> +		dev = info->dev[i];
> +		if (info->id == pci_dev_id(dev)) {
> +			ratelimited = info->ratelimited[i];
> +			break;
> +		}
> +	}

(please correct me if I'm misreading the patch)

It looks like we ratelimit the Root Port logs based on the source device 
that generated the message, and the actual errors in 
aer_process_err_devices() use their own ratelimits. As you noted in one 
of your emails, there might be the case where we report errors but 
there's no information about the Root Port that issued the interrupt 
we're handling.

The way I understood the suggestion in 20250320202913.GA1097165@bhelgaas 
is that we evaluate the ratelimit of the Root Port or Downstream Port, 
save it in aer_err_info, and use it in aer_print_rp_info() and 
aer_print_error(). I'm worried that one noisy device under a Root Port 
could hit a ratelimit and hide everything else

A fair (and complicated) solution would be to check the ratelimits of 
all devices in the Error Message to see if there is at least one that 
can be reported. If so, use that ratelimit when printing both the Root 
Port info and the error details from that device.

This is to say that if we keep aer_print_rp_info() (which was decided a 
couple emails ago), we should print it before any error coming from that 
Root Port is reported.

All the best,
Karolina

