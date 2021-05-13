Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E737F85F
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhEMNGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 09:06:50 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:7963
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229466AbhEMNGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 09:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAlkvz7H9e7ilSrT8kN5wZuP6vHxgRK7v4yShnMhLmfir6Ngcg0UuZBU3ZxjNEPGOuY8FFiUbmiwe0PFSK1/q6bTM2D01UR6gQYxpC2VSFGMW+7rgiN8AXEV8Sk+SXdk09nqgwVNnIkhb8HU0JJK47Ne9DeGH7uFBSUKmWnfisyMO54phHlyVOdfuCnJ5RPRbYa9AomObxyE4ARdnBvuFZlcANvB/fW1JgnipNABrK2EGzt0kIhHoKEzTExMlmTScv0yNM0iSx4zcwRHdwPo9z0EJA8YPMK5sAMkA7Isk+q01mn6Ih2EoPJFFzz6RujlXnflyB13rzcDIRaM25+Z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Zq61P0Ebyj7qQQak1CGWtIh36GYEZVGC2iMqGhMSM=;
 b=m/EEb9zVIK9TEAQDBw3QqvmAugPFLoKyXEoMoocNnHVaSynwvxc+nfPTUuU9UHhGEbzxLAgeFxn1+hCF+uNtp4X1Bg3fKzfDMfq7/CL9Yy3pjNb8Nq99Dqcg1O+aimpEML3P0i+dnCoobbp1iEbolVd/cwjMPBpZcX7lb/P21eBWHi6yObt8LUsGxo6cKuWmeCgyPUW6URgAma7qH2Wwz1r5fBeDd//f96BkaBRj2/3VUi4ZBQ0kSP1fWu+cvmop0hVM1/XcWg8It23dcihHxV/O8twFM7r9XANdMW7xZBezvlCbFe7VPpbFK+y52e4QvOqja/NS8RsGi1rluoa6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Zq61P0Ebyj7qQQak1CGWtIh36GYEZVGC2iMqGhMSM=;
 b=UkvEQesVv1d88fVhrlfbVcHG9tJ8mvHt4qBzmVJqsW5/IuL7LHNFILm7njC8dMFv3cVZRFz/ipp7ZVI9pq75s0euJJFpniqSTFD9ff5H/0i0ZN0Q3OiAGelJwrqc2WN7jXvi501rVLppauBn+ZjWYdXTSxqmmC9iCWW0GnNmrtd0xCxy2w5NZyAchxd0tmVROmi8Ew71gWNWdjA7FvFi01rZMscM8omxB92aVEZxQETj0QdrQAjBcdL8S0dNToLfofHoMPhOEm5X7TL2CGxh/F5vrqc9nOg6v5EWwH/8mI4qZ0rkXSST1/TBs1gJes1IOJlDcTl8U12Rs7mW7PPrrg==
