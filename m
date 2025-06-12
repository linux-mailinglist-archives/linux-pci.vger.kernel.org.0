Return-Path: <linux-pci+bounces-29567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17738AD7835
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E2F3A95C0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7EC221DA8;
	Thu, 12 Jun 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NTX8u8ia"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1C298CB2;
	Thu, 12 Jun 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745772; cv=fail; b=kDQFtIZXnDecs/j0dSrdk7hxlekfK+ssoydBHAc/aPtGAy1homoGjBzfqnGg9V15wO+Xcwo3Mv5YbG008KaCHM1spoiTvJ+NzJjf7LJ4VbxIZ3mMe4/C2X/WRdwY7mk8gczx1yv86LZrfdtIYFY9gx8dcjuL4XgEEXy3jAGULkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745772; c=relaxed/simple;
	bh=2ncuP4CnXkGxiXwKcPyI6n22NXEjciaWaKisttO7MjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcakcZgLbm1mC6Ov83DnAr+MqP0KIZFWFQWvLbN3MAjtVBqDt76xFKpSbjZ/eu1eJjq6bkZ9cqY5OxuGT+R9kg9mi/++2D3sRE8idEI7wskacdiDFslFHhOR3ardbNKonKMr+NDLZYnM6F6ngmEsBMYRlIvJMfATOllzfxwhPFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NTX8u8ia; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqttCBqENy1mBYtOoXZoZz1qH0jzWDlVohjWsLyp9ETM/Ypk0FUJZi+AkZfvsGFzt53LOnqhTNKqefhYI4umq2oxKka3UaHkdlW6J4vsCI7kATrz5kNXdOjowbS/wy/X6jB0wfKcW58V/RFDJN+aT10gzRyqcJV1cSfvUOr4SVCNoKDmTQHPY6hNLZxyi9VAvor1lJOJpBICcZ5XU+lPl6NzILLj77/c9gkVwkYWvgaKajbSvx6lcpfkePAO5JxDnrIDQDbRDiyLngGKsMfY0iyleXq+XrHzMFYxBgXCedfi+1aFXggWwZtjp1B9mZp2bq3GhgIKVoUt6e57v1gE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q5Ryt0i0Itd9yfIE5s99s9FHEyCbfgGGKjBMdlMI0o=;
 b=lweAYaXj7E2x6ohY26udS+F4HL5ntAbfutwnVDRppgdirElNR6DysM+V7RAGZ/rLCuqI+w40tk2IdzmcepnnvalDS+PmZOFZwPMN0GUUWwZk8+P7yeLaANANTEVNT//LyP12TgVU5aorKt8q1018BAFfSuuD12Cl4A+MVH/JToNUUhml7p3aG/tabUYOvcEslyPNofE1OmVI6ywG9jxvpMnnFBuj77dWJC8g8cvp2mDoZ0BNO54X2Q5XbUdkPg1023qlY52dIDWIevcdqGYHV90+4gLeS1ZzEEGBU8vVKTcBG1GqRoJsFLIP0fb1mAZ4xU5u6u4Tvi1iAJHl4pu7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q5Ryt0i0Itd9yfIE5s99s9FHEyCbfgGGKjBMdlMI0o=;
 b=NTX8u8iadgJkPWGoaZjb/qciA/efChOgLzoC6o6bFT68Qk+/C3RHtnu5HEzQjHCGgybKVYwTsKGE5JJlSNu9wV0m2E1f/W4N0oE94io8sAKT3broLb56HFyi/lhtviqcC7bKoHIBcD4gseGgQRZuUjUNNKUewMbexaf17YV1MTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 16:29:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 16:29:27 +0000
