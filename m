Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A679538C782
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 15:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEUNMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 09:12:45 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:54112
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230137AbhEUNMo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 09:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/BSVko2Ugnqz+TGDpY6tLna2wDzHlc7VG0EermJkA77DFgcEY5tsgOWD0zDq3XiRFatGM25k1DUQbqAm2m8uVm4R2TZmq4ehJsj0d67SK2gxgDcOvi4kx6H3CWQJPUJSp+7xaTOqAkR68ACtWtG4AorDDa4akXGc1dSyIrxdQertw/yDQH+DCrKoQBN/Hmo6iSytgYsdgGFuq0brxW5Ljd61H4d47QhA9KxHiilA+RcxuEn4LrHAvHPDCrh1AOp0VcXItUeujiMeqDjMW0o1K70SHQfV0QW//wd4ncwXVh6aGeGsyrFm+MhHvXnwxUiG3oY2MxHVzuohcNkZ15ySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsFXRiC7NRRIL1pSRn3X9zMzp9TJLo/wVjTxU7Kb6Og=;
 b=XVMvfzvlasJw9Z+WLyv387J4gkEnThMTmkNWxZvWguQBdnjjSZRAJGsipxsDTE6TgBp2+FvLH49Nqh/ZyWok5C9cRqUl4LFOeqUFDppuLHAW6w0x3jpKi2oKgiHInOMQV/5uURG8xN+yJRJTVIcgwEERWWJNBPUuEr7XQ9M0ivbcmVnLu9prqD+Vz0WHUyagNQzymEofWb323I3Chj54RP2vNl6KxyvfzQun+s63YAnrYxJC0S9yqfFONYIHf94xlXSczeDnG/+O2s/XaBtvyhqviv3Yv7Oxu6ua/uE0N1WkPHkAPpzhl10g5IDp8KtaQaIxqStUiT5WzNOEZ2XCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsFXRiC7NRRIL1pSRn3X9zMzp9TJLo/wVjTxU7Kb6Og=;
 b=DwMuq++qlUj9EwZPnedQpW4v46+v8V7h7Tj+Q8T4X+joxUraT8bqzw+G/Rk9y5NSe7mEkR1d94VFokulsWI7oFmzq9vWx8hb2y5XQXOE1/NMUrfY3dvPEcC3R4V/Zeb5Be7iMYa8Np+N5iSOKAa3hN8BtYYcmWRQaIePe8AL9pjN17u+2inoMvKjjfNKt4KYozwaFAZckOo96kGSjpCHn/v8IiQkKjcG9ZoCWXNqJeD5Rv5uNe0KjxjrajA9+2O90UP4jHryp3n1XJ+yv3N44YpSfgX1wnwngXbF1jlp1zacANFzviJyEtYFpken4aJUPwQmg4fggfExIKGkl0YVZw==
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 13:11:20 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::2b) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 13:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 13:11:20 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 May
 2021 13:11:17 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210520221948.GA352305@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a3f39a47-8dff-a4b0-a529-0f17f42114f3@nvidia.com>
Date:   Fri, 21 May 2021 14:11:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520221948.GA352305@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ef8952d-3f14-4a2a-4e56-08d91c59ed0c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41796F78B17BCFA900F6AC8BD9299@BY5PR12MB4179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USSIhTNLrAQmmrLpIVacGvepMA5bqoEauMsW5IOEmyUzOXGujeDprJ72+51xOLxoJQKeirPxYNM/ygV85tggSQ5C3tpA/I8xMUhpDye827qbxqK0B3tqLhlH8Cnp9tzALppVd5AYaFIcVGP+kGbE3G3hZrnKrB8RSWXT/fsT4BRL7R6oIk9xNN6e6lULZpDUVXgy9cs/0lsVfVFxSMfliQdyvAkZQaGpr8P+8B10Er1nN4pKTHSOvsbDy0hS9C7O6oyLWMiUYq/XHvMcpP/tLHQwYkx6ZuDgFjO6jHbU3tGx5usv3A9x2ViEFxpJYnYzyxIkFhR+e9e7wtHDseR+QGQsOlZi15v4GMh0ZbFKWUGiBRVB2g9ESg4pQRdxty+c1SAHTQqlDRcNcbz9Wjcw5sx68YM+B4cJxjffGW3kduWNLiLZWdISqP/ToPXOCyJqmw+AXujyzRMkqyxjy3V98IUBkAmQESvnt/6K9qfBoadylX82BHjVUy2Qm32zboUFg+RvjFVFEwTz6udT6eVljYGsW9FW+iLIOMpbU+OStt6m87RkkcQNrAbhQNNRZRNOpBzVH+WLY6UhXORS7bwuzcBCiWkB3aJcRf2kwanGzqzHayOxUciMNTvEaa0YGphiZFoDoOkTzkknprop0QKGFZOCHjv4akGt4b53UrNR7q4GE8er0BvuiYxt1COGHxam
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36840700001)(46966006)(47076005)(82310400003)(8676002)(83380400001)(356005)(2616005)(8936002)(31696002)(36906005)(4326008)(36756003)(316002)(5660300002)(336012)(7636003)(26005)(86362001)(36860700001)(426003)(31686004)(6916009)(16576012)(2906002)(70206006)(186003)(53546011)(16526019)(478600001)(82740400003)(54906003)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 13:11:20.2660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef8952d-3f14-4a2a-4e56-08d91c59ed0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 20/05/2021 23:19, Bjorn Helgaas wrote:
> On Thu, May 20, 2021 at 10:01:23AM +0100, Jon Hunter wrote:
>> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>> errata") caused a few build regressions for the Tegra194 PCIe driver
>> which are:
>>
>> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>>    was caused by removing the Makefile entry to build the pcie-tegra.c
>>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>>    so that we can build the driver as a module if ACPI support is not
>>    enabled in the kernel.
> 
> I'm not sure what "if ACPI support is not enabled in the kernel" is
> telling me.  Does it mean that we can only build tegra194 as a module
> if ACPI is not enabled?  I don't think so (at least, I don't think
> Kconfig enforces that).

