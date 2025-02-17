Return-Path: <linux-pci+bounces-21609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E2A381AE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033783B2523
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8729217703;
	Mon, 17 Feb 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d9rhKmG5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vSd23cKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5519F104
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791843; cv=fail; b=XSi0mTVJY7PMEUFh3ud7jcgeKD0ZSD3qqGAPxUB9szCgphIUoAlYe9SJztg5OqNzfNrT8vxuIsQK35WLMz6fUOMWmGqcT799gvRu4jLzLOhqnuZrX9S/nHdl8bOC7tomeSlTRSPVxwawTaTbzZGegNBPpfu/qufHQG+I9uGU11E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791843; c=relaxed/simple;
	bh=9vkKngoXeO6SBy/sVCH/pHZbsV6nrJxUiBmsVwJkMZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GYGcrVJ5+u22IR7zudDCwTIughUo4a78pdyTqomNEqqklYWGVUPbs4EPiRCnB0FcJYeCx0M2oFuwK51zAGfXp86w8UC6Zumtu/bxllnRi1uj7dww2wVx4CsFzZXGCZRJIs44ss7mulN3AOYC7PCP/PBexvLCwxjik7H2TKNFwDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d9rhKmG5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vSd23cKI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HBMeQv024794;
	Mon, 17 Feb 2025 11:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=snnP2Ml75ufD7C1PGYu5agTVd+e3YJOGSBc5s3z0txg=; b=
	d9rhKmG5vf2jwB7PZA4hEVILqcfYO2lDlSJOzw1vKZwL753eWrkCYqzjJeTxVX+Z
	GM2HrNxSuN18X/Y5IJVfr7VBoU+KzgQcygWdp1n9DgH2vx6TUpcKxCJS2hsepnfY
	9P5jCJaScbIdHYeKXQIBtKIO0bLrI5VXeLoCC51Qajk2wr78V6pd/DM3lZFOfOHB
	rmllS5X3cWUb1R8qTpIhn1RPKl6eBl2vJ01bU4fyXF/F6EB/6Ov8in3TJ2cSl1YX
	MZHE764VujN3SZBB5BetpgjXdgLcoPp4woIDrrmESh3h0yZO/BLmZme/lUGj4304
	7DLPw90F4KASkJSjxGOFjw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thuac1v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:30:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51H96tDk002133;
	Mon, 17 Feb 2025 11:30:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thce2ga0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPBaE46zz5AVn1zY5CVUlB1o/vTJi0rQ3TsLm85AUJvIvyh1uCSrvA09QJYVRRFsP9KaxcCetzJidWRsekhuY5zMFYXMpgYaku3BWr6LOaB1GHTs3zUDraASJGrGE5FWUesYVu35F259J2rAoD4iz28YKDO8ENJCsO4gxcOS2wMvI02PpvPJsNJGXeSnORQD8Th3FhiHOnDqxHL6TRNc96dBqiMDwbrUlIN6XDpETaubIelRYhOOFS4XZPRRxDsJJIRxkvdPWNG1ExxElv1p5qKMdYQek4sa94pwpWhd2nra8ydPL5dgKa7IChEdHKbA+aOYbq0OOj56U4GuU5QqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snnP2Ml75ufD7C1PGYu5agTVd+e3YJOGSBc5s3z0txg=;
 b=VbYQF8wLhpDIkGWYaqhzLIlBpAK3a4bgtyPndrHQkv9E09qVb5R56xJYnw210FYMtvQTh8XoU8wAiDTmdf3q4QZMXCPk3yithvS+nrdxcyZ5E52v+IdAFdS0qVRJBAohdeAvzgxBwHc3zQYW/4v3h4ReGXGdcXbVGJh5XodtXUw+HYG2Rk2RoZZ2Z72hSCmVfZlCixrZRcUxrnl046Ai77LDWFQmksdM9OIqxYtKkT5rKrMhuj9mwaGCHOqi6WhafTgbJz9nn/4VYri47DfikizknVMEcMZBkQuERZw4wChIrn0eVtCHDjBgre+y5mrF15HzpPM+kyta1FnkLrmrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snnP2Ml75ufD7C1PGYu5agTVd+e3YJOGSBc5s3z0txg=;
 b=vSd23cKIq83eie/NlxgPkS0JA186biMfKBtbwi5UKzG72MxZVZ/o7zwwjwCLp3ovjjo7CRyFwER0wdYq7yi2yEL3jYkxaUJ0D4CNTcBqxUfanZojJQ2mahbW8EGAeqIdGPsmbjI1qi3S9SJCxgsU0dquO8dPWtN2Ug7HI0sHT4Y=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by LV8PR10MB7750.namprd10.prod.outlook.com (2603:10b6:408:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 11:30:27 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 11:30:27 +0000
Message-ID: <22b45b04-9a8e-41c3-9194-09cfb9e44f99@oracle.com>
Date: Mon, 17 Feb 2025 12:30:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] PCI/AER: Add ratelimits to PCI AER Documentation
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
 <20250214023543.992372-7-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214023543.992372-7-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::20) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|LV8PR10MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4856dc87-39de-48f6-0de6-08dd4f467a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bldTUEpKRmZjQnRSanNnN0hkd3NtanRuaEpSY0t3WDlweWNzSzZjaTNxdEJD?=
 =?utf-8?B?ckk2Sk9FODl0bVZNd1FBRGphc1hIMlNkblZVVXRjVDdXb1RTMHUvKy84d2lW?=
 =?utf-8?B?RGhjeVpobGlKc2lSa2JLTisxUUZjYkp5WWZRZElQbVhSbmxiMXpFeEZlcjQ4?=
 =?utf-8?B?SEwwZFRkanltQW84bjRTNmJ0MlR1emlDR2taSkxGY3pjR0lVTGtma05rOTR1?=
 =?utf-8?B?WHEyTU5YaElKV3VHVG11VnBCYUhrQWIwUnpML09lNFlwUGxQZ2tiRDN0VDlm?=
 =?utf-8?B?dlZIbHJHVjZDOHVWdmVSdE9ZZE1iTDhxdHRrVHZzMFNHRStEaTZtZGRyaWx4?=
 =?utf-8?B?MFlRVHVwWDJUTURlMkE5Rjk5b0REUGJzTGlkTGNkcUZvRlJsOEF0TVVUc29s?=
 =?utf-8?B?a2dVSlIxQ3crVWEvUC9mSENXVVdkSnpJRVZ6eTE4SU9TT09xNlVUNDd3Yld4?=
 =?utf-8?B?ajFydlEwRFQvY1dRSjJpcXhFUnNOalB3cU1ENFQ2NGNLb29wRmphV01pV3N2?=
 =?utf-8?B?bm0vSythSnlNWXN0NzdrMXdaMTdGa2JNaVNzbDYrTnBtcE5EajhsLzl2ZFZ3?=
 =?utf-8?B?Ny82OEJaN095cEJ6U09ZWmREL1ZQcVdwRlBiYzRkTlYxTFh6NnJRc3ZpbURT?=
 =?utf-8?B?Vmw0SVNLajdhcXpHUlk0Z3pxSmtQdHA3eXhCTmFyOVNxUTcyS3BDQWdmbUpv?=
 =?utf-8?B?aU1qMTgzRElhak8ya2ZObGxNVjBtTUVvSXFTQmU0cWNqWjVDdXNlUFMyTkdi?=
 =?utf-8?B?TWhMSHB1UmRacE1ZaDV4eHhMbGVSNmJLbkduY3FMeTUvYitLOHRvM042ZThI?=
 =?utf-8?B?aSt3QlRNVStIbTBuWTJHeVNhSEVWRXB4UVlnc29SeWJoOU5XZlErR2UrKzdk?=
 =?utf-8?B?Skt1VTRKL2xSWTBoMmUvZWoxOUlUY3piN3k3dkRJYlI1Q2I0S3lWS3BKOHVt?=
 =?utf-8?B?d2JLSjNxUHNvRmR5N043ekh6bUhhSTRZUmJOMnBibzV6cHVrQkNBUmVtb0Vq?=
 =?utf-8?B?UXVhTEFMNmRtL3dRSXNNbVd0TG0wdlpyRStUc0RsaHFmNjhhd00zWUFaaEdy?=
 =?utf-8?B?aXFaajcyQkdFNEdsNnZjOG1Zem1HWmZzSkdOMDF4Sm4xbnlMalRzZnFTSjRa?=
 =?utf-8?B?eURkUms2dFh5Um13YVZIU2pESGt3VlV4aVFWNmVNY1NPN1FGRWhPQ2FjVWdK?=
 =?utf-8?B?a3JDeXZZUHlLdEp4NHZxWWJKd2RwMWV5blhKUHR0T1VtSFRzeGdVMWRFbExT?=
 =?utf-8?B?RWJHRjlRTVJsNDdZUkhtNUJGanJxSVRKbjlWVktZeTdUcnFTU2xCSURmbHh2?=
 =?utf-8?B?d0ZSQjNKZXVyRUE3L0xLNWZPbWJMeVF2ZFJTN3VtRXVJN2F1U0pSYUVEdjlY?=
 =?utf-8?B?OVBhZjZIRkV5K1BRMWZtcnFyL3M1UW9TNm5NaFVURWpiSlNFM0pVVjdia21K?=
 =?utf-8?B?T0h0MmgveWVUalppYzdsRWtsN2c0TVdpWHRXYytHTDVoQUZnTWpxZ0ZyeWVw?=
 =?utf-8?B?aEpxN3hvb1BJK2NFcU1wNWV1VUREOTNxa0h2bkREdlc5TzRQaVVmR2ZqbVUz?=
 =?utf-8?B?VUNTaSt6U0dzN3U4Nm8zTmFMZEdkKzJDSldSc3U3YUxpQUllNmhWS3JSSUQ2?=
 =?utf-8?B?c3NyZUNyWmZLMmNqWjhYTWhqYmsySHRYRjZmUTkyTUxRdzA4SlpwYnpzcEJk?=
 =?utf-8?B?MmlnQ1FialdZclJzN2N3QTEyZStQeSthTnVHNTBWUklWZ093bWhrT054WFZ6?=
 =?utf-8?B?aUZwNGMzR3JrYndkS1dVOENFbHVrNllkU3BtZEFWVkJoSHlOY05uZzJIM0Y0?=
 =?utf-8?B?RlFKT2pxU1B1QUN1Z1NCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUZXbGZ1K3d4V1NJbTFXZHowd0Z2RkR5NWlVWWcyTXFYLzhZdzJGQmtLVUNO?=
 =?utf-8?B?VlEzRnh4QUVGd04wWjFWb25veW80T0NXdm9KY1VJaUNKNFRCTkZhWCtWRXRJ?=
 =?utf-8?B?OWptMzdndGhZR1dzcnM2WHdRMEFZWmR2bkkxZGtoS1dYU1l2WVFHVm5PNGlC?=
 =?utf-8?B?OWFCWWVueTZzd1dWTkliRE14TWdDN2plTEZXWHdVQkRNNGtGVGljcDJ6b1NV?=
 =?utf-8?B?amlDZ2Iya21nOEdyN2dTQ05OdGZTQUNZT3dSRXE3ZlNiMzdva2R0cCtIaWlN?=
 =?utf-8?B?Vk9Bc1VJL0txanJkWGJwaVJUV2JZdWxDZWFKMitOWWp1MlkvYWRkSGcrcDh6?=
 =?utf-8?B?V3FkalBLSllRU1NIaG1kZGxMNk5wVWtxeE14aTlRMzV4M2dEOU82ZlRSd2pH?=
 =?utf-8?B?NTBsNFAyU01uK3lZOStQMnZjdTlMb1k4VzdtL0FqZjhBVVFudk5CWllsOWd0?=
 =?utf-8?B?RDVTUVZDamRCT0kvV3A2eTRkOXBGbk1wVVJjSFpUYTZadHR1Vm9VU3cxR0Q3?=
 =?utf-8?B?dnhQdnNUMUYwYkJJa3FwejllRVM3M0UwSmNqZUw0YmtzSnIvdEQ0MTNKb0VL?=
 =?utf-8?B?eG1VZmRWWkhEallPelpxL1NucmhUNU0wK1NmVldTK0o3UFRoWDZZUVBPbVo3?=
 =?utf-8?B?N0ZOcHREdUlqOW9yV3BhNWpqY21haUFOKzl0bTFMcFpqUkgyMkY5SFRTckhY?=
 =?utf-8?B?V0s3QnB6NkZGT1B4d08ySXVrb0F4Ymo4dDQxSlViZHJ0OTBLRXZOUmRsL2Q0?=
 =?utf-8?B?M1BIT2FTSFdDWWRBZDVlSkQ2U3hJcDBhUTQ1VkNXTG1pVWhZS2t1S0dhTWsr?=
 =?utf-8?B?MFFSaVl4V0ZCVVBnOWdPVUxqSmlibmZEYm92VnFYTlZta09xMVBPaUUvMGd1?=
 =?utf-8?B?WWdZT0lpU2dEZVpwWndOSWN0MGlaQ1dQRkJrUjBoZlpsRDZjWlhWYTV1MCs4?=
 =?utf-8?B?K0MvK1BadGMySXBEYnYxMGNQTXcrcTFHWWp1OXFkeEx3SlA4Uy84S3NTOTRo?=
 =?utf-8?B?QkZNNXgrMktWZkdha0txcitXajhwd1BpazQzRVAwRDl1OFhMZW96V21ZR3Bz?=
 =?utf-8?B?dEhDVVNabHNySUJaV1h0eTh1dDNSSWhsZGE1elJlcDJhcjkrWnJSREN5UUZO?=
 =?utf-8?B?VkMzTllVT2F2QWFEWFBKQnZmbnZtYXc5M0lMdStMTVJ5VGFKdGF2elVqL1Ix?=
 =?utf-8?B?L1FmUWF3cDMwMU91dUxPZjB3NysyMjFESTV1eDdkd2QxdEJZdmw1dUw3a1V6?=
 =?utf-8?B?SVpmK1puVkVzT1NkSEpBWlUvOGU0dStwODhJWFZ0eFVzalV4ekdEVk9uQVdD?=
 =?utf-8?B?SmNJa1BzaEpjcjExWGxDQlZHNlUvcDlHb2F1VnZSYTIyTi91TkNGcDdwd3FJ?=
 =?utf-8?B?bUFBVTlBd0JQb0M4bXNaNkk2Q3JpMHNiL0JjMWZNQ2o2YkRld1NXTnVLOEFZ?=
 =?utf-8?B?dW1mdGFsUnlEWVZKS09KcVhMTHZBWVpyRHNQRjJZRGNqSXlvTEY5Ynd0OXky?=
 =?utf-8?B?NGxyNkRPZHNKbFJpREpUWXV6MWpvWlhpTU1hU05FSHhNcVB1WW9ualgrNzBq?=
 =?utf-8?B?TVcrSHp6ZTZCc0JObDl5dnQwdE1SeXpnZGRNMmJVMVpDaU1zQ21uaUl2bDg3?=
 =?utf-8?B?ZGd5VmxZdWdqM0NlMi9vazdHelVKZXJadTZ2NDd6MklTQ04ySTRLcUJ3N3ZP?=
 =?utf-8?B?TTlyRzZTL3c1Nng1d2JLKzE3bVNhN0o0dGFLQ3hlaTZYVzNzbUt3Ri9pVnRG?=
 =?utf-8?B?UWtaU0IvRzFYcU1Yb0p6enF2cDhRdldOOTU3U1NRWSsvdkYxRmFMVkxUc0dJ?=
 =?utf-8?B?UzM1Y2h3MC8xUjlvNUsyVFpHVDA5YWNMR1NyMUx0M015SkEwTHZjQVhPaDRw?=
 =?utf-8?B?VEpnOFAwLzZQRERXeWFzZW9FbThkakNGYUJOanltQm10cHp6d0tCOU1HdDhD?=
 =?utf-8?B?ZGJMWkJEcTB2UWRNWDdQalZMTk8zcVRTVjVsQjFFVFZQT1RUVlpIMGdPYzBz?=
 =?utf-8?B?QkxtbGU4UmROMjdNTmNVcTFNRjJCbEZZQXhYejJhSTdtRDJvaTJsOFdBdE9j?=
 =?utf-8?B?cUVNOUU1OFVUaFc5QnA1blloV082Vi92OEE3Uk1NQkxENzZrVUdaWU0vWmUv?=
 =?utf-8?B?UjdmUXU1K3lyc0hiQlF6VTZZZVQyV3llVm9mRnNTbnlkaTU4STlaMVd6bmdU?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TW21qDvuIO1q+D4D4O5ktvcBypvM6zocy+zdvpk6ffQ0CwuA7WlMbtAdHfR39KmkNsFqVVt57panMCFzPmWTme9gHDR63MQHx1T3lolQh+czK8xTtgH2FvXIQc7ZV0G6afUgFOHwBfUJsV4qKrnreu7WRXAxPPLpUSBS+2iOcuEDSpYuveG4FAkx1VXMr/0kW1/6WbVTH90co8N7Ga33arHGKUc7BTKJHsgyfOwtRGJDYOwZvmXwmkwYp1iEt+Dkj0zENejD5nH1bP1/LyACrZItGnqPEFYF5GDpny+iE3HIqtly0Kb8BgUZRC7YJHSdN9rvB9EH9g2hvHqGf6Htl6EXP2kHXetY61dMzP/cv68dbWzZnmqhncnFC/0iojcCtSgA40WXL8q2JSdPusuCNWcjrI9dLSeSrW8mY7mXmd6SeDymXCF7qiDpb8JdWqidNzbGlCxRdmK24KXOO4DrV5PsNCncOJt8rOW+r6QhJ6bhM6RjiX1T2G6eKNQaRs4d3EJ0JdqaAPMMPEo8Y2ggJVUFKCUaa2m9UzcLwds9pU8ovRVIm2Bb7c1wRcH42gzaB8Wi1rYEp9cIezAkLXfs4NV4FE9+ZisAvkm98SBwUX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4856dc87-39de-48f6-0de6-08dd4f467a59
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:30:27.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11D+G+oS+EuFidHxpwI3GgCVqdUKIj7vO2qofsaVh14EmdJRv4p7f0I+loL8eKq7BPKzQG9sN0P8hztZIG+ljpAiV7ArmuJEvTQGB7PuG5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502170101
X-Proofpoint-GUID: ugMuUAdi2YwtTZUxon96HSaBcaSjix49
X-Proofpoint-ORIG-GUID: ugMuUAdi2YwtTZUxon96HSaBcaSjix49

