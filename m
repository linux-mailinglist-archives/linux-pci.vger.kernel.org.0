Return-Path: <linux-pci+bounces-27403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF94AAEFF1
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 02:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F684E094B
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 00:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CA13A1BA;
	Thu,  8 May 2025 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UWfJhFVY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBCEEAA;
	Thu,  8 May 2025 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663683; cv=fail; b=VH8sXuD3rENAvoHlhUFw68kLQkL0WKxcHD3hq/sML+xfhKe0uAW8Fqe/3BEwvoqX4Om4z8U9cME7xZKBWbBNqzExUwUGrv4EJFku5laX/SkRb+NLvI2nxrVEJlTrDkJV1sa8Ltd6AI4eHa7wuB25p13uXm6buXgLsSuAjhwqrI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663683; c=relaxed/simple;
	bh=O1hwO5zehfjVUufr5fqUige0GsRGs2dObdEyqthoxLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fsjt46l2Ze5AVG9Ydk88JOodKfa9uay5B6ahbN8rrrgRkEswg+A82GLUJoaG//+7HiLo3mLh3x2KNgyzaci7Q40bDgWoNXlKUFk3xSv9WGWTJaaHtkOgrenW40PRxNFLdnKuv07fN7oy7UAY576iwhw0jYwy2wVLxyGXmEydH9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UWfJhFVY; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XocxoBxH20M/D2YyW4K18B/A5057bAuQI0tC3WrRaWgMpltWskNO9Xo0XoIR25L8VpPaR/e3aE+BgAmTXx/oay3xAnGtJuMWGvd2gLGt0wOEUQlD6t4HdroP88SIfpBtL2RTWmWz1FFPrmor2hKcRBj9mBVfXD0jefLAvcKF770E2QgGALrZ1riA0TsJkqr0IErUwIStXx1P+E6cJ6tgR3i6DYbugVGgjfwIy2F4uznyE1AUyOAypYaj1bi/PwgcLGnlZc/uaKdkjWBSR+cTpxuSAFKDBTkKBl/EfpV0uHxcqS4h7wkSNreQRqoSOY2lHqJSrQb5gXHXglA9W/DfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ume4wkMcsnm3/XPM4okArey5gDEwEzcSa0gD0l8dnA=;
 b=D6K79xcaPhN7ajwZMbxv1qasROF+d8DJeZCaBGsoUCSpEYPbq+h0Re07Y/dXPshPF0GZ10faN9oDJ8RcUTowVmVXTNKF2p+v0tJTWTaZyL4ZPZpFSBPO90s7UgL2uehmF+/AuBAMzAnv3yD2/18id8WbgRNWJfT0F/7urmZgT5NU4bFqsswFOYQR89/y4qGjDv3bnPbTq/yTDmwWcXlM4va3ylKah8pATuR5uBoTcrxOSM6r1d+VaVL30cS7SO3ZxyaeteEKci7wsWa8g7i3aJkSVn2JJxyWdxKFtlOGIc37FF9DKDmJnqKpMGmbxaZSlZeSU8yHHRBAXq4GC6i2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ume4wkMcsnm3/XPM4okArey5gDEwEzcSa0gD0l8dnA=;
 b=UWfJhFVYSCT0sWXIQ7CBsBgvzdJfWkoJw7YsC7G85NeZ3fvLvKbv4RT82ING+x50v5AoKRDXst7dqWN0PwsQwUE/LDDiEgW9IFBGUzkW0solxWV6v0cnfMJn/HuLt+JxWoIUsNUOHfNqM+Zb8EpmM7/iTev9Fvunc8tregE3Ubtp4nfQgNYQawaHEeivB9zO3MPUJxnmbFUa+xHqIJ5jSZ+hqVQuhq6ojUCY/GB4cjdU4x4ub7JaUOSaAH3F4VLUr0O1OyeF+c2vDL46uSR3l1+wr6IUc92vw16sb3tEOmLBaps+TrF1xK5cUDz8C3ylLePo1rdNsYRYQW47d9A2tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 00:21:13 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%3]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 00:21:13 +0000
