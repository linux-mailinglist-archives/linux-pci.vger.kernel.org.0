Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1B35E6A2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 20:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhDMSpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 14:45:03 -0400
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:31296
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346272AbhDMSov (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 14:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyTHFz3P7gd/Bd6jNkcDQuEbqhfRN1BOQYb+eg5ZeFwsr4IDGO706TLcn30ow5sdziMJIuNphmp6ghZ32KP7DZb3aXVEr9S/Nzo75bXK6e02hhEzmEFYbbRnYItRy4Art1R0leigUQ3a6geKW745BRh/TsaWMyFabDjVpXJTSoyD3RcX9uWfdWuqFyx9rSKYXHliIIrWvfIJmqZRB8EDRMJrOuRVHPN99IcodK4WEafkf3aKFR3bMiTDi/NP2XqdfVNRQSArfO345ne30XoHohqZ5LXa5b5wvFsNjiJauvtjSd9mEOFtl1kA8vhLoF/whllDE9BPWPcc7L/KjlZgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARBYG8PrUnrm2tNU8d7FV7EFcuuQkjCFcBTs2t6n/Dk=;
 b=U+MEF0JHHwynxEuOo4Cr0MiICUyD3M5WP6AAwBeteioxMgo8bO+yAXKeHnmjB+eR3ZEiZYrmzhEgxAqtTpWba485zs6UKXoFPpVA8waRGgt3Jpd0Ohi5GS1DyKYH8kXhpMEaMbTpCQMcug8FbuTE0lG1mg5gnZHPWdXdMeGbai0yaiC6K0XBY439xQDYnc9tJWdY+k1STPw7sTQZJKny5HDfFefx2ThC8iCPiyZ+dQU/z77fYc1OL6rfD16z0DcVWrAXnjf/LdRiUC+iH8h3FYz/g0bSi2UnocdJ41Y4QFRDEfPyzglSNU9X6UKRVPfhNluSIWNNAJU7vaKQH6JmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARBYG8PrUnrm2tNU8d7FV7EFcuuQkjCFcBTs2t6n/Dk=;
 b=CgjWbWorAgda/izMU1Z59O4+db+6h+tndFEoojI2FRdRQjg4yrZfmq8soR05dwseJiL0d7zfU53ydzG4aIZ3wti9afQxghWCYPhu9XKBAiArEhjPRM6rVt+qLu58f8npSnBg51lYy0NUbLlTrdZWiGDoU/Z1w6K2dwOj2SCzi8MH6Hu2B2dQFahVP67tUebfSKLrlz4k51vAvJxTc6JiiGkSV9p79I5TIXXESHV5x+mL3k394VqsUXz0eptmDAssBqecpuyEwl632tLRYFkC5ZqsvhRWJCknrIzmRp2GnVc6knV36OLwqoAXSpoPVK/+nokZaP62nOsoR/4NkJgWWQ==
Received: from DM5PR20CA0044.namprd20.prod.outlook.com (2603:10b6:3:13d::30)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 18:44:28 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::fc) by DM5PR20CA0044.outlook.office365.com
 (2603:10b6:3:13d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 13 Apr 2021 18:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 18:44:27 +0000
Received: from [10.25.97.143] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 18:44:23 +0000
Subject: Re: Device driver location for the PCIe root port's DMA engine
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krishna Thota <kthota@nvidia.com>,
        "Manikanta Maddireddy" <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <d840687e-bfd7-71b4-e8f0-37c971d3d414@nvidia.com>
 <CAL_JsqLJn+6affnTbF7qS3QUe=trACwKm7rPfJNLL0fF2aMydg@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ba59db08-3c1c-506b-366c-3fe94ab97dfd@nvidia.com>
Date:   Wed, 14 Apr 2021 00:14:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLJn+6affnTbF7qS3QUe=trACwKm7rPfJNLL0fF2aMydg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dc95355-856b-44f5-9c63-08d8feac2acd
X-MS-TrafficTypeDiagnostic: MW3PR12MB4458:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44589EA8C9693B7F1FA34B93B84F9@MW3PR12MB4458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pwBBAHCIvVz161xItyAbfLDNSUYptrAr8bhAcnfrjhlO/6dBSMbWAY0M6Hr3uH0D7VwbNjto+5qa5qZop3lAB/7ivrf/m1/iKntbBbT9p9QBkP7/zKOilSe8TAVYvzPOQapWIP28u/yXwVFPWxdyEbPTtU8ghwKkdglD6gUCGJMQSAnGr2FqzPAcMuyBTR7BxZmhtlruGn1KWWhUxuLExQYOj/Tik8BlBF78xyZo+8z6b67FZCZqTx9Do0XHmupwuGY2XVLuK69Q+HDmin2m7chVx4ysAISrpT+cwBT0jh6fhCEabT1ZwK8OAdhugliaCMsEk+SxF1GlWrviwW7mERpU+PhfCv/ghnJE0tRanL6lxcsYbGT1ycC6TfspPuNLDevExiamFOfngIt9spYA5OkdAZ6k5N6ni9rdiI5BS2+vQEgg2Kir29zJCqTs8RQF3HsHIfH1y+mc1ejSFeYRmF7lxR5Ax6vrcIXQAq18oQkFP63BmZV0mHxIkAvDXztVE/PXNjKtwkZhAGjWCPAH4qkgmRYv5DJdlFfl2g7yniUxxSSnA0KS9BjrJ53ewjt6pqa5chZRPM0KN8QCsh3kykfChXfKaHKlOV+CSTWIko82dyVdlvlvfjUK5x/USajSgXCnyQ8DnTA2hTfXkBWJfUEXT3QReXKEPG0caY0T68L4dvR87KsmGQ4t2KHxa2J
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(478600001)(70586007)(53546011)(2616005)(47076005)(2906002)(4326008)(36756003)(16526019)(336012)(36906005)(186003)(70206006)(82740400003)(6916009)(26005)(7636003)(16576012)(86362001)(31686004)(31696002)(54906003)(316002)(426003)(82310400003)(8936002)(356005)(36860700001)(5660300002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:44:27.7853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc95355-856b-44f5-9c63-08d8feac2acd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/13/2021 11:43 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Apr 12, 2021 at 12:01 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> Hi
>> I'm starting this mail to seek advice on the best approach to be taken
>> to add support for the driver of the PCIe root port's DMA engine.
>> To give some background, Tegra194's PCIe IPs are dual-mode PCIe IPs i.e.
>> they work either in the root port mode or in the endpoint mode based on
>> the boot time configuration.
>> Since the PCIe hardware IP as such is the same for both (RP and EP)
>> modes, the DMA engine sub-system of the PCIe IP is also made available
>> to both modes of operation.
>> Typically, the DMA engine is seen only in the endpoint mode, and that
>> DMA engine’s configuration registers are made available to the host
>> through one of its BARs.
>> In the situation that we have here, where there is a DMA engine present
>> as part of the root port, the DMA engine isn’t a typical general-purpose
>> DMA engine in the sense that it can’t have both source and destination
>> addresses targeting external memory addresses.
>> RP’s DMA engine, while doing a write operation,
>> would always fetch data (i.e. source) from local memory and write it to
>> the remote memory over PCIe link (i.e. destination would be the BAR of
>> an endpoint)
>> whereas while doing a read operation,
>> would always fetch/read data (i.e. source) from a remote memory over the
>> PCIe link and write it to the local memory.
>>
>> I see that there are at least two ways we can have a driver for this DMA
>> engine.
>> a) DMA engine driver as one of the port service drivers
>>          Since the DMA engine is a part of the root port hardware itself
>> (although it is not part of the standard capabilities of the root port),
>> it is one of the options to have the driver for the DMA engine go as one
>> of the port service drivers (along with AER, PME, hot-plug, etc...).
>> Based on Vendor-ID and Device-ID matching runtime, either it gets
>> binded/enabled (like in the case of Tegra194) or it doesn't.
>> b) DMA engine driver as a platform driver
>>          The DMA engine hardware can be described as a sub-node under the PCIe
>> controller's node in the device tree and a separate platform driver can
>> be written to work with it.
> 
> DT expects PCI bridge child nodes to be a PCI device. We've already
> broken that with the interrupt controller child nodes, but I don't
> really want to add more.
Understood. Is there any other way of specifying the DMA functionality 
other than as a child node so that it is inline with the DT framework's 
expectations?

> 
>> I’m inclined to have the DMA engine driver as a port service driver as
>> it makes it cleaner and also in line with the design philosophy (the way
>> I understood it) of the port service drivers.
>> Please let me know your thoughts on this.
> 
> What is the actual usecase and benefit for using the DMA engine with
> the RP? The only one I've come up with is the hardware designers think
> having DMA is better than not having DMA so they include that option
> on the DWC controller.
In Tegra194-to-Tegra194 configuration (with one Tegra194 as RP and the 
other as EP) better performance is expected when DMA engines on both 
sides are used for pushing(writing) the data across instead of using 
only the EP's DMA engine for both push(write) and pull(read).

> 
> Rob
> 
