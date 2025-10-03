Return-Path: <linux-pci+bounces-37586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2EBB80C4
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 854204E855E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F5238C23;
	Fri,  3 Oct 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LlpuHLqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE224C669;
	Fri,  3 Oct 2025 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522353; cv=fail; b=qX7NWwDIRSPyt1oyDi2sJ7mKULgY55656f6B3FdPnGAo6PvsMJozM8Oaju22BMdkxm0uc6UYMOiWPIblnFwul5V0fVRkFQLLnlKf4V0oS1RwrW6jb8t/5zbPqW1mPbcZbxssUu+Am4QOhPhccMnZ9MDSAa9W928esmQqf0GYhVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522353; c=relaxed/simple;
	bh=oJO66YWbaE3RS8zzegOjX5gX3bRcCHOY4qmhc62gzMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=r4tSf2ByD5VdCLjQF0Y1zYPV4d9F+HIBbYotC2Q5BcTPbtur9KUU63NiCn+WhIevmkx3n2NrTpdyzv2Vnlne4BW8+tt5hBgoIGOtHbKTh0eHsNlwxTJs+tUg1etisEr1rz7wWsKXUmeQXZmr/07x/pQQaXWUZFNnsm7H0t3/D+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LlpuHLqU; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOw6W63P4g1K0MeraNYQ987mH4ysw+mlIy7ieXHJT8+eCSxkg2s3WBM3YxkwFV9M6T7GJBruuqgWFoe95Yvvvpijaj859J2K5tE2uSi2SP9wXgq2cKXODtYnpaj+rCwjVjsBUcI/XAR0CwCRWY3m3cAqAImh0LqSVAZrLf0uAwK9q45VAK7+yIGePFVA6Bz+U6hQjUsFgIPTfC6wYHy6z5mUmieGTUZJ5oTpZemXUCeJUuYS9uHuRLt4wC9UQqPhKZugSnfWq/xa6Gz6pE6hS3rN15Oq86Fydm5E7HKdtIMsnpKqSk8rVjxpKgRalst8V1XWzDKYl+vMP979UC5XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9HLhMNw0LIl/MrXDpZeFZA+Azoq2aOa5x4N8nKseSI=;
 b=CWhBxDbCDpQ1fxdXaqeg+zirJ+YbBHFDLPdG5+q44z95+txMG8lzDUkR8kus4wkNUA7q1JkKodrwzFOXvVySwfd6l7ZIzo3V1ozpx5lUX37cLrG8igk1hyT+8GB3RX1dvSXuG5Z7wwYFWpMtIlGIkfBtDlncLUVSKhx85szO07+3eXApXN8ubxt1w9KPFUU2zhZfiBA5ZPCzn5GuI820JuxhFXOaKrYNregfhRxSgCAcZ0pnlfIIViE6KxmEa6kubDtpnQ3qI+QtbM0y3DqQ4ON1B8Mp0YpBgSMJEM0rREl87lFGmQjkY7JlQRfTaD/ORXQy+eL/pYKkxG1Se+qnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9HLhMNw0LIl/MrXDpZeFZA+Azoq2aOa5x4N8nKseSI=;
 b=LlpuHLqUVs4SnCau9nsCuI/vU6FZ26NT+MXDUORrLmAhs3Wvwgezm6V30E3tYaRqaL+h3ik0ZYhr2pCSvcmLvMeHNe8IW7SdJ6Ausjisam1N3Eg8sEiudA1kGW7L/ssjr2cmn8GLFaL9/mwAPqnilLxs038MXt3orLtwQQNMblk=
