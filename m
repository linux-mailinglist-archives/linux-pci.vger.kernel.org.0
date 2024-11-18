Return-Path: <linux-pci+bounces-17014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35249D07D9
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 03:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F9F281865
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A4EAE7;
	Mon, 18 Nov 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LJw4amYL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2048.outbound.protection.outlook.com [40.92.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF91802B;
	Mon, 18 Nov 2024 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896490; cv=fail; b=UiwbNEIOPusHfPAzrcu3woPoNNc7qw6KByMePkfhIoYJ1yK+CPtaoYsgwnOjhQafXTGOz/LBCU+bMp2rlDJis8SLORw8Ok9KZ6McWYBINloLqIJVT6FKIYHMslqrjWnzBW3h9gdPXsjOIGgYZrfm2dSaGf8tn1WhbH123A2JXhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896490; c=relaxed/simple;
	bh=oatnQ2kAtsg69iGhuj5i1JrqpGAVPPdj0iElKtEV2X8=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0cpgl0kbuFmhbEA8IltuxfCG7W1vjlbNebAkmHZ5Rpr5z41UuQAC3if2O4N7wrsj8BMTDNDvlXAm/qqMMdEMgGlWpOz20WjsxxZA9PVcsUeH+i2fNQeTiwcT06Qq04u+4piXqrx1ozO7gqmzsXuynhVFVPrJhy7cvBz7hlsqos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LJw4amYL; arc=fail smtp.client-ip=40.92.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRfvAGsrV2STfBWwpTqvzrTviE07Jf4793H/ZtB6e66R623S1WstBPjiJvZLlaQt17bkpxOK6i8ht4KOQ4TcZnpKWrD4UU3sFJ2sf9f/xmZx/Q4iKBkrKoMTbfZ67z9Qek+XL+RgPJH+FJLLI/Pn0T8K1nrlSez2cMIJz54Q5wC0CTXWaYtBSBsM72nYcTcaDNO57O+Vsnf/JQEbL8j/vtyCFUticeQBj4UZs5T14JWFL7ygo6gvSwRn0r8odv7hh8DKZVLzdzy4cyOEBWo9SLVSfNrdOeMMLtLLsFXyYEkAhSAYhYU1QhD3vjsOoOjcoBaqT1qbGuGfIY4gMUmnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1iJ65w+dp1suX3uNElWX6N2x5z0JXZ/qYeagCt9+Xk=;
 b=R7SlHjtPTwtLM1Xo0l549D1HZmX9mTV4QQq6pE9YJJApcbckDkFEVLaiUyl923rAZGp6wiaTBwFybd3gB3jM8cMn8nifHimjJjvwsI6yGvTFlpHle4C8KGpWgZtj4GQgMWKVMs7mL/y8LS4GnNGpB5dLypZ/Xd7r1/5kzD4zBfiFsWrQOPk69aFAqH7eAJ+nfpmPyIfMv/IP60LjWU0KGDGh6ywToHVgIQIeUy6nCr1SPUB6dhocBAPlfKrGf2uCSduDoZ1zR7zWTYmP37vfzGyR4v/QQdhI7/N7vpyUCJp2Cql93x8JPsWY/SJd7TbQvkd5qZIIny0LYpfXESlWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1iJ65w+dp1suX3uNElWX6N2x5z0JXZ/qYeagCt9+Xk=;
 b=LJw4amYLv8z5CtRcG+5bYywBXepDGW1AjlrRruAqTeJxoq/iSP18TnfPaNvJxb5XhptY4NAIRHL/YJgSPQWw6gjTUpt9XmOZXJa82eGIeT5zxT4UJBU65MCf4j1cexhSg/9TmQYIxVhVqa2gC5MFadXOKh0+S5PItseLo+X5wGCjOzlmiIn5hEjFVPEtBdIvyUkRubTg2GaqQaoD+r52vQNsrYDg6jZ+gnecPxEVrb2Te2FdSIulTULuWuwR+nP1WfuttuFr9tUnpvOMQGaRJoTCY8X1XssvLIeFjC8+to+FRRFaLwToYJyecjtlsjiIMc1N9NXfXL4thn8ENkFO4g==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by AS4PR10MB5371.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13; Mon, 18 Nov
 2024 02:21:24 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.004; Mon, 18 Nov 2024
 02:21:24 +0000
Message-ID:
 <VI1PR10MB2016CA9B2CE19DE49693794FCE272@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Mon, 18 Nov 2024 10:21:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] cxl/pci: Map CXL PCIe root port and downstream
 switch port RAS registers
