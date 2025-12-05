Return-Path: <linux-pci+bounces-42703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDBCA831E
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E0633049C71
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4135292F;
	Fri,  5 Dec 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ub+qsnjc"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC265350D79;
	Fri,  5 Dec 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947732; cv=fail; b=AAEsB0VbIMkjtqL1XXs9o/WLztnJSoNllCTKpKjNh4rd5Kfm0LOCih7Zrm2XORmVZD3OX/bs775TXpAHbvZmTtuRmsiHL0gXV7Vjo3kmdD2cs3YkTXluNfhVrT6IpY/K11RNo+E8eN43TlE7JdL0RC0s/RTtAb3Vff9CG5cZDaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947732; c=relaxed/simple;
	bh=qDmArhEl8t6e3niL1zebdmYThwmFnX01xgxYfaZCbSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZtFYZW7oRR7xi+sk89GP0S4TM4uct1mKE/eZqnu9yDg+NXXdaR6cArndo1g6P8BS8nKMgF8xDUjRfFSB687CXR7S9J08//xQlYCpI5QqwsFaASEA7OaWIljEo22v5H+tpNYcjYXW3EIZ9XVKe+ra1MqCgC1P44xQ9vIRWFeqHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ub+qsnjc; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAHxzi1l10wyeXXbqAidkQdYksJjSohwzarqPVLJNNwEQvHBsD3G77uokGKJeRRfFSvORgTLKqYBV5c7DMt0XCTiiNESprFLoqPhLGa3GW7mU38t+oJgNGtChvYbakvRsJCTJKCPs2eXCfCLggYqA47H5M2IZAh7+wxN5PRpiFiW7at3mUpSkLxI0wjBpxP3iHwPvm9RTafdqKwmgA/ocMpGGD/JsNdCZiz76jEaz3HXSEm6pxWkV+GnJ85E3tWkh5DwNGw7V/XU1VLzNduR+INlu/4UgychamFP/goa5QWKeyM0/4Mk8wiR0I35WnGRFYLMIJwXED2SBLLXKCo8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzubDOpzX/5sKcTzeOetayB33MqujymUABNpJeBBcIg=;
 b=VvTAb+KuZeilyinRBBdhy9QLl4/jW0kebfHSJQBCnSXoDPs0O9G5Zjq10moKkAKU3jWllInz+MksEzmO/woelyTd9EghzhSrXAFrFQFUCDjrQ2fdqP9rzNn8xyWYrymBagiP6V/3JmNxZcXFOXRmVRHzH8p3pOQ7BJGIj4hHjOfB+tI+5H9T3WFiNcK91YdifuVnkM1QHJMJS8Be64jqTjmeMKtdRMMG/FZyY0mYLf3mBExEnFtFRoFqUvX7uMIOCl2feLEtxNhPVAbX2sJAXDgKdBUrmb9BGd1Ugld9+H/jjNu/bV3Zvd7yiSmd21lt20KPg+7Wrcd/5Spt+13Ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzubDOpzX/5sKcTzeOetayB33MqujymUABNpJeBBcIg=;
 b=ub+qsnjcLqDsFRE/fwmsw84HrymOyZEHathWCqVoxSUklvBgx2D8SZkMIWVcRYjTcUp55u72fAFSBC6qFda28txTJKXCxZItPsALYjmvbVox15vhW2nsjJIhq0m4oHtxVz41dITHm8H5wWT9I/bLgBNg9ND8WBXegpnTqaHpDvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 15:15:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 15:15:21 +0000
