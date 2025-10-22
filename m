Return-Path: <linux-pci+bounces-39003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E5BFBBB5
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD79119C441E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58A2F8BF7;
	Wed, 22 Oct 2025 11:52:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023095.outbound.protection.outlook.com [40.107.44.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE62302770
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133951; cv=fail; b=J+exqppltdJqTGxqfKSxjtNNkEcWNXVYnnUMGCCJ7Q9c4Yn5tttETbhdp8+Mr2uRUMGRzIVW3owQffko0SLxqUyXegYbxaIVhNmR/6ZQzbHS6k3K7O7akBGRAT8y5kiR43wYB7WDO3nFpk83YfxyeUM60Z9RPOG2RjrwCe4vN1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133951; c=relaxed/simple;
	bh=NssPpcjAjxsgPoRtmgjIQWHs37e70SClerFmY90SdGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2rDyfIjx+sDKVCCIiqumjHm+Z1qzRVsFDboT1fPPnq7O0Nm3YEFjAXtuIxUUo27uQM7qLwY9rW3RwvgEDuqVpZezy8POyWTalJsYmdCmKTOFVIB1hEqdsmrXC0Vwb6S3UAys3xApfn8UVBEEusCZMG6iHa5TSKTYJ0CRHeBxtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLYwad4EE/3wabYS670rJm3+j//OJpc1xTsBa3k/zSOCswnLiDE9jRy6CS7vd7osYn5f55MgSyVkghYr4DE7DrlxekwuWaNENbsZr2PLq9lA6YWgoW2RjxeW56l+uXDphSqIeSymeQS5KX4vYiCViDSJwlEbn3HsReqqWSs9kuJD7Yp/jRJ+bpcNlmU/WdlD6v87RpCBcJdhWlDJfo/W+npP4cWyIdh1/Aykza3KmMLgPf6osZnKwBNymop0elRM3IombFhnHeLbsGC2hz9iwsUElXOrJeASG1h6HMzNmwau4ybT/P6PprD62QPhAV00D/OBV3RPk1o44flQnKkGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcarUopedmKtskUzgp+o/OtOQFnLiwTq3sG4EYqU5ys=;
 b=e7a8PPN9rO8U0mww6ZIO+e4yUH9xKhb3MS00pvR7tAIdLyf3Bg6+k7YqhRf5PbpC5n4NjlYP5WCisG5jXg9W01pqFEAlCNJqjEdM7TwdSvXWfCAu3XezIV94yyyzHFs1VKZkPwrjIAl8eIbyFuDMrMPyYmd2REUQYe97alaM/h6Y4YbG4L2xgUBRGjQBA3EX37antGYh/HzVvoOChaQLalwcGKaUZdlGUkvqhZel/gOsTKx0v97HVTUHEeSTkcvWDU+nAh1eRl3YwcStpl/0kn8gFPSlpHCAJHPJYVAgYrI42IJov8pJRvc9W84VwkOwTNnQl/DlVrRkWSY7UpsMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=google.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) by
 PS1PPFEF7C8A25D.apcprd06.prod.outlook.com (2603:1096:308::26c) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.15; Wed, 22 Oct 2025 11:52:25 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:f4) by SG2P153CA0016.outlook.office365.com
 (2603:1096::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.4 via Frontend Transport; Wed,
 22 Oct 2025 11:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 11:52:24 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DBF9C41604E0;
	Wed, 22 Oct 2025 19:52:23 +0800 (CST)
Message-ID: <8b569a35-3913-4dfe-a586-7ec9669edbc1@cixtech.com>
Date: Wed, 22 Oct 2025 19:52:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Add L1sub support
To: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org
References: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|PS1PPFEF7C8A25D:EE_
X-MS-Office365-Filtering-Correlation-Id: e99fed55-709a-44f0-440f-08de1161776f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGYrRy9CazV1NlE2MXRma0QxcXF0MHVYUCsrZFBlcVE0Wkc1ZDFhS1dKUGNP?=
 =?utf-8?B?UnovYUdkTmdjSFRnL1MxY2V2YlBCZjNqTCsvVHJjM25QSFFEcFQ5RTR2dzVr?=
 =?utf-8?B?eDFPMDRwTGNwVm9NOTVNcmdmamVBblF2WVZKaUV4cmVIM3dWMm9KUDZMSVFT?=
 =?utf-8?B?VUZneFlHM0haZGZib2pUaDhOMVhSM2hrb3Jic0hrUFY0Q3NzUGE4b1ZpUmtu?=
 =?utf-8?B?NDU5L0dEVTJ0NlNTUFN2akVuc0hmNTlyR0dkdDNST2tMZHh2akpDYWVVbEIr?=
 =?utf-8?B?MnB5elhBTGgxTFRIbkc4ZUxibnA5bmo1RTlKUHh3am9ET25VcUtMQ1ArcnBL?=
 =?utf-8?B?MXU2S3NyL3RkUHE0ZFlXZUVXbHRSc0Z3S2pSQWlWeWZTckZxdEJVelZ0NWxZ?=
 =?utf-8?B?eENCS1JVYjZ3djNadE45WjlOa25TTUlQN1VSblhnbDlwZVZLRll0TmM3Z2xo?=
 =?utf-8?B?aFVPN3JxRDJVUFdaSTdOSzdCNmZHdi9KVjR4MU1WdjVvazdjZXNDU0w2YVBC?=
 =?utf-8?B?ZmMzbjhjZk1kOUFiTXFYV0pibkorTTNNWEZtbm84SzFvNDRuUU5HU0dGaTJy?=
 =?utf-8?B?T1poOTRUTE1md3ZwYnoxYkxnZit2TjAwZU96TUpmNEJJbWJ2Z3JFZ2FORGZw?=
 =?utf-8?B?KzE1WjNSV0JjcThUcWxaaGlnZE9yTTB3TUFTd3lHWXdTYmM0aWw5WVhHMTdC?=
 =?utf-8?B?MVl5NVVnM3JWdUEwTGdTQVhvMXp2a1FmNFVHMTU1N0I3WVlSNEYwL2xiNHRJ?=
 =?utf-8?B?UmN6dFhSbkJqWmZKRUtwWXFBTnVDY1pLNUJnUDAweFhBQ0I0RDF1cHlSeE5m?=
 =?utf-8?B?Z2NiNk9nUGFTVE13S1R6aW1wcktHcVZEMCsxdlY5Zi85ZHQ1a3FEU3dDMC9v?=
 =?utf-8?B?MUpIUkRTY1NGSzNUVXJaU0JIcFdYUzgrM3NQUWJqL0xoUlBYQWxEbE1OTTFj?=
 =?utf-8?B?WmpYRWhXclF1Um1MbE5JaG5YdkpVdUp5cDdSSkFxd0lhTExhU3RRNWhDT2cv?=
 =?utf-8?B?ZGRpSTRtOVBCeWpNYUlyR29wZVRlRWU4UEc5b0ptdFlkdWhTWXh2WmJCS0NB?=
 =?utf-8?B?cy9WVmZSaGw3aTR5cXlmRWdHVTZ5MVF5YXFhVjIyRzBQMHE1clhkbmVjeWd4?=
 =?utf-8?B?WTc0TlFiVWV6a09QclJSZlloWVhmQUd5NmsyQjdvNkNlQy9MYlFZVzdjb1Nn?=
 =?utf-8?B?RERUZ2RQSHF0OUlUUm9uRnNsYUw3SXpublRSMkhvUFZMQzFXVVBEbUxMazdw?=
 =?utf-8?B?RVBTalBaOGtQT3NYWVRWTks5RXYxSlF2Y2tkeXQwZjdOdmdRdUh5cGVZWitm?=
 =?utf-8?B?RW92Umw1eDNURnQ1RlltRDRsdkpxeWpPYlY1eERWZjkvcGdRb01sb05UZDBV?=
 =?utf-8?B?N0kvcFdzUE1QQmpGSE1wUW1jU0ZQbWVrQVM4cTN6eERsRmNZcVpWOHIwN2pH?=
 =?utf-8?B?ZnV5YWJUWTBySlpEcmJ0SVVQcjE4cExkSDBqYVlrUlNhV0w5TnBZWFptekdW?=
 =?utf-8?B?SFkvZ0RObEZGUmlrblRkYXcxUUhCWE82NUZha3VLMnIzV3dnbjNDMlFHOVgx?=
 =?utf-8?B?MzF1N3NORDlvOUNEZUpydXM4cHFDS0dpNktURXZjeHNHZ3JMQnM0aGtMbDJS?=
 =?utf-8?B?OW8rdWlBUVdrcmNTNkFKMTc4MlkyNFhrR3dxNzdQTHNzQ3RBSnUxcCtCYmw5?=
 =?utf-8?B?QWpHUTMxQk5XOUdYQVhrWnE0WWIwcTMrTzFqOEFxcVEwNHdIQTVyK2R6aGFE?=
 =?utf-8?B?Rkp5VkhoNHhWanlJQndmbnJsZnNWOFNoTVBsaE9hajY5MS96WHpCelcrcXRy?=
 =?utf-8?B?emtzOEEydkgxSnJUR2tCS2E3MmdVK3dNbGVkNTNLUTg2bDQycmptbHdmTjBs?=
 =?utf-8?B?STNvMmwrRllENUlxTlA2ZkE3YWVhZEFBQndEZ3JZaFdLZ1dJZjBmUEZqS1Rt?=
 =?utf-8?B?elY1QjNOeHZHNDl5WnVhVlY4V2VaTFRJNjB0bE95Sm9TVnBWVlg5TVlGT1Yz?=
 =?utf-8?B?cm5OTHRQeGJ1dzlNQmo3RENmMGx4cTJjblB5MTBwWVJ6OHo1U09VTkFqNjdG?=
 =?utf-8?B?Y2Z3aHNtVjVtbFNTSXBjYXF4K0ZkbW5rZmlUZFlQcU9Ea2dVUWxHbEMxQzBj?=
 =?utf-8?Q?Vd4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 11:52:24.4826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99fed55-709a-44f0-440f-08de1161776f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFEF7C8A25D



On 10/22/2025 7:35 PM, Shawn Lin wrote:
> EXTERNAL EMAIL
> 
> The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER reg
> to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - drop of_pci_clkreq_presnt API
> - drop dependency of Niklas's patch
> 
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 36 +++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c..18cd626 100644
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
> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>          struct regulator *vpcie3v3;
>          struct irq_domain *irq_domain;
>          const struct rockchip_pcie_of_data *data;
> +       bool supports_clkreq;
>   };
> 
>   struct rockchip_pcie_of_data {
> @@ -200,6 +207,31 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>          return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>   }
> 
> +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
> +{
> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +       u32 cap, l1subcap;
> +
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
> +       cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +       if (cap) {
> +               l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> +               l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> +                             PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> +                             PCI_L1SS_CAP_PCIPM_L1_2);
> +               dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> +       }
> +}
> +
>   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>   {
>          u32 cap, lnkcap;
> @@ -264,6 +296,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>          irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>                                           rockchip);
> 
> +       rockchip_pcie_enable_l1sub(pci);
>          rockchip_pcie_enable_l0s(pci);
> 
>          return 0;
> @@ -301,6 +334,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>          struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>          enum pci_barno bar;
> 
> +       rockchip_pcie_enable_l1sub(pci);
>          rockchip_pcie_enable_l0s(pci);
>          rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> 
> @@ -412,6 +446,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>                  return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>                                       "failed to get reset lines\n");
> 
> +       rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node, "supports-clkreq");

Hi Shawn,

This line exceeds 80 characters. Can it be like this?

rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
						  "supports-clkreq");

I have no doubts about the rest.

Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>


Best regards,
Hans

> +
>          return 0;
>   }
> 
> --
> 2.7.4
> 
> 


