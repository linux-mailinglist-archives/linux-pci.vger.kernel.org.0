Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A2373EA6
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhEEPhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 11:37:15 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:29024
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233562AbhEEPhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 11:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRB68q/ksEusIlil9ufzVGybacMKfg5ceDFc9dbp2iRmgdV85JRQ1d0EEOXUDg4fGEuGKmXUfBmA8QmSwgUmH2BzOcN5OPWUQX/cdECeCtXBbhpjPLNpWwlwdzCN2hEU6IfSb6eSy8H/UTAVRSo0QeDOOMTqzcc8swzc7oS0wYRlhuev4xod7P26pYh1b81vdJ73O0RqSuqbQF97ppEOlUyVlmWgFvNjVCKq6v0cmUsaCtmMm5pDx1e10xJV+//echAhOrQSyce3huvcP5RN9Mcye+CiNng8A4ddUEleYQSdcPkyfVaR5QR95PWbfXQjDquKMTQ2ORSqCqTBTWGzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu0M/4y0uKzB3qtF2vnpc7nGT0VmSbl4FC5SfufD0qE=;
 b=V3uOuXiizB1macOKFHYB9a9VmfhdvtSrS0qjLCAvJtFFrUyFAelKNJK7ngpsjFrM5CODr+2+dXq7SZjxaxdIPjfcmBIb5glKpJJo7ooxDnzP4Me0lEz01Tpj6SReJH6gGzLsCT4sMdKD+w6TY9zy63NQb/oXiT8KSgIx8xIHV4OX3jhmQdNh6cn3DoTRhPV+73Xr7zHQwCY515rhcq3b0LFSsVGHmtVEqjWTDfCQcHPqNAKwK0eBJyOVdJSNPwrN4I9sHm8t0qBSu2fMm9w7hHxFkDqZo+LRvhrzXTHfhC6zkM/CEr4Prk6ErpWrY9SCTOYtfzICpzfJyIvO5Xlh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu0M/4y0uKzB3qtF2vnpc7nGT0VmSbl4FC5SfufD0qE=;
 b=ZTfqm/DlhWedXLhRdoSvTHjHgXY7RzbBbfVyLH2Sz+m6WPv3MAP9MLV2yxCNhdTUwzRsde2Qu7fCsEDcOSWd2ddUr8Q6+4Ti3deGEVbYKYFQugZ9OcV6dLC8RB6IsqHQMBxOzb/VG+KUYgXtLAp8Ze8btepub6NWfMq3HskSG2XpUmCkQeWx3b7R7K7zCtk7xxyXaXiXbAEcWSLNwUtY8SXY+hIG+SdY9gj5JhVPyV4yP9atCFRtV8Iq6pptrhm+xB/gWtXnvEtjxILeAoH6ayIq8kDVcHPamwFUTZBWr6XTMM0v0BRYyDrTxP5CHXpTIdvdkjXk5EmXZH2sZOSwCg==
