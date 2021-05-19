Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC43894C9
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhESRuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 13:50:40 -0400
Received: from mail-bn8nam08on2049.outbound.protection.outlook.com ([40.107.100.49]:27744
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230023AbhESRuj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 May 2021 13:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcW01al+vsEn8go5uJKw0uxnw7qKUgoNvQBYxGy4V3remh8klDD5LtSMUiNO+f5jw3WhvSXADxheifxcGm+abwG8n66q85EykIy82h+KuS14KQL+XQbXPA83ObS71U/6uNl8RERDtIa9WIV11JuVfS1pzEGV04ckODW0n9oniRbgwh8ua1WMuYexr4UHZCUnaRPYlxPkMgOOyrz4XLtchshmEgHO5kUnn+gi8f7v/h4mtnWIoCDSDax8r0wI/iJnnlvjmY5NIY/+cx8GD5V6+Ur0t34zqrnnRQMPYn4jDejAfexXluCWQkoaN4aK3Us5YLHdg701/0fO1k1SAlCOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbuh/WHGQv8d+hWApRmfV3hBT1Mu38ydUKTc21hJ/dc=;
 b=k0HeRK2W32VTC97sVVojNaXf97zngnzmp/sUN/ZgWs54HtNph3Zjn6oqCMIeieBqr0Bp2VGY0SlbsC3Rmf3lRpyPJqrMNF7Uh2OTX95UakUlni55g6rEaAVwaBMg3eVKiLQoN4eIMNrgD5uLPna3iWpogwqm021Hc9IB/EP8QHOuZHhKL2d2jb98iR63yk5vytI7QtvO5InExB4ZJkAwi8X2aGo43QIyw8x9E1A33FFuzRmJ0QYXrHxHZRKCgeAxZpJ6PGMstPiWplakS22vVE+K5Ae91R7R1vJP84HheaiEPIicJGhGz86Zp+VJFsrH6AJlwVWeMWYAa6Ty/unKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbuh/WHGQv8d+hWApRmfV3hBT1Mu38ydUKTc21hJ/dc=;
 b=it7fL8dt9HF5yeC4swN4ugfu70rqTOLr4gICuDL2VqfmitaknXeFjdPo4/QEyL1/BeN0aJRQDacMihteUTXwvb4ZKlEG6bI1Qw9HblGoxwS9v5voV5W/Y6hB8qYBp3rdpvhP8jV4uaC1nH6TI9dcoK0+rN8p+Af32VLB3CVjY7+jL5x1KdHFP1X8btWZVbTSqi8BVmz+DiuBvxyG/YyN5eGJdgKMQ49qewPMLyP23vmIcfLk6oABSopuCoYEyK0Mvo2nkEHTpZFYH0+q3w0YABcC5tcuLYlMYcIV8yBEWKV4zvLLB7Wv0p1JDIkqZxIBLjgmAOa7Ugr61u6C3Jsssg==
Received: from BN6PR19CA0087.namprd19.prod.outlook.com (2603:10b6:404:133::25)
 by MN2PR12MB3549.namprd12.prod.outlook.com (2603:10b6:208:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 17:49:18 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::95) by BN6PR19CA0087.outlook.office365.com
 (2603:10b6:404:133::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend
 Transport; Wed, 19 May 2021 17:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 17:49:18 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 May
 2021 17:49:15 +0000
Subject: Re: [PATCH] PCI: tegra: Fix building Tegra194 PCIe driver
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20210519163403.212362-1-jonathanh@nvidia.com>
 <20210519165703.GA589057@rocinante.localdomain>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9eb01de8-1db7-7cab-d308-c19a3dc480ec@nvidia.com>
Date:   Wed, 19 May 2021 18:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519165703.GA589057@rocinante.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a89f147-a7c5-46b3-e6b7-08d91aee6cff
X-MS-TrafficTypeDiagnostic: MN2PR12MB3549:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3549AA3D90A058580EA98274D92B9@MN2PR12MB3549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srX4K6qX0p0uICUVW7x6CpHCgFQ7o/K9xn5CJHEtD2MpvBHUj9GqA+fdE8czGQfEKXJBP6slpFLTWTppWoh0PUUvbYhxVbwSbRZgw/WbI4Z1KjtiiCcVeu4b9UkKv1ZPtJKhKdI37DQUJHt0jC1DSuIVttrdAx3BGioraZ4MnF8eDMlwzikRX9GpDa59Nrcbf70g64agtjscIVRl/qZIn4b3r4EMEi8QkP/trgcAtsQ9PrVuvp1fpeHiZCQ2hMR/n9QZgFSxWf25AuaiAta8IpTBMr3LWsYLH3DArNN5fI/WFmvLYtakgBQ7irXVN0NtbCqx13UFjdMwcf+COo94n4kvU6B1U2tLyup2zNRpLQ8DH4Mkq1GP6MnqAA4ax9pBwchY3zdhVewRluCbXGfsNnBLh8fO4nmyrp+UH2aRqdMxn0UDOhvHVCUpHKcQJGVaHsWcGeeHEfdXthYM1rrrz1A6ehcxc17VF5JfJs774kp28KH2dwaLc++5cdrsZQDHGWYysk6fAYLKT/zUIkKOKiuPlzaqnsofhAlV9pfNryyIDxbeZpxHoE9mOJadsO7aWZ0jRV5FP1i2mhZhCv+ICNNXQq9XhxRVtUt/PQQ1Y2hnX5+k1Q8xh+oFf8c6FKv/AbbdXlZX7JQpnw7K4Ua5//0oeiuVzIu0RTeATpRSQ5m+IXlxIOPtbTCCCkXz49i8
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(5660300002)(66574015)(2906002)(31686004)(70206006)(83380400001)(36860700001)(86362001)(2616005)(82310400003)(356005)(36906005)(70586007)(7636003)(478600001)(31696002)(47076005)(53546011)(82740400003)(316002)(8676002)(426003)(8936002)(6916009)(336012)(16526019)(54906003)(36756003)(26005)(186003)(16576012)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 17:49:18.0675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a89f147-a7c5-46b3-e6b7-08d91aee6cff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3549
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 19/05/2021 17:57, Krzysztof Wilczyński wrote:
> Hi Jon,
> 
>> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>> errata") caused a couple build regressions for the Tegra194 PCIe driver
>> which are:
>>
>> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>>    was caused by removing the Makefile entry to build the pcie-tegra.c
>>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>>    so that we can build the driver as a module if ACPI support is not
>>    enabled in the kernel.
>> 2. If CONFIG_PCIE_TEGRA194 is configured to build the driver as a
>>    module, at the same time that CONFIG_ACPI and CONFIG_PCI_QUIRKS are
>>    selected to build the driver into the kernel, then the necessary
>>    functions in the driver to probe and remove the device when booting
>>    with device-tree and not compiled into to the driver. This prevents
>>    the PCIe devices being probed when booting with device-tree. Fix this
>>    by using the IS_ENABLED() macro.
> 
> Thank you for fixing this!  Much appreciated.
> 
> There are also few build time warnings related to these changes you
> mention above, as per:
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning: ‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning: ‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning: ‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
> 
> We could bill two birds with one stone, so to speak, and move these
> variables into the block behind the CONFIG_PCIE_TEGRA194 and
> CONFIG_PCIEASPM guards respectively, so that these symbols are no longer
> unused.

Ah good to know. Yes I can incorporate into this change as well. Thanks
for letting me know.

> Also, since this change fixes and issue introduced in a different
> commit, then it would be prudent to add the "Fixes:" tag.

Yes it would. I had missed that, but will add.

Thanks!
Jon

-- 
nvpublic
