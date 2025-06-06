Return-Path: <linux-pci+bounces-29097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFC8AD0381
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36343188D7B3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCD288CBA;
	Fri,  6 Jun 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bNUUVBqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD16289353;
	Fri,  6 Jun 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217906; cv=fail; b=c54alHFdFevbnVTK3xiZMPklx3pC8UfxT7vXRNktP9AND5T9lZDpWh3gUPYk2Ui2uVW5TnUehYw7HBOY+QTpHCajMnb9K8Pt66Wsd8Cz0PWordIos8ONmglUU7vy0309J/tblEzkItGPg9Tg9UP5L6WURkI2NDHOORDtXf3LlNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217906; c=relaxed/simple;
	bh=K+LMfpcSHDSxdzRCgOhGsEHXIDiER1yOFin8F+AScKE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qBJqgWdcxKGp6RhBCv0oHD8SX7NU1bSRxckldHb0dcFyDlz4jf6ZX6EfWxQbeX+sqSQrpLGNyZluMjWdFS1gi3px6y8Oab9r2phVsNRTutqciggEoA+yTxpKjG74Jn4hTDOEjbZBoUCaPeXZd/m09uOE+PMhgif9c3auGwcRQ9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bNUUVBqg; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeN2PdKh3ul3w1ksgo2sqL9HcMcSPpGv/haGC1WI8EXMjQn4JO3lYeA73Mr+dfQ0z6nSrJFCe6x03knpfvCygAVxZKUI+XsFKM0vByyt513cdbGMBW2KzqkT0dYPJaeKtLuZm9BhsCK3SmhlDE3R/nf1pk60d+GkVvAxe88/8VodEHXny71FiE3gmfHfi+SlGES31LEAd4jHEt+3LApQI4XInjdNnUCsKj0IUImuhsQQmsf+bCMl7xDt5dsyY19btyTUSBSL+zziVr4SpUmKcc1Mnrt9hIb3OiV4xaDgVY17XoOBGPp/TioFhRa625rAQi5kaKw7UsRL0+/nWm9E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6F0mbkiQICMY3ysVesMWXnzk3+XRgvaUmICLsYgjho=;
 b=hzh0StPHh1xea7sxyev3M4wNbW9QLVWh/qsYQVIxLiKozJDO0R/gpxKNKJ970nUM/KxqedFIVBQMtV4YXG+DBFHbwlIhUFjiDmdiagNT7THxLNJhwMislkfM8dzU/sw1LpFKLgtu4kRIMNT6LMqJM1HU7ZgRbLY/dFcWBYqq0so+OzHGo7QvTs9t3mUVA0bz9K1HwEjRxvGlXI1H+x0wQDd9LpxMqD80mAbeSejlnh0+6CrD21+pcjD5Kr1fFtKG20CBcePIB4y+i6vOM/3Sdtb7CvrBo/qYgZDiMGklP38iwtS5kkBfT9UNSmKdAQwtYgFLW5Llm0oEHsU15Fb72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6F0mbkiQICMY3ysVesMWXnzk3+XRgvaUmICLsYgjho=;
 b=bNUUVBqgS8J2eU1FjmgelnzvBXVYJBJvgCusODJppo0m37oXh7G7j/tfvDdhLMcfmFaqoz2u48B7lblGBHdpuvSMQdNVqqrMgps4XlBhlO+sqap0hSb2xEdzikqCTYDUU5wdIDTrZlYpwOEwu44WbRuWtDEJjihrwgyVQ32Fap0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.33; Fri, 6 Jun 2025 13:51:40 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 13:51:40 +0000