If ACPI is enabled, then we will build the driver into the kernel. If we
have ...

 CONFIG_ACPI=y
 CONFIG_PCIE_TEGRA194=m

FWICS the pcie-tegra194.c driver is builtin to the kernel.
	> Should the "if ACPI support is not enabled ..." part just be dropped?
> 
> I assume it should be possible to build the kernel with ACPI enabled
> and with pcie-tegra194 as a module?

Per the above that does not appear to be possible.

>> 2. If CONFIG_PCIE_TEGRA194 is configured to build the driver as a
>>    module, at the same time that CONFIG_ACPI and CONFIG_PCI_QUIRKS are
>>    selected to build the driver into the kernel, then the necessary
>>    functions in the driver to probe and remove the device when booting
>>    with device-tree and not compiled into to the driver. This prevents
>>    the PCIe devices being probed when booting with device-tree. Fix this
>>    by using the IS_ENABLED() macro.
> 
> The #ifdef vs IS_ENABLED() difference is kind of subtle and I have to
> figure it out every time.  Maybe something like this?
> 
>   7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>   errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
>   driver.
> 
>   But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
>   module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
>   (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
>   driver.
> 
>   Instead, use "IS_ENABLED(CONFIG_PCIE_TEGRA194)", which checks for
>   either CONFIG_PCIE_TEGRA194 or CONFIG_PCIE_TEGRA194_MODULE.

OK sounds good. Thanks

>> 3. The below build warnings to be seen with particular kernel
>>    configurations. Fix these by adding the necessary guards around these
>>    variable definitions.
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
>>   	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
>>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
>>   	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
>>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
>>   	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
>>
>> Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> This is a candidate for v5.13, since we merged 7f100744749e for
> v5.13-rc1.

Yes we need to fix for v5.13.

>> ---
>>  drivers/pci/controller/dwc/Makefile        | 1 +
>>  drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index eca805c1a023..f0d1e2d8c022 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>>  # depending on whether ACPI, the DT driver, or both are enabled.
>>  
>>  obj-$(CONFIG_PCIE_AL) += pcie-al.o
>> +obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>>  obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
> 
> It sounds like the interesting case is this:
> 
>   CONFIG_ARM64=y
>   CONFIG_ACPI=y
>   CONFIG_PCI_QUIRKS=y
>   CONFIG_PCIE_TEGRA194=m
> 
> I don't know how this works in this case:
> 
>   obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>   obj-$(CONFIG_ARM64) += pcie-tegra194.o
> 
> We want tegra194_acpi_init() and the rest of the ECAM quirk to be
> compiled into the static kernel.  And we want tegra_pcie_dw_probe(),
> tegra_pcie_dw_remove(), etc, compiled into a module.
> 
> Does kbuild really compile pcie-tegra194.c twice?  And if so, it's not
> a problem that both the static kernel and the module contain a
> tegra194_pcie_ops symbol?

FWICT it does not compile it twice and I only see it builtin. We the
above I don't see any module generated.

>>  ifdef CONFIG_ACPI
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index b19775ab134e..ae70e53a7826 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -240,13 +240,16 @@
>>  #define EP_STATE_DISABLED	0
>>  #define EP_STATE_ENABLED	1
>>  
>> +#if IS_ENABLED(CONFIG_PCIE_TEGRA194)
>>  static const unsigned int pcie_gen_freq[] = {
>>  	GEN1_CORE_CLK_FREQ,
>>  	GEN2_CORE_CLK_FREQ,
>>  	GEN3_CORE_CLK_FREQ,
>>  	GEN4_CORE_CLK_FREQ
>>  };
>> +#endif
> 
> This makes the minimal patch, but as Krzysztof suggests, I would
> prefer to move the whole struct so it's just inside the
> CONFIG_PCIE_TEGRA194 #ifdef.

OK, will do.

>> +#if defined(CONFIG_PCIEASPM)
>>  static const u32 event_cntr_ctrl_offset[] = {
>>  	0x1d8,
>>  	0x1a8,
>> @@ -264,6 +267,7 @@ static const u32 event_cntr_data_offset[] = {
>>  	0x1c8,
>>  	0x1dc
>>  };
>> +#endif
> 
> Similar for the CONFIG_PCIEASPM #ifdef.

OK.

Thanks
Jon

-- 
nvpublic
