Return-Path: <linux-pci+bounces-29109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2476AD07EC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830E63B3427
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3F433A6;
	Fri,  6 Jun 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IE4Lkft8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0C18FDDB;
	Fri,  6 Jun 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233695; cv=fail; b=JjFUzoEChQLff1CwJPsqINfT8WwfXzk0KeTKJnNbIzxqCrIWDU8FZsqzvrdGfxDqdwumVCHqQdqiisTxGBBCeFsdIfvuW2D9nx/ICF5k0X/FO1L8b5hI++iPLLMeojRzFBD+lQFgJtB0le1FB0uujK9Y36f4Rzsom17LA92tbVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233695; c=relaxed/simple;
	bh=Ab+xoZ/2PsyLfNWdIFncTlpoMLBqKRDPscj9cb5SI2E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mr+YP8HNuWboprKNFrWaV1K4sG7SqSaVLiA5tkdwMh6htH0fEtKESQsQ4EXhOT6Nb11BqBS3qknKyLdBeUnW+v6dIgByk9U7/QIsnJ2oyx71dH1knr0vYvt84Ke7fe3vaUieziOI4SiIKq3s+ikBOImzmA/L1/kptbEQaDWDwPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IE4Lkft8; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoeEyXy6dWo+dO+TDCTe3Cc87f91Si+a5dh5tOiVa7ZHdU6rn7Wolpl62S2TEpvTIinOZjhWn4VouWh02KcuVFryVJXdPcvXawum4F5SwCTloWmcSmHdnJKWGvBcBRfHcZ/ugDI5fwIDaDwiBwb23rXgdAXkGHFraZBVbW5Bsz+Kl+MPr7su44cy7MDK++BSSwLZCH8ysSB3J4a2ecRw0cvCwSLLdrVhxypdh7UETydHW3GrskDC6UbGDJffmHLrYSjJqx5XnHQhK3JEw99hx04mgw0p0Cosk89ar7KcuHBOM+rjAE0/nGQRhQvg0iK21MeUxtgy5DRso7S79QcjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmVqXs6t1KgOamZzm6t53+F1NVrv24m1Jn1oPrVXPic=;
 b=ZePdrYGmRW9kdfipeItPrHmSt7eTF0388zc5GeaFEjaw51xDCCgO+pK+zMA7+hNymwDZZdhjG5c5tK1jo6Rvuby5Nt+GwCFAWcMHOmUT76Mgv3rwS76+GXQ7n1QYg5y1Xdu04lY5qpxy701/XUNVzl7g6c4gD4nlXNqKjArWfO3SFFqiGTPA92M215f06CjqDjIN0HV5wTUd+Cz4W53sLJynWvydDidOdxKWUEZBsjHbiSTyFiOipdCCVHix8w68dxzAZKQOmvpkpkmMvsKfGUbzwf7VZMIBMQ3XZk5ynWZvUNz3qpF4oCbbs5tuKDKhVwjWJyNdsJexEvM9puuU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmVqXs6t1KgOamZzm6t53+F1NVrv24m1Jn1oPrVXPic=;
 b=IE4Lkft8gJciZ38f3eOwG0TjYUlvtFD4bS0FpnY6aguP/2ICCeBqvpOvL52ut544Stp87+TqbKqh7Xx4Qx4TeOqzzal6MnrpR+K6vMR9HulFfADl+ryuh7u+YZt3oSeEO2xbvevXbCJf5S/hayY8iUGxuj+IF91HaYuTIljv7+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 18:14:50 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 18:14:50 +0000
