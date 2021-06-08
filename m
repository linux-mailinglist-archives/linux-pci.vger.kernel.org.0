Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5E03A0002
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhFHSiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 14:38:14 -0400
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:15232
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234764AbhFHSgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 14:36:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2x7L9BuAr69tPj4WSFi0mwAlwrWs7G9V6NwEnK8dJutTatcetD+TPb1W+jfiCdv7mYhEW3pTCWChdQc81sDpu4GO7FKVCil8GY3NpOJohBkrbdhrQ+JMvi3opbjPGoDOJfgnvkkdu6i/FfETnYbWwrSNrs16bJ6xu/tvPvGdpvvMKZK6geOuxndBdap8hxW+Lw0ig+ZLmnjjEcQENyJiPxmi1tR/gIEOajo3m5FDrNh6LSM5B8VS4GDDJaVSmDY3MqMfGzi9sCT5ASDc4riWYwDS3/HZNi2g6lvMAgkLtrOFcZU58XUhW3HSjyZb4I3Z+EmN2NiwQrWOD4yvUSKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCqd17Aa6PHtTmE+mytGLa1zp1pcze2xCmNgW0Lxrs8=;
 b=RVSGoXYLby2A/EyxSQnK69giFpAMtjFtGiZCpNvUKG0BSLSPFbs7J6bIVJRPpURDI6i5jxqaqKRc8LslnTOvDGwVvkcSMrnZhk3t9Bp/q5rikxHaNC0newZvC75StAj/x9Pu0oLSVZC+qNjaBcPefcnZnDTut6S9aZMyqv0hMo/9OPJeqLJqLQnt+syIxcWVK5epJPqtVmtm6mxnfvOftPy6S9KwKPHsi8oTvDopoEu6Tg96fqgn4yhZFx4Ng3cdwe13uOaL99eYLOjortorObR+JBMQGjELSua4/3eoxGeTTVlepECsmMhgR6K7xkseolaeJZzfnpHGQBmd9mCzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCqd17Aa6PHtTmE+mytGLa1zp1pcze2xCmNgW0Lxrs8=;
 b=EXwXjqC48CwJNz1trSQBnOgkglSz2z8Nk9ra8VzR0xyE+mbuN1WsnVi2sayI7dvPmK5brDS+tr9m6dz+A6LXmELpD93QH7MAkTfZ1um75z0ekW9OG5yoApID/XAMv38p9jWUJaNx4qBgCEHz348HqeTkJUTDo6IDLAE58TGF9g+jCGDRs6WCAH6nxpYo74USVewsDf7a46WGfxyiN7kqgzEMSy5BsGvzvuX0VETFdL2vspInTd9vxRMJ65Vdmr9x18z+NixnHsDmIloK+JU3bRV4Ob5GbvSnjaDxVQic9aMVTMOqWlt7kc3/mwM3+hVlj/D+fiKSBS9XSmWBSEg5KA==
