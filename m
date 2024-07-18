Return-Path: <linux-pci+bounces-10533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F593517D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E80C1C22DC9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB7145A15;
	Thu, 18 Jul 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZPLW+mNO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7420145A11;
	Thu, 18 Jul 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721326068; cv=fail; b=Db+kRiPWNbG4gcIZkriZlPpvBVok5YAMLysbYdCwPB8LTitnVwo7a97B0YQYyO3oTRlJyY0F7dxdoJuNxfI9fkO4t+hzXrBH5TaifOUKXJ/qpwXMqp8g8zJibhS3AFzlWCWXf0kcSTfnRQSwe9dM2uIh45k9KQwxHOJpNXZKL74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721326068; c=relaxed/simple;
	bh=xB2+e/DWX/PjwpJxUvZdh2Hp25LNiicQltvWLGCfAmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tMU1/tNPWugQE5qIivsD6GagJQ5k4I9lvSS7VVlLJlFWfN6ysa44uW0gvsIjfFGLeqtZkMkLpU61+MWsq+Ftvc3gm3lPzY9Ian00SdZ9xd3vGOaCfpDzSw1W9b2u8OX3FwmZ0t1hpOaDHUGZYzYExi75nszHC7Ztx73s45TRFyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZPLW+mNO; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0oj26JNCCIdhMEWhchZt7S9Gozw8vlF6myuvdkpmd6ktg5Bfz4RW4uLyTDKl30EHyGBaVfPJg9BXp6fPt8hsCzX4UIuKLQRl0SiLmP7afti6uqg84PIau/AM9oc0Z7qQg+PhP1JfbcgOg3A86NWj2HtiNtxmle/wwLsglGDitclulqfi2wzSrWxVG4HLVZUYKT5aI5viRo4WBIej14rIjYMEwJYGxgdDqqqyiZaprjoRm+1Lr6cNo5A8PIQqZ+cXv7Ymn5FTCLj67cgdIqsT96eacS6HLBkEUFjznvraeXAfitMUXAuU6mRV3dRwveWa9cIOB05j3G6fG1k7k2JGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHq4KkFd1QgzwAL03uzR0m7COj05vOO7CSNanjvindA=;
 b=UYMVtxCtGVRtRB3aWAc2T8zSEFVFrdL579WLAnxz/zar0IwnqNhCD62OkGqHQyom1aetqvG5/PVyJUyWpjeQyxMvX/AyFEkg2CiLiYwXz7dXDTJIMVUjbJL7UJfwKP3MNPlM6b1+37oZm8NqHKJdBKwBhPRmhHfEcXOyacQC5k1M5ChQyOwQ/w8yiL64VoQKXGoGwe6kKe8roIHRomZu80jjl8tQC1XX/oq1N7X7HaC9gRZEfxpmoWqaKUbAIjMjm3479hSwt0c1YH0mLzZ+/DYaVwHXX44PIxkoMb0NUxKzqAdKR6LvB/nUtFH1KMkR5LnYmGWwY0fy5K4sLIyDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHq4KkFd1QgzwAL03uzR0m7COj05vOO7CSNanjvindA=;
 b=ZPLW+mNOwTnp9x45PonDQINxPTBMl7sXE7/ClSA173n8gSoQTF9Q0u5N/5ZJygqULdj4tgOsDR/IAuhMRkxuH3Qqmj/5lnmEbwF0UAsD/xsveQ7/NSYmiRTpTwmgLQFqlN/486e5RjBlaqQOrnptqpj6UOVl/8QruWWcua03jto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 18:07:41 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 18:07:41 +0000