Received: from BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:12:28 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::6c) by BL0PR05CA0001.outlook.office365.com
 (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Fri,
 3 Oct 2025 20:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:28 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:25 -0700
Message-ID: <c38af7bc-140c-419f-9071-08eed448e585@amd.com>
Date: Fri, 3 Oct 2025 15:12:25 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 20/25] PCI/AER: Dequeue forwarded CXL error
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
 <20250925223440.3539069-21-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-21-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: be64b28a-7757-4df4-cc70-08de02b92d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVRKaUp2Yy83dEtYMk9RdkpoQSs1ejZubjY5TVlSWTF0aGpuci9SZ0FPOEtl?=
 =?utf-8?B?ajZaSEFPVExObzJtZXZnUktzOHB6RmVvaC96WFZwTlQ3cHlIUmJ1WGhiL2Ny?=
 =?utf-8?B?aTVaeXVIc0dJY2xCQk14WFYwTS9LSTl4b3BVZzJCWTUweW1xNk5PNFRLeDVa?=
 =?utf-8?B?blVOcWVMRVFsdTJDUkVDd3pjNFRwTWQxNGxvUGozZDRmeWRnSnBrajRBQTVs?=
 =?utf-8?B?SGJYVjZNaWhRb3FaK1lqQVRVY3IwQktpNGFPMWowclJLNFBkRVFGR2FyRThI?=
 =?utf-8?B?NVNxZjJUbVpwRjhFMnJCVXBzUWRIWHVoZE1abHhwQVpSM0MzMVdvNThFNDVk?=
 =?utf-8?B?ME1CSXdXSEpmUmdHanYxWVlMckhkK2xaeDFIWXBzM3EvdUl3VThSMVorblZI?=
 =?utf-8?B?UnhRNFd6b2NxM1hEMUVJSGdjOUNURkZtZ2dIWTkxWCs4bUJSYmZ4WDl6c2w5?=
 =?utf-8?B?dkNIQTdpV2dXSmtsNnQ5OFRZeld2blNVbkUzOWRNWHZZbXp1ajBPUVVOZGlq?=
 =?utf-8?B?VHRoeE5FUTRpdlRYZlJxTkpCY2RFOXkwN0IyNWtFY0h3Sm90WUNVMXN3TlBm?=
 =?utf-8?B?MnFNU0h5a0NBZmRHUVBaaDZoUlJEMnpncnM0WC9lYTFLZzc2RHIrd3dEOWV1?=
 =?utf-8?B?eitUdXB4K29vT3dqVHR0S2pBR0psTUxoWTVTRFhOYnJIUVMvM080eVVXZ3FM?=
 =?utf-8?B?bE1OeFU4UUtHVTlNZ01RU0dqZ1EyMHRpcUhhdk1ZQTBlWHFmL1BWRGp0Lzhl?=
 =?utf-8?B?amNvVnQ3UTZBTHBrRnk4YTVXd1Q5bDdhOERpREY1dE8zSTh5cUtVUSsxd3hC?=
 =?utf-8?B?bDJaRVFVZVNvMlhJRkVJTE4xM2FXczdKQ3VpQk1FRTlXWDlLNjBoSzg2WWpX?=
 =?utf-8?B?aTYvVzFNYktVZ2RkS0ZnVmtsRDc2NUlpekZqNG1mWW9wNnpRa2ErV0RuMWNi?=
 =?utf-8?B?RnRkNGx5Mis1YUdza1FTS2Z5eUlNMEVZanRlcSsveml4NkJudCtyTmJhVnB0?=
 =?utf-8?B?WC9yTWZoaEliTTdrdlVDSFo5RWliMUpWdTRzeWVMbTVjQ200Q1VOMmdycUJa?=
 =?utf-8?B?WCswczFYYm9kYlRyNzdwcE9Jd3VjYUIzSmRCVElvYmVBYUI1c0VZQU9HK0lt?=
 =?utf-8?B?TURlVnNhR2lESmJORmo4cmhVSXpueUJSS3NlYm5VK1F0aXI0dXlhMHJ2ZEVF?=
 =?utf-8?B?UUw4akJSYURUNjg4dGVsdE5DRUJHN0h2c2pmdkVlMndKRXc2dkFuZ0t3RDI0?=
 =?utf-8?B?aW5vcGhyTUpJbnRHcHpWc25ZV0dCSEc0ZEtBc3FZZzZxRy9hbThINy9rbi9I?=
 =?utf-8?B?TlE3UUdjV24xdTIwa3V0dTRhYmFyM3plbmZscVMxUGpqMlJTZFc4UUZRUm10?=
 =?utf-8?B?NHU5TTNQak1BUTlaeXpIMkhYRExLUGw1cFZoSnFhYW9iTTQvZVN1TEhicDhJ?=
 =?utf-8?B?ZVBzM1FRckFwTFNGNmtuaFFiNmNoVFBaRmdsdXlvbHRYMTBsd1oxSlVBU1pn?=
 =?utf-8?B?bk5qL3VqNjlvYzRXWXJGNFdxbUNVc0kveFd5VVQ2dnNYRVN2ZHN2dHdJN3lV?=
 =?utf-8?B?dy9DYm13cXIwNHpzV1ZOMjNUSHNpdVNqaEE5a003cnN1U0dzd2hxdysxUDV1?=
 =?utf-8?B?QUlqeVJHSFNLaXQ3c2JQRXl4SEU4Y0hwV2VBbHpEcC8zYTVrcm1IYk56MndN?=
 =?utf-8?B?SUJ1ZVErbGpibWJISHJYUGRnWmN0V2RMMHVVMnVrZUFjUDVjZEdGaDRudm5t?=
 =?utf-8?B?U25lWHVhb3RpZmh0T1Y5VytFeGRzRjhTSnRyWmIrVUIyejhGdXNDWWFtSy9p?=
 =?utf-8?B?Ri9TYXFONTdIaUNQRzdhYys0Z1E4Q0hlL0tBS2RROW84cEVqNHIzNmlxME5U?=
 =?utf-8?B?alZtT1U0UjQzRkxmUHUxMDl5Q2lGRXZVQU1idWdMTHFQanM0MjFmTlRNMm1x?=
 =?utf-8?B?YUpweDlvak1IVEgwMVFzcGZYdjBBZ0xmSlNxYXBoRVdEVHA5L1dnaU5RQ011?=
 =?utf-8?B?UkR2SjJYdlBLSWpucHN5bGNBNUpYOHdDMTJZUm1PVmlEVFBUSVpmenZsdE1L?=
 =?utf-8?B?M1hJcVhCNXE5cUhmb0h5d29seVFwRVZnSFpiVnFpU2hNcmZMRkptbE40bzN1?=
 =?utf-8?Q?kNgk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:28.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be64b28a-7757-4df4-cc70-08de02b92d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