From: Li Ming <ming4.li@outlook.com>
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-9-terry.bowman@amd.com>
 <VI1PR10MB201647BD9FC20C8BAB8F4A90CE262@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB201647BD9FC20C8BAB8F4A90CE262@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <5fe82e3c-6f66-4137-916c-fe7a6934e5d1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|AS4PR10MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: fb26b33a-8153-4cb4-1cff-08dd0777b29f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|36102599003|19110799003|8060799006|6090799003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE13aFdRcnNvVmU5Wk5UNmMrVCtldjZRTkpyNHU2ajNSbEtnKzcvRS9hRjhO?=
 =?utf-8?B?L0J0ZGlqeVM0Y3NtMnEyRVJBZ1JsdXExbkdJSUl3Y3o0NWphSVhFOTl0VUpK?=
 =?utf-8?B?NW1UREVSS2tFZ09saGpZWEgrREVTQjN0cEl6dEQrYy8rZVkyVzhmTjFIbkJj?=
 =?utf-8?B?UEM2UU5qclNyRVJyRWRYdEFHN2lhUWFYNHAvU2RyL2ZqTDhVUG5qZVMwT2I0?=
 =?utf-8?B?SnVjczBEL2h2amRGWHZWa005eDFYdktIbWF6aVFMWXRhLzNtczU4dTllbGpC?=
 =?utf-8?B?VzdvdGkrckpiT01LT0ZRQ3BiZzFtY21JSGgrc0ZMK2JCbnl6QldvSjZyalM2?=
 =?utf-8?B?NitjaFRsb0hWK2s5eFJyR3ozQW1LSE9zUXU2VEoxWkc1cXhOWnNQNVFYdXJG?=
 =?utf-8?B?RktGUXdIMEd0VWthbGQ5N2krNXlUUCszbFVJbno3Mm93S0hGZ01jYWpudERu?=
 =?utf-8?B?MXFNZ0U4OG9lWHZneHBLL0xtZnUrYnRaaG1NQWJ0SWJFWkRTWXhQeUtKMkxT?=
 =?utf-8?B?TEdrc2FlRnNMRW9qYW9sZnFEdXQ3Umh1dmYvMzQ0Z3I3YStNWUhWVkx3cFIx?=
 =?utf-8?B?Vlk2VE5MdVp4Y0x4YVYvcUVnWW44cDFKMFZDekhhdk9MSzFjY21nK0JzNVZh?=
 =?utf-8?B?SG9CTkh2Sk1ja08xR1FTaEVDZUpRSm5qZ1VZdTBQejNZYkl6UTk2RVdkbUpz?=
 =?utf-8?B?QmZ5Y1ZaZGJDbGZVVUptRzBpOXNoc1RJUWt4aElQdlRvN3FlbWx6Vi9rQ21O?=
 =?utf-8?B?NDRld3VvZUNSMk1pYnpRM25MTGNxOUhtL3V1YTZHbVNFYzYrVFloVHNRakVZ?=
 =?utf-8?B?NThlWmZNVmtwQnBEMjlMT3JhM3A3SlBZZlJkZFQ0WHg4UUpQVjVhVUxoYm0w?=
 =?utf-8?B?K095aGJ2bzFOWk1uczRScEhwRGU4eTRlVzV5Skw2NUM5NEZnZktTR2pqRndT?=
 =?utf-8?B?WXRCMHN5OEJYVzZ4YnZ2b2t2YnNrUVNCeG42ejNnYis4R2J2dlRoYy9hcFkx?=
 =?utf-8?B?WjFRazFpS0pRcHZUd1ZCR1hEMDd1UCtlbDF6MktEWWhEamFnWER3ZWlHdkhI?=
 =?utf-8?B?OUwvQmJQOFFybUtISEhmMTAyTXdOaDdRZk5DZ0J6dG1MencwY3BLc3hiVlJv?=
 =?utf-8?B?dHk1YjdhbzJXZW9NbTRSSmRTRU5wam44eVZvVDBmTlUwblY1bmp4QUg4di82?=
 =?utf-8?B?cjIvQktZUVNKVTRRbWlpT0JCd0ljbzlMdmpBaHh0WVkzQjVoSTlTNDFVc0Jh?=
 =?utf-8?B?b1Z2Si92L3JkaU8yWU5GeUlXUDRCUE5TZ3pKNldrR2xZcVBNOFpUS0lYSUQx?=
 =?utf-8?B?TUZzZmRWb1J0SW1sM3VIbW4renlKdUMwZnRlSUcrQ2JZdGdmeWJ5NzVWMmJR?=
 =?utf-8?B?aXo5ZFoxUGNiVFdHeUUvdW9oYURDN2cyTlFnaHFsTnpJYVpkOHVBZmNjVkcy?=
 =?utf-8?Q?j71V75Ja?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2NETGhMbFJpL0J6dXRmUWg4dEpTZGFDZUwwU1c1eEx6aGhwcHNWcDVGVGFX?=
 =?utf-8?B?MzFpUE5RVkdVLzVReUpLU0pGVWFjU3BUVTVuOE1EOGNadFFqK3puNjdQYytk?=
 =?utf-8?B?ZGlrV0VmakROOE1STFpsblZxNXUwd0ExWEl0Z0UrY2tsRTFpSUx5Y1lIa3FO?=
 =?utf-8?B?NU1XaWpRN1NyWU1xeU51UWQxclRMRTBLRmZPNFFhbUVQSkhSclRzK1I0a0hQ?=
 =?utf-8?B?SFBGWDRxS2RnMnBDclgvbWNXWGkrdjFHQlp0RGFjSXRSemI5Um1zdC8yRHlU?=
 =?utf-8?B?MUhmbUVHNXN6bGdpdzF3cGJzUEhoNHhQTmw5cVZnb3FVMVNHM2pXU0VwWG02?=
 =?utf-8?B?ZW9lU2dubGRUNlZqSEREOFhGajlBcVlNbUM1ajVzYW1wTDM0bTV6d08zRTZw?=
 =?utf-8?B?TWhkRnAzUUExcnNMSWRzeWJFWllqQ0RaTC9TWk95Si9Xb2ZVV3Vxbi9pL0hl?=
 =?utf-8?B?NFZWMndkYlAvNFNtMkpOQVhqRDRiSThFWmZ6TVMvT3JSU21sbTRaSkRUc3Vy?=
 =?utf-8?B?OXk5dkJ1K0VLMmVrdFZ2M3dnbkZueFNyWURwVEZWeEVhc1VnWXI2ZDE0eGFs?=
 =?utf-8?B?ZWV0blBSNlEzb3FucjFtMURIc3h3c0U3SXR6RytBMXh2UlFLUURyOFZDM2wz?=
 =?utf-8?B?aXdlZ1hFbXIyT3NIT0V1L0JiYk5JWEFRMUtHVm5ndnBEYWgzQ0g4T0tNOFNB?=
 =?utf-8?B?MlBLOVdTM05EOGJoRWhhUkNjejlQL1FxMG9QMDFhWW5sY2E1VFhmK0lVcllr?=
 =?utf-8?B?V3pxTlN1Tnl5c1pjZjdianJLUlFqK0xyRERsdXFGRUZNNG1HdFcvbDhlQ2FF?=
 =?utf-8?B?bEtsWDkxYXB2K2RBNm1CMmN1OFFLL1N3cFJEMEFzc0phOEpWc2xZM2VsbHNZ?=
 =?utf-8?B?U2JVcTFpWkpwVWdZMDByWnBkNUhYUnJMaUlrazI1akJhSVVaWjA0STZFK1NS?=
 =?utf-8?B?UjkyN0Y2NWhsb3BGZDY4bXZtc09HWEhRQXhYamFETmhJbVFBTlFUV0NINDZ2?=
 =?utf-8?B?SHJGTUZwWG40eEF0WDkrclo2RnBLRGRLWjFIVVUzSEw5NGlncjhPQkh3T25y?=
 =?utf-8?B?WlNrR2U2OHBtaEhWTTdadkJHNGg4U2gvZ1Y1QzA1VFU0d3NDUGNlU3MxSlNG?=
 =?utf-8?B?cjZrcTZ5eTNDNDlNOVd6OUxrSUdlSTVoSjNRQ0NyTDRFa2RZZUlmb3BaSnRD?=
 =?utf-8?B?alpkOWNhMkUrdXhpa3hPT2lVVU9iVnJRWWNuU1Q5L3BsV0VJbnFxUlpyUlNw?=
 =?utf-8?B?VStNeFhMaFJWRXl5KzkyNUlzeEs2MitBcmpvTVBmU2xZT2xMaFdmUjBWSHpL?=
 =?utf-8?B?bTFkUW9FT3dZY2xaRGt2VUxZSWZhamt6cVBzWHlOZXpWeGNKMWhBVVlzaUV5?=
 =?utf-8?B?K2l5bjlFeSsvZWZDdVIvWTY5bDFxQmFXSkZBWEtCcjBVQjAveXJMVk1XVTh2?=
 =?utf-8?B?VklQYzlpd2RqT0lCUm9oMGlyWnBhUjFkeHM4TTQvdHNmaFVlTlRQNW51cDc2?=
 =?utf-8?B?bE41Yi9jME9FekdLNkdlV253UUhsZ1F0NGQzdDc5d0dsL0ZoWTFPcGNvNitw?=
 =?utf-8?B?S1NOUzkwMWpPUDhGZ2ZqTjlDdjI4em83M2Q3YjRoOWVKci9uYzFCd2Rrblh2?=
 =?utf-8?Q?1iIMpEtB8DdKRHRk7cAr/3jqWB1F+qee+8qBI7Jmrnsc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb26b33a-8153-4cb4-1cff-08dd0777b29f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 02:21:23.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5371



