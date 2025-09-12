Return-Path: <linux-pci+bounces-36028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE4B55026
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 15:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4A758064E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812AD258EF0;
	Fri, 12 Sep 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wHDCKJs0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25A30E82A;
	Fri, 12 Sep 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685586; cv=fail; b=eKtvtT08BkiEfiz0NrSwM9u5HtMM/wHmElfssxtb8XAnQu+5XMRdIAzSV1yd4Tznsv1zzh36iHuge/u6Igv286587L1Ttj0H1/rALto9EJs+p3r3vFLUIsdE5vRhui877N4tHa1/zHn5kRuibyW529tcliy1go+lsaRspyHJB4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685586; c=relaxed/simple;
	bh=dbUgLK+xl21sufSzxk46gH6xRYRTRIXlbiqzU+Q81Bg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdgMWgPP8bR3POoQMBwNAz9k8TnUxt8DfS2j/f5gs4VckzeV9xcyCUo4EUm8qoC5Q6J/h62IAZDAKV204sxBYKejxWYjpBRpcEPKtD+Y61lgGki1WxwQglwwSIF7gPZZ7uaPugwRd2nUCHm0mfEbJKDFtuJJhha90fnt0CEftEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wHDCKJs0; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ito4AgrnqrOYIAXFFwNk5b0U5uQf6o/Qs/XxBHRjUFISqMiU92n9XHBOUvX6+j0MjLMYzyBz352rANUidq2eCB9PKjPgsAXVlxb+1dVGXiTzHTCbcZnqnsDK1qV5juKfGKgUMLqRqlAQrzqi53oG1SeKATOxzTnHX2OMDZwmhyX6GPYlw9J9L2nSL1AxWHyQlYbO6aVcDgf/QJlkGuJMhzFuuIxkt+WshAdZaeQQQB/aq1LQioVz7RTEQRg/DNvtxhGbVVFWosfhLqmktxBOGg7MZYs5xtpGmtrOoFFBtG0EvSM2TyF2jq4sUDE+JYCSn+DqRERy1c9QgdxhymZ0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=195+aZGIwvVT6tiZs0Bo/6lLfrK4XDjFE68QnMtP364=;
 b=O9D9NoGYvI0XFJLF68IlXknIGPOA2Qp8/1El8GfM7z8NGDn1pri2VXOUJgjIyA82QJL7loo9xxLN6WP3xel28Gyvh+5JV/o58rfef1AEoe/C2QTvqbuPJk7X4/x/XuUsFAcD3BVYrMLj1mqcXAfC5/dFFZqrPwdo3ljcUCyfUZC2QRRPTGYnP0YhvStjBrhsNZDftwSm+npgh8WqoOZgkt4CWFmfiOHIkRG4jOiSN/4Ceo538cbM8nq266kaADrbYzydYoPMhtzrK1LOgGNVCV3FiUzfr9iNlVcGj8DxHmQEtfnuFJOj9E5IAxP2KmjpMTRE3CpmJ3yUwQlXvDOL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=195+aZGIwvVT6tiZs0Bo/6lLfrK4XDjFE68QnMtP364=;
 b=wHDCKJs0sDVvXll+tpPi7pveRBDnfzeBBt2D+7NBIe2j7cttr5wweLvA23z9gKyQG+WoP0mKuyVOLzajvKKeDfxo9WF/rXzEQ8C8Rne6FOXYnPVGTw+cJ/ALlGA0xot+VffpaM6ilcARdxD7euxeECE0KhlWNSvxMhnRpm7pync=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.18; Fri, 12 Sep 2025 13:59:40 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 13:59:40 +0000