Received: from MWHPR11CA0011.namprd11.prod.outlook.com (2603:10b6:301:1::21)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 13 May
 2021 13:05:37 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::8) by MWHPR11CA0011.outlook.office365.com
 (2603:10b6:301:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 13:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 13 May 2021 13:05:36 +0000
Received: from [10.25.74.214] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 13 May
 2021 13:05:33 +0000
Subject: Re: [PATCH V3 2/2] PCI: Add MCFG quirks for Tegra194 host controllers
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <andrew.murray@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
 <20200110191500.9538-3-vidyas@nvidia.com>
 <bba8c172-bade-d6fe-d167-3fbc2c917c93@gmx.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <babcdd00-0ff5-838a-f8e6-612d2264c2cb@nvidia.com>
Date:   Thu, 13 May 2021 18:35:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <bba8c172-bade-d6fe-d167-3fbc2c917c93@gmx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2720ee07-fc73-4433-839f-08d9160fcd06
X-MS-TrafficTypeDiagnostic: CH2PR12MB3832:
X-Microsoft-Antispam-PRVS: <CH2PR12MB383258BFC331A82C3E5C1655B8519@CH2PR12MB3832.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlQ+PJqmDKcFuKSU1qmbxA/9bpuKrap+1e4oj12eQY9YghSgKPCTymVyKdgUiax/dS/ajgwmjpYB6gRK+uNNgLtL13sAbDoyaY2kxYTaLGD0ynPtkLOq5HULTRJBKESWKr/U6FANy/3vVsbxKmp0JJRoo80jS0M7R/8BkVdruvRAQIcZBiODXk5Nbp4dGqCvqjNCb/E2X0zyswmjGzUEhC5nsjBhvpDYIZQ5PakBHrxry1YbMjfxdiTUjq+K1mGXQY/kWbG2IJMRR1louhv8akv8SA5BLcIycbpy7LzHCno9BP6E+93nBhRwprLh+SOOH4Lujb5NiSptGIUH2HoY7fWK/0CGEE0qKHSku9UzyzVcxiUqQpUoPuoVJPY4+RjyXq3j88cR9HwEuV7E3BmNP8mRgf2JL7UMa2ngE2S3rbZQxFNqI+ukbM7fMg8Owk+uQT1h/NO1iB7UBymsXXhZfVTfBwcHA2nQervK6Gxosu7/4d3JowsczJxdfyrMCPZVMF6aSlwoRhvKdT+SMAD8QzCuyEeZpRFyG0xoYL0/WnHeUR6Q8yNgU1H4bCNu+/0dasmIp5k4CBLqxtPZLJT57vvXuHbAHm7Ggzdbw+9pgLYlv4U7NKgFEcOpCY/8ABOn0syzen8I+KLXqNvX18v0zr9nj3mzP2tIryXu5DZxxsAgc4rZl6vmrP9KDthPIy6I
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(82740400003)(36860700001)(16526019)(47076005)(186003)(5660300002)(54906003)(86362001)(36756003)(7416002)(82310400003)(36906005)(16576012)(31696002)(336012)(478600001)(110136005)(316002)(7636003)(53546011)(83380400001)(2906002)(8936002)(8676002)(6636002)(426003)(31686004)(70586007)(356005)(70206006)(4326008)(2616005)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 13:05:36.8313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2720ee07-fc73-4433-839f-08d9160fcd06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/13/2021 3:10 PM, Qu Wenruo wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2020/1/11 上午3:15, Vidya Sagar wrote:
>> The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
>> With the current hardware design limitations in place, ECAM can be 
>> enabled
>> only for one controller (C5 controller to be precise) with bus numbers
>> starting from 160 instead of 0. A different approach is taken to avoid 
>> this
>> abnormal way of enabling ECAM for just one controller but to enable
>> configuration space access for all the other controllers. In this 
>> approach,
>> ops are added through MCFG quirk mechanism which access the configuration
>> spaces by dynamically programming iATU (internal AddressTranslation Unit)
>> to generate respective configuration accesses just like the way it is
>> done in DesignWare core sub-system.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Hi Vidya,
> 
> Mind to update the patch so that guys can test booting tegra194 boards
> using ACPI with PCIE enabled?
The latest version of this patch is merged and is available in linux-next.

> 
> I tried to backport this to current kernel, there are some simple
> conflicts like pci_ecam_ops now are definied with const.
> 
> But "PCIE_ATU_REGION_INDEX0" is not definited anywhere, not even in the
> first patch, thus unable to compile at all.
> 
> 
> I have already tried to boot the Xavier AGX using device tree (5.12-rc8
> kernel), although I can boot it from PCIE NVME using upstream device
> tree, but there seems to be something wrong, as just trying to push
> kernel git to the fs on NVME can lead to random crash.
> 
> Thus if we can test booting using ACPI with PCIE, maybe we can find if
> it's really the upstream device tree causing the problem.
> 
> Thanks,
> Qu
>> ---
>> V3:
>> * Removed MCFG address hardcoding in pci_mcfg.c file
>> * Started using 'dbi_base' for accessing root port's own config space
>> * and using 'config_base' for accessing config space of downstream 
>> hierarchy
>>
>> V2:
>> * Fixed build issues reported by kbuild test bot
>>
>>   drivers/acpi/pci_mcfg.c                    |   7 ++
>>   drivers/pci/controller/dwc/Kconfig         |   3 +-
>>   drivers/pci/controller/dwc/Makefile        |   2 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
>>   include/linux/pci-ecam.h                   |   1 +
>>   5 files changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 6b347d9920cc..707181408173 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -116,6 +116,13 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>       THUNDER_ECAM_QUIRK(2, 12),
>>       THUNDER_ECAM_QUIRK(2, 13),
>>
>> +     { "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +     { "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops},
>> +
>>   #define XGENE_V1_ECAM_MCFG(rev, seg) \
>>       {"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
>>               &xgene_v1_pcie_ecam_ops }
>> diff --git a/drivers/pci/controller/dwc/Kconfig 
>> b/drivers/pci/controller/dwc/Kconfig
>> index 0830dfcfa43a..f5b9e75aceed 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -255,7 +255,8 @@ config PCIE_TEGRA194
>>       select PHY_TEGRA194_P2U
>>       help
>>         Say Y here if you want support for DesignWare core based PCIe 
>> host
>> -       controller found in NVIDIA Tegra194 SoC.
>> +       controller found in NVIDIA Tegra194 SoC. ACPI platforms with 
>> Tegra194
>> +       don't need to enable this.
>>
>>   config PCIE_UNIPHIER
>>       bool "Socionext UniPhier PCIe controllers"
>> diff --git a/drivers/pci/controller/dwc/Makefile 
>> b/drivers/pci/controller/dwc/Makefile
>> index 8a637cfcf6e9..76a6c52b8500 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -17,7 +17,6 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>>   obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>>   obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>>   obj-$(CONFIG_PCI_MESON) += pci-meson.o
>> -obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>>   obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>
>>   # The following drivers are for devices that use the generic ACPI
>> @@ -33,4 +32,5 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>   ifdef CONFIG_PCI
>>   obj-$(CONFIG_ARM64) += pcie-al.o
>>   obj-$(CONFIG_ARM64) += pcie-hisi.o
>> +obj-$(CONFIG_ARM64) += pcie-tegra194.o
>>   endif
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c 
>> b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index cbe95f0ea0ca..660f55caa8be 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -21,6 +21,8 @@
>>   #include <linux/of_irq.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>> +#include <linux/pci-ecam.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> @@ -285,6 +287,103 @@ struct tegra_pcie_dw {
>>       struct dentry *debugfs;
>>   };
>>
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>> +struct tegra194_pcie_acpi  {
>> +     void __iomem *config_base;
>> +     void __iomem *iatu_base;
>> +     void __iomem *dbi_base;
>> +};
>> +
>> +static int tegra194_acpi_init(struct pci_config_window *cfg)
>> +{
>> +     struct device *dev = cfg->parent;
>> +     struct tegra194_pcie_acpi *pcie;
>> +
>> +     pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> +     if (!pcie)
>> +             return -ENOMEM;
>> +
>> +     pcie->config_base = cfg->win;
>> +     pcie->iatu_base = cfg->win + SZ_256K;
>> +     pcie->dbi_base = cfg->win + SZ_512K;
>> +     cfg->priv = pcie;
>> +
>> +     return 0;
>> +}
>> +
>> +static inline void atu_reg_write(struct tegra194_pcie_acpi *pcie, int 
>> index,
>> +                              u32 val, u32 reg)
>> +{
>> +     u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>> +
>> +     writel(val, pcie->iatu_base + offset + reg);
>> +}
>> +
>> +static void program_outbound_atu(struct tegra194_pcie_acpi *pcie, int 
>> index,
>> +                              int type, u64 cpu_addr, u64 pci_addr, 
>> u64 size)
>> +{
>> +     atu_reg_write(pcie, index, lower_32_bits(cpu_addr),
>> +                   PCIE_ATU_LOWER_BASE);
>> +     atu_reg_write(pcie, index, upper_32_bits(cpu_addr),
>> +                   PCIE_ATU_UPPER_BASE);
>> +     atu_reg_write(pcie, index, lower_32_bits(pci_addr),
>> +                   PCIE_ATU_LOWER_TARGET);
>> +     atu_reg_write(pcie, index, lower_32_bits(cpu_addr + size - 1),
>> +                   PCIE_ATU_LIMIT);
>> +     atu_reg_write(pcie, index, upper_32_bits(pci_addr),
>> +                   PCIE_ATU_UPPER_TARGET);
>> +     atu_reg_write(pcie, index, type, PCIE_ATU_CR1);
>> +     atu_reg_write(pcie, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>> +}
>> +
>> +static void __iomem *tegra194_map_bus(struct pci_bus *bus,
>> +                                   unsigned int devfn, int where)
>> +{
>> +     struct pci_config_window *cfg = bus->sysdata;
>> +     struct tegra194_pcie_acpi *pcie = cfg->priv;
>> +     u32 busdev;
>> +     int type;
>> +
>> +     if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
>> +             return NULL;
>> +
>> +     if (bus->number == cfg->busr.start) {
>> +             if (PCI_SLOT(devfn) == 0)
>> +                     return pcie->dbi_base + where;
>> +             else
>> +                     return NULL;
>> +     }
>> +
>> +     busdev = PCIE_ATU_BUS(bus->number) | 
>> PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>> +              PCIE_ATU_FUNC(PCI_FUNC(devfn));
>> +
>> +     if (bus->parent->number == cfg->busr.start) {
>> +             if (PCI_SLOT(devfn) == 0)
>> +                     type = PCIE_ATU_TYPE_CFG0;
>> +             else
>> +                     return NULL;
>> +     } else {
>> +             type = PCIE_ATU_TYPE_CFG1;
>> +     }
>> +
>> +     program_outbound_atu(pcie, PCIE_ATU_REGION_INDEX0, type,
>> +                          cfg->res.start, busdev, SZ_256K);
>> +     return (void __iomem *)(pcie->config_base + where);
>> +}
>> +
>> +struct pci_ecam_ops tegra194_pcie_ops = {
>> +     .bus_shift      = 20,
>> +     .init           = tegra194_acpi_init,
>> +     .pci_ops        = {
>> +             .map_bus        = tegra194_map_bus,
>> +             .read           = pci_generic_config_read,
>> +             .write          = pci_generic_config_write,
>> +     }
>> +};
>> +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
>> +
>> +#ifdef CONFIG_PCIE_TEGRA194
>> +
>>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>>   {
>>       return container_of(pci, struct tegra_pcie_dw, pci);
>> @@ -1728,3 +1827,6 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
>>   MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>>   MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
>>   MODULE_LICENSE("GPL v2");
>> +
>> +#endif /* CONFIG_PCIE_TEGRA194 */
>> +
>> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
>> index a73164c85e78..6156140dcbb6 100644
>> --- a/include/linux/pci-ecam.h
>> +++ b/include/linux/pci-ecam.h
>> @@ -57,6 +57,7 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; /* 
>> Cavium ThunderX 1.x */
>>   extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene 
>> PCIe v1 */
>>   extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene 
>> PCIe v2.x */
>>   extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs 
>> PCIe */
>> +extern struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
>>   #endif
>>
>>   #ifdef CONFIG_PCI_HOST_COMMON
>>
