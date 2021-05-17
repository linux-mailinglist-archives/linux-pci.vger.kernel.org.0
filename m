Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36703829A6
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhEQKSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 06:18:46 -0400
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:52320
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230248AbhEQKSq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 06:18:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXapycrsEEsp+W6/WW5Oa/nUVvntcoH9IGv7i+wVujZHWGe7sh29TeLMmLmQ2osIZTzKzxkJn1QWW6DhXE/AfOySf/kNCUy+mChrNivUqMsqq3X9hZCzPgy1/ZDtcXKSL/caRT4f2e4mbI/yZIPkt15RltyN5SAwOdTm6sQMPmUiN4i2eJovR2giG8I20VdirsofpYBbeLnIpRLneHLlDO179rVL/Ep+9BK5i9gsEKfnm+Ke8WjQgSz7mUoldxnT6PgMAMIe/LOkjfyOq2k6CRrVX0p43L61tdVVuVd46jgnM+FSYw1GPBBsiRfwAMqS89E6KZ4/k3TlSUURwoVOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99Oxi19DZBcPzheAflIIEwu6G2Jg7dQh/iQe6T4YM0o=;
 b=lnb8LuktNPdg7Q1kzsFUSqsv0fe570qT/uybxkMCiNSAjfxnIwXf2aFOqUZYu8uA+tpQvlCS9BR33ZB91RfPrUVXVmQjbfMz7YgiHwkdmExa03iJepYDlZXmcbCDoCSf9nFkAuiw3brLecA4dSRiUszujO9pZqcfm/25Qpl4S9OCiu3fQyUkTfXqWzSz1xeTntVaKkVXWB7/x27nZXIpsjwCI2IcNIaGKuouKMDcf/xdnC13UMLpHh/LX3Tz6g+3fNdbe0zHJcCw2DpMQYi1KD+DO9B/yOrrcSmTMbsEUGhnaeRBaNUstFx5Cy4+S63BRdGMckWz4UeT7dW2ukdjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99Oxi19DZBcPzheAflIIEwu6G2Jg7dQh/iQe6T4YM0o=;
 b=H2w+VtB6BZ+gDELsn9TIvgiV/dfaNb94cOTbcTuDQ5XoHr/EpqYrAdVxJXrL2/MM1XlEvC1SlCOLIAtj/0hnKk3iG6eDmbeP/wxoqogzbeAfbp94xZhYBFFmHLeoIN8RV72OUpidDHiPEXGWsCVfLG+7H/79l7MXbr20QJ4DwhEE9v8b2EiQPpZFsJXBwL4IeK1Sw4RuZ8bXn0xQ00xEAMyG97+hyVFyV0Oo8q8IwcAgE8SiZoTviCqg8PEaRd3JWGsNFnEtNfryE6Jg0U6vz4Imf81lvm2Gywy+Vj0go0X/j0EqrbMSycu9yncS+b9aO0NVDDKtLbYMlIDM+sQaIA==
Received: from MWHPR01CA0048.prod.exchangelabs.com (2603:10b6:300:101::34) by
 BL0PR12MB2819.namprd12.prod.outlook.com (2603:10b6:208:8a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 10:17:28 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::7c) by MWHPR01CA0048.outlook.office365.com
 (2603:10b6:300:101::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend
 Transport; Mon, 17 May 2021 10:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 10:17:27 +0000
Received: from [10.25.76.219] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May
 2021 10:17:26 +0000
Subject: Re: [PATCH v2] PCI: tegra: move to use request_irq by IRQF_NO_AUTOEN
 flag
To:     Tian Tao <tiantao6@hisilicon.com>, <p.zabel@pengutronix.de>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1621213953-54030-1-git-send-email-tiantao6@hisilicon.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7e203ed5-526f-3a45-9f82-ba3f567bcc83@nvidia.com>
Date:   Mon, 17 May 2021 15:47:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1621213953-54030-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b35134bb-fba9-41c6-9fbf-08d9191cf919
X-MS-TrafficTypeDiagnostic: BL0PR12MB2819:
X-Microsoft-Antispam-PRVS: <BL0PR12MB28195B3350E84FACEAC2A33FB82D9@BL0PR12MB2819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvhW81dcnkOBRFqkP/COC/JsjQGpuGS2fRAS6OMNV5SHG1ehtTSs87YnJcDNWY8+x/FyaEnUV5FCQGxlJVrtyhcKTKsjSl3rh0mOTxkdEZYU7fE0n9u4G/se8s9q1r9ed6wbbV5ZFlgGuEwOfqiYwIh6WS3RuO6G+Mgoomi2WJqARngr6q6h7pHW9RuDiPF234Y6mpiO1BUw4vxBCVQmcMxKq8RdMnJIEODmBR6vMSxCVJWlX05o3rsf60Yy221XKH3lGpXVwFsE9qq7t3FVsI7WTH/vtHgCX95okupnECuVnuHOmOdB4Nvofvi+PizqID8soxVvUiymwGDHvZORExD1jGklBYHAYQ/3b6OBg4+Os+uF1zh8eydaenOV+U2fbvvvS1dql2qdmMduX46uo2VWAAN8h843JPazpbR+ICn0dFBqAmxJ/mKoOgPOp/vmFTfSeGdp6M5e5/S6Nr/f+1tsWNIdQGI+uhaog0CAmmUkcIz4tSNCt21WZtSjKew2GGYmvzrNVmQgLmKTQbUxVXCUSc+mXn+NMhIuzh/A2eQRcQFDdHIzJDtyKzeJxPTfW+si2NWgbyn1AnFcRNGf1HSlG1IiapZV4o9cMu+vQP98kwfL8/18vi4CY1kgrSpLkpsVf0LCerx1E5V+WezPaCWMILYhXmmEjg6g7keWvWK9xBXBqO5mcu+zUIRGoS7S
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(8936002)(2616005)(36860700001)(31686004)(70206006)(8676002)(54906003)(110136005)(36756003)(36906005)(70586007)(16576012)(7636003)(356005)(26005)(83380400001)(16526019)(53546011)(86362001)(336012)(5660300002)(2906002)(4326008)(82310400003)(426003)(186003)(498600001)(6666004)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 10:17:27.7531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35134bb-fba9-41c6-9fbf-08d9191cf919
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2819
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the patch.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

- Vidya Sagar

On 5/17/2021 6:42 AM, Tian Tao wrote:
> External email: Use caution opening links or attachments
> 
> 
> request_irq() after setting IRQ_NOAUTOEN as below
> irq_set_status_flags(irq, IRQ_NOAUTOEN);
> request_irq(dev, irq...);
> can be replaced by request_irq() with IRQF_NO_AUTOEN flag.
> 
> this change is just to simplify the code, no actual functional changes.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
> 
> v2: update the commit message.
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index bafd2c6..7349926 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2021,14 +2021,13 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
>                  return -ENOMEM;
>          }
> 
> -       irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
> -
>          pcie->ep_state = EP_STATE_DISABLED;
> 
>          ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
>                                          tegra_pcie_ep_pex_rst_irq,
>                                          IRQF_TRIGGER_RISING |
> -                                       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +                                       IRQF_TRIGGER_FALLING |
> +                                       IRQF_ONESHOT | IRQF_NO_AUTOEN
>                                          name, (void *)pcie);
>          if (ret < 0) {
>                  dev_err(dev, "Failed to request IRQ for PERST: %d\n", ret);
> --
> 2.7.4
> 