Message-ID: <143deecb-aa53-42e6-b7eb-91fb392e7502@amd.com>
Date: Fri, 5 Dec 2025 15:15:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] cxl: Initialization reworks in support Soft Reserve
 Recovery and Accelerator Memory
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Shiju Jose <shiju.jose@huawei.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251204022136.2573521-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0532.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe9324b-e33a-4ad1-81f9-08de34111b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlZIbW5JZVFsdkhkVmw2RUlySUJFNUR2ZTRNdmdhV2FoRnZ5eWhjVitwcyty?=
 =?utf-8?B?SVpCTENGaUljaUpTRW9TQ3ovUVNIcy80UGhvZ0FtcUxhRlpQalgzK0NTVFVO?=
 =?utf-8?B?MnROMnZrQ2NtdzJ6WnYzM2llUnpVdElacnZnQTBUYldWbzFnbThUZEIydTBZ?=
 =?utf-8?B?V1Y1RHU1QU9XQmJkN25nazMwdTgrR3NyaG8xdHdqMVBqUXZvRzhXdC81TzRZ?=
 =?utf-8?B?WTN4UEkrRFhtVFBBSFBlV3JrU21mcHhuWE1LeTBhU2ZUSmZadVNnR0MvT1dv?=
 =?utf-8?B?bGpYQzVoTFVQeitmaE1TTHkyUlQ5NGJYUlVkWVl0OXloUjFHVklBWUdWMTN5?=
 =?utf-8?B?WEJVV0ttUDZLL0RFWW5ZTUl0UnBNdTJkTkpMNGczWEJFWUdxdjAxOXo1OE9J?=
 =?utf-8?B?RGF3enV4TGtPNGNRdGtIWnhEZytQS2JTNDF4bFJsSUhySjA3NGYwQW5lWUxy?=
 =?utf-8?B?MW1YbGRSZzB6TkRtdjBOb2NqWXBmbW1BRlhjYnhmRnE5TVBlelI1b2lWQ2dN?=
 =?utf-8?B?VmVubE1GYkFtemtDVTJiekZTSmFYNlVIdkpCOWpnbkc3bEZYVzRhTHdLWldu?=
 =?utf-8?B?NjJCcURHdjZSeFNnWk10M1Y1clUwcERiZTlnZmQ0WnN3WlhmWkZnRFNUclRY?=
 =?utf-8?B?WTN6SW1YcWFQU01MUFdCMkUrZmJSaUs2UjdPb2xBcUs1ejE2YkZEQzZqT2ZL?=
 =?utf-8?B?RVE4cmhQQVNoVllYUE5kSFl6STFzTGcvWFllSUkwVTJIL3pvUHNQeWtXbndr?=
 =?utf-8?B?dzg2U0ROUE5aSjNLczdTTyt0eHlTRlpGRml5VG1tdERiQ012dmFHZGFCcko4?=
 =?utf-8?B?Ykh2OW04ZytyZFA2OTgyYmhCOXhYb2JtekFFY3RveTBvaCtKeGxFMFF4ODdU?=
 =?utf-8?B?R2UzUExxcVZrVWh2S1BEZENTU3poMXdJZWNCZ2FqNFhmQXU1M0lMUFRMa2cy?=
 =?utf-8?B?Mi9FdHptWVRXSXk0VldIMjZTbjRvQjNpTHJ1blVKVkg0NlIxZXJlblhMQ1My?=
 =?utf-8?B?R1FCRW9MK3NzZFNJZm9Lb0t1bXJZOG9yY3l5Y3ZLOVRZZS9LelRZTXFOMURB?=
 =?utf-8?B?MTA2Rm91NnJEdS91K2dUeTQzOVEvL1JKS01hZEVSWGx2dVR4S3F2bjBjN0xx?=
 =?utf-8?B?Z05PajZWenpNZ1plb1dwQ2RiRm9tdmZlSnI2d2NEVUlJelMvSlBaZHo1b0VV?=
 =?utf-8?B?alVCV01VNCttcUtjZWRWT3JFQ0U3Y0NIYUhBZE1VRlJiRm9EYlhkZFBMakFm?=
 =?utf-8?B?RnkrNFpBSnJXQnJYVTFQenlPUktOUjRxaU4yRENmKytPaFh3TUZJYWdkMmJM?=
 =?utf-8?B?THB0MFg1bjgxSlNUeWFOUDRxa1M5dVBQOUtNbkhPeEJISEtzM0IxWVhlaWRD?=
 =?utf-8?B?V1F2K2Y1NklOcHI3dVVDWkt4WWlwdWJzQXRYSnljeUVJN05hQi9SOU1IZkht?=
 =?utf-8?B?Mk9DTEV5a2NhaXBTTDN5cEhGTGQ1djRwQ3k4Rkkxc3owL0YxbjZ2ZmwzK3dR?=
 =?utf-8?B?TE9nSThUNVQ0NG5xWmIvam5IVDZZU2VqdWR3S25XT1NjUERxTXhuWHpFZDZ6?=
 =?utf-8?B?MW5XVFN4U0hUZTdtZlpsZHVqRjZyenVIWWFwcE5HWlRlanhXSE5kZHBlWThZ?=
 =?utf-8?B?ak9RNkdsMnFZdkZoUkF2dU12N0gyalNhcWhkbngwMlRWUDNZakNRalBIa3o5?=
 =?utf-8?B?YzkxS0FEZ1JqSzlVYU5jR0w4RThsdmtPZUh3dTJyZm1QczFmc3dRRkRMWDFE?=
 =?utf-8?B?aVA0c2cxZDErcUU4d2pvbzllTk5XM1ZKRWUzR1U1WVVNU01MN1h0OEcwYVhq?=
 =?utf-8?B?TitKVUxkRDNGdnNiSXBSZDhrS1ZuSUVGNU81QnlBektSLzNNT0NmZ0YyZ0Jl?=
 =?utf-8?B?OVQ1Qml2K0V6TVp5YWczSnVxYzQzOEk3WWZ4UnJvMDVDRE5CdGVwVm85blJ3?=
 =?utf-8?B?eWtUN1BxR2dTMXh0b3NPdkxGUzVnSG44Q3JvVEh0Q1hKSXIwNU8xWWFyWHVv?=
 =?utf-8?B?OUJBTUZldnFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnJ2b2hJNm9GamJRSndoWnpWeU9wNXo1NC80V284cWVadkRodGUxZjBYYlRJ?=
 =?utf-8?B?aDR5WERmTi9vTitsY3ViRGI0ZlhDS21MMkgxNnlxamFMWDZYLzA2Mk1jaGJY?=
 =?utf-8?B?NVI4OE81Nlpla1prNDArb3FtUjlSWThOYzBTVUNVbTQwek1CQVRFODdSelYv?=
 =?utf-8?B?NVNRQmMrVlVjWXBmSGNMeXVqYnIxSlFjQWtVOHVSSlhrbGRkbFErZGZtYjNT?=
 =?utf-8?B?d1RsWU95K3I1Zk90VmlHM1lZaDhMck4vRHhJUlh5UjBXNlpPeDVlQlM5TUk0?=
 =?utf-8?B?dy92TVBBSkllZjkrWnp0ZWNESENJUzlTZkFuS3ZWS1lJQ055UnIvMHh0ME5E?=
 =?utf-8?B?cXdiNmc2dkZGenJYVWRNOG1IaEt4WUI0aFUrSEdnUWVHQTFKaXlZcExRdmM5?=
 =?utf-8?B?QWR3bUpLbzFQdVJKREJhYlRTQjBSWkVqb2lGa2k1RmdTMVgvZ2gzYU5uYlcz?=
 =?utf-8?B?SHBtSXZNVFQ0NysvQi9rdG1UUk8zQ1JCMUpYVXhDeHgzdDBGYnFxK2hzRGlj?=
 =?utf-8?B?MksxU1ZRaE95UGJ3MldvckdiVmJpVFk0SWJBZmhRbUNOKzlqRkNrNVJ6QnFi?=
 =?utf-8?B?Nlc0cEtWdHZERXdEMjdudGlaWmMvYThCV3BDQU1UeXVseXB5Ly95c0JsTGhJ?=
 =?utf-8?B?MHdpeWpTMGpJbzRFODdPV0l2WlNKeVRCd0J6SGlFVmJKNXg4ajlYUys4M1VY?=
 =?utf-8?B?OFZobXJabjFyTFN4WXpFY1g2MHlTTlVxNkV2QnkvazVVTDRqZ0NtQm85QVl6?=
 =?utf-8?B?c09ZcEZWYXd4SXdmN0oyd1o2SmQ4TS9DUlZCejhGWDl1ZUFVdjBJT2VZRTlv?=
 =?utf-8?B?blJyNGIzbzhOby9BSThkdFA0ZjFiTVF0UkU4U05kbkdtY1h2TTg3ZkZMbks1?=
 =?utf-8?B?MFpZWnJydGJLRmlHcDdZMTV2d2NXVk16aTgvMVhBOGhJeWg2ckt0bWFlT2Ji?=
 =?utf-8?B?SFBLT3c0aWNYNDhaUmdIc09obUFJaHBPU201amJPUXBnb0JtY2dvcnlGRStw?=
 =?utf-8?B?Tm9vc0ZWVUl4MjBlQVo5WWxqbjVSVFJHdVFPWkVkeE5mcWRjUjIxNzFpWjF5?=
 =?utf-8?B?dzRDNXBndDIyeW5DOWtXczN1YXY4bFkzUVpaY2lmNVRZcS9qWUswT1pLVDFh?=
 =?utf-8?B?eGVOMkxnNjArLzhFOVRZZzloc3NPQnhSdTJQeEM3aFpaYUVldlgybjlFK09S?=
 =?utf-8?B?VWwwMnFIU0F3dUtiM05IT0JWMXZRNEE3ekN2NDJ3VFJwZ1NNYjJJRURGTnBC?=
 =?utf-8?B?dzcxZUxMVFJrR0wvVU9DWG1MTkdxWkVnelhTdmVLWG11N2UyNWlwYzQ0V29F?=
 =?utf-8?B?ZUVZUEk4T3FjeSs5blFyUWZyZ1NXTUphWjFhWDNiREtEUFExWVZVajh0blo2?=
 =?utf-8?B?M1MxUXpHN2Z5c1J4Nm84blZFOG5leC95ZVd1bkVOV3hZcjRhWVhRVmdEQWVI?=
 =?utf-8?B?YmVhYy9UUmxhRmVuVFQ2K0xicnduZ3BNRk9FN0hCaUh6THFRenFxTFRsK0hk?=
 =?utf-8?B?MWhFakRpb0RTTUlNNUpUYUpnYkNmMFNBOW1uZzJiWkVhdUE2clhDRk5zTFZu?=
 =?utf-8?B?ZEt1SHJMekhRRllWemVJOUpQaElNZEdpbWs0SE56VkpsT1lKWG01MHpkbXZw?=
 =?utf-8?B?ZUl1aFdlMmdSMlVvMk90RnRPVUpLNmp1VXNFNDgxWnVhWm1XTUxuaHJyOVpU?=
 =?utf-8?B?bkQwbVBNeGxyU1U3K2tlNzJXYTR3bTJTb0NVblVUU0NwczVNRXBkaE5EMi9k?=
 =?utf-8?B?K2FNelRId0MzUVVQSENTMjdpaXh1VUlmTk9VUDZmeC9PL05RaE1WUFYyYTZL?=
 =?utf-8?B?Uis5NFM2RDYrOUxwNHlxSWI5NlZIQnNBR2trVVRTRVN3ZlZ3eTRicGc1c1l2?=
 =?utf-8?B?ZTJzdjVFWW8wekY0YVBiS0tpZUhsSWxsQkdhWm5yazJGOXF2MGwzbzR1WFBD?=
 =?utf-8?B?VHB6dU1XZ0hKbER4alhldU5NSHp0N0o0bEp3TWs1V0tIT3pFRCt3Y3lzQkNp?=
 =?utf-8?B?Qi81SDVLQkV6Z2ZyamNHd3dCSkhEaGpwakpadWJhcUxyOUl6U3k0RzlyajhG?=
 =?utf-8?B?R0IvY1BVMEp4RU00dFFKOEFjOVZZVWI1NFdOQk9kbTZvK1prTWNNRFVrQ2Jo?=
 =?utf-8?Q?xcq1DTjxZdNAB0vxv2ODZo+g9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe9324b-e33a-4ad1-81f9-08de34111b82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:15:21.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj4VfbgDDK560d/G//jnvF9cShWswYZuD/nrCG8m467njoy9Vl1eTG6lclFyMSY3l+bc0KTOSO5GNh4Rm8BKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279


