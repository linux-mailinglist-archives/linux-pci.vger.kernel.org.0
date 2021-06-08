Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7139EFDB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFHHqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 03:46:49 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:29793
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhFHHqs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 03:46:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1Wa0fbLsn4Iys6mLtA/WV6iBrGL0iNhFH+L6p1M9pbj1qfN9yCNoY5PX/ThgRdJjw/SOe4UOHdG+6+UuAl9MOPrceRtLH+1icz6DyyuafGjcGZFZlJX5FEGGraLbOLfLxYjlAZKI0CFlXh2/s/CeMK1wTeSZX5ofic0tvrKuwh5QieOmx3R5t08fyaKD0h6VezZJQfqX31UhPpCL2WZxEGMFodyS/xEQWDxKJIHq8mBxOtL1WocO0CW72+kyAXcR7n7M0c/iZ+7h9TVNPO18n6n7AQCl2U4f9P4nHv2joHE3LuOw46vp3kVyoGqV2cda6cY2spzgmJyn6ZrfYNj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxKCVRc+zKzeVDSUkJ96rigFjD3cgfYReWD8eTVYb3g=;
 b=fJOhQBvl/xItMbbYJbac5sv6DzdiuCGqEHI7UffLpSRZBSTax4qqiwi8BiuGJa6/wlRmBv9n+h/KCzncb5fgk64fnaHGCdDmocfwZDWsqeA35rm0jVPzHBCewctKASRa//fC80cML8KXhZQrzfsdZpniJNqpslcisD0sqrbhjHbvf45lr4EaBqqveyX8otoBTQCrcy3qI8dhGKHFQkILKVChBdUBIey5AECyhIrmX8IHz9m63rKYluc9WRh5sSjpOAdxtYxJB7H0RyWmtgNC3ALx6n/isbSLknrIhuS39Tw7v7mIqSjgBf7m53WGgLAoamMkxdacRuFFY9F5HYLDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxKCVRc+zKzeVDSUkJ96rigFjD3cgfYReWD8eTVYb3g=;
 b=TRRyNoqeU9bHl32btNI5wwvWxQG+DJ3mKGCn/TAPHnkS35Vl45ZN1F2ve9Cdb0KdnRh7smCwPfNVA9m5Olb7Pco2rHHGPo4vHjlUMOuryhWX6lg7H9OKqIbeJOA6iWTYbQ0fQxMbJm4Jsa4AoLcXWnklH0pLjcOlAbr4bd9A5UZuBJwBRipqdUuHWw2dGAg6jPd34DDdierlYeEoBrOLVRivbVfORSMz6Lze9dxhBeYzJWBoAYO5Smec/cF2/VsYMzANPDp9WLgzJyo7RTChliNDLQwPyvlguUR0cXyNVFxWipWDecQztgnsk3XwIEw5oZ2LgF3GPViFUsXUm/MH1A==