Received: from MWHPR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:301:4a::14) by BN6PR1201MB0115.namprd12.prod.outlook.com
 (2603:10b6:405:59::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 18:34:28 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::66) by MWHPR1201CA0004.outlook.office365.com
 (2603:10b6:301:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 18:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 18:34:27 +0000
Received: from [10.25.75.134] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 18:34:22 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210608130207.GA2597738@bjorn-Precision-5520>
 <754e3546-402c-2a0d-02e8-5d30701f3b94@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <9b027609-a2c3-3df0-5e65-1f282f03cc5d@nvidia.com>
Date:   Wed, 9 Jun 2021 00:04:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <754e3546-402c-2a0d-02e8-5d30701f3b94@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 112cf184-67e6-4ff1-088c-08d92aac0c32
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0115:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0115511A26B4D54FB1192099B8379@BN6PR1201MB0115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+55TuwzeBp6FMF3sGRLjsS+cz3rKeJdOffL9whtWXeAYcduTUe+i4K0hdI5tseQrg4zaXPIP/IOWXQU78ZN2c0vYlb1lIWouAI+svoaVUANnNdpHpU7epbjTezSsaxB0S0ig9qdlEkqZEIMxuSK1hpro31/1l8ObEYQw+srlo7uypObGqig1dmzY1vgq3/hN49VSRvnrF8t+kkJvAA7h/pxGkM/IIyXuAM7zJJL/w9VHdYFKjD5EQaD3dLT8mpjSICAC2NPu7uo9WWyPnyUz8U8aFJDvQ64J8T2gyIvhSv1u3U0uiu4TEWR/zca/2kMTS5bM8dShgpoZWcUVJnaBR3FEw8zoasuhtMMh67cxQwK/SkS/ggVvBi8tjnzPrDJDdNOk5f0bS51E9LzwrWodTxb5iYBb/K9cWBjpFGr6vT14mvr3XclvQs+D3fBHTVDodgaEDogd+pPp9AarQXUf1Ib/1oBDmo6mtJ/oGH0GJGiv4CY+Rs+pnGJzn8g7ayOjg39GR3T65oh0h6vlV7uYz858YfVwuQP+lIitUGYESoIsuPQZ8hbYZ/cfHfqwOnIw4qtjcBVHmAYyvSvTFjK1hv25S+eAFdL5REGZNsu1S3Ve7jVgOH1ZQdJcArf+ctnKIIIK0jKnGf57ORAsQBW2sYhcqFgHkkz3TQV0MrJLoYqbUAAiHVSXqXX33DwBOhY
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(336012)(53546011)(31686004)(83380400001)(16526019)(478600001)(186003)(356005)(86362001)(36906005)(2906002)(31696002)(36860700001)(5660300002)(54906003)(4326008)(26005)(36756003)(2616005)(426003)(70586007)(70206006)(82310400003)(47076005)(110136005)(82740400003)(7636003)(8676002)(8936002)(6666004)(316002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:34:27.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112cf184-67e6-4ff1-088c-08d92aac0c32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0115
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/2021 6:50 PM, Jon Hunter wrote:
> 
> On 08/06/2021 14:02, Bjorn Helgaas wrote:
>> On Tue, Jun 08, 2021 at 08:44:49AM +0100, Jon Hunter wrote:
>>> On 08/06/2021 00:50, Bjorn Helgaas wrote:
>>>
>>> ...
>>>
>>>> My understanding is that we want pcie-tegra194.c to be:
>>>>
>>>>    - Built into the kernel when CONFIG_PCIE_TEGRA194=m or =y and
>>>>      CONFIG_ACPI=y and CONFIG_PCI_QUIRKS=y.  If we're using the ACPI
>>>>      pci_root.c driver, we must have the MCFG quirk built-in, and this
>>>>      case worked as I expected (this is on x86):
>>>>
>>>>        $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
>>>>        CONFIG_ACPI=y
>>>>        CONFIG_PCI_QUIRKS=y
>>>>        CONFIG_PCIE_TEGRA194=y
>>>>        CONFIG_PCIE_TEGRA194_HOST=m
>>>>        CONFIG_PCIE_TEGRA194_EP=y
>>>>
>>>>        $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
>>>>        $ make drivers/pci/controller/dwc/
>>>> 	...
>>>> 	CC      drivers/pci/controller/dwc/pcie-tegra194.o
>>>> 	AR      drivers/pci/controller/dwc/built-in.a
>>>>
>>>>    - Built as a module when CONFIG_PCIE_TEGRA194=m and CONFIG_ACPI is
>>>>      not set.  In this case, we're not using the ACPI pci_root.c
>>>>      driver, and we don't need the MCFG quirk built-in, so it should be
>>>>      OK to build a module, and IIUC this patch is supposed to *allow*
>>>>      that.  But in my testing, it did *not* build a module.  Am I
>>>>      missing something?
>>>>
>>>>        $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
>>>>        # CONFIG_ACPI is not set
>>>>        # CONFIG_PCI_QUIRKS is not set
>>>>        CONFIG_PCIE_TEGRA194=y
>>>>        CONFIG_PCIE_TEGRA194_HOST=m
>>>>        CONFIG_PCIE_TEGRA194_EP=y
>>>
>>> The problem appears to be that you still have CONFIG_PCIE_TEGRA194=y and
>>> CONFIG_PCIE_TEGRA194_EP=y above. If I have ...
>>
>> Huh.  I can't set CONFIG_PCIE_TEGRA194 directly; it's only selectable
>> by PCIE_TEGRA194_HOST and PCIE_TEGRA194_EP.  PCIE_TEGRA194 is
>> tristate, but apparently kconfig sets it to the most restrictive,
>> which I guess makes sense.
>>
>> So I would expect the shared infrastructure to be built-in if either
>> driver is built-in, but it's somewhat confusing that
>> CONFIG_PCIE_TEGRA194_HOST=m results in a builtin driver.  If I can set
>> CONFIG_PCIE_TEGRA194_HOST and CONFIG_PCIE_TEGRA194_EP independently,
>> it seems like they should *be* independent.
>>
>> What is the purpose of PCIE_TEGRA194_EP (added by c57247f940e8 ("PCI:
>> tegra: Add support for PCIe endpoint mode in Tegra194") [1])?  I don't
>> see any reference to it in a makefile or a source file.
>>
>> It looks like one can build a single driver that works in either host
>> or endpoint mode, depending on whether a DT node matches
>> "nvidia,tegra194-pcie" or "nvidia,tegra194-pcie-ep".
>>
>> So I think PCIE_TEGRA194_EP is superfluous and should be removed and
>> you should have a single tristate Kconfig option.
> 
> This is a good point.
> 
> Sagar, any reason for this?
Although it is the same driver that works for both HOST mode and EP 
mode, PCIE_TEGRA194_EP depends on PCI_ENDPOINT whereas the 
PCIE_TEGRA194_HOST mode doesn't. Similarly the PCIE_TEGRA194_HOST mode 
depends on PCI_MSI_IRQ_DOMAIN which PCIE_TEGRA194_EP doesn't depend on.
It is possible to have end point mode support disabled (at sub-system 
level) in the system yet pcie-tegra194 can be compiled for the host mode 
vice-a-versa for the endpoint mode.
Hence, appropriate config HOST/EP needs to be selected to make sure that 
the rest of the dependencies are enabled in the system.
Hope I'm able to give the rationale correctly here.

- Vidya Sagar
> 
> Jon
>   --
> nvpublic
> 