Message-ID: <f10f54a9-e45f-47f0-8f5e-473daae82665@nvidia.com>
Date: Wed, 7 May 2025 17:21:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250505211524.1001511-1-tdave@nvidia.com>
 <a8d9e9ca-4944-40ae-acd8-d576447742d3@intel.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <a8d9e9ca-4944-40ae-acd8-d576447742d3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7db01a-3b56-4b74-7267-08dd8dc63d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkhSeXBjTU9yOVdvZm1USDZHR1RmVGlpdkNCeklWMmljSHl6ZHVCR2d1VXhU?=
 =?utf-8?B?S1lvWWdnbS9vR0t5UVNqRE5VSkQrOTJ4dTFHdmdPTCtoMjBMTWgxb3ZOOUxZ?=
 =?utf-8?B?b2xkQ0FycEhUSnpndSs2eTJxM0MyM0FLS0dFV2FEOXUzamlUYlNzdjFLZDUw?=
 =?utf-8?B?YzZwQjhTY3FkeXJGK1c0YmdEamlzVGlRKzh2aG40Tnc4engrQXNLNGZNMFpn?=
 =?utf-8?B?ZnplYUxxOXVhNDZDVEM2NnRrVTg1amhUbUJkQ2I0NHgzSDJYcEMzc0FTTUJ6?=
 =?utf-8?B?NzVrQXI2dkpVb01KNC9La2xXd1VTeTVYN1k0U1hFYVFMSUxnaDFIN3JTRlBm?=
 =?utf-8?B?TnpOeUgrSE5EY2ZsVVMwTTRlR0Q0MXc3aCtRdWVGS2hNYmREODVMWHpBRVVy?=
 =?utf-8?B?eDlHRWtrR2YwTXNDN1Vnekk5elJsay9IK1NYa0RycmRtcU5ZeW13Wlkvb0hO?=
 =?utf-8?B?QU9ZWVd2Y0xzUityV09VdmpkbERFajlMcityMExSSENDdE1zZVplVHJVMUtK?=
 =?utf-8?B?RENQd3p6MTVlWWlZdVRwTHh1TDMxK29jc29sZjlZM3hPVTQyQ0FQUWp4VFdk?=
 =?utf-8?B?Nm00UEZNNHFFYW95emFaWmNjSkVGUjJFNmJWbGNoeUozMzlTVkFJYVBNMTFW?=
 =?utf-8?B?ZkJ2a3RFSlhsdUZ3a1pvclJHUXByME5QY1FzS011VTRDbkduSVdtdTlsci9x?=
 =?utf-8?B?bWpGVUFqVWdJVFp3d3BUMGdXblJ1b1FldmQvdXlSaVo0SzlpRW5NRUNEMUFP?=
 =?utf-8?B?M3JOc09jalRRL2pEbS9jUFJJVzhpRjVRUGpXemlBZ1o5djVWSXRYa1ZaZVIy?=
 =?utf-8?B?RHVnV0NrN29vbFJNeDFrbzNRQlQyQVNla0lkcnlua1JWUFFqZGQrMW5yb094?=
 =?utf-8?B?ZFRsa1pHcUVibVI2VU5tMU1wdUhJanZORUVtYWl3a00wL3lJUk5tMnNob0tR?=
 =?utf-8?B?c1JJeWNnak1jWTJEZGpobXJhMVNEcTY5NXVGZER4MVJzRGtzU3BWbHRZc1FN?=
 =?utf-8?B?TlVpcTVPWC9VaXBURDdIVG5OdEh1WFFWUWpLQ1k3Z2RVbmtqd20xSXZIUFZL?=
 =?utf-8?B?ejNtanJoSmRLMXdyUW4zcDhIU09PaUpzeSt2eExnVFA5bC96N2lNU3NRdjQz?=
 =?utf-8?B?bktycmlJOVozSm9HOFQ3SEJ3cDU1T3RQenlVSmZUTGV5VWV6MFBSOW5CSVM5?=
 =?utf-8?B?VVREd2tBVHVmRzd5WDFWaEdjcXBEMHZZWmpEZWdPNWFjM3hONHNLNjliUWl1?=
 =?utf-8?B?M0UwNVExUnZTRDlVUG5SSWJpTW5lTUhrcXJ2Tm5XOHY4N2Q5ZXI4cFpxSnR0?=
 =?utf-8?B?ZjhCZ1ZFVHVsMDdjVlFXM1hZeklCYzhNY1EwYWRJc3QyQkRtNVJPR05QWUp0?=
 =?utf-8?B?bE5Qbm1JNEkwS0pXSU41cENSUUVKUFNlTmRWd1NBR0tuVU9UbzhIcnpOSnN6?=
 =?utf-8?B?MG5ydnpBTUJCQVZnaW9HWGk3R0tqWDRGUy82enR6eFNlWmIzV3duSEtTcmJS?=
 =?utf-8?B?TlJPbzNjdHBMQ3FjdForSGNxVUovSlBhMHhmMXgvb21Nb1dHQk9zQ1JpLzQr?=
 =?utf-8?B?QTJBWGxtM2ZxNzdseWJ2WFl0RUppaWlQaTZ3dm82eUtHS0NWSVJ2YUFSUXdN?=
 =?utf-8?B?Z1RFTWRPZDAzOXdYT3RObEVmdjZVSXZrNHEvSkgvMTcxenZ5Y0tRYTBnZU9R?=
 =?utf-8?B?aWhDaVB3UExJL1JzMWYxaUs4UktoREt4YTI5WTRUV2xpN0VOZjJ3Tk5OZm5m?=
 =?utf-8?B?Z3VKY3JMakUzQXM4WUhEZENUVlA2OXFoV0ZlZWlrVFdVaUZDTXhScEFOM2pi?=
 =?utf-8?B?MENWc29nL2NtS3B0NDJPcE84aFNSSUhreGlxVEZIMGxOa1hIQ2hzRjlma3Y1?=
 =?utf-8?B?R1JyVEdGZ3JldU1keDZ2OC9lLzNOT1F4d0tJS2pJaEdBN3lVWGhnNDN4dGUx?=
 =?utf-8?Q?WIH2EFLKrfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVI2OUFDU2ZxZDhWOVpUYThObmF4UzZwQ1E2bTVPb0toTEVXdWY4UFh1K3N1?=
 =?utf-8?B?bUpyU3I4YWFiQ1crTk5PTWRuVWI4R1FpVnUwaHltWFErdFVLb3JabXlML0R0?=
 =?utf-8?B?MmN5OGd6TWt1WmN3YUhOSW8zQWpheEd4VjQzK28wYWs0TExTMWVGRE54STQ3?=
 =?utf-8?B?SXBhMjVwQkUvaW9HeVNLR2hjdDJ0WGd0WEo4MHUvZWx6b3REZSt1ZnBTMTBm?=
 =?utf-8?B?cEtpdmJnL3AyZEJ5Sk42S3d6QU9mYmZ4aUFzS1dRM2hwM243a1hUZEZSNGdx?=
 =?utf-8?B?a1E4Qkkvb3FhRHNBdDJWVE1waGs1SzRmSnJpUVRlMU44WnlDeWgzaUxySFFv?=
 =?utf-8?B?RHpCNC9mL3l4WVU1amJHZHpBQmhuYlNHQnQzaGswYXd1NlJ2d2lTM1hIN042?=
 =?utf-8?B?R1F5SmlScFNocmJiT09MSElSb3FxOU95cHViZzZtbWYzYnNYVDNVbjREUUdB?=
 =?utf-8?B?YzJkZWViZ1pwZEM3T2FwSXJTNyt3S29MZlg1L3d3NXhFSHhNbW8xTDVtaU5y?=
 =?utf-8?B?V1M0UDh0T3VYdUNDSlBJZGtSYVArUmVmM1ZVYmJIbHdvK1ByaXU0U2E1eUJP?=
 =?utf-8?B?RGxPKzEvZ0x1VGcwc3JSVWNlajFYRjhjTENJUGdiOFRQU25kbFRHeXlBZGZJ?=
 =?utf-8?B?SVRERWxUNTREVTJnREFqUFZoSDNiM3NOOXpEMUkxcmVvQldZWkFKSkdXUFVX?=
 =?utf-8?B?b2tITnh5RFBuUFViZ2JVakcwZXM2eUl1cWVDMGtWM3Vvd2tGemdZcnl6emNK?=
 =?utf-8?B?Skdob2xSQ29QLzh3NWNkZGxCVGpmRkI5eHVRcmkvQVBCeGlYYVRHUTMxUmZn?=
 =?utf-8?B?WER6Q1dJeCsvM0djUEM2Y3Z3bkJNVVpCcmxlaXo3R0MrSUloTkhoVStmY2JK?=
 =?utf-8?B?ZnczV0xKNmNkQTY0NC9EUC9Qb2ljajVvcitCM3FTWjVJdmxBQWMvS1BaYlhl?=
 =?utf-8?B?QkJGUktkVTZhR0FHSWgyUGNVOGFHUXpySUM4Nm02b09EanlCM2drbXpRbFVp?=
 =?utf-8?B?YlZMSmtSNkFuai9GSGR6YndoMDkwT1V0ZmJYUyt6cW5Jdzl0TEtBUWloV3NN?=
 =?utf-8?B?YndSOGxIMjhleW1FMnZOZHZGNHl3SHZtL2UvU21JMXgwQU5QV1dqUTUwWDBX?=
 =?utf-8?B?R1pzc0I4ckJmbEUrcXgyQVJuL0QyRVU2b2Q5SkNzV0szcHNXSkV5NWRiMmhy?=
 =?utf-8?B?eWdSR1VpTUwwd3VGY2QwWWVMU2pkOThvdW13RGtZUGdIRXNlVHY4eC9aK2JQ?=
 =?utf-8?B?SFU4NUdyQ293T0NMYkNxN2ZSUFNMV0dHZDdDSk83RGJzWnlTOEVDc0tCM2c0?=
 =?utf-8?B?Q3d0ZEp3U2RpdUxVNDBDR3BhNU93T0dycHNib3l4MjlRMVNRUkNPQUdoc3lD?=
 =?utf-8?B?VC9YRVorY0ludkJXZERSeEcyVG8yaFk3eHVreDgxWDFKRHRlNkVYbkpNWWhU?=
 =?utf-8?B?dmdOampyVzRsK1doV0FOYW9SUjNndHlIc1FHMGhNVUl6V01aNDRIcUJ1SDhn?=
 =?utf-8?B?YmtnS0xtMm9NZXBIUk9oeHhBeHJxU0FLQ2JsOVZMeWxhS1YvQ2lQUW9KR3RB?=
 =?utf-8?B?WENYbVhkam9tQ1IrNkFsZ2U2TDNsL2Rka2N3dENSSDhRSGxDSVR1eFJSTEZw?=
 =?utf-8?B?ZU9PY1JubTJjbVhDVFkrNVpBQ2Fsd3JWbEJ4cmpwZGVaS2hSMDZzcUlQYUQ4?=
 =?utf-8?B?ZkxPWlIxSmpVWXFxbEtReTdQbHZ2THJzNUdlOG9Fam1hSHBrd01ETFJZb2Rq?=
 =?utf-8?B?M2Y2RjNuNmM0djJtbm84TVJDTnNhT0dDL1pBWGVrTnZPdWk4YUtiSVlhOHAx?=
 =?utf-8?B?N1VYSjMvVFFrYVo3bXBlOVI4WU9IVmFnRlBEZUFnWG84bFpHZE9ybm9zclFL?=
 =?utf-8?B?dXFFMzB3ZTdVZUZ5cCtoT0dNQVF1MEd6WFBsUDRZVVVMM0JKTVo3UHBiQmtB?=
 =?utf-8?B?T2JlbjZadTRaZkZQc0o2aGhKdHZZMFlFaExHNUlWcC90NTYzamRGbWIxV3d0?=
 =?utf-8?B?dlVFNi9FME8yOENsUEsyMHNERE9nclZWWDNjZlcwc3BHL3dwTTRoUTQ0a0Zi?=
 =?utf-8?B?UmhIMzErc2VSbTFMSXFlUS8xLzdVUlY2Z0Y4NWRyUDNpdFBveWM4OGZNVUtI?=
 =?utf-8?Q?SqZQWaReSv64AtB+d9cnUdmPk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7db01a-3b56-4b74-7267-08dd8dc63d3c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 00:21:12.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3VJ80UwCGtcBsIkRMg5xlVM3NIsubGJP0FxinfP1ivmrg3z7UqqLZgywOWaHKpyzBtNdzbTurDnHyTqTXdpLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891



