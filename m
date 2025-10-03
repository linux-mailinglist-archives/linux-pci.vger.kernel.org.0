Return-Path: <linux-pci+bounces-37584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1582BB80B5
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAAF1B206F1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438522A4DA;
	Fri,  3 Oct 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rv7/3iHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255121D3E6;
	Fri,  3 Oct 2025 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522342; cv=fail; b=bOUZ75cCsxf2YVkSD6e4Euwrm0/SeepeWHUaNCMC39ZdH6vSlOsQ8sQhQseYDREBV5gjD+AUHUmn0nehEQvf0f9pCfSVyxVyu46TEIe9vfI3TUt2BXQ2MA1DlGndl3PJ5d65k8KQfmIqPLRY+AGrJCRrNjVs4tMcdaltFnFTXJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522342; c=relaxed/simple;
	bh=hpTobk9SuFNfXN0USbekxIGfPgsHxfQhSSexqd2MrRU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=tTmBQQLSx2ykrpcWmwde9qU1vd6xb/LcoPsX5Pgqzdt5t6GL11QpqTiE66Imm3ct3r5cwi4VnZ2CfQ4x8ZQGMTliYT/972n7WurpMqOWpa8J08QC18S1MSSaF7PWdl0tJJ197VqYFdjr665nyV+lJjspIIJpRCjbFRjjLcbG5MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rv7/3iHO; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVn/ytkIiyowBDfwxomkrNjsGWnam2XWcBM7E6ig8uA3SSB2wic68JNyRpBaPMnnUB+xyd91NBfn9vWEmZrB/61GEibO6qHdrPVJzTL2QUPO4iFS65f8AUrT9/5t8BuDssRiuYg4DkOsqtvJimpXNxqqTiLpUTYtiMWAs++7C0SzRM4aEptkalBvZ1emb/bfV1YyGZDidcSrwy8TXe1Paq3suz7/S2sPS3SAysXPFToR4u+p1s+wnVbZJLSMCt9ZplMs36mSKMRRcAJPEh1HpfLFhwQ6eKQYIvyF8tCqQDlwsxPjJMpT34EPYi0Fgf6uVu4KiVIUJSd2e1zaA9sZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMKh2osKM5087le3W2SV5b7P39ppcqh0L37FNNH90rQ=;
 b=FcIazWRiHr3bfLZ+NawJrC6hlq/TUxJt+woJLbJbBssKWfdqa8a69jUaUCeoArcgGnmIfKwz5ovefJl0qMdBS/XMoX5f+zWV78CMtq6Y3hymXNo4ZoEJaWDd9yu2t8E6IGSsNVDT/XyxKAJZbxU2bNighMGq00cImTyfCyoHPP3VFdLkN2+oa7cNWBatRUUZLgSm49XHNGFgv5R9kAaL8z8MsuhGVZK1xdmEBkHf6hBd+Y+QFWsDbGO85ZrndJ5kFtO8A9G/GGRDgvOXTOjhCYrvlpSdaTFt8K0ztxAYg1ML8oXXGnTcdoRvw20/mhtaEQl8o2y3rpu0jNG2530Tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMKh2osKM5087le3W2SV5b7P39ppcqh0L37FNNH90rQ=;
 b=Rv7/3iHO45elgjn46+rFy1kYBvPbfchfaRgVgL3/7pw3dvNB5bQEH9x2YDW6xkUczsPmPYe0SbCUw7fFWczAvNujTaN7CcZykoLcyHZPKsYrsnDSimfIkYSdcxdi/0Idlt9+scbV4jgmrVn8xECtxCFGu7r8IWLEeaQc8j9rAmc=