Message-ID: <52a64372-098b-4656-a1c0-1a6cfee126e3@amd.com>
Date: Fri, 12 Sep 2025 08:59:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
To: Lukas Wunner <lukas@wunner.de>, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-7-terry.bowman@amd.com>
 <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com> <aLFnKbWtacLUsjAi@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aLFnKbWtacLUsjAi@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS2PEPF00004552.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51a) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 406e9b50-d4df-4c4a-e178-08ddf2049e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDY2aW9ZMWt5MmVaZGxQM200N3lHUlNCMkxVSnN3cVg0VGEwRGR5OS9HaVpL?=
 =?utf-8?B?REdlK2k5NDNWSGxsTXJyVGVaSDhET29JTDNvWTE0V0RJaFg1NnFUSHF6ckxD?=
 =?utf-8?B?bmJ1VjBzSmtDMkNmbE5IbGJtZEEySzR6NFVYcTg4VENLWCtBc3JYOWtUY3hB?=
 =?utf-8?B?dkhzaDY1ZXBPUHd4ZFlwUmpuenhCYzdib0g3TUtTTnRJcFc2OTQxN2lIMUwz?=
 =?utf-8?B?M3NNTUFvdG9aaTB4VDlsVEpseU4rL3pJREdmd3lqR2tzRHhzeG8yQVM5NDB3?=
 =?utf-8?B?bGRpOFZZOThkc2dCbHJranlweUdwUHBIT0JLcjFFOWZHcElDejAxVDUreU1w?=
 =?utf-8?B?c0R5Sk9jWWhNV09XVEZWbWtrbFpOZmNocHZBQTlGRHJ3b0xBZHRKL05QZWp5?=
 =?utf-8?B?cWdjUWFFR3R3NUxwUzdidHF5eVhCamlidW03TlY5T0xIajBJWlFkUGllZmVv?=
 =?utf-8?B?MlVIcWh0cms1ZTBsVEJ5QlJrSjJoQlNJdGJGV0hkL3FVOVl5bUxqczhzZUNq?=
 =?utf-8?B?Z0dheHhNdVlncXlQNTNURGIrbG1acXg0Nm9PdU5XQmROZjc2dUFtOCtSbllj?=
 =?utf-8?B?UUc0UFluOUI2SEZSSHlhRXdrNEZUVngvSUF4RHZLWVUrWVQ1L3FlTDdCSUg2?=
 =?utf-8?B?UDFSTUNrT2dGVzd3MlcrVEh1UkMzc2VMTkJSYXhHS0NYbVpNMkhTZmZnRWFX?=
 =?utf-8?B?OU50NTdhcjVVbnhsb2dTUC9tUnlVSlMyMk9aR21tMVJEdXRDNUQ2L3FONmFm?=
 =?utf-8?B?aXlEMmxJYjdUeXd6Nzh3dDVPZHJrNEFmT2hhUE5ZdTlPdzR0RXNWMERBbmtY?=
 =?utf-8?B?ZmE5aFQvajVhU25jeDNydlo1cUErWFJMWHpwaXV1TDZDNzdPTy85QmlpNFBH?=
 =?utf-8?B?NUtWSXpMMTI2NldzaGlUV0I5eHdwRkJqZmQwZENHd0twOUt3SGtRQThaSW9O?=
 =?utf-8?B?V0RRT3daUTRqa2RrSEsxMys0YnFhUUkxUE4xeDErbWg1Nmwvck5PQzFBdXIv?=
 =?utf-8?B?ME51SkFGWlp4YnZWZncxSGdSU0c4bnlMVCtBbmQ3VURGUGR1TkFTOTNMWW1o?=
 =?utf-8?B?OE5Zdk1wMk9ocHZTZThPMjQ4N3BabTRSZ0srenJzSlVIeGYzYTBsWlBsd0pJ?=
 =?utf-8?B?aEpnWktjYmdMYzJZM1lGdkRFMEdwdFZ4WWM3LzErSzQ5VUlnVzVjRmZrZ0Zk?=
 =?utf-8?B?b1RTbnJvNExmbUduRU80MU5YYVVoVnhJVnJPUTE3bWFOY2YvZ3c3WjJpUHRY?=
 =?utf-8?B?OGFoMDRpanQvREszZzY5SVh2aDl3SFhudytGRHc2OW5EdmpxKzBubGpqMG1i?=
 =?utf-8?B?d3BTR29qOUx4ZnZTNlpJTkxGNjNaZlNlaTlQOXdFNHpuS2Y1OW1BWEtLRDFE?=
 =?utf-8?B?RGNPOTZXcnJ2dHpBRWZ6Ulc1MlNxVndhRXhQWWlxY3o0V3IzM090SThubTNi?=
 =?utf-8?B?MUJ1TysyU09nRlJ1Ym04NWg2R2FHVlUvaHhHeXFEN29tV3gzcU9CUyt3cXJX?=
 =?utf-8?B?WkJPWVl1Nk03bVpxNlc5T0pmaE9NRG13Rkc3bjdvZHJlYlJwTE0xanZDMlFx?=
 =?utf-8?B?eUFqcmR2dk91djl4djl1N2V0blVacUVrRS8zd05MNWk0SmV0cjFKaW1FMDB3?=
 =?utf-8?B?TnVhd2dFRmZBcTZJbjM3Mkd3WXFTVEZXbzdKVmN1N1hXUVJQRm9kY3lxN0E5?=
 =?utf-8?B?K2QvVlFxTFFoQXNxd0NUNmhxL3VsclNaVklLTXlJS3kyWXdncXdjSGFDdFpy?=
 =?utf-8?B?T3RKdWlsVHFmWVJBbkR2Y2ExNWhDTHhKZ0V2cERoZzdaMnAwek84djFoMEl6?=
 =?utf-8?B?Y1d0ZmZtWFpIaTBPOXhvbEo2UVc0cHhkMkM3TDZOa1lWM1NpZjJ5UDdiUGpv?=
 =?utf-8?B?T3lIaUtLQjZrQWZ3UE9TSWxFQnpIRkFIeTExQmRjRFBWZEZ6R1NIc1dTcFlo?=
 =?utf-8?Q?NriJG9uRHiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVFEWnpaNHNiY0Y5UU9HUFdzODNzYlliQVoxVlFxNjJjek9IM3JnSUo2OFJx?=
 =?utf-8?B?VGRHRkZqU3BxRWMvZDEvbmg2MFVVT2VKL3h6R2ZoL3R0TEJyZWFCUS9XNmJi?=
 =?utf-8?B?R2NuKy8wU1pXaXp1UEpVdnNCNWsrejAvQ0QwNVF4T0trRmNEeUFJRVIzQm1V?=
 =?utf-8?B?dGkzUXoyekdpaHcwbUJPYmQzbUI3Q1Q3V201UU5sd3FLZ3c2UGhlRWc3cE5u?=
 =?utf-8?B?MTNIZnNPamhkaUlvZWhnUHUxN3IxZkttZlJ0RW54d3ZoMFlhWXVEQk5HcHg3?=
 =?utf-8?B?KzhudzVvOFBjOWI2VnJHQ1ozMlgxVnhpR1VPMERWVWdCblhhakFHbmFUY0hu?=
 =?utf-8?B?YzFuTXBCeWJkRG1LY0FaSjl6b2ZIcGhrSTlEM2w0V0ZJU2R4RVBsT3lFVDd6?=
 =?utf-8?B?dmxTK08yV2d6K0tqNEJUcjJ0Y2F2a2NLVUNpQTBZN3RISkRjMWJzS0VScFA4?=
 =?utf-8?B?Q1JnKzZqLzBidzRMb2tRWkwzaWJFVTdtMWdZdXA3UG8wL3BtNmU1WXkvWEx0?=
 =?utf-8?B?dG90d1duVEtkelpDN3A5emYwaWgxTTU4TmJMcEtUeGFyaEhZV1lMNlQ5eXdv?=
 =?utf-8?B?MFhrL3dPMkhTSi9SaWRQYVAyeEtucE9YNXRIbUZBNG9TYkMyUWYvQ2xoT0Q2?=
 =?utf-8?B?Q09wVncwMWFCUlVhR3piNUlJK1pYSGphRkY3aEZJRUZuY2RRK3FMN1Z5cXZu?=
 =?utf-8?B?RkF5eFFTWWZHYUdmbmEyQW9UVnNMem03K0w1YmtVRzZoS3ZUUXpHSDRrcDE5?=
 =?utf-8?B?S1JlWG05K3ViV3l3UEFiVDQwSGszMmNsbnpGTHpvdGJSaFp2M1dDYUpSWE9L?=
 =?utf-8?B?NEV6SXhaaW1aTnMrRnBQVDhmL0xvdW5VamtiU2VERWNQNTN0Nm90NjhIVHpi?=
 =?utf-8?B?OVk4QWFER2F4U0tzcVFqbS9aRzQvSGhUTkVzeW9UNitZN28rRnZIUmRCbjAv?=
 =?utf-8?B?bitxajNLV2NHQ093UlpNc0RvY3IvK2xJSS9idzA3UVBxZjFxMU52QmtSU2FL?=
 =?utf-8?B?YzM3SUhUQjhEZ1pvZUFTZ0VBMldwZmtROEZzYnhFeGRhc3BaODBwaG5FN2JR?=
 =?utf-8?B?QW1ud29XL2pzckRvNzZLOXVqM2JlM3BIRGxsUzFQMElLczhJZ2JQZjFrRTAr?=
 =?utf-8?B?OWZ2YXhWVm8xV0pmY2dGajFNUU5lQm1qWXFGNkJuMCtCc2NsMVI1TjJzcVhm?=
 =?utf-8?B?Q0xlVnJRdGhFUHY1WE5NNlNYVWhLeGdJV01wMHJzM0VER0FGRzNPazEyTWQ4?=
 =?utf-8?B?RVJicHhkMDhtSlhvSFpnVVRoaFV0eThNdDh4QzJIWjdhV2E3SmFNemJtQTV5?=
 =?utf-8?B?TVNzRkRvbU1GOEEva1lyaDRhV01nem1GZE8rblphRjhXMVNKVE5oVk9ZMXh1?=
 =?utf-8?B?Qmx4NDBKUTNZWUpIY2VUNE9mZmJOSllETXRpM3lnbERFQ3hpY3ZteXNKZysz?=
 =?utf-8?B?ekJrZlFKVXY2SktuUFNiM3BrYy9NSnQ5bVd5RGdDRDlWOU9TSThDWHZyV2c5?=
 =?utf-8?B?Y0dCUTJOalh6V3Ixb2YwU3ZoWFBpZ2RXdkJZK0xtMDU3VnFZbi94VWZZMkcv?=
 =?utf-8?B?ZnZHeEFqak9Od2YybmF3WEttOGIyOE15OFk0V2lncEJTVEdCQ3NES0tabWJw?=
 =?utf-8?B?UmRHSnBvL29sRkNPMExLdGNZSUNVWW16am1nWkNGWUVkMi94Y3EwbWJycDZZ?=
 =?utf-8?B?Q0IyUjVKTWVnQ2N6SEdTOGRuS1NQa2tNbDFaYmhYR2d0WktJVXBWTllnQ094?=
 =?utf-8?B?aXk4aXZSWGxVanA4TUtFNUliMVF4d1ZBMnFEQXlleFd4ZUJZMUFkcmNyT21K?=
 =?utf-8?B?YzJTRmU1anJENXFIcmJWRFhEK1VtYnpsSTJESDFlYjZZMXIyaUVxOEUzSDJ3?=
 =?utf-8?B?RGphVmNlalZNSm1GQ3NkcmQvbTJNOUxLbWdrYitFQ2ZnV1RnaTRpUUx3SHRW?=
 =?utf-8?B?RFhKeW4rZGd4Nm04VmN4WlAycC9HSWxxK0g3WVZ0YnhaRFZwMnZUaXJ4SlFo?=
 =?utf-8?B?ZHZURDlVeW80ek00ZVNTZFZEd2F5K3RnTG5zMGFBL1k4TWlKQVdDc1BPTFhm?=
 =?utf-8?B?d1Q1c3lSN0RDdU1xSWowN1o3MnROaFRGYTFhdjJobVR5VkIzbnF2VHBjQXg1?=
 =?utf-8?Q?eRnhVQBqLqRacqjfNMpJNz0ND?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406e9b50-d4df-4c4a-e178-08ddf2049e06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 13:59:40.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVj2BkIzbWrnahCdtCMJvJvIYVxZqw9G3F+dyEMy2HRGLMMRGTwBqVXb9r361O3daebeDKOwMEV6cH8JJyO+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804



On 8/29/2025 3:39 AM, Lukas Wunner wrote:
> On Thu, Aug 28, 2025 at 01:53:35PM -0700, Dave Jiang wrote:
>> On 8/26/25 6:35 PM, Terry Bowman wrote:
>>>  drivers/cxl/Kconfig        |   9 +++-
>>>  drivers/cxl/core/ras.c     |   3 ++
>>>  drivers/pci/pci.h          |  20 +++++++
>>>  drivers/pci/pcie/Makefile  |   1 +
>>>  drivers/pci/pcie/aer.c     | 108 +++----------------------------------
>>>  drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++
>> I wonder if this should be cxl_rch_aer.c to be clear that it's cxl
>> related code.
> I'd prefer an "aer_" prefix at the beginning of filenames,
> but maybe that's just me...
>
> Thanks,
>
> Lukas

Hi Lukas,

After discussing off-thread I understand you prefer changing the name here to be 
drivers/pci/pcie/aer_cxl_rch.c. 

Also, the non-RCH changes should be added to a file named drivers/pci/pcie/aer_cxl_vh.c 
in the later patch (CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors).

Can you confirm the name changes are as you prefer?

Terry


