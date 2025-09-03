Return-Path: <linux-pci+bounces-35347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB9B41226
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 04:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46936206CA4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6331DF248;
	Wed,  3 Sep 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3z5AFFKL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CB1917CD
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865279; cv=fail; b=lNNB7IGE96UkUi6VlinupU+wLRULhGg4Y0XlJFOVsuRR2IJYCsDs37FUF8f6rZ3PL+NwhpUZhLzx9ssrkgRpxcI43KWL2ZSIYhOUSumUbkUDbZ8bJxHHB2RznrtaCVQki10OY8fJniyF+bD+txSqoXmh1BpfPYJa1+8o914IKaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865279; c=relaxed/simple;
	bh=Qxqv6ML3AGGh3cF9WwElo/9tzRIaWxPkfIUIDBhrOM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u19b4b9pwMPXytWyyJXFiiDfw01Ye9wQsjRtQY9U+bqMmDfeBxxmo4in+8hmw1EqnpN14sL8WtA2ORUJe1tYk8O2lyZJTqJnE5Orf/BUGqHJj03jGnkxvB8faNrX9Mmzdydv4uqKHH8SVm52cI7AFGF/LPHlYLxj2lJ5kmauKCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3z5AFFKL; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj9Ga87+dXK+AxBuXmhXcFm0wYZGG/Hl42RXg0qJJZOV/TiZZrNIDOHu9gpdEeBqE/xQBnGeq/Whl3N3LL0E9qXNohe9B/2sEflBueIz7nekA7UqHcLcDL+tbGUPh+sqZ5ejG/KXOJLIWqY8i2ZaPNUxsKeZ31hFJnHVPX2J/vhn3tp72Ug10SXo/1TNfwnM/lDDTuPAHTVDnYumq+50PAiwGjB2RydIfo2QE6ZpOY/PWjdJxDGxrquQ7JpNh3YmosKJyEsn5R70OkhT42PVMbfipuHlNZEnMyRSv/YfRjy53FVYhxbhR6MXS9ZiAfw4qxqIosWdsRjCAwW7M+NACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYtnKbvPorvKUc7nVWdqMfYg2BIYz/dCvxSCXmCYxUc=;
 b=JKpWEP9PuGChh0+e0kD+UkgY9n4dlpBl0IKsw1cHOcjLBhxtUYT2yU8vTJdxcP5xk8phKxt6Je7Q39vvI4M/4aVcVqL47CYKP+A8j4rNfzaRzXqSuF+dkgyl7x8uZ2cCrs1Tndo8RbUga16vfZcCZo6QkwdPoy+8y8hk3kvKXrjxQcMOiFAOs6wiCykec9Z08XBoFn0lk49QpeJPhEeyHqVzsZDdxs2ZDAkoUrXCY2w+8gHwRTV47DJ5o1mjun59TI73KWwpHMU9AAXGTN7I+GLvCg//76j9f4ym4Tu6mUoOFEp22vcXDcCYEv45wx9Q2LJCkn70Fmr9hEON9X7dhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYtnKbvPorvKUc7nVWdqMfYg2BIYz/dCvxSCXmCYxUc=;
 b=3z5AFFKLlCUIOGLMnrwP0C62IuqOeYf2mYHQ8qa1VpPL2TCLU75Wwz5qRVO9CaR3sv4JFtKom2LtnICR72CfIBsf2+nKUOZ/jSTjKJkW70yEnORgR8kYQ3/tgZF6RVF0kRT21LdsJdAm5hEIBO58arqNltuJvHg52Kc1gS1c6wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:07:54 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 02:07:54 +0000
