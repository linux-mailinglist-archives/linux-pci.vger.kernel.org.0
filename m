Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F03DB333
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 08:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhG3GIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 02:08:14 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:56673
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229999AbhG3GIN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 02:08:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNu8flg29bHkU0TeRJWv+9M25XsmJGV0cM0gXgpeU6uo4PnxurezpRUP9PEQQJd/vGtUNQGyrJMOyvBFI+CLVrtA6hb0/tqWjA0QpxSoYcugTvfi/22xpWRfmzkULr4cIZtqJYh+an54JZV/kk57DdeMGNb+e6bBVmW06M80y4PAMojHYkBcA/tzc3ZAyc/OLPBWmNY5IBJxQP7trYNpBtyNt4XJj1qdreAqCIp3LIZw3l4lLNLjxguSmq7lNvvCeNO/pvOxVxaucyT5rBAK2LyJvIYtINlnwZ/X0VKj2Ariy7pMm1uvPcXiXGbceBakxPwkZ2W+0b86iqdqZVGS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbo/HPQQbZcGtgQE6DHsIITYW0KdL6az0f2aOvkSQZg=;
 b=ByMTEz99nCQWS/ze2x16cmq3XAnyYDzaAyD68VvqYs/ylOLF9SVpwb5g58Y0dTi1SrzieuYaHI16hGug2bKXQtzypn3Bljvu8JO9n9bk5f6eaW5Ompb6byhKGZ8f0sQJM0QwSPJyyeCL28x4ZCtkP6ZfzixaUTFQODT++OjDLmfr0aQbZmFRoye0uGOGNqKJ4qdta7rwsJqDNpIkUO4MiRnahDUPlI1yeHRqm+imsE9p84QnzSYE5mCSvoxAxsdO7HrliIkKRg48nI04SQF6+cH6i2tV1zxZ6rVW89vXJmSz/q1U/kbQ6TIuQ30hHuHY2Ti8YvLsW2qGgQz/Gq8vxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbo/HPQQbZcGtgQE6DHsIITYW0KdL6az0f2aOvkSQZg=;
 b=lGqD+sblNum1Z8hDl14eaurW4tzN2km5zrq8aeFqn+djStb4Bd7gYQ0ru0yRf/q5IZYxrACOClV87+vscmX9UhjvmNYVh51aQmRfMpLK7ct8ZY/82nPH//7lFIx1IA/WSD97RPe0eKSSVTWzDHVZ4+wgO+B0RJhI248HjrKP+NZgfmUhd0afnuWVKlqCHPI/gDJHgZyR0lL+avYGvt7hLJQ8Itu+seqgGFKIz8j5D8zaW1Nxcb2TtT5btuB/IHug64/us5u3aP7IuhthKr/9T5Mgfkj7k0cPezU3rY+g+UBBDXOaLWYdMnZ+9LQKtSGN3priTX+EFeUruerAGKsWsg==