Received: from BN6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:404:121::27)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 07:44:53 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::a6) by BN6PR18CA0017.outlook.office365.com
 (2603:10b6:404:121::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Tue, 8 Jun 2021 07:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 07:44:53 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 07:44:51 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210607235036.GA2549845@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4aecc0f0-692c-026b-f1dd-0a03ccf4312b@nvidia.com>
Date:   Tue, 8 Jun 2021 08:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607235036.GA2549845@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3d9a4a-9c89-406e-4091-08d92a514de3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13815C26477EFF34A9651840D9379@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGcY+BG2k2EmUDYm3a27gOTK2Wc8M7FWEVoKeig4p7+h6F75ftFaF7H/ai18x4G7d+JgYWwoR8xZ0zrpXD0+XnzobFFXugdZGJZTMkUPHBNV5dV0diWlzSd+C1qXMW+2wL09eOWJbuow3/Sd5++K6FYMcp6l8e6QTuOp7jx/D2QAUqdXERV74zmf3hiCexhsdOz2sP6eUhf9d08CYoW2K8PjpW9131hCbMwNXuDWyWLmKmIVdkzgb64AMwZqell4JBoflY9yjq1Ae4pk/3q7bvKEYeExSKCeV6Xwk8Jw4q1WVdQ123irY7WoWz4XxT4QiKvGUBQjphs1OzNdpZxMBQf8BFo4FJeqXY3+x3g8rQfJ2TWjLINTZ9aku9rEwGEOyULa32CczaxDWgPW+TDVkt/FK+dkfQQyPH6xLCl4Zmh7jcqEwKlifQjqECPPJ5kiEnRz5jVXMuk8UfHzByDbHH3fTclhEFNyer11ZjKQmuQNuwC1TWf5o5GUNrR/tRm3ZEhAOq+0TfuDQRgmdQgns/IMxrBWLAgmrrASujpa9E0WUic9H1DJHM36+IQb3Sv1kJWvQrsMujw0a9NLzgRgq8aqf6zQJStU0/H4kshHjxx7SqPFfUv+rSE4ATba3f45cRUN82qQKZJjVWnuvSdyEOnYuKmXx7IDyFDrOBp+h5LhJWXoWCqO0RIOGYS9apJN
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(54906003)(4326008)(8936002)(36860700001)(36906005)(70586007)(31696002)(36756003)(186003)(336012)(16576012)(82310400003)(70206006)(16526019)(6916009)(53546011)(47076005)(356005)(82740400003)(26005)(426003)(478600001)(5660300002)(2906002)(2616005)(7636003)(31686004)(316002)(86362001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 07:44:53.5263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3d9a4a-9c89-406e-4091-08d92a514de3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 08/06/2021 00:50, Bjorn Helgaas wrote:

...

> My understanding is that we want pcie-tegra194.c to be:
> 
>   - Built into the kernel when CONFIG_PCIE_TEGRA194=m or =y and
>     CONFIG_ACPI=y and CONFIG_PCI_QUIRKS=y.  If we're using the ACPI
>     pci_root.c driver, we must have the MCFG quirk built-in, and this
>     case worked as I expected (this is on x86):
> 
>       $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
>       CONFIG_ACPI=y
>       CONFIG_PCI_QUIRKS=y
>       CONFIG_PCIE_TEGRA194=y
>       CONFIG_PCIE_TEGRA194_HOST=m
>       CONFIG_PCIE_TEGRA194_EP=y
> 
>       $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
>       $ make drivers/pci/controller/dwc/
> 	...
> 	CC      drivers/pci/controller/dwc/pcie-tegra194.o
> 	AR      drivers/pci/controller/dwc/built-in.a
> 
>   - Built as a module when CONFIG_PCIE_TEGRA194=m and CONFIG_ACPI is
>     not set.  In this case, we're not using the ACPI pci_root.c
>     driver, and we don't need the MCFG quirk built-in, so it should be
>     OK to build a module, and IIUC this patch is supposed to *allow*
>     that.  But in my testing, it did *not* build a module.  Am I
>     missing something?
> 
>       $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
>       # CONFIG_ACPI is not set
>       # CONFIG_PCI_QUIRKS is not set
>       CONFIG_PCIE_TEGRA194=y
>       CONFIG_PCIE_TEGRA194_HOST=m
>       CONFIG_PCIE_TEGRA194_EP=y

The problem appears to be that you still have CONFIG_PCIE_TEGRA194=y and
CONFIG_PCIE_TEGRA194_EP=y above. If I have ...

$ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
# CONFIG_ACPI is not set
CONFIG_PCI_QUIRKS=y
CONFIG_PCIE_TEGRA194=m
CONFIG_PCIE_TEGRA194_HOST=m
# CONFIG_PCIE_TEGRA194_EP is not set


> 
>       $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
>       $ make drivers/pci/controller/dwc/
> 	...
> 	CC      drivers/pci/controller/dwc/pcie-tegra194.o
> 	AR      drivers/pci/controller/dwc/built-in.a

Then I see ...

$ rm drivers/pci/controller/dwc/pcie-tegra194.*o
$ make drivers/pci/controller/dwc/
  ...
  CC [M]  drivers/pci/controller/dwc/pcie-tegra194.o

Cheers
Jon

-- 
nvpublic
