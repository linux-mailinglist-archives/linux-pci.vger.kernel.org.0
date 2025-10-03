Return-Path: <linux-pci+bounces-37579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69EBB80A6
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB474E9A96
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430B244660;
	Fri,  3 Oct 2025 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="shxgX9Xg"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80F253355;
	Fri,  3 Oct 2025 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522316; cv=fail; b=nbyNohjSAjt5T89bwUCC/A9Eg93aZY6FTbRJWAWsCtz6kEnw07kizVVb1XJ7L9FdV2SWNn5XgVRJy+TmNcd/38TaMLf1YvSNCUaatfUJHzN25S9rtfErRHcOD4rP8vD4jDw2/g7J4znCXsM2C7zHGR+V86LgECRRKaCiXeQTc8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522316; c=relaxed/simple;
	bh=Uim7E6EWW6Lle0bD/JQY+dAOhva7W6lm3+l6u0DZE/4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=oGJ3y9tpA53yihexgKpavFuoRqn2Zv84mLtUyaNKTugO+QCKDtaSmya1lIXLJvUvNDO8y3iY511fw2YzpRIvH+DHF9BGLukODIvM8rMfvtuSPsgJctdhyetQCiRS5Y7Yh6O5SqyuPSvM89RkFI5prFrPqZ6DyNVVgWiy3FlEHWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=shxgX9Xg; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qpozk9OHScpFjcghf38HErE/tP+cOFcmKOXiSUQ6znbxmIaqnS5mfn+6W1qyQ5zAOOVq17jUiz0GzNtLftEGClvwDZt1cQ7hTmhKbHd2RG0ZvC1AjtjmWAhVxeiaLsGOs6yBkvwOXxdhxDgfMkAyY3boVlcI3M5lRussBs2JoN3s4cRX4lcdT2GGYAsIUPxv6jQmCFTeLOr/e4FEG7d8e2dOtNQ2tQFpbRvMFowr1amW4bFbrZ3mCk3FSflQSWCK2kEwJ9wr/mag60F9jZlVb5fClvGxQIzGF77VueEA0apRrBbMXClUh7dmzIW50iCu3jSajV8wA+TcTcaUcJRshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iSIv2OP4cDDvSOIMD8yePLO0ugYNNQK1+3PsOXjsuA=;
 b=pLJr5J8q16kFbgnM4JDaQtucpRGSWeOJ5ca4CrbgJ/wZay8pgPubWl5RbM+0aZIee6T16lEbTKJ7YC6/shrKyTsRKBCK8unOnp7aY/BfW+Itj2araOodPIezIOyF3fLZ9s09lNAkYXy29kZjcFFeQyvRrha7zB+3cKy1ZHNMX8+oLHTZVWlza9DAmBw5nawBofya3oVx7scziOLgN39Ky/S9OHeABlIk6JKwGcDrcMaKZFDOxmduDghNJwivuQOMNNwCcLuqlqN0gSoad8UgAoythZEPUTWHDXMzUTLKa3bd75YRAxx7+buWLjv0fNmn4vEvKedx6ZK11+OPN3+f3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iSIv2OP4cDDvSOIMD8yePLO0ugYNNQK1+3PsOXjsuA=;
 b=shxgX9XgLxXbhradYBr/WHb6vYHR3daqb6PNrTM507717dD7wRQpzc05UNmm+Ka0URRoMRFCiAEOxBYiiL4iTyu/O9JfJAC5WDmpoca29pu0QYtAOSQJaQLq98nKFA9SMTgBXhv5EtYzEjzdD39Xvndr6tQqsdpJHEuEv9EVhPw=
