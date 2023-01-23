Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13D677581
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 08:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAWHWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 02:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjAWHWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 02:22:35 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E910268;
        Sun, 22 Jan 2023 23:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5ICSY7j1KmhcDaE+OWtHyx5jsUFhBFY9EaHYidTa8kBi56hyebiJF8yYcixKXbOzG1oEQ3kU/Cg3S0+OgbeNRrQUfFzfqgyAQGaaAqG58XKWPPl9dhhQHlP0MzuGEChMW4Mr4A0h9JKurWN174+vKun8jmdSLucpsKf9csCg6c6a5cbIzIoLAahRwW9bBm1NOFWRMLDIQyLUXMRYSUqRr31ThcvucpmoXKFgIFyIIgQSO9Mb+pCPu0yCNDgiDaxqj2CFvuA5dPKVzPT9yU2f80E+aesuD9JIvg6OEIuIF+eyhV2De1nWoV0TfWi1QwCfx07IlYiUAGyxWoa9YIECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIahqwCZK1SlNpeHyqNRNijgGDNNvkPXrvQ5QG1zX0U=;
 b=J8a96rxgj4UAjDC/iKHNesXQ7eS10aWEwXw+Le1I2nLHn9nNLVcVWJ6kEDTdt/QIqGg5ruqBzjmjxNq9i81TKmTWoXjjrGuZXy/0dhx2HDUqNtbtcNvRNfjXMDAV3Ste3t2jEWoW9vYGyN2JvDaZWt+Sz4YqUXzBVh5MrXF5LLqoTWH9KC/vu90GdnI7x9H4u1QqIZ+6yaoOxGungAojg7lUwsjCBPkRIbQ4QdbxV2iapxaSVIOEjFOBTwV3+bJKp5SVtb0T01NfPUgb+S7pQQDkPNDGtJ3EfuOYG7LcZZ90LueOrq5/2IgvoMyBcjcVKrz23Pl2BbMbACZuaA43CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIahqwCZK1SlNpeHyqNRNijgGDNNvkPXrvQ5QG1zX0U=;
 b=Gy0UwniFQTK7RXk/28DS5rThIk4ZUupZ/u1UOg2O6oTtWuekCvxRuuBdwy383Y/1qi6IebLeu7J7/Yx9+6UECdVY6EmsvPsqPHyLcI0ljaYEprt3GwDjE0O0MiJ5BGVrjd/OvWWCHFHF14Szcn9/bCI6IB6ocaSI4ZYoVoQ5BojJ8Zhy205TC+rrHEIHd7nsPP5QEd1+L42/awyxuTqtXN5l9DWWYJYsukeTEIe630QCVrSZ0mERNYYPCxGnVCUbTgT8w0g9URE1bUZLTkz8OMbHLfdr3TBNwNP92BqdbA2W1fijqaknJxvdYurOzyWt5K763iRTE/hT8ffQufoyAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 07:22:31 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::8ae8:c68e:57a9:6dae]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::8ae8:c68e:57a9:6dae%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 07:22:31 +0000
