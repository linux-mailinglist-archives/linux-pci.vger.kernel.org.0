Return-Path: <linux-pci+bounces-24515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CFAA6D815
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4AA1886F39
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB861917D6;
	Mon, 24 Mar 2025 10:09:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A22E3372;
	Mon, 24 Mar 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810979; cv=fail; b=Nbb3QsLnjQRtGxKCR5KFirr/WBOyp9e4FkOAdLz/VnpvaSsK4JogoHfxxNqZGBwm54lFz974eFa6+kmlX7MEGBkaN4njiAzC2ynUYjOEAU3iQf4pH5K1CvHAPNofYUdhbTvSUY+H49MHY36vOXfUcJzn7Lt0z8dcJpLal+EFOQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810979; c=relaxed/simple;
	bh=yJr/zzLozDJtLIWf4RnKlc9DnDTBRIVaB089eWdisi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXai4AEqCq5ENe/rlebgIWm/zr7i7+5JBdRmoNHpTvDoupxCrMgWOLbUWmPeKLIcGVT1OzGOjhpsSxjJNcVSx0ZgnlLfPb7c4ELFwlfeYNi65VdBXOLNlfRbHib3HBVG2NumC11gSrNwCSA5ASDjbkXIRsXhWJKDf60s1KVQhIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBO+pSw+I+rw34YjZEI7R1bV40G8UUz1yna2VQEBiZwJoxH+3hv4SeZ7W0hBevMaaoDzePsNGYINALr19wyuBm7pLwhWWOPk08tAxgs/2UIcGjSgcdYHn9ez1MsjtNGV9TwelGGEDKJkBXZOlPnJZM9TVVJAE4C5zRfrWH0pAWUeIzpGPfwgfCtKGPPsQ6P6enwCuZahrixzHqtl4S+E8rlVA0o3MGhw1tPefBGSkwH/7+JtAEFeo4ydl33uebXlD7N9d8S0Y7Eovb9ngQC20fFr9vdsgz0CM4l2fM70YopYFlbli/mpSihMfqJxe1Flb0Gwb5iCHLi74bbOTtfoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM2wD1cY+57eCpUnLDc+TOYnVKoxEZ5whbgUAEyNxg4=;
 b=QeSn1s2q7BbRJC+IcnyExKuGzMpYpll/AMedJrfx3CYPLHa9XXhl8MzvjKK1YvY7EZOKp3XXYXnLjsRMCmRwis1KeShtGzv05KX2OWZ6cPkTZa6pBJMvfYW7mh88k9xnILlRZMTLV8973/4r65lMVmh+mzIGgNTq6qIKT2JjuNigLbQ5OwHBQ21ASy/zcBrF2nJ32MjLk6quF3TXPqKpWJrJs5ELCqTSnSAcLbS7XAq9mfPPVA5FhSbvfUX7lVu6nnNr8eS+VsYKQ1BUjowO3tQI6naf3Gj9ov6EAdNaI1hszSIH2SNtzaiwmrUDrAMD3BmfaXV1vrbVQctQA4Z34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) by PUZPR06MB5449.apcprd06.prod.outlook.com
 (2603:1096:301:ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:09:31 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:4:191:cafe::3f) by SI2PR01CA0012.outlook.office365.com
 (2603:1096:4:191::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 10:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 10:09:29 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B729640A5BFA;
	Mon, 24 Mar 2025 18:09:28 +0800 (CST)
Message-ID: <c69ef0ad-9391-42f2-9b6f-1742e9a746e4@cixtech.com>
Date: Mon, 24 Mar 2025 18:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] PCI: cadence: Add header support for PCIe next
 generation controllers
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250324082353.2566115-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CDE19710828C0186B13EEA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Language: en-US
From: "hans.zhang" <hans.zhang@cixtech.com>
In-Reply-To: <CH2PPF4D26F8E1CDE19710828C0186B13EEA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|PUZPR06MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a39fcd-acf6-4252-e30b-08dd6abbf76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0M0YXBDUzR3NTliQm5MdnN1MERQbC9qSGsvK24rdDNYbVJ1Q2xTLzB1aVRY?=
 =?utf-8?B?RUt6Rzg2ZWFRUXhCU2lJTEcvbklvL0JMU2VFRndCRjNFSnozdy9BUXB6OXow?=
 =?utf-8?B?alo1bzlzd2tuNlBwWjA0bTRBelMrMVRrdGszb0IralN6YlB4RVNHZlVhNjNX?=
 =?utf-8?B?VU5zWlh1NkErMUxEck5ab0cxcE9NMmMrWUwzYUpIQnAzSUNZS3o5RUVvTkdI?=
 =?utf-8?B?bEVia2dsU3IrR2NjMWRubUQ2T0pyOTZxUEVhQWltT0RaUUNGbW9vSG10Vnhh?=
 =?utf-8?B?QmFGeWhTWlYrNlRKTWR4QTk3VEdXSjJIRmJIZXpRdUw2akVDTUNjQUduWm04?=
 =?utf-8?B?a0N3clZFV3Z5eWRMQzVPZXJqSDdaVDBVUXl3TGVyK0tvL3A3Nnd4cjdPVkM0?=
 =?utf-8?B?UWNMNUFkdnZlOWFjZy85dGV0UTl3VWp4N0QrSjlZd3VBSDg2YUtveWVJcjhp?=
 =?utf-8?B?UEdXaGl1c2lDQUxCL0VPTFVtQ2tjOGllMnA4QnJXUXpBMVZpMlhKQVAzNEZF?=
 =?utf-8?B?eEpSSzJXcW54U00vVnZqZGhEeUFybkJqQ1d0NVhmNy82Qng0SGZkYWk1dGtp?=
 =?utf-8?B?dG9pWWxMdmpIQVJpdkRxcWdYc0dqZ0RlZjUvcVpkcWVJdGQ2UHo3bmJzMGZG?=
 =?utf-8?B?RHQvSmVZY1I0YWdTOGpSTWM3MWFRaE9FWXZIcUg5U3BQbFFHdHVJU0t4cEtz?=
 =?utf-8?B?bU85eGdZMU5UTFBUZERBWTlJcVBTVndxOEV5U0pMeGRLczZmVmNlQXBnNGo2?=
 =?utf-8?B?amEyNkJZUjI2TlhqUXVpWVdGcTNxUk5IU3Z2eUk2UGtYalp1TWcyYnEwUE9h?=
 =?utf-8?B?YUF1NDB1RHJZZUlSd2FGUlRyeHl6RmVxYy9Gb0tVL2ZSU2xMWWo1RmdKcm1B?=
 =?utf-8?B?bW94VkJ1cUxpbnBYZXZhdysyNTNhOWh0SUJxdmFlV0dIY0xJOHBhT3B3RVhU?=
 =?utf-8?B?blU5ZXd0UEkrbHZVSm1INU1Ma1pNSWFZbTVIMUhOSWFueHRGRmRpVFV5eENr?=
 =?utf-8?B?YS9QOG9vdHhEendLcC9uR2tsVzRSejRDQTlSbWdnZ1dLU2owT1Z2R0tWTzdW?=
 =?utf-8?B?S1kxNFkxeVZVWHliMmMxUDVGbmpKVFFBaGVYY3FLVTlpUUxTVTJMeUZnN3pB?=
 =?utf-8?B?K1RuWnpldCt2VGsvVlVuU0JURzh3dGZ2Z2dFbVRLWjVzdVE0SjQ3c0ljN1E3?=
 =?utf-8?B?aVEvZ3FzeHVNd0cvYXAwQXlMcXE1M3J3WHVvcisvdzkwM21KSk1TYUQ3YmNS?=
 =?utf-8?B?ejFVTVdvYWtoNktuSTFyaVRHTHhFM2VDZ2RwbHR4VmVBS2ZuVzMyTHZ0REdX?=
 =?utf-8?B?NE1jTVhPV09hdS9nVlczMkxKTG1UUVNaRHlvdVlVcVhXUVhsQ0E4blFGUTRs?=
 =?utf-8?B?OU1aa2xKWVBnbVZwM2FnUGptRlc2L2t0K0ZVdjZ2SzNMM0FnYWMreVl2WVJG?=
 =?utf-8?B?aDJZKy9udGg3M05FU1p0UHVpR05HM3R5UDBtVHg5djJzZmdMeE1ZdDJmKzNm?=
 =?utf-8?B?VGFUSDNOdnZxcFFBR29RQWpsMzM4MDMwOWx4UjBLNHI2cERjUVBlRmxNNVJC?=
 =?utf-8?B?azNrMUJuZURJZFBkV0FjWlZpaHJSNHVjdmFmSzFUTkMwQ2VGb2t0WURCUlZH?=
 =?utf-8?B?V1RtaGtuNzIxbW8yV3NJTE9OSGxRK1NuUFEycDZZU045a0ZiR0NsdVJmcXhj?=
 =?utf-8?B?ZXFHRkdaWHNnZ1R2bXdFc2N2SHVwaVpWQ1M0Uk53b1VlNTRiK2ZVSmxIZlRD?=
 =?utf-8?B?U3BjamZUdHlJRXNHdXkvRlpsVVh5V3hHTng3ZmZPK3JXVlQrRDIxSlJ6Rlhj?=
 =?utf-8?B?NHZ3UitrYmFzd3ZsWkxYNitZZ3UyQUY3Vk9aaUFFcDh3bEJKelRwc0pwT05i?=
 =?utf-8?B?SW91cG92dmZNZm1oVFNMaDVON1NKYXdJQytpRU13aDFqQkdNWDdvc2pRMEpl?=
 =?utf-8?B?b0xhTUhBRUR6UXArR3hrUEEzbmk1Vnc3ZjhPQjBaMlJ3QVF0V0NlYUszUE1z?=
 =?utf-8?Q?3lp9RbgmXlUcdZoEpDFkuwKALXBuZo=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:09:29.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a39fcd-acf6-4252-e30b-08dd6abbf76f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5449



