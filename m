Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A83ACFD0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFRQH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 12:07:56 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:30657
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230151AbhFRQHz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 12:07:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JizVh9D4TpsypxBLvL8W3vpagVjpfUr8CU+g89bimP3O22imjE+Rc3E+dnwuLNbSRmVniK5fY/WUjDSXH6w8PGrpO5kMgOKWSSgFBU2BIG8w57Mhp8LmBHwU+RpDAfob1Eyf3NypybkETJ8iqC0C9fhp8RLS0oDZ6LgiCvhdueGt9l8xVQDPhs42tW3fwk4KdIsTiDxbc0sN0PsbhqUVMze2PsgVWlw8Ucni9jVqOIAtpDmX0HC7HtiOEj5/ryUis4Bv1JS23P/HuKztP7+HJXpo7eugE7hV5L6IfdQG5UBste5yNYTNcpVfRGSGk8Fz7IDdNmIHom4OsPxqgWWdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxCbz4Tva6cw17vICB91vy9N888mQO5bdOW8bcAZBjI=;
 b=Hq5wP/zYyilBTwZ9YFRTELRDDCD8QIFfGop2U/gbt6Hjg/5pStuUPQ0tonh//WgNhi7DjBKCoJSzjtkpruivuFZPfjmwjdDU02r6o8Lu1rxl0H92envNEWmcJLo2lVXN9/NQ8HtwBCacrCflpGwHc/kk2RI9byElw4ksvAFcguE3IY9mfyABuNDxBt1qd/Wu2t2uo2S7fO3NNkTWCehrp5JJTTxa2CPijQ6e4HU7sI2Go01KMEwnqE4TBDlSOA0r9s0nakbF4j0ZRvs/Gi/tSxaeR/bWBVPjaqyxQGzUQ38bmb1uE4BoOyanvlL2+Dt/WYHyWk4VHcML5VSf3lD3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxCbz4Tva6cw17vICB91vy9N888mQO5bdOW8bcAZBjI=;
 b=bLP7/sIMdMYSsN1bDF0KD6UANcM1te7nGG/IHdQjMPGKM6wjjMc5sxtA9nJY2z/hpXNTMRvgB51wKg+rtG3Uy10BeZYog22FXbQACYUwaFY39YlnIfazf5hAr5wnygL0j6KsXx5focwbFk/6ALdPILUg0LAC376wyjshPvhE06VbCYmWixuYdMyDKl7A8hmrGsqi94fm8ei7ORRc0gjM9J+74+zltQQhSNW9ik6p8kBbK9U/VtiYtbn25xvSsoYfWdpE2ddhsr0IiBxTD12khY8SoYHGPr5AHnnOUBbvGICiCHcGVRAFfZOcx8qHvuR6hWR5tK0T9juQ4ieSmm9YsA==
Received: from DM5PR07CA0029.namprd07.prod.outlook.com (2603:10b6:3:16::15) by
 MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 16:05:44 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::7c) by DM5PR07CA0029.outlook.office365.com
 (2603:10b6:3:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Fri, 18 Jun 2021 16:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 16:05:43 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 16:05:41 +0000
Subject: Re: [PATCH] PCI: tegra: Fix shiftTooManyBitsSigned warning for
 Tegra194
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210618160219.303092-1-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c4d95eb7-aba4-472f-2b22-0fcea1fda5ac@nvidia.com>
Date:   Fri, 18 Jun 2021 17:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618160219.303092-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d35364-dd8a-40f6-86a4-08d93272ed66
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45494321DD72F926D5453196D90D9@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e70gNY/7nmkkcza07ONE+mI3n6MoI+ZloOYgvwo8jOdplWUJm0l5TfG1qBsTbZK/llis9vVzNTqyArJSwOymS6xnMsL0MRmMy7Aiwy9THl/ueyUUqKjTwqjQ5Y+X155QADTfiGwnEEnFrJtoJqFsYX7h3c56pB/Rg489lCeLlHDe7znI5WqQRnhkuXxlyjjsaiyeueajW9TJ4n/5K2BDJ8hFaPCPGnuxdxPytbacqDefkQVhlN6SMtk0iw7FVDW1nk3UrGZJ6g91lEPd4Uo1BdhJckaFirira8PIk+K+CL79VCiNDHZbw1PMkaBG+oobaUd1Z2Fma95ZW2mv+RuW48Fip1Y0n4r9Pt1TUh7wPsd0eZZK1RwJvaXwWf6mBVpWdV0nvIt4SndenOjimdRelkcOV4wede8kbBF/s+bfwqUejjWqtUzey3YdAqEWaNoAg5RAM76kqzUIwrVpW0GraOumHWfQsGw38Q9Vpl/MoEsdxHhSF8r4/XnsKkBa0XzxtluBSU0C644rL8IsD+W4yndlpc4PTVVVZ/xWHcMvLxmc7GqtNXzNIxp9pt3v0rdQfN1gaYL8Q52uIq9+t6H3vwIZwP1NaFa3/n/JCYh0+1bhk8Pa3Q5iglgVIhl0KzrrALe8FjURjBRZEsnC+HPwUU8UbyNyQc6B5cO3WRy3iE/zk/iR+9VOGTZa0S4g3xHzf3jNCMhk5C0TC2m8IqMIXQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(7636003)(70206006)(82740400003)(2906002)(4326008)(186003)(478600001)(16526019)(5660300002)(70586007)(47076005)(336012)(26005)(36756003)(53546011)(36860700001)(6636002)(356005)(8676002)(16576012)(110136005)(54906003)(2616005)(83380400001)(82310400003)(31686004)(426003)(31696002)(316002)(8936002)(86362001)(145543001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 16:05:43.8686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d35364-dd8a-40f6-86a4-08d93272ed66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/06/2021 17:02, Jon Hunter wrote:
> The cppcheck tool issues the following warning for the Tegra194 PCIe
> driver ...
> 
>  $ cppcheck --enable=all drivers/pci/controller/dwc/pcie-tegra194.c
>  Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability:
> 	Shifting signed 32-bit value by 31 bits is
> 	implementation-defined behaviour. See condition at line 1826.
> 	[shiftTooManyBitsSigned]
> 
>   appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
>                       ^
> The above warning occurs because the '1' is treated as a signed type
> and so fix this by using the 'BIT' macro to ensure that this is defined
> as a unsigned type.
> 
> Fixes: c57247f940e8 PCI: tegra: Add support for PCIe endpoint mode in Tegra194

Looks like I messed up the format of the Fixes: tag and it should be ...

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")


> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 8fc08336f76e..3c1feeab104f 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  	if (unlikely(irq > 31))
>  		return -EINVAL;
>  
> -	appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> +	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
>  
>  	return 0;
>  }
> 

-- 
nvpublic
