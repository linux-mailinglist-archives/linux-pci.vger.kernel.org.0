Return-Path: <linux-pci+bounces-37585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF46BB80D6
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE734C5655
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634224A06A;
	Fri,  3 Oct 2025 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="29Kvqyg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF82BD02A;
	Fri,  3 Oct 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522348; cv=fail; b=fPOAZwrJiZogBiqiUQMk672cQmoh6om3Iwz0+/GLxmX4EfRavEkCTfHXgsLKM9fkaEgTO1vRazbYDZnpZKIEbxFdONjbaTvBVNsjIApnvE0bTwCfq0KNIqPfljAWYWEXKShdS7tCFzAHyi0aGXRebg9mKM/N2VEo6o6rHE+OcN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522348; c=relaxed/simple;
	bh=f/cTTeRWLBUbL2maaaaYpCWMqNTcGwhTq3qNTNOOUMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=mBgx6QINkUT1ghmbNqxJ3Pg3190CIzTtB6OChKVi4Kf1FJLA2LEEuVT1N8W8RxmDs+/FilpiE9TghupiCZjnEPAMZLV1YaqWKsVdXP6iikvpjwlfA3vpfCke6NOUliXZ2q6z2r6d9paenYMxKLywRJgT28/3/dDe7z2oQJFy2rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=29Kvqyg+; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC5S3JI8RBytEPemGLhIfZv5ncT9W/pcXMPs3d6n2xmr33HQpsJXhH09LlzxeYXVwr+T4Dxxx1HIgL4762gGXtg/K9eFBpB/gqSULZ5e4wT2xcQ/MDTKdh51no0H2wCPyGZ/cSBWyxNc+sZPhZZAK6D1JZLnXxADDwKkZjVxVv8nKOGWGj52GxwGzgRHfRNjeKv4AlXiOcaBVv52nmswXJUItBdTl08eGTFhbTbNLqOMbOMIFP5NmpG425yzLEETxuh7cd40alFOz6spzYRdxE6SVqjo7j/L9qZ8NZUWpnqypyfCO5moTmVCRe0iUxSbWYLLKgg4tYxRky6sMVWsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi1taMiYsVW4SleNaj9BZYr51jsacaojEJJuRN2fjSw=;
 b=chPFjqzHUI2hXhcnnh/8FQj7mDhaT/puUd26FA5rMzYaMrn6W2FRwfUvuhYFn8Un8Jff1FKyDOVOQkAQj4tDn4HDa4XJOq+HQelGFwm648CbTCuqWNBDOZtLA+NiH8Q63k1gCEf6nn1KxoB4wCI3w7OwclEwO77PpngEokSZ9I477Pi4sofxVLC2WNQDv6Zylv54E7Gx/p3Eh7qKps1oUecuVStqGvuiEs+n+BjZBXLJX8megv4ggChvjc0GIQRlwQt1S0XRWXXGRHhotBQIxU+vmNM49nYUGs0AblTWRavhIyrpIB04/DkEfSpKbrG5jHa4QnO0l2wbia5X0SqMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi1taMiYsVW4SleNaj9BZYr51jsacaojEJJuRN2fjSw=;
 b=29Kvqyg+U8iVIk3zt29zuCHkXYvjHaNGDWegIlgQcfVTifGkzPDGj5XeCZ4Dx3bp3e1SV+AITqo03uj9lXp0uflYWKM+J1nSkUp65MFbE1d+Vr7Z44MFM7rFYXXzS37g/61wpKSdqVMRlOPnKuaf6ve4UfUwx1Uh5duxFvHmGXA=