Received: from BN9PR03CA0329.namprd03.prod.outlook.com (2603:10b6:408:112::34)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 20:11:43 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::9a) by BN9PR03CA0329.outlook.office365.com
 (2603:10b6:408:112::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 20:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:43 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:41 -0700
Message-ID: <fd73dd2f-4988-423f-bceb-cd1a831a2a78@amd.com>
Date: Fri, 3 Oct 2025 15:11:41 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 09/25] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
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
 <20250925223440.3539069-10-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-10-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fda127-cdf1-44d7-dba8-08de02b91299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0c1WjcrTjBXbnJJYjVtZjFudUpXbm5MVGNHbG15SjFHUVZ1akdTOWlId1hH?=
 =?utf-8?B?bm5ydnhwL21MV1B4QlJNV3ZkRlJKeFd6M3laSWlPd1kvMktXeFFHVkZndzFr?=
 =?utf-8?B?RDRQckJRN0pwMjg4dXZOQ3VyNFZPMCtQeTBMeEMyR1AvWFBXMTJnUXNJd0pU?=
 =?utf-8?B?UTdlb3hNM1lCeUx5SThZZDB0U2VzT0gydVAyY2RmR1M2TUlwdFU4VHQyWDFs?=
 =?utf-8?B?SjZXeURFNC9YZnNOdkcvVGF1anFlWng3SDdpVk1ZK1FpeDJsQXM2QzBGRGNa?=
 =?utf-8?B?aDg2NXJVcklVWkhyMVp4d1A4R2ZtWU91MWdZMlpiMjFIMG5Tc20zcERCbGRS?=
 =?utf-8?B?V1l1MWhMdVVGc0QxNmdqUzY5bnRQV1hkZStQUUV6aUhrS2RlZHY3TnJYMjRI?=
 =?utf-8?B?Y2ovQU43M2trK0g3Q1RhZkF1bmtPTWE1cHJVTVV2cWxZL053VWxuMVNlRFZX?=
 =?utf-8?B?cXIvNjR6MGVhdjBQTVBZTjV0K2pYREpCNVNPV2pYMTFJejUwVU9WblVPRnZU?=
 =?utf-8?B?dnJMR3pFV0w5UGtFYnVwdWRhalNlL0JPUlNrQVRKZ0lGelplZjdpWFFpU0p6?=
 =?utf-8?B?RXZ5Zk0vbDBBQ3NLZUhMU08vOWVvcXY2NWhJMTlwZ2pnS2hVK1ByVjJ0UW1i?=
 =?utf-8?B?WWV4SjVTY2tTYzN6bFE4UGVZc0lxSVZXZWhLNGpxZ3hGVnNtMXNUZmptL2Yy?=
 =?utf-8?B?VWEvWUlVL0VLaDFuMC9xaWYzbFExWUFZZUt2a2gyYWZhQWtoakNOV2NNb3E4?=
 =?utf-8?B?UTR2ZE1DNmh4NjNLZzM0cFg1R1p3Y2kyMzJPa09VVjNmTWtaRk1iSFNTL2Fs?=
 =?utf-8?B?UzREcjY1STdwcDMwWEQ1d1ltNnNvNU1kRFRHVXRMNjRTZ2xOUWkrRDB6aWpa?=
 =?utf-8?B?elYya1dvWTlTd203Nmlkb3IrdG1VVXJGTWJTZW1XU0x0ZXI1d1MvMzdWWmw1?=
 =?utf-8?B?T2NPNWRpY0NIK1llTjg5cjRXVEFjNGVpMGgzc2RlOEI0ZHFHN3ZlbDBwdmRa?=
 =?utf-8?B?TFl1QjRuK0F0M1g1ZEdWZjRBYVIxUGNNSFRxRTJSYXZUay8yY2FQT2dRRTVm?=
 =?utf-8?B?Y0ljZVpIQUpGaDdxbi9ZWkhvR3oySDhTQ3VpZER2V1lTMWxweldJWitLSE1B?=
 =?utf-8?B?K3EyZ1lPVElGWVc2Rnp4eHFBQjg3SG91YVNkOHErWEFVQlhBUFU2bXk0T1p3?=
 =?utf-8?B?c3d6V2lmRlRLUXRrTzhxR1JMRlZTMi9BT0dyM3dDZDZqaFRyYVErRUhKL2Vo?=
 =?utf-8?B?RHdJZUJtZ3UwdlZ4ZkhzNWZZZ3QxdGlWcWhualZ4eGpIZU00a1Q3YnRRMzE4?=
 =?utf-8?B?ZlptM0dnSTZKSEd6eUloeHN4UzRVV3NOQ1VzcmdLei8rUEhFd1pNM1RUZ2dZ?=
 =?utf-8?B?TndSYnMxMWllVmtaVGxpYmFRTzRGdlNoYjNsWFdXZjdNNDU3OEVoSXNGQ1FN?=
 =?utf-8?B?TGRqajVud0FhamRUU25UdnVuRUVXek5HWUJuVnNXUHIyaFdCTDRwTGVRcVVZ?=
 =?utf-8?B?MVYycEhzUjNEbzg3ZjdrYmgzZ2QzMHNBSllESld3Zkt5VGNFOTh5SWVhRmRH?=
 =?utf-8?B?NjM5N0lQSTkzMVdGOWVlSzQ2U0VnQWdlQk5KOWg3QTU2RFBzTEJ4dWJrSEcz?=
 =?utf-8?B?cVY0cVRHaGVFTExIR29Ld2o2YW9xbW15VXpyc1d3ZzZJdWNzOUI3bEtXdTRX?=
 =?utf-8?B?TzBPWDkzRjRqWUVMRDV3cFhiR3FxKzUvb1F4bjlUREw4NXdCbkg1bkZjNUVB?=
 =?utf-8?B?dnE0MlovcUVlSWNidzdNK2FPVWZSRTdpcE5VcERSRHNBRUJkVVRDaitDVDlU?=
 =?utf-8?B?cDR4RGdocmo5Q2xkc2N3dFVVU0FBaGMybFIxY1hHd0hoZ1hETlh6VWdEMStP?=
 =?utf-8?B?dEpJWFpXVEdhbUZiOUxBTnBwME1DZy91R0ZJcUVVZExjUGFyeld4SjRmSVdZ?=
 =?utf-8?B?a0w2UlRJZit4dFQ3dS9xYVg3Y29JelVGRytJdWc4VHlPaFNiVmFPSjA0aVpL?=
 =?utf-8?B?UmpwcXMydG0vb0FKSjgxQ2xUTDcvck0xRG9TNFFsMkJwbDYvNjZvc2w5Szk5?=
 =?utf-8?B?TGwvbTBvTXBCb0R0QXpncWJPcThZb2l5dVFCb3FNOERuOWFtc1MrZzlmcFdT?=
 =?utf-8?Q?Jiqk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:43.7042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fda127-cdf1-44d7-dba8-08de02b91299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257

