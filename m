Return-Path: <linux-pci+bounces-42665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70811CA59A3
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 23:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D063012DCC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D732B9B5;
	Thu,  4 Dec 2025 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Esoh2PqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22532B997;
	Thu,  4 Dec 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886533; cv=fail; b=oeuiHyLkaw+J/1U+p62KmrJd5/VurE5XM6Lu3ejnWt8uMei/VoJyyoOoNg1dgsC9VY0dV3RYMw9hSEPhWjXyUN2iX//vKyvjhb5+OiOJzybtJHa3HlZCZfEvmQGxrdjutEHrTZOc4lrbcgB7A+o7DIz/wt3ghiIr+5TqOKUhCEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886533; c=relaxed/simple;
	bh=qBZEiLv9dc+X4Y+FEn0HPyisHY68fclY8iuBMp43pGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bJecNWpk0UUW4v99whl3KtB+75hObTc167nZDk9uTFUvRxMVXKHET9n2nAstD7g9+6swoyR+dcMwqdm1EzBV5QnD4h7ibfunfQyx3itJb3wn4z/SCElQVES/5zmJDPYxFFv2sME6TLZ3MkSy6ggznv7xXrREp4mVGQECAdcFIk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Esoh2PqL; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/yL8QIsejETcaQAdUU3E2N27FDW08ORyGUcBjN0BZHz2fiKtBOiIWbhdbtPBA0G5gSOZILkd8wjjfHPoNSopZ+YkivQ5zhZXOYMQn9ootCNU63ANXJuxcqd9BNb1Ir0K1U/ZW7b3RssYGmOL+F4rfxEsMcUVsdYW28Liu6pjH3wi2VKzcriqSw+pm2krorN5hE/m+1ekPMck/JvqG9M3mO5TOYIU7U2jQwECZoMaLcNjVvXHYb7QB7FYjL47oCIoehgTK95XloSI6nBCD/l3G1bYA941RCHay2Mgo97+z521rPdJANsGXLq62xndXsKTo/RONRv4Pe9i5yLEmWCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud4nGqY89wmXrICQpcwcX7A7Zgh/8fR1kGtRd9YD/aQ=;
 b=h8+TQINCfzzDZCetdfKkJ8872/mxH6G9/i6wXNIkWvKxsaFXC3o9/f6ymYkTs+04jBaIGK5GrPYupaNVqkK4qJQTQQSFZ9F87LpAmdMWD4vxxbIWR29P8zGEvHG4kATgIe1thcwu9/TydwqiedLafwj3yJnGimCkhO3Jl8Aanu6COxC6YoV+msSZBVMcUzIl5qUep50RqFHn/kL3ZfJS1QREqKeb4jo32fEMHtzynN6V45mdB+5BCq6aVChjI64z2/ZK7FeTjg4Oz3CCTF16szHlfwz80/2MvXMCoxDJ3gkxmghFuEkLeBNueX2OKKH+xSuxvz4QfOJNXtAZ04Zniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud4nGqY89wmXrICQpcwcX7A7Zgh/8fR1kGtRd9YD/aQ=;
 b=Esoh2PqL4N0h3UbI4YErWvI/CcFCkT55fCOXByMrnCA4hHF/4b/NqGDFqqHe42YXD4bPXlTrXW1/BJbTgUGh29cIe0w3UAFhzlXLirJ3UTbb79VNj4YqsQoKo7/MNWTOgfXgnX7oSOYVp/Qyv90Q+k6D8co2Y6T7fsQp2iu3XVw=
Received: from SJ0PR13CA0226.namprd13.prod.outlook.com (2603:10b6:a03:2c1::21)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.10; Thu, 4 Dec 2025 22:15:15 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::a3) by SJ0PR13CA0226.outlook.office365.com
 (2603:10b6:a03:2c1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.3 via Frontend Transport; Thu, 4
 Dec 2025 22:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 22:15:15 +0000
Received: from [10.236.179.173] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 16:15:14 -0600
Message-ID: <faba12b8-6eca-414c-8e16-41cb3465b460@amd.com>
Date: Thu, 4 Dec 2025 16:15:08 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] cxl/mem: Introduce a memdev creation ->probe()
 operation
