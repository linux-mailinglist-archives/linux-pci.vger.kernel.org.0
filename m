Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551583A708F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jun 2021 22:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhFNUkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 16:40:04 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:36065
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234143AbhFNUkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jun 2021 16:40:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDSrzxUT7ECcULkfxJm4ogr1gMQnMlAoX392OxcspRX3hE7LFlEG1/AspzAlCdTnuqrFXYUMRtAj5VKCWMDxCmQCCwYX70r80BlEWh4RNeUxi/RUXaBS7rzQtMyTxTYasT6L/cXQzciPsuHzfW+e8wGfdRI8PykGgtnB43p2Cmzw4YWwWFfH9lr7cfCAcgpIBvxOnxRyWO/0YlgaJM1X75RbagVeJfrOVNtxg51OsONuXevxrWDQKmezkE/qls43+DW8IG2GIo7V9tXYfvuzLrDHwQqK6vueRU90bVr2cTp7ElZE3mG6Y0/eZ8EoxRcNLhcaUAZSi3zB7UYGlgzHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM+FlrhIu8J+wwzbmhRP0xo0eFY3P2tvyBw9xQhw+gI=;
 b=HcESkRxBrdhP4vx6QRfUpwZqAc0RDtUDC4+EAoCsr4b4ONZ33ga9vEJtZWRyYXHTOn37wSr/Wubb59W9OdxqMTtk82wOxoIHA4nvbs5ndZoiocybfIFW76TYqGq1U8mQR62AEyAbNGDNF9I44/T7VKUa+KHRBqvh8qBwCOPK7py6u1Xm0Po/ysAybs8ICEKrcJCwjWi0ERf+/M9/NR0Ga0/AP2doDOFHlBBdmvoh4+dMQu0mRTmhLqII6i3M6LhZa0Fk/Mw/zT40eTkCrJ0ZLA+ZyXOYcRESdAdYt5mqUDeTz5HOVKQMQ/eXjUrp+OYoUAQ+SGKfRaLh9xH32Jyx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM+FlrhIu8J+wwzbmhRP0xo0eFY3P2tvyBw9xQhw+gI=;
 b=H+BqTZJoawbbxsdd5yuhInwxGCz2sOu6cqIOkX4CCHZbk8Mjv3R1Iv4MIXkuTdGLTGXH9AHXLrG9Wr+uwxOUlZx78pbJbacR6sbKfGcrHjU2WziM6orxaLSkyVyWFGx0Ct34ZgB4L+tPv5w/BuWQzgyWvC4oO0af+6yvxEgrxV2d3LrcRt7MWW8QmC3heWOTVFQ7JkWP9iCc6sxxhQ/ZcQ1f9NDJ+2+Z/SZkLB5QCdEUOuMFWmScWUx9+0JKLrEQ0rQCgxyVMYiQJfYmHi05XCYJ/yacGi2DXPuuYQ2XjZKSBymzqxYtlhLfE2l1exxpWCejnffuBHfxg8/OGX3o7Q==