Received: from BN0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:e4::13)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 06:08:08 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::a4) by BN0PR02CA0008.outlook.office365.com
 (2603:10b6:408:e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Fri, 30 Jul 2021 06:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 06:08:07 +0000
Received: from [10.40.206.53] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 30 Jul
 2021 06:08:02 +0000
Subject: Re: Query on ASPM driver design
To:     Bjorn Helgaas <helgaas@kernel.org>, <", hkallweit1"@gmail.com>
CC:     <hemantk@codeaurora.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <bjorn.andersson@linaro.org>,
        <linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210728160140.GA823046@bjorn-Precision-5520>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <c62e54d4-4971-e04d-e878-d1e9902e6979@nvidia.com>
Date:   Fri, 30 Jul 2021 11:37:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728160140.GA823046@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49901f28-c6aa-4a80-b52b-08d9532066b9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2367578689CA5BD431E938F8DAEC9@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQ8mocuqLnAzzmFB0ebGkZY3+wYWt6/1YXuGE22P7Y/+QmD3QU4l5iGlDcuZuc5A+nARM4/1CIG3h2NnkX3+iV+aJlIPVH/fks/iLjrBhVlZ6N5yqSePxEQThczCUXv6MdY+/0CSWkR8eaRlqJi9zLTef24KZRtKRzQCeAXgiWdkWk/x/V2mMTI7GxRpyVaVmQK3KkPSV0InbC1WyzMgroQK0X4XLAg59uOS0jME4eVcpIdYJ9FTgnsn12CK/en4YY0PZlu6iw+0xgtCa+of6lNMrA6wUg4o98GMoMQBT7XoZv0/ByLJPGsBbhu7gC5IBqQ/4/iWrq+/YNeK28EH3fd18ri0C/braLlfq8eUtk7CXbHzu0/ghYRaw9hFgHh082MalFrN2EcQjI7/UxfjtzmhFGcK4slrgMjU8txQL+qa3YqF5ftWa9S4f6s2lKr9hVfKuixL5oN3wSMvcqieOhMRSIbJ750LjWyKk3vNFrJsUn5C1jsoMdUZ434bVozuEpy247vFDafjR7GB+wLkOPzsQXiUdekPiJgzhFqgDnlGdCgAFDlWZZgBpdINI9MINaHKA9n1FjGva5f8vQZ4nUJ6qK/p6BeUCvLpEZD8iWjksqgPfKwxz+pxdrR/wh4m3mhDDN9ACeBjo3OSwsXHd5m/a6sxFe0jf9rcjsIkIohplAnbbTVhXzZPkA6RJFVHGSzvDmvQw1oEqUgjbkaoUb/oAudyeF84S2soiOwHWTQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(70586007)(508600001)(47076005)(336012)(7636003)(26005)(2906002)(31686004)(4326008)(6666004)(8936002)(186003)(53546011)(70206006)(82310400003)(36860700001)(31696002)(5660300002)(356005)(426003)(316002)(83380400001)(16576012)(16526019)(36756003)(54906003)(2616005)(8676002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 06:08:07.5492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49901f28-c6aa-4a80-b52b-08d9532066b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/28/2021 9:31 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Rafael, driver-specific vs generic PM at very end]
> 
> On Wed, Jul 28, 2021 at 06:48:50AM +0530, Om Prakash Singh wrote:
>> On 7/27/2021 8:48 PM, Bjorn Helgaas wrote:
>>> On Tue, Jul 27, 2021 at 07:51:37AM +0530, Om Prakash Singh wrote:
>>>> Hi Bjorn,
>>>> I think it makes sense to have the scope of keeping default ASPM
>>>> policy disable and API pci_enable_link_state() to selectively enable
>>>> by EP Driver.
>>>>
>>>> sysfs interface for ASPM also does not allow enabling ASPM for a
>>>> device if the default policy (policy_to_aspm_state()) does not allow
>>>> it.
>>>
>>> The ASPM policy implementation may require changes.  I think the
>>> current setup where a policy is compiled into the kernel via Kconfig
>>> options is seriously flawed.
>>>
>>> We need a fail-safe kernel parameter, i.e., "pcie_aspm=off", for cases
>>> where devices don't work at all with ASPM.  We need quirks to work
>>> around devices known to be broken, e.g., those that advertise ASPM
>>> support that doesn't actually work, or those that advertise incorrect
>>> exit latencies.  I think most other configuration should be done via
>>> sysfs.
>>>
>>>> Consider a situation, for a platform one wants to utilize ASPM
>>>> capability of an onboard PCIe device because it is well evaluated,
>>>> at the same time they want to keep ASPM disabled for other PCIe
>>>> devices that can be connected on open PCIe slot to avoid possible
>>>> performance issue.
>>>>
>>>> I see ASPM is broken on many devices, though the device shows ASPM
>>>> capabilities but has performance issues when it is enabled.
>>>
>>> I'll wait to see your proposal and use case before commenting on this.
>>
>> few suggestions:
>>
>> 1. We can have a device-tree property to disable ASPM capabilities of a Root
>> port. Corresponding to my example, the device-tree can use be use to enable
>> ASPM capabilities of Root ports that have known/good/onboard PCIe device,
>> and keep ASPM disabled for opens slots
> 
> ASPM can only be enabled for links between two devices.  For empty
> slots, there's an upstream device (Root Port or Switch Downstream
> Port) but no downstream device, so ASPM won't be enabled anyway.
> 
>> 2. sysfs should allow overriding default ASPM policy.
>>     With below change system can boot with default policy ASPM disabled
>> (performance). But sysfs will still allow to enable ASPM capability of
>> selective device
> 
> This sounds like a good idea.  If we could get rid of the Kconfig ASPM
> policy selection, we'd likely make PCIEASPM_POWER_SUPERSAVE the
> default.  Then userspace could use sysfs to disable ASPM states
> selective as necessary for performance.
> 

want to clarify this point, my idea was to have to have all ASPM mode 
disable by default (PERFORMANCE). And through sysfs user should be 
enable selected ASPM mode for each device. With current upstream code 
this is not possible. We can introduce one more policy USER_SELECTABLE 
if it make more sense.

Keeping ASPM disabled as default policy is important as any rough device 
connected can impact on overall system performance.

Adding Heiner Kallweit to share his opinion as well

> Even before removing the Kconfig policy selection (or if we can't do
> that), I think it make sense to allow sysfs to override it.
> 
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index a08e7d6..268c2c5 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1278,7 +1278,7 @@
>>                link->aspm_disable |= state;
>>        }
>>
>> -     pcie_config_aspm_link(link, policy_to_aspm_state(link));
>> +     pcie_config_aspm_link(link, state);
>>
>>        mutex_unlock(&aspm_lock);
>>        up_read(&pci_bus_sem);
>>
>> 3. Add API pci_enable_link_state()
>>     This will give control to driver to change ASPM at runtime depending on
>> user selected performance mode. For example Android has different
>> performance modes for Wifi chip, for sleep and active state. We are using
>> similar API to overcome some performance issue related to wifi on our
>> internal platform.
> 
> I'd prefer to keep performance modes out of the drivers as much as
> possible because that's not really a scalable approach.  I'm not a
> power management expert, but I suspect the most maintainable approach
> is to do this in the generic PM core, with selectable overrides via
> sysfs as necessary.  I cc'd Rafael in case he wants to chime in.
> 
> Maybe there's a place for drivers to tweak ASPM at runtime, but I'm
> not convinced yet.  I think the intent of ASPM is that devices
> advertise exit latencies that correspond with their internal
> buffering, so the L0s and L1 states can be used with no significant
> performance impact.  But without more specifics, we can talk about
> this all day without getting anywhere.
> 
> Bjorn
> 
