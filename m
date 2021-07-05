Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3CD3BC1F3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGERDz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 13:03:55 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:27520
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhGERDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Jul 2021 13:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4KMJ+xpEf4VOLhKpO13aFoaeNzFAuIqXBLtRjxKJAk/xeJCy66L5pWB0QpeKKll+NITzABTbtF43ovM4O/kB3vDE7hPKA23tciXYbGMpIrPhCqRKSoxCpSfpiyzMztcDPtPgjl2Qh0wt6Fsln88dD1Ml8bizmQO+lCeUnT1ZNAAzmNwnraNOHnQpMxMH2w2gvvJBslqPCoc91l9v1PhNUglNNWKMl7cZJXRQPUNur6VhT6Qh2SmvKTZPmwSCdyPbihdOfp6nue2gdh5t70TQq/sHw5ysePpmknGuQ8AMqsS6yptPsAKgnirkXi10L4RXN7XJ97HyOYQE1ogbOVc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax52a/336qOHLA7icHpc2C9njzPeJ4jezT/DVSq5kww=;
 b=UXm2BdDbCniQQg+8UCp4zDDX2CGONytrgxS72wjxnPF6qygBZDp435NoFzZeqDQJGo3B3XlZDLc7t0XpXNpPCJmGa5/6EwK94jJhLcRulOdLZlSDT0ahlCTRxoR+Cs1qRtJ+F/PvhL0ku6LseYdKqNvwJJtwtNAUczBKuhzzV3xjEsMutpYAtXATNM/do9H0OVPzwUaXueuCH2g93NdXGjQoxl3DsrT5HdZmBNhGdvo5y6ywZ+4qNVQ8xf1GTRirg388deEY1IbyCQWljjuYO79wqBaOUNJpIW2beC6Vmj0IlV9Fv3bYglhbkn7oJaqwX30Fgqz1v+hnxc7KQ9+qQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax52a/336qOHLA7icHpc2C9njzPeJ4jezT/DVSq5kww=;
 b=KlVBVGQ3OYygeuqgHOplm/o3KBz/IgjIKdlR7Pf6ZGtuzFPUWWSleB4gV8WtaBqWjQeqDS01Pjd2BER0Ps381dMBOQYCmlSB/oRIqqeWkJaYYKy8m14xRhgEqU4gp5wPDXBn7GHz3pvi+jMNnz/TUgvLQzc5TO1yxh2zVsh5OX8jLuZ/Vaku4sJG4KVQW6LjYeXiyH7t08OuRPiUwrUvzTZE0amb3S1GqZ9TrWYS7vfuCxJu8Es9jZvJKva6zhuPI/IxUKCrk3UcZ8BuOKiqCOqfK0NkRnyubUFgISj7GeBcc0xvqyiSVZ/Qg/vkF3BUYFhv3NNE2IQ3Iufw1LQXVg==
Received: from CO2PR06CA0073.namprd06.prod.outlook.com (2603:10b6:104:3::31)
 by DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 17:01:16 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::b1) by CO2PR06CA0073.outlook.office365.com
 (2603:10b6:104:3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Mon, 5 Jul 2021 17:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 17:01:15 +0000
Received: from [10.25.102.231] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Jul
 2021 17:00:48 +0000
Subject: Re: [PATCH 1/3] PCI: tegra: Fix OF node reference leak
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <thierry.reding@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <636d7c23-4fdf-a6b1-5d92-2573a2e67db4@nvidia.com>
Date:   Mon, 5 Jul 2021 22:30:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99ab2c78-993e-407a-e362-08d93fd68070
X-MS-TrafficTypeDiagnostic: DM5PR12MB1866:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1866D81D00372461BF224FA8B81C9@DM5PR12MB1866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0lvD/TQfdMD3MBfVlK+uU+zLx7y/BmbhqZM3dHHTEyYYzN1O7L1XbWhQDvXSeHS95H6ZMG5Ja+Zv2DZGGBooK9FgGmaJM3MxZSjhnT0UC0sshaepIZmrqqezMwRhiy15xy2sAwG1phbmLZaX3Z9NDpvhP/NKRWSXEI1SEAHyD0PD0cCo2t0tP9IQNvF1Joy4cdxW5ugb7J4wozobXM0vsvOH1i+sFdpiIs4PryFJ0sxBupM+Bd21upY9r/VF53m7qHntcVljRKQBMRtuhtZNBROOKCHLwd1twSC6NRSFfuOUxz9/plbQJFL3jZUoUFEIVydvmqSvUTZfhHl6VD+X/1y1i6ER3Osn4kDtbhvpJfm59rJ20qTBBJ6+X0XucnTgUuwAW5kz6S03gQDZcBvEOpLFc3S0iun9I6e3F70VnLb4qF5cqM6AsQua67dbmRMK5TOyLGFSF2rDi6oI5LAjxn3ywiM+iGzcnXqeDQl1MmwXgpFj5i2fb/FERmk7D6oTNUNm0IFMeYc+pdkBJk2pCAUD7UTYAf1E93KY8SP6YU6ryGSkJDFJb11dwlvvD8Vz3w0T7Xt4/IVAPWTmahlyavVBMtl+bzj81HtWUVX7TTefkaZorsyDH+rbQ3/uVq7AEIEJqwbxc2yDbgFWeLpMM8h/3fUPHh9qBSQKPzo6ArwAUqeqfkkMNH/kInFHrGYNdwxZUe/mCN4RiUI2p1oWt89PJhB1uyOgrpls+Wzzgc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(53546011)(8676002)(36756003)(82740400003)(70206006)(83380400001)(70586007)(356005)(82310400003)(31686004)(36860700001)(316002)(16526019)(478600001)(7636003)(31696002)(110136005)(5660300002)(86362001)(16576012)(2906002)(426003)(47076005)(186003)(26005)(8936002)(336012)(36906005)(54906003)(2616005)(6636002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 17:01:15.9059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ab2c78-993e-407a-e362-08d93fd68070
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

On 5/4/2021 10:47 PM, Christophe JAILLET wrote:
> Commit 9e38e690ace3 ("PCI: tegra: Fix OF node reference leak") has fixed
> some node reference leaks in this function but missed some of them.
> 
> In fact, having 'port' referenced in the 'rp' structure is not enough to
> prevent the leak, until 'rp' is actually added in the 'pcie->ports' list.
> 
> Add the missing 'goto err_node_put' accordingly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/pci/controller/pci-tegra.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 8069bd9232d4..006bf0346dec 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2193,13 +2193,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>   		rp->np = port;
>   
>   		rp->base = devm_pci_remap_cfg_resource(dev, &rp->regs);
> -		if (IS_ERR(rp->base))
> -			return PTR_ERR(rp->base);
> +		if (IS_ERR(rp->base)) {
> +			err = PTR_ERR(rp->base);
> +			goto err_node_put;
> +		}
>   
>   		label = devm_kasprintf(dev, GFP_KERNEL, "pex-reset-%u", index);
>   		if (!label) {
> -			dev_err(dev, "failed to create reset GPIO label\n");
> -			return -ENOMEM;
> +			err = -ENOMEM;
> +			goto err_node_put;
>   		}
>   
>   		/*
> @@ -2217,7 +2219,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>   			} else {
>   				dev_err(dev, "failed to get reset GPIO: %ld\n",
>   					PTR_ERR(rp->reset_gpio));
> -				return PTR_ERR(rp->reset_gpio);
> +				err = PTR_ERR(rp->reset_gpio);
> +				goto err_node_put;
>   			}
>   		}
>   
> 
