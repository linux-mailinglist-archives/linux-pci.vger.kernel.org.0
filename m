Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559DD39F7B0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhFHNXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 09:23:09 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:50273
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232892AbhFHNXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 09:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGi3dZ6EWl21x5HeiRb9UsBXggTMZMmucx2SF+CAIemm03iUwT0z7czQtCNHAN/F5Iowlh+e3H76DZrR90VQtNVz8ZaigXn7qL87P7/zsCnHbWvhxdhhGxJ54y1DEZ6tHHlFq2dsQD3ET0Pf/ccK9ohlWCObdw+1AY7BruFGVDIBL4FP7xsvgI9yz668Bp7Hm0s1PlB2xqVzKiQsx/EhXLM/H9i+pCsAVQR+gkDOvt2jPiDSRf0HEZNfi5O7M4TO6zAh8U8WPCugByLHYGq60D7km5lwd7k4OGRaYofI8mbWQx507PxWMtZS0cdOhH7F3/q3UXNnYg/vLCEmr/c6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svlytEmt/2n+FoMbk54oZeVOhG1iyiIXzbQ66p8F/+w=;
 b=awXpIJqyUN9gn5lBkzUbOloHVvrGb/TgxIxMQ4ANvkEk13pFnz4tuMi1QNLudX5dNXQKQoMu2qgKosrYDj2aEae7hs07qc+kcouyXmN6OgsXhZvExWno+fSbJdFIFD0jzF3p2TdcYhLP5eQgqMiYi/qSKyHUOs/5fPlit/7/67y4iZZ0hjDJqG88gJllpoRbpzyIWKuDjcOKoh/mcjjrKWJaqMy1+ckGFUrd8RdjWihqgUdfix/stX8cMzEiGjXyWLvzFoF4u16Wlb9X9s5QmniHwEg/eL2zGikdeyKZZWQdaHF1heeDvR6W+7YlYjGm/HU+o3ToFXBEWXq9TTDi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svlytEmt/2n+FoMbk54oZeVOhG1iyiIXzbQ66p8F/+w=;
 b=KGaNGLrZPH90lPIPWgt79EEpDTjlTHLllzkeSziJeaQvSplU/pBPTxZi9YLXsQfYComyXkhK/UQxM8QDwMo1Q3yFcEVh3BWGA4RsIaodDLVaKoHkDHIhARMf0FAxJdAJfQhn5sCLENYm80coTnDKAnSi0Mvh4dVyuSK8CBfQswTzZRPqlYgBZpigWELcilyN2f5W8Hhix6COEqfhjix4HbmQAsa/Y95Aubm2gKUOsZ9gqKULy2ZLr3WdZqiE1qbx6AzwwBCmIkugdINd3mWLnY2uohfkPZ0plFJSf01RSAwc+LUwnuDo2N31mSikBFVkiR/lDg/nqFgy0Nj2zrTtJQ==
