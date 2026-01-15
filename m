Return-Path: <linux-pci+bounces-44970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03435D25697
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 708A5300699D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D463ACF12;
	Thu, 15 Jan 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r3Yeh05K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gvnr9GRG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9134575A;
	Thu, 15 Jan 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491578; cv=fail; b=RoWzVKtNO/blzqq9SXvQrFteoj1rjikOmXnMEuavVib5QYxsWsyH9KLG8A6OOwAoDHPdhZYhvleK1s6ZywdborIY6OBEVKqroM5rKruyb6uowP5x3fWYJ6fbxbL2JgHMUanMnI9u7GhZ0Es+0FXEHtpF2QDbn1+9XZWkE1Q6cDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491578; c=relaxed/simple;
	bh=OLY5ENjKDNxIBZPiIPMxri1wYWE+7OV4ndtQACaHuqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6A4UdpsmalcFdBHnBtk5QIZQowic1ZvVe2iwSnByOOIm0T67uEFoapQAkApKjZPE440kaRv5KE6GjEU1L1hOHjNTwp115Segkt+dtYLDZZpMogYEK4nMUjiRNiG16R0RUBKIFZdUb3osKLsXKHHGwpeYDlOEuu1a74M+ELLMxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r3Yeh05K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gvnr9GRG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FEoAW61362590;
	Thu, 15 Jan 2026 15:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OLY5ENjKDNxIBZPiIPMxri1wYWE+7OV4ndtQACaHuqw=; b=
	r3Yeh05KgBrvjsH6pb9Q00+4jp4sQM/Hv2hTWM+47qXGYEo3uV4VSuD1boDI0L4h
	TbVWWDnybAmV2C4YWmRbHu65WuWbmK79gbPGFq1WS9K8u7t3ZA2++ibMp7eXF0WY
	662VK7aWEG9vzGBfqpbvMEFaKMSOBDSJf0qj3S6qkg/1coJUyNpupxlqc07FA8u3
	GprX/XsmhrPt+o+g5EyNjqTKYQWfEvoOBxRD+3QhtAUh/MsUVF4XoLMA5iLb2tl0
	DQ9E380aQL08P+r1+zKHEAK1Vt5XjF5+9kNyl8PEYrHzyL5vX2/atOMQQXPU1hVJ
	td637USY6PxjAQcApEnvAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp3b0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 15:39:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FFdMTH004143;
	Thu, 15 Jan 2026 15:39:25 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7n89fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 15:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ne+WTdGqNo83idq9g3063JPb6FzJ2pUT5iYUBoVzx6vTF4ku5jsrabEbunAuVTMIzjpz/sdJw/o6cDf+YDjdO7ljXm1v7BImW/DxpXLyGHmrmENUuJX8eLOHV2PedB6GRztbMa1lBzsXSzxOSInUa5ugLHA7AJCiSKeKTTgcWIiUc8tUB4uXgE+rfSvSH0di6z49WPzmbH+pOSB6x7j5FOWR1gwc6wfEHqDpLEIfNxREQJoSogpANdmnxE5Aeimp1gKSFrGNiYeXvczpvgWYp9IbEvZCniaK0SlNUzPcda0FhyBsKZ6Yuprp7mWZYHf8yIX5DUTOMEeNzf3RgynNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLY5ENjKDNxIBZPiIPMxri1wYWE+7OV4ndtQACaHuqw=;
 b=NBvUS/6mLndfZc3ahm80m5yJeQy30ZLpiDiuE64Fpth1xezdWB0jx22xz2uXrJaoCoPBi3Rn4h7nzhBMWEIPySigIz+CZGC4Vz7odsff9NbbyANSANkc76L2AYxGDCVavqbjOO97P3iJi/YyFX5rFbFbAsiYr0kifITH/4MQMVpR2H/yg/gjuSMpgNWmo97+nBoxQITG/laOM6P53cHMoQDZHnAx2kCkWrghvCCbs8kgnoaDJ8GKIPtnjgaSIPLTDUcqax91m4NManhOZgqR3wfveCqtLzx1qe3GAsnsqix0Kxid8/BPJX2/0ASlhQUEiX0Jc1/gHT2gNkwpSVuNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLY5ENjKDNxIBZPiIPMxri1wYWE+7OV4ndtQACaHuqw=;
 b=Gvnr9GRGQHLMrb+ovo/n2SBP5vWZXA2uWaJgDxGnXXxK++z7WydnYiYrAvPOZFgyHICnNWUTJ+m7SXmVEBBY8B20HvJcWN9W+5ADa7Wzf40TDTAVCgQRr3F7QgdCMAvHh0FxKgQ2p9l5sCuWYcTDousgVudQudXlbgKTtrYMOO4=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 15:39:21 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 15:39:21 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Thread-Topic: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Thread-Index: AQHchLA3J+2ji9rVEUKT1oas/t+7tLVQyAGAgAKYzoA=
