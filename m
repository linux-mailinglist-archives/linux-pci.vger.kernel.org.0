Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE939F3B1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFHKkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 06:40:11 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:52321
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229942AbhFHKkK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 06:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA6vFZISh1Oq9Ozn6Z5kxhF5luY6MdPX4XAguuorhCmgQ8L8a2qVTBmRLSyR9cvHKUS8szOn6VBrNIceVHwNol0Y2wqMudgJmqGjpueAwqpNv0gds81NDv7s19GwV13NgCzDFR376Z8AMEbCzNuV4xsaaLNkuvifnN+5rpHFn8IeIalG+qBLaT2qcatCL78N0LNNjJqfvXxHDiI5QcBycZRcHTMSHt8+RQkdSCFxz3m10kzIWzPIDGztDRZDSoecXMb15+ZEFxaboHBS0G/gBqZ1mIgU1Pr+2lGMPBubehA4FBkvl/In+9B99shR6GdIR2dNcD06wUM8CK20HJYoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2owfImB9ceRcIs4x6c40dLbAaJTxaMaXPhOcEgG7/Uc=;
 b=XkmC8N3nzucaoRuebRTwz1/hc3aRw1OTErOog3NUeS/Bs5p0sBuHYvBvqKwgNuQfYaNUtGWi+XPx2VjXvQby5ji2dd7Shk4cFDV/u8gL82WOyPXOIz29ar2oddn0yEKjpRKgGbXmlb4IyXXyBYd+iHL7IBtx0Hj04s+FCckE8rzVyJOABdWeOU88aacDl2qSqNsWfRyCLg9U2QM94xtAjrqCVxEIMY+crdf65SKLezIBgkChAVWC+ZdmJ6i2pghalG1gK+USS5X4yuodrOQaHG46s45LMW5Tv3eAfRNIAtAgF0kuhX0gkBca6Q2mvhjjNURl4IHKzguOmCRDP7m9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2owfImB9ceRcIs4x6c40dLbAaJTxaMaXPhOcEgG7/Uc=;
 b=PymPvEt8uerJA6KSmQty7HopQOjZxKL0nPGU1GcCvfPEfMT47pxa2ZZA4Nfcq9QTZUTW/k4P3jq6YfMOk+Izm9e/vI3wRw7CG8pJLIiqIBcw8l/cRMw4u11naeFO5O3dpMR/RQsMpy2gbp4sTh9Xox2IKyW1bY3GH7m9h6FlQwdBv8TPQd6sx4+RCQkDx/A4t5PGtpQjDTeupbEDksKbwP5gRxt8WhstbWYgMfbHsB6eXv3owJNV7kkbL7PhP2e2GxN1BRK1u5NBZUIuGTzb10q9oekp/HBsU1hueQnAqYW8TAmOV9x0XbGbESfAKMtnLuSEIWUIWZhzsrYa8+y0bQ==
Received: from BN0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:408:ec::29)
 by CH2PR12MB3896.namprd12.prod.outlook.com (2603:10b6:610:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 10:38:17 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::a5) by BN0PR04CA0114.outlook.office365.com
 (2603:10b6:408:ec::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 10:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 10:38:16 +0000
Received: from [10.25.75.134] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 10:38:09 +0000
Subject: Re: [PATCH V2 3/5] PCI: tegra: Disable interrupts before entering L2
To:     Om Prakash Singh <omp@nvidia.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
 <20210606082204.14222-4-omp@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <1c11a5c2-32be-85ec-cb0f-270cb5ad9576@nvidia.com>
Date:   Tue, 8 Jun 2021 16:08:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210606082204.14222-4-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec433c3-822f-4c51-24c5-08d92a69869a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3896:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3896557561EE3ED1176E34D2B8379@CH2PR12MB3896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSbn9lL8z9gLpWutSyIYSjUN8s7Y8z6fopL0Y4d9jArmMSpXIBc2Fwlj8+0md1jIzY9FGLvJI1GBHBkLOxYVg4t1V0yPfVQpcZr9/GgFU0JlBSDKHYt1Ox3nPr4j55MvZP6p3aGTrT+nuXdafK0msdAB50WU7tljBntAG3E0Ht6lMguoJODU6X3MOmsaObLdZfRw12nmp+Wlfm5srG/vOTOpxd6ltvXVe59mzxWIlAa14196u5iS49iUJFP1qgDVyDlW3F4S2BAbr+Kmtzh1PZxnCq9DTzd/Qh2QS/WlDZOx7X+PV1WG2JG/UIG+Zm/CNhM47RdxrS/01fxSmnmFvjOtwDebVYZs/2B3at+8lL5nynCxE6ai7+i4qLa2zWqAnYywkinFDNn6cy6zT78gI+qrNgR/iYio6pSVKYyCvby6cozObXcbbKQSRaS/Z3JpOtjvSAzsUiFuSZVvjZPyn8u/t0n4CXLVcVyTG2R+6b4GifvTcjBGJxFP/wP18/omuHrpLR43y+o7CMmQElUgk7kpEiQH7I8vgVZRy5fgrKkokonFko6Vwk8vJDB86YX7tFg0DH4HGe+uTAJrLJoJJAuPfITqUR7Ml4km480dym1qCEVYu18TQdcbrij59LIpqapW7sRd1eUwHvltyHAfoyF+3DlT/Kq5tRs+u+dDjzIFbehiJfUhi0N23s/U2Zog
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(356005)(53546011)(8676002)(66574015)(82310400003)(336012)(8936002)(6636002)(86362001)(478600001)(47076005)(2906002)(82740400003)(31696002)(26005)(31686004)(107886003)(6666004)(110136005)(16526019)(4326008)(7636003)(83380400001)(36906005)(16576012)(316002)(70586007)(36860700001)(2616005)(54906003)(36756003)(426003)(70206006)(5660300002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:38:16.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec433c3-822f-4c51-24c5-08d92a69869a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3896
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/6/2021 1:52 PM, Om Prakash Singh wrote:
> In suspend_noirq() call if link doesn't goto L2, PERST# is asserted
> to bring link to detect state. However, this is causing surprise
> link down AER error. Since Kernel is executing noirq suspend calls,
> AER interrupt is not processed. PME and AER are shared interrupts
> and PCIe subsystem driver enables wake capability of PME irq during
> suspend. So this AER will cause suspend failure due to pending
> AER interrupt.
> 
> After PCIe link is in L2, interrupts are not expected since PCIe
> controller will be in reset state. Disable PCIe interrupts before
> going to L2 state to avoid pending AER interrupt.
> 
> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
> ---
> 
> Changes in V2:
> 	- Rephrase the commit message as per comment from Krzysztof Wilczyński
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 66e00b276cd3..64ec0da31b5b 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1593,6 +1593,16 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>   		return;
>   	}
>   
> +	/*
> +	 * PCIe controller exits from L2 only if reset is applied, so
> +	 * controller doesn't handle interrupts. But in cases where
> +	 * L2 entry fails, PERST# is asserted which can trigger surprise
> +	 * link down AER. However this function call happens in
> +	 * suspend_noirq(), so AER interrupt will not be processed.
> +	 * Disable all interrupts to avoid such a scenario.
> +	 */
> +	appl_writel(pcie, 0x0, APPL_INTR_EN_L0_0);
> +
>   	if (tegra_pcie_try_link_l2(pcie)) {
>   		dev_info(pcie->dev, "Link didn't transition to L2 state\n");
>   		/*
> 
Acked-by: Vidya Sagar <vidyas@nvidia.com>