On 12/4/25 02:21, Dan Williams wrote:
> The CXL subsystem is modular. That modularity is a benefit for
> separation of concerns and testing. It is generally appropriate for this
> class of devices that support hotplug and can dynamically add a CXL
> personality alongside their PCI personality. However, a cost of modules
> is ambiguity about when devices (cxl_memdevs, cxl_ports, cxl_regions)
> have had a chance to attach to their corresponding drivers on
> @cxl_bus_type.
>
> This problem of not being able to reliably determine when a device has
> had a chance to attach to its driver vs still waiting for the module to
> load, is a common problem for the "Soft Reserve Recovery" [1], and
> "Accelerator Memory" [2] enabling efforts.
>
> For "Soft Reserve Recovery" it wants to use wait_for_device_probe() as a
> sync point for when CXL devices present at boot have had a chance to
> attach to the cxl_pci driver (generic CXL memory expansion class
> driver). That breaks down if wait_for_device_probe() only flushes PCI
> device probe, but not the cxl_mem_probe() of the cxl_memdev that
> cxl_pci_probe() creates.
>
> For "Accelerator Memory", the driver is not cxl_pci, but any potential
> PCI driver that wants to use the devm_cxl_add_memdev() ABI to attach to
> the CXL memory domain. Those drivers want to know if the CXL link is
> live end-to-end (from endpoint, through switches, to the host bridge)
> and CXL memory operations are enabled. If not, a CXL accelerator may be
> able to fall back to PCI-only operation. Similar to the "Soft Reserve
> Memory" it needs to know that the CXL subsystem had a chance to probe
> the ancestor topology of the device and let that driver make a
> synchronous decision about CXL operation.


