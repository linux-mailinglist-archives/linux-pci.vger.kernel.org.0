Return-Path: <linux-pci+bounces-24844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A3A73193
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F391899039
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64C20F097;
	Thu, 27 Mar 2025 12:01:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48140849;
	Thu, 27 Mar 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076910; cv=fail; b=mwvv/9bq+J98q0DUvzQLrtOcggbvkEKs+N6xbMTITTmqDkLqSXdPL0aNw2ODf36g0hBzZaV85MR3058JBnCHAdLGITJDxOvSEq/HiIdUMJS8Lm2aeLBx7GX+MdLROIbrJwxDrH4YoxBkEnrLDlFDidGRnqnWx8sVXogUaxawuKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076910; c=relaxed/simple;
	bh=yrwrn0jL+sBwcPqOow7a8hnt8md8e8KHHUpn3p31ec0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cj6kE5/N6s7GEMVa7i/nyst3N5PhI8ZfVEIRxTmUc6KeUVFZtnzAJ4tUO0G9P8+u+Ns9tBek28oBNGir8x8k3w9VL3SDas9nCAYR5fEBABWLYnFSNxL4aSZHMLeJPggL6IxI4qiS+9lW/UU/wmsUWcTE80gSZa+tVwaUJfFAlyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk/vTBR6pckHZLlHabfDuITsE3g8BKM7y2GDaOi3zTG7o9ggDTOIWhhIPpHoIS0leu7nSbO/B+5q06dFDstMQ4OA7h4MGD50/Bm7kdgJaxMEl4MF8+sugEGQQet+tHtwYoQtMV6HSAoK+nk+ohZoxCUPVhRZ0BampPsjffikIte8I70fZhDrQSADJWjNp4dQ12qTP5Bt7djOLTKWIks2aSz06P5CVeSUQwiUSFvyGpTMqIqSZ7tuuL4tfMC8HVC9U6hQkQk8I1S2dFD8Kt9ZSFNet8POpElcKCa7AKBSmG9Q7Lu5YAa2UufgBudiOW/Hb1gtBB1Keqt1PmpywG7tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltzRY6kvgMTMrTnMuHWA+ZRL10M2sh0vLjKg654iAeU=;
 b=vmGVNdqtNLNWxd8FjEDw0sfMAvv/E3/ACD+GcYo/hAwf/KOTgjuzUWua3Pmu7GbmzQyVAIsOPQfgzEhZCSc9gPorctiVrf+2DGGF15m/VNiMFyHosZh9Ym+gRUEcqkKVXomzEuYQGkDj6wQDaJLAUDgUI7TkdHZD6cLI9r4SbTHy0GQl4qokx+g2j6EJtsaTI1vghkACPwREJpZag1AxCrrJhfbLjouqkOr3cBcsks63eK0NBRnp5I/xyZu5csMCchdAL1eyDHOgQuHeVnv2kHKnKb0+kLVIIEc7TmXV/PvCPzNM2ljglz8/whCswvFvdKXN/w9hw8rKmQGrMBNxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYAPR01CA0129.jpnprd01.prod.outlook.com (2603:1096:404:2d::21)
 by SEYPR06MB6949.apcprd06.prod.outlook.com (2603:1096:101:1e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:01:41 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:404:2d:cafe::c8) by TYAPR01CA0129.outlook.office365.com
 (2603:1096:404:2d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 12:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 12:01:39 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2571F4160CA0;
	Thu, 27 Mar 2025 20:01:39 +0800 (CST)
Message-ID: <71c6ba9b-adc3-4ca7-84b1-bbcb074d1f0f@cixtech.com>
Date: Thu, 27 Mar 2025 20:01:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] PCI: cadence: Add header support for PCIe next
 generation controllers
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111127.2947944-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CE94EC3F4A0D6B9849818A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <CH2PPF4D26F8E1CE94EC3F4A0D6B9849818A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|SEYPR06MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f8572b-ebde-4b1b-bc39-08dd6d272231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVhwNm40QTlnKzdwdWFJb01kdzFMQWhac3hETi80YVhYdmk3bWRFVjd0WjFx?=
 =?utf-8?B?REE1aFREWTI1Q0F0UTJ4RnhHZ1pwRjRtMnVobmdlcnZoYnpUR2F4VHVNNERk?=
 =?utf-8?B?ZmRKM0x1ZHl4T1VMcUl2UXI0U1poM205UjdTUVRJWWppcVdGNDNpMUtGNTJ2?=
 =?utf-8?B?N3JBRmdVelFFRWF4ZmMzRDE1WnhFZ3VyclVwU3RMb2lQTFkrRnFjaStpRmVl?=
 =?utf-8?B?QW1TcVIxSDJraS8xRnVyVDVWQXFvRWMrWFc4Yk1FamhTWUpkU0MrWVkrSk9X?=
 =?utf-8?B?UXgzL3d4MlZRcmtDeDZSQ3M2bzlPYUlBekwzU2pyUFJFZzJSOE84SkVrNGdL?=
 =?utf-8?B?RXZNcU9LWGxpeFhVTzhlYkFkRG9MQml1ZXNmMjM4eFFwWjRycXZaZVBPdlN1?=
 =?utf-8?B?MVdaUXhIaEthR1RVaGtsQmE2ZGkxT0JLNnI4QUo2WEdpTFFMZGtUc0ZkR3Bl?=
 =?utf-8?B?eTVyUS9remE4WXdEbDR4NWpGV0FJWjZmMDlkdmQrY2x3OEVCOHJPWUNSZDR4?=
 =?utf-8?B?S0I4cENzUTBqcnZEQ1cyKzJTbnpsREdDYUpHWjJwQzZJVktiVzg2Q1gyQTQ0?=
 =?utf-8?B?OEdtRFpBbThuQm5GaUdLWDhzdVMzVlQrUXU1MUZqK0RQajFveEVvMDVEU1Uz?=
 =?utf-8?B?RXNaRnBSVUR2QzI4VWpFWmpWWGJJdWZJREtqdlNLNlVDQTN2aTJESEdvSHBP?=
 =?utf-8?B?QmhaMEVOWjdCdy9LdlBQS0NvUEJjazNqUXJjTW4xRU5abFNnZUl5R1J3REdI?=
 =?utf-8?B?ZW52UXdvTDVxL2VseGN5eWwwcWMxeVJxRFlTb1Y2TDFpT1lYTW1rcmJONis0?=
 =?utf-8?B?K3NMTkVkUjFTU01wbDl0RjNzcHVYaktqWlF5RHlHRmZiMFdvVFpoSjVVKytQ?=
 =?utf-8?B?RVo5K1hsTFR5djNzZmNtVTJhVEZJZ0lxZE83aHVrNjluK1lVSlBlempjOS9u?=
 =?utf-8?B?c3VxVjJvU1RkT2RBL2lPZjE1Vm9rTGhnZ2plY3c0dkxJSmI3SldnLzBobWE2?=
 =?utf-8?B?U0h0RWxkOWlIc0tVMjQyVTIxUC9Ba25tZDFSUTFtQ2lXcHJrbERJaktudXhx?=
 =?utf-8?B?QWowVUx4RHQxWXNDaEFmdDR3UmRvMDZVZjFjQm9OYU9SaHJaRWptTHdWTUdi?=
 =?utf-8?B?eWx4NWFSbWhvRDF1KzhMRG5pZkpnOEFqTkh1YlYrL1FLa0tSeDNuWEVxTGFO?=
 =?utf-8?B?OWdVN04rNnIyTVM0bHVoUjY1WU9WL1RxeUdRQzN6bXpGMzFKMlVZZXBvakZo?=
 =?utf-8?B?bWtRcTUrWjdCYks5RWtLaXU1Z1dFVXYwUFY3RlA3OUdoVEN0bGZINlM2NDlj?=
 =?utf-8?B?K094Z1pJWmcvS0ZKL1B1STJKYUgybXV5dDczZFh1UE5KVjdvbTZPYUVBdjUw?=
 =?utf-8?B?Mjl0WWtKUEtMMXZxZVBqYW1oZmw0OU0yWGJsRWhYcDVCZC8wenl0TXdCcStj?=
 =?utf-8?B?RTdaUTY5a09yaHdYaGpHYy93VWY3bWJCd1Q5dVBYTGRzS2wvRlJObUUxY3Iw?=
 =?utf-8?B?L0xIV3plNVRkNlNvUkpPNW5yNUd2L2cyb0YxWTJ0SGEwd0tBaEZyNGdwM2Nl?=
 =?utf-8?B?MytyVXFweTV4azY1MzdPbHZ1OTVlS2ZrNlRlVk1ZWkdoTkZKa0RkenE3VVQ5?=
 =?utf-8?B?VzArRHBUQXg4S2lNS2dFek9wSEpndTlVdUJGa1oyQk9tVll6VXkzaHBYdSt1?=
 =?utf-8?B?N3EvNkJEalJzdGR4TnBuRUg2SHA2TUFtTHRrdC9JcEJxc0FxK05JRmVIYXhG?=
 =?utf-8?B?UFFJemxSb3p1aXZVYlA5dDM2OVk0bFZCdEx1TXAyRndWc05ZY3NFaWZGZWNh?=
 =?utf-8?B?L0RubzFscFJRcGk5N1lVeU5tZWp4c2pnMXRTYXVHYlFlaWdwR0pMSG5iK0U0?=
 =?utf-8?B?S2F0VDJrU0p5U0FhdUNJbVFPWE83RmVpejNjb2djNDl3elJaZjJDb20vVUJw?=
 =?utf-8?B?dkNubjRMeDFwSjZkNXFuLzc5UFFmckJxNGFVQjhEVm5Sc2Vkb2gzdEpMc3hx?=
 =?utf-8?Q?SVx8j7+9d0LgYqc4QjJzClNpK4ZPGc=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:01:39.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f8572b-ebde-4b1b-bc39-08dd6d272231
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6949