Message-ID: <7c9c11e5-c5f2-d36f-6204-ebc76646ee35@nvidia.com>
Date:   Mon, 23 Jan 2023 12:52:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vigneshr@ti.com
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
 <20230111114059.6553-3-manivannan.sadhasivam@linaro.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230111114059.6553-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|BL1PR12MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c14da10-2c9e-458b-4d93-08dafd1296e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KB/AjuX5pmwmgJ6bap64nFCA0ZCi5PVBcb1GLHxd1UiAN742K/296sykD2BYooyZcD0Vp8ooKUSlh71qeDvcCe7AHdQElZGQZzeY8g5EG7BMk5RCLg/8DjgaJjOveoaQKFMk04QRFcH/wkKHTa0sUPyC4EtINa/WsRAozcHNXgFkJp6FjVnD+Cx83E2OOfxHwuhbPuZa6Je1pJ7XAOmQ/AcwtNFpBUQJvVXwx4KW4M0cNcBiyw8hBfhws7O5HHk4aq7/7UV0mkvhSQ+01Qo7eNI8p1nTY4tCX1aFteJItGfm1evD9nX+/N1SCg3x2oRobrhNZW/mLcri2qeiko1/3IrPi+VHBejsyq6I8vPErUmtt1KFr2U/d36Jg4SKEvqVIRGQxUU3xTvY0Qq3vHQ5aN8Gwqi9X74drWpBWgzFzPlq8easa4CNE2P3dI6qXe8hTxltR2VYb4u/2alnwU1XaiVd1TzC8BJNx6LfWeumeGjD4Rmpzqgb5ZvaslCGiPPV1ZPLRYLxdotkqpkdnUFWZIibTGjxv9K0dsEB9daSNrc7GgNKg5DAKZlEBgB8fucGzF5hdtMqumoGCjSZewPdYlvhOtiLQwSyrT8I+lEqVR2ZgUmXXHBheOH/dppCfA7ne96UJW+ay/Lw9VpYjd7SX1rru2IGCDQhBW+BuHMRggqnsDj84Qg7D/4YbazhOpsihMf6eQ8QdA2epPOLxRneoC7Fs3tc/ASJd+BFe+p10zI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(83380400001)(31696002)(38100700002)(86362001)(2906002)(5660300002)(41300700001)(8936002)(4326008)(8676002)(186003)(53546011)(6506007)(6512007)(26005)(6666004)(2616005)(66946007)(66556008)(66476007)(316002)(478600001)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVVpaDBZeVJzQk9KQVJnazAzc1NFQXV0QkZlKzRuMndHOTJrZWo5cHE2SzJ0?=
 =?utf-8?B?WlVFY1hiSjZBandJeFlyMWhOaDdBbHRMZXNuWkl5NUJ1UXZkNmtuS29VZGZn?=
 =?utf-8?B?eVcySVpuRkY0OWc5em1VRmJrUVdkSGNSbFFQUU5ueVZxdTQ4WVMwUG1uZldx?=
 =?utf-8?B?TUlOeC94QmM4OTFWZmM1Ky9CcXk1M01GTTBXREFJMGE3eWhNNmNobkFvOTdB?=
 =?utf-8?B?ZGV3VUFEejVHY3d1YkVRZWg1OWRYbmFKbjhMUWNxL1A0RXpZVW9jV1luVUJK?=
 =?utf-8?B?c0Y1U2todER4QytheEVUNUR3R2EvUHFYdXRuQlV6SEUxMzVRQkpOMWJjVldU?=
 =?utf-8?B?VnhhYU9vN3Mrc2tscUN1Yi8ySklLNzlvbEhac0g2am9vcFR1SzhwNloxelhU?=
 =?utf-8?B?bWRBdXVnTDA3SXRsMFh2ZVdwSjFRNFlTSmdlR0h1ZEtVSVhFNDRjOStyb1J6?=
 =?utf-8?B?ZVNMRWxKbm40cXBUOU93Q2RGNGxKeFlYQmNQVEd3VjBqZ0czckpBbGNZNHEv?=
 =?utf-8?B?Qkk3cTFTVjZocHI3aTQzelBpdTVSWjRiT2JGeGRpQTU0eXdoc25oczlaTVBK?=
 =?utf-8?B?aGxka2l3VVF2dkxPYkx6bE1XNEhNbGxPeThuSVE0ekRvOElIaHQyS2dJbjg1?=
 =?utf-8?B?ZTNEclFybkNTd1dzTGhDa2VmLzVmbTFPemJUaGY3ZzdwS0NMZFpzNUxmMmht?=
 =?utf-8?B?S3ZQa1NMZVZSRVNZVW11MlBjaHFrdWF6Y2lpMnFmVWpSNE1keXlseHE5ejVO?=
 =?utf-8?B?czM0VHF1dHBrWTBxQkNaUFhvbjhzaXRzU1lEZ1RCa0JSZmRkdGcvYU55djdW?=
 =?utf-8?B?WkNRUmJmQy9RaFNoVlVseXRiOEhRSE8rK0FYMmZONG5vY2VhQ1RwVzUvUGZE?=
 =?utf-8?B?TVlDRngwbjQvcWRxNFdYOGVXTmxPYnZoV2hGN3A2WElZUmd4ald4NnE3a09P?=
 =?utf-8?B?WXM1RHNtV3RtK3ZNQlI0VjFWRFhTeVVRUkpyR0o3NnZoVFAvSXhuZEpSMUxj?=
 =?utf-8?B?ZEVtK205Z0IrWHdNUWVZWnBNemFpUEthZ3JXeHUxZXZtZ1NBWWh2Y1BncnYr?=
 =?utf-8?B?NjBvbDZLeDZRVjVLSHJPT1dRWWlWTEl0cS9samY3M1lEQzZxWHBGOHNnbTJG?=
 =?utf-8?B?eklNZzZUVERCZjJTUkhoa3NtcVA2VENraEFTUTJXUWRUTjI3NEVNWTd6R283?=
 =?utf-8?B?a2lRYTl1VnhhbWFaS0FJdVRoeXNqanBvVWM0alluKzJ0YlNhZWxablQweEI4?=
 =?utf-8?B?WWIvRm5wMmlFdnIvclhtUnJkMWFPejY0TlhBTkV2WkxlTSt2STJDcm4vcWNs?=
 =?utf-8?B?VSttTmdYZmp4L3p3VFY4TkV1NkYrQmhQZGk2dy84VUNOa3hLdjNxSmhkL0pP?=
 =?utf-8?B?ZjNONjlrSnI3NzhKQUdwSW4xVFNFQWpZRWpzRXNnREdQUDBGaTFPbU81ZFhJ?=
 =?utf-8?B?eWlNMWcxMFVLYWk5Rk02b3pKUzRuOWcvZ0RiNzNNbStwM3M2RWJieVhVTGVI?=
 =?utf-8?B?LytnNVA5NDlQOER5ZkdBekRJTGkvdURrYXR1R2dPRisyT3hTd2ZLcmlpbHlo?=
 =?utf-8?B?bktIaEo4TmU1YzNxemM3VEJvR3lhWkw0UXo1aHk2cUsrVk9hSzFYS2REUS9F?=
 =?utf-8?B?OTNHOG5NN29senBsZi9URlpiSVNXaUtaQjZIUy9Yak90R2d0bWdOTG9PMEtE?=
 =?utf-8?B?MzBWZUFldXRjUUQwZUhOdHBtQldoTTVQVlAvN1BwbGRWZzFoYnFvaTVkOWpM?=
 =?utf-8?B?dVBydi9IMzJ2MkZQNUJLWkdlZE1hbWRvaHY4enNaUGxtUVlnMktJZTJwZXhE?=
 =?utf-8?B?aSswRmk3RGlaTXNBN3BqeDhWd1J3TUtOUzRQRWpLTXlKWWhWQmIxYm4wb2R5?=
 =?utf-8?B?WGF3NXpOYzEvZy8vbWE1Yk9vekZiWGp2TXZCZnFjbEtGaFpMVDZYelUxTjJL?=
 =?utf-8?B?UFl5d1piMGVLMmZhWGtMSlcwZUMvc1U0anRYVmdwV3NUY01WeGU5ZXlYVHAw?=
 =?utf-8?B?bTA1VkVMUTFTZGdReVh5SEw2dDU4SjdqdDczWVRweXQrbm1LSmVGdmRybmNl?=
 =?utf-8?B?eEtpc25reHJrT29yOEtxNk1rOE9QUWFxcG96V2FFRlo4bE9DTW8vRmtXTmZm?=
 =?utf-8?Q?FRWNmGsMKEksNcOn+mwppXcpe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c14da10-2c9e-458b-4d93-08dafd1296e3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 07:22:31.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/8xWWl20JfajyJ8F6THMBfZ483jI07qsdZBwhEoyLOjut7lJgswdSKC1Owa9qQtR4wmhFzhv9U1ymGzS54i2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for pushing this change.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

