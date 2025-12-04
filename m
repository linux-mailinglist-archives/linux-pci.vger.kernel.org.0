Return-Path: <linux-pci+bounces-42648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AB8CA516A
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4773119110
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A440347BC3;
	Thu,  4 Dec 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jB353QbW"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0E315D4C;
	Thu,  4 Dec 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875388; cv=fail; b=kqNk8HPmjrrmYqAQwqEte6kf7J9SRSOBjM2OnA2NVJu1NiVl5+mPNlYuaJHEAzm1F9wZTu7Z4NSEPTttalPVsxFiB0lTLsvieSpcJI/UfbgvDSNuSXkLLc+UohZ4UkTLOLZdbYAD4aZklG2oUDmIjKB7tLLa4lFLGemd7WNAd34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875388; c=relaxed/simple;
	bh=0QC0zqS80/JjT+HQxOQSLoUGKrzUSbYlwcaQ98U6s7Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=CESWoUIu+xVd4YmnQXZ7OMjXfaA5m7P8yCyWeorPy1OOmA9jxKiDkUsfHywIAoHI6TsigEjUOBL7FzIHd/SS1EvnpjnCgJl56D5kN9zpvo/2CVcWwyE9l+UTllaQe9RLnuGKZbrQuc2ij+/+6gikmmwz1rszAgl8lfFb2fjnHAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jB353QbW; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/X+MHrbc3g9Sbq9ZY/tZ/c8g6jj7mCTd8WKezmT3UVnIBtmeJ90Dgfst1xhce85oE1jRiOeeB/OX45btfuo5o81SRvC+Rha+FQx6Iej0LuE8vibJ6qsdkPVnMiUe1b3sOMjuEGzNGGwXyUJZGl2dVVUCX+SzdFQNuN+VASpaNNJoiAysvqRYKbOn09zq/4q/Yz001TODb7/2p7BdwYs2YjfL5iEnC1ZBpzHcDcCSdeQ+F+qwJCmngtf2DW+YbNztBTwNhXh3sj547AsEmttkcuuPHpjpNH5jlKznTHe9oazMw/Hl/b2tqI1MpBv6Y/7VZDs6ljNiluvY/KkfuhV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqFhdLbmpLSGxXvka2JfcMbKxd9/DOzhmJR6pte8lBE=;
 b=Iqry3sF022mPk/erhCiQyqJ1gQkc3wViyyL7uGwtmP7/gD10tD1z/L8K5TBmYs/wneqDqEs1WLLLe10i7lIncGrw8hJAWUJlnrl7Sg1sWxR7A6t5OaUyQYKLrCGXFLMJ0FgZUy5Cspuwr3fc2tXdFhGzOITytt7ERK2lv240kqWgXndx0lWh3WNulnV3yTdPIVBXrQ64/iaLMhHTOyqxrJGURNd7dAMKZQ6PaEkf8sGEOXV1mRAJZxXVccW9F+swy75n8m+YOSLbXrUMC8POCqvDcATnAxbcoEf/BfcuMzIJd3+eZvtomoX9D2G78RwGWatB2hT5fanT93uCjX5ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqFhdLbmpLSGxXvka2JfcMbKxd9/DOzhmJR6pte8lBE=;
 b=jB353QbWURa6MEQW2W774GkAyWvJ331obq1oCXfFb685K7Mae6Z55MSle7+MWIJSIVNQIWNMLlpuCqIGi/1NHgaGD1I19jcigrnvuND2HZmAuU3mDHFwD6rFcpXF/4ORnFtBXCiDcqFx9eXLGRXcZTtwkxDWrfFC6hfJRNMKoJ8=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 19:09:42 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::e7) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 19:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 19:09:42 +0000
