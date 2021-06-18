Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91A43ACD05
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhFROFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 10:05:39 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:28641
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230387AbhFROFj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 10:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5L+gudlA2xANyHjWq9y7Hvj37bg7OzwWz9qpKk2owrFsKq7yia6t0eaemQ7fd5sLqs6XAZKJEzWZ1OSUmkxMkkREQQWo0ljF6mofdoGnzzz4P+7iFyoVhTLK70Xy7pKpsVCRwEU+bmfGZva2al3hEARVp8dGQOT+mscG3qBypndnI1+WsHdDl1tx900elIe9OWoltQnJ76S5bskzqstExj1zsYJtvC8zPjLXLAW6jNr7nt3pquwTEXfq8igNQF4iCmKD01d1aUZH3QhFYbKNkEIPN9nGholExxBna+LTBcX5WiAjoy4s1TKwjHaNMgpfPpGCDmixQByJ2XXyUvhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4POVLKjY5xOkkH6JuNEauLFv6Kod1Dr191HZJ78qDus=;
 b=WHmtsEw7tKlhQSfIwct8NR2opDzzxBJ/W6FS/7g5UnMjDhvd2WPUSSu7asvw/E4JyFgw83IzMmcFMMpbfKb3saABg32Es3sn0sIHR0jzd4vTTrHiPXCrfWqEy9qL3YtUEom+oZj68YwlQjL6IKUMPM5LRRCD48sw6ql2uWGP2f9Xx15K4iPwtRZvMxVAFcwEwtcu2/7N41aXQcjOE2sxIOjILSzih9p0UlCUEZbcseqNP9uiTsEt+ld8xRKyjuBvjrDuWNcKKwdq4KrLbMvEFVnBfAicee1fWwm23JBl6UJDxwHkly3vHV/Td++Ke6fo00fXpEChGwdMUcK7iF/wwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4POVLKjY5xOkkH6JuNEauLFv6Kod1Dr191HZJ78qDus=;
 b=CgtGg/1wk5yiPFFzj7HTGW2Alg+QX+g04HpaJHhA4AUS265lGPek5njaMq38dMb2nVCDgrmDm+8zuFl4kBX/aLpEnPaQVB+VjmFJw/EwLBLGaO3LozAeX2OLjFQLXopMT1/ZcHU09HeSpnUY2NAZNG9/JtAo8UJGBxgIikE+v/qHQQaFSjkRYhZ2WfdMXcKoc2u0E5/5zIc8OSI0yfjGGz4EQIDOWOU6GR7tDYooerzqsqACD//SkhawRvsZFQb7SQnBo3aWzmvNEsLnzmm+MqRnUSJIf/BazY0tlNHNzi7tnV6HuXmnSl/wZH9au15+gguoeALTJtgNF7Yz16eoag==