On 5/7/25 06:59, Yi Liu wrote:
> 
> On 2025/5/6 05:15, Tushar Dave wrote:
>> Generally PASID support requires ACS settings that usually create
>> single device groups, but there are some niche cases where we can get
>> multi-device groups and still have working PASID support. The primary
>> issue is that PCI switches are not required to treat PASID tagged TLPs
>> specially so appropriate ACS settings are required to route all TLPs to
>> the host bridge if PASID is going to work properly.
>>
>> pci_enable_pasid() does check that each device that will use PASID has
>> the proper ACS settings to achieve this routing.
>>
>> However, no-PASID devices can be combined with PASID capable devices
>> within the same topology using non-uniform ACS settings. In this case
>> the no-PASID devices may not have strict route to host ACS flags and
>> end up being grouped with the PASID devices.
>>
>> This configuration fails to allow use of the PASID within the iommu
>> core code which wrongly checks if the no-PASID device supports PASID.
>>
>> Fix this by ignoring no-PASID devices during the PASID validation. They
>> will never issue a PASID TLP anyhow so they can be ignored.
>>
>> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>
>> changes in v3:
>> - addressed review comment from Vasant.
>>
>>   drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 60aed01e54f2..636fc68a8ec0 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3329,10 +3329,12 @@ static int __iommu_set_group_pasid(struct iommu_domain 
>> *domain,
>>       int ret;
>>       for_each_group_device(group, device) {
>> -        ret = domain->ops->set_dev_pasid(domain, device->dev,
>> -                         pasid, NULL);
>> -        if (ret)
>> -            goto err_revert;
>> +        if (device->dev->iommu->max_pasids > 0) {
>> +            ret = domain->ops->set_dev_pasid(domain, device->dev,
>> +                             pasid, NULL);
>> +            if (ret)
>> +                goto err_revert;
>> +        }
>>       }
>>       return 0;
>> @@ -3342,7 +3344,8 @@ static int __iommu_set_group_pasid(struct iommu_domain 
>> *domain,
>>       for_each_group_device(group, device) {
>>           if (device == last_gdev)
>>               break;
>> -        iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +        if (device->dev->iommu->max_pasids > 0)
>> +            iommu_remove_dev_pasid(device->dev, pasid, domain);
> 
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> 
> with a nit. would it save some loc by adding the max_pasids check in
> iommu_remove_dev_pasid()?

With current code:

  drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
  1 file changed, 19 insertions(+), 8 deletions(-)


If I move the pasid check in iommu_remove_dev_pasid(), it would be:

  drivers/iommu/iommu.c | 23 ++++++++++++++++-------
  1 file changed, 16 insertions(+), 7 deletions(-)


e.g.

@@ -3318,8 +3318,9 @@ static void iommu_remove_dev_pasid(struct device *dev, 
ioasid_t pasid,
         const struct iommu_ops *ops = dev_iommu_ops(dev);
         struct iommu_domain *blocked_domain = ops->blocked_domain;

-       WARN_ON(blocked_domain->ops->set_dev_pasid(blocked_domain,
-                                                  dev, pasid, domain));
+       if (dev->iommu->max_pasids > 0)
+               WARN_ON(blocked_domain->ops->set_dev_pasid(blocked_domain,
+                                                          dev, pasid, domain));
  }

  static int __iommu_set_group_pasid(struct iommu_domain *domain,
@@ -3329,10 +3330,12 @@ static int __iommu_set_group_pasid(struct iommu_domain 
*domain,
         int ret;

         for_each_group_device(group, device) {
-               ret = domain->ops->set_dev_pasid(domain, device->dev,
-                                                pasid, NULL);
-               if (ret)
-                       goto err_revert;
+               if (device->dev->iommu->max_pasids > 0) {
+                       ret = domain->ops->set_dev_pasid(domain, device->dev,
+                                                        pasid, NULL);
+                       if (ret)
+                               goto err_revert;
+               }
         }

         return 0;

Last hunk remain same as before for iommu_attach_device_pasid()


Let me know.

-Tushar


> 
> 
>>       }
>>       return ret;
>>   }
>> @@ -3353,8 +3356,10 @@ static void __iommu_remove_group_pasid(struct 
>> iommu_group *group,
>>   {
>>       struct group_device *device;
>> -    for_each_group_device(group, device)
>> -        iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +    for_each_group_device(group, device) {
>> +        if (device->dev->iommu->max_pasids > 0)
>> +            iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +    }
>>   }
>>   /*
>> @@ -3391,7 +3396,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>       mutex_lock(&group->mutex);
>>       for_each_group_device(group, device) {
>> -        if (pasid >= device->dev->iommu->max_pasids) {
>> +        /*
>> +         * Skip PASID validation for devices without PASID support
>> +         * (max_pasids = 0). These devices cannot issue transactions
>> +         * with PASID, so they don't affect group's PASID usage.
>> +         */
>> +        if ((device->dev->iommu->max_pasids > 0) &&
>> +            (pasid >= device->dev->iommu->max_pasids)) {
>>               ret = -EINVAL;
>>               goto out_unlock;
>>           }
> 

