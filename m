Return-Path: <linux-pci+bounces-37587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65DEBB80C7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3F1B205BF
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DC5244660;
	Fri,  3 Oct 2025 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qnyi5FTG"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331B2DC767;
	Fri,  3 Oct 2025 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522360; cv=fail; b=OjaN/a/TH5egB7IztbfQZm6SXcA3LY3g7LUrAdecddfzJAapnCMgdx4RqsrLDa0ftEXvjluzR7rxW8FaNQfpNGWN88fBKbzEu3xt0p1RLn7KE1ayljSTXz/9GQ/hck3v1RZVQwd0Y/EEsHVhU3kBhJ3tcRnzKK+PDgABN5cIXbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522360; c=relaxed/simple;
	bh=L5yZVZBLzPCYR4DbBdGQ26gDNRicVkSBflVkPwm96as=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=btPw7oFXCNeks1S8uo0kLF2xOhuZGJkB2xhMc6k+osccTpyQhXhENlyaOlsVstpIZ6QCLkUYZLfK8KQ0gVLQMyIWvLwBaVgJ6047DiGW75toBYvKXeLgrYD/T57/vB7OK4IpIsbsReYXpPLGZqWaDUp6wZk+Y2j1GSkOPFUchXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qnyi5FTG; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw57bEvr33lhc9BB6sJ2ZwcsL1dv0L/n6UlaRcwWOZXktZjy6rqlvld7ceSJID3enhARolnlZ5dvXzg1OeghQ8+nIH34EDqGY69WHnGWuh/2SLwBmIzL1fsPhC3BeZuxLp0LwRakJXIWBkD9zYl0UfN4RHjXAQFlThDU95tsFsUWWL08F/0Zdws7anKiQxqxFeOgAlAZgp+JWyb3SuOOE7WGjwW0roCrICpCKut88ylXDBen91UsWC/Hmnf9j5TmMgIMiAJk3ubrbryDsGH4zyeT7215OQbYgdT7HwhA153cMQ93gi8bO5BsIHEU10wEZJK0ZD5DoifYFK6Q0D2c7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOXeVH07zvbjR4qIh2VrJ7En1npvYXotu7HNnrdGkP4=;
 b=S8D3gb8kBM3dL7uRHkW6s7eUasr1l33P/mb5xWKrZf+O/nXx+k26DJUMCGC8pA6HWYjW9hEq0vhKF5axe/pyezdm4xmF9AHNTW5Qg3a450lfxlPv24mZ06dy63zYFQlKjl6XqIMDgoncGS5zeUpnLM4LOyYertowPrOni39RAxigSH19yfXIsfEO55hqTQVcYrunGqmmMLOrNGrO2YjTGiLh8hOxYTuGdj13trG8kfM987uiPAB9jZy8rFME1LEyzEjVXRR7algUIC2Et5Z/uExjHakDYRzoRcVS8zAF2W5J1Paj3dRYmV/KXZAXf6d+vwAtkeESeRu9f/1H+Hd2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOXeVH07zvbjR4qIh2VrJ7En1npvYXotu7HNnrdGkP4=;
 b=Qnyi5FTGI1Qkp3OgPXksw2UanQJKMtWTV1K+fLsyurp526fENBDyomPol2z45cdZcnexy1oR3uLEtwZsYDdFhphi/93XmkmnTSh24wl6h7/R3zhVPgfKj7Do5KwtL3vksSyb+/RGs9gEZDin9mCVjGZi3Jjgr6Phb0TrMbc7m+k=
