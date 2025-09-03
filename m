Return-Path: <linux-pci+bounces-35346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC4B41220
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 04:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095581A8575C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 02:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5605145346;
	Wed,  3 Sep 2025 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WhovScUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65018E20
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756864991; cv=fail; b=c8WJqLJuw0P43rR0n8gbFPsnPDBroRWn3XSmPwYOVk6v+bGMrzV2TvlTVvl/Xmd28Z0TyyxstcT1s5EF7sVDcSn5Hb47hLpkyz1yZkprHt++krnETbzsFuzSBkUmWCs0qCYy8TYKH+sEpIXx+diKCZWvOOeX1KnttmugmKgn6js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756864991; c=relaxed/simple;
	bh=O9merqTOl3kXpEQSUibPXUlYsns/3v+/Si8Vy7f1xi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b3TdkA7ft7zZa+MrJvPAWs8GfBxtwU9H83J6lttfHO/Iafixk8g/+XBWwHlEzAiPcJfSC9/Cgk+ig97Db1EzQQ6h1YXxdZFW29/ro7OuXPEWs4S5qG76+WTCEWFBiol5/zWmEs1kBOncnvKBER+8dkSbjFCcgoKhLqgKKYf2mgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WhovScUH; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaPxv9siOgcYza6ni54kUwQZEXtYPDwqIZi7ae0kZfsrPvwjiT1xZ/KZ1qEfidnieqbSR4D0g9XmU35LCMSFF6WKIXUyxmMo4TzY9tKGFSBiuD2xh2gxJWfmDrQR97IYvNcUtsq6wQOf3choPWFxoJYLAW1EXMm8zEpzuFlzw25xZ2ofSoryqLf9TI99LF4n01jQzP+OKIBQfhEziWVEwTyxZvvQnSu2Zk4yx5H5pre9G9TpWQMcOPWG42GjNaQQ2MiranqZQb3if5aWmq/3ViIyAqLgKbLKA9chJR4MmFQ6Xo5gopoE5PSP/d0RjmlOYAuHC405ac1I0pW/NEtvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2P9G5xoAfRdYe+xjLxoWHOA7aIW5+b7dVusp85rdpU=;
 b=HUpKVV2loQSJapoHJ+/ieKEA4Lroj9GzfKVpZMPVNEG72G/rcwB+UruVlsfUHxlSw6/Anyh3Deh9XGb5YMKaP/Qh57yHcQZVEjCLQ09NLqsIWiAFde4VNS+TYiwa27o1o/lW7jzuHByiPKWcXQo/Zf8tfceKHN12LfWYwrCUvOWwzaTaAMgrhwTmPrv5Fd4fl9dTZ/AzqovlztYiTs1IMGzzSgbBymiQhS91b9X0JebmFUjhRtQ9kASR9v9vVkKZq4593Zr4JCDbmQ3kyDouID4RjliRdtm3tACvu4C3/mPWJzxOuRKpI8ETHGyeuBWXiGZftWCufIhcct5ZE0UF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2P9G5xoAfRdYe+xjLxoWHOA7aIW5+b7dVusp85rdpU=;
 b=WhovScUHVDA9cOY4r5KkCyQ/1m5tcDm3ZzhSQrEyc+fdJf5c6CIlr0me2YOZCXlEiA2QSpB4IA/lk/Alm/Ix+3hLnjwHyKha17S9cU6pmh3dZEp1NupSIRJUcGKjKrHBN5x/j9Q5tbqevl4YIMMGo1qXZeXaq8LuyBo7hJ80ows=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:03:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 02:03:07 +0000
