Return-Path: <linux-pci+bounces-21105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D7A2F60A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651E61884633
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365EB25B66C;
	Mon, 10 Feb 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GFMW6vfU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324B25B67D;
	Mon, 10 Feb 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210200; cv=fail; b=Pv86L42xjRPOKw4p+38FiZdci1J9m/7fouTimywAShikD5um09lGO6yBQtgJkJbJmSAfy60ZDetwe+V4kH+sPl9AoJCu2XyaRVzy8BkuhMQQLUkTCqyWIVl5HCYbN00kmS/9c1d7heXGttR6jFDhckDSI0RGCKWyFPbnHAmyR+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210200; c=relaxed/simple;
	bh=lhht+s7N+S78Qv37RLzrtxPNIQxFVNCCvoVaQ0of6lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sk3Ux5pC7/A4kSynIoktdeKg+nHUEe5uxi24mUthqvIxdidOjUluj5YJtin/l5Ibvx1kM28c3dwgpkQ5ShW3iLGn/Crkw6QAttupP6TiYtJTphC2mjQ/ui/FMqvmURcRFpey/oB7bTdQuuBGpfsf4b0xFUZDKndLKuyhiXGd/w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GFMW6vfU; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw347g3lokc2YnvFQtv3GXjU1aIpcQ8IxOnPLkw4XukjpTpTmpN0H+F3JdXr/IQ6XZPFw05Yl2li9r+9XulP2CeTsSI762LP2a19qI85KV9XyXpBgDf63PDz/bCyKENknZbsTGBF7ujlIzqectmLnpnOvUCjyLp5LDHWLzrfaR2GVLyjNGulvIh8YX3QBAk85SOn7UoNkTsJP7vkTZzWFzLhMoWME3S+WkNnHwVH+e6jpjieJ4gWS1vtQ6vSFzfH870qYSaXetct++gMypCktyb8LRF0RCWSl1MWcFV0zbO4BilwY6h80j1a6606y5yeZXuhg7/vJINPxBAm0qiU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhht+s7N+S78Qv37RLzrtxPNIQxFVNCCvoVaQ0of6lU=;
 b=tQSLsZIWlyxprYmAOIM3isIezg80SF9RqFQCBJ1fMaBgugdazAabbqKq62dbx/YKU59BNk7XX6DjuZkBXvhtqNNB1+/2ApCAh/vQi9BmCFg7DVzNKWJcf/MRsUGmtP4Wo4TCQUfbZQA5NjNM7TI101zHzuSKfPkPjGJLHOcwalJT6EdurI7rCgizIg5FeD47OGszTvZMjojc0wOxljgkBZUVQFu6jZ7LXPv3+FsvrXZZnKLuWngPfTpg+YNyyVo6Xgln6BThMJ5cp/GKi4PAQUvoHzBbHcGpKTINJGew8dHrndzN3V9cIooJukCLykUM+XXyEXBm+K4+PIRYyE4hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhht+s7N+S78Qv37RLzrtxPNIQxFVNCCvoVaQ0of6lU=;
 b=GFMW6vfUVpygrgifChZnFPC4BtN6XS6jzRUkLBljm0sJvs5Pd8MTBhqP+Beysh9Af1feN/4ZPjUQBV6ugxQPglp1/ucYws7f/KPJprvrFMfRMNGux/5IHwZUiNPsezpCZuv09oZB92EJKPUhMuVobA55CMUVHzcdzn+qwHQeE/CxFGvOLczKW6feDxtfAZEw6K2z7ZP8DJFC2fRvwJFYnu+Il2+8N28eeF1hPV3/AN0NFzmZ2COJQkEu4fp0a1knWklIPpj7uvM9fDL+Nm+flNpKBWCisJHyYb9mdU1+b7epHcniHg31LSN73FLd7FC+H3D9dywd3TxPvFrqLmkjIg==
