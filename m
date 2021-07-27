Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308663D6BE2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 04:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhG0BlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 21:41:19 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:19849
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233731AbhG0BlT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jul 2021 21:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7/LK5gEBG6ea1/YKeEgFqeakAmTLxYqz0znwC9IR5bhAtnPzGkHFJuXYfKVJgreV3CnwZtnn4V0QkQRn2BB/VoYnXB7WTNyn7pfoeTTV4vo6N1mvd2T2Y/7BQYzpTyGOzUfXKhrzHoHOxHy47K0vu2o5aWVAaPcE65x4NeAO8DWwpatydiETIhjmWFzuU6TwWqzGp5Y/itar7SYgS0HEPsWhFIMpv8GWJmpJwwkwtDdusjMSi06puNULZFuzhtNkzWmtF1G3KWKet6uwXbtCM1YWAL4riAOk1LvBhulGCLaWH6AaKtGdLWVM28ggLBu7k+4VV/Amfjv5i/ZRrVJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0O2PVjlK9RJIprv8+ccc/c7aTIReX5M3oqaV61Dgn4=;
 b=PUzIoYCiityN0K+loUaoAXMaI68KL8rSQuZvAr1lepEWlR9JExMpgn8QQFjJnpd2ABbarWUGwapfYaXS2TYWG3uyBWiKrLPxtO4ADdU8dsRRpCAE23xSKTYEPU1swBBLLJnIGi712hRrI1HvAYfuuSFG6IGvM8S9npFAJIUSdl7R4c8aOHVDxfafi/4kXCgRubzdOuqk1DpvD5iwo/4/R88poHqZoqwtbCa350ATEjTHZ7dMyPhXzt8MivDkNxAgAWKBmqwpvIlg2HvyM0fT8cIor3r1HWzmpNIWoDDiRwDZCGGNWHmuGtBrvH4+n1t3tfVv4ftlh3c0TyyxW5+3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0O2PVjlK9RJIprv8+ccc/c7aTIReX5M3oqaV61Dgn4=;
 b=UbUNXnffx0/cIxZrgILtXCpJ5zH7Yb6C1wPxZGwuurAb9F3RNnoDT6M7xeujfgiZRAl9kGTH096m65GK6gTOsKablOe3ERKqbQP7UgqHJXGQ4qTUounOYzXzqn4Npq4nUPybIxTHamC447rUWTnnKKl9mhByKbWeYNCfLnYxXckDJIt+txUeqK/qDkeVGW220Umd1zJ+rouXhVRyDCvwpP4fpNLbBD4okjsTr9sj4cfmUzOA82EnEM5Yfn7VunZSUsCwIQizF+uF5X+lKT+g8zjwQKL9DT/jfhzu85fIpg9cptT0174t4ssvYFvfgjQV7Xi19d3leR0x/BpGnhiJUA==
