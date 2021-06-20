Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2504E3ADEB9
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jun 2021 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhFTNiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Jun 2021 09:38:12 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:43744
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229624AbhFTNiF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Jun 2021 09:38:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/zt8IO3eQ8N2YXpC10PVlIqdZLDsY1t1gnHxLA6Y5bJswR5PDTXUhTFXvKkmSuPERn7TNWMPBwaa+0/l/20cP3PGbxiAahTIVFzjlRcy94tca46EUSkG7G576tqspXyu/kk4lkF5ZMvG/cegOP5sdjVQ6P/spxRI2osaKYgQkhk2nRpcd72eXlUfY1HmM1n29lVyF+iXFgq0xBrzy2+gGRyvHC6rkOPCOWlF8v01+HeVVOekEWlkJ+/nXhTmxVuCotZbOwOuB+bSnOj2dLI+cSwTdfFcVhUYTLkL5N0CC4s64VqmiFzxSO6st00Vo/44i6DpDidPBiudvpbRAmoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHs8ReOcSHZn8tdmAfoGiKEKVdwWJNObHFQmvglo3Fk=;
 b=KsEJpylVt0jFOsqt0zZWRQYpEb5Y4CTx4nVsElvgaSkFMVWmFixb7CiWfu86eKR5MJ0lVqypUQqhHAzqBmUJFjJaXUI99s0s0mh7Obt53n89BkKkOri9A6KvA9RfeAWfgJMr1rYUpEZtd3MPTXOHM/pO24r3vI07d6PW80+BAQngaGWrIGS05HoM9qtSsI9kuYt0q5lcAh36v55gzD6t1BZ+a+OpckIHkkuOA9N45tkwk9J5Cuz1PUr9TzS7ISLLG+sJ1WzmOqWMlla5CibIjxMZ0TmMV11VVxeeD8KeT0ZuGkOvSNe/lFxd8wIBSIc7NCbbCVsM7Z3ZJKFj0ABFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHs8ReOcSHZn8tdmAfoGiKEKVdwWJNObHFQmvglo3Fk=;
 b=IgRSwPe6+KLx4ghESqSOtR7ZapwTQgN3SOe1ruQ3jjHhtGT0hlHEjM/wAXqpASk7ZwWnN6Yl1HSTsobq1rnnQ4g8qPgn1N3x92c01M/JqU/5EUlyDtkv0CjKgnF3HQ2IJ7e45Q1jfgHl5t87UQ38miIXKauzbNlgZdmByEHBvjEG1a4ultBkcqMmDm4lEP9YxpC12aqUtcf8tf1ZCbBDTljSRe4srxwgIsT9TeG3kYUFsST58y6FlViTCAQjhn13/asrKrzQO/2nnrzUHgJd1Ra0FucHoQv/v5zlNPzuQD6SuGkSRUxcaRC6njOndUOPPGboz81bGBS3SIn0mld4vQ==