Message-ID: <71d8abc2-82b1-491f-9075-d5259e83f9e3@amd.com>
Date: Wed, 3 Sep 2025 12:03:01 +1000
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
 <yq5a4itk3n9f.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5a4itk3n9f.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0031.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 78523589-b432-43e6-ad87-08ddea8e0637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blZ0VUgrMjU2MmJSZHhpbHEwK0dnQk5MV01IM2E3L09pbThGVWNNUDFHY2NC?=
 =?utf-8?B?b2oyckRUaG04bjBHWW0xdFJRT2FWSGZCQVd0RHRwT1ZjemJOZmpCV0ZoeEZh?=
 =?utf-8?B?S2V2UXZxZmtNSG5neG9pcStLa2QxNm9QZjFza01tTHcvOEE3QmxXRXBmZUYr?=
 =?utf-8?B?SGZOVUxoUVVyK0s4aElaMFBZWTZ0SHo1cVF2aklncUE5NCt5Vjc1aU8xSjhX?=
 =?utf-8?B?d1JmV2VDaklCdzVxMURmMlR2TERjKzkrcEl4MFBHVU5QOHBkblNyNm8vcGdW?=
 =?utf-8?B?b1NmMjlHTFMvVkloam9uWUlmaWlUNGNjY25MdVBRVFY1ZUsrM1RVME1mSEVm?=
 =?utf-8?B?WGRPM2VrajRxd1BIRTN5QjYzbWdJUnh4OVNxby80TUN2eFZvUjJNYkc5T1hj?=
 =?utf-8?B?K055M2phWEpZaGJsUXJ3NFVweWRZSkdUMEtSWG1xOVU0L0I0aC9MM1NDMkNQ?=
 =?utf-8?B?QmR6bHprQ2ZnbTRncVg3Ymp0UzRlVllzdDArOHozQXhnQUVGY213SzdJY05z?=
 =?utf-8?B?L2lBYWtJMmhnMlRJaC9KTDFoN21ndHNXRzltS3NoU1g3Vk93WXZOQ0lacDR3?=
 =?utf-8?B?bGJTT0F0MEhHK2c4MEZ5Tm84QnhUQTZXR1N0dEJSbjNuTTg4L1dhWkpCWlNU?=
 =?utf-8?B?RTkzQ3EwU1ZzWUh4eVl3UlREbVBuTVNOcHNzMlRicUkrQmFzSWdtNVlnL0ty?=
 =?utf-8?B?SHFQZ2F1OTBuWWlhaCtVWE0rUVhIbHpjT00vbHdkaTRPeG1FSG43UTVIZDRx?=
 =?utf-8?B?TWpsU3cxZm5YckY4WFd4dmsrb2pnRzgySmx1SS8yR1FjbFE4WU1pWVJPcFJq?=
 =?utf-8?B?NFZVeXJvbjlYZ2l4OEtvWGFseW84czlrOEwrN1dDVXZST1ExZGNET2FucHlG?=
 =?utf-8?B?VFFRdU5hTktvVHNLelJhamt2cVcxREYvUExBVXgyR0g5cXRMbnBQbDFwdVM3?=
 =?utf-8?B?S2lCc01ZSHZQYXhydDkwdUNvWmJhZG43R1c0VU9KQXlSc0lkbHBiTU9OaXdl?=
 =?utf-8?B?NWdGWnhZM3YyWWhLNE9GMTJLZ2tGS1RyVWNMRjE4ZDRFSlFkc3BPVmlTMWlF?=
 =?utf-8?B?NW93QldnanVXWEJnU3cxT29GckdWYVF2VkFLZVZHRTZITHAyelV6dlBXc0hX?=
 =?utf-8?B?VVBpQWFJVEYxb3lITWtaMFJYakVQd0tGMmlxYXR0Ym5EeEVRM1dtU3U4dFhT?=
 =?utf-8?B?VWpIVnBnUTFUUjBsUm9idjhOMUN4UW5oSGhYL3FIa2E3eFlXRDJzSFNKb0Y2?=
 =?utf-8?B?RUc5Mk9yb20wYmZ3WU0rL1VJT3hrR2VQWUc4ZWhlTkFpblZMcHZnd2Z1UHRY?=
 =?utf-8?B?UFFlUS81TlA4UnFDMUFXZWZXRUxxekdnVHJMTmluczBnM1FSTlJPYXljK3FV?=
 =?utf-8?B?MnptdUxCK3VONzFLcUV2aHg1UzYyV2JlVnQ1OTZ6ZFlLWmNzcjJoSEgyNml6?=
 =?utf-8?B?OVBqQ2NGdTFab3N2bWhXdlVza2kwcjBNa1YrYk5ydWIxbk5jQXozdzRFNDcz?=
 =?utf-8?B?M3pIcHl1enFYL0hwWGl1bXEyOGloTTg4eklHOWs1dUFCZmF3ZHU4aGEzS1hD?=
 =?utf-8?B?ZEk0aUllclFRUG54dUVLdmk1eWNIQXJnR0RXTzFOWURtR2YzR2NEVmpwemp5?=
 =?utf-8?B?UHFtUG5WelhZbnZQMkY4MWl4NzdCMFJDNnNPS3lCcTNyYnNJLzdNUlFaSWFz?=
 =?utf-8?B?TVpORDZNQkloL1NudDZlSkwxMkJZd21JdFo1emtEeW9rTVNqcjdORWxNTUhL?=
 =?utf-8?B?bW9XOS9ZQ29DcnkwbitmSDA2c0xPenVwNEliTTFFTjd6cU90RUJycDRWT2dx?=
 =?utf-8?B?S2p3TTdSOXJUUkpVZEt5cXE5TlNaK2NvUjNQZGlOMGNleXRaU0RQOUlrL0hJ?=
 =?utf-8?B?b2xYOXNOeGRLV08xcHRTcFNkRHE5REVIcE9XZWVJbU5SUEI2bjU5Y1ZnMWor?=
 =?utf-8?Q?MClsvV3JlCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0ZsSUhGUnY1ZEJLK0FacktWR2NqK3VzZmtGandycDUxQ28rNTI2V25uLy92?=
 =?utf-8?B?QUUxd0lISlF3MjE4Rno0aXV5dUVHUE1PbUd2NURGVkFkWnNZM0krblhoTndl?=
 =?utf-8?B?MTNzb0JOVW00YjlBWEZKSisxTXlWczNXQ3Z6RWdScHJZZTJTZTZvZ3ZoSThL?=
 =?utf-8?B?eGI5Sm1nNWhyRlN4a2VtSjBITXdteFgxQldjd3RONldxSGdGQ1lqM0NtTFoz?=
 =?utf-8?B?T2FPRmVpazI1STMvb29JdzdmaGJMdTY1R1JiRUg5QnJuL3ZwQkRMUC90WU5o?=
 =?utf-8?B?Lzc5VjB5VGZ3bEsvY0FkZ1ZPcmxVc1N3TVJCOXF3T0t0TGhzcGlSOGV1OTJp?=
 =?utf-8?B?WmZnNmFrSmZORXZEVkZENUphb01XcjgrU3o2eDNpMkxxZ2dIQlRxQUhpbmdG?=
 =?utf-8?B?aXUvN1RCSnduQ1hnZndFMThEKzlYblliT1l5UTBjaUFuNEMxRzZPMWd0dlE4?=
 =?utf-8?B?cWNKYU1YOTVqdWs2S0J4c3RBNFJTSFhsZWRlaDJRRHp1bklMY3Y0VDYxby9l?=
 =?utf-8?B?N3NxbHdrL0EwZldiNVYwSFY1SVdqenZ2eGtDY3RZWVdmVFNuTkNkbWlhS2Vw?=
 =?utf-8?B?bCtFN2hvNUluV29BdCt0N1NMcWdpc2RFRTFrWkJwdlhKa01icTNNTnNSNDgv?=
 =?utf-8?B?c1hOMk5UQ2NmNjU5b0tzT1A1SG94dDNMbXhkWkc2MFUvSGhaTW5OV1BkQndS?=
 =?utf-8?B?T3lheGFPSUFpaWdRNTZqWHZNQkROWDh3QjBHVTZUVUE4T3RkcnpKakEvU2ow?=
 =?utf-8?B?K1c1ZFhhZ3ZQdENua2x4d2tTdmhKaFBkNDN4UFdpM0JpSWUzUE9sWHR6eVhv?=
 =?utf-8?B?by9OeExhUVBSSXZRaW5UUU5LaFgvTFlLMFd6cGJhMFBDOHd1OTFPTHhQVCta?=
 =?utf-8?B?TWtoa1p2WHE3Vm5Fd0YvQTZZdlZDQkQrTUxUL3VDQ1Q4L1ozcVNBTWxlREJ1?=
 =?utf-8?B?YmZ2ZzY4Nm0yRjZmdlBrRHJuMERmWlJLMmxzRjVpYUx3YXdLVkZjVUc1Mis0?=
 =?utf-8?B?YTRFaU1vRXliTi9acEdGR05rUnNyYTd2TXF1NFpmL3ZybE90a2NCM1NwNzRY?=
 =?utf-8?B?V2VHSVJZNUs5SlhjSG9qa3ovbGpWRmQwL2V4Y3JoUk1XcWxQbnNJNkZ5eFF4?=
 =?utf-8?B?djBSRHNUTitYa1NZbFR4NEU3TnJ6YVRRVXY3VFJhSFFvM29oRnhDYnpXNWpr?=
 =?utf-8?B?dDArdzVmamo5N2NYdGVHTGFnL01WYWZoSkI0TmJpZExtM0tBdTQycUxqYVRC?=
 =?utf-8?B?ZHVaUjJCT2FpaUZMUXU3UDJlS2R6MDVZVDlEQ0VDazBYdXVaMkdkZ1g2OHlz?=
 =?utf-8?B?blZuNGZ5bFlWRmViaGE0SGtyWFhndG9hSW10c2lLL29VYy83WWh2VGdTUHlq?=
 =?utf-8?B?anY5bjdDV2s1R2tzc2xIN2VURXp1NU9QZVVib2UrSk1IZnlDdGFBdld5MGJO?=
 =?utf-8?B?WnZmL1kwSjFoaTV0ZWg0M3ozUDZaeHhNbDU1RFg0ekllaDczcnFWUkF6SDd6?=
 =?utf-8?B?WTh0TFpZWVo0MllNcE1mZzBjaVZ3SUxabVpzUHZFV1ZtdGlWQ2tFd1lnZUdx?=
 =?utf-8?B?WUlCZU8zVkVyNEF3MXRZemFQeDlDdkkvVnk1TldFZSt6N2tmVFhSS2FsUENU?=
 =?utf-8?B?UElyVVZLRFFlb1o0VklwY3g0UlFRbjJxMVhNS05jclBpTFFqYk1LczcyM0Za?=
 =?utf-8?B?NnYxbCtHLy83WmZQS3FNVW5QbUFYMUpGZTd2MFQwOStvcXV3cUFZeS90SWsx?=
 =?utf-8?B?am1nVFU3RnNpT0ZGM29RVmhtZkxMZ05yQ0cyamxIbTU5SWZ4WFFxSnBQMFNQ?=
 =?utf-8?B?d2lVNlJOYTkraHh1ZHN5M21rZFNxaS9QQ3JDZHV0aSsveFdqSktYRTF4cnJB?=
 =?utf-8?B?eE9pOUV2L3NEOFJFL1V5di9FWk5RVi82OVcvRzl0UFZDaFVxWUZuMWpPeUlW?=
 =?utf-8?B?K3Z2ZTVMbnhLb09MWExYcjN2U1JGZFVsQUpRY0tlVUZ3S2x3UndEU1IrSitJ?=
 =?utf-8?B?OU5xdGNpcnY3eHFkU1AyTDdCaTdXMXJBSWNkWDhiY01NT1NUWEoxSVRyT0Rw?=
 =?utf-8?B?WHlYMmdLUGJZU0pqcU05YzFmTlZkZWhXcE5wMU1idUMyeUFONHMrWG5UODRr?=
 =?utf-8?Q?513FahQPBput0hbr+fWduSsqf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78523589-b432-43e6-ad87-08ddea8e0637
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:03:07.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CltEvMPFd5G+Onnnxm9RoNME7SJ7Fg/xWv+7FPCLgPY4YuqfwKQalrrMYzx1VuKLuueI8h4vm7b6yYmoZnydEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711