Received: from BN6PR2001CA0014.namprd20.prod.outlook.com
 (2603:10b6:404:b4::24) by DM6PR12MB3689.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Wed, 5 May
 2021 15:36:17 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::94) by BN6PR2001CA0014.outlook.office365.com
 (2603:10b6:404:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 15:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 15:36:17 +0000
Received: from [10.20.23.38] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 May
 2021 15:36:15 +0000
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
References: <20210430170151.GA660969@bjorn-Precision-5520>
 <52c89d4e-6b26-6c56-d71e-508a715394ab@nvidia.com>
 <20210505121501.54dlrussyk7kij5d@pali>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <7519c44f-8b78-6f1b-1ef2-7e095c048696@nvidia.com>
Date:   Wed, 5 May 2021 10:35:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210505121501.54dlrussyk7kij5d@pali>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 418792e2-78e7-4291-4c8e-08d90fdb863f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3689:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3689ACDA695440EA7D1D9E13C7599@DM6PR12MB3689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cp3ioc3VGF+JydYFOOy0W3nGGrkPiH1O+pXuNhM6TMbRjA31ewpJxz/2vzAOUiB8BMEP78HIECZV5p/7hkuQd0UFlRfmUJiXayEaENggaf0dznsNe5Z2Vg3+iKJx/j0ZgkbaR5JbWwCNNExj0L/MQa3UzW0dhSWH4iTel4s7VVkQrYcrTwczez3tHqEcrfbL6lYcDRJmdZ4zsAieOer98MsWqjn97lP91FoLAbhl7f64Z5EaORyk+1T4CvAscfQAGgUzvfU27fyf3A7FO+luehVKq1VIffqI3sEsS9xQsGQ8w5pYO4VjHq60bLdVIgWwwH8X9X51GaTS5vthR5uE+gvylg40/jW+oHBapJFHgrucN+njg+ooMOP7mQBxZdrZgDYggST/GX8mNQMrlAs3s08FICNdJee2D59xXVTXAGnOMBGbhP4iq+jIgunalXVoXDkeb7fzhEHtUqxqeHuB1aNngP5nlAvm+pfeWbxMdjqVsOCbisD/CvKvX8CYsOp09Q/y8/I8MdWFi1jf/KEVJA0Zm21QfvMcCS72AbS7XelbIwD3dwaoKPxpq7nv/T2MtxsUkhq0DjvzWE1J+SwVYRSTKgew+P53vZmkCzRt9L5cvvL3eIGw6+mki6eigyM7wjd68RuMFDE0T/ktoCwJ0wvaQMzdmoMjS+nZJ7/aZf7zXgfOAddMLqWLzWO63Ld/10Z7RKjilqc5UkJ1CUr7bWV1Sgt9LF3jwWT3iRoCo5ogM7lfaGmZuqcbabR7eIV/nRjGDOHlW9/3EthL0nva8g==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(36840700001)(46966006)(966005)(316002)(83380400001)(356005)(36906005)(66574015)(54906003)(2906002)(70206006)(16576012)(5660300002)(70586007)(31696002)(8676002)(82310400003)(36860700001)(53546011)(31686004)(186003)(36756003)(426003)(336012)(47076005)(2616005)(86362001)(478600001)(6666004)(26005)(7636003)(82740400003)(8936002)(16526019)(6916009)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 15:36:17.2426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418792e2-78e7-4291-4c8e-08d90fdb863f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On 5/5/21 7:15 AM, Pali Rohár wrote:
> Hello! If I understood this "reset" issue correctly, it means that
> affected PCIe GPU device cannot be reset via PCI Secondary Bus Reset
> (PCIe Warm Reset) and some special, platform specific reset type needs
> to be issued.
>
> And code for this platform specific reset is included in ACPI DSDT
> table.
Yes, correct.
> But because ACPI DSDT table is part of BIOS/firmware and not part of the
> PCIe GPU device itself, it means that this kind of reset is available to
> linux kernel only in the case when vendor of motherboard (or who burn
> BIOS/firmware into motherboard EEPROM) includes this specific code into
> HW. Am I Right?
ACPI specification provides a standard mechanism for a function level reset
using _RST method and should work for any OSPM not just Linux.

https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/resetting-and-recovering-a-device
ACPI firmware: Function-level reset
To support function-level device reset, there must be an _RST method defined inside the Device scope. If present, this method will override the bus driver's implementation of function-level device reset (if present) for that device. When executed, the _RST method must reset only that device, and must not affect other devices. In addition, the device must stay connected on the bus.
> So if this PCIe GPU device is connected to other motherboard or other
> system then this special platform reset in ACPI DSDT is not available.
PCI hw resets won't work. only way to reset the device using platform specific code.
> What is doing default APCI _RST() method on motherboards without this
> special platform reset hook? It probably would not be able to reset
> these PCIe GPU devices if standard SBR cannot reset them.
Yes, BIOS/firmware has to support where these affected  GPU devices are attached.
These GPU devices are not plug-in PCIe cards, only exist on server baseboards and
directly attached to PCIe fabric. 
> Would not be better to include for these PCIe devices "native" linux
> code for resetting them?
It requires complicated code sequence and has to access many platform specific
registers. We're taking advantage of OS independent standard ACPI-RST reset
mechanism for resting the GPU device.
> Please correct me if I'm wrong in my assumption or if I understood this
> issue incorrectly.
The GPU has side effects after triggering the SBR, it requires the system reboot to
bring the device back to the operating state, This workaround is to prevent SBR.
