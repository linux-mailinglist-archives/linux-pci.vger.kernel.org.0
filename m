Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27DD39F3B8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFHKki (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 06:40:38 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:43104
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231283AbhFHKki (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 06:40:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9qBzqlHKoYfPy8ZaZi6MIrZFy6FMpjxwLZuX9KQRop1lTKdDIjoAVhqKiGwUUMiTw3a6wyWn2u35ml1Dk8GltMJN+Lbhamu4AKl2KfGSAM4c2tvXGPXNQv9tLIvN0XfE5htZIOimXEdH0MhFr/yYMzZF9amFPSA1UYu8XMJLX7J4gILndlWqZLdxjLeNcOfDcKZ71OvMB69iIayyxKNT8zEoO0MFTIPzMwTTcUoXjEj+u84Y1JT98aH7HCULTwTWow/pSb3ATldHCrW6c7WM9YiPRfoQBULCFChRuGaUn3/kY2vHz10LA/3hr8oWuSpVsG0oOHe2X70IOTfUOGeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCZq4ykMjVmKZEB1toYi/uNgfrttYiIHJ7H45pLZnLQ=;
 b=lQE7FzUgtnvTsA8ee1c2Sp1Hsrb8ZU5oRNjFQxrvhRfCMLWD14FnJGqYqsL4myRIsmhcXybLP+eF8rp9YGvq9lkmsuTs2LLOefPaYz+xDCwG+SqCq5x61EwPm4/rE0je6eQ/zKa5sYF6JmoiS550qHoQGDXNJIkPbsUA8tEM1MnaMnjOiE3Qr9M1EUYJvkXefGnLhu7Av0syuenSq8VBcw6QKEAVWiaVFNFt2SC51I7M7shkSAYx3R8+PD4NVC1iUSB7pOCNmIRimTYk1X4xuluD+5ghSzldDOR2SbX4ybQO+dT0TyFzAdZLB42uMK7tnzY3CkmUqC1s9ZWtq22/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCZq4ykMjVmKZEB1toYi/uNgfrttYiIHJ7H45pLZnLQ=;
 b=TlqBv6ubYYyJURqbGk88caoCWy4c7F7a2VxyLEFVeRIbJ054wqg6t+KBvwR6Gk1gHU426Y773XxHsyXmLsT9VvSS7Rp4NyWau0ts0b0pFySZmwHLNX50/mDbc1s+2H3HZeD10XT4Azbp9aGPLCZYx2taJqQiqvMgEdWqKpTGigLk933XpdzMIxvfDJVWuNqQ1q/S8iWysEyF2DH9V+M0rgxWubkOI46I2n4ofJ0Ywj4i0I13/vPSe6wQ3+zGVwjyg+xEJ+0lVp/XErWdanEw44wbIQ0FdFyDNQjh0fCVTjHKf51cM7OLD6R2Mun/Ye7+29RJFm6kRygAJbA4IFcEqw==
Received: from BN6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:404:8e::29)
 by BN6PR12MB1345.namprd12.prod.outlook.com (2603:10b6:404:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 10:38:44 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::92) by BN6PR21CA0019.outlook.office365.com
 (2603:10b6:404:8e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.4 via Frontend
 Transport; Tue, 8 Jun 2021 10:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 10:38:44 +0000
Received: from [10.25.75.134] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 10:38:40 +0000
Subject: Re: [PATCH V2 5/5] PCI: tegra: Cleanup unused code
To:     Om Prakash Singh <omp@nvidia.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
 <20210606082204.14222-6-omp@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b72e09de-68ee-6ed3-3114-9a19779cb601@nvidia.com>
Date:   Tue, 8 Jun 2021 16:08:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210606082204.14222-6-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a939b42-ee36-4ee0-969e-08d92a699700
X-MS-TrafficTypeDiagnostic: BN6PR12MB1345:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1345DA8880CB16AB026BBF6CB8379@BN6PR12MB1345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuROlBHbUm5aHG+eUFEEYNyI8BLY6sXX21iU1OzWKMjcH8RG+qGpKWEENA7cVG/65tJqQIpi6LxI6lF24xQBGQye/Sn7JEakzUXGpvBS8ArF36dNEKvcLqBoNjj3aG9Bf0vJrfEtDkkSIeS6l8lDIvVfhsCAoYaNHkNS3P9oEn+NmqiZXRbZoY8FxRtVnXO1J8ld2Oc1JQZVjkW6P9OI3OED27jGgdS0H1jRNgm62QEpPMU+WbmzbsVhI/grOh/zKBLwEqc/IAFpzR8RhGFjXdG5MTLW2DQzNCYY8Ck/0wvduwYu9VoeV+HDl2bq6H2V7HvJpherqG+Oz17viQwKU2CZaQc/VrhugeOMyz9JEIf7ZHtKlfm76t3e1O7LmNJXhbqoDsrbupXSrlxVgnW17i4ySJbq3T8GBfWtrjUDKsxyvxva/9J/5nNMrilJnySUGsTe7RqpAc5PYpiNWlqm7LQXEaP3fA7+W2fkMIVSb4P6AFqFJC/R84xwszCK1dL6X3R9FQgPh/z/mPpx7N3ev5tjiy52cfkwkTJ2OmUy4jT9sFzYLuLB0RAscQQ7agA5VwrizYb57M65CpyGHx/fwQpJhgvIl5aCITpJA2bSISLSId8Ab3hO2p5iH5QOcbmGIeBoHvp9M2dHgI9gzsOqhCeQ52ePcW67D2UmZPOtvV+j4s8/VYl7sWnMphtO8kp7
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(6636002)(2906002)(16576012)(31686004)(82740400003)(26005)(107886003)(7636003)(478600001)(36906005)(316002)(8936002)(36756003)(110136005)(83380400001)(4326008)(82310400003)(53546011)(70206006)(16526019)(70586007)(356005)(5660300002)(336012)(36860700001)(186003)(47076005)(31696002)(6666004)(54906003)(426003)(2616005)(8676002)(4744005)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:38:44.0987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a939b42-ee36-4ee0-969e-08d92a699700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1345
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/6/2021 1:52 PM, Om Prakash Singh wrote:
> Remove unused code from function tegra_pcie_config_ep.
> 
> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
> ---
> 
> Changes in V2:
> 	- No change
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index ae4c0a29818d..e9d573c850dd 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2045,13 +2045,6 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
>   		return ret;
>   	}
>   
> -	name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_ep_work",
> -			      pcie->cid);
> -	if (!name) {
> -		dev_err(dev, "Failed to create PCIe EP work thread string\n");
> -		return -ENOMEM;
> -	}
> -
>   	pm_runtime_enable(dev);
>   
>   	ret = dw_pcie_ep_init(ep);
> 
Acked-by: Vidya Sagar <vidyas@nvidia.com>