Date: Thu, 15 Jan 2026 15:39:21 +0000
Message-ID: <52ED30CB-08FB-44AD-B366-AA3263236FA5@oracle.com>
References: <20260113235945.GA787062@bhelgaas>
In-Reply-To: <20260113235945.GA787062@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SA2PR10MB4457:EE_
x-ms-office365-filtering-correlation-id: 46f30bd3-fcf8-4902-47c1-08de544c40d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDIvaWJleXFsZTh1amhDU0l0LzZxWnZxNGVmdUNYRkdKcW4yby8xV24xZlRW?=
 =?utf-8?B?QW1FbllIbk1sT21qWjNXZVJHY0J1UzJjQUp3UWpIU3BraGt1RWxxNGxnbWxG?=
 =?utf-8?B?bVY1TTdUdEtRUkcvYklZS2IwK1c2T2Z6a0NiNi80cGgzZEptWkN6WXB5V3JX?=
 =?utf-8?B?am9KelNaSExoMGlFVDhybFIvMXlTdjI5UWFzdTE1YmxHRWU4ZDhZYWFCd2pw?=
 =?utf-8?B?R3ppdmpEOHlBY3lQakdVVnNsQVFmazlISkNQMW9UaDRHV2tpT3h1ZDROdDA3?=
 =?utf-8?B?T0tmRTJDMW4rYnFraU9SNG94ckJwSTN2eWVrOXgvZmF3YnVNSDAwNHkvYjZW?=
 =?utf-8?B?TUFlYWY1Z1RNWHNUZng5RlVqVXVrSlgwY2JrVVA3YmwzejVHMk9mbjhoTGpl?=
 =?utf-8?B?OEJ1djZldTRCTERuUmhTN1pQNWZxWU5QbTZGR0xYTm56TjA2RGtiUFRBTmxk?=
 =?utf-8?B?VU1pa00vTmVoUitvY2Z6eDBFU01uTjdma2FPeTUraURtZU9ZMmFWZXV1Zisv?=
 =?utf-8?B?Rnlzc1JHRXNLemlhWUU0VTN3TkxjZFAwV2wrV0VJTndJcGcwRXRyc2Jpb1ZS?=
 =?utf-8?B?Q3JJRE8rSXBrM1ZHWkFzeFVNZmpmNnlvN1o0S0pFS1NURWxSSnVCV0tHOU5v?=
 =?utf-8?B?MmdDRk10TGZhNHl0M2psc3ZmSFpUZ2FibkE1THZKNGlJbzArY3RvRXBQcXBB?=
 =?utf-8?B?M1RyeENIdnlpbjZHMHBFMnRid1FKSlhZY001M3JaM3VCZUhzQmhrdzU5R2sw?=
 =?utf-8?B?QlExZktnMFVHU2Z1TVNIK0lwelRCbTN4SFE2U2ZjOGY1c3ZFZGl4TWptc0tT?=
 =?utf-8?B?VjFienFRN29INlZ6bC9rcWlnSFllZjIwTitHUHkrWDErYitJMHZ2dEU0eVN0?=
 =?utf-8?B?K1QrY1pBS2srZ1BIVXRRWnllWVpTZ0pkTDlFTEcycnRPQ2dyYUZvMFJyNWJD?=
 =?utf-8?B?NE1zcUFSWW1MeVdIQVZlaFFGaExsYjIzd1hINmlvSHJ6Y1E1d25XYTVMRVBN?=
 =?utf-8?B?WDJ2c0hsbmVZbHNXWXpwNTIwaFdtdy9lSXZKaHp5dHlpTjhRMmttcUdNa0ZN?=
 =?utf-8?B?NWNhZHhhUVRPaHZteS82WTdCL0Z5WWRRaUNNek5reEJ3dTE4ek9XbHBDRWVS?=
 =?utf-8?B?WVA4cTJZMzRMa0JpOHcwTXFVN2p5bTV5MFFsZ3liUHBPM2xYVWV2NlhqcGhX?=
 =?utf-8?B?Qkp3cWlrWHVhR1A1RlNzWmt0TGNyak5seHFpRG9Ha0Y4RUJmYkVvbk1PaG5F?=
 =?utf-8?B?YnRnSHF4VkhYYVNkdW00QXBQdndUVFJIbmljMGtET0V0TlhSZkpreWU2eVpI?=
 =?utf-8?B?MHJtSnFkaVpuSnNGMldiWTR5bHVHY1pFemIwRVpKN3lPSEFuWjRBWVlIaWNK?=
 =?utf-8?B?d003Rm1ramdmL3lya1lvOWtFTGNBanhRM2pYcEJDSmhZWVBtZC9JclpWT211?=
 =?utf-8?B?VVpPakNWQlh0dWVna21CRWZqRnczNjlnVGx1SVQ5WHJaOGFZa21BMDFLSXhh?=
 =?utf-8?B?ZFlHTno3Nng0cjBWMmhnenU1SzJJc2pzRG4vbEsvbXFGV3J0V01sd1N3cDR5?=
 =?utf-8?B?dFpRUllVUXQwcmpYcVlhU1pYQnRVZkl2RTVQK2xEK2N1SHM1QjZMMzYrQ3NV?=
 =?utf-8?B?dzlVbDA1Um0rU3RCblgwNWVjU25ucmlnRHhXM3BvOW9RZkJBcjlxWGVhYVhD?=
 =?utf-8?B?c09hb0ZqOXpJU2JCcTd0TmpLMzJEZksybXE3eFdXbzBBeVU4KzVrVWxMeUJv?=
 =?utf-8?B?U1BPRnVyWUd1eW10cmpsUU1wWFpqL2dESkR1bEQxS2c1bnVvMnNHNnZvZEhR?=
 =?utf-8?B?RWl6TzZxS2JQVXZodkVWbzFnVS9YcjJVUW9DbmlZYWIzVFZmMm5IVndrcmpJ?=
 =?utf-8?B?WW4wSXQ4S3dvZGVaN3ZMWWNqZnpzQlg2cnJBZnltZ2ZDUTFLMUwxbUhxaGtK?=
 =?utf-8?B?emUvNXBMN0FQSXdsVTlTWlNjVGpKNkpzOGZFdGxIMHYxSEEzTDdpaU81bUhU?=
 =?utf-8?B?cU1oT003Mm1QbGlEcW5BblpKU2pJTTA0S0wyeGxZRmltODVoYmRVUFFBZ1Vp?=
 =?utf-8?B?R01ENWFUbTdqZlFUaW1ZWGh6dkxIdzEwOFZMODZIWGJGTXB0ZElIVEVRWmlL?=
 =?utf-8?B?NllRYlExalhlL3NZSzNoWHYzWnVua0NMeHB4dmwzTkpaekRDYTFnejMySEZI?=
 =?utf-8?Q?waUmRYUWbxgUm0mlM7+s9fo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXZ5S3hSYlFsY2JZV1o3MWkzOVRRTGVxMi9IS3VRZEhjeU1MMFF4djVXVmEw?=
 =?utf-8?B?RS9acnFoUC9kK2JGNjNOSnhHOE5oRmNaeFhtN2RSQnpGQ09ROHJmVDFWNTNa?=
 =?utf-8?B?cHpiQ1k1azk2RlR4aG9WZzdLcWNCSGtWNVIxaUVUU2NZOXFLaUhBYWx0VmlI?=
 =?utf-8?B?cFk3d1JaUldPYzRxc1AxOGViL0o1SVA2VkZENjEyUnQ3b3NuaDA5R0lmYm10?=
 =?utf-8?B?Zkl2S1doamR6Qi8xdGdJWlZ0ZGZ4ZkFPUk1IZVFUcEpOTklOUlJDaGhHeFkz?=
 =?utf-8?B?R0VhUXZ6dVN3OUZwQWxXemZCS2hPQld3elplNGtjUS9SVzc5TUg3WUtubWF4?=
 =?utf-8?B?VEFmcURORHhtVEVHUm9uZEtJQkdDSEt6NkpMZkxndUpPeDA5cEozZVZpWmgw?=
 =?utf-8?B?TEFqYXU0dVBEcERoNTNQTFN3L04vcUQ4NGJ0cEUyZ3AwUEJiMDJScnJtTHY5?=
 =?utf-8?B?dkRmYWJJeUVORm81M3J1NWFFM000MHF3UDFRTlNSUzRleDZJWUsxL3V5ajhs?=
 =?utf-8?B?WnBiL3A2WmtRSzNHelhvR1pZVWVwa0dZQk8wa1FBbVdzeU16VmFBb1BlOGRC?=
 =?utf-8?B?S0tXY28xcWx5bldla2NZczBpL1VqWGtRaHlyT3NTaUVza2M5L1NIQ0RZZDZX?=
 =?utf-8?B?MlBsWU4xb0pDU1FUaU5FLzJmejl6R2VXS0ZELzMwdHVBWWRWUGVlQTAyN2RU?=
 =?utf-8?B?NEt1MHF6UlZCaGZBY1NIdk5PZDREdjV0WTZGRjdiNkRvYVZEOWtrVGJkMUpu?=
 =?utf-8?B?MmVzeDlDQU5uSzJXMjNwbG1SRXdNbU0weG1XazdNREJGeWxNeURVR1hGV2pS?=
 =?utf-8?B?ZUwxWFA5WkpJYU1GT3VMa0dIOUlDazZKS3g4TTUydE94aktxS1JYa3ZoOTZu?=
 =?utf-8?B?SVFuRUpOS2NQcGlWai9sMjdjKy81dStaZWFVcmhPdTZxSFVVdjBPQ0JDekUx?=
 =?utf-8?B?NXRMcmJLQ1NLUnBUOUJGbG1vNlZEcENMWWFvSEFFS2taMm96cXVTd1k3REdk?=
 =?utf-8?B?S05yQlFsNGxIWFp1bk9TSC9OZmdGYmJlRk1uK2ZIcFIrNW5XUzlPRTBmc3N1?=
 =?utf-8?B?bjFubTNwWmxRYnE1Tjc4V3dzRTNMZHo4TUJiMFlrc1BqNlREK2tsMnVFeENP?=
 =?utf-8?B?d1kvcWtLdjRmaW5vSGFuUFBIbWVoaThOa2gzVnA2dzBQTXV5MTVUbWQrb1lo?=
 =?utf-8?B?MmY5RGhOZUtRUTBKaW1qeHFHdk0weFBPdkxudXNQL0xJeEN2Q2YwbmpLcW52?=
 =?utf-8?B?QXdudzdwWDlNM3RWZE5MWlhtOTY5Q3dTSVVxU3lXdDMxYnhYVm5HcVFlcEtx?=
 =?utf-8?B?SjU5QUhUaVoyay9va0xQWUNUdVhMTHB5OEIxRFJDeWM2OU5JRlo3OTh5eDRu?=
 =?utf-8?B?MWNiNzFDM3RvKzRTT3dtYW9QQi9zNUpkbFJJc2FZS1BVVFVoUDhuRlc2TUxj?=
 =?utf-8?B?NmJNNVpyWGR0M3lnUDE2aEF4TnU3SEdFekdYdlpoRFBYaS9ZckdLQXd3cDRa?=
 =?utf-8?B?bDMxWCtRbVdOcTYxMTJ1TElybTltOGtnWUJndnRDSlZjY25oWVJWZlR4TG1z?=
 =?utf-8?B?M0gxMzhXeXJmVXVVWjRJVnJXdlJoQ1R3c2lSclI3bUhuWHE3cWVLUUJ6M0lB?=
 =?utf-8?B?b0xBdU1lN2FsZmdRZGw1MkNIMDhscHR5WUk5NFdWdElwamhSWkhOT2pGbGJY?=
 =?utf-8?B?bFo0VU1oUE54N2Q3eFRxMVgweXlJZnNzUXpLS3F6L3lxZjVjczN0enhVdzFB?=
 =?utf-8?B?RFlxd3BSM1lXbk9hKzRtSlhtMVcwd0c0WnZ2Z3V0WlJSMmFkREI2am4yM1Fi?=
 =?utf-8?B?dHcrVW9zSTRXdytXQWRMcDFmQW1pSHdUVW1uMDk5S0JVeHFJQmkzVER3Sk5n?=
 =?utf-8?B?Zm5CM1NOckVralhvcnlwYzFlZDZmZVAvU0pwM3JSR2ROdHU4Tjc0dnRqLzd1?=
 =?utf-8?B?ZnNoQS90MFlhdTRndGpuUlIzZWFoNVBqRzMyTDdtUXdlb1BIbGRlNDg2ODlC?=
 =?utf-8?B?TnVUVllwWVVPRmZiWHFQZ0c0YUV0dVlrUFFsUUFmeWc4TVNLSTFUVmRnTXUw?=
 =?utf-8?B?UWV3bWdlelhoWVlQcnJnYVhmMGFoQlR5YmFTbWxkeWExRHlGZktMZ3FoTXhE?=
 =?utf-8?B?aWVJVjZiTzZkd1U4d25YZjZ2SVdxRWRFTFF4WUxnaFZkdHNOQXdQWDFjZnR0?=
 =?utf-8?B?RkJ6aHBoVHBHUFBiZHk5RFBzRzJNdTErNU1XbllKK3JwVmsvRHRJZzRHWThK?=
 =?utf-8?B?OFZ5RjlmSkRIRjVCNFJTZ0oyN0tIanoraElaRGFCQlZiQXBBenBFZGw1cERt?=
 =?utf-8?B?YjYvY0Z4TXlMUUtzWjFQOTNXNkhlekpJZDRBM2F3VDF4cU15ejJvd3M3TlJO?=
 =?utf-8?Q?XyKrbm4SlOlt2qEo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F2B4AABBB2CBF48837A07F65640ED77@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cgin8LrxAUROricW3xv61ax5gD74KxOZmmrEWatlUNbrFuLGiG3+GtgPiyE1H9Mrb+e+uylNGJWekfySPvucJ1B/TAZps6dOKTfBb2cxEJl09ixaGJsJE4lpFy8M/xfGeim1XWtOhxgq1FdoOqfYEsmOvhLIEItxM0aBEaXjaBOSfQTJbFmpssp1+YaTplFoct7ZJDhHhBN1BP7PyAMEhoOaSoZUk/s34zON5vJ9EJ+uBLH7EH6cApNqbSCWSuADVJylS7BZTQq/xZYBbDBttfXsWEJ+x2UnpOrBFoRpTQxYdj0XaiySD+Wi25VjcO+Xn2QkvM1nvMp8m5YCEfuCY7f09RIPG8PrsRs4Ycmn+RfQD/VTPu5OI0a/G9r94hmN6A9Ar3Fbpya4MkeuE2wTWYY/LCKJ9/vFK/NgybkilGQRuASBw38qommRV30JGmxd+OPHPZSqdsavKH2cg+X7APFBN44rpu7OvL5cV05cLFgEA9Y6m93WOTRCMsP7lUXSRoGKxZ6WpYKbCjcQ5F+o4BG/PbN2agWwGgJjUMKYZi8d0F/puCJc/ocPKUfOmpTP2kMoCN3WGmTS19sDApS2jvZzvhXIE0a2dCRViSYbyFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f30bd3-fcf8-4902-47c1-08de544c40d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 15:39:21.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIQEYaelwDdywKY2wFycDXAMTPEeklziqUhLFs11VMKJeI4JlYE+A4GeRny/yHd8ppqmuSjsdI915CTPWUctJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_04,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=851 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601150118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDExNyBTYWx0ZWRfXxJc+NGNHmuzU
 QlhCLuFPp4bxGdKFatbrkx0uj2FAA5o83DDmWAEDpTIsUur3dfqI8b8GHHXdd+/NergtCiQ2im0
 BxGAdwuQpl4bOvn4uqWCwDGC+lBNULB7OWJ93oet8/pxhvF5OGJWXLwqEXV2NP0yjyhBrgK5dD8
 lNQ64Us3Kt9xwFuORScWCgtrlPIcc5zbPurIflOo4dtdTVi67q+z/CDQvE1LcoR95YuGIPVKwpo
 lyDa6ger/bAVzp2+EG0dESQkjDj5mwhfPs/N2nRE+qkQhY3WmbG1uCt/nlHNx3hvgp4SJ8uFt5X
 4jLAi3YiQ3hDDgZnl2QbCQWYGkl3v9ZOPCyBo7cP8N/CiSP3BfAduxtYCZGkabdCMfBGsmpoVk0
 hiWG9uJvRO/H7zv8f2pyCq1NYRKTcBAEkVF3x7ay7DJ5D/V9+p+jwVUHpnZdslU1c1fwEP99OxH
 Y4cuFN6HeRn6dmLcamVtxzTv+p21OvdmldEvYuJA=
