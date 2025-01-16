Return-Path: <linux-pci+bounces-19973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA353A13CA3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97AA3A789F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4785C22C9E8;
	Thu, 16 Jan 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S07y/S46";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FEdmGKph"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD522BAC9
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038884; cv=fail; b=fdmtJhr3KcRfpy+8sne6xHEzLMx+P7HseCs6/0U45yie/ltheoil/5pL5is8BuJJnxbyMvlHgunCgXge8Myo0SA1+a1hKsf8FR7XSWOh73BDK9KRN6dO+c75ZzivtGp7/p18AKlTKpd0KlXpjFGarUjDDuLFML1v1+/6faRduwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038884; c=relaxed/simple;
	bh=o8Wt5l76/nWbZ4AH0wSnlofF+GiOTzWoxolnDfv7tnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pWJDDORZbBAmizOo/h+PyyNL77nC0oPtQalVY4o/fnBHqEwBBvDtv+e9tTTnQzFMedcGgGZAf1SG3YGgD94L7WpTHS5SeME0NoSKAlsm2e+l7lGLoa80oxJCv4lSaqVO5AXy6MsPgzDqK7Is4IqDVLe0PbZ1xKx5ZdNuobY7+Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S07y/S46; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FEdmGKph; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBN11t023684;
	Thu, 16 Jan 2025 14:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QgfvNa5VVCmj1F3EhY8WqXd8CPKMS8pSMmf+/fU0yRo=; b=
	S07y/S46yzUHfHtYzhbHUA53n101RUVwC3YJKLPcrPlPfmZopUjRUpap+DFqwcMJ
	RBU8KmPt96uZ9CQxrE7+4f6vmOqP28kKNdHPjiaUxC/r97JTWxHtEPykLKMqjAoL
	prNFs2dzwzVdDo1wsPwzeVU7R0f7NR2hzj4Npfpln6OP/OHroKU6pJSMYONKehDA
	csa2PYRXAygr2H1DsTkKM0Flw0pfRPKvQJOnx7vbjU24QGFryu7UG/DVQPHUbjxM
	DQNHh8PV0OkwxI+Y3YWpL+yQF/0n3tkWIBz07c/Pw18muZJARibUi6RzHq18RlCt
	uEKo/wLdguGAT0q09DHyUw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjatcn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:47:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDtcO5005236;
	Thu, 16 Jan 2025 14:47:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4473e5234s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irYGM6xKorNFwLFE1QEhyY76YJOq7223LWZnDEgiEe6HEss3ATvkVQIUso67+/wLmf7jTabbBrKDr+51/xfTgMIDEayxbDbkIsRrQ0xilREp3NhcCUZUd4Yn7pNtpeVVCpThf0QHtmRyw6xdAseFuqPG6HJc8dILGbCbbNsmniLaAIDxoWpHNVUrQnGgLqw8es7TPe73g4e5EgOiVQMiWtskFiZtLbTggNMEpjzWvgC4v/5W3oOcP00lmjHYzdwEblZ/i8CwgoIX9bCZIaEqp/uoAnoASHouZYf/4diZGhyso5n7BVxwKUOhtgMyQhqA2QIX7JGJKtGvtrzR0idtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgfvNa5VVCmj1F3EhY8WqXd8CPKMS8pSMmf+/fU0yRo=;
 b=yMp6QkHXrhOqgVy/oK/RpXQ7gFLYOoSQ3v+HgHiwyuTnc6PcZj5qsW+DX6avB6pO6HmKHnQxuHAswloOIKxSqWkXu7RytOycqSid+wSiwRFQDGnf2AaRaWbCEtH+LJoLjPVyWFxtIf/11s3oU/EtYPck/vZazZ2k2lXJha3DWBr02AMhbOh2hLgYnmcbk5HraGeeIsDw6PXJ4aSnN3Qr2YG5rw8NImn+zIQ9cBxFcf+IEwbM8BCwYf0PA3Y+5TCAdoxg8do+1vRMJ8uOYwC/Jl0wSk2kw5NL/BCSrLB8YAdx+vkPbiXnH2xPS2dzV2Qd/tsS46xfom8NkltfTJBiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgfvNa5VVCmj1F3EhY8WqXd8CPKMS8pSMmf+/fU0yRo=;
 b=FEdmGKphLqfpkZUPGUKjTG20TsoGei4AifUNyurbMnt+0R/1u/3itvkbrlb38FzCng8Qmy8KoQ4h92sybnOUq5we02l5LYNVmD08rzXVONiWeY0Of0GQA05RBqBjnymfiS31ROKIza4ymmZE9E/sYTdjnAw6FgiGrCD87rHcJTo=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 14:47:53 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 14:47:53 +0000
