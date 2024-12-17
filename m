Return-Path: <linux-pci+bounces-18583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4C9F461D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F067A2A20
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C551DAC95;
	Tue, 17 Dec 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XawqBPpO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qAwtY0NZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DA1D5AD1
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424472; cv=fail; b=aYX+JzmHAKZ3Pm1w6HLFUmJzrXZXUbvk8yEjneIKZUlxGSlGiOd4TIa9pyFG9FXIB3+8gVLbNEeCT9CFJJadoSmS/mCRGLhzsKQst6EcZgZi80ZP53AVGAuAmRgMaCrZQPIiWMEHL/+2EN89ZwX3M4v+w/NFMVNSKz/1/dxtJtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424472; c=relaxed/simple;
	bh=TZHUls/aqXM1Yt18/Zl4G8Ey5deugqVP2Vvjz9tFjCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQT/df3eqvxTuiWNOgdC4/Lzm++kodb00aA6FH7RIOCE6dE4PcLRt5QgJ+vJLC4K35XGijWZBOfm/GVIkKsRh+ya5+6op47XW3gAIczp2HjGef5s+Vhj5SOg7thxREt6MsQ6L2ZRHtAmWryeU6gC5p+JT/yv0Ekhs9Eh3gm/EIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XawqBPpO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qAwtY0NZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1u1io013644;
	Tue, 17 Dec 2024 08:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1aV0j2f5ce5LvaBzM9AAj+eHNBV2HOwsRCzWXsRuRPg=; b=
	XawqBPpOIVpkVUunLA1gPIjuDRUacMeCS3+XdLuGSQ5n7gIrXrE4sLRkJBhg9A5f
	uk/qn1OjnCzHAnkSyWGTbys0aezt0kQm73sWBUtvsrXOiX9m8k5fqMLePadIJsLx
	TsFSPTnhDVB+Kye/MC/m+Gkx4Ivr4+LDMeWb93wspaOACNoOkQZX4HC4pPiwm3Vl
	Ego7MCtqiFMcZg/Sc2HgIECN61+V0GhTLc9ZUkS1RutO9H/59a00kbmIGQ0BpP4K
	q3fKJ0fr1LxKcB7XEh6Pe8HpFo8LQSLlYxRNRRomIbGsO1mauLhZN2M1x4pW/iNv
	Clujl1q3LWh8pCxBpWsgkg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m05nw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 08:34:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH7ffGU032680;
	Tue, 17 Dec 2024 08:34:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fed98j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 08:34:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ik1sy4J7/W3Y9nGe6g75zsrqShwE2VEFVT7bKgU/yJX3Q0PCZ4p+ktEOi0Xxzwh+VRJVgjuZrY+ywk7Ne+70zvIFq5sE0YB/bzM9m96kPsl4260EuyBjX7hL6LfWxc29cIoV2e793PYVxfe0a+hpDAE3GtT2qFMRkfGhCIScQt+zSQcY2RGFH/BSKGqxtPI+tjxCFHNz9OkUUO8fGrLRS8bkNIxQ71137URi0ROSI/o0J3MtoPH0dPYniXj0lTfxsffTLnuDaZVx8Dw0ZlAcMqgIHDFbWMoo7AiyiJ4K4Clvde5UQ5GMwZ73SfvVv7HXNm0exQOBpxfRi14GMdgGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aV0j2f5ce5LvaBzM9AAj+eHNBV2HOwsRCzWXsRuRPg=;
 b=pulB+a8rcKcsGGQv2yVngnsZpiSgk+HPcvzpPQlDJiVcJw1XihmcYM1BoZWiGtONX7cIwc9vSZ/08E7S1yRuGIqM8B9sYTAvZh56qwYFHN+Oi8mRPpefuMWmD4gvahNcodUdRoheLrr/VETwPRL1zMoXSi1EaKoYYBlt3gaA9kmEFGck5Uoihgi1go6GZ7XpEOKEA3WMrGd3nPTyG9rO9IRrK/eCT1RdsoTNMjGT6os96JWUOPtXWaVm6YaYoQlms1kWQbBlHBoExVn55AQ2tui5NAYlrHC4eRe8+/p/xnWf0pzY3/qU1MApgo3qhGc+Q50cK5/ZIFkEEhBez3hSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aV0j2f5ce5LvaBzM9AAj+eHNBV2HOwsRCzWXsRuRPg=;
 b=qAwtY0NZodxGd6hQDN5U8AoVzYOr4S34cNe9+vtHf3OccILJbN9FkjYkZo+v9QCZiJBD1TvYEZOZgVnDlzGzMdo9d1wYW8yqk+fN+imKMDl/D9NwgXjgpBa3RAFd14HQV00/57DmMm8kZSkyOje8zL/4a5OwxB+enY94tLNGXfg=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:34:20 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 08:34:20 +0000