Received: from BL1PR13CA0254.namprd13.prod.outlook.com (2603:10b6:208:2ba::19)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Fri, 3 Oct 2025 20:12:18 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::17) by BL1PR13CA0254.outlook.office365.com
 (2603:10b6:208:2ba::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 20:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:18 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:16 -0700
Message-ID: <1e5e679b-a380-48c9-9fcb-a1b6a2d84cd2@amd.com>
Date: Fri, 3 Oct 2025 15:12:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-24-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-24-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 276b2602-41b8-4fee-c456-08de02b92746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjZ6bmtvdlhhNkVFUkl5NXVMRkNOSkwwS0VhNXZiUStkaDdhUjVlbXdReWgw?=
 =?utf-8?B?em9ONFZxOVhEM0NZcDdRSTZPWTkzRUVjS2hJT2FDK1BvMW5VeTVTNU5WRXly?=
 =?utf-8?B?UThIOGxtNm5XeGNGOTc4dXp4RmdXVmJJMFlhV1A4ZmphYkdHSkNLa3V3ZDFF?=
 =?utf-8?B?TXFtL1dBTWU3NDhEZUkxN0FrYWNYSlJGWlFaa3VVdDlqTFNLdEVVLzU3S3BB?=
 =?utf-8?B?RDhmWTY3aEJNeWIrcWN6LzNhWC9xRk12K1YzQkFPREtPb1Q4VVhFbGg1YVlX?=
 =?utf-8?B?TmZ6Qm5BaytGUzJKdGNnaDVmUnJlZm02VTVKR2w2bVlncGJoV21nTldaQW9D?=
 =?utf-8?B?VkdtWGZMY3NHUTlHaGsrdWt5N0doK0lyTFEwRkhRSVdwVXpYNnRQR1k1TTJQ?=
 =?utf-8?B?UzN2bVZCT0RqR1lLVzBuYi9Zd3U2OHRpWHFndXFnNldZSGs4eVpPRC9oOGZC?=
 =?utf-8?B?ZkpIbXN2WHppRnUvd3RMeEVRai8xcStBTEZ0RU9ZR1hQK2xFcEMwdS9YLzVa?=
 =?utf-8?B?aHl6Z1hoK2h1S0NvU0hYb1RhM0lYR01kZnRycmthcjBpYW0zK2g0b01Tekt3?=
 =?utf-8?B?VUltNGpMcUs0Nk5IWGpxU21BeW4yTXgyak9MU1lXZkIrNlJ6VXF1YnhOZWtY?=
 =?utf-8?B?RnFxRk5jbUVWbDZrcVFjcy9MV0ZhNnhrczJpWi9zVVBoQnluZVgrZE0vYlZp?=
 =?utf-8?B?Nml2cHBlc1JCUzhHTGZ6V3pxUUZQaVFhbVhSUC9LWnR3a0NHWHJ6UitLMmli?=
 =?utf-8?B?aS8xU1NPUjZBUDhlK0xXazNWRkpuMnpXMnorOTRUTEtSVzJsWittaGFObTFB?=
 =?utf-8?B?TnVLK0hCZGMzSXR3VEVqMXlNaElxY2ROOGhub013ZUxGSWtKWGRITXVDVGNR?=
 =?utf-8?B?ek9oMHg5aHc1SlhSMElyQkVFczNZZGRnVnNNcTV3LzFTYldXUGZRcVNac3JY?=
 =?utf-8?B?MldoYXAvNHU0R25WUXA0ckJTSHlBNnVHbXVjN3o4SkZCa09PZUpiV3ZqV1ZB?=
 =?utf-8?B?bzlNSDlGTHU0cjhwQ01pMFhTVzBhRktacGZsMklXSUpUc3V6Tk5kZGliSTRI?=
 =?utf-8?B?OUQzL2pVNHUvU3VIcVh1UGJxUndnU1ZwRHhEa00yY2MzaU42VlpLQk51Mk1s?=
 =?utf-8?B?TFlVMUVpTFZLMlJjZmw0eG82WXU3QVVpV3ZwQVRPR1VNc1BsNjUvYWhkbDRM?=
 =?utf-8?B?NEhKSXB1dk9uUnBGaFVvYWpSWHlIRlBlZWNOeGNLTDFqb2p1UlErWjc1VkRI?=
 =?utf-8?B?dzZmZ0JkRXVkeWtEdTRQbVIxVndVRDdiNVV2UVNTcDFPa1RYKy9pUTZia3JU?=
 =?utf-8?B?YnF4MjNqd21PNjFOQXVrYmZiQVZmTURKU040MDU2QXNwNFh2RHN6cGlIR3NN?=
 =?utf-8?B?Z3NmZ3NPc2ZCS3RzZXBTaTFudmVWaTM4MEtjLzNpUkpYQ3hnVXJJcXljQTd4?=
 =?utf-8?B?MU5Dd040MUxQQ2FwRlF2eUFGdmEvUmJzR2JxWWVPQnBHQ0VwNnpNcWVMKzBj?=
 =?utf-8?B?cmxCL1BTZ1BnUkZSVjg3dTczM210NTVwSHp5d1BDRHBpUUZsVHc5TzN4SEE5?=
 =?utf-8?B?VWEySjlEMTg0b2xxdUNBVDdnZG5KRm4vdmdidzdjWjdnYjlGcDNnRlhEbSs0?=
 =?utf-8?B?SEtZRmpkTkFHOTc1emt2QW5mcE9HR0tzWVBZai9xQXRSOXR5SmNaYkl1SE5j?=
 =?utf-8?B?QllYczlRVGhPWUo4RExvUjVrazErSVJHVzZBUFdJUHlYZ3hmdkZFc0pnMTl4?=
 =?utf-8?B?SDZlS2FFVkJUVTg4YXdIS3BqL3hrM3A3U2tHMnFobHZkYkppeEtWdXYxY3lw?=
 =?utf-8?B?cllWbWMwcUNmSkZhdnBwT1FkMmFRckJIZkpVbktEM3hyakpWY3Z4cmZSZnRx?=
 =?utf-8?B?L1ZsRWhYVFFmREJWd2Qvb3VYQVVRR3I3R3dTcmdkQSs3L3pFaFVsMVM0SnlU?=
 =?utf-8?B?UjVmdG5uK3BCV2wyNTZPT1FvV0R1bWFYdElmRllGbVN5d0NwazNEeEFMRGEz?=
 =?utf-8?B?VmxaeWxQMlh6b0hZZks3eEp5MDMzcGFDaEJrdysvMy9FTUIzRzE2dWpabXNZ?=
 =?utf-8?B?MUdmaFdkRFRjdlNDaDRHUVVOaHVDMFFuNnlKNzg1VHRxVVdvb1Z0aHFBNENx?=
 =?utf-8?Q?pTjk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:18.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b2602-41b8-4fee-c456-08de02b92746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
> 
> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
> CXL ports instead. This will iterate through the CXL topology from the
> erroring device through the downstream CXL Ports and Endpoints.
> 
> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v11->v12:
> - Cleaned up port discovery in cxl_do_recovery() (Dave)
> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
> 
> Changes in v10->v11:
> - pci_ers_merge_results() - Move to earlier patch
> ---
>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 7e8d63c32d72..45f92defca64 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>  
> +static int cxl_report_error_detected(struct device *dev, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);

Should probably check if dev_is_pci() first. I don't think it's an issue since
only ports under the root dport are being iterated, but I don't know if this would
trip up cxl_test.

> +	pci_ers_result_t vote, *result = data;
> +
> +	guard(device)(dev);
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
> +		if (!cxl_pci_drv_bound(pdev))
> +			return 0;
> +
> +		vote = cxl_error_detected(dev);
> +	} else {
> +		vote = cxl_port_error_detected(dev);
> +	}
> +
> +	*result = pci_ers_merge_result(*result, vote);
> +
> +	return 0;
> +}
> +
> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
> +{
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->parent_dport->dport_dev == dport_dev;
> +}
> +
> +static void cxl_walk_port(struct device *port_dev,
> +			  int (*cb)(struct device *, void *),
> +			  void *userdata)