Message-ID: <c013da01-dc6b-470f-9dbb-e209e293763a@amd.com>
Date: Fri, 6 Jun 2025 13:14:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org,
 coly.li@suse.de, uaisheng.ye@intel.com,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: b0acc82f-9dac-4602-6852-08dda52606fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjVYNy9nd1FVQzF4Nm1JZTR5STRLV3hQQ2dQWlJac2dZTVlPUTlmWUxqaFBj?=
 =?utf-8?B?bE5PQy9jb2lBazRob0NQY2dWZTJmNENZcFRhaTY2SE5PaUR5VDU2cEtVOXdv?=
 =?utf-8?B?QjZzNlBoMXhRdkp3eHFtWkUrb0NhNDY2OEorQlRXaEJISWluUUVBNEh6ai9G?=
 =?utf-8?B?SjFLR3NBTldZamc3d0dqdHdWSUE1Z1BldTRYSDhud3NhdkRRMXhrNVg5cTlt?=
 =?utf-8?B?cURON0FEKzI3R2p4WWxxS0U2eDJGaHFxWGdXRWVRcXRjWXltV2VFNFVqR2Jx?=
 =?utf-8?B?VzJSTXAvWG8xNjFUUTByNm44bUovSStqUmg3ZDE3TFVVNWtlYnZIRmdxNFVC?=
 =?utf-8?B?d3VUTFRNZEZjRE1hdUczVmlHQTR1NVd6RVlIcDZmdWR2QWw5K2pHMEtWbjBL?=
 =?utf-8?B?c3piaTB1NXZPUTVTZTkvSU54OElBOG1XcUxZRjZVT005dTBGZnZ1bkpqVTYz?=
 =?utf-8?B?WlVtMnFlWlA2QXZ0bzBLM3JtdDFSeCsvS1ZXRlJWQ243QnZHTzhNRlpFRlBq?=
 =?utf-8?B?MWxrUnJUK2RJczZHTDJXSXU4M2hqVEc5eVE2ZFp3NmpmRSt4bGk2SWVRd3Jh?=
 =?utf-8?B?dXJTS0lNSzhCYkZQWGo5c0QyUDBMWkp1ODMwZ09sREhTblcwM0R2MStSejB4?=
 =?utf-8?B?NVNaVDh2RTZvY3lSUEZSQ3RjUkpZaEsrSUs4UXBIWVE1VExvaEZHQ1UweTdm?=
 =?utf-8?B?V2g3L2xaOVlEeFhsTjJwN3BTbUMxSDNyT3ZmYmEyWTdRTGhLVlkrNUNOZ1RT?=
 =?utf-8?B?ZUhrQmZIbEtQMTc1TGhWdUY3UzI4SG5BM1hBeWlFR1FVWC9xalNCR0ZZKzV5?=
 =?utf-8?B?MGlOYTBwQzdWN0gvbDdvcTF6SXhxRkNRMHZOb0hoeVdxV0l1SEo0SjdEZURz?=
 =?utf-8?B?ZTdoTktYcWk2UnRQNWlZSFFxbTNEamh2ZFFrcVl6VEJpZGUyM1RWQWxGaVA3?=
 =?utf-8?B?VEoySitiRHRVeDE4Zko0Um5UQ0EwaldNdnFLSFlXV1AyMmttbHJ4UFpNS1cr?=
 =?utf-8?B?UDBsSVkxZlowRkRMU0VwempUZnhRcWZtWS9HUmE5NFlkUmdEcGJCV0ZMaExT?=
 =?utf-8?B?TnhkVi9BYkxqa0pwRTdrQTZ1dEIxL1haeWt4T0lpdnIrb3pPS1BFZlkvZzl4?=
 =?utf-8?B?OFM1em5uUTc4M3JFVEppL2Vyc056dk5uMmZBeC82Rk9xZE5NRWg1WVlpOENG?=
 =?utf-8?B?VjJNMmRsbTQxRENSYmFUMjVvWFNPT0hialBaeUo5TVVoME9OS2pUTHp5VWVW?=
 =?utf-8?B?WUFYM3Y4MDFRUTd5RTJ5YUFOSk12b21qMmE0WTgyYVN1RVREVHBNa0RjaTJi?=
 =?utf-8?B?Z09FV2NNV3hQZnV0TE5GL3RFaDljbW5vT0lYT2h2TU5rTWw1QzI1V003S290?=
 =?utf-8?B?WE92UmpjRHBaNHlMcWNSTGpzVVBRRVNpK1VkdEN1R1dMa1AwdW5KdjduRjQv?=
 =?utf-8?B?VENVTitIUjBTc2VReUNlaWNaZytWOFZBTVRnc3Y3LzBvcElvcFh2OFVTSC9V?=
 =?utf-8?B?cUZzelF1aCtNeXlucWhHNmJmOUc0N29ZdXpIYlVTUDJya2ErSFN1N0Z3TFIr?=
 =?utf-8?B?dHlMcEZwTTEyVXZxcUdML2JmeURSNEVZTUlZd0ZPM1hPT0Fvdk5aR2laZGhQ?=
 =?utf-8?B?anlvYVJBVGNqUVNHdEU2R2hYQkNrQlFOWTYwVkFmdUUyY09iQTloLzdpaDI0?=
 =?utf-8?B?L21RRmRlT2dKdC9uL3JteFNvbGlVY1RPUHV2YXY1c1J6TzRBTDBVVmQ0NmdP?=
 =?utf-8?B?Tjl5Z3hSaDcwaC9OWWg2TDlFckdhdWRUam9RM3NZWjBUR3VXazQxdkRSYlZX?=
 =?utf-8?B?UDF3aWhDTkZQTDYrcyt5bVZGZDNRZE5TMS9FNHNYaENCVllZQUkyQUxQODRS?=
 =?utf-8?B?QkRuU0VKeE5Bc2gxb2s4TjhHakR4Qklkb2VvaEd6ckprdXByMXhKVmZZRFBq?=
 =?utf-8?B?UXZ2ZUlMTDN4TURxaGY1TEZWanhNRE0rVG1DellJOGtnUFlPNWl1SlNMWm1N?=
 =?utf-8?B?Z0lJRUU2RDVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmRQL01HUTVIRTVhNVFhaXVQZEVDcTYrdjVZU01FaGRuTFRJbnBuNGVYVlds?=
 =?utf-8?B?bGk1Q2drbVFVT3hYNU56WlE4NXRmOXd0MmhHcDhrSjBINVhKbGFVTTB1aGVW?=
 =?utf-8?B?bTA4MVAvd0RnMndhMVNraEp2TC80Tmg4Ulp5UzZCRDIvNE5SOWoyRUVlRDVW?=
 =?utf-8?B?dVA5K3JiUkFKYVJDOG43MnZJNTI4WmZ1Sml0c3BWWG1DNGY3Ylh4TGk0dUhW?=
 =?utf-8?B?LzQrRVM2cjZzTHFMV1BURVdOb2hDODNrbk5yUVlKa3lUeHZoK3lCQTdHQ3FK?=
 =?utf-8?B?NHlFNGxPSTB3ZUprektSWjFrVzB5THgrQWVLUDJyL0gxVkp0c0JPbzJVRFRS?=
 =?utf-8?B?eXpCN3JsMUdHNkRQcHYyaXFsOWcrT3BMMlQ0Vi9GekFYVEVHWWxnN3VKdSt1?=
 =?utf-8?B?NHR5eEY0MWxmcm16eW8vVlFUTEJGZThmUHczd3V2TEVxSFFQYlo0RitPVTBj?=
 =?utf-8?B?TFlXejBuKyszdng0MEU1QmxUZ2V4enQzTGhZRlpSSjZFTm5sM3BnZjZmZlAx?=
 =?utf-8?B?Ym5hdm1BMVVHMTVyWFB4UDQxcHE1QjNQY3lBZGlYdjB0WUN1YVhkTjlTSmpp?=
 =?utf-8?B?NzZxaHdZOU91S0IrbllCNnlKcDBTb3p4MmF1RW9Sa0dwcTd1TjhYWTJRTWlH?=
 =?utf-8?B?T240WG13RkI0TlhVUjZxS0l1ZFZIV3J6cjN2SSt2b2tzU292dW5zRGcxSS9w?=
 =?utf-8?B?NzB0UVVTY1gvWi9tNi8rUncrZDF6QW45SDBkVml4U21HWStZUCt6cHBycW9L?=
 =?utf-8?B?OVllOU9kbHB4MTlyOUlkUVVHOU9Da0ZQMHpUTVkrVDh3aENQcXk1SXN2dVlE?=
 =?utf-8?B?VmJRRjVyMDZSNDF0eXBXeXlRQlg0MWRMKzdtN1FIODZrTlNQaWJVQUpxRytS?=
 =?utf-8?B?OU00SFovUkZ1b0ltSVdyS3ArejVjQi93dGRBdGVQcW4wbHY0Y3pHbmtPOUNL?=
 =?utf-8?B?NDNVRXF0Z0ZIUnpET0g1aGFsend5VWZhWXRWM20xQ3Z4VXhCY1hidU9HTjhQ?=
 =?utf-8?B?blNra1VLdVZyRDluL0g2WlpwQWFaWWhHVnRoRW13Uk8vQ2NJNUcyMm9EUCtl?=
 =?utf-8?B?UWErR2EyOWk4OWdoaVRqWVc2VkIzcVRJWFM1UnBGMDVqai9YeW80VEVyRlFO?=
 =?utf-8?B?dHp6ZS9EQ3lucTdBVytHMXp4MzFTTldLUmMzakVacTEwdEJRcWVWVlNaNlE4?=
 =?utf-8?B?eU9FbDVzTFYwOW50UmJzNjNGMlpGM2NWc3ZBTDFRMUpIR01YTlFvYUw2ZGJU?=
 =?utf-8?B?ZU1uTEpZUk5JMnNRdFFnUkZIbFd3RTMwdHBXT3Nhc3o1ekFYY0h5TlFiN2tH?=
 =?utf-8?B?elowZytnYlc1a2lqc0tHRXRVNUJtOStibjdrKyt6WnEvdlpkRSt5Y3djQi9G?=
 =?utf-8?B?SnJROXdVRHMrdFNjYzE2WUxHbnQrSnBuTlRQVnRTNWhLRmVUazh6NHRCeVJ5?=
 =?utf-8?B?SFg0a1VjOFVwSlFDVktKRk1KK0REcWkreXh6Vy9vbmZ1M1VtMjNnWGhqRWlF?=
 =?utf-8?B?QkFZYURCcytFbVlCcDhOTWNzZ0FUajVEMGgxeGwzMFRVN3RsOEFra0tKVWZI?=
 =?utf-8?B?S3kzRjFLSmNrRThocGNvd1VuRkJDVUpjL3Jjekd0Y3d6M2xLakJLemJQYlpy?=
 =?utf-8?B?WVRILzM3Zno0TzBwS2xNby9laWtkYkh0a1FBRjNsRnlzUS9jL3ZhL0QzbWpY?=
 =?utf-8?B?K1dXMk15L05NUW5wWXVmTEFxWFdoSGdlekJ3dk1TQWdCbHAvakNuRENqWEtZ?=
 =?utf-8?B?QS8zSEkrazFRekltVm1HNUc0T09Sb2xST3ZPNnhsTFFwSFRuQ0dDRjM4RVdJ?=
 =?utf-8?B?SEpvZ3lLRmdmVGorVEZheUo3T01RbTI5U0JpRzUyeDF5Zm9pTVArY3pLL1pw?=
 =?utf-8?B?YUhDcXdOVkZCdFVMVGpUdit6alRVRGtlNWJoUUpFUFJvRTNkQVY5aE01SGha?=
 =?utf-8?B?TzZiVnVoMitvdVpDVjlUUjlHV0ZvMkZTVzMvcFEyVUVJRzBHODcxMXlOSGdS?=
 =?utf-8?B?OW9taWs5TTE4Ly9WOGs1L1V4REE4VXhpWU9kcktIbVdrT2gvT25sSEZGUzlP?=
 =?utf-8?B?QVBYM1RRZVFTT2JZdTJCdSt6blBPa0dVbUYxMkNCdjJGWHRleDFEZTByTVln?=
 =?utf-8?Q?3kRYd/kWNuhopNaWzJA8JSdKe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0acc82f-9dac-4602-6852-08dda52606fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 18:14:50.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3ic4JIc/ePfr9OGHEbVKZYqb9fAQ1FfRGtse8GT6iE0WuZF9FHnAXcgSclg8zdhcMS9Y83k4YtgTbaAfec3iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065