Message-ID: <f53278c5-2076-423b-b322-95899200c700@oracle.com>
Date: Tue, 17 Dec 2024 09:34:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Rate limit PCIe Correctable Errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1734005191.git.karolina.stolarek@oracle.com>
 <20241216104424.00000fab@huawei.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241216104424.00000fab@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:205:1::16) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 471b7d46-971a-4083-a11f-08dd1e7599df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXh2UjF2ZFVQQy8wa0IzdVdMT1JxUW1GcnJkeG9McEJVZW02eVNJOVJVakVU?=
 =?utf-8?B?VXNkbTBLS3VjdzFiQ0l2NmJRK0V0TDJxUUZyK1ZKekpGMUVRN2pka1ovakZV?=
 =?utf-8?B?Q1pQQ2hZOG9kQ1lnbVl2ZVdGRzBheXlHVzRLZzVwbFlHRTdDWno5N1pwUnY4?=
 =?utf-8?B?cFVNQ3VQRXNmYm9DaHpBQk9uc0Zwc3VoWnZ4UXk5L2hNZ0RsZDVyUlNnSUlp?=
 =?utf-8?B?UVJWV1pWUlBOY1daNlRuUmpJeUFRallGSnYvVWprUzZhSk1MK1UxTWtidGV4?=
 =?utf-8?B?VXZCSmdzUEVMYWhBUXN4RVhDVXdPeDlkZ3dwS2dxUmFSMGdlWGtmQXFNdklv?=
 =?utf-8?B?Si9WWVpYVGozUUdKTnQzMjN6aFBwaHVQcjhaWm9ZcTE4VzFLay9TSnNCZytS?=
 =?utf-8?B?cmx2MjlUOHFkL2YrVDN2NUdqN2pPbHUzSzFtL3Fha2xPMm4xMzNqK0dPNkdv?=
 =?utf-8?B?VFpneThxcHpXUjBlOVk0U0pGclBXTDB2MUFzTmtURlJ4ZWJVenRxZzRvZTFI?=
 =?utf-8?B?dzhEV0NaZkNEREk5U24rbVk1WXRNUTd5L1pIdHZlOUxaMEVzSFNVTWp6eE9x?=
 =?utf-8?B?UHBQUjdNc21DUEpkSHRzWktESXJQQitZSFRUaTVZR3RGZWhTTDM1WDRSRXdR?=
 =?utf-8?B?S0F6UWVUVjR6Zm9iSWVEN3VHK3dtQ2ZoelNGN3R5Um5Qd1JGVlRUMXRQbmFz?=
 =?utf-8?B?bHZUZzdTcEdHVEVFUk1wZjhpQ3kwaWR6dGRBL0kxQm1qSEcwYlFQNGZOMStL?=
 =?utf-8?B?N1hBUkhtOWJlS3Zia0t6Yyt5WUxPaFBLTzEvL0VYdFdXQkhFYktYS3VydWZi?=
 =?utf-8?B?RElxZ1JTSmxXVXlsTWR5L2t1NXpmUXRXWEdOMnUwL0dYODdqaVZOaHhra2t4?=
 =?utf-8?B?d0QrcFVYQ1UwcEwzQlpYc3B1cCsrRnI0L2gvUlJOVEJDcVp5ZGI1cVl2UmJk?=
 =?utf-8?B?bEozc2MzbzhLZzZhbTQ2QUFaeWxpcEVxeGk3bUcwQ0Z0UkVUbzVIT0c0bVJm?=
 =?utf-8?B?czJVbHVnem1Wd0UwRTBHclVoSHVzanN5M2tvelN5eFc1aEVkR3p0Z3hzVyt4?=
 =?utf-8?B?YlhyS0tXYXB1T2pSU3BZbVNtdGZ5aE1HWHI5SHhocnFaT1RzdlN2Uzc3RExx?=
 =?utf-8?B?VXhkaDJybm1UZVY1aUZzTU4yYlZDVFcxK0hReGowOUhvYUZSTW55TmtVK3pw?=
 =?utf-8?B?QUVWRUx6aERCQ3dUWVA2YTdzYWtLY2ZXZVFWKytpcTRyeTV5ZEFodzdkM2VS?=
 =?utf-8?B?UlZEQ3J1VWZab1pDZTFOMzJlRDZPbDZEbjBsYVNCOE5tME9ncUNDTDFiOThH?=
 =?utf-8?B?bks5TzVxeTRqb1IwMm8zTmFNVlQ3WW9ha1I5VlVLNnIwMXlCYXhsMXJLZVhl?=
 =?utf-8?B?bFNEbDFtOXN3dlN2b2w3MWR6V2NhazhEUE5YSXh2WFJzc0pqWUlYWHBTU0Nu?=
 =?utf-8?B?Vm5ZRUc3SmgrdThKNDk4cmt3Q2lPLzl5MGFXRkJzeWt3UkJNRnNuNFdob3cz?=
 =?utf-8?B?ZXEwbzVBWHVIZFljcjFhWjJOSmtZcVBnQ2w4bWFCbWtuQk5aK25kSXExRE1t?=
 =?utf-8?B?VDQ4QjRkTmh3TzlVWDZUZXRrbWhVRTIvcndGbm1pZTEwdDYweXR4U1ZRUCs0?=
 =?utf-8?B?NVpKeElzQUI2L0xNN1VWZHVJTHBzNlg5bUt2ZFhhUkpKOHFlZWw3QXB5bity?=
 =?utf-8?B?YVBkN1Vjc2pRaHhEd2QyaGhEUGc4dGprVjFqMlFtRFk2VVc4NEhTMFpZbzZD?=
 =?utf-8?B?c3BHQnpzSUFEcWZ1cmNWeVhaMWpXL1lFV3JYcDJ4M1h4WWVTR0UvS2plZXFM?=
 =?utf-8?B?Lzc3blRYTU5VcEpGcndDdWpHSHNUVmNpb1VFUVBiUHlMVXZJejlaZFNySUxw?=
 =?utf-8?Q?CPUGhdAV2dduw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHArMmdOU2NWcXBoL0RVcWM4STlsQ1M5NlgrV1E2TGlsOVdWNHQzWGtOQk1K?=
 =?utf-8?B?bUNyVGJ4TGs3VjNNcE9KTWtpbWhvQ2JHcml4WnErMnNzK3BVd2xsMDRWb2hX?=
 =?utf-8?B?NWNuK0VyTlllQ05Lak5QNjhpNHA5eGd2UHdiVGRlNllldG9YMHpxNUlDdzUz?=
 =?utf-8?B?MXJRbVFNZ1FWaGdUYVlweVBaRSs4djV5V2lzbkxDdnYzUlpLaUgvN3NreGtT?=
 =?utf-8?B?dFFBeGExVS9QSG9wWDB6NHhmM09qNTNOcElvZ1JLZVY4RWdZM0NTVXc1dldr?=
 =?utf-8?B?dmE5eFpIY002K1o0NVZ0RnBCaDdkVERkZUtVRGJ5QTg2OEVxcTF6UkxnRmxa?=
 =?utf-8?B?d21reU5jYkNNdkprRnhpQ3k2dS9XZUIzMStrNXpsVnhCYjhJOUhJTUpkQ250?=
 =?utf-8?B?alpHUFlsNkk1QVpjTzk4NFJzazFpT2IrL2wrd1dJd3FVWS9rNVVZMFl4VFM0?=
 =?utf-8?B?U2wxbktmcTdQVXdQK2hVb1Nra3lTaFU3cS8rMGJxQmtGbnhtVGZsZitQem9I?=
 =?utf-8?B?dmJSR21BTFY0dEtjNEx5amFBRG41UmN6ejJueGlybWVtbEtBZXh5LzB2dysx?=
 =?utf-8?B?WlI1QnpoY3ZnZlg3aDF5dU9mTFFZTU1kMUJyekVVYkRIemh2UnU0RnFKeE4w?=
 =?utf-8?B?c2pFdlBjK0lSWkpNRDJoUlhiTnlaUXhvYWUwK0E2eXp0ZkcraVhtWnpFbUxB?=
 =?utf-8?B?NldMTEVGcnhjM3NoQWFzU3NrYnJMZldQaXl6WUduWFg5T2llMklwY0FzMlpo?=
 =?utf-8?B?S3h6bHpBRUdNK2ZLNWxmZmRhYXVlSElFTXVJbWNMU2VKQWdUTmhGR1p5SGhq?=
 =?utf-8?B?cCtvaXBYUUV2T2trQUFnQjVia1N3bUVRTWxETmFHYzlNYTUvZGc1SFpDd3Uz?=
 =?utf-8?B?bXp3dzBpdkhxb2JLY2gzN1BBYk84aEJHc0srRmZnazllV0I3R1NSRWFWZkRM?=
 =?utf-8?B?TGxRR1VpeGNVbnF1d21FN2I1WUp5QUpmZFdlRzJDVnB6Z3dqVHpXeGZNSEhk?=
 =?utf-8?B?ekhzVmRyaU8zTlBETWthRkM0ZmJacEZjMEMvU3lDazkwOVNBcTY3aDNMdWp3?=
 =?utf-8?B?cDEzVHlDdGJIU0ppQkNhazl3SjhKZVdOZ2VGOUNWaXl4ZzJ6bWZNZitSTEdH?=
 =?utf-8?B?dElYdm9Pc0hZWTJxSEVCNy9aV0FHaTVjblZ5M2VHWWxZRzlSSDhWQ1U1WklD?=
 =?utf-8?B?WkR2Qmw2Rm5ZZHpSV0F0aVRDdS9NVUh2WjJKUzJlaHJta2JvczR4RFJacGQ0?=
 =?utf-8?B?eFlTVGFSMTZvREtBZ0JnQUQxa1VjOSsxdEVpNFpoTlU0VU5sV3lrVVNCdDFP?=
 =?utf-8?B?dVcrMDdoMlgrbDdzY1Bkb2FGRkdHK1VtU0p6WVF2OVMxM3JsTEZEUlNUcWFq?=
 =?utf-8?B?SXdURVVMY3hTRllPb1VuRVZFNjBIMjBIdW9xdmtMVXpuTkVvMW5xTG4ySWp2?=
 =?utf-8?B?WDJTc0FzTXV1YzZrQ0NCN1hmU3l2NzNUcDdWdmd0QjdIMVYxalB1T01nb3N1?=
 =?utf-8?B?WVVYNTZhSlFKRlhpQUpldlZjdDRFemhpTnBsN1hLKzV0TUQ2VHRFU1hCbE9E?=
 =?utf-8?B?Z3duNWc4QmNEb1FGMWpEcVpmVm9WWFVmYnJMV2NGNUNrOW13dGZieWlYWC9E?=
 =?utf-8?B?dGhnL3l1S0MxeklUVkxPRnpNRFphTWN2dzFqR05XYVlwZ0pzbWh2U1Azc3p2?=
 =?utf-8?B?R2VTb25aNnhUcU82M3BjMFIxSXBySFgrdFhVVVhoQ1FqTnUyVThmelRFVXNU?=
 =?utf-8?B?S0JtcVlVdjgvUkNUWFpYbU8vRlYyM3pEYkRSVDJGUElHdVZEcDRnU3RKcXIw?=
 =?utf-8?B?TUszWkdlOFhrYkg1RGJ6a3huNU5MbUEvYnE4V3dBaWJMd3FBZDlIdFdNZzZ4?=
 =?utf-8?B?Q0ZkRjZzM0pnM0k3TFJ5UmhXdzhzV3F0ejU2T3pEZU9TdE5udHY0VWVkVTZR?=
 =?utf-8?B?UzBqeE95aVUyVmx1V0J3RXJLMEIxVUJ4QklXRW1WVVVhOG51WmJUanJUYWhn?=
 =?utf-8?B?WUJSZE9GRXA2Nk9FWXZBWEpYM09zWVFDMGJJcktDWjBubWhZTm1JelhLbTlR?=
 =?utf-8?B?TUV3c3d2NkU1emdNbVJOVFk0L3RDRzNWdE5maWZxNzAvK1FxMU95SHZnOS9q?=
 =?utf-8?B?VjUxN3AvcWpiL3ZDNzZhUzJTRFhrQjVVS0JLNEhnV1dHcEc2bEJXLzF6Z3dJ?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NbnSvgJ9D4Dl0rjrAUACzbYJUsavux1enz8NQqaHC3u3iex+83SG3r39Az/Faj28i64KxWvLh/aewBiV8DLz3GhjtFUVWEt5076jVvQN1Xr/6rqeP4LZ2bIWRHZbDGXTXtoTv0rTl2SQxWvGiKwe1LghEtzcl/F+fHT0vEsIMofEqkG4cmshiWMsUhJouQ244wQBTSigzQFi8B+eumUR/B1MPlJnZiOX1sziIq3JfKd/Wc0S2MgvEe3iuU6HtrYngomRm/GcH4iZtgUzH/imyKIyE0aNqjHxT0tef6cQz7RCFl7EtvO+Ll71b7Au2Ds+TVJly69TVMsz+csS9vUWbtFfaeMDZJhdJTmyN07RcaV0JaUmXJVUoZ6moqKg1AlmYb0grmZw19v/2c2+zUIbAR8caNR9v5gKKLCDd5vNhaBqz+EecqsJlFzKB1BYoeC6AUjNo4HUhM62vh3P8sI4Cen+SjgU7Id/ix0Z0jNNNwpKhfXGRRqqZlEZKdc+9rfcnUeJt/n5/7qPH/8d9W7GppS3I2YQZZqWV16nwqL9pr9E1Gji3q5QqpiVJb8XO4lHuc9e9thWMwhWkVqg18QTGAtYXbpZcW0qex/Xz/vcEZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471b7d46-971a-4083-a11f-08dd1e7599df
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:34:20.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwdgZvyMLFt/y9g2IDy7bJpb33EUGKIfi9s7Lqr4m0EmgMhTyyo6B5BuBFOcW23guAACgJf4cji1TyrqVKmd3o8P4vdvKclMcekQUhSIH7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170069
X-Proofpoint-GUID: thAofvUC725ccNzMILObp2TqZ6Dv5jg-
X-Proofpoint-ORIG-GUID: thAofvUC725ccNzMILObp2TqZ6Dv5jg-


Hi Jonathan,

Many thanks for taking a look at the patches.

On 16/12/2024 11:44, Jonathan Cameron wrote:
> 
> Hi Karolina,
> 
> Just to check, this doesn't affect tracepoints?   From a quick read
> of the patches they look like they will still be triggered so monitoring
> tools will see the correctable errors.  That's definitely the right
> option even if we limit prints to the kernel log.

The tracing seems to be working -- rasdaemon recorded every correctable
error despite that we didn't print all of them to the kernel log.

> Assuming I read it right, change the series title to make it clear this
> is just the prints to the kernel log that you are touching.

OK, will do that in the next version.

All the best,
Karolina

> 
> Thanks,
> 
> Jonathan