X-Proofpoint-GUID: wILqu3RQSspQ4RrG6WyyyWmX6Jeaj0cY
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=69690a2e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GUILgmRY3vc_xEgAwMoA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12110
X-Proofpoint-ORIG-GUID: wILqu3RQSspQ4RrG6WyyyWmX6Jeaj0cY

VGhhbmtzIGZvciB0aGUgcmV2aWV3LCBCasO4cm4hDQoNCj4+IE9uIFR1ZSwgSmFuIDEzLCAyMDI2
IGF0IDA2OjE1OjIwUE0gKzAxMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IHByb2dyYW1faHB4
X3R5cGUyKCkgaXMgdG9kYXkgdW5jb25kaXRpb25hbGx5IGNhbGxlZCwgZGVzcGl0ZSB0aGUgZmFj
dA0KPj4gdGhhdCB3aGVuIHRoZSBfSFBYIHdhcyBhZGRlZCB0byB0aGUgQUNQSSBzcGVjLiB2My4w
LCB0aGUgZGVzY3JpcHRpb24NCj4+IHN0YXRlZDoNCj4+IA0KPj4gKwkvKiBXZSBvbmx5IGRvIHRo
ZSBIUCBwcm9ncmFtbWluZyBpZiB3ZSBvd24gdGhlIFBDSWUgbmF0aXZlDQo+PiArCSAqIGhvdHBs
dWcgYW5kIG5vdCB0aGUgQUVSIG93bmVyc2hpcA0KPj4gKwkgKi8NCj4+IA0KPj4gQ29udmVudGlv
bmFsIG11bHRpLWxpbmUgY29tbWVudHMgYXJlOg0KPiANCj4gIC8qDQo+ICAgKiBXZSAuLi4NCj4g
ICAqLw0KDQpUaGUgbmV0IGNvbnZlbnRpb24gbHVya2VkIGluIDstKSANCg0KPj4gKwlpZiAoIWhv
c3QtPm5hdGl2ZV9wY2llX2hvdHBsdWcgfHwgaG9zdC0+bmF0aXZlX2FlcikNCj4+ICsJCXJldHVy
bjsNCj4+ICsNCj4+IAlpZiAoaHB4LT5yZXZpc2lvbiA+IDEpIHsNCj4+IAkJcGNpX3dhcm4oZGV2
LCAiUENJZSBzZXR0aW5ncyByZXYgJWQgbm90IHN1cHBvcnRlZFxuIiwNCj4+IAkJCSBocHgtPnJl
dmlzaW9uKTsNCj4+IAkJcmV0dXJuOw0KPj4gCX0NCj4+IA0KPj4gLQkvKg0KPj4gLQkgKiBEb24n
dCBhbGxvdyBfSFBYIHRvIGNoYW5nZSBNUFMgb3IgTVJSUyBzZXR0aW5ncy4gIFdlIG1hbmFnZQ0K
Pj4gLQkgKiB0aG9zZSB0byBtYWtlIHN1cmUgdGhleSdyZSBjb25zaXN0ZW50IHdpdGggdGhlIHJl
c3Qgb2YgdGhlDQo+PiArCS8qIFdlIG9ubHkgYWxsb3cgX0hQWCB0byBwcm9ncmFtIHRoZSBBRVIg
cmVnaXN0ZXJzLCBuYW1lbHkNCj4+ICsJICogUENJX0VYUF9ERVZDVExfQ0VSRSwgUENJX0VYUF9E
RVZDVExfTkZFUkUsDQo+PiArCSAqIFBDSV9FWFBfREVWQ1RMX0ZFUkUsIGFuZCBQQ0lfRVhQX0RF
VkNUTF9VUlJFLg0KPj4gKwkgKg0KPj4gKwkgKiBUaGUgb3RoZXIgc2V0dGluZ3MgaW4gUENJZSBE
RVZDVEwgYXJlIG1hbmFnZWQgYnkgT1MgaW4NCj4+ICsJICogb3JkZXIgdG8gbWFrZSBzdXJlIHRo
ZXkncmUgY29uc2lzdGVudCB3aXRoIHRoZSByZXN0IG9mIHRoZQ0KPj4gCSAqIHBsYXRmb3JtLg0K
Pj4gCSAqLw0KPj4gLQlocHgtPnBjaV9leHBfZGV2Y3RsX2FuZCB8PSBQQ0lfRVhQX0RFVkNUTF9Q
QVlMT0FEIHwNCj4+IC0JCQkJICAgIFBDSV9FWFBfREVWQ1RMX1JFQURSUTsNCj4+IC0JaHB4LT5w
Y2lfZXhwX2RldmN0bF9vciAmPSB+KFBDSV9FWFBfREVWQ1RMX1BBWUxPQUQgfA0KPj4gLQkJCQkg
ICAgUENJX0VYUF9ERVZDVExfUkVBRFJRKTsNCj4+ICsJaHB4LT5wY2lfZXhwX2RldmN0bF9hbmQg
fD0gUENJX0VYUF9ERVZDVExfUkVMQVhfRU4gICB8DQo+PiArCQkJCSAgIFBDSV9FWFBfREVWQ1RM
X1BBWUxPQUQgICAgfA0KPj4gKwkJCQkgICBQQ0lfRVhQX0RFVkNUTF9FWFRfVEFHICAgIHwNCj4+
ICsJCQkJICAgUENJX0VYUF9ERVZDVExfUEhBTlRPTSAgICB8DQo+PiArCQkJCSAgIFBDSV9FWFBf
REVWQ1RMX0FVWF9QTUUgICAgfA0KPj4gKwkJCQkgICBQQ0lfRVhQX0RFVkNUTF9OT1NOT09QX0VO
IHwNCj4+ICsJCQkJICAgUENJX0VYUF9ERVZDVExfUkVBRFJRICAgICB8DQo+PiArCQkJCSAgIFBD
SV9FWFBfREVWQ1RMX0JDUl9GTFI7DQo+PiArCWhweC0+cGNpX2V4cF9kZXZjdGxfb3IgJj0gfihQ
Q0lfRVhQX0RFVkNUTF9SRUxBWF9FTiAgIHwNCj4+ICsJCQkJICAgIFBDSV9FWFBfREVWQ1RMX1BB
WUxPQUQgICAgfA0KPj4gKwkJCQkgICAgUENJX0VYUF9ERVZDVExfRVhUX1RBRyAgICB8DQo+PiAr
CQkJCSAgICBQQ0lfRVhQX0RFVkNUTF9QSEFOVE9NICAgIHwNCj4+ICsJCQkJICAgIFBDSV9FWFBf
REVWQ1RMX0FVWF9QTUUgICAgfA0KPj4gKwkJCQkgICAgUENJX0VYUF9ERVZDVExfTk9TTk9PUF9F
TiB8DQo+PiArCQkJCSAgICBQQ0lfRVhQX0RFVkNUTF9SRUFEUlEgICAgIHwNCj4+ICsJCQkJICAg
IFBDSV9FWFBfREVWQ1RMX0JDUl9GTFIpOw0KPj4gDQo+IEluc3RlYWQgb2YgbGlzdGluZyB0aGUg
Yml0cyB3ZSAqZG9uJ3QqIHdhbnQgdG8gdG91Y2gsIEkgdGhpbmsgd2UNCj4gc2hvdWxkIGV4cGxp
Y2l0bHkgKmluY2x1ZGUqIENFUkUsIE5GRVJFLCBGRVJFLCBVUlJFLiAgTWF5YmUgd2Ugc2hvdWxk
DQo+IG1vdmUgdGhlIFBDSV9FWFBfQUVSX0ZMQUdTICNkZWZpbmUgdG8gZHJpdmVycy9wY2kvcGNp
Lmggc28gd2UgY291bGQNCj4gdXNlIGl0IGRpcmVjdGx5LCBlLmcuLA0KPiANCj4gIGhweC0+cGNp
X2V4cF9kZXZjdGxfYW5kIHw9IH5QQ0lfRVhQX0FFUl9GTEFHUzsNCj4gIGhweC0+cGNpX2V4cF9k
ZXZjdGxfb3IgJj0gUENJX0VYUF9BRVJfRkxBR1M7DQoNCkdvb2QgaWRlYS4gQnV0IHdoYXQgYWJv
dXQgbW92aW5nIGl0IHRvIGluY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oIGFuZCBhbHNvIHJl
bmFtZSBpdCBmcm9tIFBDSV9FWFBfQUVSX0ZMQUdTIHRvIFBDSV9FWFBfREVWQ1RMX0FFUiwgdG8g
bWF0Y2ggdGhlIGNvbnZlbnRpb24gZm9yIERFVkNUTCBpbiBwY2lfcmVncy5oPw0KDQoNCj4+IAkv
KiBJbml0aWFsaXplIERldmljZSBDb250cm9sIFJlZ2lzdGVyICovDQo+PiAJcGNpZV9jYXBhYmls
aXR5X2NsZWFyX2FuZF9zZXRfd29yZChkZXYsIFBDSV9FWFBfREVWQ1RMLA0KPj4gCQkJfmhweC0+
cGNpX2V4cF9kZXZjdGxfYW5kLCBocHgtPnBjaV9leHBfZGV2Y3RsX29yKTsNCj4+IA0KPj4gLQkv
KiBJbml0aWFsaXplIExpbmsgQ29udHJvbCBSZWdpc3RlciAqLw0KPj4gKwkvKiBMb2cgdGhlIExp
bmsgQ29udHJvbCBSZWdpc3RlciBpZiBhbnkgYml0cyBhcmUgc2V0ICovDQo+PiAJaWYgKHBjaWVf
Y2FwX2hhc19sbmtjdGwoZGV2KSkgew0KPj4gKwkJdTE2IGxua2N0bDsNCj4+IA0KPj4gLQkJLyoN
Cj4+IC0JCSAqIElmIHRoZSBSb290IFBvcnQgc3VwcG9ydHMgUmVhZCBDb21wbGV0aW9uIEJvdW5k
YXJ5IG9mDQo+PiAtCQkgKiAxMjgsIHNldCBSQ0IgdG8gMTI4LiAgT3RoZXJ3aXNlLCBjbGVhciBp
dC4NCj4+IC0JCSAqLw0KPj4gLQkJaHB4LT5wY2lfZXhwX2xua2N0bF9hbmQgfD0gUENJX0VYUF9M
TktDVExfUkNCOw0KPj4gLQkJaHB4LT5wY2lfZXhwX2xua2N0bF9vciAmPSB+UENJX0VYUF9MTktD
VExfUkNCOw0KPj4gLQkJaWYgKHBjaWVfcm9vdF9yY2Jfc2V0KGRldikpDQo+PiAtCQkJaHB4LT5w
Y2lfZXhwX2xua2N0bF9vciB8PSBQQ0lfRVhQX0xOS0NUTF9SQ0I7DQo+PiAtDQo+PiAtCQlwY2ll
X2NhcGFiaWxpdHlfY2xlYXJfYW5kX3NldF93b3JkKGRldiwgUENJX0VYUF9MTktDVEwsDQo+PiAt
CQkJfmhweC0+cGNpX2V4cF9sbmtjdGxfYW5kLCBocHgtPnBjaV9leHBfbG5rY3RsX29yKTsNCj4+
ICsJCXBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoZGV2LCBQQ0lfRVhQX0xOS0NUTCwgJmxua2N0
bCk7DQo+PiArCQlpZiAobG5rY3RsKQ0KPj4gKwkJCXBjaV93YXJuKGRldiwgIlNvbWUgYml0cyBp
biBQQ0llIExpbmsgQ29udHJvbCBhcmUgc2V0OiAweCUwNHhcbiIsDQo+PiArCQkJCSBsbmtjdGwp
Ow0KPj4gDQo+IFNvcnJ5LCBJIHdhc24ndCBjbGVhciBhYm91dCB0aGlzLiAgSSBtZWFudCB0aGF0
IHdlIGNvdWxkIGxvZyB0aGUNCj4gTE5LQ1RMIEFORC9PUiB2YWx1ZXMgZnJvbSBfSFBYLCBub3Qg
dGhlIHZhbHVlcyBmcm9tIFBDSV9FWFBfTE5LQ1RMDQo+IGl0c2VsZi4gIFRoZXJlIHdpbGwgZGVm
aW5pdGVseSBiZSBiaXRzIHNldCBpbiBQQ0lfRVhQX0xOS0NUTCBpbiBub3JtYWwNCj4gb3BlcmF0
aW9uLCB3aGljaCBpcyBwZXJmZWN0bHkgZmluZS4NCj4gDQo+IEJ1dCBpZiBwY2lfZXhwX2xua2N0
bF9hbmQgb3IgcGNpX2V4cF9sbmtjdGxfb3IgYXJlIG5vbi16ZXJvLCB0aGUNCj4gcGxhdGZvcm0g
aXMgdGVsbGluZyB1cyB0byBkbyBzb21ldGhpbmcsIGFuZCB3ZSdyZSBpZ25vcmluZyBpdC4NCj4g
KlRoYXQncyogd2hhdCBJIHRoaW5rIHdlIG1pZ2h0IHdhbnQgdG8ga25vdyBhYm91dC4gIHBjaV9p
bmZvKCkgaXMNCj4gcHJvYmFibHkgc3VmZmljaWVudDsgdGhlIHVzZXIgZG9lc24ndCBuZWVkIHRv
ICpkbyogYW55dGhpbmcgd2l0aCBpdCwgSQ0KPiBqdXN0IHdhbnQgaXQgaW4gY2FzZSB3ZSBuZWVk
IHRvIGRlYnVnIGFuIGlzc3VlLg0KDQpNeSBiYWQsIFllcywgdGhhdCBtYWtlcyBtb3JlIHNlbnNl
IHRvIG1lLiBBbmQsIHlvdSdyZSBPSyB3aXRoIHJlbW92aW5nIHRoZSBSQ0IgdHdlYWtpbmcgYXMg
d2VsbD8NCg0KDQpUaHhzLCBIw6Vrb24NCg0K