Received: from DM5PR1101CA0003.namprd11.prod.outlook.com (2603:10b6:4:4c::13)
 by MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 13:21:15 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::4a) by DM5PR1101CA0003.outlook.office365.com
 (2603:10b6:4:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 13:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 13:21:15 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 13:20:21 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210608130207.GA2597738@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <754e3546-402c-2a0d-02e8-5d30701f3b94@nvidia.com>
Date:   Tue, 8 Jun 2021 14:20:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608130207.GA2597738@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e2258f9-6215-4714-7315-08d92a804b38
X-MS-TrafficTypeDiagnostic: MW2PR12MB2460:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24604EC12ECD7556F1B001C1D9379@MW2PR12MB2460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCu6bDkOtpN4qmLCLKolUa6LSxzPOHG5xd+QoKG+LGBqkTj/fQPSZBOJG4F2ic6/SDrNZX1B9yd1tJhDz5ZR14ZauuSRFKeORvoV/LwaCsEVR8Vp3dd4UJoOw9UEY7rJyCFyJyZsuo0bFiwBJ9I0l+puR3wZIQXh3zzN03tRCeHKLzY5m+EcvG5ySwTJFQlaTQ9fWWEIO9yhOCNwlN5cDLW5khhj5YhsqeEDof+qVmR9HxEkoHHQ2ecVbZkAq332FiOS9bVSwPA/Wzf/Wm2Hry4aB8ptECWx6aM2UL8rFkBjS+F3jZn9TYfNd10AVR5tqfyrDodc0gSfI2cIyAnpjbYpLw7uGnsvGwpUVlxiAN0irTKF5IxMS8m+NBf2KIqTvB5RtYfMNIFr66LaIpnxNnM4talZZOb4zDL8RCH+FY0f8nsNlENm6h3s7+buI+k3bArUyzAB9brqT/4QrqQSCPxL6NcvXdDlR37NHRo4NzJHifgcODHfWORCnVPVspd4yskTQEJ8KTm6nrawt40ippZWMqvFY6i+VXiPuA5wXxx0kli0lZzrHEe3MRlKWWPjSF6Szlc0quMRZmCJefCd076scGaxb4K5lvWKi/uzQeaZP3vicsOElXwA+MN1KsdJx7lTIZR4aF/FBgFvmry1MOSetQ/PZEMX3izy1kgxBx1FmHBQ0JaoUk3ixGhoVWnq
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(110136005)(6666004)(16576012)(54906003)(426003)(5660300002)(70206006)(356005)(16526019)(4326008)(186003)(82740400003)(47076005)(53546011)(82310400003)(8676002)(70586007)(2616005)(7636003)(2906002)(31696002)(316002)(36860700001)(36756003)(8936002)(26005)(31686004)(478600001)(336012)(6636002)(86362001)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 13:21:15.3808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2258f9-6215-4714-7315-08d92a804b38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2460
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 08/06/2021 14:02, Bjorn Helgaas wrote:
> On Tue, Jun 08, 2021 at 08:44:49AM +0100, Jon Hunter wrote:
>> On 08/06/2021 00:50, Bjorn Helgaas wrote:
>>
>> ...
>>
>>> My understanding is that we want pcie-tegra194.c to be:
>>>
>>>   - Built into the kernel when CONFIG_PCIE_TEGRA194=m or =y and
>>>     CONFIG_ACPI=y and CONFIG_PCI_QUIRKS=y.  If we're using the ACPI
>>>     pci_root.c driver, we must have the MCFG quirk built-in, and this
>>>     case worked as I expected (this is on x86):
>>>
>>>       $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
>>>       CONFIG_ACPI=y
>>>       CONFIG_PCI_QUIRKS=y
>>>       CONFIG_PCIE_TEGRA194=y
>>>       CONFIG_PCIE_TEGRA194_HOST=m
>>>       CONFIG_PCIE_TEGRA194_EP=y
>>>
>>>       $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
>>>       $ make drivers/pci/controller/dwc/
>>> 	...
>>> 	CC      drivers/pci/controller/dwc/pcie-tegra194.o
>>> 	AR      drivers/pci/controller/dwc/built-in.a
>>>
>>>   - Built as a module when CONFIG_PCIE_TEGRA194=m and CONFIG_ACPI is
>>>     not set.  In this case, we're not using the ACPI pci_root.c
>>>     driver, and we don't need the MCFG quirk built-in, so it should be
>>>     OK to build a module, and IIUC this patch is supposed to *allow*
>>>     that.  But in my testing, it did *not* build a module.  Am I
>>>     missing something?
>>>
>>>       $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
>>>       # CONFIG_ACPI is not set
>>>       # CONFIG_PCI_QUIRKS is not set
>>>       CONFIG_PCIE_TEGRA194=y
>>>       CONFIG_PCIE_TEGRA194_HOST=m
>>>       CONFIG_PCIE_TEGRA194_EP=y
>>
>> The problem appears to be that you still have CONFIG_PCIE_TEGRA194=y and
>> CONFIG_PCIE_TEGRA194_EP=y above. If I have ...
> 
> Huh.  I can't set CONFIG_PCIE_TEGRA194 directly; it's only selectable
> by PCIE_TEGRA194_HOST and PCIE_TEGRA194_EP.  PCIE_TEGRA194 is
> tristate, but apparently kconfig sets it to the most restrictive,
> which I guess makes sense.
> 
> So I would expect the shared infrastructure to be built-in if either
> driver is built-in, but it's somewhat confusing that
> CONFIG_PCIE_TEGRA194_HOST=m results in a builtin driver.  If I can set
> CONFIG_PCIE_TEGRA194_HOST and CONFIG_PCIE_TEGRA194_EP independently,
> it seems like they should *be* independent.
> 
> What is the purpose of PCIE_TEGRA194_EP (added by c57247f940e8 ("PCI:
> tegra: Add support for PCIe endpoint mode in Tegra194") [1])?  I don't
> see any reference to it in a makefile or a source file.
> 
> It looks like one can build a single driver that works in either host
> or endpoint mode, depending on whether a DT node matches
> "nvidia,tegra194-pcie" or "nvidia,tegra194-pcie-ep".
> 
> So I think PCIE_TEGRA194_EP is superfluous and should be removed and
> you should have a single tristate Kconfig option.

This is a good point.

Sagar, any reason for this?

Jon
 --
nvpublic
