Return-Path: <linux-pci+bounces-24845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70147A731AE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 13:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78BF176DD4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED62135A6;
	Thu, 27 Mar 2025 12:03:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2130.outbound.protection.outlook.com [40.107.215.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C01B960;
	Thu, 27 Mar 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743077003; cv=fail; b=k6dHno3ZUPD/HjdpF7vqTFU/LgUAOGRh+Y0BA+dsluP4UMSLF/c63VnZ7nKLfVIuM5zH+Pm82jZr4yWyPTiyWeoMIFR1lhj8oGoknkCb4ck48uGf6F0wppWBI7adLhWCPhIIkwbT0UXwTx2ekmGaO4ZzMTTEYwfdbYut4Cp/2v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743077003; c=relaxed/simple;
	bh=D/W/astpbBbKyIPRIDsrctk7V5FpM5GrerEWPMld8nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCaySPQ0D/K6riJM2O19wxV3QUPeuErorexnhgejAbI10+7Uht5CibcyK8FlxqDL35lphbhtKz0izYjvycOLgPybIYjew8sWQn+Yr9AHmCmDOIttlu2NuE8z+U4jO84r5xrvjhBuu04O1eOE6gfnl19IqRwp1tC69CnAvs91DvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmXN1TFkzaGrNMYWnTtUVDJb5PoaALezVNV6XGBFVUoYUe04S+W0xn2hTtCLt1ILzFeWeTmxZL+gz87jfdmxu3sn3QPxx03VjhXzlWSV5cNNVSC5eXrNVwNc6g1VLjL9e319m9o8KNcFedNYmr3OmwAd0KybaoSj/W8x1njcqyZbfExgk5Odp+qSC/GaVhEOuTaPfFydX2t79GRLsXY593b6YSYAZrDLwT6DWAahOsLLCTU+b3lIWmOCla+wOcjoygt75L9Ghwoatnb2tWbS8mJWeXJycey+RKkiMTjKm7Ck7xXAz/+uU3U2WmySXfkpByXaiL/JXMge+X030qZUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK0UPQ+t29BshZMNuF1EQBj9+yFNiQVI6nMsmuCRGf0=;
 b=yn6+X/lmZYTjuepFDvSOZFB5Z9Bi22CkZe+9XzOrTHRhHKkygLS/Ud+EgHTCjF+zEmIZlu4zbbxaH1/JF8JhZyn5M4NSvmSXhcCWqzCJI93KeGHOUA3oaP/IKxphi148eA3yFheQ9aTypnd1WWuM5tEBl6W6IpE+BQ1URIAlh0rsKFmpgH7UvUgUesHzRSVJi9RVfqjlrYPG38f9rWqtCTlJ+CAOqbaIttJZKiYsZ1JkY7BtFnx8SndiXtvwaMgpCOLwwb4r6eyWJFEz/yh7Wy/Rvygl4K+z0BthshOcaLc2TSJmbUmCer9BC8Q6i86yjPDO5IcfBgcsrkIFy7ISFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8) by
 KL1PR06MB7049.apcprd06.prod.outlook.com (2603:1096:820:120::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:03:18 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::3a) by SI2P153CA0007.outlook.office365.com
 (2603:1096:4:140::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.13 via Frontend Transport; Thu,
 27 Mar 2025 12:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 12:03:16 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DF25B4160CA0;
	Thu, 27 Mar 2025 20:03:15 +0800 (CST)
Message-ID: <ab7817d8-c998-48e1-8349-596c043d9db4@cixtech.com>
Date: Thu, 27 Mar 2025 20:03:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Enhance the PCIe controller driver
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Milind Parab <mparab@cadence.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250327105429.2947013-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|KL1PR06MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 985b5fc2-93bf-4fc6-0771-08dd6d275bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnFmUGJLSGVMMjJCNWhsZkFDNDl0SkhGZmJzODVvQlArMXpwMkJUV3Y5ZmhK?=
 =?utf-8?B?V2h1bFZncHZha2E5QUw1MFJGMnBwanZ4bHlTRGIvdjlQcGgxVDl6WUlSZkp5?=
 =?utf-8?B?REptaTVPdUh1MC9wQ3dhZ1lPYkw1eGJuMml6NGVjVnZtdXFPTjUydUhNaGRG?=
 =?utf-8?B?NVBON2JEWEEyWHRLNjl0WDhLZU9pYUwyMXo1eDJKb2VrMm5aRkZYNHFVM0Fl?=
 =?utf-8?B?WVFpUFBDSC9QV0lSdEJFWWJ2ZitwaGxpelpYUzh5TkVzdDB0L1N0TDZXNkh2?=
 =?utf-8?B?VjhhcWswc2g5R1FWcllaNVk4UVd4OHU1OG5pajNCQTI0UlRJbTg3N2VqWmdR?=
 =?utf-8?B?Y29JV2swRE1EcWN5T0NrRGdzaStLZ1Ura2RMUnJpZEhuaEUwNWxKRFQyOEk0?=
 =?utf-8?B?UC9ZWVFwQTFWdFRmeFNKeFhrQjBrNU9Jc29JTVBFRkZJVDVPL3NQZ244TWJ6?=
 =?utf-8?B?MHIwbnFXL1NQcndLdmM0ZzNqSDZOMEhTc1FNbFZEalZSbFQrOE81dXM0c0VH?=
 =?utf-8?B?Z3hkSEE4ZU8wS3dzMXFQMW0wZWg4UmdJQ1Vmem9XSlNXYVFRbEZBS3JhMzY0?=
 =?utf-8?B?VnlnTy96bWJOZmJXTHpuT283MlVDSlkwT3h6d0xpK29XejlRa2ZNNGNSQlNm?=
 =?utf-8?B?TzN5QUJobkZ3Q01BNSs1bVhuQ0YyU25reHF0Mk5kNzhmTzhnbUlNZDNMY25v?=
 =?utf-8?B?V3k3TGVFSkdhV2FSeE93Tlo1SHhRWXhnd1FmWXBWd01IY28xSWYyZ29veDZn?=
 =?utf-8?B?aWtoTkR4andpZ3paZEhLWjFUcWRVaElpV2pWNUhwSDU3QndEUlRrdE13OUlW?=
 =?utf-8?B?UWtpdWc1MGhvdzNLQnNKL29zUTNuS2twR3g4VU53MUpLaThXOGdlY2dNTStz?=
 =?utf-8?B?d2FrY3hJZWNwWjVUN2hXTUY2NjN6UW96a3N1MThVVXE5ZjVYcFRSblMvUWJL?=
 =?utf-8?B?L1cyR2dyWFY4UUFCNTdIcjduMjRqM2tjMTVWVUh3QW5zR1JEL3NtSG1NU0Jw?=
 =?utf-8?B?MkxsSE5aQkxnTnF3b2srNE81a0llRFBhM2hwUVg1UHVIOTN3MWR5d01Ia3py?=
 =?utf-8?B?TmpJSjU3ZFlkbElnMFZxeHlzajFlbUJxT0wwNkFVWmlJUHV0Zzl5T2tvSGZy?=
 =?utf-8?B?T1FCN0JVandudytyNDBmZmphTGoxQkZDYS85MjNJK1U2YnMrbHZvcXN6RlFs?=
 =?utf-8?B?cVN4Mit2bmdoNjNzTkF0cVRNZTdCek5rOGExV3VmZlQrWnVhOEtlYTFQd0R2?=
 =?utf-8?B?cFA3MDNNOW9mVVFnb1FSaVd4SXh2cXlQbXgzRnRBYm5VaEMvY0tQaFlCUTdP?=
 =?utf-8?B?WkFSMTVFdG5OOWpyMlpESlplVmpoZU10Um94aXRBZDBBV0wzeSsxdGNHZmNR?=
 =?utf-8?B?a1BlNVdiWCtNU1FvWlB2TXNoVXFvYXJoWUd0UkU5MUw3dzIybHc5dXMyUnF0?=
 =?utf-8?B?YUlJOFBYL2dQOGRiRzI3dGRPaUp0K2FkelJQTE14RG92cUhrVVNvUXRMc1lO?=
 =?utf-8?B?VThxdjl4TXVHVk9nSkV3ZzVMVjNaSnFXTXpUMmJMck5RZHRmZGxreDlTQThW?=
 =?utf-8?B?T1llTFNHcFZtbG90R0VWemhkbmluTXdMajlQaXhnYXdjdXl2eUkwanl2VnJn?=
 =?utf-8?B?U1REUkU3cUtQK1JNK0xrcTZsVFptb3pMZHdpcUh5OFRZbzlOTUxzS2ZjWTNH?=
 =?utf-8?B?WnhpMTBEdFZBYWxQVGUveSs0Z2VEVm9BcFhzM25sR1p5WFlrNmRBdlZOdkxX?=
 =?utf-8?B?S2dBcHdrR0ZYdkxNWWpPM3hUUCtWMDJGVWNYbFRUNXV2WHJZTzFoK2lWSXhk?=
 =?utf-8?B?SDNDdDdCcDVzTzAybUtPd2RjNnYxVU51OE5IeFNnclc4MXpkSG8yTEpTODFB?=
 =?utf-8?B?cHh5ZGZWT0M5UzU1MXB0MmJhUG5nR1M1c0pXR3BmbHAvNWIzcTVzNm1zY3hN?=
 =?utf-8?B?bEQ5OHR3NEhQS0xvQmhWQ2s4Z1VoN2xjei9EZXRwaktlTVJxNjA4YVV1T1Z5?=
 =?utf-8?Q?vQHUeX4JNh1zagFnTJ6UQDH5yxtgmE=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:03:16.5092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985b5fc2-93bf-4fc6-0771-08dd6d275bbe
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7049

Hi Manikandan,

You should update your patch to V2, not no version at all.

Best regards,
Hans

On 2025/3/27 18:59, Manikandan Karunakaran Pillai wrote:
> EXTERNAL EMAIL
> 
> Enhances the exiting Cadence PCIe controller drivers to support second
> generation PCIe controller also referred as HPA(High Performance
> Architecture) controllers.
> 
> The patch set enhances the Cadence PCIe driver for the new high
> performance architecture changes. The "compatible" property in DTS
> is added with  more strings to support the new platform architecture
> and the register maps that change with it. The driver read register
> and write register functions take the updated offset stored from the
> platform driver to access the registers. The driver now supports
> the legacy and HPA architecture, with the legacy code being changed
> minimal. The TI SoC continues to be supported with the changes
> incorporated. The changes are also in tune with how multiple platforms
> are supported in related drivers.
> 
> Patch 1/7 - DTS related changes for property "compatible"
> Patch 2/7 - Updates the header file with relevant register offsets and
>              bit definitions
> Patch 3/7 - Platform related code changes
> Patch 4/7 - PCIe EP related code changes
> Patch 5/7 - Header file is updated with register offsets and updated
>              read and write register functions
> Patch 6/7 - Support for multiple arch by using registered callbacks
> Patch 7/7 - TIJ72X board is updated to use the new approach
> 
> Comments from the earlier patch submission on the same enhancements are
> taken into consideration. The previous submitted patch links is
> https://lore.kernel.org/lkml/CH2PPF4D26F8E1C205166209F012D4F3A81A2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com/
> 
> The scripts/checkpatch.pl has been run on the patches with and without
> --strict. With the --strict option, 4 checks are generated on 1 patch
> (patch 0002 of the series), which can be ignored. There are no code
> fixes required for these checks. The rest of the 'scripts/checkpatch.pl'
> is clean.
> 
> The changes are tested on TI platforms. The legacy controller changes are
> tested on an TI J7200 EVM and HPA changes are planned for on an FPGA
> platform available within Cadence.
> 
> Manikandan K Pillai (7):
>    dt-bindings: pci: cadence: Extend compatible for new platform
>      configurations
>    PCI: cadence: Add header support for PCIe next generation controllers
>    PCI: cadence: Add platform related architecture and register
>      information
>    PCI: cadence: Add support for PCIe Endpoint HPA controllers
>    PCI: cadence: Update the PCIe controller register address offsets
>    PCI: cadence: Add callback functions for Root Port and EP controller
>    PCI: cadence: Update support for TI J721e boards
> 
>   .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  12 +-
>   .../bindings/pci/cdns,cdns-pcie-host.yaml     | 119 +++++-
>   drivers/pci/controller/cadence/pci-j721e.c    |   8 +
>   .../pci/controller/cadence/pcie-cadence-ep.c  | 184 +++++++--
>   .../controller/cadence/pcie-cadence-host.c    | 264 ++++++++++--
>   .../controller/cadence/pcie-cadence-plat.c    | 145 +++++++
>   drivers/pci/controller/cadence/pcie-cadence.c | 217 +++++++++-
>   drivers/pci/controller/cadence/pcie-cadence.h | 380 +++++++++++++++++-
>   8 files changed, 1259 insertions(+), 70 deletions(-)
> 
> --
> 2.27.0
> 
> 

