Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC0E35E615
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbhDMSMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 14:12:54 -0400
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:27561
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238635AbhDMSMp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 14:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKIhLfKO7ypQvilHwv2h7JSBCgpN0AxzYDq/Vb3Zwqacs076MeZNDAhOWLttFAQti3RMYwS0ASSkXxBHXRY+nHHkQEiqI7f4VjYj9jS8mTYNf3biP4V/F3kITAMO9+zj6RVdqheBK7u4FiH8rdqO3z8zHtgcY+cjUa+d8IlObALMIhDnkrwxamK3QZTZ37qZSkNYTSNXahuGfUOxvC8IlU2SmnzTIQoevplwrD8s2qsF+W982w0CnFg0izQLryN/yWSTvSJsbE1/N88Yr0f/67Qo5/uD/Yi+uatkTmEjA87uMEDQRCa9n84Qwc1Lff6Rr5Nfrj/JsWzud7OADKqdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSgsw92c1G9DOSTLjOqF4j25QcElM7Zwjl2PB4DKQf8=;
 b=LR0ig5SIqciSIJJvwgfkSzCBzzunRVi53y5EMCXnRVIvaP2WRV2PiT3y6EYFi020a+bteZov8cxIXl50tXLq4EjfW5Y2McwSiKX5K8ZLxizfseijh1KKa2ZX/sWSQEdQ6eqscMarccxkB23Of0V/4oYZECy3Gwxfb0coYMgd/0pfE21Dboncgmuq9NlSNBKn/3n9d3flbw0Cdgti6PhvS0nk+p2Js0YqNbkycUGfeF7E7Y7uD7ahZLA1xJ8bCvlS/FrDRX0CobjHvfxlpvYCaYJX19cIOIGLouwrcETWT2cMqKACPviarXURLJKaCyOeqiLZF8MNwoH8XbR0psSa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSgsw92c1G9DOSTLjOqF4j25QcElM7Zwjl2PB4DKQf8=;
 b=DJPFqwztmUwTNPuYTuBkX4vuUmngwE1sspSnu6/qlRpWaRu6aEFWfJZoKXUXn6kINfBqn21TgRzkq311Gr/ie/PL+Ui1MNHa8xIr2u4Ly89a97ALhOT56QCAbbmosjBhhLQlgt61cpDdn97uG2Fnllp91AE7eKKrTriiVZfmuLpcWIfWwSCVRJ7197l026uMEKEbzJ3gR062TSnTCs3xVAyZpDq5fQ37cKF/DbH2xgBp2nzrm8Ysm7VA9678uEYHnSt4d18i9mTBoZX6ER4LNORvEpcQQFBIgPDPihH+Foa3pLyo2ystaAe66UkwXYFylU1MxqwLfe3zqADieccHpA==