On 6/6/2025 10:57 AM, Dave Jiang wrote:
>
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> The AER driver is now designed to forward CXL protocol errors to the CXL
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>> error handling processing using the work received from the FIFO.
>>
>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
>> AER service driver. This will begin the CXL protocol error processing
>> with a call to cxl_handle_prot_error().
>>
>> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
>> previously in the AER driver.
>>
>> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
>> and use in discovering the erring PCI device. Make scope based reference
>> increments/decrements for the discovered PCI device and the associated
>> CXL device.
>>
>> Implement cxl_handle_prot_error() to differentiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>> RCH errors will be processed with a call to walk the associated Root
>> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>> so the CXL driver can walk the RCEC's downstream bus, searching for
>> the RCiEP.
>>
>> VH correctable error (CE) processing will call the CXL CE handler. VH
>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>> and pci_clean_device_status() used to clean up AER status after handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c  | 92 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.c       |  1 +
>>  drivers/pci/pci.h       |  8 ----
>>  drivers/pci/pcie/aer.c  |  1 +
>>  drivers/pci/pcie/rcec.c |  1 +
>>  include/linux/aer.h     |  2 +
>>  include/linux/pci.h     | 10 +++++
>>  7 files changed, 107 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d35525e79e04..9ed5c682e128 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -110,8 +110,100 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  
>> +static void cxl_do_recovery(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_prot_error_info *err_info = data;
>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.0, 8.1.3).
>> +	 */
>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>> +		return 0;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>> +	 * 3.0, 8.1.12.1).
>> +	 */
>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> Should use FIELD_GET() to be consistent with the rest of CXL code base