On 2025/3/24 17:08, Manikandan Karunakaran Pillai wrote:
> [You don't often get email from mpillai@cadence.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> Add the required definitions for register addresses and register bits
> for the next generation Cadence PCIe controllers - High
> performance architecture(HPA) controllers
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> ---
>   .../controller/cadence/pcie-cadence-host.c    |  12 +-
>   drivers/pci/controller/cadence/pcie-cadence.h | 290 +++++++++++++++++-
>   2 files changed, 295 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 8af95e9da7ce..1e2df49e40c6 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -175,7 +175,7 @@ static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
>          return ret;
>   }
> 
> -static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
> +int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>   {
>          struct cdns_pcie *pcie = &rc->pcie;
>          u32 value, ctrl;
> @@ -215,10 +215,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>          return 0;
>   }
> 
> -static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
> -                                       enum cdns_pcie_rp_bar bar,
> -                                       u64 cpu_addr, u64 size,
> -                                       unsigned long flags)
> +int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
> +                                enum cdns_pcie_rp_bar bar,
> +                                u64 cpu_addr, u64 size,
> +                                unsigned long flags)
>   {
>          struct cdns_pcie *pcie = &rc->pcie;
>          u32 addr0, addr1, aperture, value;
> @@ -428,7 +428,7 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
>          return 0;
>   }
> 
> -static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
> +int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>   {
>          struct cdns_pcie *pcie = &rc->pcie;
>          struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..2a806e5a3685 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -218,6 +218,218 @@
>           (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
>           CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
> 
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

We will also reply to you in the case.

Best regards,
Hans

> +/*
> + * Root port register base address
> + */
> +#define CDNS_PCIE_HPA_RP_BASE                  0x0
> +
> +#define CDNS_PCIE_HPA_LM_ID                    (CDNS_PCIE_HPA_IP_REG_BANK + 0x1420)
> +
> +/*
> + * Endpoint Function BARs(HPA) Configuration Registers
> + */
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
> +       (((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
> +                       CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) \
> +       (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) \
> +       (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)) + 0x04)
> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
> +       (((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
> +                       CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) \
> +       (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x08)
> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) \
> +       (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x0C)
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
> +       (GENMASK(9, 4) << ((f) * 10))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
> +       (((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
> +       (GENMASK(3, 0) << ((f) * 10))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
> +       (((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
> +
> +/*
> + * Endpoint Function Configuration Register
> + */
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG           (CDNS_PCIE_HPA_IP_REG_BANK + 0x02c0)
> +
> +/*
> + * Root Complex BAR Configuration Register
> + */
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + 0x14)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
> +       FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK         GENMASK(3, 0)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
> +       FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK     GENMASK(19, 14)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
> +       FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK         GENMASK(13, 10)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
> +       FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
> +
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE BIT(20)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS BIT(21)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE           BIT(22)
> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS           BIT(23)
> +
> +/* BAR control values applicable to both Endpoint Function and Root Complex */
> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED              0x0
> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS             0x3
> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS            0x1
> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS   0x9
> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS            0x5
> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS   0xD
> +
> +#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
> +               (CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
> +               (CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
> +               (CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
> +               (CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
> +               (CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
> +               (CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
> +               (((aperture) - 7) << ((bar) * 10))
> +
> +#define CDNS_PCIE_HPA_LM_PTM_CTRL              (CDNS_PCIE_HPA_IP_REG_BANK + 0x0520)
> +#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN      BIT(17)
> +
> +/*
> + * Root Port Registers PCI config space(HPA) for root port function
> + */
> +#define CDNS_PCIE_HPA_RP_CAP_OFFSET    0xC0
> +
> +/*
> + * Region r Outbound AXI to PCIe Address Translation Register 0
> + */
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r) \
> +       (CDNS_PCIE_HPA_AXI_SLAVE + 0x1010 + ((r) & 0x1F) * 0x0080)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, ((nbits) - 1))
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK    GENMASK(23, 16)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK      GENMASK(31, 24)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
> +
> +/*
> + * Region r Outbound AXI to PCIe Address Translation Register 1
> + */
> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r) \
> +       (CDNS_PCIE_HPA_AXI_SLAVE + 0x1014 + ((r) & 0x1F) * 0x0080)
> +
> +/*
> + * Region r Outbound PCIe Descriptor Register 0
> + */
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r) \
> +       (CDNS_PCIE_HPA_AXI_SLAVE + 0x1008 + ((r) & 0x1F) * 0x0080)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
> +
> +/*
> + * Region r Outbound PCIe Descriptor Register 1
> + */
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r) \
> +       (CDNS_PCIE_HPA_AXI_SLAVE + 0x100C + ((r) & 0x1F) * 0x0080)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK  GENMASK(31, 24)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
> +
> +#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r) \
> +       (CDNS_PCIE_HPA_AXI_SLAVE + 0x1018 + ((r) & 0x1F) * 0x0080)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
> +
> +/*
> + * Region r AXI Region Base Address Register 0
> + */
> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r) \
> +       (CDNS_PCIE_HPA_AXI_SLAVE + 0x1000 + ((r) & 0x1F) * 0x0080)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK    GENMASK(5, 0)
> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1))
> +
> +/*
> + * Region r AXI Region Base Address Register 1
> + */
> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r) \
> +       (CDNS_PCIE_HPA_AXI_SLAVE + 0x1004 + ((r) & 0x1F) * 0x0080)
> +
> +/*
> + * Root Port BAR Inbound PCIe to AXI Address Translation Register
> + */
> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar) \
> +       (CDNS_PCIE_HPA_AXI_MASTER + ((bar) * 0x0008))
> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK        GENMASK(5, 0)
> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
> +       FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar) \
> +       (CDNS_PCIE_HPA_AXI_MASTER + 0x04 + ((bar) * 0x0008))
> +
> +/*
> + * AXI link down register
> + */
> +#define CDNS_PCIE_HPA_AT_LINKDOWN (CDNS_PCIE_HPA_AXI_SLAVE + 0x04)
> +
> +/*
> + * Physical Layer Configuration Register 0
> + * This register contains the parameters required for functional setup
> + * of Physical Layer.
> + */
> +#define CDNS_PCIE_HPA_PHY_LAYER_CFG0     (CDNS_PCIE_HPA_IP_REG_BANK + 0x0400)
> +#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
> +#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
> +       FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
> +#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
> +
> +#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0   (CDNS_PCIE_HPA_IP_REG_BANK + 0x0420)
> +
> +#define CDNS_PCIE_HPA_RP_MAX_IB     0x3
> +#define CDNS_PCIE_HPA_MAX_OB        15
> +
> +/*
> + * Endpoint Function BAR Inbound PCIe to AXI Address Translation Register(HPA)
> + */
> +#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
> +       (CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + ((fn) * 0x0040) + ((bar) * 0x0008))
> +#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
> +       (CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + 0x4 + ((fn) * 0x0040) + ((bar) * 0x0008))
> +
>   enum cdns_pcie_rp_bar {
>          RP_BAR_UNDEFINED = -1,
>          RP_BAR0,
> @@ -249,6 +461,7 @@ struct cdns_pcie_rp_ib_bar {
>   #define CDNS_PCIE_MSG_NO_DATA                  BIT(16)
> 
>   struct cdns_pcie;
> +struct cdns_pcie_rc;
> 
>   enum cdns_pcie_msg_code {
>          MSG_CODE_ASSERT_INTA    = 0x20,
> @@ -286,6 +499,20 @@ struct cdns_pcie_ops {
>          void    (*stop_link)(struct cdns_pcie *pcie);
>          bool    (*link_up)(struct cdns_pcie *pcie);
>          u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
> +       int     (*pcie_host_init_root_port)(struct cdns_pcie_rc *rc);
> +       int     (*pcie_host_bar_ib_config)(struct cdns_pcie_rc *rc,
> +                                          enum cdns_pcie_rp_bar bar,
> +                                          u64 cpu_addr, u64 size,
> +                                          unsigned long flags);
> +       int     (*pcie_host_init_address_translation)(struct cdns_pcie_rc *rc);
> +       void    (*pcie_detect_quiet_min_delay_set)(struct cdns_pcie *pcie);
> +       void    (*pcie_set_outbound_region)(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> +                                           u32 r, bool is_io, u64 cpu_addr,
> +                                           u64 pci_addr, size_t size);
> +       void    (*pcie_set_outbound_region_for_normal_msg)(struct cdns_pcie *pcie,
> +                                                          u8 busnr, u8 fn, u32 r,
> +                                                          u64 cpu_addr);
> +       void    (*pcie_reset_outbound_region)(struct cdns_pcie *pcie, u32 r);
>   };
> 
>   /**
> @@ -305,6 +532,7 @@ struct cdns_pcie {
>          struct resource         *mem_res;
>          struct device           *dev;
>          bool                    is_rc;
> +       bool                    is_hpa;
>          int                     phy_count;
>          struct phy              **phy;
>          struct device_link      **link;
> @@ -444,6 +672,8 @@ static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
>   {
>          void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> 
> +       if (pcie->is_hpa)
> +               addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
>          cdns_pcie_write_sz(addr, 0x1, value);
>   }
> 
> @@ -452,6 +682,8 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>   {
>          void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> 
> +       if (pcie->is_hpa)
> +               addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
>          cdns_pcie_write_sz(addr, 0x2, value);
>   }
> 
> @@ -459,6 +691,8 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
>   {
>          void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> 
> +       if (pcie->is_hpa)
> +               addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
>          return cdns_pcie_read_sz(addr, 0x2);
>   }
> 
> @@ -525,6 +759,22 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
>   int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
>   void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>                                 int where);
> +int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc);
> +int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
> +                                enum cdns_pcie_rp_bar bar,
> +                                u64 cpu_addr, u64 size,
> +                                unsigned long flags);
> +int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc);
> +int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn, int where);
> +int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc);
> +int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
> +                                    enum cdns_pcie_rp_bar bar,
> +                                    u64 cpu_addr, u64 size,
> +                                    unsigned long flags);
> +int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc);
> +int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc);
> +
>   #else
>   static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>   {
> @@ -546,6 +796,34 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int d
>   {
>          return NULL;
>   }
> +
> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
> +{
> +       return NULL;
> +}
> +
> +int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
> +{
> +       return 0;
> +}
> +
> +int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
> +                                    enum cdns_pcie_rp_bar bar,
> +                                    u64 cpu_addr, u64 size,
> +                                    unsigned long flags)
> +{
> +       return 0;
> +}
> +
> +int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
> +{
> +       return 0;
> +}
> +
> +int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc)
> +{
> +       return 0;
> +}
>   #endif
> 
>   #ifdef CONFIG_PCIE_CADENCE_EP
> @@ -556,7 +834,10 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>          return 0;
>   }
>   #endif
> -
> +bool cdns_pcie_linkup(struct cdns_pcie *pcie);
> +bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie);
> +int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie);
> +void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
>   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> 
>   void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> @@ -571,6 +852,13 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
>   void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
>   int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
>   int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
> +void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> +void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> +                                      u32 r, bool is_io, u64 cpu_addr, u64 pci_addr, size_t size);
> +void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
> +                                                     u8 busnr, u8 fn, u32 r, u64 cpu_addr);
> +void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
> +
>   extern const struct dev_pm_ops cdns_pcie_pm_ops;
> 
>   #endif /* _PCIE_CADENCE_H */
> --
> 2.27.0
> 
> 

