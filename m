Return-Path: <linux-pci+bounces-21619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC752A384CE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 14:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528B83A3845
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6EF1E515;
	Mon, 17 Feb 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UzLH0zVb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hRgqhw1a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FF216E35
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799120; cv=fail; b=jENqSnXmgyAQVvH2dcAB0tkYh4tKbu8N2N2ftTMIWwz4CWP7Mo6jS370pXEsqzzKEP6NTkjGhJ5cbFzcD3aIoHkLEYG0VssilYSunGOY6hs+MDo/S33iGw8Bi1RGeyAICyBLcK5OaPdg5XEqcIaXsUOrCMgTf16f1nHcx49XSaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799120; c=relaxed/simple;
	bh=PdSCfOtZsNb/j9KR1CBa+MqK7f+Kp08NQjaTAjLfhpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HwkZY4BYtjS5Flf13uQr2GoPCRa2IjQP/k7d+keMdyyUfwPh2XybKSv/yC9wHNaj0pl9UuRqnkjFz7vw9iA2qJVRmmP0/knBnjC2GazgM6NqfvBzj+63rggU3AQcvXGZeBNeqFKLWe6z9NFFf//q9QBvvBnfW2Gw0+H2Tge+ZzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UzLH0zVb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hRgqhw1a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HBXXro008941;
	Mon, 17 Feb 2025 13:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=83RbbyIu4aIU5i8bq9CuI16d0yxHn0m8gckLJIBzF34=; b=
	UzLH0zVb5nuygKniMKTj3S8pIFxuKGWNONsbP256aM+CuTchwNQR0DVa08kRVR6y
	KHyJ9o+2NHXWUjCnLSywqOkpL8lSXE8NLSyuyU/PpbZsq8E5rciSrzoQzLEuqp3d
	KGTJtKPCZV0lUORxEZWjQcAHPUGIie8hxuVPdnAZzK+bYv4TncMqy+oSTjuFM97t
	ZWt7q8EUvRl8V+x7jZGwIYDDtBtW21mDEDnwZXCrDriFMV/wHGk3numKBRgDesfg
	MOyyH1F1bshCfo9UflbuND+6Ohqsv69StnHa5K4vs+FE+A23/uhx9vla4HJoHZCC
	kK6O+K+i+W1BgVw2ZtyfTA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thq2mcup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 13:31:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51HC0xsa002115;
	Mon, 17 Feb 2025 13:31:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thce63e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 13:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+OeFtXSiWI4ATjtQOwfjPcNiMDgnzwAlHwowotMtM+ZjLeJ6DBin43O3BC7zKrLFZGMu778YXIS1pL7ke76ZUMbqPhEpg7U+hYm6Ss82NcSohYKh1gaqtCLDtjv7N04yJczAiISHKgdsIY7TKQTPV36irwfGANHAkQGsD4SeXJRjb3SxNXj2ooqNbPbvtyNlsIQ82xMms5S6iZY00psifTAIXw54+QvUBiW/GFsre/GS0NAzYt10PJjZ/TABKlZNqamts8QBlDsFma4n8bLgcDF7z85sZWIed5iWxY5vhiWrATDGWLJn8PW9FU2HnsPSeYmG40S9F3fMjJgpVBUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83RbbyIu4aIU5i8bq9CuI16d0yxHn0m8gckLJIBzF34=;
 b=tyF3Cintc3vcZLCTKmJpR1Xksp1Gym7RJwO+Uqy8ltoTtiD1dv37Vj/ZKFWhClHiGEt3LOrmRa75/8zTvJJjRRhvrt83Dg1j03LNB/A0eHt6HiXcg6O/9nflRcw0VVV3TsDI4oJi9gsM7JrPOuYPOD8w3arqoaMfHGqkf3oa8siC6eYj1cQqGNSsLxbX01lwVMBuBQTAG+Y6ZCnscjOo5sOncfeFZbz/1qRXhY/B3Nka9S+kUWj/TRomqIGQ3H9w9L6opQVBSP3T3SbZUIVLcmNEQoa1CHwwhsopmTe/HN/RKHuRw4VE+mmjN+bOrHik4fZqmXf9pwe400NOrytz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83RbbyIu4aIU5i8bq9CuI16d0yxHn0m8gckLJIBzF34=;
 b=hRgqhw1a9pj360pVcVcVzHfG6GA9f0llVjMKEic6eQzfcEk1JLzmBEhGhPyV7d0CDL4YKIRwDSjzKea3l5LwirT46PY/4dF8x5ZvfC40fUP8/lw+3CuHNBRGvNtc15wiGGybr/o1Pd8b68KtTb3uTuTk8sk+qQyPQZN5Z5J2DYQ=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DS0PR10MB7901.namprd10.prod.outlook.com (2603:10b6:8:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:31:30 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 13:31:30 +0000
Message-ID: <38451a01-4e95-44ff-922b-8fda725eb25b@oracle.com>
Date: Mon, 17 Feb 2025 14:31:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log
 ratelimits
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
 <20250214023543.992372-8-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214023543.992372-8-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::26) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DS0PR10MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8bcc85-ab84-4d8d-095f-08dd4f576349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXZLU1hVLytiVlBwZkd0UnI2YUUzQ3JKeW9ZUE80NXVNV2ZwTUdPYWVFd3py?=
 =?utf-8?B?QmNhZmdwQ292NWRGekh6UzVwN282cWhOL1NETm5IQy9tYm9lSVQrUlFjaGI3?=
 =?utf-8?B?WElka0RkdHhSMFdVb3Z3QkpCZkNDNURNNnd3T2R3aGF1TzArOG91WmxvRE00?=
 =?utf-8?B?bnpKSTJNVCtkeHNqOTNZOGl0SXhydGtoM1BsNmg4S0hzUWRDbjJOY2FuaUJD?=
 =?utf-8?B?T2JVYUZJTjh5N3lzelltb2VMSzRYdjJ2YmIxOEc2aDFCNkt0eVZJMSs2N2Jm?=
 =?utf-8?B?bXNiVmE3enZQc09KZkNiKzRqbUFySEVVODF5T3QzdU9NSnhCMEZMUFA5ZGYx?=
 =?utf-8?B?UU9iZWN5UFJqZEtrNWgya0h4UWxGWklMM2dNYjhVaDhxcTBQN2xRY0JhU3Nv?=
 =?utf-8?B?RTJ5QTRuNHRsWkZqdU85RUFocTN3VVNQeXVoendQTXlMUmJJcnI3T0ZSZ3c1?=
 =?utf-8?B?anZiNDdnQlVZZndYRWpGVEdnbWIweGlWZzdnMGtPWDI2OWNxSGd5VnpqREox?=
 =?utf-8?B?NFBQdGdYcUNaNHJadzRNR2lHMDNJUytZMnpSNGg5N3VTUER1RXdieFlvYVBk?=
 =?utf-8?B?c3VzVlRtZkJSd3laK1BtdnY3N2ZaVythMkpISWhJVy95RlBsSGtta205VUx4?=
 =?utf-8?B?UnR0UytCWHVZLzVGS0tZd1NqRERsbEZXeWhRYUN0bHF2TER5UGtKVDZ2VmZS?=
 =?utf-8?B?Y0I2dFlyaVREZVVFSUh1eHhiZlFKZkFvN2dOb08rb2xVR2NxZjJId20vVzdl?=
 =?utf-8?B?MTI5bHNWT1k5aUtSTjJwWklUQ3Z0OW0xZWNpeG9uOFpoUVY1REN0L0xLcGgz?=
 =?utf-8?B?SWY1MUN1YmlNc2lBTTkyOFdUcWpRU3FBQm9acFU0OW1URzh1bXd5K2l1TjUv?=
 =?utf-8?B?MEVwVnlXSWFhT3B1MjVxWHVCaWU1dGdBQjdUSkpLOUJDZjdpNTIwZzhsMHEr?=
 =?utf-8?B?SE1xbmpBYXlURThXQno4MW9Heng2ZHhyVFBRTUd4UTl3elQ3aHNRTEZ2b2FZ?=
 =?utf-8?B?cnl2MDQrbkIwNzVIYk42NkdwaEZWc05rQ29mUUsxTnNwKzc5T2xodmtTUk4z?=
 =?utf-8?B?VHlRdytiYnB5enBuQXJqWlQ4bUlRSThCZzVXajJpdnpjWWtOSzJWY3JzalE2?=
 =?utf-8?B?SzM4TVBXbDVHbHJOdDRpOTJGaXMvSVJrMWU4RHI0djVRb0RUM1ZBeGI5MzQ4?=
 =?utf-8?B?MGFvR25sM2QrcjNST21YbHJ6V2RtMXRpUklMeHU5WkZtbGlVdVNjSDFTZlp3?=
 =?utf-8?B?dXE0VHN4YXd4bW9IUnJlWVUyMk1XUHVyQWhHQjFMbEdTaXBZQjJlelQwR0pt?=
 =?utf-8?B?QjNZRjN6d3hHb3g3QWhiRVE3MndkL2NSUE5UYUtubVp4ZExLOGg0TTlKdDhy?=
 =?utf-8?B?cCtBVmJ4b3Z4WmFVeE9nWDkvODFVdmZ2SGt2bVhNcHpGZWMwQmh1RXluR09q?=
 =?utf-8?B?OFRLTzdtZGh6b2V6Wkhqblc2OE5YYjM2Zmcya2VscTZPak1wb0dyNlZFQ0la?=
 =?utf-8?B?eEhEc1FlcFZ1eUNNQ1RUeVh6NHByZDQvRDlaOXdhbmJ6cG12emwyQ0FMVG9n?=
 =?utf-8?B?blo0NFcyL3FQSXkwQ3dHUXZ1YkYzaGtTVXp0QWtQRXQ3dzRVZWF0WmdHK1Zv?=
 =?utf-8?B?R2kvKzY3YzkzRndwSkppMnJ6N1F0NmFJeFlXV0lzMmxxajk1OFFEanNJT3VN?=
 =?utf-8?B?ZDZWWXpkTUlTYysrSnE2d09OTzZrd0xXOVJVQkprK2hLaERnTGZTczJhNFZ0?=
 =?utf-8?B?bVZrZlowdkN2R2xhd3c3U3FYT2w2M0NzUG1VcXdkT0ZPdEVLMGZYeGVjMDVq?=
 =?utf-8?B?SUptUy9WVWVwQTlsL1FWSDdaR3htRXhiMkk2WVNILzdlUHg3RjBSNEQyN0o1?=
 =?utf-8?Q?x82BU2g/riF+3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkltbzFURlRlNlJCcEg2OHdIRXdER1NQay8vQlpNQTl3aVpHL3lPcE0rMm1o?=
 =?utf-8?B?M25OTDZoRHVkWjVGeUd2cUlmeU9kVTUvREdzODk5WkFMcGlyVzFUK0tSLzlQ?=
 =?utf-8?B?bitRbGgwUWRtSWVSZjJhQ0FZdmhQMmJ1eVNidDlYa0VKTHU4bUhGSGZpZTBy?=
 =?utf-8?B?RUIrVU5ESVdlMGowMWVTWFBBVXhpVWV2M3NRZ2NURURuU0dBTWJTWWxNaXBN?=
 =?utf-8?B?ZXh5N29QNS9VZFpvcTV6dEFBaGZZaUNYa0V3UkZabjA1VmdTQldsaGtrb09B?=
 =?utf-8?B?Vzhvc2VYUmorZkNXWTd3VEp2TEF0a3FDckdDQzFXUFpURThob29XSW5VOGE1?=
 =?utf-8?B?eWpWMy9BL01KOTZwa3NVaXJUeHE1MnNLd3U5R3FubDlsc3MveXFTVXVSM2NB?=
 =?utf-8?B?ZXVhM0phTnBWdUtwMkRZcDQ3V0E3bS9SL21pYTVXTjFVcGJvem83UFRBMW0y?=
 =?utf-8?B?VGVZZ3h2anJ5cHcvYlB0U1RaZ3d2TlZneVpoYktZNjV6YXdMTG5kdVRSTnB3?=
 =?utf-8?B?ZGxQa2VUdUZWYklubWlnNWpSdDNxWVZrZUZMb1NIa2xjZTlDYW5ueitodHNR?=
 =?utf-8?B?aDlKcmdrQklQNXJCSENEKzlOMFZnVTJFaFN1UENwR2Q1aTdlb3FLcm93K1Aw?=
 =?utf-8?B?c2VTcDZ3MHJCSE01a1RYNWtxT2tnSkd6ak9OaWZEcmNucnlyTUhCbDVZR242?=
 =?utf-8?B?WUEzWEM4V1JUbXFzVi85V1N5blBBOGZaVjR5S2RRWUpiQTBYNGdoUzNCdGtV?=
 =?utf-8?B?NXN2SlVMaHluZWY5TmxSaVhjR1VBUXRnS3QrNURJM0RYY2k5M1VRS2ozWDBs?=
 =?utf-8?B?STIxSmtPVlkrQUFkcGEvZDhKNFo5Z1lOR2VPWEV5aC9YK3VyMW1RMEN6eUIz?=
 =?utf-8?B?bmE3NGE4QWpBRFdHUGpLamdoeEtRL2hjeXpubHJ6THIxbUtFTVhCU0pzeGFs?=
 =?utf-8?B?eFh6d0pwbTZ4S3dpUmxoVVVMRVdacmc3dmdxbElwcWQ5bytuUEdnaGsrMnQr?=
 =?utf-8?B?V2RZT1NMbkdLcURvMW5sREczUUMwc1hQYWwwQ2V5SGx0RVpPeTBqWndOWnFv?=
 =?utf-8?B?ZExBRHUrTmFuMUpnMUZuOGY5bE9tYWJnREtBcG82bk5iRXRxblRGZTNaZjFG?=
 =?utf-8?B?REhqdHoyRy91d2xjNTdpcWlGSE5SSUthS2xRWDc3Vi83WUJRN1Qxcnp2aXZv?=
 =?utf-8?B?OUVjY3VRcWI3SjdGYjhPNkJGZWxWMWdYalZJb1Y3cjlISG1WR1RRYzRoRStR?=
 =?utf-8?B?SEhFbnlDdExDSUVOTVZsdG9uMWdoaWFHS0txbTFNMWxlL2h1enBGcGhxRkpz?=
 =?utf-8?B?MkNQZ0VwZEJBOUFYV0owODZRVm1YQUJjTjY2NEhhcDJsRTEvU0kxZDIwZnRs?=
 =?utf-8?B?Mk9ybThhTFI5SFhPSFNSOTliejhseGZFbG5Ta0N3b203VkM1VFBZWmpPdWoz?=
 =?utf-8?B?Z0xiSmFTOGhxNjd5L3ZVL05vd1ZZSFB6Tmk3NHJZcVdqVGJ0NDNDK0l6N2Zs?=
 =?utf-8?B?Smk5bVdlK3ZOd2ZETVdNT1JPSHdEWGlHNG9SRG4zRVhBcExuWkVMZGxxK29k?=
 =?utf-8?B?dWt3bFB3eWg5YWxuTE1RVnpxRWJ2OGtGeXY4cGVQakdvdHlXTklkazBVOGxT?=
 =?utf-8?B?b2kxOVcwZ0JFMVI2WkhHaE0zSGU3QUJLNmFMVGpmQ3Z6d0hnUE5kaU9vclNn?=
 =?utf-8?B?NVBCUEtWK3F4aytyQkNHaU0rdktTQzdxK3dNNkVkZ3dIOGlvbS94TlJJWWNk?=
 =?utf-8?B?bVdpVjUwdit2VlpzdXhseUZ0a3hvNTlsdThoenJmVXZxbXRqL285dFhjeHhI?=
 =?utf-8?B?emg3R2htbm42ZXl0NXZkUWthS25UWUFSMzZJWFM5WExtMEJNVHdNbzRIVWF1?=
 =?utf-8?B?YWY3M1Z1c1BkODMyOVhoeGxDbFNUckFjTjgwSXoydzJZSEZQWGZzS0hZNS9V?=
 =?utf-8?B?RnlRMVJzN2RhdkVTME9FWGphN1JpcHoxVHByS1U2QXUyZ09hR2VUVzBIVnRU?=
 =?utf-8?B?bEh6NXRWamtzUzB5ekpZMXFmY0Nmd0tiWlg5QTRYaGNrSkNDRHJjUlZrMlg0?=
 =?utf-8?B?OGlCZVdMN2h6QSszbUJYRElGK0VFNDJBOFoxN1BjVnVCclpOSzYzRnFNeFdn?=
 =?utf-8?B?WE5sT01vT0RrbWVhdmNLQklnY1pMQkxnQm13ZUhISC9DbVJKdjdheVdjU3hL?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JFASbuOxAaB9lY5d8/poibsObr/Au9uaLYbri+CdclPriogHXCW/T4c5M4hp9vP5BPcDDUEEq6t/Mnxu1p/riaJSu9FfkO0gZXKt5pB1whMibaJhSU4mCK60UgRLmz6gaCo9OwMg/KoGvx0vz7+xjcsjFD6F+qmDNZh7Iijfb4kRmuX9IKSFyc4s2oiqcCXgoAYO/JcFG28KLFSZrWCY1NMmsQKTU1+193ST/5YW7MMrc5CmQ2WNeY9nOLcRe9n5jnXrzn1XJ6uuWxjSduDBBv0j9h9hkYKUKH2fLcrgxGvKblV0nQ31lodHrFxcbGh7FU+Nh6BFoi38OsgS3/zTOVBsUPT33ExFgJZPFcCskOPUXuN9d8dqopfAEmfglR6wUuQb8EqnW7kxO7vP0gkT+ofoQG/gP5mFk5ofw/8UP8gluaNX3gcK+bq87W/HTyKf+uM8WJ0nebyp5NQ7H5kUiWxdg0Lrp/Uk3+ixXZDmlt2PIeOCe4Dtg4OS/lnyn9J4cazJQnmk2YUlq1BPigonopehDHfArDNlRiD7Z/GJjTuCYturUW88jv7L/RtumRRNyorg2j8+S/ImbZhA1+7yti3K9yap7a7PNZD20zUE0EE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8bcc85-ab84-4d8d-095f-08dd4f576349
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:31:30.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQemWP4T2mwIxrVFSZUd1ZaS4Ai8FI43b4RFpa5JVazRW48VoCcUcgOenJ2b4A2ZD5WQ9jWWUX88j0OL5OggFiv7lqWZI69uqbSxxV2cDWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502170117
X-Proofpoint-ORIG-GUID: 9DSwPxevLdo_yjRdUX56M-h_f8lOSHC8
X-Proofpoint-GUID: 9DSwPxevLdo_yjRdUX56M-h_f8lOSHC8