Message-ID: <8be9cd2d-6a13-40ed-97af-0a6129b2756b@amd.com>
Date: Wed, 3 Sep 2025 12:07:48 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, gregkh@linuxfoundation.org,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <yq5a1poo3n1f.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5a1poo3n1f.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0120.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 85528666-4d95-4108-dc80-08ddea8eb19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2REM2ZlT1E2T1pFYmRMLzFDazE0TW9SeEUvRFdvRklHV1RlbTNiZWtMU0xy?=
 =?utf-8?B?RGV5ZFgwQlk4Y04vU0ExWVVzMEJyNzYzVEEwYmFuL0FzNmMyQ25ZV1dPc1BI?=
 =?utf-8?B?TkdZRXhtVWNVbmJNeWZCZ1VYMTVaL1F5cGhkZWdsaTdLREsxMTZyMXZ6UnJJ?=
 =?utf-8?B?MVJsNGNmTWYza2lmQXlSVEk0SUV4eGVvLzNlUEZIc1V1dzAwTVRGY0VzcXRr?=
 =?utf-8?B?aytqQWFlQUNlWW1KempwOSsrODlHSTNoNkx5RSs0UlIyWUV5THNNVGpWdTN6?=
 =?utf-8?B?V3ZQMURUWm91YTl1cnByOE9UNVZ0U1JvNDNHamo3OTNvVWl2UTFoM3NsNU9B?=
 =?utf-8?B?UFZmdlg0K25vbDhuMVhQRG0vWDhPTG5hQXA3TzcvWk5mSlpXNnJMYlNaVEI3?=
 =?utf-8?B?K0VjM1ZsdFZpN21vd1BLY1B6UTk3UjBwS2xvTUJwTmhkQ3Z3YThWQTdyNmZW?=
 =?utf-8?B?RXV2dnRwZFduRFVkZDR2R2RHTlloUG1OZmNEdW1abjVOVGlDTXVsRTJKTnB0?=
 =?utf-8?B?b3RtVFI5bjFLSWV6TnhYRzdDb2dWeWRicXNQdW1TbWRCeERaN1VjYlg5N0Zz?=
 =?utf-8?B?S0IwZWdUcE9Vb1IzNC9iY0tMT1pYOW1UWUtjcHJWRkFxcC9oeDBjYjQ1djVT?=
 =?utf-8?B?RldlNlZIcVVvR2JXcDhSYzRHMFhRM0tjemNNV2JVRXEwVjFua1ZvdG8rZGFv?=
 =?utf-8?B?QmVtWEFlK1JmU3NqZHY3clpsYVdDM3VtSi8rdkJxbG9HRU1QWEFLTmVyRjd5?=
 =?utf-8?B?Y3BnU0JQM3NlN1I2bnV6TVBLRU1oNi92WTRkODdpakVuVnh2TGFrUlp5M1JY?=
 =?utf-8?B?TzU5TmdpOTZmdmVWUUQvTDNKcWFCZmRqMTVJZHBoTk9YNmRlS1d6WjhYOU16?=
 =?utf-8?B?MklzaHR4SDZWZ0RIOEV2azFaQjJIM2EzTWgwNU9LUFZOeEZ3V3UxOW9aMjZB?=
 =?utf-8?B?NUZBTURIZTVsbjZCL3VZTnFNR1FmUHhCRVZZWkxZaUIrQXVsZG5lUnN2Tll6?=
 =?utf-8?B?QXg0UHlpbXVQcE5vWmloTjVENEtLanNoRGJsR3A5MGN6bXhIaUp1S3h2QVQz?=
 =?utf-8?B?a3Rta0ZINXZCMlJiUjJUODAwMk5xU1I5RmFQZE9Xb0QwbFJaVXRXWTc1MjBX?=
 =?utf-8?B?Q1o3bXMyVWpXOWV3VVMxa1lybUtxb2QzcGtsQ0F4c044d1dLZEVRamxNMkFu?=
 =?utf-8?B?OXhDRmpMM3NCRXcvRUR1Vm9nWFNhNXZoVVlldHd5WGFNRXNpZS9PcmpvYisr?=
 =?utf-8?B?cjVUUHdDSjhkRjlJY0FvL0xwcU5GY2NZSlg5cnhFSnR5aENiMVJLNXpKbWtm?=
 =?utf-8?B?dHVDTSt1eHRBSEtBaUs0SmhSaWNZdmJhMUQxc0RGN0VBQ1U1aGFqYmM0TzZL?=
 =?utf-8?B?V2w4V01lTThXTk1nRmNreDdDSUVtM3JXdmVWcXNxd3pHZnhFRE9pQWpQUkRk?=
 =?utf-8?B?RE5xSW1lR0RwaXNndjkzRFpieDZPOW0xTEdzVlJqczZJRS83dEpSU21QL2pS?=
 =?utf-8?B?WWFzNkFraHZ4b2VLbmtDUjNFSy92WmU0RmtJZDZ1U2d1cW9PYmtIc3F2bHNy?=
 =?utf-8?B?NWFsb1cyYnJyRWVrcy9kSzR6Z3VuRWpBV0VFUnJmc2VIdEJsWkNTa2IrKzhp?=
 =?utf-8?B?U2xMYS8rVzRFUDlDbWc1UGYxditBcjNSaXBlaXJuWlhMY05hUFpuM01jeVIv?=
 =?utf-8?B?N2ZsOWFzQkNETXBMTEdpcWRlcmIxaU5xS1ZIYnZQa1F6MVJBOU5KMEx0MkRT?=
 =?utf-8?B?VU1lZEJaMVE5QzdndFNuNzRXcnFtYWNSUmsxL3ZTRDdjTldtNEcyK0wxQmNX?=
 =?utf-8?B?TVdVSElFUUMyT0d4VkduYjAzNGVSaUtjRXora0lLdzRVS3lrektERVBIM0sz?=
 =?utf-8?B?NnlCNCtxM2NrVXdXR0hXcG1sS2xpcEg5ZjBQMEVLV3VsZUJvUkV1QkoxU2pY?=
 =?utf-8?Q?S3oyW2lDlcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTFNTmU0dkZCTDVoSzdpbjJIUUVjcXMwUUMzRmk5dnFWajkvZGxmQlhZK1h3?=
 =?utf-8?B?ejIrdGdYOUZWNkMrVUZsNFBZMzhUQi8xMUFLNjNrelFLTXZpcjBrSEtSelJh?=
 =?utf-8?B?Z3drenNCTHV5WlBxWVF3Zm5oMWZOb3NFMXljaXBiN0ZXZzNuTG1wckdhS2VB?=
 =?utf-8?B?T3ZNYVMvS0pyUFk4elNFR01wTUZQdkVHQUppa2lIRzM2dStBNDB0Uy96aWQz?=
 =?utf-8?B?ekF1TkFoY1FrdnBmODJBZW13RC8rRmhhL2xZYm1ja3RJYWJpRlZ2VGNkMmRx?=
 =?utf-8?B?K0FSMm5tWXdtSjNRSDZ2Z3RxRTg2djM5cDlvYzNhNHh2RTVES0dUQVZYNzgv?=
 =?utf-8?B?bXZ6WDlwQlNYY3Q0L3VMVkdnYjBlZlgyUlRxYzRWNXQ2c3JVRjVpd3krLzRO?=
 =?utf-8?B?YUVOWm9iQnBXL0lnbjhPTDcvZFI1SDVGejgrWmE5OHYxUlU2RGkrT3pZclNq?=
 =?utf-8?B?ZlhDSHpNdzk5d3VNNTY5RWtyKzZPT2QrbXJZUzFHV0JTbzhGc0dXSnZkZ1Bh?=
 =?utf-8?B?aWtmc0FNTm13czF2YU1SdWZGUmc2TGVpeFhrQUpJdjJlL1pnRHg1M09SZjg5?=
 =?utf-8?B?TDRpRFZiblViejk0Uk9OMkVwSTBlWk5jT1o5ZXIySXVSZDl3ZXNHM0J3M0Rx?=
 =?utf-8?B?VVZRQ0UyLzFlY01NeTcvMGRFU1pZRW4wM0RWZ1IxdERpWkI0U1FFY3lkem5X?=
 =?utf-8?B?cGZjT3lXSmNxbGowRHE2SHR0ZlUrK0NNTTBCRkpKOEVhRis4Vmd4KzJhdzVX?=
 =?utf-8?B?Tk5jRnRYTXFMYW1FTDQ5YkhVQnkzZTRNY2o1eTU2NWR5VUNUQ1FLOVZvSDBj?=
 =?utf-8?B?WmdhWGc1M3NhYVlJa21UY3JCTVZUeHVDZittaUw5NGRIUWhmWjZvQ1AyQ2I3?=
 =?utf-8?B?SkkwVzUwMHhXV3Z6eFFoTE5iTlNZYzZmdkhQVnlHcHdjSDd6WTR1ckhBVTZv?=
 =?utf-8?B?c2FNQXkrdVA2cTV3UnJHck5STC9JWW53UXZlVHJoRkNsYkM3SUVSY0Nhdmpm?=
 =?utf-8?B?ZGtBWFIxQk9QNzFxZ0ZzVUNsQlZIcFhaaEVvalVsVityU2ZWMHJmelRrVWRp?=
 =?utf-8?B?WEgwa1BTNXZ1NDZPejlVbFdlK0V2VWVORFMyRTlRTHlJWlZXWkJFQ3htRXVZ?=
 =?utf-8?B?SHJkcnQ1VEo1ckJ1VkdJZXJYbnExV2hkMFFsK0F5U3VxQW1hYk5tb05oelp4?=
 =?utf-8?B?Zk5sVlVDM3pOaXozQ2tNVXQ4RFlxV2VZaXlDdk9YQllFeVNZOVV2M2hObDJs?=
 =?utf-8?B?ZENkSzFBMnA0ZVpPSEErTkd1NGNSK3JvWFdBZlA4MGRWU1JPbXpIekVieWRr?=
 =?utf-8?B?eVlDSGxSSmtRQitiQzNVellsNHJiT3hCa0cwcWE2N0pybThWT2RxRGx3Qm8w?=
 =?utf-8?B?MFJ0elM0STBVbVI5Z05VKzI2T3g4RHEyb004QzY0clVNMlg0UDFvWGs3RWVL?=
 =?utf-8?B?c3RFTWhvVE4zL1ZGYUtjUzkyTVZuUUwwL1dRalBUOTg0clVBMzJuUzhxR0RI?=
 =?utf-8?B?SjdTVVYwZEMrNXB2bk5VK1RocGF6Yzc1RXpXVUpJWG96blNNT2VpTXk3Y25s?=
 =?utf-8?B?RGRMK2ZLN2krcjI4U04rd2tkWXMzdXJTMXlEOGQ0bkt1UGJCUkRsOFMxUHh3?=
 =?utf-8?B?L2lrNVIwQm9jSCtyMUVEeFE1bkNGTEFpZ0FUVW4xWFA1NHY4TkgzL2xtd1U0?=
 =?utf-8?B?VE16d0JEQjBKQm9UakVuL1p6Z3pqWEJDYWp5Z3JkM3pHeE4wc3dBeElyWnFw?=
 =?utf-8?B?MTFQRlVtN0J6bkU1ZFIvSDNNS3lwdWlpbjVUT1FBa3BZSmZHbVhaSkxvSDJH?=
 =?utf-8?B?TDRCWjFCRGtXU2thL1lheXAxaUorbExKaWRvT0VjM2tPKzVmejZoZlhyengr?=
 =?utf-8?B?RytwUlZOaThSUEx3OCtLaEF2SlY0RFlDSmxza3ppc0twRmo1WHNBWG12K2RX?=
 =?utf-8?B?c29pcXVJaEhCMGJaOHdrMmlPTzZ1RFF0d1FlQ25VWXlwQkI0cHVEc0FPZ1Rr?=
 =?utf-8?B?Zmx1UDdZU0JGTzUxWUF6WWZPTDkyVXhZNjJaa3EyTXVJZWNwc1IvT1RWZ0VT?=
 =?utf-8?B?akViSHFMVmY4NVRmT1RDWHc2NmJRZDhQU2wxRmMzS1d3MXgyd3VoK2cvS1RZ?=
 =?utf-8?Q?EgJlOkepP21ayDe604EX8Urie?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85528666-4d95-4108-dc80-08ddea8eb19e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:07:54.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn6Jg9M0Aqoz0YfwLWoPhRth17vrBqrWvfp8R0JMTXrRrAyFFSgmnku7oqf5J1yxNHRfLpQ3gzuq1AdNsblkow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801



