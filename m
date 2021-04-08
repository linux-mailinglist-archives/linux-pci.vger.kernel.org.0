Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8955E35835B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDHMe5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 08:34:57 -0400
Received: from mail-dm6nam08on2060.outbound.protection.outlook.com ([40.107.102.60]:18400
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229741AbhDHMez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 08:34:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHGJKdVRvVcnkts+JNUav4tFMV2ZHTV3opAf+y2drTj1U4RgVWsPAGKk8anrviE4lU/J/k7yg+hXly+1PJCIccNg/7Mk12ciDtDvu6lc3QuhROJv4/hMtlYAh+5Yfd/22AizDGvMrwrsaVy9bO38N39h1JeTTKoBZwUsQxDW3p7UEDLgzsK1Sdrk86ZBdbcutEqlEFsx1SwnLu4aosFeIhBaXWfVKFL8ZUDnQM7pX4pmV9gqznk7f4jscI96i6zfBWe5lA2agoTz/YkDaIDkvqWkAnlGps1erQlIKUA/SMwOO6WUnSoGPVRj0NPLhlfbMo/9zhSNX6yz/mY95hNGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYk2q2cb/3NeVg4oymiu2JtnLsDpresVBCUCCeRmI+k=;
 b=d3Bu5xYpgExyN13RIncmHoeXesWtpDFlEKQWeSBR6EHNOAcpD/nhSZQu7EcGCyRja1I8ed8f52xuKq+SaehM7XTwVl/RU2pQTnIiohzcDNXTAPXpYDB3YQK5sjP7xERORjuWHYQfvez8zJLJsDeP4+sMH5+JlX0ghxV0sgwMRnDoY1lf7qXPHsYucfcgr2brhyDAAPotkMDZ5JUW2tFnVh3wZFj4zFathfzqPmd0whOWqsna3sB/bSxP67Gl1bSnQe6NEy+dXEdPtuyGQ2zJuCg1GB+qBULvp7435hf8FTJI3KeFvrAtG+I9iuf62aHQ3Vg/9ULDOpMkUP0m6Zd1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYk2q2cb/3NeVg4oymiu2JtnLsDpresVBCUCCeRmI+k=;
 b=YEKNbeovuiCzFTYuPHQHa5RbgrCTCq29bsE7HbzhCwKA5IEyOIqMunthnGJhrZPHyHIwgI3XbH9nu/bENXQueySa3/GFkjuO+5bQQpQXzPkcghAOeFOwRb6MGpGIS0aa8YHT9EEGU5wCqXjTKH+Fy6HAo/CY3/WIRzFfgyz/v91nZX468G12bpQJoH1vtnml0axJMauVHv60kJWNC6qpm5mH5RnzGEx80UuGKzsglHXSAAGWrp7mrO95gIzRm08R7+UCfo6norXNDeA7z5Ouj09E6lgs7K03HLt4a+3GG2JLiWK8qLpFvf2Ry6RcDnh7ua7a50ZdxjYB0/FJl9C7+w==
Received: from BN6PR11CA0070.namprd11.prod.outlook.com (2603:10b6:404:f7::32)
 by DM6PR12MB4730.namprd12.prod.outlook.com (2603:10b6:5:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 12:34:43 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::3) by BN6PR11CA0070.outlook.office365.com
 (2603:10b6:404:f7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 12:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 12:34:42 +0000
Received: from [10.26.49.14] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 12:34:39 +0000
Subject: Re: [PATCH] PCI: tegra: Fix runtime PM imbalance in
 pex_ep_event_pex_rst_deassert
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210408072700.15791-1-dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <11feff02-c466-5296-b4c3-85754c755c9a@nvidia.com>
Date:   Thu, 8 Apr 2021 13:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210408072700.15791-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e876ea1-a1f5-4ca5-d961-08d8fa8aaf98
X-MS-TrafficTypeDiagnostic: DM6PR12MB4730:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4730C21919897466540FCFE1D9749@DM6PR12MB4730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFmCuG5zupDiOc41OqAMuO4pZe5hjO7CRRaQfFvetsoVVECrdFcIM2BfcELHMHvUz1bK1D792/DBt/se837Mred0zMo44OSPK6NT4AG80xrC1P7faK41QHBHcjd7unKaDprhqkWD7bsjog3ByT3nYXJKzTZtVUwuxA+PqQfLlTPJBu91v4saRcz72WpeNLoHhdWy50ve9n6Rq2/JkR0Dc6Pquqz06TlafUEDy3w3CUT0K2OVkGqFMDWbTPDPfIK/nJGP2KMtyzb+YXHZFQl9oXe73cJaNOnjASmM2VZN6pR8mPzmsrSq6s7noqJl887bjIxRPgO3/V/GshyYob+/wp1sNJkwT2+RsvoxVvI8uKTwj9otwEzWJRNYQmg2AtaMSBc7FGdGl248wu41fR/kPjRhWgQJkJ2Hh4Qq/yq8KnMMvrCEMVsQZob07A9RGilT5s0/UqmVqZ0djzdK65gR+VTYcPr+Wts909vPxe/9U1Xvttv4tEspQDvNmEBEnKSK6rZdrW4ZJp19eHnT0ydDxQC2U4xn93BArqp0LKAxEJ1ZCuLX9bmE0Yuo5CEUkvIRWT9UHIxWU+elzeYB3Nsgk6u9YeEiet2d2dYaFUDxEgkooBC1k+YwPZsUeTK4XPAW/ugQqET9DFvJddNbPfmuKlM8wneSa0auXk9bpzi2gJm5jhFZZ3H9v14ZVH4sm0OM
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(26005)(36860700001)(83380400001)(36906005)(36756003)(426003)(7636003)(16576012)(47076005)(70206006)(186003)(2616005)(478600001)(356005)(16526019)(2906002)(70586007)(8676002)(7416002)(82740400003)(82310400003)(53546011)(54906003)(31696002)(110136005)(8936002)(316002)(4326008)(5660300002)(86362001)(336012)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:34:42.9766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e876ea1-a1f5-4ca5-d961-08d8fa8aaf98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4730
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 08/04/2021 08:26, Dinghao Liu wrote:
> pm_runtime_get_sync() will increase the runtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6fa216e52d14..0e94190ca4e8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1645,7 +1645,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	if (pcie->ep_state == EP_STATE_ENABLED)
>  		return;
>  
> -	ret = pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
>  			ret);
> 

There are two places in the driver where pm_runtime_get_sync() is called.

Thanks
Jon

-- 
nvpublic