On 14/02/2025 03:35, Jon Pan-Doh wrote:
> Allow userspace to read/write log ratelimits per device. Create aer/ sysfs
> directory to store them and any future aer configs.

I don't think it's neccessary to keep ratelimits in a separate directory 
when we decided to we keep the rest of AER attributes at the dev level.

> 
> Tested using aer-inject[1]. Configured correctable log ratelimits to 5.
> Sent 6 AER errors. Observed 5 errors logged while AER stats
> (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 6.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   .../testing/sysfs-bus-pci-devices-aer_stats   | 20 +++++++
>   Documentation/PCI/pcieaer-howto.rst           |  3 ++
>   drivers/pci/pci-sysfs.c                       |  1 +
>   drivers/pci/pci.h                             |  1 +
>   drivers/pci/pcie/aer.c                        | 52 +++++++++++++++++++
>   5 files changed, 77 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> index d1f67bb81d5d..c1221614c079 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> @@ -117,3 +117,23 @@ Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>   Description:	Total number of ERR_NONFATAL messages reported to rootport.
> +
> +PCIe AER ratelimits
> +-------------------
> +
> +These attributes show up under all the devices that are AER capable.
> +Provides configurable ratelimits of logs/irq per error type. Writing a

This sentence seems to refer to _one_ attribute and mentions IRQ 
ratelimiting, which is not a part of the series.

How about rephrasing this section to say that the attributes allow 
configuration of the rate at which AER errors are reported, with each of 
them dedicated to one error type (correctable or uncorrectable)? 
Something along these lines.

> +nonzero value changes the number of errors (burst) allowed per 5 second
> +window before ratelimiting. Reading gets the current ratelimits.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_cor_log
> +Date:		March 2025
> +KernelVersion:	6.15.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Log ratelimit for correctable errors.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_uncor_log
> +Date:		March 2025
> +KernelVersion:	6.15.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Log ratelimit for uncorrectable errors.
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 167c0b277b62..ab5b0f232204 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -93,6 +93,9 @@ spammy devices from flooding the console and stalling execution. Set the
>   default ratelimit to DEFAULT_RATELIMIT_BURST over
>   DEFAULT_RATELIMIT_INTERVAL (10 per 5 seconds).
>   
> +Ratelimits are exposed in the form of sysfs attributes and configurable.
> +See Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats.
> +
>   AER Statistics / Counters
>   -------------------------
>   
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..16de3093294e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1801,6 +1801,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   	&pcie_dev_attr_group,
>   #ifdef CONFIG_PCIEAER
>   	&aer_stats_attr_group,
> +	&aer_attr_group,
>   #endif
>   #ifdef CONFIG_PCIEASPM
>   	&aspm_ctrl_attr_group,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 26104aee06c0..26d30a99c48b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -887,6 +887,7 @@ void pci_no_aer(void);
>   void pci_aer_init(struct pci_dev *dev);
>   void pci_aer_exit(struct pci_dev *dev);
>   extern const struct attribute_group aer_stats_attr_group;
> +extern const struct attribute_group aer_attr_group;
>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
>   int pci_aer_clear_status(struct pci_dev *dev);
>   int pci_aer_raw_clear_status(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c5b5381e2930..1237faee6542 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -626,6 +626,58 @@ const struct attribute_group aer_stats_attr_group = {
>   	.is_visible = aer_stats_attrs_are_visible,
>   };
>   
> +#define aer_ratelimit_attr(name, ratelimit)				\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *attr,	\
> +		    char *buf)						\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	return sysfs_emit(buf, "%u errors every %u seconds\n",		\

The convention is that sysfs files should provide one value per file. It 
won't be just people interacting with this interface, but scripts as 
well. Parsing such a string is a hassle. As we can only change the burst 
of the ratelimit, I'd simply emit pdev->aer_report->ratelimit.burst.

All the best,
Karolina

> +			  pdev->aer_report->ratelimit.burst,		\
> +			  pdev->aer_report->ratelimit.interval / HZ);	\
> +}									\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *attr,	\
> +		     const char *buf, size_t count)			\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	int burst;							\
> +									\
> +	if (kstrtoint(buf, 0, &burst) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	pdev->aer_report->ratelimit.burst = burst;			\
> +	return count;							\
> +}									\
> +static DEVICE_ATTR_RW(name)
> +
> +aer_ratelimit_attr(ratelimit_cor_log, cor_log_ratelimit);
> +aer_ratelimit_attr(ratelimit_uncor_log, uncor_log_ratelimit);
> +
> +static struct attribute *aer_attrs[] __ro_after_init = {
> +	&dev_attr_ratelimit_cor_log.attr,
> +	&dev_attr_ratelimit_uncor_log.attr,
> +	NULL
> +};
> +
> +static umode_t aer_attrs_are_visible(struct kobject *kobj,
> +				     struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev->aer_report)
> +		return 0;
> +	return a->mode;
> +}
> +
> +const struct attribute_group aer_attr_group = {
> +	.name = "aer",
> +	.attrs = aer_attrs,
> +	.is_visible = aer_attrs_are_visible,
> +};
> +
>   void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>   {
>   	unsigned long status = info->status & ~info->mask;


