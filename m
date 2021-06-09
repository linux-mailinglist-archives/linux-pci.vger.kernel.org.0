Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4158B3A1B81
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFIRJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 13:09:29 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:21473
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229788AbhFIRJ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 13:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUxQHRiA3KeGPmaI7weR9ZneZQAE5z+lrLYBjCtBYicJIaYzujy64TNyXbRK0/J95GOTiferHCp8iFxAjjfv2OA2/saJu/ZjNC20g4pigYx6IvbdUQp32TM3J9Azfjhf+gpOR55grx/be69K0+Sro9wpox07UWXPWu8pn9yrEXbk6YABpahKxfxv3GPiExVZWI6YLTu3JmPRS3+otvttCwbFS4j+Stt60HijMOMQMfDjnBSbXMK/teHOmozkrd+BRmhI/VPkPDqSjVW05E/cn+PXNDA0qzioefwwCvMDTTnmHlpO5c149MQXsVkApry61VXZrt2wYLrJiYpFFEW3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxz8yOvzIkL3bfsemEEk5E3jJa4pmOrrYpsVfvvxqM8=;
 b=nLhJtkA44w+2ZC/oFarrOebkayT/TBS0LbAGpTuHVpzqs8D0MMC94nD0yGGnhrjbd6XrseubJLlTOzEJ1HeZOOEdiQper12BZBN9z7G/woZQ4CL8kTeSrdGyuSSQqsdbAVf0FQUbaODZgQsI2N/yFhLdNBPiu2Zg9Sf9LIupaWwfh7f7nK3pieEF09D48kZzUDl/SLJkParGjE8fPoDd7myxrlylcgdexfgiDXyifHUeNSmo8E7+t64CKMu29pFYeU3fqvG09fPLUKlArwqpTBpMPWXZV9PKXdn8SFFGrBjFVUoWLjtolsnuvjj4qmMyexiPrFeu3DKmmuetMUWqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxz8yOvzIkL3bfsemEEk5E3jJa4pmOrrYpsVfvvxqM8=;
 b=gxBa1GEWO6POsEra7+aEEiqfe/bm1AlRx1GiXbgMjX217Gw5LV5a8tvFqGW77gfy/XEZDdj8DdsshAggw8BdasmTJvknfypo4NE5eLFDMPi2RS2j7o7sL9Ly8y5eDNSbN0bfiWM3p/x2RTNMTMi4iA4lt71xkt4OOlsCBd52f4hH69/2KnYs06hGcR6Qb5W4XyndEQISJUKeyBRilXOb7TyiuYCcBUL/e7K526GhrxhFPgUS/EOn2KTPvcW7dHtbN1N0CBZeFBhNxyv8ov77I4ng7Gm5umh8QOWZCfGWxb2CvzPSNR8dn7/FwobubtLLbYM17PrkBgPSTjy3tTt3nA==
