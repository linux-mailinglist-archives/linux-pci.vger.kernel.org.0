Return-Path: <linux-pci+bounces-40948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04608C505CD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 03:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 709CA34AA23
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 02:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C52475CE;
	Wed, 12 Nov 2025 02:50:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6822370D;
	Wed, 12 Nov 2025 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762915799; cv=fail; b=P8CcCDvqm9FkujDVANMlXxEXUszEaNAWrQMHO5qi9kMfcdy0Kre+497hokYXZgdopJlF87ubXKNthxM3dLxkQOmfO9EFjT4vJQlNqZiH7Li/Fp2vOtZlkuSkmbYnORQXP+uvMIMBVtKBbbE/Gtk0XipFmFqL4iptJ5t/bIfnx54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762915799; c=relaxed/simple;
	bh=aAaK+fOiXBOm0RkUfxjWXFCAYAkD8GLQGttzI0yvlFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTioI4BYZHTVKef+gSiOWLaV77v8Tl+n6B/9JTQecZR4bsxn/1uBYnW89yARt5ppH28veheeNNHN90cSnkd5Nz0x0NJAGXBmwlsCXHHmyWn5USMDYOYR0JYBfLaVG7CY8FI6UUUJNKJc3F0YAHxajp4bbBeAuS06zbb/UhoVbdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyq2AkxHrmiDmv91djjP00tLCGrUR1VscSvSARaG7ts+WbvLnCE1Nx2XyhPZWuUf+2CRxxE87QN6JH30NiVjvEMj1jxlGzh6vU3Z39WqU9foVJMSl/H32r6cIJLNburPvux8PqpEybDLmAbAPEq5yJrr5HZvnI/KLQRoRnnaeVTaPdqLl1xIgbfk+L/YVZzZFlArBlk8j0V2bUh+7PnLp3Z4QXBIqhedUDahkOXZ2vOanun2Oi8xJUsFE0+BLOpDju+CoPfqIE2nLz5aCrFwTwP6/50yJgMESOp2Z6f1umuifPCaRMl2/hZCywBOy2bD0kaXRx1xGtzR3rRmxNto+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhJ1h/19pA1rVIw2NzIOWDwzP/r8gLb7prN4Oc3+rqY=;
 b=tXRq7MS0iCK/mHHRCdsVLiN4XV1LmFGykcK7RdYwuTIo4P5PEm+Bpv63yRqFQMrE/KMvYwd+WJpPVzoCnKWTLAMJ4R73CjcdITfWOc0VHURjp9f6QKj9K+dFNqjL6Mz2aiX/5Ce+gsx7dWjfrNPjfT0TmhC20VAD6CeLPgvBGFfIcq60ZQPRcB4dqBgYST25mOREwvQiV90qel+xmu9YOKgMM1/shAMMO7zkVRCLx5zNgfXXsSqFZMHzihzWf4zu7HjtfB4JUz0dWV9eKKCC1h4ZtaFGSe8T0ZznW+34ayl0jHlsz/zbon9+Ecnto5CywlfDB9vNIYpMwTyzxZ02uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cknow-tech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:4:186::22)
 by TYPPR06MB8208.apcprd06.prod.outlook.com (2603:1096:405:383::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Wed, 12 Nov
 2025 02:49:51 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::b) by SI2PR06CA0016.outlook.office365.com
 (2603:1096:4:186::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 02:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 02:49:49 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4AEBA41C0141;
	Wed, 12 Nov 2025 10:49:48 +0800 (CST)
Message-ID: <e8ef529b-b2e9-4c39-8137-60795fda7773@cixtech.com>
Date: Wed, 12 Nov 2025 10:49:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI: dw-rockchip: Configure L1sub support
To: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-4-helgaas@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20251111221621.2208606-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYPPR06MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4b5c70-cfa5-4e0e-6de1-08de219625a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1Y5WG1acmE5TFBITlpjS0djdWxpdXY3a0dzSnl0Q1JWV0xlYjFYSmdsZVQ5?=
 =?utf-8?B?NXQ3dG96dWFWdTF6UktQZFlMMENkUUlhU2Jyc2szT3U5cDB2emc3OFBLdnB4?=
 =?utf-8?B?VUlxNEtrcXgwZUJrY2Q4UVVtMjF2RXZwVDJFYVp1ZVE0ck9BVnFaQS9HTU8w?=
 =?utf-8?B?OXpJeGZoRkJNVUNBUjE0S0VJTEd1T0l3M1BSMGxFTG15RG0vdWYvKzZZTmZS?=
 =?utf-8?B?d0tkbWJTbkVHcUFKRXpyV21pQ25vUjlVZk9uZmpaNStDd0tRVEFuZm9tZXlz?=
 =?utf-8?B?L1dhTTA1bmtaazRXemU0TDkyQm1JZy9VRHpKeENMQVhzWTkxR2hRUEhNS2hl?=
 =?utf-8?B?cUs4c2pteERFZHNHcHl6Nm9NMHptcG84UVY3ME85Tys2aHRrN2ZBRUFVbjNM?=
 =?utf-8?B?M0h3bXZERU81c3VLakd2Z1Bvd0QyMHFWUnQ2YS9YNHdUMEJ1QUtFazNsUS9t?=
 =?utf-8?B?cFJ1TzU5eUhDZG82NlY4ZDVDOFBVZEtZK2VvcytZWFd4RGUxQkNBSWFRMklQ?=
 =?utf-8?B?N2NwNTRDSDVoaFlEckc4aEpRbEZYd01FSis2aGxNaWRxV0JQZmJsUmZucjRu?=
 =?utf-8?B?ZlFJTFMzbW1WWU03MnhZSzlsekx3MWVxd2lLRDdRYlB3ekROZjZmVDJlWTUv?=
 =?utf-8?B?cHdDcDZZR2RwbTNHdVV5YUVxNDUweEhHOGZ4dElVUHltdkVra0dhancrSzFv?=
 =?utf-8?B?UkZ1MWQzMmw2NkFWcmxOR3dXQWNSV05DcWRXQnJPK1VPOTYwZFBGVnFUSWRh?=
 =?utf-8?B?bkFySUY1S0RBRWgvSGdJSjBGcGNKVzB4KzQ1U2lnRmI2Nk5QN0hGeGtobS9J?=
 =?utf-8?B?QUJoRDk5eWUxekZqWldNSFFicCtSL1RZa1JNV3RXd2k0b0lpZDJWcWdoSWlN?=
 =?utf-8?B?NUdZWTJQYm1EY0RMV3RKcDdsNnhJVWtzc1g5TTR1Y0xqNzMvRTNjVHhRQ05r?=
 =?utf-8?B?bWdTaUpKcEJVbVFaNDZ6OFZBUzlIWVZ1dkxMdU9vQS82ZFJ5SlplVWVhZUNQ?=
 =?utf-8?B?YTlISWNvcmFGYVlxTUZ1bzdHbEs2TmNGczlsdWpTa1hNRTlwS2RWcWhnbGtt?=
 =?utf-8?B?YTVnS041dGZvczNxbTByOFBlczd6bVU5RXh1dVVqYlRLaTllNlg4U2FwWU41?=
 =?utf-8?B?ZlZDQUh3Z2JhS0p1ekpBRUE5ZU5tWGtDTDBYbnFTa2F3VWVtK2MxMmxHTHVz?=
 =?utf-8?B?YXlYdjBKSmlBK2E0L09QK1BxemtWcXk0UjM0Smt2S3F3K2hORmhyTXdSR3FM?=
 =?utf-8?B?WVJxSndkcXluLzZ2VTJlOGxUZE8xaEYzNFpEamF6dXlYQzNYbEZnR01WUHEw?=
 =?utf-8?B?dWlFd2kxQnNHc3V6bXBKd2lyQXZWdHdVQ1RwbWZ3R0JHY21ZZlBxN3ZnS3pH?=
 =?utf-8?B?NjkvMTM2NklrbnFIemcwZ2tFb3VWMFhzZHptbzc5SzREQ1VsOVFXRTdkTnBI?=
 =?utf-8?B?RjliUlZja2hYVVVzWXlRU01NSklCYzF3TDZhVktQOTM1N1RDejhmZVE5RnI1?=
 =?utf-8?B?NTNud1h0eGVaR0lhREpJM3FnTEtYaHZPNVBERlFJVUJEZnhrVmFVK1hlNzEw?=
 =?utf-8?B?RGdFYUdIaUVydjZvSHIrVk81S2FNZWs2a0lKN3RETFJzNmJWZTc5MzB3Zkwy?=
 =?utf-8?B?VzV5TzZITGxjanlaNzB5V3JreUZLMHZ6dFE0TDhPSGQzeWFEcis1aVpRWUpn?=
 =?utf-8?B?allMcEUyQTc0bkttZWtvcFlkcUNSa1Q2aVhxZHFENktXbkM4bmZWTVpGSGVx?=
 =?utf-8?B?YXFCZi8yRFcxVlBUNThRYUpzSldxVngyc1EzTzAvaFBWUWhrSW1kQjZCZ2lv?=
 =?utf-8?B?bVN3aVlHbUsvZFVDSFFpT2gyVUtQdWs3NlFmSVZ4bTFtdVR2YkpZS0JDc0VN?=
 =?utf-8?B?S0pRWkJQcWRSVElyM1NaNjhxVHppZXdYcHVpRUtFaDJnSThIbXo1S21NMVRo?=
 =?utf-8?B?OUdsOGZpc2Urenk4UmhoY0NuUi82aXZGUjZQTzM1cG9ESGNLYW4wdkJuOTBq?=
 =?utf-8?B?UEdTcnlYYUliVnJHSTgzdktxT3VTNEcwR29yTC9vK1lUanFac3Juckl1S09G?=
 =?utf-8?Q?qRWVoK?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 02:49:49.2380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4b5c70-cfa5-4e0e-6de1-08de219625a8
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8208



On 11/12/2025 6:16 AM, Bjorn Helgaas wrote:
> EXTERNAL EMAIL
> 
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> L1 PM Substates for RC mode require support in the dw-rockchip driver
> including proper handling of the CLKREQ# sideband signal. It is mostly
> handled by hardware, but software still needs to set the clkreq fields
> in the PCIE_CLIENT_POWER_CON register to match the hardware implementation.
> 
> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
> 
> Meanwhile, for the EP mode, we haven't prepared enough to actually support
> L1 PM Substates yet. So disable it now until proper support is added later.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> [bhelgaas: set pci->l1ss_support so DWC core preserves L1SS Capability bits;
> drop corresponding code here]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com


Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>

Best regards,
Hans

> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 38 +++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd09..62a095752833 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -62,6 +62,12 @@
>   /* Interrupt Mask Register Related to Miscellaneous Operation */
>   #define PCIE_CLIENT_INTR_MASK_MISC     0x24
> 
> +/* Power Management Control Register */
> +#define PCIE_CLIENT_POWER_CON          0x2c
> +#define  PCIE_CLKREQ_READY             FIELD_PREP_WM16(BIT(0), 1)
> +#define  PCIE_CLKREQ_NOT_READY         FIELD_PREP_WM16(BIT(0), 0)
> +#define  PCIE_CLKREQ_PULL_DOWN         FIELD_PREP_WM16(GENMASK(13, 12), 1)
> +
>   /* Hot Reset Control Register */
>   #define PCIE_CLIENT_HOT_RESET_CTRL     0x180
>   #define  PCIE_LTSSM_APP_DLY2_EN                BIT(1)
> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>          struct regulator *vpcie3v3;
>          struct irq_domain *irq_domain;
>          const struct rockchip_pcie_of_data *data;
> +       bool supports_clkreq;
>   };
> 
>   struct rockchip_pcie_of_data {
> @@ -200,6 +207,32 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>          return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>   }
> 
> +/*
> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> + * needed to support L1 substates. Currently, just enable L1 substates for RC
> + * mode if CLKREQ# is properly connected and supports-clkreq is present in DT.
> + * For EP mode, there are more things should be done to actually save power in
> + * L1 substates, so disable L1 substates until there is proper support.
> + */
> +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
> +{
> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +       /* Enable L1 substates if CLKREQ# is properly connected */
> +       if (rockchip->supports_clkreq &&
> +           rockchip->data->mode == DW_PCIE_RC_TYPE ) {
> +               rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY,
> +                                        PCIE_CLIENT_POWER_CON);
> +               pci->l1ss_support = true;
> +               return;
> +       }
> +
> +       /* Otherwise, pull down CLKREQ# */
> +       rockchip_pcie_writel_apb(rockchip,
> +                                PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> +                                PCIE_CLIENT_POWER_CON);
> +}
> +
>   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>   {
>          u32 cap, lnkcap;
> @@ -264,6 +297,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>          irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>                                           rockchip);
> 
> +       rockchip_pcie_configure_l1sub(pci);
>          rockchip_pcie_enable_l0s(pci);
> 
>          return 0;
> @@ -301,6 +335,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>          struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>          enum pci_barno bar;
> 
> +       rockchip_pcie_configure_l1sub(pci);
>          rockchip_pcie_enable_l0s(pci);
>          rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> 
> @@ -412,6 +447,9 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>                  return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>                                       "failed to get reset lines\n");
> 
> +       rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
> +                                                         "supports-clkreq");
> +
>          return 0;
>   }
> 
> --
> 2.43.0
> 