On 1/11/2023 5:10 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> driver implementation. Calling this API in the hard IRQ handler is not
> encouraged since the hard IRQ handlers are supposed to complete quickly.
> 
> So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 02d78a12b6e7..09825b4a075e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -286,6 +286,7 @@ struct tegra_pcie_dw {
>          struct gpio_desc *pex_refclk_sel_gpiod;
>          unsigned int pex_rst_irq;
>          int ep_state;
> +       long link_status;
>   };
> 
>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -449,9 +450,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
>   static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>   {
>          struct tegra_pcie_dw *pcie = arg;
> +       struct dw_pcie_ep *ep = &pcie->pci.ep;
>          struct dw_pcie *pci = &pcie->pci;
>          u32 val, speed;
> 
> +       if (test_and_clear_bit(0, &pcie->link_status))
> +               dw_pcie_ep_linkup(ep);
> +
>          speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>                  PCI_EXP_LNKSTA_CLS;
>          clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> @@ -498,7 +503,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>   static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>   {
>          struct tegra_pcie_dw *pcie = arg;
> -       struct dw_pcie_ep *ep = &pcie->pci.ep;
>          int spurious = 1;
>          u32 status_l0, status_l1, link_status;
> 
> @@ -514,7 +518,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>                          link_status = appl_readl(pcie, APPL_LINK_STATUS);
>                          if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
>                                  dev_dbg(pcie->dev, "Link is up with Host\n");
> -                               dw_pcie_ep_linkup(ep);
> +                               set_bit(0, &pcie->link_status);
> +                               return IRQ_WAKE_THREAD;
>                          }
>                  }
> 
> --
> 2.25.1
> 