Received: from DM3PR08CA0019.namprd08.prod.outlook.com (2603:10b6:0:52::29) by
 BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Tue, 13 Apr 2021 18:12:24 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::df) by DM3PR08CA0019.outlook.office365.com
 (2603:10b6:0:52::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 18:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 18:12:23 +0000
Received: from [10.25.97.143] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 18:12:18 +0000
Subject: Re: Device driver location for the PCIe root port's DMA engine
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        Krishna Thota <kthota@nvidia.com>,
        "Manikanta Maddireddy" <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20210412215333.GA2144302@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <5fe57865-41f8-67c5-e6a6-9abe7252591c@nvidia.com>
Date:   Tue, 13 Apr 2021 23:42:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210412215333.GA2144302@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba32f84-0bb7-4303-2226-08d8fea7b01e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:
X-Microsoft-Antispam-PRVS: <BN6PR12MB168438B0B99195E94C1E0B71B84F9@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOvYZKhI8BqqYUWxvfnYqo8oy1mZ/9B9c0sPXaNij+fxr8/5aia7O3ZYFLG32pjZKK7g8NtIXKd6SNaBGf1AxL0bxNTWZy2AgkzkgWbSKJRa5YsSLp/4H78FgOssadfl8o4HTQJrylxNMo9vE6abwwqc/+YlLEYe7Pt8Y/UloW3oXoJ6Vm79pJDWhO2K1tv4WFCTMChHvaihPTR8lf1076updkioQGdHyDiYfffKmZXhohhxOPscyqnAoxFhLXQ9pCZPXo5QI8106laHZ8Qk5O1prSKYZSnVA1iQMjXZP459b2REI9kJ2rjliLe6v1WrCnzpUo21ZdAC8KHm6Lw4mAaqr0S3EneE2BMNvoyM+omTJsSMM3UdzxpDbT6YFUIn17jxJ/EJSw1CS/uSWsd2Z5MKYe7g+KLSTLK6yi3hxjIB9bdINyOu3xOiJT0zDEgasBAGmVPqI1kircbmhv3tvZKVWJh5owDB9Be4UHzT0yho/mzea2+uikth5QPoDFV//X5wFchlfU20N1rGlGXB61H+52onAmT9C9+CmzbEMgJJLa4jiKbLImVDTzZVlEO04DzcLsROYMdUeBcgQdRb7QBNX641yXONqc3kY3lJJa4V7fMF3CN7QHFLYpk8ah5prV8OmO4vzVb92Vz44hCnwUxUwZ1oIHmVm6eUCFw7PbOKJI9yYRv7fr8mhCR6NN/D
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(2616005)(478600001)(16576012)(316002)(36860700001)(8676002)(36906005)(5660300002)(8936002)(86362001)(4326008)(26005)(47076005)(54906003)(6666004)(426003)(110136005)(82740400003)(31686004)(53546011)(16526019)(31696002)(36756003)(82310400003)(70586007)(83380400001)(356005)(2906002)(186003)(7636003)(70206006)(336012)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:12:23.9514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba32f84-0bb7-4303-2226-08d8fea7b01e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/13/2021 3:23 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Matthew for portdrv comment]
> 
> On Mon, Apr 12, 2021 at 10:31:02PM +0530, Vidya Sagar wrote:
>> Hi
>> I'm starting this mail to seek advice on the best approach to be taken to
>> add support for the driver of the PCIe root port's DMA engine.
>> To give some background, Tegra194's PCIe IPs are dual-mode PCIe IPs i.e.
>> they work either in the root port mode or in the endpoint mode based on the
>> boot time configuration.
>> Since the PCIe hardware IP as such is the same for both (RP and EP) modes,
>> the DMA engine sub-system of the PCIe IP is also made available to both
>> modes of operation.
>> Typically, the DMA engine is seen only in the endpoint mode, and that DMA
>> engine’s configuration registers are made available to the host through one
>> of its BARs.
>> In the situation that we have here, where there is a DMA engine present as
>> part of the root port, the DMA engine isn’t a typical general-purpose DMA
>> engine in the sense that it can’t have both source and destination addresses
>> targeting external memory addresses.
>> RP’s DMA engine, while doing a write operation,
>> would always fetch data (i.e. source) from local memory and write it to the
>> remote memory over PCIe link (i.e. destination would be the BAR of an
>> endpoint)
>> whereas while doing a read operation,
>> would always fetch/read data (i.e. source) from a remote memory over the
>> PCIe link and write it to the local memory.
>>
>> I see that there are at least two ways we can have a driver for this DMA
>> engine.
>> a) DMA engine driver as one of the port service drivers
>>        Since the DMA engine is a part of the root port hardware itself (although
>> it is not part of the standard capabilities of the root port), it is one of
>> the options to have the driver for the DMA engine go as one of the port
>> service drivers (along with AER, PME, hot-plug, etc...). Based on Vendor-ID
>> and Device-ID matching runtime, either it gets binded/enabled (like in the
>> case of Tegra194) or it doesn't.
>> b) DMA engine driver as a platform driver
>>        The DMA engine hardware can be described as a sub-node under the PCIe
>> controller's node in the device tree and a separate platform driver can be
>> written to work with it.
>>
>> I’m inclined to have the DMA engine driver as a port service driver as it
>> makes it cleaner and also in line with the design philosophy (the way I
>> understood it) of the port service drivers.
>> Please let me know your thoughts on this.
> 
> Personally I'm not a fan of the port service driver model.  It creates
> additional struct devices for things that are not separate devices.
> And it creates a parallel hierarchy in /sys/bus/pci_express/devices/
> that I think does not accurately model the hardware.
Agree.

> 
> The existing port services (AER, DPC, hotplug, etc) are things the
> device advertises via the PCI Capabilities defined by the generic PCIe
> spec, and in my opinion the support for them should be directly part
> of the PCI core and activated when the relevant Capability is present.
Is there an on-going activity to remove port service drivers are move 
AER/DPC/Hotplug etc.. handling within PCI core?

> 
> The DMA engine is different -- this is device-specific functionality
> and I think the obvious way to discover it and bind a driver to it is
> via the PCI Vendor and Device ID.
> 
> This *is* complicated by the fact that you can't just use
> pci_register_driver() to claim functionality implemented in Root Ports
> or Switch Ports because portdrv binds to them before you have a
> chance.  I think that's a defect in the portdrv design.  The usual
Yes. Hence I was thinking of adding a service driver for the DMA 
functionality

> workaround is to use pci_get_device(), which has its own issues (it's
> ugly, it's outside the normal driver binding model, doesn't work
> nicely with hotplug or udev, doesn't coordinate with other drivers
> using the same device, etc).  There are many examples of this in the
> EDAC code.
I didn't think of approaching this issue in this way. Thanks for the 
pointers to EDAC code. I'll wait for comments from Matthew before I 
proceed with this approach.

> 
> Bjorn
> 