To: <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-7-dan.j.williams@intel.com>
 <03ec6e1f-bb7d-42e2-a887-70c18dbf4749@amd.com>
 <6931f9127f46a_1e02100a0@dwillia2-mobl4.notmuch>
 <69320503ebad3_1e02100e9@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <69320503ebad3_1e02100e9@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: e179de44-f5a7-4988-0f48-08de338299de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmZqbyt5TjEyaTVCTFlMYzd0UkEyRWZWc3loTWFaSzQ4OU1WTnBRb005OW9O?=
 =?utf-8?B?Mk9WOXF6b1Bya0lCbXU5WDJPN1kweSs3cHdvSWdGcjRFRzlBdG1XV2JJMW1X?=
 =?utf-8?B?ZDgrWm9GY29KRmV4b3ZZOUdhN1NqbTJSMllYZ3NNWUdwU0RvblJsdzJUTlZS?=
 =?utf-8?B?V0ZDblhlc1gvTU0wQitGWTlhNjdnNEFJZEtGSVZTM1E3MVdvZVJiY3lwaEto?=
 =?utf-8?B?NDlielhZME9QUEpxZElaTm9mdW9DaEVTNWx3VTFWNURZTEZ2TmdPR041TFZD?=
 =?utf-8?B?bFlhbzFKZS9lckhOMHVveGthZjdnNHhjbDE4RnhMSzRUd205TXU0Q3U0eDJa?=
 =?utf-8?B?UTBtSTcwbXN0bUtzRGJOeWdTNjRQVmd1NXFLVTlSbkVoMXRnQ0hSM3Y5T2l2?=
 =?utf-8?B?bklFM3E1ZWxFWkRRUk9VYm9VZTdqVkpnTHFNM29nMytiWnAwbW5Vbks5bmtw?=
 =?utf-8?B?WjRwcG5pVFZ2RnUwZXdpbHhhSHl1ZDFabnBGQmxFUmZCc3pleG95YVhBWTZ6?=
 =?utf-8?B?bGdXaGxZTnpCZDFXcTRkMHIrS3QrMm1kM2lqNlRFaEZIY3JLK2sxSVZqVzV3?=
 =?utf-8?B?OU5vREhyMGF2ZmlrelFINjJGQ2laS2JYL0NSdFU1Y2tWMStGZ2VrT0lMS3dH?=
 =?utf-8?B?Sk84ekp1NGlOalEybi9GS2JodGlhK1NtQys5NENUTnhSOUw4d3ZCYklsVXV5?=
 =?utf-8?B?TEdzNE5zQXNqZk54RVA3NlI5ZUVqaG1xV0ZJeHAxR3lnTlpIc3pmN1ZDUGYz?=
 =?utf-8?B?a01qRktCbEl5S1M1ckV1bzJpdTcwUXBSR1Y3U3JORVBjMlhhSVIzMmJtYlhk?=
 =?utf-8?B?VjcxV0NxbUFFY2U3emxrckxCK3cxNEpwMWNOVWF1MW5xd0h0cGhzTDdiS0la?=
 =?utf-8?B?eklrSFRFc2RVcEUzc2lvdWNmSVpjTjhlQ2JzeEx6OE5xZkExNmJTamd6VkZV?=
 =?utf-8?B?L1Q5YlRiN1NBdkdtVWdOc1RVcUM5SjJlekV6VDZyZ29xMXEycmhnN1VKeTQ2?=
 =?utf-8?B?TFE0cXcvcTZVSGc2dDY5RnBhVkdqK1BrTzI0WHZ6cG1CL0tyOHBmb2VzWHF0?=
 =?utf-8?B?V1JyRlplRkFNTnBmQ2VkdlhJK3FjbXFmVldOdUljcXd5WGVEZW9pcFd1ckZy?=
 =?utf-8?B?YlBOUktocWVvbnpDS0hpVlBIdm1WbzZraXpHNkJkTGh5K0JDY2tTQmljb1NI?=
 =?utf-8?B?Y0QxbFFIanhRTGI4THplcGZKaVE5QlJEUURrd1gzMkRGMWI0cHcvdlhta05j?=
 =?utf-8?B?NnJLR1JVWSs1UElhbktDVkwyRENteHU0QTd0U1oxV2puTThJSHowa3VSaW1Y?=
 =?utf-8?B?djVZZG5kNlF4ZWxWTk1SOFMzcVpPS2g0TE41YmFoNC8zdUdCakFDaDZWdUVK?=
 =?utf-8?B?a2cwL094N09FOWFTbEFXb1RIZVl1MnpYblB6OGwrUUtHcFVVMVZtNndVb1cv?=
 =?utf-8?B?K2xhVWhUcWR6M24vMlNrVlhaRnQvNW9vMFNlZ3NycFBmcnY5azRVVWZjWFFG?=
 =?utf-8?B?QVpjenFoUnVObitrL2QrSXRSbitqRW83VFNaSXp5cTlKZXAzVTdCd3dSWG5r?=
 =?utf-8?B?QTFyald2Qm96OThidWpLUThmTVNNZmpTUXBnd2dqTUhJMythbWlkM1NtdWsr?=
 =?utf-8?B?UFFUQnNha1djcFZXRHljZEJBcEtOWC9LSXBGRFF3aytLRGppTXFKekl2Mk56?=
 =?utf-8?B?UEU5eU1RVGpIaDVsc1k0elFSWWIvcXBoVjdyVWdaQlFaaUZ6YUh4ZTg5aFc5?=
 =?utf-8?B?Yi9FbjBzOVhGYmNtay93bWJQbmJRZFBVMlBNa3FFdUN5czBDRGRhbHVybzdW?=
 =?utf-8?B?TVNHOHI4ZEpZZW9ZYys5Znk0S2dhdVpvMVJQT0RZUnVSbllSTGRWenhlQnQv?=
 =?utf-8?B?K3diaS9WWkJ3c2crcnVXZjY4MDFLaENFSnMxL2J5aXR2aHVlQTFCYjhQUllk?=
 =?utf-8?B?aDkxdEh2bC9JcldYQTAveWpEcWFhbEducXE0RWI4d3hFakdFM0NHRzU3cDgy?=
 =?utf-8?B?ZkFJTVRPb0RueEFtMlIxZ1BqcFcyb3hBTFp3N2xqT2lsTVM5cnJlRnZlL3JJ?=
 =?utf-8?B?ZDAyUkpwT251NVdnRGJZU1phTzFkQ3pOSGl6NkVMdDZpWFloWnpkR2xDTEFx?=
 =?utf-8?Q?tJlk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 22:15:15.2053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e179de44-f5a7-4988-0f48-08de338299de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159



On 12/4/2025 4:02 PM, dan.j.williams@intel.com wrote:
> dan.j.williams@ wrote:
> [..]
>> That is functionally equivalent to a new devm_cxl_add_memdev() flag, and
>> is something that can come later when such a driver arrives.
> 
> Here are the fixups collected for a v2, I added some documentation of
> the expectations around @ops:
> 

Changes look good to me, feel free to add my reviewed-by for 4/6 & 6/6 when
you send v2.

Thanks,
Ben

