Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD039E660
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFGSVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 14:21:07 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:58208
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230333AbhFGSVG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 14:21:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guCWbo+axKDCnxWODTfB95Js5cDt799eQ6pTPJDCKXaiVESxRewnKGRRvdkdpaX9zCEo4Kz2h8yCRsn81Jl9efsjn54ZGg+A2RAJamnPkN/AQ4p3b4EVRrormUhHQUwM8zycN2DWdqc8vOOX2BmSiGTIi4Ov/fjofRrYlTb0l9G8I9nhLvpSwQrEl+vU6ROQlRVkmUvTKpDhnICYwBwDjjzNbTEgrZf/ZbNPzXlahYYgeYyJoesFHV1geRtPxg0URYnL+XNXv+Tccc+4hMof7pF9qN+4POKw5uIZhaDLMQx1U7X5La7H8xMFMVGRrVO77QccFos9qElEXBmup3oVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN504FY98AKYqF2OO0Zq7Q97VdjfmU96v+dxFtu7oPA=;
 b=I97/1cNCVvJuA4GZJYI3PxIOIuCxW6JWEnvvq/ggYJPHzo/MEejQhkrRUDiHBfkCMi7sVtuTZqkFk6L+t4ppeMc22GaB8bB2HfwFctm2ds7PgJXN89esrLnh140Uxj421QqMfLS5hFfQSzZTUUnB+WIiSbV49qipGR6JpA+73tQMS7hYC2CYxoM4izhybfHo3tKDitWg2sYSRX6kJW8+M34ASkHmX6D0RjuMVoJqx/QdYRX3bPZPNf0Y7jSBbkzAN1hbLWa+X+G7t8UFTqljs8BGNw/R4rahja3iNTwpM26kPXGPXUfP6MlwIK59BI+wNkGRzFK1OmjJuQ34DwIcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN504FY98AKYqF2OO0Zq7Q97VdjfmU96v+dxFtu7oPA=;
 b=gUGl0TwdYxJfp0fHeE9jqjAq4Xmz659MckRMBXg29ATsShH+TXzszHldQQEDw7TBl/iNHSCgYHB+M59Uu3u43KBIkLRYYDEVDRmAjJOAyfVaEpyU/GxaHiQfehRkTMjNh3o0dSFhIpBCohjRgfDP5Vk4Si1HURnHAGLWIgmHFGq2sEBWMdUeIRecMb/431UfRIyfXYTbCSUfnCHO+aNZ1mPb7vK+acRBS+x5EVwOxXnHnvmqKBqIOQK5Tc4YDD0KSgT8P8V96KPMSmuTeCuJRA/q7j6OkoI2dTxwjgqUajeRcXhRbKbaKNCTn+cnw8tyLBj0kkPgppy/iXHfCSH6wQ==
Received: from CO2PR04CA0157.namprd04.prod.outlook.com (2603:10b6:104:4::11)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 7 Jun
 2021 18:19:12 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::64) by CO2PR04CA0157.outlook.office365.com
 (2603:10b6:104:4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 18:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 18:19:12 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 18:19:10 +0000
Subject: Re: [PATCH V3] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210607171842.GA2507565@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0457da33-3ddd-2234-1d09-20d5537b8993@nvidia.com>
Date:   Mon, 7 Jun 2021 19:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607171842.GA2507565@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50a92c0c-250c-454d-a8dd-08d929e0c06b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4419:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4419B784197DB8AAD67E8DB8D9389@DM6PR12MB4419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDsbWxA3CvpnDgM35WYnGYolbkbSH17VirNbcGpsp/PUs7sdeE9yRGEOQTQBPXYAj7oi6pMloGFf8idGvDMBT5JrLZW/qc0a8kUxcQ3kQJ6D4bjsG7Gc5lu0CTekiUrrVug3g22jreMu2hxXIOE0Tzp75UABAkoi5qDCViF8kzP0TW+SBvxg6S6vf4658Fy70m3RsoH6F60ul8ormgpS1xS5L1HQidTYUU4/MkMxTYkFib6/rz5gMU2eVzcJ7yjKhbXKT9E/ercSyEEixuboR5Ur07zFTzsOLZQFCqTjaR8YVMKe28ytioHkppfqwcSNPuyJBAFxD1tp6KuN2mcK51W7GVNh/tUUcSlnP/jgWnlyE7N8jCJaHaWvWllpobpKNmNpBJBXI8Oe0i/HWjz3ysTr0F2IBTYELa936ONKeoxAX5p5Vu0utSvvIWLrEfaaM2b3o3QmUSqRE8NTfW/zuMoRTPUoVVW/7il71+bLYBYqEbhK36IsmQDQ24pO2u3fumH3FUOcQ40gmLq4vAvHwVMr3KY9rgqKigtwsFWwFY1I9oEt3KlBD4mQ9W6RGPHRCu1nGEdhxGtFGFuS+vQ9cnYosftEXg3ens0Ug3+ZqYof+TMDC/zQ4vL7RdYZ4D+m6mfrvuTa0ni8bYwiw1nFIy8aWLflVm0pKUvr/chOmQxSBlke3PROg7so87B64Czv
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(16526019)(356005)(31686004)(36756003)(5660300002)(336012)(8676002)(36860700001)(47076005)(478600001)(186003)(86362001)(7636003)(6916009)(16576012)(2616005)(36906005)(4326008)(31696002)(70206006)(53546011)(70586007)(54906003)(83380400001)(82740400003)(82310400003)(316002)(2906002)(426003)(26005)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 18:19:12.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a92c0c-250c-454d-a8dd-08d929e0c06b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 07/06/2021 18:18, Bjorn Helgaas wrote:
> On Mon, Jun 07, 2021 at 04:50:34PM +0100, Jon Hunter wrote:
>> Hi Bjorn, Lorenzo,
>>
>> On 26/05/2021 13:33, Jon Hunter wrote:
>>> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>>> errata") caused a few build regressions for the Tegra194 PCIe driver
>>> which are:
>>>
>>> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>>>    was caused by removing the Makefile entry to build the pcie-tegra.c
>>>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>>>    so that we can build the driver as a module.
>>> 2. 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>>>    errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
>>>    driver. But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
>>>    module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
>>>    (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
>>>    driver. Instead, use "IS_ENABLED(CONFIG_PCIE_TEGRA194)", which checks
>>>    for either CONFIG_PCIE_TEGRA194 or CONFIG_PCIE_TEGRA194_MODULE.
>>> 3. The below build warnings that are seen with particular kernel
>>>    configurations. Fix these by moving these structure definitions to
>>>    within the necessary guards.
>>>
>>>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
>>>   	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
>>>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
>>>   	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
>>>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
>>>   	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
>>>
>>> Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>
>>
>> Any feedback on this? We need this for v5.13.
> 
> Thanks for the reminder, I'll take a look at this.  It looks like we
> broke this in v5.13-rc1, so we should fix it before v5.13.
> 

Thanks. Yes this is needed before v5.13.

Jon

-- 
nvpublic