On 14/02/2025 03:35, Jon Pan-Doh wrote:
> Add ratelimits section for rationale and defaults.
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   Documentation/PCI/pcieaer-howto.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index f013f3b27c82..167c0b277b62 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -85,6 +85,14 @@ In the example, 'Requester ID' means the ID of the device that sent
>   the error message to the Root Port. Please refer to PCIe specs for other
>   fields.
>   
> +AER Ratelimits
> +--------------
> +
> +Error messages are ratelimited per device and error type. This prevents
> +spammy devices from flooding the console and stalling execution. Set the
> +default ratelimit to DEFAULT_RATELIMIT_BURST over
> +DEFAULT_RATELIMIT_INTERVAL (10 per 5 seconds).

The imperative tone of the last sentence doesn't fit here. How about 
adding information about the ratelimit values to the first one, to 
specify how frequently we limit the error reporting?

If you're eager, you can explain here that the errors are reported on 
each interrupt generated for an Error Message, and that PCIe registers 
can only toggle error generation on and off, with no option to control 
the rate. Feel free to use bits of my cover letter[1] and if you do so, 
please add my SOB to the patch.

All the best,
Karolina

[1] - 
https://lore.kernel.org/linux-pci/cover.1734005191.git.karolina.stolarek@oracle.com/T/#u
> +
>   AER Statistics / Counters
>   -------------------------
>   


