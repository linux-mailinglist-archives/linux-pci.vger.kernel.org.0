Return-Path: <linux-pci+bounces-24235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85610A6A933
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DA23AA49A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778281E1022;
	Thu, 20 Mar 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EMVGskxO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J+p1/PaW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2E1C3C1F
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482654; cv=fail; b=aZVYd6KjiJU2brBRIh+aBvuqmxKJgRewaVvJWQtRs2GQj3P01eaioCTdhUs3oKLT+v/p3r/9D6MwoFZ2fDKXMsrx+EWIqjLrTgkvAuDLEgKaxy5OePQmC9ICfrc2ICc2ya6ZJowZCejYYeGS/TaKdSRc6LFGPQnLvxKOSzvVxVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482654; c=relaxed/simple;
	bh=g1hsuVrbd0hF3Dc75PgmVdQyEURAUT0l13h5Diz8YQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mzSpw20+JneSO/vl5snBv5+6xn3UvKxopzYisoSM204jwrT9ETgW4GBMro2h+nE8PU453Tgz6wlBqP774HoIt2kNeAYbmq3RUSOQDPzSLhVudf8zxYx3CSzzKE0Kag0Op1WP9Uyb+mlPtfOgZi8EnZy6AfaYw0qGlo5jaug/pbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EMVGskxO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J+p1/PaW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDMqkh032764;
	Thu, 20 Mar 2025 14:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y7CCmDUM8sboxd8d3drn+rNI3qZScOmQxQHYZtIu8Qc=; b=
	EMVGskxOf/pCzdB0jhRqoyFFREjSOxNUkYl2T+smUOVRjqQOZaQStWGXAPuR2U0R
	hPazq6T2LM4l8f42BpiZCot/S6k9OzwrqFfTeZLUD/QUfZVzFNihEm4VW7tj4YSb
	1Q3yA0lZqSHaPqeKGdPa5ivEcc2TkYiSKZjYqlxZ1hAYjCR5mZr6PtdCnPVWCiAD
	yxG3esaApyZGTS97Z5UKzhvdIgPOIF7aSCxOu3Hh9vR6R/4tlEnWIaz644KZ8+eQ
	THMbWzaHx+xKD9bWElqXiD8+W+JSAVx+Nc57MyUMi9ZEeBs1KKYrNIYxxvtUqVH1
	6/NIsma+A/+w7wqIXGz69g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s6q1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:57:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDhwOI018555;
	Thu, 20 Mar 2025 14:57:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdp6m3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:57:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoD2qwYmb4801lpYwnC3BWm988zsT1O5qYqpR1us2OXyYxkaiAnRW6h0qMrn3cqInpvKfAwPNUhOrqpvEhIoW3MdWetmlppFHEZAORhWgaJagQ0VHkJ8VxmgPlSqkK2By2oMSQ20UCs+yyQLPCWXS1/mCFQVYHM83+fIKAZlTPmLX8kNH9VlOq8q1fRqezy8pSANganPToNSseR/w+LcpBVZDy9nvEOvsmiQ7E8j+OszfJRsys0R8tFW0+NCqyNooLq6yFiXqHIBMnvU4KtZTW0VyEaS+9IN/goWo7sNr5SjyWH+jesVfS0KoJBK7E41NH4Ri0g1btJORnlcvGdmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7CCmDUM8sboxd8d3drn+rNI3qZScOmQxQHYZtIu8Qc=;
 b=bNaZDZXiAaMiEVXd9NYksTCeW7QAsGhPmGKezz/If9KoraiN3IZBKTJoETtb3fG1ak00seLNy8LNPWeWQMUDjI3WlCrXxwJwWRa0vY+AEmFg+zzmPvlshlUeWCc/3bxbJoJfX5U3CkyXUbrS0CdLw9WfQesbKYrkvNR1Ct0ggbxnzyXTF9VaPsrIxIXt7YoA5jRWem+0aVGPxWPFCy9obnCfyrb7wHnf+J1kC1+9v13QoKd77GmYP4pY9dHnofOc3O2i23kIxLQQAzz2hzIRYjv7LRQclICroTdM6NswIrVYzHJkM/2hDSvLZGiDKTGY0tGnRQf+W9WL8treC3iTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7CCmDUM8sboxd8d3drn+rNI3qZScOmQxQHYZtIu8Qc=;
 b=J+p1/PaWW8PcXNJsgYmmQZxQxRyyOFGWd2pjHqFl7qWNPzTQnU0h538xNiRaPP/ufEPExWfxs7kb+oPF0y7Z/ngtnyseIqLN5jEWCTjCu00y+J0CaF940vK6iMVvH9kqDMaJ/7oSis+1hNG8nPc2l4AS9Afvvdj/8xCkt0+Cne4=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CY8PR10MB6876.namprd10.prod.outlook.com (2603:10b6:930:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:57:05 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Thu, 20 Mar 2025
 14:57:05 +0000
Message-ID: <ebafe3cc-2d0f-4000-863d-20365977e27c@oracle.com>
Date: Thu, 20 Mar 2025 15:56:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
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
        Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-6-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320082057.622983-6-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVP282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1fe::14) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CY8PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1add472e-0efb-4189-37af-08dd67bf7a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFdRaVdaRCtUekViS0RtTkJydUh1ODF4aHF4cTZXdk1JY1RxS1YrVEYwTEdF?=
 =?utf-8?B?a2ZKdlhiK0lCUGdGYzNFNGZLUXFsYlFCK1pwc1A0MTg5UE5UVnVucEN4SVo1?=
 =?utf-8?B?a3lFSmFWVjRWcWgyY3lnMW5QdGZGTytnUUNWN2tORmNkaUx4R05vTHRKajNQ?=
 =?utf-8?B?SndNS2dma3RVMHN5SFQzRFg4T1lhSlk5SmZYRUgzMkpybHJHZ3MvM2JIYUJO?=
 =?utf-8?B?U0pOWmZJOStHUHYyVkorWTZ0R2dhRm92YUo4bVhQbG9SdngyQ1VVd1BCRHVQ?=
 =?utf-8?B?dHo2T2Y4Ni9lSHRHZklCc1ZoNXJUcXcySXNxS2NjOHE0dHY4a0dzbjJyT284?=
 =?utf-8?B?Z2V4REhLQUd1VC9lQ011RlRwemdPQjU5TVFmOE8zNGNaaHMvL3RWMWJmN3Fj?=
 =?utf-8?B?L0ppZFVlVjBYM2JlT2ZyWklqdmNMZktRQkNrYXhWLytpandlWWZYMGJXV2xT?=
 =?utf-8?B?cnJJelpoM0k5LzZjb2txb2xFYnVlaHpWbTRVOEdBN3Uvb2lOQkNFZVM3Q2J1?=
 =?utf-8?B?WjAwWU5tOW85V1ozMS85MVcxNUN5UDJ6UWZxc2xKL0NBK0VTSHdwWXFHWDJp?=
 =?utf-8?B?ZE5xVDNDNU9QQTVBcEF3Q0xzcGUxY2NXOFRyS1Q5WlVBQjU0bm56cjNSTzdX?=
 =?utf-8?B?ZEpTUXBXS3B0SzBJVXd5S0pMdzlvd1AyeFpoNTZoMktmKzhxZFo0S25YQk80?=
 =?utf-8?B?ZFBnc0QzY1NlcEhUVlpnekJiTGxHTW0vdUVDeHZSWXNWSnVRdDIxZ2R6Sm05?=
 =?utf-8?B?a2hGTWIxZkNjU2FuUzV5NVZOTklGZHRNSExIK0lJZmI4d1FuSjJ6cG5ySHhI?=
 =?utf-8?B?c0tEbnlFSHZTMFQwKzBJckNsTTZkeGl5aCtBWFV4TFdMQklBb1Fsb2xXZlNM?=
 =?utf-8?B?TXNhNGE4a08wcm9lbTEvTEZmY3VjQmh3U0psaUM2TjRCa1BNMlRIL1FnRVE3?=
 =?utf-8?B?cW1WWEZKbmhJU1kyb2laaGVrVng0S3N5UEVUa2tma254bUp4Uktwa0ZPVmhx?=
 =?utf-8?B?cE1HV0VRSWd1VkUzZ0dldUpWRFBaOC9yVTlrZzh0eGZwQW45aHZvelFrQ05n?=
 =?utf-8?B?Slp3a1QrRFZjQXRuNXBOcWRlS1g3TGRkeWNqQzIwMW94WlQ0WGJ1L0FBUi8r?=
 =?utf-8?B?RmNXM0p4bkV5TFBETFArb1NrV1h2dTRmRnlOUFlTTEtPU1hva2NXNWVhbHR0?=
 =?utf-8?B?VXRWK0Fxc05MZ1QxRDYxRzZIUEVlQklFbUhxaGJ4bUJOcUpPWmg5TnE1RG5l?=
 =?utf-8?B?NGhTSnZSVEpqbzJaNVR0K1BQZG5TMkI2NGRJejhUZlZmYlZIcGdNRDNXNXpJ?=
 =?utf-8?B?OG9mVFpwYXZodDR4bk41SDcxRVdZYzA2Q1BnNmZ0TDl3SHVSZXVFdkhOcG4w?=
 =?utf-8?B?VXpqZUQrYjh1WjVpSnR0dHZIZUZ6Um9XdFZVYnZKdkYzRTlHamNrZDFVT1E3?=
 =?utf-8?B?Q3l1c2w4Z29kUjFyTHdhU0hrVGh5QVZjZVl6QnVsV2dqbWhQaGVuOVlyZEM3?=
 =?utf-8?B?SGRYZWZnaEY4TUxRL2dHNWFMRzIwT2QxV0xPK2dYY3NodHNsM0JTUHdPM1ln?=
 =?utf-8?B?MmdnbVNNbndOYW1nZkdCZlIvc2NmQm9VZEYvNzI2Vld3aUtoR09jUDd0b1dM?=
 =?utf-8?B?dTdJcUZxQzk0T2JBQ01IL20rbE11TWhJUmlwb1RjWm00YmJOVkIxcDc4aFEz?=
 =?utf-8?B?VGNveHFXeFVIM28vanB6T3VBdk9aRDlzajM2cEhGaktkQUdyaW1IODBiNWZI?=
 =?utf-8?B?OEJuNmVNejFxQ3hpMjl1VTJpdjJBUlBlbkdTSXhsQTRiS1VZYklDUmp0Z3BR?=
 =?utf-8?B?L3NRUjdrMlNQZUpJWUxaRUJuVmNnSWJoMUYwRnlVR2E3cEh3ZzIzVzJlRzgv?=
 =?utf-8?Q?iUubY9Co58UVp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdyU2NIaDJ2eFM2dkhMM05tRVVrbGxvbEZobU1RWTRGeHVKcmdDL2k3RlYx?=
 =?utf-8?B?cVRyVEJEeWRoYmU2Nk1mZit0NnFvSllXVHd3VEJveUR6ZnBYYlRMT1F5dWFY?=
 =?utf-8?B?TVVrRnNjYUxzb3hLME9JZHNrT0RZUnlSSGt1Ukp0MTNVa3FsTDV3ZmxkSFM2?=
 =?utf-8?B?SXN0NHo0NCs0cDVUQW1Bb3VZZ3ZEWk9XeTFpalhGWFEwVTN5ZU9PSWdGV3lF?=
 =?utf-8?B?NHVuZEtlTnBJZlV3MDREYWgrM2E2YWZ6Smo2d0hLZ3V1RXl6TDZmcUZWdXM3?=
 =?utf-8?B?TXVya3h4cGU2bThpSG04QlhjUjZMZG5EZVRnKzJUOS9rZE9XZXR1NThTQTRq?=
 =?utf-8?B?NGdkRWhhSGc4cDAyd0prdnM3WGNkRUNERXpWOThtTmxyanRtUjkxZXNwYnNZ?=
 =?utf-8?B?SUtTSHBTdU5xMmJCbHFRS0E3S09idlI5MThud1VidzBFMStIaG92V3ZTYTBK?=
 =?utf-8?B?TXBIT3J2RmlPM1gyV0NxQThBLzJjOUZERjdwS0lwRmFMTzYyQzlkV3dlWUgv?=
 =?utf-8?B?ZTFGblZnSEg2VkdFajhPYVhZU1lLR2VPVlFkY21pRmk0Vk5wWDJtVk95MDh1?=
 =?utf-8?B?T1p5dE5CTkc4K2RCU0lNbGNwV28vTk9OUk5vK1EwamczaXFuV21RL2xTbytz?=
 =?utf-8?B?NmU3WkxXREl3dFJlS1JkbC9CT2YzMXNac0I2S3pjQmIrYzRFUkxkekV4U0NP?=
 =?utf-8?B?WDd4eTlicVFZaWNtZjZLa282WHo3VzJrYWwrdm5WMURxQ3N1dnQ1NmI0OFZJ?=
 =?utf-8?B?eUFVdHlXUUxEaHZxUmtyRkpNcnp6Qisrbk8yWlhKKzJXdmExdFJDQnJyUUt4?=
 =?utf-8?B?NC92T2EwWFpBeVJmWGt2b256Q01CUmVCODVkZ0o3YS84UXBKOW1CeHdkMW0y?=
 =?utf-8?B?TDg5OFhidXVTZmJlSDdwVmhGeERISlp2Q0tTTkg5bG1BWXBuK05ycXV4b3Bz?=
 =?utf-8?B?WjhEbEN0VUdHNG51VlRUMTcrVmJqc1dVbmJMTzg0U3VDR1k2TWROME4rQ1Ba?=
 =?utf-8?B?M2Qrd0l3Z3h4enJRVlhtbFc2SWFKdEIrdmZoTjJiSDltVGFCM3YwcEV5WFFL?=
 =?utf-8?B?eVhJVGxhcGthajdXVHQ4OFk2Y2FxOUVaT05ia2NmdHQrenNmUkFicEIxcDR6?=
 =?utf-8?B?dFpCUTlxeUQ3MFhoS01ONDdzKytQaXJxTjRtci9nRlhoekVlUXY2RmhXRXRM?=
 =?utf-8?B?R2V3bkdVQVhaMmJzUGhKR1NiTUdickNDc0kxS3BCazk3SDEvRkRIU2FUZDlp?=
 =?utf-8?B?L2R5LzJOVWZ2TlJZWlVlclNSVUJUa1IwWGJwd0FPaU96aVd1R3dwWXRjZkZ1?=
 =?utf-8?B?NE9xUzR3a0xPb3JqaHNQY0tTUk5RSm5xUm8yRE1yYXVEK1N2ZjE4bXZ2eEhi?=
 =?utf-8?B?aUREcUU4MlNNMmlVZmtIL3FPT2VvWHM2Q09weHBSdy9XVGk4a2pMTVBWYzNq?=
 =?utf-8?B?Vk1Eclo3cVpuZXpkMzE2TWx6emlsY2x2RmtYb0dLZ3dpSXpQdEI3UERmdUJR?=
 =?utf-8?B?Y25yRldLVWVBVVpTdVlXT1A3RUdXcEZTSFZyczFkWmplUWJUb09OTEdCTWd4?=
 =?utf-8?B?K0ZPdGdrS00veEZIV2Vtakh2a2JEdkpOVXdQemhqdldjdVZYUDBvL2l3VFE4?=
 =?utf-8?B?U1dUWTRKVVdWM1k0Z1RKZVN2SVNWMnZFOGdLV0tpMGEzMGpaMkU0cXJHc0Js?=
 =?utf-8?B?NklOeHBaejd1TEZZOS83QS9WbjdlSloyZFJPb2s1L3FPdTVuVSs1Z1h4Q213?=
 =?utf-8?B?ZE1LQTduUW1hd04zOFRkK3ZPSFBmRVBsWHM4V1pqak9JZHNtUCtoQW9xYzgx?=
 =?utf-8?B?QWlXZlpoYmY5YTRobnVJZ0t0a3RBNEF5OU5yTmZONzV1aTUva1VkcmplUTl1?=
 =?utf-8?B?WmRxeE1RNCtMeFlWRy9WQTJKTHJnTm1aMkViTjFRK21ONy9LdEx4eDh2bjdF?=
 =?utf-8?B?SXBEQmU2YVJjQ1BXMjkwSEZtSHVNVnhodk82Zkgya3ZPM1d0eVNwRjBDcWdC?=
 =?utf-8?B?QURRNmFFMzFiTjBoc3VWNkE1L0pKdDcrbS9ocngrZ1NJWXBMejZnV1pzOHcy?=
 =?utf-8?B?ckl1MFlPVzNYZ0lpMW9RNUN1citMMXYvS1Z5ekN1Z2syRXpMZVdudEcyczlz?=
 =?utf-8?B?VzZ1ZjI1TlZtWUVlYXhXRUoyczVRMzI0VU9XM2NNK25EMGxkSXhxSE1GTTJt?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tEK/jk5cBapbF++jsaCuJXeI6SyCoZKZelqLs1y6oOTt/w3a4qgDf96akIYGu/ra51VmYcc/jNnG9uKLgb/T2U2DtjM2F30oW6b0S3HmWqaH2erAObGfj2cQK5GpYj9irOBQ1D2vapyUk/dYnGMf7HsPIhPSCtMa7JHO/Sz+YYiYKrx1BShMcW5yFGqPoickV+OZAl5Q/Pe+/uqxBel/wavlQSVa4Em0OdAnJnUvf4X8QemTV6Ejd/A6JXkxN2E3A07DavmtgHM6vwF7bY1HI22HpN+i/2LtU7GBCB5/XLbuSbbnPqqZfEQOIlAwVnCEc9WzWVeUubtQTVVNTQVu7+2qWWVUVOPU8/bcwcDMFhKGACDHom413/TIYf+FvhCTaFXNSFKljO9rcs6UVIoksED1PsTOY/XYBlF/n6FHbVb8HQubkXrUjSS81kjwOeHvLy9qQ/0GlMR+626xw1fzI082zg3VXMZvUa5ytHwsv9/11PhmxFA8oMgrXJVpSKhgMGKxwctV6UwFPeNzIhqwk9ZwpwsbkXrTPVtVo1cXGkxJHfOLZnnMCKGV1wpBpBa8iQ51S3vJ7BB55mKT5NbljkkE4SPDemq322NCQgKdqFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1add472e-0efb-4189-37af-08dd67bf7a70
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:57:05.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyAkQ0O3IWvAU96JR3otIFu05H+klfB+kiaX458sQq0RPDH2O1sIidQUAG6w5aAiXEkvKIUXR/n3JmWii+ze77XMPW5Pk5n4OWwSu0Ntx5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200093
X-Proofpoint-GUID: eTYPOfdF3mhCFLZvKPNI6agzFnYCZs6o
X-Proofpoint-ORIG-GUID: eTYPOfdF3mhCFLZvKPNI6agzFnYCZs6o