Message-ID: <ebfa2c44-7a12-4d73-81cb-5d74e99163d8@amd.com>
Date: Thu, 12 Jun 2025 11:29:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
 dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
 kobayashi.da-06@fujitsu.com, yanfei.xu@intel.com, rrichter@amd.com,
 peterz@infradead.org, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-6-terry.bowman@amd.com>
 <20250612170622.000071df@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250612170622.000071df@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:806:d2::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb78f91-ca13-43fe-5443-08dda9ce4c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTVLVGF5aXdjOElQRnh5SFNPRGpnZjZjSXhGeGhYS3RnY3BBWDNadVdFVEN5?=
 =?utf-8?B?WHpHZ0dCaEhHbTN1c3dRaFNya0Y1N3kzak5tS2R5UjJOZHAzWldVYVJOcEVW?=
 =?utf-8?B?OUJEb2N3bnY1dktSRExzM0U3RjVjNFkya3QwOG9hNlgxbFFMMHlFOEYxbUkz?=
 =?utf-8?B?RkFKdHo4WkZiR0w4WGdZaG0zNGVqYzhXWVc0S1dxWDVnNEhKV0RBQm14cUUw?=
 =?utf-8?B?RHRPVUdEUVFGbUg3SzY3cy9DQ2Qwazcvc3pleWZDakFhNVhhamlyaXRWaW5D?=
 =?utf-8?B?NVp0Mzg1V0o4aHZiWDhUeVh6WU1lSm8rS1dmNFJWLzlmaWVUcWk5WUdpK2NF?=
 =?utf-8?B?NXczdWx3cXcrMCtkVERab0M3MGszZXNFYTlVdThMWkoxRDRTTjZiazBzdnZW?=
 =?utf-8?B?UmZZTnF0L2VFMGo0dHRpQ0VIeHpnYm9adUVoWFRnazZUemM0UExEdlc4M3JN?=
 =?utf-8?B?Qzg4amZVRnU3Ti8xQ2drNVhVVktRMEtNRmIvWFpjd3ZKaGpkQ0VXM1NrdCti?=
 =?utf-8?B?eWFCY2t2RERZWFFhN1pLTUJ6SjRHZkJheW9GVk9jYzg0dnMwNHN3RjFtcy9E?=
 =?utf-8?B?dkRNMGFRMjBFYUUzQ0hWTi9yZEVCVlNvd0VxRnFPLzNTN081OUdVT1RIVzVQ?=
 =?utf-8?B?UVo4cGR0SHgxdVJQV095bnNXMlhlbzVLRHZJNU52M3JKam8wdTRFQXZhSUZH?=
 =?utf-8?B?VGlQU1l1a0JUN0pIbGFxS0FaSGlkZmVLRHpqUURKbnpnZWNmVVlMSmdUSGQ4?=
 =?utf-8?B?R25LS013VU1sVStkWWZIRFFudmQzQjY3OG9qMVlYYmJQM2c0aUdkTkdKbzlD?=
 =?utf-8?B?Zk9DSnRDU0pXOEdKRlk4b0Rmd1RUMDU2K01xeTBwVngwNlNRWldGeHVWNllr?=
 =?utf-8?B?Q2dpdW5EU1VTMzhMMnVzVW1WWGszR0p5REdZSjFrK0R5Q055YmhmQTB2SWFB?=
 =?utf-8?B?aFlYS09sQldiK2k3MUZqc21xOVIwVzArNTlIRzBSNEtnN2pTT3BNQ0x6U0NM?=
 =?utf-8?B?OFZDN0VPT1pUODhxK21jcEplVCtaSXFDVDJ1TW5lc0NRbUtlZDN4cis4Witp?=
 =?utf-8?B?NjJROHFkbVF0YnZGb1B1d2crMTY5d2NubWVWVUxYV25WeC9FSnpOdmtlM3kv?=
 =?utf-8?B?Z3NOeGYwSXltSUhLL2RoRnJ4L3RrNk1nakJmQjZqaWw4VjM5Ym83L0IxNEw0?=
 =?utf-8?B?a1FoVWd3a0lyWk1RYkdRNmJWam5Ya0JtYTdrVmwya0lCSEpKV2ZGZC9JY1FT?=
 =?utf-8?B?MnZQTHhCdXplazU2ZDErU3lVaFpTUFpDNXY5Q1ozaWhNZHRRZk1yS1B3MDFP?=
 =?utf-8?B?SmNWTzUwN2NsYkViL2RHRnJvdTNsbThxWitCZm9BMnZxMWV4NGxHQTdUSE9l?=
 =?utf-8?B?YWRnTWx6MGtnbWpteG1SeWZGcUJXckhSOTh0a085dk5oYzBsN2JCc3hnV3oy?=
 =?utf-8?B?S1Z4aC9hVHlBa25ndXplczVQcEVIdmtiYW5CcnlocS9acnh4OFVENlBpbzRD?=
 =?utf-8?B?RlRhRk9QQzVEWG00eVlxdXczQi9STmpIZXcxZC92TWEzd1Radiszb1RERDZW?=
 =?utf-8?B?Z0ZGVnZiUDVtbmxMWGR0RCtWM1U4M3VJdmdUMEpvY21hR0Z1QjJURktnWS9Z?=
 =?utf-8?B?OHJqQXBhNEQ4NVNodGRvQU92THNnVXVqUE5OamdkVTRpd0Z1dUR2c0wxTnlj?=
 =?utf-8?B?MUovQUVFakRnS01UeC9zRWRPRVluQ0MwWFVTWXYrWUhHVGdSZVNNWmd0bjZi?=
 =?utf-8?B?VXNBcUlXaWk5MTVBUi9uRVU3UkV3OUFQTW9EdEFtVWtGb05jdm41TGwrQWY3?=
 =?utf-8?B?UktXNlFBMFQyRmI0OWlwSEJ5UnkyVHNtOFF6TmZjNDh2aXdsVWloOE5CZXRQ?=
 =?utf-8?B?TEx1T0x0S1h2MUx1WE83SE8wOEtzK0JaYXZHNXI5VmI2SkkvOERFRXBJZTVB?=
 =?utf-8?Q?vVZ+2hPm3Fg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STBOR0dreUlCbFRBSW1GS09mWnRUVjhHRDY0akIrUTVmbmdnUVJsc1ZjRVg1?=
 =?utf-8?B?K3B2VnN2ejM2V1VLMDlGWXFQdFFHY0NvL2RZMFVHblJ3QWUwYmc0WFN4SDQ4?=
 =?utf-8?B?RnBQVlc4U1JtSWc5YVdSUlJvbnRZVTRNSG8xbE1aUlZ0ZlhVVVJwWHdKNi9y?=
 =?utf-8?B?Yko4Y29Fa2Q3UW1ZWG9PL3pEaGpkMFdrNHI3NG9Oa0p6b1NuWVlUTnR6NElR?=
 =?utf-8?B?cXdjbVlEYVkvVUFRd3d4MHF5QUUyRDAyb0krQ1pwNmFJbUhHSlJhOWtsWU1E?=
 =?utf-8?B?N1ozSVJEY2JhUWhHMHJjcDF0N29IZ3RDTmg1VVllUXNCNlhwbGhxZkZhN1N6?=
 =?utf-8?B?NmJhT0NKNnBzMTZUZnlvSnlac3p3TWhGOFltV09vVXVQY2loN1JEVVMwQzJa?=
 =?utf-8?B?cnFMRGdtUUIxWUxOK1ZPOVVDVTVuZjZ6d01DdEdwcFk3TVVvdXp0VFlNRFRp?=
 =?utf-8?B?SlpXaHZqS2k4YU5zc0xoZElhZzMrVklmekxucDUzSjc0TWVpcTFwdVJRWnU0?=
 =?utf-8?B?WlpiSklzNXg3a1VCUTMvaUt1VXJqVU9WR3Q5NlR5b1k2eU1TN1FZckJIcmRT?=
 =?utf-8?B?VlEyNGk4bHNBNnBOZVd1ZldBb3lVNE5WWVJHN2tIYWQvSEYvY3k5d1JGM3Z1?=
 =?utf-8?B?eVlkQkhkY3cyWmJjLzBxN1lVSWN5MzVLVVNBSWpDbHpWSjllczdUakdVQ3NO?=
 =?utf-8?B?Vko2ZGRsSXhOaXMxck9pellxS2hnY1BqRW5TclIvem5BNk83diszcWl0SW9j?=
 =?utf-8?B?RG1HSm5TNGtLQm5BN3BuRVVFVHBpTDhxTlBYc1pTRXE1VlRudmlDaDdQL3F2?=
 =?utf-8?B?UHc3VDJRWFRuaG0xNjFEV0o4WGtJNDlsdU1VaUtCTUdlMzJFMjV4OWdCdWpT?=
 =?utf-8?B?L3JEV2dJb2EwSTNjR2RUa3dQR0xLdG0rYWtVVHpMZHlHTnYzckRWbG9JQmNZ?=
 =?utf-8?B?MVlVK2xkSm4yVTlHcTVOdExGRS9wTkVpaENINE1ZNlBZMlMyQ3F0RTVhZDd1?=
 =?utf-8?B?SDd3RFpTQ0J5NWtMR3l1ekVrWXNFa05jeUpmb1FKN3UrdjBNQjc1ZDhQUVE3?=
 =?utf-8?B?c25oS0FkVnBCWlYxR2g2ekJseXlHbThIMDM1SFBvOHRuZjdWaFIzOExqMHQ3?=
 =?utf-8?B?V0swTE9BbFUxMXZPVDgyNmFWQVI5WGc1Nm5QYXJ3YXdSRVVNMnRqMjRoQTBj?=
 =?utf-8?B?eThueW9jQ3VzSmdqMzBFekwxOGdEQjhoWW1sR2hvdWRLWERaaTNmaVhYY2Ja?=
 =?utf-8?B?dWVZWDBxR3pxYXlNK2JCVGhldFYwUlhnRFROSFUrQ1RKbjVyVjVRSkdQM1JO?=
 =?utf-8?B?Q2RTRys3MGlFWmtzdnF6ZDQxOTdnQ2o1bXVmakk2ejBMa3VrNmxzZnFqSEd0?=
 =?utf-8?B?UnFpa1dmVHNZWWt5cTNOQmdkWHAwZVluQlBrOVJJWjFESUtyZnZtMnZ4T2RK?=
 =?utf-8?B?emRkU1h2TkdWWkpqVFd3Zkd3R1RVeWk1UVNxN1QrLzh6bGZ0MEZSd3hTWnNX?=
 =?utf-8?B?OGM5cmk1NUNwQU1Eb245ZkRINUR1OG1lR1NRd1F5bG1OK0R1YXVlSkt4K1JK?=
 =?utf-8?B?UlR0MCt2STVYTE1jRTZoNEFCZDNlUnFEbDZSZWVleFlvVVh2VWFiZytaemVQ?=
 =?utf-8?B?MVdzODA4ekx4TG1jc2VGZmZBSUk1UEtDSm1qN240T21Lc1F2Z2c4WXdhLzJQ?=
 =?utf-8?B?eGszaXc2dWdmaHphTG1uRlh1UVRJMlB3enhlaE9ML0xJNUYzQUpxZWxUWndF?=
 =?utf-8?B?RDJNTHFFNTVwVDVCUUVudU9iNXlnWWgyd3VnWVREQ0NvM3dHMkd2a255aTZ1?=
 =?utf-8?B?UEVJZTNQcDNQNWhxSW5XT2RFaXpmWkQwQitMamJxMGtNZElwanpVblB2T2Zq?=
 =?utf-8?B?NmIvREtSOHk5Z1lPZWN6Y1l0N0tabnE2UEc4alZGb1BCZjFadWtzMzlqRHNm?=
 =?utf-8?B?MzZIU2VrNGFSR2Z1em9TWGo4RGtkcjlDOVlMQnlSaU9yQmVPeEJqUmlEcXFS?=
 =?utf-8?B?c3pHMit1N0pOa0JrQk1udlpWMUhkN2lHYzFVbi81TnlWSmo1VklTWkJDT1dp?=
 =?utf-8?B?b3Q1QW80akM4RnB5dnhXbllkMFg4a0RLR0FMNEZiTGZmalBYeTEwWTlaZGRY?=
 =?utf-8?Q?Tvj1dU8u9UWS6QA3/zN24v7uI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb78f91-ca13-43fe-5443-08dda9ce4c6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:29:27.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEw7maodOW5C88pAISkLOxK9InNxVayPo4iVcsH6pKyCD2NEuh6WHsro6KRhITOkHcW6xuxLELHQsrErs7Mk7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330



