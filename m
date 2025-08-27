Return-Path: <linux-pci+bounces-34910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC5B37FCD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CD820413D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE7322774;
	Wed, 27 Aug 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cM2D6X/l"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAA223301;
	Wed, 27 Aug 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290185; cv=fail; b=dYcR3fySezxRc52hNmTPLgdo14RyH0u9lb9yUClwXRBh2vNCJDjO1OppzU0vpAlMvnbuQ8gVHFVyIDFcjA+tWCpZHMbtUHyj6+AxmM+gPFCj2Bt/tte3SLTFGAkdLABb7e+ra/oWEpS7wUpZa9zZJij2UkPhclfP13lN3mxtoMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290185; c=relaxed/simple;
	bh=j33lNq/1eyvB5bGNrgdJxwQGRL/0AYQYavlRnUCREv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DOme9e3luREbTG8qd1nvcbYRlIsUFT2c0kNlepIVU9nPycHif8I6uK523X8lq1OCaUObi+4Q84NJRwZ/RqCp9E1dLHoeh48xHJgj2oor+f9mJfhwAskR2Pe0XsBe9rMYYjxTNGuAarYuvu6ki4OmYclhg7AdXxbDAO6FizyTLwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cM2D6X/l; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgAVX2MCyHloIME33yG1xAJZZDBYmXUOsftC3Fr6FJcEH2q2u4eF/8YX52R4KzfSKhLHi4fz4FXgOSz1VEa+EHVYdfLPJPlEIGj6NwtlsIrRGpcf2rXFD04GB51HYHtF46fL9xE69JYiLr6de1eVUOB8y2Hry+03yUzeLIwCjtcR3EpzNbG9RjqXXOV+scK7hfiLTI85OOBotb6ui9SAqVtft9vBR5iKf5D2RUo32+bRZF4ofhGzpwrhP0msZ+eLaWyhpAUNZR5/r+RL+DHYmtEyaLkOfWmF0QFu2ATjMVn9ZTcqgVqHg8Orlmt6TF8Q4jDXQoLqp33nT1IyoOC1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X06AKaUU5+2cN09CEvDU38sXrjJCE0Ujw2tHpH7PLro=;
 b=RPyzVJQ1FzT6R4kr6lJ2Tq/lcTeW1o7CLQpX5fLUDvwgvD0v5FwSWIookUrMocmaRqgI8ekFtbAh9f1VflHOe2rfB5R6PnJmRkzM4DkOQC6igTfG03bczRzDAgAguCXP7ewci0VpOUq1ymXyY9LSaOnbGqjOhYEsZ600rJ9P7mt9ZJkQfOqmKV2K5p7ErX7Ro/5y8/FT/Xw8M7QGucoaZ/0PZNL4INfg6QNq6ITn7XaJ29/ntT9fIa4prSHisGm7VvQ06B2CsjsemV/un7HDb6mEufrvJr5a6DA5AyrWehhsIjv8iEyMxihoUN/OKPx2CuBVGw5eGhVcYeHMkmKuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X06AKaUU5+2cN09CEvDU38sXrjJCE0Ujw2tHpH7PLro=;
 b=cM2D6X/lTf7pKOARsJTUCA8cBS2WW1za/ihR8WACQZBGwSQJnRuZnjnuZKCpYoDVO+0wXw06wlO+y31nkpl3Mu9fs2x59R9dpuids5NzuR5wD0ohugQe0fEK9kmalidpQ2SgtJaqQdyH7sJ0uNeUb1EnbgvD+rEwmrqzHWdT1klBG9bVGbMl/KWY36slsqKqa3J70eOodM6+mbYcZv39jKUGU4oQqyXg1gwfaXufB22gG8aDa1E1sjBNkxHPbyT8D9IydKjmeXvoZEtSnQFXdBfuNFiSLWBgaitdkZ1t98p5jEzIiABbwYt2sPuZUkO2aWYaCuy8WtD5GtoEKvWV/A==