On 20/03/2025 09:20, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall 
> execution. Add per-device ratelimits for AER correctable and 
> uncorrectable errors that use the kernel defaults (10 per 5s).
> 
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors 
> logged while AER stats (cat /sys/bus/pci/devices/<dev>/ 
> aer_dev_correctable) show true count of 11.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer- 
> inject.git
 >
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>

For future reference -- please drop r-bs from patches that have 
functional/bigger changes. New code nullifies previous reviews.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 3069376b3553..081cef5fc678 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -88,6 +89,10 @@ struct aer_report {
>   	u64 rootport_total_cor_errs;
>   	u64 rootport_total_fatal_errs;
>   	u64 rootport_total_nonfatal_errs;
> +
> +	/* Ratelimits for errors */
> +	struct ratelimit_state cor_log_ratelimit;
> +	struct ratelimit_state uncor_log_ratelimit;
>   };
>   
>   #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
> @@ -379,6 +384,15 @@ void pci_aer_init(struct pci_dev *dev)
>   
>   	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
>   
> +	/*
> +	 * Ratelimits are doubled as a given error produces 2 logs (root port
> +	 * and endpoint) that should be under same ratelimit.
> +	 */

It took me a bit to understand what this comment is about.

When we handle an error message, we first use the source's ratelimit to 
decide if we want to print the port info, and then the actual error. In 
theory, there could be more errors of the same class coming from other 
devices within one message. For these devices, we would call the 
ratelimit just once. I don't have a nice an clean solution for this 
problem, I just wanted to highlight that 1) we don't use the Root Port's 
ratelimit in aer_print_port_info(), 2) we may use the bursts to either 
print port_info + error message or just the message, in different 
combinations. I think we should reword this comment to highlight the 
fact that we don't check the ratelimit once per error, we could do it twice.

Also, I wonder -- do only Endpoints generate error messages? From what I 
understand, that some errors can be detected by intermediary devices.

> +	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
> +	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
> +
>   	/*
>   	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>   	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> @@ -668,6 +682,17 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   	}
>   }
>   
> +static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)

I really like this solution, it's nice and tidy


>   static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>   {

I'm also thinking -- we are ratelimiting the aer_print_port_info() and 
aer_print_error(). What about the messages in dpc_process_error()? 
Should we check early if DPC was triggered because of an uncorrectable 
error, and if so, ratelimit that?

All the best,
Karolina

