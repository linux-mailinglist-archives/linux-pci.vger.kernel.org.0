Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E333A947F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFPH6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 03:58:31 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:6369
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231751AbhFPH62 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 03:58:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1lzKJ0f+ELA6saM8fsMlOapifooVNXosILQbfuz4YmJDNUouLynOpBsio/5F6BhkXZhfLbjLFARtPQBnOTtwL+PgDSr6ESe7Dd5nuE4HrZ7G9AA2pek0/4qNftlbi/Z6bC3IYT7/jDh7+CZAmgn+xS89HpNCc8Ped6VbF8QWSaiCVJ4sT7Oe445mj9FPBio/1kYVZ4H7jeuaRF5bWFLZ7CJzmxlr1P7/J8bXGkl5yMaMn5rvJZhravsMwiNfpS7R/Ah46WUT5XD6G2pvwDPyc/laXrFWjXQrUWHaYC84gKr5ZvpZ2ZFC+/4NHATfSxcs9zbvZXHifrTERAK0VhxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLEvQqKJoJFJwBLNjCp1BMi1n1NgJ8oxepE+GqOml3Q=;
 b=kifyOtH1KciEywU2itpbn+q0R+8D4SgLma6mkEeQl9sU2MtGapUddm88zyRfxvh6El+wqNTG79hD7IRFRsCx8HWf073PQnMWwrHcU1thSomND8runTSeawbJWPG4xfr6X0tyDHeeuZaR194mwVONutHYhZLjyq570xsG/pK35npISD0mx5Jj3mSDK544lukRehkurykMLm9So9IZ/+Uf4cZe8tqbUHiD/BRbI04O/Sqlb2ooiqiJw78wdb/wYdo4NI99Ew1QtFjxJxc+n6vNrXn8ck3Zx8CAuNI1vrTvk0xOsaJdmtZGdKA8D4SzaxL8kLi3FhZieV4IJMicmsFqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLEvQqKJoJFJwBLNjCp1BMi1n1NgJ8oxepE+GqOml3Q=;
 b=mcEtSQT65vurMKcYzwagJZr+p0I9ik0z07cDOYZ4qdT+u0/N+zeq47XorUiA6JBsXlZmt2O5t3JKb7ERupeA5OKEb4TF11FYoT87gxrGsj0GfUEjXMuPAYMNTsnZAs2K1pki+zoSeqDEDI762cLEg6h6X6s9Xt1y6QrnQt/Cyru65kvpusQZP0/HcyiNwbW4io4j8g25Ry+SmAL5h+/1y1OPdnqWVAWTUGHwG/96XY1z30b3dFGlgn0xtU3GLuvbYcB0esYzlieZzpJypMlkFxLWA4yDwA5oNoYEA2hjC2Y2ia/3WcDDr+7bp5MmuH3I/l5RxzcEGHg24TfGqdUKMQ==