On 2024/11/17 15:45, Li Ming wrote:
> 
> 
> On 2024/11/14 5:54, Terry Bowman wrote:
>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
>> registers for the endpoint's root port. The same needs to be done for
>> each of the CXL downstream switch ports and CXL root ports found between
>> the endpoint and CXL host bridge.
>>
>> Introduce cxl_init_ep_ports_aer() to be called for each port in the
>> sub-topology between the endpoint and the CXL host bridge. This function
>> will determine if there are CXL downstream switch ports or CXL root ports
>> associated with this port. The same check will be added in the future for
>> upstream switch ports.
>>
>> Move the RAS register map logic from cxl_dport_map_ras() into
>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
>> function, cxl_dport_map_ras().
>>
>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
>> the RAS registers for CXL downstream switch ports and CXL root ports.
>>
>> cxl_dport_init_ras_reporting() must check for previously mapped registers
>> before mapping. This is necessary because endpoints under a CXL switch
>> may share CXL downstream switch ports or CXL root ports. Ensure the port
>> registers are only mapped once.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> [snip]
> 
>>   static int devm_cxl_add_endpoint(struct device *host, struct 
>> cxl_memdev *cxlmd,
>>                    struct cxl_dport *parent_dport)
>>   {
>> @@ -62,6 +87,7 @@ static int devm_cxl_add_endpoint(struct device 
>> *host, struct cxl_memdev *cxlmd,
>>           ep = cxl_ep_load(iter, cxlmd);
>>           ep->next = down;
>> +        cxl_init_ep_ports_aer(ep);
> 
> In RCH case, seems like another issue is here, I believe that a RCD will 
> be added to a CXL root directly rather than a CXL host bridge, it means 
> that no chance to call cxl_init_ep_ports_aer() for a RCD, because this 
> loop is only for a EP attaching to a CXL non-root port.
> 
> Please correct me if I'm wrong.
> 

I think above explaination is not clear, what I meant is the hierachy 
in RCH case should be this:

cxl_port(root) <--> cxl_dport(host bridge) <--> cxl_port(RCD endpoint)

RCD endpoint's parent port is a cxl root port, so that the 
cxl_init_ep_ports_aer() cannot be called in that case.

Ming

> Ming
> 
>>       }
>>       /* Note: endpoint port component registers are derived from 
>> @cxlds */
>> @@ -166,8 +192,6 @@ static int cxl_mem_probe(struct device *dev)
>>       else
>>           endpoint_parent = &parent_port->dev;
>> -    cxl_dport_init_ras_reporting(dport, dev);
>> -
>>       scoped_guard(device, endpoint_parent) {
>>           if (!endpoint_parent->driver) {
>>               dev_err(dev, "CXL port topology %s not enabled\n",
> 


