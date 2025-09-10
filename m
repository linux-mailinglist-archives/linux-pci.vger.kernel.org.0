Return-Path: <linux-pci+bounces-35825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBCAB51C9E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166B5188649B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7201327A19;
	Wed, 10 Sep 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XVstZqO9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3B30FC39;
	Wed, 10 Sep 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519845; cv=fail; b=fbd9Jg6gwsFp34r0xKQgUN5hKRzpJr3exnNbrTwSKsEhzwqvJgM7SEYW7sRR+TxhcM3Te4DbZ13UA2FUV7HsMLla6gCXF6wXiyLgXdJIILfpa/M+/ZYCIqHcYrKsKnPV9JNAH0/69bl7Xz8ua7vEI++c1ucgTlzYt1gdVWMLBTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519845; c=relaxed/simple;
	bh=40e2gEhhrfJ/hhYZai/mzGMt7X0+TRm4+7qwDVTPQlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTgf2mhm1fa3hM7s3w6iNhJ1snuhMQHt6GGUQiMHqBOCKk/UI/PJMvH4Xn7uTgnb+c1F8DboF1rj6l6FdXnG4E6ed9OVP72g1kAJH92xRQ/t0jxa2eQuHvh46I0MfO9EVyMCsp6w0cHUiWpGnh8RtJd427OoySCb8ZUc7ZXEoEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XVstZqO9; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXmcxzbuATveEGTR1WZMieq4/xp+FohWiJIiEJU6b6qoHg5RIwnnJNSY76l1+JY6uZqigKyL9Qeeet6C4xH+5wWSt532hW6G7SDvMpkP1Fd38/6nXfjKsWgVD88FYJXEHV9gqjggyRp5g355dEE76CS+2aEM8T6Xq52Y/ICUqw3BMB8UD4Laf2ny7ZqFUrt47Ajprg/C8WMzBqvngTsF29t/BrTOAhW0QJITi6itpujSnh+myJVHapCeYFRvxJzPD8MUK8qPbaUFbVfTlieMms6MZUjMmB9W4KPj9sWKlFrOHQSWykqwRowtFXiNTuR4p5QdJ3N2+5KF5xQWSniNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is0CVq2wcyxQD0W8C5cyS9mirUjc/5BylYvw53Rp0AE=;
 b=DGOJydVnXd9J+W0ONTWdO0UYVa/38Q+geGw8dul1H+pr9Ks1F5DQYkW9jfT6COoZN7MRivXK7NejzQuxXfXOqQTuqb9oZcrEQacC70K+3kyg2ofYTb6yMDUuoviquB12OTBqmA5B1BUrEO+6OsCnTL2hrLbyXT0vyNBit6pIsMMhsKieH0qavp4OEsXMdZx+novboRgpc/+csRWgRpoUdT1ljwOnY7kxX1mhMBOQzX3ia+qqaXZdNlXv3LeYhRpyYGgyRgrxYQT6G2BiFtRBhpaPSAPobuuWJaTnY0iDdkxitNytPx2e2Mho+mhW6JeCQ08qzhKrAni8sFXISgnk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is0CVq2wcyxQD0W8C5cyS9mirUjc/5BylYvw53Rp0AE=;
 b=XVstZqO9AVfzXjKCfmLuAYzjw1lVaGSCL5wmMasTOn7+5OsyzVWWIPZlR6+ypUuCLYY18gAU9sJMgq1r/6n60mMx79jWB8Qim+whbzTd7oPGv0Jy3KHZVsEluVqZRU2hSqJXIgFldwFImdeNoiSxkJ7JLAtDSxk8Y39hyufkiOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 15:57:21 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:57:21 +0000