On 3/9/25 01:13, Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> ....
>> +
>> +/**
>> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
>> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
>> + * @dsm: PCI Device Security Manager for link operations on @pdev
>> + * @ops: Link Confidentiality or Device Function Security operations
>> + *
>> + * This structure is wrapped by low level TSM driver data and returned by
>> + * probe()/lock(), it is freed by the corresponding remove()/unlock().
>> + *
>> + * For link operations it serves to cache the association between a Device
>> + * Security Manager (DSM) and the functions that manager can assign to a TVM.
>> + * That can be "self", for assigning function0 of a TEE I/O device, a
>> + * sub-function (SR-IOV virtual function, or non-function0
>> + * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
>> + * DSM).
>> + */
>> +struct pci_tsm {
>> +	struct pci_dev *pdev;
>> +	struct pci_dev *dsm;
>>
> 
> struct pci_dev *dsm_dev?

Unless we start calling pci_tsm_pf0 instances "dsm", I'd keep it "dsm".

> 
>> +	const struct pci_tsm_ops *ops;
>> +};
>> +
>> +/**
>> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
>> + * @base: generic core "tsm" context
>> + * @lock: mutual exclustion for pci_tsm_ops invocation
>> + * @doe_mb: PCIe Data Object Exchange mailbox
>> + */
>> +struct pci_tsm_pf0 {
>> +	struct pci_tsm base;
>>
> 
> struct pci_tsm base_tsm ?

It is usually pdev->tsm->... so it has "tsm" in the value, having another "tsm" is hardly useful imho.

> 
>> +	struct mutex lock;
>> +	struct pci_doe_mb *doe_mb;
>> +};
>> +
> 
> 
> Both the above will help when we have names likes
> 
> dsm->pci.base.pdev; vs dsm->pci.base_tsm.pdev;

What type this "dsm" of in this example? Currently it is pci_dev which has no "pci" member. Thanks,

> 
> and tsm->dsm vs tsm->dsm_dev
> 
> 
> -aneesh

-- 
Alexey


