Return-Path: <linux-pci+bounces-38862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F6BF5213
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 10:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC546351F55
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35506A926;
	Tue, 21 Oct 2025 08:02:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022114.outbound.protection.outlook.com [40.107.75.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA9231A30
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033720; cv=fail; b=cHSyqUo0gkYuWwkBVfN5IDfGf/qU/rdSD6yqRzMJwUqtRlTp4fZQabZHmCE8gbSnhXEKCyCWzbKKI9VKqAKsSugFrbRP9ORFcqAGS3n5wkoMLq9CaFY0sGfmysxBnos7KRBJq4ZLhOdt1ZeB2DcIhMNebW+/1WYfOH71axlMPrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033720; c=relaxed/simple;
	bh=bNDd1dTvfd0pN1yLwDFxtiDTTbFY4pq7ZT+atOTswno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dC6knVhrZIvMUpL64ABoQbUkNf20GZw6ICOBJJUt0xk/gC0RgeeEEFkK7eeMZVZ8fhhjqmKGBg5dTXjSwHR+OouVKZ/543ED2/zwSAuVMzi2O05Eddchv4HCrsr4uGtx1A8t5IqJLfov36ZAqteKWP3F9cySA8epJcT/cROK3Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4EgiUisp93OvdN4ZHh/+zfrzGfVd07Jo+plpiL8SIvl/Cw+BCcG+UJYQ/FLa3uQYpB6a5lggbk6J4zbWMPXDc/Dtl6GW3sVUqBLQcnHMHt3lHmKsO8HljJ2Z+bXPK7APLmYYwg12yR8Ej2VK8Ka2IA5q7UMIBM+pkKVEafojBiNYv8Mx6e5B74EZrhOKCa9z+fS23z7G/qWzfmeQTXQ3NURtJdVGsRkhuNyZUMRMeohg57yRfb87BD8m11v3zHs751nR/JP+ZUT5TUMem7f1FcyXWnWPvV2xkVhhkIEHbWEGMOCF0H+MGG4f7s+cMi14cK4afJdZk8ne7Tuj93HPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLpmmxrMWEMTJHLAvX20Zu29Z79XZ6z8LgNQJeVqtMc=;
 b=vVjhTuruaeYIQnmjTKt25c7dlxNSZt3ggedo1aAx6qIC1mUxftGkstyZDp9FHuUCdbJHaDI2CPJX7M/t6y/xXVUfIJ1ouNvowxMmLSrq6CuyzaZyLsnQRPNXjn164VHmjwcgLMYBjDN6uN+8D1L25U2+Po9jfZgKihqVF0XGoY2dwivyqCc7Qt0pfMYYLUGjLo5JvSxZVs1My22rLZLMpyKIwOlUuyfbMdVV15xc0Xmvyr1frcZ/yP19I39OHftPETim9lTtINBT/+/z6vLrzUm28eV9Gw3AlWrOwfGchKnPzM4NRhSHidMTH21AyweoeZFsNAY7f25iycIS8W5/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0029.apcprd02.prod.outlook.com (2603:1096:4:195::6) by
 SEZPR06MB6197.apcprd06.prod.outlook.com (2603:1096:101:f3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 08:01:52 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:195:cafe::9c) by SI2PR02CA0029.outlook.office365.com
 (2603:1096:4:195::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 08:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 08:01:52 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6B9E541C0143;
	Tue, 21 Oct 2025 16:01:51 +0800 (CST)
Message-ID: <3f90b0f9-06bb-44d3-97a3-a13ced9b1c3a@cixtech.com>
Date: Tue, 21 Oct 2025 16:01:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI: dw-rockchip: Add L1sub support
To: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-4-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <1761032907-154829-4-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR06MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: a1964e67-8786-40cf-2514-08de1078183f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHlLN0xqeGR2VUF0QzB5K2NDYVczRHdxeUlWSWF1VHNvMm5zLzFJNlFSWVlN?=
 =?utf-8?B?NGExZFQxYzFQOW1HME5XU0xHTlZ0WS9ETDFXN0Y5cmVaSmk4RXNzNTFXV3Yv?=
 =?utf-8?B?MUVVM1oyRGFTemswUjJVWmtXQ0djOHJ4SUVhbXpoQWlPWkdrd0ZRMVJ4VG1W?=
 =?utf-8?B?MFdXa3JuOHZ1L3hjazU5TmVTSGRuWnVUckRZeFByM01DRUI1V2trRVFka0lI?=
 =?utf-8?B?TUhBcEtPQW1POGNYMW1iQ2lSdUdKeUVCd0JoQ1Z6aXd6WkFqMHVqTmpnczhL?=
 =?utf-8?B?dVY3dGZObHlKNkxLa0F1cUpEZ3VpWVVnV1A1QUREcjdWbEtnWm9JMzFSYnVv?=
 =?utf-8?B?RGNzdWR5RmcraHErdjBVekVsdkovbUkwSEJRU0kwcktQRVo2ZTJlVWNtNUFi?=
 =?utf-8?B?ckpoWlNWYkJrdkF3RW9QcU5URWlvemFac2lCenVSUXhRZW5PamgyOGMwQjFu?=
 =?utf-8?B?RmgyYXVkaEVDeDY2TG9CSlczQU1mNEltU1NtUmZ6L3Z0UVFaQStKTWN0Y05o?=
 =?utf-8?B?UWw2V2UvSjBBUlp0dWhnU0ZmdUM1UEdiUTR5d2RpbEhkN2V0R1ptbGozNnVy?=
 =?utf-8?B?Mzc1aXo4b2RrQngycUVnajdTK283bmtRUTVmSFE1TGpON2dPTUdieXhZcWVy?=
 =?utf-8?B?ZHUxa2ZZVFdXY3JMQUltY24wOHVydEMzSERlVEJMUm1nSmRwaFpxWXFXdU1t?=
 =?utf-8?B?L2FWL044R3gwZWlXaFZtTGhGY0NyL0JrTlcxUkZQUU8rKytBeC9jWGFkNjBK?=
 =?utf-8?B?QzluR05WaEUzS2E4YmJETTM5dUxWVERKR1BlbnZZdWF0YzRiaWwxYlNneHh2?=
 =?utf-8?B?RFhweVUya0ZMTGdva2NYZFZiOXRkRFY5elhLV1dXTnYwVDM4dHc0L3RMSi9F?=
 =?utf-8?B?T2ZNNWU2TU5HYW40dlI1S2tOa1FTMkJMcnVac1JIaU5ZTllSeFNMc1YwbGpO?=
 =?utf-8?B?V3NZZWtkSkFoVENvOGp6QlZWdXVKOWZUeUNaVjBlWDJvZTJCWkczeElMc05V?=
 =?utf-8?B?cnROSGUzeVdaYnVzVDJteGplNU9oeks2YkRrbFk5S09CYzIydWk2dWp0ZXFW?=
 =?utf-8?B?Zmxna3hYR2lJekRudTlSTDZZNmpCc2NtL2YxT3p0UFR1Y3RPeUhEd3JzMFM2?=
 =?utf-8?B?NU9CUm50Tis2cEFvK0svc3ZVZi9oeUdybjRYd3FIeENvYW9hMjRhSFR4dUt1?=
 =?utf-8?B?VXhLVFRISVJLNWxqY0Y1ejJRaTFCc3VFaWRWUnltclltRHZtUWxzTnpnTFRq?=
 =?utf-8?B?WTR3YnpERGpSbDBFSm83MUMzOEQxMmtpdGJNcU1TVzRVZytMcFFKQWpoYWpF?=
 =?utf-8?B?SVVJTGRjRkswU1VydytLc0VvVVBKU255TmRLak5WekNUak1UMk1ub284bGp1?=
 =?utf-8?B?V3lCVGhlaW0xOG1YOGtQdzkrbFlMYnp1K2Q2cEFUd3NUNXZvS3RpVVBuUExa?=
 =?utf-8?B?WlAzU3RLRjQ2REY2SHg2OW85anV0WjRLZElXRVkybUNyQjYwcWg3eVBnbldD?=
 =?utf-8?B?UmI2U1lXRXN1S1M5WVl3K1gwWUtSMERmcHN5WFZraXYxRzhud09jUW9Db0ho?=
 =?utf-8?B?dkh1cFdlWnoxUFBPV2N5UzBTTm1OVy8wc0UwY3ZGbVFkV0ttRUhMZTYwY3dW?=
 =?utf-8?B?b05lQUd5STJNY3pwSGJtOFRaSG8vS2k5R1poUHE3cTFiVllkYkZxT1I3Y2lK?=
 =?utf-8?B?MERUNWU1cEF5RFFUbjg0Tyt2ZzdzK2E3TEYxT1JmZFA4akJjNVM5b0pNN0hV?=
 =?utf-8?B?eWF3OUJGY3BzNGFvb01HdDl1aTNNTzhMVU5qVDBvSzh1TDFIcVZ2VElEQjNJ?=
 =?utf-8?B?TkNPNWxPRVNwV1Y5cWRDa0Yzei9xNkRyUFBwZm9PWkY1WWRsejMreDZ2UVF2?=
 =?utf-8?B?dlpyeXd0em1qK3czTnVSWjdrWCtWNVVPeHhPc082TExaZld1YlhHeEpYUkVl?=
 =?utf-8?B?VThPWEc5V0p1MWt4ZitnQzE2WWVaSlEwTjJNUndLZGRPc3NhVEpoVDFNQ1JD?=
 =?utf-8?B?WGtZaHhFRnVRb0xoRXNkS2prbmJxNjlIVklRMU1qdk13aExTRGhGblZZRFky?=
 =?utf-8?B?eEhTa2I4NVRCTkN1alhDV1grK1dFZlhmT2xPdmxjT25WZWVoSG9nZUErVjZT?=
 =?utf-8?Q?K0zM=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 08:01:52.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1964e67-8786-40cf-2514-08de1078183f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6197



On 10/21/2025 3:48 PM, Shawn Lin wrote:
> EXTERNAL EMAIL
> 
> The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER reg
> to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 31 ++++++++++++++-----
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 87dd2dd188b4..8a52ff73ec46 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -62,6 +62,12 @@
>   /* Interrupt Mask Register Related to Miscellaneous Operation */
>   #define PCIE_CLIENT_INTR_MASK_MISC     0x24
> 
> +/* Power Management Control Register */
> +#define PCIE_CLIENT_POWER              0x2c
> +#define  PCIE_CLKREQ_READY             0x10001
> +#define  PCIE_CLKREQ_NOT_READY         0x10000
> +#define  PCIE_CLKREQ_PULL_DOWN         0x30001000
> +
>   /* Hot Reset Control Register */
>   #define PCIE_CLIENT_HOT_RESET_CTRL     0x180
>   #define  PCIE_LTSSM_APP_DLY2_EN                BIT(1)
> @@ -84,6 +90,7 @@ struct rockchip_pcie {
>          struct gpio_desc *rst_gpio;
>          struct irq_domain *irq_domain;
>          const struct rockchip_pcie_of_data *data;
> +       bool supports_clkreq;
>   };
> 
>   struct rockchip_pcie_of_data {
> @@ -199,15 +206,21 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>          return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>   }
> 
> -/*
> - * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> - * needed to support L1 substates. Currently, not a single rockchip platform
> - * performs these steps, so disable L1 substates until there is proper support.
> - */
> -static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)

Hi,

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dw-rockchip&id=40331c63e7901a2cc75ce6b5d24d50601efb833d

Mani has already placed this part in the above branch. Can it be removed?

Best regards,
Hans


> +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
>   {
> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>          u32 cap, l1subcap;
> 
> +       /* Enable L1 substates if CLKREQ# is properly connected */
> +       if (rockchip->supports_clkreq) {
> +               /* Ready to have reference clock removed */
> +               rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER);
> +               return;
> +       }
> +
> +       /* Otherwise, pull down CLKREQ# and disable L1 substates */
> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> +                                PCIE_CLIENT_POWER);
>          cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>          if (cap) {
>                  l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> @@ -282,7 +295,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>          irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>                                           rockchip);
> 
> -       rockchip_pcie_disable_l1sub(pci);
> +       rockchip_pcie_enable_l1sub(pci);
>          rockchip_pcie_enable_l0s(pci);
> 
>          return 0;
> @@ -320,7 +333,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>          struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>          enum pci_barno bar;
> 
> -       rockchip_pcie_disable_l1sub(pci);
> +       rockchip_pcie_enable_l1sub(pci);
>          rockchip_pcie_enable_l0s(pci);
>          rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> 
> @@ -432,6 +445,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>                  return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>                                       "failed to get reset lines\n");
> 
> +       rockchip->supports_clkreq = of_pci_clkreq_present(pdev->dev.of_node);
> +
>          return 0;
>   }
> 
> --
> 2.43.0
> 
> 