Received: from BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 17:56:35 +0000
Received: from BN9PR12MB5323.namprd12.prod.outlook.com
 ([fe80::efb1:9741:c066:f01c]) by BN9PR12MB5323.namprd12.prod.outlook.com
 ([fe80::efb1:9741:c066:f01c%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 17:56:35 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: Niklas Cassel <cassel@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"quic_schintav@quicinc.com" <quic_schintav@quicinc.com>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Krishna Thota
	<kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: RE: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Thread-Topic: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Thread-Index: AQHbcT8nBepV4G+xqEWbd1qc6N38crMsFxYAgBSVZnOAADmqAIAAALNg
Date: Mon, 10 Feb 2025 17:56:35 +0000
Message-ID:
 <BN9PR12MB53239715E7131254B07CCAE9B8F22@BN9PR12MB5323.namprd12.prod.outlook.com>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <Z5jH0G3V7fPXk0BG@ryzen>
 <BN9PR12MB5323E59E530FA1F87DE3C7FCB8F22@BN9PR12MB5323.namprd12.prod.outlook.com>
 <20250210175050.5htfgtgkyrfcjtre@thinkpad>
In-Reply-To: <20250210175050.5htfgtgkyrfcjtre@thinkpad>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5323:EE_|SJ2PR12MB9138:EE_
x-ms-office365-filtering-correlation-id: 2d80513e-6352-4caa-de07-08dd49fc426d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?cktjZ2pUSFFxaUpyWEdkUndjeGdQclV0SU9NanlvaHMvYWFWLzJOMHNQWTlS?=
 =?utf-8?B?dGo2MjVGM1VoVUFwN3dreHZsUm81YXNiWW9xR1ErM3NibTE2WlpXa0lwaDBx?=
 =?utf-8?B?enkwSVo4elUvQzAwZmR6bVlRU09FZ1BXY0o1ZFFBVGFNU0YzenNLSUZSRm1q?=
 =?utf-8?B?VzV5UWNhWCtRVzR1ZVlrZzVwTE10bGhiTkVqSExZT2xYQUZiYzVHc2FRekE0?=
 =?utf-8?B?T1NCMlA0OXBOTGZHWnhvSmExZ3JXSVc4cjlHOXh5ZktHbmo0ajgxWjFuZFFs?=
 =?utf-8?B?bkZaSXYra0Y3RFhSNE93MlgrRVdhS2NzdzJ2cE9IMk5RNTlaOVVPTDFHMXhw?=
 =?utf-8?B?cy8wVXd4UElwR2d3MXdyWWtycXNqT2FsZWgzRkw3UndTVDh3dXI1UjRQcEhr?=
 =?utf-8?B?OFRMRjBmVTB0ZXVFMU5QWmZQU2lpU0dSaTk2TDM5NDdEODd2ZnpSaHNSdTBJ?=
 =?utf-8?B?S0V6b0dpc0dwMERxbGFNUkxKdUQ5RXpUOE15WEFCN0ZaWmdOYklGVGZwSUgw?=
 =?utf-8?B?N05tZ21NMTE3dkNQblhuZkUrY1p3TndLd1NJaStocDNNT2ZnbUcrcWFpamdR?=
 =?utf-8?B?dkl2ckZqYlluQzRtY2dKcHZKRllsdElmNnJmZEdNNHBXYWhQVGZIbVJnSjN3?=
 =?utf-8?B?QTBjVFc2NjUydUlKZzRVRnpFVTYxWTQzLzdnc3phRWhTTE1KTUNkQlhPNHdp?=
 =?utf-8?B?VlcyWmRzTWo3Y0tZWWduNjJoc256dVd3NmI4c2NkTW9scnluL2Rleldoemw5?=
 =?utf-8?B?Q2dvTFpFVE5GNjNTY3VleCtJTVl0T3JMa3VUU3p2VWE0ZWxtL0xsQzlFMVA1?=
 =?utf-8?B?bnVUbnBsS0p0cldyaXBFMFlaM1VQQk9Ha2N6K3IxODZNWFpacmNmbUZ3TTVv?=
 =?utf-8?B?RWY4UGt2Qk5FVTZxUHJyc2hMTVh0dnYvSFFieVJPWWszMlZWWTZsSEJEdFJw?=
 =?utf-8?B?SWprTG5HbmRtd1gzRWhDZnVld3ZvQkRWc20wMXFVZFhqbm53QkloQ2grbWQz?=
 =?utf-8?B?a1IyTHVGZ3YrNTFibjdKYThja21sTE5VYjFIY294dTBsY3dCMXhIQkllWlFW?=
 =?utf-8?B?QjRzRjNNcjBrbk1MZURDUXVjMURLNWJrbXdmVDVoL0VuTWo3cC9GN1ZHUktn?=
 =?utf-8?B?QnZubUNkWWpMNDRXNXdsQS9HTWVXZExEcTFONmQ0ZE9vY2xDVWNoRTJwcjZ1?=
 =?utf-8?B?VWo5NEx5Q0ZlQkpUQjgyYTlYTllHemZHTSs3ZXJmZnRYeUc1QnVhUVZBU3F5?=
 =?utf-8?B?WXlpbk04S1dMNFFuWUVlVlFOWjVrcmR3OGROeHM0Q055YTRPN0F4a1IxOUFW?=
 =?utf-8?B?cVJGSHRseVZJNUE3R2o0WG40SnRabGE3SkpkSDcyWmF6OHFnZUxBdk9xSXdn?=
 =?utf-8?B?aHdzL21KSGRObkRTSzRvQlE4QzRmWU1ReVo2V293bTRHUmttWnhMN0ZDRHF0?=
 =?utf-8?B?YUpJMXdpTlR2eTBHcVE2dE9SdWlibDhXZ3pJUWpicEsxVlA3VEwxTmEyQUph?=
 =?utf-8?B?YkJJN3VpbGRDajhVVWl1NVo4UEp0aW9VdWwwL05UNUI4emVnSG15dmhzNnhw?=
 =?utf-8?B?dkwvUTlrcUQrSFoweHJYVHB6WGRLZ3IrT3g4bGdiSlhxWFliR25ONk91QlJh?=
 =?utf-8?B?UXZBNDZ5WG45MEttK3grTm8wTWJ4b092Mmwrb3ZnUi9LZnBoejU5ZzBwWDNO?=
 =?utf-8?B?aWpVM3ZQNFl5YUl2eUsxR2tPWFJVVzNYUm9XSkZ3NExZUXY2dnYzc1M1S3hy?=
 =?utf-8?B?K29NR0pnM3JKMENMUHQ1Q1ZmRUdUNmlLN3pidVZKS0VoS1N4ZEdTZlI3UFlk?=
 =?utf-8?B?VXNKa1ZWSDJnZ1RIb0pVLzdsdmVURW5EeWIrTXNUeTJzWnhJdWt5aHJkcXkr?=
 =?utf-8?B?aDhQNUZRa3V3VlNuWDNOSXlCWHBONENncWo3K09IWUJERWxPRkRjUGFGRWhz?=
 =?utf-8?Q?hCrCTpCCClinlpaX9sJWI12R4/0Jxb5O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5323.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDJ2eStNRG14VEpCRDJQcXAzMTBIalNLMGc0YzhiTC9wTWlOT1p3Yk95bk80?=
 =?utf-8?B?NWhXbGFVbUd3UDV3RFRtMzNXYitRUkFNWXVoVzhJVjk2cUVkUGk2UlVUTE5t?=
 =?utf-8?B?VFdHb0pMY0FnRGN3ZlQyQ3pTdEdGUWNiQmlaWjNhMWExbW11UzlIVTNxendO?=
 =?utf-8?B?ZkpRVjVHNUVObE1TZVcyQkNSQnJ3ZXBCWkJDN3N1SkFPVXFMY2Ird2NDM3Yv?=
 =?utf-8?B?SURibldXdndUTHRHbDdmRW9pQ0hHMjJ1RFd4ZUV3aGNCWlpINGhNU1k1QTRM?=
 =?utf-8?B?U2JOL1RkeFFrRlJ0TU1xMUlhcXc3d2x5NFFXTmsyVm9KeEtBMXIvd0IzTHJG?=
 =?utf-8?B?a2tweWFGaEdiN001UlpBMUJEQVJ4c0tiRldieUpuV2pTMnJQcTNsYzFBbGhS?=
 =?utf-8?B?RnY4Ym5NenRnWGxoQXBKRjkvNEh0UldHQ3loODRET3J5dWQvMW0xQjZUN04w?=
 =?utf-8?B?T2JVdTNtWWhUelNBY0VERGIxU0JpOXFSY09jMklmdkFBcGRsZUpXZU1ienhx?=
 =?utf-8?B?bEVTeDZtbzdOc1RHV2puUTRzaFBMbzVPREY2RjJJUnFDSXAvVFh3UGd0Z3kr?=
 =?utf-8?B?bzdHakpqNFVlbytHZ0FRYzNNUm5pN0c3Q0szWG9vRzBUVjg4ZFZvVmFZL1Jk?=
 =?utf-8?B?SjhoUVJ6QlZJbjVhTW5UUUZxNllPYnpkZ2JJWTVRRGJzZFBaVjRsSk5aM3Nj?=
 =?utf-8?B?VTNqa3lBT0xoSkdpK2FjSXdlVEtuSXhTd25zbCtjTHIxNzRsZzUxNElnbTdQ?=
 =?utf-8?B?OW1GWEFadCtSeTZQQUhXYnp4RW9LTGJkNGpiZktJaDBnV3dobHVabmp1aXh5?=
 =?utf-8?B?Ylg4Snd0UlJqKy9saFQycUVLWGY0MUxaSSsvMmhoQTVJem1yR0lUNnR1SUJv?=
 =?utf-8?B?ODNVdzlsUVZabmprS29odHVEaUdyY2ZSbkZYUEdGN2Exb255VWM3dmExaGQ0?=
 =?utf-8?B?d3pyWWR5R3JXMHA3NkNRRTRRMHE5dnV2eVMyRHBCZE5lZlliTG9HVHFibFBi?=
 =?utf-8?B?dis5ajdJbXhKZHVSWmxOOHpuaXo4Skp1a2lHbWJrTjhqZ1dnZ2J3Q0dYUzdt?=
 =?utf-8?B?RDRxbVBBNmsxb0M1ZEJuM2NyRlY5UU5DU2l0WHdOMDk1eit3cXl0VWdGWGpY?=
 =?utf-8?B?RDVWVWZDeWNyYkN5WXpFcnZGUUdvcVlHblBoWnlmeGgvOE45V1RrYXByeWU5?=
 =?utf-8?B?YVZpTHJTNmtkSUhObzlmc2s0MC9JRVIrUUVSdHdUcXl1clBTb3FnS3FrdjlG?=
 =?utf-8?B?RzFVS1RqUXJIL1VBTm1BbGx0RDV1a1JJOURWcnp2Sk02NzZaZmFhQ2ZFYXNn?=
 =?utf-8?B?ZC8xZm9lMHJSWkZHMTVubjlJalFwUDZQc0JlaGkwQjNPL3dJOHQvdEtRL3d3?=
 =?utf-8?B?NkllNEI1ZDMwdkU3UUwvMmNObkdHbUpZaU1qS09BTU9ZdDhkYWlyQXNOa2VV?=
 =?utf-8?B?VU9mUHozdHFzaG1OS0k5K3didWR6ZzRQU3BDcEJ4Y0VKblgyYU81N3RCTS9i?=
 =?utf-8?B?bXFpdGFKRnVtTWQ5ckVMREs4bkI5cjdFVTAyd3FESFRTVHBIUGdvN2ZiODZy?=
 =?utf-8?B?Sm84ZnIzNkVxMXZWRXFJRmFuWVVhZzFmK29mdTNZSjN1RjlJY0ZFOFk2K2pa?=
 =?utf-8?B?ZURXcUpSQ0o3U2NiWkJodzFrNGRCZ0NzZkUvbDM5M2d2eGpuVVBhMmF5cXVW?=
 =?utf-8?B?NkkvVEhQRi9LNWl6WEpGeFFkNVRYeWZINDhtUkZPMUprRkFyTytpQ1FQSUd4?=
 =?utf-8?B?Y1BBYVQ0TWNYZDlvZUg4WUJEMXhFbzI1RXdXb09zdHR5SWl4dlIrY3NoaUVu?=
 =?utf-8?B?TDA2ejQ5elM0U29rZlJOdVNvbWxNQjV0RW9lREExWFg3UEh1cVpWRmpQUUJJ?=
 =?utf-8?B?eVdmck0ySGszak9rNU5jWTRndk1YM04rbkEvZGZDcXdHbmd0OEp1U2RDUmp5?=
 =?utf-8?B?dDBDZksrUFVzRG9yY3BTUmpLVWFvRXJmVmRLbFdmVkM0aGpkcFJadGNIdHd6?=
 =?utf-8?B?MFp0WW1NajFySXdMVkhLTW5EQlhhK0xvU29tdDdCUlRscmFVVXdBWXNRbFBz?=
 =?utf-8?B?UlJRR20zaThjNzJuL1hzbnozUDAwbzJDR0wxMENmNm81TmtmQmJiL0wzNSti?=
 =?utf-8?Q?Zqu4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d80513e-6352-4caa-de07-08dd49fc426d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 17:56:35.0962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVI/ZnXwlU2Vbqbbni8k7eLgU+CoX8VXrCOteFEwx8PS3La+v+aeG9yhCT2egbqcMhSE5xzvtmkTTiw2yRhCmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbWFuaXZhbm5hbi5zYWRo
YXNpdmFtQGxpbmFyby5vcmcgPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBT
ZW50OiAxMCBGZWJydWFyeSAyMDI1IDIzOjIxDQo+IFRvOiBWaWR5YSBTYWdhciA8dmlkeWFzQG52
aWRpYS5jb20+DQo+IENjOiBOaWtsYXMgQ2Fzc2VsIDxjYXNzZWxAa2VybmVsLm9yZz47IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPiByb2JoQGtlcm5lbC5vcmc7IGJoZWxn
YWFzQGdvb2dsZS5jb207IHF1aWNfc2NoaW50YXZAcXVpY2luYy5jb207DQo+IGpvaGFuK2xpbmFy
b0BrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9u
IEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBLcmlzaG5hDQo+IFRob3RhIDxrdGhvdGFA
bnZpZGlhLmNvbT47IE1hbmlrYW50YSBNYWRkaXJlZGR5IDxtbWFkZGlyZWRkeUBudmlkaWEuY29t
PjsNCj4gc2FnYXIudHZAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjFdIFBDSTog
dGVncmExOTQ6IEFkZCBzdXBwb3J0IGZvciBQQ0llIFJDICYgRVAgaW4gVGVncmEyMzQNCj4gUGxh
dGZvcm1zDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIE1vbiwgRmViIDEwLCAyMDI1IGF0IDAyOjI1OjQz
UE0gKzAwMDAsIFZpZHlhIFNhZ2FyIHdyb3RlOg0KPiA+IFRoYW5rcyBOaWtsYXMgZm9yIHRoZSBy
ZXZpZXcuDQo+ID4gSSdsbCByZXdyaXRlIHRoZSBjb21taXQgbWVzc2FnZSBhZGQgdGhlIGZvbGxv
d2luZyBsaW5lDQo+ID4gRml4ZXM6IGE1NGUxOTA3MzcxOCAoIlBDSTogdGVncmExOTQ6IEFkZCBU
ZWdyYTIzNCBQQ0llIHN1cHBvcnQiKQ0KPiA+DQo+IA0KPiBObywgcGxlYXNlLiBUcnkgdG8gdXNl
IHRoZSBnZW5lcmljIEFSQ0ggc3ltYm9sIGRlcGVuZGVuY3kgYXMgc3VnZ2VzdGVkLg0KV2Ugd2Fu
dGVkIHRvIGhhdmUgbW9yZSBncmFudWxhcml0eSBpbiB0ZXJtcyBvZiBlbmFibGluZyB0aGUgZHJp
dmVyDQpmb3Igb25seSB0aG9zZSBTb0NzIHdoZXJlIHRoZSByZXNwZWN0aXZlIGhhcmR3YXJlIGlz
IGF2YWlsYWJsZS4NCkJ1dCwgaWYgdGhlIGNvbW11bml0eSBoYXMgc3Ryb25nIHByZWZlcmVuY2Ug
dG93YXJkcyBlbmFibGluZw0KdGhlIGRyaXZlcnMgYXQgYSBoaWdoZXIgbGV2ZWwsIEknbGwgbW9k
aWZ5IGFuZCBzZW5kIG5leHQgdmVyc2lvbg0Kb2YgdGhlIHBhdGNoIGFjY29yZGluZ2x5Lg0KDQot
IFZpZHlhIFNhZ2FyDQoNCj4gDQo+IC0gTWFuaQ0KPiANCj4gPiBUaGFua3MNCj4gPiBWaWR5YSBT
YWdhcg0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBGcm9t
OiBOaWtsYXMgQ2Fzc2VsIDxjYXNzZWxAa2VybmVsLm9yZz4NCj4gPiBTZW50OiBUdWVzZGF5LCBK
YW51YXJ5IDI4LCAyMDI1IDE3OjM0DQo+ID4gVG86IFZpZHlhIFNhZ2FyIDx2aWR5YXNAbnZpZGlh
LmNvbT4NCj4gPiBDYzogbHBpZXJhbGlzaUBrZXJuZWwub3JnIDxscGllcmFsaXNpQGtlcm5lbC5v
cmc+OyBrd0BsaW51eC5jb20NCj4gPiA8a3dAbGludXguY29tPjsgbWFuaXZhbm5hbi5zYWRoYXNp
dmFtQGxpbmFyby5vcmcNCj4gPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+OyBy
b2JoQGtlcm5lbC5vcmcgPHJvYmhAa2VybmVsLm9yZz47DQo+ID4gYmhlbGdhYXNAZ29vZ2xlLmNv
bSA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IHF1aWNfc2NoaW50YXZAcXVpY2luYy5jb20NCj4gPiA8
cXVpY19zY2hpbnRhdkBxdWljaW5jLmNvbT47IGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnDQo+ID4g
PGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiA+
IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiA+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgVGhpZXJyeSBSZWRpbmcgPHRy
ZWRpbmdAbnZpZGlhLmNvbT47DQo+ID4gSm9uIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+
OyBLcmlzaG5hIFRob3RhIDxrdGhvdGFAbnZpZGlhLmNvbT47DQo+ID4gTWFuaWthbnRhIE1hZGRp
cmVkZHkgPG1tYWRkaXJlZGR5QG52aWRpYS5jb20+OyBzYWdhci50dkBnbWFpbC5jb20NCj4gPiA8
c2FnYXIudHZAZ21haWwuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjFdIFBDSTogdGVn
cmExOTQ6IEFkZCBzdXBwb3J0IGZvciBQQ0llIFJDICYgRVAgaW4NCj4gPiBUZWdyYTIzNCBQbGF0
Zm9ybXMNCj4gPg0KPiA+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQo+ID4NCj4gPg0KPiA+IEhlbGxvIFZpZHlhLA0KPiA+DQo+ID4gT24g
VHVlLCBKYW4gMjgsIDIwMjUgYXQgMTA6MTI6NDRBTSArMDUzMCwgVmlkeWEgU2FnYXIgd3JvdGU6
DQo+ID4gPiBBZGQgUENJZSBSQyAmIEVQIHN1cHBvcnQgZm9yIFRlZ3JhMjM0IFBsYXRmb3Jtcy4N
Cj4gPg0KPiA+IFRoZSBjb21taXQgbG9nIGRvZXMgbGVhdmUgcXVpdGUgYSBmZXcgcXVlc3Rpb25z
IHVuYW5zd2VyZWQuDQo+ID4NCj4gPiBTaW5jZSB5b3UgYXJlIGp1c3QgdXBkYXRpbmcgdGhlIEtj
b25maWcgYW5kIG5vdGhpbmcgZWxzZToNCj4gPiBEb2VzIHRoZSBEVCBiaW5kaW5nIGFscmVhZHkg
aGF2ZSBzdXBwb3J0IGZvciB0aGUgVGVncmEyMzQgU29DPw0KPiA+IERvZXMgdGhlIGRyaXZlciBh
bHJlYWR5IGhhdmUgc3VwcG9ydCBmb3IgdGhlIFRlZ3JhMjM0IFNvQz8NCj4gPg0KPiA+IExvb2tp
bmcgYXQgdGhlIERUIGJpbmRpbmcgYW5kIGRyaXZlciwgdGhlIGFuc3dlciB0byBib3RoIHF1ZXN0
aW9ucyBpcw0KPiA+IHllcy4gKFRoaXMgc2hvdWxkIGhhdmUgYmVlbiBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UgSU1PLikNCj4gPg0KPiA+DQo+ID4gQnV0IHRoYXQgbGVhZHMgbWUgdG8gdGhlIHF1ZXN0
aW9uLCBzaW5jZSB0aGVyZSBpcyBzdXBwb3J0IGZvciBUZWdyYTIzNA0KPiA+IFNvQyBpbiB0aGUg
ZHJpdmVyLCBkb2VzIHRoaXMgbWVhbnMgdGhhdCB0aGlzIGZpeGVzIGEgcmVncmVzc2lvbiwgZS5n
Lg0KPiA+IHRoZSBLY29uZmlnIEFSQ0hfVEVHUkFfMjM0X1NPQyB3YXMgYWRkZWQgYWZ0ZXIgdGhl
IGRyaXZlciBzdXBwb3J0IGluDQo+ID4gdGhpcyBkcml2ZXIgd2FzIGFkZGVkLiBJbiB0aGlzIGNh
c2UsIHlvdSBzaG91bGQgaGF2ZSBhIEZpeGVzOiB0YWcgdGhhdA0KPiA+IHBvaW50cyB0byB0aGUg
Y29tbWl0IHRoYXQgYWRkZWQgQVJDSF9URUdSQV8yMzRfU09DLg0KPiA+DQo+ID4gT3IgaGFzIHRo
ZSB0aGUgZHJpdmVyIHN1cHBvcnQgZm9yIFRlZ3JhMjM0IGJlZW4gImRlYWQtY29kZSIgc2luY2Ug
aXQNCj4gPiB3YXMgb3JpZ2luYWxseSBhZGRlZD8gKEJlY2F1c2Ugd2l0aG91dCB0aGlzIHBhdGNo
LCBubyBvbmUgY2FuIGhhdmUNCj4gPiB0ZXN0ZWQgaXQsIGF0IGxlYXN0IG5vdCB3aXRob3V0IENP
TVBJTEVfVEVTVC4pIEluIHRoaXMgY2FzZSwgeW91DQo+ID4gc2hvdWxkIGFkZDoNCj4gPiBGaXhl
czogYTU0ZTE5MDczNzE4ICgiUENJOiB0ZWdyYTE5NDogQWRkIFRlZ3JhMjM0IFBDSWUgc3VwcG9y
dCIpDQo+ID4NCj4gPg0KPiA+IEtpbmQgcmVnYXJkcywNCj4gPiBOaWtsYXMNCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

