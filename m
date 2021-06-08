Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981E239F3AE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 12:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFHKju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 06:39:50 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:3552
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231166AbhFHKjt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 06:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoiWgExESVzBZiQ+LaoVIQ5AKcCiXxEeDyFRQT+Ns/Agf51FVUKDvRvHjlDJ6Uo8kgl3WTPadsbn6dzTM/lgcO1D+FnwM8mgnIaEF9jenmNBEGKFQLQBU7Mq/QzNHdqDMXs+1IkvNB1ShweVTerMJT+xrXh3rcTYPwRt6j05LqOJDpA2MwxoChd2VhM69aR7HUAyIs6Okq4PIxnZwGgMaCfHKJ2FvG8SSDSYbHgvAXsmKEeAtD21kPEooKUg9hGBUCM9VKOAI0pgkOUwlLb1ZRDw3gXS6JwwUSbd1rQczGEXjZJXUVqdsJXOmpCuLNJ1VMn5JhmzygTn3vhbxKL0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anYAw7WRHco14MujAaSKOXnJrcTSUOBFhxzmWF/54AE=;
 b=Q9n+oy26Re5KNDiHXF1C5dlXSmqbQ8E/biw53ldQhpwl2bH3XyBealwSVqyE1/iVxCM0niClLre/dIlP1jTzu7Gc/eK2ofa7rxfnRovREEXoLn5jTPW9T0xm6xCY/vdOKNFihe3nQCzSuUfQhs/styhYgO0Xe8vJ+iC0QRe06DW7ATY2TZSXLOWPZVQgMEt5iyaKHfr6Q/Iro5WCay7j1CbSwsdMP73D0E7cwp4wB/r6F03eA2W6g91OAkE3w8Zy1ln5pPGko+6ffS1U5JYrbSf88UR99ZFb5WYuhxzX1/fXbaUdRiC8rGtgRyIdleU2hlLdcVlYEtKJS0GsDQekgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anYAw7WRHco14MujAaSKOXnJrcTSUOBFhxzmWF/54AE=;
 b=VbWbRVcG61TgoxWNmeQwtGvRzQtMtC7t/8h8qMsDwRRUdeh6jm5/dhFJZXcVRP+hRR18zS9JTYOyZbSsC6017WfwQeRIVN13iLkDmmNOf2Wl2u7HQ7xH1ETmfksDHoZs7+w0DzuLete3miB7pVZcMURCYLUSMm6A4V/rCwnVZaCtlSjkorBM4690nmKQvwpKfaGLIlHY2lsrDfRlByLh11Gm3e9Ikr99AJk+4wuokucP4fzEoNjWdsO6PHftNpGnJDZ66QLU2JvI5IyeVhcD/kdumGpbUbyCvs+nrlFI7Yl3oaD9Wb3xXnrP17BzSqwxMkVum8DOdoqQAkiahmxeEg==
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 10:37:55 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::27) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Tue, 8 Jun 2021 10:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 10:37:54 +0000
Received: from [10.25.75.134] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 10:37:51 +0000
Subject: Re: [PATCH V2 2/5] PCI: tegra: Fix MSI-X programming
To:     Om Prakash Singh <omp@nvidia.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
 <20210606082204.14222-3-omp@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c0d4b6bd-d521-191b-6fb6-50ba4c89df51@nvidia.com>
Date:   Tue, 8 Jun 2021 16:07:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210606082204.14222-3-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d8085e-0d9f-4414-f979-08d92a6979b9
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0160:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0160E5221A91293AA2FD3AB9B8379@MWHPR1201MB0160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08nUVL3wRDtYE1o8jofwOvxabjD2EnnbARUUcOTwZnJqjK7Pak95EVoAJWVcVFRD7exxtQK22galixU2WU8onP/gs3+VfMmMBMU3CVHxMP9uC+dF5YRsrZmLsbtngm64vN3ijYB6/B0+gSQgpIyG970nZuSonr61kTInNYig5XAjWpfM4mZRqwfS7m2XLpA+BSTgrWaoOQ7hVelSQAba/KqkwG8lPMzHmgHjtFIKcpt/kiaz6OZOGw2TRiaCVEPoJrkkUOFFXAQIJiLc3vyQwB0gyd48nSw3qMWP1VehBog0EL2jfdQOstgn4M1ZUiFH7ghIIxCGUgJVjDRGWE5JC6AcfTWl0/abt2qPGdYd1AuQRsqF3/tbqWdVqmI6qRfEUWloQWRpSIQ5Ykt9Ar9X1SEfn1zT/bEN7NgkCvH6JQ9bCy1drgrIpaYKH9tInGhy84hgbdBKosQILjrm0jh0DUUOjBQntM7L1AUHHJrY0CkNCHH5UGHnVic4Twy77FBBwUNRxNNf+4rDk64m9Z42RCgSARrffJVv+zNYdFHTaUde9NEThfjun+NAl34xOp4BzxwH+hvL60YpwcRvFkxHSyVdC3HH+xrIkAT86uh+3x7p4K0nGownXIx4eF4KzUkG87bYDjQRrqWXX+PEt1OBeFKIXeCXOh7C0T07C5BgcFC8g3ns298IjGiqAwy+G63y
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(2906002)(53546011)(36906005)(110136005)(7636003)(5660300002)(4326008)(86362001)(47076005)(36860700001)(54906003)(70206006)(8676002)(336012)(83380400001)(16526019)(31686004)(2616005)(316002)(426003)(31696002)(82740400003)(8936002)(107886003)(26005)(16576012)(6666004)(36756003)(70586007)(478600001)(356005)(6636002)(82310400003)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:37:54.9730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d8085e-0d9f-4414-f979-08d92a6979b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Acked-by: Vidya Sagar <vidyas@nvidia.com>

On 6/6/2021 1:52 PM, Om Prakash Singh wrote:
> Lower order MSI-X address is programmed in MSIX_ADDR_MATCH_HIGH_OFF
> DBI register instead of higher order address. This patch fixes this
> programming mistake.
> 
> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
> ---
> 
> Changes in V2:
> 	- No change
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6f388523bffe..66e00b276cd3 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1863,7 +1863,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>   	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>   	val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
>   	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
> -	val = (lower_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
> +	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
>   	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
>   
>   	ret = dw_pcie_ep_init_complete(ep);
> 
