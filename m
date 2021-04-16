Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6533536214E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 15:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhDPNqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 09:46:18 -0400
Received: from mail-eopbgr770085.outbound.protection.outlook.com ([40.107.77.85]:40894
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229706AbhDPNqS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 09:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAIcJVMVtashNN0EC2bKhS+ywyw5F6foavX70ujXQk6PX1+wnbDvRZ/JNQFGo51/I2rvq+J2mTMZlD9Z0og3e44kH+WHIZH60rmkT/N1u35quVEcgz5XsCeSsRARxhjJbhlUWLcTNBXe0xFqsXgqsKgmUxBlkFeZp9LhvDz294lBuMTAeEYY7997Wdo1mtocvsNkWnQTt/AEU6orXhUkTvXinmC/4skQrrRemeG9RFsROqz7Gg5fWAhobFWR8rBXtnkTkYlfgU4b3oQaupVMcnmNNtEARB/H1ISWB6xgRzto4DtLuFURZE62R3Kpf4naDU8yMxvWfygEngFz6EQ++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+/esXgp9JvtqIk8Jjt4cbRjutmgj5ErpXeH1hk6D+4=;
 b=PovO639xugcAGKEC/ESajmkySiQ6rbPRFRlbi0OqiOWrRRTQgNZMph1nJ1Z/o5xWVFcDzry2XhwxPRcgOr5AuXfw3Hk5Ps9AtCNtmDWYrGEWlLL0lUgAwidYMTgzTb3ByY5xBQEyGIOI+nt8PrTP0EnAAKHseAsH6/KCpvFzimiHh5H76pgrbTCWqvS+kfa1tfYtdTbDATyV3qZbVvflSf3IpLFtwAGjqaIl6VWfRrZHDCx2+laevxheOYsX78wXVCgHReSU4AB7CmIXX31zCCvnXWDMlun5CMTbdZrk19o5viUhLj6aT6esuV6Y/+c0fip59ksR5tcnCOucDj/Fsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+/esXgp9JvtqIk8Jjt4cbRjutmgj5ErpXeH1hk6D+4=;
 b=OPpIhsax6CuUw70o6WA+n2iCgjF0f0438jqJY3RF4VQiM+PAz5Q+i+iupPbbonpWp6Ck7nXw/cloRz78SobyFACHJQ4M0QfSyZuczz3dbte0u3pp7yU/3DaqXMuazp325HqkVB/6sl/AzqE2fH1SomzFNJUK2RTqZQWoJW7rErvm+y2unmL8OPQOWiAtlrcMo1X1VoOSUQO/KZtO1iSy7AAUFnzyCoTMzC3KUJabE8zcrHY15TU5D/910UkrgfEJkb716BwluQCqV6M+ZcU0RFxLZ7sdkOGBO09EvcAq6LNqE5Ez2a7UgTJLj/sgNEF8DQL8UlAipO2f8s+hbzT0GA==
Received: from DM5PR07CA0084.namprd07.prod.outlook.com (2603:10b6:4:ad::49) by
 DM6PR12MB2665.namprd12.prod.outlook.com (2603:10b6:5:41::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22; Fri, 16 Apr 2021 13:45:51 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ce) by DM5PR07CA0084.outlook.office365.com
 (2603:10b6:4:ad::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Fri, 16 Apr 2021 13:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 13:45:51 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Apr
 2021 06:45:50 -0700
Received: from [10.25.99.89] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Apr
 2021 13:45:45 +0000
Subject: Re: [PATCH V3 2/2] PCI: Add MCFG quirks for Tegra194 host controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <andrew.murray@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <20210305215749.GA1117765@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <3b9d99cc-fa20-1906-f200-c993a8e4d9c9@nvidia.com>
Date:   Fri, 16 Apr 2021 19:15:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305215749.GA1117765@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8208d9d3-ed4f-4adf-1f9b-08d900ddf305
X-MS-TrafficTypeDiagnostic: DM6PR12MB2665:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2665981756CC64F15E3B75BCB84C9@DM6PR12MB2665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwfL2h60znauFl3A5Ali1BAlPYB6lhvI8X1B+Rs/KZ19qx5K5F+rpkXJ+59LAOv6PvZowOcPKy2BoYTtj/Du+z6F52E1vwuYq3aWmGl5bV5zOJPwI1XrsgkIoKwq5hWo6ALjqGzu+wje8oCCwhweP8ugdr/pTGM0Qqey/gnRb78hSe8ZM++ZFeyYl3xZm6Wm8Kn/DUhC7ueQtPzC6k8MDKT+Nb/KEG04+WbSHqWdsKhbQTWvmlHv85hrELZwUFSL43Pq9BQ1u3Tmwt1I6MC151IaUVVkQXHw3cOPXR1UB7OwP6lBktPWoX1sjq57k+v53+HxL1OfwhgRkiuJEwsqtBsfxYi9RvqC59ejsl7T7AZnmtVNsk8i3wf5gBHBdqWvO+AWL3+XUm+wSfM2KMagrK3wrjjUfiI62cIi2rA45sMOq5YTLLLl//FVm8IK8DIl0H8fADsZwB97Af0EhchGl4xd54VeGN4ikPhsavpHX7dVTGMEniRoRv7PdGwFwn5hCnMXeguODLyAY5MikbySsHSQIbS9tEABwcPeAdrnhlH+IVXXg0e2u2rUlvPYlMh9BcDOhqLoSgqiOppurpiohYVnePTcDNdzLerR95Jea0ppQnXUejQv9vRadGOWbx+OjXPm3/oZaWHYqVNdXWbdYJu4N2P3epGDSaBsrPO38NrOUXRMgIsTn/JzH2GiFyL7
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(4326008)(36860700001)(7416002)(83380400001)(82740400003)(16576012)(7636003)(2616005)(316002)(86362001)(53546011)(356005)(47076005)(26005)(54906003)(31696002)(5660300002)(6916009)(8676002)(426003)(336012)(36756003)(16526019)(2906002)(82310400003)(478600001)(186003)(70206006)(70586007)(6666004)(8936002)(31686004)(30864003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 13:45:51.3448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8208d9d3-ed4f-4adf-1f9b-08d900ddf305
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2665
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/6/2021 3:27 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Krzysztof for .bus_shift below]
> 
> This is [2/2] but I don't see a [1/2].  Is there something missing?
> 
> On Sat, Jan 11, 2020 at 12:45:00AM +0530, Vidya Sagar wrote:
>> The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
>> With the current hardware design limitations in place, ECAM can be enabled
>> only for one controller (C5 controller to be precise) with bus numbers
>> starting from 160 instead of 0. A different approach is taken to avoid this
>> abnormal way of enabling ECAM for just one controller but to enable
>> configuration space access for all the other controllers. In this approach,
>> ops are added through MCFG quirk mechanism which access the configuration
>> spaces by dynamically programming iATU (internal AddressTranslation Unit)
>> to generate respective configuration accesses just like the way it is
>> done in DesignWare core sub-system.
> 
> Is this a published erratum in the device?  The purpose of specs is so
> we can run existing code on new platforms without having to add quirks
> like this, so I'm looking for some acknowledgement that this is an
> issue that will be fixed in future designs.
Yes. This would be fixed in the following SoC.

> 
> Ideally this would be a URL to published errata, and we would include
> the text or a synopsis here in the commit log.
> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> What is this "Reported-by" telling me?  Normally this would be a
> person who could supply more information about a defect we're fixing
> and might be able to test the fix.
I'll remove this.

> 
>> ---
>> V3:
>> * Removed MCFG address hardcoding in pci_mcfg.c file
>> * Started using 'dbi_base' for accessing root port's own config space
>> * and using 'config_base' for accessing config space of downstream hierarchy
>>
>> V2:
>> * Fixed build issues reported by kbuild test bot
> 
> Ah, I see this is probably where the "Reported-by" came from.  To me,
> it would make sense to add the tag if the commit *only* fixes the
> build problem so it's obvious what the robot reported.
> 
> But here, the build fix got squashed in before merging, so it's more
> like a general review comment and I think the robot's response on the
> mailing list is probably enough.
> 
>>   drivers/acpi/pci_mcfg.c                    |   7 ++
>>   drivers/pci/controller/dwc/Kconfig         |   3 +-
>>   drivers/pci/controller/dwc/Makefile        |   2 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
>>   include/linux/pci-ecam.h                   |   1 +
>>   5 files changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 6b347d9920cc..707181408173 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -116,6 +116,13 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>        THUNDER_ECAM_QUIRK(2, 12),
>>        THUNDER_ECAM_QUIRK(2, 13),
>>
>> +     { "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +
>>   #define XGENE_V1_ECAM_MCFG(rev, seg) \
>>        {"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
>>                &xgene_v1_pcie_ecam_ops }
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 0830dfcfa43a..f5b9e75aceed 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -255,7 +255,8 @@ config PCIE_TEGRA194
>>        select PHY_TEGRA194_P2U
>>        help
>>          Say Y here if you want support for DesignWare core based PCIe host
>> -       controller found in NVIDIA Tegra194 SoC.
>> +       controller found in NVIDIA Tegra194 SoC. ACPI platforms with Tegra194
>> +       don't need to enable this.
>>
>>   config PCIE_UNIPHIER
>>        bool "Socionext UniPhier PCIe controllers"
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index 8a637cfcf6e9..76a6c52b8500 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -17,7 +17,6 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>>   obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>>   obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>>   obj-$(CONFIG_PCI_MESON) += pci-meson.o
>> -obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>>   obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>
>>   # The following drivers are for devices that use the generic ACPI
>> @@ -33,4 +32,5 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>   ifdef CONFIG_PCI
>>   obj-$(CONFIG_ARM64) += pcie-al.o
>>   obj-$(CONFIG_ARM64) += pcie-hisi.o
>> +obj-$(CONFIG_ARM64) += pcie-tegra194.o
>>   endif
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index cbe95f0ea0ca..660f55caa8be 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -21,6 +21,8 @@
>>   #include <linux/of_irq.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>> +#include <linux/pci-ecam.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> @@ -285,6 +287,103 @@ struct tegra_pcie_dw {
>>        struct dentry *debugfs;
>>   };
>>
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>> +struct tegra194_pcie_acpi  {
>> +     void __iomem *config_base;
>> +     void __iomem *iatu_base;
>> +     void __iomem *dbi_base;
>> +};
>> +
>> +static int tegra194_acpi_init(struct pci_config_window *cfg)
>> +{
>> +     struct device *dev = cfg->parent;
>> +     struct tegra194_pcie_acpi *pcie;
> 
> "pcie" doesn't seem like the best name for this since everywhere else
> in this driver, "pcie" is a "struct tegra_pcie_dw *".  Maybe "mcfg"
> or similar?
> 
> With some rename of tegra194_pcie_acpi along the same lines, since it
> really isn't ACPI-specific.  It's just that the ACPI MCFG table
> happens to be the way to discover the ECAM address space.
Understood. I'll take care of it in the next patch.

> 
>> +     pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> +     if (!pcie)
>> +             return -ENOMEM;
>> +
>> +     pcie->config_base = cfg->win;
>> +     pcie->iatu_base = cfg->win + SZ_256K;
>> +     pcie->dbi_base = cfg->win + SZ_512K;
>> +     cfg->priv = pcie;
>> +
>> +     return 0;
>> +}
>> +
>> +static inline void atu_reg_write(struct tegra194_pcie_acpi *pcie, int index,
>> +                              u32 val, u32 reg)
> 
> "inline" is pointless, I think, since this isn't a performance path
> and the compiler will probably inline it by itself.
Ok. I'll remove it in the next patch.

> 
>> +{
>> +     u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>> +
>> +     writel(val, pcie->iatu_base + offset + reg);
>> +}
>> +
>> +static void program_outbound_atu(struct tegra194_pcie_acpi *pcie, int index,
>> +                              int type, u64 cpu_addr, u64 pci_addr, u64 size)
>> +{
>> +     atu_reg_write(pcie, index, lower_32_bits(cpu_addr),
>> +                   PCIE_ATU_LOWER_BASE);
>> +     atu_reg_write(pcie, index, upper_32_bits(cpu_addr),
>> +                   PCIE_ATU_UPPER_BASE);
>> +     atu_reg_write(pcie, index, lower_32_bits(pci_addr),
>> +                   PCIE_ATU_LOWER_TARGET);
>> +     atu_reg_write(pcie, index, lower_32_bits(cpu_addr + size - 1),
>> +                   PCIE_ATU_LIMIT);
>> +     atu_reg_write(pcie, index, upper_32_bits(pci_addr),
>> +                   PCIE_ATU_UPPER_TARGET);
>> +     atu_reg_write(pcie, index, type, PCIE_ATU_CR1);
>> +     atu_reg_write(pcie, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>> +}
>> +
>> +static void __iomem *tegra194_map_bus(struct pci_bus *bus,
>> +                                   unsigned int devfn, int where)
>> +{
>> +     struct pci_config_window *cfg = bus->sysdata;
>> +     struct tegra194_pcie_acpi *pcie = cfg->priv;
>> +     u32 busdev;
>> +     int type;
>> +
>> +     if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
>> +             return NULL;
>> +
>> +     if (bus->number == cfg->busr.start) {
>> +             if (PCI_SLOT(devfn) == 0)
>> +                     return pcie->dbi_base + where;
>> +             else
>> +                     return NULL;
>> +     }
>> +
>> +     busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>> +              PCIE_ATU_FUNC(PCI_FUNC(devfn));
>> +
>> +     if (bus->parent->number == cfg->busr.start) {
>> +             if (PCI_SLOT(devfn) == 0)
>> +                     type = PCIE_ATU_TYPE_CFG0;
>> +             else
>> +                     return NULL;
>> +     } else {
>> +             type = PCIE_ATU_TYPE_CFG1;
>> +     }
>> +
>> +     program_outbound_atu(pcie, PCIE_ATU_REGION_INDEX0, type,
>> +                          cfg->res.start, busdev, SZ_256K);
> 
> I don't see a PCIE_ATU_REGION_INDEX0 definition.  Maybe that's what's
> in the [1/2] patch?  I guess there's some way to be sure this ATU
> isn't used for other purposes?
> 
>> +     return (void __iomem *)(pcie->config_base + where);
> 
> Isn't the type correct even without the cast, same as above for
> "pcie->dbi_base + where"?
Correct. I'll address it in the next patch.

> 
>> +}
>> +
>> +struct pci_ecam_ops tegra194_pcie_ops = {
>> +     .bus_shift      = 20,
> 
> I think e7708f5b10e2 ("PCI: Unify ECAM constants in native PCI Express
> drivers") means you don't need this .bus_shift.
Correct. I'll remove this in the next patch.

> 
>> +     .init           = tegra194_acpi_init,
>> +     .pci_ops        = {
>> +             .map_bus        = tegra194_map_bus,
>> +             .read           = pci_generic_config_read,
>> +             .write          = pci_generic_config_write,
>> +     }
>> +};
>> +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
>> +
>> +#ifdef CONFIG_PCIE_TEGRA194
>> +
>>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>>   {
>>        return container_of(pci, struct tegra_pcie_dw, pci);
>> @@ -1728,3 +1827,6 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
>>   MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>>   MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
>>   MODULE_LICENSE("GPL v2");
>> +
>> +#endif /* CONFIG_PCIE_TEGRA194 */
>> +
>> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
>> index a73164c85e78..6156140dcbb6 100644
>> --- a/include/linux/pci-ecam.h
>> +++ b/include/linux/pci-ecam.h
>> @@ -57,6 +57,7 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
>>   extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
>>   extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>>   extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
>> +extern struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
>>   #endif
>>
>>   #ifdef CONFIG_PCI_HOST_COMMON
>> --
>> 2.17.1
>>