[snip]

> +/**
> + * struct aer_err_info - AER Error Information
> + * @dev: Devices reporting error
> + * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
> + * @error_devnum: Number of devices reporting an error
> + * @level: printk level to use in logging
> + * @id: Value from register PCI_ERR_ROOT_ERR_SRC
> + * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
> + * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
> + * @multi_error_valid: If multiple errors are reported
> + * @first_error: First reported error
> + * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
> + * @tlp_header_valid: Indicates if TLP field contains error information
> + * @status: COR/UNCOR error status
> + * @mask: COR/UNCOR mask
> + * @tlp: Transaction packet information
> + */
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
> @@ -621,7 +638,8 @@ struct aer_err_info {
>  	unsigned int multi_error_valid:1;
>  
>  	unsigned int first_error:5;
> -	unsigned int __pad2:2;
> +	unsigned int __pad2:1;
> +	bool is_cxl:1;                  /* CXL or PCI bus error? */
>  	unsigned int tlp_header_valid:1;
>  
>  	unsigned int status;		/* COR/UNCOR Error Status */

I'd get rid of the comments after the members since it's the exact same thing as the kernel
doc above the struct.

> @@ -632,6 +650,11 @@ struct aer_err_info {
>  int aer_get_device_error_info(struct aer_err_info *info, int i);
>  void aer_print_error(struct aer_err_info *info, int i);
>  
> +static inline const char *aer_err_bus(struct aer_err_info *info)
> +{
> +	return info->is_cxl ? "CXL" : "PCIe";
> +}
> +
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
>  		      struct pcie_tlp_log *log);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6e5c9efe2920..befa73ace9bb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
>  	struct pci_dev *dev;
>  	int layer, agent, id;
>  	const char *level = info->level;
> +	const char *bus_type = aer_err_bus(info);
>  
>  	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
>  		return;
> @@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
>  	id = pci_dev_id(dev);
>  
>  	pci_dev_aer_stats_incr(dev, info);
> -	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
> +	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  
>  	if (!info->ratelimit_print[i])
>  		return;
>  
>  	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> -			aer_error_severity_string[info->severity]);
> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +			bus_type, aer_error_severity_string[info->severity]);
>  		goto out;
>  	}
>  
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		   aer_error_severity_string[info->severity],
> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
> +		   bus_type, aer_error_severity_string[info->severity],
>  		   aer_error_layer[layer], aer_agent_string[agent]);
>  
>  	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> @@ -895,6 +896,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
> +	const char *bus_type;
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info = {
> @@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	info.status = status;
>  	info.mask = mask;
> +	info.is_cxl = pcie_is_cxl(dev);
> +
> +	bus_type = aer_err_bus(&info);
>  
>  	pci_dev_aer_stats_incr(dev, &info);
> -	trace_aer_event(pci_name(dev), (status & ~mask),
> +	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  
>  	if (!aer_ratelimit(dev, info.severity))
> @@ -1278,6 +1283,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  	/* Must reset in this function */
>  	info->status = 0;
>  	info->tlp_header_valid = 0;
> +	info->is_cxl = pcie_is_cxl(dev);
>  

So am I right in assuming every AER error that occurs while the link is trained
as a CXL link will be reported as a CXL error? Sorry if this is a stupid question,
but is it possible for a PCIe error to occur or does CXL.io just replace the PCIe
protocol once the link is trained as CXL?

If so, do we not care if the error is a PCIe-level error and just report it as
a CXL error anyway?

Sorry if you've already hashed all of this out, but I figured I'd ask just to make sure.