Received: from BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 3 Oct
 2025 20:12:25 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::49) by BL0PR05CA0022.outlook.office365.com
 (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 20:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:23 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:20 -0700
Message-ID: <03ee0a67-9f2f-40a2-aa47-e548fb800ab9@amd.com>
Date: Fri, 3 Oct 2025 15:12:20 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 21/25] CXL/PCI: Introduce CXL Port protocol error
 handlers
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
 <20250925223440.3539069-22-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-22-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f17e439-f5be-43f2-75ab-08de02b92a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXNCblp6WHBlUGI5bDFKMUN5Y1VxZy9OVThsQ25ucVFTWDZvelFaT2kwMW5X?=
 =?utf-8?B?bE44UG1neC92Nm4vdllSYWI2K2VJTUxSZ25QUFZEY2VuMjVLWDhmWTZRR3Zz?=
 =?utf-8?B?TngvVjlqbTdVKy9Lckg0VTd4UHdxakQvNi9BcVFFTGVXcFg0UDlrcHA4NHlV?=
 =?utf-8?B?ZktIaFA4UUk5TWtJZHh5ZWI1alFla0xZZVR0ZVFKRTFkeWlONE8wcElncnRU?=
 =?utf-8?B?REtMUkFDUmx4RGQ2enQzaUtQRVVEbHJmdFZ6MzRjcHVPbkhFNDhjSDc0Q0cr?=
 =?utf-8?B?NWVnZ2JkenozeW9oQnE3RmFGUm9ERjZ2THlyU0hBWTZ0d1ZVY2hqRndHNk54?=
 =?utf-8?B?ODJJTG1QUHQ4aEU4QzJzcU1hS29IbTRTQWtPd3o2bXFvRlpLc3ZDaTN5akFR?=
 =?utf-8?B?STNZNmtrTWI1RGRTellJbG9XeUFlblYrTmNsejV5V1NzTHV5Y1VqdDRlOFY4?=
 =?utf-8?B?eW9VYzRrSmZIRFpNc0dHc1pSWTZLRDhSby90b3V4VXk1c0NZUTJzaXJnalJ5?=
 =?utf-8?B?bnlVemJ0YnR0a05jYzZ0elpDdzk0TXhZYmtFZTlHcVFyeVdBWjZrdG1zZEdN?=
 =?utf-8?B?aHF1VU9jQS9odnhKWVBBSi9wSXNQWnpGTVZKU1JJM2Zkd3JNZ3NaNGpFeWhr?=
 =?utf-8?B?M3B2MUlsajBMQ2N1RXE2ZzlDN05uQkRGMjZ1dG9mUmQ2cHRDZzRRNC8rdGNk?=
 =?utf-8?B?K2ZxZGZVMDRWbTBZTjVuNTZETXVVY3g2TVpjVlNKblVzaTNXS3c2UGVBVjQv?=
 =?utf-8?B?VW1abmQ5Vlg4ekdlSzdycTRGWjRXRlVRTDV2YnBOK0JWY1BhdUpBU2NlOVIy?=
 =?utf-8?B?L3lQVVBkZVMxYldxVjREZUc2VWVkT2Z0bksvcUFyZUhnQlNOT3hBTlFoMnRO?=
 =?utf-8?B?K2xMOUxxUlIyQkFUQlVYbGpKVnJ6L0FMVWJhU1hJMHJkT09rMWRKZ004WmN5?=
 =?utf-8?B?eElFUWVsTnpOVTZLSFg5SUoyYUVyS3prMUUvaFJJcHcxTDJnTDZBMThHeUpn?=
 =?utf-8?B?K04rc3hFdXNBbURmTFg2MUtoTjF1UThDUzZVd0l0SS9LMUVoMXVEUWlEaThz?=
 =?utf-8?B?MGljY1ZjN1hDRzdHaDR0QkNCUzhwVFU3bUxWcUdSb0pNRXJSRHNkcTd6bjRv?=
 =?utf-8?B?NFExbGxtdFVlVmNSYnV2djd2SlpkSVYxZHdWSGJPcis4bVQ0NVJNZTFIMG03?=
 =?utf-8?B?dFQ3Y1RKMVg0TENTZjZhQXNYQUI1SlA1ZnhUQ1N2NjBqWmdVWmpHdlNYMW9L?=
 =?utf-8?B?RFl3OGJnYUFNQjVPaFpGVjF6aDFhaXBDTUlsV2o2WVM0S0taNjJqOWtoM2dE?=
 =?utf-8?B?S1dRTDg1WVdZcmwxUXFoNVVoY0tCa3ZEKytSZWZWMGRSRExZUHhmd1ZBMU5q?=
 =?utf-8?B?VEorOGp2ODZlTWpLVkNJNEFrcUpKNVJ4b1hBUnN1KysyNmltcWk2QTZCR29h?=
 =?utf-8?B?eFpiTGRlTndvUVBIOUVTZnpPUXBpRFBVS2hFTHJ5a0M4OHJSNDluYWtEcUhH?=
 =?utf-8?B?OXZwc0tBVFN3bHl5U3pNOXU2OThZNlQ5SGttc3Bkd2FSOFFtck0xYldiZEdL?=
 =?utf-8?B?RnRWNDh5bktlY2ZxZHFXZHV2UFJZaUFWM0dBUnRyMEpuVGZ6WHpwYitkd0VE?=
 =?utf-8?B?VHFFV21wbWNpbmxHdVZ4VnZuc2NnR2UyckNWUjFlZGlsSzdyUzVoM2o4dzVu?=
 =?utf-8?B?MG5qdERmeG1vUE1iUjNzOC9WdTZxb0RtWWR1YUJMdGF3aU13Ym1Wc05tZnZP?=
 =?utf-8?B?N0YzbERDWUEwWlRhVm5zdTdCbmJiTklvakYyNkg3Y05xNXA4VXkvMi9vdWJV?=
 =?utf-8?B?b1hHVFVZRnM4aktMQU0ycUdTVTVUZllGUTBxeC9qVEhHSlNMdDdvMEVHckpH?=
 =?utf-8?B?VDNNdWxxODBnRlpaajNqN1BpdEV4cG9RZU1WZDd1TFZQNnFsOGhuaXhGSHY1?=
 =?utf-8?B?S1draXlaVE1TVXRCUy9tK0tlWklUSEg3NVJ1T1N5ZTR6SEoxclNUSVB2RHFP?=
 =?utf-8?B?SDhJeFBDY3hES05LV003bjJnNkdjaTd6VTR2d1JrNjNxTXY4UUF2RE5oZFpy?=
 =?utf-8?B?RGhIai9TbVpoUitCaS9wbTV5R1lVVDJuYi9hQXVtZTVSdWhXMzJHNFA4bHlm?=
 =?utf-8?Q?1VDs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:23.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f17e439-f5be-43f2-75ab-08de02b92a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> Introduce CXL error handlers for CXL Port devices.