Received: from BN9PR03CA0764.namprd03.prod.outlook.com (2603:10b6:408:13a::19)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Fri, 3 Oct
 2025 20:12:10 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::a4) by BN9PR03CA0764.outlook.office365.com
 (2603:10b6:408:13a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Fri,
 3 Oct 2025 20:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:09 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:06 -0700
Message-ID: <f70d062f-0889-4ae4-93f7-f2c7578b8bf3@amd.com>
Date: Fri, 3 Oct 2025 15:12:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 25/25] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
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
 <20250925223440.3539069-26-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-26-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 003093ed-8b75-434a-8318-08de02b92245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWtnc2FiNG5oTGQ0aTRkSTc5dGh1RkQvMW8zN2piSjk2K2h6a05FblZRcCtQ?=
 =?utf-8?B?dW54MS92TFlPVlBZSnJrVkdNR3ZaTjlOeVArc0FVdWJ5bGNaTzlPZjN1ZHEz?=
 =?utf-8?B?SGl2TVZNQUwyN29hRmJnR0pDejRFaDRSdkt4U3ROeU9WcFlnL0xmU3ZwVWJK?=
 =?utf-8?B?Ny94V05rT0lMSnJ0VXl0QWdhN25LVlQyb3psWlR0TytVTXg3ZzFkTDAxVm1x?=
 =?utf-8?B?K3BHOFpSMGFKTGN0ODFHdGFBcENkNkhSTFo3cFV1bFFYRXl4ak1UNDhvVGF1?=
 =?utf-8?B?RmJvK3k4SkdLTldrMHhtTGVWeDh3QktZem9qSnAvVnR1QUJ2S2NNS2ZiejBR?=
 =?utf-8?B?OVhIZ1dkM0MwS0J6Snk2ZlRHMEM4WHllbWgyRE1vL3o5amI2R0k2NjN3TDlo?=
 =?utf-8?B?Ry9wb3hRUjRTY2hlYVczNjlaelBMa0VycXV4aGlWRkpBblUzWGdEWHhsSjE1?=
 =?utf-8?B?VzJiMW9kRnRrSjhDY21pU1cyZEU1cDFWZklGRmR5b1l5RG1BUUlqM0VFeTU5?=
 =?utf-8?B?RDV0ZEI5S0FySFhJRWRMOXJGMHk4RDVuVTVWd0FzTGRjSkk3OXJuZEtkWnhz?=
 =?utf-8?B?NzNiazdSY0RkMlpIbFlxUEJRU1RjQ2xSQS9kQnlQOWQzczJiazlGSDNZbnh2?=
 =?utf-8?B?YldYc0Vzeit5WFJjM1psQW9jNGZTRCtSaFR1bkVvczZwMjNNOVhUdHVMcUVw?=
 =?utf-8?B?YzF6Zk0vSUI3NFRWVlB0TzJJa3V3dVErYVN3Rk4rVThnNmJtQittb295NDk2?=
 =?utf-8?B?YUQyN1pXaFVQQWpxQWVvMEZtMzQrZXMvYVZKdHNPaG9ySWg3RnYzOUhIb21u?=
 =?utf-8?B?T0lGakg5R2lkb1ZZT0NzelR3VlpqaEp0ODJyNGNFMjBzRHN3VFNqTXp2bnAy?=
 =?utf-8?B?SkNYbzMwS3ZEVWdkQ3VBa2xzVzV5YkJxWk9JdzZqNUZBeVl1R1JPT1Z4d3JS?=
 =?utf-8?B?dUpUMjdpelhEOFlnWGs1S096V1hBbzRLN2FkOWpNQ2JQMExCZzIzdm90Y3RC?=
 =?utf-8?B?NFRKL2pXYWI2MWJWaUZwanN5dE1takk3eVhlc3NkcXlRM3ZyQUk2UXpBK2ln?=
 =?utf-8?B?c3V2Y3A3bGFKZG5iVTNndENSSkNTdVowTWRnbWl3dGJOOXdyY0hjcE03Rm5Q?=
 =?utf-8?B?MGpETGoySXFhVG8xbHRoekJzYURQRnFxWlV0SERpZzFjREt3RlpWcGF5c0h3?=
 =?utf-8?B?WUlNcnNQa0ZheWZ4bDM4aGY4REtJOWdrbVgrM3RNaURjditHSGJYTVhOT2tV?=
 =?utf-8?B?WTVXZnd0STc2SHhFMW9DTkhMMGxzanppclBEcGxtbXh0bGVpZDJrcnQwa0Zl?=
 =?utf-8?B?OHZPNTlzN2RidXpTQld6OUd4emJWWmpQbDFBMGxXYVJkNVpQT01OaHFadHR0?=
 =?utf-8?B?R1JWY0Y0MnVWS0xSRGJRS1NVL2dGdmJOV2RxdEowRWtJVGhaV1d1TC93d0Fr?=
 =?utf-8?B?MG9hV0JHd2JoeWhLZGZuZEdveUczbldOZ3BWQUwvWnVjWlkwdmlBR3FCK2NO?=
 =?utf-8?B?WldHdnM5M0xsWWVkV2E0S1RLbURrMjBzOVBqWnFuQXZxcHZORytQUmZYbkJm?=
 =?utf-8?B?WHdxOE56SHFlcG12Vml1dUI5S2dCcWlHVjIxUXFjU0kvaTZOSFp0aEZLL05O?=
 =?utf-8?B?cTl6bVY4ZFJZdlhaMXRiRWUwV2NwdFlITU4xWFg3bTlZNTB1aHQ3UC9tVTlz?=
 =?utf-8?B?cmJWZGJxMTA3dGpnaDNIVzliQUpBRWp3TGFkTHMySG9aQzd5UGpGZjJZRmlY?=
 =?utf-8?B?S1NldnA3L1NPd2tmS2l0TCtiL3NnNEhtWGQ4L05IeG1aczdlZUs1aE9WejlH?=
 =?utf-8?B?QUhkTWw2RmE3Tmd3a2NsMkk2MHg1aDk1SVo0bzJPYjNvRmtweWNieGRTdjVp?=
 =?utf-8?B?VG12WTIzL3p5NFlXZ1Nxa3UwWk1qdnR1VXFBbHg3R0R1djhEWnVidEpyakdz?=
 =?utf-8?B?S0N1alduZnRhTDFVbU02YXduL0RsNm9LalMzRnlSSlA2c2x6dE5NeSttcC9C?=
 =?utf-8?B?TWlaMUo3QTFnK2EyMHhCZ200U1dOZ21TU20wdlFJdFdydW5yai9lYmF3T24w?=
 =?utf-8?B?czFabE9NVlQ2ZmtJa1hvWUVLRGhjaExabHBrUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:09.9944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003093ed-8b75-434a-8318-08de02b92245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> During CXL device cleanup the CXL PCIe Port device interrupts remain
