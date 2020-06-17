Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A36E1FD4F9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgFQS4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 14:56:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3045 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQS4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 14:56:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eea670f0000>; Wed, 17 Jun 2020 11:55:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Jun 2020 11:56:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Jun 2020 11:56:50 -0700
Received: from [10.25.77.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jun
 2020 18:56:38 +0000
Subject: Re: [PATCH 0/2] PCI: dwc: Add support to handle prefetchable memory
 separately
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        <alan.mikhak@sifive.com>, <kishon@ti.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20200602100940.10575-1-vidyas@nvidia.com>
 <DM5PR12MB127675E8C053755CB82A54BCDA8B0@DM5PR12MB1276.namprd12.prod.outlook.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <389018aa-79c8-4a1e-5379-8b8e42939859@nvidia.com>
Date:   Thu, 18 Jun 2020 00:26:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB127675E8C053755CB82A54BCDA8B0@DM5PR12MB1276.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592420111; bh=nrAfvRpzitdvypLL4y2WXfDQPZq/5S/jtH4f/LylrSI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bPFnxGmZy2KKMlPo8KEmV5YPW1Vz4T3mdarKKcLwvlXNCYRr5hfQCxzeDZLhZPPGp
         ewt94k+5r8k4bq6Xddtr9VO/Xdyb2MyPP5IVeQSxE4dieUZdBngvQxiJjl0W1GnIfv
         ev2y9HWuazH0CXINtx1NuCLyCJrNGMI+3tEZo8Hi2p+mxHCYgWL90MENivXur1YQ1h
         aVIbUTzjUWkqEzFyquACm1Wfq5G1BsHNkBagjYwUpi8JgtCrF+CGhJWwGh3++wOKCh
         0cqD0aThxs0bSlD0o5TbT8TKxOpKgVcFHAiuBbbxA8KlhMrqlzKtBDcSfumN1faTNN
         5a+2XOdaGBwug==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 02-Jun-20 10:37 PM, Gustavo Pimentel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Jun 2, 2020 at 11:9:38, Vidya Sagar <vidyas@nvidia.com> wrote:
> 
>> In this patch series,
>> Patch-1
>> adds required infrastructure to deal with prefetchable memory region
>> information coming from 'ranges' property of the respective device-tree node
>> separately from non-prefetchable memory region information.
>> Patch-2
>> Adds support to use ATU region-3 for establishing the mapping between CPU
>> addresses and PCIe bus addresses.
>> It also changes the logic to determine whether mapping is required or not by
>> checking both CPU address and PCIe bus address for both prefetchable and
>> non-prefetchable regions. If the addresses are same, then, it is understood
>> that 1:1 mapping is in place and there is no need to setup ATU mapping
>> whereas if the addresses are not the same, then, there is a need to setup ATU
>> mapping. This is certainly true for Tegra194 and what I heard from our HW
>> engineers is that it should generally be true for any DWC based implementation
>> also.
>> Hence, I request Synopsys folks (Jingoo Han & Gustavo Pimentel ??) to confirm
>> the same so that this particular patch won't cause any regressions for other
>> DWC based platforms.
> 
> Hi Vidya,
> 
> Unfortunately due to the COVID-19 lockdown, I can't access my development
> prototype setup to test your patch.
> It might take some while until I get the possibility to get access to it
> again.
Hi Gustavo,
Did you find time to check this?
Adding Kishon and Alan as well to take a look at this and verify on 
their platforms if possible.

Thanks,
Vidya Sagar

> 
> -Gustavo
> 
>>
>> Vidya Sagar (2):
>>    PCI: dwc: Add support to handle prefetchable memory separately
>>    PCI: dwc: Use ATU region to map prefetchable memory region
>>
>>   .../pci/controller/dwc/pcie-designware-host.c | 46 ++++++++++++++-----
>>   drivers/pci/controller/dwc/pcie-designware.c  |  6 ++-
>>   drivers/pci/controller/dwc/pcie-designware.h  |  8 +++-
>>   3 files changed, 45 insertions(+), 15 deletions(-)
>>
>> --
>> 2.17.1
> 
> 