Received: from CO1PR15CA0113.namprd15.prod.outlook.com (2603:10b6:101:21::33)
 by MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 07:56:20 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::af) by CO1PR15CA0113.outlook.office365.com
 (2603:10b6:101:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 16 Jun 2021 07:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 07:56:20 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 07:56:18 +0000
Subject: Re: [PATCH V4] PCI: tegra: Fix building Tegra194 PCIe driver
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20210610064134.336781-1-jonathanh@nvidia.com>
 <YMHWNusvLtwKWlQe@orome.fritz.box>
 <ed4a5e2a-d6c8-099c-5b1e-70b31daa8f8e@nvidia.com>
Message-ID: <3b84d3ba-37e0-8672-7604-5bfde17be10f@nvidia.com>
Date:   Wed, 16 Jun 2021 08:56:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ed4a5e2a-d6c8-099c-5b1e-70b31daa8f8e@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8c786e8-9b86-47dc-7936-08d9309c3a89
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1663D45A4512E8405B9AEE59D90F9@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TO0A8VhtLbny4ZkYSHmoKBAAnHc9SrHLxrJilSPzgBnIHeYqDx+uSV4vUD/5GX+xSbqdXvfRZfgVjKmACy6pJsIsEw7w+haOP8WulPXFsA+kd6wl52PilqTtBeItmBELJb/wpjmuwpJRMMN1Twe51AMeOTHdT4EzoNVg/6b51UBAg/0lFsTIZE56n8stJealGVbMMeoo6CK+7E85iYmMAIIg2QS36N5l89JwKO0sh2yHxV+ZZAcubsB1J/2j280GPMVeEEDix68cxKTKHkJwWrFss6denQr/Z+4/AXm5x7whm5UrxUO5fJ9PDlutj25W8U5f7NGhpXQfCmsm5oiGMcs1Vcg91lc+O0JtMkBhqu+uNZVbU0z/yVvuVbdy0aUqVaLTtI4B0VqcFFNuNHqmo73erqk8mq9RvueW6p7nAjEK9X8Thdgg+p69obaFXuSCPfx5MH23ocKfc5V+wM2hC1bA4BQ1Mztunu4WpVTkgULEcDoiyeZJcDCK0u7N0olAP1LVA3BpZEwUghUys5mRwUGxmLPFxSWgzCo3JYOuiFc0JjE0cko2ihbbgCQQ+kgN9HkaL+OPTI4XYXDPLcFCoI3y8dVPkVkla1lzWaIsMBJtk/HB/91ihHr2rtMpYcpnbOOr+l1cJ7FNRJ6LD8GoY/tbPKz1U5kR4C+YgAv4wBuUdG3CeW6YjFZ+fSS1PIRF
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(2906002)(36756003)(4326008)(31686004)(47076005)(2616005)(336012)(16526019)(186003)(54906003)(31696002)(82740400003)(8676002)(36906005)(86362001)(316002)(426003)(356005)(70586007)(83380400001)(7636003)(107886003)(110136005)(5660300002)(478600001)(82310400003)(53546011)(70206006)(8936002)(36860700001)(16576012)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 07:56:20.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c786e8-9b86-47dc-7936-08d9309c3a89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding Bjorn to the To ...

On 14/06/2021 21:37, Jon Hunter wrote:
> Hi Bjorn, Lorenzo,
> 
> On 10/06/2021 10:07, Thierry Reding wrote:
>> On Thu, Jun 10, 2021 at 07:41:34AM +0100, Jon Hunter wrote:
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
>>
>> I think the correct way to write conditionals that are true on =y and =m
>> is to use:
>>
>> 	#ifdef IS_ENABLED(CONFIG_PCIE_TEGRA194)
>>
>> but that doesn't fix the issue of not getting the quirks included when
>> CONFIG_PCIE_TEGRA194=m.
>>
>>>    driver. Given that the ACPI quirk code for Tegra194 is completely
>>>    independent of the native Tegra194 PCIe driver, move this code into
>>>    its own file so that it can be built independently and we can remove
>>>    the "#ifdef CONFIG_PCIE_TEGRA194" in the native driver. Note that
>>>    given the native Tegra194 PCIe driver is only used with device-tree,
>>>    this will not cause any conflicts.
>>> 3. The below build warnings to be seen with particular kernel
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
>>> ---
>>> Changes since V3:
>>> - Moved ACPI quirk code into separate source file
>>>
>>> Changes since V2:
>>> - Update the commit message per Bjorn's feedback
>>> - Moved the structure definitions within the necessary guards as opposed
>>>   to wrapping the existing defintions with the appropriate guards.
>>>
>>> Changes since V1:
>>> - Added fixes tag
>>> - Fixed 'defined but not used' compiler warnings
>>>
>>>  drivers/pci/controller/dwc/Makefile           |   3 +-
>>>  .../pci/controller/dwc/pcie-tegra194-acpi.c   | 108 ++++++++++++++
>>>  drivers/pci/controller/dwc/pcie-tegra194.c    | 138 +++---------------
>>>  3 files changed, 128 insertions(+), 121 deletions(-)
>>>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194-acpi.c
>>
>> We've had a similar problem with Tegra210 EMC and the EMC frequency
>> table parsing code. The EMC frequency table parsing code needs to be
>> always built-in because it is stashed into a linker section. However
>> we still want the driver to be able to be a loadable module. The only
>> way I know how to achieve that is by splitting up the sources files
>> like you do here, so I this looks like a correct fix:
>>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 
> 
> Just a reminder that we need to get this fixed for v5.13. Please let me
> know if you have any more comments on this fix.
> 
> Thanks!
> Jon
> 

-- 
nvpublic
