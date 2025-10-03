Return-Path: <linux-pci+bounces-37588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54164BB80CA
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB58F4EA55E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFA242925;
	Fri,  3 Oct 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1mJqAhWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17E23D7FF;
	Fri,  3 Oct 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522379; cv=fail; b=VxCVftlPQ4Nnq+OQAml6lNnYIBLK24z3rqjDx5lh498dwBd2Eo7lFdDOXZjMF6YGXDO7RRp33fIBrHfnou42/vxQJ/uM+Dk7wmY+/MRyi+aorCYJjpH/P+NSw0hNYrI/3VLfi66wATvEhID355KNjInuMLRLJE5z+0wUpS5QT1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522379; c=relaxed/simple;
	bh=wVE72S6mpi6qahpgCcWEpNQBF7M+NWtCAH3hprD32sc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Ymgt82RdfxXH3ox1XxQftXPTFbnxgRjLfuYXYFgwhjIgFr2wKp5gFCEOE1Py4+ck/dfsVofaJZGnGORX4dqLCjnrbBt7CFBfF8emHgUOOSeGQDPChRmafLFnvgX0q3UPqRdVNKklNYyb7qJbsVmx1ia5bIeNQxeka6fmvbwzr8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1mJqAhWc; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJBh0BlThyWVz3fKwt5BOiPWla4bt+PWgS+y6dHSarg6Eda0Gk2cRN0+msAO/lOVmE8hbg2L1kw1PlVKxM2YVlm655Eo232EoBIJ7/4bV2BriLyy/Cb1/HqRVV2B2llz+uoAFHjVl/0/ydR6ZQJvnzIpllx18S8fMY7VRsxKPcImHFFeWKGxBHGAd5p8WvZPM3CcqNpZF+mx48khtJJ+qbgwdnskUeHgVfZGrGjFKtzjrp9REVjLtRU2uyAdaOZIqqxyFvHae+xDq5t71ef4kztcmHbEOdcnS/A1WEMPNHKTFaElEX7wfJVAc+Z4vPluqJE0QT2V8tvnHZcGZuKqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d141tr5BlliekqMAUaP58jUokBNkgGXIKeBk6Xpr59k=;
 b=ZWwanfy7H66fpyZYQYg6XnOeQ2qN5ieX/WgePDylQclDZAvKkWejJthQ1xXGy/H5ldWfVMpWE1vpNcoaJlA6mfhTHVngI69DCkjQ1fUOGpOT82Q+Z0qJ0WKfGdaFscgIhnaHTIVuL0mHnf60R7sEDXTXVXUqPvlw5jNlMtAzZFLFR2VaI4V6gL5BU6qiDvwgBvrZAdfY8TRTcih1PzYvxVd3I7lCOS8qkHZHabWbXuzT75CZkwxl/vrbQnIr782PcgksLL8eEOHTCmWbek4inE4tfSIkEfl/eRmy01DpMhZA/bp1D8Um2LiSUo7j4KhznpvbnSbuiDQnAMcGOnnK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d141tr5BlliekqMAUaP58jUokBNkgGXIKeBk6Xpr59k=;
 b=1mJqAhWcgq2f2edSBTihb6zD7CsxeFwdGCgTpSipRcTIXF6UwJ2bBjaBYPs7B7GIKvNG5C+pPSERC7/409zsk5KFRv0O7eJiYH4aInDRVZ8H8DX/eyVtgjTZThG/9VsjPLMXpngGHHgRNAXFqwCGwX5x5xyqyticm+D2iruaZCY=