On 2025/3/27 19:26, Manikandan Karunakaran Pillai wrote:
> +/*
> + * High Performance Architecture(HPA) PCIe controller register
> + */
> +#define CDNS_PCIE_HPA_IP_REG_BANK              0x01000000
> +#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK     0x01003C00
> +#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON     0x01020000
> +/*
> + * Address Translation Registers(HPA)
> + */
> +#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
> +#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000


Hi Manikandan,

I have replied to your email in Cadence case, and our design engineer 
has also explained it. Please provide a way for us, as Cadence 
customers, to modify it ourselves. Please think about it.

Please kindly follow up HPA's patch CC to my email address, thank you 
very much.

V1 patch:
https://patchwork.kernel.org/project/linux-pci/patch/CH2PPF4D26F8E1CDE19710828C0186B13EEA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com/


Communication history:

Can you change this part of the code to look like this?

#define CDNS_PCIE_HPA_IP_REG_BANK(a)              (a)
#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK(a)     (a)
#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON(a)     (a)
#define CDNS_PCIE_HPA_AXI_SLAVE(a)                (a)
#define CDNS_PCIE_HPA_AXI_MASTER(a)               (a)



The offset we designed is: (Cixtech)
#define CDNS_PCIE_HPA_IP_REG_BANK 0x1000
#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK 0x4c00
#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON 0xf000
#define CDNS_PCIE_HPA_AXI_SLAVE 0x9000
#define CDNS_PCIE_HPA_AXI_MASTER 0xb000
#define CDNS_PCIE_HPA_AXI_HLS_REGISTERS 0xc000
#define CDNS_PCIE_HPA_DTI_REGISTERS 0xd000
#define CDNS_PCIE_HPA_AXI_RAS_REGISTERS 0xe000
#define CDNS_PCIE_HPA_DMA_BASE 0xf400
#define CDNS_PCIE_HPA_DMA_COMMON_BASE 0xf800


The original register bank consumed at least 48MB address space which is
begin from 0x0000_0000 to 0x03020000. Because there is unoccupied
address space between every two register banks , our hardware remaps the
registers to a smaller address space which means the register bank
offset address is changed by custormer. So, we cannot utilise the common
code directly without rewriting the function.


We submit and pull a Cadence case: #46872873


Reply from Cadence case Manikandan:
Another option I can propose is to pass these values through the DTS
file … (Hopefully that would be lesser changes)

Hans:
I agree to get it through the DTS attribute, please modify it, so as to
be more flexible. This offset value may be modified when RTL is integrated.


Best regards,
Hans

