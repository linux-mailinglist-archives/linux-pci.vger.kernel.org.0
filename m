Return-Path: <linux-pci+bounces-20136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44620A16AAE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CF33A1D18
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB06197A67;
	Mon, 20 Jan 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jwi4Af37";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iPKV+/A9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E218FDC8
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368726; cv=fail; b=uf7j54TKhM0a1LOE5qTsMTgDAWbh2pZHIe0mCBPwGQizHwz/gPnfgOV5SLD1y+6+EFFbV6c9nKKXof4Yqit65drHQ5BhntCowDLIuX2gQ+W3cFZf77v5sUKt/HZQ5P3vr7Hl4h5AVJgO7wlsmVxlI2/3S/Si94FamOqEfWjjHqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368726; c=relaxed/simple;
	bh=GssSDstl73fYCyfCRovTc3VghFIt9kq3u/HV6EkNeX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQV3k7PhqkgCyp21eBH6+WhSWSDtU7wSCNpC2VYziSZTr1XTZQfC7Rw7oNVAZweeaO8FWrNCRFxASghafduGa3KTMoFIMlzMflaGPQ/8YCuwKHfTdI2NUExLxR08AJa5vXiYA6OnIVE1AACSL2wFNBn1UNi2t+K4JKE6ThZ+w9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jwi4Af37; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iPKV+/A9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7fxgX011288;
	Mon, 20 Jan 2025 10:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Mpy5m6j50DdyhEFDP22QfKIjgRxvAqSw3zg1gQEZjB8=; b=
	jwi4Af37Co+CJWa3cW/nnVl9nwFzn7CYsJvlq85tFOGlgIdJsX7Crv9u0h8KUfVK
	PGSOQaXyPd96ORh1gDl74ufOG9RRUTjWz7h1OoFdg5ht9tYwOcWuJ2T4vFMNbFQ7
	5AF1vaLPu5OPrN6bI5OnQT1dvjJVoAA6AUjjukl5L1L9Wynov04RZji18d3IFVgF
	LmBvNDs+ZxjAZDutFXOZqbM/V77ThespwAzoF9QBRW2nGze54kHzadQNXbPg6ASO
	iIbEN8NrtdYcVPQGF4HUQhY84YseYxZhoqlo1UVS83Ebz5FHCpXRUuntOWukvAJd
	iAGHgU0XosHp276vQTebMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485tm3dar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:25:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50K8gUHQ031183;
	Mon, 20 Jan 2025 10:25:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44919173p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f943v5RWc7FoE56XqXPiCnpz0ht4doX8CiO4TX8EiWm/orKDtIqcEup/NuNnEmF+S94L+kBVs8agAIxWBPnVM+jGcAjXEVXBW8uPNwDRz1y7YlEcom6Lb5Ebm9ZVDKEOhBTJU1Fq6weHyQMHUtxZRP3ukl0KIn4FUxsI+zkHGktt9Ib+3BajqVgosXqwIV7IeJF2X7mfwqtbqJiCU1r0w9B0umGu8HoXYIajJlgqESCjPuJwOsZAbtKEkSTOmvM5RDX3FzphtU/iwWeohgHh4yEvNbvoZrWIqwwtJtkMPJIYUC3/TB36FMXL1HjVxP9cXwDu6VHR4dhSibXH/7WL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpy5m6j50DdyhEFDP22QfKIjgRxvAqSw3zg1gQEZjB8=;
 b=TII+aLuLHaHp9ujE5DGNkj6yD1H3n3NF45iiiM86dvnUeB1XQbzBY0K5I0OHAmSGyYDr5zP3h4eaZYVUNdCSxHnNUfb1/RTBRExhWSJsqYAPrvwDgOQPl8YKCrytX1F/spnW4B99npK6JxjUbz0bP2ez+n2Rbab9Kp4TYXWIj5oqz+iPUcuFh159lbj16qLtTG9CzaE13KCaFAmVIZTq1BuzmFursPyA/m7yofOwz2WoBcY6/qAYHoLf2TbaXLEVlxG3DumkDTx99Nb4YxyD8WaUSGjsMYhrYMWtF0KulJO5OKkCxEPeucpwwF0opuH5R5ywdaBWxy6J9gvqEKNXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpy5m6j50DdyhEFDP22QfKIjgRxvAqSw3zg1gQEZjB8=;
 b=iPKV+/A9Gx7pL/VufKRztuMqR2hcf7ccC+dRMokRb6QMRkqMoayOjvKybNnsJSvpXTOV2AW7i3UDIy3j98djEJVdKWsAsDeFirs/7eBXPGqWWNa7uepcRdy3PYXCF/k6bte4OpLLOQUgqUgfiNWIqUDf8VzEjq23WEMYPEO5HNk=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CYXPR10MB7899.namprd10.prod.outlook.com (2603:10b6:930:df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 10:25:13 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 10:25:13 +0000
Message-ID: <55e1330c-da64-49a1-b628-e51f0d04058f@oracle.com>
Date: Mon, 20 Jan 2025 11:25:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] PCI/AER: Introduce ratelimit for error logs
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-5-pandoh@google.com>
 <b0eb4417-600b-4b70-ae5f-d51ccbd5ef2c@oracle.com>
 <CAMC_AXV00AU2UHw1h2WVE+GV8YqTNOsrC85-fWSLrqSu2efWPA@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXV00AU2UHw1h2WVE+GV8YqTNOsrC85-fWSLrqSu2efWPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0453.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::8) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CYXPR10MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ffcdfc-38af-4dc6-f2d9-08dd393cb984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTJmQUpHRm54K2pQNWtYeG9pR0hBeEhyMUFZaG1GeXJuQ0tabk5SMC9iS0xD?=
 =?utf-8?B?MDl6N0xnSytWd1c3aC82TnRTWVYxT1FCZStHSm4vNGlhSFp6YXk4bEl1RlhM?=
 =?utf-8?B?KzhqTHJxMCtWR0xpOXFRdDUrdGljL2FkSEMwYUI4VjNmSVgxNG5HK21zR09S?=
 =?utf-8?B?YktodXgrdkxRRlo5aFc4Z09rNUZHNzZncFd2TmR1bnkrd1prK1hDWGNaNjlo?=
 =?utf-8?B?ZlM1MStoRzdBa1poOVJTdldOMjJxelhZdWR2Smp4c2wxZXY2NzRiSXFMZ3hT?=
 =?utf-8?B?c2VteW1yc29JV2RsSDVwZzN2TWFoQkxDeDg1K0dycVpVVDZmcU9mTjRVajhk?=
 =?utf-8?B?TUhITldEUWhDUUpzWEVEbGRsSTJWRDI0cXNOSTM0di9wT093enlYQU92THVw?=
 =?utf-8?B?WVJRYSt4K1N3Yk5td09Ub2lEeE9FcExPK2tHR1Jqby8rZ1h6QnkxY1pKZ1o3?=
 =?utf-8?B?RW9ISHRCOGdlZW92cDMxbndPWjFreWF4anRMTlNkSzlMK2hIbzhvL2dXQTY4?=
 =?utf-8?B?d1ZBcHFRWVdMUnNYYlZSaTFZRkhIQzhwWkZZYWVFTUxCbnZYeko3aGkyVEN0?=
 =?utf-8?B?QXEzQU1xam5EUWVqbmNFR3FVZ3JscWxOWVVsZzhCYktPOHlFN2VVMHdpYlFS?=
 =?utf-8?B?dVp0VUxuU2hhVXdUczN1cmVUZHZEOWZ3MGYwOUEwdEpmdlZ2d1pkajBQY09q?=
 =?utf-8?B?UFZWOEI4ZEJwK1RrMjRPSzVsVTJRUGNONjhvK1N4cUNpYk9BUUlUM25FQ1Jo?=
 =?utf-8?B?K0lhVDhNaXo5VVo4eUFRMVBhZmhnMXpZY3pPaTFwRW1FUHJGa3ZTZmRsMWFy?=
 =?utf-8?B?TWxnU29iakZ1NkJ1QTlCeFM4NGFORTlWK1FqVmRjV0hSWUZneFhpUVFmVlNp?=
 =?utf-8?B?NjlSZTZwT2FaSzA0Uzl1UVM3ejVLbDJJL3Nzb0Z1NEdWVHVDNTh6bXdXTWRt?=
 =?utf-8?B?NkN1NzdFOTh2VUlqUWFIVllwWHJSamZqZmJveTRDamZVcmpMaDh4ZnJnY1lH?=
 =?utf-8?B?NCtSb1dNdUNjamZPZkQvY3E3V1llQTNudjhZUGYwUGhQQjI4WmRuNzlTUSsy?=
 =?utf-8?B?RGRNNnN4amhZa3FEeFJ1WmZvMHFISU11TDczTkUydVpwWVZhRjJFTGtUUkRo?=
 =?utf-8?B?OURzcGdRa0ZxVWNZYmU1R1I2RXBBbTVPMFg3NDZVZDVTalJSMUY4ZDY4U0dD?=
 =?utf-8?B?eWZpNVA4ZnZDcWQzdloybDY4TWJpeEZUVVZXeUFNeVJWL2hnK2ZtbUMzMjl0?=
 =?utf-8?B?T05VbGJFMUp5RWJadG1WUUtXS3ZDQmZMRWl3c3Jpd29pK3dLWDVSNUpUNnhJ?=
 =?utf-8?B?ZEZublcxOTJXZ3EvbElnbVBqODFBbnN1MEVQb29tbmhKSHFSMDN1czlQTXVa?=
 =?utf-8?B?RzFibWNwV2dBMzdydEZsMTcrWWEybEJ6OTR6dmkwellWRzh2eGFwUnZWdFYy?=
 =?utf-8?B?YW4zZWdRdGhYaU9pWG1abFhlbG1YanFxU3Q0SU5WRzZreWt1aENTM2xwUE1D?=
 =?utf-8?B?V2ZpNHBuRFNHbUgwLzAvSWNwRUluQW0vRm5EYXVmb3ZzZURFL3ZRbzZoT2JL?=
 =?utf-8?B?TDQwYVYyc1NPSGIyeDhuaGptRjhGNEEwMXNIaFVDSWdnOTUzdklMVWhpQ2I0?=
 =?utf-8?B?MXBGMWJZNElGdzF4Y1pPWkZyaWhTYzhCMUE0RkYvbUE3UGgrVXVVT1VDbm5Q?=
 =?utf-8?B?STNydmN6YVVtSjJodkNKZGh4RkdhTlV4VEd5c2tWdWZNMVd3VWNDdGZ4VUY0?=
 =?utf-8?B?c0JPc3EycGlseWt0SUduejhDaGJ0L1VHQnplUldMak5nVm92UzJOUlU1VWE3?=
 =?utf-8?B?WEJvd3pIQVE0YzM1NkJqaTkzZkVZY01LOVkwOVNYN1NhOHE3b1RPb2ZYcHVj?=
 =?utf-8?Q?IYZWxH8rJjK+B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhuRkloSlV4N1lkcE9iQU5FWXFZVzdRU3ZOK2gxdVp4OTY2VXdsMnRmcWZ2?=
 =?utf-8?B?cG1Rbmx2cWprSk1tbkl0WDhORW1ON3ZMWS8yYnFPWXViekVZZnpFZU5zM3JS?=
 =?utf-8?B?T0gzNXF2eXZMMmtPNi9UYUl3UE1ZL0RWZnViakE4VFFtRE44dkorQ2VlQUpK?=
 =?utf-8?B?cnlGMzBYdTlLczhwNDYwSy9VeTA3cXZ5UUZyc3B4cHhDUHlUZm5BRko5WEEx?=
 =?utf-8?B?eTRTaUNnOGFVTnVMaW0zVnlqNm9Va2FjQU5JQjhoT1Z3T25zZVZ1YThXQkRQ?=
 =?utf-8?B?VllvYm15Rk5oMmFvRjRabm4rdDU0LzdTSnNuSmg5RStkZHRtaWczb2diWlJQ?=
 =?utf-8?B?aTVtK3cxemJUbFBWTkxtblhOWlpWMXoyeTZYVDFzTWJqcXpUV0YzTHdTWVNE?=
 =?utf-8?B?TEZQQmNjRXhlTWhtdXI1VHVKZ29BU0IzTGVwQ245eWdJSHJ4YUNQYlBjRGZx?=
 =?utf-8?B?ekNxcWlKR2l0N2UzQ0NEWERaVHZYSVRUU2ErUjEzTmZ1Ynl5NDk0SmVxbk5l?=
 =?utf-8?B?ODNkbm1hNXA0V3Zhc0h1eENDQjJQZkdsRk1CQ0ZDeGJtaUhnOFBFVUw3Tnls?=
 =?utf-8?B?N0xOaGZrSlJ1ZzNybDhPNGh4REVQamVsamlPV3FiZXZmaGVQeHdlRHFuZk9I?=
 =?utf-8?B?NlVBcllYSEJ2a2UvTTdWN0tkY29DeW01Y2xmb3RGS1lDMVdKYUZDUWxCamJK?=
 =?utf-8?B?cEtwTHdqaUVXa2pDOGF0MkRnSlVIcmFRTll6NlVNL052SHRIamxwb3hZVU9t?=
 =?utf-8?B?ZlpWaS9uN29PeFJhbzlJRmFhZFVDQVJ4RWJybXVJODhuZm01UDRnYkZhdDQ4?=
 =?utf-8?B?RC95UzRNa3dYbmh2eFdoMGJCVVBRaWhYdzVwbjVqdTdtR2Z6dHdoUGNMbkRz?=
 =?utf-8?B?VGFPRkZoZGVoYmNNSFREZS9aUWNWeGRlbERsTWFLbGwrVkhmekc4RUlGNlAw?=
 =?utf-8?B?R1dtZlFldFBQOG16eUc1VURxZ1YwWGFUdG11cVAyNWxqZFMwcXNXU2t5NHp0?=
 =?utf-8?B?VjdmTGZGTXQ4RVorRUNQaHlsaWJ0a0JoUjE4TXRXbVdhVHZKLzhHVzhvT0Ri?=
 =?utf-8?B?VG4vZWNjTXN6RytiSll0UStyamF6QTIycnB0eEFGK3dHbC84R2xhZUN4bk9E?=
 =?utf-8?B?blpyK0dlOXBQY2NhRlMwY3VZdWVrN3ZOcjVJTlJFKzVhUzg5UXA2SURGL1VP?=
 =?utf-8?B?MFV6ZXNMSWUweldaODJhQkx3Yzg5SGdscE1nejdzT3JiT2FJOGhTREkzMEhm?=
 =?utf-8?B?aFp5Y3QvSWJLMHdaNWJySkJxT3l1NzV0UDBVeDl4enRPODRJTE5PZDV1NFZJ?=
 =?utf-8?B?UjB6NURHUDIycmQ0em5reXBFdngxRUMzV1dMeGhDSmMyN2NCZlVJcDJtL25z?=
 =?utf-8?B?elZOKzY2MllvUGNocE1aYjJYTWxlazI2eDYvL3FMVXllRXpEMEZXTjRqNlYr?=
 =?utf-8?B?eTZvb3dKcDI4SW5JWTlHaC9XR2RYUG1aQjlLQUtSbmpWbmtDdVpJNWpKY1ox?=
 =?utf-8?B?TWNCbkJIL0VCNld3bFN2MVlTRHN0YThGcmdXS1Jpb2V4SEZITUpBVnl0MDJ3?=
 =?utf-8?B?WitPcG1LNjRFL0JMNU85bGJZTGZjN2I1MVpqYU9LWHNKWU1MS2hwMjBRbU5F?=
 =?utf-8?B?YnFXalYwN0RYeStEMWtYTXpUMCt4akp0YWVtZE5TNDBhbXVXRnkzdmIxQ3RG?=
 =?utf-8?B?M3QrUU91MENrUGluYmJFR1dVdW5wN0R4UkcxekZVeE4yQVU4WHBTZXpHNDdk?=
 =?utf-8?B?Y1RZeExhNzNLYStrRzBNQmRucUV4Y1pEbnZXTGVGMG1QVEpwWkNCcWhmaENy?=
 =?utf-8?B?YUkrd3ZDUEM5NWRnWmI0cDhHYVhzTEh6cmYvbXRtZTlTM1hTdXBjNlEyWUtY?=
 =?utf-8?B?NVdkNGFTY05QVlJ4RUlDU0pSR0xOMzI4QkNnYUo3cGl6NUUyK3JqaVBVYVlI?=
 =?utf-8?B?cjB0TnoyL3Y2cEhuLzlVUDJJM2NSRHJ2QnNWQnNCckFJcCszS2ptM2xYZmlu?=
 =?utf-8?B?SXI5dkYxY3djRDZndlhMZW1JVlkzc3NqTFRnZVo5UXF6ZzNiOVhPZ1plNjJr?=
 =?utf-8?B?NUg2WW5JWVdMRThieU9JMzNBbG94WEdxdmpaUUlCcmRZNTcvQVp4eGs3RTJ5?=
 =?utf-8?B?Lzl0MHE2QTN3eGY4WEpCajFlTGdvdlJvNmFrMk9TSm5UNzdSOUVpYlFDMG1T?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UVpLJ/XOFv70Nli0sEHgFnOzhOTHSjhtaNIJjJ/UYx8YqskuOnyuHKZED/hjqNaJYGP1qMHCdgNaFW01X5SO7DhF9PGCSlXxV7vQYHGr+Oj5ZVvfXyTRkwnNqpxLBZyXvtPE9CJQt0kHYAW0YjT0mr4JbAVCx1ru5yJM847h33bmLl9b/SP5vyqOuweLhD5F9lowAAnQ2mra7AJDeEWSCgnS/fzdSi1j4mcYvemOKBAQhXsLJqbWRCmv68hzr0UAVMx9gxAq6RaSF8UlPX0mcDalgalkPZQpXpgPcULYb7qNMoet1Wd/Fw3xJRFHLD+Py+AfOh2pzEbrNa92iVKrppuVCEYaazUVvgqgZepYr+CvPpMUM2Zxvqfe8KiCQ3DWWKQ/cymVegOHYRiganPognCGDPOsitLRR/c0qUFk/iP66xT3MLDOLYodDIVEs59srmrz1kSkLiOuyQjUR/K1Fyw8xqwWZZHaXSPuQAAnpYz7f+M9T2Uv0ud8ecNgJe17Fm3D5ILCx8PxQcoMazJxE9sHyKyq60NYhhkzuaoHSMdbUYEhsYblspH1xZBIb0S2hKcVh5Wk8UPHIwTdyUq6LlTEHrMWuE18Hohdw+KXWKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ffcdfc-38af-4dc6-f2d9-08dd393cb984
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 10:25:13.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQzAfe/NiqPfQhW0yggOqfeqoR4rwq3uYlDUhXs5wEvId9+UMrDZ9YfZiVCsmPOpqITsZmwp9bFiAIGZHqb5JTtgFMxCUgID1d0Anmqo0vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501200086
X-Proofpoint-ORIG-GUID: 8wO4RnTOJLGASeXgRElCFzLYq8EL4uik
X-Proofpoint-GUID: 8wO4RnTOJLGASeXgRElCFzLYq8EL4uik

On 18/01/2025 02:59, Jon Pan-Doh wrote:
> On Thu, Jan 16, 2025 at 3:11 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>> In some cases, it would be beneficial to keep the "X callbacks
>> suppressed" to give an idea of how prevalent the errors are. On some
>> devices, we could see just 11 Correctable Errors per 5 seconds, but on
>> others this would be >1k (seen such a case myself).
>>
>> As it's not immediately clear what the defaults are, could you add a
>> comment for this?
> 
> It seems like the convention is not to use RATELIMIT_MSG_ON_RELEASE (I
> was unfamiliar :)). I'll omit this in the next version. Let me know if
> you'd still like the comment in that case.

Interesting, I wasn't aware of that. There are still a couple of places 
where this flag is used, but maybe it's legacy code.

I'm not too passionate about the comment, it was just a suggestion (I 
tend to be verbose in my code), feel free to omit it.

> FYI the majority of existing usage seems to be split between
> __ratelimit() and !__ratelimit() (though majority doesn't always
> indicate the right thing). The only instance I see of a variable is in
> drivers/iommu/intel/dmar.c:dmar_fault where the variable is used in
> repeated conditionals.

Yeah, it's a problem that's hard to solve at this level.

I thought that introducing a variable to make it easier to read is 
acceptable, but it's hard to defend this approach when the value is 
checked only once. Let's keep things simple and leave it as it is.

All the best,
Karolina

> 
> Thanks,
> Jon

