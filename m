Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45A339F3B4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 12:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFHKk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 06:40:27 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:58080
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231389AbhFHKkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 06:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUKGc38wTlZ0heTD5voDXSTz0sw4Qj30llQ6eX/moAWVrb2mJhcL+WU5fVRkypQhdKBHMjc2pjcXZqo0I1Q/nnANPnitaytDInRxq7KBr6KUQtpvEJe2BjpE0RGhUbGLvsWhTTGanKFgTRgAJO1AEEXv8wTsNwL7pxTVB1xEwQoM2fXzKff6E56oOsIcLFyeMrM1RqOfEyxSuhhSG2frALU7lXWxW5sgnt9GvPUO2tCIrn8npAjSALTfZbBJsmvMCgM8vsvpTPLtUic8A7veCHMx/09uYjuma2OxgxJZilQUZaVdMJtg1EZkOc/auSQN+OMDOvVHnQLzppiy3qWmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1UHGpg8s39za6ikQZKQHEiQ6MZ4XBmPFSPUnj6aAkw=;
 b=kB07MTkLafiOn3ynHlz0pFOzS1dyffwhpKSD3U0VuPh7dd8V/tVp0Z+D3UwUxbcKTg/QbpmwG4IfjtkKY4LYq2fFvSZWnj8O1vqpIAKRKzD6FvoIuRS0srtiZEzBlBnLporbKNtTIEJf0CjY78oO8xTdF4oFYFPgt1c6i01Xd1JzQGwYZdg9gWlVAolDDwc4ksgoxDE3nVJf5QVwfVRpfQE9kwtbVxvByiXU776+V2o9QcUW6msuFJpnknUSa553/IlKhH6pnVzvz/07aTGifnXUFPU8/ZwLrzdxbPdxxROshzdF5F5nwwGGgrL4r5bfi2Nqyr0tlx9EUe3vWNcqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1UHGpg8s39za6ikQZKQHEiQ6MZ4XBmPFSPUnj6aAkw=;
 b=lyBJTeHDQO+8ZDeAaBgGHK/aO9d+xvCA7R3rvWnVq5l0az/07Ar9Fv2N/rhrSBJYhKkbzYeMEk6MNydWtGcziwrztFNepNxLr4oMJ8q3Q6CgVKtXpZR/qPtLFksWOwVuBg7wzAYm/RIK3p7aupQ2AlthuqKI9untww5qQEC/B0RoXgfGqDgAT42GPmyz3i4zMBRypZT93TsG4Hjl1Eormj7Kuh6FWz0mCZpMTr20nzGk8hHyUUdmo8/vWHY5cjJyUVj8Lnqp/vBUiMHCJyvLf3xhm63/tIZDlqWzXPsFvgGOpICGdVw1m38JAGLZnxELdhaZ9D0GzwOLN3RthnC5Zg==
Received: from BN6PR11CA0044.namprd11.prod.outlook.com (2603:10b6:404:4b::30)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Tue, 8 Jun
 2021 10:38:29 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::c1) by BN6PR11CA0044.outlook.office365.com
 (2603:10b6:404:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 10:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 10:38:28 +0000
Received: from [10.25.75.134] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 10:38:25 +0000
Subject: Re: [PATCH V2 4/5] PCI: tegra: Don't allow suspend when Tegra PCIe is
 in EP mode
To:     Om Prakash Singh <omp@nvidia.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
 <20210606082204.14222-5-omp@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f08fc39f-c420-369b-2dd2-332605666d93@nvidia.com>
Date:   Tue, 8 Jun 2021 16:08:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210606082204.14222-5-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d49e47e6-4d1d-4de9-01cf-08d92a698dde
X-MS-TrafficTypeDiagnostic: CH2PR12MB4149:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4149714349EAB72C615831E1B8379@CH2PR12MB4149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IljgGhh1bnKhF/ZG2L/by8A07F4gCuqaf15nYu+6PMN+OMEndCq5MiJeOpIhZcpMub20os0vrmRBJMOrZJfJt7GQtuT+Jgcd03rZJpaOffhUktnZoR1mzAOwoL97T4z83PW1lJj7z5agp+tzEX/ziTrOjF197F8xNyEtdjI4HsIA1H4vIqlATLkGo+FDfyM0AaBou+f/w3FwuezukhpeEE9vItQUcKqmz3ZnMNLzAZ5nUrYGQlqOz8MlVwPZWqsowTyGbJcuhrmw/amHTgyu1EWgEbIRR7z6HayHbo0mEVFyiZu7gbVLKa/cTJLfQahxielTUDVwSu5C4JfABy8e+PXa4P33u/W+cfVYdPQsRfm2ao/oflRpGRaKUOsMKPpB1jiFXUT2FnfUdGBFMoqVbQ3US3HunYo0Fh4Z3VqUJdkVDm1dTMx6CbNeYwJykdx97fyhZv1GfCGJoCD7OGUqnFsln+YvIm4tITyMOmzwgio/E4Tv6UuxREhg86y2jpTN1e9q0/A8lymcGvPOJ2oKoa0rzwMrUGwGasb0Fcxe9U9rh7hBOF2alCbdGepsVBGTvz6Qiuk3uWTb/rHhTeNPpAZHPxruMjqy8s+1iYURxLJ6xwoCN0MtaQwmRv0K/yz58BKuh5cjwEQ4IDlmEug+2FI98JkDTjZDPggIxxB0rDnKj+UR115DnxSHbABXXS80
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(36860700001)(54906003)(316002)(356005)(478600001)(6636002)(107886003)(36756003)(426003)(47076005)(7636003)(4326008)(82310400003)(31686004)(336012)(26005)(8676002)(110136005)(53546011)(31696002)(5660300002)(83380400001)(86362001)(15650500001)(16526019)(70586007)(36906005)(82740400003)(2616005)(16576012)(66574015)(186003)(2906002)(70206006)(8936002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:38:28.8056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49e47e6-4d1d-4de9-01cf-08d92a698dde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/6/2021 1:52 PM, Om Prakash Singh wrote:
> When Tegra PCIe is in endpoint mode it should be available for root port.
> PCIe link up by root port fails if it is in suspend state. So, don't allow
> Tegra to suspend when endpoint mode is enabled.
> 
> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
> ---
> 
> Changes in V2:
> 	- Update return value and error log as per comment from Krzysztof Wilczyński
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 64ec0da31b5b..ae4c0a29818d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2276,6 +2276,11 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
>   	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
>   	u32 val;
>   
> +	if (pcie->mode == DW_PCIE_EP_TYPE) {
> +		dev_err(dev, "Suspend is not supported in EP mode");
> +		return -ENOTSUPP;
> +	}
> +
>   	if (!pcie->link_state)
>   		return 0;
>   
> 
Acked-by: Vidya Sagar <vidyas@nvidia.com>