Received: from DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::12) by
 DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Fri, 3 Oct 2025 20:12:53 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::3b) by DSZP220CA0005.outlook.office365.com
 (2603:10b6:5:280::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 20:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:53 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:46 -0700
Message-ID: <161e558a-11ae-4b57-ad4f-7736e23da1c0@amd.com>
Date: Fri, 3 Oct 2025 15:12:46 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 17/25] cxl/pci: Introduce CXL Endpoint protocol error
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
 <20250925223440.3539069-18-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-18-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cd6fd8-9dd3-4088-acb0-08de02b93c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2xzRmpLSGo0UDRMVXJjZzV2aDhwaUZvTTBCbEtsQkUxSENNS0ZjU1A1ZHpR?=
 =?utf-8?B?bnJqRTVQQk5scEczQjBIWXN5R2pBaWE4cjZKNTZnc2FFbWJ5emlIMjZ5WEZC?=
 =?utf-8?B?YkZGYnQ5Vm5zTGtXWEU4aWdURHRiTjZ0L05SOU9zSFh0QzNUQis4dWFwS2Zl?=
 =?utf-8?B?UzVBNTJubnZjSjlrTHJkYVB1NThCdkpKMFBIYy96UVVrWU5mV3Q3SjZDcC9x?=
 =?utf-8?B?cHNIRHR2Ylk1SWlHbkljemtVQ3JNamtKaDhiNHdyZDM4MFBDYldneWN6bnVH?=
 =?utf-8?B?eU1SZDBXMlB1SzRwdjNuaTJFSnRJdE5pV3lkSjFYVkdaMkY0SHcyZm1ybVZr?=
 =?utf-8?B?amNCNXNZZkxreXlQd3pXRWxEMUpERTc2ek1sSGdEdUVvOU1jOW9mR3M2Tjdi?=
 =?utf-8?B?YmFWZXZpbXFhMWZ4MUdyRjhtK05EMW4wcG5zakNWa1YvMXhqSHBXbVFQR0F0?=
 =?utf-8?B?dmJPUUFPbXNrOCtFajloY3NOcmJmclJza3BETFllOURMTWhsbzNjRENhRHZx?=
 =?utf-8?B?T0VDZ21DR3NXQkh1cjluNm9UMVVOSkg1MTJVNTRJMXhBb3pEL096bGp4NEtv?=
 =?utf-8?B?ZnVuVElrMHN0Ukk4NkR5cFVVOXRwdUZNaXFyWGxFYlR4UGRMTURVeVI2TkhO?=
 =?utf-8?B?N3lYN1Fpb3A5V2VIMEpVYlRSYTRnYS9TZFkyOXA5VlVpek1tODVTMXlUTUNG?=
 =?utf-8?B?MS8wQURydUNQRE5EdXhUYzU0bU1qMEJFeVM1WFNPektSdVZRVWFwNnR1Wkhs?=
 =?utf-8?B?T0FhRndlTHk4K0FEL0xVYWRPSENiT0Q5OGZkbUJFUzNSb0lvbklRdjFCYVAv?=
 =?utf-8?B?aG8vN1ZtWUM5TVlvZ0NvWGoxaW84cWxJdEVQKzBvZE50OTFEMXhRc2doMXYx?=
 =?utf-8?B?Nm9vV0o3bWRYS2FDdEkwWmh1enFZTWtmZUJ2aGdmNFR1RmlNQVBsTlNJUjZp?=
 =?utf-8?B?MS9YdVNRVXNVMEM0RTJzZnpaSzc1UWZtUnFzYURGTk5iNWdMOXlOcC82Y3hU?=
 =?utf-8?B?UmE5WW1HQ1dEbkR6b3dxRGYxdlU4bWo2VEtmdWJYY1JWUFVBTUhlR2VMRVhl?=
 =?utf-8?B?Z0FBdlZOSm9qK2tPM2VKL2VXTVpHNlNaYm90OFhOaFF3NzNhMEtBSmUyY2ZL?=
 =?utf-8?B?ak5mNTk4bWZRRlZVMTEvWjJ0VW1DT3VVMUV6bGFHZUNGK1JzcWNtcCtTS0hZ?=
 =?utf-8?B?cHozRDIyQ3NySGdsamhxaFcvU3djSUNaWU9GbENyT01QVWhkNmMwYnhabnpO?=
 =?utf-8?B?Z1dDU1ZQbFVmUm9vK2krRDlNSW5xQkI4eS9ZVjZpUUFpbUhpWVJRUTFCMTY1?=
 =?utf-8?B?cVlsTXBab0Ura2ZxQVhFb0pka3RNMjVFTGdiT00rTElGaSthK1IvNEFTSTJE?=
 =?utf-8?B?L3N3NFR3M2x4SzJqQXRXT3pKYlhXUjdRMTlDY1hZTXVmQUQyOUpIaXJqWTNX?=
 =?utf-8?B?WE1rYjRrMFlNdWdMVUt6QW85bXBrNHBIM0MvZXNCUFhFMjZ0YUgwdCtqWGp0?=
 =?utf-8?B?cWNXcEZ4eTRvRmlUeEU3ZHVFSGN2U3RvcGhoZEVDby9xc0VzNXRnMVV5UXVo?=
 =?utf-8?B?QlJ6VmFOaytOWUNUKzRjUmhZT21heW9OemxFVVdjdGMzMHZFdytqb3pXbk1m?=
 =?utf-8?B?eEs3c0NkWEliUk1qazdmRXRoakJKcHYwTU9CMUlwKzhURHV4dEdJblhZVldq?=
 =?utf-8?B?by80Y0c2aFExV0JFZy94MWJ4OGRSTE5KWkdDbEQrY3diSWRqakh5RUEwZ1RK?=
 =?utf-8?B?NDkwbVRNcGgwQ1plOHV1SFZKeWdwZ1pneGg4LzJaeGFmaGF1bGFxcVl5djFx?=
 =?utf-8?B?K0MxS3NKWGpzZGY1bEZTL3F1a2xISVZwSkhsajRrU01CcGJjQVFRbjBkdXdq?=
 =?utf-8?B?a2xweFBaK2RqemlZUERNcVY2amR3UXFLQ1lzWllnOGsxOFAycVZBS3Bncysz?=
 =?utf-8?B?MmRFakdDSU1BOFFzdEFSUWtIMm5jSHBBQThkQVJsbXFNSjk5NVYzeFY3YVlY?=
 =?utf-8?B?N25sTFQ5ZnB5Sk1JNHpHbVF6QTRCSmxRQWNJOFM5SlJNRFZQTCs1R25xS3ZB?=
 =?utf-8?B?Y2NrekxFSHRUU3FWWlF2ZzMxUDA1eG52Tlp3OEQ1ZUR6K2ExbDdObGpoTVpF?=
 =?utf-8?Q?2xhY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:53.8453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cd6fd8-9dd3-4088-acb0-08de02b93c6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> CXL Endpoint protocol errors are currently handled using PCI error