Received: from BN9PR03CA0362.namprd03.prod.outlook.com (2603:10b6:408:f7::7)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 02:21:45 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::aa) by BN9PR03CA0362.outlook.office365.com
 (2603:10b6:408:f7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Tue, 27 Jul 2021 02:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 02:21:45 +0000
Received: from [10.40.204.204] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Jul
 2021 02:21:41 +0000
Subject: Re: Query on ASPM driver design
To:     Bjorn Helgaas <helgaas@kernel.org>, <hemantk@codeaurora.org>
CC:     <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <bjorn.andersson@linaro.org>, <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20210723222858.GA445474@bjorn-Precision-5520>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <28465f90-3c64-678a-9b90-209eaa30a084@nvidia.com>
Date:   Tue, 27 Jul 2021 07:51:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723222858.GA445474@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e121a9d-ec9a-4a8e-5767-08d950a547e4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4011F4CB8AC3CB79DE2FD2A4DAE99@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSdoqRsPsdXBdIxXoYQEM6RvxSRRXR3LBIh+nITa1RaXJdYULKO9Bv4FZHv3wJebiXFZ9n6drlw93AV/wq5nG1jdTM1SGp92Vil5lxNCPSnoX1hpgUCQ2fFtODHPQ4DKNR+so67hoK7QldbWV983VKfXYR8EAbgcqQVoL4sV6qA1YM2oa4kvegY4CEJgIKunmXP8t18snDArdBPQH4SrQ8mR5rdYtnlb4lzuQQhyQPDkztl6B+vD/th2tO/lrlplpzlPwd2WXnS5ooqhFWfqZOMgUM6bIfZZKXWZO2OfVd9tQ9+sITUFrS8IS5ziDM7+pHXwZ/myDDl6kfnFsZwQjjzkmUo+atC0IJs80OF7ZXJ1ywf+Hrp+/433PvHfv5sGWHa+dQ4aVBUoLY7OD9z+ERQ8E+FhLj4rpY5xfXqSHzZQ7pVgxVJYex5CDQGwb3uLu4BCwUbpW97mQOSihpeYtxKRSLOUYT332qeq/KaxstBqTuO6vqFVOHakpKAbe3y3Gs8NRZlxZOb5qb7fX62curu3rZl9N61ofAw3KDbukgLkJ6CsJ2zMQ7Fb3CSjXA/SAijfjUHIuFBvSIiWkl4Fn5n3wv+p9C0HZsk9RlxeRYZqPz7IvVjp+OFZE2jz56SfzbrxZD6UvV3oTCgbtwWrnKURNMznGvNhNmVLESGxizye61dj9WTdc/wbs8XoPFe9eDxYLJ5ckV7Zz1PB5zTQgC0xmC5Hl8R8dOxYckfXJCCFO9COgolM8gS8mTjQ2vTc
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(316002)(2906002)(36756003)(16576012)(70586007)(7636003)(83380400001)(31686004)(86362001)(110136005)(54906003)(107886003)(36906005)(82310400003)(356005)(82740400003)(5660300002)(4326008)(16526019)(478600001)(47076005)(36860700001)(31696002)(8936002)(53546011)(70206006)(6666004)(336012)(426003)(2616005)(8676002)(26005)(186003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 02:21:45.4029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e121a9d-ec9a-4a8e-5767-08d950a547e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
I think it makes sense to have the scope of keeping default ASPM policy 
disable and API pci_enable_link_state() to selectively enable by EP Driver.

sysfs interface for ASPM also does not allow enabling ASPM for a device 
if the default policy (policy_to_aspm_state()) does not allow it.

Consider a situation, for a platform one wants to utilize ASPM 
capability of an onboard PCIe device because it is well evaluated, at 
the same time they want to keep ASPM disabled for other PCIe devices 
that can be connected on open PCIe slot to avoid possible performance issue.

I see ASPM is broken on many devices, though the device shows ASPM 
capabilities but has performance issues when it is enabled.

Thanks,
Om


On 7/24/2021 3:58 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Jul 23, 2021 at 03:04:52PM -0700, hemantk@codeaurora.org wrote:
>> On 2021-07-23 13:32, Bjorn Helgaas wrote:
>>> On Fri, Jul 23, 2021 at 01:11:18PM -0700, hemantk@codeaurora.org wrote:
>>>> I have a question regarding PCIe ASPM driver in upstream. Looks like
>>>> current ASPM driver is going to enable ASPM L1 and L1SS based on
>>>> EP's config space capability register read. Why ASPM driver is
>>>> enabling L1SS based on capability, instead of that can ASPM honor
>>>> default control register value (in EP config space) and let pci
>>>> device driver probe (or later after probe) to make the decision if
>>>> ASPM needs to be enabled or not.
>>>
>>> Are you asking why the PCI core makes the decision about enabling ASPM
>>> instead of having each device driver decide?
>>
>> Yes.
>>
>>> If you want each driver to decide, what benefit would that have?
>>
>> Basically if PCI EP has capability to support ASPM L1 and L1SS but
>> power on default control reg values are meant to enumerate with ASPM
>> disabled.  Which means EP wants to keep ASPM disabled right from the
>> enumeration, and at some point of time later EP wants to enable the
>> ASPM. Main benefit is to give control to EP to enumerate with what
>> ever its control reg's power on default value is. EP does not want
>> to enable ASPM during its boot up and after entering to mission mode
>> use case it would enable the ASPM.
> 
> The power-on default value for the "ASPM Control" field in the Link
> Control register is 00b, which means ASPM is disabled.  The current
> Linux behavior is that when we enumerate the device, we evaluate the
> L0s and L1 exit latencies and enable ASPM if the device can tolerate
> them.
> 
> It sounds like you want to prevent ASPM from being enabled until the
> driver explicitly enables it.  Why?  The device should not be active
> until a driver claims it, so it should not be a problem to have ASPM
> enabled.
> 
>>>> Basically point is: it is possible to honor what device control reg
>>>> reflects power on default and let the pci ep driver running on host
>>>> to make the decision when to enable/disable the aspm in kernel space
>>>> pci driver.
>>>
>>> There is a pci_disable_link_state() interface that drivers can use to
>>> disable certain link states.  Some drivers use this to work around
>>> hardware defects, but it would be better to use quirks in that
>>> situation.
>>
>> Thanks for pointing this API, which quirk also uses. But we just
>> have disable ver which EP driver can call only after enumeration is
>> done. i was thinking of the other way round where EP enumerates and
>> then calls enable API at some point of time. Also, if it decides to
>> again disable and then enable.
> 
> There is currently no pci_enable_link_state() because nobody has
> needed it and implemented it.  I would push back a little bit on
> adding this because I don't want to encourage drivers to mess with
> ASPM.
> 
> Bjorn
> 