> 
> Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
> These will serve as the handlers for all CXL Port devices. Introduce
> cxl_get_ras_base() to provide the RAS base address needed by the handlers.
> 
> Update cxl_handle_proto_error() to call the CXL Port or CXL Endpoint
> handler depending on which CXL device reports the error.
> 
> Implement cxl_get_ras_base() to return the cached RAS register address of a
> CXL Root Port, CXL Downstream Port, or CXL Upstream Port.
> 
> Introduce get_pci_cxl_host_dev() to return the host responsible for
> releasing the RAS mapped resources. CXL endpoints do not use a host to
> manage its resources, allow for NULL in the case of an EP. Use reference
> count increment on the host to prevent resource release. Make the caller
> responsible for the reference decrement.
> 
> Update the AER driver's is_cxl_error() PCI type check because CXL Port
> devices are now supported.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/core.h       |  10 +++
>  drivers/cxl/core/port.c       |   7 +-
>  drivers/cxl/core/ras.c        | 159 ++++++++++++++++++++++++++++++++--
>  drivers/pci/pcie/aer_cxl_vh.c |   5 +-
>  4 files changed, 170 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 9ceff8acf844..3197a71bf7b8 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -156,6 +156,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>  void pci_cor_error_detected(struct pci_dev *pdev);
>  void cxl_cor_error_detected(struct device *dev);
>  pci_ers_result_t cxl_error_detected(struct device *dev);
> +void cxl_port_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_port_error_detected(struct device *dev);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -180,9 +182,17 @@ static inline pci_ers_result_t cxl_error_detected(struct device *dev)
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> +static inline void cxl_port_cor_error_detected(struct device *dev) { }
> +static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	return PCI_ERS_RESULT_NONE;

Same question as endpoint error handler on if this should be a PCI_ERS_RESULT_PANIC instead.

> +}
>  #endif // CONFIG_CXL_RAS

Wrong comment style.

>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 56fa4ac33e8b..f34a44abb2c9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1357,8 +1357,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1561,7 +1561,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */
> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  {
>  	struct device *dev;
>  
> @@ -1570,6 +1570,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  		return to_cxl_port(dev);
>  	return NULL;
>  }
> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
>  
>  static int update_decoder_targets(struct device *dev, void *data)
>  {
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 9acfe24ba3bb..7e8d63c32d72 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -250,6 +250,129 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>  }
>  
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport || !dport->dport_dev) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return port->uport_regs.ras;
> +	}
> +	}
> +
> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +static struct device *pci_to_cxl_dev(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return dport->dport_dev;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return port->uport_dev;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_dev_state *cxlds;
> +
> +		if (!cxl_pci_drv_bound(pdev))
> +			return NULL;
> +
> +		cxlds = pci_get_drvdata(pdev);
> +		return cxlds->dev;
> +	}
> +	}
> +
> +	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +/*
> + * Return 'struct device *' responsible for freeing pdev's CXL resources.
> + * Caller is responsible for reference count decrementing the return
> + * 'struct device *'.
> + *
> + * dev: Find the host of this dev
> + */
> +static struct device *get_cxl_host_dev(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return &port->dev;

I may just be tired, but won't the __free() action get called here unless you use no_free_ptr()?
You do the same thing with cxl_get_ras_base() and pci_to_cxl_dev() above, though I think it's the
intended behavior for the latter function.