Received: from [10.236.179.173] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 13:09:41 -0600
Message-ID: <6ec1e441-e446-46d4-842a-699c2c263a6e@amd.com>
Date: Thu, 4 Dec 2025 13:09:41 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/6] cxl/mem: Arrange for always-synchronous memdev attach
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-3-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6cab24-a6b3-42a3-cd6d-08de3368ae38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|30052699003|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlcrMjU5VExKK2JvTWpESGlJUDRURkdXZzJVdXRWL0FpaDk4L3NQMlpEeEtP?=
 =?utf-8?B?ZHl5eEJvaFVGMFBZTi8yQWF2MWRnOFV4cklhdGNBM2RkRGcyOFdiMFNKNGpx?=
 =?utf-8?B?UUZrZWRvSjJRRnZNUXhUSUZEZDVNNVpCT0NPUzBUUVVSbjFmU2NYb3ZacWds?=
 =?utf-8?B?RlZWN0dNMWxjbXdHdkhqUTFmbVdLSGxYUW5wbk1FeFFHUk9xSG1qV3MxVUM0?=
 =?utf-8?B?SE1kR0UvYWxTVTVSb2g1VGcwQjlqclZ5MDdJWUxQQ3ozNHZ5Skx0N3ptdTUv?=
 =?utf-8?B?c2RJTzh1T1oxbUZseER2enluNEJlQzRoQlV6WDlNeUNPZHF0d2k2VXJPc0U0?=
 =?utf-8?B?ckx4Tm1vQVhncW53ZVpja2RtTlU5eGNhYWZEY0w2WVdNSUdJTHB1QWlsbDVG?=
 =?utf-8?B?Vm9SVkNrc2pxZVNHRnlLdHFrbUZXaVdNU1d1YVYySU0zWXplQlp3U0hSOHNh?=
 =?utf-8?B?bThlVHMrbURHVkpRcjY4TkVvemN6a1RZZHpVeUVYdFdFK2gvNGRBMVpZckdM?=
 =?utf-8?B?YllkZEJReU4xbDFVNzl0bjVTRTVKM2JBSzZ3V1RkeExTTmtURUpLOUdPVTNz?=
 =?utf-8?B?Y0c2NFpKeFcyeU0yOEpOMEFDbWxPV1dldVVianc1NjdBTlpsa1JkSmV4NjJD?=
 =?utf-8?B?aUprUFc3VGlseXNlTE41ZjJQYTl4UnFSQWtaR2hBMzhKVnRVd0tIbnNYTk9V?=
 =?utf-8?B?S3RVM0tsbmZ5RUFiN3BiOGdaa1R1N2V5TWlybmtYeWFmTEhwOHl4bWZUVVph?=
 =?utf-8?B?bWRaNVZKTkJ0aVp4MVFGdWdvVjJzZkRrelJVd0lsQTQxTXZiSVlyUVRzNHBm?=
 =?utf-8?B?Y2UvdVRBL080cS90M3RucHdoYzRMY01RRjQzMXZTMEhMQTMxK3hOV3VtQU1p?=
 =?utf-8?B?eHlZbmZZajVqMFc5Z2VtNlZEaXhmMGk1dnp1TUl4RHpRckdrYzZ6L1V1dzlV?=
 =?utf-8?B?T3JHWGdxM3VaRHpWZ3VZdVk4cG1vWUhmYmRucXdneWU5NC94S094ajlXeFNL?=
 =?utf-8?B?RkgrRTFDd3dzOXRHVFk3UVNseVNVUDZ5TUtucC9nSDF3LzI5QUhkUHlocm5E?=
 =?utf-8?B?RThaVVB3c3g2S05NQ2xLRzAwbDRveERDNHJUcVN0WVRuNWhqbk1PWXdMSHlp?=
 =?utf-8?B?dkxtK1dZSzhsYVRWWjBjQTBTVVhpaGk5UzA0WWFScFNhV2R2V2VZZi9BU09j?=
 =?utf-8?B?Y0ZmN1hNL0xHTiswZ0pMZVBuKzNWT0h0eWg1SWQzbUJEc1NFaXpza3dKZFhP?=
 =?utf-8?B?QnE4Z0JrM2hqVjhOVEkzWGgreG83WWRMY0M3VGJwRHhvTGtWVUhxaVgvT2RF?=
 =?utf-8?B?N3lkUjc3cGlqTEpOcTBGbHRmZGdyUnphd0wwd1l1Wno1aHF4NjRlVUVYa2Rv?=
 =?utf-8?B?MzFUMnhPT2krZUJXaGdnY3RWcCs5cGNFeWN1S3ZtbnVYd25LK0xlMngrTDg4?=
 =?utf-8?B?dUtCYWFPeXNBL0lhV3hnOFVvQW1qZlVqaTFwdGEvTDZ1dlJvWXdKektmbkF1?=
 =?utf-8?B?N3BlanVESGdRZy93TkVwakJ5ck8vbjBOR2pybUIvM2VkdnU2QXA2bm1sZE9a?=
 =?utf-8?B?dWxhaXlSbnNBSDBQeFY1K2hna2lNQ2xJWGovcWRSUGYyTS9tSWNWQUs2aFlU?=
 =?utf-8?B?NG1xWFBzam9SVllqMkUzVlJRMVpZWjNxc1I1VWJ2QlBONkxOeEF3bTEwRXB5?=
 =?utf-8?B?UWFHRzhLUUhhb1A4d0djelJrNld5aEdldnM4MVhEck1ZUkVVRkpCbFdpRzhJ?=
 =?utf-8?B?OEsyZURXbWFpUVBQUEtFckprbDlucFh3V2NhZCs5T1JING5GS3U3cjZZZGJo?=
 =?utf-8?B?Z1hHb0NudGJ3TFBlbDlMcWFyY3VLc1VOLy82ZVk0SHJ0MTg4ajNPU25BVDVx?=
 =?utf-8?B?dm5vNWw0bmVpeVJhN2JkbGpnWUpmN2ZyNVovSVA2SXFJYisxWmZjMi9kZGNn?=
 =?utf-8?B?TXQwNmlsQldUZnZzZ0x1K01KM0pJNmx2R2pqZ0lkZFR5SUM3dVVMMXcxTDBM?=
 =?utf-8?B?Rm9ZNFUrTWxsS0FjUFFCazdMeHVZVmQvWHlHZ0p3RUprUHdCZjRuenE5TFJx?=
 =?utf-8?B?d1Z0bnQ1cTVFc3dpdE9vNklkTkJxMFcydWFpNG9zUTZWbFRDR3lKSkRoL2tz?=
 =?utf-8?Q?JT54=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(30052699003)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:09:42.4959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6cab24-a6b3-42a3-cd6d-08de3368ae38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576

On 12/3/2025 8:21 PM, Dan Williams wrote:
> In preparation for CXL accelerator drivers that have a hard dependency on
> CXL capability initialization, arrange for cxl_mem_probe() to always run
> synchronous with the device_add() of cxl_memdev instances. I.e.
> cxl_mem_driver registration is always complete before the first memdev
> creation event.
> 
> At present, cxl_pci does not care about the attach state of the cxl_memdev
> because all generic memory expansion functionality can be handled by the
> cxl_core. For accelerators, however, that driver needs to perform driver
> specific initialization if CXL is available, or execute a fallback to PCIe
> only operation.
> 
> This synchronous attach guarantee is also needed for Soft Reserve Recovery,
> which is an effort that needs to assert that devices have had a chance to
> attach before making a go / no-go decision on proceeding with CXL subsystem
> initialization.
> 
> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
> loading as one reason that a memdev may not be attached upon return from
> devm_cxl_add_memdev().
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