On 3/9/25 01:08, Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
>> The PCIe 7.0 specification, section 11, defines the Trusted Execution
>> Environment (TEE) Device Interface Security Protocol (TDISP).  This
>> protocol definition builds upon Component Measurement and Authentication
>> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
>> assigning devices (PCI physical or virtual function) to a confidential VM
>> such that the assigned device is enabled to access guest private memory
>> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
>> CCA.
>>
>> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
>> of an agent that mediates between a "DSM" (Device Security Manager) and
>> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
>> to setup link security and assign devices. A confidential VM uses TSM
>> ABIs to transition an assigned device into the TDISP "RUN" state and
>> validate its configuration. From a Linux perspective the TSM abstracts
>> many of the details of TDISP, IDE, and CMA. Some of those details leak
>> through at times, but for the most part TDISP is an internal
>> implementation detail of the TSM.
>>
>> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
>> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
>> Userspace can watch for the arrival of a "TSM" device,
>> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
>> initialized TSM services.
>>
>> The operations that can be executed against a PCI device are split into
>> two mutually exclusive operation sets, "Link" and "Security" (struct
>> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
>> security properties and communication with the device's Device Security
>> Manager firmware. These are the host side operations in TDISP. The
>> "Security" operations coordinate the security state of the assigned
>> virtual device (TDI). These are the guest side operations in TDISP. Only
>> link management operations are defined at this stage and placeholders
>> provided for the security operations.
>>
>> The locking allows for multiple devices to be executing commands
>> simultaneously, one outstanding command per-device and an rwsem
>> synchronizes the implementation relative to TSM
>> registration/unregistration events.
>>
>> Thanks to Wu Hao for his work on an early draft of this support.
>>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Cc: Samuel Ortiz <sameo@rivosinc.com>
>> Cc: Alexey Kardashevskiy <aik@amd.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> you dropped pci_tsm_doe_transfer from an earlier version of this patch
> in this series. Any reason for that?

yeah, me, it was rather useless wrapper.

https://lore.kernel.org/r/68ae4a0c45650_75db10016@dwillia2-mobl4.notmuch

thanks,


> 
> -aneesh

-- 
Alexey


