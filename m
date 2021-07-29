Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE13D9BDE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 04:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhG2Cfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 22:35:51 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:3168
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233256AbhG2Cfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 22:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjsAHXM4J8bxP68NKjEouR375DLZ2djj2FxA7BqmYB3GeCrXf4MkHZlON5ysd8PVWOUxrygUD/tc2uIXbL5FOcCWV0wzDxHY7RVQQ1axDwPmTcc5wVR84Mg9/q4bCa21jpYuywj9a/EZeLwt5YHWzW85cxxNLFlkOtJKH9r8D5hKVvl73/ejooNyyx3F3Ta6y3zp/dzcxSjS3fvQOzW39Vhpbpkir9waf1z4SLxC1IN2PRLMtEaVuIsDrvM3VljWPSzQqA8trHicwqWAVUwh1VcmLGzVlr7NaHGhawrkvujZKZLtwH/ejuUPWMuHG44Uaq8xl5CDu0tMBKMQEeqX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS1z5FAPjJxj/zEah8mJS9GA25i8tqX3oqDma0G1j0g=;
 b=N6paMl6h4MbDvP/SXCxkmYbVwoYLAWgqXBS3MviGI+psuIuHQbIvoxJIKUcMI2IBSCoukTGLLY807+b9mWzp0Xq8zjbta7zOt2+U7BFF8x4u4eBJGKB/Mp6uQ+gH6G5ddE0o0Itb53+chW70u2OeoG+cJBKiPQHHx9CCvDtqYm3afbJs8hvw9/A7Rr9WD3aZKupcZ9MYwFvgP8ybVv7JeJsuBUTv3bhvva0/sFPKrtICOhl7FGPGblfmImu04+HHxnG60cmBSWdWhPef82yAbYh2aBkLBxypuos3vrfa9H61aj24DSITKW+5Y6TwsGo7u6xjuW27gKz9uPoG7JoQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS1z5FAPjJxj/zEah8mJS9GA25i8tqX3oqDma0G1j0g=;
 b=JH/mz0S8RHXevpNhexQoQltBgVkL2dvt2llnryIODYsldYHy546JZHz9SQw9dMDR48wrEA/xkkK3xZgRN5WIuqAcLOUcdxFGvOsgrjZEHC2TFUDXdwqKveZqZZ76eTZBuqZCceMt6rjZO076tUH2GOl2LlygQyBN87IUpyImj9Ti/PO66qCWZmgQeEcoyBvtwWGdshWnbAxsgP+2TnPS6wX7ynE97vrnMHtLfPTpDAOF8WSrZHGYju9pUAb0KQRZebMU5pTz61N5ibYyaAXAYIYWyKMhKXD/dZQCCviScA4DeERNyz6FkTZFsvi9+jDWMq3J2IP0DkNxX3giDvbcXw==
Received: from BN9PR03CA0800.namprd03.prod.outlook.com (2603:10b6:408:13f::25)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 02:35:46 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::29) by BN9PR03CA0800.outlook.office365.com
 (2603:10b6:408:13f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Thu, 29 Jul 2021 02:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 02:35:46 +0000
Received: from [10.40.205.201] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Jul
 2021 02:35:39 +0000
Subject: Re: Query on ASPM driver design
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <hemantk@codeaurora.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <bjorn.andersson@linaro.org>,
        <linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210728160140.GA823046@bjorn-Precision-5520>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <c38932ba-d0b4-63bc-5128-fb4a98502254@nvidia.com>
Date:   Thu, 29 Jul 2021 08:05:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728160140.GA823046@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e0dd57-3ed9-4504-ebef-08d95239920e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:
X-Microsoft-Antispam-PRVS: <DM4PR12MB526392FE4A7A09F37F1BA9C7DAEB9@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gprgBSIjmppyJTnvU+2JzuUk5TRQ733ehamF5nYVbpEAYz9KreJJ4z2mHnuKoqf37Scc71punH4Su9SMDjm2kv3zocLhbvVqQkVxbDzv0IitqJ47TLmUnNQaKa7lTQFb6X2XBH2pk6nPwvUM0OBf9i1wGJbutqXgTpXTzktpd00lOullmapi+j/ZZyE8962HfMVj42CrnxrJNelH+47A82PbA0xUVNnKpX5j7dlDbog5H3JbOmVpEgQAQxGG/6/c+eiP6kRTY9TvZkl4sCca4MzqPvpeCMtt0RixMtcoLwvpxcnF9ngLCvUSHKPJGJXaZYJ9OGNcC0qcVY1XEBrA9QJ6nCD5QB07KJfMoQ8VsXI/HSnT6LFuhkIPQ8GHXsXBqGjSq/FWZBka1z4yGOY4XDx7P5fdnpxuf7ILoF8Al7SKri1TgaogHsq8QVXOoWjY9ekHgr8ipiRB7SualvG8BmppmkDdu/VosjSpnqSzJyxShTV2Z8PD0wzjeXcN2F4uDE0zuB5OIwfURRuFubws+SieH65MPM6Uh0KAm99bzHIj0OTaroE1kYaoK3328guCPZbg4g5bHeH4hCIGIgdcL2nUssGJWswEBPDrtaa2zLqXtRTvbjnBKN2i1Mgki7TZp6hR0h1d4RCtbseEZEAYOnvt+wVD04mJWAdsqT6oZSSzzJrh59zTVP774rT/Fhgu0H5umwdC2cmMsvJXdENhuEakstR4s8NelmLhVT9uP6E=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(6916009)(31696002)(8936002)(47076005)(4326008)(36756003)(86362001)(83380400001)(426003)(478600001)(2616005)(82740400003)(7636003)(31686004)(36860700001)(2906002)(356005)(336012)(70206006)(70586007)(8676002)(82310400003)(26005)(6666004)(186003)(16526019)(5660300002)(36906005)(54906003)(53546011)(16576012)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 02:35:46.5111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e0dd57-3ed9-4504-ebef-08d95239920e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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

Yes, I meant to say this device-tree property will allow to disable ASPM 
capabilities of selected root port, ASPM will be disabled even if 
downstream device has ASPM capability.

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
> Even before removing the Kconfig policy selection (or if we can't do
> that), I think it make sense to allow sysfs to override it.

I see Kconfig policy will is useful as different platform owner may want 
to keep different default policy for their platform.

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

We are discussing about all these options because many times device 
doesn't performs well with ASPM capabilities what they advertise.

> 
> Bjorn
> 
