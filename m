Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B60152659
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 07:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgBEGd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 01:33:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50144 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEGdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2020 01:33:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0156XjvP117119;
        Wed, 5 Feb 2020 00:33:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580884425;
        bh=oq7M5D4MHfw58kUSHUZ2et32/o3xpjb9uBa074gAXtA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=kKMB39BkYrq0YXMigUT8w5YVkK7oeHBdyoK0/K+qW+gov5/5NA58d6e6FkH6LwwLp
         WFBLSmOr/GA7Y+hWGTJIYUwehS/lUmEiVuqa1mCErXaeqVyFRlcVmDHB2vgn/W2uoX
         MMwDoHyw8Qv3aviomTIwxFpdZcAp0ppeyQgq2nSc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0156Xj4v080383
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Feb 2020 00:33:45 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 00:33:44 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 00:33:44 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0156Xadk124007;
        Wed, 5 Feb 2020 00:33:38 -0600
Subject: Re: [PATCH V2 0/5] Add support to defer core initialization
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Vidya Sagar <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, Tom Joseph <tjoseph@cadence.com>,
        Milind Parab <mparab@cadence.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
 <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
 <680a58ec-5d09-3e3b-2fd6-544c32732818@nvidia.com>
 <ca911119-da45-4cbd-b173-2ac8397fd79a@ti.com>
Message-ID: <b4af8353-3a56-fa31-3391-056050c0440a@ti.com>
Date:   Wed, 5 Feb 2020 12:07:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <ca911119-da45-4cbd-b173-2ac8397fd79a@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Tom, Milind

Hi,

On 23/01/20 3:25 PM, Kishon Vijay Abraham I wrote:
> Hi Vidya Sagar,
> 
> On 23/01/20 2:54 pm, Vidya Sagar wrote:
>> Hi Kishon,
>> Apologies for pinging again. Could you please review this series?
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 1/11/2020 5:18 PM, Vidya Sagar wrote:
>>> Hi Kishon,
>>> Could you please review this series?
>>>
>>> Also, this series depends on the following change of yours
>>> http://patchwork.ozlabs.org/patch/1109884/
>>> Whats the plan to get this merged?
> 
> I've posted the endpoint improvements as a separate series
> http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com
> 
> I'd prefer this series gets tested by others. I'm also planning to test
> this series. Sorry for the delay. I'll test review and test this series
> early next week.

I tested this series with DRA7 configured in EP mode. So for the series
itself

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Tom, Can you test this series in Cadence platform?

Lorenzo, Andrew,

How do you want to go about merging this series? This series depends on
[1] which in turn is dependent on two other series. If required, I can
rebase [1] on mainline kernel and remove it's dependencies with the
other series. That way this series and [1] could be merged. And the
other series could be worked later. Kindly let me know.

Thanks
Kishon

[1] ->
https://lore.kernel.org/linux-pci/20191231100331.6316-1-kishon@ti.com/
> 
> Thanks
> Kishon
> 
>>>
>>> Thanks,
>>> Vidya Sagar
>>>
>>> On 1/3/20 3:37 PM, Vidya Sagar wrote:
>>>> EPC/DesignWare core endpoint subsystems assume that the core
>>>> registers are
>>>> available always for SW to initialize. But, that may not be the case
>>>> always.
>>>> For example, Tegra194 hardware has the core running on a clock that
>>>> is derived
>>>> from reference clock that is coming into the endpoint system from host.
>>>> Hence core is made available asynchronously based on when host system
>>>> is going
>>>> for enumeration of devices. To accommodate this kind of hardwares,
>>>> support is
>>>> required to defer the core initialization until the respective
>>>> platform driver
>>>> informs the EPC/DWC endpoint sub-systems that the core is indeed
>>>> available for
>>>> initiaization. This patch series is attempting to add precisely that.
>>>> This series is based on Kishon's patch that adds notification mechanism
>>>> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
>>>>
>>>> Vidya Sagar (5):
>>>>    PCI: endpoint: Add core init notifying feature
>>>>    PCI: dwc: Refactor core initialization code for EP mode
>>>>    PCI: endpoint: Add notification for core init completion
>>>>    PCI: dwc: Add API to notify core initialization completion
>>>>    PCI: pci-epf-test: Add support to defer core initialization
>>>>
>>>>   .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
>>>>   drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
>>>>   drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
>>>>   drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
>>>>   include/linux/pci-epc.h                       |   2 +
>>>>   include/linux/pci-epf.h                       |   5 +
>>>>   6 files changed, 164 insertions(+), 70 deletions(-)
>>>>
