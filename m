Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81944375115
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhEFIuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 04:50:21 -0400
Received: from mail-mw2nam08on2071.outbound.protection.outlook.com ([40.107.101.71]:18881
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233464AbhEFIuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 04:50:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5G3YeY+e3HEencEqB+J53u1M8MlSuMK0PM0/ibthWyZ0HSSJb2SguVTuEVX0v8zeecwzlhLV0rRob9IsPaIZdG/sDFwBpSWQgRszUxB9BfNK3VNhnCCW0Pr4Idk3GidJuujHl4f/4IcsftTJ1hFpBVBtGd2yEJe/D+sJe3wi6wVyr+SpTOyQSEFRpKImvsMlgqzDCDKnSLeZNRrNqZtrIi98J6Ujx7Hjm8VY2DWAq6J+kbYJzLXBbhdEekRMv8qZZRYaut6EcSQPLzcJDk8zBaHdwv5vWyHR6a1L6EeBB3mxy3T/sFPkCE8vTHXb4CO4h3T03c1Ran0Qy+4AKT4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvze2Q4UHFsJPQxmU7Ysn3esafMd5+XWXKybkTOdSrI=;
 b=Ox1nsU9Hftq46qk3T7wNePSmSy5bD9ZorDkiwAoxonbo6+MOHyhg8oc8MNVEuhP9e3/wzyjY7PMOMWMbl5BNhllkT/4nohmdD1luUtZ/ygOiwMe/2fZ5co6xLUSdB1+H3c0v1u4NOpioI5snbfjGa1lxYhow1tu/hbEtKDjXDNoE4PxzHK4idqpdOm+wxXoJStdtmykvL+HRZYgeY4shvt76qeWm8oY0ZpdgItPoIFfkPSsCGsiARPFff+yACNv7jf9+Kpu+niOivfRuTHBLq+j191oNJfPXfSEjJWrC9PNK0P2Gphkyzun5El3sG3hs+iaDrUKaXr4wAZ0qR+IYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvze2Q4UHFsJPQxmU7Ysn3esafMd5+XWXKybkTOdSrI=;
 b=YrM7tpEFJ1+T9x719HHHYypAz56iExVcGS04bQ8tzsVMMHV9kCR/0GRHDdklrgdSsDCNVB2ifd2PJRdosZeXWJnHBx4k2bnCpPx5RaRJEWaZJsdMvZscl+wH4gBVbwpnYF1fE8C3wY7xwybKCiYg5zzU5/STy7sbW/ZwPVy95Eo/H2qRIG//SAVs7Ya+iB3lZoTahVSCfMTiXFKE112UcA0aMEw7/1/4mE5Az7rwvl150R/aoQa1BMds7GIhJ4+atwRt0N9+wI9CRqyykxRgzf+dfnjmZbvRse+hoJC9V1qlVhB9OTsgyriBo/jfLtOESd+Mdk0nrjdHvM0Cke/RLA==
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by BYAPR12MB4760.namprd12.prod.outlook.com (2603:10b6:a03:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Thu, 6 May
 2021 08:49:21 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::47) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 6 May 2021 08:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 08:49:21 +0000
Received: from [10.26.49.8] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 May
 2021 08:49:18 +0000
Subject: Re: [PATCH] PCI: tegra: Fix host initialization during resume
To:     Vidya Sagar <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20210504172157.29712-1-vidyas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <fecc2899-06ef-f91f-4a39-bb4ee664c800@nvidia.com>
Date:   Thu, 6 May 2021 09:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504172157.29712-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61a0d96e-ae0f-4426-7e00-08d9106bd784
X-MS-TrafficTypeDiagnostic: BYAPR12MB4760:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4760E36BBFDDF955909EEB9DD9589@BYAPR12MB4760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXeaxIh9C1cYfubLVTJ1oK8+vs19yERtHIhw4C6lD41LcoewnuqfU9FSVJkpJgjY+khfyTUZKhigHDvg24pi1qIMwxRRrO+3BjK1A6y37hJJ75nnIoWW/TpDFIpm/uor92r8C/drIICpIa13kLNLTn4jEaizBIkeJUHhcB+ue7dEOJS/CdhyZRdeSSGM3ajZgaV0nLBubxqW/NHzlKDhAZeg9r2YAAyzs86fqGHCPPEyDinsaAyPYcL7WYI6xoZXT5YC1ir32iEXUazgqdYCgHzp6Lw3r8YiT9b/nHZjjHQoUt2AXBQcE717U3tLYcAsdHU4SOLWLMbAU0jEZ0AkyX3mMtRT7grr1DHRMfDsGrN+T6QvXTVZimqaxzy9rNgOESFGud27Wt9+v98yKyZtjkqp5ZC/YV7LRDf92J8qQrLrYdQiS57yPy/AHjkkT0k5epjQ7xT9rco+vXqJL7sqakKN+hqJkioWMU3uv5PKXJRBPb8LF/w02vLbvdjy0+RkY4DNkAGgIM0V4y8ZY5KPJwSPx8k/1qJ8IQF31EWr4ZfYo7qAP5/0Sf96CBLBCZ3MnfxLUvarVuqFDS4niz0OPfFim4Sxyd7qqycyFfjC5J9lLKMa6GUTTry1krIW568m7fs0IJkfL3PH//mIzSbHRsb13eAMdegtPZuGA/TjcogzJH8cKLwjgyzxU19kO1H6
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(110136005)(7636003)(2906002)(186003)(31686004)(54906003)(4326008)(336012)(36756003)(5660300002)(26005)(16526019)(36860700001)(6666004)(82310400003)(7416002)(82740400003)(426003)(70206006)(86362001)(70586007)(31696002)(16576012)(8936002)(8676002)(2616005)(478600001)(53546011)(356005)(316002)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 08:49:21.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a0d96e-ae0f-4426-7e00-08d9106bd784
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4760
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 04/05/2021 18:21, Vidya Sagar wrote:
> Commit 275e88b06a27 ("PCI: tegra: Fix host link initialization") broke
> host initialization during resume as it misses out calling the API
> dw_pcie_setup_rc() which is required for host and MSI initialization.
> 
> Fixes: 275e88b06a27 ("PCI: tegra: Fix host link initialization")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6fa216e52d14..4c3c0738f2e6 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2214,6 +2214,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>  		goto fail_host_init;
>  	}
>  
> +	dw_pcie_setup_rc(&pcie->pci.pp);
> +
>  	ret = tegra_pcie_dw_start_link(&pcie->pci);
>  	if (ret < 0)
>  		goto fail_host_init;
> 


Thanks for fixing!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

We should also mark this for stable so that this gets back-ported.

Jon

-- 
nvpublic