Received: from MWHPR20CA0004.namprd20.prod.outlook.com (2603:10b6:300:13d::14)
 by DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Mon, 14 Jun
 2021 20:37:59 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::3) by MWHPR20CA0004.outlook.office365.com
 (2603:10b6:300:13d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Mon, 14 Jun 2021 20:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 20:37:58 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Jun
 2021 20:37:57 +0000
Subject: Re: [PATCH V4] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20210610064134.336781-1-jonathanh@nvidia.com>
 <YMHWNusvLtwKWlQe@orome.fritz.box>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ed4a5e2a-d6c8-099c-5b1e-70b31daa8f8e@nvidia.com>
Date:   Mon, 14 Jun 2021 21:37:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMHWNusvLtwKWlQe@orome.fritz.box>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a535b1ea-664c-4013-da16-08d92f744c26
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3852B1AA569339D4113DB9ECD9319@DM6PR12MB3852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crD5Q4+6fLaR3Mb/dFz5ZbpB7U4+qbEyEpVlea3uZ6uhKvRn90KBIzSlMyFjXhfqRI+ocvI7paQ9e/v0wMCf6eL/YeLK0LBm0C1j0d2UM6LqB2isRmupKoYPbdmabVyCDbSz6RcKWBLxfWGdTdZ1xQ+xdpAFr6HeA0C4IQwMjDIZfq3A8J9FkC2mLuhg5ZCky0buIJpQEm4fUCxU+Y1o1Qg+o9fo5g83ZmdcZ23h643341lGva+lbvYFV7b/76ahvUd/8+r5uBH9l6YPMufy6X7Acehgo2gK60bkcUmCswcbb1h6thmvE/og7GtuNVy5ouK6ole8ACBTnWLzfNFdnHo5BtovtT3H2ZuN9gcAlxFU3un9cShhpeAFY8LQA5tnqQ3opFD0Ofcx21dcIixsOjMHecVn07/zz1uGToHGYSxAHKZLwHOToRJ4gIiVgunFckjhOH8HoO0DasAnDx4rYS+Zq1xOeM44CcceNbfKF/ZPd5r/BzxW74Y/4M1roulw3ECgr/OEOZZhD75PVPmYmD1e3wan82CniSRMAqLw/J3f1Gvvl/2GEEtbQzH7/CePvOH8w0g2QEmhSw4qF/1zauCw+3q+wFHTiPVKSxmYPAZGuGN/vVTTmDmaPdz+WYwfmZ9a76PvwDAw5SyWSP+vP70MBfUvXUQUaVtfUUXyvY0wVnjh97dUd9iqLKYOC9QE
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(8936002)(16576012)(426003)(31696002)(336012)(110136005)(36756003)(70586007)(47076005)(70206006)(8676002)(5660300002)(7636003)(31686004)(6636002)(2616005)(82740400003)(82310400003)(6666004)(54906003)(478600001)(83380400001)(86362001)(53546011)(36906005)(2906002)(4326008)(316002)(26005)(356005)(16526019)(186003)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 20:37:58.8862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a535b1ea-664c-4013-da16-08d92f744c26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Lorenzo,

On 10/06/2021 10:07, Thierry Reding wrote:
> On Thu, Jun 10, 2021 at 07:41:34AM +0100, Jon Hunter wrote:
>> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>> errata") caused a few build regressions for the Tegra194 PCIe driver
>> which are:
>>
>> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>>    was caused by removing the Makefile entry to build the pcie-tegra.c
>>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>>    so that we can build the driver as a module.
>> 2. 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>>    errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
>>    driver. But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
>>    module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
>>    (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
> 
> I think the correct way to write conditionals that are true on =y and =m
> is to use:
> 
> 	#ifdef IS_ENABLED(CONFIG_PCIE_TEGRA194)
> 
> but that doesn't fix the issue of not getting the quirks included when
> CONFIG_PCIE_TEGRA194=m.
> 
>>    driver. Given that the ACPI quirk code for Tegra194 is completely
>>    independent of the native Tegra194 PCIe driver, move this code into
>>    its own file so that it can be built independently and we can remove
>>    the "#ifdef CONFIG_PCIE_TEGRA194" in the native driver. Note that
>>    given the native Tegra194 PCIe driver is only used with device-tree,
>>    this will not cause any conflicts.
>> 3. The below build warnings to be seen with particular kernel
>>    configurations. Fix these by moving these structure definitions to
>>    within the necessary guards.
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
>> ---
>> Changes since V3:
>> - Moved ACPI quirk code into separate source file
>>
>> Changes since V2:
>> - Update the commit message per Bjorn's feedback
>> - Moved the structure definitions within the necessary guards as opposed
>>   to wrapping the existing defintions with the appropriate guards.
>>
>> Changes since V1:
>> - Added fixes tag
>> - Fixed 'defined but not used' compiler warnings
>>
>>  drivers/pci/controller/dwc/Makefile           |   3 +-
>>  .../pci/controller/dwc/pcie-tegra194-acpi.c   | 108 ++++++++++++++
>>  drivers/pci/controller/dwc/pcie-tegra194.c    | 138 +++---------------
>>  3 files changed, 128 insertions(+), 121 deletions(-)
>>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194-acpi.c
> 
> We've had a similar problem with Tegra210 EMC and the EMC frequency
> table parsing code. The EMC frequency table parsing code needs to be
> always built-in because it is stashed into a linker section. However
> we still want the driver to be able to be a loadable module. The only
> way I know how to achieve that is by splitting up the sources files
> like you do here, so I this looks like a correct fix:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>


Just a reminder that we need to get this fixed for v5.13. Please let me
know if you have any more comments on this fix.

Thanks!
Jon

-- 
nvpublic