This should just take a struct cxl_port * instead of device *. You always have the
struct cxl_port below and then pass in the &port->dev, only to just cast it back
to a struct cxl_port and never use the device pointer.

> +{
> +	struct cxl_dport *dport = NULL;
> +	struct cxl_port *port;
> +	unsigned long index;
> +
> +	if (!port_dev)
> +		return;
> +
> +	port = to_cxl_port(port_dev);
> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
> +		cb(port->uport_dev, userdata);
> +
> +	xa_for_each(&port->dports, index, dport)
> +	{
> +		struct device *child_port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
> +					match_port_by_parent_dport);
> +
> +		cb(dport->dport_dev, userdata);
> +
> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
> +	}
> +
> +	if (is_cxl_endpoint(port))
> +		cb(port->uport_dev->parent, userdata);
> +}
> +
>  static void cxl_do_recovery(struct device *dev)
>  {
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port = NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +		struct cxl_port *rp_port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		port = rp_port;
> +
> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct cxl_port *us_port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		port = us_port;
> +
> +	} else	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
> +		struct cxl_dev_state *cxlds;
> +
> +		if (!cxl_pci_drv_bound(pdev))
> +			return;
> +
> +		cxlds = pci_get_drvdata(pdev);
> +		port = cxlds->cxlmd->endpoint;
> +	}
> +
> +	if (!port) {
> +		dev_err(dev, "Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (cxl_error_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
>  }
>  
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)