> enabled. This potentially allows unnecessary interrupt processing on
> behalf of the CXL errors while the device is destroyed.
> 
> Disable CXL protocol errors by setting the CXL devices' AER mask register.
> 
> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
> Add to the AER service driver allowing other subsystems to use.
> 
> Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
> Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
> Endpoints. Follow the same "bottom-up" approach used during CXL Port
> teardown.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> ---
> 
> Changes in v11->v12:
> - Keep pci_aer_mask_internal_errors() in driver/pci/pcie/aer.c (Lukas)
> - Update commit description for pci_aer_mask_internal_errors()
> - Add check `if (port->parent_dport)` in delete_switch_port() (Terry)
> 
> Changes in v10->v11:
> - Removed guard() cxl_mask_proto_interrupts(). RP was blocking during
>   testing. (Terry)
> ---
>  drivers/cxl/core/core.h |  2 ++
>  drivers/cxl/core/port.c | 10 +++++++++-
>  drivers/cxl/core/ras.c  |  7 +++++++
>  drivers/pci/pcie/aer.c  | 21 +++++++++++++++++++++
>  include/linux/aer.h     |  2 ++
>  5 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3197a71bf7b8..db318a81034a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -158,6 +158,7 @@ void cxl_cor_error_detected(struct device *dev);
>  pci_ers_result_t cxl_error_detected(struct device *dev);
>  void cxl_port_cor_error_detected(struct device *dev);
>  pci_ers_result_t cxl_port_error_detected(struct device *dev);
> +void cxl_mask_proto_interrupts(struct device *dev);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -187,6 +188,7 @@ static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> +static inline void cxl_mask_proto_interrupts(struct device *dev) { }
>  #endif // CONFIG_CXL_RAS
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f34a44abb2c9..337a165e8dcd 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1434,6 +1434,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
>   */
>  static void delete_switch_port(struct cxl_port *port)
>  {
> +	cxl_mask_proto_interrupts(port->uport_dev);
> +	if (port->parent_dport)
> +		cxl_mask_proto_interrupts(port->parent_dport->dport_dev);
> +
>  	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
>  	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
>  	devm_release_action(port->dev.parent, unregister_port, port);
> @@ -1455,8 +1459,10 @@ static void del_dports(struct cxl_port *port)
>  
>  	device_lock_assert(&port->dev);
>  
> -	xa_for_each(&port->dports, index, dport)
> +	xa_for_each(&port->dports, index, dport) {
> +		cxl_mask_proto_interrupts(dport->dport_dev);

Should this call get moved into del_dport()? I think the dports can get
deleted as the downstream devices leave, which would skip masking the protocol interrupts
on said dports.

If that's not the case, then:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

>  		del_dport(dport);
> +	}