Ok.

>> +		return 0;
>> +
>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
> I think you need to hold the pdev->dev lock while checking if the driver exists.
Ok.
>> +		return 0;
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> Maybe a comment on why cxlmd->dev ref is needed here.
Good point.
>> +
>> +	if (err_info->severity == AER_CORRECTABLE)
>> +		cxl_cor_error_detected(pdev);
>> +	else
>> +		cxl_do_recovery(pdev);
>> +
>> +	return 1;
>> +}
>> +
>> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>> +{
>> +	unsigned int devfn = PCI_DEVFN(err_info->device,
>> +				       err_info->function);
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(err_info->segment,
>> +					    err_info->bus,
>> +					    devfn);
> Looks like DanC already caught that. Maybe have this function return with a ref held. I would also add a comment for the function mention that the caller need to put the device.
Right. I made the change in v10 source after DanC commented. I'll add a comment that callers must decrement the reference count..
>> +	return pdev;
>> +}
>> +
>> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
>> +
>> +	if (!pdev) {
>> +		pr_err("Failed to find the CXL device\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>> +
> cxl_rch_handle_error_iter() holds the pdev device lock when handling errors. Does the code block below need locking?
>
> DJ
There is a guard_lock() in the EP CXL error handlers (cxl_error_detected()/cxl_cor_error_detected()). I have question about
the same for the non-EP handlers added later: should we add the same guard() for the CXL port handlers? That is in following patch:
[PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error handlers.

Terry
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		int aer = pdev->aer_cap;
>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +		if (aer)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       aer + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_cor_error_detected(pdev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +}
>> +
>>  static void cxl_prot_err_work_fn(struct work_struct *work)
>>  {
>> +	struct cxl_prot_err_work_data wd;
>> +
>> +	while (cxl_prot_err_kfifo_get(&wd)) {
>> +		struct cxl_prot_error_info *err_info = &wd.err_info;
>> +
>> +		cxl_handle_prot_error(err_info);
>> +	}
>>  }
>>  
>>  #else
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e77d5b53c0ce..524ac32b744a 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>>  #endif
>>  
>>  /**
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index d6296500b004..3c54a5ed803e 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -649,16 +649,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>  void pci_rcec_init(struct pci_dev *dev);
>>  void pci_rcec_exit(struct pci_dev *dev);
>>  void pcie_link_rcec(struct pci_dev *rcec);
>> -void pcie_walk_rcec(struct pci_dev *rcec,
>> -		    int (*cb)(struct pci_dev *, void *),
>> -		    void *userdata);
>>  #else
>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> -				  int (*cb)(struct pci_dev *, void *),
>> -				  void *userdata) { }
>>  #endif
>>  
>>  #ifdef CONFIG_PCI_ATS
>> @@ -967,7 +961,6 @@ void pci_no_aer(void);
>>  void pci_aer_init(struct pci_dev *dev);
>>  void pci_aer_exit(struct pci_dev *dev);
>>  extern const struct attribute_group aer_stats_attr_group;
>> -void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pci_aer_clear_status(struct pci_dev *dev);
>>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>>  void pci_save_aer_state(struct pci_dev *dev);
>> @@ -976,7 +969,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>  static inline void pci_no_aer(void) { }
>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 5350fa5be784..6e88331c6303 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -290,6 +290,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>  	if (status)
>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>  
>>  /**
>>   * pci_aer_raw_clear_status - Clear AER error registers.
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> index d0bcd141ac9c..fb6cf6449a1d 100644
>> --- a/drivers/pci/pcie/rcec.c
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>  
>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>>  
>>  void pci_rcec_init(struct pci_dev *dev)
>>  {
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 550407240ab5..c9a18eca16f8 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -77,12 +77,14 @@ struct cxl_prot_err_work_data {
>>  
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>>  #else
>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>>  	return -EINVAL;
>>  }
>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index bff3009f9ff0..cd53715d53f3 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1806,6 +1806,9 @@ extern bool pcie_ports_native;
>>  
>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  			  bool use_lt);
>> +void pcie_walk_rcec(struct pci_dev *rcec,
>> +		    int (*cb)(struct pci_dev *, void *),
>> +		    void *userdata);
>>  #else
>>  #define pcie_ports_disabled	true
>>  #define pcie_ports_native	false
>> @@ -1816,8 +1819,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +
>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> +				  int (*cb)(struct pci_dev *, void *),
>> +				  void *userdata) { }
>> +
>>  #endif
>>  
>> +void pcie_clear_device_status(struct pci_dev *dev);
>> +
>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