[snip]

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1a4f61caa0db..c8f17233a18e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");

Probably should just use EXPORT_SYMBOL_GPL() here. Doesn't make sense to export in the CXL namespace
for a non-CXL specific function.

>  #endif
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 22e8f9a18a09..189b22ab2b1b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -692,16 +692,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>  void pci_rcec_init(struct pci_dev *dev);
>  void pci_rcec_exit(struct pci_dev *dev);
>  void pcie_link_rcec(struct pci_dev *rcec);
> -void pcie_walk_rcec(struct pci_dev *rcec,
> -		    int (*cb)(struct pci_dev *, void *),
> -		    void *userdata);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
> -				  int (*cb)(struct pci_dev *, void *),
> -				  void *userdata) { }
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> @@ -1081,7 +1075,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ccefbcfe5145..e018531f5982 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>  
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index d0bcd141ac9c..fb6cf6449a1d 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>  
>  	walk_rcec(walk_rcec_helper, &rcec_data);
>  }
> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");

Same thing as above?

>  
>  void pci_rcec_init(struct pci_dev *dev)
>  {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 6b2c87d1b5b6..64aef69fb546 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -66,6 +66,7 @@ struct cxl_proto_err_work_data {
>  
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
> @@ -73,6 +74,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index bc3a7b6d0f94..b8e36bde346c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1825,6 +1825,9 @@ extern bool pcie_ports_native;
>  
>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  			  bool use_lt);
> +void pcie_walk_rcec(struct pci_dev *rcec,
> +		    int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #else
>  #define pcie_ports_disabled	true
>  #define pcie_ports_native	false
> @@ -1835,8 +1838,14 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
> +				  int (*cb)(struct pci_dev *, void *),
> +				  void *userdata) { }
>  #endif
>  
> +void pcie_clear_device_status(struct pci_dev *dev);
> +
>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