Received: from MW2PR2101CA0005.namprd21.prod.outlook.com (2603:10b6:302:1::18)
 by BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 14:03:29 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::28) by MW2PR2101CA0005.outlook.office365.com
 (2603:10b6:302:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.0 via Frontend
 Transport; Fri, 18 Jun 2021 14:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 14:03:28 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 14:03:27 +0000
Subject: Re: [pci:for-linus] BUILD SUCCESS WITH WARNING
 15ac366c3d20ce1e08173f1de393a8ce95a1facf
To:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20210618131304.GA3182065@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1991f432-3c32-32da-997d-e1dec12df0c5@nvidia.com>
Date:   Fri, 18 Jun 2021 15:03:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618131304.GA3182065@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e66fd69a-7634-42e8-4575-08d93261d944
X-MS-TrafficTypeDiagnostic: BL0PR12MB2547:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25475ECC0C132108163C28DCD90D9@BL0PR12MB2547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:203;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwtmWYgtojbe1V8LL/Rb9rkUqD2mCP/2vDP7tieIeospWShj89wjquY8IwBH4Bh5QPmJDi9tdd74xji1qYsug028XwOmjj+ruuAaMpG7THG2pqcFqSVCpF7NK04X9v+K3O/ZXwk8H4XygIdX6EDZbZWXUAojh9fzrnpNFK3TsmbRKqAa4G+Ij6HvgONcM3Bb7UA/e+E72BvQFu+0glM9FmEcUEIbKpunwGUzbFn1txfHqMFf3pJED/BOSd/b1UTkNuiTteATgjXkuMnI0273MOwYPLgVJlS7cWdYmvGkFfEh07C12pj4LvbwK3ZxdreBnkmRu+fjXcLZOKX1WJjf8mi2w90DidFFuRW0Avv99+povx/uEypTONvTdjc3vQU4BOB19BsuEMLTk1I9YwFRkeNA2ca+75LbOm/wzEbvuHtkyPscM8zpbVoc71yoMDCb0k4sT/K09hF03Xl8L9u3oHZni14RYjV9JAATvNiQCpsbtHnH7q9T4kaR3MLRT6O6rYVRLWNEf2f0JqrI8HUwra0ISHVTKICYZp1GyBRuQeQII7CCkWy1HzPv++I+9uwxqW+osjNfrhzCTDU0u0zkjQqcYne24m6TlAPlHfNHDy3g9ZSUDSjLnklekUU7ZuV7otm/CXC1lrG3xZEoJje20Ubp2bgL/QysdWRrdstXtphgGbyO8X+/hEX1HeOJ9fRT3ZGWbkQT5iwkPWnbDN7Yf4w1uz9Cnuzqzr53glbrkyFyKogV5cmQPqqWDnYhoIBfn03bLdwDKs6SjGBhh+1khb+kbsSBGjom5yK2j0CFKu2DHGMoaZ8KhmYFAzacCA4sB90PpoAoT4oUBjvOg96/LijXvfvAAiQJ5cChM86Vtb4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(36840700001)(2906002)(31696002)(26005)(966005)(70586007)(186003)(53546011)(47076005)(70206006)(82310400003)(36860700001)(2616005)(31686004)(83380400001)(16576012)(4326008)(6636002)(478600001)(16526019)(36756003)(86362001)(110136005)(8676002)(82740400003)(356005)(6666004)(7636003)(36906005)(54906003)(107886003)(316002)(336012)(8936002)(5660300002)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 14:03:28.6973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66fd69a-7634-42e8-4575-08d93261d944
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 18/06/2021 14:13, Bjorn Helgaas wrote:
> [+to Jon, +cc Thierry]
> 
> On Fri, Jun 18, 2021 at 06:34:20PM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
>> branch HEAD: 15ac366c3d20ce1e08173f1de393a8ce95a1facf  PCI: aardvark: Fix kernel panic during PIO transfer
>>
>> possible Warning in current branch:
>>
>> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]
> 
> This looks like a legit warning, but I think the only commit that
> could be related is this one:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=99ab5996278379a02d5a84c4a7ac33a2ebfdb29e
> 
> which doesn't touch that code.
> 
> It does *move* some code, so maybe this was an existing warning that
> moved enough that the robot thought it was new?


I guessing that this is now happening because we are now compiling the
bulk of the code in the driver. However, yes looks like it has been
there for a while. 

I wonder if the '(1 << irq)' is being treated as a signed type.

> How can we reproduce this to make sure we fix it?

I was able to reproduce it by ...

$ cppcheck --force --enable=all drivers/pci/controller/dwc/pcie-tegra194.c 
Checking drivers/pci/controller/dwc/pcie-tegra194.c ...

drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]
 appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
                      ^
drivers/pci/controller/dwc/pcie-tegra194.c:1826:19: note: Assuming that condition 'irq>31' is not redundant
 if (unlikely(irq > 31))
                  ^
drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: note: Shift
 appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);


I was able to fix this by ...

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 8fc08336f76e..05d6a8da190b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
        if (unlikely(irq > 31))
                return -EINVAL;
 
-       appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
+       appl_writel(pcie, (BIT(1) << irq), APPL_MSI_CTRL_1);
 
        return 0;
 }

I can send this as a patch.

Cheers
Jon

-- 
nvpublic