Message-ID: <d9971090-a609-4f7b-bbcc-2dd6aaf12bfe@amd.com>
Date: Fri, 6 Jun 2025 08:51:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/16] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-17-terry.bowman@amd.com>
 <a8d687e4-03d3-4d08-9149-757349704207@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <a8d687e4-03d3-4d08-9149-757349704207@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0205.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::30) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9acd47-8214-4bca-1925-08dda5014370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clZHVUMyOGJtRlhGYjZrcmYzZjdBSlVmNFJEa2lZMkVydzB0RzZtcktveElN?=
 =?utf-8?B?TlJUMjlPcGJId3FvMTdwR0I4R0dmSUI0WGY3RmpBb0V5TmY5MThuZ3o1RlVW?=
 =?utf-8?B?OWtLNE1kSm1WdnJ6K1Y0eGgzZ3VoMDFyd2lmVkFYNkd6R1BIQ1ZtdHFOdnp1?=
 =?utf-8?B?YlZReEhkWkxCUWJ5SWczRHdsdnlvS3N3M2Z0NnVZT0dGV1cvSk80cGVsZmh5?=
 =?utf-8?B?VGJJbFBXa05WR09ZUUg0OVcwc0h1c0tZNVAwRThxbFJXU2s5bFlZNytsdHph?=
 =?utf-8?B?dnQyMjlydUhBM2tNajFTN2JuK1VNb0NTelN4VTVCVnZBcmFrYzY5czdMMUl5?=
 =?utf-8?B?RDArSzU5K1JwdWZKbUx6R2xFYXNLcjduWlVIamZ5bU1QZ09KWC9SYnpZdHY3?=
 =?utf-8?B?elhmSHhYcmZ6TzhialVaODA4L0gzSUttbFlBczVONEhlWk9MTkxqaUpxa0dp?=
 =?utf-8?B?OVUwY3FnN3djTDJCb0xINmZiak43a2diaTF3ZVhrVS96UUtCSzhiM0ltRnRB?=
 =?utf-8?B?RDlPNlNQaEhHRjN0VXA1NjFYc2k2MlowQS9kempHRURTVXFXMjFCakxjWnNP?=
 =?utf-8?B?TDRwdE1MYWJyalNERE5Idkdha2MyRVFzdU84NGlrRUtHTnNBZno5N2puYmFn?=
 =?utf-8?B?clgwVGZtQ3hDVmZ0Rmt6RmQ2S3M0VXpteXBObkFVWHNONlAyaHZ4WVFJMzlO?=
 =?utf-8?B?d0FkVGlLc3NBY2hoWkxDVHdWeVcxNjFheWtqRWZvOTRCV0Nxem12MFo4WWpw?=
 =?utf-8?B?eFZtcVE5S2NLdEt0WVcwUWhGT1RIck44Ymh0RHBsVmF2ejJzSHZQTkE2c29T?=
 =?utf-8?B?WTZYTmpMbDJrL212UDRzbkkzMUFsLzdOdVROZCtZZkxsRXo1Y2kybFY5N0Fv?=
 =?utf-8?B?Q0lVKzE1aXU1YjdRRzZjdDFVdmR1cGhqaVhZRG04TjQzcUxSendHWG5Wd1p2?=
 =?utf-8?B?WlQvK1hBVFU3SWp0NXNBbEg0b0ptUitmclU0MG5HNFN1eS9KWHNtYlcvRGFH?=
 =?utf-8?B?T0JnR0I4NmF6bVBKV2Q2RkE3eEU0dFB2Q3BjWkMyUkZLWkJRcTJLZ0ZBckFH?=
 =?utf-8?B?SW0wRTZVZG1WK2ovZ2dLUVRBNUI2SzFYa29aSXBsVHVFb2NsQTZmSW5BUEJI?=
 =?utf-8?B?dFV1WnVPQkF3ZFRiUGVRVFo0RkZ2OHI0NDhpSmRhd2Q5WGIrVkNuQzlPNlhK?=
 =?utf-8?B?VHpVQVNUR2UwNXNvYVQ4RWtybTVSMHlWaWovenprME5NdEJwL09sODNQREdX?=
 =?utf-8?B?d2lGdlBDNGUxUkFaMElLUXNCV2RxVUtnM1NQQWFQTmRzckhjR1FWeDFTMS9H?=
 =?utf-8?B?UGgwUUlHVEFXNjRKb0EvTXZUWGZTNFdJMVovMUMvdTlIWFpyYTNGWEV6dkRM?=
 =?utf-8?B?R2FZV0JncjZEL2V6eGxMNEdDVzFIMkR6b1dMalM4QTlQNVhRdk5vRi9uWi9x?=
 =?utf-8?B?WmVPQW5rcnc5ZitLWkUzRlpLckltck1HVWVJZFhiSG4xOHJ0Y25VQWZXVU1T?=
 =?utf-8?B?aWEzTEJ5YmdGSkFleGZqYXAwRmhxWkNpMTdaQUJPVzhFa28rL1duWmx2dTFa?=
 =?utf-8?B?STEyTzZzVUIzS1ZjOUhNRmlidUIvOG9FN3lvMzhYVzZEdEN2cU9JS2hhcDRX?=
 =?utf-8?B?YmZaNDl1WXlaUFUvUGh0L3plTFVrWExDNjFZMUlwYU5HVFJDTS91UnBWellS?=
 =?utf-8?B?MG9CMFJtaEtOUGlqOFRabW1FaXYvcEk2VHlxdmNEM2JiNTdBNThkcUZjVlVN?=
 =?utf-8?B?bW91MDB0cHh2d1V4OHE4WFdRM0NDNlF6MUUxZWpCVTVUTitpNW9zSFZ6L0R3?=
 =?utf-8?B?KzkvdGtlWjIwdHppUHN4MkdFVjQ5aEszWWxYaE5UTzlUY21WejdLdVFnZlJC?=
 =?utf-8?B?Z3piS1Z3MHhIUEE5TVJTaFZsRHVydGFSN292Y1FPcUVBMU44cE5mUXN6eUt5?=
 =?utf-8?B?ZGhiT2VqVmJ1OXBxQzhsUTRtRmtuL1J4azhzOGovVkhBRVM1SGsrMDlqMkpZ?=
 =?utf-8?B?WUNPcmhpQ25nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2J5bnJ0TmNmRFVnRW1MSGRHbldGbllnWWJBQ1c2dHBWV1VETjdFM1gwYmha?=
 =?utf-8?B?dzYxSkpxaER3YmtidURmMWRkeDY5WDZKSXdxbHZPTlR3OEtTbmNKZk0xYm5a?=
 =?utf-8?B?bWJYZEJ5c2hxMkk2bTVPeEpiazRQNHJZOFdKZFdNbUNVTnNXUUNzZVFhQmFF?=
 =?utf-8?B?M001eTBjamNmV1YzT0pQZjVpemRIdElmRHczWCtXRmxLRDVrNWhFTXNOd0ph?=
 =?utf-8?B?MXJ5RkF4Zi9qV1NsZ2hJQmFTN0hUbVhBMlpOQnhaQWpVdy9wWnAzUW9BZHZD?=
 =?utf-8?B?aGtmaGUwcjFUbzFrb1dZVjVyc3J4b00vbi8wRXY4ZFdIZmowaU03M0pRZ21y?=
 =?utf-8?B?OUdwWi9QbCtWdFIxWFk4b3BwSXNhRWpoZzl2SFhrQklFWFdzZXN6Z3QrSERJ?=
 =?utf-8?B?Smc1eWhQYWtCNlIwWFNJekxuQ1RjY1FuVk1UVVMzR2haN3dETWFxSVFBaEZv?=
 =?utf-8?B?NnlDY28xU2dZRDlVMVRSdm9DNC9ORmdkMHVMOXgrTmRFSEtPdGNwbTVFeHFx?=
 =?utf-8?B?RGNTTnRnQnJrOGltSHZBQmdCUVIwSDRPb0o3djY1VFA0SUJMdEowN1FtSHhN?=
 =?utf-8?B?R0JZVGI1akY0eUVOeTE1Vi9SVWZNWlpuZXVjV3dSWWRpN3dRejNHclE2K2ZC?=
 =?utf-8?B?UlJaaXVLUXBQUVJTbXUrQStSMXF3S1ZzZ0pYQ3hIcXUxQnpZT2Y1TFBiQXVO?=
 =?utf-8?B?Z0Y2byt6SGFjUkFKbVJId1JvM1ZPMHgxaXN3ZDFSMU1mcCtLOHVlckhRZk8x?=
 =?utf-8?B?YmFiemR1blNJdGpxL05lKzMwREFEbkk5dDdKbjk4UFlmaUxPbERuMVo2RmYx?=
 =?utf-8?B?elo0UThmd25JWkNVOFNXcXlYTHE4VVJmOEhKOUpwTEZZWHNwQmZiRXhWOSs0?=
 =?utf-8?B?OW14TGl5S0x0QXRacXlkVnR1elJyME5NeFFiSCtpOVZjcHA3MjlRT3dhQjM1?=
 =?utf-8?B?QXlwYzFLMkF5R0NDNXZSM2NrSDk2bHFCd1g0cUFQM210YU55YndhL2Q2Slov?=
 =?utf-8?B?czZkeVZIQmg0WWZra21PT1dDZENBNERJajhSZ3FjU3JlYTlYandSeTVJNkZZ?=
 =?utf-8?B?VmQyTFZnN2FrQllSWm56eW44WGdyeHA4alFtNkZ3OVZKdHE2enBHVG1ZUTBG?=
 =?utf-8?B?WEFXQUlZYTNqMUJqcjdBWVUxNnUycDFiaHhSUkJ0TXNFZHB4R1NLdDhqY1Zs?=
 =?utf-8?B?UXpjK0V5OCtHVnRERU5iTTRNaXMrZWdIN25TeE9oTWJFLzhxeFk4T1FHZm5F?=
 =?utf-8?B?UlFZdXpGdnVUUjlUOTV2SmJCbXFEN0Y2WFBXSjJYaEJRZFFRNzZBdmMrMXVS?=
 =?utf-8?B?TlFUZ25PUlBPNjVZY1E3eVphL080OGRxaGFUa0FsOGNEam1pTTROSnJVL3A4?=
 =?utf-8?B?Q1VEYmxrRnBCNmpQdXBOU3g1alFMU2VlOENlQ2drSzdGWnhia0Y5d0hvQW9C?=
 =?utf-8?B?d0xxVzZHY21ONTFDMndYVjVBK0pJWlJ6c24rSmt3U3VRY2tzaTkyZTZJYTJW?=
 =?utf-8?B?QUFpV0JBTW9pV2lUZVB4U3NCcHpHaG1UTklDYUdtRVFCWDIwV0lqdHo1U3lP?=
 =?utf-8?B?OTJ0VGNUdGtJZklzZURqZGFaWkJTeDJGTFBVOUxQY0k1L0ZrZW9tMUc5NHVs?=
 =?utf-8?B?dDFMbnloU3lnUkw2dHRwSkxubDhDZ2hGMngxYTUvM3ZtcUVwU0JuSGJ3NUw1?=
 =?utf-8?B?SUZZS3NIMXZFZlB2SmVMbDYzaTJ1MlVkcHZmVEVCU3doSDFDNzF5T3RVVkkv?=
 =?utf-8?B?a2xPbWlNaE5SelNSOE0zVlJwOXZwUVhSMXNhc3VOYm5RclVwN3FNdnFkaUdX?=
 =?utf-8?B?Nm1lSzBscnlMcmVqS0lZaitBV0xpRWhyaGhLZFhxVk8ranJ0Sjlqc1cxSHVz?=
 =?utf-8?B?TFVXZEN4eXl6ak5IL211clRIeFhRQks1RUF3amJWQ2JrWmlhQW5yRkhGVHlF?=
 =?utf-8?B?d3F3emlPR0VxVms2Z01LbTFaWXNrQ3NzV1RRQXJDVlpTUVd2bmVNVithZzJ5?=
 =?utf-8?B?bVQvbXRvQ2lSQ09RR3BRNnJIUW92azNYRXBOd2oyaFl1Ulc3em04L2hzSE54?=
 =?utf-8?B?bnloOWRvV2hZRnVrMnlRU09tWDkyRUl3dEdRUjZEUWtkRFdnNStqQVlQeWRS?=
 =?utf-8?Q?d5JOoxJm8C5ysSdVnLbIxxwQ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9acd47-8214-4bca-1925-08dda5014370
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 13:51:40.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7wZeOV9uHCqqWJtpjQfxzjIhrprgYblPXI6Jzm/tJ2CGM3JftXlLystB9JsMetkZ+lIbQqHoaXS+uDBzG6qaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742