Message-ID: <95ea23bf-b628-4fdb-a4ef-0029f9df2ec2@amd.com>
Date: Thu, 18 Jul 2024 23:37:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/amd_nb: Add new PCI IDs for AMD family 0x1a model
 60h
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Anvin <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Muralidhara M K <muralidhara.mk@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <Avadhut.Naik@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20240718171342.GA575689@bhelgaas>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240718171342.GA575689@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::33) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 57acd565-fc9e-4e2c-0902-08dca75483f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2ZDbHpvNGVoVHBpbUdWbEZpaFdSV2RvSVRhenZFbUlPWjJWUlhJcEtGMnJk?=
 =?utf-8?B?SVZPVENnOXpsdURqUUhNVHg1bWtVeFdtNFFWK2JpNHNsUUxxK09JbURUWTZK?=
 =?utf-8?B?TDZTWC9icWxGRHNXVVM2N2xuM0xSVHBWYkVhejhHand6STlEcXdObHZZV2Jn?=
 =?utf-8?B?SEp0RmU0TVBNT2R4WmNjdDIzaDhZeW5sK0wxV0E5MlpMZnBGQ3o2My9zNHQr?=
 =?utf-8?B?N25GdDlaT2hGTmljRVdRTUhOY1I0M3NEVC8xaU1wQkZGcUVKd1VuUVArUzNQ?=
 =?utf-8?B?VWJXbWREZWNqcjBMMlJ5aUVjWjM2MFV4OWhuVjVkYklrbHRGU1BMUWdxTTVm?=
 =?utf-8?B?Mit2ck1ZQzhGZkNvN011by9HeFIwNTRXVm0wekFBZWhsNERKRlFXS3BjU3I0?=
 =?utf-8?B?UklLNEpIaHh3eG5iQ0QrSFZ5RW8wcUh1bVhkdkxjbXFBSWpjL3lOQ0puZko0?=
 =?utf-8?B?WThNS2pnZDZtZ3hhTW9KWnkrb2V4aSthVW1xcStobFZOVUt6Z0FRelo2Ymt1?=
 =?utf-8?B?V2l3WXVvc0d6Vy9VbG5yVlFlemJEQy9yMTV4ZnYxVTZNd1p4MDI5NWE4bWk2?=
 =?utf-8?B?MUxlZDM0c05XengwZ2NHK2N5ZElTUnFhc0pIaTRSNkJxY0IrNXJTd0RhRDlu?=
 =?utf-8?B?Unc3MU1qcTFMTWNvMC9NWHZ1N0tpNjd4UGYySHhXSVJibDRHbU52aGxORWdY?=
 =?utf-8?B?Zkp0dWtuM3JGdkVNN1NmUzNFbXVzYzByY1o3cXMwOVBYeGJlV2IrNy82TmpF?=
 =?utf-8?B?bVNYcVpBYm1BN0NETHJ1R3ZnM2NJaExXZVVBczBPQVNFKzFjeVRWdEs0bUdu?=
 =?utf-8?B?SXYwMjJkTlhPUDdsSlZxZVN2b0ZBZXdwWGt4MStaNVhtVVRpbmQ5eUtzeW5X?=
 =?utf-8?B?cEYramdRYWFONHl5dWFkeUUva0dXcnhaR09ZQXFRdURLY0tUWnZYNm1NS2gw?=
 =?utf-8?B?M1c2TzVNZ2pNRURVS2Z4WDdtcDRkY0VmSWtIMkkwOHUzVUJOUnpGTHNuaDhV?=
 =?utf-8?B?UU83aHQxQ1FOcHV3djdJc3VDWis5akhVcEUzOEJBVGpaeFFVOHVielMyNEVm?=
 =?utf-8?B?TzYzUlJyaDdmQWVxT2RWeW1kQ1QycmJzbHBobDBwSVg1eUZtalhZY2d0NU1o?=
 =?utf-8?B?TlJtTmVsdGx1Sm42Z1BYZG1pOVhJclkvWGNOWWpndUsyWU9GeEdzM2NCK1lp?=
 =?utf-8?B?ZmVTR20yZno2cUh0MTRlQ2xjSys5ZVZ3MUd3aWxoVWp5U1o2TjFydlNyeUZ3?=
 =?utf-8?B?RjNZWUNCVnJaK2dmWFJ5ek1YdnRjdmJqK3FUVmMrdk9tK1kvdFFzaTFpZ3A5?=
 =?utf-8?B?UnpLajk0OFZFak9aZUFXblRlbVoveE11T2Q0RzE4YlBOVE96SHdjVWpVTWtS?=
 =?utf-8?B?VWw0NmRBVFlwZC9TYmpnT0dRZCtNVzNCVC9EWk9ydTlJbUlvU2JZRERHY2Jq?=
 =?utf-8?B?YnpmRk5mOTZlc3F3SGtIdGVGSWxILzVGM0pFcmkrZW5RQkFQL1NHckNyNmpC?=
 =?utf-8?B?Q0lSRzdpUjZUMmlZZW50ZGlMMHhpc2VScU16MUxZUG1qMmlIN1VBNEYxVlQx?=
 =?utf-8?B?R3FubnA4WkFhVEp6NytFenFxVnhZcWdzemo5blAzSVBpVU5LMGxXNHllZkN2?=
 =?utf-8?B?MmNldE5GdmpIZmRjV3I3SGVMbXdVWGFyaFFFckVVNFFhVDJJUjA2VEtRdXBH?=
 =?utf-8?B?T1Ira3NuZEZjOXZnU04zU25kYVBubTJTZG9QQTJJUVpMWXJCZS9tcFk2ODR1?=
 =?utf-8?B?bTltbWpwd0szSzI2SzRNWHJhNzIyTHByM2VmcHVhaXBkbytESHNFZEdEWGpl?=
 =?utf-8?B?VGMyZ1NHODUveDR5dXo4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?USs1L3ZUc2hnWDlVMCszaFo5L1EwQnJqcTdXNVpXczFaRitsalc0K0FGbmJS?=
 =?utf-8?B?bC82QllTdktCQ09Qd0czOTF1Q0tVTzZUeTZmRW02UlZ1aVNBOEFVT0VMNEZy?=
 =?utf-8?B?UkNoQWZQeGw1UGZ6QVZvS3pMU21qZHlZSFFmeDFOaExVeURGSUp3UXRoQ2hU?=
 =?utf-8?B?QXBCN0xMOU5EM3FEQUh6WDdwZXpEaDh4S1h3V0pJT3JvUkJFRlNjbVVEa1hB?=
 =?utf-8?B?VXRKWkdyQi9ESmYwWGVOaEJzdXRYV2Faa1ptS0htbnkycGVobUtFTlhOZGRp?=
 =?utf-8?B?SkNTeDVzOEpnVWE4YWtHS0lCYU5Xcjc4ZmNnVjJ0MWZQdFF1MjZwTE0xdlpZ?=
 =?utf-8?B?SWJuVkM1MytDWnZFWUpFb0ZtQVlRQkJOOXFZbEhKckhZa0tIMXprNzhvTXVL?=
 =?utf-8?B?OXh1RFhEVTN2eTB5M1pGVHpEd1E4NmlVU0trRlFPZk1QNERRU0cwZDFneVRX?=
 =?utf-8?B?NjQwUzJUSDlydnhUdEtXMW1JSGVwY1FaQ3VDR00wWnR6QVJSWTJPMXRXVkZV?=
 =?utf-8?B?RUZHZjNRbTUzeTU4ZkRjSHQrT2JVR25sb05vRlpwV0VMdG1PNzJRbGI3aTdp?=
 =?utf-8?B?aW01MHM4bjIvME0rUGZzK3NIUE8ydlM3NzJaYXRvNWpWb1hPcGlFSDE5MDh3?=
 =?utf-8?B?eTJSN1gwcmxRL0JOYU9vSHRRMFVSWGVxQU9xNFpzUkV3WmorNEtLMStzL3dS?=
 =?utf-8?B?cnVLQ1RZazJnK3N0blorMlFKV1pyMXg0WlZ2Y0pwRGExaEQ2VWFnRldQTmdN?=
 =?utf-8?B?UUpNdVZtUFpKQ0pmamdzYkg5UXAvNGJPMVlCVk5uSlRVL29RcjRNdTlMOGls?=
 =?utf-8?B?Tlcvb0xtdDkvME9UcW50S1JXNzZDaFN5VWQxUGtKSk1weGlFcHZGVzdEVi9G?=
 =?utf-8?B?WFR6aGZMNWZwb1J6aUZQbmFnS0dxU2dJTkJOTUFzajQ0amIwZmpjMDlNTEJJ?=
 =?utf-8?B?RVYwbS9OcFlJK2h5d1AvaTNWQWUyYTZSOU9MWXo5dEpiNVo5V1dOYko4aHFP?=
 =?utf-8?B?ZmRKM1JRMzBwQm5QTlZoczZWM3g0aVZROE9jb01WQ3pkeERhemVuM09aUGJi?=
 =?utf-8?B?Y2hobWJLcDhMYmtETjdwa3MreU5IbzJrcDZTeVBTUkFveEs0cm9vak1OSDA3?=
 =?utf-8?B?b0did3BrTkZQMGJueGl2MUt1YXIzdUNldHdWUGdDTCtQUUkrZkFFTG8vTUEw?=
 =?utf-8?B?YlBRdHpjVnBWMGhUOVl4djBWUElpakE1QWtyV0lOVkc1SWFhVjJ5RlRReDQ2?=
 =?utf-8?B?Wjlvamh3bzFXR1dlb1F4clNaSHFtVkJLenhWakFrSkFhUGxmRWk4cDNlNHJS?=
 =?utf-8?B?QkE5RUdCTkpTL0lBVFVQak5OUTUwSUZwNWc3ZWYydWdubjlnaG1FNkZrbnk0?=
 =?utf-8?B?RldQUXJaYUNJOEVtWHloMHFkdHFGQnN6SXoxZmwrWEpTbzliWDl2YjNUWXdu?=
 =?utf-8?B?UEllcVVzeEZHbFk0U1Q5SEdlT0FIbHJBNU5WV1dYQTA5cHNlenFySjY4VzF1?=
 =?utf-8?B?bFNZOWRMOVQ2VjhxVnlaWEZPc0RaS1BzMlBsR2MrQm5sc0pPQU11dXplbTVN?=
 =?utf-8?B?Z01iT1RLb2pPZitvbXNDSFloWWVneDFDbCt2ZUtyQ0ZlUis5T1VuSHIwNWcz?=
 =?utf-8?B?cTJ3Nkl0bWN2OXdPbnV4SjZWTGJUSVkyb0RONXl2d0ZRWFlyUTRkT1pIRndV?=
 =?utf-8?B?cXZ0djBLM25qc3RKSTdsS3poSVZrMEFFYXhXck1zNXJEVk5VZDlwR2wxSmcx?=
 =?utf-8?B?R1dYTURhdGhUTytiejY3WWgvVmhTTGNvRHhPdmxHSTMvdjdhS2NMWEl5U28y?=
 =?utf-8?B?TXZLL1RJK3E4QTcwdUtUQnh5YTAzM3dCWndDWTlsYnNKRGtJR0svblVEV2hG?=
 =?utf-8?B?OUROQ09FTDhkM0JOWEtUV1haUU1YRFVkUGMydk5KZVdtYW11V3U5eWNlT2ZI?=
 =?utf-8?B?VHNCK0t5dVlHZ3UrRE1ZdGtDVHVOYVVhanFpRnVuemxWdkxnOXAzaEZFRGVT?=
 =?utf-8?B?bHlwWkxJUTlLWnh4VGw3TU10S1R3UkVTMVgyblVNKzNMdzlEbUowcnFQQ2Vx?=
 =?utf-8?B?d093WjEyNWRualZDNTc3Y0pRbTFmcW9lbW1WTmEyZGNnS2Z5aEtRa29NYUxE?=
 =?utf-8?Q?J/QtjwdYopv92BduVr+WkZArf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57acd565-fc9e-4e2c-0902-08dca75483f9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 18:07:41.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50MKlsxFiue/XTP2Cv+5bT1uWVHiKPJTQ4HGF8SNNrUesR3h0lyi7LFkb5uuT+jSfkk7qUePlBmhpmsHGZydbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920