On 6/12/2025 11:06 AM, Jonathan Cameron wrote:
> On Tue, 3 Jun 2025 12:22:28 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>
>> Copy the PCI error driver's merge_result() and rename as cxl_merge_result().
>> Introduce PCI_ERS_RESULT_PANIC and add support in the cxl_merge_result()
>> routine.
> Do we need a separate version?  PCI won't ever set PCI_ERS_RESULT_PANIC
> so new != PCI_ERS_RESULT_PANIC and the first condition would only do
> something on CXL.
Correct. A common merge_result() can be used. I'll change it.

- Terry
>> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
>> first device in all cases.
>>
>> Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
>> Note, only CXL Endpoints are currently supported. Add locking for PCI
>> device as done in PCI's report_error_detected(). Add reference counting for
>> the CXL device responsible for cleanup of the CXL RAS. This is necessary
>> to prevent the RAS registers from disappearing before logging is completed.
>>
>> Call panic() to halt the system in the case of uncorrectable errors (UCE)
>> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
>> if a UCE is not found. In this case the AER status must be cleared and
>> uses pci_aer_clear_fatal_status().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h    |  3 ++
>>  2 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 9ed5c682e128..715f7221ea3a 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -110,8 +110,87 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  
>> +static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
>> +					 enum pci_ers_result new)
>> +{
>> +	if (new == PCI_ERS_RESULT_PANIC)
>> +		return PCI_ERS_RESULT_PANIC;
>> +
>> +	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>> +		return PCI_ERS_RESULT_NO_AER_DRIVER;
>> +
>> +	if (new == PCI_ERS_RESULT_NONE)
>> +		return orig;
>> +
>> +	switch (orig) {
>> +	case PCI_ERS_RESULT_CAN_RECOVER:
>> +	case PCI_ERS_RESULT_RECOVERED:
>> +		orig = new;
>> +		break;
>> +	case PCI_ERS_RESULT_DISCONNECT:
>> +		if (new == PCI_ERS_RESULT_NEED_RESET)
>> +			orig = PCI_ERS_RESULT_NEED_RESET;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return orig;
>> +}
>> +
>> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
>> +{
>> +	pci_ers_result_t vote, *result = data;
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
>> +		return 0;
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +	device_lock(&pdev->dev);
>> +	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
>> +	*result = cxl_merge_result(*result, vote);
>> +	device_unlock(&pdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>> +			    int (*cb)(struct pci_dev *, void *),
>> +			    void *userdata)
>> +{
>> +	if (cb(bridge, userdata))
>> +		return;
>> +
>> +	if (bridge->subordinate)
>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +}
>> +
>>  static void cxl_do_recovery(struct pci_dev *pdev)
>>  {
>> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +
>> +	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
>> +	if (host->native_aer) {
>> +		pcie_clear_device_status(pdev);
>> +		pci_aer_clear_nonfatal_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>> +	}
>> +
>> +	pci_info(pdev, "CXL uncorrectable error.\n");
>>  }
>>  
>>  static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index cd53715d53f3..b0e7545162de 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -870,6 +870,9 @@ enum pci_ers_result {
>>  
>>  	/* No AER capabilities registered for the driver */
>>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>> +
>> +	/* System is unstable, panic  */
>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>>  };
>>  
>>  /* PCI bus error event callbacks */