IMO, this is not the problem with accelerators, because this can not be 
dynamically done, or not easily. The HW will support CXL or PCI, and if 
CXL mem is not enabled by the firmware, likely due to a 
negotiation/linking problem, the driver can keep going with CXL.io. Of 
course, this is from my experience with sfc driver/hardware. Note sfc 
driver added the check for CXL availability based on Terry's v13.


But this is useful for solving the problem of module removal which can 
leave the type2 driver without the base for doing any unwinding. Once a 
type2 uses code from those other cxl modules explicitly, the problem is 
avoided. You seem to have forgotten about this problem, what I think it 
is worth to describe.


>
> In support of those efforts:
>
> * Clean up some resource lifetime issues in the current code
> * Move some object creation symbols (devm_cxl_add_memdev() and
>    devm_cxl_add_endpoint()) into the cxl_mem.ko and cxl_port.ko objects.
>    Implicitly guarantee that cxl_mem_driver and cxl_port_driver have been
>    registered prior to any device objects being registered. This is
>    preferred over explicit open-coded request_module().
> * Use scoped-based-cleanup before adding more resource management in
>    devm_cxl_add_memdev()
> * Give an accelerator the opportunity to run setup operations in
>    cxl_mem_probe() so it can further probe if the CXL configuration matches
>    its needs.
>
> Some of these previously appeared on a branch as an RFC [3] and left
> "Soft Reserve Recovery" and "Accelerator Memory" to jockey for ordering.
> Instead, create a shared topic branch for both of those efforts to
> import. The main changes since that RFC are fixing a bug and reducing
> the amount of refactoring (which contributed to hiding the bug).
>
> [1]: http://lore.kernel.org/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com
> [2]: http://lore.kernel.org/20251119192236.2527305-1-alejandro.lucero-palau@amd.com
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order
>
> Dan Williams (6):
>    cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
>    cxl/mem: Arrange for always-synchronous memdev attach
>    cxl/port: Arrange for always synchronous endpoint attach
>    cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
>    cxl/mem: Drop @host argument to devm_cxl_add_memdev()
>    cxl/mem: Introduce a memdev creation ->probe() operation
>
>   drivers/cxl/Kconfig          |   2 +-
>   drivers/cxl/cxl.h            |   2 +
>   drivers/cxl/cxlmem.h         |  17 ++++--
>   drivers/cxl/core/edac.c      |  64 ++++++++++++---------
>   drivers/cxl/core/memdev.c    | 104 ++++++++++++++++++++++++-----------
>   drivers/cxl/mem.c            |  69 +++++++++--------------
>   drivers/cxl/pci.c            |   2 +-
>   drivers/cxl/port.c           |  40 ++++++++++++++
>   tools/testing/cxl/test/mem.c |   2 +-
>   9 files changed, 192 insertions(+), 110 deletions(-)
>
>
> base-commit: ea5514e300568cbe8f19431c3e424d4791db8291

