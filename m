Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908C2835BD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 14:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJEMTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 08:19:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11748 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJEMTw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 08:19:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b0efa0003>; Mon, 05 Oct 2020 05:18:03 -0700
Received: from [10.25.74.112] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 12:19:38 +0000
Subject: Re: [PATCH 0/2] PCI: dwc: Add support to handle prefetchable memory
 separately
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        <alan.mikhak@sifive.com>, <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20200602100940.10575-1-vidyas@nvidia.com>
 <DM5PR12MB127675E8C053755CB82A54BCDA8B0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <389018aa-79c8-4a1e-5379-8b8e42939859@nvidia.com>
 <dd32f413-aa1c-b2e6-d76f-9d2897a8cfad@nvidia.com>
 <20200907171006.GD10272@e121166-lin.cambridge.arm.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <81c9c1d7-db0e-d7b6-34cc-093ad79268bb@nvidia.com>
Date:   Mon, 5 Oct 2020 17:49:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907171006.GD10272@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601900284; bh=+Kb7s0+T+7Dcwng7PbskdsRUPhXNDD+FmTLsUPshx1M=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=T5+I83Hq88Iv0G+ePpVXzICaAUUSNrkgPFrN4k3Ml62Am/fLpOJ2/iYASzqpyRytw
         7y04cAhkvY/tNQx+2XrS+GABh/BlGxDQrN6voXS1zhbrUzWPRJeDoLLI1rD5SSoTR6
         eDuSEUMoB+d0+dW9VE3V6YdUq4Pvt3m/mf2QxIllw375o3DdHwsfxHXQIxlnowMEUe
         t488gtsCOJ//KBZ0T3BfxdoEJDHjeny1NqRI45eiRTDvbesxUwt8/mzlM0dTCQdKPp
         ZbPiX0v4JH77DOyUDRZjUy5K1h4JHfh3/7Rn5kTp03N3Fl0cY9tGyTXh/5xzSVakZg
         2YC9JzAFsG5PQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/7/2020 10:40 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jul 06, 2020 at 10:05:06AM +0530, Vidya Sagar wrote:
>>
>>
>> On 18-Jun-20 12:26 AM, Vidya Sagar wrote:
>>>
>>>
>>> On 02-Jun-20 10:37 PM, Gustavo Pimentel wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Tue, Jun 2, 2020 at 11:9:38, Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>
>>>>> In this patch series,
>>>>> Patch-1
>>>>> adds required infrastructure to deal with prefetchable memory region
>>>>> information coming from 'ranges' property of the respective
>>>>> device-tree node
>>>>> separately from non-prefetchable memory region information.
>>>>> Patch-2
>>>>> Adds support to use ATU region-3 for establishing the mapping
>>>>> between CPU
>>>>> addresses and PCIe bus addresses.
>>>>> It also changes the logic to determine whether mapping is
>>>>> required or not by
>>>>> checking both CPU address and PCIe bus address for both prefetchable and
>>>>> non-prefetchable regions. If the addresses are same, then, it is
>>>>> understood
>>>>> that 1:1 mapping is in place and there is no need to setup ATU mapping
>>>>> whereas if the addresses are not the same, then, there is a need
>>>>> to setup ATU
>>>>> mapping. This is certainly true for Tegra194 and what I heard
>>>>> from our HW
>>>>> engineers is that it should generally be true for any DWC based
>>>>> implementation
>>>>> also.
>>>>> Hence, I request Synopsys folks (Jingoo Han & Gustavo Pimentel
>>>>> ??) to confirm
>>>>> the same so that this particular patch won't cause any
>>>>> regressions for other
>>>>> DWC based platforms.
>>>>
>>>> Hi Vidya,
>>>>
>>>> Unfortunately due to the COVID-19 lockdown, I can't access my development
>>>> prototype setup to test your patch.
>>>> It might take some while until I get the possibility to get access to it
>>>> again.
>>> Hi Gustavo,
>>> Did you find time to check this?
>>> Adding Kishon and Alan as well to take a look at this and verify on
>>> their platforms if possible.
>> Hi Kishon and Alan, did you find time to verify this on your respective
>> platforms?
> 
> Yes please. I would like to merge this code, in preparation for that
> to happen mind rebasing the series against my pci/dwc branch with
> Rob's suggested changes implemented ?
Hi,
Apologies for the delay in reply. I was on leave and couldn't really 
look into it.
I pushed a new patch on top of your pci/dwc branch at 
http://patchwork.ozlabs.org/project/linux-pci/patch/20201005121351.32516-1-vidyas@nvidia.com/

@Rob and @Lorenzo, please review it.
Since I changed the subject, I pushed it as a new patch and not as V2 of 
the previous patch set. I hope this is fine.

Thanks,
Vidya Sagar

> 
> Thanks a lot,
> Lorenzo
> 