Received: from BN0PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:e5::6)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Wed, 27 Aug
 2025 10:23:00 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::ab) by BN0PR02CA0031.outlook.office365.com
 (2603:10b6:408:e5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Wed,
 27 Aug 2025 10:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 10:22:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 03:22:39 -0700
Received: from [10.64.161.125] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 03:22:36 -0700
Message-ID: <b35dc03c-a947-4139-8e70-dbfb5c701cdf@nvidia.com>
Date: Wed, 27 Aug 2025 12:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/PCI: Fix memory leak fix in pci_acpi_preserve_config
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250825223731.GA808746@bhelgaas>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <20250825223731.GA808746@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d6872b-2e36-453d-5e7a-08dde553b2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXlEN0ExTDdrNGp5eVZVMGtieW5BM0FIaGFSWnk3RG9MVG5SQ0FJa0JBeHY3?=
 =?utf-8?B?dHJGSDZzbkE0ZXlkWm5kYUd0ZjY4K1JVQ3BnT0R0QkpyRmNqS0svUHJyYlBn?=
 =?utf-8?B?Qktrb3RzR1N3bXBuSUdFME4yencveEJtUk92dzRaMEtFOHJQU3llZUtnbmNv?=
 =?utf-8?B?Y0JCQ2VpeFJuU2JpUzNrNG1KUXgrbFNrOWpITWNRS0lWbTJFamFjcERlb2xX?=
 =?utf-8?B?WU5DY1BXTituaU1xRUloUVcrUzVnVVFzUm5oNFBCRXFUa0xZYVZKS1djS000?=
 =?utf-8?B?anBTcjJHekE2ZjhERFE5b0dMYm1KMW5Calc4QWVqQmdZRjFSOUpiTU5TR3B4?=
 =?utf-8?B?R21uMGZja0dsbTZuYW1mUkQ0OElMVU8wdk1ycDA4VEFQTmRhUUI3Uk9QdGVh?=
 =?utf-8?B?VmMyRXkrQnY0OFUrd0cwWE9hdGJWYWV1dXBLNERCNURZSkhORXR2RkpDUC9U?=
 =?utf-8?B?VUVaajQyczQzK0dGMTREaUNwclZkam5VUXFFb2VJYkJ3ZTVSRCsxMndhN3Ny?=
 =?utf-8?B?UkxmQW1ub1VTM0NkM05VN1h1Ykozc2Y4am51bHBMRWNEMzVaS2F2TStMR0NE?=
 =?utf-8?B?eFNkUU9vdXk2Uld0dkQrMUtqb0FUbmMwMmo1eW4rNmxjT0hVM3lnREFhWWMw?=
 =?utf-8?B?Q0xkekQyMEVMUFBXNURLb0tuT0dPNXNEYXhpZk1DQ2dSSThCSENyanJCbVdM?=
 =?utf-8?B?YXhBTXk4NkV4eXV0cVVlczNlU2o0R01haTBoUGNxQWhSSGMxSnlUNEhxdE0r?=
 =?utf-8?B?dVBLTW12cTBvamtIQkVxWmQrbUN5c1gzR0xOSlFiYkZrVDFtWGk4aVJHcXhU?=
 =?utf-8?B?N0E2ZDNjcXlvMkZYZXVuM2tnM2cwdEozaHlEUGRDaXE0TzMybHRvd1V1Qm9R?=
 =?utf-8?B?ajZ2dStucG5WdXlVVWpmd01wSG1TTEZZZ096RGlYbVdtV1YyR1FSVFZuUTE4?=
 =?utf-8?B?d2dVamJuNVY4TThVMmU3OFRzUUhKV2diWVFHWFFvQk94cWlDTGVBTTltT3Q0?=
 =?utf-8?B?WlNiRUFXcFhJQlY2S29NSjRteGxmR1A0cXVwK3JuSGJOU1l1RUlVWEFmWmxG?=
 =?utf-8?B?M0pIOXZBZUZ5OHBJdnE4QWFJMGNVbHVlZ0t4cFlyekJaN2lYREw5by9YWjl5?=
 =?utf-8?B?bjB2eUxEeE1Ob0ZNSFA0aWlidjZTNlVSSjVqTmNlcGhtWUhWeWFHOXhOV09Q?=
 =?utf-8?B?cERZNlp5cDdTZ1FySWluZEM3aDlWejBVUVV0YzNJeFRac1o5NzRJNTY0U2JQ?=
 =?utf-8?B?Rm92RTFEajRmb3AyTlJHdnFaQUZBZ1Y2QUFqbEpvQTBwZ3JINHlaRll0NTlw?=
 =?utf-8?B?MUdaaWFSaXRkMWxoaXU3aVNjNnU3Q1pwc2Ird0I0UmZMWHlQVzdweitvejla?=
 =?utf-8?B?S1g4dVozeXdJYkZuY0JDd1V2VzdYSW9FZlhxL1BSbjVPV3p4Tko2TldxWDNK?=
 =?utf-8?B?OEJpcnRBYk9CeENXQi9RdHVzRXR2aExzWlUyVndWYjlNcis4d2haalhXYzFJ?=
 =?utf-8?B?UFBQZDJpSWZjOVByRzFKaG9WL1l3ay92YTRCc1FVRmNKMlFsNVV1YktZbUxZ?=
 =?utf-8?B?eUdpalo4eFdQTUNoeHlxeFhUUkhCZ1RxVkt6MkNlSUM3VWg5RkFoY2M5U3Jt?=
 =?utf-8?B?T2w5RnhsS0JGMkphZkc0Q2IwVGhTN1NpMmE4Q2VPYlp0cU9jbzVSMlNrQlRa?=
 =?utf-8?B?aFMybTJSa2p1Q3AyRGprdmxmbnZmUDRCVmpLZjJoQ2xTRkhLd1RuQUkrSlU3?=
 =?utf-8?B?L0tNZEtTaWZZT0J5VzBqVUZ4K1Z6VlB0QXNYSEUzWEJsTVp3WHhreDVoRkNL?=
 =?utf-8?B?ZWdnMStxZUNNdFNCaC9UMHlEejVJY2tzbzczeTNPTDFDNWdPbWdIM1lLSWoz?=
 =?utf-8?B?LytKNUdOVnZsdjA1b0dQMHhXWEpwNWZmcUdNQTRXTWkwaGVaYUMxdmVVbVJV?=
 =?utf-8?B?ZnZPWnJQY2VFZlpST1FXTUFCUGJqa1lnWWt1NnpBR1cxdnV2K0Q2am9rU0Yw?=
 =?utf-8?B?K3g0RndzTTFpOW15M0FIS1RadzlZWGg2a2k1Lys1cGFDTjRGNHdhNzBGbjg2?=
 =?utf-8?Q?Hgok+8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:22:59.7152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d6872b-2e36-453d-5e7a-08dde553b2a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171


On 26.08.25 00:37, Bjorn Helgaas wrote:
> On Mon, Aug 25, 2025 at 02:46:42PM -0700, Nirmoy Das wrote:
>> The pci_acpi_preserve_config() function is leaking memory by returning
>> early without freeing the ACPI object on success. Fix that by always
>> freeing the obj which is not needed by the caller.
>>
>> Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
>> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> Applied to pci/misc for v6.18, thanks!
Thanks Bjorn!
>
>> ---
>>   drivers/pci/pci-acpi.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index ddb25960ea47d..9369377725fa0 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -122,6 +122,8 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>>   
>>   bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
>>   {
>> +	bool ret = false;
>> +
>>   	if (ACPI_HANDLE(&host_bridge->dev)) {
>>   		union acpi_object *obj;
>>   
>> @@ -135,11 +137,11 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
>>   					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
>>   					      NULL, ACPI_TYPE_INTEGER);
>>   		if (obj && obj->integer.value == 0)
>> -			return true;
>> +			ret = true;
>>   		ACPI_FREE(obj);
>>   	}
>>   
>> -	return false;
>> +	return ret;
>>   }
>>   
>>   /* _HPX PCI Setting Record (Type 0); same as _HPP */
>> -- 
>> 2.43.0
>>