Message-ID: <f1ddffe9-e1ea-45b5-9042-e9aa6ce41e34@amd.com>
Date: Wed, 10 Sep 2025 10:57:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 20/23] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
To: Lukas Wunner <lukas@wunner.de>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-21-terry.bowman@amd.com> <aK67_CP7l7c7CSPp@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aK67_CP7l7c7CSPp@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:8:57::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 02250c84-0998-46de-e253-08ddf082b9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEFFcEJadnVTR2t3aWhtQ01oZnRyVWZlemp1K0xhL2RQZ0tTMUxleEJSRXlC?=
 =?utf-8?B?SGdlQ0NSOVFmSXhrSkVxb3dvN3JDZjZHSnIzc0RLQU96dVFvcW9TVFduZTNM?=
 =?utf-8?B?dFl2WkxGRTJYdXoyZ3ovR1dBRk9EVHFxRHVSN2phb2JST1Z6UHZZaXZmdHYy?=
 =?utf-8?B?a05WU2d0Y2paSUtUb21hWUZEeWdyMzRCclBSZUhEVUpYTE11NFlTZ0NKWng4?=
 =?utf-8?B?Rzc1cVhOQkppTzNvOVdNbVZwOVlHaE5lWjNHWEVkZitYS1hlRWRWUEhvM0s5?=
 =?utf-8?B?ekcrNzFBVUx5SkdLam5oZ2RZYTFDUHRCd1BNYnQ2OUxtcC9IeFJ6K29JVHp0?=
 =?utf-8?B?cko2NUptK1grNFlwZTZHN214SzZzdjdieGc0VnUzU2tYMm53L0Y0Ni80S2ww?=
 =?utf-8?B?dUtHamh0M2R4TVpCZDNhaG1nT2xOSEUwLzhFY0M0bTg3MzNHbXFmVTd2TTE3?=
 =?utf-8?B?K01HdEtGOHJuLytKMGovNERvQ1kxb2FaMDFlZGVIYW1XeTNJV211KzdzQzJR?=
 =?utf-8?B?Rm05VHNieExpa3h3WEJzakpUZDFMTzJNUlMvUUF6a0p1MFdwbWduTjFGcHgz?=
 =?utf-8?B?UFVIb2l4TXlmOU4zRkkrUDYzNHZEOXhGcnVaWHdsU3pFaVhYQjRYZDMrdjVI?=
 =?utf-8?B?Q05nc1FFek9EekJ3eFRZeWVZb2hNdjc4QmYxdDZzcVV5STdvWDVJVTVlS3RE?=
 =?utf-8?B?Y3NPVVRkUHFyK3BXMnVJK2lySE1EdElJZzU4NmxNa29tMGFqQ0gxMHdmSWQz?=
 =?utf-8?B?ZTdGdHMyWTRjV0JrVWFhY0toa3ZlVFp2RmlVYWtET2xmQ3c5ODBaOWliWVY2?=
 =?utf-8?B?RkJCeld2Z3JTb1dGQVBqVXdLWnFKY1VEVk1WY1BWUDlwZ1FoY0xWZ1Q5OVox?=
 =?utf-8?B?c2RkMEpFS09KMWZaMEJvT1lRWDFCSnorOEZyVDBZdFlhbmNpRXRIdWorMUo2?=
 =?utf-8?B?TVBTcUM0YjI3cjkvWlFZVEF2N3kxdnJ4QkZrbU9sZGI0bWI5TlpYTHVzL1BB?=
 =?utf-8?B?Ly9rQVcrWERRNk40Q0RLclJkWnZjZ1JBekdiUDlKZWU2ZlpiYmFoZlNTUGlZ?=
 =?utf-8?B?anVraUFQVnpnRjdHTlY5VlRqUExZQlpCNTV0UVo0NVJBaTV3T0JPRkNmd1Mw?=
 =?utf-8?B?dW50Z0xZVkhJeHFKczVNWXNDc0tXV0xXZmRkNksxdVV2RldaT0Y3RE14eitn?=
 =?utf-8?B?S3Z3OXhxUWpQVGUraXY5bVNqWHdhK1QwYW85ek1jM3ZRbWMzd2NGZnZQdkZH?=
 =?utf-8?B?cXVWTmhhTHZNQ3RGSHhkQ2pTN2VzTktXU2F4WmpZd2hvQjRtbEFtekFZZ2xx?=
 =?utf-8?B?SlVZalZtWXFXMzJreGUwYWNlWEtrZGwzb0NBZktPUHlPblU3bmx6eCthMWZN?=
 =?utf-8?B?ZHFCWHJtQkxNeGZJa3FPMDdoZStIOTVxeTZ3RXFXK3MrSXVoeUZ0RlcyQUkz?=
 =?utf-8?B?ZnJNVFBXQjk4RjFvbG9jREk4YVBxZ0h0OEJHR1p0cjEwOWZ0b3R2a1Q3VDhT?=
 =?utf-8?B?UFl0TVdHZXgzb2RETmVJb1QzblJFbG5CU3ZVN1JhV2NFTlBveWkvWGZOcjh5?=
 =?utf-8?B?aTFmRHZNcmpzOXZiRjd3Uks0WEduM3NPSFZ1QXdmTm1ZalVCZmgzaWRYaEhJ?=
 =?utf-8?B?UG4vYXJaT1p2Q2QreExNQzJSazB4SWFaOVgzUWdTOUtsMTlOZFZQU05RVnFh?=
 =?utf-8?B?MWdWSmU1WVRkSDJ6Vm81SzlwY3Y0RXZWQytYUm4zL0N0WVZJQ2xGR0JKdGYr?=
 =?utf-8?B?aTJibXBQTGt0RnhBcDZBcGt4U3E0ajE0aEpLVko5dnE3QUdPdHRiaTRGbTAv?=
 =?utf-8?B?V29VOFpUc3Z5U3FvRTl5elZqTGM0bEVta29WTDBxZU5CSyt0UTQ1ekdjdk1T?=
 =?utf-8?B?dUxKczJuMGtndkprTU1UNnZXcDhzbnRBYnZwclhWc1ZVcnhmeVlFTFVUcm9Q?=
 =?utf-8?Q?VSjk7zK+B9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNsWmhBdzF6SFprZDQ3dSt2UG1wZ3VTMDd3ci9iRzJ4MVhmZ0tXcXJvWjdD?=
 =?utf-8?B?QXZhbTVIbVBRUEpnUGhLRVlqdmhmdTZrbGkyZ1kvNFlQMStCaHhkZXdOUWll?=
 =?utf-8?B?L3A1L3V2SjJWUStmSVllM2EwUTNDUGgwa1B2eTAycXVQbGY5M3ZtbUJLTUlS?=
 =?utf-8?B?d3d3clJTYVcwSmJlekdzdkpJaUhXUDJIN2U2bW5pRHIrNm1xNjlZV1NoNWtl?=
 =?utf-8?B?MmpYY2J6NTNqMGsrWCthb2pZM2YrZTVFQkZwVTU0R1BpMnZNWWZncUk0ck9C?=
 =?utf-8?B?L2FKd2pNdlg5anFRNjJ3RWtVRGdKL1lMQ0k0V0xDeFRTTEt6eGxCQ3pEYlAz?=
 =?utf-8?B?UjRqZitveGlqNkNDSHRoVkl1UmprZ053ZVZNU1Q3RGl5NDdvOGRKZithSGIx?=
 =?utf-8?B?Y2llSTBaZ1BOYUpPYk9yM1pyTnFQYURzRFpGbFo0cVQ2aHFNR3JvY01MdjRn?=
 =?utf-8?B?V25uRUNvMmVsclgxY2QvcEtCNk1YbmFiSi96MnlPaFk1K3RjZCtIM2JXVjh4?=
 =?utf-8?B?T2VLTVBiYjNIQU1OL0pyR0JNL3NhZGJkRzUvbnk4MVgxb2ZiczNiUGlFQ2Vm?=
 =?utf-8?B?YnNnckFodmp3by8zKzhyazE0akNIQU9lVGZocWJvVVp3OCtBYWdmcm9QRndS?=
 =?utf-8?B?MG1hUGxhdTlGTCttQmFrZytOZE1uNWdSZEFGNGk5VmpDMVlPdlU3ejlsRGJz?=
 =?utf-8?B?S2pmbnUwV0N0aWNRUWZsOFhtSDIyVnhNbXRIVVlLU2lXbGFIME9uVjNxQ3k1?=
 =?utf-8?B?TEFaZ1hiM1VTa0FUTlZ6VlZLWVR5ZzFteEI1cjIyUXBKUFE0YnpKYk8vbVNK?=
 =?utf-8?B?Nm05TlZJaVdUVXNWOUZZdkg5MEZzV285TGNIOEpZZHEyV2dNa2J0NHdyc3Vl?=
 =?utf-8?B?QUdZd3FNZmM2VmlDM0Z5S2RJaDNrL1JqRmZ4bzJDNVdPY3JkeUVJT0ZGUnlD?=
 =?utf-8?B?Y1lTbzdzZllFc2pRRVBjZGdLL3ZYZCtuc2UzN0tCY1J2MjZ4QU5Vc0VBbzVD?=
 =?utf-8?B?MU4zSE1mNUo5UGhhS0pCTFNvMFlzc1hsN0xTMHY1djZTa0lDMHU2ajRibm9Q?=
 =?utf-8?B?eGVWV3E5THk0aU9jYlRDdW42U0RtM1ZkYUdGWUJ5WmN3bkZ4UGMwRXJ4ajdW?=
 =?utf-8?B?aElEY1I0SDN4ZzBCV2pib3NQM3BrMGVPaXJRVFNnckhXblFVcmhvMEpIL2to?=
 =?utf-8?B?OUdYejJPaWRDbGFaY3hleTgrOTFrVk92QWttbTRnN2xibDVXMGoxVXZWYlhE?=
 =?utf-8?B?eW94NHN4ZTF6VnhMb0JWTVMvT1VnUEpqdVlXdjdaS3JDZlo0S1gzaFlveU9B?=
 =?utf-8?B?WitFV3pmQTZtWUpSMENyV0FYZUthdFE3RXhmTk4xbUloQm9KS0x4UnUyRGNK?=
 =?utf-8?B?dW15M0pTcUs1dk5zcUFsTTJqWnJUa2VlZWhiSXVDUlNsT0xybm1xT1oxQ1Nq?=
 =?utf-8?B?R3kwd29vYXFDU1VpaEtWY2JJMStWRzlkcFh0bTBDWlZvalMzTzNGRTd2ZFBh?=
 =?utf-8?B?aW9TT291dXI1MnZhQ0wwUWpEanpUbFhqRDNOb0FWakFMeUg2YWNjMjFoUHAv?=
 =?utf-8?B?ZDhXU3NMRjFjU2lmVWl2ZFdqWFFRc2xUUFVYVUxuRlZCVjRkV1hUN0VOOENr?=
 =?utf-8?B?NDcxSVBuUjZSZk02OHhscUNzUDRDQmdPNkVDYzdxQWxuUEJMWlBtTGFrS01n?=
 =?utf-8?B?ODVtd1d4YzJLY3E4SVZxNDdpNjZSVmRKWmhFejc0R3QzWXZhRFhUbi9URnVU?=
 =?utf-8?B?b1ZoZmVxdkFkQUJSazU0d2pvaFdWSElHWUxPSURLK1pGazNTbUEwTm9Uc0F3?=
 =?utf-8?B?RWNlb2UzSmFmTkovSW82RTAwT0Jqb2FnTFkyWlRNemh3L3VaYmhoZlVmWXcv?=
 =?utf-8?B?bitpc0ZBRDJzZGQxVXBjUkFnTVVQMEZDa1VlZUdoZTFDRnIwK244QXBlb1di?=
 =?utf-8?B?S3VGOXUwd3BOVjVETmdMRVB0WTFGZXZLMzNlVisrZG1rLzR5NlJqNnQzT2Fn?=
 =?utf-8?B?V1J2RTVuZURpV0NwSitMeEU4d2ZyL3ZBdnNReU1IM2FuaW1RNEszaUk3L2dQ?=
 =?utf-8?B?RzB2ZCtyT2FhRzRRai9tTzJJQ2pUcmFiVi85RFlpanNRR2tpVHNSaXliT01j?=
 =?utf-8?Q?3lHbGgKk8Vh4n0lMeX48TYXiu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02250c84-0998-46de-e253-08ddf082b9fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:57:21.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eM3D/VZSMfrpSRi87t8cUZSENVJ1JtocTr5EkmvYpsRicQMU+dOHWWoyjV4ODU6iAgkox57f4vaCFf0G9f4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727