Received: from MW4PR03CA0037.namprd03.prod.outlook.com (2603:10b6:303:8e::12)
 by MW2PR12MB2410.namprd12.prod.outlook.com (2603:10b6:907:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Wed, 9 Jun
 2021 17:07:30 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::24) by MW4PR03CA0037.outlook.office365.com
 (2603:10b6:303:8e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 17:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 17:07:30 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 17:07:28 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210609161842.GA2641672@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <21efef30-099b-9930-ba5c-9c030ea3414a@nvidia.com>
Date:   Wed, 9 Jun 2021 18:07:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609161842.GA2641672@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2113e4b2-4db6-4ee0-720a-08d92b69111d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2410:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2410FAA8687F00A0A77C8D9ED9369@MW2PR12MB2410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMyKMgMFmHt395BSLvwuEIxwKqDS41o2tBVCjmjoNEqR2s8OX44ONIJarjV6JypYAnTblSNubbCNNaG2FivIOSYWT+PvoDqVYPMhmNnexlsFTGYqsptpA8s78hzBMbx7WPn5d92r/qPE3Ofp/SNZX5G1AR4BvsIhOpDiqtOow7+rQvn0PpGPh0s1WlpYlwPM2mPjQUP9BpszScjPpyUfXDf7BGsD8S8nDuungRJ33nfKH0bj+KZQJ0ODhIW8gD5qjFe7pKLAP+H5SRCSKLHGtMxatIRlrdyXJxo0y+De07qtN/xIXvShOJcAyHGVlr126OJLPVW4m+QOZTkH+I6YoaKcSW7OtphmCjbNvCY1/kUI07kNd1rxeWDPh1yW2uYbhAFNofcH6yJmZMalaPsxENluxizd5PAvotNqxZelUDzqQlGv8EBXmoB6RYJtctH8kW0THlywr4dwYfjFp63foeL5DFiM92CQfOlZFHWuivr/iOjGGtB8MK25Gt3Cvkcx31/8YIPyeS5PKaSm/C4daWZReXuui6WDgknHDGIPw4Iku05v4wqltkE3U6soKt3J2iko7PygTfpW1H3Y97aYT8Qk68gUHYxG8PwR1Wwo+dgyL4lTEU4mgNUZd4Zey1XKOoGgaq02VW/NKI9mVyPg1RxrUVBNqYHn2V+nzpRBXYBjaBn0yX8v2wTLdNdS2mvZ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(54906003)(26005)(8676002)(8936002)(6916009)(16576012)(36756003)(316002)(36906005)(186003)(16526019)(82310400003)(31686004)(86362001)(82740400003)(4326008)(478600001)(2616005)(426003)(356005)(5660300002)(7636003)(53546011)(36860700001)(70586007)(70206006)(31696002)(2906002)(336012)(83380400001)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 17:07:30.7339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2113e4b2-4db6-4ee0-720a-08d92b69111d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2410
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 09/06/2021 17:18, Bjorn Helgaas wrote:
> On Tue, Jun 08, 2021 at 09:11:27PM +0100, Jon Hunter wrote:
>> On 08/06/2021 19:34, Vidya Sagar wrote:
>>
>> ...
>>
>>>>> What is the purpose of PCIE_TEGRA194_EP (added by c57247f940e8 ("PCI:
>>>>> tegra: Add support for PCIe endpoint mode in Tegra194") [1])?  I don't
>>>>> see any reference to it in a makefile or a source file.
>>>>>
>>>>> It looks like one can build a single driver that works in either host
>>>>> or endpoint mode, depending on whether a DT node matches
>>>>> "nvidia,tegra194-pcie" or "nvidia,tegra194-pcie-ep".
>>>>>
>>>>> So I think PCIE_TEGRA194_EP is superfluous and should be removed and
>>>>> you should have a single tristate Kconfig option.
>>>>
>>>> This is a good point.
>>>>
>>>> Sagar, any reason for this?
>>> Although it is the same driver that works for both HOST mode and EP
>>> mode, PCIE_TEGRA194_EP depends on PCI_ENDPOINT whereas the
>>> PCIE_TEGRA194_HOST mode doesn't. Similarly the PCIE_TEGRA194_HOST mode
>>> depends on PCI_MSI_IRQ_DOMAIN which PCIE_TEGRA194_EP doesn't depend on.
>>> It is possible to have end point mode support disabled (at sub-system
>>> level) in the system yet pcie-tegra194 can be compiled for the host mode
>>> vice-a-versa for the endpoint mode.
>>> Hence, appropriate config HOST/EP needs to be selected to make sure that
>>> the rest of the dependencies are enabled in the system.
>>> Hope I'm able to give the rationale correctly here.
>>
>> Yes but should we combine them like this ...
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 423d35872ce4..206455a9b70d 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -254,15 +254,12 @@ config PCI_MESON
>>           implement the driver.
>>  
>>  config PCIE_TEGRA194
>> -       tristate
>> -
>> -config PCIE_TEGRA194_HOST
>> -       tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
>> +       tristate "NVIDIA Tegra194 (and later) PCIe controller"
>>         depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>> -       depends on PCI_MSI_IRQ_DOMAIN
>> -       select PCIE_DW_HOST
>> +       depends on PCI_MSI_IRQ_DOMAIN || PCI_ENDPOINT
>> +       select PCIE_DW_HOST if PCI_MSI_IRQ_DOMAIN
>> +       select PCIE_DW_EP if PCI_ENDPOINT
>>         select PHY_TEGRA194_P2U
>> -       select PCIE_TEGRA194
>>         help
>>           Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
>>           work in host mode. There are two instances of PCIe controllers in
>> @@ -271,21 +268,6 @@ config PCIE_TEGRA194_HOST
>>           in order to enable device-specific features PCIE_TEGRA194_EP must be
>>           selected. This uses the DesignWare core.
>>  
>> -config PCIE_TEGRA194_EP
>> -       tristate "NVIDIA Tegra194 (and later) PCIe controller - Endpoint Mode"
>> -       depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>> -       depends on PCI_ENDPOINT
>> -       select PCIE_DW_EP
>> -       select PHY_TEGRA194_P2U
>> -       select PCIE_TEGRA194
>> -       help
>> -         Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
>> -         work in endpoint mode. There are two instances of PCIe controllers in
>> -         Tegra194. This controller can work either as EP or RC. In order to
>> -         enable host-specific features PCIE_TEGRA194_HOST must be selected and
>> -         in order to enable device-specific features PCIE_TEGRA194_EP must be
>> -         selected. This uses the DesignWare core.
> 
> I'm not a Kconfig expert, but I really like that solution, as long as
> it addresses Vidya's concerns about RP/EP dependencies.

I think that Sagar's concern is that if PCI_ENDPOINT and
PCI_MSI_IRQ_DOMAIN are enabled, then we will always PCIE_DW_EP and
PCIE_DW_HOST even if we only need RP or EP functionality. So there is no
switch at the Tegra driver level to indicate if we want RP, EP or both.

My concern with the existing implementation is that if PCIE_TEGRA194_EP
is disabled and PCIE_TEGRA194_HOST is enabled, then if PCI_ENDPOINT and
PCIE_DW_EP already happen to be enabled, we will still have EP
functionality regardless of PCIE_TEGRA194_EP setting.

I am not sure what is best/preferred in this case.

> Looks like the Kconfig help text should be updated to remove the
> other PCIE_TEGRA194_EP reference?  Maybe it should include a clue
> about how the connections to host/endpoint support, e.g., "includes
> endpoint support if PCI_ENDPOINT is enabled"?
> 
>> Furthermore, I wonder if we should just move the code
>> that is required for ACPI into it's own file like
>> drivers/pci/controller/dwc/pcie-tegra194-acpi.c?
> 
> That might simplify things.  I think the reason we started with things
> in one file is because for some drivers there's a lot of shared stuff
> (#defines, register accessors) between the quirk and the native host
> driver.  Either you have to put it all in one file, or you have to add
> a shared .h file and make some of that stuff non-static.

I did test this and there is nothing that needs to be shared via a local
header. We only need to include the appropriate pci headers and so the
code is well isolated. I send the patch if that is easier to see.

Jon

-- 
nvpublic