Message-ID: <2448a813-1cce-4bf9-bf78-f84daefa1289@oracle.com>
Date: Thu, 16 Jan 2025 15:47:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] PCI/AER: Move AER stat collection out of
 __aer_print_error
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-3-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115074301.3514927-3-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d6d108-87d0-4dab-d3a6-08dd363cc16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDZKSHZONmVkL2p4TmVJM2g2KzArU3RLM05kR1R6d2NmaEdiNWtrL2M2T0RM?=
 =?utf-8?B?NUtLYnBYV3J1V0dWdmpqTi8wTnQxYmIrVWs5Y0RoN3dESFpVTE82eFJFUTd4?=
 =?utf-8?B?WG5WdEtYTUJJWTA1TENyY1NGQ3RTVEthSHByUVVFYUpyT21QNkV2OUdYR2tQ?=
 =?utf-8?B?djJjck9CbGhIeG9JSzRSVnp2aG9ITGtTbUFkNkl2aHhmVlhiUzAvU3dKdkIx?=
 =?utf-8?B?bmEzbDI1eEVqUnVLaGQ3WHdOSUYvUmpaeGJRSjgxd0tjemJUWHVtTnVWOWpK?=
 =?utf-8?B?YURlU3pwblZvemQ0YVUrRjN4ejc3eGJJNzY1a0ZUQ2VBS2wyeGk5M1ByclRq?=
 =?utf-8?B?SDY3aFY2MnJ4ZG5PQ0NvZ0w4eXFOMWUzbXl1WitNUnZqSzVTWm9TZzZmSDU1?=
 =?utf-8?B?dXJ6Y3RDYkxwMUszUldjQndyZzg4SEdCQzRaOTlYZXlobXExeGhjR1RZL3Iy?=
 =?utf-8?B?V2J2OGt6QXdpUzVQQ1ZQV2JCSy8wOVhmVkE5L2JLYmVDa3h5ZkRzbTdLcUhD?=
 =?utf-8?B?ZTlvVUZhOFRIdHFzckJOZmpuR0JyVVM4MlRKcXhFbGUxa2ZMK1A5TkM3bXJP?=
 =?utf-8?B?N002bWNLYjhySTRRUXcrSnZBOSsyckN2UkJQSU82QTBENVlXSk1EMEtiWmly?=
 =?utf-8?B?dytaRmRUSVZCVjY1QmdoUkl1WFA5RUhyYTh4WFgzeW4zYnFqOE1NNStTMHd1?=
 =?utf-8?B?MVRNNzE2S1FBaUdxRlR2S1EzTms3Zis2dW5ERHdKeU9Ma0JBUlJvZ3ZaTWl0?=
 =?utf-8?B?K0JIMzIwbjNjVWpTVVRSb2M0RmNuQVpoemhiR0lTejFKVTBIRnM1VzFDTERa?=
 =?utf-8?B?QVYwQVJVWllJb0JSODB1YXpGSXFDZnBLOW1RQVJsa2grN3RVZXpMRElWSjRV?=
 =?utf-8?B?Q0o1QzNPcTd2OENvSXpjWEZYcDdMSHdHSER2SE5QZHRTVjAzN2RRV2kxVER1?=
 =?utf-8?B?YkMzbUZ4cVJtemlCTGhvV2kxbTNGYW1EZU1yeitWRzFrTkttVXQ5ZHAySUhw?=
 =?utf-8?B?RmVQcWxwcklNSHdMRzErQjFjTGI5YTMxRGdtSDVDRTc0RGNLUWMyYnJnQ2hh?=
 =?utf-8?B?eUVYVzhUMVZjUUJwUysxenppMmRwZlBndkQ3c0FLN3Q3dXF0bG5XQWhJUnYz?=
 =?utf-8?B?L1o4QlppdXRrNkNLdDBRMC9ETU05YUF6QXlWRHQ2NG5STEFVRjB5cnFvRGd3?=
 =?utf-8?B?VTN6aVJYbkN1dEorcFltcFBtd3Q3M1czbjFaVUtiTUM4VW1FVWxZYlc5YWFu?=
 =?utf-8?B?cjMvOUpCeFNyMTlQLzJpOHJRem1Tbmx2ZldWMjA5YW1ROTZDZTgxTW1jQldj?=
 =?utf-8?B?Z0V6dEhsbzFXSm9pM3lkdkJ6NitDejVZWU9FcW9iQnJoNjJ2MnFORms5YWl4?=
 =?utf-8?B?TmFoSnVlSldkQUpuWjlsT2hEZ3NEOXNtM3QwRzkwYlRNanhiaUc3ekxzT3V2?=
 =?utf-8?B?YlRBZzJTeEJrWVFiUWVXeFJ1eXV2UzMrYnV4OGVUUzRoQnJyNkkwc1JrNXh5?=
 =?utf-8?B?enRURElVckNxclF6YWFSVmNFc045UnFFMUNxUWluVlBza1FHME1XRG53UHpY?=
 =?utf-8?B?WXoyM3JpUTZyNDA1RmxSbDRwc01ac0I5bHVhdDVxZW1Mdi80cXNiOUJCOG8y?=
 =?utf-8?B?K3R1U2xkalh6cWZsWGxDOUp5M3RHNlBtcnVLbmFoWU1MVWdlZWxXMEM5NGcv?=
 =?utf-8?B?aXVzZVFDczNoYm4xN0h1UHBDTFFaa2VzWXdzWU1qK0Y4cFA3MVkxVkFUUm1O?=
 =?utf-8?B?Wlo2V2sxdzNYM053UVNJSzRHMGFUUWZZVXRXQ3l0Q1JVSklkUjQ1MFV0dlps?=
 =?utf-8?B?UVJvN3BJZ1QwOUUwU3UwdlBoM1JGem9xOG1oR2xvdXZWY1o2cWlKNHozNVhh?=
 =?utf-8?Q?qKPGtZZzI/v07?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1VONDZMYTdzMk5mWW1hbVdxK0RuSndWaXFIaEFFTEZ3RDBCb2NMWFJLZWNs?=
 =?utf-8?B?ci9uV2gvODdJeXZtRzVmcGlJTFdLTWxNYnB6c1pMSCtSQkg0ZkhkSFZyOWsx?=
 =?utf-8?B?ZklPQTdqWXRrUThQeld5b0kydjA3cWpUSnVRYkk1TUFHVXRudjAzQ2xYSDZj?=
 =?utf-8?B?MjlGUTJscFJuS3hOS05NVlJUeU02TWFvdCtxZElwQ212NGxjQi9IRTF0bVcz?=
 =?utf-8?B?M0x1T1J3MzMrSnh6Ym1PcFFkQVFCd21uRjVjNTltbGZ5MXdCbnUrN3lMY1Z0?=
 =?utf-8?B?UDJKYytGVXpLQ1h3WmpRekJIbmNmaitFaTVPY0ViVlAwNmgzWDZsZFhSV0hu?=
 =?utf-8?B?MVgyL3g4QlY1NUp1SHZYdzlXTTVuK1E4WGpXOE1HbEpadElZZjRaMHJNK2dC?=
 =?utf-8?B?M1RuUXFacmJ0MWY0Y1lEcERpdEI5TVhzcTdqb0VubG80akFDbE9TRkdPZVlT?=
 =?utf-8?B?czlSQjlDTTE2YXY4UzZvS2tIcHVZSFlTdUl2Ri9VSzJkSlIrNW9teTJuZVBV?=
 =?utf-8?B?Tk5VcVRDWW1CY1NhYmc4TmRoTEkzQjFRN09yNUxEWHhDYTFYUXRGYlozV2c4?=
 =?utf-8?B?T1Vablo2MGlNSUExdk9QQnZXZzBlNXl1Q2VVSkdzUkh6akQ5VkVpNHBtZ2FQ?=
 =?utf-8?B?VnRoRVpuelh0aFpWTlpPcnBBQ0s1YUt5ZTJWU0ZQVEpGT3FwNFJ6Y0FuTitJ?=
 =?utf-8?B?OHNjMm9hRnlOL0QyWWVIUmJ0eDdnMUptd21HekNaN1ZxR0JkeXVuUS9uWTBJ?=
 =?utf-8?B?VHEvV1JKSzBmdWk1ZUtlMy9UN3dualJkTnErZU9ZZys2L2tRengwaW9Mdi80?=
 =?utf-8?B?cjFhaVhONGpLYnRLd2U2alF4N3plZy9DaVpZMVlpc3BQNXdaNFRyaFd0REhu?=
 =?utf-8?B?S3ZCRmo5bWt5Vy8rdzdvYm5QNWtaaU5MTVI3UjVtVkh0aGtFSFZUVnEzaDZQ?=
 =?utf-8?B?T1U1UDN4MjZXWkJmL09kTEhxS1IvaUNCMGYzUTBuZDJOQkN0U2pKZnBjREVV?=
 =?utf-8?B?YmRwR2dlZnk5NGFMSjZvM2VURkRtaDJ6OFNoc1EwWGtxL1kwdGJqSlhJdUFH?=
 =?utf-8?B?WDZFTmRGSlgvSzdBaE92SzJEZEQ0c2J5ZSs3N29nTnFjNU9Na1VOQ2FsNlEy?=
 =?utf-8?B?VDNjUUd5azlLVGhLUEFBUmxnNjRPVTZWNGdmMHZ2ODBsRlFzRGVydVRUL2dq?=
 =?utf-8?B?d29VTXdjR2JHZzVObGljOEF3cjI0N0k2Qjk5aUlHMjZOSWNaSzVsRkxSQlBo?=
 =?utf-8?B?Wmp4aDdULzA5NllEMFkrMHBhOVplSjYyb2luOEE2UjVnR0NRdlhjK2FObDhG?=
 =?utf-8?B?WHBLTVExUFdLZElKQnc3NUNIZENJYWdEZm1lUTRvYjRoZE9EM2xiTmUxdlJ1?=
 =?utf-8?B?TlZYdXRSUjJvbWpZbnVHTEFGZlltd0FHdmVHTUtaOFVONXg4UU90bXdwdVVJ?=
 =?utf-8?B?MmZEdnVlR3hXcmdJeDZDODlnRUErUjdzeDNqTjZHQm5GcDNtTWtLOEczZi83?=
 =?utf-8?B?ZzZ0N01HTGtDbkI5Z2c3WjJPU3psZ1BUcFo1U0FJUUdVOC9aSnBXaTllSmhQ?=
 =?utf-8?B?d1BhOEFKRlF1SWUvOTRRSi9MRmFZdlpWSTd5OE04cXlSZ0hpY09DS2pUOXRB?=
 =?utf-8?B?OUcxS1pMNUh1cXNzSy8rVkpHM01xa0dPbW9ZdlFCL1hVTUE0a2Y5aFJQN1Bq?=
 =?utf-8?B?OWdkS0lXWnBBR1A2SUk4TXhhV3djeXcrYngvOVFMc2hkN25kd0Z3RDFzUnpU?=
 =?utf-8?B?MEpUaXd1ZUZ4N2JYVytPblBHcm5mTnE2Szk3eXduYlUyOThNKzRGKy93b1h0?=
 =?utf-8?B?WjZZUTVVSjlCNFBxOTE2eExsYXVKdWtCWUxZQU0xNVdSQnEwTVhLd0ZoTFU2?=
 =?utf-8?B?WHRmTHJtMHJ5R01tMkcwZ2RjRTh1REpqVHpNY1JnY093VXRSTzJHNmZhdGx3?=
 =?utf-8?B?ODZaeTB4NDJWenI0T2U5TUJOSlQ0NkZzWjJlRDQ5bm9mU3dibGNBU3lkT0Zk?=
 =?utf-8?B?YWgzcy9DT0d6TjhsQW1rZ2ZMR1JiWTkrZnEzQSszTTVjaUtkQ0MwQTJMN2F2?=
 =?utf-8?B?TytFQjRDeUwxdkZpck1vbERXM0lmMXdNMWh3eloxSnBmSHNZS21WQ0FHUFRY?=
 =?utf-8?B?Rm1yd3FaZVRiend5Z253cDB6OTd2a0huRVVzMVVKQ1V3QlgyK0FoTTRBcytU?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EuamE4HSwxuGP7ujqQ3uQb2TpPs8BZ+gbAfI8awQaqfQG6kYiIcboLeiO+BJcHOuCvyv9Aris9KmRJezlGRkFSw+DDJhARcWl8r3s4nolTxPM4lseB4sIc4QMtscc4FB/9DkMh0pXoPa5bubd4aqIgkMNQXfs6dw5NiwnJNZKLznm/eVLAz0TZi4jxjJENfMIDI7jvbTPwD1JfLXf1n9P/2QMrXvoFS+qKHIRvQhH1QEkgHkXNfgiGfeD2TvL+gw8uRrunvcLgPd8NgfAQSDfKxIOLksa9GiQ6KeCg1hvX3yPmEDK2JbE2/mP57sd+VVk04AHjevB9vYBeAhPJZw1wuPPALWXL1q5CGP21J+UEXGPJZQ+8k1OrjfOpDXzRZhtLCLvhGpMCPyCqWesOgWDua2BLN1mddPGNWZq28Uzx7G+jscujlZy0uCAyHvVCDUvovZ3MqMXZ9MEkFOuy7gDFEFHJ01kgJmYpEaRWA6Cy1yf6bfUdmPgALR3AiTjMEUfHLsoei3bnIMnwXGDXsuf3hjnB02Ukl9HMD4JOwnLcr6XUFXrMkdWpWJbTNLbERwPWNpo0pCGFzDPQn4wStumeatACAYu5qLiVwf5ik17Z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d6d108-87d0-4dab-d3a6-08dd363cc16c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:47:53.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: era2EIENBmJb8nDu7kDpz/mZrwsg5LcuN6Yb/lJM7FFCHrg+C0D4u+v6+oHxUK4yBLqpf6ohcMjHS58np1JtfjIHPK6O+kqfZf7B0FRv8mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160111