On 8/27/2025 3:04 AM, Lukas Wunner wrote:
> On Tue, Aug 26, 2025 at 08:35:35PM -0500, Terry Bowman wrote:
>> +++ b/include/linux/pci.h
>> @@ -2760,6 +2760,17 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>>  #endif
>>  
>> +#if defined(CONFIG_PCIEAER)
>> +pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
>> +				      enum pci_ers_result new);
>> +#else
>> +static inline pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
>> +						    enum pci_ers_result new)
>> +{
>> +	return PCI_ERS_RESULT_NONE;
>> +}
>> +#endif
>> +
>>  #include <linux/dma-mapping.h>
>>  
>>  #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
> Would it be possible for you to just declare a local version of
> pci_ers_merge_result() within drivers/cxl/ which is encapsulated by
> "#ifndef CONFIG_PCIEAER"?
>
> That would avoid the need to make this public in include/linux/pci.h.
>
> Thanks,
>
> Lukas
Hi Lukas,

The move of local merge_result() to exported pci_merge_result() was requested 
by Jonathan Cameron:
https://lore.kernel.org/linux-cxl/20250627120541.00003a14@huawei.com/

I believe the intent was to make reuse of the PCI merge function to keep the PCI 
and CXL UCE flows somewhat similar.

Jonathan may have a better explanation. I'm not opposed to either solution but 
adding details here for discussion with Jonathan.
 
Regards,
Terry



