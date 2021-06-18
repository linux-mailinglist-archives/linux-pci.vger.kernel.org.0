Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7503ACDE0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 16:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhFROvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 10:51:55 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:4320
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234383AbhFROvy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 10:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4egmV4nyjJ2ctcSKW175R6gIxvGtP5Ui6kf6mWSNYWdzkbb9R7fLzkcTcgdv3DJZvzSMr4yqVAQJ4s0PT4IjajhTcFQUjeWxs7Ltx24hmJCA+3SspMsBdO0A3Jc0678f2aVk4d6rDG7xS6BwV/ZH5VuC+8IxyNaDVpHy0I7swZnV3OkescMulFSWxnlz92jl6oMMH8O8MYmxVBZszbQ7xyusSPFHJoES9PgSQTLzsAYSyWOwO4evxqQlZFcPgLHjm1AXr4qvqlTJJ7+L6W/ZmBw8fmUwzmdYEn5DE/APlqaRHkZ4l0o/2GZo5Wu7lQfsCUU+b//eNBs+glFNkcN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoOTYBi083/Fej9W0+jP+nndckzQsfnJlcumd68yUVo=;
 b=NDP2TOo0JBDziGxJ0uDAiLPc26fQHF1vmTlVkwWsHXe5syU+Awzz0B7d1JaEx52Tgpd/YUn93HB9aW8TqKVHv5GKvMJSdYa07LZ0tZBlxjQxYMMdrOL/UKZNY1sGmTAVb/CElP+kPDa3O9C/dWgYlaD2u9RuTew6ix5Y1dnXFUNJfvRyAJg2w17sWaBdNRe5U/lNRZZ+7c2C+6CYXoZNfdG9n+XU6LA3hr4dgDfKC7xdRWF5VUhrgZUXAYX44gBJUx+knVIRLGqDqm6fGytgcZXBR/yJHbq4Rsz3mC9WlUhaofVU73grbucIjY3xchZdvHr1fDzzJPomm+xh2/0gfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoOTYBi083/Fej9W0+jP+nndckzQsfnJlcumd68yUVo=;
 b=cAAH+FNvXpu5sV8NZto0AXddmRrvvlV2FErALuxcie6cFisjoZdM86k2uILbOAIck6CuCsWxER0qd54mSOwzGaJqujHXtbt3Ft/tx2bJL31A5h0TKdVCY7BC0uZEOS/rvo4J9RH2RKCLX4XY14h6RD23ZcgsIDYMjf4i7Y9B1ffIDpUM60TMjatdI1nPxK/GIZgFCHLRfnNGdRSr8Bu6bdFlTgVxCkurc2m7MlRnzAlDjLBmQV82JzLjMdx7C/iwFsWchfYNptZ38D0zUyYig5cBSaEbWr6qu59yB945+JpYTs+IyAD6amA+Zmg45E3cbquDy/TOHlhdNgLC0vQAiQ==