> handlers. The CXL Endpoint requires CXL specific handling in the case of
> uncorrectable error (UCE) handling not provided by the PCI handlers.
> 
> Add CXL specific handlers for CXL Endpoints. Rename the existing
> cxl_error_handlers to be pci_error_handlers to more correctly indicate
> the error type and follow naming consistency.
> 
> The PCI handlers will be called if the CXL device is not trained for
> alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
> CXL UCE handlers.
> 
> The existing EP UCE handler includes checks for various results. These are
> no longer needed because CXL UCE recovery will not be attempted. Implement
> cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
> CXL UCE handler is called by cxl_do_recovery() that acts on the return
> value. In the case of the PCI handler path, call panic() if the result is
> PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---
> 
> Changes in v11->v12:
> - None
> 
> Changes in v10->v11:
> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
> - cxl_error_detected() - Remove extra line (Shiju)
> - Changes moved to core/ras.c (Terry)
> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
> - Move #include "pci.h from cxl.h to core.h (Terry)
> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
> ---
>  drivers/cxl/core/core.h |  17 +++++++
>  drivers/cxl/core/ras.c  | 110 +++++++++++++++++++---------------------
>  drivers/cxl/cxlpci.h    |  15 ------
>  drivers/cxl/pci.c       |   9 ++--
>  4 files changed, 75 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 8c51a2631716..74c64d458f12 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -6,6 +6,7 @@
>  
>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
> +#include <linux/pci.h>
>  
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> @@ -150,6 +151,11 @@ void cxl_ras_exit(void);
>  void cxl_switch_port_init_ras(struct cxl_port *port);
>  void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error);
> +void pci_cor_error_detected(struct pci_dev *pdev);
> +void cxl_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_error_detected(struct device *dev);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -163,6 +169,17 @@ static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>  static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  						struct device *host) { }
> +static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +						  pci_channel_state_t error)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
> +static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
> +static inline void cxl_cor_error_detected(struct device *dev) { }
> +static inline pci_ers_result_t cxl_error_detected(struct device *dev)
> +{
> +	return PCI_ERS_RESULT_NONE;

My understanding is this only occurs for uncorrectable errors, so should this be upgraded to
a PCI_ERS_RESULT_PANIC? If uncorrectable errors == system panic, I would expect that to be the
case even if we don't have the code to handle the error built.

I guess it's really a question of how safe you want to be. Is it ok to let uncorrectable errors
propagate when the support is missing, or do we always panic regardless of handling code?

> +}
>  #endif // CONFIG_CXL_RAS
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 14a434bd68f0..39472d82d586 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -129,7 +129,7 @@ void cxl_ras_exit(void)
>  }
>  
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>  
>  #ifdef CONFIG_CXL_RCH_RAS
>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> @@ -371,7 +371,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -380,13 +380,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
>  
>  	if (!ras_base) {
>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
> -		return false;
> +		return PCI_ERS_RESULT_NONE;

Same idea as above. I would assume since we can't tell the severity of the error we would
just treat it as the worst case scenario.


