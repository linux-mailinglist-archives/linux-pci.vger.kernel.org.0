Return-Path: <linux-pci+bounces-39768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F4C1F0EA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39066189B1DF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA9633A036;
	Thu, 30 Oct 2025 08:45:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022130.outbound.protection.outlook.com [52.101.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280717B43F;
	Thu, 30 Oct 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813939; cv=fail; b=IAGU62zjSYv0pvvsH3Xx9G4GdXBBkKXZVZ0zalXdF/DsdzyQuybCXozZOvZgmpB+WIOAPA4yyN1ltjru3bSdMwXzOb4rFJBaGMfz+WZSwlw6OnN5BbStx2SSYrCzpo+PiQpMX5ZsJmR1lx4ntwKITzJonI2oV+NE1ZSqBk2DMcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813939; c=relaxed/simple;
	bh=7r8Td4WuNB3aEkgREp1S8UjbxccFLUhyPC0iGZc/1Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVUSAY9DEJKENCczbL2pItmVbTtTyh0Wef18Kja6e/aMlrs6SgiuzteFL8QfYGlhf2Pnbm1byqYH9qk8kOVTWJu6M/yrWpk3nW6z1vu0spggim6xz0leXlVJBzuIWXQnTBsu5ojYPQsJysvIfzdRWLSsxW8egWBg/zxNWR9iI+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOcQ6cvM4Ll+gWmALqt5H41ktdKAWJL6G2M+maCNhnX5glo3fmDnGR9dip5k4YMcWuQRAZRqxtgzDIpKVrzYOdIazEiOLy4bxlkLJcun51q4aLDuHHB1ZCrdkYTts8bDi0jcKRRXMFeH0UcNR6PNcRjY9AZ5Ph2D4ZfZ9zQHyp+GyGAtsjHkstlzg5iRDkSNvJto4e6SD3K8X0sp289mRB6Tr2T7PsPJp9vrrKYUxWSNqYDiqOVlHZ0CG5KKLquwFw2kbea1KrCx8nQc0y7Ffk12IoP4e1iTXtNg8Y/6w8qygEcuUKnXPUu0nOGTOvFp5Q1dFyBzLCxk9mQsOK2XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3xYDIHokD44tax2t0uYNppF8FcoEugsh2opYaENEB0=;
 b=tTlOHV27yh8v+re7zIiQ6lrc2vNkZxkNiGVrFkVZFrAES5+43SRIP3jGwsMvZZhpZCiumGB8LuxNa0EazwuyDzvBOylQ2wc7tNANZ2pPEmnqSOlnSK405WmqEnMMo3fLd+Oek7FRtD7bvb9o5T+LGfsHgwLUowC+6bhAY7THt4w5xhoCZ5AI9XOujsB1uC9rGxGsb6xEPJBAUervZBiJr23yVVANpw/QyLK+DTBExZ6fteokxWc4WQ7Snh8P88jM8GLLvEyjDeXV57x70hx3Z46fUm8kVRaiLOU20/Q7Dp07vmTpQ11zGkxSNYn4lAWJkGZONClQ9TLQPqoXK5QIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0069.apcprd02.prod.outlook.com (2603:1096:4:54::33) by
 SI2PR06MB5115.apcprd06.prod.outlook.com (2603:1096:4:1aa::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Thu, 30 Oct 2025 08:45:32 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::1b) by SG2PR02CA0069.outlook.office365.com
 (2603:1096:4:54::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 08:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 08:45:30 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0B7EB41C0145;
	Thu, 30 Oct 2025 16:45:30 +0800 (CST)
Message-ID: <b6ad96f5-09f6-469c-be89-6c44aff7d3ae@cixtech.com>
Date: Thu, 30 Oct 2025 16:45:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/10] Enhance the PCIe controller driver for next
 generation controllers
To: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org,
 kw@linux.com, mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
 peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|SI2PR06MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 7949e782-86d9-4d0b-5c9c-08de1790aedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjVKblNPejJ1UGhuQ3hKdjFPRXFvRlVuaXYyYjZDZzFoeTRUdUk5c3lBck56?=
 =?utf-8?B?Q2tLSFNucUVqT3BTVDZ6eFNWRDdVSFljV0tHYVVHQ3NKb2p2a0ZkMEM1VHJn?=
 =?utf-8?B?R1cwakNPUE1SSW5wSHl5TEY1dHkybjBZdkZBamhEeG91RHBwUGZubituYXpz?=
 =?utf-8?B?M1ZMeDMxS1U4eXN4SDBwMmk2VXRGcmdpb2EyTityaVVYckMxRGlFa09IZVNw?=
 =?utf-8?B?YUZoRXE3cVExeWVBSFppQ1daVlByYmswcE91bVVCb2RtcG45ZGZPTEM5Ymlm?=
 =?utf-8?B?dE5mMHZKS0NGZFZDNGJHdFdsUkVwdjhMb0t0enhPU1N3eDIrYndzcWk1K2VP?=
 =?utf-8?B?SExlcnFrMnFmd2JmNldDUFVJL0tESTgzbzlFY0lEczRHcmkvOXJGMzRXSjFE?=
 =?utf-8?B?bzZvelgwblQ0c0YzQXNOdm5KczJHN0NCdDFFbzduT2NOMHQ4Zm1qVVVBN3RN?=
 =?utf-8?B?dU50L0M3bUF1S2xDQURKaUcyallvdExkalU0amx1V0VEUStmU3RkQTVkSkta?=
 =?utf-8?B?ODNxK1d3eTlvb052Mys1VXFSMGhLWCtXelIxNG9tMitCcldQSjRqTWRJZW5H?=
 =?utf-8?B?YVdMSC9idTJLMWxTeW5PMFZxUE8xa2QvR3VTQ0EzM0l1Zm1za3czdHlUdDZt?=
 =?utf-8?B?S1F3NkVtSXFpdk5Gd1Z0NmVWTkdrRGxqeGdYTXVZc290M3MyV1A0VXBTbmdY?=
 =?utf-8?B?V2ZuUVJUbXVnZ3N1TWEvWU5WY1V4Tzlya0pDZklxS2NiYkY3NmRCdWQwbmoz?=
 =?utf-8?B?Z21TQkNBNVZwa3JFSDRCV0lSaGZ3V0Y5WHF4MXA3cHdzMm43MGtURExYbVNQ?=
 =?utf-8?B?NWxtZkdkQVlwRm4rZFNCcWppSlRVbjJEMG1Pb3dCWXRSQWpRSXJaeVZBblEy?=
 =?utf-8?B?OW94RFNuNkIwWkg3YWZsdDJ5OWY5VFhsZlZ3aU1WWG96bmVhcWlOOTRYVDVa?=
 =?utf-8?B?UnQrR2VQaXdSekhubkhnWkV5V2c3aWNacGZrOE9WVGZIUmxaWEdzOHFmbmdB?=
 =?utf-8?B?ai82Yisxck9rS2YyS2JETEw5TWJ2R0hNc2kxK004enoydHB4Q01iNXQ1MVFE?=
 =?utf-8?B?YlUyZkUzbCtEQ3ZyaGY3dmJleWE0WGhXbU1iRzRIelZEUVBTd1hlS3k1R3p2?=
 =?utf-8?B?V0JYYndBQytTcFdHZmJHYitIL3JxSzdOVnhlU09Ic1I4TTJBOG1UZGMxREFr?=
 =?utf-8?B?bjYrWVlQRUNkNE80L2VrYWlhamovOU1rV2lFbnZoczhHcHV5Q09KSmMxM08w?=
 =?utf-8?B?SWxoQjhQTjdCUnpnTFFOUjRjeEQyR1E2K3dBYjk4Z0FvbUl4ZGZrYWVVbHFj?=
 =?utf-8?B?enl0Wndwbmo4bE5zeDJtcVVya0YwLzZOcTBIWG5SOG5zUHR0TXJiVm11aG5Y?=
 =?utf-8?B?WVFOYjdQb2xUS3QxQmtqOGpHbHl1cGptZ2tsQk9QTEM3RS9OUGc0bWhveEsy?=
 =?utf-8?B?Zk1FMTVBZEVwbmp1anMrSVlsT0hKQlpCdVJFcWJxeXNPQmtCMmlFR3pZclZw?=
 =?utf-8?B?Rlp6dlNKU2twT3laUnFCcExiWjRzWEJSZkR1WnNsRktaWE1MN0cvdXU5ZDJz?=
 =?utf-8?B?MU5aQzBJcnRMY0RZaHlHNUMyTmV6c1dBSFFZMEJjZVdzbllqUHE0NDJoMmZZ?=
 =?utf-8?B?U2NXbTI1Y255MEFRSTRmL09XckdsVmJ6UGJMSTREdEVGS1VzcmFKQWtJUW9z?=
 =?utf-8?B?MmVZQkJQRVhUd3lVallJK1ZzSndBZ3BzN0FGNUVCOWw0Y2tDcDJjekx1QjJk?=
 =?utf-8?B?K2JOM0o5VFFPa2EwN2pocUhDbWZKZXBwVFhaR1BNVnpXSEMzRnNqc2ROd1RB?=
 =?utf-8?B?VUdPVTBoVXpIb1MxYU9zQW9RYXpxUjAvQjJMZjBQVTB1UTVKR3ZvaER0bTFx?=
 =?utf-8?B?VmpJdjl3c2NyOFJBdFhxRUdmMWxDR1R4alV1aXBuZlFyMWRuc2x5NVRNeEJO?=
 =?utf-8?B?amk0bmc4VjVHN1NueWdPY1phUU11RTBKVnZhamt1dng1K050b1BTUUtvVndr?=
 =?utf-8?B?d3l2cFZGbDYrT054RjhyOHZjbkZZK0U3a1hVLzlSeW0vSWdzYlNQcnR0LzhN?=
 =?utf-8?B?R2xmMWdZUDltem9VaHV0cW5qMkRDa3RJbTk5QU12N3VEcDRyckZiZ0hRZy9s?=
 =?utf-8?Q?z1AI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 08:45:30.7707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7949e782-86d9-4d0b-5c9c-08de1790aedc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5115

Hi all,

Gentle ping.


Best regards,
Hans

On 10/20/2025 12:28 PM, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> ---
> Dear Maintainers,
> 
> This series is Cadence's HPA PCIe IP and the Root Port driver of our
> CIX sky1. Please help review. Thank you very much.
> ---
> 
> Enhances the exiting Cadence PCIe controller drivers to support
> HPA (High Performance Architecture) Cadence PCIe controllers.
> 
> The patch set enhances the Cadence PCIe driver for HPA support.
> The header files are separated out for legacy and high performance
> register maps, register address and bit definitions. The driver
> read register and write register functions for HPA take the
> updated offset stored from the platform driver to access the registers.
> As part of refactoring of the code, few new files are added to the
> driver by splitting the existing files.
> This helps SoC vendor who change the address map within PCIe controller
> in their designs. Setting the menuconfig appropriately will allow
> selection between RP and/or EP PCIe controller support. The support
> will include Legacy and HPA for the selected configuration.
> 
> The TI SoC continues to be supported with the changes incorporated.
> 
> The changes address the review comments in the previous patches where
> the need to move away from "ops" pointers used in current implementation
> and separate out the Legacy and HPA driver implementation was stressed.
> 
> The scripts/checkpatch.pl has been run on the patches with and without
> --strict. With the --strict option, 4 checks are generated on 3 patch,
> which can be ignored. There are no code fixes required for these checks.
> All other checks generated by ./scripts/checkpatch.pl --strict can be
> ignored.
> ---
> Changes for v10:
> https://patchwork.kernel.org/project/linux-pci/cover/20250901092052.4051018-1-hans.zhang@cixtech.com/
> 
>    - Rebase to v6.18-rc2.
>    - Comments from Manivannan which have been addressed.
>    - Merging of header file split patches with the patches that
>      use the changes.
>    - Addressing some of the code comments, initialization of variables,
>      making some functions static and removing unused functions.
>    - Delete the cdns_pcie_hpa_create_region_for_ecam function, which
>      depends on the initialization of ECAM by bios. After this series
>      is accepted, I will submit it later.
> 
> Changes for v9
> https://patchwork.kernel.org/project/linux-pci/cover/20250819115239.4170604-1-hans.zhang@cixtech.com/
> 
> 	- Fixes the issue of kernel test robot where one variable overflow was flagged
> https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202508261955.U9IomdXb-lkp@intel.com/__;!!EHscmS1ygiU1lA!EZnnh6v5bjIDVqDhCnuprUvH9PTNCSANIaNa6wx7Tp3NgGMqsrTwOKz9z8z5fWHkQH3Q8l_S$
> 	- Minor changes that includes adding a flag for RC, removing vendor id and device id from DTS.
>      - Fix comments
> 	- Remove EP platform code by removing patch 0007 in v8 series
>      - Fix comments style for new files
>      - Remove #define from within functions to header file
>    - Modification of the review opinion on CIX SKY1 RC driver (Mani).
> 
> Changes for v8
>    - Fixed the error issue of DT binding. (Rob and Krzysztof)
>    - Optimization of CIX SKY1 Root Port driver. (Bjorn and Krzysztof)
>    - Review comments fixed. (Bjorn and Krzysztof)
>    - All comments related fixes like single line comments, spaces
>          between HPA or LGA, periods in single line, changes proposed
>          in the description, etc are fixed. (Bjorn and Krzysztof)
>    - Patches have been split to separate out code moves from
>      update and fixes.
>    - "cdns_...send_irq.." renamed to "cdns_..raise_irq.."
> 
>    The test log on the Orion O6 board is as follows:
>    root@cix-localhost:~# lspci
>    0000:c0:00.0 PCI bridge: Device 1f6c:0001
>    0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>    0001:90:00.0 PCI bridge: Device 1f6c:0001
>    0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
>    0002:60:00.0 PCI bridge: Device 1f6c:0001
>    0002:61:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>    0003:00:00.0 PCI bridge: Device 1f6c:0001
>    0003:01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
>    0004:30:00.0 PCI bridge: Device 1f6c:0001
>    0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
>    root@cix-localhost:~#
>    root@cix-localhost:~# uname -a
>    Linux cix-localhost 6.17.0-rc2-00043-gb2782ead460c #185 SMP PREEMPT Tue Aug 19 19:35:34 CST 2025 aarch64 GNU/Linux
>    root@cix-localhost:~# cat /etc/issue
>    Debian GNU/Linux 12 \n \l
> 
> Changes for v7
> https://patchwork.kernel.org/project/linux-pci/cover/20250813042331.1258272-1-hans.zhang@cixtech.com/
> 
>    - Rebase to v6.17-rc1.
>    - Fixed the error issue of cix,sky1-pcie-host.yaml make dt_binding_check.
>    - CIX SKY1 Root Port driver compilation error issue: Add header
>      file, Kconfig select PCI_ECAM.
> 
> Changes for v6
> https://patchwork.kernel.org/project/linux-pci/cover/20250808072929.4090694-1-hans.zhang@cixtech.com/
> 
>    - The IP level DTS changes for HPA have been removed as the SoC
>      level DTS is added
>    - Virtual FPGA platform is also removed as the CiX SoC support is
>      added
>    - Fix the issue of dt bindings
>    - Modify the order of PCIe node attributes in sky1-orion-o6.dts
>      and delete unnecessary attributes.
>    - Continue to simplify the RC driver.
>    - The patch of the Cix Sky1 platform has been accepted and merged into the linux master branch.
>    https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250721144500.302202-1-peter.chen@cixtech.com/
> 
> Changes for v5
> https://patchwork.kernel.org/project/linux-pci/cover/20250630041601.399921-1-hans.zhang@cixtech.com/
> 
>    - Header and code files separated for library functions(common
>      functions used by both architectures) and Legacy and HPA.
>    - Few new files added as part of refactoring
>    - No checks for "is_hpa" as the functions have been separated
>      out
>    - Review comments from previous patches have been addressed
>    - Add region 0 for ECAM and region 1 for message.
>    - Add CIX sky1 PCIe drivers. Submissions based on the following v9 patches:
>    https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250609031627.1605851-1-peter.chen@cixtech.com/
> 
>    Cix Sky1 base dts review link to show its review status:
>    https://lore.kernel.org/all/20250609031627.1605851-9-peter.chen@cixtech.com/
> 
>    The test log on the Orion O6 board is as follows:
>    root@cix-localhost:~# lspci
>    0000:c0:00.0 PCI bridge: Device 1f6c:0001
>    0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>    0001:90:00.0 PCI bridge: Device 1f6c:0001
>    0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
>    0002:60:00.0 PCI bridge: Device 1f6c:0001
>    0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
>    0003:00:00.0 PCI bridge: Device 1f6c:0001
>    0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>    0004:30:00.0 PCI bridge: Device 1f6c:0001
>    0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>    root@cix-localhost:~# uname -a
>    Linux cix-localhost 6.16.0-rc1-00023-gbaa962a95a28 #138 SMP PREEMPT Fri Jun 27 16:43:41 CST 2025 aarch64 GNU/Linux
>    root@cix-localhost:~# cat /etc/issue
>    Debian GNU/Linux 12 \n \l
>   
> Changes for v4
> https://patchwork.kernel.org/project/linux-pci/cover/20250424010445.2260090-1-hans.zhang@cixtech.com/
> 
>    - Add header file bitfield.h to pcie-cadence.h
>    - Addressed the following review comments
>            Merged the TI patch as it
>            Removed initialization of struct variables to '0'
> 
> Changes for v3
> https://patchwork.kernel.org/project/linux-pci/patch/20250411103656.2740517-1-hans.zhang@cixtech.com/
> 
>    - Patch version v3 added to the subject
>    - Use HPA tag for architecture descriptions
>    - Remove bug related changes to be submitted later as a separate
>      patch
>    - Two patches merged from the last series to ensure readability to
>      address the review comments
>    - Fix several description related issues, coding style issues and
>      some misleading comments
>    - Remove cpu_addr_fixup() functions
> ---
> 
> Hans Zhang (6):
>    dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
>    PCI: Add Cix Technology Vendor and Device ID
>    PCI: sky1: Add PCIe host support for CIX Sky1
>    MAINTAINERS: add entry for CIX Sky1 PCIe driver
>    arm64: dts: cix: Add PCIe Root Complex on sky1
>    arm64: dts: cix: Enable PCIe on the Orion O6 board
> 
> Manikandan K Pillai (4):
>    PCI: cadence: Add module support for platform controller driver
>    PCI: cadence: Split PCIe controller header file
>    PCI: cadence: Move PCIe RP common functions to a separate file
>    PCI: cadence: Add support for High Perf Architecture (HPA) controller
> 
>   .../bindings/pci/cix,sky1-pcie-host.yaml      |  83 +++
>   MAINTAINERS                                   |   7 +
>   arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
>   arch/arm64/boot/dts/cix/sky1.dtsi             | 126 +++++
>   drivers/pci/controller/cadence/Kconfig        |  21 +-
>   drivers/pci/controller/cadence/Makefile       |  11 +-
>   drivers/pci/controller/cadence/pci-sky1.c     | 233 ++++++++
>   .../cadence/pcie-cadence-host-common.c        | 182 +++++++
>   .../cadence/pcie-cadence-host-common.h        |  26 +
>   .../cadence/pcie-cadence-host-hpa.c           | 499 ++++++++++++++++++
>   .../controller/cadence/pcie-cadence-host.c    | 156 +-----
>   .../cadence/pcie-cadence-hpa-regs.h           | 193 +++++++
>   .../pci/controller/cadence/pcie-cadence-hpa.c | 186 +++++++
>   .../cadence/pcie-cadence-lga-regs.h           | 230 ++++++++
>   .../controller/cadence/pcie-cadence-plat.c    |   9 +-
>   drivers/pci/controller/cadence/pcie-cadence.c |  12 +
>   drivers/pci/controller/cadence/pcie-cadence.h | 410 ++++++--------
>   include/linux/pci_ids.h                       |   3 +
>   18 files changed, 2006 insertions(+), 401 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>   create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
> 
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada


