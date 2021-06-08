Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A139F3A9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhFHKjT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 06:39:19 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:18260
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229937AbhFHKjS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 06:39:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTKFiCqROuh3iox1gpe0vwcwgi7KCOrxj3DyTD9HGr5awoL049c6ZgkxILvd6llEikhJae3oPRCuDQt+qvsX7dpoCNBBORcddvaLoXzHngCOguYeLzyX9RTRZCPZaw+2KCEXzhuOxGYpsyWX+v5GpoSdHbacQjjbIqtbOr3CV4jFdym8Rs98PycTzuLWcsN5Y/eP4qw7AwLBSsBxXFgiLRXdO1fNtfQ7EzO1UVDMWYWuFoO/33FcS8jWpt+Aq/KqW+L5S9mPkLDBqE9TbTB8sUIZDLzrbHEQoRwT1u8vIN4DDojoz7Ybsc4IvmiUameRq1wuTXaX4jxTBObJUA/Fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRFHA9vmMNS908L509TcvBZ7BAhyknl7VduadIwxd0c=;
 b=NxnUOwQLFt4reF8vZoIhNFp82vdjaiXat1rjiUyfQD7CCwrKgHQQ2QjDzcH2agRsANaD8m2y+Qihfn6Id9GZjGAfS5WvQapfHB9Dz7BjYFgAsMW54cBzr7C+LroJokdCQjk3iGzExBftQNGl87+AZhT6R8zEek9ZXCq9VO6FQwkts68IxCtmnFJhQ8cNtkrXVM4nV8I052FXZrlZrRLkv0QFOI+ALO7iA/LeAgRni2nTYytt5voANzXWnCKAEVG9IsYVnqVr3cDWFzR54FnsHutJJ5CE+ATOn7sHqtNSzl4mgyEei9ylQawHF1UozPxV6wTDDStvimmEpdoge6+5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRFHA9vmMNS908L509TcvBZ7BAhyknl7VduadIwxd0c=;
 b=ZF0a8lWJd2iKvJwtjkCVVUiIXtSt2YVfXOOaQ2ng1IngiOae3x4rk2Bw5E/LlnPO/PqZrrjfUn2HcWiwEcSINvMRZbf7yF07tL/iN/FAr32dr/VMYLvmv10VnU58fc56YTc9O9RRNbze84K36jRLBBsKAFeFI3ZLQKn/vrMgAavEfMu39pgM9RSyeKUYCN/I9AdohAtm/k6OREcdvb5EP98mg8Gq4ootfib7bH0+/5OvQqVteGjnyLdFvth2YmEcjfsGFu8U1GrWP5H47olOZHdvYgwyxjtMD8KX7jaYs0wSyFOmZh10o862COZxXG5/YmEZZuByVN0xB6IneFYR9g==
Received: from BN9PR03CA0117.namprd03.prod.outlook.com (2603:10b6:408:fd::32)
 by MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 10:37:24 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::1e) by BN9PR03CA0117.outlook.office365.com
 (2603:10b6:408:fd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 10:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 10:37:23 +0000
Received: from [10.25.75.134] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 10:37:20 +0000
Subject: Re: [PATCH V2 1/5] PCI: tegra: Fix handling BME_CHGED event
To:     Om Prakash Singh <omp@nvidia.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
 <20210606082204.14222-2-omp@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <54fe5d68-9bc9-ce80-3917-49d616802698@nvidia.com>
Date:   Tue, 8 Jun 2021 16:07:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210606082204.14222-2-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd0cfe06-6a77-4e7b-e735-08d92a6966ff
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0160:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01606CC94BDFDEE465E9C4B4B8379@MWHPR1201MB0160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGpyvdlheaLbXfRdknY8hdQhdDzWi3B9LKtujR98/aUdAfEJQow2RRqY1lk8yk8PyXJTj6zDPuB3o9HJ/LWs6S9Ec4NImKIz53eCvjFuNj+3HeKIheaR/QTbsHg+kR0l7at1CKLJOEyrvbdvwujFtrZrf4LGYLBbCmF/IyTNZYJqTM1f8vbKKC/Z7e6goreKOLpma3jpj3YTFx2UrZnnHN2FUYSCZAVHdNH+HuVagm3EriYuYjSE15/ZJ4MUHRUm66Dvqekhn6rik9ZhIFxnZqVmUW04b6ryVJAfvbbfoEn+78CxvRNWrVEnhQl+bx5q91T4cNb7H2/uWVfSQLm+Cvq8Kz0vJCCdYvDUSGOfeqeDw+0xBc8IyDI8P03URz3URXobXAVyNHEaJXO38LDGJM4QPenAFRU2nTQeSFWdFKh7Hs4gJZbxj8L83/yyNZ43KuWEGaYJkOg8ch9ho8UNTlcH/q5Go6oq1bOyMRloZls5jZXCmmHc+vZLoo8e0YFCxMCmIPrNyGMECG+vHUj9VvU6HeCSgo3g4utUtEqr+8AcieyhfZGkDf7ACt1EE9Jwxr+CRIK8vO+rEJyox3jRZdiL+J4k5S5/zQ7YsdvCtfHmrSvQvWv8aJimYBDTkG0wfDl4fsFEsPNc3XVACrCjHY/pxy7HIej8tcQ96PJeWob5cYly3YRF61K4sTrPm9lp
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(2906002)(53546011)(36906005)(110136005)(7636003)(5660300002)(4326008)(86362001)(47076005)(36860700001)(54906003)(70206006)(8676002)(336012)(83380400001)(16526019)(31686004)(2616005)(316002)(426003)(31696002)(82740400003)(8936002)(107886003)(26005)(16576012)(6666004)(36756003)(70586007)(478600001)(356005)(6636002)(82310400003)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:37:23.5713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0cfe06-6a77-4e7b-e735-08d92a6966ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Acked-by: Vidya Sagar <vidyas@nvidia.com>

On 6/6/2021 1:52 PM, Om Prakash Singh wrote:
> In tegra_pcie_ep_hard_irq(), APPL_INTR_STATUS_L0 is stored in val and again
> APPL_INTR_STATUS_L1_0_0 is also stored in val. So when execution reaches
> "if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT)", val is not correct.
> 
> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
> ---
> 
> Changes in V2:
> 	- Update variable naming as per comment from Bjorn Helgaas
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 30 +++++++++++-----------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index bafd2c6ab3c2..6f388523bffe 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -615,19 +615,19 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>   	struct tegra_pcie_dw *pcie = arg;
>   	struct dw_pcie_ep *ep = &pcie->pci.ep;
>   	int spurious = 1;
> -	u32 val, tmp;
> +	u32 status_l0, status_l1, link_status;
>   
> -	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
> -	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
> -		val = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
> -		appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
> +	status_l0 = appl_readl(pcie, APPL_INTR_STATUS_L0);
> +	if (status_l0 & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
> +		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
> +		appl_writel(pcie, status_l1, APPL_INTR_STATUS_L1_0_0);
>   
> -		if (val & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE)
> +		if (status_l1 & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE)
>   			pex_ep_event_hot_rst_done(pcie);
>   
> -		if (val & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
> -			tmp = appl_readl(pcie, APPL_LINK_STATUS);
> -			if (tmp & APPL_LINK_STATUS_RDLH_LINK_UP) {
> +		if (status_l1 & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
> +			link_status = appl_readl(pcie, APPL_LINK_STATUS);
> +			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
>   				dev_dbg(pcie->dev, "Link is up with Host\n");
>   				dw_pcie_ep_linkup(ep);
>   			}
> @@ -636,11 +636,11 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>   		spurious = 0;
>   	}
>   
> -	if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
> -		val = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
> -		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
> +	if (status_l0 & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
> +		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
> +		appl_writel(pcie, status_l1, APPL_INTR_STATUS_L1_15);
>   
> -		if (val & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED)
> +		if (status_l1 & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED)
>   			return IRQ_WAKE_THREAD;
>   
>   		spurious = 0;
> @@ -648,8 +648,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>   
>   	if (spurious) {
>   		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
> -			 val);
> -		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
> +			 status_l0);
> +		appl_writel(pcie, status_l0, APPL_INTR_STATUS_L0);
>   	}
>   
>   	return IRQ_HANDLED;
> 