On 6/5/2025 7:52 PM, Sathyanarayanan Kuppuswamy wrote:
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> During CXL device cleanup the CXL PCIe Port device interrupts remain
>> enabled. This potentially allows unnecessary interrupt processing on
>> behalf of the CXL errors while the device is destroyed.
>>
>> Disable CXL protocol errors by setting the CXL devices' AER mask register.
>>
>> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
>>
>> Introduce cxl_mask_prot_interrupts() to call pci_aer_mask_internal_errors().
>> Add calls to cxl_mask_prot_interrupts() within CXL Port teardown for CXL
>> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
>> Endpoints. Follow the same "bottom-up" approach used during CXL Port
>> teardown.
>>
>> Implement cxl_mask_prot_interrupts() in a header file to avoid introducing
>> Kconfig ifdefs in cxl/core/port.c.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Kuppuswamy, thank you for the series patchset reviews and reviewed-by's. I 

Regards,
Terry


>>   drivers/cxl/core/port.c |  6 ++++++
>>   drivers/cxl/cxl.h       |  8 ++++++++
>>   drivers/pci/pcie/aer.c  | 21 +++++++++++++++++++++
>>   include/linux/aer.h     |  1 +
>>   4 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 07b9bb0f601f..6aaaad002a7f 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1433,6 +1433,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
>>    */
>>   static void delete_switch_port(struct cxl_port *port)
>>   {
>> +	cxl_mask_prot_interrupts(port->uport_dev);
>> +	cxl_mask_prot_interrupts(port->parent_dport->dport_dev);
>> +
>>   	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
>>   	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
>>   	devm_release_action(port->dev.parent, unregister_port, port);
>> @@ -1446,6 +1449,7 @@ static void reap_dports(struct cxl_port *port)
>>   	device_lock_assert(&port->dev);
>>   
>>   	xa_for_each(&port->dports, index, dport) {
>> +		cxl_mask_prot_interrupts(dport->dport_dev);
>>   		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>>   		devm_release_action(&port->dev, cxl_dport_remove, dport);
>>   		devm_kfree(&port->dev, dport);
>> @@ -1476,6 +1480,8 @@ static void cxl_detach_ep(void *data)
>>   {
>>   	struct cxl_memdev *cxlmd = data;
>>   
>> +	cxl_mask_prot_interrupts(cxlmd->cxlds->dev);
>> +
>>   	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>>   		struct cxl_port *port, *parent_port;
>>   		struct detach_ctx ctx = {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 2c1c00466a25..2753db3d473e 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/node.h>
>>   #include <linux/io.h>
>>   #include <linux/pci.h>
>> +#include <linux/aer.h>
>>   
>>   extern const struct nvdimm_security_ops *cxl_security_ops;
>>   
>> @@ -771,9 +772,16 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>   #ifdef CONFIG_PCIEAER_CXL
>>   void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>>   void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>> +static inline void cxl_mask_prot_interrupts(struct device *dev)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
>> +
>> +	pci_aer_mask_internal_errors(pdev);
>> +}
>>   #else
>>   static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>   						struct device *host) { }
>> +static inline void cxl_mask_prot_interrupts(struct device *dev) { }
>>   #endif
>>   
>>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 2d202ad1453a..69230cf87d79 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -979,6 +979,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>>   
>> +/**
>> + * pci_aer_mask_internal_errors - mask internal errors
>> + * @dev: pointer to the pcie_dev data structure
>> + *
>> + * Masks internal errors in the Uncorrectable and Correctable Error
>> + * Mask registers.
>> + *
>> + * Note: AER must be enabled and supported by the device which must be
>> + * checked in advance, e.g. with pcie_aer_is_native().
>> + */
>> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
>> +{
>> +	int aer = dev->aer_cap;
>> +
>> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
>> +				       0, PCI_ERR_UNC_INTN);
>> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
>> +				       0, PCI_ERR_COR_INTERNAL);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
>> +
>>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>>   {
>>   	/*
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 74600e75705f..41167ad3797a 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -108,5 +108,6 @@ int cper_severity_to_aer(int cper_severity);
>>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>   		       int severity, struct aer_capability_regs *aer_regs);
>>   void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>>   #endif //_AER_H_
>>   