Received: from CO2PR04CA0157.namprd04.prod.outlook.com (2603:10b6:104:4::11)
 by BN6PR12MB1825.namprd12.prod.outlook.com (2603:10b6:404:107::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 14:49:44 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::8) by CO2PR04CA0157.outlook.office365.com
 (2603:10b6:104:4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Fri, 18 Jun 2021 14:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 14:49:43 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 14:49:41 +0000
Subject: Re: [pci:for-linus] BUILD SUCCESS WITH WARNING
 15ac366c3d20ce1e08173f1de393a8ce95a1facf
To:     Thierry Reding <treding@nvidia.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>
References: <20210618131304.GA3182065@bjorn-Precision-5520>
 <1991f432-3c32-32da-997d-e1dec12df0c5@nvidia.com>
 <YMyyPZSPMamYtgO6@orome.fritz.box>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b8a022e4-15b3-1339-7128-fdcc5ba1f7e8@nvidia.com>
Date:   Fri, 18 Jun 2021 15:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMyyPZSPMamYtgO6@orome.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27452ee0-df5c-41ed-b631-08d932684f2a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1825:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1825085C7DDCD2E345E2F21DD90D9@BN6PR12MB1825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ryuDW6wYEHuTKjSPz1Y3EE74l5LmWSCjI9ou2sjgL0vtnjE2EAjrCU4hQd7UWftE1cjxLsSulvfIOZG5DxuZHLznhps6GJo6LsBwW0tH38DIUAAHKN3sQa3eO8L226PRPOOBfFfl24AXht6tq/bKfHsXX7EWUvaiJazwCMWLz0Z0RLuigui76cFjTuvtv1yZNmr77abxh+J3WBScPF8Wp4QC8dC8PxN03sGpO8fG1l6Yoxk8mCJhbEo5FD9EVMIL5tKNqsFlpa391SD4uF3Sbsr1XTRyLU/TnuUiE1ZuUFlKsmOb382frbHfT0ykR+uIW/gixowIRzHPFQIckvR6YmljDPlRXm4eYJs2ciBuyHDw6g8wg89nRTKS/1vRLjJ+U/l1AZzWc6bEQiGyTKI1e9SUNAo9DL2LI25XWW6aumdSQU1nT908DokkHjYBaZpf5DCnUth/BYv2EDgI7waSxTTmGUbuRbKg5wLNTLJV5/OIOGQy0YqWgWDQJ2K3SlUitjZElpLqXJTarJhlPh9Ri2SZLzYGgWsgmVdZjOuVR1jSUo8LmJwLNHkOWw9MG0Y0Am8yX+fBYj8StqAF7Gm1Sf+q1XDvyi/T95T/Un7kFoQuRuSNZTKmx1SUGyoAvZq4mQCYm5b6lQfPJGPyjV6YMaz5v/oTZT5KL1fKIRW9UVi7qFFtq+XNwuYQ7Dx+n/HZ1M7RRFguK4DcGX7k0Pk5YOTXJNwOg58R+FvMiharPBtpABQKKHQUtx1x1zaLSC9cdnH6E5GcQPfM0iTi6FpD3DXMz9wwb382AHbuAhZtT/63M5+SUiOv0cjpYjhE4ldgG4Rl6ym9u8FFkjSPiH2+IaaQoEmAlkvzTqJf6Rw+lg=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(8936002)(36906005)(316002)(16576012)(37006003)(54906003)(6862004)(86362001)(47076005)(70206006)(70586007)(83380400001)(8676002)(966005)(53546011)(2616005)(6636002)(478600001)(16526019)(336012)(5660300002)(426003)(4326008)(186003)(26005)(82310400003)(36756003)(31686004)(31696002)(2906002)(36860700001)(82740400003)(7636003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 14:49:43.4703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27452ee0-df5c-41ed-b631-08d932684f2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1825
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 18/06/2021 15:48, Thierry Reding wrote:
> On Fri, Jun 18, 2021 at 03:03:24PM +0100, Jon Hunter wrote:
>> Hi Bjorn,
>>
>> On 18/06/2021 14:13, Bjorn Helgaas wrote:
>>> [+to Jon, +cc Thierry]
>>>
>>> On Fri, Jun 18, 2021 at 06:34:20PM +0800, kernel test robot wrote:
>>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
>>>> branch HEAD: 15ac366c3d20ce1e08173f1de393a8ce95a1facf  PCI: aardvark: Fix kernel panic during PIO transfer
>>>>
>>>> possible Warning in current branch:
>>>>
>>>> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]
>>>
>>> This looks like a legit warning, but I think the only commit that
>>> could be related is this one:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=99ab5996278379a02d5a84c4a7ac33a2ebfdb29e
>>>
>>> which doesn't touch that code.
>>>
>>> It does *move* some code, so maybe this was an existing warning that
>>> moved enough that the robot thought it was new?
>>
>>
>> I guessing that this is now happening because we are now compiling the
>> bulk of the code in the driver. However, yes looks like it has been
>> there for a while. 
>>
>> I wonder if the '(1 << irq)' is being treated as a signed type.
>>
>>> How can we reproduce this to make sure we fix it?
>>
>> I was able to reproduce it by ...
>>
>> $ cppcheck --force --enable=all drivers/pci/controller/dwc/pcie-tegra194.c 
>> Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
>>
>> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]
>>  appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
>>                       ^
>> drivers/pci/controller/dwc/pcie-tegra194.c:1826:19: note: Assuming that condition 'irq>31' is not redundant
>>  if (unlikely(irq > 31))
>>                   ^
>> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: note: Shift
>>  appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
>>
>>
>> I was able to fix this by ...
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 8fc08336f76e..05d6a8da190b 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
>>         if (unlikely(irq > 31))
>>                 return -EINVAL;
>>  
>> -       appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
>> +       appl_writel(pcie, (BIT(1) << irq), APPL_MSI_CTRL_1);
>>  
>>         return 0;
>>  }
>>
>> I can send this as a patch.
> 
> I think that's not the same anymore. The equivalent would rather be:
> 
> 	appl_writel(pcie, (BIT(0) << irq), APPL_MSI_CTRL_1);

Yes indeed!

> But I think this can be achieved more easily by doing this:
> 
> 	appl_writel(pcie, 1UL << irq, APPL_MSI_CTRL_1);
> 
> Which is what BIT(0) would effectively end up doing. Actually, this
> sounds like it should really have been this all along:
> 
> 	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
> 
> Which should also get rid of that warning.

Yes it does. I will send a patch with the above.

Thanks
Jon

-- 
nvpublic