Received: from MW4PR03CA0345.namprd03.prod.outlook.com (2603:10b6:303:dc::20)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Sun, 20 Jun
 2021 13:35:51 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::8f) by MW4PR03CA0345.outlook.office365.com
 (2603:10b6:303:dc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Sun, 20 Jun 2021 13:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 13:35:51 +0000
Received: from [10.25.74.204] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 20 Jun
 2021 13:35:47 +0000
Subject: Re: Query regarding the use of pcie-designware-plat.c file
To:     Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <amurray@thegoodpenguin.co.uk>,
        <gustavo.pimentel@synopsys.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>, Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210615194209.GA2908457@bjorn-Precision-5520>
 <10a92c35-6e4d-0428-079c-7e98ff6e9414@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f9bc8a51-7bf8-349d-365b-0493dd811f01@nvidia.com>
Date:   Sun, 20 Jun 2021 19:05:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <10a92c35-6e4d-0428-079c-7e98ff6e9414@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a701e5-ae65-4916-58f6-08d933f05230
X-MS-TrafficTypeDiagnostic: CH0PR12MB5203:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5203ED1759F482CCFABD4213B80B9@CH0PR12MB5203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGGawce8ywwg4I7KjWwuiE/TIAs+srq249aHMePCeiDyouuHS4N2zhhUGVKH8r/OGFFD9b6kaH2HTwoRiJjl7ykvYKacpByXkXZxf9Nu/yGA7lu9R6xtOQQCULQWgkH3kTz++DBuj3sG4c/n8/3G3tJAbm0x3I9aNKy1spWzhV6GlsmDriSViPX78yKzTueDMlvJ0It9OneuyHcncgautVgKHd8tqMnHRx0gElp2d43lYngtWrAtkSeVdVwUvEoYKMLd8LTcvcogtUxQ0mkU4g00X/aKEJ3yAjLrT1eiGGA5aIaMAqLxXuqhBaQLf+TS5gFXROLS3G/Kmq2xrOb5wxKR0/M0v+VVkDK6aPzc2Mbud/qiYw3t0DUYfBSqPr0eC5xLb0KzBlEZcPPuNZnYmtoOroZ6y2/BAIMOYCATlQ6bSzkXoWgAH1+I+eZfZszTHli436L8uPy9LQt9fvd6E9h+edIQbo7JV3XN9Er3uUh8qQXPuNG+jsfps6ODAyr1KYNX5m+ghVJWiDpkzkQNWxuIMso+oaQOE2+xrmBEwMrT7OjJsv21lM7FK/o7E22VeHo/Nx89bh8B3T6VJi3a8VhOEY/CeVKFvaHU+VXFqDHpiQNj6fS4BNQtzjssfE21MdXoNCsV/Vcsn2lPUX9E74tNsTOfFRjgF88uyG/qgmPs83jPt1eX4R1bZ+YZA3TJ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(2616005)(82310400003)(70586007)(70206006)(5660300002)(356005)(336012)(31686004)(31696002)(83380400001)(86362001)(110136005)(47076005)(7416002)(36860700001)(2906002)(54906003)(16526019)(36906005)(82740400003)(316002)(16576012)(186003)(26005)(478600001)(7636003)(4326008)(426003)(8676002)(36756003)(53546011)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 13:35:51.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a701e5-ae65-4916-58f6-08d933f05230
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Given Rob's latest reply, I think Jon's patch addressed the issue in the 
correct way. And IIUC, I think this is how it should be for all Synopsys 
DesignWare implementations unless the implementation really claims that 
it can even work with the generic pcie-designware-plat.c file, otherwise 
it shouldn't contain 'snps,dw-pcie' compatibility string.
IMHO, the addition of 'snps,dw-pcie' along with the respective platform 
specific compatibility string should be strictly restricted.
I think this thread is considered to be concluded at this point.

Thanks,
Vidya Sagar

On 6/16/2021 1:24 PM, Jon Hunter wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 15/06/2021 20:42, Bjorn Helgaas wrote:
>> On Wed, Jun 09, 2021 at 05:54:38PM +0100, Jon Hunter wrote:
>>>
>>> On 09/06/2021 17:30, Bjorn Helgaas wrote:
>>>> On Wed, Jun 09, 2021 at 12:52:37AM +0530, Vidya Sagar wrote:
>>>>> Hi,
>>>>> I would like to know what is the use of pcie-designware-plat.c file. This
>>>>> looks like a skeleton file and can't really work with any specific hardware
>>>>> as such.
>>>>> Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT is
>>>>> enabled in a system where a Synopsys DesignWare IP based PCIe controller is
>>>>> present and its configuration is enabled (Ex:- Tegra194 system with
>>>>> CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen that the probe of
>>>>> pcie-designware-plat.c called first (because all DWC based PCIe controller
>>>>> nodes have "snps,dw-pcie" compatibility string) and can crash the system.
>>>>
>>>> What's the crash?  If a device claims to be compatible with
>>>> "snps,dw-pcie" and pcie-designware-plat.c claims to know how to
>>>> operate "snps,dw-pcie" devices, it seems like something is wrong.
>>>>
>>>> "snps,dw-pcie" is a generic device type, so pcie-designware-plat.c
>>>> might not know how to operate device-specific details of some of those
>>>> devices, but basic functionality should work and it certainly
>>>> shouldn't crash.
>>>
>>> It is not really a crash but a hang when trying to access the hardware
>>> before it has been properly initialised.
>>
>> This doesn't really answer my question.
>>
>> If the hardware claims to be compatible with "snps,dw-pcie" and a
>> driver knows how to operate "snps,dw-pcie" devices, it should work.
>>
>> If the hardware requires initialization that is not part of the
>> "snps,dw-pcie" programming model, it should not claim to be compatible
>> with "snps,dw-pcie".  Or, if pcie-designware-plat.c is missing some
>> init that *is* part of the programming model, maybe it needs to be
>> enhanced?
> 
> Right and this is exactly why I removed the compatible string
> "snps,dw-pcie" for Tegra194 because it is clear that this does not work
> and hence not compatible.
> 
> Sagar is purely trying to understand if this is case of other devices as
> well or just Tegra194.
> 
> Jon
> 
> --
> nvpublic
> 