X-Proofpoint-GUID: xeB5PTRJFQo22ut3BIunh8raG9neTzjf
X-Proofpoint-ORIG-GUID: xeB5PTRJFQo22ut3BIunh8raG9neTzjf

On 15/01/2025 08:42, Jon Pan-Doh wrote:
> Decouple stat collection from internal AER print functions. AERs from ghes
> or cxl drivers have stat collection in pci_print_aer as that is where
> aer_err_info is populated.
> 
> Tested using aer-inject[1] tool. AER sysfs counters still updated
> correctly.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pcie/aer.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ba40800b5494..4bb0b3840402 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -695,7 +695,6 @@ static void __aer_print_error(struct pci_dev *dev,
>   		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>   				info->first_error == i ? " (First)" : "");
>   	}
> -	pci_dev_aer_stats_incr(dev, info);
>   }

With this change, we stop calling pci_dev_aer_stats_incr() in 
dpc_process_error(). Is this intended?

All the best,
Karolina

>   
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> @@ -775,6 +774,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> +	pci_dev_aer_stats_incr(dev, &info);
> +
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info);
>   	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> @@ -1249,8 +1250,10 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>   
>   	/* Report all before handle them, not to lost records by reset etc. */
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info->dev[i], e_info))
> +		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
> +			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
>   			aer_print_error(e_info->dev[i], e_info);
> +		}
>   	}
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>   		if (aer_get_device_error_info(e_info->dev[i], e_info))