On 7/18/2024 22:43, Bjorn Helgaas wrote:
> On Thu, Jul 18, 2024 at 07:32:58PM +0530, Shyam Sundar S K wrote:
>> Add the new PCI Device IDs to the root IDs and misc ids list to support
>> new generation of AMD 1Ah family 60h Models of processors.
>>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>> (As the amd_nb functions are used by PMC and PMF drivers, without these IDs
>> being present AMD PMF/PMC probe shall fail.)
> 
> Is there any plan for making this generic so a kernel update is not
> needed?  Obviously the *functionality* is not changed by this patch,
> so having to add a device ID for every new processor just makes work
> for distros and users.

Regarding AMD processors, there are numerous PCI IDs defined in the
PPRs/BKDG. I'm not sure if there's a generic way to address this
without a kernel update.

> 
>>  arch/x86/kernel/amd_nb.c | 3 +++
>>  include/linux/pci_ids.h  | 1 +
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index 059e5c16af05..61eadde08511 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -26,6 +26,7 @@
>>  #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
>>  #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
>>  #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
>> +#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
>>  #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
>>  #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
>>  
>> @@ -63,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
>>  	{}
>> @@ -95,6 +97,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 76a8f2d6bd64..bbe8f3dfa813 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -580,6 +580,7 @@
>>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
> 
> Why not add this in amd_nb.c, as you did for
> PCI_DEVICE_ID_AMD_1AH_M60H_ROOT?  There's already a
> PCI_DEVICE_ID_AMD_CNB17H_F4 definition there.  No need to update
> pci_ids.h unless PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 is used in more than
> one place.
> 
> Based on previous history, I suppose PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3
> will someday be used by k10temp.c?  Ideally a pci_ids.h addition would
> be in the same patch that adds uses in both amd_nb.c and k10temp.c so
> it's clear that the new definition is used in two places.
> 

Okay, I understand your point. I will add
PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 to k10temp.c in v2.

Thanks,
Shyam

>>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>> -- 
>> 2.25.1
>>

